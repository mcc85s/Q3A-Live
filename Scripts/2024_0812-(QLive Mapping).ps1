### This script contains multiple blocks for different uses, and is not meant to be run all at once

# [Conversion]

# // Load System.IO.Compression + Filesystem types
Add-Type -Assembly System.IO.Compression, System.IO.Compression.Filesystem

# // File path
$FilePath    = "C:\Program Files (x86)\Quake III Arena\baseq3\2023_0717-(testmap3).pk3"
$Name        = Split-Path $Filepath -Leaf

# // Establish working path
$WorkingPath = "C:\Workspace\testmap3"

If (![System.IO.Directory]::Exists($WorkingPath))
{
    [System.IO.Directory]::CreateDirectory($WorkingPath)
}

# // Extract everything in a particular (*.pk3) file to working path
[System.IO.Compression.ZipFile]::ExtractToDirectory($Filepath,$WorkingPath)

# // Paths for game tools (Q3MAP2)
$Q3MAP2      = "C:\Games\GtkRadiant\q3map2.exe"

# // [Fix BSP] - Path to (*.bsp) file
$Label       = $Name.Replace("pk3","bsp")
$BSP         = "$WorkingPath\maps\$Label"

# // Set parameters
$Param       = "-game quake3 -convert -format quakelive $BSP"

# // Start Process, the output will be <mapname>_c.bsp
Start-Process -FilePath $Q3Map2 -ArgumentList $Param -NoNewWindow -Wait

# // Remove old (*.bsp), rename new (*.bsp)
$NewBsp      = Get-ChildItem "$WorkingPath\maps" | ? Name -match "_c" | % Fullname
[System.IO.File]::Delete($BSP)
[System.IO.File]::Move($NewBsp,$Bsp)

# [Fix AAS] - Path to (*.aas) file
$Label       = $Name.Replace("pk3","aas")
$AAS         = "$WorkingPath\maps\$Label"

# // Set parameters
$Param       = "-fixaas $AAS"

# // Start Process
Start-Process -FilePath $Q3Map2 -ArgumentList $Param -NoNewWindow -Wait

# // Fix (*.aas) file in hex editor, first 4 hex values must be 45, 41, 41, 53
# 00000000 45 41 41 53

# // Run the bspc again
$BSPC        = "C:\Games\GtkRadiant\bspc.exe"
$Param       = "-optimize -reach $AAS"
Start-Process -FilePath $BSPC -ArgumentList $PARAM -NoNewWindow -Wait

# // Remove the files that aren't the new (AAS/BSP) file
Get-ChildItem "$WorkingPath\maps" *.bak | Remove-Item

# // Create the NEW zip file
$Target      = "C:\Workspace\testmap3.pk3"

If ([System.IO.File]::Exists($Target))
{
    [System.IO.File]::Delete($Target)
}

[System.IO.Compression.ZipFile]::CreateFromDirectory($WorkingPath,$Target,"Optimal",$False)

# // Copy to Quake Live directory
$QuakeLive   = "${Env:ProgramFiles(x86)}\Steam\steamapps\common\Quake Live\baseq3"
$File        = "$QuakeLive\testmap3.pk3"

If ([System.IO.File]::Exists($File))
{
    [System.IO.File]::Delete($File)
}

[System.IO.File]::Move($Target,$File)

# // [Compiling from (*.map)]

# // Variables
$Q3Map2 = "C:/Games/GtkRadiant/x64/q3map2.exe"
$BSPC   = "C:/Games/GtkRadiant/bspc.exe"
$Game   = "C:/Program Files (x86)/Quake III Arena/"
$Map    = "$Game/baseq3/maps/testmap3.map"

# // Compiling BSP part 1
$Param  = "-v  -connect 127.0.0.1:39000  -game quakelive -fs_basepath `"$Game`" -meta `"$Map`""
Start-Process -FilePath $Q3Map2 -ArgumentList $Param -NoNewWindow -Wait

# // Compiling BSP part 2
$Param  = " -connect 127.0.0.1:39000  -game quakelive -fs_basepath `"$Game`" -vis -saveprt `"$Map`""
Start-Process -FilePath $Q3Map2 -ArgumentList $Param -NoNewWindow -Wait

# // Compiling BSP part 3
$Param  = " -connect 127.0.0.1:39000  -game quakelive -fs_basepath `"$Game`" -light -fast -patchshadows -samples 2 -bounce 2 -dirty -gamma 2 -compensate 4 `"$Map`""
Start-Process -FilePath $Q3Map2 -ArgumentList $Param -NoNewWindow -Wait

# // Compiling AAS part 4
$Param  = "-optimize -forcesidesvisible -bsp2aas `"$Map`""
Start-Process -FilePath $BSPC -ArgumentList $Param -NoNewWindow -Wait
