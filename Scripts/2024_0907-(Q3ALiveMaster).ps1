# This script helps to manage components needed to develop and distribute maps for Quake Live, including steamcmd integration

# // Load System.IO.Compression + Filesystem types [Allows direct control over (*.pk3) files]
Add-Type -Assembly System.IO.Compression, System.IO.Compression.Filesystem

Class Q3ALiveComponent
{
    [String] $Name
    [String] $Path
    [String] $Base
    Q3ALiveComponent([String]$Name,[String]$Path)
    {
        $This.Name = $Name
        $This.Path = $Path
        $This.Base = "$Path\baseq3"
    }
    [String] ToString()
    {
        Return "<Q3ALive.Component>"
    }
}

Class Q3ALiveRadiant
{
    [String]   $Name
    [String]   $Path
    [String] $Engine
    [String] $Q3Map2
    [String]   $Bspc
    Q3ALiveRadiant([String]$Path)
    {
        $This.Name   = "Radiant"
        $This.Path   = $Path
        $This.Engine = "$Path\radiant.exe"
        $This.Q3Map2 = "$Path\x64\q3map2.exe"
        $This.Bspc   = "$Path\bspc.exe"
    }
    [String] ToString()
    {
        Return "<Q3ALive.Radiant>"
    }
}

Class Q3ALiveWorkspaceEntry
{
    Hidden [UInt32] $Index
    [String]         $Type
    [String]         $Date
    [String]         $Name
    [UInt64]       $Length
    [String]     $Fullname
    Q3ALiveWorkspaceEntry([UInt32]$Index,[Object]$Object)
    {
        $This.Index    = $Index
        $This.Name     = $Object.Name
        $This.Fullname = $Object.Fullname
        $This.Date     = $Object.LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss")
        $This.Type     = @{ DirectoryInfo = "Directory"; FileInfo = "File" }[$Object.GetType().Name]
        $This.Length   = @($Object.Length;0)[[UInt32]$Object.Length -eq 1]
    }
    [String] ToString()
    {
        Return "<Q3ALive.Workspace.Entry>"
    }
}

Class Q3ALiveWorkspace
{
    [String]   $Name
    [String]   $Path
    [String]    $Log
    [Object] $Output
    Q3ALiveWorkspace([String]$Path)
    {
        $This.Name     = "Workspace"
        $This.Path     = $Path
        $This.Log      = "$($This.Path)\workspace.log"
        $This.CheckLog()
        $This.Refresh()
    }
    [Object[]] GetDirectories()
    {
        Return [System.IO.DirectoryInfo]::new($This.Path).EnumerateDirectories()
    }
    [Object[]] GetFiles()
    {
        Return [System.IO.DirectoryInfo]::new($This.Path).EnumerateFiles()
    }
    [Object] Q3ALiveWorkspaceEntry([UInt32]$Index,[Object]$Object)
    {
        Return [Q3ALiveWorkspaceEntry]::New($Index,$Object)
    }
    [Object[]] Directories()
    {
        Return $This.Output | ? Type -eq Directory
    }
    [Object[]] Files()
    {
        Return $This.Output | ? Type -eq File
    }
    Clear()
    {
        $This.Output = @( )
    }
    Rerank()
    {
        Switch ($This.Output.Count)
        {
            0
            {
                @( )
            }
            1
            {
                $This.Output[0].Index = 0
            }
            Default
            {
                ForEach ($X in 0..($This.Output.Count-1))
                {
                    $This.Output[$X].Index = $X
                }
            }
        }
    }
    Refresh()
    {
        $This.Clear()

        $Entries     = @{ }

        # // Get Directories
        ForEach ($Directory in $This.GetDirectories())
        {
            $Entries.Add($Entries.Count,$This.Q3ALiveWorkspaceEntry($Entries.Count,$Directory))
        }

        # // Get Files
        ForEach ($File in $This.GetFiles())
        {
            $Entries.Add($Entries.Count,$This.Q3ALiveWorkspaceEntry($Entries.Count,$File))
        }

        $xOutput    = Switch ($Entries.Count)
        {
            0       { @( )                            }
            1       { $Entries[0]                     }
            Default { $Entries[0..($Entries.Count-1)] }
        }

        $This.Output = $xOutput | Sort-Object Name

        $This.Rerank()
    }
    CheckLog()
    {
        If (![System.IO.File]::Exists($This.Log))
        {
            $Content = "[Workspace log file, created $([DateTime]::Now.ToString("MM/dd/yyyy HH:mm:ss"))]",
            $This.LogHeader()
            [System.IO.File]::WriteAllLines($This.Log,$Content)
        }
    }
    [String] LogHeader()
    {
        Return "Date       Time     Hash                             Source"
    }
    [String] ToString()
    {
        Return "<Q3ALive.Workspace>"
    }
}

Enum Q3ALiveMapAssetType
{
    levelshots
    maps
    models
    music
    scripts
    sound
    textures
}

Class Q3ALiveAssetEntry : Q3ALiveWorkspaceEntry
{
    Q3ALiveAssetEntry([UInt32]$Index,[Object]$Object) : base ($Index,$Object)
    {

    }
    [String] ToString()
    {
        Return "<Q3ALive.Asset.Entry>"
    }
}

Class Q3ALiveMapFile
{
    [String]   $Name
    [String]   $Path
    [String]   $Date
    [UInt32] $Exists
    Q3ALiveMapFile([String]$Name,[String]$Path)
    {
        $This.Name   = $Name
        $This.Path   = $Path
        $This.CheckFile()
    }
    CheckFile()
    {
        $File = [System.IO.File]::Exists($This.Path)
        If (!$File)
        {
            $This.Date   = "XX/XX/XXXX XX:XX:XX"
            $This.Exists = 0
        }
        Else
        {
            $This.Date   = [System.IO.FileInfo]::New($This.Path).LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss")
            $This.Exists = 1
        }
    }
}

Class Q3ALiveScriptContent
{
    [UInt32] $Index
    [String] $Line
    Q3ALiveScriptContent([UInt32]$Index,[String]$Line)
    {
        $This.Index = $Index
        $This.Line  = $Line
    }
    [String] ToString()
    {
        Return "<Q3ALive.Script.Content>"
    }
}

Class Q3ALiveScript
{
    [String] $Type
    [String] $Path
    [UInt32] $Exists
    [Object] $Content
    Q3ALiveScript([String]$Type)
    {
        $This.Type    = $Type
        $This.Path    = "<not set>"
        $This.Refresh()
    }
    Q3ALiveScript([String]$Type,[String]$Path)
    {
        $This.Type    = $Type
        $This.Path    = $Path
        $This.Refresh()
    }
    Check()
    {
        $This.Exists = [System.IO.File]::Exists($This.Path)
    }
    Clear()
    {
        $This.Content = @( )
    }
    [Object] Q3ALiveScriptContent([UInt32]$Index,[String]$Line)
    {
        Return [Q3ALiveScriptContent]::New($Index,$Line)
    }
    [Object[]] GetContent()
    {
        Return [System.IO.File]::ReadAllLines($This.Path)
    }
    SetContent()
    {
        $Bytes     = @( )
        ForEach ($Line in $This.Content.Line)
        {
            $Bytes += [System.Text.Encoding]::UTF8.GetBytes($Line)
            $Bytes += 10
        }

        [System.IO.File]::WriteAllBytes($This.Path,$Bytes)
    }
    Populate([String[]]$Lines)
    {
        $Hash         = @{ }
        ForEach ($Line in $Lines)
        {
            $Hash.Add($Hash.Count,$This.Q3ALiveScriptContent($Hash.Count,$Line))
        }

        $This.Content = @(Switch ($Hash.Count)
        {
            0 { $Null } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] }
        })
    }
    Refresh()
    {
        $This.Clear()
        $This.Check()
        Switch ($This.Exists)
        {
            0
            {

            }
            1
            {
                $This.Populate($This.GetContent())
            }
        }
    }
    Show()
    {
        [Console]::WriteLine(("[{0}]: {1}" -f $This.Type, $This.Path))
        ForEach ($Line in $This.Content.Line)
        {
            [Console]::WriteLine($Line)
        }
    }
    [String] ToString()
    {
        Return "<Q3ALive.Map.Script>"
    }
}

