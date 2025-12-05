<#  [Program Map]

    - General              | classes that don't fit a particular category
    - Xaml                 | classes meant for XAML/WPF
    - Registry             | classes meant to stage and initialize the utility
    - Component            | classes meant for Quake III Arena/Quake Live
    - Dependency           | classes that search the registry and elsewhere for installed dependencies
    - Workspace            | classes that partition game directories from project assets, and overall logs
    - Assignment           | classes that manage (single/multiple) map actions
    - Compilation          | classes that manage the compilation array
    - Steam                | classes that manage SteamCmd
    - Controller           | main class factory that embeds all of the above classes
#>

<#
Resource
Name
DisplayName
Version
Fullname
InstallDate
Settings
 Q3A                # | Path
 QLive              # | Path
 Editor             # | Name
 ImageMagick        # | Path
 7Zip               # | Path
 Q3ASE              # | Path
 Steam              # | Path
 Workspace          # | Path
 Credential         # | Path
Component
 Q3A                # | Path
 QLive              # | Path
Editor
 GtkRadiant         # | Path
 NetRadiant         # | Path
 NetRadiant-Custom  # | Path
Dependency          
 7Zip               # | Path
 ImageMagick        # | Path
 Q3ASE              # | Path
 Steam              # | Path
 GtkRadiant         # | Path
 NetRadiant         # | Path
 NetRadiant-Custom  # | Path
#>

#    ____                                                                                                    ________    
#   //¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
#   \\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\__//¯¯¯    
#    ¯¯¯\\__[ General    ]__________________________________________________________________________________//¯¯¯        
#        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯            

