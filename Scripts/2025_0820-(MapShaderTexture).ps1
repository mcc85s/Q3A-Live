<# Use this to:
- parse (*.map) file
- extract its' (texture/shader) references
- reformat and parse multiple (*.shader) files into shader objects + subshaders
- look through file system for existing texture files
- other stuff to implement when its tested and done
#>

Enum DefaultShaders
{
    base_button
    base_door
    base_floor
    base_light
    base_object
    base_support
    base_trim
    base_wall
    common
    ctf
    gothic_block
    gothic_button
    gothic_door
    gothic_floor
    gothic_light
    gothic_trim
    gothic_wall
    liquids
    models
    organics
    sfx
    skin
    skies
}

Class MapAssetByteSize
{
    [String]   $Name
    [UInt64]  $Bytes
    [String]   $Unit
    [String]   $Size
    MapAssetByteSize([String]$Name,[UInt64]$Bytes)
    {
        $This.Name   = $Name
        $This.Bytes  = $Bytes
        $This.GetUnit()
        $This.GetSize()
    }
    GetUnit()
    {
        $This.Unit   = Switch ($This.Bytes)
        {
            {$_ -lt 1KB}                 {     "Byte" }
            {$_ -ge 1KB -and $_ -lt 1MB} { "Kilobyte" }
            {$_ -ge 1MB -and $_ -lt 1GB} { "Megabyte" }
            {$_ -ge 1GB -and $_ -lt 1TB} { "Gigabyte" }
            {$_ -ge 1TB}                 { "Terabyte" }
        }
    }
    GetSize()
    {
        $This.Size   = Switch -Regex ($This.Unit)
        {
            ^Byte     {     "{0} B" -f  $This.Bytes      }
            ^Kilobyte { "{0:n2} KB" -f ($This.Bytes/1KB) }
            ^Megabyte { "{0:n2} MB" -f ($This.Bytes/1MB) }
            ^Gigabyte { "{0:n2} GB" -f ($This.Bytes/1GB) }
            ^Terabyte { "{0:n2} TB" -f ($This.Bytes/1TB) }
        }
    }
    [String] ToString()
    {
        Return $This.Size
    }
}

Class ShaderItemFormatLine
{
    [UInt32] $Index
    [String] $Line
    ShaderItemFormatLine([UInt32]$Index,[String]$Line)
    {
        $This.Index = $Index
        $This.Line  = $Line
    }
    [String] ToString()
    {
        Return $This.Line
    }
}

Class ShaderItemFormat
{
    [UInt32] $Index
    [String] $DisplayName
    [Object] $Content
    ShaderItemFormat([UInt32]$Index,[String]$DisplayName)
    {
        $This.Index       = $Index
        $This.DisplayName = $DisplayName
        $This.Content     = @( )
    }
    Add([String]$Line)
    {
        $This.Content += $This.ShaderItemFormatLine($This.Content.Count,$Line)
    }
    Format()
    {
        $Ct = $This.Content.Count-1
        ForEach ($X in 0..$Ct)
        {
            If ($X -notin 0,1,$Ct)
            {
                $This.Content[$X].Line = "    {0}" -f $This.Content[$X].Line
            }
        }

        $Start = $This.Content | ? Line -match "    {" | Select-Object -First 1 | % Index
        If (!!$Start)
        {
            $End   = $Ct-1

            ForEach ($X in $Start..$End)
            {
                If ($This.Content[$X].Line -notmatch "(    {|    })")
                {
                    $This.Content[$X].Line = "    {0}" -f $This.Content[$X].Line
                }
            }
        }
    }
    [Object] ShaderItemFormatLine([UInt32]$Index,[String]$Line)
    {
        Return [ShaderItemFormatLine]::New($Index,$Line)
    }
    [String] ToString()
    {
        Return "<ShaderItemFormatLine>"
    }
}

Class ShaderFileLine
{
    [UInt32]      $Index
    [Int32] $ShaderIndex
    [String]       $Line
    ShaderFileLine([UInt32]$Index,[Int32]$ShaderIndex,[String]$Line)
    {
        $This.Index       = $Index
        $This.ShaderIndex = $ShaderIndex
        $This.Line        = $Line
    }
    [String] ToString()
    {
        Return $This.Line
    }
}

