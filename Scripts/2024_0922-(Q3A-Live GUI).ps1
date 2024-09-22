Import-Module FightingEntropy

Class Q3ALiveXaml
{
    Static [String] $Content = @(
    '<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"',
    '        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"',
    '        Title="[Q3A-Live]://Map Development Kit"',
    '        Height="550"',
    '        Width="650"',
    '        ResizeMode="NoResize"',
    '        Icon="C:\ProgramData\Secure Digits Plus LLC\FightingEntropy\2024.1.0\Graphics\icon.ico"',
    '        HorizontalAlignment="Center"',
    '        WindowStartupLocation="CenterScreen"',
    '        FontFamily="Consolas"',
    '        Background="Gray">',
    '    <Window.Resources>',
    '        <Style x:Key="DropShadow">',
    '            <Setter Property="TextBlock.Effect">',
    '                <Setter.Value>',
    '                    <DropShadowEffect ShadowDepth="1"/>',
    '                </Setter.Value>',
    '            </Setter>',
    '        </Style>',
    '        <Style TargetType="ToolTip">',
    '            <Setter Property="Background" Value="#000000"/>',
    '            <Setter Property="Foreground" Value="#66D066"/>',
    '            <Setter Property="FontFamily" Value="Consolas"/>',
    '            <Setter Property="FontWeight" Value="SemiBold"/>',
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
    '                            <Trigger Property="IsSelected"',
    '                                     Value="True">',
    '                                <Setter TargetName="Border"',
    '                                        Property="Background"',
    '                                        Value="#4444FF"/>',
    '                                <Setter Property="Foreground"',
    '                                        Value="#FFFFFF"/>',
    '                            </Trigger>',
    '                            <Trigger Property="IsSelected"',
    '                                     Value="False">',
    '                                <Setter TargetName="Border"',
    '                                        Property="Background"',
    '                                        Value="#DFFFBA"/>',
    '                                <Setter Property="Foreground"',
    '                                        Value="#000000"/>',
    '                            </Trigger>',
    '                            <Trigger Property="IsEnabled"',
    '                                     Value="True">',
    '                                <Setter Property="Opacity"',
    '                                        Value="1"/>',
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
    '        <Style TargetType="Button">',
    '            <Setter Property="Margin" Value="5"/>',
    '            <Setter Property="Padding" Value="5"/>',
    '            <Setter Property="FontWeight" Value="Heavy"/>',
    '            <Setter Property="Foreground" Value="Black"/>',
    '            <Setter Property="Background" Value="#DFFFBA"/>',
    '            <Setter Property="BorderThickness" Value="2"/>',
    '            <Setter Property="VerticalContentAlignment" Value="Center"/>',
    '            <Style.Resources>',
    '                <Style TargetType="Border">',
    '                    <Setter Property="CornerRadius" Value="5"/>',
    '                </Style>',
    '            </Style.Resources>',
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
    '            <Setter Property="Foreground" Value="#000000"/>',
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
    '            <Setter Property="Margin" Value="4"/>',
    '            <Setter Property="Height" Value="24"/>',
    '            <Style.Resources>',
    '                <Style TargetType="Border">',
    '                    <Setter Property="CornerRadius" Value="2"/>',
    '                </Style>',
    '            </Style.Resources>',
    '        </Style>',
    '        <Style x:Key="xTextBlock" TargetType="TextBlock">',
    '            <Setter Property="TextWrapping"',
    '                    Value="WrapWithOverflow"/>',
    '            <Setter Property="FontFamily"',
    '                    Value="Consolas"/>',
    '            <Setter Property="FontWeight"',
    '                    Value="Heavy"/>',
    '            <Setter Property="Background"',
    '                    Value="#000000"/>',
    '            <Setter Property="Foreground"',
    '                    Value="#00FF00"/>',
    '        </Style>',
    '        <Style x:Key="rTextBlock" TargetType="TextBlock">',
    '            <Setter Property="HorizontalAlignment"',
    '                    Value="Right"/>',
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
    '        <Style TargetType="DataGrid">',
    '            <Setter Property="Margin"',
    '                        Value="5"/>',
    '            <Setter Property="AutoGenerateColumns"',
    '                        Value="False"/>',
    '            <Setter Property="AlternationCount"',
    '                        Value="2"/>',
    '            <Setter Property="HeadersVisibility"',
    '                        Value="Column"/>',
    '            <Setter Property="CanUserResizeRows"',
    '                        Value="False"/>',
    '            <Setter Property="CanUserAddRows"',
    '                        Value="False"/>',
    '            <Setter Property="IsReadOnly"',
    '                        Value="True"/>',
    '            <Setter Property="IsTabStop"',
    '                        Value="True"/>',
    '            <Setter Property="IsTextSearchEnabled"',
    '                        Value="True"/>',
    '            <Setter Property="SelectionMode"',
    '                        Value="Single"/>',
    '            <Setter Property="ScrollViewer.CanContentScroll"',
    '                        Value="True"/>',
    '            <Setter Property="ScrollViewer.VerticalScrollBarVisibility"',
    '                        Value="Auto"/>',
    '            <Setter Property="ScrollViewer.HorizontalScrollBarVisibility"',
    '                        Value="Auto"/>',
    '        </Style>',
    '        <Style x:Key="xDataGridRow"',
    '               TargetType="DataGridRow">',
    '            <Setter Property="VerticalAlignment"',
    '                    Value="Center"/>',
    '            <Setter Property="VerticalContentAlignment"',
    '                    Value="Center"/>',
    '            <Setter Property="TextBlock.VerticalAlignment"',
    '                    Value="Center"/>',
    '            <Setter Property="Height"',
    '                    Value="20"/>',
    '            <Setter Property="FontSize"',
    '                    Value="12"/>',
    '            <Setter Property="FontWeight"',
    '                    Value="Heavy"/>',
    '        </Style>',
    '        <Style TargetType="DataGridRow">',
    '            <Setter Property="VerticalAlignment"',
    '                        Value="Center"/>',
    '            <Setter Property="VerticalContentAlignment"',
    '                        Value="Center"/>',
    '            <Setter Property="TextBlock.VerticalAlignment"',
    '                        Value="Center"/>',
    '            <Setter Property="Height"',
    '                        Value="20"/>',
    '            <Setter Property="FontSize"',
    '                        Value="12"/>',
    '            <Style.Triggers>',
    '                <Trigger Property="AlternationIndex"',
    '                         Value="0">',
    '                    <Setter Property="Background"',
    '                            Value="White"/>',
    '                </Trigger>',
    '                <Trigger Property="AlternationIndex" Value="1">',
    '                    <Setter Property="Background"',
    '                            Value="#FFD6FFFB"/>',
    '                </Trigger>',
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
    '            <Setter Property="FontSize"   Value="10"/>',
    '            <Setter Property="FontWeight" Value="Normal"/>',
    '        </Style>',
    '        <Style TargetType="TabControl">',
    '            <Setter Property="TabStripPlacement" Value="Top"/>',
    '            <Setter Property="HorizontalContentAlignment" Value="Center"/>',
    '            <Setter Property="Background" Value="LightYellow"/>',
    '        </Style>',
    '        <Style TargetType="GroupBox">',
    '            <Setter Property="Foreground" Value="Black"/>',
    '            <Setter Property="Margin" Value="5"/>',
    '            <Setter Property="FontSize" Value="12"/>',
    '            <Setter Property="FontWeight" Value="Normal"/>',
    '        </Style>',
    '        <Style TargetType="Label">',
    '            <Setter Property="Margin" Value="5"/>',
    '            <Setter Property="FontWeight" Value="Bold"/>',
    '            <Setter Property="Background" Value="Black"/>',
    '            <Setter Property="Foreground" Value="White"/>',
    '            <Setter Property="BorderBrush" Value="Gray"/>',
    '            <Setter Property="BorderThickness" Value="2"/>',
    '            <Style.Resources>',
    '                <Style TargetType="Border">',
    '                    <Setter Property="CornerRadius" Value="5"/>',
    '                </Style>',
    '            </Style.Resources>',
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
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="100"/>',
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
    '                            <ColumnDefinition Width="80"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="25"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <Label Grid.Column="0"',
    '                               Style="{StaticResource LabelGray}"',
    '                               Content="Radiant:"/>',
    '                        <TextBox Grid.Column="1"',
    '                                 Name="RadiantPathText"/>',
    '                        <Image Grid.Column="2"',
    '                               Name="RadiantPathIcon"/>',
    '                        <Button Grid.Column="3"',
    '                               Name="RadiantPathBrowse"',
    '                                Content="Browse"',
    '                                ToolTip="Open folder dialog to select *Radiant path"/>',
    '                        <Button Grid.Column="4"',
    '                                Name="RadiantPathApply"',
    '                                Content="Apply"',
    '                                ToolTip="If path is valid, assign it to access *Radiant tools"/>',
    '                    </Grid>',
    '                    <DataGrid Grid.Row="2"',
    '                              Name="RadiantProperty"',
    '                              HeadersVisibility="None"',
    '                              SelectionMode="Single">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="&lt;FEModule.Console.Item&gt;"',
    '                                               TextWrapping="Wrap"',
    '                                               FontFamily="Consolas"',
    '                                               Background="#000000"',
    '                                               Foreground="#00FF00"/>',
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
    '                        <RowDefinition Height="*"/>',
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
    '                    </Grid>',
    '                    <Border Grid.Row="1"',
    '                            Style="{StaticResource Line}"/>',
    '                    <TabControl Grid.Row="2">',
    '                        <TabItem Header="Log">',
    '                            <Grid>',
    '                                <Grid.RowDefinitions>',
    '                                    <RowDefinition Height="40"/>',
    '                                    <RowDefinition Height="*"/>',
    '                                </Grid.RowDefinitions>',
    '                                <Grid Grid.Row="0">',
    '                                    <Grid.ColumnDefinitions>',
    '                                        <ColumnDefinition Width="80"/>',
    '                                        <ColumnDefinition Width="*"/>',
    '                                        <ColumnDefinition Width="70"/>',
    '                                    </Grid.ColumnDefinitions>',
    '                                    <Label Grid.Column="0"',
    '                                           Content="Path:"',
    '                                           Style="{StaticResource LabelRed}"/>',
    '                                    <TextBox Grid.Column="1"',
    '                                             Name="WorkspaceLogPathText"/>',
    '                                    <CheckBox Grid.Column="2"',
    '                                              Name="WorkspaceLogPathExists"',
    '                                              Content="Exists"',
    '                                              HorizontalAlignment="Center"/>',
    '                                </Grid>',
    '                                <DataGrid Grid.Row="1"',
    '                                          Name="WorkspaceLogContent"',
    '                                          HeadersVisibility="None"',
    '                                          SelectionMode="Single">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="&lt;Q3ALive.Workspace.Log.Content&gt;"',
    '                                                                       TextWrapping="Wrap"',
    '                                                                       FontFamily="Consolas"',
    '                                                                       Background="#000000"',
    '                                                                       Foreground="#00FF00"/>',
    '                                                        </Setter.Value>',
    '                                                    </Setter>',
    '                                                </Trigger>',
    '                                            </Style.Triggers>',
    '                                        </Style>',
    '                                    </DataGrid.RowStyle>',
    '                                    <DataGrid.Columns>',
    '                                        <DataGridTextColumn Header="Index"',
    '                                                            Binding="{Binding Index}"',
    '                                                            Width="40"/>',
    '                                        <DataGridTextColumn Header="Line"',
    '                                                            Binding="{Binding Line}"',
    '                                                            Width="*"/>',
    '                                    </DataGrid.Columns>',
    '                                </DataGrid>',
    '                            </Grid>',
    '                        </TabItem>',
    '                        <TabItem Header="Output">',
    '                            <DataGrid Name="WorkspaceOutput"',
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
    '                        </TabItem>',
    '                    </TabControl>',
    '                </Grid>',
    '            </TabItem>',
    '            <TabItem Header="Map"',
    '                     Name="MapTab"',
    '                     ToolTip="Controls to compile, package, and publish map assets">',
    '                <Grid>',
    '                    <Grid.RowDefinitions>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="10"/>',
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
    '                    <TabControl Grid.Row="2">',
    '                        <TabItem Header="Details">',
    '                            <Grid>',
    '                                <Grid.RowDefinitions>',
    '                                    <RowDefinition Height="80"/>',
    '                                    <RowDefinition Height="*"/>',
    '                                </Grid.RowDefinitions>',
    '                                <DataGrid Grid.Row="0"',
    '                                      Name="MapDetails"',
    '                                      HeadersVisibility="None"',
    '                                      SelectionMode="Single">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="&lt;Q3ALive.Map.Detail&gt;"',
    '                                                                       TextWrapping="Wrap"',
    '                                                                       FontFamily="Consolas"',
    '                                                                       Background="#000000"',
    '                                                                       Foreground="#00FF00"/>',
    '                                                        </Setter.Value>',
    '                                                    </Setter>',
    '                                                </Trigger>',
    '                                            </Style.Triggers>',
    '                                        </Style>',
    '                                    </DataGrid.RowStyle>',
    '                                    <DataGrid.Columns>',
    '                                        <DataGridTextColumn Header="Name"',
    '                                                        Binding="{Binding Name}"',
    '                                                        Width="60"/>',
    '                                        <DataGridTextColumn Header="Value"',
    '                                                        Binding="{Binding Value}"',
    '                                                        Width="*"/>',
    '                                    </DataGrid.Columns>',
    '                                </DataGrid>',
    '                            </Grid>',
    '                        </TabItem>',
    '                        <TabItem Header="Levelshot">',
    '                            <Grid>',
    '                                <Grid.RowDefinitions>',
    '                                    <RowDefinition Height="40"/>',
    '                                    <RowDefinition Height="*"/>',
    '                                </Grid.RowDefinitions>',
    '                                <Grid Grid.Row="0">',
    '                                    <Grid.ColumnDefinitions>',
    '                                        <ColumnDefinition Width="70"/>',
    '                                        <ColumnDefinition Width="*"/>',
    '                                        <ColumnDefinition Width="70"/>',
    '                                        <ColumnDefinition Width="70"/>',
    '                                    </Grid.ColumnDefinitions>',
    '                                    <Label Grid.Column="0"',
    '                                           Content="Path:"',
    '                                           Style="{StaticResource LabelRed}"/>',
    '                                    <TextBox Grid.Column="1"',
    '                                             Name="MapLevelshotPath"/>',
    '                                    <CheckBox Grid.Column="2"',
    '                                              Name="MapLevelshotExists"',
    '                                              Content="Exists"',
    '                                              HorizontalAlignment="Center"/>',
    '                                    <Button Grid.Column="3"',
    '                                              Name="MapLevelshotImport"',
    '                                              Content="Import"',
    '                                            ToolTip="Open a file dialog to select OR replace a valid levelshot image"/>',
    '                                </Grid>',
    '                                <Image Grid.Row="1"',
    '                                       Name="MapLevelshotImage"/>',
    '                            </Grid>',
    '                        </TabItem>',
    '                        <TabItem Header="Arena">',
    '                            <Grid>',
    '                                <Grid.RowDefinitions>',
    '                                    <RowDefinition Height="40"/>',
    '                                    <RowDefinition Height="*"/>',
    '                                </Grid.RowDefinitions>',
    '                                <Grid Grid.Row="0">',
    '                                    <Grid.ColumnDefinitions>',
    '                                        <ColumnDefinition Width="70"/>',
    '                                        <ColumnDefinition Width="*"/>',
    '                                        <ColumnDefinition Width="70"/>',
    '                                        <ColumnDefinition Width="70"/>',
    '                                    </Grid.ColumnDefinitions>',
    '                                    <Label Grid.Column="0"',
    '                                           Content="Path:"',
    '                                           Style="{StaticResource LabelRed}"/>',
    '                                    <TextBox Grid.Column="1"',
    '                                             Name="MapArenaPath"/>',
    '                                    <CheckBox Grid.Column="2"',
    '                                              Name="MapArenaExists"',
    '                                              Content="Exists"',
    '                                              HorizontalAlignment="Center"/>',
    '                                    <Button Grid.Column="3"',
    '                                            Name="MapArenaApply"',
    '                                            Content="Apply"',
    '                                            ToolTip="Write the (*.arena) content below to file"/>',
    '                                </Grid>',
    '                                <TextBox Grid.Row="1"',
    '                                         Name="MapArenaContent"',
    '                                         Height="240"',
    '                                         Padding="2"',
    '                                         VerticalAlignment="Top"',
    '                                         VerticalContentAlignment="Top"',
    '                                         HorizontalScrollBarVisibility="Auto"/>',
    '                            </Grid>',
    '                        </TabItem>',
    '                        <TabItem Header="Shader">',
    '                            <Grid>',
    '                                <Grid.RowDefinitions>',
    '                                    <RowDefinition Height="40"/>',
    '                                    <RowDefinition Height="*"/>',
    '                                </Grid.RowDefinitions>',
    '                                <Grid Grid.Row="0">',
    '                                    <Grid.ColumnDefinitions>',
    '                                        <ColumnDefinition Width="70"/>',
    '                                        <ColumnDefinition Width="*"/>',
    '                                        <ColumnDefinition Width="70"/>',
    '                                        <ColumnDefinition Width="70"/>',
    '                                    </Grid.ColumnDefinitions>',
    '                                    <Label Grid.Column="0"',
    '                                           Content="Path:"',
    '                                           Style="{StaticResource LabelRed}"/>',
    '                                    <TextBox Grid.Column="1"',
    '                                             Name="MapShaderPath"/>',
    '                                    <CheckBox Grid.Column="2"',
    '                                              Name="MapShaderExists"',
    '                                              Content="Exists"',
    '                                              HorizontalAlignment="Center"/>',
    '                                    <Button Grid.Column="3"',
    '                                              Name="MapShaderApply"',
    '                                              Content="Apply"',
    '                                            ToolTip="Write the (*.shader) content below to file"/>',
    '                                </Grid>',
    '                                <TextBox Grid.Row="1"',
    '                                         Name="MapShaderContent"',
    '                                         Height="240"',
    '                                         Padding="2"',
    '                                         VerticalAlignment="Top"',
    '                                         VerticalContentAlignment="Top"',
    '                                         HorizontalScrollBarVisibility="Auto"/>',
    '                            </Grid>',
    '                        </TabItem>',
    '                        <TabItem Header="Output">',
    '                            <DataGrid Name="MapOutput"',
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
    '                        </TabItem>',
    '                    </TabControl>',
    '                    <Grid Grid.Row="3">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <Button Grid.Column="0"',
    '                                Name="MapCompile"',
    '                                Content="Compile (*.map)"',
    '                                ToolTip="Compile the (*.map) file into (*.bsp) + (*.aas) files"/>',
    '                        <Button Grid.Column="1"',
    '                                Name="MapPackage"',
    '                                Content="Generate (*.pk3)"',
    '                                ToolTip="Generate a (*.pk3) based on all files in map asset folder"/>',
    '                        <Button Grid.Column="2"',
    '                                Name="MapTransfer"',
    '                                Content="Transfer (*.pk3)"',
    '                                ToolTip="Transfer the (*.pk3) to Q3A + QL base directories to (compile/playtest)"/>',
    '                        <Button Grid.Column="3"',
    '                                Name="MapPublish"',
    '                                Content="Publish (*.pk3)"',
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
    '                        <RowDefinition Height="10"/>',
    '                        <RowDefinition Height="*"/>',
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
    '                               Content="Path:"',
    '                               Style="{StaticResource LabelRed}"/>',
    '                        <TextBox Grid.Column="1"',
    '                                 Name="SteamPathText"/>',
    '                        <Image Grid.Column="2"',
    '                               Name="SteamPathIcon"/>',
    '                        <Button Grid.Column="3"',
    '                               Name="SteamPathBrowse"',
    '                                Content="Browse"',
    '                                ToolTip="Open a folder dialog to select SteamCmd folder location"/>',
    '                        <Button Grid.Column="4"',
    '                                Name="SteamPathApply"',
    '                                Content="Apply"',
    '                                ToolTip="If valid, assigns the path to access Steam controls"/>',
    '                    </Grid>',
    '                    <Border Grid.Row="1"',
    '                            Style="{StaticResource Line}"/>',
    '                    <TabControl Grid.Row="2">',
    '                        <TabItem Header="Credential">',
    '                            <Grid>',
    '                                <Grid.RowDefinitions>',
    '                                    <RowDefinition Height="40"/>',
    '                                    <RowDefinition Height="40"/>',
    '                                    <RowDefinition Height="40"/>',
    '                                </Grid.RowDefinitions>',
    '                                <Grid Grid.Row="0">',
    '                                    <Grid.ColumnDefinitions>',
    '                                        <ColumnDefinition Width="80"/>',
    '                                        <ColumnDefinition Width="*"/>',
    '                                        <ColumnDefinition Width="25"/>',
    '                                        <ColumnDefinition Width="70"/>',
    '                                        <ColumnDefinition Width="70"/>',
    '                                    </Grid.ColumnDefinitions>',
    '                                    <Label Grid.Column="0"',
    '                                           Content="Path:"',
    '                                           Style="{StaticResource LabelRed}"/>',
    '                                    <TextBox Grid.Column="1"',
    '                                             Name="SteamCredentialPathText"/>',
    '                                    <Image Grid.Column="2"',
    '                                           Name="SteamCredentialPathIcon"/>',
    '                                    <Button Grid.Column="3"',
    '                                            Name="SteamCredentialPathBrowse"',
    '                                            Content="Browse"',
    '                                            ToolTip="Open a file dialog to import an XML credential"/>',
    '                                    <Button Grid.Column="4"',
    '                                            Name="SteamCredentialPathApply"',
    '                                            Content="Apply"',
    '                                            ToolTip="If valid, will utilize the XML credential to populate Steam username + password"/>',
    '                                </Grid>',
    '                                <Grid Grid.Row="1">',
    '                                    <Grid.ColumnDefinitions>',
    '                                        <ColumnDefinition Width="80"/>',
    '                                        <ColumnDefinition Width="*"/>',
    '                                        <ColumnDefinition Width="80"/>',
    '                                        <ColumnDefinition Width="*"/>',
    '                                    </Grid.ColumnDefinitions>',
    '                                    <Label Grid.Column="0"',
    '                                           Content="User:"',
    '                                           Style="{StaticResource LabelGray}"/>',
    '                                    <TextBox Grid.Column="1"',
    '                                             Name="SteamCredentialUsername"/>',
    '                                    <Label Grid.Column="2"',
    '                                           Content="Pass:"',
    '                                           Style="{StaticResource LabelGray}"/>',
    '                                    <PasswordBox Grid.Column="3"',
    '                                             Name="SteamCredentialPassword"/>',
    '                                </Grid>',
    '                            </Grid>',
    '                        </TabItem>',
    '                        <TabItem Header="Workshop">',
    '                            <Grid>',
    '                                <Grid.RowDefinitions>',
    '                                    <RowDefinition Height="40"/>',
    '                                    <RowDefinition Height="50"/>',
    '                                    <RowDefinition Height="*"/>',
    '                                    <RowDefinition Height="40"/>',
    '                                </Grid.RowDefinitions>',
    '                                <Grid Grid.Row="0">',
    '                                    <Grid.ColumnDefinitions>',
    '                                        <ColumnDefinition Width="70"/>',
    '                                        <ColumnDefinition Width="*"/>',
    '                                        <ColumnDefinition Width="25"/>',
    '                                        <ColumnDefinition Width="70"/>',
    '                                        <ColumnDefinition Width="70"/>',
    '                                    </Grid.ColumnDefinitions>',
    '                                    <Label Grid.Column="0"',
    '                                           Content="Path:"',
    '                                           Style="{StaticResource LabelRed}"/>',
    '                                    <TextBox Grid.Column="1"',
    '                                             Name="SteamWorkshopPathText"/>',
    '                                    <Image Grid.Column="2"',
    '                                           Name="SteamWorkshopPathIcon"/>',
    '                                    <Button Grid.Column="3"',
    '                                            Name="SteamWorkshopPathBrowse"',
    '                                            Content="Browse"',
    '                                            ToolTip="Open a folder dialog to select a Steam Workshop project folder"/>',
    '                                    <Button Grid.Column="4"',
    '                                            Name="SteamWorkshopPathApply"',
    '                                            Content="Apply"',
    '                                            ToolTip="If valid, assign the workshop path to access nested project controls"/>',
    '                                </Grid>',
    '                                <DataGrid Grid.Row="1"',
    '                                          Name="SteamWorkshopOutput"',
    '                                          SelectionMode="Single">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="&lt;Steam.Workshop.Item&gt;"',
    '                                                                       TextWrapping="Wrap"',
    '                                                                       FontFamily="Consolas"',
    '                                                                       Background="#000000"',
    '                                                                       Foreground="#00FF00"/>',
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
    '                                <TabControl Grid.Row="2">',
    '                                    <TabItem Header="Details">',
    '                                        <DataGrid Grid.Column="0"',
    '                                                  Name="SteamProjectDetails"',
    '                                                  HeadersVisibility="None"',
    '                                                  SelectionMode="Single">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="&lt;Steam.Workshop.Project.Detail&gt;"',
    '                                                                               TextWrapping="Wrap"',
    '                                                                               FontFamily="Consolas"',
    '                                                                               Background="#000000"',
    '                                                                               Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="Name"',
    '                                                                    Binding="{Binding Name}"',
    '                                                                    Width="120"/>',
    '                                                <DataGridTextColumn Header="Value"',
    '                                                                    Binding="{Binding Value}"',
    '                                                                    Width="*"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                    </TabItem>',
    '                                    <TabItem Header="Preview">',
    '                                        <Grid>',
    '                                            <Grid.RowDefinitions>',
    '                                                <RowDefinition Height="40"/>',
    '                                                <RowDefinition Height="*"/>',
    '                                            </Grid.RowDefinitions>',
    '                                            <Grid Grid.Row="0">',
    '                                                <Grid.ColumnDefinitions>',
    '                                                    <ColumnDefinition Width="70"/>',
    '                                                    <ColumnDefinition Width="*"/>',
    '                                                    <ColumnDefinition Width="70"/>',
    '                                                    <ColumnDefinition Width="70"/>',
    '                                                </Grid.ColumnDefinitions>',
    '                                                <Label Grid.Column="0"',
    '                                                       Content="Path:"',
    '                                                       Style="{StaticResource LabelRed}"/>',
    '                                                <TextBox Grid.Column="1"',
    '                                                         Name="SteamProjectPreviewPathText"/>',
    '                                                <CheckBox Grid.Column="2"',
    '                                                          Name="SteamProjectPreviewExists"',
    '                                                          Content="Exists"',
    '                                                          HorizontalAlignment="Center"/>',
    '                                                <Button Grid.Column="3"',
    '                                                        Name="SteamProjectPreviewImport"',
    '                                                        Content="Import"',
    '                                                        ToolTip="Assign or overwrite the Steam Workshop preview image"/>',
    '                                            </Grid>',
    '                                            <Image Grid.Row="1"',
    '                                                   Name="SteamProjectPreviewImage"/>',
    '                                        </Grid>',
    '                                    </TabItem>',
    '                                    <TabItem Header="Vdf">',
    '                                        <Grid>',
    '                                            <Grid.RowDefinitions>',
    '                                                <RowDefinition Height="40"/>',
    '                                                <RowDefinition Height="*"/>',
    '                                            </Grid.RowDefinitions>',
    '                                            <Grid Grid.Row="0">',
    '                                                <Grid.ColumnDefinitions>',
    '                                                    <ColumnDefinition Width="70"/>',
    '                                                    <ColumnDefinition Width="*"/>',
    '                                                    <ColumnDefinition Width="70"/>',
    '                                                    <ColumnDefinition Width="70"/>',
    '                                                </Grid.ColumnDefinitions>',
    '                                                <Label Grid.Column="0"',
    '                                                       Content="Path:"',
    '                                                       Style="{StaticResource LabelRed}"/>',
    '                                                <TextBox Grid.Column="1"',
    '                                                         Name="SteamProjectVdfPathText"/>',
    '                                                <CheckBox Grid.Column="2"',
    '                                                          Name="SteamProjectVdfExists"',
    '                                                          Content="Exists"',
    '                                                          HorizontalAlignment="Center"/>',
    '                                                <Button Grid.Column="3"',
    '                                                        Name="SteamProjectVdfApply"',
    '                                                        Content="Apply"',
    '                                                        ToolTip="Write the (*.vdf) content below to file"/>',
    '                                            </Grid>',
    '                                            <TextBox Grid.Row="1"',
    '                                                     Name="SteamProjectVdfContent"',
    '                                                     Height="160"',
    '                                                     Padding="2"',
    '                                                     VerticalAlignment="Top"',
    '                                                     VerticalContentAlignment="Top"',
    '                                                     HorizontalScrollBarVisibility="Auto"/>',
    '                                        </Grid>',
    '                                    </TabItem>',
    '                                    <TabItem Header="Output">',
    '                                        <DataGrid Name="SteamProjectOutput"',
    '                                                  SelectionMode="Single">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="{Binding Fullname}"',
    '                                                                               TextWrapping="Wrap"',
    '                                                                               FontFamily="Consolas"',
    '                                                                               Background="#000000"',
    '                                                                               Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="Type"',
    '                                                                    Binding="{Binding Type}"',
    '                                                                    Width="70"/>',
    '                                                <DataGridTextColumn Header="Date"',
    '                                                                    Binding="{Binding Date}"',
    '                                                                    Width="135"/>',
    '                                                <DataGridTextColumn Header="Name"',
    '                                                                    Binding="{Binding Name}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridTextColumn Header="Length"',
    '                                                                    Binding="{Binding Length}"',
    '                                                                    Width="70"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                    </TabItem>',
    '                                </TabControl>',
    '                                <Grid Grid.Row="3">',
    '                                    <Grid.ColumnDefinitions>',
    '                                        <ColumnDefinition Width="*"/>',
    '                                        <ColumnDefinition Width="*"/>',
    '                                        <ColumnDefinition Width="*"/>',
    '                                    </Grid.ColumnDefinitions>',
    '                                    <Button Grid.Column="0"',
    '                                            Name="SteamProjectCreate"',
    '                                            Content="Create"/>',
    '                                    <Button Grid.Column="1"',
    '                                            Name="SteamProjectRemove"',
    '                                            Content="Remove"/>',
    '                                    <Button Grid.Column="2"',
    '                                            Name="SteamProjectUpload"',
    '                                            Content="Upload"/>',
    '                                </Grid>',
    '                            </Grid>',
    '                        </TabItem>',
    '                    </TabControl>',
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
    '                            <ColumnDefinition Width="80"/>',
    '                            <ColumnDefinition Width="120"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="90"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <Label Grid.Column="0"',
    '                               Content="Search:"',
    '                               Style="{StaticResource LabelRed}"',
    '                               HorizontalContentAlignment="Left"/>',
    '                        <ComboBox Grid.Column="1"',
    '                                  Name="ConsoleProperty"',
    '                                  SelectedIndex="3">',
    '                            <ComboBoxItem Content="Index"/>',
    '                            <ComboBoxItem Content="Elapsed"/>',
    '                            <ComboBoxItem Content="State"/>',
    '                            <ComboBoxItem Content="Status"/>',
    '                        </ComboBox>',
    '                        <TextBox Grid.Column="2"',
    '                                 Name="ConsoleFilter"/>',
    '                        <Button  Grid.Column="3"',
    '                                 Name="ConsoleRefresh"',
    '                                 Content="Refresh"/>',
    '                    </Grid>',
    '                    <DataGrid Grid.Row="2"',
    '                              Name="ConsoleOutput"',
    '                              SelectionMode="Extended">',
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
    '                                                Width="50"/>',
    '                            <DataGridTextColumn Header="Elapsed"',
    '                                                Binding="{Binding Elapsed}"',
    '                                                Width="125"/>',
    '                            <DataGridTextColumn Header="State"',
    '                                                Binding="{Binding State}"',
    '                                                Width="50"/>',
    '                            <DataGridTextColumn Header="Status"',
    '                                                Binding="{Binding Status}"',
    '                                                Width="*"/>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <Grid Grid.Row="3">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="80"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="25"/>',
    '                            <ColumnDefinition Width="90"/>',
    '                            <ColumnDefinition Width="90"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <Label Grid.Column="0"',
    '                               Content="Path:"',
    '                               Style="{StaticResource LabelGray}"',
    '                               HorizontalContentAlignment="Left"/>',
    '                        <TextBox Grid.Column="1"',
    '                                 Name="ConsolePath"/>',
    '                        <Image Grid.Column="2"',
    '                               Name="ConsolePathIcon"/>',
    '                        <Button Grid.Column="3"',
    '                                Name="ConsoleBrowse"',
    '                                Content="Browse"/>',
    '                        <Button Grid.Column="4"',
    '                                Name="ConsoleSave"',
    '                                Content="Save"/>',
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
        Return "<FEModule.XamlWindow[VmControllerXaml]>"
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
        $This.Log      = $This.Q3ALiveScript("Log","$($This.Path)\workspace.log")
        $This.Refresh()
    }
    [Object] Q3ALiveScript([String]$Type,[String]$Path)
    {
        Return [Q3ALiveScript]::New($Type,[String]$Path)
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
    CheckLog()
    {
        If (![System.IO.File]::Exists($This.Log.Path))
        {
            $Content = "[Workspace log file, created $([DateTime]::Now.ToString("MM/dd/yyyy HH:mm:ss"))]",
            $This.LogHeader()
            [System.IO.File]::WriteAllLines($This.Log.Path,$Content)
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

Class Q3ALiveMap
{
    [String]      $Name
    [String]      $Path
    [String]    $Source
    [String]    $Target
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

        [Console]::WriteLine("Found [+] Map assets: [$($This.Name)], ($($This.Output.Count)) item(s)")

        $This.GetArena()     > $Null
        $This.GetShader()    > $Null
        $This.GetLevelshot() > $Null
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
    LoadXml([String]$XmlPath)
    {
        If (![System.IO.File]::Exists($XmlPath))
        {
            Throw "Invalid target"
        }

        $This.SetCredential($XmlPath)
    }
    SetCredential([String]$Path)
    {
        $This.Credential = $This.SteamWorkshopCredential($Path)
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
    [Object]         $Module
    [Object]           $Xaml
    [Object]      $Component
    [Object]        $Radiant
    [Object]      $Workspace
    [Object]            $Map
    [Object]          $Steam
    Hidden [DateTime] $Start
    Hidden [String]   $Color
    Q3ALiveMaster()
    {
        $This.Module = $This.GetModule()
        $This.Color  = [Console]::ForegroundColor
        $This.Refresh()
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
        $xPath = "{0}\{1}-{2}.log" -f $This.LogPath(), $This.Now(), $This.Name
        $This.Update(100,"[+] Dumping console: [$xPath]")
        $This.Console.Finalize()
        
        $Value = $This.Console.Output | % ToString

        [System.IO.File]::WriteAllLines($xPath,$Value)
    }
    [String] LogPath()
    {
        $xPath = $This.ProgramData()

        ForEach ($Folder in $This.Author(), "Logs")
        {
            $xPath = $xPath, $Folder -join "\"
            If (![System.IO.Directory]::Exists($xPath))
            {
                [System.IO.Directory]::CreateDirectory($xPath)
            }
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
    ReleaseMap()
    {
        $This.Map = $Null
    }
    SetSteam([String]$Path)
    {
        If (![System.IO.Directory]::Exists($Path))
        {
            Throw "Exception [!] Invalid directory"
        }
        ElseIf ("steamcmd.exe" -notin $This.GetFiles($Path).Name)
        {
            Throw "Exception [!] SteamCmd not found"
        }
        Else
        {
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
    SetLevelshot([String]$Path)
    {
        $This.Map.SetLevelshot($Path)
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
            $Writer   = [System.IO.File]::AppendText($This.Workspace.Log.Path)
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

        ForEach ($Item in $This.Live().Base, $This.Q3A().Base)
        {
            $Destination = "{0}\{1}" -f $Item, ($This.Map.Target | Split-Path -Leaf)

            [System.IO.File]::Copy($This.Map.Target,$Destination,$True)

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
    Reinstantiate()
    {
        # Loads XAML
        $This.Xaml       = $This.GetQ3ALiveXaml()
    }
    [Object[]] Property([Object]$Object)
    {
        Return $Object.PSObject.Properties | % { $This.Q3ALiveProperty($_) }
    }
    RadiantPathText()
    {
        $Ctrl                    = $This

        $Text                    = $Ctrl.Xaml.Get("RadiantPathText")
        $Icon                    = $Ctrl.Xaml.Get("RadiantPathIcon")
        $Apply                   = $Ctrl.Xaml.Get("RadiantPathApply")

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
    RadiantPathBrowse()
    {
        $This.Update(0,"Browsing [~] Folder: [Radiant]")

        $Dialog      = [System.Windows.Forms.FolderBrowserDialog]::New()

        $Dialog.ShowDialog()

        $This.Xaml.IO.RadiantPathText.Text = @("<not set>",$Dialog.SelectedPath)[!!$Dialog.SelectedPath]
    }
    RadiantPathApply()
    {
        $This.SetRadiant($This.Xaml.IO.RadiantPathText.Text)
        $This.Reset($This.Xaml.IO.RadiantProperty,$This.Property($This.Radiant))

        $This.Xaml.IO.RadiantPathText.IsEnabled    = 0
        $This.Xaml.IO.RadiantPathBrowse.IsEnabled  = 0
        $This.Xaml.IO.RadiantPathApply.IsEnabled   = 0
        $This.Xaml.IO.WorkspaceTab.IsEnabled       = 1
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
        $This.SetWorkspace($This.Xaml.IO.WorkspacePathText.Text)

        $This.Xaml.IO.WorkspacePathText.IsEnabled      = 0
        $This.Xaml.IO.WorkspacePathBrowse.IsEnabled    = 0
        $This.Xaml.IO.WorkspacePathApply.IsEnabled     = 0
        $This.Xaml.IO.MapTab.IsEnabled                 = 1

        $This.Xaml.IO.WorkspaceLogPathText.Text        = $This.Workspace.Log.Path
        $This.Xaml.IO.WorkspaceLogPathExists.IsChecked = $This.Workspace.Log.Exists
        $This.Reset($This.Xaml.IO.WorkspaceLogContent,$This.Workspace.Log.Content)

        $This.Reset($This.Xaml.IO.WorkspaceOutput,$This.Workspace.Output)
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
    }
    MapNameClear()
    {
        $This.ReleaseMap()
        $This.Initial("Map")

        $This.Xaml.IO.MapTab.IsEnabled                 = 1
        $This.Xaml.IO.MapNameText.IsEnabled            = 1
    }
    MapLevelshotLoad([String]$Path)
    {
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
        $This.Update(0,"Import [~] Levelshot")

        $Dialog = [System.Windows.Forms.OpenFileDialog]::New()

        $Dialog.InitialDirectory = $Env:SystemDrive
        $Dialog.Filter           = "jpg (*.jpg)|*.jpg|tga (*.tga)|*.tga|png (*.png)|*.png"

        $Dialog.ShowDialog()

        If ($Dialog.Filename)
        {
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
        $This.SetArena($This.Xaml.IO.MapArenaContent.Text)
        $This.Map.Arena.SetContent()
        $This.Map.Refresh()
    }
    MapShaderApply()
    {
        $This.SetShader($This.Xaml.IO.MapShaderContent.Text)
        $This.Map.Shader.SetContent()
        $This.Map.Refresh()
    }
    MapCompile()
    {
        If ([System.IO.File]::Exists($This.Map.Source))
        {
            $This.Update(0,"Compiling [~] File: $($This.Map.Source)")
            $This.Compile()
        }
    }
    MapPackage()
    {
        If ($This.Map.Output.Count -gt 0)
        {
            $This.Update(0,"Packaging [~] File: $($This.Map.Target)")
            $This.Package()
        }
    }
    MapTransfer()
    {
        If ([System.IO.File]::Exists($This.Map.Target))
        {
            $This.Update(0,"Transferring [~] File: $($This.Map.Target)")
            $This.Transfer()
        }
    }
    MapPublish()
    {
        $This.Xaml.IO.SteamTab.IsEnabled = 1
    }
    SteamPathText()
    {
        $Ctrl                    = $This

        $Text                    = $Ctrl.Xaml.Get("SteamPathText")
        $Icon                    = $Ctrl.Xaml.Get("SteamPathIcon")
        $Apply                   = $Ctrl.Xaml.Get("SteamPathApply")

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
    SteamPathBrowse()
    {
        $This.Update(0,"Browsing [~] Folder: [Steamcmd]")

        $Dialog      = [System.Windows.Forms.FolderBrowserDialog]::New()

        $Dialog.ShowDialog()

        $This.Xaml.IO.SteamPathText.Text = @("<not set>",$Dialog.SelectedPath)[!!$Dialog.SelectedPath]
    }
    SteamPathApply()
    {
        $Ctrl = $This

        $Ctrl.SetSteam($Ctrl.Xaml.IO.SteamPathText.Text)

        $Ctrl.Xaml.IO.SteamPathText.IsEnabled      = 0
        $Ctrl.Xaml.IO.SteamPathBrowse.IsEnabled    = 0
        $Ctrl.Xaml.IO.SteamPathApply.IsEnabled     = 0

        $Ctrl.SteamGetCredential()
    }
    SteamGetCredential()
    {
        $This.Update(0,"Getting [~] Steam Credential path")

        $Ctrl = $This

        If (Test-Path $Ctrl.Steam.Q3ALive())
        {
            $Slot    = $Ctrl.Steam.List()
            If ($Slot.Count -gt 0)
            {
                $xTarget = "{0}\{1}" -f $Ctrl.Steam.Q3ALive(), $Slot[0]
                $xPath   = Get-ItemProperty $xTarget | % Workshop

                $Ctrl.Xaml.IO.SteamCredentialPathText.Text = $xPath
            }
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
        $This.Update(0,"Browsing [~] File: [Credential]")
    
        $Dialog = [System.Windows.Forms.OpenFileDialog]::New()

        $Dialog.InitialDirectory = $Env:SystemDrive
        $Dialog.Filter           = "xml (*.xml)"

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
        $Ctrl = $This

        If ([System.IO.File]::Exists($Ctrl.Xaml.IO.SteamCredentialPathText.Text))
        {
            $Ctrl.Steam.LoadXml($Ctrl.Xaml.IO.SteamCredentialPathText.Text)
            If ($Ctrl.Steam.Credential)
            {
                $Ctrl.Xaml.IO.SteamCredentialUsername.Text        = $Ctrl.Steam.Credential.Username
                $Ctrl.Xaml.IO.SteamCredentialPassword.Password    = $Ctrl.Steam.Credential.Password

                $Ctrl.Xaml.IO.SteamCredentialPathText.IsEnabled   = 0
                $Ctrl.Xaml.IO.SteamCredentialPathIcon.IsEnabled   = 0
                $Ctrl.Xaml.IO.SteamCredentialPathBrowse.IsEnabled = 0
                $Ctrl.Xaml.IO.SteamCredentialPathApply.IsEnabled  = 0
                $Ctrl.Xaml.IO.SteamCredentialUsername.IsEnabled   = 0
                $Ctrl.Xaml.IO.SteamCredentialPassword.IsEnabled   = 0
            }
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
        $This.Update(0,"Browsing [~] Folder: [Steam Workshop]")

        $Dialog              = [System.Windows.Forms.FolderBrowserDialog]::New()
        $Dialog.SelectedPath = $This.Steam.Path
        $Dialog.ShowDialog()

        $This.Xaml.IO.SteamWorkshopPathText.Text = @("<not set>",$Dialog.SelectedPath)[!!$Dialog.SelectedPath]
    }
    SteamWorkshopPathApply()
    {
        $Ctrl = $This

        $Ctrl.Steam.SetWorkshop($Ctrl.Xaml.IO.SteamWorkshopPathText.Text)

        $Ctrl.Xaml.IO.SteamWorkshopPathText.IsEnabled      = 0
        $Ctrl.Xaml.IO.SteamWorkshopPathBrowse.IsEnabled    = 0
        $Ctrl.Xaml.IO.SteamWorkshopPathApply.IsEnabled     = 0

        $Ctrl.Xaml.IO.SteamProjectCreate.IsEnabled         = 0
        $Ctrl.Xaml.IO.SteamProjectRemove.IsEnabled         = 0

        If ($Ctrl.Map.Name -notin $Ctrl.Steam.Project.Name)
        {
            $Ctrl.Steam.CreateProject($Ctrl.Map.Name)
            $Ctrl.Steam.GetProject()
        }

        $Selection = $Ctrl.Steam.Project | ? Name -match $Ctrl.Map.Name
        $Ctrl.Steam.SetSelection($Selection.Index)

        $Ctrl.SteamWorkshopProject()
    }
    SteamWorkshopProject()
    {
        $Ctrl    = $This

        $Current = $Ctrl.Steam.Current()
        $Current.Populate()

        $Ctrl.Reset($Ctrl.Xaml.IO.SteamWorkshopOutput,$Current)
        $Ctrl.Xaml.IO.SteamWorkshopOutput.IsEnabled      = 0

        # Details
        $Object = $Current.Vdf | Select-Object AppId, PublishedFileId, ContentFolder, PreviewFile, Visibility, Title, Description, ChangeNote
        $Ctrl.Reset($Ctrl.Xaml.IO.SteamProjectDetails,$Ctrl.Property($Object))
        $Ctrl.Xaml.IO.SteamProjectDetails.IsEnabled      = 1

        # Preview
        $Label     = "levelshots\\\w+\.jpg"
        $Levelshot = $Ctrl.Map.Output | ? Fullname -match $Label
        If ($Levelshot)
        {
            $Current.SetPreview($Levelshot.Fullname)
        }

        $Ctrl.Xaml.IO.SteamProjectPreviewPathText.Text      = $Current.Preview.Fullname
        $Ctrl.Xaml.IO.SteamProjectPreviewPathText.IsEnabled = 0

        $Ctrl.Xaml.IO.SteamProjectPreviewExists.IsChecked   = $Current.Preview.Exists
        $Ctrl.Xaml.IO.SteamProjectPreviewExists.IsEnabled   = 0

        $Ctrl.Xaml.IO.SteamProjectPreviewImport.IsEnabled   = 1

        $Ctrl.SteamProjectPreviewLoad($Current.Preview.Fullname)

        # Vdf
        $Ctrl.Xaml.IO.SteamProjectVdfPathText.Text       = $Current.Vdf.Fullname
        $Ctrl.Xaml.IO.SteamProjectVdfPathText.IsEnabled  = 0

        $Ctrl.Xaml.IO.SteamProjectVdfExists.IsChecked    = $Current.Vdf.Exists
        $Ctrl.Xaml.IO.SteamProjectVdfExists.IsEnabled    = 0

        $Ctrl.Xaml.IO.SteamProjectVdfApply.IsEnabled     = 1

        $Ctrl.Xaml.IO.SteamProjectVdfContent.IsEnabled   = 1

        If ($Current.Vdf.Exists)
        {
            $Ctrl.Xaml.IO.SteamProjectVdfContent.Text = [System.IO.File]::ReadAllLines($Current.Vdf.Fullname) -join "`n"
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

            $Ctrl.Xaml.IO.SteamProjectVdfContent.Text = [System.IO.File]::ReadAllLines($Current.Vdf.Fullname) -join "`n"
        }

        # Output
        $Ctrl.Reset($Ctrl.Xaml.IO.SteamProjectOutput,$Current.Content)

        $Ctrl.Xaml.IO.SteamProjectUpload.IsEnabled = [UInt32]($Current.Content.Count -ge 4)
    }
    SteamProjectVdfApply()
    {
        $Ctrl = $This

        $Current = $Ctrl.Steam.Current()

        $Current.UpdateVdf($Ctrl.Xaml.IO.SteamProjectVdfContent.Text)

        $Ctrl.SteamWorkshopProject()
    }
    SteamProjectPreviewLoad([String]$Path)
    {
        $This.Xaml.IO.SteamProjectPreviewImage.Source = $Null

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

        $This.Xaml.IO.SteamProjectPreviewImage.Source = $Bitmap
    }
    SteamProjectPreviewImport()
    {
        $This.Update(0,"Import [~] Levelshot")

        $Dialog = [System.Windows.Forms.OpenFileDialog]::New()

        $Dialog.InitialDirectory = $Env:SystemDrive
        $Dialog.Filter           = "jpg (*.jpg)|*.jpg"

        $Dialog.ShowDialog()

        If ($Dialog.Filename)
        {
            $Current = $This.Steam.Current()

            [System.IO.File]::Copy($Dialog.Filename,$Current.Preview.Fullname,$True)

            $This.SteamWorkshopProject()
        }
    }
    SteamProjectCreate()
    {
        $Ctrl = $This

        If ($Ctrl.Map.Name -notin $Ctrl.Steam.Project.Name)
        {
            $Ctrl.Steam.CreateProject($Ctrl.Map.Name)
            $Ctrl.Steam.GetProject()
        }

        $Ctrl.SteamWorkshopProject()
    }
    SteamProjectRemove()
    {
        $Ctrl = $This

        If ($Ctrl.Map.Name -in $Ctrl.Steam.Project.Name)
        {
            $Ctrl.Steam.RemoveProject($Ctrl.Map.Name)
            $Ctrl.Steam.GetProject()
        }
    }
    SteamProjectUpload()
    {
        $Ctrl = $This

        $Ctrl.Steam.UploadProject()
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
                # N/A
            }
            Radiant
            {
                $Ctrl.Xaml.IO.RadiantPathText.Add_TextChanged(
                {
                    $Ctrl.RadiantPathText()
                })

                $Ctrl.Xaml.IO.RadiantPathText.Add_GotFocus(
                {
                    $Text = Switch -Regex ($Ctrl.Xaml.IO.RadiantPathText.Text)
                    {
                        "(^$|^<not set>$)" 
                        {
                            ""
                        }
                        Default
                        { 
                            $Ctrl.Xaml.IO.RadiantPathText.Text
                        }
                    }

                    $Ctrl.Xaml.IO.RadiantPathText.Text = $Text
                })

                $Ctrl.Xaml.IO.RadiantPathText.Add_LostFocus(
                {
                    $Text = Switch -Regex ($Ctrl.Xaml.IO.RadiantPathText.Text)
                    {
                        "(^$|^<not set>$)" 
                        {
                            "<not set>"
                        }
                        Default
                        { 
                            $Ctrl.Xaml.IO.RadiantPathText.Text
                        }
                    }

                    $Ctrl.Xaml.IO.RadiantPathText.Text = $Text
                })

                $Ctrl.Xaml.IO.RadiantPathBrowse.Add_Click(
                {
                    $Ctrl.RadiantPathBrowse()
                })

                $Ctrl.Xaml.IO.RadiantPathApply.Add_Click(
                {
                    $Ctrl.RadiantPathApply()
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

                $Ctrl.Xaml.IO.MapNameApply.Add_Click(
                {
                    $Ctrl.MapNameApply()
                })

                $Ctrl.Xaml.IO.MapNameClear.Add_Click(
                {
                    $Ctrl.MapNameClear()
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

                $Ctrl.Xaml.IO.MapPublish.Add_Click(
                {
                    $Ctrl.MapPublish()
                })
            }
            Steam
            {
                $Ctrl.Xaml.IO.SteamPathText.Add_TextChanged(
                {
                    $Ctrl.SteamPathText()
                })

                $Ctrl.Xaml.IO.SteamPathText.Add_GotFocus(
                {
                    $Text = Switch -Regex ($Ctrl.Xaml.IO.SteamPathText.Text)
                    {
                        "(^$|^<not set>$)" 
                        {
                            ""
                        }
                        Default
                        { 
                            $Ctrl.Xaml.IO.SteamPathText.Text
                        }
                    }

                    $Ctrl.Xaml.IO.SteamPathText.Text = $Text
                })

                $Ctrl.Xaml.IO.SteamPathText.Add_LostFocus(
                {
                    $Text = Switch -Regex ($Ctrl.Xaml.IO.SteamPathText.Text)
                    {
                        "(^$|^<not set>$)" 
                        {
                            "<not set>"
                        }
                        Default
                        { 
                            $Ctrl.Xaml.IO.SteamPathText.Text
                        }
                    }

                    $Ctrl.Xaml.IO.SteamPathText.Text = $Text
                })

                $Ctrl.Xaml.IO.SteamPathBrowse.Add_Click(
                {
                    $Ctrl.SteamPathBrowse()
                })

                $Ctrl.Xaml.IO.SteamPathApply.Add_Click(
                {
                    $Ctrl.SteamPathApply()
                })

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

                $Ctrl.Xaml.IO.SteamProjectVdfApply.Add_Click(
                {
                    $Ctrl.SteamProjectVdfApply()
                })

                $Ctrl.Xaml.IO.SteamProjectPreviewImport.Add_Click(
                {
                    $Ctrl.SteamProjectPreviewImport()
                })

                $Ctrl.Xaml.IO.SteamProjectCreate.Add_Click(
                {
                    $Ctrl.SteamProjectCreate()
                })

                $Ctrl.Xaml.IO.SteamProjectRemove.Add_Click(
                {
                    $Ctrl.SteamProjectRemove()
                })

                $Ctrl.Xaml.IO.SteamProjectUpload.Add_Click(
                {
                    $Ctrl.SteamProjectUpload()
                })
            }
        }
    }
    Initial([String]$Name)
    {
        $Ctrl = $This

        Switch ($Name)
        {
            Component
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentOutput,$Ctrl.Component)
            }
            Radiant
            {
                $Ctrl.Xaml.IO.RadiantPathText.Text             = "<not set>"
                $Ctrl.Xaml.IO.RadiantPathIcon.Source           = $Ctrl.IconStatus(2)
                $Ctrl.Xaml.IO.RadiantPathApply.IsEnabled       = 0
                $Ctrl.Xaml.IO.RadiantProperty.Items.Clear()
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

                # Details
                $Ctrl.Reset($Ctrl.Xaml.IO.MapDetails,$Null)

                # Levelshot
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
        
                # Output
                $Ctrl.Xaml.IO.MapOutput.IsEnabled              = 1
                $Ctrl.Reset($Ctrl.Xaml.IO.MapOutput,$Null)
            }
            Steam
            {
                $Ctrl.Xaml.IO.SteamTab.IsEnabled                  = 0

                $Ctrl.Xaml.IO.SteamPathText.IsEnabled             = 1
                $Ctrl.Xaml.IO.SteamPathText.Text                  = "<not set>"
                $Ctrl.Xaml.IO.SteamPathBrowse.IsEnabled           = 1
                $Ctrl.Xaml.IO.SteamPathApply.IsEnabled            = 0

                # Credential
                $Ctrl.Xaml.IO.SteamCredentialPathText.IsEnabled   = 1
                $Ctrl.Xaml.IO.SteamCredentialPathIcon.IsEnabled   = 1
                $Ctrl.Xaml.IO.SteamCredentialPathBrowse.IsEnabled = 1
                $Ctrl.Xaml.IO.SteamCredentialPathApply.IsEnabled  = 1
                $Ctrl.Xaml.IO.SteamCredentialUsername.IsEnabled   = 1
                $Ctrl.Xaml.IO.SteamCredentialPassword.IsEnabled   = 1

                # Workshop
                $Ctrl.Xaml.IO.SteamWorkshopPathText.IsEnabled     = 1
                $Ctrl.Xaml.IO.SteamWorkshopPathText.Text          = "<not set>"
                $Ctrl.Xaml.IO.SteamWorkshopPathIcon.IsEnabled     = 1
                $Ctrl.Xaml.IO.SteamWorkshopPathBrowse.IsEnabled   = 1
                $Ctrl.Xaml.IO.SteamWorkshopPathApply.IsEnabled    = 0

                $Ctrl.Reset($Ctrl.Xaml.IO.SteamWorkshopOutput,$Null)

                # Details
                $Ctrl.Xaml.IO.SteamProjectDetails.IsEnabled       = 0
                $Ctrl.Reset($Ctrl.Xaml.IO.SteamProjectDetails,$Null)

                # Preview
                $Ctrl.Xaml.IO.SteamProjectPreviewPathText.IsEnabled   = 0
                $Ctrl.Xaml.IO.SteamProjectPreviewPathText.Text        = "<not set>"
                $Ctrl.Xaml.IO.SteamProjectPreviewExists.IsEnabled     = 0
                $Ctrl.Xaml.IO.SteamProjectPreviewExists.IsChecked     = 0
                $Ctrl.Xaml.IO.SteamProjectPreviewImport.IsEnabled     = 0
                $Ctrl.Xaml.IO.SteamProjectPreviewImage.IsEnabled      = 0

                # Vdf
                $Ctrl.Xaml.IO.SteamProjectVdfPathText.IsEnabled       = 0
                $Ctrl.Xaml.IO.SteamProjectVdfPathText.Text            = "<not set>"
                $Ctrl.Xaml.IO.SteamProjectVdfExists.IsEnabled         = 0
                $Ctrl.Xaml.IO.SteamProjectVdfExists.IsChecked         = 0
                $Ctrl.Xaml.IO.SteamProjectVdfApply.IsEnabled          = 0
                $Ctrl.Xaml.IO.SteamProjectVdfContent.IsEnabled        = 0

                # Output
                $Ctrl.Xaml.IO.SteamProjectOutput.IsEnabled            = 0
                $Ctrl.Reset($Ctrl.Xaml.IO.SteamProjectOutput,$Null)

                # Functions
                $Ctrl.Xaml.IO.SteamProjectCreate.IsEnabled            = 0
                $Ctrl.Xaml.IO.SteamProjectRemove.IsEnabled            = 0
                $Ctrl.Xaml.IO.SteamProjectUpload.IsEnabled            = 0
            }
        }
    }
    StageXaml()
    {
        # [Event handler stuff]
        $This.Stage("Component")
        $This.Stage("Radiant")
        $This.Stage("Workspace")
        $This.Stage("Map")
        $This.Stage("Steam")

        # [Initial properties/settings]
        $This.Initial("Component")
        $This.Initial("Radiant")
        $This.Initial("Workspace")
        $This.Initial("Map")
        $This.Initial("Steam")
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

$Ctrl      = [Q3ALiveMaster]::New()
$Ctrl.Reload()
