<#   ______________________________________________________________________________________________________
    /¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
    |==[ P R O G R A M   M A P ]===========================================================================|
    \______________________________________________________________________________________________________/
    / General              | classes that don't fit a particular category                                  \
    | Xaml                 | classes meant for XAML/WPF                                                    |
    | Threading            | Classes meant specifically for managing operations on other threads           |
    | Audio                | classes meant to handle multiple audio file formats + playback                |
    |----------------------|-------------------------------------------------------------------------------|
    | Registry             | classes meant to stage and initialize the utility                             |
    | Dependency           | classes that search the registry and elsewhere for installed dependencies     |
    | Component            | classes meant for Quake III Arena/Quake Live                                  |
    | Radiant              | classes meant for GtkRadiant/NetRadiant/NetRadiant-Custom (Garux)             |
    | Workspace            | classes that partition game directories from project assets, and overall logs |
    |----------------------|-------------------------------------------------------------------------------|
    | Shader               | classes that deal specifically with shader formatting and handling            |
    | Texture              | classes that deal specifically with textures                                  |
    |----------------------|-------------------------------------------------------------------------------|
    | Assignment           | classes that manage (single/multiple) map actions                             |
    | Compilation          | classes that manage the compilation array                                     |
    | Steam                | classes that manage SteamCmd                                                  |
    |----------------------|-------------------------------------------------------------------------------|
    / Controller           | main class factory that embeds all of the above classes                       \
    \______________________|_______________________________________________________________________________/
#>

<#
    ____                                                                                                    ________    
   //¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
   \\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\__//¯¯¯    
    ¯¯¯\\__[ General    ]__________________________________________________________________________________//¯¯¯        
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯            
#>

# CSharp Type Definition
Try
{
    $TypeDefinition = [System.IO.File]::ReadAllLines("https://github.com/mcc85s/Q3A-Live/blob/main/Scripts/2026_0218-(Q3A-Live).cs") -join "`n"
    $Wpf            = "$env:WINDIR\Microsoft.NET\Framework64\v4.0.30319\WPF"

    $refs           = @(
        "mscorlib.dll",
        "System.dll",
        "System.Core.dll",
        "System.Data.dll",
        "Microsoft.CSharp.dll",
        "$Wpf\WindowsBase.dll",
        "$Wpf\PresentationCore.dll",
        "$Wpf\PresentationFramework.dll",
        "System.Management.Automation.dll",
        "C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.8\System.Xaml.dll",
        "System.IO.Compression.dll",
        "System.IO.Compression.FileSystem.dll"
    )

    Add-Type -ReferencedAssemblies $refs -TypeDefinition $TypeDefinition
    Add-Type -Assembly System.IO.Compression, System.IO.Compression.Filesystem

    Import-Module FightingEntropy
}
Catch
{

}

<#
    ____    ____________________________________________________________________________________________________        
   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
   \\__//¯¯¯ Xaml [~]                                                                                       ___//¯¯\\   
    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
#>

Class Q3ALiveXaml
{
    Static [String] $Content = [System.IO.File]::ReadAllLines("https://github.com/mcc85s/Q3A-Live/blob/main/Scripts/2026_0218-(Q3A-Live).xaml") -join "`n"
}

Class XamlProperty
{
    [UInt32]   $Index
    [String]    $Name
    [Object]    $Type
    [Object] $Control
    [UInt32]  $Status
    [String]  $Reason
    XamlProperty([UInt32]$Index,[String]$Name,[Object]$Object)
    {
        $This.Index   = $Index
        $This.Name    = $Name
        $This.Type    = $Object.GetType().Name
        $This.Control = $Object
    }
    [String] ToString()
    {
        Return $This.Name
    }
}

Class Q3ALiveProperty
{
    [String] $Name
    [String] $Value
    Q3ALiveProperty([Object]$Property)
    {
        $This.Name  = $Property.Name
        $This.Value = $Property.Value
    }
    Q3ALiveProperty([String]$Name,[String]$Value)
    {
        $This.Name  = $Name
        $This.Value = $Value
    }
    [String] ToString()
    {
        Return "<Q3ALive.Property>"
    }
}

Class XamlWindow
{
    Hidden [Object]        $Xaml
    Hidden [Object]         $Xml
    [String[]]            $Names
    [Object]              $Types
    [Object]               $Node
    [Object]                 $IO
    [String]          $Exception
    XamlWindow([String]$Xaml)
    {           
        If (!$Xaml)
        {
            Throw "Invalid XAML Input"
        }

        [System.Reflection.Assembly]::LoadWithPartialName('presentationframework')

        $This.Xaml           = $Xaml
        $This.Xml            = [XML]$Xaml
        $This.Names          = $This.FindNames()
        $This.Types          = @( )
        $This.Node           = [System.Xml.XmlNodeReader]::New($This.Xml)
        $This.IO             = [Windows.Markup.XamlReader]::Load($This.Node)
        
        ForEach ($X in 0..($This.Names.Count-1))
        {
            $Name            = $This.Names[$X]
            $Object          = $This.IO.FindName($Name)
            $This.IO         | Add-Member -MemberType NoteProperty -Name $Name -Value $Object -Force
            If (!!$Object)
            {
                $This.Types += $This.XamlProperty($This.Types.Count,$Name,$Object)
            }
        }
    }
    [String[]] FindNames()
    {
        Return [Regex]::Matches($This.Xaml,"( Name\=\`"\w+`")").Value -Replace "( Name=|`")",""
    }
    [Object] XamlProperty([UInt32]$Index,[String]$Name,[Object]$Object)
    {
        Return [XamlProperty]::New($Index,$Name,$Object)
    }
    [Object] Get([String]$Name)
    {
        $Item = $This.Types | ? Name -eq $Name

        If ($Item)
        {
            Return $Item
        }
        Else
        {
            Return $Null
        }
    }
    Invoke()
    {
        Try
        {
            $This.IO.Dispatcher.InvokeAsync({ $This.IO.ShowDialog() }).Wait()
        }
        Catch
        {
            $This.Exception = $PSItem
        }
    }
    [String] ToString()
    {
        Return "<FEModule.XamlWindow[Q3ALive.Master]>"
    }
}

<#
    ____    ____________________________________________________________________________________________________        
   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
   \\__//¯¯¯ Resource/Registry [~]                                                                          ___//¯¯\\   
    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
#>

Class Q3ALiveResourceRoot
{
    [String]     $Name
    [String]  $Created
    [String] $Modified
    [String] $Fullname
    [UInt32]   $Exists
    [Object]   $Output
    Q3ALiveResourceRoot([String]$Fullname)
    {
        $This.Fullname = $Fullname

        $Item          = $This.Get()
        If (!$Item)
        {
            $This.Create()
        }

        $This.Refresh()
    }
    Clear()
    {
        $This.Output       = @( )
    }
    Refresh()
    {
        $This.Clear()

        $Item          = $This.Get()
        $This.Created  = $Item.CreationTime.ToString("MM/dd/yyyy HH:mm:ss")
        $This.Modified = $Item.LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss")
        $This.Name     = $Item.Name

        $This.Output   = [Q3ALive.DirectoryScan]::New($This.Fullname).Output
    }
    Create()
    {
        $This.Check()

        If (!$This.Exists)
        {
            [System.IO.Directory]::CreateDirectory($This.Fullname) > $Null
        }

        ForEach ($Name in $This.ResourceInstallTypes())
        {
            $xPath = "{0}\{1}" -f $This.Fullname, $Name
            If (![System.IO.Directory]::Exists($xPath))
            {
                [System.IO.Directory]::CreateDirectory($xPath) > $Null
            }
        }

        $This.Refresh()
    }
    [String] Gfx()
    {
        Return $This.Output | ? Name -eq gfx | % Fullname
    }
    [Object] Get()
    {
        Return Get-Item $This.Fullname -EA 0
    }
    Check()
    {
        $This.Exists = [System.IO.Directory]::Exists($This.Fullname)
    }
    [String[]] ResourceInstallTypes()
    {
        Return [System.Enum]::GetNames([Q3ALive.ResourceInstallType])
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALive.ByteSize]::New("File",$Bytes)
    }
    [String] ToString()
    {
        Return $This.Fullname
    }
}

Class Q3ALiveRegistryUninstall
{
    [UInt32]           $Index
    [String]     $DisplayName
    [String] $InstallLocation
    Q3ALiveRegistryUninstall([UInt32]$Index,[Object]$Object)
    {
        $This.Index           = $Index
        $This.DisplayName     = Switch -Regex ($Object.DisplayName)
        {
            "^7-Zip"            { "7-Zip"           }
            "^ImageMagick"      { "ImageMagick"     }
            "^Quake III Arena$" { "Quake III Arena" }
            "^Quake Live$"      { "Quake Live"      }
        }

        $This.InstallLocation = Switch ($This.DisplayName)
        {
            "Quake III Arena"
            {
                $Object.UninstallString.Split('"')[1] | Split-Path -Parent
            }
            Default
            {
                $Object.InstallLocation.TrimEnd("\")
            }
        }
    }
    [String] ToString()
    {
        Return "<Q3ALive.Registry.Uninstall>"
    }
}

Class Q3ALiveRegistryReference
{
    [String]            $Type
    [UInt32]           $Index
    Hidden [String] $Fullname
    [String]            $Name
    [UInt32]          $Exists
    [String]           $Value
    [UInt32]           $Valid
    Hidden [String]  $Default = "<not set>"
    Q3ALiveRegistryReference([String]$Type,[UInt32]$Index,[String]$Fullname,[String]$Name)
    {
        $This.Type     = $Type
        $This.Index    = $Index
        $This.Fullname = $Fullname
        $This.Name     = $Name
        $This.Check()
    }
    Check()
    {
        $xItem               = Get-ItemProperty -Path $This.Fullname -Name $This.Name -EA 0
        If ($xItem)
        {
            $xValue          = $xItem.$($This.Name)
            If (!!$xValue)
            {
                $This.Value  = $xValue
                $This.Exists = [UInt32](!!$xValue)
            }
        }
        Else
        {
            $This.Value      = $Null
            $This.Exists     = 0
        }
    }
    Apply()
    {
        $This.Valid = [UInt32](!!(Test-Path $This.Value -EA 0))
        Set-ItemProperty -Path $This.Fullname -Name $This.Name -Value $This.Value -Verbose
    }
    [String] ToString()
    {
        Return $This.Name
    }
}

Class Q3ALiveRegistryReferenceList
{
    [String] $Type
    [String] $Fullname
    [UInt32] $Exists
    [Object] $Property
    Q3ALiveRegistryReferenceList([String]$Type,[String]$Fullname,[String[]]$Criteria)
    {
        $This.Type     = $Type
        $This.Fullname = $Fullname
        $This.Clear()
        $This.Check()

        ForEach ($Item in $Criteria)
        {
            $This.Add($Item)
        }
    }
    Clear()
    {
        $This.Property = @( )
    }
    Check()
    {
        $This.Exists   = Test-Path $This.Fullname
    }
    Create()
    {
        $This.Check()
        If (!$This.Exists)
        {
            New-Item -Path $This.Fullname -Verbose
            $This.Check()

            ForEach ($Item in $This.Property)
            {
                Set-ItemProperty -Path $This.Fullname -Name $Item.Name -Value $Item.Default -EA 0 -Verbose
                $Item.Exists = 1
            }
        }
    }
    Remove()
    {
        $This.Check()
        If ($This.Exists)
        {
            Remove-Item -Path $This.Fullname -Verbose
            $This.Check()
        }
    }
    Refresh()
    {
        ForEach ($Item in $This.Property)
        {
            $xProperty = Get-ItemProperty $Item.Fullname

            $Filter    = $xProperty.$($Item.Name)

            Switch ([UInt32]!!$Filter)
            {
                0
                {
                    New-ItemProperty -Path $Item.Fullname -Name $Item.Name -Verbose
                }
                1
                {
                    $Item.Value = $Filter
                }
            }

            $Item.Valid = [UInt32]!!(Test-Path $Item.Value -EA 0)
        }
    }
    Add([String]$Name)
    {
        If ($Name -notin $This.Output)
        {
            $This.Property += $This.Q3ALiveRegistryReference($This.Type,$This.Property.Count,$This.Fullname,$Name)
        }
    }
    [Object] Q3ALiveRegistryReference([String]$Type,[UInt32]$Index,[String]$Fullname,[String]$Name)
    {
        Return [Q3ALiveRegistryReference]::New($Type,$Index,$Fullname,$Name)
    }
    [String] ToString()
    {
        Return "($($This.Property.Count))"
    }
}

Class Q3ALiveRegistryBase
{
    [String] $Resource
    [String] $Name
    [String] $DisplayName
    [String] $Version
    [String] $Fullname
    [String] $InstallDate
    [String] $Game
    [String] $Editor
    [String] $Map
    [UInt32] $Exists
    [Object] $Settings
    [Object] $Dependency
    [Object] $Component
    [Object] $Radiant
    Q3ALiveRegistryBase([String]$Fullname)
    {
        $Parent        = $Fullname | Split-Path -Parent
        Switch ([UInt32](!!(Test-Path $Parent)))
        {
            0
            {
                Throw "Exception [!] Invalid parent: $Fullname"
            }
            1
            {
                $This.Fullname = $Fullname
                $This.Check()

                Switch ($This.Exists)
                {
                    0
                    {
                        $This.Create()
                    }
                    1
                    {
                        $This.CreateLists()
                        $This.GetProperty()
                    }
                }
            }
        }

        # $List              = Get-ChildItem $Fullname
    }
    [String] CompanyName()
    {
        Return "Secure Digits Plus LLC"
    }
    [String] ProjectName()
    {
        Return "Q3A-Live"
    }
    [String] DefaultResourcePath()
    {
        Return "{0}\{1}\{2}" -f [Environment]::GetEnvironmentVariable("ProgramData"), $This.CompanyName(), $This.ProjectName()
    }
    [String] CurrentVersion()
    {
        Return [DateTime]::Now.ToString("yyyy.MM.0")
    }
    [String] CurrentDateTimeString()
    {
        Return [DateTime]::Now.ToString("yyyy_MMdd-HHmmss")
    }
    Template()
    {
        $This.Resource      = $This.DefaultResourcePath()
        $This.Name          = $This.ProjectName()
        $This.DisplayName   = "{0}\{1}" -f $This.ProjectName(), $This.CurrentVersion()
        $This.Version       = $This.CurrentVersion()
        $This.Fullname      = $This.Fullname
        $This.Exists        = [UInt32](!!(Test-Path $This.Fullname -EA 0))
        $This.InstallDate   = $This.CurrentDateTimeString()
        $This.Game          = "<not set>"
        $This.Editor        = "<not set>"
        $This.Map           = "<not set>"
    }
    GetProperty()
    {
        $Item              = Get-ItemProperty $This.Fullname
        $This.Resource     = $Item.Resource
        $This.Name         = $Item.Name
        $This.DisplayName  = $Item.DisplayName
        $This.Version      = $Item.Version
        $This.InstallDate  = $Item.InstallDate
        $This.Game         = $Item.Game
        $This.Editor       = $Item.Editor
        $This.Map          = $Item.Map
    }
    SetProperty()
    {
        ForEach ($Name in $This.BaseTypes())
        {
            Set-ItemProperty -Path $This.Fullname -Name $Name -Value $This.$Name -Verbose
        }
    }
    SetKeys()
    {
        ForEach ($Name in $This.ReferenceTypes())
        {

        }
    }
    CreateLists()
    {
        ForEach ($Item in $This.ReferenceTypes())
        {
            $This.$Item = $This.Q3ALiveRegistryReferenceList($Item,"$($This.Fullname)\$Item",$This.rstr($Item))
        }
    }
    Check()
    {
        $This.Exists = [UInt32](Test-Path $This.Fullname)
    }
    Create()
    {
        # Create main
        New-Item $This.Fullname -Verbose

        $This.CreateLists()

        $This.Settings.Create()
        $This.Dependency.Create()
        $This.Component.Create()
        $This.Radiant.Create()

        $This.Template()
        $This.SetProperty()
        $This.GetProperty()

        If (![System.IO.Directory]::Exists($This.Resource))
        {
            [System.IO.Directory]::CreateDirectory($This.Resource)
        }
    }
    Remove()
    {
        $This.Check()
        If ($This.Exists)
        {
            Remove-Item $This.Fullname -Recurse -Verbose
            $This.Check()
        }
    }
    Refresh()
    {
        If ($This.Exists)
        {
            $This.Settings.Refresh()
            $This.Dependency.Refresh()
            $This.Component.Refresh()
            $This.Radiant.Refresh()
        }
    }
    [Object] Q3ALiveRegistryReferenceList([String]$Type,[String]$Fullname,[String[]]$Criteria)
    {
        Return [Q3ALiveRegistryReferenceList]::New($Type,$Fullname,$Criteria)
    }
    [String] DefaultPath()
    {
        Return "HKLM:\SOFTWARE\Policies\Secure Digits Plus LLC\Q3A-Live"
    }
    [String[]] BaseTypes()
    {
        Return [System.Enum]::GetNames([Q3ALive.RegistryBaseType])
    }
    [String[]] ReferenceTypes()
    {
        Return [System.Enum]::GetNames([Q3ALive.RegistryReferenceType])
    }
    [String[]] rstr([String]$Type)
    {
        $String = Switch ($Type)
        {
            Component  {                                "Q3A Live" }
            Settings   {           "Workspace Credential Workshop" }
            Radiant    { "GtkRadiant NetRadiant NetRadiant-Custom" }
            Dependency {            "7Zip ImageMagick Q3ASE Steam" }
        }

        Return $String -Split " "
    }
    [String[]] Display()
    {
        $Hash  = @{ }
        $List  = @($This.BaseTypes(); $This.ReferenceTypes())
        $Max   = $List | Sort-Object Length | Select-Object -Last 1

        $Line = "[ Q3A-Live MDK+ Registry ]"

        "","=".PadRight($Line.Length,"="),$Line,"=".PadRight($Line.Length,"="),"" | % { $Hash.Add($Hash.Count,$_) }
        ForEach ($Item in $List)
        {
            Switch ([UInt32]($Item -in $This.ReferenceTypes()))
            {
                0
                {
                    $Line = "{0} : {1}" -f $Item.PadRight(11," "), $This.$Item
                    $Hash.Add($Hash.Count,$Line)
                }
                1
                {
                    $Hash.Add($Hash.Count,"")
                    $Line = "{0} : ======>" -f $Item.PadRight(11," ")
                    $Hash.Add($Hash.Count,$Line)
                    $Hash.Add($Hash.Count,"")

                    $Width = @($This.ReferenceTypes() | % { $This.$_.Property })

                    $Max   = $Width | Sort-Object { $_.Name.Length } | Select-Object -Last 1 | % { $_.Name.Length }
                    
                    Switch ($Item)
                    {
                        Settings
                        {
                            ForEach ($Property in $This.Settings.Property)
                            {
                                $Hash.Add($Hash.Count,("{0} : {1}" -f $Property.Name.PadRight($Max," "), $Property.Value))
                            }
                        }
                        Dependency
                        {
                            ForEach ($Property in $This.Dependency.Property)
                            {
                                $Hash.Add($Hash.Count,("{0} : {1}" -f $Property.Name.PadRight($Max," "), $Property.Value))
                            }
                        }
                        Component
                        {
                            ForEach ($Property in $This.Component.Property)
                            {
                                $Hash.Add($Hash.Count,("{0} : {1}" -f $Property.Name.PadRight($Max," "), $Property.Value))
                            }
                        }
                        Radiant
                        {
                            ForEach ($Property in $This.Radiant.Property)
                            {
                                $Hash.Add($Hash.Count,("{0} : {1}" -f $Property.Name.PadRight($Max," "), $Property.Value))
                            }
                        }
                    }
                }
            }
        }

        $Hash.Add($Hash.Count,"")
        Return $Hash[0..($Hash.Count-1)]
    }
    [String] ToString()
    {
        Return "<Q3ALive.Registry.Base>"
    }
}

<#
    ____    ____________________________________________________________________________________________________        
   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
   \\__//¯¯¯ Dependency [~]                                                                                 ___//¯¯\\   
    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
#>

Class Q3ALiveDependencyItem
{
    [UInt32]         $Index
    [String]          $Name
	[String]          $Type
    [String]       $Version
	[UInt32]     $Installed
    [UInt32]      $Selected
	[String]   $Description
    [String]   $PackageName
    [String]   $PackageType
    [String]   $PackageSize
    [String] $PackageSource
	[String]   $PackageHash
    [String]      $Fullname
    [String]     $Directory
    [String]    $Executable
    Q3ALiveDependencyItem([UInt32]$Index,[String]$Name,[String]$Type,[String]$Version,[String]$Description,[String]$Source,[String]$Size,[String]$Hash)
    {
        $This.Index           = $Index
        $This.Name            = $Name
        $This.Type            = $Type
        $This.Version         = $Version
        $This.Description     = $Description
        $This.PackageName     = $Source | Split-Path -Leaf

        If ($This.PackageName -match "\?")
        {
            $This.PackageName = $This.PackageName.Split("?")[0]
        }

        $This.GetPackageType()
        $This.PackageSize     = $Size
        $This.PackageSource   = $Source
        $This.PackageHash     = $Hash

        $This.Fullname        = "<not set>"
        $This.Directory       = "<not set>"
        $This.Executable      = "<not set>"
    }
    Assign([String]$Directory,[String]$Executable)
    {
        $This.Fullname     = "$Directory\$Executable"
        $This.Directory    = $Directory
        $This.Executable   = $Executable
        $This.Check()
    }
    Check()
    {
        $This.Installed    = [UInt32][System.IO.File]::Exists($This.Fullname)
    }
    GetPackageType()
    {
        $This.PackageType = Switch ($This.PackageName.Split(".")[-1])
        { 
            Default { "Unknown"    } 
            zip     { "Archive"    } 
            exe     { "Executable" }
            msi     { "Installer"  }
        }
    }
    [String] Path()
    {
        Return "{0}\{1}" -f $This.Directory, $This.Executable
    }
    [String] ToString()
    {
        Return "<Q3ALive.Dependency.Item>"
    }
}

Class Q3ALiveDependencyList
{
    [String] $Fullname
    [UInt32]   $Exists
    [Object]   $Output
    Q3ALiveDependencyList()
    {
        $This.Refresh()
    }
    Assign([String]$Fullname)
    {
        $This.Fullname = $Fullname
        $This.Check()

        If (!$This.Exists)
        {
            $This.Create()
        }

        $This.Refresh()
    }
    Clear()
    {
        $This.Output = @( )
    }
    Check()
    {
        $This.Exists = [UInt32][System.IO.Directory]::Exists($This.Fullname)
    }
    Create()
    {
        If (!$This.Exists)
        {
            [System.IO.Directory]::CreateDirectory($This.Fullname) > $Null
            $This.Check()
        }
    }
    Assign([String]$Name,[String]$Fullname,[String]$Executable)
    {
        $Item = $This.Output | ? Name -eq $Name
        If ($Item)
        {
            $Item.Assign($Fullname,$Executable)
        }
    }
    Refresh()
    {
        $This.Clear()

        ForEach ($Name in $This.DependencyNames())
        {
            $Item = Switch ($Name)
            {
                "GtkRadiant"
                {
                    "GtkRadiant",
                    "Radiant",
                    "1.6.7",
                    "Original/QERadiant idTech3 (*.map) editor",
                    "https://s3.amazonaws.com/GtkRadiant/GtkRadiant-1.6.7-20230820.zip",
                    "104.51 MB",
                    "D7C2C334FFB0B9F611FDC30D19BCF6F8"
                }
                "NetRadiant"
                {
                    "NetRadiant",
                    "Radiant",
                    "1.5.0",
                    "Forked version of GtkRadiant idTech3 (*.map) editor",
                    "https://dl.unvanquished.net/share/netradiant/release/netradiant_1.5.0-20220628-windows-amd64.zip",
                    "57.09 MB",
                    "58DD907C82654A58F7B74AD45DAB292D"
                }
                "NetRadiant-Custom"
                {
                    "NetRadiant-Custom",
                    "Radiant",
                    "1.6.0n",
                    "Forked version of NetRadiant by garux (recommended)",
                    "https://github.com/Garux/netradiant-custom/releases/download/20251023/netradiant-custom-20251023-windows-x86_64.zip",
                    "41.26 MB",
                    "F7883AFF6F362F85F873D7EAA271551D"
                }
                "7Zip"
                {
                    "7Zip",
                    "Archive",
                    "24.08",
                    "Archive creation tool",
                    "https://www.7-zip.org/a/7z2408-x64.exe",
                    "1.55 MB",
                    "0330D0BD7341A9AFE5B6D161B1FF4AA1"
                    
                }
                "ImageMagick"
                {
                    "ImageMagick",
                    "Image",
                    "7.1.1.38",
                    "Command line based image manipulation tool",
                    "https://imagemagick.org/archive/binaries/ImageMagick-7.1.1-38-Q16-HDRI-x64-dll.exe",
                    "21.99 MB",
                    "9BB56A6A1079467E8E51E343F08F7577"
                    
                }
                "Q3ASE"
                {
                    "Q3ASE",
                    "Shader",
                    "1.2.1",
                    "Quake 3 Arena Shader Editor",
                    "https://github.com/mcc85s/Q3A-Live/blob/main/Dependency/Q3ASE/q3ase.zip?raw=true",
                    "316.49 KB",
                    "EE98BE75ECA5C6F9AD146F12CD39AA72"
                }
                "Steam"
                {
                    "Steam",
                    "Publish",
                    "1.0.0",
                    "Steam Workshop command line tool (steamcmd)",
                    "https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip",
                    "756.67 KB",
                    "C320ECF2C5D82B605E81BC11A8078C39"
                }
            }

            $This.AddDependency($Item[0],$Item[1],$Item[2],$Item[3],$Item[4],$Item[5],$Item[6])
        }
    }
    SetSelected([UInt32]$Index)
    {
        If ($Index -in $This.Output.Index)
        {
            ForEach ($Item in $This.Output)
            {
                $Item.Selected = $Item.Index -eq $Index
            }
        }
    }
    [Object] Current()
    {
        Return $This.Output | ? Selected
    }
    [Object] Get([String]$DisplayName)
    {
        If ($DisplayName -in $This.Output.DisplayName)
        {
            Return $This.Output | ? DisplayName -eq $DisplayName
        }
        Else
        {
            Return $Null
        }
    }
    AddDependency([String]$Name,[String]$Type,[String]$Version,[String]$Description,[String]$Source,[String]$Size,[String]$Hash)
    {
        If ($Name -notin $This.Output.Name)
        {
            $This.Output += $This.Q3ALiveDependencyItem($This.Output.Count,$Name,$Type,$Version,$Description,$Source,$Size,$Hash)
        }
    }
    [String[]] DependencyNames()
    {
        Return "GtkRadiant","NetRadiant","NetRadiant-Custom","7Zip","ImageMagick","Q3ASE","Steam"
    }
    [Object] Q3ALiveDependencyItem([UInt32]$Index,[String]$Name,[String]$Type,[String]$Version,[String]$Description,[String]$Source,[String]$Size,[String]$Hash)
    {
        Return [Q3ALiveDependencyItem]::New($Index,$Name,$Type,$Version,$Description,$Source,$Size,$Hash)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Dependency.Master>"
    }
}


<#
    ____    ____________________________________________________________________________________________________        
   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
   \\__//¯¯¯ Radiant [~]                                                                                    ___//¯¯\\   
    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
#>

Class Q3ALiveRadiantItem
{
    [UInt32]     $Index
    [Object]  $Modified
    [String]      $Name
    [Object]      $Size
    [UInt32]    $Exists
    [String]  $Fullname
    [UInt32] $Installed
    [UInt32]  $Selected
    [Object]      $File
    [String]    $Editor
    [String]    $Q3Map2
    [String]      $Bspc
    Q3ALiveRadiantItem([UInt32]$Index,[String]$Name)
    {
        $This.Index    = $Index
        $This.Name     = $Name

        $This.Clear()
    }
    Check()
    {
        $This.Exists   = [System.IO.Directory]::Exists($This.Fullname)
    }
    Clear()
    {
        $This.Editor   = "<not set>"
        $This.Q3Map2   = "<not set>"
        $This.Bspc     = "<not set>"
        $This.File     = @( )
    }
    Assign([String]$Fullname)
    {
        If ([System.IO.Directory]::Exists($Fullname))
        {
            $This.Fullname = $Fullname
            $This.Check()

            If ($This.Exists)
            {
                $This.Refresh()
                
                $This.Editor = $This.File | ? Name -match "radiant.exe" | % Fullname
                
                $xQ3Map2     = $This.File | ? Name -eq "q3map2.exe" | % Fullname
                
                If ($xQ3Map2.Count -gt 1)
                {
                    $This.Q3Map2 = $xQ3Map2 | ? { $_ -match "x64" }
                }
                Else
                {
                    $This.Q3Map2 = $xQ3Map2
                }
            
                $This.Bspc   = $This.File | ? Name -match "bspc.exe" | % Fullname
            
                If ($This.Editor -and $This.Bspc -and $This.Q3Map2)
                {
                    $This.Installed = 1
                }
            }
        }
    }
    Refresh()
    {
        $This.Check()

        If ($This.Exists)
        {
            $Tree = $This.Q3ALiveDirectoryScan()

            $Hash = @{ }
            ForEach ($Item in $Tree.Output)
            {
                $Hash.Add($Hash.Count,$Item)
            }

            $This.Modified = $Tree.Modified
            $This.File     = Switch ($Hash.Count) { 0 { @( ) } 1 { @($Hash[0]) } Default { $Hash[0..($Hash.Count-1)] } }
            $This.SetDisplayName()
            $This.Size     = $Tree.GetRecursiveSize()
        }
    }
    SetDisplayName()
    {
        ForEach ($Item in $This.File)
        {
            $Item.DisplayName = $Item.Fullname.Replace($This.Fullname,"")
        }
    }
    [String] EditorProcessName()
    {
        Return $This.LeafStrip($This.Editor)
    }
    [String] Q3Map2ProcessName()
    {
        Return $This.LeafStrip($This.Q3Map2)
    }
    [String] BspcProcessName()
    {
        Return $This.LeafStrip($This.Bspc)
    }
    [String] LeafStrip([String]$Value)
    {
        Return ($Value | Split-Path -Leaf).Replace(".exe","")
    }
    [Object] Q3ALiveDirectoryScan()
    {
        Return [Q3ALive.DirectoryScan]::New($This.Fullname,2,1)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Radiant.Item>"
    }
}

Class Q3ALiveRadiantList
{
    [Object] $Output
    Q3ALiveRadiantList()
    {
        $This.Refresh()
    }
    Clear()
    {
        $This.Output = @( )
    }
    Add([String]$Name)
    {
        $This.Output += $This.Q3ALiveRadiantItem($This.Output.Count,$Name)
    }
    Refresh()
    {
        $This.Clear()

        ForEach ($Name in $This.RadiantNames())
        {
            $This.Add($Name)
        }
    }
    [String[]] RadiantNames()
    {
        Return "GtkRadiant","NetRadiant","NetRadiant-Custom"
    }
    Assign([String]$Name,[String]$Fullname)
    {
        $Item = $This.Output | ? Name -eq $Name
        If ($Item)
        {
            $Item.Assign($Fullname)
        }
    }
    SetSelected([UInt32]$Index)
    {
        If ($Index -in $This.Output.Index)
        {
            ForEach ($Item in $This.Output)
            {
                $Item.Selected = $Item.Index -eq $Index
            }
        }
    }
    [Object] Current()
    {
        Return $This.Output | ? Selected
    }
    [Object] Q3ALiveRadiantItem([UInt32]$Index,[String]$Name)
    {
        Return [Q3ALiveRadiantItem]::New($Index,$Name)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Radiant.List>"
    }
}

<#
    ____    ____________________________________________________________________________________________________        
   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
   \\__//¯¯¯ Workspace [~]                                                                                  ___//¯¯\\   
    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
#>

Class Q3ALiveWorkspaceEntry
{
    [UInt32]    $Index
    [String] $Modified
    [String]     $Name
    [Object]     $Size
    [UInt32]   $Exists
    [String] $Fullname
    [UInt32]    $Valid
    [UInt32] $Selected
    [Object]   $Output
    Q3ALiveWorkspaceEntry([UInt32]$Index,[Object]$Object)
    {
        $This.Index    = $Index
        $This.Name     = $Object.Name
        $This.Fullname = $Object.Fullname

        $This.Refresh()
    }
    Clear()
    {
        $This.Size     = $Null
        $This.Output   = @( )
    }
    Check()
    {
        $This.Exists   = [System.IO.Directory]::Exists($This.Fullname)
    }
    Refresh()
    {
        $This.Clear()
        $This.Check()

        If ($This.Exists)
        {
            $Tree          = $This.Q3ALiveDirectoryScan()
            $Hash          = @{ }
            ForEach ($Item in $Tree.Output)
            {
                $Hash.Add($Hash.Count,$Item)
            }

            $This.Modified = $Tree.Modified
            $This.Size     = $Tree.GetRecursiveSize()
            $This.Output   = Switch ($Hash.Count) { 0 { @( ) } 1 { @($Hash[0]) } Default { $Hash[0..($Hash.Count-1)] } }

            If ($This.AssetTypes() | ? { $_ -in $This.Output.Name})
            {
                $This.Valid = 1
            }
        }
    }
    [String[]] AssetTypes()
    {
        Return [System.Enum]::GetNames([Q3ALive.AssetType])
    }
    [Object] Q3ALiveDirectoryScan()
    {
        Return [Q3ALive.DirectoryScan]::New($This.Fullname,0,1)
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALive.ByteSize]::New("File",$Bytes)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Workspace.Entry>"
    }
}