Class ShaderItemLine
{
    [UInt32] $Index
    [String] $Line
    ShaderItemLine([UInt32]$Index,[String]$Line)
    {
        $This.Index = $Index
        $This.Line  = $Line
    }
    [String] ToString()
    {
        Return $This.Line
    }
}

Class ShaderItem
{
    [UInt32]        $Index
    [String]  $DisplayName
    [String]         $Name
    [String]     $Fullname
    [UInt32]    $IsTexture
    [UInt32]    $IsVirtual
    [UInt32] $IsReferenced
    [String[]]  $Subshader
    [Object]      $Content
    ShaderItem([UInt32]$Index,[String]$DisplayName)
    {
        $This.Index       = $Index
        $This.DisplayName = $DisplayName.Replace("textures/","")
        $This.Name        = $DisplayName | Split-Path -Leaf
        $This.Fullname    = $DisplayName
        $This.Subshader   = @( )
        $This.Content     = @( )
    }
    Add([String]$Line)
    {
        $This.Content    += $This.ShaderItemLine($This.Content.Count,$Line)
    }
    [Object] ShaderItemLine([UInt32]$Index,[String]$Line)
    {
        Return [ShaderItemLine]::New($Index,$Line)
    }
    GetSubshader()
    {
        [Console]::WriteLine("Shader [~] $($This.DisplayName)")

        $xSubshader  = $This.Content | ? { $_ -match "textures\/\S+" }
        If ($xSubshader.Count -gt 0)
        {
            $Filter  = $xSubshader | % { [Regex]::Matches($_,"textures\S+").Value.TrimEnd(" ") }

            $This.Subshader = $Filter.Replace("textures/","").Replace(".tga","") | Select-Object -Unique 
        }
    }
    [String] ToString()
    {
        Return "<ShaderItem>"
    }
}

Class ShaderFileItem
{
    [UInt32] $Index
    [String] $DisplayName
    [String] $Name
    [String] $Fullname
    [UInt32] $IsReferenced
    [Object] $Content
    [Object] $Output
    ShaderFileItem([UInt32]$Index,[String]$Fullname)
    {
        $This.Index       = $Index
        $This.Fullname    = $Fullname
        $This.Name        = $Fullname | Split-Path -Leaf
        $This.DisplayName = $This.Name.Split(".")[0]
        $This.Refresh()
    }
    Refresh()
    {
        $This.Content     = @( )

        $xContent         = [System.IO.File]::ReadAllLines($This.Fullname)

        # // Prepares the shader content format
        $yContent         = $xContent -Replace "\t"," " -Replace "^\s+" | ? { $_.Length -gt 0 } | ? { $_ -notmatch "^\s*\/\/" }
        $Shaders          = $yContent | ? { $_ -match "^(textures|models)" }

        $Hash = @{ }
        ForEach ($Line in $yContent)
        {
            If ($Line -in $Shaders)
            {
                $Hash.Add($Hash.Count,$This.ShaderItemFormat($Hash.Count,$Line))
            }
                
            $Hash[$Hash.Count-1].Add($Line)
        }

        $Array = $Hash[0..($Hash.Count-1)]

        ForEach ($Item in $Array)
        {
            $Item.Format()
            $Item.Add("")
        }

        $xContent         = $Array.Content.Line

        # // Converts all formatted shader data into line by line objects
        $Hash             = @{ }
        $sContent         = @{ }
        $ShaderIndex      = -1
        ForEach ($Line in $xContent)
        {
            $Line = $Line.Replace("\t","    ")

            If ($Line -match "^(textures|models)")
            {
                $ShaderIndex ++
                $Hash.Add($Hash.Count,$This.ShaderItem($Hash.Count,$Line))
            }

            $sContent.Add($sContent.Count,$This.ShaderFileLine($sContent.Count,$ShaderIndex,$Line))
            If ($ShaderIndex -ge 0)
            {
                $Hash[$ShaderIndex].Add($Line)
            }
        }

        $This.Content = Switch ($sContent.Count) { 0 { } 1 { $sContent[0] } Default { $sContent[0..($sContent.Count-1)] } }

        $This.Output  = $Hash[0..($Hash.Count-1)]

        ForEach ($Item in $This.Output)
        {
            $Item.GetSubshader()
        }
    }
    [Object] ShaderItemFormat([UInt32]$Index,[String]$DisplayName)
    {
        Return [ShaderItemFormat]::New($Index,$DisplayName)
    }
    [Object] ShaderFileLine([UInt32]$Index,[Int32]$ShaderIndex,[String]$Line)
    {
        Return [ShaderFileLine]::New($Index,$ShaderIndex,$Line)
    }
    [Object] ShaderItem([UInt32]$Index,[Object[]]$Line)
    {
        Return [ShaderItem]::New($Index,$Line)
    }
    [String] ToString()
    {
        Return "<ShaderFileItem>"
    }
}