Class Q3ALiveArena : Q3ALiveScript
{
    [String] $Type
    [String] $Path
    [UInt32] $Exists
    [Object] $Content
    Q3ALiveArena([String]$Type) : base([String]$Type)
    {

    }
    Q3ALiveArena([String]$Type,[String]$Path) : base([String]$Type,[String]$Path)
    {

    }
    [String] ToString()
    {
        Return "<Q3ALive.Map.Script.Arena>"
    }
}

Class Q3ALiveShader : Q3ALiveScript
{
    [String] $Type
    [String] $Path
    [UInt32] $Exists
    [Object] $Content
    Q3ALiveShader([String]$Type,[String]$Path) : base([String]$Type,[String]$Path)
    {

    }
    [String] ToString()
    {
        Return "<Q3ALive.Map.Script.Shader>"
    }
}

Class Q3ALiveMap
{
    [String]      $Name
    [String]      $Path
    [String]    $Source
    [String]    $Target
    [Object]     $Arena
    [Object]    $Shader
    [Object]    $Output
    Q3ALiveMap([String]$Name,[String]$Path)
    {
        $This.Name   = $Name
        $This.Path   = $Path
        $This.Target = "$Path.pk3"
        $This.CheckAssetTypes()
        $This.Refresh()
    }
    [Object] Q3ALiveMapFile([String]$Name,[String]$Path)
    {
        Return [Q3ALiveMapFile]::New($Name,$Path)
    }
    [Object] Q3ALiveAssetEntry([UInt32]$Index,[Object]$Object)
    {
        Return [Q3ALiveAssetEntry]::New($Index,$Object)
    }
    [Object] Q3ALiveArena([String]$Path)
    {
        Return [Q3ALiveArena]::New("Arena",$Path)
    }
    [Object] Q3ALiveShader([String]$Path)
    {
        Return [Q3ALiveShader]::New("Shader",$Path)
    }
    [Object] Q3ALiveScript([String]$Path)
    {
        Return [Q3ALiveScript]::New("Script",$Path)
    }
    [String[]] AssetTypes()
    {
        Return [System.Enum]::GetNames([Q3ALiveMapAssetType])
    }
    CheckAssetTypes()
    {
        ForEach ($Name in $This.AssetTypes())
        {
            $xPath = "$($This.Path)\$Name"
            If (![System.IO.Directory]::Exists($xPath))
            {
                [System.IO.Directory]::CreateDirectory($xPath) > $Null
            }
        }
    }
    [Object[]] Assets()
    {
        Return $This.Output
    }
    Clear()
    {
        $This.Output = @( )
    }
    Refresh()
    {
        $This.Clear()
        
        $Assets = Get-ChildItem $This.Path -Recurse | Sort-Object Fullname
        $Hash   = @{ }
        ForEach ($Asset in $Assets)
        {
            $Hash.Add($Hash.Count,$This.Q3ALiveAssetEntry($Hash.Count,$Asset))
        }
    
        $This.Output = Switch ($Hash.Count)
        {
            0       { @( )                      }
            1       { $Hash[0]                  }
            Default { $Hash[0..($Hash.Count-1)] }
        }

        [Console]::WriteLine("Found [+] Map assets: [$($This.Name)], ($($This.Output.Count)) item(s)")

        $Base             = "{0}\scripts\{1}" -f $This.Path, $This.Name
        $This.GetArena()  > $Null
        $This.GetShader() > $Null
    }
    [String] Scripts([String]$Type)
    {
        Return "{0}\scripts\{1}.{2}" -f $This.Path, $This.Name, $Type
    }
    [Object] GetArena()
    {
        $This.Arena  = $This.Q3ALiveArena($This.Scripts("arena"))

        Return $This.Arena
    }
    [Object] GetShader()
    {
        $This.Shader  = $This.Q3ALiveShader($This.Scripts("shader"))

        Return $This.Shader
    }
    SetArena([String[]]$Script)
    {
        $This.Arena.Populate($Script)
    }
    SetShader([String[]]$Script)
    {
        $This.Shader.Populate($Script)
    }
    SetSource([String]$Path)
    {
        Switch ([UInt32][System.IO.File]::Exists($Path))
        {
            0
            {
                Throw "Exception [!] Source file does not exist"
            }

            1
            {
                $This.Source = $Path
            }
        }
    }
    [String] ToString()
    {
        Return "<Q3ALive.Map>"
    }
}

Class SteamWorkshopCredential
{
    Hidden [PSCredential] $Credential
    [String]                $Username
    Hidden [String]         $Password
    SteamWorkshopCredential([String]$Path)
    {
        If (![System.IO.File]::Exists($Path))
        {
            Throw "Invalid path"
        }

        $Xml  = Import-CliXml $Path -EA 0
        If (!$Xml -or $Xml.GetType().Name -ne "PSCredential")
        {
            Throw "Invalid target specified"
        }
        Else
        {
            $This.Inject($Xml)
        }
    }
    Inject([PSCredential]$Credential)
    {
        $This.Credential = $Credential
        $This.Username   = $Credential.UserName
        $This.Password   = $Credential.GetNetworkCredential().Password
    }
    [String] ToString()
    {
        Return "<Steam.Workshop.Credential>"
    }
}

Class SteamWorkshopProjectContentLine
{
    [UInt32] $Index
    [String] $Line
    SteamWorkshopProjectContentLine([UInt32]$Index,[String]$Line)
    {
        $This.Index = $Index
        $This.Line  = $Line
    }
    [String] ToString()
    {
        Return "<Steam.Workshop.Project.Content.Line>"
    }
}

Class SteamWorkshopProjectContent
{
    [UInt32] $Index
    [String] $Type
    [String] $Date
    [String] $Name
    [String] $Fullname
    [UInt32] $Exists
    SteamWorkshopProjectContent([UInt32]$Index,[Object]$Object)
    {
        $This.Index    = $Index
        $This.Type     = @("File","Directory")[[UInt32]$Object.PSIsContainer]
        $This.Date     = $This.DateFormat($Object.LastWriteTime)
        $This.Name     = $Object.Name
        $This.Fullname = $Object.Fullname
        $This.Check()
    }
    SteamWorkshopProjectContent([Switch]$Flags,[UInt32]$Index,[String]$Name)
    {
        $This.Index    = $Index
        $This.Type     = "File"
        $This.Name     = $Name
        $This.Fullname = "<not set>"
        $This.Check()
    }
    [Object] SteamWorkshopProjectContentLine([UInt32]$Index,[String]$Line)
    {
        Return [SteamWorkshopProjectContentLine]::New($Index,$Line)
    }
    [String] DateFormat([DateTime]$Object)
    {
        Return $Object.ToString("MM/dd/yyyy HH:mm:ss")
    }
    Check()
    {
        $Item          = Get-Item $This.Fullname -EA 0
        $This.Exists   = !!$Item
        If (!$Item)
        {
            $This.Date = "<not set>"
        }
        If (!!$Item)
        {
            $This.Date = $This.DateFormat($Item.LastWriteTime)
        }
    }
    [String] ToString()
    {
        Return "<Steam.Workshop.Project.Content>"
    }
}