Class Q3ALiveWorkspaceLogEntry
{
    [UInt32]  $Index
    [String]   $Date
    [String]   $Time
    [String]   $Hash
    [String] $Source
    Q3ALiveWorkspaceLogEntry([UInt32]$Index,[String]$Line)
    {
        $This.Index  = $Index
        $This.Date   = $Line.Substring(0,10)
        $This.Time   = $Line.Substring(11,8)
        $This.Hash   = $Line.Substring(20,32)
        $This.Source = $Line.Substring(53)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Workspace.Log.Entry>"
    }
}

Class Q3ALiveWorkspaceLog
{
    [String]     $Type
    [Object]  $Created
    [Object] $Modified
    [String]     $Name
    [Object]     $Size
    [UInt32]   $Exists
    [String] $Fullname
    [Object]   $Output
    [UInt32]    $Count
    Q3ALiveWorkspaceLog([String]$Fullname)
    {
        $This.Type         = "Log"
        $This.Fullname     = $Fullname

        $This.Refresh()
    }
    Check()
    {
        $This.Exists       = [System.IO.File]::Exists($This.Fullname)
        If ($This.Exists)
        {
            $Item          = $This.Q3ALiveWorkspaceLogFile()
            $This.Created  = $Item.Created
            $This.Modified = $Item.Modified
            $This.Name     = $Item.Name
            $This.Size     = $Item.Size
        }
        If (!$This.Exists)
        {
            $This.Created  = $Null
            $This.Modified = $Null
            $This.Name     = $Null
            $This.Size     = $Null
        }
    }
    Clear()
    {
        $This.Size         = $Null
        $This.Output       = @( )
        $This.Count        = 0
    }
    Create()
    {
        $This.Check()

        If (!$This.Exists)
        {
            $Content       = @( )
            $Content      += $This.Header()
            $Content      += "{0} {1} {2}" -f $This.Now(), "X".PadLeft(32,"X"), $This.Fullname
            [System.IO.File]::WriteAllLines($This.Fullname,$Content)
        }

        $This.Check()
    }
    Refresh()
    {
        $This.Clear()
        $This.Check()

        If (!$This.Exists)
        {
            $This.Create()
        }

        If ($This.Exists)
        {
            $Lines       = [System.IO.File]::ReadAllLines($This.Fullname) | ? { $_ -notmatch "^Date" }
            $Hash        = @{ }

            ForEach ($Line in $Lines)
            {
                $Hash.Add($Hash.Count,$This.Q3ALiveWorkspaceLogEntry($Hash.Count,$Line))
            }

            $This.Output = Switch ($Hash.Count) { 0 { } 1 { $Hash[0]} Default { $Hash[0..($Hash.Count-1)] } }
        }

        $This.Count      = $This.Output.Count
    }
    [String] Header()
    {
        Return "Date       Time     Hash                             Source"
    }
    [String] Now()
    {
        Return [DateTime]::Now.ToString("MM/dd/yyyy HH:mm:ss")
    }
    [Object] Q3ALiveWorkspaceLogFile()
    {
        Return [Q3ALive.FileSystemObject][System.IO.FileInfo]::New($This.Fullname)
    }
    [Object] Q3ALiveWorkspaceLogEntry([UInt32]$Index,[String]$Line)
    {
        Return [Q3ALiveWorkspaceLogEntry]::New($Index,$Line)
    }
    [String] ToString()
    {
        Return $This.Fullname
    }
}

Class Q3ALiveWorkspace
{
    [Object] $Modified
    [String]     $Name
    [UInt32]   $Exists
    [Object]     $Size
    [String] $Fullname
    [Object]      $Log
    [Object]   $Output
    Q3ALiveWorkspace()
    {
        $This.Name     = "Workspace"
        $This.Refresh()
    }
    Check()
    {
        $This.Exists   = [System.IO.Directory]::Exists($This.Fullname)
    }
    Clear()
    {
        $This.Size   = $Null
        $This.Output = @( )
    }
    Assign([String]$Fullname)
    {
        If ([System.IO.Directory]::Exists($Fullname))
        {
            $This.Fullname = $Fullname
            $This.Check()
            
            If ($This.Exists)
            {
                $This.Refresh()
                $This.Log  = $This.Q3ALiveWorkspaceLog("$($This.Fullname)\Q3ALive-workspace.log")
            }
        }
    }
    Refresh()
    {
        $This.Clear()
        $This.Check()

        If ($This.Exists)
        {
            $Tree        = $This.Q3ALiveDirectoryScan()
            $Hash        = @{ }
            ForEach ($Item in $Tree.Output)
            {            
                $Hash.Add($Hash.Count,$This.Q3ALiveWorkspaceEntry($Hash.Count,$Item))
            }

            $This.Modified = $Tree.Modified
            $This.Output   = Switch ($Hash.Count) { 0 { @( ) } 1 { @($Hash[0]) } Default { $Hash[0..($Hash.Count-1)] } }
            $This.Size     = $Tree.GetRecursiveSize()
        }
    }
    Add([String]$Name)
    {
        $Item = $This.Output | ? Name -eq $Name
        If (!$Item)
        {
            $xPath = "{0}\{1}" -f $This.Fullname, $Name

            [System.IO.Directory]::CreateDirectory($xPath) > $Null

            ForEach ($Asset in $This.AssetTypes())
            {
                $aPath = "{0}\{1}" -f $xPath, $Asset
                [System.IO.Directory]::CreateDirectory($aPath) > $Null
            }

            $This.Refresh()
        }
    }
    Remove([String]$Name)
    {
        $Item = $This.Output | ? Name -eq $Name
        If ($Item)
        {
            [System.IO.Directory]::Delete($Item.Fullname,$True)

            $This.Refresh()
        }
    }
    SetSelected([UInt32]$Index)
    {
        If ($Index -in $This.Output.Index)
        {
            ForEach ($Item in $This.Output)
            {
                $Item.Selected = $Item.Index -eq $Index
            }
        }
    }
    [Object] Current()
    {
        Return $This.Output | ? Selected
    }
    [String[]] AssetTypes()
    {
        Return [System.Enum]::GetNames([Q3ALive.AssetType])
    }
    [Object] Q3ALiveWorkspaceLog([String]$Fullname)
    {
        Return [Q3ALiveWorkspaceLog]::New($Fullname)
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALive.ByteSize]::New("Workspace",$Bytes)
    }
    [Object] Q3ALiveWorkspaceEntry([UInt32]$Index,[Object]$Object)
    {
        Return [Q3ALiveWorkspaceEntry]::New($Index,$Object)
    }
    [Object] Q3ALiveDirectoryScan()
    {
        Return [Q3ALive.DirectoryScan]::New($This.Fullname,0,0)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Workspace>"
    }
}

<#
    ____    ____________________________________________________________________________________________________        
   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
   \\__//¯¯¯ Shaders [~]                                                                                    ___//¯¯\\   
    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
#>

Class Q3ALiveSubshader
{
    [String]      $Shader
    [String]        $Name
    [String] $DisplayName
    [UInt32]   $IsDefault
    [UInt32]   $IsMissing
    [String]    $Fullname
    [UInt32]      $Exists
    Q3ALiveSubshader([String]$DisplayName)
    {
        $This.DisplayName = $DisplayName
        $This.Name        = $DisplayName | Split-Path -Leaf
        $This.Shader      = $DisplayName | Split-Path
        $This.Fullname    = "\scripts\{0}.shader" -f $This.Shader
    }
    Check()
    {
        # $This.Exists      = [System.IO.File]::New($This.Fullname)
    }
    [String] ToString()
    {
        Return $This.DisplayName
    }
}

Class Q3ALiveShaderItemLine
{
    [UInt32] $Index
    [String]  $Line
    Q3ALiveShaderItemLine([UInt32]$Index,[String]$Line)
    {
        $This.Index = $Index
        $This.Line  = $Line
    }
    [String] ToString()
    {
        Return $This.Line
    }
}

Class Q3ALiveShaderItemFormat
{
    [UInt32]       $Index
    [String] $DisplayName
    [Object]     $Content
    Q3ALiveShaderItemFormat([UInt32]$Index,[String]$DisplayName)
    {
        $This.Index       = $Index
        $This.DisplayName = $DisplayName
        $This.Content     = @( )
    }
    Add([String]$Line)
    {
        $This.Content    += $This.Q3ALiveShaderItemLine($This.Content.Count,$Line)
    }
    Format()
    {
        $Ct = $This.Content.Count - 1

        ForEach ($X in 0..$Ct)
        {
            If ($X -notin 0,1,$Ct)
            {
                $This.Content[$X].Line = "    {0}" -f $This.Content[$X].Line
            }
        }

        $Start     = $This.Content | ? Line -match "    {" | Select-Object -First 1 | % Index
        
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
    [Object] Q3ALiveShaderItemLine([UInt32]$Index,[String]$Line)
    {
        Return [Q3ALiveShaderItemLine]::New($Index,$Line)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Shader.Item.Format>"
    }
}

Class Q3ALiveShaderItem
{
    [UInt32]         $File
    [UInt32]        $Index
    [String]  $DisplayName
    [String]         $Name
    [String]     $Fullname
    [UInt32]    $IsTexture
    [UInt32]    $IsVirtual
    [UInt32] $IsReferenced
    [Object]    $Subshader
    [Object]      $Content
    Q3ALiveShaderItem([UInt32]$Index,[String]$DisplayName)
    {
        $This.Index         = $Index
        $This.DisplayName   = $DisplayName.Replace("textures/","")
        $This.Name          = $DisplayName | Split-Path -Leaf
        $This.Fullname      = $DisplayName
        $This.Subshader     = @( )
        $This.Content       = @( )
    }
    Add([String]$Line)
    {
        $This.Content      += $This.Q3ALiveShaderItemLine($This.Content.Count,$Line)
    }
    GetSubshader()
    {
        [Console]::WriteLine("Shader [~] $($This.DisplayName)")

        $This.Subshader     = @( )

        $xSubshader         = $This.Content | ? { $_ -match "textures\/\S+" } # // <- write logic to handle models too
        If ($xSubshader.Count -gt 0)
        {
            $Filter         = $xSubshader | % { [Regex]::Matches($_,"textures\S+").Value.TrimEnd(" ") }
            $Filter         = $Filter.Replace("textures/","").Replace(".tga","") | Select-Object -Unique

            $This.Subshader = @($Filter | % { $This.Q3ALiveSubshader($_) })
        }
    }
    [Object] Q3ALiveShaderItemLine([UInt32]$Index,[String]$Line)
    {
        Return [Q3ALiveShaderItemLine]::New($Index,$Line)
    }
    [Object] Q3ALiveSubshader([String]$DisplayName)
    {
        Return [Q3ALiveSubshader]::New($DisplayName)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Assignment.Shader.Item>"
    }
}

Class Q3ALiveShaderFileLine
{
    [UInt32]      $Index
    [Int32] $ShaderIndex
    [String]       $Line
    Q3ALiveShaderFileLine([UInt32]$Index,[Int32]$ShaderIndex,[String]$Line)
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

Class Q3ALiveShaderFileItem
{
    [UInt32]        $Index
    [String]       $Source
    [String]         $Type
    [String]        $Label
    [Object]     $Modified
    [String]         $Name
    [String]    $Extension
    [String]  $DisplayName
    [String]     $Fullname
    [Object]         $Size
    [String]       $Shader
    [UInt32] $IsReferenced
    [Object]      $Content
    [Object]       $Output
    Hidden [Object] $_File
    Hidden [Object] $_Package
    Q3ALiveShaderFileItem([UInt32]$Index,[String]$Type,[Object]$Asset)
    {
        $This.Index            = $Index
        $This.Source           = $Asset.Source
        $This.Type             = $Type
        $This.Label            = "Script"
        $This.Modified         = $Asset.Modified
        $This.Name             = $Asset.Name
        $This.Shader           = $Asset.Name -Replace ".shader",""
        $This.DisplayName      = $Asset.DisplayName
        $This.Size             = $Asset.Size
        $This.Fullname         = $Asset.Fullname
        $This.Refresh()
    }
    Q3ALiveShaderFileItem([Object]$Item)
    {
        $This.Index            = $Item.Index
        $This.Source           = $Item.Source
        $This.Type             = $Item.GetType().Name
        $This.Label            = $Item.Label
        $This.Modified         = $Item.Modified
        $This.Name             = $Item.Name
        $This.Extension        = $Item.Extension
        $This.DisplayName      = $Item.DisplayName
        $This.Fullname         = $Item.Fullname
        $This.Size             = $Item.Size
        $This.Shader           = $Item.Name -Replace ".shader",""

        # Assign object
        Switch ($This.Type)
        {
            FileSystemObject
            {
                $This._File    = $Item
            }
            PackageFileEntry
            {
                $This._Package = $Item
            }
        }

        $This.Refresh()
    }
    Clear()
    {
        $This.Content       = @( )
    }
    Refresh()
    {
        $This.Clear()
        $xContent           = $Null

        Switch -Regex ($This.Type)
        {
            PackageFileEntry
            {
                $This._Package.ReadAllBytes()
                $xContent       = [Char[]]$This._Package.Bytes -join "" -split "`n"
            }
            "(Stream|Archive)"
            {
                $xPath          = $This.Fullname.Replace($This.DisplayName,"")
                $xArchive       = [System.IO.Compression.ZipFile]::Open($xPath,"Read")
                $Entry          = $xArchive.Entries | ? Name -eq $This.Name
                
                $xContent       = ([System.IO.StreamReader]::New($Entry.Open()).ReadToEnd()) -split "`r?`n"
                $xArchive.Dispose()
            }
            Default
            {
                $xContent       = [System.IO.File]::ReadAllLines($This.Fullname)
            }
        }

        # // Prepares the shader content format
        $yContent           = $xContent -Replace "\t","" -Replace "\s+"," " | ? Length -gt 0 | ? { $_ -notmatch "(^\s*\/\/|^\s)" }
        $Shaders            = $yContent | ? { $_ -match "^(textures|models)" }

        $Hash               = @{ }
        ForEach ($Line in $yContent)
        {
            If ($Line -in $Shaders)
            {
                $Hash.Add($Hash.Count,$This.Q3ALiveShaderItemFormat($Hash.Count,$Line))
                #$Hash.Add($Hash.Count,[Q3ALiveShaderItemFormat]::New($Hash.Count,$Line))
            }
                
            $Hash[$Hash.Count-1].Add($Line)
        }

        $Array              = $Hash[0..($Hash.Count-1)]

        ForEach ($Item in $Array)
        {
            $Item.Format()
            $Item.Add("")
        }

        $xContent           = $Array.Content.Line

        # // Converts all formatted shader data into line by line objects
        $Hash               = @{ }
        $sContent           = @{ }
        $ShaderIndex        = -1

        ForEach ($Line in $xContent)
        {
            $Line           = $Line.Replace("\t","    ")

            If ($Line -match "^(textures|models)")
            {
                $ShaderIndex ++
                $Hash.Add($Hash.Count,$This.Q3ALiveShaderItem($Hash.Count,$Line))
            }

            $sContent.Add($sContent.Count,$This.Q3ALiveShaderFileLine($sContent.Count,$ShaderIndex,$Line))
            If ($ShaderIndex -ge 0)
            {
                $Hash[$ShaderIndex].Add($Line)
            }
        }

        $This.Content = Switch ($sContent.Count) { 0 { } 1 { $sContent[0] } Default { $sContent[0..($sContent.Count-1)] } }

        $This.Output  = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } }

        # Flag default subshaders
        $Default      = $This.DefaultShaders()

        ForEach ($Item in $This.Output)
        {
            $Item.GetSubshader()

            ForEach ($Subshader in $Item.Subshader)
            {
                $Subshader.IsDefault = $Subshader.Shader -in $Default
            }
        }
    }
    [String[]] DefaultShaders()
    {
        Return [System.Enum]::GetNames([Q3ALive.DefaultShadersType])
    }
    [String] ArchiveString()
    {
        Return $This.DisplayName.Replace("\","/").TrimStart("/")
    }
    [Object] Q3ALiveShaderItemFormat([UInt32]$Index,[String]$DisplayName)
    {
        Return [Q3ALiveShaderItemFormat]::New($Index,$DisplayName)
    }
    [Object] Q3ALiveShaderFileLine([UInt32]$Index,[Int32]$ShaderIndex,[String]$Line)
    {
        Return [Q3ALiveShaderFileLine]::New($Index,$ShaderIndex,$Line)
    }
    [Object] Q3ALiveShaderItem([UInt32]$Index,[Object[]]$Line)
    {
        Return [Q3ALiveShaderItem]::New($Index,$Line)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Assignment.Shader.File.Item>"
    }
}

Class Q3ALiveShaderFileList
{
    [String]  $Type
    [Object] $Asset
    [Object]  $File
    Q3ALiveShaderFileList([String]$Type)
    {
        $This.Type    = $Type
        $This.Clear()
    }
    Assign([Object[]]$Asset)
    {
        $This.Asset   = $Asset
        $This.Refresh()
    }
    Clear()
    {
        $This.File    = @( )
    }
    Refresh()
    {
        $This.Clear()

        $Hash        = @{ } 

        ForEach ($Item in $This.Asset)
        {
            $Hash.Add($Hash.Count,$This.Q3ALiveShaderFileItem($Hash.Count,$This.Type,$Item))
        }

        $This.File   = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } }
    }
    [String[]] DefaultShaders()
    {
        Return [System.Enum]::GetNames([Q3ALive.DefaultShadersType])
    }
    [Object] Get([String]$DisplayName)
    {
        Return $This.Shader.File.Output | ? DisplayName -eq $DisplayName
    }
    [Object] Q3ALiveShaderFileItem([UInt32]$Index,[String]$Type,[Object]$Asset)
    {
        Return [Q3ALiveShaderFileItem]::New($Index,$Type,$Asset)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Assignment.Shader.File.List>"
    }
}

<#
    ____    ____________________________________________________________________________________________________        
   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
   \\__//¯¯¯ Textures [~]                                                                                   ___//¯¯\\   
    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
#>

Class Q3ALiveTextureFileItem
{
    [UInt32]        $Index
    [String]         $Type
    [String]       $Source
    [String]     $Modified
    [String]         $Name
    [String]    $Extension
    [String]        $Label
    [String]  $DisplayName
    [String]    $Reference
    [Object]         $Size
    [UInt32] $IsReferenced
    [UInt32]  $IsSubshader
    [String]     $Fullname
    [String]      $NewName
    Hidden [Byte[]] $Bytes
    Q3ALiveTextureFileItem([UInt32]$Index,[Object]$Asset)
    {
        $This.Index       = $Index
        $This.Type        = $Asset.Type
        $This.Source      = $Asset.Source
        $This.Modified    = $Asset.Modified
        $This.Name        = $Asset.Name
        $This.Extension   = $Asset.Extension
        $This.Label       = $This.GetLabel()
        $This.DisplayName = $Asset.DisplayName
        $This.Reference   = $This.ReferenceString()
        $This.Size        = $Asset.Size
        $This.Fullname    = $Asset.Fullname
    }
    [String] GetLabel()
    {
        Return @{ tga = "Targa"; jpg = "Jpeg"; png = "Png"}[$This.Extension]
    }
    [String] ArchiveString()
    {
        Return $This.DisplayName.Replace("\","/").TrimStart("/")
    }
    [String] ReferenceString()
    {
        $xDisplayName = $This.DisplayName -Replace "(\\textures\\|\.(tga|jpg|png))","" -Replace "\\", "/"
        
        Return $xDisplayName.TrimStart("/")
    }
    [String] Leaf()
    {
        Return "{0}.tga" -f $This.Reference
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALive.ByteSize]::New("Texture",$Bytes)
    }
    [String] ToString()
    {
        Return $This.Fullname
    }
}

Class Q3ALiveTextureFileList
{
    [String]  $Type
    [Object] $Asset
    [Object]  $File
    Q3ALiveTextureFileList([String]$Type)
    {
        $This.Type = $Type
        $This.Clear()
    }
    Assign([Object[]]$Asset)
    {
        $This.Asset = $Asset
        $This.Refresh()
    }
    Clear()
    {
        $This.File = @( )
    }
    Refresh()
    {
        $This.Clear()

        $Hash = @{ }
        ForEach ($File in $This.Asset)
        {
            $Hash.Add($Hash.Count,$This.Q3ALiveTextureFileItem($Hash.Count,$File))
        }

        $This.File = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } }
    }
    [Object] Q3ALiveTextureFileItem([UInt32]$Index,[Object]$File)
    {
        Return [Q3ALiveTextureFileItem]::New($Index,$File)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Assignment.Texture.File.List>"
    }
}

<# 
    ____    ____________________________________________________________________________________________________        
   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
   \\__//¯¯¯ Audio [~]                                                                                      ___//¯¯\\   
    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
#>

Class Q3ALiveAudioEngine
{
    [String]      $Name
    [Object]   $Current
    [Object]    $Player
    Hidden [Bool] $Drag
    Q3ALiveAudioEngine([String]$Name)
    {
        $This.Name    = $Name
        $This.Current = $Null
        $This.Player  = $This.Q3ALiveAudioPlayer()
    }
    Load([Object]$Audio)
    {
        $This.Current = $Audio
        $This.Player.Load($This.Current)
    }
    Clear()
    {
        $This.Current = $Null
        $This.Player.Clear()
    }
    Play()
    {
        If ($This.Current)
        {
            $This.Player.Play()
        }
    }
    Pause()
    {
        If ($This.Current)
        {
            $This.Player.Pause()
        }
    }
    Stop()
    {
        If ($This.Current)
        {
            $This.Player.Stop()
        }
    }
    [Object] Q3ALiveAudioPlayer()
    {
        Return [Q3ALive.AudioPlayer]::New()
    }
    [String] ToString()
    {
        Return "<Q3ALive.Audio.Engine({0})[{1}]>" -f $This.Index, $This.Name
    }
}

Class Q3ALiveAudioController
{
    [Object] $Sound
    [Object] $Music
    Q3ALiveAudioController()
    {
        $This.Sound = $This.Q3ALiveAudioEngine("Sound")
        $This.Music = $This.Q3ALiveAudioEngine("Music")
    }
    Load([String]$Name,[Object]$Current)
    {
        Switch ($Name)
        {
            Sound
            {
                $This.Sound.Current = $Current
                $This.Sound.Player.Load($This.Sound.Current)
            }
            Music
            {
                $This.Music.Current = $Current
                $This.Music.Player.Load($This.Music.Current)
            }
        }
    }
    Clear([String]$Name)
    {
        Switch ($Name)
        {
            Sound
            {
                $This.Sound.Current = $Null
                $This.Sound.Player.Clear()
            }
            Music
            {
                $This.Music.Current = $Null
                $This.Music.Player.Clear()
            }
        }
       
    }
    Play([String]$Name)
    {
        Switch ($Name)
        {
            Sound
            {
                If ($This.Sound.Current)
                {
                    $This.Sound.Player.Play()
                }
            }
            Music
            {
                If ($This.Music.Current)
                {
                    $This.Music.Player.Play()
                }
            }
        }
    }
    Pause([String]$Name)
    {
        Switch ($Name)
        {
            Sound
            {
                If ($This.Sound.Current)
                {
                    $This.Sound.Player.Pause()
                }
            }
            Music
            {
                If ($This.Music.Current)
                {
                    $This.Music.Player.Pause()
                }
            }
        }
    }
    Stop([String]$Name)
    {
        Switch ($Name)
        {
            Sound
            {
                If ($This.Sound.Current)
                {
                    $This.Sound.Player.Stop()
                }
            }
            Music
            {
                If ($This.Music.Current)
                {
                    $This.Music.Player.Stop()
                }
            }
        }
    }
    [Object] Q3ALiveAudioEngine([String]$Name)
    {
        Return [Q3ALiveAudioEngine]::New($Name)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Audio.Controller>"
    }
}

<#
    ____    ____________________________________________________________________________________________________        
   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
   \\__//¯¯¯ Arena/Text [~]                                                                                 ___//¯¯\\   
    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
#>
Class Q3ALiveArenaContent
{
    [UInt32] $Index
    [String]  $Line
    Q3ALiveArenaContent([UInt32]$Index,[String]$Line)
    {
        $This.Index = $Index
        $This.Line  = $Line
    }
    [String] ToString()
    {
        Return $This.Line
    }
}

Class Q3ALiveArenaProperty
{
    [UInt32] $Index
    [String] $Name
    [String] $Property
    Q3ALiveArenaProperty()
    {

    }
}

Class Q3ALiveArenaObject
{
    [String]       $Index
    [String]      $Source
    [String]        $Type
    [String]       $Label
    [Object]    $Modified
    [String]        $Name
    [String]   $Extension
    [String] $DisplayName
    [String]    $Fullname
    [Object]        $Size
    [UInt32]      $Exists
    [Byte[]]       $Bytes
    [String]   $Reference
    [Object]     $Content
    [Object]    $Property
    Q3ALiveArenaObject([Object]$Item)
    {
        $This.Index       = $Item.Index
        $This.Source      = $Item.Source
        $This.Type        = $Item.Type
        $This.Label       = $Item.Label
        $This.Modified    = $Item.Modified
        $This.Name        = $Item.Name
        $This.Extension   = $Item.Extension
        $This.DisplayName = $Item.DisplayName
        $This.Fullname    = $Item.Fullname
        $This.Size        = $Item.Size
        $This.Exists      = 1

        $Item.ReadAllBytes()
        $This.Bytes       = $Item.Bytes
        $This.Reference   = $Item.Reference
        $This.Refresh()
    }
    Clear()
    {
        $This.Content     = @( )
        $This.Property    = $This.Q3ALiveArenaProperty()
    }
    Refresh()
    {
        $This.Clear()

        If ($This.Exists)
        {
            $xContent     = [Char[]]$This.Bytes -join "" -Split "`n"
            $Hash         = @{ }
            ForEach ($Line in $xContent)
            {
                $Line = Switch -Regex ($Line)
                {
                    "(\{|\})" { $Line                                         }
                    Default   { "    {0}" -f ($Line -Replace "(\s+|\t)", " ") }
                }

                $Hash.Add($Hash.Count,$This.Q3ALiveArenaContent($Hash.Count,$Line))
            }

            $This.Content = @(Switch ($Hash.Count)
            {
                0 { $Null } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] }
            })

            #$This.Property.Assign($This.Content)
        }
    }
    [Object] Q3ALiveArenaContent([UInt32]$Index,[String]$Line)
    {
        Return [Q3ALiveArenaContent]::New($Index,$Line)
    }
    [Object] Q3ALiveArenaProperty()
    {
        Return [Q3ALiveArenaProperty]::New()
    }
    [String] ToString()
    {
        Return "<Q3ALive.Arena.Object>"
    }
}

Class Q3ALiveTextContent
{
    [UInt32] $Index
    [String] $Line
    Q3ALiveTextContent([UInt32]$Index,[String]$Line)
    {
        $This.Index = $Index
        $This.Line  = $Line
    }
    [String] ToString()
    {
        Return $This.Line
    }
}

Class Q3ALiveTextObject
{
    [String]       $Index
    [String]      $Source
    [String]        $Type
    [String]       $Label
    [Object]    $Modified
    [String]        $Name
    [String]   $Extension
    [String] $DisplayName
    [String]    $Fullname
    [Object]        $Size
    [UInt32]      $Exists
    [Byte[]]       $Bytes
    [String]   $Reference
    [Object]     $Content
    [Object]    $Property
    Q3ALiveTextObject([Object]$Item)
    {
        $This.Index       = $Item.Index
        $This.Source      = $Item.Source
        $This.Type        = $Item.Type
        $This.Label       = $Item.Label
        $This.Modified    = $Item.Modified
        $This.Name        = $Item.Name
        $This.Extension   = $Item.Extension
        $This.DisplayName = $Item.DisplayName
        $This.Fullname    = $Item.Fullname
        $This.Size        = $Item.Size
        $This.Exists      = 1

        $Item.ReadAllBytes()
        $This.Bytes       = $Item.Bytes
        $This.Refresh()
    }
    Clear()
    {
        $This.Content     = @( )
    }
    Refresh()
    {
        $This.Clear()

        If ($This.Exists)
        {
            $xContent     = [Char[]]$This.Bytes -join "" -Split "`n"
            $Hash         = @{ }
            ForEach ($Line in $xContent)
            {
                $Hash.Add($Hash.Count,$This.Q3ALiveTextContent($Hash.Count,$Line.Replace("`r","")))
            }

            $This.Content = @(Switch ($Hash.Count)
            {
                0 { $Null } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] }
            })
        }
    }
    [Object] Q3ALiveTextContent([UInt32]$Index,[String]$Line)
    {
        Return [Q3ALiveTextContent]::New($Index,$Line)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Text.Object>"
    }
}

