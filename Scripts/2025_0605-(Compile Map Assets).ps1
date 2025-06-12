
Enum MapPackId
{
    crossfire
    breakthru
    ss1138
    suspanim
    deadcenter
    tranquilibrium
    wisdom
    kerberos
    tempgrave
    rtcq
    insprod
    oomh
    goliath
}

Class MapCompilationItem
{
    [UInt32] $Index
    [String] $Name
    [String] $Id
    [String] $Source
    [String] $Workspace
    [String] $Q3Map2
    [String] $Bspc
    [UInt32] $Bsp
    [UInt32] $Vis
    [UInt32] $Light
    [UInt32] $Aas
    MapCompilationItem([UInt32]$Index,[String]$Name,[String]$Id,[String]$Source,[String]$Workspace,[String]$Q3Map2,[String]$Bspc)
    {
        $This.Index     = $Index
        $This.Name      = $Name
        $This.Id        = $Id
        $This.Source    = $Source
        $This.Workspace = "$Workspace\$Name\maps"
        $This.Q3Map2    = $Q3Map2
        $This.Bspc      = $Bspc
    }
    [UInt32] Check([String]$Name)
    {
        $Check = @{ 
            
            Vis   = $This.Bsp; 
            Light = $This.Bsp, $This.Vis;
            Aas   = $This.Bsp, $This.Vis, $This.Light; 
            All   = $This.Bsp, $This.Vis, $This.Light, $This.Aas
        
        }[$Name]

        Return [UInt32](0 -notin $Check)
    }
    [String] ToString()
    {
        Return "{0}\{1}.map" -f $This.Source, $This.Name
    }
}