Class SteamWorkshopProjectPreview : SteamWorkshopProjectContent
{
    [UInt32] $Index
    [String] $Type
    [String] $Date
    [String] $Name
    [String] $Fullname
    [UInt32] $Exists
    [Byte[]] $Bytes
    SteamWorkshopProjectPreview([UInt32]$Index,[Object]$Object) : base ($Index,$Object)
    {

    }
    SteamWorkshopProjectPreview([Switch]$Flags,[UInt32]$Index,[String]$Name) : base ($Flags,$Index,$Name)
    {

    }
    GetBytes()
    {
        $This.Bytes = [System.IO.File]::ReadAllBytes($This.Fullname)
    }
    [String] ToString()
    {
        Return "<Steam.Workshop.Project.Vdf>"
    }
}

Class SteamWorkshopProjectItem
{
    [String] $Name
    [String] $Fullname
    [UInt32] $Exists
    [Object] $Content
    [String] $AppId
    [String] $PublishedFileId
    [String] $ContentFolder
    [String] $PreviewFile
    [String] $Visibility
    [String] $Title
    [String] $Description
    [String] $ChangeNote
    SteamWorkshopProjectItem([Object]$Object)
    {
        $This.Inject($Object)
    }
    SteamWorkshopProjectItem([Switch]$Flags)
    {
        $This.Name     = "<not set>"
        $This.Fullname = "<not set>"
        $This.Exists   = 0
        $This.Content  = @( )
        $This.Defaults()
    }
    SteamWorkshopProjectItem([Switch]$Flags,[Object]$Object)
    {
        $This.Inject($Object)
    }
    SteamWorkshopProjectItem([Switch]$Flags,
    [Object] $Object,
    [String] $AppId,
    [String] $PublishedFileId,
    [String] $ContentFolder,
    [String] $PreviewFile,
    [String] $Visibility,
    [String] $Title,
    [String] $Description,
    [String] $ChangeNote)
    {
        $This.Inject($Object)
        $This.AppId           = $AppId
        $This.PublishedFileId = $PublishedFileId
        $This.ContentFolder   = $ContentFolder
        $This.PreviewFile     = $PreviewFile
        $This.Visibility      = $Visibility
        $This.Title           = $Title
        $This.Description     = $Description
        $This.ChangeNote      = $ChangeNote
    }
    Defaults()
    {
        $This.AppId           = "282440"
        $This.PublishedFileId = "0"
        $This.ContentFolder   = "<not set>"
        $This.PreviewFile     = "<not set>"
        $This.Visibility      = "0"
        $This.Title           = "<not set>"
        $This.Description     = "<not set>"
        $This.ChangeNote      = "<not set>"
    }
    Inject([Object]$Object)
    {
        $This.Name     = $Object.Name
        $This.Fullname = $Object.Fullname
        $This.Check()

        Switch ($This.Exists)
        {
            0
            {
                $This.Defaults()
                $This.Content = @( )
            }
            1
            {
                $Hash = @{ }
                ForEach ($Line in [System.IO.File]::ReadAllLines($This.Fullname))
                {
                    $Hash.Add($Hash.Count,$This.Line($Hash.Count,$Line))

                    Switch -Regex ($Line)
                    {
                        appid           { $This.AppId           = $Line.Split('"')[3] }
                        publishedfileid { $This.PublishedFileId = $Line.Split('"')[3] }
                        contentfolder   { $This.ContentFolder   = $Line.Split('"')[3] }
                        previewfile     { $This.PreviewFile     = $Line.Split('"')[3] }
                        visibility      { $This.Visibility      = $Line.Split('"')[3] }
                        title           { $This.Title           = $Line.Split('"')[3] }
                        description     { $This.Description     = $Line.Split('"')[3] }
                        changenote      { $This.ChangeNote      = $Line.Split('"')[3] }
                    }
                }

                $This.Content = Switch ($Hash.Count)
                {
                    0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] }
                }
            }
        }
    }
    GenerateContent()
    {
        If ($This.ContentFolder -eq "<not set>" -or ![System.IO.Directory]::Exists($This.ContentFolder))
        {
            Throw "Exception [!] Invalid content folder path"
        }
        ElseIf ($This.PreviewFile -eq "<not set>" -or ![System.IO.File]::Exists($This.PreviewFile))
        {
            Throw "Exception [!] Invalid preview file"
        }
        ElseIf ($This.Title -eq "<not set>")
        {
            Throw "Exception [!] Invalid title"
        }
        ElseIf ($This.Description -eq "<not set>")
        {
            Throw "Exception [!] Invalid description"
        }
        ElseIf ($This.ChangeNote -eq "<not set>")
        {
            Throw "Exception [!] Invalid change note"
        }
        Else
        {
            $This.Content = @( )
            $Hash         = @{ }
            ForEach ($xLine in $This.Template())
            {
                $Hash.Add($Hash.Count,$This.Line($Hash.Count,$xLine))
            }

            $This.Content = Switch ($Hash.Count)
            {
                0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] }
            }
        }
    }
    [String[]] GetContent()
    {
        Return [System.IO.File]::ReadAllLines($This.Fullname)    
    }
    SetContent()
    {
        [System.IO.File]::WriteAllLines($This.Fullname,$This.Content.Line)
    }
    Check()
    {
        $This.Exists   = [System.IO.File]::Exists($This.Fullname)
    }
    [Object] Line([Uint32]$Index,[String]$Line)
    {
        Return $This.SteamWorkshopProjectContentLine($Index,$Line)
    }
    [Object] SteamWorkshopProjectContentLine([UInt32]$Index,[String]$Line)
    {
        Return [SteamWorkshopProjectContentLine]::New($Index,$Line)
    }
    [String[]] Template()
    {
        Return @(
        "workshopitem";
        "{";
        "  `"appid`"           `"{0}`"" -f $This.AppId;
        "  `"publishedfileid`" `"{0}`"" -f $This.PublishedFileId;
        "  `"contentfolder`"   `"{0}\`"" -f $This.ContentFolder.TrimEnd("\");
        "  `"previewfile`"     `"{0}`"" -f $This.PreviewFile;
        "  `"visibility`"      `"{0}`"" -f $This.Visibility;
        "  `"title`"           `"{0}`"" -f $This.Title;
        "  `"description`"     `"{0}`"" -f $This.Description;
        "  `"changenote`"      `"{0}`"" -f $This.ChangeNote;
        "}")
    }
    [String] ToString()
    {
        Return "<Steam.Workshop.Project.Item>"
    }
}