<#
    ____    ____________________________________________________________________________________________________        
   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
   \\__//¯¯¯ Assignment [~]                                                                                 ___//¯¯\\   
    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
#>

Class Q3ALiveArchiveEntry
{
    [UInt32]       $Index
    [String]        $Type
    [String]      $Source
    [String]    $Modified
    [String]        $Name
    [String]   $Extension
    [String]       $Label
    [String] $DisplayName
    [String]   $Reference
    [Object]        $Size
    [String]    $Fullname
    [UInt32]      $Exists
    Q3ALiveArchiveEntry([UInt32]$Index,[String]$Source,[Object]$Entry)
    {
        $This.Index     = $Index
        $This.Type      = @("File","Directory")[$Entry.Length -eq 0]
        $This.Source    = $Source
        $This.Modified  = $Entry.LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss")
        $xPath          = $Entry.Fullname.Replace("/","\").TrimEnd("\")
        $This.Name      = $xPath | Split-Path -Leaf
        $This.Extension = $Entry.Name.Split(".")[-1]
        $This.Fullname  = "$Source\$xPath"
        $This.SetDisplayName("\$xPath")
        $This.Size      = $This.Q3ALiveByteSize($Entry.Length)
    }
    SetDisplayName([String]$DisplayName)
    {
        $This.DisplayName = $DisplayName.Replace("/","\")
        $This.Label       = Switch -Regex ($DisplayName.TrimStart("\").Split("\")[0])
        {
            Default    { "Other"     }
            levelshots { "Levelshot" }
            maps       { "Map"       }
            models     { "Model"     }
            music      { "Music"     }
            scripts    { "Script"    }
            sound      { "Sound"     }
            textures   { "Texture"   }
        }
    }
    [String] ArchiveString()
    {
        Return $This.DisplayName.Replace("\","/").TrimStart("/")
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALive.ByteSize]::New("Entry",$Bytes)
    }
}

Class Q3ALiveAssignmentResourceArchive
{
    [UInt32] $Index
    [String] $Type
    [String] $Modified
    [String] $Name
    [String] $Fullname
    [Object] $Size
    [UInt32] $Exists
    [Object] $Shader
    [Object] $Texture
    [Object] $Output
    [Object] $FileStream
    [Object] $Archive
    Q3ALiveAssignmentResourceArchive([UInt32]$Index,[String]$Fullname)
    {
        $This.Index        = $Index
        $This.Type         = "Archive"
        $This.Fullname     = $Fullname
        $This.Name         = $Fullname | Split-Path -Leaf

        $This.Shader       = $This.Q3ALiveShaderFileList("Stream")
        $This.Texture      = $This.Q3ALiveTextureFileList("Stream")

        $Item              = Get-Item $Fullname -EA 0
        If ($Item)
        {
            $This.Modified = $Item.LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss")
            
            $This.Size     = $This.Q3ALiveByteSize($Item.Length)
            $This.Exists   = 1
            $This.Refresh()
        }
    }
    Clear()
    {
        $This.Output       = @( )
        $This.Shader.Clear()
        $This.Texture.Clear()
    }
    Check()
    {

    }
    Refresh()
    {
        $This.Clear()
        $This.Check()

        If ($This.Exists)
        {
            Try
            {
                $xArchive = [System.IO.Compression.ZipFile]::Open($This.Fullname,"Read")
                If ($xArchive)
                {
                    $Hash = @{ }
                    ForEach ($Entry in $xArchive.Entries)
                    {
                        $Item      = $This.Q3ALiveArchiveEntry($Hash.Count,$This.Fullname,$Entry)
                        $Item.Type = "Stream"
                        $Hash.Add($Hash.Count,$Item)
                    }

                    $This.Output = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default {$Hash[0..($Hash.Count-1)] } }

                    $xArchive.Dispose()

                    # Process shaders
                    $xShader     = $This.Output | ? Extension -eq Shader
                    $This.Shader.Assign($xShader)

                    # Process textures
                    $xTexture    = $This.Output | ? Type -match "(File|Stream)" | ? Label -eq Texture
                    $This.Texture.Assign($xTexture)
                }
            }
            Catch
            {

            }
        }
    }
    [Object] Q3ALiveShaderFileList([String]$Type)
    {
        Return [Q3ALiveShaderFileList]::New($Type)
    }
    [Object] Q3ALiveTextureFileList([String]$Type)
    {
        Return [Q3ALiveTextureFileList]::New($Type)
    }
    [Object] Q3ALiveArchiveEntry([UInt32]$Index,[String]$Source,[Object]$Entry)
    {
        Return [Q3ALiveArchiveEntry]::New($Index,$Source,$Entry)
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALive.ByteSize]::New("Archive",$Bytes)
    }
}

Class Q3ALiveAssignmentResourceDirectoryAsset
{
    [UInt32]       $Index
    [String]        $Type
    [String]      $Source
    [String]    $Modified
    [String]        $Name
    [String]   $Extension
    [String]       $Label
    [String] $DisplayName
    [String]   $Reference
    [Object]        $Size
    [String]    $Fullname
    [UInt32]      $Exists
    Q3ALiveAssignmentResourceDirectoryAsset([UInt32]$Index,[String]$Source,[Object]$File)
    {
        $This.Index     = $Index
        $This.Source    = $Source

        Switch -Regex ($File.GetType().Name)
        {
            DirectoryInfo
            {
                $This.Type = "Directory"
            }
            FileInfo
            {
                $This.Type = "File"
                $This.Extension = $File.Extension.TrimStart(".")
            }
            Default
            {
                $This.Type = "Other"
            }
        }

        $This.Modified  = $File.LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss")
        $This.Name      = $File.Name

        $This.Size      = $This.Q3ALiveByteSize($File.Length)
        $This.Fullname  = $File.Fullname
        $This.Exists    = 1

        $This.SetDisplayName($This.Fullname.Replace($Source,""))
    }
    SetDisplayName([String]$DisplayName)
    {
        $This.DisplayName = $DisplayName
        $This.Label       = Switch -Regex ($DisplayName.TrimStart("\").Split("\")[0])
        {
            Default    { "Other"     }
            levelshots { "Levelshot" }
            maps       { "Map"       }
            models     { "Model"     }
            music      { "Music"     }
            scripts    { "Script"    }
            sound      { "Sound"     }
            textures   { "Texture"   }
        }
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALive.ByteSize]::New("Asset",$Bytes)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Assignment.Resource.Asset>"
    }
}

Class Q3ALiveAssignmentResourceDirectory
{
    [UInt32] $Index
    [String] $Type
    [String] $Modified
    [String] $Name
    [String] $Fullname
    [Object] $Size
    [UInt32] $Exists
    [Object] $Shader
    [Object] $Texture
    [Object] $Output
    Q3ALiveAssignmentResourceDirectory([UInt32]$Index,[String]$Fullname)
    {
        $This.Index    = $Index
        $This.Type     = "Directory"
        $This.Shader   = $This.Q3ALiveShaderFileList("File")
        $This.Texture  = $This.Q3ALiveTextureFileList("File")

        $This.Name     = $Fullname | Split-Path -Leaf
        $This.Fullname = $Fullname

        $This.Refresh()
    }
    Clear()
    {
        $This.Output   = @( )
        $This.Shader.Clear()
        $This.Texture.Clear()
    }
    Check()
    {
        $This.Exists = [UInt32][System.IO.Directory]::Exists($This.Fullname)
    }
    Refresh()
    {
        $This.Clear()
        $This.Check()

        If ($This.Exists)
        {
            $Item          = Get-Item $This.Fullname
            $This.Modified = $Item.LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss")

            $Hash          = @{ }
            $Bytes         = 0
            ForEach ($Item in Get-ChildItem $This.Fullname -Recurse | Sort-Object Fullname)
            {
                If ($Item.Length -gt 1)
                {
                    $Bytes = $Bytes + $Item.Length
                }

                $Hash.Add($Hash.Count,$This.Q3ALiveAssignmentResourceDirectoryAsset($Hash.Count,$This.Fullname,$Item))
            }

            $This.Output   = Switch ($Hash.Count) { 0 { @( ) } 1 { @($Hash[0]) } Default { $Hash[0..($Hash.Count-1)] } }
            $This.Size     = $This.Q3ALiveByteSize($Bytes)

            # Process shaders
            $xShader       = $This.Output | ? Extension -eq Shader
            $This.Shader.Assign($xShader)

            # Process textures
            $xTexture      = $This.Output | ? Type -eq File | ? Label -eq Texture
            $This.Texture.Assign($xTexture)
        }
    }
    [Object] Q3ALiveAssignmentResourceDirectoryAsset([UInt32]$Index,[String]$Source,[Object]$File)
    {
        Return [Q3ALiveAssignmentResourceDirectoryAsset]::New($Index,$Source,$File)
    }
    [Object] Q3ALiveShaderFileList([String]$Type)
    {
        Return [Q3ALiveShaderFileList]::New($Type)
    }
    [Object] Q3ALiveTextureFileList([String]$Type)
    {
        Return [Q3ALiveTextureFileList]::New($Type)
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALive.ByteSize]::New("Asset",$Bytes)
    }
    [String] ToString()
    {
        Return $This.Fullname
    }
}

Class Q3ALiveAssignmentResourceList
{
    [Object] $Output
    Q3ALiveAssignmentResourceList()
    {
        $This.Clear()
    }
    Add([String]$Fullname)
    {
        If ($Fullname -notin $This.Output.Fullname)
        {
            $Object = Get-Item $Fullname -EA 0
            If ($Object)
            {
                [Console]::WriteLine("Adding [+] Resource: [$Fullname]")

                $Item = Switch ($Object.GetType().Name)
                {
                    DirectoryInfo
                    {
                        $This.Q3ALiveAssignmentResourceDirectory($This.Output.Count,$Fullname)
                    }
                    FileInfo
                    {
                        $This.Q3ALiveAssignmentResourceArchive($This.Output.Count,$Fullname)
                    }
                    Default
                    {

                    }
                }

                If ($Item)
                {
                    $This.Output += $Item
                }
            }
        }
    }
    Remove([UInt32]$Index)
    {
        If ($Index -in $This.Output.Index)
        {
            [Console]::WriteLine("Removing [~] Resource: [$($This.Output[$Index].Fullname)]")

            $This.Output = $This.Output | ? Index -ne $Index
            $This.Rerank()
        }
    }
    Rerank()
    {
        $X = 0
        ForEach ($Item in $This.Output)
        {
            $Item.Index = $X 
            $X ++
        }
    }
    Clear()
    {
        $This.Output = @( )
    }
    [Object] GetShaderFile([Object]$Reference)
    {
        $Resource = $This.Output.Shader.File | ? Shader -eq $Reference.Shader

        If ($Resource.Count -eq 0)
        {
            Return $Null
        }
        ElseIf ($Resource.Count -eq 1)
        {
            Return $Resource
        }
        Else
        {
            [Console]::WriteLine("Duplicate [!] ($($Resource.Count)) entries found for $($Reference.Reference)")
            Return $Null
        }
    }
    [Object] GetShaderItem([Object]$Reference)
    {
        $Resource = $This.Output.Shader.File.Output | ? DisplayName -eq $Reference.DisplayName

        If ($Resource.Count -eq 0)
        {
            Return $Null
        }
        ElseIf ($Resource.Count -eq 1)
        {
            Return $Resource
        }
        Else
        {
            [Console]::WriteLine("Duplicate [!] ($($Resource.Count)) entries found for $($Reference.Reference)")
            Return $Null
        }
    }
    [Object] GetTextureFile([Object]$Reference)
    {
        $Filter = Switch ($Reference.GetType())
        {
            String  { $Reference }
            Default { $Reference.DisplayName }
        }

        $Resource = $This.Output.Texture.File | ? Reference -eq $Filter

        If ($Resource.Count -eq 0)
        {
            Return $Null
        }
        ElseIf ($Resource.Count -eq 1)
        {
            Return $Resource
        }
        Else
        {
            [Console]::WriteLine("Duplicate [!] ($($Resource.Count)) entries found for $($Reference.Reference)")
            Return $Null
        }
    }
    [Object[]] GetReferencedShaders()
    {
        Return $This.Output.Shader.File | ? IsReferenced
    }
    [Object[]] GetReferencedTextures()
    {
        Return $This.Output.Texture.File | ? IsReferenced
    }
    [Object] Q3ALiveAssignmentResourceArchive([UInt32]$Index,[String]$Fullname)
    {
        Return [Q3ALiveAssignmentResourceArchive]::New($Index,$Fullname)
    }
    [Object] Q3ALiveAssignmentResourceDirectory([UInt32]$Index,[String]$Fullname)
    {
        Return [Q3ALiveAssignmentResourceDirectory]::New($Index,$Fullname)
    }
}

Class Q3ALiveAssignmentEditFileLineDetail
{
    [Double[]] $Coords1
    [Double[]] $Coords2
    [Double[]] $Coords3
    [String]   $Texture
    [Double]     $X_Pos
    [Double]     $Y_Pos
    [Double]  $Rotation
    [Double]   $X_Scale
    [Double]   $Y_Scale
    [Double]      $Flag
    [UInt32]    $Param1
    [UInt32]    $Param2
    Q3ALiveAssignmentEditFileLineDetail([String]$Line)
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

Class Q3ALiveAssignmentEditFileLine
{
    [UInt32]         $Index
    [String]          $Line
    [UInt32]     $IsTexture
    [UInt32]       $IsBrush
    [UInt32]      $IsEntity
    [String]     $Reference
    [Object]        $Detail
    Q3ALiveAssignmentEditFileLine([UInt32]$Index,[String]$Line)
    {
        $This.Index   = $Index
        $This.Line    = $Line

        If ($This.Line -match $This.TexturePattern())
        {
            $This.IsTexture = 1

            $xLine          = $This.Line -Replace "(\(\s(-?\d+(\.\d+)?\s){3}\)\s){3}",""
            $This.Reference = [Regex]::Matches($xLine,"^\S+").Value
            $This.Detail    = $This.Q3ALiveAssignmentEditFileLineDetail($This.Line)
        }
        If ($This.Line -match $This.BrushPattern())
        {
            $This.IsBrush   = 1
        }
        If ($This.Line -match $This.EntityPattern())
        {
            $This.IsEntity  = 1
        }
    }
    [String] TexturePattern()
    {
        Return "(\(\s(-?\d+(\.\d+)?\s){3}\)\s){3}\S+\s(-?\d+(\.\d+)?\s){5}"
    }
    [String] BrushPattern()
    {
        Return "\/\/ brush \d+"
    }
    [String] EntityPattern()
    {
        Return "\/\/ entity \d+"
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
    [Object] Q3ALiveAssignmentEditFileLineDetail([String]$Line)
    {
        Return [Q3ALiveAssignmentEditFileLineDetail]::New($Line)
    }
    [String] ToString()
    {
        Return $This.Line
    }
}

Class Q3ALiveAssignmentEditReference
{
    [UInt32]       $Index
    [String]      $Shader
    [String]        $Name
    [String] $DisplayName
    [UInt32]   $IsDefault
    [UInt32]   $IsTexture
    [UInt32]    $IsShader
    [UInt32]   $IsVirtual
    [UInt32] $IsSubshader
    [UInt32]   $IsMissing
    Q3ALiveAssignmentEditReference([UInt32]$Index,[String]$DisplayName)
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

Class Q3ALiveAssignmentEditProperty
{
    [String] $Author
    [String] $Message
    [String] $Music
    [UInt32] $Brush
    [UInt32] $Entity
    Q3ALiveAssignmentEditProperty()
    {

    }
    [String] ToString()
    {
        Return "<Q3ALive.AssignmentEdit.Property>"
    }
}

Class Q3ALiveAssignmentEditAssetEntry
{
    [UInt32]       $Index
    [String]        $Type
    [String]      $Source
    [String]    $Modified
    [String]        $Name
    [String]   $Extension
    [String]       $Label
    [String] $DisplayName
    [String]   $Reference
    [Object]        $Size
    [String]    $Fullname
    [UInt32]      $Exists
    Q3ALiveAssignmentEditAssetEntry([UInt32]$Index,[Object]$File)
    {
        $This.Index    = $Index
        $This.Fullname = $File.Fullname

        $This.Refresh()
    }
    Initial()
    {
        $This.Type      = "<not set>"
        $This.Source    = $Null
        $This.Modified  = "XX/XX/XXXX XX:XX:XX"
        $This.Name      = "<not set>"
        $This.Size      = $This.Q3ALiveByteSize(0)
        $This.Extension = $Null
        $This.Label     = $Null
        $This.Reference = $Null
    }
    SetDisplayName([String]$DisplayName)
    {
        $This.Source      = $This.Fullname.Replace($DisplayName,"")
        $This.DisplayName = $DisplayName
        $This.Label       = Switch -Regex ($DisplayName.TrimStart("\").Split("\")[0])
        {
            Default    { "Other"     }
            levelshots { "Levelshot" }
            maps       { "Map"       }
            models     { "Model"     }
            music      { "Music"     }
            scripts    { "Script"    }
            sound      { "Sound"     }
            textures   { "Texture"   }
        }
    }
    Refresh()
    {
        $This.Initial()

        $File           = Get-Item $This.Fullname -EA 0

        If ($File)
        {
            $This.Exists    = 1
            $This.Modified  = $File.LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss")
            $This.Name      = $File.Name
            $This.Size      = $This.Q3ALiveByteSize($File.Length)

            Switch -Regex ($File.GetType().Name)
            {
                DirectoryInfo
                {
                    $This.Type = "Directory"
                }
                FileInfo
                {
                    $This.Type = "File"
                    $This.Extension = $File.Extension.TrimStart(".")
                }
                Default
                {
                    $This.Type = "Other"
                }
            }
        }
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALive.ByteSize]::New("Asset",$Bytes)
    }
    [String] ToString()
    {
        Return "<Q3ALive.AssignmentEdit.Asset>"
    }
}

Class Q3ALiveAssignmentEditArenaContent
{
    [UInt32] $Index
    [String] $Line
    Q3ALiveAssignmentEditArenaContent([UInt32]$Index,[String]$Line)
    {
        $This.Index = $Index
        $This.Line  = $Line
    }
    [String] ToString()
    {
        Return $This.Line
    }
}

Class Q3ALiveAssignmentEditArenaProperty
{
    [String]      $Map
    [String] $Longname
    [String]     $Type
    Q3ALiveAssignmentEditArenaProperty()
    {
        
    }
    Assign([Object[]]$Content)
    {
        # Map name
        $xName = $Content | ? Line -match "^\s*map"
        If ($xName)
        {
            $This.Map = $xName -Replace "(^\s*map\s+|\`")","" | % toLower
        }
        
        # Map longname
        $xLongname = $Content | ? Line -match "^\s*longname"
        If ($xName)
        {
            $This.Longname = $xLongname -Replace "(^\s*longname\s+|\`")",""
        }

        # Map type
        $xType = $Content | ? Line -match "^\s*type"
        If ($xName)
        {
            $This.Type = $xType -Replace "(^\s*type\s+|\`")",""
        }
    }
    Clear()
    {
        $This.Map      = $Null
        $This.Longname = $Null
        $This.Type     = $Null
    }
    [String] ToString()
    {
        Return "<Q3ALive.Assignment.Edit.Arena.Property>"
    }
}

Class Q3ALiveAssignmentEditSourceArena
{
    [String] $Index
    [String] $Type
    [String] $Source
    [String] $Modified
    [String] $Label
    [String] $Name
    [String] $Extension
    [String] $DisplayName
    [String] $Reference
    [String] $Size
    [String] $Fullname
    [String] $Exists
    [Object] $Content
    [Object] $Property
    Q3ALiveAssignmentEditSourceArena([Object]$Asset)
    {
        $This.Index       = $Asset.Index
        $This.Type        = $Asset.Type
        $This.Source      = $Asset.Source
        $This.Modified    = $Asset.Modified
        $This.Label       = $Asset.Label
        $This.Name        = $Asset.Name
        $This.Extension   = $Asset.Extension
        $This.DisplayName = $Asset.DisplayName
        $This.Reference   = $Asset.Reference
        $This.Size        = $Asset.Size
        $This.Fullname    = $Asset.Fullname
        $This.Exists      = $Asset.Exists
        $This.Refresh()
    }
    Check()
    {
        $This.Exists      = [System.IO.File]::Exists($This.Fullname)
    }
    Clear()
    {
        $This.Content     = @( )
        $This.Property    = $This.Q3ALiveAssignmentEditArenaProperty()
    }
    [Object[]] GetContent()
    {
        Return [System.IO.File]::ReadAllLines($This.Fullname)
    }
    SetContent()
    {
        $Bytes     = @( )
        ForEach ($Line in $This.Content.Line)
        {
            $Bytes += [System.Text.Encoding]::UTF8.GetBytes($Line)
            $Bytes += 10
        }

        [System.IO.File]::WriteAllBytes($This.Fullname,$Bytes)
    }
    Refresh()
    {
        $This.Clear()
        $This.Check()

        If ($This.Exists)
        {
            $Hash         = @{ }
            ForEach ($Line in $This.GetContent())
            {
                $Line = Switch -Regex ($Line)
                {
                    "(\{|\})" { $Line                                         }
                    Default   { "    {0}" -f ($Line -Replace "(\s+|\t)", " ") }
                }

                $Hash.Add($Hash.Count,$This.Q3ALiveAssignmentEditArenaContent($Hash.Count,$Line))
            }

            $This.Content = @(Switch ($Hash.Count)
            {
                0 { $Null } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] }
            })

            $This.Property.Assign($This.Content)
        }
    }
    [Object] Q3ALiveAssignmentEditArenaContent([UInt32]$Index,[String]$Line)
    {
        Return [Q3ALiveAssignmentEditArenaContent]::New($Index,$Line)
    }
    [Object] Q3ALiveAssignmentEditArenaProperty()
    {
        Return [Q3ALiveAssignmentEditArenaProperty]::New()
    }
    [String] ToString()
    {
        Return "<Q3ALive.AssignmentEdit.Source.Arena>"
    }
}

<#
Class Q3ALiveAssignmentEditLevelshot : Q3ALiveAssignmentEditSourceAsset
{
    [UInt32] $Index
    [String] $Type
    [String] $Source
    [String] $Modified
    [String] $Label
    [String] $Name
    [String] $Extension
    [String] $DisplayName
    [String] $Reference
    [Object] $Size
    [String] $Fullname
    [UInt32] $Exists
    [Byte[]] $Bytes
    Q3ALiveAssignmentEditLevelshot([UInt32]$Index,[Object]$File) : Base ($Index,$File)
    {

    }
    Clear()
    {
        $This.Bytes = $Null
    }
    Read()
    {
        $This.Clear()
        $This.Check()

        If ($This.Exists)
        {
            $This.Bytes = [System.IO.File]::ReadAllBytes($This.Fullname)
        }
    }
    [String] ToString()
    {
        Return "<Q3ALive.AssignmentEdit.Levelshot>"
    }
}
#>

Class Q3ALiveAssignmentEditItemDirectory
{
    [String]     $Type
    [String]     $Name
    [String] $Fullname
    [UInt32]   $Exists
    [Object]   $Output
    Q3ALiveAssignmentEditItemDirectory([String]$Type,[String]$Fullname)
    {
        $This.Type     = $Type
        $This.Name     = $Fullname | Split-Path -Leaf
        $This.Fullname = $Fullname
        $This.Check()
    }
    Clear()
    {
        $This.Output   = @( )
    }
    Check()
    {
        $This.Exists = [UInt32][System.IO.Directory]::Exists($This.Fullname)
    }
    Create()
    {
        $This.Check()

        If (!$This.Exists)
        {
            [System.IO.Directory]::CreateDirectory($This.Fullname) > $Null

            $This.Check()
        }
    }
    [String] ToString()
    {
        Return $This.Fullname
    }
}

Class Q3ALiveAssignmentEditSourceAsset
{
    [UInt32] $Index
    [String] $Type
    [String] $Source
    [String] $Modified
    [String] $Label
    [String] $Name
    [String] $Extension
    [String] $DisplayName
    [String] $Reference
    [Object] $Size
    [String] $Fullname
    [UInt32] $Exists
    Q3ALiveAssignmentEditSourceAsset([UInt32]$Index,[String]$Source,[Object]$File)
    {
        $This.Index       = $Index
        $This.Type        = $This.AssignType($File)
        $This.Source      = $Source
        $This.Modified    = $File.LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss")
        $This.Name        = $File.Name
        $This.Extension   = $File.Extension.TrimStart(".")
        $This.Size        = $This.Q3ALiveByteSize($File.Length)
        $This.Fullname    = $File.Fullname
        $This.DisplayName = $File.FullName.Replace($Source,"")
        $This.SetLabel()
        $This.Check()
    }
    Check()
    {
        $This.Exists      = [UInt32](Test-Path $This.Fullname -EA 0)
    }
    SetLabel()
    {
        $Flag             = $This.DisplayName.Split("\")[1]
        $This.Label       = Switch -Regex ($Flag)
        {
            Default    { "Other"     }
            levelshots { "Levelshot" }
            maps       { "Map"       }
            models     { "Model"     }
            music      { "Music"     }
            scripts    { "Script"    }
            sound      { "Sound"     }
            textures   { "Texture"   }
        }
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALive.ByteSize]::New("Asset",$Bytes)
    }
    [String] AssignType([Object]$File)
    {
        Return @(Switch -Regex ($File.GetType().Name)
        {
            DirectoryInfo { "Directory" }
            FileInfo      { "File"      } 
            Default       { "Other"     }
        })
    }
    [String] ToString()
    {
        Return $This.Name
    }
}

Class Q3ALiveAssignmentEditSourceDirectory : Q3ALiveAssignmentEditItemDirectory
{
    [String]      $Type
    [String]      $Name
    [String]  $Fullname
    [UInt32]    $Exists
    [Object]    $Output
    [Object]       $Map
    [Object] $Levelshot
    [Object]     $Model
    [Object]     $Sound
    [Object]     $Music
    [Object]    $Script
    [Object]   $Texture
    Q3ALiveAssignmentEditSourceDirectory([String]$Type,[String]$Fullname) : base([String]$Type,[String]$Fullname)
    {
        $This.Clear()
    }
    Clear()
    {
        $This.Output    = @( )
        $This.Map       = @( )
        $This.Levelshot = @( )
        $This.Model     = @( )
        $This.Sound     = @( )
        $This.Music     = @( )
        $This.Script    = @( )
        $This.Texture   = @( )
    }
    Refresh()
    {
        $This.Clear()
        $This.Check()

        If ($This.Exists)
        {
            $List = Get-ChildItem $This.Fullname -Recurse | Sort-Object Fullname
            $Hash = @{ }
            ForEach ($File in $List)
            {
                $Item = $This.Q3ALiveAssignmentEditSourceAsset($Hash.Count,$File)

                # Assign to specific property
                If ($Item.Type -eq "File")
                {
                    Switch ($Item.Label)
                    {
                        Levelshot { $This.Levelshot += $Item }
                        Map       { $This.Map       += $Item }
                        Model     { $This.Model     += $Item }
                        Music     { $This.Music     += $Item }
                        Script    { $This.Script    += $Item }
                        Sound     { $This.Sound     += $Item }
                        Texture   { $This.Texture   += $Item }
                    }
                }

                $Hash.Add($Hash.Count,$Item)
            }

            $This.Output = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } }
        }
    }
    [Object] Q3ALiveAssignmentEditSourceAsset([UInt32]$Index,[Object]$File)
    {
        Return [Q3ALiveAssignmentEditSourceAsset]::New($Index,$This.Fullname,$File)
    }
}

Class Q3ALiveAssignmentEditItemArchive
{
    [String] $Name
    [String] $Fullname
    [String] $Modified
    [UInt32] $Exists
    [Object] $Size
    Q3ALiveAssignmentEditItemArchive([String]$Name,[String]$Fullname)
    {
        $This.Name     = $Name
        $This.Fullname = $Fullname
        $This.Check()
    }
    Check()
    {
        $This.Exists   = [UInt32][System.IO.File]::Exists($This.Fullname)
        $This.GetInfo()
    }
    GetInfo()
    {
        $Item          = Get-Item $This.Fullname -EA 0
        If ($Item)
        {
            $This.Modified = $Item.LastWriteTime("MM/dd/yyyy HH:mm:ss")
            $This.Size     = $This.Q3ALiveByteSize($Item.Bytes)
        }
        Else
        {
            $This.Modified = "XX/XX/XXXX XX:XX:XX"
            $This.Size     = $This.Q3ALiveByteSize(0)
        }
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALive.ByteSize]::New("Archive",$Bytes)
    }
}

