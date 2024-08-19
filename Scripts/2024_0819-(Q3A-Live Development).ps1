<# 
    The purpose of this script is to bridge [Quake III Arena], [Quake Live], [GtkRadiant/NetRadiant], and file system management.
#>

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

Class Q3ALiveMap
{
    [String]      $Name
    [String]      $Path
    [String]    $Source
    [String]    $Target
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
    Package()
    {
        [System.IO.Compression.ZipFile]::CreateFromDirectory($This.Path,$This.Target,"Optimal",$False)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Map>"
    }
}

Class Q3ALiveMaster
{
    [Object]      $Component
    [Object]        $Radiant
    [Object]      $Workspace
    [Object]            $Map
    Hidden [DateTime] $Start
    Hidden [String]   $Color
    Q3ALiveMaster()
    {
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
        $This.Color  = [Console]::ForegroundColor
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
            [System.IO.File]::Delete($This.Map.Target)
        }

        [Console]::WriteLine("Creating [~] [$($This.Map.Target)]")

        $This.Map.Package()

        If ([System.IO.File]::Exists($This.Map.Target))
        {
            $Hash     = Get-FileHash -Algorithm MD5 $This.Map.Target | % Hash
            $LogEntry = "{0} {1} {2}" -f [DateTime]::Now.ToString("MM/dd/yyyy HH:mm:ss"), $Hash, $This.Map.Target
            $Writer   = [System.IO.File]::AppendText($This.Workspace.Log)
            $Writer.WriteLine($LogEntry)
            $Writer.Dispose()
            [Console]::WriteLine("----")
            [Console]::WriteLine($This.Workspace.LogHeader)
            [Console]::WriteLine($LogEntry)
            [Console]::WriteLine("----")
        }

        $This.WriteStatus(5)
    }
    Transfer()
    {
        # // Transfer the map asset package to the [Quake Live] directory
        [Console]::WriteLine("Transferring [~] Package -> [Quake Live] directory")

        $Destination = "{0}\{1}" -f $This.Live().Base, ($This.Map.Target | Split-Path -Leaf)

        If ([System.IO.File]::Exists($Destination))
        {
            [System.IO.File]::Delete($Destination)
        }

        [System.IO.File]::Copy($This.Map.Target,$Destination)

        [Console]::WriteLine("Transferred [+] Package: [$Destination]")

        $This.WriteStatus(6)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Master>"
    }
}

$Radiant   = "C:\Games\GtkRadiant"
$Workspace = "C:\Workspace"
$MapName   = "selfdestruction-new"

$Ctrl      = [Q3ALiveMaster]::New()
$Ctrl.SetRadiant($Radiant)
$Ctrl.SetWorkspace($Workspace)
$Ctrl.SetMap($MapName)
$Ctrl.Compile()
$Ctrl.Package()
$Ctrl.Transfer()
