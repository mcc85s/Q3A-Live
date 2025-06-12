
# Map Asset stuff
Enum MapAssetType
{
    levelshots
    maps
    models
    music
    scripts
    sound
    textures
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

Class MapAssetShaderFileLine
{
    [UInt32]      $Index
    [Int32] $ShaderIndex
    [String]       $Line
    MapAssetShaderFileLine([UInt32]$Index,[Int32]$ShaderIndex,[String]$Line)
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

Class MapAssetShaderFileItem
{
    [UInt32] $Index
    [String] $DisplayName
    [String] $Name
    [String] $Fullname
    [UInt32] $IsTexture
    [UInt32] $IsVirtual
    [UInt32] $IsReferenced
    [String[]] $Subshader
    [Object] $Content
    MapAssetShaderFileItem([UInt32]$Index,[String]$Name)
    {
        $This.Index       = $Index
        $This.DisplayName = $Name.Replace("textures/","")
        $This.Name        = $Name | Split-Path -Leaf
        $This.Fullname    = $Name
        $This.Subshader   = @( )
        $This.Content     = @( )
    }
    GetSubshader()
    {
        $xSubshader  = $This.Content | ? { $_ -match "textures" }
        If ($xSubshader.Count -gt 0)
        {
            $Filter  = ForEach ($Line in $xSubshader)
            {
                [Regex]::Matches($Line,"textures\/.+\s*").Value.TrimEnd(" ")
            }

            $This.Subshader = $Filter.Replace("textures/","").Replace(".tga","") | Select-Object -Unique 
        }
    }
    [String] ToString()
    {
        Return $This.DisplayName
    }
}

Class MapAssetShaderFile
{
    [String] $DisplayName
    [String] $Name
    [String] $Fullname
    [Object] $Size
    [Object] $Content
    [Object] $Output
    MapAssetShaderFile([String]$Path)
    {
        $File             = Get-Item $Path -EA 0
        $This.DisplayName = $File.BaseName
        $This.Name        = $File.Name
        $This.Fullname    = $File.Fullname
        $This.Refresh()
    }
    Clear()
    {
        $This.Content     = @( )
        $This.Output      = @( )
    }
    Refresh()
    {
        $File             = Get-Item $This.Fullname -EA 0
        $This.Size        = $This.MapAssetByteSize($File.Length)
        $This.Clear()

        $Hash             = @{ }
        $ShaderContent    = @{ }
        $ShaderIndex      = -1
        ForEach ($Line in [System.IO.File]::ReadAllLines($This.Fullname))
        {
            If ($Line -match "^textures")
            {
                $ShaderIndex ++
                $Hash.Add($Hash.Count,$This.MapAssetShaderFileItem($Hash.Count,$Line))
            }

            $ShaderContent.Add($ShaderContent.Count,$This.MapAssetShaderFileLine($ShaderContent.Count,$ShaderIndex,$Line))

            If ($ShaderIndex -ge 0)
            {
                $Hash[$ShaderIndex].Content += $Line
            }
        }

        $This.Content      = $ShaderContent[0..($ShaderContent.Count-1)]
        $This.Output       = $Hash[0..($Hash.Count-1)]

        ForEach ($Item in $This.Output)
        {
            $Item.GetSubshader()
        }
    }
    [Object] MapAssetByteSize([UInt64]$Bytes)
    {
        Return [MapAssetByteSize]::New("Shader",$Bytes)
    }
    [Object] MapAssetShaderFileLine([UInt32]$Index,[Int32]$ShaderIndex,[String]$Line)
    {
        Return [MapAssetShaderFileLine]::New($Index,$ShaderIndex,$Line)
    }
    [Object] MapAssetShaderFileItem([UInt32]$Index,[String]$Name)
    {
        Return [MapAssetShaderFileItem]::New($Index,$Name)
    }
    [Object] MapAssetMapAssetByteSize([UInt64]$Bytes)
    {
        Return [MapAssetByteSize]::New("Shader",$Bytes)
    }
    [String] ToString()
    {
        Return $This.Name
    }
}

Class MapAssetTextureFile
{
    [UInt32] $Index
    [String] $DisplayName
    [String] $Type
    [Object] $Size
    [String] $Name
    [String] $Fullname
    [UInt32] $IsReferenced
    MapAssetTextureFile([UInt32]$Index,[Object]$File)
    {
        $This.Index       = $Index
        $This.DisplayName = "{0}/{1}" -f $File.Directory.Name, $File.BaseName
        $This.Type        = $File.Extension.TrimStart(".")
        $This.Size        = $This.MapAssetByteSize($File.Length)
        $This.Name        = $File.Name
        $This.Fullname    = $File.Fullname
    }
    [Object] MapAssetByteSize([UInt64]$Bytes)
    {
        Return [MapAssetByteSize]::New("Texture",$Bytes)
    }
    [String] ToString()
    {
        Return $This.DisplayName
    }
}

Class MapAssetTextureFileList
{
    [String]       $Path
    [Object]       $Size
    [Object]     $Output
    MapAssetTextureFileList([String]$Path)
    {
        If (![System.IO.Directory]::Exists($Path))
        {
            [Console]::WriteLine("Invalid directory")
        }
        Else
        {
            $This.Path     = $Path
            $This.Refresh()
        }
    }
    Clear()
    {
        $This.Output = @( )
    }
    Refresh()
    {
        $This.Clear()

        $Hash        = @{ }

        $List        = [System.IO.DirectoryInfo]::New($This.Path).GetFiles()
        $Count       = $List.Count
        $Pad         = "$Count".Length

        ForEach ($X in 0..($List.Count-1))
        {
            $File    = $List[$X]
            $Display = "({0:d$Pad}/$Count) Texture [+] $File" -f ($X+1)
            [Console]::WriteLine($Display)

            $Hash.Add($Hash.Count,$This.MapAssetTextureFile($Hash.Count,$File))
        }

        $This.Output = Switch ($Hash.Count)
        {
            0 { $Null    }
            1 { $Hash[0] }
            Default { $Hash[0..($Hash.Count-1)] }
        }

        $This.Size  = $This.MapAssetByteSize($This.GetListSize())

        [Console]::WriteLine("Size [=] $($This.Size)")
    }
    [UInt64] GetListSize()
    {
        $Bytes = 0
        ForEach ($Item in $This.Output)
        {
            $Bytes = $Bytes + $Item.Size.Bytes
        }

        Return $Bytes
    }
    [Object] MapAssetByteSize([UInt64]$Bytes)
    {
        Return [MapAssetByteSize]::New("Textures",$Bytes)
    }
    [Object] MapAssetTextureFile([Uint32]$Index,[Object]$File)
    {
        Return [MapAssetTextureFile]::New($Index,$File)
    }
    [String] ToString()
    {
        Return $This.Path
    }
}

Class MapAssetMapFileContent
{
    [UInt32] $Index
    [String] $Line
    [UInt32] $Texture
    MapAssetMapFileContent([UInt32]$Index,[String]$Line)
    {
        $This.Index   = $Index
        $This.Line    = $Line
        $This.Texture = [UInt32]($Line -match "\w+\/\w+")
    }
    [String] ToString()
    {
        Return $This.Line
    }
}

Class MapAssetMapFile
{
    [UInt32] $Index
    [String] $DisplayName
    [String] $Name
    [String] $Fullname
    [String] $Id
    [String] $TargetId
    [Object] $Size
    [String[]] $Texture
    [Object] $Content
    MapAssetMapFile([UInt32]$Index,[String]$Path)
    {
        $File             = Get-Item $Path -EA 0
        $This.Index       = $Index
        $This.DisplayName = $File.BaseName
        $This.Name        = $File.Name
        $This.Fullname    = $File.Fullname
        $This.Size        = $This.MapAssetByteSize($File.Length)
        $This.Refresh()
    }
    Clear()
    {
        $This.Content = @( )
        $This.Texture = @( )
    }
    Refresh()
    {
        $File             = Get-Item $This.Fullname -EA 0
        $This.Size        = $This.MapAssetByteSize($File.Length)
        $This.Clear()

        [Console]::WriteLine("`nProcessing [~] [$($This.Name)] (*.map) file (content + textures)")

        $Hash  = @{ }
        $Hash2 = @{ }
        ForEach ($Line in [System.IO.File]::ReadAllLines($This.Fullname))
        {
            $Hash.Add($Hash.Count,$This.MapAssetMapFileContent($Hash.Count,$Line))
            If ($Line -match "(^\w+\/\S+|(\(\s(-?\d+(\.\d+)?\s){3}\)\s){3}\S+\s(-?\d+(\.\d+)?\s){5})")
            {
                $Hash2.Add($Hash2.Count,[Regex]::Matches($Line,"\w+\/\S+").Value)
            }
        }

        $This.Content = $Hash[0..($Hash.Count-1)]
        $This.Texture = $Hash2[0..($Hash2.Count-1)] | Sort-Object | Select-Object -Unique

        [Console]::WriteLine("($($This.Texture.Count)) (textures/shaders) referenced")
    }
    [Object] MapAssetMapFileContent([UInt32]$Index,[String]$Line)
    {
        Return [MapAssetMapFileContent]::New($Index,$Line)
    }
    [Object] MapAssetByteSize([UInt64]$Bytes)
    {
        Return [MapAssetByteSize]::New("Map",$Bytes)
    }
    [String] ToString()
    {
        Return $This.DisplayName
    }
}

Class MapAssetMapFileList
{
    [String]              $Path
    Hidden [String[]] $Selected
    [Object]              $Size
    [Object]            $Output
    MapAssetMapFileList([String]$Path,[String[]]$Selected)
    {
        If (![System.IO.Directory]::Exists($Path))
        {
            [Console]::WriteLine("Invalid directory")
        }
        Else
        {
            $This.Path     = $Path
            $This.Selected = $Selected
            $This.Refresh()
        }
    }
    Clear()
    {
        $This.Output = @( )
    }
    Refresh()
    {
        $This.Clear()

        $Hash = @{ }
        ForEach ($File in [System.IO.DirectoryInfo]::New($This.Path).GetFiles() | ? Name -in $This.Selected)
        {
            $Hash.Add($Hash.Count,$This.MapAssetMapFile($Hash.Count,$File.Fullname))
        }

        $This.Output = $Hash[0..($Hash.Count-1)]

        $This.Size = $This.MapAssetByteSize($This.GetListSize())
    }
    [UInt64] GetListSize()
    {
        $Bytes = 0
        ForEach ($Item in $This.Output)
        {
            $Bytes = $Bytes + $Item.Size.Bytes
        }

        Return $Bytes
    }
    [Object] MapAssetByteSize([UInt64]$Bytes)
    {
        Return [MapAssetByteSize]::New("Maps",$Bytes)
    }
    [Object] MapAssetMapFile([UInt32]$Index,[Object]$File)
    {
        Return [MapAssetMapFile]::New($Index,$File)
    }
    [String] ToString()
    {
        Return $This.Path
    }
}

Class MapAssetManifestItem
{
    [UInt32] $Index
    [String] $DisplayName
    [String] $Name
    [String] $Fullname
    [UInt32] $IsTexture
    [UInt32] $IsVirtual
    [UInt32] $IsReferenced
    [UInt32] $IsShader
    [UInt32] $IsSubshader
    MapAssetManifestItem([UInt32]$Index,[Object]$Texture)
    {
        $This.Index       = $Index
        $This.DisplayName = $Texture.DisplayName
        $This.Name        = $Texture.Name
        $This.Fullname    = $Texture.Fullname
        $This.IsTexture   = 1
    }
    [String] ToString()
    {
        Return $This.Name
    }
}

Class MapAssetManifestList
{
    [Object] $Output
    MapAssetManifestList([Object]$TextureList)
    {
        $This.Clear()
        $This.Assign($TextureList)
    }
    Clear()
    {
        $This.Output = @( )
    }
    Assign([Object]$TextureList)
    {
        $This.Clear()

        $Hash = @{ }
        ForEach ($X in 0..($TextureList.Output.Count-1))
        {
            $Hash.Add($Hash.Count,$This.MapAssetManifestItem($X,$TextureList.Output[$X]))
        }

        $This.Output = $Hash[0..($Hash.Count-1)]
    }
    [Object] MapAssetManifestItem([UInt32]$Index,[Object]$Texture)
    {
        Return [MapAssetManifestItem]::New($Index,[Object]$Texture)
    }
}

Class MapAssetController
{
    [Object] $Control
    [Object] $Module
    [String] $Workspace
    [String] $Id
    [Object] $Texture
    [Object] $Shader
    [Object] $Map
    [Object] $Manifest
    [String] $Source
    [String] $Destination
    MapAssetController([Object]$Control,[String]$Workspace,[String]$Id,[String]$MapPath,[String[]]$Selected,[String]$Destination)
    {
        $xSource = "$Workspace\$Id"
        If (![System.IO.Directory]::Exists($Workspace))
        {
            Throw "Invalid <workspace> directory"
        }
        ElseIf (![System.IO.Directory]::Exists($xSource))
        {
            Throw "Invalid <workspace/id> directory"
        }
        ElseIf (![System.IO.Directory]::Exists($MapPath))
        {
            Throw "Invalid <map> directory"
        }
        ElseIf ($Selected.Count -eq 0)
        {
            Throw "Must select existing <map>.map names in <map> directory"
        }

        $This.Control   = $Control
        $This.Module    = $Control.Module
        
        $This.Workspace = $Workspace
        $This.Id        = $Id
        $This.Source    = $xSource

        $ShaderPath    = "$Workspace\$Id\scripts\$Id.shader"
        $This.Update(0,"== Shaders == [$ShaderPath]")
        $This.Shader  = $This.MapAssetShaderFile($ShaderPath)

        $TexturePath   = "$Workspace\$Id\textures\$Id"
        $This.Update(0,"== Textures == [$TexturePath]")
        $This.Texture = $This.MapAssetTextureFileList($TexturePath)

        $This.Update(0,"== Maps == [$MapPath]")
        $This.Map     = $This.MapAssetMapFileList($MapPath,$Selected)

        $This.Update(0,"== Manifest ==")
        $This.Manifest = $This.MapAssetManifestList($This.Texture)

        $This.Destination = $Destination

        $This.Assign()
    }
    Update([Int32]$State,[String]$Status)
    {
        # Updates the console
        $This.Module.Update($State,$Status)
        If ($This.Module.Mode -ne 0)
        {
            $xStatus = $This.Module.Console.Last()

            [Console]::WriteLine($xStatus)
        }
    }
    Refresh([String]$Name)
    {
        If ($Name -notin "Texture","Shader","Map")
        {
            $This.Update(0,"Select [Texture], [Shader], or [Map]")
        }
        Else
        {
            Switch ($Name)
            {
                Texture { $This.Texture.Refresh() }
                Shader  { $This.Shader.Refresh()  }
                Map     { $This.Map.Refresh()     }
            }
        }
    }
    Assign()
    {
        # Manifest of mapped textures
        $Textures   = @{ }
        $Shaders    = @{ }

        ForEach ($Item in $This.Manifest.Output)
        {
            $Textures.Add($Item.DisplayName,$Item)
        }

        ForEach ($Item in $This.Shader.Output)
        {
            If (!$Textures[$Item.DisplayName])
            {
                $Item.IsVirtual = 1
            }

            $Shaders.Add($Item.DisplayName,$Item)
        }

        # Maps textures
        $Mapped    = $This.Map.Output.Texture | ? { $_ -match $This.Shader.DisplayName } | Select-Object -Unique | Sort-Object
        ForEach ($xTexture in $Mapped)
        {
            $Item = $Textures[$xTexture]
            If ($Item)
            {
                #[Console]::WriteLine("Texture [+] $Item")
                $This.Update(0,"Texture [+] $Item")
                $Item.IsReferenced        = 1
                $xShader                  = $Shaders[$xTexture]
                If ($xShader)
                {
                    #[Console]::WriteLine("  Shader [+] $xShader")
                    $This.Update(0,"  Shader [+] $($xShader)")
                    $Item.IsShader        = 1
                    $xShader.IsTexture    = 1
                    $xShader.IsReferenced = 1
                    ForEach ($xSubshader in $xShader.Subshader)
                    {
                        $xItem = $Textures[$xSubshader]
                        If ($xItem)
                        {
                            # [Console]::WriteLine("    Subshader [+] $xSubshader")
                            $This.Update(0,"    Subshader [+] $xSubshader")
                            $xItem.IsReferenced = 1
                            $xItem.IsSubshader  = 1
                        }
                    }
                }
            }
            If (!$Item)
            {
                $xShader              = $Shaders[$xTexture]
                $xShader.IsVirtual    = 1
                $xShader.IsReferenced = 1
            }
        }

        # Maps shaders to textures
        $xShaders = $This.Shader.Output | ? IsReferenced
        ForEach ($xShader in $xShaders)
        {
            # [Console]::WriteLine("  Shader [+] $xShader")
            $This.Update(0,"  Shader [+] $($xShader)")
            ForEach ($xSubshader in $xShader.Subshader)
            {
                $Item = $Textures[$xSubshader]
                If ($Item)
                {
                    # [Console]::WriteLine("    Subshader [+] $xSubshader")
                    $This.Update(0,"    Subshader [+] $xSubshader")
                    $Item.IsReferenced = 1
                    $Item.IsSubshader  = 1
                }
                If (!$Item)
                {
                    # [Console]::WriteLine("    Subshader [!] $xSubshader [missing]")
                    $This.Update(0,"    Subshader [!] $xSubshader [missing]")
                }
            }
        }

        # Update textures to be referenced
        $Textures = @{ }
        ForEach ($Item in $This.Texture.Output)
        {
            $Textures.Add($Item.DisplayName,$Item)
        }

        ForEach ($Item in $This.Manifest.Output | ? IsReferenced)
        {
            $Textures[$Item.DisplayName].IsReferenced = 1
        }
    }
    ProcessDirectories()
    {
        If (![System.IO.Directory]::Exists($This.Destination))
        {
            [System.IO.Directory]::CreateDirectory($This.Destination)
        }

        # Process directories first
        ForEach ($Name in [System.Enum]::GetNames("MapAssetType"))
        {
            $Stub = "{0}\{1}" -f $This.Destination, $Name
            If (![System.IO.Directory]::Exists($Stub))
            {
                [System.IO.Directory]::CreateDirectory($Stub)
                If ($Name -eq "levelshots")
                {
                    $Stub = "$Stub\preview"
                    If (![System.IO.Directory]::Exists($Stub))
                    {
                        [System.IO.Directory]::CreateDirectory($Stub)
                    }
                }
            }
        }
    }
    ProcessExistingAssets()
    {
        ForEach ($Map in $This.Map.Output)
        {
            $xSource = "{0}\{1}" -f $This.Workspace, $Map.DisplayName

            # Process any additional subdirectories
            $Folders = Get-ChildItem $xSource -Directory -Recurse
            ForEach ($Folder in $Folders)
            {
                $NewFolderName = $Folder.Fullname.Replace($xSource,$This.Destination)
                If (![System.IO.Directory]::Exists($NewFolderName))
                {
                    [System.IO.Directory]::CreateDirectory($NewFolderName)
                }
            }

            # Process files (*.bsp/*.aas/*.jpg/*.arena)
            $Files   = Get-ChildItem $xSource -File -Recurse
            ForEach ($File in $Files)
            {
                If ($File.Extension -eq ".arena")
                {
                    $Content = [System.IO.File]::ReadAllLines($File.Fullname)
                    $Arena   = $Map.DisplayName, $Map.TargetId | % { "map `"$_`""}
                    $Content = $Content -Replace $Arena[0], $Arena[1]
                    [System.IO.File]::WriteAllLines($File.FullName.Replace($xSource,$This.Destination).Replace($Map.DisplayName,$Map.TargetId),$Content)
                }
                Else
                {
                    [System.IO.File]::Copy($File.Fullname,$File.FullName.Replace($xSource,$This.Destination).Replace($Map.DisplayName,$Map.TargetId),1)
                }
            }
        }
    }
    ProcessShader()
    {
        $xShaderList = $This.Shader.Output | ? IsReferenced
        If ($xShaderList.Count -gt 0)
        {
            $Hash = @{ }
            ForEach ($xShader in $xShaderList)
            {
                ForEach ($Line in $xShader.Content)
                {
                    $Hash.Add($Hash.Count,$Line.Replace("\t",""))
                }
            }
        
            $ShaderPath = "{0}\scripts\{1}" -f $This.Destination, $This.Shader.Name
            $Content    = $Hash[0..($Hash.Count-1)]
        
            [System.IO.File]::WriteAllLines($ShaderPath,$Content)
        }
    }
    ProcessTextures()
    {
        $Magick       = $This.Control.Dependency.Get("Image")

        $xTexturePath = "{0}\textures\{1}" -f $This.Destination, $This.Shader.DisplayName
        If (![System.IO.Directory]::Exists($xTexturePath))
        {
            [System.IO.Directory]::CreateDirectory($xTexturePath)
        }

        $Start        = [DateTime]::Now
        $List         = $This.Texture.Output | ? IsReferenced
        $Count        = $List.Count
        $Pad          = ([String]$Count).Length

        ForEach ($X in 0..($List.Count-1))
        {
            $Item     = $List[$X]
            $Display  = "({0:d$Pad}/{1}) => [{2}]" -f ($X+1), $Count, $Item.Fullname
            $This.Update(0,$Display)

            If ($Item.Size.Bytes -ge 1mb)
            {
                $Param    = Switch ($Item.Type)
                {
                    tga
                    { 
                        # "convert `"{0}`" -compress RLE `"{1}\{2}`"" # to (*.tga) (no compression, large archive)
                        "convert `"{0}`" -depth 8 -define png:compression-level=9 `"{1}\{2}.png`"" -f $Item.Fullname, $xTexturePath, $Item.Name.Split(".")[0] # to (*.png)
                    }
                    jpg
                    {
                        "convert `"{0}`" -quality 85 `"{1}\{2}.jpg`"" -f $Item.Fullname, $xTexturePath, $Item.Name.Split(".")[0]
                    }
                }

                Start-Process -FilePath $Magick.FilePath -ArgumentList $Param -NoNewWindow -Wait
            }
            Else
            {
                [System.IO.File]::Copy($Item.Fullname,$Item.Fullname.Replace($This.Source,$This.Destination))
            }
        }

        $End  = [DateTime]::Now
        $Span = [TimeSpan]($End-$Start)
        $This.Update(1,"Successful [+] Texture (compression/transfer) took [$Span]")
    }
    Package()
    {
        $7Zip       = $This.Control.Dependency.Get("Archive")
        $Target       = "{0}.pk3" -f $This.Destination
        If ([System.IO.File]::Exists($Target))
        {
            $This.Update(0,"Exists [!] $Target, deleting...")
            [System.IO.File]::Delete($Target)
        }

        $This.Update(0,"Packaging [~] $Target")
        $Param        = "a -tzip -mx=5 `"{0}`" `"{1}\*`" -o`"{2}`"" -f $Target, $This.Destination, $This.Workspace
        Start-Process -FilePath $7Zip.FilePath -WorkingDirectory $This.Workspace -ArgumentList $Param -NoNewWindow -Wait

        If ([System.IO.File]::Exists($Target))
        {
            $This.Update(1,"Packaged [+] $Target")
        }
    }
    Transfer()
    {
        $Q3A     = $This.Control.Q3A().Path
        $Live    = $This.Control.Live().Path
        $xId     = $This.Destination | Split-Path -Leaf
        $Target  = "{0}\{1}.pk3" -f $This.Workspace, $xId

        $This.Update(0,"Transferring [~] $Target")
        ForEach ($Item in "$Live\baseq3", "$Q3A\baseq3")
        {
            $xDestination = "{0}\{1}.pk3" -f $Item, $xId
            [System.IO.File]::Copy($Target,$xDestination,1)
            If ([System.IO.File]::Exists($xDestination))
            {
                $This.Update(1,"Transferred [+] $Target => $xDestination")
            }
        }
    }
    [Object] MapAssetShaderFile([String]$Path)
    {
        Return [MapAssetShaderFile]::New($Path)
    }
    [Object] MapAssetTextureFileList([String]$Path)
    {
        Return [MapAssetTextureFileList]::New($Path)
    }
    [Object] MapAssetMapFileList([String]$Path,[String[]]$Selected)
    {
        Return [MapAssetMapFileList]::New($Path,$Selected)
    }
    [Object] MapAssetManifestList([Object]$TextureList)
    {
        Return [MapAssetManifestList]::New($TextureList)
    }
    [String] ToString()
    {
        Return "<MapAssetController>"
    }
}

$Workspace   = "C:\Workspace"
$Id          = "bfg20k"
$Maps        = "C:\Program Files (x86)\Quake III Arena\baseq3\maps"
$Selected    = "crossfire.map",
               "breakthru.map",
               "spacestation1138.map",
               "suspendedanimation.map",
               "kerberos.map",
               "temperedgraveyard.map",
               "rtcq.map",
               "insaneproducts.map",
               "deadcenter.map",
               "tranquilibrium.map",
               "wisdom.map",
               "outofmyhead.map",
               "goliath.map"
$Destination = "C:\Workspace\bfg20k-pak0-beta"

<# Requires Q3A-Live @ https://github.com/mcc85s/Q3A-Live/blob/main/Scripts/2025_0605-(Q3A-Live).ps1
$Ctrl      = [Q3ALiveMaster]::New()
#>
$Asset       = [MapAssetController]::New($Ctrl,$Workspace,$Id,$Maps,$Selected,$Destination)

# Assign each map Id and TargetId
ForEach ($Map in $Asset.Map.Output)
{
    $Map.Id = Switch ($Map.DisplayName)
    {
      crossfire          { "crossfire"      }
	  breakthru          { "breakthru"      }
	  spacestation1138   { "ss1138"         }
	  suspendedanimation { "suspanim"       }
	  deadcenter         { "deadcenter"     }
	  tranquilibrium     { "tranquilibrium" }
	  wisdom             { "wisdom"         }
	  kerberos           { "kerberos"       }
	  temperedgraveyard  { "tempgrave"      }
	  rtcq               { "rtcq"           }
	  insaneproducts     { "insprod"        }
	  outofmyhead        { "oomh"           }
	  goliath            { "goliath"        }
    }
    $Map.TargetId = "20k_{0}_beta" -f $Map.Id
}

# Process directories
$Asset.ProcessDirectories()

# Process existing assets
$Asset.ProcessExistingAssets()

# Process shader
$Asset.ProcessShader()

# Process textures
$Asset.ProcessTextures()

# Move sound assets from BFG20K
ForEach ($Item in Get-ChildItem "$($Asset.Source)\sound" -Directory -Recurse)
{
    $xTarget = $Item.FullName.Replace($Asset.Source,$Asset.Destination)
    If (![System.IO.Directory]::Exists($xTarget))
    {
        [System.IO.Directory]::CreateDirectory($xTarget)
    }
}

ForEach ($Item in Get-ChildItem "$($Asset.Source)\sound" -File -Recurse)
{
    [System.IO.File]::Copy($Item.Fullname,$Item.FullName.Replace($Asset.Source,$Asset.Destination),1)
}

# Package assets
$Asset.Package()

# Transfer
$Asset.Transfer()