Class ShaderFileList
{
    [String] $DisplayName
    [String] $Fullname
    [Object] $File
    [Object] $Subshader
    [Object] $Output
    ShaderFileList()
    {

    }
    ShaderFileList([String]$Fullname)
    {
        $This.SetShaderPath($Fullname)
    }
    SetShaderPath([String]$Fullname)
    {
        $This.Fullname    = $Fullname
        $This.DisplayName = $Fullname | Split-Path -Parent | Split-Path -Leaf
        $This.Refresh()
    }
    Clear()
    {
        $This.File        = @( )
        $This.Subshader   = @( )
        $This.Output      = @( )
    }
    Refresh()
    {
        $This.Clear()

        $List = Get-ChildItem $This.Fullname -EA 0 | ? Extension -eq ".shader"
        $Hash = @{ } 

        ForEach ($Item in $List)
        {
            $Hash.Add($Hash.Count,$This.ShaderFileItem($Hash.Count,$Item.Fullname))
        }

        $This.File = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } }
    }
    [Object] ShaderFileItem([UInt32]$Index,[String]$Fullname)
    {
        Return [ShaderFileItem]::New($Index,$Fullname)
    }
    [String] ToString()
    {
        Return "<ShaderFileList>"
    }
}

Class TextureFileItem
{
    [UInt32] $Index
    [String] $DisplayName
    [String] $Name
    [String] $Type
    [String] $Date
    [Object] $Size
    [UInt32] $IsReferenced
    [String] $Fullname
    [String] $NewName
    TextureFileItem([UInt32]$Index,[Object]$File)
    {
        $This.Index       = $Index
        $This.DisplayName = "{0}/{1}" -f $File.Directory.Name, $File.BaseName
        $This.Name        = $File.Name
        $This.Type        = $File.Extension.TrimStart(".").ToLower()
        $This.Date        = $File.LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss")
        $This.Size        = $This.MapAssetByteSize($File.Length)
        $This.Fullname    = $File.Fullname
    }
    [Object] MapAssetByteSize([UInt64]$Bytes)
    {
        Return [MapAssetByteSize]::New("Texture",$Bytes)
    }
    [String] ToString()
    {
        Return $This.Fullname
    }
}

Class TextureFileList
{
    [String] $Fullname
    [Object] $File
    TextureFileList([String]$Fullname)
    {
        $This.Fullname = $Fullname
        $This.Refresh()
    }
    Refresh()
    {
        $This.File = @( )

        $List = Get-ChildItem $This.Fullname -File -Recurse -EA 0
        $Hash = @{ }
        ForEach ($File in $List)
        {
            $Hash.Add($Hash.Count,$This.TextureFileItem($Hash.Count,$File))
        }

        $This.File = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } }
    }
    [Object] TextureFileItem([UInt32]$Index,[Object]$File)
    {
        Return [TextureFileItem]::New($Index,$File)
    }
    [String] ToString()
    {
        Return $This.Fullname
    }
}