Class SteamWorkshopProject
{
    [UInt32]           $Index
    [String]            $Date
    [String]            $Name
    Hidden [String] $Fullname
    [UInt32]          $Exists
    [Object]             $Vdf
    [Object]         $Preview
    [Object]         $Content
    SteamWorkshopProject([UInt32]$Index,[Object]$Directory)
    {
        $This.Index       = $Index
        $This.Name        = $Directory.Name
        $This.Fullname    = $Directory.Fullname
        $This.Check()
    }
    SteamWorkshopProject([Switch]$Flags,[UInt32]$Index,[String]$Parent,[String]$Name)
    {
        $This.Index        = $Index
        $This.Name         = $Name
        $This.Fullname     = "$Parent\$Name"
        $This.Check()
    }
    Check()
    {
        $This.Exists       = [System.IO.Directory]::Exists($This.Fullname)
        Switch ($This.Exists)
        {
            0 { $This.Date = "<unknown>" } 
            1 { $This.Date = [System.IO.Directory]::GetLastWriteTime($This.Fullname).ToString("MM/dd/yyyy") }
        }
    }
    Create()
    {
        $This.Check()
        If (!$This.Exists)
        {
            [Console]::WriteLine("Creating [~] Project: $($This.Name)")
            [System.IO.Directory]::CreateDirectory($This.Fullname) > $Null
            $This.Check()

            If ($This.Exists)
            {
                # Content
                [System.IO.Directory]::CreateDirectory("$($This.Fullname)\content") > $Null
                $This.Populate()
            }
        }
    }
    Remove()
    {
        $This.Check()
        If ($This.Exists)
        {
            [Console]::WriteLine("Removing [~] Project: $($This.Name)")
            [System.IO.Directory]::Delete($This.Fullname,$True)
            $This.Check()
        }
    }
    Populate()
    {
        $Hash             = @{ }
        ForEach ($Item in Get-ChildItem $This.Fullname -Recurse)
        {
            $Hash.Add($Hash.Count,$This.SteamWorkshopProjectContent($Hash.Count,$Item))
        }

        $This.Content     = Switch ($Hash.Count)
        {
            0 { @( ) } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] }
        }

        # [Check VDF]
        $xVdf           = $This.Content | ? Name -match \.vdf
        If (!$xVdf)
        {
            $This.Vdf          = $This.SteamWorkshopProjectItem($False)
            $This.Vdf.Name     = "{0}.vdf" -f $This.Name
            $This.Vdf.Fullname = $This.Fullname, $This.Vdf.Name -join "\"
        }
        Else
        {
            $This.Vdf   = $This.SteamWorkshopProjectItem($xVdf)
        }
        
        # [Check Preview]
        $xFilter          = "{0}\content\preview" -f $This.Fullname
        $Escape           = [Regex]::Escape($xFilter)
        $xPreview         = $This.Content | ? FullName -match $Escape
        
        If (!!$xPreview)
        {
            $This.Preview = $This.SteamWorkshopProjectPreview($xPreview.Index,(Get-Item $xPreview.Fullname))
        }
        Else 
        {
            $This.Preview = $This.SteamWorkshopProjectPreview($True,$xPreview.Index,"preview.jpg")
        }
    }
    [Object] SteamWorkshopProjectContent([UInt32]$Index,[Object]$Object)
    {
        Return [SteamWorkshopProjectContent]::New($Index,$Object)
    }
    [Object] SteamWorkshopProjectContent([Switch]$Flags,[UInt32]$Index,[Object]$Object)
    {
        Return [SteamWorkshopProjectContent]::New($Flags,$Index,$Object)
    }
    [Object] SteamWorkshopProjectPreview([UInt32]$Index,[Object]$Object)
    {
        Return [SteamWorkshopProjectPreview]::New($Index,$Object)
    }
    [Object] SteamWorkshopProjectPreview([Switch]$Flags,[UInt32]$Index,[String]$Name)
    {
        Return [SteamWorkshopProjectPreview]::New($Flags,$Index,$Name)
    }
    [Object] SteamWorkshopProjectItem([Object]$Object)
    {
        Return [SteamWorkshopProjectItem]::New($Object)
    }
    [Object] SteamWorkshopProjectItem([Switch]$Flags)
    {
        Return [SteamWorkshopProjectItem]::New($Flags)
    }
    [Object] SteamWorkshopProjectItem([Switch]$Flags,[Object]$Object)
    {
        Return [SteamWorkshopProjectItem]::New($Flags,$Object)
    }
    [Object] SteamWorkshopProjectItem([Switch]$Flags,
    [Object] $Object,
    [String] $AppId,
    [String] $PublishedFileId,
    [String] $ContentFolder,
    [String] $PreviewFile,
    [String] $Visibility,
    [String] $Title,
    [String] $Description,
    [String] $ChangeNote)
    {
        Return [SteamWorkshopProjectItem]::New($Flags,$Object,$AppId,
        $PublishedFileId,
        $ContentFolder,
        $PreviewFile,
        $Visibility,
        $Title,
        $Description,
        $ChangeNote)
    }
    [Object] DefaultTemplate([String]$Content,[String]$Preview,[String]$Title,[string]$Description,[String]$ChangeNote)
    {
        Return $This.SteamWorkshopProjectItem(282440,0,$Content,$Preview,0,$Title,$Description,$ChangeNote)
    }
    [String] ContentPath()
    {
        Return $This.Content | ? Name -eq content | % Fullname
    }
    SetPreview([String]$File)
    {
        $Extension = "." + $File.Split(".")[-1]

        If (![System.IO.File]::Exists($File))
        {
            Throw "Invalid preview file"
        }

        If ($This.Preview.Fullname -eq "<not set>")
        {
            $This.Preview.Fullname = "{0}\{1}" -f $This.ContentPath(), $This.Preview.Name
        }

        If ($This.Preview.Name -notmatch $Extension)
        {
            $Ext = "." + $This.Preview.Name.Split(".")[-1]
            $This.Preview.Name.Replace($Ext,$Extension)
            $This.Preview.Fullname = "{0}\{1}" -f $This.ContentPath(), $This.Preview.Name
        }

        [System.IO.File]::Copy($File,$This.Preview.Fullname)

        $This.Preview.Check()

        $This.Populate()
    }
    SetVdf([Hashtable]$Vdf)
    {
        $This.Vdf.AppId           = $Vdf.AppId
        $This.Vdf.PublishedFileId = $Vdf.PublishedFileId
        $This.Vdf.ContentFolder   = $Vdf.ContentFolder
        $This.Vdf.PreviewFile     = $Vdf.PreviewFile
        $This.Vdf.Visibility      = $Vdf.Visibility
        $This.Vdf.Title           = $Vdf.Title
        $This.Vdf.Description     = $Vdf.Description
        $This.Vdf.ChangeNote      = $Vdf.ChangeNote

        $This.Vdf.GenerateContent()
        $This.Vdf.SetContent()

        $This.Populate()
    }
    SetPk3([String]$File)
    {
        $Item = Get-Item $File -EA 0

        If (!$Item)
        {
            Throw "Exception [!] Invalid path"
        }
        ElseIf ($Item.Extension -ne ".pk3")
        {
            Throw "Exception [!] Invalid (*.pk3) file"
        }
        Else
        {
            $xDest = "{0}\{1}" -f $This.ContentPath(), $Item.Name
            [System.IO.File]::Copy($Item.Fullname,$xDest,$True)

            $This.Populate()
        }
    }
    [String] ToString()
    {
        Return "<Steam.Workshop.Project>"
    }
}

