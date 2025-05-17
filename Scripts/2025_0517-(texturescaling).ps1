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
    [UInt32] $Index
    [String] $Line
    [UInt32] $Texture
    [Object] $Detail
    MapLine([UInt32]$Index,[String]$Line)
    {
        $This.Index   = $Index
        $This.Line    = $Line

        If ($This.Line -match '\(\s*-?\d+\s*-?\d+\s*-?\d+\s*\)\s*\(\s*-?\d+\s*-?\d+\s*-?\d+\s*\)\s*\(\s*-?\d+\s*-?\d+\s*-?\d+\s*\)\s*\S+\s*(-?\d+(\.\d+)?\s*)+')
        {
            $This.Texture = 1
            $This.Detail  = $This.MapLineDetail($This.Line)
        }
    }
    Amend([String]$Texture,[UInt32]$Scale)
    {
        If ($This.Texture)
        {
            $This.Detail.Amend($Texture,$Scale)
            $This.Line = $This.Detail.ToString()
        }
    }
    [Object] MapLineDetail([String]$Line)
    {
        Return [MapLineDetail]::New($Line)
    }
}

Class MapFile
{
    [String] $Path
    [UInt32] $Exists
    [Object] $Content
    MapFile([String]$Path)
    {
        $This.Path    = $Path
        $This.Refresh()
    }
    Clear()
    {
        $This.Content = @( )
    }
    Refresh()
    {
        $This.Clear()
        $This.Check()

        If ($This.Exists)
        {
            $xContent = [System.IO.File]::ReadAllLines($This.Path)
            $Hash     = @{ }

            ForEach ($Line in $xContent)
            {
                $Hash.Add($Hash.Count,$This.MapLine($Hash.Count,$Line))
            }

            $This.Content = Switch ($Hash.Count)
            {
                0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] }
            }
        }
    }
    Check()
    {
        $This.Exists = [System.IO.File]::Exists($This.Path)
    }
    [Object] MapLine([UInt32]$Index,[String]$Line)
    {
        Return [MapLine]::New($Index,$Line)
    }
    Save()
    {
        [System.IO.File]::WriteAllLines($This.Path,$This.Content.Line)
    }
}

$Path    = "C:\Program Files (x86)\Quake III Arena\baseq3\maps\deadcenter.map"
$Map     = [MapFile]::New($Path)

# Test
ForEach ($Line in ($Map.Content | ? Line -match "bfg20k/light_strip_32x256_red\s"))
{
    $Line.Amend("bfg20k/light_strip_128x1024_red",4)
}

$Map.Save()
