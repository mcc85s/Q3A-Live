Import-Module -Name FightingEntropy -Version 2024.1.0 -Force -EA 0

If (!(Get-Module -Name FightingEntropy -EA 0 | ? Version -eq 2024.1.0))
{
    $Install = Invoke-RestMethod "https://github.com/mcc85s/FightingEntropy/blob/main/FightingEntropy.ps1?raw=true"
    $Content = Invoke-RestMethod ("{0}?raw=true" -f $Install.TrimEnd("`n"))
    Invoke-Expression $Content
    $Module.Install()

    Import-Module -Name FightingEntropy -Version 2024.1.0 -Force -EA 0
}

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
    '            <TabItem Header="Components"',
    '                     ToolTip="(Components/Prerequisites) for Q3A-Live">',
    '                <Grid>',
    '                    <Grid.RowDefinitions>',
    '                        <RowDefinition Height="50"/>',
    '                        <RowDefinition Height="120"/>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="135"/>',
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
    '                            <ColumnDefinition Width="40"/>',
    '                        </Grid.ColumnDefinitions>',
    '                    </Grid>',
    '                    <Grid Grid.Row="1">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                        </Grid.ColumnDefinitions>',
    '                            <DataGrid Grid.Column="0"',
    '                                      Name="DependencyOutput">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="&lt;Q3ALive.Dependency.Item&gt;"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                        </Setter.Value>',
    '                                                    </Setter>',
    '                                                </Trigger>',
    '                                            </Style.Triggers>',
    '                                        </Style>',
    '                                    </DataGrid.RowStyle>',
    '                                    <DataGrid.Columns>',
    '                                        <DataGridTextColumn Header="Dependency"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="80"/>',
    '                                        <DataGridTextColumn Header="Version"',
    '                                                Binding="{Binding Version}"',
    '                                                Width="60"/>',
    '                                        <DataGridTextColumn Header="DisplayName"',
    '                                                Binding="{Binding DisplayName}"',
    '                                                Width="80"/>',
    '                                        <DataGridTextColumn Header="+"',
    '                                                Binding="{Binding Installed}"',
    '                                                Width="20"/>',
    '                                        <DataGridTextColumn Header="Description"',
    '                                                Binding="{Binding Description}"',
    '                                                Width="*"/>',
    '                                    </DataGrid.Columns>',
    '                                </DataGrid>',
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
    '                    <DataGrid Grid.Row="3"',
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
    '                    <Border Grid.Row="4"',
    '                            Style="{StaticResource Line}"/>',
    '                    <DataGrid Grid.Row="5"',
    '                              Name="RadiantProperty"',
    '                              HeadersVisibility="None"',
    '                              SelectionMode="Single">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="&lt;Q3ALive.Radiant.Item&gt;"',
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
    '                    </Grid.RowDefinitions>',
    '                    <Grid Grid.Row="0">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="80"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="25"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <Label Grid.Column="0"',
    '                               Style="{StaticResource LabelGray}"',
    '                               Content="Path:"/>',
    '                        <TextBox Grid.Column="1"',
    '                                 Name="WorkspacePathText"/>',
    '                        <Image Grid.Column="2"',
    '                               Name="WorkspacePathIcon"/>',
    '                        <Button Grid.Column="3"',
    '                                Name="WorkspacePathBrowse"',
    '                                Content="Browse"',
    '                                ToolTip="Open folder dialog to set workspace path"/>',
    '                        <Button Grid.Column="4"',
    '                                Name="WorkspacePathApply"',
    '                                Content="Apply"',
    '                                ToolTip="Set the workspace path to access workspace controls"/>',
    '                        <Button Grid.Column="5"',
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
    '                              Visibility="Hidden">',
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
    '                              Visibility="Hidden"',
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
    '                            <DataGridTextColumn Header="Type"',
    '                                                Binding="{Binding Type}"',
    '                                                Width="70"/>',
    '                            <DataGridTextColumn Header="Date"',
    '                                                Binding="{Binding Date}"',
    '                                                Width="135"/>',
    '                            <DataGridTextColumn Header="Name"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="*"/>',
    '                            <DataGridTextColumn Header="Length"',
    '                                                Binding="{Binding Length}"',
    '                                                Width="70"',
    '                                                ElementStyle="{StaticResource rTextBlock}"/>',
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
    '                    </Grid.RowDefinitions>',
    '                    <Grid Grid.Row="0">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="80"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="25"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <Label Grid.Column="0"',
    '                               Style="{StaticResource LabelRed}"',
    '                               Content="Name:"/>',
    '                        <TextBox Grid.Column="1"',
    '                                 Name="MapNameText"/>',
    '                        <Image Grid.Column="2"',
    '                               Name="MapNameIcon"/>',
    '                        <Button Grid.Column="3"',
    '                                Name="MapNameApply"',
    '                                Content="Apply"',
    '                                ToolTip="If valid, uses the (*.map) file to construct OR reconstitute map assets"/>',
    '                        <Button Grid.Column="4"',
    '                                Name="MapNameClear"',
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
    '                            <ColumnDefinition Width="*"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <Button Grid.Column="0"',
    '                                Name="SteamWorkshopProjectCreate"',
    '                                Content="Create"',
    '                                ToolTip="Create &lt;this project&gt; in local workshop path"/>',
    '                        <Button Grid.Column="1"',
    '                                Name="SteamWorkshopProjectRemove"',
    '                                Content="Remove"',
    '                                ToolTip="Remove &lt;this project&gt; in the local workshop path"/>',
    '                        <Button Grid.Column="2"',
    '                                Name="SteamWorkshopProjectUpload"',
    '                                Content="Upload"',
    '                                ToolTip="Upload &lt;this project&gt; into the Steam workshop"/>',
    '                        <Button Grid.Column="3"',
    '                                Name="SteamWorkshopProjectReference"',
    '                                Content="Reference"',
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

<# [Idea for module function Write-Xaml]

$Name     = "Q3ALive.Master"
$Filepath = "C:\Users\mcadmin\source\repos\DesignView\DesignView\Q3ALiveXaml.xaml"

Write-Xaml -Name $Name -FilePath $FilePath | Set-Clipboard

#>

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

Enum Q3ALiveRegistryType
{
    Radiant
    Archive
    Image
    Shader
    Workspace
    Steam
    Workshop
    Credential
}

Class Q3ALiveRegistryEntry
{
    [UInt32]      $Index
    [String]       $Name
    [DateTime]     $Date
    [String]   $Fullname
    [String]    $Radiant
    [String]    $Archive
    [String]      $Image
    [String]     $Shader
    [String]  $Workspace
    [String]      $Steam
    [String]   $Workshop
    [String] $Credential
    Q3ALiveRegistryEntry([UInt32]$Index,[Object]$Object)
    {
        $This.Index    = $Index
        $This.Name     = $Object.Name | Split-Path -Leaf
        $This.Fullname = $Object.Name -Replace $Object.PSDrive.Root, "$($Object.PSDrive.Name):"
        $This.GetDate()
        $This.GetProperties()
        $This.CheckDependencyProperties()
    }
    GetDate()
    {
        $Month         = $This.Name.Substring(4,2)
        $Day           = $This.Name.Substring(6,2)
        $Year          = $This.Name.Substring(0,4)
        $Hour          = $This.Name.Substring(9,2)
        $Minute        = $This.Name.Substring(11,2)
        $Second        = $This.Name.Substring(13,2)
        $String        = "{0}/{1}/{2} {3}:{4}:{5}" -f $Month, $Day, $Year, $Hour, $Minute, $Second
        $This.Date     = [DateTime]$String
    }
    GetProperties()
    {
        $Item            = Get-ItemProperty -Path $This.Fullname
        ForEach ($Type in $This.Types())
        {
            $This.$Type  = $Item.$Type 
        }
    }
    CheckDependencyProperties()
    {
        ForEach ($Item in "Radiant","Archive","Image","Shader","Steam")
        {
            If (![System.IO.Directory]::Exists($This.$Item))
            {
                $This.$Item = $Null
            }
        }
    }
    SetProperty([String]$Name,[String]$Value)
    {
        $This.$Name = $Value
        Set-ItemProperty -Path $This.Fullname -Name $Name -Value $Value
    }
    SetProperty([String]$Name)
    {
        Set-ItemProperty -Path $This.Fullname -Name $Name -Value $This.$Name
    }
    SetProperties()
    {
        ForEach ($Type in $This.Types())
        {
            $This.SetProperty($Type)
        }
    }
    [String[]] Types()
    {
        Return [System.Enum]::GetNames([Q3ALiveRegistryType])
    }
    [String] ToString()
    {
        Return "<Q3ALive.Registry.Entry>"
    }
}