Class Q3ALiveAssignmentEditItem
{
    [UInt32]       $Index
    [String]    $Modified
    [String]        $Name
    [String] $DisplayName
    [String]    $Fullname
    [UInt32]      $Exists
    [Object]        $Size
    [UInt32]    $Selected
    [Object]     $Content
    [Object]   $Reference
    [Object]    $Property
    [Object]      $Source
    [Object]      $Target
    [Object]     $Archive
    [Object]         $Map
    [Object]   $Levelshot
    [Object]       $Arena
    [Object]       $Model
    [Object]       $Sound
    [Object]       $Music
    [Object]      $Shader
    [Object]     $Texture
    Q3ALiveAssignmentEditItem([UInt32]$Index,[Object]$File)
    {
        $This.Index       = $Index
        $This.Modified    = $File.Modified
        $This.Shader      = $This.Q3ALiveShaderFileList("Directory")
        $This.Texture     = $This.Q3ALiveTextureFileList("Directory")

        $This.Name        = $File.Name
        $This.DisplayName = $File.DisplayName
        $This.Fullname    = $File.Fullname
        $This.Size        = $File.Size
        $This.Check()
        $This.Clear()
    }
    Clear()
    {
        $This.Map         = @( )
        $This.Levelshot   = @( )
        $This.Arena       = @( )
        $This.Model       = @( )
        $This.Sound       = @( )
        $This.Music       = @( )
        $This.Shader.Clear()
        $This.Texture.Clear()
    }
    Check()
    {
        $This.Exists      = [System.IO.File]::Exists($This.Fullname)
    }
    GetContent()
    {
        $This.Content = @( )

        If ([System.IO.File]::Exists($This.Fullname))
        {
            $xContent = [System.IO.File]::ReadAllLines($This.Fullname)
            $Hash     = @{ }

            ForEach ($Line in $xContent)
            {
                $Hash.Add($Hash.Count,$This.Q3ALiveAssignmentEditFileLine($Hash.Count,$Line))
            }

            $This.Content = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } }
        }
    }
    GetReference()
    {
        $This.Reference = @( )

        $DefaultShaders = $This.DefaultShaders()

        $xList          = $This.Content.Reference | Select-Object -Unique | Sort-Object
        $Hash           = @{ }

        ForEach ($Item in $xList)
        {
            $Entry           = $This.Q3ALiveAssignmentEditReference($Hash.Count,$Item)
            $Entry.IsDefault = [UInt32]($Entry.Shader -in $DefaultShaders)

            $Hash.Add($Hash.Count,$Entry)
        }

        $This.Reference = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } }
    }
    GetProperty()
    {
        $This.Property = $This.Q3ALiveAssignmentEditProperty()

        # Header
        $xHeader      = @( )
        $X            = 0
        Do
        {
            $xHeader += $This.Content[$X].Line
            $X ++
        }
        Until ($This.Content[$X].Line -match "// brush 0")
        
        ForEach ($Line in $xHeader)
        {
            Switch -Regex ($Line)
            {
                "^`"author`".+"  { $This.Property.Author  = $Line.Split("`"")[3] }
                "^`"message`".+" { $This.Property.Message = $Line.Split("`"")[3] }
                "^`"music`".+"   { $This.Property.Music   = $Line.Split("`"")[3] }
            }
        }
        
        $This.Property.Brush   = ($This.Content | ? IsBrush).Count
        $This.Property.Entity  = ($This.Content | ? IsEntity).Count
    }
    SetSource([Object]$Resource,[String]$Source)
    {
        $This.Source      = $This.Q3ALiveAssignmentEditSourceDirectory("Source",$Source)

        $This.CheckAssetTypes("Source")

        $This.SourceRefresh($Resource)
    }
    SetTarget([String]$Target)
    {
        $This.Target   = $This.Q3ALiveAssignmentEditItemDirectory("Target",$Target)

        $This.CheckAssetTypes("Target") 
    }
    CheckAssetTypes([String]$Type)
    {
        $Slot = @{ Source = $This.Source; Target = $This.Target }[$Type]
        
        If (!$Slot.Exists)
        {
            $Slot.Create()
        }

        ForEach ($Name in $This.AssetTypes())
        {
            $xPath = "{0}\$Name" -f $Slot.Fullname

            If (![System.IO.Directory]::Exists($xPath))
            {
                [System.IO.Directory]::CreateDirectory($xPath) > $Null
            }
        }
    }
    Refresh()
    {
        $xMap = $This

        $xMap.Check()

        If ($xMap.Exists)
        {
            [Console]::WriteLine("Processing [~] $($This.Fullname)")

            # // Get (*.map) file content
            $xMap.GetContent()

            # // Get references from (*.map) file content
            $xMap.GetReference()

            # // Get properties from (*.map) file
            $xMap.GetProperty()
        }
    }
    SourceRefresh([Object]$Resource)
    {
        $xMap = $This

        $xMap.Check()

        If ($xMap.Source.Exists)
        {
            $xMap.Refresh()
            $xMap.Source.Refresh()

            # // Get shader item list from (*.shader) file(s)
            $Hash = @{ }
            ForEach ($File in $xMap.Source.Output | ? Label -eq Script | ? Extension -eq Shader)
            {
                $File.Reference = "{0}" -f $File.Name.Replace(".shader","")
                $Hash.Add($Hash.Count,$File)
            }
            
            $Assets = @(Switch ($Hash.Count) { 0 {  } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } })
            
            $xMap.Shader.Assign($Assets)

            # // Get texture item list from (*.(jpg|tga|png)) file(s)
            $Hash     = @{ }
            ForEach ($File in $xMap.Source.Output | ? Label -eq Texture | ? Extension -match "(jpg|png|tga)")
            {
                $File.Reference = $File.DisplayName.Replace("\textures\",'').Replace("\","/").Replace(".$($File.Extension)","")
            
                $Hash.Add($Hash.Count,$File)
            }
            
            $Asset = @(Switch ($Hash.Count) { 0 {  } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } })
            
            $xMap.Texture.Assign($Asset)

            # // Assign References
            $xMap.QueryReferenceList($Resource)

            # Create objects for each of these
            $xMap.Map       = @($xMap.Source.Map)
            $xMap.Levelshot = @($xMap.Source.Levelshot)
            
            # Arena
            ForEach ($Asset in $xMap.Source.Script | ? Extension -eq Arena)
            {
                $xMap.Arena += $xMap.Q3ALiveAssignmentEditSourceArena($Asset)
            }

            $xMap.Model     = @($xMap.Source.Model)
            $xMap.Sound     = @($xMap.Source.Sound)
            $xMap.Music     = @($xMap.Source.Music)
        }
    }
    [String] Escape([String]$String)
    {
        Return [Regex]::Escape($String)
    }
    [Object] GetReference([String]$DisplayName)
    {
        $Return = $This.Reference | ? DisplayName -eq $DisplayName
        If (!$Return)
        {
            Return $Null
        }
        Else
        {
            Return $Return
        }
    }
    [Object] GetShaderFile([Object]$Reference)
    {
        $Return = $This.Shader.File | ? Shader -eq $Reference.Shader
        If (!$Return)
        {
            Return $Null
        }
        Else
        {
            Return $Return
        }
    }
    [Object] GetShaderItem([Object]$File,[Object]$Reference)
    {
        $Return = $File.Output | ? DisplayName -eq $Reference.DisplayName
        If (!$Return)
        {
            Return $Null
        }
        Else
        {
            Return $Return
        }
    }
    [Object] GetShaderItem([Object]$Reference)
    {
        $File = $This.Shader.File | ? Shader -eq $Reference.Shader
        If ($File)
        {
            $Return = $File.Output | ? DisplayName -eq $Reference.DisplayName
            If (!$Return)
            {
                Return $Null
            }
            Else
            {
                Return $Return
            }
        }
        Else
        {
            Return $Null
        }
    }
    [Object] GetTextureFile([Object]$Reference)
    {
        $Filter = Switch ($Reference.GetType())
        {
            String  { $Reference }
            Default { $Reference.DisplayName }
        }

        $Return = $This.Texture.File | ? Reference -eq $Filter
        If (!$Return)
        {
            Return $Null
        }
        Else
        {
            Return $Return
        }
    }
    CheckReference([Object]$Resource,[Object]$Reference)
    {
        $xMap             = $This

        [Console]::WriteLine("Checking [~] $($Reference.DisplayName)")

        $xTextureFile     = $xMap.GetTextureFile($Reference)
        $xShaderFile      = $xMap.GetShaderFile($Reference)
        $xShaderItem      = $xMap.GetShaderItem($Reference)

        $yTextureFile     = $Resource.GetTextureFile($Reference.DisplayName)
        $yShaderFile      = $Resource.GetShaderFile($Reference)
        $yShaderItem      = $Resource.GetShaderItem($Reference)

        # // Texture and shader exists (Shader)
        If (($xTextureFile -and $xShaderItem) -or ($yTextureFile -and $yShaderItem))
        {
            # Reference
            $Reference.IsTexture       = 1
            $Reference.IsShader        = 1

            If ($xTextureFile -and $xShaderItem)
            {
                # Texture File
                $xTextureFile.IsReferenced = 1

                # Shader File/Item
                $xShaderFile.IsReferenced  = 1

                $xShaderItem.IsReferenced  = 1
                $xShaderItem.IsTexture     = 1
            }
            If ($yTextureFile -and $yShaderItem)
            {
                # Texture File
                $yTextureFile.IsReferenced = 1

                # Shader File/Item
                $yShaderFile.IsReferenced  = 1

                $yShaderItem.IsReferenced  = 1
                $yShaderItem.IsTexture     = 1
            }
        }

        # // Texture exists, shader doesn't (Texture)
        If (($xTextureFile -and !$xShaderItem) -or ($yTextureFile -and !$yShaderItem))
        {
            # Reference
            $Reference.IsTexture       = 1

            If ($xTextureFile)
            {
                # Texture file
                $xTextureFile.IsReferenced = 1
            }

            If ($yTextureFile)
            {
                # Texture file
                $yTextureFile.IsReferenced = 1
            }

            # Shader File/Item $Null
        }

        # // Texture doesn't exist, shader does (Virtual)
        If ((!$xTextureFile -and $xShaderItem) -or (!$yTextureFile -and $yShaderItem))
        {
            # Reference
            $Reference.IsShader        = 1
            $Reference.IsVirtual       = 1

            # Texture file $Null

            If ($xShaderItem)
            {
                # Shader File/Item
                $xShaderFile.IsReferenced  = 1
                $xShaderItem.IsVirtual     = 1
            }
            If ($yShaderItem)
            {
                # Shader File/Item
                $yShaderFile.IsReferenced  = 1
                $yShaderItem.IsVirtual     = 1
            }
        }

        # // Neither texture or shader exist (Missing)
        If ((!$xTextureFile -and !$xShaderItem) -and (!$yTextureFile -and !$yShaderItem))
        {
            # Reference
            $Reference.IsMissing = 1

            # Texture file $Null
        
            # Shader File/Item $Null
        }

        # // If source shader item exists => Process subshaders
        If ($xShaderItem)
        {
            # Process Skybox
            $Skybox = $xShaderItem.Content | ? Line -match "skyparms textures"
            If ($Skybox)
            {
                $xTexture = [Regex]::Matches($Skybox.Line,"textures[^ ]+").Value
                If ($xTexture)
                {
                    $xTexture = $xTexture.Replace("textures/","")
                
                    ForEach ($Flag in "bk","dn","ft","lf","rt","up")
                    {
                        $xReference = $xMap.GetTextureFile("$xTexture`_$Flag")
                        $xReference.IsReferenced = 1
                        $xReference.IsSubshader  = 1
                    }
                }
            }
        
            ForEach ($Subshader in $xShaderItem.Subshader | ? IsDefault -eq 0)
            {
                $xSubShaderTexture = $xMap.GetTextureFile($Subshader.DisplayName)
                If ($xSubshaderTexture)
                {
                    $xReference    = $xMap.GetReference($Subshader.DisplayName)
                    If ($xReference)
                    {
                        $xReference.IsSubshader = 1
                    }

                    $xSubshaderTexture.IsReferenced = 1
                    $xSubshaderTexture.IsSubshader  = 1
                }
            }
        }

        # // If reference shader exists => Process subshaders
        If ($yShaderItem)
        {
            # Process Skybox
            $Skybox = $yShaderItem.Content | ? Line -match "skyparms textures"
            If ($Skybox)
            {
                $yTexture = [Regex]::Matches($Skybox.Line,"textures[^ ]+").Value
                If ($yTexture)
                {
                    $yTexture = $yTexture.Replace("textures/","")
                
                    ForEach ($Flag in "bk","dn","ft","lf","rt","up")
                    {
                        $yReference = $Resource.GetTextureFile("$yTexture`_$Flag")
                        $yReference.IsReferenced = 1
                        $yReference.IsSubshader  = 1
                    }
                }
            }
        
            ForEach ($Subshader in $yShaderItem.Subshader | ? IsDefault -eq 0)
            {
                $ySubShaderTexture = $Resource.GetTextureFile($Subshader.DisplayName)
                If ($ySubshaderTexture)
                {
                    $yReference = $xMap.GetReference($Subshader.DisplayName)
                    If ($yReference)
                    {
                        $yReference.IsSubshader = 1
                    }

                    $ySubshaderTexture.IsReferenced = 1
                    $ySubshaderTexture.IsSubshader  = 1
                }
            }
        }
    }
    QueryReferenceList([Object]$Resource)
    {
        $Default = $This.DefaultShaders()
        ForEach ($Reference in $This.Reference)
        {
            If ($Reference.Shader -in $Default)
            {
                $Reference.IsDefault = 1
            }
            Else
            {
                $This.CheckReference($Resource,$Reference)
            }
        }
    }
    [Object[]] GetReferencedShaders()
    {
        Return $This.Shader.File | ? IsReferenced
    }
    [Object[]] GetReferencedTextures()
    {
        Return $This.Texture.File | ? IsReferenced
    }
    GetArena()
    {
        <#
        $This.Arena    = $This.Q3ALiveArena($This.Scripts("arena"))
        #>
    }
    GetLevelshot()
    {
        <#
        $This.Levelshot = $This.Q3ALiveMapLevelshot($xName,$xLevelshot)
        #>
    }
    SetProperty([String]$Source)
    {
        <#
        $xLevelshot     = $This.Output | ? Name -match "levelshots\\\w+\.(jpg|tga|png)"
        If (!$xLevelshot)
        {
            $xLevelshot = "{0}\levelshots\{1}.jpg" -f $This.Path, $This.Name
        }

        $xName          = $xLevelshot | Split-Path -Leaf

        $This.Levelshot = $This.Q3ALiveMapLevelshot($xName,$xLevelshot)

        Return $This.Levelshot
        #>
    }
    SetArena([String[]]$Script)
    {
        <#
        $This.Arena.Populate($Script)
        #>
    }
    SetShader([String[]]$Script)
    {
        <#
        $This.Shader.Populate($Script)
        #>
    }
    SetLevelshot([String]$Path)
    {
        <#
        If (![System.IO.File]::Exists($Path))
        {
            Throw "Exception [!] Invalid path"
        }

        $Extension  = $Path.Split(".")[-1]
        $xLevelshot = "{0}\levelshots\{1}.{2}" -f $This.Path, $This.Name, $Extension

        [System.IO.File]::Copy($Path,$xLevelshot,$True)

        If (![System.IO.File]::Exists($xLevelshot))
        {
            [Console]::WriteLine("Exception [!] Levelshot not detected")
        }
        Else
        {
            [Console]::WriteLine("Levelshot [+] $xLevelshot")

            $Magick = $This.GetImageMagick()
            If (!$Magick)
            {
                Throw "Exception [!] Unable to make preview image, ImageMagick required"
            }
            Else
            {
                $xPath   = "{0}\levelshots\preview" -f $This.Map.Path, $This.Map.Name
                $xTarget = "$xPath\{0}.jpg" -f $This.Map.Name

                If (![System.IO.Directory]::Exists($xPath))
                {
                    [System.IO.Directory]::CreateDirectory($xPath) > $Null
                }

                $Param = "convert `"$xLevelshot`" -resize 256x256! `"$xTarget`""

                Start-Process -FilePath $Magick -ArgumentList $Param -NoNewWindow -Wait

                If (![System.IO.File]::Exists($xTarget))
                {
                    [Console]::WriteLine("Exception [!] Unable to create preview image")
                }
                Else
                {
                    [Console]::WriteLine("Complete [+] Preview image")
                }
            }
        }
        #>
    }
    [String[]] AssetTypes()
    {
        Return [System.Enum]::GetNames([Q3ALive.AssetType])
    }
    [String[]] DefaultShaders()
    {
        Return [System.Enum]::GetNames([Q3ALive.DefaultShadersType])
    }
    [Object] Q3ALiveAssignmentEditFileLine([UInt32]$Index,[String]$Line)
    {
        Return [Q3ALiveAssignmentEditFileLine]::New($Index,$Line)
    }
    [Object] Q3ALiveAssignmentEditReference([UInt32]$Index,[String]$DisplayName)
    {
        Return [Q3ALiveAssignmentEditReference]::New($Index,$DisplayName)
    }
    [Object] Q3ALiveAssignmentEditProperty()
    {
        Return [Q3ALiveAssignmentEditProperty]::New()
    }
    [Object] Q3ALiveAssignmentEditSourceDirectory([String]$Type,[String]$Fullname)
    {
        Return [Q3ALiveAssignmentEditSourceDirectory]::New($Type,$Fullname)
    }
    [Object] Q3ALiveAssignmentEditAssetEntry([UInt32]$Index,[Object]$File)
    {
        Return [Q3ALiveAssignmentEditAssetEntry]::New($Index,$File)
    }
    [Object] Q3ALiveAssignmentEditSourceArena([Object]$Asset)
    {
        Return [Q3ALiveAssignmentEditSourceArena]::New($Asset)
    }
    [Object] Q3ALiveAssignmentEditItemDirectory([String]$Type,[String]$Fullname)
    {
        Return [Q3ALiveAssignmentEditItemDirectory]::New($Type,$Fullname)
    }
    [Object] Q3ALiveAssignmentEditItemArchive([String]$Name,[String]$Fullname)
    {
        Return [Q3ALiveAssignmentEditItemArchive]::New($Name,$Fullname)
    }
    [Object] Q3ALiveShaderFileList([String]$Type)
    {
        Return [Q3ALiveShaderFileList]::New($Type)
    }
    [Object] Q3ALiveTextureFileList([String]$Type)
    {
        Return [Q3ALiveTextureFileList]::New($Type)
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
        Return "<Q3ALive.Assignment.Edit.Item>"
    }
}

Class Q3ALiveAssignmentEditItemList
{
    [Object] $Output
    Q3ALiveAssignmentEditItemList()
    {
        $This.Clear()
    }
    Clear()
    {
        $This.Output = @( )
    }
    Assign([Object[]]$Selected)
    {
        $This.Clear()

        ForEach ($Item in $Selected)
        {
            $This.Output += $This.Q3ALiveAssignmentEditItem($This.Output.Count,$Item)
        }
    }
    SetSelected([UInt32]$Index)
    {
        If ($Index -in $This.Output.Index)
        {
            ForEach ($Item in $This.Output)
            {
                $Item.Selected = $Item.Index -eq $Index
            }
        }
    }
    [Object] Current()
    {
        Return $This.Output | ? Selected
    }
    [Object] Q3ALiveAssignmentEditItem([UInt32]$Index,[Object]$AssignmentItem)
    {
        Return [Q3ALiveAssignmentEditItem]::New($Index,$AssignmentItem)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Assignment.Edit.List>"
    }
}

<#
    ____    ____________________________________________________________________________________________________        
   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
   \\__//¯¯¯ Controller [~]                                                                                 ___//¯¯\\   
    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
#>