Class SteamWorkshopMaster
{
    [String]       $Path
    [String]        $Cmd
    [Object] $Credential
    [Object]   $Workshop
    [Object]    $Project
    [UInt32]  $Selection
    SteamWorkshopMaster([String]$Path)
    {
        If (![System.IO.Directory]::Exists($Path))
        {
            Throw "Invalid path"
        }

        $This.Path = $Path
        $This.Cmd  = Get-ChildItem $Path | ? Name -eq steamcmd.exe | % Fullname
        $This.Check()

        $List = $This.List()
        Switch ($List.Count)
        {
            1 { $This.LoadXml($List[0]) }
            Default { }
        }
    }
    [String] Q3ALive()
    {
        Return "HKLM:\SOFTWARE\Policies\Secure Digits Plus LLC\Q3ALive"
    }
    [String] Now()
    {
        Return [DateTime]::Now.ToString("yyyyMMdd_HHmmss")
    }
    [Object] SteamWorkshopCredential([String]$Path)
    {
        Return [SteamWorkshopCredential]::New($Path)
    }
    [Object] SteamWorkshopProject([UInt32]$Index,[Object]$Directory)
    {
        Return [SteamWorkshopProject]::New($Index,$Directory)
    }
    [Object] SteamWorkshopProject([Switch]$Flags,[Uint32]$Index,[String]$Parent,[String]$Name)
    {
        Return [SteamWorkshopProject]::New($Flags,$Index,$Parent,$Name)
    }
    SetSelection([UInt32]$Index)
    {
        If ($This.Project.Count -le 0)
        {
            Throw "Invalid project count"
        }
        ElseIf ($This.Project.count -eq 1 -and $Index -ne 0)
        {
            Throw "Invalid index"
        }
        ElseIf ($This.Project.Count -gt 1 -and $Index -gt $This.Project.Count)
        {
            Throw "Invalid index"
        }
        Else
        {
            $This.Selection = $Index   
        }
    }
    Check()
    {
        # Validate registry entry
        If (!(Test-Path $This.Q3ALive()))
        {
            $xPath   = $This.Q3ALive().Split("\")
            $Current = $xPath[0..2] -join "\"
            $X       = 3
            Do
            {
                $Current = $Current, $xPath[$X] -join "\"
                If (!(Test-Path $Current))
                {
                    New-Item -Path $Current
                }
                $X ++
            }
            Until ($X -eq $xPath.Count)
        }
    }
    [String[]] List()
    {
        # Existing registry entry
        $List = Get-ChildItem $This.Q3ALive()
        $Slot = Switch ($List.Count)
        {
            0 { } Default { $List.PSChildName }
        }

        Return $Slot
    }
    LoadXml([String]$Slot)
    {
        $XmlPath = Get-ItemProperty "HKLM:\SOFTWARE\Policies\Secure Digits Plus LLC\Q3ALive\$Slot" | % Workshop
        If (![System.IO.File]::Exists($XmlPath))
        {
            Throw "Invalid target"
        }

        $This.Credential = $This.SteamWorkshopCredential($XmlPath)
    }
    SetWorkshop([String]$Path)
    {
        # [Steam Workshop Project]
        If (![System.IO.Directory]::Exists($Path))
        {
            $Parent = $Path | Split-Path -Parent
            If (![System.IO.Directory]::Exists($Parent))
            {
                Throw "Invalid directory"
            }

            [System.IO.Directory]::CreateDirectory($Path)
        }

        $This.Workshop = $Path
        $This.GetProject()
    }
    GetProject()
    {
        If (!$This.Workshop)
        {
            Throw "Workshop not set"
        }

        $This.Project = @( )
        ForEach ($Item in Get-ChildItem $This.Workshop)
        {
            $This.Project += $This.SteamWorkshopProject($This.Project.Count,$Item)
        }
    }
    RemoveProject([String]$Name)
    {        
        $Item = $This.Project | ? Name -eq $Name
        If (!!$Item)
        {
            $Item.Remove()
        }

        $This.GetProject()
    }
    CreateProject([String]$Name)
    {        
        # [Steam Workshop Project]
        If ($Name -in $This.Project.Name)
        {
            Throw "Project already exists"
        }

        $Item = $This.SteamWorkshopProject($True,$This.Project.Count,$This.Workshop,$Name)
        If (!!$Item)
        {   
            $Item.Create()
        }

        $This.GetProject()
    }
    UploadProject()
    {
        # [Upload to workshop]
        $Param = $This.Credential | % { "+login {0} {1} +workshop_build_item {2} +quit" -f $_.Username, $_.Password, $This.Current().Vdf.Fullname }

        Start-Process -FilePath $This.Cmd -ArgumentList $Param -NoNewWindow -Wait
    }
    [Object] Current()
    {
        If (!$This.Selection)
        {
            Throw "Invalid selection"
        }

        Return $This.Project[$This.Selection]
    }
    [String] ToString()
    {
        Return "<Steam.Workshop.Master>"
    }
}

Class Q3ALiveMaster
{
    [Object]      $Component
    [Object]        $Radiant
    [Object]      $Workspace
    [Object]            $Map
    [Object]          $Steam
    Hidden [DateTime] $Start
    Hidden [String]   $Color
    Q3ALiveMaster()
    {
        $This.Color  = [Console]::ForegroundColor
        $This.Refresh()
    }
    [Object] Q3ALiveComponent([String]$Name,[String]$Path)
    {
        Return [Q3ALiveComponent]::New($Name,$Path)
    }
    [Object] Q3ALiveRadiant([String]$Path)
    {
        Return [Q3ALiveRadiant]::New($Path)
    }
    [Object] Q3ALiveWorkspace([String]$Path)
    {
        Return [Q3ALiveWorkspace]::New($Path)
    }
    [Object] Q3ALiveMap([String]$Name,[String]$Directory)
    {
        Return [Q3ALiveMap]::New($Name,$Directory)
    }
    [Object] SteamWorkshopMaster([String]$Path)
    {
        Return [SteamWorkshopMaster]::New($Path)
    }
    [Bool] CheckDirectory($Path)
    {
        Return [System.IO.Directory]::Exists($Path)
    }
    [Object[]] GetFiles($Path)
    {
        Return [System.IO.DirectoryInfo]::new($Path).EnumerateFiles()
    }
    [Object[]] GetDirectories($Path)
    {
        Return [System.IO.DirectoryInfo]::new($Path).EnumerateDirectories()
    }
    [String[]] Registry()
    {
        Return "", "\WOW6432Node" | % { "Hklm:\Software$_\Microsoft\Windows\CurrentVersion\Uninstall\*" }
    }
    [String] MapBspAas()
    {
        Return "{0}\.(aas|bsp)" -f $This.Map.Name
    }
    [String] Escape([String]$String)
    {
        Return [Regex]::Escape($String)
    }
    ExtractTexture([String]$Archive,[String]$Texture)
    {
        <#
        $Game      = "C:/Program Files (x86)/Quake III Arena/"
        $Zip       = [System.IO.Compression.ZipFile]::OpenRead("$Game\baseq3\pak0.pk3")
        $Path      = "C:\Workspace\testextract"
        $Entry     = $Zip.Entries[900]

        # // Extract entry to file
        $Target    = "{0}\{1}" -f $Path, $Entry.Fullname
        $Directory = Split-Path $Target -Parent
        If (![System.IO.Directory]::Exists($Directory))
        {
            [System.IO.Directory]::CreateDirectory($Directory)
        }

        [System.IO.Compression.ZipFileExtensions]::ExtractToFile($Entry,$Target,$True)
        #>
    }
    Clear()
    {
        $This.Component = @( )
    }
    Refresh()
    {
        $This.Clear()

        # // Get the list of installed programs from the uninstall registry paths
        [Console]::WriteLine("Getting [~] Installed programs")

        $Registry = $This.Registry() | % { Get-ItemProperty $_ }

        # // If "Quake III Arena" found, parse out the installation directory and add the component
        $Q3A      = $Registry | ? DisplayName -eq "Quake III Arena"
        If ($Q3A)
        {
            $Path = ($Q3A.UninstallString -Split '"')[1] | Split-Path
            If ($This.CheckDirectory($Path))
            {
                If ("quake3.exe" -in $This.GetFiles($Path).Name)
                {
                    $This.Component += $This.Q3ALiveComponent("Q3A",$Path)
                    [Console]::WriteLine("Found [+] Component: [Quake III Arena]")
                }
            }
        }

        # [QLive settings]
        $Live     = $Registry | ? DisplayName -eq "Quake Live"
        If ($Live)
        {
            $Path = $Live.InstallLocation
            If ($This.CheckDirectory($Path))
            {
                If ("quakelive_steam.exe" -in $This.GetFiles($Path).Name)
                {
                    $This.Component +=  $This.Q3ALiveComponent("Live",$Path)
                    [Console]::WriteLine("Found [+] Component: [Quake Live]")
                }
            }
        }
    }
    SetRadiant([String]$Path)
    {
        If ($This.CheckDirectory($Path))
        {
            If ("radiant.exe" -in $This.GetFiles($Path).Name)
            {
                [Console]::WriteLine("Setting [~] Radiant path: [$Path]")
                $This.Radiant = $This.Q3ALiveRadiant($Path)
            }
        }
    }
    SetWorkspace([String]$Path)
    {
        If ("Q3A" -notin $This.Component.Name)
        {
            Throw "Exception [!] Must have [Quake III Arena] installed"
        }
        
        If ("Live" -notin $This.Component.Name)
        {
            Throw "Exception [!] Must have [Quake Live] installed"
        }

        If (!$This.Radiant)
        {
            Throw "Exception [!] Must set [Radiant] path"
        }
        
        If ($This.CheckDirectory($Path))
        {
            [Console]::WriteLine("Setting [~] Workspace path: [$Path]")
            $This.Workspace = $This.Q3ALiveWorkspace($Path)
        }
    }
    SetMap([String]$Name)
    {
        If ("Q3A" -notin $This.Component.Name)
        {
            Throw "Exception [!] Must have [Quake III Arena] installed"
        }

        If (!$This.Workspace)
        {
            Throw "Exception [!] Must set a workspace path"
        }

        $AssetPath = "{0}\{1}" -f $This.Workspace.Path, $Name

        If ($Name -notin $This.Workspace.Directories().Name)
        {
            [System.IO.Directory]::CreateDirectory($AssetPath)
        }

        If ([System.IO.Directory]::Exists($AssetPath))
        {
            [Console]::WriteLine("Setting [~] Map asset path: [$AssetPath]")
            $This.Map           = $This.Q3ALiveMap($Name,$AssetPath)
        }

        $xSource = "{0}\maps\{1}.map" -f $This.Q3A().Base, $This.Map.Name

        Switch ([UInt32][System.IO.File]::Exists($xSource))
        {
            0 { Throw "Exception [!] Map file not found in [Quake III Arena\baseq3\maps] directory" }
            1 { $This.Map.SetSource($xSource)                                                       }
        }
    }
    SetSteam([String]$Path)
    {
        $This.Steam = $This.SteamWorkshopMaster($Path)
    }
    [Object] Live()
    {
        Return $This.Component | ? Name -eq Live
    }
    [Object] Q3A()
    {
        Return $This.Component | ? Name -eq Q3A
    }
    [String] Q3Map2()
    {
        Return $This.Radiant.Q3Map2
    }
    [String] Bspc()
    {
        Return $This.Radiant.Bspc
    }
    [String] GetParam([UInt32]$Phase)
    {
        $Param = Switch ($Phase)
        {
            0
            {
                "-v";
                "-connect 127.0.0.1:39000";
                "-game quakelive";
                '-fs_basepath "{0}"' -f $This.Q3A().Path;
                '-meta "{0}"' -f $This.Map.Source
            }
            1
            {
                "-connect 127.0.0.1:39000";
                "-game quakelive";
                '-fs_basepath "{0}"' -f $This.Q3A().Path;
                "-vis";
                '-saveprt "{0}"' -f $This.Map.Source
            }
            2
            {
                "-connect 127.0.0.1:39000";
                "-game quakelive";
                '-fs_basepath "{0}"' -f $This.Q3A().Path;
                "-light";
                "-fast";
                "-patchshadows";
                "-samples 2";
                "-bounce 2";
                "-dirty";
                "-gamma 2";
                "-compensate 4";
                '"{0}"' -f $This.Map.Source
            }
            3
            {
                "-optimize";
                "-forcesidesvisible";
                '-bsp2aas "{0}"' -f $This.Map.Source
            }
        }

        $Param = $Param -join " "
        
        Return $Param -join " "
    }
    WriteStatus([UInt32]$Phase)
    {
        $Span  = [DateTime]::Now - $This.Start
        $Slot  = $Phase + 1

        [Console]::ForegroundColor = "Green"
        [Console]::WriteLine("`n=================================`n| $Span [+] Part ($Slot) |`n=================================`n")
        [Console]::ForegroundColor = $This.Color
    }
    SetArena([String]$Script)
    {
        $Entry = $Script -Split "`n"
        $This.Map.SetArena($Entry)

        #$This.Map.Arena.SetContent()
    }
    SetShader([String]$Script)
    {
        $Entry = $Script -Split "`n"
        $This.Map.SetShader($Entry)

        #$This.Map.Shader.SetContent()
    }
    Compile()
    {
        # // Runs the compilation process for the (*.bsp) and (*.aas) files
        If (!$This.Q3A())
        {
            Throw "Exception [!] Q3A not detected"
        }

        If (!$This.Radiant)
        {
            Throw "Exception [!] Radiant not detected"
        }

        If (!$This.Map.Source)
        {
            Throw "Exception [!] Map source not set"
        }
        
        $This.Start  = [DateTime]::Now
        [Console]::WriteLine("Compiling [~] $($This.Map.Source)")

        # // Compiling BSP part 1

        Start-Process -FilePath $This.Q3Map2() -ArgumentList $This.GetParam(0) -NoNewWindow -Wait
    
        $Lin  = Get-Item $This.Map.Source.Replace(".map",".lin") -EA 0
        If ($Lin)
        {
            If (($Lin.LastWriteTime - $This.Start).TotalSeconds -gt 0)
            {
                Throw "Exception [!] Map file leaked"
            }
        }

        $This.WriteStatus(0)

        # // Compiling BSP part 2
        Start-Process -FilePath $This.Q3Map2() -ArgumentList $This.GetParam(1) -NoNewWindow -Wait

        $This.WriteStatus(1)

        # // Compiling BSP part 3
        Start-Process -FilePath $This.Q3Map2() -ArgumentList $This.GetParam(2) -NoNewWindow -Wait

        $This.WriteStatus(2)

        # // Compiling AAS part 4
        Start-Process -FilePath $This.Bspc() -ArgumentList $This.GetParam(3) -NoNewWindow -Wait

        $This.WriteStatus(3)

        [Console]::WriteLine("Compiled [+] Map: [$($This.Map.Source)]")

        # // Updates the (map + asset) folder with the newly created (*.bsp) and (*.aas) files
        [Console]::WriteLine("Updating [~] (Map + Asset) folder with newly created (*.bsp) and (*.aas) files")

        $BspAas = Get-ChildItem "$($This.Q3A().Base)\maps" | ? Name -match $This.MapBspAas()

        ForEach ($Item in $BspAas)
        {
            $New = "{0}\maps\{1}" -f $This.Map.Path, $Item.Name

            If ([System.IO.File]::Exists($New))
            {
                [System.IO.File]::Delete($New)
            }

            [Console]::WriteLine("Moving [~] $($Item.Name)")

            [System.IO.File]::Move($Item.Fullname,$New)
        }

        $This.WriteStatus(4)

        [Console]::WriteLine("Updated [+] Map: [$($This.Map.Path)]")
    }
    Package()
    {
        # // Creates a new (*.pk3) file based on the content of (map + asset) folder

        If (!$This.Map)
        {
            Throw "Exception [!] Map template not set"
        }

        If (!$This.Map.Target)
        {
            Throw "Exception [!] Must set the asset target"
        }

        If ([System.IO.File]::Exists($This.Map.Target))
        {
            [Console]::WriteLine("Exists [!] Deleting [$($This.Map.Target)]")
            [System.IO.File]::Delete($This.Map.Target)
        }

        [Console]::WriteLine("Creating [~] [$($This.Map.Target)]")

        $7zip = "$Env:ProgramFiles\7-Zip\7z.exe"
        If (![System.IO.File]::Exists($7zip))
        {
            # $This.Map.Package() <- Issues w/ [System.IO.Compression.ZipFile] on linux systems
            # // System.IO.Compression
            [System.IO.Compression.ZipFile]::CreateFromDirectory($This.Map.Path,$This.Map.Target,"Optimal",$False)
        }
        Else
        {
            # // 7zip
            $Param = 'a -tzip -mx=5 {0}.pk3 "{1}\*" -o"{2}"' -f $This.Map.Name, $This.Map.Path, $This.Workspace.Path

            Start-Process -FilePath $7zip -WorkingDirectory $This.Workspace.Path -ArgumentList $Param -NoNewWindow -Wait
        }

        If ([System.IO.File]::Exists($This.Map.Target))
        {
            $Hash     = Get-FileHash -Algorithm MD5 $This.Map.Target | % Hash
            $LogEntry = "{0} {1} {2}" -f [DateTime]::Now.ToString("MM/dd/yyyy HH:mm:ss"), $Hash, $This.Map.Target
            $Writer   = [System.IO.File]::AppendText($This.Workspace.Log)
            $Writer.WriteLine($LogEntry)
            $Writer.Dispose()
            [Console]::WriteLine("")
            [Console]::WriteLine($This.Workspace.LogHeader())
            [Console]::WriteLine("----       ----     ----                             ------")
            [Console]::WriteLine($LogEntry)
            [Console]::WriteLine("")
        }

        $This.WriteStatus(5)
    }
    Transfer()
    {
        # // Transfer the map asset package to the [Quake Live] directory
        [Console]::WriteLine("Transferring [~] Package -> [Quake Live] directory")

        ForEach ($Item in $This.Q3A().Base, $This.Live().Base)
        {
            $Destination = "{0}\{1}" -f $Item, ($This.Map.Target | Split-Path -Leaf)

            If ([System.IO.File]::Exists($Destination))
            {
                [System.IO.File]::Delete($Destination)
            }

            [System.IO.File]::Copy($This.Map.Target,$Destination)

            [Console]::WriteLine("Transferred [+] Package: [$Destination]")
        }

        $This.WriteStatus(6)
    }
    Decompile([String]$Bsp)
    {
        <#
        If (![System.IO.File]::Exists($Bsp))
        {
            Throw "Invalid path"
        }

        Start-Process -FilePath $This.Q3Map2() -ArgumentList "-game ql -convert -format map $Bsp" -NoNewWindow -Wait

        $Map     = $Bsp.Replace(".bsp","_converted.map")
        $Content = [System.IO.File]::ReadAllLines($Map)
        $Content = $Content -replace "(\\{1})", "/"
        [System.IO.File]::WriteAllLines($Map,$Content)

        [Console]::WriteLine("Complete [+] $Map")
        #>
    }
    [String] ToString()
    {
        Return "<Q3ALive.Master>"
    }
}

<#
The concept of getting [Shaped By Fire]

Sometimes in life, you have to question what's right in front of you.
Take the album [Shaped By Fire] by [As I Lay Dying], for example.
One of the most legendary, classic, top-notch metal bands that have ever existed…

It's mean...?
It's in your face...?
That's just a short description of the album, [Shaped By Fire] for ya.

But, the reason I wrote this excerpt, is to have a little discussion about the difference
between the album [Shaped By Fire], versus actually being shaped by fire.
The concept of being shaped by fire should scare the shit out of whoever hears about it.
Seriously.

The ALBUM [Shaped By Fire], is something that you could in fact listen to right now.
You could support the band by visiting https://www.asilaydying.com/ and get yourself
some 1) merchandise or 2) information on their next projects + apppearances.

