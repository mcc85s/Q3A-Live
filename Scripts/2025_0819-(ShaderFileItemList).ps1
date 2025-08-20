<# 
    Use to parse through and clean all (*.shader) files in a list.
    
    Removes comments, tabs, and spaces in order to format them correctly.

    Will implement a feature that allows a list of replacements to replace:
    - file system entries
    - shader file entries
    - map file references
#>

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
        $yContent         = $xContent -replace "\t"," " -replace "^\s+" | ? { $_.Length -gt 0 } | ? { $_ -notmatch "^\/\/" }
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
    [Object] $Output
    ShaderFileList([String]$Fullname)
    {
        $This.Fullname    = $Fullname
        $This.DisplayName = $Fullname | Split-Path -Parent | Split-Path -Leaf
        $This.Refresh()
    }
    Clear()
    {
        $This.Output = @( )
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

        $This.Output = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } }
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