Class MapLineDetail
{
    [Double[]] $Coords1
    [Double[]] $Coords2
    [Double[]] $Coords3
    [String] $Texture
    [Double] $X_Pos
    [Double] $Y_Pos
    [Double] $Rotation
    [Double] $X_Scale
    [Double] $Y_Scale
    [Double] $Flag
    [UInt32] $Param1
    [UInt32] $Param2
    MapLineDetail([String]$Line)
    {
        $Object        = $Line -Split " "

        $This.Coords1  = $Object[1..3]
        $This.Coords2  = $Object[6..8]
        $This.Coords3  = $Object[11..13]

        $This.Texture  = $Object[15]
        $This.X_Pos    = $Object[16]
        $This.Y_Pos    = $Object[17]
        $This.Rotation = $Object[18]
        $This.X_Scale  = $Object[19]
        $This.Y_Scale  = $Object[20]
        $This.Flag     = $Object[21]
        $This.Param1   = $Object[22]
        $This.Param2   = $Object[23]
    }
    Amend([String]$Texture,[UInt32]$Scale)
    {
        $This.Texture = $Texture
        $This.X_Pos   = $This.X_Pos * $Scale
        $This.Y_Pos   = $This.Y_Pos * $Scale
        $This.X_Scale = $This.X_Scale/$Scale
        $This.Y_Scale = $This.Y_Scale/$Scale
    }
    [String] ToString()
    {
        $1 = $This.Coords1 -join " "
        $2 = $This.Coords2 -join " "
        $3 = $This.Coords3 -join " "

        $Out = "( {0} ) ( {1} ) ( {2} ) {3} {4} {5} {6} {7} {8} {9} {10} {11}" -f $1, $2, $3,
        $This.Texture,
        $This.X_Pos,
        $This.Y_Pos,
        $This.Rotation,
        $This.X_Scale,
        $This.Y_Scale,
        $This.Flag,
        $This.Param1,
        $This.Param2

        Return $Out
    }
}

Class MapLine
{
    [UInt32]         $Index
    [String]          $Line
    [UInt32]     $IsTexture
    [String]     $Reference
    Hidden [Object] $Detail
    MapLine([UInt32]$Index,[String]$Line)
    {
        $This.Index   = $Index
        $This.Line    = $Line

        If ($This.Line -match $This.Regex())
        {
            $This.IsTexture = 1

            $xLine          = $This.Line -Replace "(\(\s(-?\d+(\.\d+)?\s){3}\)\s){3}",""
            $This.Reference = [Regex]::Matches($xLine,"^\S+").Value
            $This.Detail    = $This.MapLineDetail($This.Line)
        }
    }
    [String] Regex()
    {
        Return "(\(\s(-?\d+(\.\d+)?\s){3}\)\s){3}\S+\s(-?\d+(\.\d+)?\s){5}"
    }
    Amend([String]$Texture,[UInt32]$Scale)
    {
        If ($This.Texture)
        {
            $This.Detail.Amend($Texture,$Scale)
            $This.Reference = $Texture
            $This.Line      = $This.Detail.ToString()
        }
    }
    [Object] MapLineDetail([String]$Line)
    {
        Return [MapLineDetail]::New($Line)
    }
    [String] ToString()
    {
        Return $This.Line
    }
}

Class MapReferenceItem
{
    [UInt32] $Index
    [UInt32] $Default
    [String] $Shader
    [String] $Name
    [String] $DisplayName
    MapReferenceItem([UInt32]$Index,[String]$DisplayName)
    {
        $This.Index       = $Index
        $This.DisplayName = $DisplayName
        $This.Shader      = $DisplayName | Split-Path
        $This.Name        = $DisplayName | Split-Path -Leaf
    }
    [String] ToString()
    {
        Return $This.DisplayName
    }
}

Class ReplacementItem
{
    [UInt32] $Index
    [String] $Current
    [String] $New
    [UInt32] $Scale
    ReplacementItem([UInt32]$Index,[String]$Current,[String]$New,[UInt32]$Scale)
    {
        $This.Index   = $Index
        $This.Current = $Current
        $This.New     = $New
        $This.Scale   = $Scale
    }
    [String] ToString()
    {
        Return "<Replacement.Item>"
    }
}

Class ReplacementList
{
    [Object] $Output
    ReplacementList()
    {
        $This.Clear()
    }
    Clear()
    {
        $This.Output = @( )
    }
    Add([String]$Current,[String]$New)
    {
        $This.Output += $This.ReplacementItem($This.Output.Count,$Current,$New,1)
    }
    Add([String]$Current,[String]$New,[UInt32]$Scale)
    {
        $This.Output += $This.ReplacementItem($This.Output.Count,$Current,$New,$Scale)
    }
    [Object] ReplacementItem([UInt32]$Index,[String]$Current,[String]$New,[UInt32]$Scale)
    {
        Return [ReplacementItem]::New($Index,$Current,$New,$Scale)
    }
    [String] ToString()
    {
        Return "<Replacement.List>"
    }
}