Class Q3ALiveRegistryRoot
{
    [String]      $Path
    [Object] $Uninstall
    [Object]    $Output
    [UInt32]  $Selected
    Q3ALiveRegistryRoot()
    {
        $This.Path = $This.Q3ALive()
        $This.Check()
    }
    [Object] Q3ALiveRegistryUninstall([UInt32]$Index,[Object]$Object)
    {
        Return [Q3ALiveRegistryUninstall]::New($Index,$Object)
    }
    [Object] Q3ALiveRegistryEntry([UInt32]$Index,[Object]$Object)
    {
        Return [Q3ALiveRegistryEntry]::New($Index,$Object)
    }
    [String[]] GetUninstallPath()
    {
        Return "", "\WOW6432Node" | % { "Hklm:\Software$_\Microsoft\Windows\CurrentVersion\Uninstall\*" }
    }
    Check()
    {
        If (!(Test-Path $This.Path))
        {
            $Split = $This.Path -Split "\\"
            $xPath = $Split[0]
            ForEach ($X in 1..($Split.Count-1))
            {
                $xPath = $xPath, $Split[$X] -join "\"
                If (!(Test-Path $xPath))
                {
                    New-Item -Path $xPath
                }
            }
        }
    }
    GetUninstall()
    {
        $This.Uninstall      = @( )
        $xUninstall          = $This.GetUninstallPath() | % { Get-ItemProperty $_ }

        ForEach ($Item in $xUninstall | ? DisplayName -match "(^Quake III Arena$|^Quake Live$|^7-Zip|^ImageMagick)")
        {
            $This.Uninstall += $This.Q3ALiveRegistryUninstall($This.Uninstall.Count,$Item)
        }
    }
    Refresh()
    {
        $This.GetUninstall()
        $This.Output    = @( )

        ForEach ($Item in Get-ChildItem $This.Path | Sort-Object Name)
        {
            $This.Output += $This.Q3ALiveRegistryEntry($This.Tree.Count,$Item)
        }

        $This.Rerank()
    }
    [Object] Current()
    {
        If ($This.Selected -in $This.Output.Index)
        {
            Return $This.Output | ? Index -eq $This.Selected
        }
        Else
        {
            Return $Null
        }
    }
    SetSelection([UInt32]$Index)
    {
        If ($Index -in $This.Output.Index)
        {
            $This.Selected = $Index
        }
        Else
        {
            $This.Selected = -1
        }
    }
    Rerank()
    {
        Switch ($This.Output.Count)
        {
            0
            {

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
    [String] Q3ALive()
    {
        Return "HKLM:\SOFTWARE\Policies\Secure Digits Plus LLC\Q3ALive"
    }
    [String] ToString()
    {
        Return "<Q3ALive.Registry.Root>"
    }
}

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

Enum Q3ALiveDependencyType
{
    GtkRadiant
    _7Zip
    ImageMagick
    Q3ASE
    Steam
}

Class Q3ALiveDependencyItem
{
    [UInt32]         $Index
    [String]          $Name
    [String]       $Version
    [String]   $DisplayName
    [UInt32]     $Installed
    [String]   $Description
    [String]           $Url
    [String]          $Hash
    [String]          $Size
    [String]      $FileName
    [String]      $FileType
    [String]     $Directory
    [String]      $FilePath
    Q3ALiveDependencyItem([UInt32]$Index,[String]$Name,[String]$Version,[String]$Description,[String]$Hash,[String]$Url,[String]$Size)
    {
        $This.Index        = $Index
        $This.Name         = $Name
        $This.GetDisplayName()
        $This.Version      = $Version
        $This.Description  = $Description
        $This.Hash         = $Hash
        $This.Url          = $Url
        $This.Size         = $Size
        $This.GetFilenameType()
    }
    GetDisplayName()
    {
        $This.DisplayName = Switch -Regex ($This.Name)
        {
            GtkRadiant  { "Radiant" }
            _7zip       { "Archive" }
            ImageMagick { "Image"   }
            Q3ASE       { "Shader"  }
            Steam       { "Steam"   }
        }
    }
    GetFilenameType()
    {
        $This.FileName     = $This.Url.Split("/")[-1]

        If ($This.Filename -match "\?")
        {
            $This.Filename = $This.Filename.Split("?")[0] 
        }

        $This.FileType     = @{ exe = "Executable"; zip = "Archive"}[$This.FileName.Split(".")[-1]]
    }
    [String] ToString()
    {
        Return "<Q3ALive.Dependency.Item>"
    }
}

Class Q3ALiveDependencyMaster
{
    [String]     $Path
    [UInt32]   $Exists
    [UInt32] $Selected
    [Object]   $Output
    Q3ALiveDependencyMaster()
    {
        $This.Path = $This.DependencyPath()
        $This.Check()

        If (!$This.Exists)
        {
            $This.Create()
        }

        $This.Refresh()
    }
    Check()
    {
        $This.Exists = [UInt32][System.IO.Directory]::Exists($This.Path)
    }
    Create()
    {
        If (!$This.Exists)
        {
            [System.IO.Directory]::CreateDirectory($This.Path) > $Null
            $This.Check()
        }
    }
    [String] DependencyPath()
    {
        Return "{0}\Secure Digits Plus LLC\Q3A-Live\dependencies" -f [Environment]::GetEnvironmentVariable("ProgramData")
    }
    Clear()
    {
        $This.Output = @( )
    }
    Refresh()
    {
        $This.Clear()

        ForEach ($Type in $This.Dependencies())
        {
            $Item = Switch -Regex ($Type)
            {
                GtkRadiant
                {
                    "GtkRadiant",
                    "1.6.7",
                    "idTech3 map editor w/ compilation tools",
                    "D7C2C334FFB0B9F611FDC30D19BCF6F8",
                    "https://s3.amazonaws.com/GtkRadiant/GtkRadiant-1.6.7-20230820.zip",
                    "104.51 MB"
                }
                _7Zip
                {
                    "_7Zip",
                    "24.08",
                    "Archive creation tool",
                    "0330D0BD7341A9AFE5B6D161B1FF4AA1",
                    "https://www.7-zip.org/a/7z2408-x64.exe",
                    "1.55 MB"
                }
                ImageMagick
                {
                    "ImageMagick",
                    "7.1.1.38",
                    "Command line based image manipulation tool",
                    "9BB56A6A1079467E8E51E343F08F7577",
                    "https://imagemagick.org/archive/binaries/ImageMagick-7.1.1-38-Q16-HDRI-x64-dll.exe",
                    "21.99 MB"
                }
                Q3ASE
                {
                    "Q3ASE",
                    "1.2.1",
                    "Quake 3 Arena Shader Editor",
                    "EE98BE75ECA5C6F9AD146F12CD39AA72",
                    "https://github.com/mcc85s/Q3A-Live/blob/main/Dependency/Q3ASE/q3ase.zip?raw=true",
                    "316.49 KB"

                }
                Steam
                {
                    "Steam",
                    "1.0.0",
                    "Steam Workshoop command line tool (steamcmd)",
                    "C320ECF2C5D82B605E81BC11A8078C39",
                    "https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip",
                    "756.67 KB"
                }
            }

            $This.AddDependency($Item[0],$Item[1],$Item[2],$Item[3],$Item[4],$Item[5])
        }
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
    AddDependency([String]$Name,[String]$Version,[String]$Description,[String]$Hash,[String]$Url,[String]$Size)
    {
        If ($Name -notin $This.Output.Name)
        {
            $This.Output += $This.Q3ALiveDependencyItem($This.Output.Count,$Name,$Version,$Description,$Hash,$Url,$Size)
        }
    }
    [String[]] Dependencies()
    {
        Return [System.Enum]::GetNames([Q3ALiveDependencyType])
    }
    [Object] Q3ALiveDependencyItem([UInt32]$Index,[String]$Name,[String]$Version,[String]$Description,[String]$Hash,[String]$Url,[String]$Size)
    {
        Return [Q3ALiveDependencyItem]::New($Index,$Name,$Version,$Description,$Hash,$Url,$Size)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Dependency.Master>"
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

Class Q3ALiveWorkspaceEntry
{
    Hidden [UInt32] $Index
    [String]         $Type
    [String]         $Date
    [String]         $Name
    [Object]       $Length
    [String]     $Fullname
    Q3ALiveWorkspaceEntry([UInt32]$Index,[Object]$Object)
    {
        $This.Index    = $Index
        $This.Name     = $Object.Name
        $This.Fullname = $Object.Fullname
        $This.Date     = $Object.LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss")
        $This.Type     = @{ DirectoryInfo = "Directory"; FileInfo = "File" }[$Object.GetType().Name]
        $Bytes         = Switch ($This.Type) { Directory { 0 } Default { $Object.Length } }
        $This.Length   = $This.Q3ALiveByteSize($Bytes)
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALiveByteSize]::New("File",$Bytes)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Workspace.Entry>"
    }
}

Class Q3ALiveWorkspaceLogEntry
{
    [UInt32] $Index
    [String] $Date
    [String] $Time
    [String] $Hash
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
    [String]   $Type
    [String]   $Path
    [UInt32] $Exists
    [String]   $Date
    [Object] $Output
    Q3ALiveWorkspaceLog([String]$Path)
    {
        $This.Type = "Log"
        $This.Path = $Path
        $This.Check()

        If (!$This.Exists)
        {
            $This.Create()
        }
        
        $This.Refresh()
    }
    Check()
    {
        $This.Exists = [UInt32][System.IO.File]::Exists($This.Path)
    }
    [Object] Q3ALiveWorkspaceLogEntry([UInt32]$Index,[String]$Line)
    {
        Return [Q3ALiveWorkspaceLogEntry]::New($Index,$Line)
    }
    Refresh()
    {
        If ($This.Exists)
        {
            $Lines       = [System.IO.File]::ReadAllLines($This.Path)
            $This.Date   = $Lines[0].Substring(0,20)
            $This.Output = @( )
            $Hash        = @{ }
            Switch ($Lines.Count)
            {
                1 
                {
                    $Hash.Add(0,$This.Q3ALiveWorkspaceLogEntry(0,$Lines[0]))
                    $This.Output = @($Hash[0])
                }
                Default
                {                    
                    ForEach ($X in 0..($Lines.Count-1))
                    {
                        $Hash.Add($X,$This.Q3ALiveWorkspaceLogEntry($X,$Lines[$X]))
                    }

                    $This.Output = @($Hash[0..($Hash.Count-1)])
                }
            }
        }
    }
    Create()
    {
        If (![System.IO.File]::Exists($This.Log.Path))
        {
            $Content    = "{0} {1} {2}" -f [DateTime]::Now.ToString("MM/dd/yyyy HH:mm:ss"), "X".PadLeft(32,"X"), $This.Path
            [System.IO.File]::WriteAllLines($This.Log.Path,$Content)
            $This.Check()
        }
    }
    [String] LogHeader()
    {
        Return "Date       Time     Hash                             Source"
    }
    [String] ToString()
    {
        Return "<Q3ALive.Workspace.Log>"
    }
}

Class Q3ALiveWorkspace
{
    [String]   $Name
    [String]   $Path
    [Object]    $Log
    [Object] $Output
    Q3ALiveWorkspace([String]$Path)
    {
        $This.Name     = "Workspace"
        $This.Path     = $Path
        $This.Log      = $This.Q3ALiveWorkspaceLog("$($This.Path)\Q3ALive-workspace.log")
        $This.Refresh()
    }
    [Object] Q3ALiveWorkspaceLog([String]$Path)
    {
        Return [Q3ALiveWorkspaceLog]::New($Path)
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

        $This.Output = $xOutput | Sort-Object Fullname

        $This.Rerank()
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

Class Q3ALiveMapLevelshot
{
    [String] $Name
    [String] $Path
    [UInt32] $Exists
    [Byte[]] $Bytes
    Q3ALiveMapLevelshot([String]$Name,[String]$Path)
    {
        $This.Name = $Name
        $This.Path = $Path
        $This.Check()
    }
    Check()
    {
        $This.Exists = [System.IO.File]::Exists($This.Path)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Map.Levelshot>"
    }
}

Class Q3ALiveMapTexture
{
    [UInt32] $Index
    [String] $Shader
    [String] $Name
    [String] $Fullname
    [String] $Target
    Q3ALiveMapTexture([UInt32]$Index,[String]$Name)
    {
        $This.Index    = $Index
        $Split         = $Name.Split("/")
        $This.Shader   = $Split[0]
        $This.Name     = $Split[1]
        $This.Fullname = $Name
    }
    [String] ToString()
    {
        Return "<Q3ALive.Map.Texture>"
    }
}

Class Q3ALiveMapProperty
{
    [String] $Path
    [String] $Date
    [String] $Author
    [String] $Message
    [String] $Music
    [UInt32] $Brush
    [UInt32] $Entity
    [Object] $Texture
    Q3ALiveMapProperty([String]$Path)
    {
        If (![System.IO.File]::Exists($Path))
        {
            Throw "Invalid path"
        }

        $This.Path   = $Path
        $This.Date   = [System.IO.File]::GetLastWriteTime($Path).ToString("MM/dd/yyyy HH:mm:ss")
        $This.Refresh()
    }
    [String[]] GetContent()
    {
        Return [System.IO.File]::ReadAllLines($This.Path)
    }
    [Object] Q3ALiveMapTexture([UInt32]$Index,[String]$Name)
    {
        Return [Q3ALiveMapTexture]::New($Index,$Name)
    }
    Refresh()
    {
        $This.Brush   = 0
        $This.Entity  = 0
        $This.Texture = @( )

        $xContent     = $This.GetContent()

        # Header
        $xHeader      = @( )
        $X            = 0
        Do
        {
            $xHeader += $xContent[$X]
            $X ++
        }
        Until ($xContent[$X] -match "// brush 0")

        ForEach ($Line in $xHeader)
        {
            Switch -Regex ($Line)
            {
                "^`"author`".+"  { $This.Author  = $Line.Split("`"")[3] }
                "^`"message`".+" { $This.Message = $Line.Split("`"")[3] }
                "^`"music`".+"   { $This.Music   = $Line.Split("`"")[3] }
            }
        }

        # Content (Entity/Brush/Texture)
        $xTexture = @{ }

        ForEach ($Line in $xContent)
        {
            Switch -Regex ($Line)
            {
                "^// entity \d+" { $This.Entity ++ }
                "^// brush \d+"  { $This.Brush ++  }
                "^\(.+\) \w+\/\w+"
                {
                    $xTexture.Add($xTexture.Count,[Regex]::Matches($Line,"\w+\/\w+").Value)
                }
            }
        }

        $Array = @( Switch ($xTexture.Count)
        {
            0 { } 1 { $xTexture[0] } Default { $xTexture[0..($xTexture.Count-1)]}

        })  | Select-Object -Unique | Sort-Object

        ForEach ($Texture in $Array)
        {
            $This.Texture += $This.Q3ALiveMapTexture($This.Texture.Count,$Texture)
        }
    }
    [String] ToString()
    {
        Return "<Q3ALive.Map.Content>"
    }
}
Class Q3ALiveMap
{
    [String]      $Name
    [String]      $Path
    [String]    $Source
    [String]    $Target
    [Object]  $Property
    [Object] $Levelshot
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
    [Object] Q3ALiveMapLevelshot([String]$Name,[String]$Path)
    {
        Return [Q3ALiveMapLevelshot]::New($Name,$Path)
    }
    [Object] Q3ALiveMapProperty([String]$Path)
    {
        Return [Q3ALiveMapProperty]::New($Path)
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
            Default { $Hash[0..($Hash.Count-1)] | Sort-Object Fullname }
        }

        #$This.GetProperty()  > $Null
        $This.GetArena()     > $Null
        $This.GetShader()    > $Null
        $This.GetLevelshot() > $Null
    }
    [String] Scripts([String]$Type)
    {
        Return "{0}\scripts\{1}.{2}" -f $This.Path, $This.Name, $Type
    }
    [Object] GetProperty()
    {
        $This.Property = $This.Q3ALiveMapProperty($This.Source)

        Return $This.Property
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
    [Object] GetLevelshot()
    {
        $xLevelshot     = $This.Output | ? Name -match "levelshots\\\w+\.(jpg|tga|png)"
        If (!$xLevelshot)
        {
            $xLevelshot = "{0}\levelshots\{1}.jpg" -f $This.Path, $This.Name
        }

        $xName          = $xLevelshot | Split-Path -Leaf

        $This.Levelshot = $This.Q3ALiveMapLevelshot($xName,$xLevelshot)

        Return $This.Levelshot
    }
    SetArena([String[]]$Script)
    {
        $This.Arena.Populate($Script)
    }
    SetShader([String[]]$Script)
    {
        $This.Shader.Populate($Script)
    }
    SetLevelshot([String]$Path)
    {
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
                $This.GetProperty() > $Null
            }
        }
    }
    [String] GetImageMagick()
    {
        Return Get-ChildItem $Env:ProgramFiles -EA 0 | ? Name -match ImageMagick | % { "{0}\magick.exe" -f $_.Fullname }
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
    SteamWorkshopCredential([String]$Username,[SecureString]$Password)
    {
        $Cred        = [PSCredential]::New($Username,$Password)
        $This.Inject($Cred)
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
    [Object] $Length
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
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALiveByteSize]::New("File",$Bytes)
    }
    [String] DateFormat([DateTime]$Object)
    {
        Return $Object.ToString("MM/dd/yyyy HH:mm:ss")
    }
    Check()
    {
        $Object          = Get-Item $This.Fullname -EA 0
        $This.Exists     = !!$Object
        If (!$Object)
        {
            $This.Date   = "<not set>"
            $This.Length = $This.Q3ALiveByteSize(0)
        }
        If (!!$Object)
        {
            $This.Date   = $This.DateFormat($Object.LastWriteTime)
            $Bytes       = Switch ($This.Type) { Directory { 0 } Default { $Object.Length } }
            $This.Length = $This.Q3ALiveByteSize($Bytes)
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
        Return "<Steam.Workshop.Project.Preview>"
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
        ForEach ($Item in Get-ChildItem $This.Fullname -Recurse | Sort-Object Fullname)
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

        [System.IO.File]::Copy($File,$This.Preview.Fullname,$True)

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
    UpdateVdf([String]$Content)
    {
        ForEach ($Line in $Content -Split "`n")
        {
            Switch -Regex ($Line)
            {
                appid           { $This.Vdf.AppId           = $Line.Split('"')[3] }
                publishedfileid { $This.Vdf.PublishedFileId = $Line.Split('"')[3] }
                contentfolder   { $This.Vdf.ContentFolder   = $Line.Split('"')[3] }
                previewfile     { $This.Vdf.PreviewFile     = $Line.Split('"')[3] }
                visibility      { $This.Vdf.Visibility      = $Line.Split('"')[3] }
                title           { $This.Vdf.Title           = $Line.Split('"')[3] }
                description     { $This.Vdf.Description     = $Line.Split('"')[3] }
                changenote      { $This.Vdf.ChangeNote      = $Line.Split('"')[3] }
            }
        }

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
    [UInt32]   $Selected
    SteamWorkshopMaster([String]$Path)
    {
        If (![System.IO.Directory]::Exists($Path))
        {
            Throw "Invalid path"
        }

        $This.Path = $Path
        $This.Cmd  = Get-ChildItem $Path | ? Name -eq steamcmd.exe | % Fullname
    }
    [Object] SteamWorkshopCredential([String]$Username,[SecureString]$Password)
    {
        Return [SteamWorkshopCredential]::New($Username,$Password)
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
        ElseIf ($This.Project.Count -eq 1 -and $Index -ne 0)
        {
            Throw "Invalid index"
        }
        ElseIf ($This.Project.Count -gt 1 -and $Index -gt $This.Project.Count)
        {
            Throw "Invalid index"
        }
        Else
        {
            $This.Selected = $Index   
        }
    }
    SetCredential([String]$Username,[SecureString]$Password)
    {
        $This.Credential = $This.SteamWorkshopCredential($Username,$Password)
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
    CreateProject([String]$Name)
    {        
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
    RemoveProject([String]$Name)
    {        
        $Item = $This.Project | ? Name -eq $Name
        If (!!$Item)
        {
            $Item.Remove()
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
        Return @($Null;$This.Project[$This.Selected])[$This.Selected -in $This.Project.Index]
    }
    [String] ToString()
    {
        Return "<Steam.Workshop.Master>"
    }
}

Class Q3ALiveMaster
{
    [Object]         $Module
    [Object]           $Xaml
    [Object]       $Registry
    [Object]      $Component
    [Object]     $Dependency
    [Object]        $Radiant
    [Object]      $Workspace
    [Object]            $Map
    [Object]          $Steam
    Hidden [DateTime] $Start
    Q3ALiveMaster()
    {
        $This.Module   = $This.GetModule()
        $This.Module.Console.Reset()
        $This.Module.Console.Initialize()

        $This.Prime()
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
    Error([UInt32]$State,[String]$Status)
    {
        $This.Module.Update($State,$Status)
        Throw $This.Module.Console.Last().Status
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
    [String] LogPath()
    {
        $xPath = "{0}\{1}\Q3A-Live\Logs" -f $This.ProgramData(), $This.Author()
        
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
    [Object] GetModule()
    {
        Return Get-FEModule -Mode 1
    }
    [Object] GetQ3ALiveXaml()
    {
        Return [XamlWindow][Q3ALiveXaml]::Content
    }
    [Object] Q3ALiveRegistryRoot()
    {
        Return [Q3ALiveRegistryRoot]::New()
    }
    [Object] Q3ALiveDependencyMaster()
    {
        Return [Q3ALiveDependencyMaster]::New()
    }
    [Object] Q3ALiveProperty([Object]$Property)
    {
        Return [Q3ALiveProperty]::New($Property)
    }
    [Object] Q3ALiveProperty([String]$Name,[String]$Value)
    {
        Return [Q3ALiveProperty]::New($Name,$Value)
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
    [String] MapBspAas()
    {
        Return "{0}\.(aas|bsp)" -f $This.Map.Name
    }
    [String] Escape([String]$String)
    {
        Return [Regex]::Escape($String)
    }
    [String] IconStatus([UInt32]$Flag)
    {
        Return $This.Module._Control(@("failure.png","success.png","warning.png")[$Flag]).Fullname
    }
    UpdateShaderlist()
    {
        If (!$This.Map)
        {
            Throw "Exception [!] No map selected"
        }

        $Shaderlist = "{0}\scripts\shaderlist.txt" -f $This.Q3A().Base
        $Content    = [System.IO.File]::ReadAllLines($Shaderlist)

        If ($This.Map.Name -notin $Content)
        {
            $Content += $This.Map.Name
            [System.IO.File]::WriteAllLines($Shaderlist,$Content)
        }
    }
    ExtractTexture([String]$Archive,[String]$Texture)
    {
        <#
        $Archive   = "{0}\pak0.pk3" -f $Ctrl.Q3A().Base
        #$Texture   = "pjbasesky"
        $Path      = "{0}\temp" -f $Ctrl.Workspace.Path
        
        $Zip       = [System.IO.Compression.ZipFile]::OpenRead($Archive)
        $Entries   = $Zip.Entries | ? Name -match $Texture

        # // Extract entry to file
        ForEach ($Entry in $Entries)
        {
            $Target    = "{0}\{1}" -f $Path, $Entry.Fullname
            $Directory = Split-Path $Target -Parent
            If (![System.IO.Directory]::Exists($Directory))
            {
                [System.IO.Directory]::CreateDirectory($Directory)
            }

            [System.IO.Compression.ZipFileExtensions]::ExtractToFile($Entry,$Target,$True)
            [Console]::WriteLine("Extracted [+] $Target")
        }

        $Zip.Dispose()
        #>
    }
    RegistryRoot()
    {
        $This.Update(0,"Getting [~] Registry Root")
        $This.Registry   = $This.Q3ALiveRegistryRoot()
    }
    RegistryRefresh()
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Refresh [~] Registry")
        $Ctrl.Registry.Refresh()
    }
    DependencyMaster()
    {
        $This.Update(0,"Getting [~] Dependency Master")
        $This.Dependency = $This.Q3ALiveDependencyMaster()
    }
    ComponentCheck()
    {
        $Ctrl           = $This
        $Ctrl.Update(0,"Checking [~] Quake III Arena + Quake Live")

        $Ctrl.Component = @( )

        $Q3A            = $Ctrl.Registry.Uninstall | ? DisplayName -eq "Quake III Arena"
        If ($Q3A)
        {
            $Path = $Q3A.InstallLocation
            If ($Ctrl.CheckDirectory($Path) -and "quake3.exe" -in $Ctrl.GetFiles($Path).Name)
            {
                $Ctrl.Component += $Ctrl.Q3ALiveComponent("Q3A",$Path)
                $Ctrl.Update(0,"Component [+] Quake III Arena: $Path")
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

        $Live           = $Ctrl.Registry.Uninstall | ? DisplayName -eq "Quake Live"
        If ($Live)
        {
            $Path = $Live.InstallLocation
            If ($Ctrl.CheckDirectory($Path) -and "quakelive_steam.exe" -in $Ctrl.GetFiles($Path).Name)
            {
                $Ctrl.Component += $Ctrl.Q3ALiveComponent("Live",$Path)
                $Ctrl.Update(0,"Component [+] Quake Live: $Path")
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
    DependencyCheck([String]$DisplayName)
    {
        $Ctrl    = $This
        $Current = $Ctrl.Registry.Current()

        If (!$Current)
        {
            $Ctrl.Update(1,"Exception [!] Registry root not found")
        }
        Else 
        {
            Switch ($DisplayName)
            {
                Radiant # [GtkRadiant]
                {
                    # No registry uninstall entry
                    $xRadiant = $Ctrl.Dependency.Get("Radiant")
                    
                    If ($Ctrl.CheckDirectory($Current.Radiant))
                    {
                        $xRadiant.Directory = $Current.Radiant
                        $xRadiant.FilePath  = $Ctrl.GetFiles($Current.Radiant) | ? Name -eq radiant.exe | % FullName
                        $xRadiant.Installed = !!$xRadiant.FilePath
    
                        $Ctrl.Update(0,"Registry [+] Radiant: $($Current.Radiant)")
                    }
                    Else
                    {
                        $xRadiant.Directory = "<not set>"
                        $xRadiant.FilePath  = "<not set>"
    
                        $Ctrl.Update(0,"Registry [!] Radiant: <not set> or <invalid>")
                    }

                    If ($xRadiant.Installed)
                    {
                        $Ctrl.SetRadiant($xRadiant.Directory)
                    }
                }
                Archive # [7zip]
                {
                    If ($Ctrl.Xaml.IO.DependencyPathText.Text -match "(^$|<not set>)")
                    {
                        # Check registry uninstall first
                        $7Zip     = $Ctrl.Registry.Uninstall | ? DisplayName -match 7-Zip
                        If ($7Zip)
                        {
                            If ($Ctrl.CheckDirectory($7Zip.InstallLocation))
                            {
                                $Current.Archive = $7Zip.InstallLocation
                                $Current.SetProperties()
                            }
                        }
                    }

                    # Then process the registry root setting
                    $xArchive = $Ctrl.Dependency.Get("Archive")

                    If ($Ctrl.CheckDirectory($Current.Archive))
                    {
                        $xArchive.Directory = $Current.Archive
                        $xArchive.FilePath  = $Ctrl.GetFiles($Current.Archive) | ? Name -eq 7z.exe | % Fullname
                        $xArchive.Installed = !!$xArchive.FilePath

                        $Ctrl.Update(0,"Registry [+] Archive: $($Current.Archive)")
                    }
                    Else
                    {
                        $xArchive.Directory = "<not set>"
                        $xArchive.FilePath  = "<not set>"

                        $Ctrl.Update(0,"Registry [!] Archive <not set> or <invalid>")
                    }
                }
                Image # [ImageMagick]
                {
                    If ($Ctrl.Xaml.IO.DependencyPathText.Text -match "(^$|<not set>)")
                    {
                        # Check registry uninstall first
                        $Magick = $Ctrl.Registry.Uninstall | ? DisplayName -match ImageMagick

                        If ($Magick)
                        {
                            If ($Ctrl.CheckDirectory($Magick.InstallLocation))
                            {
                                $Current.Image = $Magick.InstallLocation
                                $Current.SetProperties()
                            }
                        }
                    }

                    # Then process the registry root setting
                    $xImage = $Ctrl.Dependency.Get("Image")

                    If ($Ctrl.CheckDirectory($Current.Image))
                    {
                        $xImage.Directory = $Current.Image
                        $xImage.FilePath  = $Ctrl.GetFiles($Current.Image) | ? Name -eq magick.exe | % Fullname
                        $xImage.Installed = !!$xImage.FilePath
        
                        $Ctrl.Update(0,"Registry [+] Image: $($Current.Image)")
                    }
                    Else
                    {
                        $xImage.Directory = "<not set>"
                        $xImage.FilePath  = "<not set>"
        
                        $Ctrl.Update(0,"Registry [!] Image <not set> or <invalid>")
                    }
                }
                Shader # [Q3ASE]
                {
                    # No registry uninstall entry
                    $xShader = $Ctrl.Dependency.Get("Shader")

                    If ($Ctrl.CheckDirectory($Current.Shader))
                    {
                        $xShader.Directory = $Current.Shader
                        $xShader.FilePath  = $Ctrl.GetFiles($Current.Shader) | ? Name -eq q3ase.exe | % Fullname
                        $xShader.Installed = !!$xShader.FilePath
        
                        $Ctrl.Update(0,"Registry [+] Shader: $($Current.Shader)")
                    }
                    Else
                    {
                        $xShader.Directory = "<not set>"
                        $xShader.FilePath  = "<not set>"
        
                        $Ctrl.Update(0,"Registry [!] Shader <not set> or <invalid>")
                    }
                }
                Steam # [SteamCmd]
                {
                    $xSteam = $Ctrl.Dependency.Get("Steam")

                    If ($Ctrl.CheckDirectory($Current.Steam))
                    {
                        $xSteam.Directory = $Current.Steam
                        $xSteam.FilePath  = $Ctrl.GetFiles($Current.Steam) | ? Name -eq steamcmd.exe | % Fullname
                        $xSteam.Installed = !!$xSteam.FilePath

                        $Ctrl.Update(0,"Registry [+] Steam: $($Current.Steam)")
                    }
                    Else
                    {
                        $xSteam.Directory = "<not set>"
                        $xSteam.FilePath  = "<not set>"

                        $Ctrl.Update(0,"Registry [!] Steam <not set> or <invalid>")
                    }

                    If ($xSteam.Installed)
                    {
                        $Ctrl.SetSteam($xSteam.Directory)
                    }
                }
            }
        }
    }
    DependencyRefresh()
    {
        $Ctrl = $This

        If ($Ctrl.Component.Count -eq 2)
        {
            ForEach ($Type in "Radiant","Archive","Image","Shader","Steam")
            {
                $Ctrl.DependencyCheck($Type)
            }
        }
    }
    Prime()
    {
        $Ctrl = $This

        $Ctrl.RegistryRoot()
        $Ctrl.RegistryRefresh()
        $Ctrl.DependencyMaster()
        $Ctrl.ComponentCheck()
        $Ctrl.DependencyRefresh()
    }
    SetRadiant([String]$Path)
    {
        If ($This.CheckDirectory($Path))
        {
            If ("radiant.exe" -in $This.GetFiles($Path).Name)
            {
                $This.Update(0,"Setting [~] Radiant: $Path")
                $This.Radiant = $This.Q3ALiveRadiant($Path)
            }
        }
    }
    SetWorkspace([String]$Path)
    {
        If ("Q3A" -notin $This.Component.Name)
        {
            $This.Update(1,"Exception [!] Must have [Quake III Arena] installed")
        }
        ElseIf ("Live" -notin $This.Component.Name)
        {
            $This.Update(1,"Exception [!] Must have [Quake Live] installed")
        }
        ElseIf (!$This.Radiant)
        {
            $This.Update(1,"Exception [!] Must set [Radiant] path")
        }
        ElseIf ($This.CheckDirectory($Path))
        {
            $This.Update(0,"Setting [~] Workspace: [$Path]")
            $This.Workspace = $This.Q3ALiveWorkspace($Path)
        }
    }
    SetMap([String]$Name)
    {
        If ("Q3A" -notin $This.Component.Name)
        {
            $This.Update(1,"Exception [!] Must have [Quake III Arena] installed")
        }
        ElseIf (!$This.Workspace)
        {
            $This.Update(1,"Exception [!] Must set a workspace path")
        }
        Else
        {
            $AssetPath = "{0}\{1}" -f $This.Workspace.Path, $Name

            If ($Name -notin $This.Workspace.Directories().Name)
            {
                [System.IO.Directory]::CreateDirectory($AssetPath)
            }
    
            If ([System.IO.Directory]::Exists($AssetPath))
            {
                $This.Update(0,"Setting [~] Map Name  : $Name")
                $This.Update(0,"Setting [~] Map Path  : $AssetPath")
                $This.Map           = $This.Q3ALiveMap($Name,$AssetPath)
            }
    
            $xSource = "{0}\maps\{1}.map" -f $This.Q3A().Base, $This.Map.Name
    
            Switch ([UInt32][System.IO.File]::Exists($xSource))
            {
                0
                {
                    $This.Update(1,"Exception [!] Map file not found in [Quake III Arena\baseq3\maps] directory")
                }
                1
                {
                    $This.Update(0,"Setting [~] Map Source: $xSource")
                    $This.Map.SetSource($xSource)
                }
            }
        }
    }
    ReleaseMap()
    {
        $This.Update(0,"Releasing [~] Map: $($This.Map.Name)")
        $This.Map = $Null
    }
    SetSteam([String]$Path)
    {
        If (![System.IO.Directory]::Exists($Path))
        {
            $This.Update(1,"Exception [!] Invalid directory")
        }
        ElseIf ("steamcmd.exe" -notin $This.GetFiles($Path).Name)
        {
            $This.Update(1,"Exception [!] SteamCmd not found")
        }
        Else
        {
            $This.Update(0,"Setting [~] Steam: $Path")
            $This.Steam = $This.SteamWorkshopMaster($Path)
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
    SetLevelshot([String]$Path)
    {
        $This.Map.SetLevelshot($Path)
    }
    [String] Span()
    {
        Return [DateTime]::Now - $This.Start
    }
    Compile()
    {
        # // Runs the compilation process for the (*.bsp) and (*.aas) files
        If (!$This.Q3A())
        {
            $This.Update(1,"Exception [!] Q3A not detected")
        }
        ElseIf (!$This.Radiant)
        {
            $This.Update(1,"Exception [!] Radiant not detected")
        }
        ElseIf (!$This.Map.Source)
        {
            $This.Update(1,"Exception [!] Map source not set")
        }
        Else
        {
            $This.Start  = [DateTime]::Now
            $This.Update(0,"Compiling [~] Map: $($This.Map.Source)")
            Start-Process -FilePath $This.Q3Map2() -ArgumentList $This.GetParam(0) -NoNewWindow -Wait
        
            $Lin  = Get-Item $This.Map.Source.Replace(".map",".lin") -EA 0
            If ($Lin)
            {
                If (($Lin.LastWriteTime - $This.Start).TotalSeconds -gt 0)
                {
                    $This.Update(1,"Exception [!] Map file leaked")
                }
            }
            Else
            {
                $This.Update(0,"$($This.Span()) [+] Part (1)")
    
                # // Compiling BSP part 2
                Start-Process -FilePath $This.Q3Map2() -ArgumentList $This.GetParam(1) -NoNewWindow -Wait
        
                $This.Update(0,"$($This.Span()) [+] Part (2)")
        
                # // Compiling BSP part 3
                Start-Process -FilePath $This.Q3Map2() -ArgumentList $This.GetParam(2) -NoNewWindow -Wait
        
                $This.Update(0,"$($This.Span()) [+] Part (3)")
        
                # // Compiling AAS part 4
                Start-Process -FilePath $This.Bspc() -ArgumentList $This.GetParam(3) -NoNewWindow -Wait
        
                $This.Update(0,"$($This.Span()) [+] Part (4)")
        
                $This.Update(0,"Compiled [+] Map: [$($This.Map.Source)]")
        
                # // Updates the (map + asset) folder with the newly created (*.bsp) and (*.aas) files
                $This.Update(0,"Updating [~] (Map + Asset) folder with newly created (*.bsp) and (*.aas) files")
        
                $BspAas = Get-ChildItem "$($This.Q3A().Base)\maps" | ? Name -match $This.MapBspAas()
        
                ForEach ($Item in $BspAas)
                {
                    $New = "{0}\maps\{1}" -f $This.Map.Path, $Item.Name
        
                    If ([System.IO.File]::Exists($New))
                    {
                        [System.IO.File]::Delete($New)
                    }
        
                    $This.Update(0,"Moving [~] $($Item.Name)")
        
                    [System.IO.File]::Move($Item.Fullname,$New)
                }
        
                $This.Update(0,"$($This.Span()) [+] Part (5)")
        
                $This.Update(0,"Updated [+] Map: [$($This.Map.Path)]")
            }
        }
    }
    Package()
    {
        # // Creates a new (*.pk3) file based on the content of (map + asset) folder
        If (!$This.Map)
        {
            $This.Update(1,"Exception [!] Map template not set")
        }
        ElseIf (!$This.Map.Target)
        {
            $This.Update(1,"Exception [!] Must set the asset target")
        }
        Else
        {
            If ([System.IO.File]::Exists($This.Map.Target))
            {
                $This.Update(0,"Exists [!] Deleting [$($This.Map.Target)]")
                [System.IO.File]::Delete($This.Map.Target)
            }

            $This.Update(0,"Creating [~] [$($This.Map.Target)]")

            $FilePath = $This.Dependency.Get("Archive").FilePath
            $Param    = 'a -tzip -mx=5 {0}.pk3 "{1}\*" -o"{2}"' -f $This.Map.Name, $This.Map.Path, $This.Workspace.Path

            Start-Process -FilePath $FilePath -WorkingDirectory $This.Workspace.Path -ArgumentList $Param -NoNewWindow -Wait

            If ([System.IO.File]::Exists($This.Map.Target))
            {
                $Hash     = Get-FileHash -Algorithm MD5 $This.Map.Target | % Hash
                $LogEntry = "{0} {1} {2}" -f [DateTime]::Now.ToString("MM/dd/yyyy HH:mm:ss"), $Hash, $This.Map.Target
                $Writer   = [System.IO.File]::AppendText($This.Workspace.Log.Path)
                $Writer.WriteLine($LogEntry)
                $Writer.Dispose()

                [Console]::WriteLine("")
                [Console]::WriteLine($This.Workspace.Log.LogHeader())
                [Console]::WriteLine("----       ----     ----                             ------")
                [Console]::WriteLine($LogEntry)
                [Console]::WriteLine("")

                $This.Update(0,$LogEntry)
            }

            $This.Update(0,"$($This.Span()) [+] Part (6)")
        }
    }
    Transfer()
    {
        # // Transfer the map asset package to the [Quake Live] directory
        If (![System.IO.File]::Exists($This.Map.Target))
        {
            $This.Update(0,"Exception [!] File: [$($This.Map.Target)] does not exist")
        }
        Else
        {
            $This.Update(0,"Transferring [~] Package -> [Quake Live] directory")

            ForEach ($Item in $This.Live().Base, $This.Q3A().Base)
            {
                $Destination = "{0}\{1}" -f $Item, ($This.Map.Target | Split-Path -Leaf)
    
                [System.IO.File]::Copy($This.Map.Target,$Destination,$True)
    
                $This.Update(0,"Transferred [+] Package: [$Destination]")
            }
    
            $This.Update(0,"$($This.Span()) [+] Part (7)")
        }
    }
    [Object] TestConnection()
    {
        $This.Update(0,"Testing [~] Internet connection...")
        Return Test-Connection 1.1.1.1 -Count 1 -EA 0
    }
    Decompile([String]$Bsp)
    {
        If (![System.IO.File]::Exists($Bsp))
        {
            Throw "Invalid path"
        }

        $Ctrl = $This

        $Leaf   = $Bsp | Split-Path -Leaf
        $Target = "{0}\maps\$Leaf" -f $Ctrl.Q3A().Base
        [System.IO.File]::Copy($Bsp,$Target)

        Start-Process -FilePath $Ctrl.Q3Map2() -WorkingDirectory $Ctrl.Q3A().Base -ArgumentList "-game ql -convert -format map `"$Target`"" -NoNewWindow -Wait

        $xMap     = $Bsp.Replace(".bsp","_converted.map")
        $Content  = [System.IO.File]::ReadAllLines($xMap)
        $Content  = $Content -replace "(\\{1})", "/"
        [System.IO.File]::WriteAllLines($xMap,$Content)

        [Console]::WriteLine("Complete [+] $xMap")
        #>
    }
    Reinstantiate()
    {
        # Loads XAML
        $This.Xaml       = $This.GetQ3ALiveXaml()
    }
    [Object[]] Property([Object]$Object)
    {
        Return $Object.PSObject.Properties | % { $This.Q3ALiveProperty($_) }
    }
    DependencyOutput()
    {
        $Ctrl   = $This

        $Item                     = $Ctrl.Xaml.IO.DependencyOutput.SelectedItem
        
        $Object                   = $Item | Select-Object Url, Size, Hash, FileName, FileType, Directory, FilePath
        $Ctrl.Reset($Ctrl.Xaml.IO.DependencyProperty,$Ctrl.Property($Object))

        # Defaults
        $Ctrl.Xaml.IO.DependencyInstall.IsEnabled     = 0
        $Ctrl.Xaml.IO.DependencyClear.IsEnabled       = 0
        $Ctrl.Xaml.IO.DependencyEdit.IsEnabled        = 0
        $Ctrl.Xaml.IO.DependencyPathText.IsEnabled    = 0
        $Ctrl.Xaml.IO.DependencyPathIcon.IsEnabled    = 0
        $Ctrl.Xaml.IO.DependencyPathBrowse.IsEnabled  = 0
        $Ctrl.Xaml.IO.DependencyPathApply.IsEnabled   = 0

        # Path check
        If (!$Item.Directory -or $Item.Directory -match "(^$|<not set>)")
        {
            $Ctrl.Xaml.IO.DependencyPathText.IsEnabled    = 1
            $Ctrl.Xaml.IO.DependencyPathText.Text         = "<not set>"
            $Ctrl.Xaml.IO.DependencyPathIcon.IsEnabled    = 1
            $Ctrl.Xaml.IO.DependencyPathBrowse.IsEnabled  = 1
        }
        Else
        {
            $Ctrl.Xaml.IO.DependencyPathText.Text         = $Item.Directory
        }

        # Install check
        If (!$Item.Installed -and $Item.Directory -notmatch "(^$|<not set>)" -and $Item.FilePath -match "(^$|<not set>)")
        {
            $Ctrl.Xaml.IO.DependencyInstall.IsEnabled = 1
        }

        # Edit check
        If ($Item.Installed -or $Item.Directory -notmatch "(^$|<not set>)")
        {
            $Ctrl.Xaml.IO.DependencyEdit.IsEnabled  = 1
        }
        
        # Clear check
        If ($Item.Installed -or $Item.Directory -notmatch "(^$|<not set>)" -and $Item.FilePath -notmatch "(^$|<not set>)")
        {
            $Ctrl.Xaml.IO.DependencyClear.IsEnabled = 1
        }

        # Radiant population
        If ($Item.DisplayName -eq "Radiant" -and $Item.Installed -and $Ctrl.Radiant.Path -ne $Item.Directory)
        {
            $Ctrl.SetRadiant($Item.Directory)
            $Object = $Ctrl.Radiant | Select-Object Name, Path, Engine, Q3Map2, Bspc
            $Ctrl.Reset($Ctrl.Xaml.IO.RadiantProperty,$Ctrl.Property($Object))
        }

        # Steam population
        If ($Item.DisplayName -eq "Steam" -and $Item.Installed -and $Ctrl.Steam.Path -ne $Item.Directory)
        {
            $Ctrl.SetSteam($Item.Directory)
        }

        # Workspace tab check
        $Select = $Ctrl.Dependency.Output | ? DisplayName -match "(Radiant|Archive|Image|Steam)"
        $Ctrl.Xaml.IO.WorkspaceTab.IsEnabled = [UInt32](0 -notin $Select.Installed)
    }
    DependencyPathText()
    {
        $Ctrl                    = $This

        $Item                    = $Ctrl.Xaml.Get("DependencyOutput")
        $Text                    = $Ctrl.Xaml.Get("DependencyPathText")
        $Icon                    = $Ctrl.Xaml.Get("DependencyPathIcon")
        $Apply                   = $Ctrl.Xaml.Get("DependencyPathApply")
    
        If ($Text.Control.Text -match "(^<not set>$|^$)")
        {
            $Text.Status         = 2
        }
        Else
        {
            $Text.Status         = [UInt32][System.IO.Directory]::Exists($Text.Control.Text)
        }
    
        $Icon.Control.Source     = $Ctrl.IconStatus($Text.Status)

        $Escape                  = "^{0}$" -f [Regex]::Escape($Item.Control.SelectedItem.Directory)
        $Apply.Control.IsEnabled = [UInt32]($Text.Control.Text -notmatch $Escape -and $Text.Status -eq 1)
    }
    DependencyPathBrowse()
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Browsing [~] Dependency target")

        $Dialog              = [System.Windows.Forms.FolderBrowserDialog]::New()
        $Dialog.ShowDialog()

        If ([System.IO.Directory]::Exists($Dialog.SelectedPath))
        {
            $Ctrl.Xaml.IO.DependencyPathText.Text = $Dialog.SelectedPath

            $Ctrl.Update(0,"Selected [+] Path: $($Dialog.SelectedPath)")
        }
        Else
        {
            $Ctrl.Xaml.IO.DependencyPathText.Text    = "<not set>"

            $Ctrl.Update(0,"Selected [!] Path: <not set>")
        }
    }
    DependencyPathApply()
    {
        $Ctrl                 = $This

        $Item                 = $Ctrl.Xaml.IO.DependencyOutput.SelectedItem
        $xName                = $Item.DisplayName
        $Item.Directory       = $Ctrl.Xaml.IO.DependencyPathText.Text

        $Current              = $Ctrl.Registry.Current()
        $Property             = $Item.DisplayName

        $Current.$($Property) = $Item.Directory
        $Current.SetProperties()

        $Ctrl.DependencyCheck($Property)

        $Ctrl.DependencyOutput()
        $Ctrl.Reset($Ctrl.Xaml.IO.DependencyOutput,$Ctrl.Dependency.Output)

        $Ctrl.Xaml.IO.DependencyOutput.SelectedIndex = $Ctrl.Xaml.IO.DependencyOutput.Items | ? DisplayName -eq $xName | % Index

        $Ctrl.Xaml.IO.DependencyPathText.IsEnabled   = 0
        $Ctrl.Xaml.IO.DependencyPathBrowse.IsEnabled = 0
        $Ctrl.Xaml.IO.DependencyClear.IsEnabled      = 1
        $Ctrl.Xaml.IO.DependencyEdit.IsEnabled       = 1
    }
    DependencyInstall()
    {
        $Ctrl        = $This

        $Item        = $Ctrl.Xaml.IO.DependencyOutput.SelectedItem
        $xName       = $Item.DisplayName
        $Hash        = $Null
        $Ctrl.Update(0,"Installing [~] $($Item.Name)")
        $Source      = $Item.Url
        $Destination = "{0}\{1}" -f $Item.Directory, $Item.Filename
        $Connection  = Test-Connection 1.1.1.1 -Count 1 -EA 0
        If ($Connection)
        {
            Start-BitsTransfer -Source $Source -Destination $Destination -Description "$($Item.Name) [~] $($Item.Description)"

            # Existence check, hash retrieval
            If ([System.IO.File]::Exists($Destination))
            {
                $Hash = Get-FileHash -Algorithm MD5 $Destination | % Hash
            }

            # Hash check, installation procedure
            If ($Hash -notmatch $Item.Hash)
            {
                $Ctrl.Update(1,"Exception [!] Hash for [$xName] does not match")
            }
            Else
            {
                $Ctrl.Update(1,"Success [+] Hash for [$xName] matches")
                Switch ($xName)
                {
                    Radiant
                    {
                        $Ctrl.Update(0,"Extracting [~] Radiant: $Destination")
                        $Zip    = [System.IO.Compression.ZipFile]::OpenRead($Destination)
                        $Parent = $Item.Directory | Split-Path -Parent
                        [System.IO.Compression.ZipFileExtensions]::ExtractToDirectory($Zip,$Parent)
                        $Zip.Dispose()
                        [System.IO.Directory]::Delete($Item.Directory,1)
                        $Old = "$Parent\{0}" -f $Item.FileName.Replace(".zip","")
                        [System.IO.Directory]::Move($Old,$Item.Directory)
                    }
                    Archive
                    {
                        $ArgumentList = "/S /D=`"{0}`"" -f $Item.Directory
                        Start-Process -FilePath $Destination -ArgumentList $ArgumentList -NoNewWindow -Wait
                        $Ctrl.RegistryRefresh()
                        If ("7-Zip" -in $Ctrl.Registry.Uninstall.DisplayName)
                        {
                            [System.IO.File]::Delete($Destination)
                        }
                    }
                    Image
                    {
                        $ArgumentList = "/SILENT /NORESTART /DIR=`"{0}`"" -f $Item.Directory
                        Start-Process -FilePath $Destination -ArgumentList $ArgumentList -NoNewWindow -Wait
                        $Ctrl.RegistryRefresh()
                        If ("ImageMagick" -in $Ctrl.Registry.Uninstall.DisplayName)
                        {
                            [System.IO.File]::Delete($Destination)
                        }
                    }
                    Shader
                    {
                        $Ctrl.Update(0,"Extracting [~] Shader: $Destination")
                        $Zip = [System.IO.Compression.ZipFile]::OpenRead($Destination)
                        [System.IO.Compression.ZipFileExtensions]::ExtractToDirectory($Zip,$Item.Directory)
                        $Zip.Dispose()
                        [System.IO.File]::Delete($Destination)
                    }
                    Steam
                    {
                        $Ctrl.Update(0,"Extracting [~] Steam: $Destination")
                        $Zip    = [System.IO.Compression.ZipFile]::OpenRead($Destination)
                        [System.IO.Compression.ZipFileExtensions]::ExtractToDirectory($Zip,$Item.Directory)
                        $Zip.Dispose()
                        [System.IO.File]::Delete($Destination)
                        $Ctrl.Update(0,"Warning [+] Must perform initial [steamcmd.exe] login before using Steam panel")
                    }
                }

                $Ctrl.DependencyCheck($xName)
            }

            $Ctrl.DependencyOutput()
            $Ctrl.Reset($Ctrl.Xaml.IO.DependencyOutput,$Ctrl.Dependency.Output)

            $Ctrl.Xaml.IO.DependencyOutput.SelectedIndex = $Ctrl.Xaml.IO.DependencyOutput.Items | ? DisplayName -eq $xName | % Index
        }
        Else
        {
            $Ctrl.Update(0,"Exception [!] Unable to access internet to install [$xName]")
        }
    }
    DependencyEdit()
    {
        $Ctrl = $This

        $Ctrl.Xaml.IO.DependencyEdit.IsEnabled       = 0
        $Ctrl.Xaml.IO.DependencyClear.IsEnabled      = 0

        $Ctrl.Xaml.IO.DependencyPathText.IsEnabled   = 1
        $Ctrl.Xaml.IO.DependencyPathIcon.IsEnabled   = 1
        $Ctrl.Xaml.IO.DependencyPathBrowse.IsEnabled = 1
    }
    DependencyClear()
    {
        $Ctrl = $This

        $Item = $Ctrl.Xaml.IO.DependencyOutput.SelectedItem

        # Modify dependency
        $Item.Directory = $Null
        $Item.FilePath  = $Null
        $Item.Installed = 0

        # Output
        $Ctrl.Reset($Ctrl.Xaml.IO.DependencyOutput,$Ctrl.Dependency.Output)
        $Ctrl.Xaml.IO.DependencyOutput.SelectedIndex = $Item.Index

        # Path/Browse
        $Ctrl.Xaml.IO.DependencyPathText.Text        = "<not set>"
        $Ctrl.Xaml.IO.DependencyPathText.IsEnabled   = 1
        $Ctrl.Xaml.IO.DependencyPathIcon.IsEnabled   = 1
        $Ctrl.Xaml.IO.DependencyPathBrowse.IsEnabled = 1

        # Buttons
        $Ctrl.Xaml.IO.DependencyInstall.IsEnabled    = 0
        $Ctrl.Xaml.IO.DependencyClear.IsEnabled      = 0
        $Ctrl.Xaml.IO.DependencyEdit.IsEnabled       = 0
        
        # Details
        $Object         = $Item | Select-Object Url, Size, Hash, Filename, Filetype, Directory, Filepath
        $Ctrl.Reset($Ctrl.Xaml.IO.DependencyProperty,$Ctrl.Property($Object))

        # Radiant
        If ($Item.DisplayName -eq "Radiant")
        {
            $Ctrl.Radiant   = $Null
            $Ctrl.Reset($Ctrl.Xaml.IO.RadiantProperty,$Null)
        }
    }
    WorkspacePathText()
    {
        $Ctrl                    = $This

        $Text                    = $Ctrl.Xaml.Get("WorkspacePathText")
        $Icon                    = $Ctrl.Xaml.Get("WorkspacePathIcon")
        $Apply                   = $Ctrl.Xaml.Get("WorkspacePathApply")

        If ($Text.Control.Text -match "(^<not set>$|^$)")
        {
            $Text.Status         = 2
        }
        Else
        {
            $Text.Status         = [UInt32][System.IO.Directory]::Exists($Text.Control.Text)
        }

        $Icon.Control.Source     = $Ctrl.IconStatus($Text.Status)
        $Apply.Control.IsEnabled = [UInt32]($Text.Status -eq 1)
    }
    WorkspacePathBrowse()
    {
        $This.Update(0,"Browsing [~] Folder: [Radiant]")

        $Dialog      = [System.Windows.Forms.FolderBrowserDialog]::New()

        $Dialog.ShowDialog()

        $This.Xaml.IO.WorkspacePathText.Text = @("<not set>",$Dialog.SelectedPath)[!!$Dialog.SelectedPath]
    }
    WorkspacePathApply()
    {
        $Ctrl = $This

        $Ctrl.SetWorkspace($Ctrl.Xaml.IO.WorkspacePathText.Text)

        <# [Disable dependency stuff]...
        $Ctrl.Xaml.IO.DependencyOutput.IsEnabled       = 0
        $Ctrl.Xaml.IO.DependencyPathText.IsEnabled     = 0
        $Ctrl.Xaml.IO.DependencyPathBrowse.IsEnabled   = 0
        $Ctrl.Xaml.IO.DependencyPathApply.IsEnabled    = 0
        $Ctrl.Xaml.IO.DependencyInstall.IsEnabled      = 0
        $Ctrl.Xaml.IO.DependencyClear.IsEnabled        = 0
        $Ctrl.Xaml.IO.DependencyEdit.IsEnabled         = 0
        $Ctrl.Xaml.IO.DependencyProperty.IsEnabled     = 0
        $Ctrl.Xaml.IO.RadiantProperty.IsEnabled        = 0
        #>
        
        $Reg = $This.Registry.Current()
        $Reg.Workspace = $This.Workspace.Path
        $Reg.SetProperty("Workspace")

        $This.Xaml.IO.WorkspacePathText.IsEnabled      = 0
        $This.Xaml.IO.WorkspacePathBrowse.IsEnabled    = 0
        $This.Xaml.IO.WorkspacePathApply.IsEnabled     = 0
        $This.Xaml.IO.MapTab.IsEnabled                 = 1

        $This.Xaml.IO.WorkspaceLogPathText.Text        = $This.Workspace.Log.Path
        $This.Xaml.IO.WorkspaceLogPathExists.IsChecked = $This.Workspace.Log.Exists
        $This.Reset($This.Xaml.IO.WorkspaceLogContent,$This.Workspace.Log.Output)

        $This.Reset($This.Xaml.IO.WorkspaceOutput,$This.Workspace.Output)

        $This.Xaml.IO.WorkspaceSlot.SelectedIndex      = 0
    }
    WorkspacePathClear()
    {
        $Ctrl = $This

        If ($Ctrl.Workspace)
        {
            $Ctrl.Update(0,"Clearing [~] Workspace: $($Ctrl.Workspace.Path)")

            $Ctrl.Workspace = $Null
    
            $Ctrl.Xaml.IO.WorkspacePathText.Text           = "<not set>"
            $Ctrl.Xaml.IO.WorkspacePathText.IsEnabled      = 1
            $Ctrl.Xaml.IO.WorkspacePathBrowse.IsEnabled    = 1

            $Ctrl.Xaml.IO.WorkspaceLogPathText.Text        = "<not set>"
            $Ctrl.Xaml.IO.WorkspaceLogPathExists.IsChecked = 0

            $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceLogContent,$Null)
            $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceOutput,$Null)
        }
    }
    WorkspaceSlot()
    {
        $Ctrl = $This

        Switch ($Ctrl.Xaml.IO.WorkspaceSlot.SelectedItem.Content)
        {
            "^$"
            {
                $Ctrl.Xaml.IO.WorkspaceLogHeader.Visibility    = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceLogContent.Visibility   = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceOutputHeader.Visibility = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceOutput.Visibility       = "Hidden"
            }
            Log
            {
                $Ctrl.Xaml.IO.WorkspaceLogHeader.Visibility    = "Visible"
                $Ctrl.Xaml.IO.WorkspaceLogContent.Visibility   = "Visible"
                $Ctrl.Xaml.IO.WorkspaceOutputHeader.Visibility = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceOutput.Visibility       = "Hidden"
            }
            Output
            {
                $Ctrl.Xaml.IO.WorkspaceLogHeader.Visibility    = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceLogContent.Visibility   = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceOutputHeader.Visibility = "Visible"
                $Ctrl.Xaml.IO.WorkspaceOutput.Visibility       = "Visible"
            }
        }
    }
    WorkspaceOutputRefresh()
    {
        $Ctrl = $This

        If ([System.IO.Directory]::Exists($Ctrl.Workspace.Path))
        {
            $Ctrl.Update(0,"Refreshing [~] Workspace: $($Ctrl.Workspace.Path)")

            $Ctrl.Workspace.Refresh()
            $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceOutput,$Ctrl.Workspace.Output)
        }
    }
    MapNameText()
    {
        $Ctrl                    = $This

        $Text                    = $Ctrl.Xaml.Get("MapNameText")
        $Icon                    = $Ctrl.Xaml.Get("MapNameIcon")
        $Apply                   = $Ctrl.Xaml.Get("MapNameApply")

        If ($Text.Control.Text -match "(^<not set>$|^$)")
        {
            $Text.Status         = 2
        }
        Else
        {
            $xPath               = "{0}\maps\{1}.map" -f $Ctrl.Q3A().Base, $Text.Control.Text
            $Text.Status         = [UInt32][System.IO.File]::Exists($xPath)
        }

        $Icon.Control.Source     = $Ctrl.IconStatus($Text.Status)
        $Apply.Control.IsEnabled = [UInt32]($Text.Status -eq 1)
    }
    MapNameApply()
    {
        $This.SetMap($This.Xaml.IO.MapNameText.Text)

        $This.Xaml.IO.MapTab.IsEnabled                 = 1
        $This.Xaml.IO.MapNameText.IsEnabled            = 0
        $This.Xaml.IO.MapNameApply.IsEnabled           = 0

        $Object = $This.Map | Select-Object Path, Source, Target
        $This.Reset($This.Xaml.IO.MapDetails,$This.Property($Object))

        $Object = $This.Map.Property | Select-Object Date, Author, Message, Music, Entity, Brush
        $This.Reset($This.Xaml.IO.MapProperty,$This.Property($Object))

        $This.Reset($This.Xaml.IO.MapTexture,$This.Map.Property.Texture)

        # Levelshot
        $This.Xaml.IO.MapLevelshotPath.Text            = $This.Map.Levelshot.Path
        $This.Xaml.IO.MapLevelshotExists.IsChecked     = $This.Map.Levelshot.Exists
        $This.Xaml.IO.MapLevelshotImport.IsEnabled     = 1
        $This.Xaml.IO.MapLevelshotImage.IsEnabled      = $This.Map.Levelshot.Exists

        If ($This.Map.Levelshot.Exists)
        {
            $This.MapLevelshotLoad($This.Map.Levelshot.Path)
        }
        Else
        {
            $This.Xaml.IO.MapLevelshotImage.Source     = $Null
        }

        # Arena
        $This.Xaml.IO.MapArenaPath.Text                = $This.Map.Arena.Path
        $This.Xaml.IO.MapArenaExists.IsChecked         = $This.Map.Arena.Exists
        $This.Xaml.IO.MapArenaApply.IsEnabled          = 1
        $This.Xaml.IO.MapArenaContent.IsEnabled        = 1
        $This.Xaml.IO.MapArenaContent.Text             = ($This.Map.Arena.Content | % Line) -join "`n"

        # Shader
        $This.Xaml.IO.MapShaderPath.Text               = $This.Map.Shader.Path
        $This.Xaml.IO.MapShaderExists.IsChecked        = $This.Map.Shader.Exists
        $This.Xaml.IO.MapShaderApply.IsEnabled         = 1
        $This.Xaml.IO.MapShaderContent.IsEnabled       = 1
        $This.Xaml.IO.MapShaderContent.Text            = ($This.Map.Shader.Content | % Line) -join "`n"

        # Output
        $This.Reset($This.Xaml.IO.MapOutput,$This.Map.Output)

        # Map Controls
        $This.Xaml.IO.MapCompile.IsEnabled             = 1
        $This.Xaml.IO.MapPackage.IsEnabled             = 1
        $This.Xaml.IO.MapTransfer.IsEnabled            = 1

        $This.Xaml.IO.MapPlayText.IsEnabled            = 1
        $This.Xaml.IO.MapPlayText.Text                 = "+map {0} ffa" -f $This.Map.Name
        $This.Xaml.IO.MapPlayButton.IsEnabled          = 1
        $This.Xaml.IO.MapPublish.IsEnabled             = 1

        $This.Xaml.IO.MapSlot.SelectedIndex            = 0
    }
    MapNameClear()
    {
        $This.Update(0,"Clearing [~] Map: $($This.Map.Name)")
        $This.ReleaseMap()
        $This.Initial("Map")

        $This.Xaml.IO.MapTab.IsEnabled                 = 1
        $This.Xaml.IO.MapNameText.IsEnabled            = 1
    }
    MapSlot()
    {
        $Ctrl = $This

        # Details
        $Ctrl.Xaml.IO.MapDetailsPanel.Visibility    = "Hidden"

        # Levelshot
        $Ctrl.Xaml.IO.MapLevelshotHeader.Visibility = "Hidden"
        $Ctrl.Xaml.IO.MapLevelshotPanel.Visibility  = "Hidden"

        # Arena
        $Ctrl.Xaml.IO.MapArenaHeader.Visibility     = "Hidden"
        $Ctrl.Xaml.IO.MapArenaPanel.Visibility      = "Hidden"

        # Shader
        $Ctrl.Xaml.IO.MapShaderHeader.Visibility    = "Hidden"
        $Ctrl.Xaml.IO.MapShaderPanel.Visibility     = "Hidden"

        # Output
        $Ctrl.Xaml.IO.MapOutputPanel.Visibility     = "Hidden"

        Switch -Regex ($Ctrl.Xaml.IO.MapSlot.SelectedItem.Content)
        {
            "^$"
            {

            }
            Details
            {
                $Ctrl.Xaml.IO.MapDetailsPanel.Visibility    = "Visible"
            }
            Levelshot
            {
                $Ctrl.Xaml.IO.MapLevelshotHeader.Visibility = "Visible"
                $Ctrl.Xaml.IO.MapLevelshotPanel.Visibility  = "Visible"
            }
            Arena
            {
                $Ctrl.Xaml.IO.MapArenaHeader.Visibility     = "Visible"
                $Ctrl.Xaml.IO.MapArenaPanel.Visibility      = "Visible"
            }
            Shader
            {
                $Ctrl.Xaml.IO.MapShaderHeader.Visibility    = "Visible"
                $Ctrl.Xaml.IO.MapShaderPanel.Visibility     = "Visible"
            }
            Output
            {
                $Ctrl.Xaml.IO.MapOutputPanel.Visibility     = "Visible"
            }
        }
    }
    MapLevelshotLoad([String]$Path)
    {
        $This.Update(0,"Loading [~] Levelshot: $Path")

        $This.Xaml.IO.MapLevelshotImage.Source = $Null

        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()

        # Load the new image into a memory stream
        $MemoryStream          = [System.IO.MemoryStream]::New()
        $FileStream            = [System.IO.File]::OpenRead($Path)
        $FileStream.CopyTo($MemoryStream)
        $FileStream.Close()
        $MemoryStream.Position = 0

        # Reload the new image from the memory stream
        $Bitmap                = [System.Windows.Media.Imaging.BitmapImage]::New()
        $Bitmap.BeginInit()
        $Bitmap.StreamSource   = $MemoryStream
        $Bitmap.CacheOption    = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
        $Bitmap.EndInit()

        $This.Xaml.IO.MapLevelshotImage.Source = $Bitmap
    }
    MapLevelshotImport()
    {
        $This.Update(0,"Importing [~] Levelshot")

        $Dialog = [System.Windows.Forms.OpenFileDialog]::New()

        $Dialog.InitialDirectory = $Env:SystemDrive
        $Dialog.Filter           = "jpg (*.jpg)|*.jpg|tga (*.tga)|*.tga|png (*.png)|*.png"

        $Dialog.ShowDialog()

        If ($Dialog.Filename)
        {
            $This.Update(0,"Setting [~] Levelshot: $($Dialog.Filename)")
            $This.SetLevelshot($Dialog.Filename)
            $This.MapLevelshotLoad($Dialog.Filename)
            $This.Map.Refresh()

            $xName = $This.Map.Name
            $This.MapNameClear()
            $This.Xaml.IO.MapNameText.Text = $xName
            $This.MapNameApply()
        }
    }
    MapArenaApply()
    {
        $This.Update(0,"Setting [~] Arena: $($This.Xaml.IO.MapArenaPath.Text)")
        $This.SetArena($This.Xaml.IO.MapArenaContent.Text)
        $This.Map.Arena.SetContent()
        $This.Map.Refresh()
    }
    MapShaderApply()
    {
        $This.Update(0,"Setting [~] Shader: $($This.Xaml.IO.MapShaderPath.Text)")
        $This.SetShader($This.Xaml.IO.MapShaderContent.Text)
        $This.Map.Shader.SetContent()
        $This.Map.Refresh()
    }
    MapCompile()
    {
        If ([System.IO.File]::Exists($This.Map.Source))
        {
            $This.Compile()
        }
    }
    MapPackage()
    {
        If ($This.Map.Output.Count -gt 0)
        {
            $This.Package()
        }
    }
    MapTransfer()
    {
        If (Get-Process | ? Name -match radiant)
        {
            $This.Update(1,"Exception [!] Close *radiant.exe")
        }
        ElseIf ([System.IO.File]::Exists($This.Map.Target))
        {
            $This.Transfer()
        }
    }
    MapPlay()
    {
        $Ctrl = $This
        $This.Update(0,"Playing [~] Map: $($This.Map.Name)")

        $Param = Switch -Regex ($Ctrl.Xaml.IO.MapPlayText.Text)
        {
            "^$" { "+map {0} ffa" -f $Ctrl.Map.Name } Default { $Ctrl.Xaml.IO.MapPlayText.Text }
        }

        Start-Process -FilePath "steam://rungameid/282440//$Param"
    }
    MapPublish()
    {
        $This.Xaml.IO.SteamTab.IsEnabled = 1
    }
    SteamSlot()
    {
        $Ctrl = $This

        $Ctrl.Xaml.IO.SteamCredentialHeader.Visibility = "Hidden"
        $Ctrl.Xaml.IO.SteamCredentialPanel.Visibility  = "Hidden"
        $Ctrl.Xaml.IO.SteamWorkshopHeader.Visibility   = "Hidden"
        $Ctrl.Xaml.IO.SteamWorkshopPanel.Visibility    = "Hidden"

        Switch ($Ctrl.Xaml.IO.SteamSlot.SelectedItem.Content)
        {
            "^$"
            {

            }
            Credential
            {
                $Ctrl.Xaml.IO.SteamCredentialHeader.Visibility = "Visible"
                $Ctrl.Xaml.IO.SteamCredentialPanel.Visibility  = "Visible"
            }
            Workshop
            {
                $Ctrl.Xaml.IO.SteamWorkshopHeader.Visibility   = "Visible"
                $Ctrl.Xaml.IO.SteamWorkshopPanel.Visibility    = "Visible"
            }
        }
    }
    SteamCheckLogin()
    {
        $Ctrl     = $This

        $Param       = "+login {0} {1} +quit" -f $Ctrl.Steam.Credential.Username, $Ctrl.Steam.Credential.Password
        Start-Process -FilePath $Ctrl.Steam.Cmd -ArgumentList $Param -NoNewWindow -Wait

        If ([System.IO.Directory]::Exists($Ctrl.Steam.Path))
        {
            $LogPath  = "{0}\Logs" -f $Ctrl.Steam.Path
            $LogFile  = "$LogPath\connection_log.txt"
        
            $xContent = [System.IO.File]::ReadAllLines($LogFile)
            $C        = $xContent.Count - 1
            $X        = ($C-20)..$C | ? { $xContent[$_] -match "Successfully generated token via password authentication" }
        
            If ($X)
            {
                $Connection = [Regex]::Matches($xContent[$X],"\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}").Value
                $Ctrl.Update(0,"Success [+] Login at [$Connection]")
            }
            Else
            {
                $Ctrl.Update(0,"Exception [!] Login attempt failed")
            }
        }
        Else
        {
            $Ctrl.Update(0,"Exception [!] Steam log path does not exist, run initial setup")
        }
    }
    SteamCredentialPathText()
    {
        $Ctrl                    = $This

        $Text                    = $Ctrl.Xaml.Get("SteamCredentialPathText")
        $Icon                    = $Ctrl.Xaml.Get("SteamCredentialPathIcon")
        $Apply                   = $Ctrl.Xaml.Get("SteamCredentialPathApply")

        If ($Text.Control.Text -match "(^<not set>$|^$)")
        {
            $Text.Status         = 2
        }
        Else
        {
            $Text.Status         = [UInt32][System.IO.File]::Exists($Text.Control.Text)
        }

        $Icon.Control.Source     = $Ctrl.IconStatus($Text.Status)
        $Apply.Control.IsEnabled = [UInt32]($Text.Status -eq 1)
    }
    SteamCredentialPathBrowse()
    {
        $This.Update(0,"Browsing [~] Credential")
    
        $Dialog = [System.Windows.Forms.OpenFileDialog]::New()

        $Dialog.InitialDirectory = $Env:SystemDrive
        $Dialog.Filter           = "xml (*.xml)|*.xml"

        $Dialog.ShowDialog()

        If ($Dialog.Filename)
        {
            $This.Xaml.IO.SteamCredentialPathText.Text = $Dialog.Filename
            $This.Steam.SetCredential($Dialog.Filename)
        }
        If (!$Dialog.Filename)
        {
            $This.Xaml.IO.SteamCredentialPathText.Text = "<not set>"
        }
    }
    SteamCredentialPathApply()
    {
        $Ctrl           = $This

        If (![System.IO.File]::Exists($Ctrl.Xaml.IO.SteamCredentialPathText.Text))
        {
            $Ctrl.Update(0,"Exception [!] Credential file does not exist")
        }
        Else
        {
            $Ctrl.Update(0,"Setting [~] Credential: $($Ctrl.Xaml.IO.SteamCredentialPathText.Text)")

            $Current            = $Ctrl.Registry.Current()
            $Current.Credential = $Ctrl.Xaml.IO.SteamCredentialPathText.Text
            $Current.SetProperties()
        }
    }
    SteamCredentialChanged()
    {
        $Ctrl                        = $This

        $Username                    = $Ctrl.Xaml.Get("SteamCredentialUsername")
        $UsernameIcon                = $Ctrl.Xaml.Get("SteamCredentialUsernameIcon")
        $Password                    = $Ctrl.Xaml.Get("SteamCredentialPassword")
        $PasswordIcon                = $Ctrl.Xaml.Get("SteamCredentialPasswordIcon")
        $Save                        = $Ctrl.Xaml.Get("SteamCredentialSave")
        $Assign                      = $Ctrl.Xaml.Get("SteamCredentialAssign")
    
        $Username.Status             = [UInt32]($Username.Control.Text -match "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$")
        $Password.Status             = [UInt32]($Password.Control.Password -notmatch "^$")
    
        $UsernameIcon.Control.Source = $Ctrl.IconStatus($Username.Status)
        $PasswordIcon.Control.Source = $Ctrl.IconStatus($Password.Status)

        $Save.Control.IsEnabled      = [UInt32]($Username.Status -and $Password.Status)
        $Assign.Control.IsEnabled    = [UInt32]($Username.Status -and $Password.Status)
    }
    SteamCredentialSave()
    {
        $Ctrl     = $This

        $xPath    = $Ctrl.Xaml.IO.SteamCredentialPathText.Text 
        $Parent   = $xPath | Split-Path -Parent
        $Username = $Ctrl.Xaml.IO.SteamCredentialUsername.Text
        $Password = $Ctrl.Xaml.IO.SteamCredentialPassword.SecurePassword
        $Cred     = [PSCredential]::New($Username,$Password)

        If ($Cred -and [System.IO.Directory]::Exists($Parent))
        {
            Export-CliXml -Path $xPath -InputObject $Cred
            $Ctrl.Update(0,"Saved [+] Credential: $xPath")
        }
    }
    SteamCredentialLoad()
    {
        $Ctrl = $This

        If ([System.IO.File]::Exists($Ctrl.Xaml.IO.SteamCredentialPathText.Text))
        {
            $Xml  = Import-CliXml -Path $Ctrl.Xaml.IO.SteamCredentialPathText.Text
            If ($Xml.GetType().Name -ne "PSCredential")
            {
                $Ctrl.Update(0,"Exception [!] Invalid credential")
            }
            Else
            {
                $Ctrl.Update(0,"Loading [~] Credential: $($Ctrl.Xaml.IO.SteamCredentialPathText.Text)")

                $Ctrl.Xaml.IO.SteamCredentialUsername.Text        = $Xml.Username
                $Ctrl.Xaml.IO.SteamCredentialPassword.Password    = $Xml.GetNetworkCredential().Password
            }
        }
    }
    SteamCredentialAssign()
    {
        $Ctrl     = $This

        $Username = $Ctrl.Xaml.IO.SteamCredentialUsername.Text
        $Password = $Ctrl.Xaml.IO.SteamCredentialPassword.SecurePassword

        $Ctrl.Steam.SetCredential($Username,$Password)

        If ($Ctrl.Steam.Credential)
        {
            $Ctrl.Xaml.IO.SteamCredentialPathText.IsEnabled   = 0
            $Ctrl.Xaml.IO.SteamCredentialPathBrowse.IsEnabled = 0
            $Ctrl.Xaml.IO.SteamCredentialPathApply.IsEnabled  = 0
            $Ctrl.Xaml.IO.SteamCredentialUsername.IsEnabled   = 0
            $Ctrl.Xaml.IO.SteamCredentialPassword.IsEnabled   = 0
            $Ctrl.Xaml.IO.SteamCredentialSave.IsEnabled       = 0
            $Ctrl.Xaml.IO.SteamCredentialLoad.IsEnabled       = 0
            $Ctrl.Xaml.IO.SteamCredentialAssign.IsEnabled     = 0
            $Ctrl.Xaml.IO.SteamCredentialEdit.IsEnabled       = 1

            If (![System.IO.Directory]::Exists("$($Ctrl.Steam.Path)\Logs"))
            {
                $Ctrl.Xaml.IO.SteamCredentialSetup.IsEnabled  = 1
                $Ctrl.Xaml.IO.SteamCredentialTest.IsEnabled   = 0
            }
            Else
            {
                $Ctrl.Xaml.IO.SteamCredentialSetup.IsEnabled  = 0
                $Ctrl.Xaml.IO.SteamCredentialTest.IsEnabled   = 1
            }

            $Ctrl.Update(0,"Assigned [+] Username: $Username, Password: <SecureString>")
        }
    }
    SteamCredentialEdit()
    {
        $Ctrl = $This

        $Ctrl.Xaml.IO.SteamCredentialPathText.IsEnabled   = 1
        $Ctrl.Xaml.IO.SteamCredentialPathBrowse.IsEnabled = 1
        $Ctrl.Xaml.IO.SteamCredentialPathApply.IsEnabled  = 0
        $Ctrl.Xaml.IO.SteamCredentialUsername.IsEnabled   = 1
        $Ctrl.Xaml.IO.SteamCredentialPassword.IsEnabled   = 1
        $Ctrl.Xaml.IO.SteamCredentialSave.IsEnabled       = 1
        $Ctrl.Xaml.IO.SteamCredentialLoad.IsEnabled       = 1
        $Ctrl.Xaml.IO.SteamCredentialAssign.IsEnabled     = 0
        $Ctrl.Xaml.IO.SteamCredentialEdit.IsEnabled       = 0
    }
    SteamCredentialSetup()
    {
        $Ctrl        = $This
        $Connection  = $Ctrl.TestConnection()

        If ($Connection)
        {
            $Caption = "SteamCmd initialization [~] (steamcmd.exe) setup required"
            $Message = "If the assigned credential is correct, Steam Guard will send authentication token which must be entered, proceed?"
    
            Switch ((Get-Host).UI.PromptForChoice($Caption,$Message,@("&Yes","&No"),0))
            {
                0 
                {
                    $Ctrl.Update(0,"Initializing [~] SteamCmd using assigned credential")
                    $Ctrl.SteamCheckLogin()
                    If ($Ctrl.Module.Console.Status -match "Success")
                    {
                        $Ctrl.Xaml.IO.SteamCredentialSetup.IsEnabled = 0
                        $Ctrl.Xaml.IO.SteamCredentialTest.IsEnabled  = 1
                        $Ctrl.Xaml.IO.SteamSlot.SelectedIndex        = 1
                    }
                }
                1
                {
                    $Ctrl.Update(0,"Exception [!] SteamCmd not initialized")
                }
            }
        }
        Else
        {
            $Ctrl.Update(0,"Exception [!] No internet connection")
        }
    }
    SteamCredentialTest()
    {
        $Ctrl        = $This
        $Connection  = $Ctrl.TestConnection()

        If ($Connection)
        {
            $Ctrl.Update(0,"Testing [~] Assigned Steam credential")
            $Ctrl.SteamCheckLogin()
            If ($Ctrl.Module.Console.Status -match "Success")
            {
                $Ctrl.Xaml.IO.SteamSlot.SelectedIndex        = 1
            }
        }
        Else
        {
            $Ctrl.Update(0,"Exception [!] No internet connection")
        }
    }
    SteamWorkshopPathText()
    {
        $Ctrl                    = $This
    
        $Text                    = $Ctrl.Xaml.Get("SteamWorkshopPathText")
        $Icon                    = $Ctrl.Xaml.Get("SteamWorkshopPathIcon")
        $Apply                   = $Ctrl.Xaml.Get("SteamWorkshopPathApply")
    
        If ($Text.Control.Text -match "(^<not set>$|^$)")
        {
            $Text.Status         = 2
        }
        Else
        {
            $Text.Status         = [UInt32][System.IO.Directory]::Exists($Text.Control.Text)
        }
    
        $Icon.Control.Source     = $Ctrl.IconStatus($Text.Status)
        $Apply.Control.IsEnabled = [UInt32]($Text.Status -eq 1)
    }
    SteamWorkshopPathBrowse()
    {
        $This.Update(0,"Browsing [~] Workshop")

        $Dialog              = [System.Windows.Forms.FolderBrowserDialog]::New()
        $Dialog.SelectedPath = $This.Steam.Path
        $Dialog.ShowDialog()

        $This.Xaml.IO.SteamWorkshopPathText.Text = @("<not set>",$Dialog.SelectedPath)[!!$Dialog.SelectedPath]
    }
    SteamWorkshopPathApply()
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Setting [~] Workshop: $($Ctrl.Xaml.IO.SteamWorkshopPathText.Text)")
        $Ctrl.Steam.SetWorkshop($Ctrl.Xaml.IO.SteamWorkshopPathText.Text)

        $Ctrl.Xaml.IO.SteamWorkshopPathText.IsEnabled      = 0
        $Ctrl.Xaml.IO.SteamWorkshopPathBrowse.IsEnabled    = 0
        $Ctrl.Xaml.IO.SteamWorkshopPathApply.IsEnabled     = 0

        $Ctrl.Xaml.IO.SteamWorkshopProjectCreate.IsEnabled = 0
        $Ctrl.Xaml.IO.SteamWorkshopProjectRemove.IsEnabled = 0

        If ($Ctrl.Map.Name -notin $Ctrl.Steam.Project.Name)
        {
            $Ctrl.Steam.CreateProject($Ctrl.Map.Name)
            $Ctrl.Steam.GetProject()
        }

        $Selection = $Ctrl.Steam.Project | ? Name -match $Ctrl.Map.Name
        $Ctrl.Steam.SetSelection($Selection.Index)

        $Ctrl.SteamWorkshopProject()

        $Ctrl.Xaml.IO.SteamWorkshopProjectSlot.SelectedIndex = 0
    }
    SteamWorkshopProjectSlot()
    {
        $Ctrl = $This

        $Ctrl.Xaml.IO.SteamWorkshopProjectDetailsHeader.Visibility = "Hidden"
        $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewHeader.Visibility = "Hidden"
        $Ctrl.Xaml.IO.SteamWorkshopProjectVdfHeader.Visibility     = "Hidden"
        $Ctrl.Xaml.IO.SteamWorkshopProjectDetailsPanel.Visibility  = "Hidden"
        $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewPanel.Visibility  = "Hidden"
        $Ctrl.Xaml.IO.SteamWorkshopProjectVdfPanel.Visibility      = "Hidden"
        $Ctrl.Xaml.IO.SteamWorkshopProjectOutputPanel.Visibility   = "Hidden"

        Switch -Regex ($Ctrl.Xaml.IO.SteamWorkshopProjectSlot.SelectedItem.Content)
        {
            "^$"
            {

            }
            Details
            {
                $Ctrl.Xaml.IO.SteamWorkshopProjectDetailsHeader.Visibility = "Visible"
                $Ctrl.Xaml.IO.SteamWorkshopProjectDetailsPanel.Visibility  = "Visible"
            }
            Preview
            {
                $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewHeader.Visibility = "Visible"
                $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewPanel.Visibility  = "Visible"
            }
            Vdf
            {
                $Ctrl.Xaml.IO.SteamWorkshopProjectVdfHeader.Visibility     = "Visible"
                $Ctrl.Xaml.IO.SteamWorkshopProjectVdfPanel.Visibility      = "Visible"
            }
            Output
            {
                $Ctrl.Xaml.IO.SteamWorkshopProjectOutputPanel.Visibility   = "Visible"
            }
        }
    }
    SteamWorkshopProject()
    {
        $Ctrl    = $This

        $Current = $Ctrl.Steam.Current()
        $Ctrl.Update(0,"Setting [~] Project: $($Ctrl.Map.Name)")
        $Current.Populate()

        # Details Header
        $Ctrl.Reset($Ctrl.Xaml.IO.SteamWorkshopProjectDetailsSelected,$Current)

        $Ctrl.Xaml.IO.SteamWorkshopProjectRefresh.IsEnabled = 1

        # Details Body
        $Object = $Current.Vdf | Select-Object AppId, PublishedFileId, ContentFolder, PreviewFile, Visibility, Title, Description, ChangeNote
        $Ctrl.Reset($Ctrl.Xaml.IO.SteamWorkshopProjectDetails,$Ctrl.Property($Object))
        $Ctrl.Xaml.IO.SteamWorkshopProjectDetails.IsEnabled      = 1

        # Preview
        $Label     = "levelshots\\\w+\.jpg"
        $Levelshot = $Ctrl.Map.Output | ? Fullname -match $Label
        If ($Levelshot)
        {
            $Current.SetPreview($Levelshot.Fullname)
        }

        $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewPathText.Text      = $Current.Preview.Fullname
        $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewPathText.IsEnabled = 0

        $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewExists.IsChecked   = $Current.Preview.Exists
        $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewExists.IsEnabled   = 0

        $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewImport.IsEnabled   = 1

        $Ctrl.SteamWorkshopProjectPreviewLoad($Current.Preview.Fullname)

        # Vdf
        $Ctrl.Xaml.IO.SteamWorkshopProjectVdfPathText.Text       = $Current.Vdf.Fullname
        $Ctrl.Xaml.IO.SteamWorkshopProjectVdfPathText.IsEnabled  = 0

        $Ctrl.Xaml.IO.SteamWorkshopProjectVdfExists.IsChecked    = $Current.Vdf.Exists
        $Ctrl.Xaml.IO.SteamWorkshopProjectVdfExists.IsEnabled    = 0

        $Ctrl.Xaml.IO.SteamWorkshopProjectVdfApply.IsEnabled     = 1

        $Ctrl.Xaml.IO.SteamWorkshopProjectVdfContent.IsEnabled   = 1

        If ($Current.Vdf.Exists)
        {
            $Ctrl.Xaml.IO.SteamWorkshopProjectVdfContent.Text = [System.IO.File]::ReadAllLines($Current.Vdf.Fullname) -join "`n"
        }
        If (!$Current.Vdf.Exists)
        {
            # Default starting VDF template bonanza extravaganza 5000
            $xVdf = @{

                AppId           = 282440
                PublishedFileId = 0
                ContentFolder   = $Current.ContentPath()
                PreviewFile     = @($Null,$Current.Preview.Fullname)[!!$Current.Preview.Fullname]
                Visibility      = 0
                Title           = "<Enter Title here>"
                Description     = "<Enter Description here>"
                ChangeNote      = "<Enter ChangeNote here>"
            }

            $Current.SetVdf($xVdf)
            $Current.SetPk3($Ctrl.Map.Target)

            $Ctrl.Xaml.IO.SteamWorkshopProjectVdfContent.Text = [System.IO.File]::ReadAllLines($Current.Vdf.Fullname) -join "`n"
        }

        # Output
        $Ctrl.Reset($Ctrl.Xaml.IO.SteamWorkshopProjectOutput,$Current.Content)
        $Ctrl.Xaml.IO.SteamWorkshopProjectOutput.IsEnabled      = 0

        $Ctrl.Xaml.IO.SteamWorkshopProjectUpload.IsEnabled    = [UInt32]($Current.Content.Count -ge 4)
        $Ctrl.Xaml.IO.SteamWorkshopProjectReference.IsEnabled = [UInt32]($Current.Vdf.PublishedFileId -ne 0)
    }
    SteamWorkshopProjectVdfApply()
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Setting [~] Vdf: $($Ctrl.Xaml.IO.SteamWorkshopProjectVdfContent.Text)")
        $Current = $Ctrl.Steam.Current()

        $Current.UpdateVdf($Ctrl.Xaml.IO.SteamWorkshopProjectVdfContent.Text)

        $Ctrl.SteamWorkshopProject()
    }
    SteamWorkshopProjectPreviewLoad([String]$Path)
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Loading [~] Preview: $Path")
        $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewImage.Source = $Null

        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()

        # Load the new image into a memory stream
        $MemoryStream          = [System.IO.MemoryStream]::New()
        $FileStream            = [System.IO.File]::OpenRead($Path)
        $FileStream.CopyTo($MemoryStream)
        $FileStream.Close()
        $MemoryStream.Position = 0

        # Reload the new image from the memory stream
        $Bitmap                = [System.Windows.Media.Imaging.BitmapImage]::New()
        $Bitmap.BeginInit()
        $Bitmap.StreamSource   = $MemoryStream
        $Bitmap.CacheOption    = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
        $Bitmap.EndInit()

        $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewImage.Source = $Bitmap
    }
    SteamWorkshopProjectPreviewImport()
    {
        $This.Update(0,"Browse [~] Preview")

        $Dialog = [System.Windows.Forms.OpenFileDialog]::New()

        $Dialog.InitialDirectory = $Env:SystemDrive
        $Dialog.Filter           = "jpg (*.jpg)|*.jpg"

        $Dialog.ShowDialog()

        If ($Dialog.Filename)
        {
            $Current = $This.Steam.Current()
            $This.Update(0,"Setting [~] Preview: $($Current.Preview.Fullname)")

            [System.IO.File]::Copy($Dialog.Filename,$Current.Preview.Fullname,$True)

            $This.SteamWorkshopProject()
        }
    }
    SteamWorkshopProjectRefresh()
    {
        $This.SteamWorkshopProject()
    }
    SteamWorkshopProjectCreate()
    {
        $Ctrl = $This

        If ($Ctrl.Map.Name -notin $Ctrl.Steam.Project.Name)
        {
            $Ctrl.Steam.CreateProject($Ctrl.Map.Name)
            $Ctrl.Steam.GetProject()
        }

        $Ctrl.SteamWorkshopProject()
    }
    SteamWorkshopProjectRemove()
    {
        $Ctrl = $This

        If ($Ctrl.Map.Name -in $Ctrl.Steam.Project.Name)
        {
            $Ctrl.Steam.RemoveProject($Ctrl.Map.Name)
            $Ctrl.Steam.GetProject()
        }
    }
    SteamWorkshopProjectUpload()
    {
        $Ctrl    = $This
        $Current = $Ctrl.Steam.Current()

        $Connection  = $Ctrl.TestConnection()
        If ($Connection)
        {
            $Ctrl.Update(0,"Uploading [~] Project: [$($Current.Name)]")
            $Ctrl.Steam.UploadProject()
            $Ctrl.SteamWorkshopProject()
            $Ctrl.Xaml.IO.SteamWorkshopProjectReference.IsEnabled = 1
        }
        Else
        {
            $Ctrl.Update(0,"Exception [!] Could not update project: [$($Current.Name)], no internet connection")
        }
    }
    SteamWorkshopProjectReference()
    {
        $ReferenceId = $This.Steam.Current().Vdf.PublishedFileId

        Start-Process -FilePath "https://steamcommunity.com/sharedfiles/filedetails/?id=$ReferenceId"
    }
    ConsoleFilter()
    {
        $Ctrl    = $This
        $Text    = $Ctrl.Xaml.IO.ConsoleFilter.Text

        $Content = Switch -Regex ($Text)
        {
            "^$"
            {
                $Ctrl.Module.Console.Output
            }
            Default
            {
                $Ctrl.Module.Console.Output | ? $Ctrl.Xaml.IO.ConsoleProperty.SelectedItem.Content -match $Text
            }
        }

        $Ctrl.Reset($Ctrl.Xaml.IO.ConsoleOutput,$Content)
    }
    ConsoleRefresh()
    {
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.ConsoleFilter.Text -notmatch "^$")
        {
            $Ctrl.ConsoleFilter()
        }
        Else
        {
            $Ctrl.Reset($Ctrl.Xaml.IO.ConsoleOutput,$Ctrl.Module.Console.Output)
        }
    }
    ConsolePathText()
    {
        $Ctrl                    = $This
    
        $Text                    = $Ctrl.Xaml.Get("ConsolePathText")
        $Icon                    = $Ctrl.Xaml.Get("ConsolePathIcon")
        $Apply                   = $Ctrl.Xaml.Get("ConsoleSave")
    
        If ($Text.Control.Text -match "(^<not set>$|^$)")
        {
            $Text.Status         = 2
        }
        Else
        {
            $Parent              = Split-Path $Text.Control.Text -Parent

            If ([System.IO.Directory]::Exists($Parent) -and ![System.IO.File]::Exists($Text.Control.Text))
            {
                $Text.Status     = 1
            }
            Else
            {
                $Text.Status     = 0
            }
        }
    
        $Icon.Control.Source     = $Ctrl.IconStatus($Text.Status)
        $Apply.Control.IsEnabled = [UInt32]($Text.Status -eq 1)
    }
    ConsolePathBrowse()
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Importing [~] Levelshot")

        $Dialog = [System.Windows.Forms.SaveFileDialog]::New()

        $Dialog.InitialDirectory = "$Env:ProgramData\Secure Digits Plus LLC\Q3A-Live\Logs"
        $Dialog.Filename         = $Ctrl.Module.Console.Start.Time.ToString("yyyy_MMdd-HHmmss")
        $Dialog.Filter           = "log (*.log)|*.log"

        $Dialog.ShowDialog()

        If ($Dialog.Filename)
        {
            $Ctrl.Xaml.IO.ConsolePathText.Text = $Dialog.Filename
        }
        Else
        {
            $Ctrl.Xaml.IO.ConsolePathText.Text = "<not set>"
        }
    }
    ConsoleSave()
    {
        $Ctrl  = $This

        $Ctrl.Module.Console.Finalize()
        $xPath = $Ctrl.Xaml.IO.ConsolePathText.Text
        $Value = $Ctrl.Module.Console.Output | % ToString

        [System.IO.File]::WriteAllLines($xPath,$Value)

        $Ctrl.Xaml.IO.Close()
    }
    Reset([Object]$xSender,[Object]$Object)
    {
        $xSender.Items.Clear()
        ForEach ($Item in $Object)
        {
            $xSender.Items.Add($Item)
        }
    }
    Stage([String]$Name)
    {
        $This.Update(0,"Staging [~] $Name")

        $Ctrl = $This

        Switch ($Name)
        {
            Component
            {
                $Ctrl.Xaml.IO.DependencyOutput.Add_SelectionChanged(
                {
                    $Ctrl.DependencyOutput()
                })

                $Ctrl.Xaml.IO.DependencyPathText.Add_TextChanged(
                {
                    $Ctrl.DependencyPathText()
                })

                $Ctrl.Xaml.IO.DependencyPathText.Add_GotFocus(
                {
                    $Text = Switch -Regex ($Ctrl.Xaml.IO.DependencyPathText.Text)
                    {
                        "(^$|^<not set>$)" 
                        {
                            ""
                        }
                        Default
                        { 
                            $Ctrl.Xaml.IO.DependencyPathText.Text
                        }
                    }

                    $Ctrl.Xaml.IO.DependencyPathText.Text = $Text
                })
    
                $Ctrl.Xaml.IO.DependencyPathText.Add_LostFocus(
                {
                    $Text = Switch -Regex ($Ctrl.Xaml.IO.DependencyPathText.Text)
                    {
                        "(^$|^<not set>$)" 
                        {
                            "<not set>"
                        }
                        Default
                        { 
                            $Ctrl.Xaml.IO.DependencyPathText.Text
                        }
                    }

                    $Ctrl.Xaml.IO.DependencyPathText.Text = $Text
                })

                $Ctrl.Xaml.IO.DependencyPathBrowse.Add_Click(
                {
                    $Ctrl.DependencyPathBrowse()
                })

                $Ctrl.Xaml.IO.DependencyPathApply.Add_Click(
                {
                    $Ctrl.DependencyPathApply()
                })

                $Ctrl.Xaml.IO.DependencyInstall.Add_Click(
                {
                    $Ctrl.DependencyInstall()
                })

                $Ctrl.Xaml.IO.DependencyEdit.Add_Click(
                {
                    $Ctrl.DependencyEdit()
                })

                $Ctrl.Xaml.IO.DependencyClear.Add_Click(
                {
                    $Ctrl.DependencyClear()
                })
            }
            Workspace
            {
                $Ctrl.Xaml.IO.WorkspacePathText.Add_TextChanged(
                {
                    $Ctrl.WorkspacePathText()
                })

                $Ctrl.Xaml.IO.WorkspacePathText.Add_GotFocus(
                {
                    $Text = Switch -Regex ($Ctrl.Xaml.IO.WorkspacePathText.Text)
                    {
                        "(^$|^<not set>$)" 
                        {
                            ""
                        }
                        Default
                        { 
                            $Ctrl.Xaml.IO.WorkspacePathText.Text
                        }
                    }

                    $Ctrl.Xaml.IO.WorkspacePathText.Text = $Text
                })

                $Ctrl.Xaml.IO.WorkspacePathText.Add_LostFocus(
                {
                    $Text = Switch -Regex ($Ctrl.Xaml.IO.WorkspacePathText.Text)
                    {
                        "(^$|^<not set>$)" 
                        {
                            "<not set>"
                        }
                        Default
                        { 
                            $Ctrl.Xaml.IO.WorkspacePathText.Text
                        }
                    }

                    $Ctrl.Xaml.IO.WorkspacePathText.Text = $Text
                })

                $Ctrl.Xaml.IO.WorkspacePathBrowse.Add_Click(
                {
                    $Ctrl.WorkspacePathBrowse()
                })

                $Ctrl.Xaml.IO.WorkspacePathApply.Add_Click(
                {
                    $Ctrl.WorkspacePathApply()
                })

                $Ctrl.Xaml.IO.WorkspacePathClear.Add_Click(
                {
                    $Ctrl.WorkspacePathClear()
                })

                $Ctrl.Xaml.IO.WorkspaceSlot.Add_SelectionChanged(
                {
                    $Ctrl.WorkspaceSlot()
                })

                $Ctrl.Xaml.IO.WorkspaceOutputRefresh.Add_Click(
                {
                    $Ctrl.WorkspaceOutputRefresh()
                })
            }
            Map
            {
                $Ctrl.Xaml.IO.MapNameText.Add_TextChanged(
                {
                    $Ctrl.MapNameText()
                })

                $Ctrl.Xaml.IO.MapNameText.Add_GotFocus(
                {
                    $Text = Switch -Regex ($Ctrl.Xaml.IO.MapNameText.Text)
                    {
                        "(^$|^<not set>$)" 
                        {
                            ""
                        }
                        Default
                        { 
                            $Ctrl.Xaml.IO.MapNameText.Text
                        }
                    }

                    $Ctrl.Xaml.IO.MapNameText.Text = $Text
                })

                $Ctrl.Xaml.IO.MapNameText.Add_LostFocus(
                {
                    $Text = Switch -Regex ($Ctrl.Xaml.IO.MapNameText.Text)
                    {
                        "(^$|^<not set>$)" 
                        {
                            "<not set>"
                        }
                        Default
                        { 
                            $Ctrl.Xaml.IO.MapNameText.Text
                        }
                    }

                    $Ctrl.Xaml.IO.MapNameText.Text = $Text
                })

                $Ctrl.Xaml.IO.MapNameText.Add_KeyDown(
                {
                    If ($_.KeyCode -eq [System.Windows.Forms.Keys]::Enter)
                    {
                        $Ctrl.MapNameApply()
                    }
                })

                $Ctrl.Xaml.IO.MapNameApply.Add_Click(
                {
                    $Ctrl.MapNameApply()
                })

                $Ctrl.Xaml.IO.MapNameClear.Add_Click(
                {
                    $Ctrl.MapNameClear()
                })

                $Ctrl.Xaml.IO.MapSlot.Add_SelectionChanged(
                {
                    $Ctrl.MapSlot()
                })

                $Ctrl.Xaml.IO.MapLevelshotImport.Add_Click(
                {
                    $Ctrl.MapLevelshotImport()
                })

                $Ctrl.Xaml.IO.MapArenaApply.Add_Click(
                {
                    $Ctrl.MapArenaApply()
                })

                $Ctrl.Xaml.IO.MapShaderApply.Add_Click(
                {
                    $Ctrl.MapShaderApply()
                })

                $Ctrl.Xaml.IO.MapCompile.Add_Click(
                {
                    $Ctrl.MapCompile()
                })

                $Ctrl.Xaml.IO.MapPackage.Add_Click(
                {
                    $Ctrl.MapPackage()
                })

                $Ctrl.Xaml.IO.MapTransfer.Add_Click(
                {
                    $Ctrl.MapTransfer()
                })

                $Ctrl.Xaml.IO.MapPlayButton.Add_Click(
                {
                    $Ctrl.MapPlay()
                })

                $Ctrl.Xaml.IO.MapPublish.Add_Click(
                {
                    $Ctrl.MapPublish()
                })
            }
            Steam
            {
                $Ctrl.Xaml.IO.SteamSlot.Add_SelectionChanged(
                {
                    $Ctrl.SteamSlot()
                })

                # [Steam Credential]
                $Ctrl.Xaml.IO.SteamCredentialPathText.Add_TextChanged(
                {
                    $Ctrl.SteamCredentialPathText()
                })

                $Ctrl.Xaml.IO.SteamCredentialPathText.Add_GotFocus(
                {
                    $Text = Switch -Regex ($Ctrl.Xaml.IO.SteamCredentialPathText.Text)
                    {
                        "(^$|^<not set>$)" 
                        {
                            ""
                        }
                        Default
                        { 
                            $Ctrl.Xaml.IO.SteamCredentialPathText.Text
                        }
                    }

                    $Ctrl.Xaml.IO.SteamCredentialPathText.Text = $Text
                })

                $Ctrl.Xaml.IO.SteamCredentialPathText.Add_LostFocus(
                {
                    $Text = Switch -Regex ($Ctrl.Xaml.IO.SteamCredentialPathText.Text)
                    {
                        "(^$|^<not set>$)" 
                        {
                            "<not set>"
                        }
                        Default
                        { 
                            $Ctrl.Xaml.IO.SteamCredentialPathText.Text
                        }
                    }

                    $Ctrl.Xaml.IO.SteamCredentialPathText.Text = $Text
                })

                $Ctrl.Xaml.IO.SteamCredentialPathBrowse.Add_Click(
                {
                    $Ctrl.SteamCredentialPathBrowse()
                })

                $Ctrl.Xaml.IO.SteamCredentialPathApply.Add_Click(
                {
                    $Ctrl.SteamCredentialPathApply()
                })

                $Ctrl.Xaml.IO.SteamCredentialUsername.Add_TextChanged(
                {
                    $Ctrl.SteamCredentialChanged()
                })

                $Ctrl.Xaml.IO.SteamCredentialPassword.Add_PasswordChanged(
                {
                    $Ctrl.SteamCredentialChanged()
                })

                $Ctrl.Xaml.IO.SteamCredentialSave.Add_Click(
                {
                    $Ctrl.SteamCredentialSave()
                })

                $Ctrl.Xaml.IO.SteamCredentialLoad.Add_Click(
                {
                    $Ctrl.SteamCredentialLoad()
                })

                $Ctrl.Xaml.IO.SteamCredentialAssign.Add_Click(
                {
                    $Ctrl.SteamCredentialAssign()
                })

                $Ctrl.Xaml.IO.SteamCredentialEdit.Add_Click(
                {
                    $Ctrl.SteamCredentialEdit()
                })

                $Ctrl.Xaml.IO.SteamCredentialSetup.Add_Click(
                {
                    $Ctrl.SteamCredentialSetup()
                })

                $Ctrl.Xaml.IO.SteamCredentialTest.Add_Click(
                {
                    $Ctrl.SteamCredentialTest()
                })

                # [Steam Workshop]
                $Ctrl.Xaml.IO.SteamWorkshopPathText.Add_TextChanged(
                {
                    $Ctrl.SteamWorkshopPathText()
                })

                $Ctrl.Xaml.IO.SteamWorkshopPathText.Add_GotFocus(
                {
                    $Text = Switch -Regex ($Ctrl.Xaml.IO.SteamWorkshopPathText.Text)
                    {
                        "(^$|^<not set>$)" 
                        {
                            ""
                        }
                        Default
                        { 
                            $Ctrl.Xaml.IO.SteamWorkshopPathText.Text
                        }
                    }

                    $Ctrl.Xaml.IO.SteamWorkshopPathText.Text = $Text
                })

                $Ctrl.Xaml.IO.SteamWorkshopPathText.Add_LostFocus(
                {
                    $Text = Switch -Regex ($Ctrl.Xaml.IO.SteamWorkshopPathText.Text)
                    {
                        "(^$|^<not set>$)"
                        {
                            "<not set>"
                        }
                        Default
                        { 
                            $Ctrl.Xaml.IO.SteamWorkshopPathText.Text
                        }
                    }

                    $Ctrl.Xaml.IO.SteamWorkshopPathText.Text = $Text
                })

                $Ctrl.Xaml.IO.SteamWorkshopPathBrowse.Add_Click(
                {
                    $Ctrl.SteamWorkshopPathBrowse()
                })

                $Ctrl.Xaml.IO.SteamWorkshopPathApply.Add_Click(
                {
                    $Ctrl.SteamWorkshopPathApply()
                })

                $Ctrl.Xaml.IO.SteamWorkshopProjectSlot.Add_SelectionChanged(
                {
                    $Ctrl.SteamWorkshopProjectSlot()
                })

                $Ctrl.Xaml.IO.SteamWorkshopProjectVdfApply.Add_Click(
                {
                    $Ctrl.SteamWorkshopProjectVdfApply()
                })

                $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewImport.Add_Click(
                {
                    $Ctrl.SteamWorkshopProjectPreviewImport()
                })

                $Ctrl.Xaml.IO.SteamWorkshopProjectCreate.Add_Click(
                {
                    $Ctrl.SteamWorkshopProjectCreate()
                })

                $Ctrl.Xaml.IO.SteamWorkshopProjectRemove.Add_Click(
                {
                    $Ctrl.SteamWorkshopProjectRemove()
                })

                $Ctrl.Xaml.IO.SteamWorkshopProjectUpload.Add_Click(
                {
                    $Ctrl.SteamWorkshopProjectUpload()
                })

                $Ctrl.Xaml.IO.SteamWorkshopProjectReference.Add_Click(
                {
                    $Ctrl.SteamWorkshopProjectReference()
                })
            }
            Console
            {
                $Ctrl.Xaml.IO.ConsoleFilter.Add_TextChanged(
                {
                    $Ctrl.ConsoleFilter()
                })

                $Ctrl.Xaml.IO.ConsoleRefresh.Add_Click(
                {
                    $Ctrl.ConsoleRefresh()
                })

                $Ctrl.Xaml.IO.ConsolePathText.Add_TextChanged(
                {
                    $Ctrl.ConsolePathText()
                })

                $Ctrl.Xaml.IO.ConsolePathBrowse.Add_Click(
                {
                    $Ctrl.ConsolePathBrowse()
                })

                $Ctrl.Xaml.IO.ConsoleSave.Add_Click(
                {
                    $Ctrl.ConsoleSave()
                })
            }
        }
    }
    Initial([String]$Name)
    {
        $Ctrl    = $This

        Switch ($Name)
        {
            Component
            {
                $Ctrl.Xaml.IO.DependencyPathText.IsEnabled     = 0
                $Ctrl.Xaml.IO.DependencyPathText.Text          = "<not set>"

                $Ctrl.Xaml.IO.DependencyPathIcon.IsEnabled     = 0

                $Ctrl.Xaml.IO.DependencyPathBrowse.IsEnabled   = 0
                
                $Ctrl.Xaml.IO.DependencyPathApply.IsEnabled    = 0

                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentOutput,$Ctrl.Component)
                $Ctrl.Reset($Ctrl.Xaml.IO.DependencyOutput,$Ctrl.Dependency.Output)

                $Ctrl.Xaml.IO.DependencyOutput.SelectedIndex   = 0
            }
            Workspace
            {
                $Ctrl.Xaml.IO.WorkspaceTab.IsEnabled           = 0
                $Ctrl.Xaml.IO.WorkspacePathText.Text           = "<not set>"
                $Ctrl.Xaml.IO.WorkspacePathIcon.Source         = $Ctrl.IconStatus(2)
                $Ctrl.Xaml.IO.WorkspacePathApply.IsEnabled     = 0

                $Ctrl.Xaml.IO.WorkspaceLogPathText.IsEnabled   = 0
                $Ctrl.Xaml.IO.WorkspaceLogPathExists.IsEnabled = 0
                $Ctrl.Xaml.IO.WorkspaceLogContent.Items.Clear()
                $Ctrl.Xaml.IO.WorkspaceOutput.Items.Clear()
            }
            Map
            {
                $Ctrl.Xaml.IO.MapTab.IsEnabled                 = 0
                $Ctrl.Xaml.IO.MapNameText.Text                 = "<not set>"
                $Ctrl.Xaml.IO.MapNameIcon.Source               = $Ctrl.IconStatus(2)
                $Ctrl.Xaml.IO.MapNameApply.IsEnabled           = 0

                # Details/Property/Texture
                $Ctrl.Reset($Ctrl.Xaml.IO.MapDetails,$Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.MapProperty,$Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.MapTexture,$Null)

                $Ctrl.Xaml.IO.MapLevelshotPath.IsEnabled       = 0
                $Ctrl.Xaml.IO.MapLevelshotPath.Text            = $Null
                $Ctrl.Xaml.IO.MapLevelshotExists.IsEnabled     = 0
                $Ctrl.Xaml.IO.MapLevelshotExists.IsChecked     = 0
                $Ctrl.Xaml.IO.MapLevelshotImport.IsEnabled     = 0
                $Ctrl.Xaml.IO.MapLevelshotImage.IsEnabled      = 0
                $Ctrl.Xaml.IO.MapLevelshotImage.Source         = $Null

                # Arena
                $Ctrl.Xaml.IO.MapArenaPath.IsEnabled           = 0
                $Ctrl.Xaml.IO.MapArenaPath.Text                = $Null
                $Ctrl.Xaml.IO.MapArenaExists.IsEnabled         = 0
                $Ctrl.Xaml.IO.MapArenaExists.IsChecked         = 0
                $Ctrl.Xaml.IO.MapArenaApply.IsEnabled          = 0
                $Ctrl.Xaml.IO.MapArenaContent.IsEnabled        = 0
                $Ctrl.Xaml.IO.MapArenaContent.Text             = $Null

                # Shader
                $Ctrl.Xaml.IO.MapShaderPath.IsEnabled          = 0
                $Ctrl.Xaml.IO.MapShaderPath.Text               = $Null
                $Ctrl.Xaml.IO.MapShaderExists.IsEnabled        = 0
                $Ctrl.Xaml.IO.MapShaderExists.IsChecked        = 0
                $Ctrl.Xaml.IO.MapShaderApply.IsEnabled         = 0
                $Ctrl.Xaml.IO.MapShaderContent.IsEnabled       = 0
                $Ctrl.Xaml.IO.MapShaderContent.Text            = $Null

                # Map
                $Ctrl.Xaml.IO.MapCompile.IsEnabled             = 0
                $Ctrl.Xaml.IO.MapPackage.IsEnabled             = 0
                $Ctrl.Xaml.IO.MapTransfer.IsEnabled            = 0
                $Ctrl.Xaml.IO.MapPlayText.IsEnabled            = 0
                $Ctrl.Xaml.IO.MapPlayText.Text                 = $Null
                $Ctrl.Xaml.IO.MapPlayButton.IsEnabled          = 0
                $Ctrl.Xaml.IO.MapPublish.IsEnabled             = 0
        
                # Output
                $Ctrl.Xaml.IO.MapOutput.IsEnabled              = 1
                $Ctrl.Reset($Ctrl.Xaml.IO.MapOutput,$Null)
            }
            Steam
            {
                # Steam
                $Ctrl.Xaml.IO.SteamTab.IsEnabled                    = 0
                $Ctrl.Xaml.IO.SteamSlot.SelectedIndex               = 0

                # Credential
                $Ctrl.Xaml.IO.SteamCredentialPathText.IsEnabled     = 1
                $Ctrl.Xaml.IO.SteamCredentialPathText.Text          = "<not set>"
                
                $Ctrl.Xaml.IO.SteamCredentialPathIcon.IsEnabled     = 1
                $Ctrl.Xaml.IO.SteamCredentialPathBrowse.IsEnabled   = 1
                $Ctrl.Xaml.IO.SteamCredentialPathApply.IsEnabled    = 1

                $Ctrl.Xaml.IO.SteamCredentialUsername.IsEnabled     = 1
                $Ctrl.Xaml.IO.SteamCredentialPassword.IsEnabled     = 1

                $Ctrl.Xaml.IO.SteamCredentialSave.IsEnabled         = 0
                $Ctrl.Xaml.IO.SteamCredentialLoad.IsEnabled         = 1
                $Ctrl.Xaml.IO.SteamCredentialEdit.IsEnabled         = 0
                $Ctrl.Xaml.IO.SteamCredentialAssign.IsEnabled       = 0
                $Ctrl.Xaml.IO.SteamCredentialSetup.IsEnabled        = 0
                $Ctrl.Xaml.IO.SteamCredentialTest.IsEnabled         = 0

                # Workshop
                $Ctrl.Xaml.IO.SteamWorkshopPathText.IsEnabled       = 1
                $Ctrl.Xaml.IO.SteamWorkshopPathText.Text            = "<not set>"
                $Ctrl.Xaml.IO.SteamWorkshopPathIcon.IsEnabled       = 1
                $Ctrl.Xaml.IO.SteamWorkshopPathBrowse.IsEnabled     = 1
                $Ctrl.Xaml.IO.SteamWorkshopPathApply.IsEnabled      = 0

                $Ctrl.Reset($Ctrl.Xaml.IO.SteamWorkshopProjectOutput,$Null)

                # Details
                $Ctrl.Xaml.IO.SteamWorkshopProjectDetails.IsEnabled = 0
                $Ctrl.Reset($Ctrl.Xaml.IO.SteamWorkshopProjectDetails,$Null)

                # Preview
                $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewPathText.IsEnabled = 0
                $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewPathText.Text      = "<not set>"
                $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewExists.IsEnabled   = 0
                $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewExists.IsChecked   = 0
                $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewImport.IsEnabled   = 0
                $Ctrl.Xaml.IO.SteamWorkshopProjectPreviewImage.IsEnabled    = 0

                # Vdf
                $Ctrl.Xaml.IO.SteamWorkshopProjectVdfPathText.IsEnabled     = 0
                $Ctrl.Xaml.IO.SteamWorkshopProjectVdfPathText.Text          = "<not set>"
                $Ctrl.Xaml.IO.SteamWorkshopProjectVdfExists.IsEnabled       = 0
                $Ctrl.Xaml.IO.SteamWorkshopProjectVdfExists.IsChecked       = 0
                $Ctrl.Xaml.IO.SteamWorkshopProjectVdfApply.IsEnabled        = 0
                $Ctrl.Xaml.IO.SteamWorkshopProjectVdfContent.IsEnabled      = 0

                # Output
                $Ctrl.Xaml.IO.SteamWorkshopProjectOutput.IsEnabled          = 0
                $Ctrl.Reset($Ctrl.Xaml.IO.SteamWorkshopProjectOutput,$Null)

                # Functions
                $Ctrl.Xaml.IO.SteamWorkshopProjectCreate.IsEnabled          = 0
                $Ctrl.Xaml.IO.SteamWorkshopProjectRemove.IsEnabled          = 0
                $Ctrl.Xaml.IO.SteamWorkshopProjectUpload.IsEnabled          = 0
                $Ctrl.Xaml.IO.SteamWorkshopProjectReference.IsEnabled       = 0
            }
            Console
            {
                $Ctrl.Xaml.IO.ConsoleProperty.IsEnabled                     = 1
                $Ctrl.Xaml.IO.ConsoleProperty.SelectedIndex                 = 3
                $Ctrl.Xaml.IO.ConsoleFilter.IsEnabled                       = 1
                $Ctrl.Xaml.IO.ConsoleFilter.Text                            = ""
                $Ctrl.Xaml.IO.ConsoleRefresh.IsEnabled                      = 1

                $Ctrl.Xaml.IO.ConsoleOutput.IsEnabled                       = 1
                $Ctrl.Reset($Ctrl.Xaml.IO.ConsoleOutput,$Ctrl.Module.Console.Output)

                $Ctrl.Xaml.IO.ConsolePathText.IsEnabled                     = 1
                $Ctrl.Xaml.IO.ConsolePathIcon.IsEnabled                     = 1
                $Ctrl.Xaml.IO.ConsolePathBrowse.IsEnabled                   = 1
                $Ctrl.Xaml.IO.ConsoleSave.IsEnabled                         = 0

                $Ctrl.Xaml.IO.ConsolePathText.Text                          = "<not set>"
            }
        }
    }
    StageXaml()
    {
        $Ctrl = $This

        # [Event handler stuff]
        $Ctrl.Stage("Component")
        $Ctrl.Stage("Radiant")
        $Ctrl.Stage("Workspace")
        $Ctrl.Stage("Map")
        $Ctrl.Stage("Steam")
        $Ctrl.Stage("Console")

        # [Initial properties/settings]
        $Ctrl.Initial("Component")
        $Ctrl.Initial("Radiant")
        $Ctrl.Initial("Workspace")
        $Ctrl.Initial("Map")
        $Ctrl.Initial("Steam")
        $Ctrl.Initial("Console")

        # [Registry]
        $Current = $Ctrl.Registry.Current()
        If ($Current)
        {
            If ([System.IO.Directory]::Exists($Current.Workspace))
            {
                $Ctrl.Xaml.IO.WorkspacePathText.Text              = $Current.Workspace
                $Ctrl.Xaml.IO.WorkspacePathIcon.Source            = $Ctrl.IconStatus(1)
                $Ctrl.Xaml.IO.WorkspacePathBrowse.IsEnabled       = 1
                $Ctrl.Xaml.IO.WorkspacePathApply.IsEnabled        = 1
            }

            If ([System.IO.File]::Exists($Current.Credential))
            {
                $Ctrl.Xaml.IO.SteamCredentialPathText.Text        = $Current.Credential
                $Ctrl.Xaml.IO.SteamCredentialPathIcon.Source      = $Ctrl.IconStatus(1)
                $Ctrl.Xaml.IO.SteamCredentialPathBrowse.IsEnabled = 1
                $Ctrl.Xaml.IO.SteamCredentialPathApply.IsEnabled  = 1
            }

            If ([System.IO.Directory]::Exists($Current.Workshop))
            {
                $Ctrl.Xaml.IO.SteamWorkshopPathText.Text          = $Current.Workshop
                $Ctrl.Xaml.IO.SteamWorkshopPathIcon.Source        = $Ctrl.IconStatus(1)
                $Ctrl.Xaml.IO.SteamWorkshopPathBrowse.IsEnabled   = 1
                $Ctrl.Xaml.IO.SteamWorkshopPathApply.IsEnabled    = 1
            }
        }

        $Select = $Ctrl.Dependency.Output | ? DisplayName -match "(Radiant|Archive|Image|Steam)"
        $Ctrl.Xaml.IO.WorkspaceTab.IsEnabled = [UInt32](0 -notin $Select.Installed)
    }
    Invoke()
    {
        $This.Update(0,"Invoking [~] Xaml Interface")
        Try
        {
            $This.Xaml.Invoke()
        }
        Catch
        {
            $This.Module.Write(1,"Exception [!] Either the user cancelled, or the dialog failed.")
        }
    }
    Reload()
    {
        $This.Reinstantiate()
        $This.StageXaml()
        $This.Invoke()
    }
    [String] ToString()
    {
        Return "<Q3ALive.Master>"
    }
}

<# 
    [Todo]:
    - Rewrite map class so that Q3ALiveMaster orchestrates (levelshot + preview) image update from dependency for ImageMagick
    - Update button for the Steam Project that updates the levelshot and pk3 files
    - Map panel
      - Refresh button for properties and textures
      - Add to [shaderlist.txt] when a new (*.shader) is detected
    - Refresh button for output panels
#>

$Ctrl      = [Q3ALiveMaster]::New()
$Ctrl.Reload()