However, the CONCEPT of getting shaped by fire, is something that I think the founder
of the band found himself struggling with...

That is, having a ring of fire rain down upon you, from time to time, in a way that would
even cause [Johnny Cash] to stand in total shock and awe.

Over the years, I’ve found myself going on adventures with [Tim Lambesis], and [his crew.]
Teachers tried to tell me I was a troublemaker... but [frail words collapse].
Whether [shadows are security] in actuality, is beyond me.
There may have actually been [an ocean between us], at one point or another.
I'm not going to ego trip into a [powerless rise]...
...because I've been [awakened].
But- if I even see someone being [shaped by fire]...?
Well, I'm not gonna stand for that.

Friends don't let friends get [shaped by fire].
Unless it's the album [Shaped By Fire]. 
Then, you'd be doing your friends a real favor.
#>

$Radiant   = "C:\Games\GtkRadiant"
$Workspace = "C:\Workspace"
$MapName   = "insaneproducts"
$Steam     = "C:\Games\steam"
$Workshop  = "$Steam\Workshop"

$Ctrl      = [Q3ALiveMaster]::New()
$Ctrl.SetRadiant($Radiant)         # <- Assigns the path to radiant + compilation tools
$Ctrl.SetWorkspace($Workspace)     # <- Assigns a separate path for all map projects each containing their own assets