Class Q3ALiveByteSize
{
    [String]   $Name
    [UInt64]  $Bytes
    [String]   $Unit
    [String]   $Size
    Q3ALiveByteSize([String]$Name,[UInt64]$Bytes)
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

#    ____                                                                                                    ________    
#   //¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
#   \\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\__//¯¯¯    
#    ¯¯¯\\__[ Xaml   ]______________________________________________________________________________________//¯¯¯        
#        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯            

Class Q3ALiveXaml
{
    Static [String] $Content = @(
    '<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"',
    '        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"',
    '        Title="[Q3A-Live]://Map Development Kit by &lt;BFG20K&gt;"',
    '        Height="550"',
    '        Width="750"',
    '        ResizeMode="NoResize"',
    '        Icon="C:\ProgramData\Secure Digits Plus LLC\FightingEntropy\2024.1.0\Graphics\icon.ico"',
    '        HorizontalAlignment="Center"',
    '        WindowStartupLocation="CenterScreen"',
    '        FontFamily="Consolas"',
    '        Background="#5F5F50">',
    '    <Window.Resources>',
    '        <Style TargetType="TabControl">',
    '            <Setter Property="TabStripPlacement" Value="Top"/>',
    '            <Setter Property="HorizontalContentAlignment" Value="Center"/>',
    '            <Setter Property="Background" Value="#555555"/>',
    '        </Style>',
    '        <Style TargetType="TabItem">',
    '            <Setter Property="Template">',
    '                <Setter.Value>',
    '                    <ControlTemplate TargetType="TabItem">',
    '                        <Border Name="Border"',
    '                                BorderThickness="2"',
    '                                BorderBrush="Black"',
    '                                CornerRadius="5"',
    '                                Margin="2">',
    '                            <ContentPresenter x:Name="ContentSite"',
    '                                              VerticalAlignment="Center"',
    '                                              HorizontalAlignment="Right"',
    '                                              ContentSource="Header"',
    '                                              Margin="5"/>',
    '                        </Border>',
    '                        <ControlTemplate.Triggers>',
    '                            <Trigger Property="IsSelected" Value="True">',
    '                                <Setter TargetName="Border" Property="Background" Value="#4444FF"/>',
    '                                <Setter Property="Foreground" Value="#FFFFFF"/>',
    '                            </Trigger>',
    '                            <Trigger Property="IsSelected" Value="False">',
    '                                <Setter TargetName="Border" Property="Background" Value="#CFFFBF"/>',
    '                                <Setter Property="Foreground" Value="#000000"/>',
    '                            </Trigger>',
    '                            <Trigger Property="IsEnabled" Value="True">',
    '                                <Setter Property="Opacity" Value="1"/>',
    '                            </Trigger>',
    '                            <Trigger Property="IsEnabled"',
    '                                     Value="False">',
    '                                <Setter Property="Opacity"',
    '                                        Value="0.5"/>',
    '                            </Trigger>',
    '                        </ControlTemplate.Triggers>',
    '                    </ControlTemplate>',
    '                </Setter.Value>',
    '            </Setter>',
    '        </Style>',
    '        <Style TargetType="DataGrid">',
    '            <Setter Property="Margin" Value="5"/>',
    '            <Setter Property="AutoGenerateColumns" Value="False"/>',
    '            <Setter Property="AlternationCount" Value="2"/>',
    '            <Setter Property="HeadersVisibility" Value="Column"/>',
    '            <Setter Property="CanUserResizeRows" Value="False"/>',
    '            <Setter Property="CanUserAddRows" Value="False"/>',
    '            <Setter Property="IsReadOnly" Value="True"/>',
    '            <Setter Property="IsTabStop" Value="True"/>',
    '            <Setter Property="IsTextSearchEnabled" Value="True"/>',
    '            <Setter Property="SelectionMode" Value="Single"/>',
    '            <Setter Property="Background"  Value="#000000"/>',
    '            <Setter Property="Foreground" Value="#00FF00"/>',
    '            <Setter Property="ScrollViewer.CanContentScroll" Value="True"/>',
    '            <Setter Property="ScrollViewer.VerticalScrollBarVisibility" Value="Auto"/>',
    '            <Setter Property="ScrollViewer.HorizontalScrollBarVisibility" Value="Auto"/>',
    '        </Style>',
    '        <Style x:Key="xDataGridRow"',
    '               TargetType="DataGridRow">',
    '            <Setter Property="VerticalAlignment" Value="Center"/>',
    '            <Setter Property="VerticalContentAlignment" Value="Center"/>',
    '            <Setter Property="TextBlock.VerticalAlignment" Value="Center"/>',
    '            <Setter Property="Height" Value="20"/>',
    '            <Setter Property="FontSize" Value="12"/>',
    '            <Setter Property="FontWeight" Value="Heavy"/>',
    '        </Style>',
    '        <Style TargetType="DataGridRow">',
    '            <Setter Property="VerticalAlignment" Value="Center"/>',
    '            <Setter Property="VerticalContentAlignment" Value="Center"/>',
    '            <Setter Property="TextBlock.VerticalAlignment" Value="Center"/>',
    '            <Setter Property="Height" Value="20"/>',
    '            <Setter Property="FontSize" Value="12"/>',
    '            <Style.Triggers>',
    '                <Trigger Property="IsMouseOver" Value="True">',
    '                    <Setter Property="ToolTip">',
    '                        <Setter.Value>',
    '                            <TextBlock TextWrapping="Wrap"',
    '                                       Width="400"',
    '                                       Background="#000000"',
    '                                       Foreground="#00FF00"/>',
    '                        </Setter.Value>',
    '                    </Setter>',
    '                    <Setter Property="ToolTipService.ShowDuration" Value="360000000"/>',
    '                </Trigger>',
    '            </Style.Triggers>',
    '        </Style>',
    '        <Style TargetType="DataGridColumnHeader">',
    '            <Setter Property="FontSize" Value="12"/>',
    '            <Setter Property="FontWeight" Value="Normal"/>',
    '            <Setter Property="Background" Value="#333333"/>',
    '            <Setter Property="Foreground" Value="#00FF00"/>',
    '            <Setter Property="BorderBrush" Value="#444444"/>',
    '            <Setter Property="Padding" Value="2"/>',
    '        </Style>',
    '        <Style TargetType="DataGridCell">',
    '            <Setter Property="Background" Value="#000000"/>',
    '            <Setter Property="Foreground" Value="#00FF00"/>',
    '            <Setter Property="BorderBrush" Value="#333333"/>',
    '            <Style.Triggers>',
    '                <Trigger Property="IsSelected" Value="True">',
    '                    <Setter Property="Background" Value="#4444FF"/>',
    '                    <Setter Property="Foreground"  Value="#FFFFFF"/>',
    '                    <Setter Property="BorderBrush" Value="#3F3F3F"/>',
    '                </Trigger>',
    '            </Style.Triggers>',
    '        </Style>',
    '        <Style TargetType="GroupBox">',
    '            <Setter Property="Foreground" Value="Black"/>',
    '            <Setter Property="Margin" Value="5"/>',
    '            <Setter Property="FontSize" Value="12"/>',
    '            <Setter Property="FontWeight" Value="Normal"/>',
    '        </Style>',
    '        <Style TargetType="Button">',
    '            <Setter Property="Margin" Value="5"/>',
    '            <Setter Property="Padding" Value="5"/>',
    '            <Setter Property="FontWeight" Value="Heavy"/>',
    '            <Setter Property="Foreground" Value="Black"/>',
    '            <Setter Property="Background" Value="#CFFFBF"/>',
    '            <Setter Property="BorderBrush" Value="Black"/>',
    '            <Setter Property="BorderThickness" Value="2"/>',
    '            <Setter Property="VerticalContentAlignment" Value="Center"/>',
    '            <Style.Resources>',
    '                <Style TargetType="Border">',
    '                    <Setter Property="CornerRadius" Value="5"/>',
    '                </Style>',
    '            </Style.Resources>',
    '        </Style>',
    '        <Style TargetType="ComboBox">',
    '            <Setter Property="Height" Value="24"/>',
    '            <Setter Property="Margin" Value="5"/>',
    '            <Setter Property="FontSize" Value="12"/>',
    '            <Setter Property="FontWeight" Value="Normal"/>',
    '        </Style>',
    '        <Style TargetType="CheckBox">',
    '            <Setter Property="VerticalContentAlignment" Value="Center"/>',
    '        </Style>',
    '        <Style TargetType="Label">',
    '            <Setter Property="Margin" Value="5"/>',
    '            <Setter Property="FontWeight" Value="Bold"/>',
    '            <Setter Property="Background" Value="Black"/>',
    '            <Setter Property="Foreground" Value="White"/>',
    '            <Setter Property="BorderBrush" Value="DarkGray"/>',
    '            <Setter Property="BorderThickness" Value="2"/>',
    '            <Style.Resources>',
    '                <Style TargetType="Border">',
    '                    <Setter Property="CornerRadius" Value="5"/>',
    '                </Style>',
    '            </Style.Resources>',
    '        </Style>',
    '        <Style x:Key="DropShadow">',
    '            <Setter Property="TextBlock.Effect">',
    '                <Setter.Value>',
    '                    <DropShadowEffect ShadowDepth="1"/>',
    '                </Setter.Value>',
    '            </Setter>',
    '        </Style>',
    '        <Style TargetType="ToolTip">',
    '            <Setter Property="Background" Value="#000000"/>',
    '            <Setter Property="Foreground" Value="#00FF00"/>',
    '            <Setter Property="FontFamily" Value="Consolas"/>',
    '            <Setter Property="FontWeight" Value="SemiBold"/>',
    '        </Style>',
    '        <Style x:Key="DGCombo" TargetType="ComboBox">',
    '            <Setter Property="Margin" Value="0"/>',
    '            <Setter Property="Padding" Value="2"/>',
    '            <Setter Property="Height" Value="18"/>',
    '            <Setter Property="FontSize" Value="10"/>',
    '            <Setter Property="VerticalContentAlignment" Value="Center"/>',
    '        </Style>',
    '        <Style TargetType="{x:Type TextBox}" BasedOn="{StaticResource DropShadow}">',
    '            <Setter Property="TextBlock.TextAlignment" Value="Left"/>',
    '            <Setter Property="VerticalContentAlignment" Value="Center"/>',
    '            <Setter Property="HorizontalContentAlignment" Value="Left"/>',
    '            <Setter Property="Height" Value="24"/>',
    '            <Setter Property="Margin" Value="4"/>',
    '            <Setter Property="FontSize" Value="12"/>',
    '            <Setter Property="Background" Value="#111111"/>',
    '            <Setter Property="Foreground" Value="#00FF00"/>',
    '            <Setter Property="TextWrapping" Value="Wrap"/>',
    '            <Style.Resources>',
    '                <Style TargetType="Border">',
    '                    <Setter Property="CornerRadius" Value="2"/>',
    '                </Style>',
    '            </Style.Resources>',
    '        </Style>',
    '        <Style TargetType="{x:Type PasswordBox}" BasedOn="{StaticResource DropShadow}">',
    '            <Setter Property="TextBlock.TextAlignment" Value="Left"/>',
    '            <Setter Property="VerticalContentAlignment" Value="Center"/>',
    '            <Setter Property="HorizontalContentAlignment" Value="Left"/>',
    '            <Setter Property="Background" Value="#333333"/>',
    '            <Setter Property="Foreground" Value="#00FF00"/>',
    '            <Setter Property="Margin" Value="4"/>',
    '            <Setter Property="Height" Value="24"/>',
    '            <Style.Resources>',
    '                <Style TargetType="Border">',
    '                    <Setter Property="CornerRadius" Value="2"/>',
    '                </Style>',
    '            </Style.Resources>',
    '        </Style>',
    '        <Style x:Key="xTextBlock" TargetType="TextBlock">',
    '            <Setter Property="TextWrapping" Value="WrapWithOverflow"/>',
    '            <Setter Property="FontFamily" Value="Consolas"/>',
    '            <Setter Property="FontWeight" Value="Heavy"/>',
    '            <Setter Property="Background" Value="#333333"/>',
    '            <Setter Property="Foreground" Value="#00FF00"/>',
    '        </Style>',
    '        <Style x:Key="rTextBlock" TargetType="TextBlock">',
    '            <Setter Property="HorizontalAlignment"',
    '                    Value="Right"/>',
    '        </Style>',
    '        <Style x:Key="LabelGray" TargetType="Label">',
    '            <Setter Property="Margin" Value="5"/>',
    '            <Setter Property="FontWeight" Value="Bold"/>',
    '            <Setter Property="Background" Value="DarkSlateGray"/>',
    '            <Setter Property="Foreground" Value="White"/>',
    '            <Setter Property="BorderBrush" Value="Black"/>',
    '            <Setter Property="BorderThickness" Value="2"/>',
    '            <Setter Property="HorizontalContentAlignment" Value="Center"/>',
    '            <Style.Resources>',
    '                <Style TargetType="Border">',
    '                    <Setter Property="CornerRadius" Value="5"/>',
    '                </Style>',
    '            </Style.Resources>',
    '        </Style>',
    '        <Style x:Key="LabelRed" TargetType="Label">',
    '            <Setter Property="Margin" Value="5"/>',
    '            <Setter Property="FontWeight" Value="Bold"/>',
    '            <Setter Property="Background" Value="IndianRed"/>',
    '            <Setter Property="Foreground" Value="White"/>',
    '            <Setter Property="BorderBrush" Value="Black"/>',
    '            <Setter Property="BorderThickness" Value="2"/>',
    '            <Setter Property="HorizontalContentAlignment" Value="Center"/>',
    '            <Style.Resources>',
    '                <Style TargetType="Border">',
    '                    <Setter Property="CornerRadius" Value="5"/>',
    '                </Style>',
    '            </Style.Resources>',
    '        </Style>',
    '        <Style x:Key="Line" TargetType="Border">',
    '            <Setter Property="Background" Value="Black"/>',
    '            <Setter Property="BorderThickness" Value="0"/>',
    '            <Setter Property="Margin" Value="4"/>',
    '        </Style>',
    '    </Window.Resources>',
    '    <Grid>',
    '        <TabControl>',
    '            <TabItem Header="Config"',
    '                     ToolTip="(Resource + Registry) information for Q3A-Live">',
    '                <Grid>',
    '                    <Grid.RowDefinitions>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="45"/>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="*"/>',
    '                        <RowDefinition Height="40"/>',
    '                    </Grid.RowDefinitions>',
    '                    <Grid Grid.Row="0">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="90"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="90"/>',
    '                            <ColumnDefinition Width="90"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <Button Grid.Column="0"',
    '                                Content="Install"',
    '                                Name="ConfigInstall"/>',
    '                        <TextBox Grid.Column="1"',
    '                                 Text="&lt;Manages filesystem + registry properties for Q3A-Live&gt;"',
    '                                 IsReadOnly="True"/>',
    '                        <Button Grid.Column="2"',
    '                                Content="Uninstall"',
    '                                Name="ConfigUninstall"/>',
    '                        <Button Grid.Column="3"',
    '                                Content="Refresh"',
    '                                Name="ConfigRefresh"/>',
    '                    </Grid>',
    '                    <DataGrid Grid.Row="1"',
    '                              Name="ResourceOutput">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="&lt;Q3ALive.Dependency.Item&gt;"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                            </Setter.Value>',
    '                                        </Setter>',
    '                                    </Trigger>',
    '                                </Style.Triggers>',
    '                            </Style>',
    '                        </DataGrid.RowStyle>',
    '                        <DataGrid.Columns>',
    '                            <DataGridTextColumn Header="Name"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="65"/>',
    '                            <DataGridTextColumn Header="Created"',
    '                                                Binding="{Binding Created}"',
    '                                                Width="140"/>',
    '                            <DataGridTextColumn Header="Fullname"',
    '                                                Binding="{Binding Fullname}"',
    '                                                Width="*"/>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <Grid Grid.Row="2">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="120"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <TextBox Grid.Column="0"',
    '                                 Name="RegistryPathText"',
    '                                 IsReadOnly="True"/>',
    '                        <ComboBox Grid.Column="1"',
    '                                  Name="RegistrySlot"',
    '                                  SelectedIndex="0">',
    '                            <ComboBoxItem Content="Settings"/>',
    '                            <ComboBoxItem Content="Component"/>',
    '                            <ComboBoxItem Content="Radiant"/>',
    '                            <ComboBoxItem Content="Dependency"/>',
    '                        </ComboBox>',
    '                    </Grid>',
    '                    <DataGrid Grid.Row="3"',
    '                              Name="RegistryProperty"',
    '                              HeadersVisibility="None">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="&lt;Q3ALive.Dependency.ItemProperty&gt;"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                            </Setter.Value>',
    '                                        </Setter>',
    '                                    </Trigger>',
    '                                </Style.Triggers>',
    '                            </Style>',
    '                        </DataGrid.RowStyle>',
    '                        <DataGrid.Columns>',
    '                            <DataGridTextColumn Header="Name"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="120"/>',
    '                            <DataGridTextColumn Header="Value"',
    '                                                Binding="{Binding Value}"',
    '                                                Width="*"/>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <Grid Grid.Row="6">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="120"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="25"/>',
    '                            <ColumnDefinition Width="80"/>',
    '                            <ColumnDefinition Width="80"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <TextBox Grid.Column="0"',
    '                                 Name="RegistryPropertyNameText"/>',
    '                        <TextBox Grid.Column="1"',
    '                                 Name="RegistryPropertyValueText"/>',
    '                        <Image Grid.Column="2"',
    '                               Name="RegistryPropertyValueIcon"/>',
    '                        <Button Grid.Column="3"',
    '                                Name="RegistryPropertyBrowse"',
    '                                Content="Browse"/>',
    '                        <Button Grid.Column="4"',
    '                                Name="RegistryPropertyApply"',
    '                                Content="Apply"/>',
    '                    </Grid>',
    '                </Grid>',
    '            </TabItem>',
    '            <TabItem Header="Components"',
    '                     ToolTip="(Components/Prerequisites) for Q3A-Live">',
    '                <Grid>',
    '                    <Grid.RowDefinitions>',
    '                        <RowDefinition Height="50"/>',
    '                        <RowDefinition Height="120"/>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="10"/>',
    '                        <RowDefinition Height="*"/>',
    '                    </Grid.RowDefinitions>',
    '                    <DataGrid Grid.Row="0"',
    '                              Name="ComponentOutput"',
    '                              HeadersVisibility="None"',
    '                              SelectionMode="Single">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="{Binding Base}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                            </Setter.Value>',
    '                                        </Setter>',
    '                                    </Trigger>',
    '                                </Style.Triggers>',
    '                            </Style>',
    '                        </DataGrid.RowStyle>',
    '                        <DataGrid.Columns>',
    '                            <DataGridTextColumn Header="Name"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="60"/>',
    '                            <DataGridTextColumn Header="Path"',
    '                                                Binding="{Binding Path}"',
    '                                                Width="*"/>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <Grid Grid.Row="1">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <DataGrid Grid.Column="0"',
    '                                      Name="DependencyOutput">',
    '                            <DataGrid.RowStyle>',
    '                                <Style TargetType="{x:Type DataGridRow}">',
    '                                    <Style.Triggers>',
    '                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                            <Setter Property="ToolTip">',
    '                                                <Setter.Value>',
    '                                                    <TextBlock Text="&lt;Q3ALive.Dependency.Item&gt;"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                </Setter.Value>',
    '                                            </Setter>',
    '                                        </Trigger>',
    '                                    </Style.Triggers>',
    '                                </Style>',
    '                            </DataGrid.RowStyle>',
    '                            <DataGrid.Columns>',
    '                                <DataGridTextColumn Header="Dependency"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="80"/>',
    '                                <DataGridTextColumn Header="Version"',
    '                                                Binding="{Binding Version}"',
    '                                                Width="60"/>',
    '                                <DataGridTextColumn Header="DisplayName"',
    '                                                Binding="{Binding DisplayName}"',
    '                                                Width="80"/>',
    '                                <DataGridTextColumn Header="+"',
    '                                                Binding="{Binding Installed}"',
    '                                                Width="20"/>',
    '                                <DataGridTextColumn Header="Description"',
    '                                                Binding="{Binding Description}"',
    '                                                Width="*"/>',
    '                            </DataGrid.Columns>',
    '                        </DataGrid>',
    '                        <Grid Grid.Column="1">',
    '                            <Grid.RowDefinitions>',
    '                                <RowDefinition Height="40"/>',
    '                                <RowDefinition Height="40"/>',
    '                                <RowDefinition Height="40"/>',
    '                            </Grid.RowDefinitions>',
    '                            <Button Grid.Row="0"',
    '                                Name="DependencyInstall"',
    '                                Content="Install"/>',
    '                            <Button Grid.Row="1"',
    '                                Name="DependencyClear"',
    '                                Content="Clear"/>',
    '                            <Button Grid.Row="2"',
    '                                Name="DependencyEdit"',
    '                                Content="Edit"/>',
    '                        </Grid>',
    '                    </Grid>',
    '                    <Grid Grid.Row="2">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="25"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <TextBox Grid.Column="0"',
    '                                 Name="DependencyPathText"',
    '                                 ToolTip="Directory for selected dependency"/>',
    '                        <Image Grid.Column="1"',
    '                               Name="DependencyPathIcon"/>',
    '                        <Button Grid.Column="2"',
    '                                Name="DependencyPathBrowse"',
    '                                Content="Browse"/>',
    '                        <Button Grid.Column="3"',
    '                                Name="DependencyPathApply"',
    '                                Content="Apply"/>',
    '                    </Grid>',
    '                    <Border Grid.Row="3"',
    '                            Style="{StaticResource Line}"/>',
    '                    <DataGrid Grid.Row="4"',
    '                              Name="DependencyProperty"',
    '                              HeadersVisibility="None">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="&lt;Q3ALive.Dependency.ItemProperty&gt;"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                            </Setter.Value>',
    '                                        </Setter>',
    '                                    </Trigger>',
    '                                </Style.Triggers>',
    '                            </Style>',
    '                        </DataGrid.RowStyle>',
    '                        <DataGrid.Columns>',
    '                            <DataGridTextColumn Header="Name"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="80"/>',
    '                            <DataGridTextColumn Header="Value"',
    '                                                Binding="{Binding Value}"',
    '                                                Width="*"/>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                </Grid>',
    '            </TabItem>',
    '            <TabItem Header="Workspace"',
    '                     Name="WorkspaceTab"',
    '                     ToolTip="(Path/folder) where all tentative map assets (should) exist">',
    '                <Grid>',
    '                    <Grid.RowDefinitions>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="10"/>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="*"/>',
    '                        <RowDefinition Height="40"/>',
    '                    </Grid.RowDefinitions>',
    '                    <Grid Grid.Row="0">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="25"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <TextBox Grid.Column="0"',
    '                                 Name="WorkspacePathText"/>',
    '                        <Image Grid.Column="1"',
    '                               Name="WorkspacePathIcon"/>',
    '                        <Button Grid.Column="2"',
    '                                Name="WorkspacePathBrowse"',
    '                                Content="Browse"',
    '                                ToolTip="Open folder dialog to set workspace path"/>',
    '                        <Button Grid.Column="3"',
    '                                Name="WorkspacePathApply"',
    '                                Content="Apply"',
    '                                ToolTip="Set the workspace path to access workspace controls"/>',
    '                        <Button Grid.Column="4"',
    '                                Name="WorkspacePathClear"',
    '                                Content="Clear"',
    '                                ToolTip="Clears the currently specified workspace"/>',
    '                    </Grid>',
    '                    <Border Grid.Row="1"',
    '                            Style="{StaticResource Line}"/>',
    '                    <Grid Grid.Row="2">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="80"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <ComboBox Grid.Column="0"',
    '                                  Name="WorkspaceSlot">',
    '                            <ComboBoxItem Content="Log"/>',
    '                            <ComboBoxItem Content="Output"/>',
    '                        </ComboBox>',
    '                        <Grid Grid.Column="1"',
    '                              Name="WorkspaceLogHeader"',
    '                              Visibility="Visible">',
    '                            <Grid.ColumnDefinitions>',
    '                                <ColumnDefinition Width="*"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                            </Grid.ColumnDefinitions>',
    '                            <TextBox Grid.Column="0"',
    '                                     Name="WorkspaceLogPathText"/>',
    '                            <CheckBox Grid.Column="1"',
    '                                      Name="WorkspaceLogPathExists"',
    '                                      Content="Exists"',
    '                                      HorizontalAlignment="Center"/>',
    '                        </Grid>',
    '                        <Grid Grid.Column="1"',
    '                              Name="WorkspaceOutputHeader"',
    '                              Visibility="Hidden">',
    '                            <Grid.ColumnDefinitions>',
    '                                <ColumnDefinition Width="*"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                            </Grid.ColumnDefinitions>',
    '                            <Button Grid.Column="1"',
    '                                    Name="WorkspaceOutputRefresh"',
    '                                    Content="Refresh"/>',
    '                        </Grid>',
    '                    </Grid>',
    '                    <DataGrid Grid.Row="3"',
    '                              Name="WorkspaceLogContent"',
    '                              Visibility="Visible"',
    '                              SelectionMode="Single">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="{Binding Source}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                            </Setter.Value>',
    '                                        </Setter>',
    '                                    </Trigger>',
    '                                </Style.Triggers>',
    '                            </Style>',
    '                        </DataGrid.RowStyle>',
    '                        <DataGrid.Columns>',
    '                            <DataGridTextColumn Header="#"',
    '                                                Binding="{Binding Index}"',
    '                                                Width="40"/>',
    '                            <DataGridTextColumn Header="Date"',
    '                                                Binding="{Binding Date}"',
    '                                                Width="75"/>',
    '                            <DataGridTextColumn Header="Time"',
    '                                                Binding="{Binding Time}"',
    '                                                Width="60"/>',
    '                            <DataGridTextColumn Header="Hash"',
    '                                                Binding="{Binding Hash}"',
    '                                                Width="220"/>',
    '                            <DataGridTextColumn Header="Source"',
    '                                                Binding="{Binding Source}"',
    '                                                Width="*"/>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <DataGrid Grid.Row="3"',
    '                              Name="WorkspaceOutput"',
    '                              Visibility="Hidden"',
    '                              SelectionMode="Single">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                            </Setter.Value>',
    '                                        </Setter>',
    '                                    </Trigger>',
    '                                </Style.Triggers>',
    '                            </Style>',
    '                        </DataGrid.RowStyle>',
    '                        <DataGrid.Columns>',
    '                            <DataGridTextColumn Header="[X]"',
    '                                                Binding="{Binding Selected}"',
    '                                                Width="30"/>',
    '                            <DataGridTextColumn Header="Name"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="200"/>',
    '                            <DataGridTextColumn Header="Created"',
    '                                                Binding="{Binding Created}"',
    '                                                Width="120"/>',
    '                            <DataGridTextColumn Header="Modified"',
    '                                                Binding="{Binding Modified}"',
    '                                                Width="120"/>',
    '                            <DataGridTextColumn Header="Size"',
    '                                                Binding="{Binding Size}"',
    '                                                Width="70"',
    '                                                ElementStyle="{StaticResource rTextBlock}"/>',
    '                            <DataGridTextColumn Header="Fullname"',
    '                                                Binding="{Binding Fullname}"',
    '                                                Width="*"/>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                </Grid>',
    '            </TabItem>',
    '            <TabItem Header="Map"',
    '                     Name="MapTab"',
    '                     ToolTip="Controls to compile, package, and publish map assets">',
    '                <Grid>',
    '                    <Grid.RowDefinitions>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="10"/>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="*"/>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="40"/>',
    '                    </Grid.RowDefinitions>',
    '                    <Grid Grid.Row="0">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="25"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <TextBox Grid.Column="0"',
    '                                 Name="MapNameText"/>',
    '                        <Image Grid.Column="1"',
    '                               Name="MapNameIcon"/>',
    '                        <Button Grid.Column="2"',
    '                                Name="MapApply"',
    '                                Content="Apply"',
    '                                ToolTip="If valid, uses the (*.map) file to construct OR reconstitute map assets"/>',
    '                        <Button Grid.Column="3"',
    '                                Name="MapClear"',
    '                                Content="Clear"',
    '                                ToolTip="Use this to clear the selected map in order to select another"/>',
    '                    </Grid>',
    '                    <Border Grid.Row="1"',
    '                            Style="{StaticResource Line}"/>',
    '                    <Grid Grid.Row="2">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="100"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <ComboBox Grid.Column="0"',
    '                                  Name="MapSlot"',
    '                                  SelectedItem="0">',
    '                            <ComboBoxItem Content="Details"/>',
    '                            <ComboBoxItem Content="Levelshot"/>',
    '                            <ComboBoxItem Content="Arena"/>',
    '                            <ComboBoxItem Content="Shader"/>',
    '                            <ComboBoxItem Content="Output"/>',
    '                        </ComboBox>',
    '                        <Grid Grid.Column="1"',
    '                              Name="MapLevelshotHeader"',
    '                              Visibility="Hidden">',
    '                            <Grid.ColumnDefinitions>',
    '                                <ColumnDefinition Width="*"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                            </Grid.ColumnDefinitions>',
    '                            <TextBox Grid.Column="0"',
    '                                         Name="MapLevelshotPath"/>',
    '                            <CheckBox Grid.Column="1"',
    '                                          Name="MapLevelshotExists"',
    '                                          Content="Exists"',
    '                                          HorizontalAlignment="Center"/>',
    '                            <Button Grid.Column="2"',
    '                                        Name="MapLevelshotImport"',
    '                                        Content="Import"',
    '                                        ToolTip="Open a file dialog to select OR replace a valid levelshot image"/>',
    '                        </Grid>',
    '                        <Grid Grid.Column="1"',
    '                              Name="MapArenaHeader"',
    '                              Visibility="Hidden">',
    '                            <Grid.ColumnDefinitions>',
    '                                <ColumnDefinition Width="*"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                            </Grid.ColumnDefinitions>',
    '                            <TextBox Grid.Column="0"',
    '                                     Name="MapArenaPath"/>',
    '                            <CheckBox Grid.Column="1"',
    '                                      Name="MapArenaExists"',
    '                                      Content="Exists"',
    '                                      HorizontalAlignment="Center"/>',
    '                            <Button Grid.Column="2"',
    '                                    Name="MapArenaApply"',
    '                                    Content="Apply"',
    '                                    ToolTip="Write the (*.arena) content below to file"/>',
    '                        </Grid>',
    '                        <Grid Grid.Column="1"',
    '                              Name="MapShaderHeader"',
    '                              Visibility="Hidden">',
    '                            <Grid.ColumnDefinitions>',
    '                                <ColumnDefinition Width="*"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                            </Grid.ColumnDefinitions>',
    '                            <TextBox Grid.Column="0"',
    '                                     Name="MapShaderPath"/>',
    '                            <CheckBox Grid.Column="1"',
    '                                      Name="MapShaderExists"',
    '                                      Content="Exists"',
    '                                      HorizontalAlignment="Center"/>',
    '                            <Button Grid.Column="2"',
    '                                    Name="MapShaderApply"',
    '                                    Content="Apply"',
    '                                    ToolTip="Write the (*.shader) content below to file"/>',
    '                        </Grid>',
    '                    </Grid>',
    '                    <Grid Grid.Row="3"',
    '                          Name="MapDetailsPanel"',
    '                          Visibility="Hidden">',
    '                        <Grid.RowDefinitions>',
    '                            <RowDefinition Height="65"/>',
    '                            <RowDefinition Height="115"/>',
    '                            <RowDefinition Height="*"/>',
    '                        </Grid.RowDefinitions>',
    '                        <DataGrid Grid.Row="0"',
    '                                  Name="MapDetails"',
    '                                  HeadersVisibility="None"',
    '                                  SelectionMode="Single">',
    '                            <DataGrid.RowStyle>',
    '                                <Style TargetType="{x:Type DataGridRow}">',
    '                                    <Style.Triggers>',
    '                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                            <Setter Property="ToolTip">',
    '                                                <Setter.Value>',
    '                                                    <TextBlock Text="&lt;Q3ALive.Map.Detail&gt;"',
    '                                                               TextWrapping="Wrap"',
    '                                                               FontFamily="Consolas"',
    '                                                               Background="#000000"',
    '                                                               Foreground="#00FF00"/>',
    '                                                </Setter.Value>',
    '                                            </Setter>',
    '                                        </Trigger>',
    '                                    </Style.Triggers>',
    '                                </Style>',
    '                            </DataGrid.RowStyle>',
    '                            <DataGrid.Columns>',
    '                                <DataGridTextColumn Header="Name"',
    '                                                        Binding="{Binding Name}"',
    '                                                        Width="60"/>',
    '                                <DataGridTextColumn Header="Value"',
    '                                                        Binding="{Binding Value}"',
    '                                                        Width="*"/>',
    '                            </DataGrid.Columns>',
    '                        </DataGrid>',
    '                        <DataGrid Grid.Row="1"',
    '                                  Name="MapProperty"',
    '                                  HeadersVisibility="None"',
    '                                  SelectionMode="Single">',
    '                            <DataGrid.RowStyle>',
    '                                <Style TargetType="{x:Type DataGridRow}">',
    '                                    <Style.Triggers>',
    '                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                            <Setter Property="ToolTip">',
    '                                                <Setter.Value>',
    '                                                    <TextBlock Text="&lt;Q3ALive.Map.Detail&gt;"',
    '                                                               TextWrapping="Wrap"',
    '                                                               FontFamily="Consolas"',
    '                                                               Background="#000000"',
    '                                                               Foreground="#00FF00"/>',
    '                                                </Setter.Value>',
    '                                            </Setter>',
    '                                        </Trigger>',
    '                                    </Style.Triggers>',
    '                                </Style>',
    '                            </DataGrid.RowStyle>',
    '                            <DataGrid.Columns>',
    '                                <DataGridTextColumn Header="Name"',
    '                                                    Binding="{Binding Name}"',
    '                                                    Width="60"/>',
    '                                <DataGridTextColumn Header="Value"',
    '                                                    Binding="{Binding Value}"',
    '                                                    Width="*"/>',
    '                            </DataGrid.Columns>',
    '                        </DataGrid>',
    '                        <DataGrid Grid.Row="2"',
    '                                  Name="MapTexture"',
    '                                  HeadersVisibility="None"',
    '                                  SelectionMode="Single">',
    '                            <DataGrid.RowStyle>',
    '                                <Style TargetType="{x:Type DataGridRow}">',
    '                                    <Style.Triggers>',
    '                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                            <Setter Property="ToolTip">',
    '                                                <Setter.Value>',
    '                                                    <TextBlock Text="&lt;Q3ALive.Map.Detail&gt;"',
    '                                                               TextWrapping="Wrap"',
    '                                                               FontFamily="Consolas"',
    '                                                               Background="#000000"',
    '                                                               Foreground="#00FF00"/>',
    '                                                </Setter.Value>',
    '                                            </Setter>',
    '                                        </Trigger>',
    '                                    </Style.Triggers>',
    '                                </Style>',
    '                            </DataGrid.RowStyle>',
    '                            <DataGrid.Columns>',
    '                                <DataGridTextColumn Header="Index"',
    '                                                    Binding="{Binding Index}"',
    '                                                    Width="30"/>',
    '                                <DataGridTextColumn Header="Shader"',
    '                                                    Binding="{Binding Shader}"',
    '                                                    Width="*"/>',
    '                                <DataGridTextColumn Header="Name"',
    '                                                    Binding="{Binding Name}"',
    '                                                    Width="*"/>',
    '                                <DataGridTextColumn Header="Fullname"',
    '                                                    Binding="{Binding Fullname}"',
    '                                                    Width="2*"/>',
    '                            </DataGrid.Columns>',
    '                        </DataGrid>',
    '                    </Grid>',
    '                    <Grid Grid.Row="3"',
    '                          Name="MapLevelshotPanel"',
    '                          Visibility="Hidden">',
    '                        <Grid.RowDefinitions>',
    '                            <RowDefinition Height="*"/>',
    '                        </Grid.RowDefinitions>',
    '                        <Image Grid.Row="0"',
    '                               Name="MapLevelshotImage"/>',
    '                    </Grid>',
    '                    <Grid Grid.Row="3"',
    '                          Name="MapArenaPanel"',
    '                          Visibility="Hidden">',
    '                        <TextBox Grid.Row="0"',
    '                                 Name="MapArenaContent"',
    '                                 Height="280"',
    '                                 Padding="2"',
    '                                 VerticalAlignment="Top"',
    '                                 VerticalContentAlignment="Top"',
    '                                 HorizontalScrollBarVisibility="Auto"',
    '                                 AcceptsReturn="True"',
    '                                 AcceptsTab="True"/>',
    '                    </Grid>',
    '                    <Grid Grid.Row="3"',
    '                          Name="MapShaderPanel"',
    '                          Visibility="Hidden">',
    '                        <TextBox Grid.Row="0"',
    '                                 Name="MapShaderContent"',
    '                                 Height="280"',
    '                                 Padding="2"',
    '                                 VerticalAlignment="Top"',
    '                                 VerticalContentAlignment="Top"',
    '                                 HorizontalScrollBarVisibility="Auto"',
    '                                 AcceptsReturn="True"',
    '                                 AcceptsTab="True"/>',
    '                    </Grid>',
    '                    <Grid Grid.Row="3"',
    '                          Name="MapOutputPanel"',
    '                          Visibility="Hidden">',
    '                        <DataGrid Name="MapOutput"',
    '                                  SelectionMode="Single">',
    '                            <DataGrid.RowStyle>',
    '                                <Style TargetType="{x:Type DataGridRow}">',
    '                                    <Style.Triggers>',
    '                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                            <Setter Property="ToolTip">',
    '                                                <Setter.Value>',
    '                                                    <TextBlock Text="{Binding Fullname}"',
    '                                                               TextWrapping="Wrap"',
    '                                                               FontFamily="Consolas"',
    '                                                               Background="#000000"',
    '                                                               Foreground="#00FF00"/>',
    '                                                </Setter.Value>',
    '                                            </Setter>',
    '                                        </Trigger>',
    '                                    </Style.Triggers>',
    '                                </Style>',
    '                            </DataGrid.RowStyle>',
    '                            <DataGrid.Columns>',
    '                                <DataGridTextColumn Header="Type"',
    '                                                    Binding="{Binding Type}"',
    '                                                    Width="70"/>',
    '                                <DataGridTextColumn Header="Date"',
    '                                                    Binding="{Binding Date}"',
    '                                                    Width="135"/>',
    '                                <DataGridTextColumn Header="Name"',
    '                                                    Binding="{Binding Name}"',
    '                                                    Width="*"/>',
    '                                <DataGridTextColumn Header="Length"',
    '                                                    Binding="{Binding Length}"',
    '                                                    Width="90"',
    '                                                    ElementStyle="{StaticResource rTextBlock}"/>',
    '                            </DataGrid.Columns>',
    '                        </DataGrid>',
    '                    </Grid>',
    '                    <Grid Grid.Row="4">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="2*"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <Button Grid.Column="0"',
    '                                Name="MapCompile"',
    '                                Content="Compile"',
    '                                ToolTip="Compile the (*.map) file into (*.bsp) + (*.aas) files"/>',
    '                        <Button Grid.Column="1"',
    '                                Name="MapPackage"',
    '                                Content="Package"',
    '                                ToolTip="Package a (*.pk3) based on all files in map asset folder"/>',
    '                        <Button Grid.Column="2"',
    '                                Name="MapTransfer"',
    '                                Content="Transfer"',
    '                                ToolTip="Transfer the (*.pk3) to Q3A + QL base directories to (compile/playtest)"/>',
    '                        <TextBox Grid.Column="3"',
    '                                 Name="MapPlayText"',
    '                                 ToolTip="Set :&lt;starting criteria&gt; for Quake Live"/>',
    '                        <Button Grid.Column="4"',
    '                                Name="MapPlayButton"',
    '                                Content="Play"',
    '                                ToolTip="Play the (*.pk3) in specific mode"/>',
    '                        <Button Grid.Column="5"',
    '                                Name="MapPublish"',
    '                                Content="Publish"',
    '                                ToolTip="Select this (*.pk3) to enable Steam tab and access workshop controls"/>',
    '                    </Grid>',
    '                </Grid>',
    '            </TabItem>',
    '            <TabItem Header="Steam"',
    '                     Name="SteamTab"',
    '                     ToolTip="Controls to orchestrate the publishing process through Steam Workshop">',
    '                <Grid>',
    '                    <Grid.RowDefinitions>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="*"/>',
    '                        <RowDefinition Height="40"/>',
    '                    </Grid.RowDefinitions>',
    '                    <Grid Grid.Row="0">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="110"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <ComboBox Grid.Column="0"',
    '                                  Name="SteamSlot">',
    '                            <ComboBoxItem Content="Credential"/>',
    '                            <ComboBoxItem Content="Workshop"/>',
    '                        </ComboBox>',
    '                        <Grid Grid.Column="1"',
    '                              Name="SteamCredentialHeader"',
    '                              Visibility="Hidden">',
    '                            <Grid.ColumnDefinitions>',
    '                                <ColumnDefinition Width="*"/>',
    '                                <ColumnDefinition Width="25"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                            </Grid.ColumnDefinitions>',
    '                            <TextBox Grid.Column="0"',
    '                                     Name="SteamCredentialPathText"/>',
    '                            <Image Grid.Column="1"',
    '                                   Name="SteamCredentialPathIcon"/>',
    '                            <Button Grid.Column="2"',
    '                                    Name="SteamCredentialPathBrowse"',
    '                                    Content="Browse"',
    '                                    ToolTip="Open a file dialog to import an existing XML credential"/>',
    '                            <Button Grid.Column="3"',
    '                                    Name="SteamCredentialPathApply"',
    '                                    Content="Apply"',
    '                                    ToolTip="If valid, will save this path to the registry for future use"/>',
    '                        </Grid>',
    '                        <Grid Grid.Column="1"',
    '                              Name="SteamWorkshopHeader"',
    '                              Visibility="Hidden">',
    '                            <Grid.RowDefinitions>',
    '                                <RowDefinition Height="40"/>',
    '                                <RowDefinition Height="50"/>',
    '                                <RowDefinition Height="*"/>',
    '                                <RowDefinition Height="40"/>',
    '                            </Grid.RowDefinitions>',
    '                            <Grid Grid.Row="0">',
    '                                <Grid.ColumnDefinitions>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                    <ColumnDefinition Width="25"/>',
    '                                    <ColumnDefinition Width="70"/>',
    '                                    <ColumnDefinition Width="70"/>',
    '                                </Grid.ColumnDefinitions>',
    '                                <TextBox Grid.Column="0"',
    '                                         Name="SteamWorkshopPathText"/>',
    '                                <Image Grid.Column="1"',
    '                                       Name="SteamWorkshopPathIcon"/>',
    '                                <Button Grid.Column="2"',
    '                                        Name="SteamWorkshopPathBrowse"',
    '                                        Content="Browse"',
    '                                        ToolTip="Open a folder dialog to select a Steam Workshop project folder"/>',
    '                                <Button Grid.Column="3"',
    '                                        Name="SteamWorkshopPathApply"',
    '                                        Content="Apply"',
    '                                        ToolTip="If valid, assign the workshop path to access nested project controls"/>',
    '                            </Grid>',
    '                        </Grid>',
    '                    </Grid>',
    '                    <Grid Grid.Row="1"',
    '                          Name="SteamCredentialPanel"',
    '                          Visibility="Hidden">',
    '                        <Grid.RowDefinitions>',
    '                            <RowDefinition Height="40"/>',
    '                            <RowDefinition Height="40"/>',
    '                            <RowDefinition Height="40"/>',
    '                            <RowDefinition Height="*"/>',
    '                        </Grid.RowDefinitions>',
    '                        <Grid Grid.Row="0">',
    '                            <Grid.ColumnDefinitions>',
    '                                <ColumnDefinition Width="80"/>',
    '                                <ColumnDefinition Width="*"/>',
    '                                <ColumnDefinition Width="25"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                            </Grid.ColumnDefinitions>',
    '                            <Label Grid.Column="0"',
    '                                   Content="User:"',
    '                                   Style="{StaticResource LabelGray}"/>',
    '                            <TextBox Grid.Column="1"',
    '                                     Name="SteamCredentialUsername"/>',
    '                            <Image Grid.Column="2"',
    '                                   Name="SteamCredentialUsernameIcon"/>',
    '                            <Button Grid.Column="3"',
    '                                    Name="SteamCredentialSave"',
    '                                    Content="Save"',
    '                                    ToolTip="Save the current (username + password) to an XML credential file"/>',
    '                            <Button Grid.Column="4"',
    '                                    Name="SteamCredentialLoad"',
    '                                    Content="Load"',
    '                                    ToolTip="Load the defined XML credential file"/>',
    '                        </Grid>',
    '                        <Grid Grid.Row="1">',
    '                            <Grid.ColumnDefinitions>',
    '                                <ColumnDefinition Width="80"/>',
    '                                <ColumnDefinition Width="*"/>',
    '                                <ColumnDefinition Width="25"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                            </Grid.ColumnDefinitions>',
    '                            <Label Grid.Column="0"',
    '                                   Content="Pass:"',
    '                                   Style="{StaticResource LabelGray}"/>',
    '                            <PasswordBox Grid.Column="1"',
    '                                         Name="SteamCredentialPassword"/>',
    '                            <Image Grid.Column="2"',
    '                                   Name="SteamCredentialPasswordIcon"/>',
    '                            <Button Grid.Column="3"',
    '                                    Content="Edit"',
    '                                    Name="SteamCredentialEdit"',
    '                                    ToolTip="Edit the current credential and credential path"/>',
    '                            <Button Grid.Column="4"',
    '                                    Content="Assign"',
    '                                    Name="SteamCredentialAssign"',
    '                                    ToolTip="Use the current (username + password) to login to the Steam Workshop"/>',
    '                        </Grid>',
    '                        <Grid Grid.Row="2">',
    '                            <Grid.ColumnDefinitions>',
    '                                <ColumnDefinition Width="*"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                            </Grid.ColumnDefinitions>',
    '                            <Button Grid.Column="1"',
    '                                    Name="SteamCredentialSetup"',
    '                                    Content="Setup"',
    '                                    ToolTip="If steamcmd.exe was installed via this tool, you must perform an initial login for steamcmd.exe to finish install"/>',
    '                            <Button Grid.Column="2"',
    '                                    Name="SteamCredentialTest"',
    '                                    Content="Test"',
    '                                    ToolTip="Test the current credential"/>',
    '                        </Grid>',
    '                    </Grid>',
    '                    <Grid Grid.Row="1"',
    '                          Name="SteamWorkshopPanel"',
    '                          Visibility="Hidden">',
    '                        <Grid.RowDefinitions>',
    '                            <RowDefinition Height="10"/>',
    '                            <RowDefinition Height="40"/>',
    '                            <RowDefinition Height="*"/>',
    '                        </Grid.RowDefinitions>',
    '                        <Border Grid.Row="0"',
    '                                Style="{StaticResource Line}"/>',
    '                        <Grid Grid.Row="1">',
    '                            <Grid.ColumnDefinitions>',
    '                                <ColumnDefinition Width="110"/>',
    '                                <ColumnDefinition Width="*"/>',
    '                            </Grid.ColumnDefinitions>',
    '                            <ComboBox Grid.Column="0"',
    '                                      Name="SteamWorkshopProjectSlot">',
    '                                <ComboBoxItem Content="Details"/>',
    '                                <ComboBoxItem Content="Preview"/>',
    '                                <ComboBoxItem Content="Vdf"/>',
    '                                <ComboBoxItem Content="Output"/>',
    '                            </ComboBox>',
    '                            <Grid Grid.Column="1"',
    '                                  Name="SteamWorkshopProjectDetailsHeader"',
    '                                  Visibility="Hidden">',
    '                                <Grid.ColumnDefinitions>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                    <ColumnDefinition Width="70"/>',
    '                                </Grid.ColumnDefinitions>',
    '                                <DataGrid Grid.Column="0"',
    '                                      Name="SteamWorkshopProjectDetailsSelected"',
    '                                      HeadersVisibility="None"',
    '                                      Height="20"',
    '                                      VerticalAlignment="Center"',
    '                                      SelectionMode="Single">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="&lt;Steam.Workshop.Item&gt;"',
    '                                                                   TextWrapping="Wrap"',
    '                                                                   FontFamily="Consolas"',
    '                                                                   Background="#000000"',
    '                                                                   Foreground="#00FF00"/>',
    '                                                        </Setter.Value>',
    '                                                    </Setter>',
    '                                                </Trigger>',
    '                                            </Style.Triggers>',
    '                                        </Style>',
    '                                    </DataGrid.RowStyle>',
    '                                    <DataGrid.Columns>',
    '                                        <DataGridTextColumn Header="Date"',
    '                                                            Binding="{Binding Date}"',
    '                                                            Width="135"/>',
    '                                        <DataGridTextColumn Header="Name"',
    '                                                            Binding="{Binding Name}"',
    '                                                            Width="*"/>',
    '                                        <DataGridTextColumn Header="Exists"',
    '                                                            Binding="{Binding Exists}"',
    '                                                            Width="50"/>',
    '                                    </DataGrid.Columns>',
    '                                </DataGrid>',
    '                                <Button Grid.Column="1"',
    '                                        Name="SteamWorkshopProjectRefresh"',
    '                                        Content="Refresh"/>',
    '                            </Grid>',
    '                            <Grid Grid.Column="1"',
    '                                  Name="SteamWorkshopProjectPreviewHeader"',
    '                                  Visibility="Hidden">',
    '                                <Grid.ColumnDefinitions>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                    <ColumnDefinition Width="70"/>',
    '                                    <ColumnDefinition Width="70"/>',
    '                                </Grid.ColumnDefinitions>',
    '                                <TextBox Grid.Column="0"',
    '                                         Name="SteamWorkshopProjectPreviewPathText"/>',
    '                                <CheckBox Grid.Column="1"',
    '                                          Name="SteamWorkshopProjectPreviewExists"',
    '                                          Content="Exists"',
    '                                          HorizontalAlignment="Center"/>',
    '                                <Button Grid.Column="2"',
    '                                        Name="SteamWorkshopProjectPreviewImport"',
    '                                        Content="Import"',
    '                                        ToolTip="Assign or overwrite the Steam Workshop preview image"/>',
    '                            </Grid>',
    '                            <Grid Grid.Column="1"',
    '                                  Name="SteamWorkshopProjectVdfHeader"',
    '                                  Visibility="Hidden">',
    '                                <Grid.ColumnDefinitions>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                    <ColumnDefinition Width="70"/>',
    '                                    <ColumnDefinition Width="70"/>',
    '                                </Grid.ColumnDefinitions>',
    '                                <TextBox Grid.Column="0"',
    '                                         Name="SteamWorkshopProjectVdfPathText"/>',
    '                                <CheckBox Grid.Column="1"',
    '                                          Name="SteamWorkshopProjectVdfExists"',
    '                                          Content="Exists"',
    '                                          HorizontalAlignment="Center"/>',
    '                                <Button Grid.Column="2"',
    '                                        Name="SteamWorkshopProjectVdfApply"',
    '                                        Content="Apply"',
    '                                        ToolTip="Write the (*.vdf) content below to file"/>',
    '                            </Grid>',
    '                        </Grid>',
    '                        <Grid Grid.Row="2"',
    '                              Name="SteamWorkshopProjectDetailsPanel"',
    '                              Visibility="Hidden">',
    '                            <Grid.RowDefinitions>',
    '                                <RowDefinition Height="*"/>',
    '                                <RowDefinition Height="40"/>',
    '                            </Grid.RowDefinitions>',
    '                            <DataGrid Grid.Row="0"',
    '                                      Name="SteamWorkshopProjectDetails"',
    '                                      HeadersVisibility="None"',
    '                                      SelectionMode="Single">',
    '                                <DataGrid.RowStyle>',
    '                                    <Style TargetType="{x:Type DataGridRow}">',
    '                                        <Style.Triggers>',
    '                                            <Trigger Property="IsMouseOver" Value="True">',
    '                                                <Setter Property="ToolTip">',
    '                                                    <Setter.Value>',
    '                                                        <TextBlock Text="&lt;Steam.Workshop.Project.Detail&gt;"',
    '                                                                   TextWrapping="Wrap"',
    '                                                                   FontFamily="Consolas"',
    '                                                                   Background="#000000"',
    '                                                                   Foreground="#00FF00"/>',
    '                                                    </Setter.Value>',
    '                                                </Setter>',
    '                                            </Trigger>',
    '                                        </Style.Triggers>',
    '                                    </Style>',
    '                                </DataGrid.RowStyle>',
    '                                <DataGrid.Columns>',
    '                                    <DataGridTextColumn Header="Name"',
    '                                                        Binding="{Binding Name}"',
    '                                                        Width="120"/>',
    '                                    <DataGridTextColumn Header="Value"',
    '                                                        Binding="{Binding Value}"',
    '                                                        Width="*"/>',
    '                                </DataGrid.Columns>',
    '                            </DataGrid>',
    '                        </Grid>',
    '                        <Grid Grid.Row="2"',
    '                              Name="SteamWorkshopProjectPreviewPanel"',
    '                              Visibility="Hidden">',
    '                            <Image Name="SteamWorkshopProjectPreviewImage"',
    '                                   VerticalAlignment="Top"/>',
    '                        </Grid>',
    '                        <Grid Grid.Row="2"',
    '                              Name="SteamWorkshopProjectVdfPanel"',
    '                              Visibility="Hidden">',
    '                            <TextBox Name="SteamWorkshopProjectVdfContent"',
    '                                     Height="280"',
    '                                     Padding="2"',
    '                                     AcceptsReturn="True"',
    '                                     AcceptsTab="True"',
    '                                     VerticalAlignment="Top"',
    '                                     VerticalContentAlignment="Top"',
    '                                     HorizontalScrollBarVisibility="Auto"/>',
    '                        </Grid>',
    '                        <Grid Grid.Row="2"',
    '                              Name="SteamWorkshopProjectOutputPanel"',
    '                              Visibility="Hidden">',
    '                            <DataGrid Name="SteamWorkshopProjectOutput"',
    '                                      SelectionMode="Single">',
    '                                <DataGrid.RowStyle>',
    '                                    <Style TargetType="{x:Type DataGridRow}">',
    '                                        <Style.Triggers>',
    '                                            <Trigger Property="IsMouseOver" Value="True">',
    '                                                <Setter Property="ToolTip">',
    '                                                    <Setter.Value>',
    '                                                        <TextBlock Text="{Binding Fullname}"',
    '                                                                   TextWrapping="Wrap"',
    '                                                                   FontFamily="Consolas"',
    '                                                                   Background="#000000"',
    '                                                                   Foreground="#00FF00"/>',
    '                                                    </Setter.Value>',
    '                                                </Setter>',
    '                                            </Trigger>',
    '                                        </Style.Triggers>',
    '                                    </Style>',
    '                                </DataGrid.RowStyle>',
    '                                <DataGrid.Columns>',
    '                                    <DataGridTextColumn Header="Type"',
    '                                                        Binding="{Binding Type}"',
    '                                                        Width="70"/>',
    '                                    <DataGridTextColumn Header="Date"',
    '                                                        Binding="{Binding Date}"',
    '                                                        Width="135"/>',
    '                                    <DataGridTextColumn Header="Name"',
    '                                                        Binding="{Binding Name}"',
    '                                                        Width="*"/>',
    '                                    <DataGridTextColumn Header="Length"',
    '                                                        Binding="{Binding Length}"',
    '                                                        Width="70"',
    '                                                        ElementStyle="{StaticResource rTextBlock}"/>',
    '                                </DataGrid.Columns>',
    '                            </DataGrid>',
    '                        </Grid>',
    '                    </Grid>',
    '                    <Grid Grid.Row="2">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <Button Grid.Column="0"',
    '                                Name="SteamWorkshopProjectUpdate"',
    '                                Content="Update Project"',
    '                                ToolTip="Synchronize the currently selected map to the currently selected project"/>',
    '                        <Button Grid.Column="1"',
    '                                Name="SteamWorkshopProjectUpload"',
    '                                Content="Upload Project"',
    '                                ToolTip="Upload &lt;this project&gt; into the Steam workshop"/>',
    '                        <Button Grid.Column="2"',
    '                                Name="SteamWorkshopProjectReference"',
    '                                Content="Reference Project"',
    '                                ToolTip="View &lt;this.project&gt; referenced in the Steam workshop"/>',
    '                    </Grid>',
    '                </Grid>',
    '            </TabItem>',
    '            <TabItem Header="Console"',
    '                     Name="ConsoleTab">',
    '                <Grid>',
    '                    <Grid.RowDefinitions>',
    '                        <RowDefinition Height="10"/>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="*"/>',
    '                        <RowDefinition Height="40"/>',
    '                    </Grid.RowDefinitions>',
    '                    <Border Grid.Row="0" Background="Black" Margin="4"/>',
    '                    <Grid Grid.Row="1">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="120"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="90"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <ComboBox Grid.Column="0"',
    '                                  Name="ConsoleProperty"',
    '                                  SelectedIndex="3">',
    '                            <ComboBoxItem Content="Index"/>',
    '                            <ComboBoxItem Content="Elapsed"/>',
    '                            <ComboBoxItem Content="State"/>',
    '                            <ComboBoxItem Content="Status"/>',
    '                        </ComboBox>',
    '                        <TextBox Grid.Column="1"',
    '                                 Name="ConsoleFilter"/>',
    '                        <Button  Grid.Column="3"',
    '                                 Name="ConsoleRefresh"',
    '                                 Content="Refresh"/>',
    '                    </Grid>',
    '                    <DataGrid Grid.Row="2"',
    '                              Name="ConsoleOutput"',
    '                              SelectionMode="Extended"',
    '                              FontSize="10">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}"',
    '                                   BasedOn="{StaticResource xDataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="{Binding String}"',
    '                                                           Style="{StaticResource xTextBlock}"/>',
    '                                            </Setter.Value>',
    '                                        </Setter>',
    '                                        <Setter Property="ToolTipService.ShowDuration"',
    '                                                Value="360000000"/>',
    '                                    </Trigger>',
    '                                </Style.Triggers>',
    '                            </Style>',
    '                        </DataGrid.RowStyle>',
    '                        <DataGrid.Columns>',
    '                            <DataGridTextColumn Header="#"',
    '                                                Binding="{Binding Index}"',
    '                                                Width="40"/>',
    '                            <DataGridTextColumn Header="Elapsed"',
    '                                                Binding="{Binding Elapsed}"',
    '                                                Width="115"/>',
    '                            <DataGridTextColumn Header="%"',
    '                                                Binding="{Binding State}"',
    '                                                Width="15"/>',
    '                            <DataGridTextColumn Header="Status"',
    '                                                Binding="{Binding Status}"',
    '                                                Width="*"/>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <Grid Grid.Row="3">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="25"/>',
    '                            <ColumnDefinition Width="90"/>',
    '                            <ColumnDefinition Width="90"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <TextBox Grid.Column="0"',
    '                                 Name="ConsolePathText"/>',
    '                        <Image Grid.Column="1"',
    '                               Name="ConsolePathIcon"/>',
    '                        <Button Grid.Column="2"',
    '                                Name="ConsolePathBrowse"',
    '                                Content="Browse"/>',
    '                        <Button Grid.Column="3"',
    '                                Name="ConsoleSave"',
    '                                Content="Save/Exit"/>',
    '                    </Grid>',
    '                </Grid>',
    '            </TabItem>',
    '        </TabControl>',
    '    </Grid>',
    '</Window>' -join "`n")
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
        $This.IO             = [System.Windows.Markup.XamlReader]::Load($This.Node)
        
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

#    ____                                                                                                    ________    
#   //¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
#   \\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\__//¯¯¯    
#    ¯¯¯\\__[ Resource + Registry ]_________________________________________________________________________//¯¯¯        
#        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯            

Class Q3ALiveResourceRoot
{
    [String] $Name
    [String] $Created
    [String] $Modified
    [String] $Fullname
    [UInt32] $Exists
    [Object] $Output
    Q3ALiveResourceRoot([String]$Path)
    {
        $Item = Get-Item $Path -EA 0
        If (!$Item)
        {
            New-Item $Path -ItemType Directory -EA 0
            New-Item "$Path\dependencies" -ItemType Directory -EA 0
            New-Item "$Path\logs" -ItemType Directory -EA 0
            
            $Item = Get-Item $Path -EA 0
        }

        $This.Created  = $Item.CreationTime.ToString("MM/dd/yyyy HH:mm:ss")
        $This.Modified = $Item.LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss")
        $This.Name     = $Item.Name
        $This.Fullname = $Item.Fullname
        $This.Exists   = 1

        $This.Refresh()
    }
    Clear()
    {
        $This.Output       = @( )
    }
    Refresh()
    {
        $This.Clear()

        $This.Output       = Get-ChildItem $This.Fullname -EA 0
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALiveByteSize]::New("File",$Bytes)
    }
    [String] ToString()
    {
        Return $This.Fullname
    }
}

Enum Q3ALiveRegistryInstallType
{
    DisplayName
    DisplayIcon
    Publisher
    DisplayVersion
    InstallLocation
    RegistryPath
    UninstallString
}

Enum Q3ALiveRegistryBaseType
{
    Resource
    Name
    DisplayName
    Version
    Fullname
    InstallDate
    Editor
}

Enum Q3ALiveRegistryReferenceType
{
    Settings
    Component
    Radiant
    Dependency
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
        }
    }
    Validate()
    {
        ForEach ($Item in $This.Property)
        {
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
    [String] $Editor
    [UInt32] $Exists
    [Object] $Settings
    [Object] $Component
    [Object] $Radiant
    [Object] $Dependency
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
        $This.Editor        = "<not set>"
    }
    GetProperty()
    {
        $Item              = Get-ItemProperty $This.Fullname
        $This.Resource     = $Item.Resource
        $This.Name         = $Item.Name
        $This.DisplayName  = $Item.DisplayName
        $This.Version      = $Item.Version
        $This.InstallDate  = $Item.InstallDate
        $This.Editor       = $Item.Editor
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
        $This.Component.Create()
        $This.Radiant.Create()
        $This.Dependency.Create()

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
            $This.Component.Refresh()
            $This.Radiant.Refresh()
            $This.Dependency.Refresh()
        }
    }
    Validate()
    {
        If ($This.Exists)
        {
            $This.Settings.Validate()
            $This.Component.Validate()
            $This.Radiant.Validate()
            $This.Dependency.Validate()
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
        Return [System.Enum]::GetNames([Q3ALiveRegistryBaseType])
    }
    [String[]] ReferenceTypes()
    {
        Return [System.Enum]::GetNames([Q3ALiveRegistryReferenceType])
    }
    [String[]] rstr([String]$Type)
    {
        $String = Switch ($Type)
        {
            Settings
            {
                "Q3A Live ImageMagick 7Zip Q3ASE Workspace Steam Credential Workshop"
            }
            Component
            {
                "Q3A Live"
            }
            Radiant
            {
                "GtkRadiant NetRadiant NetRadiant-Custom"
            }
            Dependency
            {
                "7Zip ImageMagick Q3ASE Steam GtkRadiant NetRadiant NetRadiant-Custom"
            }
        }

        Return $String -Split " "
    }
    [String[]] Display()
    {
        $Hash  = @{ }
        $List = @($This.BaseTypes(); $This.ReferenceTypes())
        $Max  = $List | Sort-Object Length | Select-Object -Last 1

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
                        Dependency
                        {
                            ForEach ($Property in $This.Dependency.Property)
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

# Controller

Class Q3ALiveController
{
    [Object] $Module     # Fighting Entropy module (manages logging for console)
    [Object] $Xaml       # GUI I/O (Xaml controls)
    [Object] $Resource   # Resource (dependencies + main logging)
    [Object] $Registry   # Registry (generates and manages persistent keys + properties)
    [Object] $Component  # Quake III Arena/Quake Live (could possibly accommodate other games)
    [Object] $Dependency # Various tools (some required)
    [Object] $Workspace  # Source assets (handles archive logging)
    [Object] $Assignment # Used to orchestrate tasks related to selection and management of compilation and assets
    [Object] $Compile    # All of the options for compiling a particular map or array of maps
    [Object] $Asset      # Manages and handles all of the map assets to publish a single map, or multiple
    [Object] $Steam      # Manages the interactions with steamcmd.exe to publish work to the Steam Workshop
    Q3ALiveController()
    {
        # Creates an instance of the module
        $This.Module = Get-FEModule -Mode 1
        $This.Module.Console.Reset()
        $This.Module.Console.Initialize()
    }
    Q3ALiveController([Object]$Module)
    {
        # Accepts and assigns an instance of the module
        $This.Module = $Module
        $This.Module.Console.Reset()
        $This.Module.Console.Initialize()
    }
    Update([Int32]$State,[String]$Status)
    {
        # Updates the console
        $This.Module.Update($State,$Status)
        If ($This.Module.Mode -ne 0)
        {
            $xStatus = $This.Module.Console.Last()

            # Adds the item to GUI console
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
    [String] IconStatus([UInt32]$Flag)
    {
        Return $This.Module._Control(@("failure.png","success.png","warning.png")[$Flag]).Fullname
    }
    [String] LogPath()
    {
        $xPath = "{0}\Logs" -f $This.Registry.Root
        
        If (![System.IO.Directory]::Exists($xPath))
        {
            [System.IO.Directory]::CreateDirectory($xPath) > $Null
        }

        Return $xPath
    }
    [String] Now()
    {
        Return [DateTime]::Now.ToString("yyyy-MMdd_HHmmss")
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
    [String] ProjectName()
    {
        Return "Q3A-Live"
    }
    [String] UninstallPath()
    {
        Return "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
    }
    [String] DefaultResourcePath()
    {
        Return "{0}\{1}\{2}" -f [Environment]::GetEnvironmentVariable("ProgramData"), $This.CompanyName(), $This.ProjectName()
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
    ConfigRefresh()
    {
        $Ctrl    = $This

        $Item    = Get-Item $Ctrl.DefaultUninstallPath() -EA 0
        If ($Item)
        {
            $Ctrl.GetResource($Item.GetValue("InstallLocation"))
            $Ctrl.GetRegistry($Item.GetValue("RegistryPath"))

            # Xaml
            If ($Ctrl.Xaml)
            {
                $Ctrl.Xaml.IO.ConfigInstall.IsEnabled   = 0
                $Ctrl.Xaml.IO.ConfigUninstall.IsEnabled = 1

                $Ctrl.Reset($Ctrl.Xaml.IO.ResourceOutput,$Ctrl.Resource)
                
                $Ctrl.Xaml.IO.RegistryPathText.Text     = $Ctrl.Registry.Fullname

                $Ctrl.RegistrySlot()
            }
        }
        If (!$Item)
        {
            $Ctrl.Resource = $Null
            $Ctrl.Registry = $Null

            If ($Ctrl.Xaml)
            {
                $Ctrl.Xaml.IO.ConfigInstall.IsEnabled   = 1
                $Ctrl.Xaml.IO.ConfigUninstall.IsEnabled = 0

                $Ctrl.Reset($Ctrl.Xaml.IO.ResourceOutput,$Null)

                $Ctrl.Xaml.IO.RegistryPathText.Text = "<not installed>"

                $Ctrl.RegistrySlot()
            }
        }
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

                ForEach ($Name in [System.Enum]::GetNames([Q3ALiveRegistryInstallType]))
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

            # Resource path
            If (Test-Path $Item.GetValue("InstallLocation"))
            {
                $Ctrl.Update(0,"Removing [-] Resource: $($Item.GetValue("InstallLocation"))")
                Remove-Item $Item.GetValue("InstallLocation") -Recurse -Force -Verbose -EA 0
            }

            # Registry Path
            If (Test-Path $Item.GetValue("RegistryPath"))
            {
                $Ctrl.Update(0,"Removing [-] Registry: $($Item.InstallLocation)")
                Remove-Item $Item.GetValue("RegistryPath") -Recurse -Force -Verbose -EA 0
            }

            # Uninstall Key
            $Ctrl.Update(0,"Removing [-] Uninstall: $($Ctrl.DefaultUninstallPath())")
            Remove-Item $Ctrl.DefaultUninstallPath() -Recurse -Force -Verbose -EA 0
        }
    }
    GetFEModule()
    {
        $This.Module   = $This.FEModule()
    }
    GetXaml()
    {
        $This.Xaml     = $This.Q3ALiveXaml()
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
    GetResource([String]$Resource)
    {
        # Check if a valid path entered
        If ($This.CheckPathChars($Resource) -gt 0)
        {
            $This.Update(0,"Exception [!] Resource: [$Resource] contains invalid chars")
            Throw $This.Module.Console.Last().Status
        }

        Else
        {
            # Check if parent path exists
            $Parent = $Resource | Split-Path -Parent
            If (![System.IO.Directory]::Exists($Parent))
            {
                [System.IO.Directory]::CreateDirectory($Parent) > $Null
            }

            # Detect/Create the resource path + object
            $Message = @("Creating","Detected")[[UInt32]!![System.IO.Directory]::Exists($Resource)]

            $This.Update(0,"$Message [+] Resource: [$Resource]")

            $This.Resource = $This.Q3ALiveResourceRoot($Resource)
        }
    }
    GetRegistry([String]$Registry)
    {
        # Check if a valid path
        If ($This.CheckPathChars($Registry) -gt 0)
        {
            $This.Update(0,"Exception [!] Registry: [$Registry] contains invalid chars")
            Throw $This.Module.Console.Last().Status
        }

        Else
        {
            # Check if parent path exists
            $Parent = $Registry | Split-Path -Parent
            If (!(Test-Path $Parent -EA 0))
            {
                New-Item $Parent -EA 0
            }

            # Detect/Create the registry path + object
            $Message = @("Creating","Detected")[[UInt32]!!(Test-Path $Registry)]

            $This.Update(0,"$Message [+] Resource: [$Registry]")

            # Create the registry path + properties
            $This.Registry = $This.Q3ALiveRegistryBase($Registry)
            $This.Registry.Refresh()
            $This.Registry.Validate()
        }
    }
    GetComponent()
    {

    }
    GetDependency()
    {

    }
    RegistrySlot()
    {
        $Ctrl = $This

        $Slot   = $Ctrl.Xaml.IO.RegistrySlot.SelectedItem.Content
        $Object = Switch ([UInt32]!!$Ctrl.Registry)
        {
            0
            {
                $Null
            }
            1
            {
                $Ctrl.Registry.$Slot.Property
            }
        }

        $Ctrl.Reset($Ctrl.Xaml.IO.RegistryProperty,$Object)

        # Clear all bottom fields
        $Ctrl.Xaml.IO.RegistryPropertyNameText.Text       = ""
        $Ctrl.Xaml.IO.RegistryPropertyValueText.Text      = ""

        $Ctrl.Xaml.IO.RegistryPropertyBrowse.IsEnabled    = 0
        $Ctrl.Xaml.IO.RegistryPropertyApply.IsEnabled     = 0

        $Ctrl.Xaml.IO.RegistryPropertyValueText.IsEnabled = 0
        $Ctrl.Xaml.IO.RegistryPropertyBrowse.IsEnabled    = 0
        $Ctrl.Xaml.IO.RegistryPropertyApply.IsEnabled     = 0
    }
    RegistryProperty()
    {
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.RegistryProperty.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.RegistryProperty.SelectedItem
            
            $Ctrl.Xaml.IO.RegistryPropertyNameText.Text       = $Item.Name
            $Ctrl.Xaml.IO.RegistryPropertyValueText.Text      = $Item.Value

            $Ctrl.Xaml.IO.RegistryPropertyValueText.IsEnabled = [UInt32]($Item.Name -notin $Ctrl.Registry.BaseTypes())
            $Ctrl.Xaml.IO.RegistryPropertyValueIcon.Source    = $Null
            $Ctrl.Xaml.IO.RegistryPropertyBrowse.IsEnabled    = [UInt32]($Item.Name -notin $Ctrl.Registry.BaseTypes())
            $Ctrl.Xaml.IO.RegistryPropertyApply.IsEnabled     = 0
        }
        Else
        {
            $Ctrl.Xaml.IO.RegistryPropertyValueText.IsEnabled = 0
            $Ctrl.Xaml.IO.RegistryPropertyBrowse.IsEnabled    = 0
            $Ctrl.Xaml.IO.RegistryPropertyApply.IsEnabled     = 0
        }
    }
    RegistryPropertyValueText()
    {
        $Ctrl                                              = $This

        If ($Ctrl.Xaml.IO.RegistryProperty.SelectedIndex -ne -1)
        {
            $Item                                              = $Ctrl.Xaml.IO.RegistryProperty.SelectedItem
            $Value                                             = $Ctrl.Xaml.IO.RegistryPropertyValueText.Text

            If (!$Value)
            {
                $Ctrl.Xaml.IO.RegistryPropertyValueIcon.Source = $Ctrl.IconStatus(0)
                $Ctrl.Xaml.IO.RegistryPropertyApply.IsEnabled  = 0
            }
            ElseIf ($Item.Name -notin $Ctrl.Registry.BaseTypes())
            {
                $Flag                                          = [UInt32](Test-Path $Value -EA 0)
                $Ctrl.Xaml.IO.RegistryPropertyValueIcon.Source = $Ctrl.IconStatus($Flag)
                $Ctrl.Xaml.IO.RegistryPropertyApply.IsEnabled  = [UInt32]($Value -ne $Ctrl.Registry.$($Item.Name))
            }
        }
        Else
        {

        }
    }
    RegistryPropertyBrowse()
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Browsing [~] Registry property target")

        $Dialog              = $Ctrl.FolderBrowserDialog()
        $Dialog.ShowDialog()

        If ([System.IO.Directory]::Exists($Dialog.SelectedPath))
        {
            $Ctrl.Xaml.IO.RegistryPropertyValueText.Text = $Dialog.SelectedPath

            $Ctrl.Update(0,"Selected [+] Path: $($Dialog.SelectedPath)")
        }
        Else
        {
            $Ctrl.Update(0,"Selected [!] Path: <not set>")
        }
    }
    RegistryPropertyApply()
    {
        $Ctrl       = $This

        $Item       = $Ctrl.Xaml.IO.RegistryProperty.SelectedItem
        $Slot       = $Ctrl.Xaml.IO.RegistrySlot.SelectedItem.Content
        $Value      = $Ctrl.Xaml.IO.RegistryPropertyValueText.Text

        If ($Value -ne $Item.Value)
        {
            $Item.Value = $Value
            $Item.Apply()
        }

        $Ctrl.Xaml.IO.RegistryPropertyApply.IsEnabled = 0

        $Ctrl.Reset($Ctrl.Xaml.IO.RegistryProperty,$Ctrl.Registry.$Slot.Property)
        
        $Ctrl.Xaml.IO.RegistryPropertyNameText.Text  = $Null
        $Ctrl.Xaml.IO.RegistryPropertyValueText.Text = $Null
    }
    [Object] FEModule()
    {
        Return Get-FEModule -Mode 1
    }
    [Object] Q3ALiveByteSize([String]$Name,[UInt64]$Bytes)
    {
        Return [Q3ALiveByteSize]::New($Name,$Bytes)
    }
    [Object] Q3ALiveXaml()
    {
        Return [XamlWindow][Q3ALiveXaml]::Content
    }
    [Object] Q3ALiveResourceRoot([String]$Path)
    {
        Return [Q3ALiveResourceRoot]::New($Path)
    }
    [Object] Q3ALiveRegistryBase([String]$Fullname)
    {
        Return [Q3ALiveRegistryBase]::New($Fullname)
    }
    [Object] FolderBrowserDialog()
    {
        Return [System.Windows.Forms.FolderBrowserDialog]::New()
    }
    UninstallPrompt()
    {
        $Ctrl     = $This

        $Caption  = "Confirm"
        $Message  = "Are you sure you want to uninstall Q3A-Live and remove all files?"
        $Choices  = "YesNo"
        #$Choices = "&Yes","&No"
        #$Default = 1
        
        $Ctrl.Update(0,"Prompt [~] $Message")
        #(Get-Host).UI.PromptForChoice($Caption,$Message,$Choices,$Default))
        Switch ([System.Windows.Forms.MessageBox]::Show($Message,$Caption,$Choices))
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
    Prime()
    {
        # basically the same thing as Main()
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

                $Ctrl.Xaml.IO.ConfigRefresh.Add_Click(
                {
                    $Ctrl.ConfigRefresh()
                })

                $Ctrl.Xaml.IO.RegistrySlot.Add_SelectionChanged(
                {
                    $Ctrl.RegistrySlot()
                })

                $Ctrl.Xaml.IO.RegistryProperty.Add_SelectionChanged(
                {
                    $Ctrl.RegistryProperty()
                })

                $Ctrl.Xaml.IO.RegistryPropertyValueText.Add_TextChanged(
                {
                    $Ctrl.RegistryPropertyValueText()
                })

                $Ctrl.Xaml.IO.RegistryPropertyBrowse.Add_Click(
                {
                    $Ctrl.RegistryPropertyBrowse()    
                })

                $Ctrl.Xaml.IO.RegistryPropertyValueText.Add_TextChanged(
                {
                    $Ctrl.RegistryPropertyValueText()
                })

                $Ctrl.Xaml.IO.RegistryPropertyValueText.Add_GotFocus(
                {
                    $Item  = $Ctrl.Xaml.IO.RegistryProperty.SelectedItem
                    $Value = $Ctrl.Xaml.IO.RegistryPropertyValueText.Text

                    If ($Value -eq $Item.Default)
                    {
                        $Ctrl.Xaml.IO.RegistryPropertyValueText.Text = ""
                    }
                })
    
                $Ctrl.Xaml.IO.RegistryPropertyValueText.Add_LostFocus(
                {
                    $Item  = $Ctrl.Xaml.IO.RegistryProperty.SelectedItem
                    $Value = $Ctrl.Xaml.IO.RegistryPropertyValueText.Text

                    If ($Value -ne $Item.Value)
                    {
                        $Ctrl.Xaml.IO.RegistryPropertyValueText.Text = $Value
                    }
                })

                $Ctrl.Xaml.IO.RegistryPropertyApply.Add_Click(
                {
                    $Ctrl.RegistryPropertyApply()
                })
            }
            Component
            {

            }
            Workspace
            {

            }
            Map
            {

            }
            Steam
            {

            }
            Console
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
                $Ctrl.Xaml.IO.ConfigInstall.IsEnabled             = 0
                $Ctrl.Xaml.IO.ConfigUninstall.IsEnabled           = 0
                $Ctrl.Xaml.IO.ConfigRefresh.IsEnabled             = 1

                # Resource
                $Ctrl.Xaml.IO.ResourceOutput.IsEnabled            = 1
                $Ctrl.Reset($Ctrl.Xaml.IO.ResourceOutput,$Null)

                # Registry
                $Ctrl.Xaml.IO.RegistryProperty.IsEnabled          = 1
                $Ctrl.Reset($Ctrl.Xaml.IO.RegistryProperty,$Null)

                # Registry Property
                $Ctrl.Xaml.IO.RegistryPropertyNameText.IsEnabled  = 0
                $Ctrl.Xaml.IO.RegistryPropertyValueText.IsEnabled = 1
                $Ctrl.Xaml.IO.RegistryPropertyBrowse.IsEnabled    = 0
                $Ctrl.Xaml.IO.RegistryPropertyApply.IsEnabled     = 0
            }
            Component
            {

            }
            Workspace
            {

            }
            Map
            {

            }
            Steam
            {

            }
            Console
            {

            }
        }
    }
    StageXaml()
    {
        # Event handlers for the xaml
        $This.Stage("Config")

        # Initial settings
        $This.Initial("Config")

        # Configuration refresh
        $This.ConfigRefresh()

        $This.Xaml.Invoke()
    }
    Reload()
    {
        $This.GetXaml()
        $This.GetConfig()
        $This.StageXaml()
    }
    Reset([Object]$xSender,[Object]$Object)
    {
        $xSender.Items.Clear()
        ForEach ($Item in $Object)
        {
            $xSender.Items.Add($Item)
        }
    }
    [String] ToString()
    {
        Return "<Q3ALive.Controller>"
    }
}

$Ctrl = [Q3ALiveController]::New()
$Ctrl.Reload()