Class MapFileItem
{
    [UInt32] $Index
    [String] $Source
    [String] $DisplayName
    [String] $Fullname
    [Object] $Content
    [Object] $Reference
    [Object] $Shader
    [Object] $Texture
    [Object] $Replacement
    MapFileItem([UInt32]$Index,[String]$Source,[String]$Fullname)
    {
        $This.Index       = $Index
        $This.Source      = $Source
        $This.Fullname    = $Fullname
        $This.DisplayName = $Fullname | Split-Path -Leaf

        $This.Refresh()
    }
    Refresh()
    {
        # // Get the map file content
        $This.GetContent()

        # // Get references from (*.map) file content
        $This.GetReference()

        # // Get the map asset shaders
        $This.GetShader()

        # // Get the map asset textures
        $This.GetTexture()

        # // Get the replacement list
        $This.GetReplacement()

        # // Go through references to identify what shaders are used
    }
    GetContent()
    {
        [Console]::WriteLine("Getting [~] Map Content")

        $This.Content = @( )

        If ([System.IO.File]::Exists($This.Source))
        {
            $xContent = [System.IO.File]::ReadAllLines($This.Source)
            $Hash     = @{ }

            ForEach ($Line in $xContent)
            {
                $Hash.Add($Hash.Count,$This.MapLine($Hash.Count,$Line))
            }

            $This.Content = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } }
        }
    }
    GetReference()
    {
        [Console]::WriteLine("Getting [~] Map References")

        $This.Reference = @( )

        $DefaultShaders = $This.DefaultShaders()

        $xList          = $This.Content.Reference | Select-Object -Unique | Sort-Object
        $Hash           = @{ }

        ForEach ($Item in $xList)
        {
            $Entry         = $This.MapReferenceItem($Hash.Count,$Item)
            $Entry.Default = [UInt32]($Entry.Shader -in $DefaultShaders)

            $Hash.Add($Hash.Count,$Entry)
        }

        $This.Reference = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } }
    }
    GetShader()
    {
        [Console]::WriteLine("Getting [~] Shader file list")

        $This.Shader      = $This.ShaderFileList("$($This.Fullname)\scripts")
    }
    GetTexture()
    {
        [Console]::WriteLine("Getting [~] Texture file list")

        $This.Texture     = $This.TextureFileList("$($This.Fullname)\textures")
    }
    GetReplacement()
    {
        [Console]::WriteLine("Getting [~] Replacement list")

        $This.Replacement = $This.ReplacementList()
    }
    [String[]] DefaultShaders()
    {
        Return [System.Enum]::GetNames([DefaultShaders])
    }
    [Object] MapLine([UInt32]$Index,[String]$Line)
    {
        Return [MapLine]::New($Index,$Line)
    }
    [Object] MapReferenceItem([UInt32]$Index,[String]$DisplayName)
    {
        Return [MapReferenceItem]::New($Index,$DisplayName)
    }
    [Object] ShaderFileList()
    {
        Return [ShaderFileList]::New()
    }
    [Object] ShaderFileList([String]$ScriptPath)
    {
        Return [ShaderFileList]::New($ScriptPath)
    }
    [Object] TextureFileList([String]$Fullname)
    {
        Return [TextureFileList]::New($Fullname)
    }
    [Object] ReplacementList()
    {
        Return [ReplacementList]::New()
    }
    [Object[]] Find([String]$Filter)
    {
        Return $This.Content | ? Line -match $Filter
    }
    Replace()
    {
        <#
        ForEach ($Item in $This.Texture.Output)
        {
            [Console]::WriteLine($Item.Current)

            $Filter = "{0}\s" -f $Item.Current
            ForEach ($Line in $This.Content | ? Line -match $Filter)
            {
                $Line.Amend($Item.New,$Item.Scale)
            }
        }
        #>
    }
    Save()
    {
        <#
        [System.IO.File]::WriteAllLines($This.Path,$This.Content.Line)
        #>
    }
    [String] ToString()
    {
        Return "<Map.File.Item>"
    }
}