$Ctrl.SetMap($MapName)             # <- Assigns the map name, and will build folders for map assets to be packaged
$Ctrl.SetSteam($Steam)             # <- Assigns the path to steamcmd installation
$Ctrl.Steam.SetWorkshop($Workshop) # <- Assigns the path to Steam Workshop projects

$Remove = 0 # <- Prevents this little block from running
If ($Remove -eq 1)
{
    $Ctrl.Steam.RemoveProject($Ctrl.Map.Name)
}

# $Ctrl.Steam.Project <- Shows available projects in the Steam Workshop
$Create = 0 # <- Prevents this little block from running
If ($Create -eq 1)
{
    $Ctrl.Steam.CreateProject($Ctrl.Map.Name)
}

$Select = 0 # <- Prevents this little block from running
If ($Select -eq 1)
{
    $Selection = $Ctrl.Steam.Project | ? Name -match $MapName
    $Ctrl.Steam.SetSelection($Selection.Index)
    $Current = $Ctrl.Steam.Current()
    $Current.Populate()
}

$Preview = 0  # <- Prevents this little block from running
If ($Preview -eq 1)
{
    $Levelshot = $Ctrl.Map.Output | ? Fullname -match levelshots\\.+
    $Current.SetPreview($Levelshot.Fullname)
}

# $Current.Preview
# $Current.Preview.Check()

$Vdf = 0  # <- Prevents this little block from running
If ($Vdf -eq 1)
{
    $xVdf               = @{ 
        AppId           = 282440
        PublishedFileId = 0
        ContentFolder   = $Current.ContentPath()
        PreviewFile     = $Current.Preview.Fullname
        Visibility      = 0
        Title           = "Insane Products"
        Description     = "An update to: https://lvlworld.com/review/id:1850"
        ChangeNote      = "Alpha v0.0"
    }

    $Current.SetVdf($xVdf)
}

$Pk3 = 0
If ($Pk3 -eq 1)
{
    $xPk3                = $Ctrl.Map.Target
    $Current.SetPk3($xPk3)
}

$Upload = 0
If ($Upload -eq 1)
{
    $Ctrl.Steam.UploadProject()
}

<# [insaneproducts.arena]
$Arena = @'
{
map "insaneproducts"
longname "Insane Products"
type "ffa duel"
}
'@

$Ctrl.SetArena($Arena)
$Ctrl.Map.Arena.SetContent()
#>

<# [insaneproducts.shader]

$Shader = @'
textures/insaneproducts/tssfx1
{
	qer_editorimage textures/insaneproducts/tssfx1.tga
	q3map_lightimage textures/insaneproducts/tssfxb1.tga
	q3map_surfacelight 750
	surfaceparm nomarks
	{
		map textures/insaneproducts/tssfx1.tga
		rgbGen identity
	}
	{
		map $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identity
	}
	{
		map textures/insaneproducts/tssfxb1.tga
		blendfunc GL_ONE GL_ONE
		rgbGen wave sawtooth .6 .1 0 7
	}
}

textures/insaneproducts/tssfx2
{
	qer_editorimage textures/insaneproducts/tssfx2.tga
	q3map_lightimage textures/insaneproducts/tssfxb2.tga
	q3map_surfacelight 750
	surfaceparm nomarks
	{
		map textures/insaneproducts/tssfx2.tga
		rgbGen identity
	}
	{
		map $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identity
	}
	{
		map textures/insaneproducts/tssfxb2.tga
		blendfunc GL_ONE GL_ONE
		rgbGen wave sawtooth .6 .1 0 7
	}
}