Class Q3ALiveController
{
    [Object]     $Module # Fighting Entropy module (manages logging for console)
    [Object]       $Xaml # GUI I/O (Xaml controls)
    [Object]  $Threading # Thread controls for managing responsiveness in UI
    [Object]      $Audio # Audio controller
    [Object]   $Resource # Resource (dependencies + main logging)
    [Object]   $Registry # Registry (generates and manages persistent keys + properties)
    [Object] $Dependency # Various tools (some required)
    [Object]  $Component # Quake III Arena/Quake Live (could possibly accommodate other games)
    [Object]    $Radiant # Specifically controls Radiant
    [Object]  $Workspace # Source assets (handles archive logging)
    [Object] $Assignment # Used to orchestrate tasks related to selection and management of compilation and assets
    [Object]    $Compile # All of the options for compiling a particular map or array of maps
    [Object]      $Asset # Manages and handles all of the map assets to publish a single map, or multiple
    [Object]      $Steam # Manages the interactions with steamcmd.exe to publish work to the Steam Workshop
    Q3ALiveController()
    {
        # // Creates an instance of the module
        $This.Module = Get-FEModule -Mode 1
        $This.Module.Console.Reset()
        $This.Module.Console.Initialize()
    }
    Q3ALiveController([Object]$Module)
    {
        # // Accepts and assigns an instance of the module
        $This.Module = $Module
        $This.Module.Console.Reset()
        $This.Module.Console.Initialize()
    }
    Update([Int32]$State,[String]$Status)
    {
        # // Updates the console
        $This.Module.Update($State,$Status)
        If ($This.Module.Mode -ne 0)
        {
            $xStatus = $This.Module.Console.Last()

            # // Adds the item to GUI console
            If ($This.Xaml.IO.ConsoleOutput)
            {
                $This.Xaml.IO.ConsoleOutput.Items.Add($xStatus)
            }

            [Console]::WriteLine($xStatus)
        }
    }
    DumpConsole()
    {
        $Ctrl = $This

        $xPath = "{0}\{1}.log" -f $Ctrl.LogPath(), $Ctrl.Module.Console.Start.Time.ToString("yyyy_MMdd-HHmmss")
        $Ctrl.Update(100,"[+] Dumping console: [$xPath]")
        $Ctrl.Module.Console.Finalize()
        
        $Value = $Ctrl.Module.Console.Output | % ToString

        [System.IO.File]::WriteAllLines($xPath,$Value)
    }
    GetFEModule()
    {
        $This.Module   = $This.FEModule()
    }
    GetXaml()
    {
        $This.Update(0,"Loading [~] Xaml")
        $This.Xaml     = $This.Q3ALiveXaml()
    }
    GetThreading()
    {
        $This.Update(0,"Loading [~] Threading")
        $This.Threading = $This.Q3ALiveThreadingService()
    }
    GetAudio()
    {
        $This.Update(0,"Loading [~] Audio")
        $This.Audio     = $This.Q3ALiveAudioController()
    }
    GetResource([String]$Resource)
    {
        # // Check if a valid path entered
        If ($This.CheckPathChars($Resource) -gt 0)
        {
            $This.Update(0,"Exception [!] Resource: [$Resource] contains invalid chars")
            Throw $This.Module.Console.Last().Status
        }

        Else
        {
            # // Check if parent path exists
            $Parent = $Resource | Split-Path -Parent
            If (![System.IO.Directory]::Exists($Parent))
            {
                [System.IO.Directory]::CreateDirectory($Parent) > $Null
            }

            # // Detect/Create the resource path + object
            $Message = @("Creating","Detected")[[UInt32]!![System.IO.Directory]::Exists($Resource)]

            $This.Update(0,"$Message [+] Resource: [$Resource]")

            $This.Resource = $This.Q3ALiveResourceRoot($Resource)
        }
    }
    GetRegistry([String]$Registry)
    {
        # // Check if a valid path
        If ($This.CheckPathChars($Registry) -gt 0)
        {
            $This.Update(0,"Exception [!] Registry: [$Registry] contains invalid chars")
            Throw $This.Module.Console.Last().Status
        }

        Else
        {
            # // Check if parent path exists
            $Parent = $Registry | Split-Path -Parent
            If (!(Test-Path $Parent -EA 0))
            {
                New-Item $Parent -EA 0
            }

            # // Detect/Create the registry path + object
            $Message = @("Creating","Detected")[[UInt32]!!(Test-Path $Registry)]

            $This.Update(0,"$Message [+] Resource: [$Registry]")

            # // Create the registry path + properties
            $This.Registry = $This.Q3ALiveRegistryBase($Registry)
            $This.Registry.Refresh()
        }
    }
    GetConfig()
    {
        $Ctrl          = $This

        $Item          = Get-ItemProperty $Ctrl.DefaultUninstallPath() -EA 0
        If (!$Item)
        {
            If ($Ctrl.Xaml)
            {
                $Ctrl.Xaml.IO.ConfigInstall.IsEnabled   = 1
                $Ctrl.Xaml.IO.ConfigUninstall.IsEnabled = 0
            }
        }
        If (!!$Item)
        {
            If ($Ctrl.Xaml)
            {
                $Ctrl.Xaml.IO.ConfigInstall.IsEnabled   = 0
                $Ctrl.Xaml.IO.ConfigUninstall.IsEnabled = 1
            }

            $Ctrl.GetResource($Item.InstallLocation)
            $Ctrl.GetRegistry($Item.RegistryPath)
        }
    }
    GetDependency()
    {
        $This.Update(0,"Dependency [~] <List>")

        $This.Dependency = $This.Q3ALiveDependencyList()
        $This.Dependency.Assign($This.DefaultDependencyPath())
    }
    GetComponent()
    {
        $This.Update(0,"Component [~] <List>")

        $This.Component = $This.Q3ALiveComponentList()
    }
    GetRadiant()
    {
        $This.Update(0,"Radiant [~] <List>")
        
        $This.Radiant = $This.Q3ALiveRadiantList()
    }
    GetWorkspace()
    {
        $This.Update(0,"Workspace [~] <Workspace>")

        $This.Workspace = $This.Q3ALiveWorkspace()
    }
    GetAssignment()
    {
        $This.Update(0,"Assignment [~] <List>")

        $This.Assignment          = $This.Q3ALiveAssignmentSelectFileList()
        $This.Assignment.Resource = $This.Q3ALiveAssignmentResourceList()
        $This.Assignment.Edit     = $This.Q3ALiveAssignmentEditItemList()
    }
    ConfigInstall()
    {
        $Ctrl    = $This

        $Item    = Get-Item $Ctrl.DefaultUninstallPath() -EA 0
        If ($Item)
        {
            $Ctrl.Update(0,"Exception [+] $($Ctrl.ProjectName()) already installed, loading")

            $Ctrl.ConfigRefresh()
        }
        If (!$Item)
        {
            $Ctrl.Update(0,"Installing [~] $($Ctrl.ProjectName())")

            New-Item -Path $Ctrl.DefaultUninstallPath() -Verbose

            If (!!(Test-Path $Ctrl.DefaultUninstallPath()))
            {
                $Ctrl.Update(0,"$($Ctrl.ProjectName()) [+] Uninstall -> $($Ctrl.DefaultUninstallPath())")

                ForEach ($Name in [System.Enum]::GetNames([Q3ALive.RegistryInstallType]))
                {
                    $Value = Switch ($Name)
                    {
                        DisplayName     { $Ctrl.ProjectName()         }
                        DisplayIcon     { $Ctrl.DefaultIcon()         }
                        Publisher       { $Ctrl.CompanyName()         }
                        DisplayVersion  { $Ctrl.DefaultVersion()      }
                        InstallLocation { $Ctrl.DefaultResourcePath() }
                        RegistryPath    { $Ctrl.DefaultRegistryPath() }
                        UninstallString { "<not set>"                 }
                    }

                    Set-ItemProperty -Path $Ctrl.DefaultUninstallPath() -Name $Name -Value $Value -Verbose
                }

                $Ctrl.ConfigRefresh()
            }
        }
    }
    ConfigUninstall()
    {
        $Ctrl    = $This

        $Item    = Get-Item $Ctrl.DefaultUninstallPath() -EA 0
        If (!$Item)
        {
            $Ctrl.Update(0,"Exception [+] $($Ctrl.ProjectName()) not installed")
        }
        If (!!$Item)
        {
            $Ctrl.Update(0,"Uninstalling [~] $($Ctrl.ProjectName())")

            # // Resource path
            If (Test-Path $Item.GetValue("InstallLocation"))
            {
                $Ctrl.Update(0,"Removing [-] Resource: $($Item.GetValue("InstallLocation"))")
                Remove-Item $Item.GetValue("InstallLocation") -Recurse -Force -Verbose -EA 0
            }

            # // Registry Path
            If (Test-Path $Item.GetValue("RegistryPath"))
            {
                $Ctrl.Update(0,"Removing [-] Registry: $($Item.InstallLocation)")
                Remove-Item $Item.GetValue("RegistryPath") -Recurse -Force -Verbose -EA 0
            }

            # // Uninstall Key
            $Ctrl.Update(0,"Removing [-] Uninstall: $($Ctrl.DefaultUninstallPath())")
            Remove-Item $Ctrl.DefaultUninstallPath() -Recurse -Force -Verbose -EA 0
        }
    }
    ConfigUninstallPrompt()
    {
        $Ctrl     = $This

        $Message  = "Are you sure you want to uninstall Q3A-Live and remove all files?"
    
        $Ctrl.Update(0,"Prompt [~] $Message")
        Switch ([System.Windows.Forms.MessageBox]::Show($Message,"Confirm","YesNo"))
        {
            Yes
            {
                $Ctrl.Update(0,"Prompt [+] Uninstalling $($Ctrl.ProjectName())")
                $Ctrl.ConfigUninstall()
                $Ctrl.ConfigRefresh()
            }
            No
            {
                $Ctrl.Update(0,"Prompt [_] Uninstall cancelled")
                $Ctrl.ConfigRefresh()
            }
        }
    }
    ConfigScan()
    {
        $Ctrl           = $This

        $Ctrl.Update(0,"Scanning [~] (Components [Q3A/Live] + Dependencies [7zip/ImageMagick])")

        # // Check the registry for installed apps
        $Hash           = @{ }
        $Filter         = "(^Quake III Arena$|^Quake Live|^7-Zip|^ImageMagick)"

        ForEach ($Item in $Ctrl.UninstallPath_x86_64() | % { Get-ItemProperty "$_\*" } | ? DisplayName -match $Filter)
        {
            $Hash.Add($Hash.Count,$Ctrl.Q3ALiveRegistryUninstall($Hash.Count,$Item))
        }

        $Uninstall     = $Hash[0..($Hash.Count-1)]

        $Hash = @{ 

            # // Dependency
            Zip        = $Ctrl.Registry.Dependency.Property | ? Name -eq 7Zip
            Magick     = $Ctrl.Registry.Dependency.Property | ? Name -eq ImageMagick

            # // Component
            Q3A        = $Ctrl.Registry.Component.Property  | ? Name -eq Q3A
            Live       = $Ctrl.Registry.Component.Property  | ? Name -eq Live
        }

        # // 7Zip (Detection/Component)
        If (!$Hash.Zip.Valid)
        {
            $7Zip = $Uninstall | ? DisplayName -eq "7-Zip"
                
            If (!!$7Zip)
            {
                $Path = $7Zip.InstallLocation

                If ($Ctrl.CheckDirectory($Path) -and "7z.exe" -in $Ctrl.GetFiles($Path).Name)
                {
                    $Hash.Zip.Value = $Path
                    $Hash.Zip.Apply()

                    $Ctrl.Update(0,"Found [+] 7-Zip: $Path")
                }
                Else
                {
                    $Ctrl.Update(0,"Exception [!] <7-Zip path invalid>")
                }
            }
            Else
            {
                $Ctrl.Update(0,"Exception [!] <7-Zip not found>")
            }
        }

        # // ImageMagick (Detection/Component)
        If (!$Hash.Magick.Valid)
        {
            
            $Magick = $Uninstall | ? DisplayName -eq "ImageMagick"
            
            If (!!$Magick)
            {
                $Path = $Magick.InstallLocation
                If ($Ctrl.CheckDirectory($Path) -and "magick.exe" -in $Ctrl.GetFiles($Path).Name)
                {
                    $Hash.Magick.Value = $Path
                    $Hash.Magick.Apply()

                    $Ctrl.Update(0,"Found [+] ImageMagick: $Path")
                }
                Else
                {
                    $Ctrl.Update(0,"Exception [!] <ImageMagick path invalid>")
                }
            }
            Else
            {
                $Ctrl.Update(0,"Exception [!] <ImageMagick not found>")
            }
        }

        # // Q3A (Detection/Component)
        If (!$Hash.Q3A.Valid)
        {
            $Q3A = $Uninstall | ? DisplayName -eq "Quake III Arena"
            If ($Q3A)
            {
                $Path = $Q3A.InstallLocation

                If ($Ctrl.CheckDirectory($Path) -and "quake3.exe" -in $Ctrl.GetFiles($Path).Name)
                {
                    $Hash.Q3A.Value = $Path
                    $Hash.Q3A.Apply()

                    $Ctrl.Update(0,"Found [+] Quake III Arena: $Path")
                }
                Else
                {
                    $Ctrl.Update(0,"Exception [!] <Quake III Arena path invalid>")
                }
            }
            Else
            {
                $Ctrl.Update(0,"Exception [!] <Quake III Arena not found>")
            }
        }

        # // Live
        If (!$Hash.Live.Valid)
        {
            $Live = $Uninstall | ? DisplayName -eq "Quake Live"
                    
            If (!!$Live)
            {
                $Path = $Live.InstallLocation

                If ($Ctrl.CheckDirectory($Path) -and "quakelive_steam.exe" -in $Ctrl.GetFiles($Path).Name)
                {
                    $Hash.Live.Value = $Path
                    $Hash.Live.Apply()

                    $Ctrl.Update(0,"Found [+] Quake Live: $Path")
                }
                Else
                {
                    $Ctrl.Update(0,"Exception [!] <Quake Live path invalid>")
                }
            }
            Else
            {
                $Ctrl.Update(0,"Exception [!] <Quake Live not found>")
            }
        }

        $Ctrl.Update(1,"Completed [+] Scan")
    }
    ConfigRefresh()
    {
        $Ctrl    = $This

        $Ctrl.Update(0,"Refreshing [~] Configuration")
        
        $Root    = Get-Item $Ctrl.DefaultUninstallPath() -EA 0

        If (!$Ctrl.Resource)
        {
            $Ctrl.GetResource($Root.GetValue("InstallLocation"))
        }
        If (!$Ctrl.Registry)
        {
            $Ctrl.GetRegistry($Root.GetValue("RegistryPath"))
        }

        $Ctrl.Resource.Refresh()
        $Ctrl.Registry.Refresh()
        $Ctrl.Dependency.Refresh()

        # // Must do the same with the surrounding properties/classes, staging/priming = first pass, refresh = population
        $Ctrl.Component.Stage()
        
        $Ctrl.Radiant.Refresh()

        # // Determine whether the registry settings are valid
        $Hash          = @{ 

            # // Settings =========================================================
            Workspace  = $Ctrl.Registry.Settings.Property | ? Name -eq Workspace
            Credential = $Ctrl.Registry.Settings.Property | ? Name -eq Credential
            Workshop   = $Ctrl.Registry.Settings.Property | ? Name -eq Workshop

            # // Dependency =====================================================
            Zip        = $Ctrl.Registry.Dependency.Property | ? Name -eq 7Zip
            Magick     = $Ctrl.Registry.Dependency.Property | ? Name -eq ImageMagick
            ASE        = $Ctrl.Registry.Dependency.Property | ? Name -eq Q3ASE
            Steam      = $Ctrl.Registry.Dependency.Property | ? Name -eq Steam

            # // Component ====================================================
            Q3A        = $Ctrl.Registry.Component.Property  | ? Name -eq Q3A
            Live       = $Ctrl.Registry.Component.Property  | ? Name -eq Live

            # // Radiant ==========================================================
            Gtk        = $Ctrl.Registry.Radiant.Property | ? Name -eq GtkRadiant
            Net        = $Ctrl.Registry.Radiant.Property | ? Name -eq NetRadiant
            Garux      = $Ctrl.Registry.Radiant.Property | ? Name -eq "NetRadiant-Custom"
        }

        # // [Dependency]
        # // 7-Zip Detection/Component
        Switch ($Hash.Zip.Valid)
        {
            0
            {
                $Ctrl.Update(0,"Exception [!] <7-Zip not found>")
            }
            1
            {
                $Path = $Hash.Zip.Value

                $Ctrl.Dependency.Assign("7Zip",$Path,"7z.exe")

                $Ctrl.Update(0,"Dependency [+] 7-Zip: [$Path]")
            }
        }

        # // ImageMagick
        Switch ($Hash.Magick.Valid)
        {
            0
            {
                $Ctrl.Update(0,"Exception [!] <ImageMagick not found>")
            }
            1
            {
                $Path = $Hash.Magick.Value

                $Ctrl.Dependency.Assign("ImageMagick",$Path,"magick.exe")

                $Ctrl.Update(0,"Dependency [+] ImageMagick: [$Path]")
            }
        }

        # // Q3ASE
        If ($Hash.ASE.Valid)
        {
            $Path = $Hash.ASE.Value

            $Ctrl.Dependency.Assign("Q3ASE",$Path,"q3ase.exe")

            $Ctrl.Update(0,"Dependency [+] Q3ASE: [$Path]")
        }

        # // Steam
        If ($Hash.Steam.Valid)
        {
            $Path = $Hash.Steam.Value

            $Ctrl.Dependency.Assign("Steam",$Path,"steamcmd.exe")

            $Ctrl.Update(0,"Dependency [+] Steam: [$Path]")
        }

        # // [Component]
        # // Q3A
        Switch ($Hash.Q3A.Valid)
        {
            0
            {
                $Ctrl.Update(0,"Exception [!] <Quake III Arena not found>")
            }
            1
            {
                $Ctrl.Component.Assign("Q3A",$Hash.Q3A.Value)

                $Ctrl.Update(0,"Component [+] Quake III Arena: [$($Hash.Q3A.Value)]")
            }
        }

        # // Live
        Switch ($Hash.Live.Valid)
        {
            0
            {
                $Ctrl.Update(0,"Exception [!] <Quake Live not found>")
            }
            1
            {
                $Ctrl.Component.Assign("Live",$Hash.Live.Value)

                $Ctrl.Update(0,"Component [+] Quake Live: [$($Hash.Live.Value)]")
            }
        }

        # // [Radiant]
        # // GtkRadiant
        If ($Hash.Gtk.Valid)
        {
            $Path = $Hash.Gtk.Value

            $Ctrl.Dependency.Assign("GtkRadiant",$Path,"radiant.exe")

            $Ctrl.Radiant.Assign("GtkRadiant",$Path)

            $Ctrl.Update(0,"Radiant [+] GtkRadiant: [$Path]")
        }

        # // NetRadiant
        If ($Hash.Net.Valid)
        {
            $Path = $Hash.Net.Value

            $Ctrl.Dependency.Assign("NetRadiant",$Path,"netradiant.exe")

            $Ctrl.Radiant.Assign("NetRadiant",$Path)

            $Ctrl.Update(0,"Radiant [+] NetRadiant: [$Path]")
        }

        # // NetRadiant-Custom
        If ($Hash.Garux.Valid)
        {
            $Path = $Hash.Garux.Value

            $Ctrl.Dependency.Assign("NetRadiant-Custom",$Path,"radiant.exe")

            $Ctrl.Radiant.Assign("NetRadiant-Custom",$Path)

            $Ctrl.Update(0,"Radiant [+] NetRadiant-Custom: [$Path]")
        }

        # // [Settings]
        # // Workspace
        If ($Hash.Workspace.Valid -and $Ctrl.Workspace.Fullname -ne $Hash.Workspace.Value)
        {
            $Path = $Hash.Workspace.Value

            $Ctrl.Update(0,"Workspace [~] Loading: [$Path]")

            $Ctrl.Workspace.Assign($Path)

            $Ctrl.Update(0,"Workspace [+] <Loaded>")
        }

        # // Credential
        # // Workshop

        If ($Root)
        {
            # // Xaml
            If ($Ctrl.Xaml)
            {
                # // Config
                $Ctrl.Xaml.IO.ConfigInstall.IsEnabled   = 0
                $Ctrl.Xaml.IO.ConfigUninstall.IsEnabled = 1

                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigResource,$Ctrl.Resource)
                
                $Ctrl.Xaml.IO.ConfigRegistryPathText.Text = $Ctrl.Registry.Fullname

                $Ctrl.ConfigProperty()
                
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigSettings,   $Ctrl.Registry.Settings.Property)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigDependency, $Ctrl.Registry.Dependency.Property)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigComponent,  $Ctrl.Registry.Component.Property)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigRadiant,    $Ctrl.Registry.Radiant.Property)

                # // Components
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentOutput,  $Ctrl.Component.Output)
                $Ctrl.Reset($Ctrl.Xaml.IO.RadiantOutput,    $Ctrl.Radiant.Output)
                $Ctrl.Reset($Ctrl.Xaml.IO.DependencyOutput, $Ctrl.Dependency.Output)

                # // Workspace
                If ([System.IO.Directory]::Exists($Ctrl.Workspace.Fullname))
                {
                    $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceProperty,$Ctrl.Workspace)

                    # // Log
                    $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceLogProperty,$Ctrl.Workspace.Log)
                    $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceLogOutput,$Ctrl.Workspace.Log.Output)

                    # // Output
                    If ($Ctrl.Workspace.Output -eq 0)
                    {
                        $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceOutput,$Null)
                    }
                    Else
                    {
                        $Ctrl.Xaml.IO.WorkspaceOutputRefresh.IsEnabled = 1
                        $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceOutput,$Ctrl.Workspace.Output)
                    }
                }
                # // Assignment (gonna have to clean this up later.)
                If (!!$Ctrl.Registry.Map)
                {
                    $Ctrl.Xaml.IO.AssignmentSelectPathText.Text = $Ctrl.Registry.Map
                }
            }
        }
        If (!$Root)
        {
            $Ctrl.Resource = $Null
            $Ctrl.Registry = $Null

            If ($Ctrl.Xaml)
            {
                # // Config
                $Ctrl.Xaml.IO.ConfigInstall.IsEnabled   = 1
                $Ctrl.Xaml.IO.ConfigUninstall.IsEnabled = 0

                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigResource,$Null)

                $Ctrl.Xaml.IO.ConfigRegistryPathText.Text = "<not installed>"

                $Ctrl.ConfigProperty()

                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigSettings,       $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigDependency,     $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigComponent,      $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigRadiant,        $Null)

                # // Component
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentOutput,      $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBase,        $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBasePackage, $Null)

                $Ctrl.Reset($Ctrl.Xaml.IO.DependencyOutput,     $Null)

                # // Workspace
                $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceProperty,    $Null)

                # // Log
                $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceLogProperty, $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceLogOutput,   $Null)

                # // Output
                $Ctrl.Xaml.IO.WorkspaceOutputRefresh.IsEnabled = 0
                $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceOutput,      $Null)
            }
        }
    }
    ConfigComponent()
    {
        $Ctrl = $This

        $Ctrl.ConfigProperty()

        $Ctrl.Xaml.IO.ConfigSettings.SelectedIndex   = -1
        $Ctrl.Xaml.IO.ConfigRadiant.SelectedIndex    = -1
        $Ctrl.Xaml.IO.ConfigDependency.SelectedIndex = -1

        If ($Ctrl.Xaml.IO.ConfigComponent.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.ConfigComponent.SelectedItem
            
            $Ctrl.Xaml.IO.ConfigPropertyNameText.Text       = $Item.Name
            $Ctrl.Xaml.IO.ConfigPropertyValueText.Text      = $Item.Value

            $Ctrl.Xaml.IO.ConfigPropertyValueText.IsEnabled = [UInt32]($Item.Name -notin $Ctrl.Registry.BaseTypes())
            $Ctrl.Xaml.IO.ConfigPropertyValueIcon.Source    = $Ctrl.IconStatus($Item.Valid)
            $Ctrl.Xaml.IO.ConfigPropertyBrowse.IsEnabled    = [UInt32]($Item.Name -notin $Ctrl.Registry.BaseTypes())
            $Ctrl.Xaml.IO.ConfigPropertyApply.IsEnabled     = 0
        }
    }
    ConfigSettings()
    {
        $Ctrl = $This

        $Ctrl.Xaml.IO.ConfigComponent.SelectedIndex  = -1
        $Ctrl.Xaml.IO.ConfigRadiant.SelectedIndex    = -1
        $Ctrl.Xaml.IO.ConfigDependency.SelectedIndex = -1

        $Ctrl.ConfigProperty()

        If ($Ctrl.Xaml.IO.ConfigSettings.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.ConfigSettings.SelectedItem
            
            $Ctrl.Xaml.IO.ConfigPropertyNameText.Text       = $Item.Name
            $Ctrl.Xaml.IO.ConfigPropertyValueText.Text      = $Item.Value

            $Ctrl.Xaml.IO.ConfigPropertyValueText.IsEnabled = [UInt32]($Item.Name -notin $Ctrl.Registry.BaseTypes())
            $Ctrl.Xaml.IO.ConfigPropertyValueIcon.Source    = $Ctrl.IconStatus($Item.Valid)
            $Ctrl.Xaml.IO.ConfigPropertyBrowse.IsEnabled    = [UInt32]($Item.Name -notin $Ctrl.Registry.BaseTypes())
            $Ctrl.Xaml.IO.ConfigPropertyApply.IsEnabled     = 0
        }
    }
    ConfigRadiant()
    {
        $Ctrl = $This

        $Ctrl.Xaml.IO.ConfigComponent.SelectedIndex  = -1
        $Ctrl.Xaml.IO.ConfigSettings.SelectedIndex   = -1
        $Ctrl.Xaml.IO.ConfigDependency.SelectedIndex = -1

        $Ctrl.ConfigProperty()

        If ($Ctrl.Xaml.IO.ConfigRadiant.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.ConfigRadiant.SelectedItem
            
            $Ctrl.Xaml.IO.ConfigPropertyNameText.Text       = $Item.Name
            $Ctrl.Xaml.IO.ConfigPropertyValueText.Text      = $Item.Value

            $Ctrl.Xaml.IO.ConfigPropertyValueText.IsEnabled = [UInt32]($Item.Name -notin $Ctrl.Registry.BaseTypes())
            $Ctrl.Xaml.IO.ConfigPropertyValueIcon.Source    = $Ctrl.IconStatus($Item.Valid)
            $Ctrl.Xaml.IO.ConfigPropertyBrowse.IsEnabled    = [UInt32]($Item.Name -notin $Ctrl.Registry.BaseTypes())
            $Ctrl.Xaml.IO.ConfigPropertyApply.IsEnabled     = 0
        }
    }
    ConfigDependency()
    {
        $Ctrl = $This

        $Ctrl.Xaml.IO.ConfigComponent.SelectedIndex  = -1
        $Ctrl.Xaml.IO.ConfigSettings.SelectedIndex   = -1
        $Ctrl.Xaml.IO.ConfigRadiant.SelectedIndex    = -1

        $Ctrl.ConfigProperty()

        If ($Ctrl.Xaml.IO.ConfigDependency.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.ConfigDependency.SelectedItem
            
            $Ctrl.Xaml.IO.ConfigPropertyNameText.Text       = $Item.Name
            $Ctrl.Xaml.IO.ConfigPropertyValueText.Text      = $Item.Value

            $Ctrl.Xaml.IO.ConfigPropertyValueText.IsEnabled = [UInt32]($Item.Name -notin $Ctrl.Registry.BaseTypes())
            $Ctrl.Xaml.IO.ConfigPropertyValueIcon.Source    = $Ctrl.IconStatus($Item.Valid)
            $Ctrl.Xaml.IO.ConfigPropertyBrowse.IsEnabled    = [UInt32]($Item.Name -notin $Ctrl.Registry.BaseTypes())
            $Ctrl.Xaml.IO.ConfigPropertyApply.IsEnabled     = 0
        }
    }
    ConfigProperty()
    {
        $Ctrl = $This

        # // Clear all bottom fields
        $Ctrl.Xaml.IO.ConfigPropertyNameText.Text       = ""
        $Ctrl.Xaml.IO.ConfigPropertyValueText.Text      = ""

        $Ctrl.Xaml.IO.ConfigPropertyBrowse.IsEnabled    = 0
        $Ctrl.Xaml.IO.ConfigPropertyApply.IsEnabled     = 0

        $Ctrl.Xaml.IO.ConfigPropertyValueText.IsEnabled = 0
        $Ctrl.Xaml.IO.ConfigPropertyBrowse.IsEnabled    = 0
        $Ctrl.Xaml.IO.ConfigPropertyApply.IsEnabled     = 0
    }
    [Object] ConfigSelected()
    {
        $Current = "Component","Settings","Radiant","Dependency" | ? { $This.Xaml.IO."Config$_".SelectedIndex -ne -1 }
        Return $This.Xaml.IO."Config$Current"
    }
    ConfigPropertyValueText()
    {
        $Ctrl     = $This

        $Current  = $Ctrl.ConfigSelected()

        $Item     = $Current.SelectedItem
        $Value    = $Ctrl.Xaml.IO.ConfigPropertyValueText.Text

        If (!$Value -or $Value -eq $Item.Default)
        {
            $Ctrl.Xaml.IO.ConfigPropertyValueIcon.Source = $Ctrl.IconStatus(0)
            $Ctrl.Xaml.IO.ConfigPropertyApply.IsEnabled  = 0
        }
        ElseIf ($Value -ne $Item.Default)
        {
            $Flag                                        = [UInt32](Test-Path $Value -EA 0)
            $Ctrl.Xaml.IO.ConfigPropertyValueIcon.Source = $Ctrl.IconStatus($Flag)
            $Ctrl.Xaml.IO.ConfigPropertyApply.IsEnabled  = [UInt32]($Value -ne $Item.Value)
        }
    }
    ConfigPropertyBrowse()
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Browsing [~] Registry property target")

        $Dialog              = $Ctrl.FolderBrowserDialog()
        $Dialog.ShowDialog()

        If ([System.IO.Directory]::Exists($Dialog.SelectedPath))
        {
            $Ctrl.Xaml.IO.ConfigPropertyValueText.Text = $Dialog.SelectedPath

            $Ctrl.Update(0,"Selected [+] Path: $($Dialog.SelectedPath)")
        }
        Else
        {
            $Ctrl.Update(0,"Selected [!] Path: <not set>")
        }
    }
    ConfigPropertyApply()
    {
        $Ctrl    = $This

        $Current = $Ctrl.ConfigSelected()
        $Slot    = $Current.Name -Replace "Config", ""
        $Item    = $Current.SelectedItem
        $Value   = $Ctrl.Xaml.IO.ConfigPropertyValueText.Text

        If ($Value -ne $Item.Value)
        {
            $Item.Value = $Value
            $Item.Apply()
        }

        $Ctrl.Xaml.IO.ConfigPropertyApply.IsEnabled = 0

        $Ctrl.Reset($Current,$Ctrl.Registry.$Slot.Property)
        
        $Ctrl.Xaml.IO.ConfigPropertyNameText.Text  = $Null
        $Ctrl.Xaml.IO.ConfigPropertyValueText.Text = $Null
    }
    DependencyOutput()
    {
        $Ctrl = $This

        $Ctrl.Xaml.IO.DependencyInstall.IsEnabled    = 0
        $Ctrl.Xaml.IO.DependencyClear.IsEnabled      = 0
        $Ctrl.Xaml.IO.DependencyEdit.IsEnabled       = 0
        $Ctrl.Xaml.IO.DependencyNew.IsEnabled        = 0

        $Ctrl.Xaml.IO.DependencyPathText.IsEnabled   = 0
        $Ctrl.Xaml.IO.DependencyPathText.Text        = $Null
        $Ctrl.Xaml.IO.DependencyPathIcon.Source      = $Null
        $Ctrl.Xaml.IO.DependencyPathBrowse.IsEnabled = 0
        $Ctrl.Xaml.IO.DependencyPathApply.IsEnabled  = 0

        $Ctrl.Reset($Ctrl.Xaml.IO.DependencyProperty,$Null)

        If ($Ctrl.Xaml.IO.DependencyOutput.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.DependencyOutput.SelectedItem

            $Ctrl.Xaml.IO.DependencyInstall.IsEnabled = !$Item.Installed
            $Ctrl.Xaml.IO.DependencyClear.IsEnabled   = $Item.Installed

            $Ctrl.Xaml.IO.DependencyPathText.Text     = $Item.Directory
            $Ctrl.Xaml.IO.DependencyPathIcon.Source   = $Ctrl.IconStatus($Item.Installed)
            
            $Ctrl.Reset($Ctrl.Xaml.IO.DependencyProperty,$Ctrl.DependencyFilter($Item))
        }
    }
    DependencyInstall()
    {

    }
    DependencyClear()
    {

    }
    DependencyEdit()
    {

    }
    DependencyPathText()
    {

    }
    DependencyPathBrowse()
    {

    }
    DependencyPathApply()
    {

    }
    ComponentOutput()
    {
        $Ctrl  = $This

        If ($Ctrl.Xaml.IO.ComponentOutput.SelectedIndex -ne -1)
        {
            $Ctrl.Component.SetSelected($Ctrl.Xaml.IO.ComponentOutput.SelectedIndex)

            $xComponent = $Ctrl.Component.Current()

            $Ctrl.Xaml.IO.ComponentSlot.SelectedIndex = 0
            $Ctrl.Xaml.IO.ComponentSlotPathText.Text  = $xComponent.Fullname

            If ($xComponent.Fullname -notmatch "<not set>")
            {
                $Ctrl.Xaml.IO.ComponentSlotRemove.IsEnabled = 1
            }

            $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBase,$xComponent.Base[0])

            $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBasePackage,$Null)
            $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBasePackageEntry,$Null)
        }
    }
    ComponentSelect()
    {
        $Ctrl  = $This

        If ($Ctrl.Xaml.IO.ComponentOutput.SelectedIndex -ne -1)
        {
            $xComponent         = $Ctrl.Component.Current()

            $Ctrl.Registry.Game = $xComponent.Name

            Set-ItemProperty -Path $Ctrl.Registry.Fullname -Name Game -Value $xComponent.Name -Verbose
        }
    }
    ComponentSlotPathText()
    {
        $Ctrl    = $This

        $Current = $Ctrl.Component.Current()
        $Slot    = $Ctrl.Xaml.Get("ComponentSlot")
        $Text    = $Ctrl.Xaml.Get("ComponentSlotPathText")
        $Icon    = $Ctrl.Xaml.Get("ComponentSlotPathIcon")
        $Add     = $Ctrl.Xaml.Get("ComponentSlotAdd")
        $Remove  = $Ctrl.Xaml.Get("ComponentSlotRemove")

        # Default states
        $Add.Control.IsEnabled    = 0
        $Remove.Control.IsEnabled = 0

        # Logic prerequisites
        $Value   = $Text.Control.Text
        $Valid   = $Ctrl.CheckPathChars($Text.Control.Text).Count -ne 0
        $Regex   = $Ctrl.Escape($Value)
        $Exists  = [System.IO.Directory]::Exists($Text.Control.Text)

        # // 1) not a valid path
        # // 2) valid path but doesn't exist
        # // 3) valid path, exists, already set
        # // 4) valid path, exists, not already set
        Switch ($Slot.Control.SelectedIndex)
        {
            0
            {
                If (!$Valid)
                {
                    $Text.Reason    = "Invalid game path"
                    $Text.Status    = 0
                }
                ElseIf ($Valid -and !$Exists)
                {
                    $Text.Reason    = "Invalid game directory"
                    $Text.Status    = 0
                }
                ElseIf ($Valid -and $Exists -and $Value -eq $Current.Fullname)
                {
                    $Text.Reason    = "Game directory already set"
                    $Text.Status    = 2
                }
                ElseIf ($Valid -and $Exists -and $Value -ne $Current.Fullname)
                {
                    $Text.Reason    = "Valid game directory"
                    $Text.Status    = 1
                    $Add.Control.IsEnabled = 1
                }
            }
            1
            {
                If (!$Valid)
                {
                    $Text.Reason   = "Invalid base path"
                    $Text.Status   = 0
                }
                ElseIf ($Valid -and !$Exists)
                {
                    $Text.Reason    = "Invalid base directory"
                    $Text.Status    = 0
                }
                ElseIf ($Valid -and $Exists -and $Value -in $Current.Base.Fullname)
                {
                    $Text.Reason    = "Base directory already set"
                    $Text.Status    = 2

                    If ($Current.Base.Default -eq 0)
                    {
                        $Remove.Control.IsEnabled = 1
                    }
                }
                ElseIf ($Valid -and $Exists -and $Value -notin $Current.Base.Fullname)
                {
                    $Text.Reason    = "Valid base directory"
                    $Text.Status    = 1
                    $Add.Control.IsEnabled = 1
                }
            }
        }

        $Icon.Status              = $Text.Status
        $Icon.Reason              = $Text.Reason
        
        $Icon.Control.ToolTip  = $Text.Reason

        $Icon.Control.Source   = $Ctrl.IconStatus($Text.Status)
    }
    ComponentSlotPathBrowse()
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Browsing [~] Component (game/base) path")

        $Dialog              = $Ctrl.FolderBrowserDialog()
        $Dialog.SelectedPath = Switch ($Ctrl.Xaml.IO.ComponentSlot.SelectedIndex)
        {
            0 { $Ctrl.Xaml.IO.ComponentOutput.SelectedItem.Fullname }
            1 { $Ctrl.Xaml.IO.ComponentBase.SelectedItem.Fullname   }
        }

        $Dialog.ShowDialog()

        If ([System.IO.Directory]::Exists($Dialog.SelectedPath))
        {
            $Ctrl.Xaml.IO.ComponentSlotPathText.Text = $Dialog.SelectedPath

            $Ctrl.Update(0,"Selected [+] Path: [$($Dialog.SelectedPath)]")
        }
        Else
        {
            $Value = Switch ($Ctrl.Xaml.IO.ComponentSlot.SelectedIndex)
            {
                0 { $Ctrl.Xaml.IO.ComponentOutput.SelectedItem.Fullname }
                1 { $Ctrl.Xaml.IO.ComponentBase.SelectedItem.Fullname   }
            }

            If (!$Value)
            {
                $Value = "<not set>"
            }

            $Ctrl.Xaml.IO.ComponentSlotPathText.Text = $Value

            $Ctrl.Update(0,"Selected [!] Path: [<not set>]")
        }
    }
    ComponentSlotAdd()
    {
        $Ctrl = $This

        Switch ($Ctrl.Xaml.IO.ComponentSlot.SelectedIndex)
        {
            0
            {
                $Selected = $Ctrl.Xaml.IO.ComponentOutput.SelectedItem
                $Ctrl.Component.Assign($Selected.Name,$Ctrl.Xaml.IO.ComponentSlotPathText.Text)

                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentOutput,$Ctrl.Component.Output)

                $Ctrl.Xaml.IO.ComponentOutput.SelectedItem = $Ctrl.Xaml.IO.ComponentOutput | ? Name -eq $Selected.Name
            }
            1
            {
                $Current  = $Ctrl.Component.Current()
                $Value    = $Ctrl.Xaml.IO.ComponentSlotPathText.Text
                If ($Value -notin $Current.Base.Fullname)
                {
                    $Current.AddBase($Current.Base.Count,$Ctrl.Xaml.IO.ComponentSlotPathText.Text)
                }

                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBase,             $Current.Base)
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBasePackage,      $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBasePackageEntry, $Null)

                $Ctrl.Xaml.IO.ComponentBase.SelectedItem = $Ctrl.Xaml.IO.ComponentBase.Items | ? Fullname -eq $Value
            }
        }
    }
    ComponentSlotRemove()
    {
        $Ctrl = $This

        Switch ($Ctrl.Xaml.IO.ComponentSlot.SelectedIndex)
        {
            0
            {
                $Selected = $Ctrl.Xaml.IO.ComponentOutput.SelectedItem
        
                $Selected.Clear()

                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentOutput,$Ctrl.Component.Output)

                $Ctrl.Xaml.IO.ComponentOutput.SelectedItem = $Ctrl.Xaml.IO.ComponentOutput | ? Name -eq $Selected.Name
                $Ctrl.Xaml.IO.ComponentSlotRemove.IsEnabled = 0
            }
            1
            {
                $Current  = $Ctrl.Component.Current()
                $Value    = $Ctrl.Xaml.IO.ComponentSlotPathText.Text
                $Default  = $Current.GetDefault()

                If ($Value -in $Current.Base.Fullname -and $Value -ne $Default.Fullname)
                {
                    $Current.RemoveBase($Ctrl.Xaml.IO.ComponentSlotPathText.Text)
                }

                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBase,             $Current.Base)
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBasePackage,      $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBasePackageEntry, $Null)

                $Ctrl.Xaml.IO.ComponentBase.SelectedIndex   = -1
                $Ctrl.Xaml.IO.ComponentSlotRemove.IsEnabled = 0
            }
        }
    }
    ComponentBase()
    {
        $Ctrl  = $This

        If ($Ctrl.Xaml.IO.ComponentBase.SelectedIndex -ne -1)
        {
            $Base = $Ctrl.Xaml.IO.ComponentBase.SelectedItem

            $Ctrl.Xaml.IO.ComponentSlot.SelectedIndex = 1
            $Ctrl.Xaml.IO.ComponentSlotPathText.Text  = $Base.Fullname

            $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBasePackage,$Base.Package)
            $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBasePackageEntry,$Null)

            If (!$Base.Default)
            {
                $Ctrl.Xaml.IO.ComponentSlotRemove.IsEnabled = 1
            }
        }
    }
    ComponentBasePackage()
    {
        $Ctrl    = $This

        If ($Ctrl.Xaml.IO.ComponentBasePackage.SelectedIndex -ne -1)
        {
            $Package = $Ctrl.Xaml.IO.ComponentBasePackage.SelectedItem
            
            $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBasePackageEntry,$Package.Entry)
        }
    }
    ComponentBasePackageOverlay([UInt32]$Mode)
    {
        $Ctrl    = $This

        Switch ($Mode)
        {
            0
            {
                # // Start
                $Ctrl.Xaml.IO.ComponentBasePackage.IsEnabled         = 0
                $Ctrl.Xaml.IO.ComponentBasePackageOverlay.Visibility = "Visible"
            }
            1
            {
                # // End
                $Ctrl.Xaml.IO.ComponentBasePackage.IsEnabled         = 1
                $Ctrl.Xaml.IO.ComponentBasePackageOverlay.Visibility = "Collapsed"
            }
        }
    }
    ComponentBasePackagePopulate()
    {
        $Ctrl          = $This

        If ($Ctrl.Xaml.IO.ComponentBasePackage.SelectedIndex -ne -1)
        {
            $Package   = $Ctrl.Xaml.IO.ComponentBasePackage.SelectedItem

            If (!$Package.Loaded)
            {
                $Work  = $Ctrl.Threading.Wrap($Package,"Refresh") 
                $Start = [System.Action]{ $Ctrl.ComponentBasePackageOverlay(0) }
                $End   = [System.Action]{ $Ctrl.ComponentBasePackageOverlay(1) }
                $UI    = [System.Action]{ $Ctrl.ComponentBasePackageFilter()   }
                
                $Ctrl.Threading.RunAsyncWithProgress($Work,$Start,$End,$UI)
            }
        }
    }
    ComponentBasePackageProperty()
    {
        $Ctrl = $This

        $Ctrl.ComponentBasePackageFilter()
    }
    ComponentBasePackageFilter()
    {
        $Ctrl     = $This

        $Property = $Ctrl.Xaml.IO.ComponentBasePackageProperty.SelectedItem.Content
        $Filter   = $Ctrl.Xaml.IO.ComponentBasePackageFilter.Text
        $Package  = $Ctrl.Xaml.IO.ComponentBasePackage.SelectedItem
        
        Switch -Regex ($Filter)
        {
            "^$"
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBasePackageEntry,$Package.Entry)
            }
            Default
            {
                $List    = $Package.Entry | ? $Property -match $Ctrl.Escape($Filter)
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBasePackageEntry,$List)
            }
        }
    }
    ComponentBasePackageRefresh()
    {
        $Ctrl    = $This
        $Index   = $Ctrl.Xaml.IO.ComponentBasePackage.SelectedIndex

        If ($Index -ne -1)
        {
            $Package = $Ctrl.Xaml.IO.ComponentBasePackage.SelectedItem

            $Package.Loaded = 0
            $Package.Refresh()

            $Ctrl.ComponentBasePackageFilter()
        }
    }
    ComponentBaseOutputControlReset()
    {
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.ComponentBaseOutputControl.SelectedIndex -eq 0)
        {
            # Defer the clear until layout is stable
            $Ctrl.Xaml.IO.Dispatcher.BeginInvoke(
                [Action]{
                    $Ctrl.ComponentBaseClear()
                },
                [System.Windows.Threading.DispatcherPriority]::Background
            )
        }
    }
    ComponentBaseClear()
    {
        $Ctrl = $This

        ForEach ($X in 1..9)
        {
            $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[$X].IsEnabled  = 0
            $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[$X].IsSelected = 0
        }

        # Reset everything
        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseShaderProperty,    $Null)
        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseShaderItemOutput,  $Null)
        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseShaderItemContent, $Null)

        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseTextureProperty,   $Null)
        $Ctrl.Xaml.IO.ComponentBaseTextureImage.Source          = $Null

        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseMapProperty,       $Null)

        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseLevelshotProperty, $Null)
        $Ctrl.Xaml.IO.ComponentBaseTextureImage.Source          = $Null

        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseArenaProperty,     $Null)
        $Ctrl.Xaml.IO.ComponentBaseArenaContent.Text            = $Null

        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseModelProperty,     $Null)
        $Ctrl.Xaml.IO.ComponentBaseModelImage.Source            = $Null

        $Ctrl.Audio.Clear("Sound")
        $Ctrl.Xaml.IO.ComponentBaseSoundTrackbar.Value          = 0
        $Ctrl.Xaml.IO.ComponentBaseSoundPosition.Text           = "00:00"
        $Ctrl.Xaml.IO.ComponentBaseSoundRemain.Text             = "00:00"

        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseSoundProperty,     $Null)

        $Ctrl.Audio.Clear("Music")
        $Ctrl.Xaml.IO.ComponentBaseMusicTrackbar.Value          = 0
        $Ctrl.Xaml.IO.ComponentBaseMusicPosition.Text           = "00:00"
        $Ctrl.Xaml.IO.ComponentBaseMusicRemain.Text             = "00:00"

        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseMusicProperty,     $Null)

        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseTextProperty,      $Null)
        $Ctrl.Xaml.IO.ComponentBaseTextContent.Text = $Null

        # Switch tab AFTER layout
        $Ctrl.Xaml.IO.Dispatcher.BeginInvoke(
            [Action]{
                $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[0].IsSelected = 1
                $Ctrl.Xaml.IO.ComponentBaseOutputControl.SelectedIndex       = 0
            },
            [System.Windows.Threading.DispatcherPriority]::Background
        )
    }
    ComponentBaseShader([Object]$Item)
    {
        $Ctrl = $This

        If ($Item.GetType().Name -notmatch "Q3ALiveShaderFileItem")
        {
            $Item = $Ctrl.Q3ALiveShaderObject($Item)
        }

        $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[1].IsEnabled = 1

        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseShaderProperty,    $Item)
        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseShaderItemOutput,  $Item.Output)
        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseShaderItemContent, $Null)

        $Ctrl.Xaml.IO.Dispatcher.BeginInvoke(
            [Action]{
                $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[1].IsSelected = 1
                $Ctrl.Xaml.IO.ComponentBaseOutputControl.SelectedIndex       = 1
            },
            [System.Windows.Threading.DispatcherPriority]::Background
        )
    }
    ComponentBaseImage([Object]$Item)
    {
        $Ctrl = $This

        If ($Item.GetType().Name -notmatch "Q3ALive.ImageObject")
        {
            $Item = $Ctrl.Q3ALiveImageObject($Item)
        }

        Switch ($Item.Label)
        {
            Texture
            {
                $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[2].IsEnabled = 1

                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseTextureProperty,$Item)
                $Ctrl.Xaml.IO.ComponentBaseTextureImage.Source = $Item.GetBitmap()

                $Ctrl.Xaml.IO.Dispatcher.BeginInvoke(
                    [Action]{
                        $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[2].IsSelected = 1
                        $Ctrl.Xaml.IO.ComponentBaseOutputControl.SelectedIndex       = 2
                    },
                    [System.Windows.Threading.DispatcherPriority]::Background
                )
            }

            Levelshot
            {
                $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[4].IsEnabled = 1

                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseLevelshotProperty,$Item)
                $Ctrl.Xaml.IO.ComponentBaseLevelshotImage.Source = $Item.GetBitmap()

                $Ctrl.Xaml.IO.Dispatcher.BeginInvoke(
                    [Action]{
                        $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[4].IsSelected = 1
                        $Ctrl.Xaml.IO.ComponentBaseOutputControl.SelectedIndex       = 4
                    },
                    [System.Windows.Threading.DispatcherPriority]::Background
                )
            }

            Model
            {
                $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[6].IsEnabled = 1

                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseModelProperty,$Item)
                $Ctrl.Xaml.IO.ComponentBaseModelImage.Source = $Item.GetBitmap()

                $Ctrl.Xaml.IO.Dispatcher.BeginInvoke(
                    [Action]{
                        $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[6].IsSelected = 1
                        $Ctrl.Xaml.IO.ComponentBaseOutputControl.SelectedIndex       = 6
                    },
                    [System.Windows.Threading.DispatcherPriority]::Background
                )
            }
        }
    }
    ComponentBaseArena([Object]$Item)
    {
        $Ctrl = $This

        If ($Item.GetType().Name -notmatch "Q3ALiveArenaObject")
        {
            $Item = $Ctrl.Q3ALiveArenaObject($Item)
        }

        $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[5].IsEnabled = 1

        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseArenaProperty,$Item)
        $Ctrl.Xaml.IO.ComponentBaseArenaContent.Text = $Item.Content -join "`n"

        $Ctrl.Xaml.IO.Dispatcher.BeginInvoke(
            [Action]{
                $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[5].IsSelected = 1
                $Ctrl.Xaml.IO.ComponentBaseOutputControl.SelectedIndex       = 5
            },
            [System.Windows.Threading.DispatcherPriority]::Background
        )
    }
    ComponentBaseAudio([Object]$Item)
    {
        $Ctrl = $This

        If ($Item.GetType().Name -notmatch "Q3ALiveAudioObject")
        {
            $Item = $Ctrl.Q3ALiveAudioObject($Item)
        }

        Switch ($Item.Label)
        {
            Sound
            {
                $Ctrl.Audio.Sound.Load($Item)

                $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[7].IsEnabled = 1

                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseSoundProperty,$Item)

                $Ctrl.Xaml.IO.Dispatcher.BeginInvoke(
                    [Action]{
                        $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[7].IsSelected = 1
                        $Ctrl.Xaml.IO.ComponentBaseOutputControl.SelectedIndex       = 7

                        $Ctrl.Xaml.IO.ComponentBaseSoundTrackbar.Value = 0 
                        $Ctrl.Xaml.IO.ComponentBaseSoundPosition.Text = "00:00" 
                        $Ctrl.Xaml.IO.ComponentBaseSoundRemain.Text = $Ctrl.SecondsToString($Item.Duration.TotalSeconds)
                    },
                    [System.Windows.Threading.DispatcherPriority]::Background
                )
            }
            Music
            {
                $Ctrl.Audio.Music.Load($Item)

                $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[8].IsEnabled = 1

                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseMusicProperty,$Item)

                $Ctrl.Xaml.IO.Dispatcher.BeginInvoke(
                    [Action]{
                        $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[8].IsSelected = 1
                        $Ctrl.Xaml.IO.ComponentBaseOutputControl.SelectedIndex       = 8

                        $Ctrl.Xaml.IO.ComponentBaseMusicTrackbar.Value = 0 
                        $Ctrl.Xaml.IO.ComponentBaseMusicPosition.Text  = "00:00" 
                        $Ctrl.Xaml.IO.ComponentBaseMusicRemain.Text    = $Ctrl.SecondsToString($Item.Duration.TotalSeconds)
                    },
                    [System.Windows.Threading.DispatcherPriority]::Background
                )
            }
        }
    }
    ComponentBaseText([Object]$Item)
    {
        $Ctrl = $This

        If ($Item.GetType().Name -notmatch "Q3ALiveTextObject")
        {
            $Item = $Ctrl.Q3ALiveTextObject($Item)
        }

        $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[9].IsEnabled = 1

        $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseTextProperty,$Item)
        $Ctrl.Xaml.IO.ComponentBaseTextContent.Text = $Item.Content -join "`n"

        $Ctrl.Xaml.IO.Dispatcher.BeginInvoke(
            [Action]{
                $Ctrl.Xaml.IO.ComponentBaseOutputControl.Items[9].IsSelected = 1
                $Ctrl.Xaml.IO.ComponentBaseOutputControl.SelectedIndex       = 9
            },
            [System.Windows.Threading.DispatcherPriority]::Background
        )
    }
    ComponentBasePackageEntry()
    {
        $Ctrl  = $This
        $Item  = $Ctrl.Xaml.IO.ComponentBasePackageEntry.SelectedItem

        $Ctrl.ComponentBaseClear()

        # [Shader]

        If ($Item.Type -eq "File")
        {
            Switch -Regex ($Item.Label)
            {
                Script
                {
                    If ($Item.Extension -eq "shader")
                    {
                        $Ctrl.ComponentBaseShader($Item)
                    }

                    If ($Item.Extension -eq "arena")
                    {
                        $Ctrl.ComponentBaseArena($Item)
                    }
                }
                Texture
                {
                    $Ctrl.ComponentBaseImage($Item)
                }
                Levelshot
                {
                    $Ctrl.ComponentBaseImage($Item)
                }
                Model
                {
                    Switch -Regex ($Item.Extension)
                    {
                        "(jpg|tga|png)"
                        {
                            $Ctrl.ComponentBaseImage($Item)
                        }
                        md3
                        {

                        }
                        skin
                        {

                        }

                    }
                }
                Sound
                {
                    $Ctrl.ComponentBaseAudio($Item)
                }
                Music
                {
                    $Ctrl.ComponentBaseAudio($Item)
                }
                Other
                {
                    Switch -Regex ($Item.Extension)
                    {
                        "(cfg|config|c|h|log|txt)"
                        {
                            $Ctrl.ComponentBaseText($Item)
                        }
                        Default
                        {

                        }
                    }
                }
            }
        }
    }
    ComponentBaseShaderItemOutput()
    {
        $Ctrl  = $This
        $Item  = $Ctrl.Xaml.IO.ComponentBaseShaderItemOutput.SelectedItem

        If ($Ctrl.Xaml.IO.ComponentBaseShaderItemOutput.SelectedIndex  -ne -1)
        {
            $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseShaderItemContent,$Item.Content)
        }
    }
    ComponentBaseSoundPlay()
    {
        $Ctrl = $This

        $Ctrl.Audio.Play("Sound")
    }
    ComponentBaseSoundTrackbar([Object]$sender,[Object]$args)
    {
        $Ctrl   = $This
        $Slider = $Ctrl.Xaml.IO.ComponentBaseSoundTrackbar
        $Engine = $Ctrl.Audio.Sound

        # Drag start
        if ($Slider.IsMouseCaptureWithin -and !$Engine.Drag)
        {
            $Engine.Drag = $true
            return
        }

        # Drag end
        if (!$Slider.IsMouseCaptureWithin -and $Engine.Drag)
        {
            $Engine.Drag = $false

            $normalized  = $Slider.Value
            $duration    = $Engine.Current.Duration.TotalSeconds
            $seconds     = $normalized * $duration

            $Engine.Player.Seek($seconds)
            return
        }
    }
    ComponentBaseSoundTrackbarPosition([double]$Seconds)
    {
        $Ctrl   = $This
        $Engine = $Ctrl.Audio.Sound

        if ($Engine.Drag) { return }

        $duration   = $Engine.Current.Duration.TotalSeconds
        if ($duration -eq 0) { return }

        $normalized = $Seconds / $duration
        $remaining  = $duration - $Seconds
        if ($remaining -lt 0) { $remaining = 0 }

        $Ctrl.Xaml.IO.Dispatcher.BeginInvoke(
            [Action]{
                $Ctrl.Xaml.IO.ComponentBaseSoundTrackbar.Value = $normalized
                $Ctrl.Xaml.IO.ComponentBaseSoundPosition.Text  = $Ctrl.SecondsToString($Seconds)
                $Ctrl.Xaml.IO.ComponentBaseSoundRemain.Text    = $Ctrl.SecondsToString($remaining)
            },
            [System.Windows.Threading.DispatcherPriority]::Background
        )
    }
    ComponentBaseSoundStop()
    {
        $Ctrl = $This

        $Ctrl.Audio.Stop("Sound")
    }
    ComponentBaseMusicPlay()
    {
        $Ctrl = $This

        $Ctrl.Audio.Play("Music")
    }
    ComponentBaseMusicTrackbar([Object]$sender,[Object]$args)
    {
        $Ctrl   = $This
        $Slider = $Ctrl.Xaml.IO.ComponentBaseMusicTrackbar
        $Engine = $Ctrl.Audio.Music

        # Drag start
        if ($Slider.IsMouseCaptureWithin -and !$Engine.Drag)
        {
            $Engine.Drag = $true
            return
        }

        # Drag end
        if (!$Slider.IsMouseCaptureWithin -and $Engine.Drag)
        {
            $Engine.Drag = $false

            $normalized  = $Slider.Value
            $duration    = $Engine.Current.Duration.TotalSeconds
            $seconds     = $normalized * $duration

            $Engine.Player.Seek($seconds)
            return
        }
    }
    ComponentBaseMusicTrackbarPosition([double]$Seconds)
    {
        $Ctrl   = $This
        $Engine = $Ctrl.Audio.Music

        if ($Engine.Drag) { return }

        $duration   = $Engine.Current.Duration.TotalSeconds
        if ($duration -eq 0) { return }

        $normalized = $Seconds / $duration
        $remaining  = $duration - $Seconds
        if ($remaining -lt 0) { $remaining = 0 }

        $Ctrl.Xaml.IO.Dispatcher.BeginInvoke(
            [Action]{
                $Ctrl.Xaml.IO.ComponentBaseMusicTrackbar.Value = $normalized
                $Ctrl.Xaml.IO.ComponentBaseMusicPosition.Text  = $Ctrl.SecondsToString($Seconds)
                $Ctrl.Xaml.IO.ComponentBaseMusicRemain.Text    = $Ctrl.SecondsToString($remaining)
            },
            [System.Windows.Threading.DispatcherPriority]::Background
        )
    }
    ComponentBaseMusicStop()
    {
        $Ctrl = $This

        $Ctrl.Audio.Stop("Music")
    }
    RadiantOutput()
    {
        $Ctrl  = $This
        $Index = $Ctrl.Xaml.IO.RadiantOutput.SelectedIndex

        If ($Index -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.RadiantOutput.SelectedItem

            $Ctrl.Radiant.SetSelected($Item.Index)
            
            $Ctrl.Reset($Ctrl.Xaml.IO.RadiantProperty,$Ctrl.RadiantFilter($Item))
            $Ctrl.Reset($Ctrl.Xaml.IO.RadiantFileOutput,$Item.File)
        }
    }
    RadiantSelect()
    {
        $Ctrl  = $This
        $Index = $Ctrl.Xaml.IO.RadiantOutput.SelectedIndex
        
        If ($Index -ne -1)
        {
            $Current = $Ctrl.Radiant.Current()

            $Ctrl.Registry.Editor = $Current.Name

            Set-ItemProperty -Path $Ctrl.Registry.Fullname -Name Editor -Value $Current.Name -Verbose

            $Ctrl.Xaml.IO.RadiantLaunch.IsEnabled           = 1
            $Ctrl.Xaml.IO.RadiantLaunchParamText.IsReadOnly = 0
            $Ctrl.Xaml.IO.RadiantLaunchParamIcon.IsEnabled  = 1
            $Ctrl.Xaml.IO.RadiantBrowse.IsEnabled           = 1
            $Ctrl.Xaml.IO.RadiantClose.IsEnabled            = 0

            $Ctrl.Xaml.IO.RadiantLaunchParamText.Text       = "<not set>"
        }
    }
    RadiantFileProperty()
    {
        $Ctrl = $This

        $Ctrl.RadiantFileFilter()
    }
    RadiantFileFilter()
    {
        $Ctrl     = $This
        $xRadiant = $Ctrl.Radiant.Current()

        If ($Ctrl.Xaml.IO.RadiantOutput.SelectedIndex -ne -1)
        {
            $Property = $Ctrl.Xaml.IO.RadiantFileProperty.SelectedItem.Content
            $Filter   = $Ctrl.Xaml.IO.RadiantFileFilter.Text
            
            Switch -Regex ($Filter)
            {
                "^$"
                {
                    $Ctrl.Reset($Ctrl.Xaml.IO.RadiantFileOutput,$xRadiant.File)
                }
                Default
                {
                    $List    = $xRadiant.File | ? $Property -match $Ctrl.Escape($Filter)
                    $Ctrl.Reset($Ctrl.Xaml.IO.RadiantFileOutput,$List)
                }
            }
        }
    }
    RadiantFileRefresh()
    {
        $Ctrl     = $This
        $xRadiant = $Ctrl.Radiant.Current()
        
        If ($Ctrl.Xaml.IO.RadiantOutput.SelectedIndex -ne -1)
        {
            $xRadiant.Refresh()
        
            $Ctrl.RadiantFileFilter()
        }
    }
    RadiantLaunch()
    {
        $Ctrl = $This

        $Current = $Ctrl.Radiant.Current()
        $Process = $Ctrl.RadiantEditorProcess($Current)

        If (!$Process)
        {
            $Ctrl.Update(0,"Launching [~] Editor: [$($Current.Name)]")

            $ParamSwitch = $Null

            If ($Ctrl.Xaml.IO.RadiantLaunchParamText.Text -notmatch "(<not set>|^$)")
            {
                $ParamSwitch = Switch -Regex ($Current.Name)
                {
                    "GtkRadiant"        { "`"{0}`""     -f $Ctrl.Xaml.IO.RadiantLaunchParamText.Text }
                    "NetRadiant-Custom" { "--% `"{0}`"" -f $Ctrl.Xaml.IO.RadiantLaunchParamText.Text }
                }
            }

            # Testing
            $Param = @{ FilePath = $Current.Editor }
            If (!!$ParamSwitch) 
            { 
                $Param.ArgumentList = $ParamSwitch 
            }

            Start-Process @Param -EA 0
            If ($?)
            {
                $Ctrl.Update(0,"Running [+] Editor: [$($Current.Name)]")

                $Ctrl.Xaml.IO.RadiantLaunch.IsEnabled          = 0
                $Ctrl.Xaml.IO.RadiantLaunchParamText.IsEnabled = 0
                $Ctrl.Xaml.IO.RadiantClose.IsEnabled           = 1
            }
        }
        Else
        {
            # // in case the buttons aren't in the right state
            $Ctrl.Update(0,"Exception [!] Editor: [$($Current.Name)] already running")
        }
    }
    RadiantLaunchParamText()
    {
        $Ctrl = $This

        $Text   = $Ctrl.Xaml.Get("RadiantLaunchParamText")
        $Icon   = $Ctrl.Xaml.Get("RadiantLaunchParamIcon")

        $Value = $Text.Control.Text

        If ($Value -match "(^<not set>|^$)")
        {
            $Text.Status = 2
            $Text.Reason = "<No argument provided>"
        }
        ElseIf ($Value -notmatch "(^<not set>|^$)" -and $Value -notmatch "\.map")
        {
            $Text.Status = 0
            $Text.Reason = "<Not a valid map file>"
        }
        ElseIf ($Value -notmatch "(^<not set>|^$)" -and $Value -match "\.map" -and ![System.IO.File]::Exists($Value))
        {
            $Text.Status = 0
            $Text.Reason = "<File does not exist>"
        }
        ElseIf ([System.IO.File]::Exists($Value) -and $Value -match "\.map" -and ![System.IO.File]::Exists($Value))
        {
            $Text.Status = 1
            $Text.Reason = "<Valid map path>"
        }

        $Icon.Status          = $Text.Status
        $Icon.Reason          = $Text.Reason
        
        $Icon.Control.ToolTip = $Text.Reason

        $Icon.Control.Source  = $Ctrl.IconStatus($Text.Status)
    }
    RadiantBrowse()
    {
        $Ctrl = $This

        $Dialog = $Ctrl.FileBrowserDialog()

        $Dialog.InitialDirectory = $Ctrl.Registry.Map
        $Dialog.Filter           = "map (*.map)|*.map"

        $Dialog.ShowDialog()

        If ($Dialog.Filename)
        {
            $Ctrl.Xaml.IO.RadiantLaunchParamText.Text = $Dialog.Filename
        }
        If (!$Dialog.Filename)
        {
            $Ctrl.Xaml.IO.RadiantLaunchParamText.Text  = "<not set>"
        }
    }
    RadiantClose()
    {
        $Ctrl = $This

        $Current = $Ctrl.Radiant.Current()
        $Process = $Ctrl.RadiantEditorProcess($Current)
        If (!$Process)
        {
            # // in case the buttons aren't in the right state
            $Ctrl.Update(0,"Exception [!] Editor: [$($Current.Name)] not running")
        }
        Else
        {
            $Ctrl.Update(0,"Closing [~] Editor: [$($Current.Name)]")
            $Process | Stop-Process -EA 0
            If ($?)
            {
                $Ctrl.Update(0,"Closed [+] Editor: [$($Current.Name)]")
                
                $Ctrl.Xaml.IO.RadiantLaunch.IsEnabled          = 1
                $Ctrl.Xaml.IO.RadiantClose.IsEnabled           = 0
                $Ctrl.Xaml.IO.RadiantLaunchParamText.IsEnabled = 1
                $Ctrl.Xaml.IO.RadiantLaunchParamText.Text      = "<not set>"
            }
        }
    }
    [Object] RadiantEditorProcess([Object]$Current)
    {
        $Process = Get-Process -EA 0 | ? ProcessName -eq $Current.EditorProcessName()
        If (!$Process)
        {
            Return $Null
        }
        Else
        {
            Return $Process
        }
    }
    [Object] RadiantQ3Map2Process([Object]$Current)
    {
        $Process = Get-Process -EA 0 | ? ProcessName -eq $Current.Q3Map2ProcessName()
        If (!$Process)
        {
            Return $Null
        }
        Else
        {
            Return $Process
        }
    }
    [Object] RadiantBspcProcess([Object]$Current)
    {
        $Process = Get-Process -EA 0 | ? ProcessName -eq $Current.BspcProcessName()
        If (!$Process)
        {
            Return $Null
        }
        Else
        {
            Return $Process
        }
    }
    WorkspaceSlot()
    {
        $Ctrl = $This

        Switch ($Ctrl.Xaml.IO.WorkspaceSlot.SelectedIndex)
        {
            -1
            {
                $Ctrl.Xaml.IO.WorkspaceLogHeader.Visibility    = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceLogPanel.Visibility     = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceOutputHeader.Visibility = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceOutputPanel.Visibility  = "Hidden"
            }
            0
            {
                $Ctrl.Xaml.IO.WorkspaceLogHeader.Visibility    = "Visible"
                $Ctrl.Xaml.IO.WorkspaceLogPanel.Visibility     = "Visible"
                $Ctrl.Xaml.IO.WorkspaceOutputHeader.Visibility = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceOutputPanel.Visibility  = "Hidden"
            }
            1
            {
                $Ctrl.Xaml.IO.WorkspaceLogHeader.Visibility    = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceLogPanel.Visibility     = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceOutputHeader.Visibility = "Visible"
                $Ctrl.Xaml.IO.WorkspaceOutputPanel.Visibility  = "Visible"
            }
        }
    }
    WorkspaceOutput()
    {
        $Ctrl                 = $This

        If ($Ctrl.Xaml.IO.WorkspaceOutput.SelectedIndex -ne -1)
        {
            $Item                                      = $Ctrl.Xaml.IO.WorkspaceOutput.SelectedItem
            $Ctrl.Xaml.IO.WorkspaceOutputPathText.Text = $Item.Name
        }
    }
    WorkspaceOutputPathText()
    {
        $Ctrl                     = $This
        
        $Text                     = $Ctrl.Xaml.Get("WorkspaceOutputPathText")
        $Icon                     = $Ctrl.Xaml.Get("WorkspaceOutputPathIcon")
        $Add                      = $Ctrl.Xaml.Get("WorkspaceOutputAdd")
        $Add.Control.IsEnabled    = 0

        $Remove                   = $Ctrl.Xaml.Get("WorkspaceOutputRemove")
        $Remove.Control.IsEnabled = 0

        $Name                     = $Text.Control.Text
        
        If ($Name -match "(^<not set>$|^$)")
        {
            $Text.Status              = 2
            $Text.Reason              = "Cannot be blank or unset"

            $Add.Control.IsEnabled    = 0
            $Remove.Control.IsEnabled = 0
        }
        ElseIf ($Name -notmatch "(^<not set>$|^$)" -and $Name -notmatch "^[A-Za-z0-9_]+$")
        {
            $Text.Status              = 0
            $Text.Reason              = "Invalid characters"

            $Add.Control.IsEnabled    = 0
            $Remove.Control.IsEnabled = 0
        }
        ElseIf ($Name -notmatch "(^<not set>$|^$)" -and $Name -match "^[A-Za-z0-9_]+$" -and $Name -in $Ctrl.Workspace.Output.Name)
        {
            $Text.Status              = 0
            $Text.Reason              = "Project already exists"

            $Add.Control.IsEnabled    = 0
            $Remove.Control.IsEnabled = 1
        }
        Else
        {
            $xPath                    = "{0}\{1}" -f $Ctrl.Workspace.Fullname, $Name
 
            $Text.Status              = ![System.IO.Directory]::Exists($xPath)
            $Text.Reason              = "Entry valid for use"

            $Add.Control.IsEnabled    = 1
            $Remove.Control.IsEnabled = 0
        }

        $Icon.Status          = $Text.Status
        $Icon.Reason          = $Text.Reason
        $Icon.Control.ToolTip = $Text.Reason

        $Icon.Control.Source  = $Ctrl.IconStatus($Text.Status)

        If ($Text.Control.Text -notin $Ctrl.Workspace.Output.Name)
        {
            If ($Text.Status -eq 1)
            {
                $Add.Control.IsEnabled    = 1
                $Remove.Control.IsEnabled = 0
            }

            $Ctrl.Xaml.IO.WorkspaceOutput.SelectedIndex = -1
            $Ctrl.ScrollToTop($Ctrl.Xaml.IO.WorkspaceOutput)
        }

        If ($Text.Control.Text -in $Ctrl.Workspace.Output.Name)
        {
            If ($Text.Status -eq 0)
            {
                $Add.Control.IsEnabled    = 0
                $Remove.Control.IsEnabled = 1
            }

            $Item = $Ctrl.Workspace.Output | ? Name -eq $Text.Control.Text
            $Ctrl.Xaml.IO.WorkspaceOutput.SelectedItem = $Item
            $Ctrl.Xaml.IO.WorkspaceOutput.ScrollIntoView($Item)
        }
    }
    WorkspaceOutputAdd()
    {
        $Ctrl = $This

        $xName = $Ctrl.Xaml.IO.WorkspaceOutputPathText.Text
        $xPath = "{0}\{1}" -f $Ctrl.Workspace.Fullname, $xName

        $Ctrl.Update(0,"Adding [~] Project: [$($xPath)]")
        $Ctrl.Workspace.Add($xName)

        $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceOutput,$Ctrl.Workspace.Output)

        $Ctrl.Xaml.IO.WorkspaceOutputPathText.Text = "<not set>"
        $Ctrl.Xaml.IO.WorkspaceOutputPathText.Text = $xName
    }
    WorkspaceOutputRemove()
    {
        $Ctrl = $This

        $Item = $Ctrl.Xaml.IO.WorkspaceOutput.SelectedItem

        $Ctrl.Update(0,"Removing [!] Project: [$($Item.Fullname)]")
        $Ctrl.Workspace.Remove($Item.Name)

        $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceOutput,$Ctrl.Workspace.Output)
        $Ctrl.ScrollToTop($Ctrl.Xaml.IO.WorkspaceOutput)

        $Ctrl.Xaml.IO.WorkspaceOutputPathText.Text = "<not set>"
    }
    WorkspaceOutputRefresh()
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Refreshing [~] Workspace content")
        $Ctrl.Workspace.Refresh()

        If ($Ctrl.Workspace.Output -eq 0)
        {
            $Ctrl.Xaml.IO.WorkspaceOutputRefresh.IsEnabled = 0
            $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceOutput,$Null)
        }
        Else
        {
            $Ctrl.Xaml.IO.WorkspaceOutputRefresh.IsEnabled = 1
            $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceOutput,$Ctrl.Workspace.Output)

            $Text = $Ctrl.Xaml.IO.WorkspaceOutputPathText.Text
            If ($Text -notmatch "(<not set>|^$)")
            {
                $Ctrl.Xaml.IO.WorkspaceOutputPathText.Text = "^$"
                $Ctrl.Xaml.IO.WorkspaceOutputPathText.Text = $Text 
            }
        }
        
        $Ctrl.Update(0,"Complete [~] Workspace content refreshed")
    }
    AssignmentResourceOutput()
    {
        $Ctrl = $This

        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceContent,$Null)

        # Shaders
        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceShaderOutput,$Null)
        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceShaderItemOutput,$Null)
        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceShaderItemContent,$Null)

        # Textures
        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceTextureOutput,$Null)
        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceTextureProperty,$Null)

        $Ctrl.Xaml.IO.AssignmentResourceRemove.IsEnabled = 0

        If ($Ctrl.Xaml.IO.AssignmentResourceOutput.SelectedIndex -ne -1)
        {
            $xResource = $Ctrl.Xaml.IO.AssignmentResourceOutput.SelectedItem

            $Ctrl.Xaml.IO.AssignmentResourcePathText.Text = $xResource.Fullname

            # Output
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceContent,$xResource.Output)

            # Shader
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceShaderOutput,$xResource.Shader.File)

            # Texture
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceTextureOutput,$xResource.Texture.File)

            $Ctrl.Xaml.IO.AssignmentResourceRemove.IsEnabled = 1
        }
    }
    AssignmentResourcePathText()
    {
        $Ctrl = $This

        $Text = $Ctrl.Xaml.Get("AssignmentResourcePathText")
        $Icon = $Ctrl.Xaml.Get("AssignmentResourcePathIcon")
        $Add  = $Ctrl.Xaml.Get("AssignmentResourceAdd")

        $Add.Control.IsEnabled = 0
        
        If ($Text.Control.Text -match "(^<not set>$|^$)")
        {
            $Text.Status         = 2
        }
        Else
        {
            $Text.Status         = Test-Path $Text.Control.Text
            If ($Text.Status -eq 1)
            {
                $Add.Control.IsEnabled = 1
            }
        }

        $Icon.Control.Source     = $Ctrl.IconStatus($Text.Status)
    }
    AssignmentResourceBrowse()
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Browsing [~] Resource (file/folder) dialog")

        $Ctrl.Xaml.IO.AssignmentResourceBrowseHeader.Visibility  = "Hidden"
        $Ctrl.Xaml.IO.AssignmentResourceBrowsePanel.Visibility   = "Hidden"

        $Ctrl.Xaml.IO.AssignmentResourceSelectHeader.Visibility  = "Visible"
        $Ctrl.Xaml.IO.AssignmentResourceSelectPanel.Visibility   = "Visible"

        $Ctrl.Xaml.IO.AssignmentResourceBrowseTree.Items.Clear()
        $Ctrl.Xaml.IO.AssignmentResourceBrowseList.Items.Clear()

        ForEach ($Drive in Get-PSDrive -PSProvider FileSystem)
        {
            $Ctrl.Xaml.IO.AssignmentResourceBrowseTree.Items.Add($Drive)
        }
    }
    [Object[]] AssignmentResourceBrowseFilter([String]$Path)
    {
        $Items = Get-ChildItem $Path | % { $Ctrl.Q3ALiveFileSystemObject($_) }

        $Items = $Items | ? { $_.Type -eq "Directory" -or $_.Extension -match "(zip|pk3|pk4|pak)" }

        Return $Items | Sort-Object Fullname
    }
    AssignmentResourceBrowseTree()
    {
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.AssignmentResourceBrowseTree.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.AssignmentResourceBrowseTree.SelectedItem

            $Ctrl.Xaml.IO.AssignmentResourcePathText.Text = $Item.Root

            $Ctrl.AssignmentResourceBrowsePopulate()
        }
    }
    AssignmentResourceBrowseList()
    {
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.AssignmentResourceBrowseList.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.AssignmentResourceBrowseList.SelectedItem

            $Ctrl.Xaml.IO.AssignmentResourcePathText.Text = $Item.Fullname
        }
    }
    AssignmentResourceBrowseListOpen()
    {
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.AssignmentResourceBrowseList.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.AssignmentResourceBrowseList.SelectedItem

            $Ctrl.Xaml.IO.AssignmentResourcePathText.Text = $Item.Fullname

            $Ctrl.AssignmentResourceBrowsePopulate()

            $Ctrl.Xaml.IO.AssignmentResourceBack.IsEnabled = 1
        }
    }
    AssignmentResourceBrowsePopulate()
    {
        $Ctrl = $This

        $xPath = $Ctrl.Xaml.IO.AssignmentResourcePathText.Text
        If (Test-Path $xPath)
        {
            $Item = Get-Item $xPath
            Switch -Regex ($Item.GetType().Name)
            {
                "DirectoryInfo"
                {
                    $Ctrl.Xaml.IO.AssignmentResourceBrowseList.Items.Clear()
                    $Items = $Ctrl.AssignmentResourceBrowseFilter($xPath)
                    $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceBrowseList,$Items)
                }
                "FileInfo"
                {

                }
            }
        }
    }
    AssignmentResourceBack()
    {
        $Ctrl  = $This
        
        $xPath = $Ctrl.Xaml.IO.AssignmentResourcePathText.Text | Split-Path -Parent -EA 0
        $Root  = $Ctrl.Xaml.IO.AssignmentResourceBrowseTree.SelectedItem.Root

        If (!$xPath)
        {
            $xPath = $Root
        }

        $Ctrl.Xaml.IO.AssignmentResourcePathText.Text = $xPath

        $Ctrl.AssignmentResourceBrowsePopulate()

        $Ctrl.Xaml.IO.AssignmentResourceBack.IsEnabled = [UInt32]($xPath -ne $Root)
    }
    AssignmentResourceCancel()
    {
        $Ctrl = $This
        
        $Ctrl.Update(0,"Canceling [~] Resource (file/folder) dialog")

        $Ctrl.Xaml.IO.AssignmentResourceBrowseHeader.Visibility  = "Visible"
        $Ctrl.Xaml.IO.AssignmentResourceBrowsePanel.Visibility   = "Visible"

        $Ctrl.Xaml.IO.AssignmentResourceSelectHeader.Visibility  = "Hidden"
        $Ctrl.Xaml.IO.AssignmentResourceSelectPanel.Visibility   = "Hidden"

        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceBrowseTree,$Null)
        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceBrowseList,$Null)

        $Ctrl.Xaml.IO.AssignmentResourceOutput.SelectedIndex     = -1
        $Ctrl.Xaml.IO.AssignmentResourcePathText.Text            = "<not set>"
    }
    AssignmentResourceSelect()
    {
        $Ctrl = $This

        $Item = $Ctrl.Xaml.IO.AssignmentResourceBrowseList.SelectedItem

        $Ctrl.Update(0,"Selected [~] Resource : [$($Item.Fullname)]")

        $Ctrl.AssignmentResourceAdd()

        $Ctrl.Xaml.IO.AssignmentResourceBrowseHeader.Visibility  = "Visible"
        $Ctrl.Xaml.IO.AssignmentResourceBrowsePanel.Visibility   = "Visible"

        $Ctrl.Xaml.IO.AssignmentResourceSelectHeader.Visibility  = "Hidden"
        $Ctrl.Xaml.IO.AssignmentResourceSelectPanel.Visibility   = "Hidden"

        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceBrowseTree,$Null)
        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceBrowseList,$Null)
    }
    AssignmentResourceAdd()
    {
        $Ctrl = $This

        $xPath = $Ctrl.Xaml.IO.AssignmentResourcePathText.Text
        If (Test-Path $xPath)
        {
            $Ctrl.Assignment.Resource.Add($xPath)

            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceOutput,$Ctrl.Assignment.Resource.Output)

            $Ctrl.Xaml.IO.AssignmentResourceOutput.SelectedItem = $Ctrl.Assignment.Resource.Output | ? Fullname -eq $xPath
            $Ctrl.Xaml.IO.AssignmentResourceAdd.IsEnabled       = 0
        }
    }
    AssignmentResourceAdd([String]$Path)
    {
        $Ctrl = $This

        $Ctrl.Xaml.IO.AssignmentResourcePathText.Text = $Path
        $This.AssignmentResourceAdd()
    }
    AssignmentResourceRemove()
    {
        $Ctrl = $This

        $xIndex = $Ctrl.Xaml.IO.AssignmentResourceOutput.SelectedIndex
        If ($xIndex -ne -1)
        {
            $Ctrl.Assignment.Resource.Remove($xIndex)
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceOutput,$Ctrl.Assignment.Resource.Output)
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceContent,$Null)
            $Ctrl.Xaml.IO.AssignmentResourceRemove.IsEnabled     = 0
            $Ctrl.Xaml.IO.AssignmentResourceOutput.SelectedIndex = -1
            $Ctrl.Xaml.IO.AssignmentResourcePathText.Text        = "<not set>"
        }
    }
    AssignmentResourceShaderOutput()
    {
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.AssignmentResourceShaderOutput.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.AssignmentResourceShaderOutput.SelectedItem

            # Shaders
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceShaderItemOutput,$Item.Output)
        }
    }
    AssignmentResourceShaderItemOutput()
    {
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.AssignmentResourceShaderItemOutput.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.AssignmentResourceShaderItemOutput.SelectedItem

            # Shaders
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceShaderItemContent,$Item.Content)

            $Ctrl.ScrollToTop($Ctrl.Xaml.IO.AssignmentResourceShaderItemContent)
        }
    }
    AssignmentResourceTextureOutput()
    {
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.AssignmentResourceTextureOutput.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.AssignmentResourceTextureOutput.SelectedItem

            # Shaders
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceTextureProperty,$Item)
        }
    }
    AssignmentResourceSoundOutput()
    {
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.AssignmentResourceSoundOutput.SelectedIndex -ne -1)
        {

        }

        <#
        $SoundDir = "C:\Workspace\inspired\sound\world"
        $Sound    = Get-ChildItem $SoundDir | ? Name -match pc_up
        $player   = [System.Windows.Media.MediaPlayer]::New()
        $player.Open($Sound.Fullname)

        $player.Play()
        $player.Position = [TimeSpan]"00:00:00"
        $Player.Stop()
        #>
    }
    AssignmentSelectPathText()
    {
        $Ctrl = $This
        
        If ($Ctrl.Xaml.IO.AssignmentSelectPathText.Text -match "(^$|<not set>)")
        {
            $Ctrl.Xaml.IO.AssignmentSelectPathIcon.Source  = $Null
            $Ctrl.Xaml.IO.AssignmentSelectPathOpen.IsEnabled  = 0
            $Ctrl.Xaml.IO.AssignmentSelectPathClose.IsEnabled  = 0
        }
        Else
        {
            $Flag = [System.IO.Directory]::Exists($Ctrl.Xaml.IO.AssignmentSelectPathText.Text)
            $Ctrl.Xaml.IO.AssignmentSelectPathIcon.Source      = $Ctrl.IconStatus($Flag)
            $Ctrl.Xaml.IO.AssignmentSelectPathOpen.IsEnabled   = $Flag
            $Ctrl.Xaml.IO.AssignmentSelectPathClose.IsEnabled  = !$Flag
        }
    }
    AssignmentSelectPathBrowse()
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Browsing [~] Registry property target")

        $Dialog              = $Ctrl.FolderBrowserDialog()
        $Dialog.ShowDialog()

        If ([System.IO.Directory]::Exists($Dialog.SelectedPath))
        {
            $Ctrl.Xaml.IO.AssignmentSelectPathText.Text = $Dialog.SelectedPath

            $Ctrl.Update(0,"Selected [+] Path: $($Dialog.SelectedPath)")
        }
        Else
        {
            $Ctrl.Update(0,"Selected [!] Path: <not set>")
        }
    }
    AssignmentSelectPathOpen()
    {
        $Ctrl = $This

        $xPath = $Ctrl.Xaml.IO.AssignmentSelectPathText.Text

        $Ctrl.Update(0,"Assignment [~] Path: $xPath")

        Set-ItemProperty -Path $Ctrl.Registry.Fullname -Name Map -Value $xPath -Verbose

        $Ctrl.Assignment.Assign($xPath)

        $Ctrl.Xaml.IO.AssignmentSelectOutput.ItemsSource   = $Ctrl.Assignment.Output

        $Ctrl.Xaml.IO.AssignmentSelectPathBrowse.IsEnabled = 1
        $Ctrl.Xaml.IO.AssignmentSelectPathOpen.IsEnabled   = 0
        $Ctrl.Xaml.IO.AssignmentSelectPathClose.IsEnabled  = 1
        $Ctrl.Xaml.IO.AssignmentSelectFilterText.IsEnabled = 1
        $Ctrl.Xaml.IO.AssignmentSelectRefresh.IsEnabled    = 1
    }
    AssignmentSelectPathClose()
    {
        $Ctrl = $This

        $Ctrl.Assignment.Clear()

        $Ctrl.Xaml.IO.AssignmentSelectPathText.Text       = "<not set>"
        $Ctrl.Xaml.IO.AssignmentSelectPathOpen.IsEnabled  = 0
        $Ctrl.Xaml.IO.AssignmentSelectPathClose.IsEnabled = 0

        $Ctrl.Xaml.IO.AssignmentSelectFilterText.Text     = ""
        $Ctrl.Xaml.IO.AssignmentSelectRefresh.IsEnabled   = 0
        $Ctrl.Xaml.IO.AssignmentSelectAssign.IsEnabled    = 0

        $Ctrl.Xaml.IO.AssignmentSelectOutput.ItemsSource  = $Null
        $Ctrl.Xaml.IO.AssignmentSelectOutput.IsEnabled    = 1

        $Ctrl.Xaml.IO.AssignmentSelectFullname.Text       = ""

        # additional logic for other edit panel
    }
    AssignmentSelectFilterText()
    {
        $Ctrl = $This

        $PropertyName = $Ctrl.Xaml.IO.AssignmentSelectFilterProperty.SelectedItem.Content
        $FilterText   = $Ctrl.Xaml.IO.AssignmentSelectFilterText.Text

        $Ctrl.Assignment.ApplyFilter($PropertyName,$FilterText)
    }
    AssignmentSelectRefresh()
    {
        $Ctrl = $This

        $Ctrl.Assignment.Refresh()

        $Ctrl.Xaml.IO.AssignmentSelectFilterText.Text = $Null
    }
    AssignmentSelectAssign()
    {
        $Ctrl = $This

        $Ctrl.Xaml.IO.AssignmentSelectOutput.SelectedIndex = -1
        $Ctrl.Xaml.IO.AssignmentSelectOutput.IsEnabled     = 0
        $Ctrl.Xaml.IO.AssignmentSelectRefresh.IsEnabled    = 0
        $Ctrl.Xaml.IO.AssignmentSelectAssign.IsEnabled     = 0

        $Items = @($Ctrl.Assignment.Output | ? Selected)
        $Ctrl.Assignment.Edit.Assign($Items)
        $Ctrl.Assignment.FilterSelected()

        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceOutput,$Ctrl.Assignment.Edit.Output)

        $Ctrl.Xaml.IO.AssignmentEditTab.IsSelected         = 1
    }
    AssignmentSelectOutput()
    {
        $Ctrl = $This

        $Ctrl.Xaml.IO.AssignmentSelectFullname.Text = ""

        If ($Ctrl.Xaml.IO.AssignmentSelectOutput.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.AssignmentSelectOutput.SelectedItem

            $Ctrl.Xaml.Io.AssignmentSelectFullname.Text = $Item.Fullname
        }
    }
    AssignmentEditSourceOutput()
    {
        $Ctrl = $This
        
        $Ctrl.Xaml.IO.AssignmentEditSourcePathText.Text        = $Null
        $Ctrl.Xaml.IO.AssignmentEditSourcePathIcon.Source      = $Null
        $Ctrl.Xaml.IO.AssignmentEditSourcePathAssign.IsEnabled = 0

        If ($Ctrl.Xaml.IO.AssignmentEditSourceOutput.SelectedIndex -ne -1)
        {
            $Map = $Ctrl.Xaml.IO.AssignmentEditSourceOutput.SelectedItem
            $Ctrl.Assignment.Edit.SetSelected($Map.Index)

            If (!$Map.Source)
            {
                $Ctrl.Xaml.IO.AssignmentEditSourcePathText.Text   = "{0}\{1}" -f $Ctrl.Workspace.Fullname, $Map.DisplayName
            }
            Else
            {
                $Ctrl.Xaml.IO.AssignmentEditSourcePathText.Text   = $Map.Source   
            }

            $Ctrl.AssignmentEditSourceUpdate()

            $Ctrl.Xaml.IO.AssignmentEditSourcePathAssign.IsEnabled = 1
        }
    }
    AssignmentEditSourcePathText()
    {
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.AssignmentEditSourcePathText.Text -match "(^$|<not set>)")
        {
            $Ctrl.Xaml.IO.AssignmentEditSourcePathIcon.Source       = $Null
            $Ctrl.Xaml.IO.AssignmentEditSourcePathAssign.IsEnabled  = 0
        }
        Else
        {
            $Flag = [System.IO.Directory]::Exists($Ctrl.Xaml.IO.AssignmentEditSourcePathText.Text)
            $Ctrl.Xaml.IO.AssignmentEditSourcePathIcon.Source        = $Ctrl.IconStatus($Flag)
            $Ctrl.Xaml.IO.AssignmentEditSourcePathAssign.IsEnabled   = $Flag
        }
    }
    AssignmentEditSourceUpdate()
    {
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.AssignmentEditSourceOutput.SelectedIndex -ne -1)
        {
            $Map = $Ctrl.Xaml.IO.AssignmentEditSourceOutput.SelectedItem

            # Details
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditProperty,$Null)
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditReference,$Null)

            # Output
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceDirectory,$Null)
            
            # Map
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceMapOutput,$Null)

            # Shader
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceShaderOutput,$Null)

            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceShaderItemOutput,$Null)
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceShaderItemContent,$Null)

            # Texture
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceTextureOutput,$Null)

            # Levelshot
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceLevelshotOutput,$Null)

            # Arena
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceArenaOutput,$Null)

            $Ctrl.Xaml.IO.AssignmentEditSourceArenaContent.Text = $Null

            # Model
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceModelOutput,$Null)

            # Sound
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceSoundOutput,$Null)

            # Music
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceMusicOutput,$Null)

            If ($Map.Property)
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditProperty,$Ctrl.MapFilter($Map.Property))
            }

            If ($Map.Reference)
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditReference,$Map.Reference)
            }

            # Output
            If ($Map.Source.Exists)
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceDirectory,$Map.Source.Output)
            }

            # Map
            If ($Map.Source.Map.Count -gt 0)
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceMapOutput,$Map.Source.Map)
            }

            # Shaders
            If ($Map.Shader)
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceShaderOutput,$Map.Shader.File)
            }

            # Textures
            If ($Map.Texture)
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceTextureOutput,$Map.Texture.File)
            }

            # Levelshot
            If ($Map.Source.Levelshot.Count -gt 0)
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceLevelshotOutput,$Map.Levelshot)
            }

            # Arena
            If ($Map.Arena.Count -gt 0)
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceArenaOutput,$Map.Arena)
            }

            # Model
            If ($Map.Source.Model.Count -gt 0)
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceModelOutput,$Map.Source.Model)
            }

            # Sound
            If ($Map.Source.Sound.Count -gt 0)
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceSoundOutput,$Map.Source.Sound)
            }

            # Music
            If ($Map.Source.Music.Count -gt 0)
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceMusicOutput,$Map.Source.Music)
            }
        }
    }
    AssignmentEditSourcePathAssign()
    {
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.AssignmentEditSourceOutput.SelectedIndex -ne -1)
        {
            $Map = $Ctrl.Xaml.IO.AssignmentEditSourceOutput.SelectedItem

            $Map.SetSource($Ctrl.Assignment.Resource,$Ctrl.Xaml.IO.AssignmentEditSourcePathText.Text)

            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceOutput,$Ctrl.Assignment.Edit.Output)

            $Ctrl.Xaml.IO.AssignmentEditSourceOutput.SelectedItem = $Map
            
            $Ctrl.AssignmentEditSourceUpdate()

            # $Ctrl.AssignmentResourceUpdate()
        }
    }
    AssignmentEditSourceShaderOutput()
    {
        $Ctrl = $This

        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceShaderItemOutput,$Null)
        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceShaderItemContent,$Null)

        $Shader = $Ctrl.Xaml.IO.AssignmentEditSourceShaderOutput.SelectedItem
        If ($Shader)
        {
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceShaderItemOutput,$Shader.Output)
        }
    }
    AssignmentEditSourceShaderItemOutput()
    {
        $Ctrl = $This
        
        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceShaderItemContent,$Null)

        $Item = $Ctrl.Xaml.IO.AssignmentEditSourceShaderItemOutput.SelectedItem
        If ($Item)
        {
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceShaderItemContent,$Item.Content)
        }
    }
    AssignmentEditSourceTextureOutput()
    {
        $Ctrl = $This

        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceTextureProperty,$Null)
        $Item = $Ctrl.Xaml.IO.AssignmentEditSourceTextureOutput.SelectedItem
        If ($Item)
        {
            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceTextureProperty,$Item)
        }
    }
    AssignmentEditSourceLevelshot([String]$Source)
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Loading [~] Levelshot: $Source")

        $Ctrl.Xaml.IO.AssignmentEditSourceLevelshotImage.Source = $Null

        $Ctrl.Xaml.IO.AssignmentEditSourceLevelshotImage.Source = $Ctrl.GenerateBitmap($Source)
    }
    AssignmentEditSourceLevelshotOutput()
    {
        $Ctrl = $This

        $Ctrl.Xaml.IO.AssignmentEditSourceLevelshotImage.Source = $Null
        If ($Ctrl.Xaml.IO.AssignmentEditSourceLevelshotOutput.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.AssignmentEditSourceLevelshotOutput.SelectedItem
            If ($Item)
            {
                # $Ctrl.Xaml.IO.AssignmentEditSourceLevelshotImage.Source = $Item.Fullname
                $Ctrl.AssignmentEditSourceLevelshot($Item.Fullname) 
                # ^ this method is slower, but allows the screenshot to be changed and not locked by the UI
            }
        }
    }
    AssignmentEditSourceArenaOutput()
    {
        $Ctrl = $This

        $Ctrl.Xaml.IO.AssignmentEditSourceArenaContent.Text = $Null

        $Item = $Ctrl.Xaml.IO.AssignmentEditSourceArenaOutput.SelectedItem
        If ($Item)
        {
            $Ctrl.Xaml.IO.AssignmentEditSourceArenaContent.Text = $Item.Content.Line -join "`n"
        }
    }
    AboutBfg20kBanner([String]$Source)
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Loading [~] Banner: $Source")

        $Ctrl.Xaml.IO.AboutBfg20kBanner.Source = $Null
        $Ctrl.Xaml.IO.AboutBfg20kBanner.Source = $Ctrl.GenerateBitmap($Source)
    }
    Stage([String]$Name)
    {
        $This.Update(0,"Staging [~] $Name")

        $Ctrl = $This

        Switch ($Name)
        {
            Config
            {
                $Ctrl.Xaml.IO.ConfigInstall.Add_Click(
                {
                    $Ctrl.ConfigInstall()
                })

                $Ctrl.Xaml.IO.ConfigUninstall.Add_Click(
                {
                    $Ctrl.ConfigUninstallPrompt()
                })

                $Ctrl.Xaml.IO.ConfigScan.Add_Click(
                {
                    $Ctrl.ConfigScan()
                })

                $Ctrl.Xaml.IO.ConfigRefresh.Add_Click(
                {
                    $Ctrl.ConfigRefresh()
                })

                $Ctrl.Xaml.IO.ConfigComponent.Add_GotFocus(
                {
                    $Ctrl.Xaml.IO.ConfigSettings.SelectedIndex   = -1
                    $Ctrl.Xaml.IO.ConfigRadiant.SelectedIndex    = -1
                    $Ctrl.Xaml.IO.ConfigDependency.SelectedIndex = -1
                })

                $Ctrl.Xaml.IO.ConfigComponent.Add_SelectionChanged(
                {
                    $Ctrl.ConfigComponent()
                })

                $Ctrl.Xaml.IO.ConfigSettings.Add_GotFocus(
                {
                    $Ctrl.Xaml.IO.ConfigComponent.SelectedIndex  = -1
                    $Ctrl.Xaml.IO.ConfigRadiant.SelectedIndex    = -1
                    $Ctrl.Xaml.IO.ConfigDependency.SelectedIndex = -1
                })

                $Ctrl.Xaml.IO.ConfigSettings.Add_SelectionChanged(
                {
                    $Ctrl.ConfigSettings()
                })

                $Ctrl.Xaml.IO.ConfigRadiant.Add_GotFocus(
                {
                    $Ctrl.Xaml.IO.ConfigComponent.SelectedIndex  = -1
                    $Ctrl.Xaml.IO.ConfigSettings.SelectedIndex   = -1
                    $Ctrl.Xaml.IO.ConfigDependency.SelectedIndex = -1
                })

                $Ctrl.Xaml.IO.ConfigRadiant.Add_SelectionChanged(
                {
                    $Ctrl.ConfigRadiant()
                })

                $Ctrl.Xaml.IO.ConfigDependency.Add_GotFocus(
                {
                    $Ctrl.Xaml.IO.ConfigComponent.SelectedIndex  = -1
                    $Ctrl.Xaml.IO.ConfigSettings.SelectedIndex   = -1
                    $Ctrl.Xaml.IO.ConfigRadiant.SelectedIndex    = -1
                })

                $Ctrl.Xaml.IO.ConfigDependency.Add_SelectionChanged(
                {
                    $Ctrl.ConfigDependency()   
                })

                $Ctrl.Xaml.IO.ConfigPropertyValueText.Add_TextChanged(
                {
                    $Ctrl.ConfigPropertyValueText()
                })

                $Ctrl.Xaml.IO.ConfigPropertyBrowse.Add_Click(
                {
                    $Ctrl.ConfigPropertyBrowse() 
                })

                $Ctrl.Xaml.IO.ConfigPropertyValueText.Add_GotFocus(
                {
                    $Current = $Ctrl.ConfigSelected()
                    $Item    = $Current.SelectedItem
                    $Value   = $Ctrl.Xaml.IO.ConfigPropertyValueText.Text
                
                    If ($Value -eq $Item.Default)
                    {
                        $Ctrl.Xaml.IO.ConfigPropertyValueText.Text = ""
                    }
                })
    
                $Ctrl.Xaml.IO.ConfigPropertyValueText.Add_LostFocus(
                {
                    $Current = $Ctrl.ConfigSelected()
                    $Item    = $Current.SelectedItem
                    $Value   = $Ctrl.Xaml.IO.ConfigPropertyValueText.Text
                
                    If ($Value -ne $Item.Value)
                    {
                        $Ctrl.Xaml.IO.ConfigPropertyValueText.Text = $Value
                    }
                })

                $Ctrl.Xaml.IO.ConfigPropertyApply.Add_Click(
                {
                    $Ctrl.ConfigPropertyApply()
                })
            }
            Dependency
            {
                $Ctrl.Xaml.IO.DependencyOutput.Add_SelectionChanged(
                {
                    $Ctrl.DependencyOutput()
                })

                $Ctrl.Xaml.IO.DependencyInstall.Add_Click(
                {
                    # $Ctrl.DependencyInstall()
                })

                $Ctrl.Xaml.IO.DependencyClear.Add_Click(
                {
                    # $Ctrl.DependencyClear()
                })

                $Ctrl.Xaml.IO.DependencyEdit.Add_Click(
                {
                    # $Ctrl.DependencyEdit()
                })

                $Ctrl.Xaml.IO.DependencyPathText.Add_TextChanged(
                {
                    # $Ctrl.DependencyPathText()
                })

                $Ctrl.Xaml.IO.DependencyPathBrowse.Add_Click( 
                {
                    # $Ctrl.DependencyPathBrowse()
                })

                $Ctrl.Xaml.IO.DependencyPathApply.Add_Click( 
                {
                    # $Ctrl.DependencyPathApply()
                })
            }
            Component
            {
                $Ctrl.Xaml.IO.ComponentOutput.Add_SelectionChanged(
                {
                    $Ctrl.ComponentOutput()
                })

                $Ctrl.Xaml.IO.ComponentOutput.Add_MouseDoubleClick(
                {
                    $Ctrl.ComponentSelect()
                })

                $Ctrl.Xaml.IO.ComponentSlotPathText.Add_TextChanged(
                {
                    $Ctrl.ComponentSlotPathText()
                })

                $Ctrl.Xaml.IO.ComponentSlotPathText.Add_GotFocus(
                {
                    $Value = $Ctrl.Xaml.IO.ComponentSlotPathText.Text
                    If ($Value -eq "<not set>")
                    {
                        $Ctrl.Xaml.IO.ComponentSlotPathText.Text = ""
                    }
                })

                $Ctrl.Xaml.IO.ComponentSlotPathText.Add_LostFocus(
                {
                    $Value = $Ctrl.Xaml.IO.ComponentSlotPathText.Text
                    If ($Value -eq "")
                    {
                        $Ctrl.Xaml.IO.ComponentSlotPathText.Text = "<not set>"
                    }
                })

                $Ctrl.Xaml.IO.ComponentSlotPathText.Add_MouseDoubleClick(
                {
                    $Ctrl.Xaml.IO.ComponentSlotPathText.Text = ""
                })

                $Ctrl.Xaml.IO.ComponentSlotPathBrowse.Add_Click(
                {
                    $Ctrl.ComponentSlotPathBrowse()
                })

                $Ctrl.Xaml.IO.ComponentSlotAdd.Add_Click(
                {
                    $Ctrl.ComponentSlotAdd()
                })

                $Ctrl.Xaml.IO.ComponentSlotRemove.Add_Click(
                {
                    $Ctrl.ComponentSlotRemove()
                })

                $Ctrl.Xaml.IO.ComponentBase.Add_SelectionChanged(
                {
                    $Ctrl.ComponentBase()
                })

                $Ctrl.Xaml.IO.ComponentBasePackage.Add_SelectionChanged(
                {
                    $Ctrl.ComponentBasePackage()
                })

                $Ctrl.Xaml.IO.ComponentBasePackage.Add_MouseDoubleClick(
                {
                    $Ctrl.ComponentBasePackagePopulate()
                })

                $Ctrl.Xaml.IO.ComponentBasePackageProperty.Add_SelectionChanged(
                {
                    $Ctrl.ComponentBasePackageProperty()
                })

                $Ctrl.Xaml.IO.ComponentBasePackageFilter.Add_TextChanged(
                {
                    $Ctrl.ComponentBasePackageFilter()
                })
                
                $Ctrl.Xaml.IO.ComponentBasePackageRefresh.Add_Click(
                {
                    $Ctrl.ComponentBasePackageRefresh()
                })

                $Ctrl.Xaml.IO.ComponentBasePackageEntry.Add_MouseDoubleClick(
                {
                    $Ctrl.ComponentBasePackageEntry()
                })

                $Ctrl.Xaml.IO.ComponentBaseOutputControl.Add_SelectionChanged(
                { 
                    $Ctrl.ComponentBaseOutputControlReset()
                })

                # [Shader]
                $Ctrl.Xaml.IO.ComponentBaseShaderItemOutput.Add_SelectionChanged(
                {
                    $Ctrl.ComponentBaseShaderItemOutput()
                })

                # [Levelshot]
                # [Arena]
                # [Model]
                # [Sound]
                $Ctrl.Audio.Sound.Player.Add_PositionChanged(
                {
                    param($sender, $seconds)
                    $Ctrl.ComponentBaseSoundTrackbarPosition($seconds)
                })

                $Ctrl.Xaml.IO.ComponentBaseSoundPlay.Add_Click(
                {
                    $Ctrl.ComponentBaseSoundPlay()
                })

                $Ctrl.Xaml.IO.ComponentBaseSoundTrackbar.Add_PreviewMouseLeftButtonDown(
                {
                    param($sender,$args)
                    $Ctrl.ComponentBaseSoundTrackbar($sender,$args)
                })

                $Ctrl.Xaml.IO.ComponentBaseSoundTrackbar.Add_PreviewMouseLeftButtonUp(
                {
                    param($sender,$args)
                    $Ctrl.ComponentBaseSoundTrackbar($sender,$args)
                })

                $Ctrl.Xaml.IO.ComponentBaseSoundTrackbar.Add_ValueChanged(
                {
                    param($sender,$args)
                    $Ctrl.ComponentBaseSoundTrackbar($sender,$args)
                })

                $Ctrl.Xaml.IO.ComponentBaseSoundStop.Add_Click(
                {
                    $Ctrl.ComponentBaseSoundStop()
                })

                # [Music]
                $Ctrl.Audio.Music.Player.Add_PositionChanged(
                {
                    param($sender, $seconds)
                    $Ctrl.ComponentBaseMusicTrackbarPosition($seconds)
                })

                $Ctrl.Xaml.IO.ComponentBaseMusicPlay.Add_Click(
                {
                    $Ctrl.ComponentBaseMusicPlay()
                })

                # Drag start
                $Ctrl.Xaml.IO.ComponentBaseMusicTrackbar.Add_PreviewMouseLeftButtonDown(
                {
                    param($sender,$args)
                    $Ctrl.ComponentBaseMusicTrackbar($sender,$args)
                })

                # Drag end
                $Ctrl.Xaml.IO.ComponentBaseMusicTrackbar.Add_PreviewMouseLeftButtonUp(
                {
                    param($sender,$args)
                    $Ctrl.ComponentBaseMusicTrackbar($sender,$args)
                })

                # Value changed (still needed!)
                $Ctrl.Xaml.IO.ComponentBaseMusicTrackbar.Add_ValueChanged(
                {
                    param($sender,$args)
                    $Ctrl.ComponentBaseMusicTrackbar($sender,$args)
                })

                $Ctrl.Xaml.IO.ComponentBaseMusicStop.Add_Click(
                {
                    $Ctrl.ComponentBaseMusicStop()
                })

                # [Text]
            }
            Radiant
            {
                $Ctrl.Xaml.IO.RadiantOutput.Add_SelectionChanged(
                {
                    $Ctrl.RadiantOutput()
                })

                $Ctrl.Xaml.IO.RadiantOutput.Add_MouseDoubleClick(
                {
                    $Ctrl.RadiantSelect()
                })

                $Ctrl.Xaml.IO.RadiantFileProperty.Add_SelectionChanged(
                {
                    $Ctrl.RadiantFileProperty()
                })

                $Ctrl.Xaml.IO.RadiantFileFilter.Add_TextChanged(
                {
                    $Ctrl.RadiantFileFilter()
                })

                $Ctrl.Xaml.IO.RadiantFileRefresh.Add_Click(
                {
                    $Ctrl.RadiantFileRefresh()
                })

                $Ctrl.Xaml.IO.RadiantLaunch.Add_Click(
                {
                    $Ctrl.RadiantLaunch()
                })

                $Ctrl.Xaml.IO.RadiantLaunchParamText.Add_TextChanged(
                {
                    $Ctrl.RadiantLaunchParamText()
                })

                $Ctrl.Xaml.IO.RadiantBrowse.Add_Click(
                {
                    $Ctrl.RadiantBrowse()
                })

                $Ctrl.Xaml.IO.RadiantClose.Add_Click(
                {
                    $Ctrl.RadiantClose()
                })
            }
            Workspace
            {
                $Ctrl.Xaml.IO.WorkspaceSlot.Add_SelectionChanged(
                {
                    $Ctrl.WorkspaceSlot()
                })

                $Ctrl.Xaml.IO.WorkspaceOutput.Add_SelectionChanged(
                {
                    $Ctrl.WorkspaceOutput()
                })

                $Ctrl.Xaml.IO.WorkspaceOutputPathText.Add_TextChanged(
                {
                    $Ctrl.WorkspaceOutputPathText()
                })

                $Ctrl.Xaml.IO.WorkspaceOutputPathText.Add_GotFocus(
                {
                    If ($Ctrl.Xaml.IO.WorkspaceOutputPathText.Text -match "<not set>")
                    {
                        $Ctrl.Xaml.IO.WorkspaceOutputPathText.Text = ""
                    }
                })

                $Ctrl.Xaml.IO.WorkspaceOutputPathText.Add_LostFocus(
                {
                    If ($Ctrl.Xaml.IO.WorkspaceOutputPathText.Text -match "^$")
                    {
                        $Ctrl.Xaml.IO.WorkspaceOutputPathText.Text = "<not set>"
                    }
                })

                $Ctrl.Xaml.IO.WorkspaceOutputPathText.Add_MouseDoubleClick(
                {
                    $Ctrl.Xaml.IO.WorkspaceOutput.SelectedIndex = -1
                    $Ctrl.Xaml.IO.WorkspaceOutputPathText.Text  = ""
                })

                $Ctrl.Xaml.IO.WorkspaceOutputAdd.Add_Click(
                {
                    $Ctrl.WorkspaceOutputAdd()
                })

                $Ctrl.Xaml.IO.WorkspaceOutputRemove.Add_Click(
                {
                    $Ctrl.WorkspaceOutputRemove()
                })

                $Ctrl.Xaml.IO.WorkspaceOutputRefresh.Add_Click(
                {
                    $Ctrl.WorkspaceOutputRefresh()
                })
            }
            Assignment
            {
                # Resource
                $Ctrl.Xaml.IO.AssignmentResourceOutput.Add_SelectionChanged(
                {
                    $Ctrl.AssignmentResourceOutput()
                })

                $Ctrl.Xaml.IO.AssignmentResourcePathText.Add_TextChanged(
                {
                    $Ctrl.AssignmentResourcePathText()
                })

                $Ctrl.Xaml.IO.AssignmentResourcePathText.Add_GotFocus(
                {
                    If ($Ctrl.Xaml.IO.AssignmentResourcePathText.Text -eq "<not set>")
                    {
                        $Ctrl.Xaml.IO.AssignmentResourcePathText.Text = ""
                    }
                })

                $Ctrl.Xaml.IO.AssignmentResourcePathText.Add_LostFocus(
                {
                    If ($Ctrl.Xaml.IO.AssignmentResourcePathText.Text -eq "")
                    {
                        $Ctrl.Xaml.IO.AssignmentResourcePathText.Text = "<not set>"
                    }
                })

                $Ctrl.Xaml.IO.AssignmentResourcePathText.Add_MouseDoubleClick(
                {
                    $Ctrl.Xaml.IO.AssignmentResourceOutput.SelectedIndex = -1
                    $Ctrl.Xaml.IO.AssignmentResourcePathText.Text        = ""
                })

                $Ctrl.Xaml.IO.AssignmentResourceBrowse.Add_Click(
                {
                    $Ctrl.AssignmentResourceBrowse()
                })

                $Ctrl.Xaml.IO.AssignmentResourceCancel.Add_Click(
                {
                    $Ctrl.AssignmentResourceCancel()
                })

                $Ctrl.Xaml.IO.AssignmentResourceAdd.Add_Click(
                {
                    $Ctrl.AssignmentResourceAdd()
                })

                $Ctrl.Xaml.IO.AssignmentResourceRemove.Add_Click(
                {
                    $Ctrl.AssignmentResourceRemove()
                })

                $Ctrl.Xaml.IO.AssignmentResourceBrowseTree.Add_SelectionChanged(
                {
                    $Ctrl.AssignmentResourceBrowseTree()
                })

                $Ctrl.Xaml.IO.AssignmentResourceBrowseList.Add_SelectionChanged(
                {
                    $Ctrl.AssignmentResourceBrowseList()
                })

                $Ctrl.Xaml.IO.AssignmentResourceBrowseList.Add_MouseDoubleClick(
                {
                    $Ctrl.AssignmentResourceBrowseListOpen()
                })

                $Ctrl.Xaml.IO.AssignmentResourceBack.Add_Click(
                {
                    $Ctrl.AssignmentResourceBack()
                })

                $Ctrl.Xaml.IO.AssignmentResourceSelect.Add_Click(
                {
                    $Ctrl.AssignmentResourceSelect()
                })

                $Ctrl.Xaml.IO.AssignmentResourceShaderOutput.Add_SelectionChanged(
                {
                    $Ctrl.AssignmentResourceShaderOutput()
                })

                # // Debugging datagrid
                $Ctrl.Xaml.IO.AssignmentResourceShaderItemOutput.Add_SelectionChanged(
                {
                    $Ctrl.AssignmentResourceShaderItemOutput()
                })

                $Ctrl.Xaml.IO.AssignmentResourceTextureOutput.Add_SelectionChanged(
                {
                    $Ctrl.AssignmentResourceTextureOutput()
                })

                # Select
                $Ctrl.Xaml.IO.AssignmentSelectPathText.Add_TextChanged(
                {
                    $Ctrl.AssignmentSelectPathText()
                })

                $Ctrl.Xaml.IO.AssignmentSelectPathText.Add_GotFocus(
                {
                    If ($Ctrl.Xaml.IO.AssignmentSelectPathText.Text -eq "<not set>")
                    {
                        $Ctrl.Xaml.IO.AssignmentSelectPathText.Text = ""
                    }
                })

                $Ctrl.Xaml.IO.AssignmentSelectPathBrowse.Add_Click(
                {
                    $Ctrl.AssignmentSelectPathBrowse()
                })

                $Ctrl.Xaml.IO.AssignmentSelectPathOpen.Add_Click(
                {
                    $Ctrl.AssignmentSelectPathOpen()   
                })

                $Ctrl.Xaml.IO.AssignmentSelectPathClose.Add_Click(
                {
                    $Ctrl.AssignmentSelectPathClose()
                })

                $Ctrl.Xaml.IO.AssignmentSelectFilterText.Add_TextChanged(
                {
                    $Ctrl.AssignmentSelectFilterText()
                })

                $Ctrl.Xaml.IO.AssignmentSelectRefresh.Add_Click(
                {
                    $Ctrl.AssignmentSelectRefresh()
                })

                $Ctrl.Xaml.IO.AssignmentSelectAssign.Add_Click(
                {
                    $Ctrl.AssignmentSelectAssign()
                })

                $Ctrl.Xaml.IO.AssignmentSelectOutput.Add_SelectionChanged(
                {
                    $Ctrl.AssignmentSelectOutput()
                })

                $Ctrl.Xaml.IO.AssignmentEditSourceOutput.Add_SelectionChanged(
                {
                    $Ctrl.AssignmentEditSourceOutput()
                })

                $Ctrl.Xaml.IO.AssignmentEditSourcePathText.Add_TextChanged(
                {
                    $Ctrl.AssignmentEditSourcePathText()
                })

                $Ctrl.Xaml.IO.AssignmentEditSourcePathAssign.Add_Click(
                {
                    $Ctrl.AssignmentEditSourcePathAssign()
                })

                $Ctrl.Xaml.IO.AssignmentEditSourceShaderOutput.Add_SelectionChanged(
                {
                    $Ctrl.AssignmentEditSourceShaderOutput()
                })

                $Ctrl.Xaml.IO.AssignmentEditSourceShaderItemOutput.Add_SelectionChanged(
                {
                    $Ctrl.AssignmentEditSourceShaderItemOutput()
                })

                $Ctrl.Xaml.IO.AssignmentEditSourceTextureOutput.Add_SelectionChanged(
                {
                    $Ctrl.AssignmentEditSourceTextureOutput()
                })

                $Ctrl.Xaml.IO.AssignmentEditSourceLevelshotOutput.Add_SelectionChanged(
                {
                    $Ctrl.AssignmentEditSourceLevelshotOutput()
                })

                $Ctrl.Xaml.IO.AssignmentEditSourceArenaOutput.Add_SelectionChanged(
                {
                    $Ctrl.AssignmentEditSourceArenaOutput()
                })
            }
            Steam
            {

            }
            Console
            {

            }
            About
            {

            }
        }
    }
    Initial([String]$Name)
    {
        $This.Update(0,"Initial [~] $Name")

        $Ctrl = $This

        Switch ($Name)
        {
            Config
            {
                $Ctrl.Xaml.IO.ConfigInstall.IsEnabled           = 0
                $Ctrl.Xaml.IO.ConfigUninstall.IsEnabled         = 0
                $Ctrl.Xaml.IO.ConfigRefresh.IsEnabled           = 1

                $Ctrl.Xaml.IO.ConfigResource.IsEnabled          = 1
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigResource,       $Null)

                $Ctrl.Xaml.IO.ConfigPropertyNameText.IsEnabled  = 0
                $Ctrl.Xaml.IO.ConfigPropertyValueText.IsEnabled = 1
                $Ctrl.Xaml.IO.ConfigPropertyBrowse.IsEnabled    = 0
                $Ctrl.Xaml.IO.ConfigPropertyApply.IsEnabled     = 0
            }
            Dependency
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.DependencyOutput,     $Null)

                $Ctrl.Xaml.IO.DependencyInstall.IsEnabled       = 0
                $Ctrl.Xaml.IO.DependencyClear.IsEnabled         = 0
                $Ctrl.Xaml.IO.DependencyEdit.IsEnabled          = 0
                $Ctrl.Xaml.IO.DependencyPathText.IsEnabled      = 0
                $Ctrl.Xaml.IO.DependencyPathIcon.IsEnabled      = 0
                $Ctrl.Xaml.IO.DependencyPathBrowse.IsEnabled    = 0
                $Ctrl.Xaml.IO.DependencyPathApply.IsEnabled     = 0

                $Ctrl.Reset($Ctrl.Xaml.IO.DependencyProperty,   $Null)
            }
            Component
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentOutput,       $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBase,         $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBasePackage,  $Null)

                $Ctrl.ComponentBaseClear()

                $Ctrl.Xaml.IO.ComponentSlot.SelectedIndex      = 0
                $Ctrl.Xaml.IO.ComponentSlot.IsHitTestVisible   = 0
                $Ctrl.Xaml.IO.ComponentSlotPathText.Text       = ""
                $Ctrl.Xaml.IO.ComponentSlotPathIcon.Source     = $Null
                $Ctrl.Xaml.IO.ComponentSlotAdd.IsEnabled       = 0
                $Ctrl.Xaml.IO.ComponentSlotRemove.IsEnabled    = 0
            }
            Radiant
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.RadiantOutput,        $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.RadiantProperty,      $Null)

                $Ctrl.Xaml.IO.RadiantLaunch.IsEnabled          = 0
                $Ctrl.Xaml.IO.RadiantLaunchParamText.IsEnabled = 0
                $Ctrl.Xaml.IO.RadiantLaunchParamText.Text      = "<Double click an editor to use these controls>"
                $Ctrl.Xaml.IO.RadiantLaunchParamIcon.IsEnabled = 0
                $Ctrl.Xaml.IO.RadiantBrowse.IsEnabled          = 0
                $Ctrl.Xaml.IO.RadiantClose.IsEnabled           = 0
            }
            Workspace
            {
                $Ctrl.Xaml.IO.WorkspaceSlot.SelectedIndex       = 1
                $Ctrl.Xaml.IO.WorkspaceOutputRefresh.IsEnabled  = 0

                $Ctrl.Xaml.IO.WorkspaceOutputPathText.Text      = "<not set>"
                $Ctrl.Xaml.IO.WorkspaceOutputPathIcon.Source    = $Null
            }
            Assignment
            {
                # Resource
                $Ctrl.Xaml.IO.AssignmentResourcePathText.Text       = "<not set>"
                
                $Ctrl.Xaml.IO.AssignmentResourceAdd.IsEnabled       = 0
                $Ctrl.Xaml.IO.AssignmentResourceRemove.IsEnabled    = 0

                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceContent,            $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceShaderOutput,       $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceShaderItemOutput,   $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceShaderItemContent,  $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceTextureOutput,      $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentResourceTextureProperty,    $Null)

                # Select
                $Ctrl.Xaml.IO.AssignmentSelectPathText.Text         = "<not set>"  
                $Ctrl.Xaml.IO.AssignmentSelectPathIcon.Source       = $Null
                $Ctrl.Xaml.IO.AssignmentSelectPathBrowse.IsEnabled  = 1
                $Ctrl.Xaml.IO.AssignmentSelectPathOpen.IsEnabled    = 0
                $Ctrl.Xaml.IO.AssignmentSelectPathClose.IsEnabled   = 0
                $Ctrl.Xaml.IO.AssignmentSelectFilterText.IsEnabled  = 0
                $Ctrl.Xaml.IO.AssignmentSelectRefresh.IsEnabled     = 0
                $Ctrl.Xaml.IO.AssignmentSelectAssign.DataContext    = $Ctrl.Assignment

                $Ctrl.Xaml.IO.AssignmentSelectFilterProperty.SelectedIndex = 0

                # Edit
                $Ctrl.Xaml.IO.AssignmentEditSourceLevelshotImage.Source    = $Null
            }
            Steam
            {

            }
            Console
            {

            }
            About
            {
                $Ctrl.Xaml.IO.AboutBfg20kText.Text   = $Ctrl.Bfg20kText()
                $Ctrl.AboutBfg20kBanner($Ctrl.Bfg20kIcon())
                $Ctrl.Reset($Ctrl.Xaml.IO.AboutBfg20kContact,$Ctrl.Module)
            }
        }
    }
    StageXaml()
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Staging [~] XAML")

        # Event handlers for the xaml
        $Ctrl.Stage("Config")
        $Ctrl.Stage("Dependency")
        $Ctrl.Stage("Component")
        $Ctrl.Stage("Radiant")
        $Ctrl.Stage("Workspace")
        $Ctrl.Stage("Assignment")
        $Ctrl.Stage("About")

        # Initial settings
        $Ctrl.Initial("Config")
        $Ctrl.Initial("Dependency")
        $Ctrl.Initial("Component")
        $Ctrl.Initial("Radiant")
        $Ctrl.Initial("Workspace")
        $Ctrl.Initial("Assignment")
        $Ctrl.Initial("About")

        $Ctrl.Update(1,"Staged [+]")
    }
    Prime()
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Priming [~] Q3A-Live MDK+ by <BFG20K>")

        If (!$Ctrl.Resource -or !$Ctrl.Registry)
        {
            $Ctrl.GetConfig()
        }
        If (!$Ctrl.Component)
        {
            $Ctrl.GetComponent()
        }
        If (!$Ctrl.Dependency)
        {
            $Ctrl.GetDependency()
        }
        If (!$Ctrl.Radiant)
        {
            $Ctrl.GetRadiant()
        }
        If (!$Ctrl.Workspace)
        {
            $Ctrl.GetWorkspace()
        }
        If (!$Ctrl.Assignment)
        {
            $Ctrl.GetAssignment()
        }

        $Ctrl.Update(1,"Primed [+]")
    }
    Reload()
    {
        $This.GetXaml()
        $This.GetThreading()
        $This.GetAudio()
        $This.Prime()
        $This.StageXaml()
        $This.ConfigRefresh()
        $This.Xaml.Invoke()
    }
    Reset([Object]$xSender,[Object]$Object)
    {
        # // Debugging 
        If ($This.Module.Mode -eq 2)
        {
            [Console]::WriteLine($xSender.Name)
        }

        $xSender.Items.Clear()
        ForEach ($Item in $Object)
        {
            $xSender.Items.Add($Item)
        }
    }
    ScrollToTop([Object]$xSender)
    {
        If ($xSender.Items.Count -gt 0)
        {
            $First = $xSender.Items[0]
            $xSender.ScrollIntoView($First)
        }
    }
    [String] Escape([String]$String)
    {
        Return [Regex]::Escape($String)
    }
    [String] IconStatus([UInt32]$Flag)
    {
        Return $This.Module._Control(@("failure.png","success.png","warning.png")[$Flag]).Fullname
    }
    [String] LogPath()
    {   
        Return $This.DefaultLogPath()
    }
    [String] Now()
    {
        Return [DateTime]::Now.ToString("yyyy-MMdd_HHmmss")
    }
    [String] SecondsToString([Double]$Seconds)
    {
        Return [TimeSpan]::FromSeconds($Seconds).ToString("mm\:ss")
    }
    [String] ProgramData()
    {
        Return [Environment]::GetEnvironmentVariable("ProgramData")
    }
    [String] Author()
    {
        Return "Secure Digits Plus LLC"
    }
    [String] CompanyName()
    {
        Return "Secure Digits Plus LLC"
    }
    [String] Bfg20kText()
    {
        Return "The BFG20K is a high powered variant of the big fucking gun.",
        " ",
        "It features a <minaturized portable nuclear fusion reactor> that feeds on <cells> of plasma in",
        "order to fire a <high powered ball of energy> that- while moving, scans for enemies, emitting",
        "continuous plasma beam radiation that deals fatal damage for <every> target it detects…",
        "And explodes when it strikes a surface… usually leaving a trail of multiple lifeless foes.",
        " ",
        "It's smaller variant, the <BFG10K>, was used to shoot a hole into the surface of Mars.",
        " ",
        "Make no mistake, this thing is <dangerous> for <all involved>… including the one firing it.",
        " ",
        "The <blast radius> is so large, that no one should ever fire it in confined areas.",
        "So, use a <smaller gun> for that.",
        " ",
        "If you hear the sound it makes and you didn't fire it... it's already too late.",
        " ",
        "The <plasma> has a high propensity to (pierce + burn) ALL types of <armor>, as well as",
        "<liquify> (and/or) <vaporize> flesh in seconds or less.",
        " ",
        "If you see someone carrying this thing...? Run.",
        "And if it you fire it, and it manages to explode in your face…?",
        "See you on the other side, pal.",
        " ",
        "Cause the last thing they'll say is that you <should've used a smaller gun>." -join "`n"
    }
    [String] Bfg20kIcon()
    {
        Return "{0}\bfg20k-400x300.jpg" -f $This.Resource.Gfx()
    }
    [String] ProjectName()
    {
        Return "Q3A-Live"
    }
    [String] UninstallPath()
    {
        Return "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
    }
    [String] UninstallPath_x64()
    {
        Return "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
    }
    [String[]] UninstallPath_x86_64()
    {
        Return $This.UninstallPath(), $This.UninstallPath_x64()
    }
    [String] DefaultResourcePath()
    {
        Return "{0}\{1}\{2}" -f [Environment]::GetEnvironmentVariable("ProgramData"), $This.CompanyName(), $This.ProjectName()
    }
    [String] DefaultLogPath()
    {
        Return "{0}\logs" -f $This.DefaultResourcePath()
    }
    [String] DefaultDependencyPath()
    {
        Return "{0}\dependencies" -f $This.DefaultResourcePath()
    }
    [String] DefaultRegistryPath()
    {
        Return "HKLM:\Software\Policies\{0}\{1}" -f $This.CompanyName(), $This.ProjectName()
    }
    [String] DefaultUninstallPath()
    {
        Return "{0}\{1}" -f $This.UninstallPath(), $This.ProjectName()
    }
    [String] DefaultVersion()
    {
        Return [DateTime]::Now.ToString("yyyy.MM.0")
    }
    [String] DefaultIcon()
    {
        Return $This.Module._Graphic("icon.ico").Fullname
    }
    [UInt32] CheckPathChars([String]$Path)
    {
        Return @([Char[]]$Path | ? { $_ -in [System.IO.Path]::GetInvalidPathChars() }).Count
    }
    [Bool] CheckDirectory([String]$Path)
    {
        Return [System.IO.Directory]::Exists($Path)
    }
    [Bool] CheckFile([String]$Path)
    {
        Return [System.IO.File]::Exists($Path)
    }
    [Object[]] GetFiles($Path)
    {
        Return [System.IO.DirectoryInfo]::new($Path).EnumerateFiles()
    }
    [Object[]] GetDirectories($Path)
    {
        Return [System.IO.DirectoryInfo]::new($Path).EnumerateDirectories()
    }
    [String] GetShaderListPath()
    {
        If ([System.IO.Directory]::Exists($This.Registry.Map))
        {
            Return "{0}\scripts\shaderlist.txt" -f ($This.Registry.Map | Split-Path -Parent)
        }
        Else
        {
            Return $Null
        }
    }
    [Object] FEModule()
    {
        Return Get-FEModule -Mode 1
    }
    [Object] Q3ALiveByteSize([String]$Name,[UInt64]$Bytes)
    {
        Return [Q3ALive.ByteSize]::New($Name,$Bytes)
    }
    [Object] Q3ALiveFileSystemObject([Object]$File)
    {
        Return [Q3ALive.FileSystemObject]::New($File)
    }
    [Object] Q3ALiveXaml()
    {
        Return [XamlWindow][Q3ALiveXaml]::Content
    }
    [Object] Q3ALiveThreadingService()
    {
        If ($This.Xaml)
        {
            Return [Q3ALive.ThreadingService]::New($This.Xaml.IO.Dispatcher)
        }
        Else
        {
            Return $Null
        }
    }
    [Object] Q3ALiveAudioController()
    {
        Return [Q3ALiveAudioController]::New()
    }
    [Object] Q3ALiveResourceRoot([String]$Path)
    {
        Return [Q3ALiveResourceRoot]::New($Path)
    }
    [Object] Q3ALiveRegistryUninstall([UInt32]$Index,[Object]$Object)
    {
        Return [Q3ALiveRegistryUninstall]::New($Index,$Object)
    }
    [Object] Q3ALiveRegistryBase([String]$Fullname)
    {
        Return [Q3ALiveRegistryBase]::New($Fullname)
    }
    [Object] Q3ALiveComponentList()
    {
        Return [Q3ALive.ComponentList]::New()
    }
    [Object] Q3ALiveDependencyList()
    {
        Return [Q3ALiveDependencyList]::New()
    }
    [Object] Q3ALiveRadiantList()
    {
        Return [Q3ALiveRadiantList]::New()
    }
    [Object] Q3ALiveWorkspace()
    {
        Return [Q3ALiveWorkspace]::New()
    }
    [Object] Q3ALiveAssignmentResourceList()
    {
        Return [Q3ALiveAssignmentResourceList]::New()
    }
    [Object] Q3ALiveAssignmentSelectFileList()
    {
        Return [Q3ALive.AssignmentSelectFileList]::New()
    }
    [Object] Q3ALiveAssignmentEditItemList()
    {
        Return [Q3ALiveAssignmentEditItemList]::New()
    }
    [Object] Q3ALiveImageObject([Object]$FileEntry)
    {
        Return [Q3ALive.ImageObject]::New($FileEntry)
    }
    [Object] Q3ALiveShaderObject([Object]$FileEntry)
    {
        Return [Q3ALiveShaderFileItem]::New($FileEntry)
    }
    [Object] Q3ALiveAudioObject([Object]$FileEntry)
    {
        Return [Q3ALive.AudioObject]::New($FileEntry)
    }
    [Object] Q3ALiveArenaObject([Object]$FileEntry)
    {
        Return [Q3ALiveArenaObject]::New($FileEntry)
    }
    [Object] Q3ALiveTextObject([Object]$FileEntry)
    {
        Return [Q3ALiveTextObject]::New($FileEntry)
    }
    [Object] GenerateBitmap([String]$Source)
    {
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()

        # Load the new image into a memory stream
        $MemoryStream          = [System.IO.MemoryStream]::New()
        $FileStream            = [System.IO.File]::OpenRead($Source)
        $FileStream.CopyTo($MemoryStream)
        $FileStream.Close()
        $MemoryStream.Position = 0

        # Reload the new image from the memory stream
        $Bitmap                = [System.Windows.Media.Imaging.BitmapImage]::New()
        $Bitmap.BeginInit()
        $Bitmap.StreamSource   = $MemoryStream
        $Bitmap.CacheOption    = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
        $Bitmap.EndInit()

        Return $Bitmap
    }
    [Object] FileBrowserDialog()
    {
        Return [System.Windows.Forms.OpenFileDialog]::New()
    }
    [Object] FolderBrowserDialog()
    {
        Return [System.Windows.Forms.FolderBrowserDialog]::New()
    }
    [String[]] ResourceInstallType()
    {
        Return [System.Enum]::GetNames([Q3ALive.ResourceInstallType])
    }
    [String[]] RegistryInstallType()
    {
        Return [System.Enum]::GetNames([Q3ALive.RegistryInstallType])
    }
    [String[]] RegistryBaseType()
    {
        Return [System.Enum]::GetNames([Q3ALive.RegistryBaseType])
    }
    [String[]] RegistryReferenceType()
    {
        Return [System.Enum]::GetNames([Q3ALive.RegistryReferenceType])
    }
    [String[]] DefaultShadersType()
    {
        Return [System.Enum]::GetNames([Q3ALive.DefaultShadersType])
    }
    [String[]] AssetType()
    {
        Return [System.Enum]::GetNames([Q3ALive.AssetType])
    }
    [Object[]] PSProperty([Object]$Object)
    {
        Return $Object.PSObject.Properties | ? Name -notmatch "^PS" | Select-Object Name, Value
    }
    [Object[]] PSProperty([Object]$Object,[String[]]$Selected)
    {
        Return $Object.PSObject.Properties | ? Name -in $Selected | Select-Object Name, Value
    }
    [Object[]] ComponentFilter([Object]$Object)
    {
        $Filter = "Base","Executable"

        Return $This.PSProperty($Object,$Filter)
    }
    [Object[]] DependencyFilter([Object]$Object)
    {
        $Filter = "PackageName","PackageType","PackageSize","PackageSource","PackageHash","Executable","Fullname"

        Return $This.PSProperty($Object,$Filter)
    }
    [Object[]] RadiantFilter([Object]$Object)
    {
        $Filter = "Editor","Q3Map2","Bspc"

        Return $This.PSProperty($Object,$Filter)
    }
    [Object[]] MapFilter([Object]$Object)
    {
        $Filter = "Author","Message","Music","Brush","Entity"

        Return $This.PSProperty($Object,$Filter)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Controller>"
    }
}

$Ctrl = [Q3ALiveController]::New()
# $Ctrl.Module.Mode = 2
$Ctrl.Reload()
