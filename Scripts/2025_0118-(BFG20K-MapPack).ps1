# Allows me to create a master (*.pk3) file of my QLive map portfolio

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

Enum MapPackId
{
    kerberos
    tempgrave
    rtcq
    insprod
    crossfire
    breakthru
    ss1138
    suspanim
    tranquilibrium
    deadcenter
    wisdom
    oomh
}

Class MapPackItem
{
    [UInt32] $Index
    [String] $Id
    [String] $Name
    [String] $Fullname
    [UInt32] $Exists
    [String] $Version
    [String] $Target
    [UInt32] $Include = 1
    [Object] $Output
    MapPackItem([String]$Id)
    {
        $This.Id    = $Id
        $This.Index = [UInt32][MapPackId]::$Id
    }
    Check()
    {
        If (!$This.Fullname)
        {
            $This.Exists = 0
        }
        Else
        {   
            $This.Exists = [System.IO.Directory]::Exists($This.Fullname)
            If ($This.Exists)
            {
                $This.Refresh()
            }
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
        ForEach ($Item in Get-ChildItem $This.Fullname -Recurse)
        {
            $Hash.Add($Hash.Count,$Item)
        }

        $This.Output = Switch ($Hash.Count) { 0 { $Null } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } }
    }
}

Class MapPackList
{
    [String] $Workspace
    [String]      $Name
    [String]  $Fullname
    [UInt32]    $Exists = 0
    [String]   $Scratch
    [String]    $Target
    [Object]    $Output
    MapPackList([String]$Path,[String]$Name)
    {
        $This.Workspace = $Path
        $This.Name      = $Name
        $This.Fullname  = "$Path\$Name"
        
        $This.Refresh()
    }
    MapPackList([String]$Path,[String]$Name,[String]$Scratch)
    {
        $This.Workspace = $Path
        $This.Name      = $Name
        $This.Fullname  = "$Path\$Name"
        $This.Scratch   = "$Path\$Scratch"
        $This.Target    = "$Path\$Scratch.pk3"
        
        $This.Refresh()
    }
    Clear()
    {
        $This.Output   = @( )
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
    Refresh()
    {
        $This.Clear()
        $This.Exists   = [System.IO.Directory]::Exists($This.Fullname)

        ForEach ($Id in [System.Enum]::GetNames([MapPackId]))
        {
            $Item      = $This.MapPackItem($Id)
            $Slot      = Switch ($Item.Id)
            {
                kerberos        {           "kerberos","beta v0.5"   }
                tempgrave       {  "temperedgraveyard","beta v0.7"   }
                rtcq            {               "rtcq","final v1.01" }
                insprod         {     "insaneproducts","final v1.0"  }
                crossfire       {          "crossfire","alpha v0.4"  }
                breakthru       {          "breakthru","alpha v0.4"  }
                ss1138          {   "spacestation1138","alpha v0.4"  }
                suspanim        { "suspendedanimation","alpha v0.4"  }
                tranquilibrium  {     "tranquilibrium","alpha v0.4"  }
                deadcenter      {         "deadcenter","alpha v0.4"  }
                wisdom          {             "wisdom","alpha v0.4"  }
                oomh            {        "outofmyhead","alpha v0.1"  }
            }

            $Item.Name    = $Slot[0]
            $Item.Version = $Slot[1]

            $Item.Fullname        = "{0}\{1}" -f $This.Workspace, $Item.Name
            $Item.Check()
            $Item.Target          = "20k-{0}" -f $Item.Id
            $This.Output         += $Item
        }
    }
    [Object] MapPackItem([String]$Id)
    {
        Return [MapPackItem]$Id
    }
    [Void] CreateArchive()
    {
        If (!$This.Scratch)
        {
            Throw "Scratch [!] Not set"
        }
        Else
        {
            If (![System.IO.Directory]::Exists($This.Scratch))
            {
                [System.IO.Directory]::CreateDirectory($This.Scratch) > $Null
            }
        }
    }
    SetScratch([String]$Path)
    {
        If ([System.IO.Directory]::Exists($Path))
        {
            $This.Scratch = $Path
        }
    }
    Prepare()
    {
        If (![System.IO.Directory]::Exists($This.Scratch))
        {
            [System.IO.Directory]::CreateDirectory($This.Scratch) > $Null
        }

        ForEach ($Item in $This.AssetTypes())
        {
            $xPath = "{0}\{1}" -f $This.Scratch, $Item
            If (![System.IO.Directory]::Exists($xPath))
            {
                [System.IO.Directory]::CreateDirectory($xPath) > $Null
            }
            If ($Item -eq "levelshots")
            {
                If (![System.IO.Directory]::Exists("$xPath\preview"))
                {
                    [System.IO.Directory]::CreateDirectory("$xPath\preview") > $Null
                }
            }
        }
    }
    Synchronize()
    {
        If (!$This.Scratch -or ![System.IO.Directory]::Exists($This.Scratch))
        {
            Throw "Exception [!] Must set valid scratch path"
        }

        # // Synchronizes all content into target master folder

        # // Transfer and rename each individual map (levelshot|preview|bsp|aas|arena)

        # Copy individual maps
        ForEach ($Map in $This.Output)
        {
            ForEach ($Item in $Map.Output)
            {
                Switch -Regex ($Item.GetType().Name)
                {
                    DirectoryInfo
                    {
                        $NewName = $Item.FullName.Replace($Map.Fullname,$This.Scratch)

                        If (![System.IO.Directory]::Exists($NewName))
                        {
                            [System.IO.Directory]::CreateDirectory($NewName)
                        }
                    }
                    FileInfo
                    {
                        $NewName = $Item.Fullname.Replace($Map.Fullname,$This.Scratch).Replace($Map.Name,$Map.Target)
                        If ($Item.Extension -match "\.arena")
                        {
                            $Content = [System.IO.File]::ReadAllLines($Item.Fullname)
                            ForEach ($Line in $Content)
                            {
                                If ($Line -match "^\s*map\s+\`"$($Map.Name)\`"")
                                {
                                    $Line  = $Line.Replace($Map.Name,$Map.Target)
                                }
                            }

                            [System.IO.File]::WriteAllLines($NewName,$Content)
                        }
                        Else
                        {
                            [System.IO.File]::Copy($Item.Fullname,$NewName,1)
                        }
                    }
                }
            }
        }

        # Copy all map assets
        $List = Get-ChildItem $This.Fullname -File -Recurse | Sort-Object Fullname
        ForEach ($Item in $List)
        {
            $NewName = $Item.Fullname.Replace($This.Fullname,$This.Scratch)
            $Parent  = $NewName | Split-Path -Parent
            If (![System.IO.Directory]::Exists($Parent))
            {
                [System.IO.Directory]::CreateDirectory($Parent) > $Null
            }

            [System.IO.File]::Copy($Item.Fullname,$NewName,1)
        }
    }
    [String] Params()
    {
        Return "a -tzip -mx=5 $($This.Scratch).pk3 `"$($This.Scratch)\*`" -o`"$($This.Workspace)`""
    }
}

# [Create cumulative master archive]
$7Zip         = "${Env:ProgramFiles(x86)}\7-Zip\7z.exe"
$Q3A          = "${Env:ProgramFiles(x86)}\Quake III Arena"
$Live         = "${Env:ProgramFiles(x86)}\Steam\steamapps\common\Quake Live"

$Workspace    = "C:\Workspace"
$ID           = "bfg20k"
$Scratch      = "bfg20k(0)"
$Maps         = [MapPackList]::New($Workspace,$Id,$Scratch)
$Maps.Prepare()
$Maps.Synchronize()
$Param = $Maps.Params()

Start-Process -FilePath $7zip -WorkingDirectory $Workspace -ArgumentList $Param -NoNewWindow -Wait

ForEach ($Item in "$Live\baseq3", "$Q3A\baseq3")
{
    $Destination = "{0}\{1}" -f $Item, ($Maps.Target | Split-Path -Leaf)
    [System.IO.File]::Copy($Maps.Target,$Destination,1)
}