textures/insaneproducts/tssfx3
{
	qer_editorimage textures/insaneproducts/tssfx3.tga
	q3map_lightimage textures/insaneproducts/tssfxb3.tga
	q3map_surfacelight 750
	surfaceparm nomarks
	{
		map textures/insaneproducts/tssfx3.tga
		rgbGen identity
	}
	{
		map $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identity
	}
	{
		map textures/insaneproducts/tssfxb3.tga
		blendfunc GL_ONE GL_ONE
		rgbGen wave sawtooth .6 .1 0 7
	}
}

textures/insaneproducts/tssfx4
{
	qer_editorimage textures/insaneproducts/tssfx4.tga
	q3map_lightimage textures/insaneproducts/tssfxb4.tga
	q3map_surfacelight 750
	surfaceparm nomarks
	{
		map textures/insaneproducts/tssfx4.tga
		rgbGen identity
	}
	{
		map $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identity
	}
	{
		map textures/insaneproducts/tssfxb4.tga
		blendfunc GL_ONE GL_ONE
		rgbGen wave sawtooth .6 .1 0 7
	}
}

textures/insaneproducts/tssfx5
{
	qer_editorimage textures/insaneproducts/tssfx5.tga
	q3map_lightimage textures/insaneproducts/tssfxb5.tga
	q3map_surfacelight 750
	surfaceparm nomarks
	{
		map textures/insaneproducts/tssfx5.tga
		rgbGen identity
	}
	{
		map $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identity
	}
	{
		map textures/insaneproducts/tssfxb5.tga
		blendfunc GL_ONE GL_ONE
		rgbGen wave sawtooth .6 .1 0 7
	}
}

textures/insaneproducts/tssfx6
{
	qer_editorimage textures/insaneproducts/tssfx6.tga
	q3map_lightimage textures/insaneproducts/tssfxb6.tga
	q3map_surfacelight 300
	surfaceparm nomarks
	{
		map $lightmap
		rgbGen identity
	}
	{
		map textures/insaneproducts/tssfx6.tga
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identity
	}
	{
		map textures/insaneproducts/tssfxb6.tga
		blendfunc GL_ONE GL_ONE
		rgbGen wave sin .3 .1 0 0.5
	}
}

textures/insaneproducts/tssfx7
{
	qer_editorimage textures/insaneproducts/tssfx7.tga
	q3map_lightimage textures/insaneproducts/tssfxb7.tga
	q3map_surfacelight 750
	surfaceparm nomarks
	{
		map $lightmap
		rgbGen identity
	}
	{
		map textures/insaneproducts/tssfx7.tga
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identity
	}
	{
		map textures/insaneproducts/tssfxb7.tga
		blendfunc GL_ONE GL_ONE
		rgbGen wave sin .3 .1 0 0.5
	}
}

textures/insaneproducts/tssfx8
{
	qer_editorimage textures/insaneproducts/tssfx8.tga
	q3map_lightimage textures/insaneproducts/tssfxb8.tga
	q3map_surfacelight 750
	surfaceparm nomarks
	{
		map textures/insaneproducts/tssfx8.tga
		rgbGen identity
	}
	{
		map $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identity
	}
	{
		map textures/insaneproducts/tssfxb8.tga
		blendfunc GL_ONE GL_ONE
		rgbGen wave sawtooth .6 .1 0 7
	}
}

textures/insaneproducts/tssfx9
{
	qer_editorimage textures/insaneproducts/tssfx9.tga
	q3map_lightimage textures/insaneproducts/tssfxb9.tga
	q3map_surfacelight 750
	surfaceparm nomarks
	{
		map textures/insaneproducts/tssfx9.tga
		rgbGen identity
	}
	{
		map $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identity
	}
	{
		map textures/insaneproducts/tssfxb9.tga
		blendfunc GL_ONE GL_ONE
		rgbGen wave sawtooth .6 .1 0 7
	}
}

textures/insaneproducts/tssfx10
{
	qer_editorimage textures/insaneproducts/tssfx10.tga
	q3map_lightimage textures/sfx/launchpad_blocks17.tga
	{
		map $lightmap
		rgbGen identity
	}
	{ 
		map textures/insaneproducts/tssfx10.tga
		rgbGen identity
		blendfunc gl_dst_color gl_zero
	}
	{	
		map textures/insaneproducts/tssfx14.tga
		blendfunc gl_one gl_one	
		rgbgen wave inversesawtooth 0 1 0 1	
	}
	{	
		map textures/insaneproducts/tssfx15.tga		
		blendfunc gl_src_alpha gl_one	
		tcmod scroll 0 2
		rgbgen wave square 0 1 0 2
		alphagen wave square 0 1 .1 2
	}
}

textures/insaneproducts/tssfx11
{
	qer_editorimage textures/insaneproducts/tssfx11.tga
	surfaceparm nodamage
	q3map_lightimage textures/sfx/blocks11b_jumppad.tga
	q3map_surfacelight 400
	{
		map textures/insaneproducts/tssfx11.tga
		rgbGen identity
	}
	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_zero
	}
	{
		map textures/insaneproducts/tssfx12.tga
		blendfunc gl_one gl_one
		rgbGen wave sin .5 .5 0 1.5	
	}
	{
		clampmap textures/insaneproducts/tssfx13.tga
		blendfunc gl_one gl_one
		tcMod stretch sin 1.2 .8 0 1.5
		rgbGen wave square .5 .5 .25 1.5
	}
}

textures/insaneproducts/tssky
{
	qer_editorimage textures/insaneproducts/tssfx16.tga
	q3map_lightimage textures/skies/pjbasesky.tga
	surfaceparm noimpact
	surfaceparm nomarks
	surfaceparm nolightmap
	surfaceparm sky
	q3map_sun 2 3 2 90 315 60
	q3map_surfacelight 80
	skyparms - 512 -
	{
		map textures/insaneproducts/tssfx16.tga
		tcMod scroll 0.05 .1
		tcMod scale 2 2
		depthWrite
	}
	{
		map textures/insaneproducts/tssfx17.tga
		blendfunc GL_ONE GL_ONE
		tcMod scroll 0.05 0.06
		tcMod scale 3 2
	}
}

textures/insaneproducts/bfgslime
{
	qer_editorimage textures/liquids/slime7.tga
	q3map_lightimage textures/liquids/slime7.tga
	q3map_globaltexture
	qer_trans .5

	surfaceparm noimpact
	surfaceparm slime
	surfaceparm nolightmap
	surfaceparm trans		

	q3map_surfacelight 300
	tessSize 32
	cull disable

	deformVertexes wave 100 sin 0 1 .5 .5

	{
		map textures/liquids/slime7c.tga
		tcMod turb .3 .2 1 .05
		tcMod scroll .01 .01
	}
	{
		map textures/liquids/slime7.tga
		blendfunc GL_ONE GL_ONE
		tcMod turb .2 .1 1 .05
		tcMod scale .5 .5
		tcMod scroll .01 .01
	}
	{
		map textures/liquids/bubbles.tga
		blendfunc GL_ZERO GL_SRC_COLOR
		tcMod turb .2 .1 .1 .2
		tcMod scale .05 .05
		tcMod scroll .001 .001
	}		
}

textures/insaneproducts/tsrock
{
	qer_editorimage textures/stone/pjrock16.tga
	q3map_lightimage textures/stone/pjrock16.tga
 	q3map_nonplanar
 	q3map_shadeangle 60
 	{
 		map $lightmap
 		rgbGen identity
 	}
 	{
 		map textures/stone/pjrock16.tga
 		blendFunc filter
 	}
 }
'@

$Ctrl.SetShader($Shader)
$Ctrl.Map.Shader.SetContent()
#>

$Ctrl.Compile()   # <- Compiles the map
$Ctrl.Package()   # <- Creates an archive of the map
$Ctrl.Transfer()  # <- Transfers the produced archive to Quake III Arena and Quake Live folders

$Param = "+map {0} ffa" -f $Ctrl.Map.Name
Start-Process -FilePath "steam://rungameid/282440//$Param"