Class MapCompilationList
{
    [Object] $Control
    [Object] $Module
    [String] $Source
    [String] $Workspace
    [String] $Q3Map2A   = "C:\Games\GtkRadiant\x64\q3map2.exe"
    [String] $Q3Map2B   = "C:\Games\NetRadiant25\q3map2.exe"
    [String] $Bspc      = "C:\Games\GtkRadiant\bspc.exe"
    [UInt32] $Selection
    [Object] $Output
    MapCompilationList([Object]$Control,[String]$Source,[String]$Workspace)
    {
        $This.Control   = $Control
        $This.Module    = $This.Control.Module
        $This.Source    = $Source
        $This.Workspace = $Workspace
        $This.Refresh()
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
    Clear()
    {
        $This.Output    = @( )
    }
    Refresh()
    {
        $This.Clear()

        ForEach ($Name in [System.Enum]::GetNames([MapPackId]))
        {
            $Item = Switch ($Name)
            {
                crossfire
                {
                    "crossfire","crossfire",$This.Q3Map2A
                }
                breakthru
                {
                    "breakthru","breakthru",$This.Q3Map2A
                }
                ss1138
                {
                    "spacestation1138","ss1138",$This.Q3Map2B
                }
                suspanim
                {
                    "suspendedanimation","suspanim",$This.Q3Map2A
                }
                deadcenter
                {
                    "deadcenter","deadcenter",$This.Q3Map2B
                }
                tranquilibrium
                {
                    "tranquilibrium","tranquilibrium",$This.Q3Map2A
                }
                wisdom
                {
                    "wisdom","wisdom",$This.Q3Map2A
                }
                kerberos
                {
                    "kerberos","kerberos",$This.Q3Map2A
                }
                tempgrave
                {
                    "temperedgraveyard","tempgrave",$This.Q3Map2A
                }
                rtcq
                {   "rtcq","rtcq",$This.Q3Map2B

                }
                insprod
                {
                    "insaneproducts","insprod",$This.Q3Map2B
                }
                oomh
                {
                    "outofmyhead","oomh",$This.Q3Map2A
                }
                goliath
                {
                    "goliath","goliath",$This.Q3Map2B
                }
            }

            $This.Output += $This.MapCompilationItem($This.Output.Count,$Item[0],$Item[1],$Item[2])
        }
    }
    [Object] Selected()
    {
        Return $This.Output[$This.Selection]
    }
    [String] Q3APath()
    {
        Return "C:\Program Files (x86)\Quake III Arena"
    }
    [String] GetParam([UInt32]$Phase)
    {
        $xMap  = $This.Selected()
        $Param = Switch ($Phase)
        {
            0
            {
                "-v";
                "-connect 127.0.0.1:39000";
                "-game quakelive";
                '-fs_basepath "{0}"' -f $This.Q3APath();
                '-meta "{0}"' -f $xMap
            }
            1
            {
                "-connect 127.0.0.1:39000";
                "-game quakelive";
                '-fs_basepath "{0}"' -f $This.Q3APath();
                "-vis";
                '-saveprt "{0}"' -f $xMap
            }
            2
            {
                "-connect 127.0.0.1:39000";
                "-game quakelive";
                '-fs_basepath "{0}"' -f $This.Q3APath();
                "-light";
                "-fast";
                "-patchshadows";
                "-samples 3";
                "-bounce 8";
                "-dirty";
                "-gamma 2";
                "-compensate 4";
                '"{0}"' -f $xMap
            }
            3
            {
                "-optimize";
                "-forcesidesvisible";
                '-bsp2aas "{0}"' -f $xMap
            }
        }

        $Param = $Param -join " "
        
        Return $Param -join " "
    }
    Compile([UInt32]$Index)
    {
        If ($Index -notin $This.Output.Index)
        {
            Throw "Invalid index"
        }

        $This.Selection = $Index

        $Compile        = $This.Selected()

        # Q3Map2 (Bsp)
        If ($Compile)
        {
            Try
            {
                $Param = $This.GetParam(0)
                $This.Update(0,"Running [~] Q3Map2 (bsp) => $([DateTime]::Now)")
                $This.Update(0,"$($Compile.Q3Map2)")
                "$Param`n".Replace("-","`n-").Split("`n") | % { $This.Update(0,"    $_") }

                Start-Process -FilePath $Compile.Q3Map2 -ArgumentList $Param -NoNewWindow -Wait

                $This.Update(1,"Success [+] Q3Map2 (bsp) => $([DateTime]::Now)")
                $Compile.Bsp = 1
            }
            Catch
            {
                $This.Update(-1,"Exception [!] Q3Map2 (bsp) => failed")
            }
        }

        # Q3Map2 (Vis)
        If ($Compile.Check("Vis"))
        {
            Try
            {
                $Param = $This.GetParam(1)
                $This.Update(0,"Running [~] Q3Map2 (vis) => $([DateTime]::Now)")
                $This.Update(0,$Compile.Q3Map2)
                "$Param`n".Replace("-","`n-").Split("`n") | % { $This.Update(0,"    $_") }

                Start-Process -FilePath $Compile.Q3Map2 -ArgumentList $Param -NoNewWindow -Wait

                $This.Update(1,"Success [+] Q3Map2 (vis) => $([DateTime]::Now)")

                $Compile.Vis = 1
            }
            Catch
            {
                $This.Update(-1,"Exception [!] Q3Map2 (vis) => $([DateTime]::Now)")
            }
        }

        # Q3Map2 (Light)
        If ($Compile.Check("Light"))
        {
            Try
            {
                $Param = $This.GetParam(2).Replace("-samples 2","-samples 3").Replace("-bounce 2","-bounce 5")

                $This.Update(0,"Running [~] Q3Map2 (light) => $([DateTime]::Now)")
                $This.Update(0,$Compile.Q3Map2)
                "$Param`n".Replace("-","`n-").Split("`n") | % { $This.Update(0,"    $_") }
                
                Start-Process -FilePath $Compile.Q3Map2 -ArgumentList $Param -NoNewWindow -Wait
                
                $This.Update(1,"Success [+] Q3Map2 (light) => $([DateTime]::Now)")

                $Compile.Light = 1
            }
            Catch
            {
                [Console]::WriteLine("`nException [!] Q3Map2 (light) => $([DateTime]::Now)")
            }
        }

        # Bspc (aas)
        If ($Compile.Check("Aas"))
        {
            Try
            {
                $Param = $This.GetParam(3)

                $This.Update(0,"Running [~] Bspc (Aas) => $([DateTime]::Now)")
                $This.Update(0,$Compile.Bspc)
                "$Param`n".Replace("-","`n-").Split("`n") | % { $This.Update(0,"    $_") }
                
                Start-Process -FilePath $Compile.Bspc -ArgumentList $Param -NoNewWindow -Wait
                
                $This.Update(1,"Success [+] Bspc (Aas) => $([DateTime]::Now)")

                $Compile.Aas = 1
            }
            Catch
            {
                $This.Update(-1,"Exception [!] Bspc (Aas) => $([DateTime]::Now)")
            }
        }

        # Copy
        If ($Compile.Check("All"))
        {
            Try
            {
                $This.Update(0,"Copying [~] Map Assets (Bsp/Aas) => $([DateTime]::Now)")

                ForEach ($Item in Get-ChildItem $Compile.Source | ? BaseName -eq $Compile.Name | ? Name -match "(bsp|aas)")
                {
                    [System.IO.File]::Copy($Item.Fullname,"$($Compile.Workspace)\$($Item.Name)",1)
                }

                $This.Update(1,"Success [+] Map Assets (Bsp/Aas) => $([DateTime]::Now)")
            }
            Catch
            {
                $This.Update(-1,"Exception [!] Map Assets (Bsp/Aas) => $([DateTime]::Now)")
            }
        }
    }
    CompileArray()
    {
        $Start     = [DateTime]::Now

        $This.Update(0,"Starting [~] Compilation Array => [$Start] [00:00:00]")
        ForEach ($Id in $This.Output.Id)
        {
            Switch ($Id)
            {
                crossfire      { $This.Control.SetMap("crossfire");          $This.Compile(0)  }
                breakthru      { $This.Control.SetMap("breakthru");          $This.Compile(1)  }
                ss1138         { $This.Control.SetMap("spacestation1138");   $This.Compile(2)  }
                suspanim       { $This.Control.SetMap("suspendedanimation"); $This.Compile(3)  }
                deadcenter     { $This.Control.SetMap("deadcenter");         $This.Compile(4)  }
                tranquilibrium { $This.Control.SetMap("tranquilibrium");     $This.Compile(5)  }
                wisdom         { $This.Control.SetMap("wisdom");             $This.Compile(6)  }
                kerberos       { $This.Control.SetMap("kerberos");           $This.Compile(7)  }
                tempgrave      { $This.Control.SetMap("temperedgraveyard");  $This.Compile(8)  }
                rtcq           { $This.Control.SetMap("rtcq");               $This.Compile(9)  }
                insprod        { $This.Control.SetMap("insaneproducts");     $This.Compile(10) }
                oomh           { $This.Control.SetMap("outofmyhead");        $This.Compile(11) }
                goliath        { $This.Control.SetMap("goliath");            $This.Compile(12) }
            }
        
            If ($This.Selected().Check("All"))
            {
                $This.Control.MapPackage()
                $This.Control.MapTransfer()
            }

            $Now  = [DateTime]::Now
            $Span = [TimeSpan]($Now-$Start)
            $This.Update(1,"Elapsed [~] [$Span]")
        }

        $Now  = [DateTime]::Now
        $Span = [TimeSpan]($Now-$Start)
        $This.Update(1,"Completed [+] Compilation Array => [$Now] [$Span]")
    }
    [Object] MapCompilationItem([UInt32]$Index,[String]$Name,[String]$Id,[String]$Q3Map2)
    {
        Return [MapCompilationItem]::New($Index,$Name,$Id,$This.Source,$This.Workspace,$Q3Map2,$This.Bspc)
    }
}

$Source    = "C:\Program Files (x86)\Quake III Arena\baseq3\maps"
$Workspace = "C:\Workspace"
<# Requires Q3A-Live @ https://github.com/mcc85s/Q3A-Live/blob/main/Scripts/2025_0605-(Q3A-Live).ps1
$Ctrl      = [Q3ALiveMaster]::New()
#>
$Ctrl.SetWorkspace($Workspace)
$Comp      = [MapCompilationList]::New($Ctrl,$Source,$Workspace)

<# Compiles (1) item
$Comp.Control.SetMap("deadcenter");
$Comp.Compile(12)

$Comp.Control.MapPackage()
$Comp.Control.MapTransfer()
$Comp.Control.MapPlay()
#>

<# Compiles (1/multiple) item(s) by name
ForEach ($Item in $Comp.Output | ? Id -in "deadcenter")
{
    $Comp.Control.SetMap($Item.Name)
    $Comp.Compile($Item.Index)

    $Comp.Control.MapPackage()
    $Comp.Control.MapTransfer()
}
#>

<# Compiles all items in the array
$Comp.CompileArray()
#>
