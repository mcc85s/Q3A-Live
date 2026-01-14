<#
    [Program Map]

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
    ____                                                                                                    ________    
   //¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
   \\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\__//¯¯¯    
    ¯¯¯\\__[ General    ]__________________________________________________________________________________//¯¯¯        
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯            
#>

# CSharp Type Definition
Try
{
    $TypeDefinition = 'using System;',
    'using System.Collections.ObjectModel;',
    'using System.ComponentModel;',
    'using System.IO;',
    'using System.Linq;',
    ' ',
    'namespace Q3ALive',
    '{',
    '    public class ByteSize',
    '    {',
    '        public string Name { get; set; }',
    '        public long Bytes { get; set; }',
    '        public string Unit { get; private set; }',
    '        public string Size { get; private set; }',
    '        public ByteSize(string name, long bytes)',
    '        {',
    '            this.Name = name;',
    '            this.Bytes = bytes;',
    '            GetUnit();',
    '            GetSize();',
    '        }',
    '        private void GetUnit()',
    '        {',
    '            if (Bytes < 1024L)',
    '            {',
    '                Unit = "Byte";',
    '            }',
    '            else if (Bytes >= 1024L && Bytes < 1048576L)',
    '            { ',
    '                // 1KB–1MB',
    '                Unit = "Kilobyte";',
    '            }',
    '            else if (Bytes >= 1048576L && Bytes < 1073741824L)',
    '            { ',
    '                // 1MB–1GB',
    '                Unit = "Megabyte";',
    '            }',
    '            else if (Bytes >= 1073741824L && Bytes < 1099511627776L)',
    '            { // 1GB–1TB',
    '                Unit = "Gigabyte";',
    '            }',
    '            else',
    '            {',
    '                Unit = "Terabyte";',
    '            }',
    '        }',
    '        private void GetSize()',
    '        {',
    '            switch (Unit) ',
    '            {',
    '                case "Byte":',
    '                    Size = string.Format("{0} B", Bytes);',
    '                    break;',
    '                case "Kilobyte":',
    '                    Size = string.Format("{0:n2} KB", (Bytes / 1024.0));',
    '                    break;',
    '                case "Megabyte":',
    '                    Size = string.Format("{0:n2} MB", (Bytes / 1048576.0));',
    '                    break;',
    '                case "Gigabyte":',
    '                    Size = string.Format("{0:n2} GB", (Bytes / 1073741824.0));',
    '                    break;',
    '                case "Terabyte":',
    '                    Size = string.Format("{0:n2} TB", (Bytes / 1099511627776.0));',
    '                    break;',
    '            }',
    '        }',
    '        public override string ToString()',
    '        {',
    '            return Size;',
    '        }',
    '        public static ByteSize New(string name, long bytes)',
    '        {',
    '            return new ByteSize(name, bytes);',
    '        }',
    '    }',
    '    ',
    '    public class AssignmentSelectFile : INotifyPropertyChanged',
    '    {',
    '        public event PropertyChangedEventHandler PropertyChanged;',
    '        public uint Index { get; set; }',
    '        public string Name { get; set; }',
    '        public string DisplayName { get; set; }',
    '        public string Fullname { get; set; }',
    '        public string Modified { get; set; }',
    '        public object Size { get; set; }',
    '        private bool _selected;',
    '        public bool Selected {',
    '            get { return _selected; }',
    '            set',
    '            {',
    '                if (_selected != value)',
    '                {',
    '                    _selected = value;',
    '                    OnPropertyChanged("Selected");',
    '                }',
    '            }',
    '        }',
    '        public AssignmentSelectFile(uint index, FileInfo file)',
    '        {',
    '            this.Index    = index;',
    '            this.Name     = file.Name;',
    '            this.DisplayName = System.IO.Path.GetFileNameWithoutExtension(file.Name);',
    '            this.Fullname = file.FullName;',
    '            this.Modified = file.LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss");',
    '            this.Size     = new ByteSize("Map",file.Length);',
    '            this._selected = false;',
    '        }',
    '        protected void OnPropertyChanged(string propertyName)',
    '        {',
    '            if (PropertyChanged != null)',
    '            {',
    '                PropertyChanged(this, new PropertyChangedEventArgs(propertyName));',
    '            }',
    '        }',
    '        public override string ToString()',
    '        {',
    '            return this.Name;',
    '        }',
    '    }',
    ' ',
    '    public class AssignmentSelectFileList : INotifyPropertyChanged',
    '    {',
    '        public event PropertyChangedEventHandler PropertyChanged;',
    '        public string Fullname { get; private set; }',
    '        public uint Exists { get; private set; }',
    '        public object Resource { get; set; }',
    '        public ObservableCollection<AssignmentSelectFile> Output { get; private set; }',
    '        public System.ComponentModel.ICollectionView View { get; set; }',
    '        public object Edit { get; set; }',
    '        public AssignmentSelectFileList()',
    '        {',
    '            Clear();',
    '        }',
    '        public void Assign(string fullname)',
    '        {',
    '            if (Directory.Exists(fullname))',
    '            {',
    '                Fullname = fullname;',
    '                Exists = 1;',
    '                Refresh();',
    '            }',
    '            else',
    '            {',
    '                Exists = 0;',
    '                Clear();',
    '            }',
    '        }',
    '        public void Clear()',
    '        {',
    '            Output = new ObservableCollection<AssignmentSelectFile>();',
    '            View = System.Windows.Data.CollectionViewSource.GetDefaultView(Output);',
    '            OnPropertyChanged("Output");',
    '            OnPropertyChanged("View");',
    '        }',
    '        public void Refresh()',
    '        {',
    '            Clear();',
    ' ',
    '            var files = new DirectoryInfo(Fullname)',
    '                .GetFiles("*.map")',
    '                .OrderBy(f => f.Name);',
    '        ',
    '            uint index = 0;',
    '            foreach (var file in files)',
    '            {',
    '                AssignmentSelectFile item = new AssignmentSelectFile(index++, file);',
    '                item.PropertyChanged += Item_PropertyChanged;',
    '                Output.Add(item);',
    '            }',
    '        ',
    '            OnPropertyChanged("Output");',
    '            OnPropertyChanged("View");',
    '            OnPropertyChanged("AnySelected");',
    '        }',
    '        private void Item_PropertyChanged(object sender, PropertyChangedEventArgs e)',
    '        {',
    '            if (e.PropertyName == "Selected")',
    '                OnPropertyChanged("AnySelected");',
    '        }',
    '        public void ApplyFilter(string propertyName, string filterText)',
    '        {',
    '            if (string.IsNullOrEmpty(propertyName) || string.IsNullOrEmpty(filterText))',
    '            {',
    '                View.Filter = null;',
    '            }',
    '            else',
    '            {',
    '                View.Filter = item =>',
    '                {',
    '                    var file = item as AssignmentSelectFile;',
    '                    if (file == null) return false;',
    ' ',
    '                    var prop = file.GetType().GetProperty(propertyName);',
    '                    if (prop == null) return false;',
    ' ',
    '                    var raw = prop.GetValue(file, null);',
    '                    var value = raw != null ? raw.ToString() : null;',
    ' ',
    '                    return value != null &&',
    '                    value.IndexOf(filterText, StringComparison.OrdinalIgnoreCase) >= 0;',
    '                };',
    '            }',
    ' ',
    '            View.Refresh();',
    '        }',
    '        protected void OnPropertyChanged(string propertyName)',
    '        {',
    '            if (PropertyChanged != null)',
    '            {',
    '                PropertyChanged(this, new PropertyChangedEventArgs(propertyName));',
    '            }',
    '        }',
    '        public bool AnySelected',
    '        {',
    '            get',
    '            {',
    '                foreach (AssignmentSelectFile f in Output)',
    '                {',
    '                    if (f.Selected)',
    '                        return true;',
    '                }',
    '                return false;',
    '            }',
    '        }',
    ' ',
    '        public override string ToString()',
    '        {',
    '            return "<Q3ALive.Map.List>";',
    '        }',
    '    }',
    '}'

    $AssemblyNames = 'mscorlib','System','System.Core','WindowsBase','PresentationCore','PresentationFramework'
    Add-Type -ReferencedAssemblies $AssemblyNames -TypeDefinition $TypeDefinition
    Add-Type -Assembly System.IO.Compression, System.IO.Compression.Filesystem
}
Catch
{

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
        $This.Bytes  = Switch ($Bytes) { Default { $Bytes } 1 { 0 } }
        $This.GetUnit()
        $This.GetSize()
    }
    GetUnit()
    {
        $This.Unit   = Switch ($This.Bytes)
        {
            {$_ -ge 0   -and $_ -lt 1KB} {     "Byte" }
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
    '        Height="585"',
    '        Width="750"',
    '        ResizeMode="NoResize"',
    '        Icon="C:\ProgramData\Secure Digits Plus LLC\FightingEntropy\2024.1.0\Graphics\icon.ico"',
    '        HorizontalAlignment="Center"',
    '        WindowStartupLocation="CenterScreen"',
    '        FontFamily="Consolas"',
    '        Background="#5F5F50">',
    '    <Window.Resources>',
    '        <CollectionViewSource x:Key="AssignmentSelectView" Source="{Binding Output}"/>',
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
    '            <Style.Triggers>',
    '                <Trigger Property="DisplayIndex" Value="-1">',
    '                    <Setter Property="Background"',
    '                            Value="Transparent"/>',
    '                    <Setter Property="BorderThickness"',
    '                            Value="0"/>',
    '                    <Setter Property="Template">',
    '                        <Setter.Value>',
    '                            <ControlTemplate TargetType="DataGridColumnHeader">',
    '                                <Border Background="Transparent"',
    '                                        BorderThickness="0"/>',
    '                            </ControlTemplate>',
    '                        </Setter.Value>',
    '                    </Setter>',
    '                </Trigger>',
    '            </Style.Triggers>',
    '            <Setter Property="FontSize" Value="12"/>',
    '            <Setter Property="FontWeight" Value="Normal"/>',
    '            <Setter Property="Background" Value="#333333"/>',
    '            <Setter Property="Foreground" Value="#00FF00"/>',
    '            <Setter Property="BorderBrush" Value="#444444"/>',
    '            <Setter Property="Padding" Value="2"/>',
    '            <Setter Property="HorizontalContentAlignment" Value="Stretch"/>',
    '            <Setter Property="SeparatorVisibility" Value="Collapsed"/>',
    '        </Style>',
    '        <Style TargetType="DataGridRowHeader">',
    '            <Setter Property="Visibility" Value="Collapsed"/>',
    '            <Setter Property="Width" Value="0"/>',
    '            <Setter Property="Padding" Value="0"/>',
    '            <Setter Property="BorderThickness" Value="0"/>',
    '            <Setter Property="Background" Value="Transparent"/>',
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
    '        <Style x:Key="OneClickCheckBoxStyle" TargetType="CheckBox">',
    '            <Setter Property="Focusable" Value="False"/>',
    '            <Setter Property="HorizontalContentAlignment" Value="Right"/>',
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
    '                        <RowDefinition Height="67"/>',
    '                        <RowDefinition Height="85"/>',
    '                        <RowDefinition Height="85"/>',
    '                        <RowDefinition Height="103"/>',
    '                        <RowDefinition Height="*"/>',
    '                    </Grid.RowDefinitions>',
    '                    <Grid Grid.Row="0">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="90"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="90"/>',
    '                            <ColumnDefinition Width="90"/>',
    '                            <ColumnDefinition Width="90"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <Button Grid.Column="0"',
    '                                Content="Install"',
    '                                ToolTip="Installs Q3A-Live"',
    '                                Name="ConfigInstall"/>',
    '                        <TextBox Grid.Column="1"',
    '                                 Text="&lt;Manages Q3A-Live filesystem + registry properties&gt;"',
    '                                 IsReadOnly="True"/>',
    '                        <Button Grid.Column="2"',
    '                                Content="Uninstall"',
    '                                ToolTip="Uninstalls Q3A-Live"',
    '                                Name="ConfigUninstall"/>',
    '                        <Button Grid.Column="3"',
    '                                Content="Scan"',
    '                                ToolTip="Scans installed programs for components/depencencies"',
    '                                Name="ConfigScan"/>',
    '                        <Button Grid.Column="4"',
    '                                Content="Refresh"',
    '                                ToolTip="Refreshes all properties + toggles tabs"',
    '                                Name="ConfigRefresh"/>',
    '                    </Grid>',
    '                    <DataGrid Grid.Row="1"',
    '                              Name="ConfigResource">',
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
    '                    <TextBox Grid.Row="2"',
    '                                 Name="ConfigRegistryPathText"',
    '                                 IsReadOnly="True"/>',
    '                    <DataGrid Grid.Row="3"',
    '                              Name="ConfigComponent">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="&lt;Q3ALive.Registry.Component&gt;"',
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
    '                            <DataGridTextColumn Header="Component"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="120"/>',
    '                            <DataGridTextColumn Header="Directory"',
    '                                                Binding="{Binding Value}"',
    '                                                Width="*"/>',
    '                            <DataGridCheckBoxColumn Header="&#x2714;"',
    '                                                Binding="{Binding Valid}"',
    '                                                Width="20"/>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <DataGrid Grid.Row="4"',
    '                              Name="ConfigSettings">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="&lt;Q3ALive.Registry.Settings&gt;"',
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
    '                            <DataGridTextColumn Header="Setting"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="120"/>',
    '                            <DataGridTextColumn Header="Directory"',
    '                                                Binding="{Binding Value}"',
    '                                                Width="*"/>',
    '                            <DataGridCheckBoxColumn Header="&#x2714;"',
    '                                                Binding="{Binding Valid}"',
    '                                                Width="20"/>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <DataGrid Grid.Row="5"',
    '                              Name="ConfigRadiant">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="&lt;Q3ALive.Registry.Radiant&gt;"',
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
    '                            <DataGridTextColumn Header="Radiant"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="120"/>',
    '                            <DataGridTextColumn Header="Directory"',
    '                                                Binding="{Binding Value}"',
    '                                                Width="*"/>',
    '                            <DataGridCheckBoxColumn Header="&#x2714;"',
    '                                                Binding="{Binding Valid}"',
    '                                                Width="20"/>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <DataGrid Grid.Row="6"',
    '                              Name="ConfigDependency">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="&lt;Q3ALive.Registry.Dependency&gt;"',
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
    '                            <DataGridTextColumn Header="Dependency"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="120"/>',
    '                            <DataGridTextColumn Header="Directory"',
    '                                                Binding="{Binding Value}"',
    '                                                Width="*"/>',
    '                            <DataGridCheckBoxColumn Header="&#x2714;"',
    '                                                Binding="{Binding Valid}"',
    '                                                Width="20"/>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <Grid Grid.Row="8"',
    '                          VerticalAlignment="Bottom">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="130"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="25"/>',
    '                            <ColumnDefinition Width="80"/>',
    '                            <ColumnDefinition Width="80"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <TextBox Grid.Column="0"',
    '                                 Name="ConfigPropertyNameText"/>',
    '                        <TextBox Grid.Column="1"',
    '                                 Name="ConfigPropertyValueText"/>',
    '                        <Image Grid.Column="2"',
    '                               Name="ConfigPropertyValueIcon"/>',
    '                        <Button Grid.Column="3"',
    '                                Name="ConfigPropertyBrowse"',
    '                                Content="Browse"/>',
    '                        <Button Grid.Column="4"',
    '                                Name="ConfigPropertyApply"',
    '                                Content="Apply"/>',
    '                    </Grid>',
    '                </Grid>',
    '            </TabItem>',
    '            <TabItem Header="Component"',
    '                     ToolTip="(Components/Prerequisites) for Q3A-Live">',
    '                <Grid>',
    '                    <Grid.RowDefinitions>',
    '                        <RowDefinition Height="70"/>',
    '                        <RowDefinition Height="85"/>',
    '                        <RowDefinition Height="165"/>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="*"/>',
    '                    </Grid.RowDefinitions>',
    '                    <Grid Grid.Row="0">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <DataGrid Grid.Column="0"',
    '                              Name="ComponentOutput"',
    '                              SelectionMode="Single">',
    '                            <DataGrid.RowStyle>',
    '                                <Style TargetType="{x:Type DataGridRow}">',
    '                                    <Style.Triggers>',
    '                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                            <Setter Property="ToolTip">',
    '                                                <Setter.Value>',
    '                                                    <TextBlock Text="{Binding Base}"',
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
    '                                <DataGridTextColumn Header="Component"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="125"/>',
    '                                <DataGridTextColumn Header="Directory"',
    '                                                Binding="{Binding Fullname}"',
    '                                                Width="*"/>',
    '                                <DataGridCheckBoxColumn Header="&#x2714;"',
    '                                                Binding="{Binding Installed}"',
    '                                                Width="20"/>',
    '                            </DataGrid.Columns>',
    '                        </DataGrid>',
    '                        <Button Grid.Column="1"',
    '                                Content="Select"',
    '                                Name="ComponentSelect"',
    '                                Height="30"',
    '                                ToolTip="Selects the (component/game)"/>',
    '                    </Grid>',
    '                    <Grid Grid.Row="1">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <DataGrid Grid.Row="1"',
    '                              Name="RadiantOutput"',
    '                              SelectionMode="Single">',
    '                            <DataGrid.RowStyle>',
    '                                <Style TargetType="{x:Type DataGridRow}">',
    '                                    <Style.Triggers>',
    '                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                            <Setter Property="ToolTip">',
    '                                                <Setter.Value>',
    '                                                    <TextBlock Text="{Binding Base}"',
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
    '                                <DataGridTextColumn Header="Radiant"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="125"/>',
    '                                <DataGridTextColumn Header="Directory"',
    '                                                Binding="{Binding Fullname}"',
    '                                                Width="*"/>',
    '                                <DataGridCheckBoxColumn Header="&#x2714;"',
    '                                                Binding="{Binding Installed}"',
    '                                                Width="20"/>',
    '                            </DataGrid.Columns>',
    '                        </DataGrid>',
    '                        <Button Grid.Column="1"',
    '                                Content="Select"',
    '                                Name="RadiantSelect"',
    '                                Height="30"',
    '                                ToolTip="Selects the editor"/>',
    '                    </Grid>',
    '                    <Grid Grid.Row="2">',
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
    '                                                Width="125"/>',
    '                                <DataGridTextColumn Header="Type"',
    '                                                    Binding="{Binding Type}"',
    '                                                    Width="60"/>',
    '                                <DataGridTextColumn Header="Version"',
    '                                                Binding="{Binding Version}"',
    '                                                Width="60"/>',
    '                                <DataGridTextColumn Header="Description"',
    '                                                Binding="{Binding Description}"',
    '                                                Width="*"/>',
    '                                <DataGridCheckBoxColumn Header="&#x2714;"',
    '                                                Binding="{Binding Installed}"',
    '                                                Width="20"/>',
    '                            </DataGrid.Columns>',
    '                        </DataGrid>',
    '                        <Grid Grid.Column="1">',
    '                            <Grid.RowDefinitions>',
    '                                <RowDefinition Height="40"/>',
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
    '                            <Button Grid.Row="3"',
    '                                Name="DependencyNew"',
    '                                Content="New"',
    '                                IsEnabled="False"/>',
    '                        </Grid>',
    '                    </Grid>',
    '                    <Grid Grid.Row="3">',
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
    '                                                Width="100"/>',
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
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="*"/>',
    '                        <RowDefinition Height="40"/>',
    '                    </Grid.RowDefinitions>',
    '                    <Grid Grid.Row="0">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="25"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <TextBox Grid.Column="0"',
    '                                 Name="WorkspacePathText"',
    '                                 IsReadOnly="True"/>',
    '                        <Image Grid.Column="1"',
    '                               Name="WorkspacePathIcon"/>',
    '                    </Grid>',
    '                    <Grid Grid.Row="1">',
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
    '                                <ColumnDefinition Width="25"/>',
    '                            </Grid.ColumnDefinitions>',
    '                            <TextBox Grid.Column="0"',
    '                                     Name="WorkspaceLogPathText"/>',
    '                            <Image Grid.Column="1"',
    '                                   Name="WorkspaceLogPathIcon"/>',
    '                        </Grid>',
    '                        <Grid Grid.Column="1"',
    '                              Name="WorkspaceOutputHeader"',
    '                              Visibility="Hidden">',
    '                            <Grid.ColumnDefinitions>',
    '                                <ColumnDefinition Width="*"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                                <ColumnDefinition Width="100"/>',
    '                                <ColumnDefinition Width="70"/>',
    '                            </Grid.ColumnDefinitions>',
    '                            <Label Grid.Column="1"',
    '                                   Content="Size:"/>',
    '                            <TextBox Grid.Column="2"',
    '                                     Name="WorkspaceOutputSizeText"',
    '                                     IsReadOnly="True"/>',
    '                            <Button Grid.Column="3"',
    '                                    Name="WorkspaceOutputRefresh"',
    '                                    Content="Refresh"/>',
    '                        </Grid>',
    '                    </Grid>',
    '                    <DataGrid Grid.Row="2"',
    '                              Name="WorkspaceLogOutput"',
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
    '                    <DataGrid Grid.Row="2"',
    '                              Name="WorkspaceOutput"',
    '                              Visibility="Visible"',
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
    '                            <DataGridTextColumn Header="Modified"',
    '                                                Binding="{Binding Modified}"',
    '                                                Width="135"/>',
    '                            <DataGridTextColumn Header="Name"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="*"/>',
    '                            <DataGridTextColumn Header="Size"',
    '                                                Binding="{Binding Size}"',
    '                                                Width="70"',
    '                                                ElementStyle="{StaticResource rTextBlock}"/>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <Grid Grid.Row="3"',
    '                          Name="WorkspaceOutputFooter"',
    '                          Visibility="Hidden">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="125"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="25"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <Label Grid.Column="0"',
    '                               Content="Fullname:"/>',
    '                        <TextBox Grid.Column="1"',
    '                                 Name="WorkspaceOutputPropertyText"/>',
    '                        <Image Grid.Column="2"',
    '                               Name="WorkspaceOutputPropertyIcon"/>',
    '                    </Grid>',
    '                </Grid>',
    '            </TabItem>',
    '            <TabItem Header="Assignment"',
    '                     Name="AssignmentTab"',
    '                     ToolTip="Controls to compile, package, and publish map(s) assets">',
    '                <TabControl>',
    '                    <TabItem Header="Resource">',
    '                        <Grid>',
    '                            <Grid.RowDefinitions>',
    '                                <RowDefinition Height="80"/>',
    '                                <RowDefinition Height="40"/>',
    '                                <RowDefinition Height="*"/>',
    '                            </Grid.RowDefinitions>',
    '                            <DataGrid Grid.Row="0"',
    '                                      Name="AssignmentResourceOutput"',
    '                                      CanUserAddRows="False"',
    '                                      CanUserDeleteRows="False">',
    '                                <DataGrid.RowStyle>',
    '                                    <Style TargetType="{x:Type DataGridRow}">',
    '                                        <Style.Triggers>',
    '                                            <Trigger Property="IsMouseOver" Value="True">',
    '                                                <Setter Property="ToolTip">',
    '                                                    <Setter.Value>',
    '                                                        <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                    </Setter.Value>',
    '                                                </Setter>',
    '                                            </Trigger>',
    '                                        </Style.Triggers>',
    '                                    </Style>',
    '                                </DataGrid.RowStyle>',
    '                                <DataGrid.Columns>',
    '                                    <DataGridTextColumn Header="Modified"',
    '                                                        Binding="{Binding Modified}"',
    '                                                        Width="135"/>',
    '                                    <DataGridTextColumn Header="Name"',
    '                                                        Binding="{Binding Name}"',
    '                                                        Width="*"/>',
    '                                    <DataGridTextColumn Header="Size"',
    '                                                        Binding="{Binding Size}"',
    '                                                        Width="80"/>',
    '                                </DataGrid.Columns>',
    '                            </DataGrid>',
    '                            <Grid Grid.Row="1">',
    '                                <Grid.ColumnDefinitions>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                    <ColumnDefinition Width="25"/>',
    '                                    <ColumnDefinition Width="70"/>',
    '                                    <ColumnDefinition Width="70"/>',
    '                                </Grid.ColumnDefinitions>',
    '                                <TextBox Grid.Column="0"',
    '                                             Name="AssignmentResourcePathText"/>',
    '                                <Image Grid.Column="1"',
    '                                              Name="AssignmentResourcePathIcon"/>',
    '                                <Button Grid.Column="2"',
    '                                            Name="AssignmentResourceAdd"',
    '                                            Content="Add"/>',
    '                                <Button Grid.Column="3"',
    '                                            Name="AssignmentResourceRemove"',
    '                                            Content="Remove"/>',
    '                            </Grid>',
    '                            <TabControl Grid.Row="2">',
    '                                <TabItem Header="Output">',
    '                                    <DataGrid Grid.Row="2"',
    '                                      Name="AssignmentResourceContent"',
    '                                      SelectionMode="Single">',
    '                                        <DataGrid.RowStyle>',
    '                                            <Style TargetType="{x:Type DataGridRow}">',
    '                                                <Style.Triggers>',
    '                                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                                        <Setter Property="ToolTip">',
    '                                                            <Setter.Value>',
    '                                                                <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                            </Setter.Value>',
    '                                                        </Setter>',
    '                                                    </Trigger>',
    '                                                </Style.Triggers>',
    '                                            </Style>',
    '                                        </DataGrid.RowStyle>',
    '                                        <DataGrid.Columns>',
    '                                            <DataGridTextColumn Header="Modified"',
    '                                                        Binding="{Binding Modified}"',
    '                                                        Width="135"/>',
    '                                            <DataGridTextColumn Header="DisplayName"',
    '                                                        Binding="{Binding DisplayName}"',
    '                                                        Width="*"/>',
    '                                            <DataGridTextColumn Header="Label"',
    '                                                        Binding="{Binding Label}"',
    '                                                        Width="70"/>',
    '                                            <DataGridTextColumn Header="Size"',
    '                                                        Binding="{Binding Size}"',
    '                                                        Width="70"',
    '                                                        ElementStyle="{StaticResource rTextBlock}"/>',
    '                                        </DataGrid.Columns>',
    '                                    </DataGrid>',
    '                                </TabItem>',
    '                                <TabItem Header="Shader">',
    '                                    <Grid>',
    '                                        <Grid.RowDefinitions>',
    '                                            <RowDefinition Height="85"/>',
    '                                            <RowDefinition Height="85"/>',
    '                                            <RowDefinition Height="*"/>',
    '                                        </Grid.RowDefinitions>',
    '                                        <DataGrid Grid.Row="0"',
    '                                      Name="AssignmentResourceShaderOutput"',
    '                                      ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                      AutoGenerateColumns="False"',
    '                                      IsReadOnly="True"',
    '                                      SelectionUnit="FullRow"',
    '                                      SelectionMode="Extended"',
    '                                      CanUserAddRows="False"',
    '                                      CanUserDeleteRows="False">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                        Binding="{Binding Modified}"',
    '                                                        Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                        Binding="{Binding DisplayName}"',
    '                                                        Width="*"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                        Binding="{Binding Size}"',
    '                                                        Width="70"/>',
    '                                                <DataGridCheckBoxColumn Header="Used"',
    '                                                                        Binding="{Binding IsReferenced}"',
    '                                                                        Width="55"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                        <DataGrid Grid.Row="1"',
    '                                                  Name="AssignmentResourceShaderItemOutput"',
    '                                                  AutoGenerateColumns="False"',
    '                                                  IsReadOnly="True"',
    '                                                  SelectionUnit="FullRow"',
    '                                                  SelectionMode="Extended"',
    '                                                  CanUserAddRows="False"',
    '                                                  CanUserDeleteRows="False">',
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
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridCheckBoxColumn Header="Texture"',
    '                                                                        Binding="{Binding IsTexture}"',
    '                                                                        Width="55"/>',
    '                                                <DataGridCheckBoxColumn Header="Virtual"',
    '                                                                        Binding="{Binding IsVirtual}"',
    '                                                                        Width="55"/>',
    '                                                <DataGridCheckBoxColumn Header="Used"',
    '                                                                        Binding="{Binding IsReferenced}"',
    '                                                                        Width="55"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                        <DataGrid Grid.Row="2"',
    '                                                  Name="AssignmentResourceShaderItemContent"',
    '                                                  SelectionMode="Extended"',
    '                                                  HeadersVisibility="None">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="&lt;Q3ALive.Dependency.ItemProperty&gt;"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="#"',
    '                                                                    Binding="{Binding Index}"',
    '                                                                    Width="50"/>',
    '                                                <DataGridTextColumn Header="Line"',
    '                                                                    Binding="{Binding Line}"',
    '                                                                    Width="*"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                    </Grid>',
    '                                </TabItem>',
    '                                <TabItem Header="Texture">',
    '                                    <Grid>',
    '                                        <Grid.RowDefinitions>',
    '                                            <RowDefinition Height="*"/>',
    '                                            <RowDefinition Height="50"/>',
    '                                        </Grid.RowDefinitions>',
    '                                        <DataGrid Grid.Row="0"',
    '                                      Name="AssignmentResourceTextureOutput"',
    '                                      ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                      AutoGenerateColumns="False"',
    '                                      IsReadOnly="True"',
    '                                      SelectionUnit="FullRow"',
    '                                      SelectionMode="Extended"',
    '                                      CanUserAddRows="False"',
    '                                      CanUserDeleteRows="False">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                        Binding="{Binding Modified}"',
    '                                                        Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                        Binding="{Binding DisplayName}"',
    '                                                        Width="2*"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                        Binding="{Binding Size}"',
    '                                                        Width="70"/>',
    '                                                <DataGridCheckBoxColumn Header="Used"',
    '                                                                        Binding="{Binding IsReferenced}"',
    '                                                                        Width="55"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                        <DataGrid Grid.Row="1"',
    '                                      Name="AssignmentResourceTextureProperty"',
    '                                      ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                      AutoGenerateColumns="False"',
    '                                      IsReadOnly="True"',
    '                                      SelectionUnit="FullRow"',
    '                                      SelectionMode="Extended"',
    '                                      CanUserAddRows="False"',
    '                                      CanUserDeleteRows="False">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="Reference"',
    '                                                        Binding="{Binding Reference}"',
    '                                                        Width="*"/>',
    '                                                <DataGridTextColumn Header="Name"',
    '                                                        Binding="{Binding Name}"',
    '                                                        Width="*"/>',
    '                                                <DataGridTextColumn Header="Label"',
    '                                                        Binding="{Binding Label}"',
    '                                                        Width="50"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                    </Grid>',
    '                                </TabItem>',
    '                            </TabControl>',
    '                        </Grid>',
    '                    </TabItem>',
    '                    <TabItem Header="Select">',
    '                        <Grid>',
    '                            <Grid.RowDefinitions>',
    '                                <RowDefinition Height="40"/>',
    '                                <RowDefinition Height="10"/>',
    '                                <RowDefinition Height="40"/>',
    '                                <RowDefinition Height="*"/>',
    '                                <RowDefinition Height="40"/>',
    '                            </Grid.RowDefinitions>',
    '                            <Grid Grid.Row="0">',
    '                                <Grid.ColumnDefinitions>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                    <ColumnDefinition Width="25"/>',
    '                                    <ColumnDefinition Width="70"/>',
    '                                    <ColumnDefinition Width="70"/>',
    '                                    <ColumnDefinition Width="70"/>',
    '                                </Grid.ColumnDefinitions>',
    '                                <TextBox Grid.Column="0"',
    '                                     Name="AssignmentSelectPathText"/>',
    '                                <Image Grid.Column="1"',
    '                                       Name="AssignmentSelectPathIcon"/>',
    '                                <Button Grid.Column="2"',
    '                                        Content="Browse"',
    '                                        Name="AssignmentSelectPathBrowse"/>',
    '                                <Button Grid.Column="3"',
    '                                        Content="Open"',
    '                                        Name="AssignmentSelectPathOpen"/>',
    '                                <Button Grid.Column="4"',
    '                                        Content="Close"',
    '                                        Name="AssignmentSelectPathClose"/>',
    '                            </Grid>',
    '                            <Border Grid.Row="1"',
    '                                    Style="{StaticResource Line}"/>',
    '                            <Grid Grid.Row="2">',
    '                                <Grid.ColumnDefinitions>',
    '                                    <ColumnDefinition Width="120"/>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                    <ColumnDefinition Width="70"/>',
    '                                    <ColumnDefinition Width="70"/>',
    '                                </Grid.ColumnDefinitions>',
    '                                <ComboBox Grid.Column="0"',
    '                                          Name="AssignmentSelectFilterProperty">',
    '                                    <ComboBoxItem Content="Name"/>',
    '                                    <ComboBoxItem Content="Modified"/>',
    '                                </ComboBox>',
    '                                <TextBox Grid.Column="1"',
    '                                         Name="AssignmentSelectFilterText"/>',
    '                                <Button Grid.Column="2"',
    '                                        Name="AssignmentSelectRefresh"',
    '                                        Content="Refresh"/>',
    '                                <Button Grid.Column="3"',
    '                                        Name="AssignmentSelectAssign"',
    '                                        Content="Assign"',
    '                                        IsEnabled="{Binding AnySelected}"/>',
    '                            </Grid>',
    '                            <DataGrid Grid.Row="3"',
    '                                      Name="AssignmentSelectOutput"',
    '                                      ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                      AutoGenerateColumns="False"',
    '                                      IsReadOnly="True"',
    '                                      SelectionUnit="FullRow"',
    '                                      SelectionMode="Extended"',
    '                                      CanUserAddRows="False"',
    '                                      CanUserDeleteRows="False">',
    '                                <DataGrid.RowStyle>',
    '                                    <Style TargetType="{x:Type DataGridRow}">',
    '                                        <Style.Triggers>',
    '                                            <Trigger Property="IsMouseOver" Value="True">',
    '                                                <Setter Property="ToolTip">',
    '                                                    <Setter.Value>',
    '                                                        <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                    </Setter.Value>',
    '                                                </Setter>',
    '                                            </Trigger>',
    '                                        </Style.Triggers>',
    '                                    </Style>',
    '                                </DataGrid.RowStyle>',
    '                                <DataGrid.Columns>',
    '                                    <DataGridTextColumn Header="Modified"',
    '                                                        Binding="{Binding Modified}"',
    '                                                        Width="135"/>',
    '                                    <DataGridTextColumn Header="Name"',
    '                                                        Binding="{Binding Name}"',
    '                                                        Width="*"/>',
    '                                    <DataGridTextColumn Header="Size"',
    '                                                        Binding="{Binding Size}"',
    '                                                        Width="80"/>',
    '                                    <DataGridTemplateColumn Header="&#x2714;"',
    '                                                            Width="20"',
    '                                                            IsReadOnly="False">',
    '                                        <DataGridTemplateColumn.CellTemplate>',
    '                                            <DataTemplate>',
    '                                                <CheckBox IsChecked="{Binding Selected, Mode=TwoWay, UpdateSourceTrigger=PropertyChanged}"',
    '                                                          Focusable="False"/>',
    '                                            </DataTemplate>',
    '                                        </DataGridTemplateColumn.CellTemplate>',
    '                                    </DataGridTemplateColumn>',
    '                                </DataGrid.Columns>',
    '                            </DataGrid>',
    '                            <Grid Grid.Row="4">',
    '                                <Grid.ColumnDefinitions>',
    '                                    <ColumnDefinition Width="120"/>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                </Grid.ColumnDefinitions>',
    '                                <Label Grid.Column="0"',
    '                                       Content="Fullname:"/>',
    '                                <TextBox Grid.Column="1"',
    '                                         Name="AssignmentSelectFullname"/>',
    '                            </Grid>',
    '                        </Grid>',
    '                    </TabItem>',
    '                    <TabItem Header="Edit">',
    '                        <Grid>',
    '                            <Grid.RowDefinitions>',
    '                                <RowDefinition Height="80"/>',
    '                                <RowDefinition Height="40"/>',
    '                                <RowDefinition Height="*"/>',
    '                                <RowDefinition Height="40"/>',
    '                            </Grid.RowDefinitions>',
    '                            <DataGrid Grid.Row="0"',
    '                                      Name="AssignmentEditSourceOutput"',
    '                                      ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                      AutoGenerateColumns="False"',
    '                                      IsReadOnly="True"',
    '                                      SelectionUnit="FullRow"',
    '                                      SelectionMode="Extended"',
    '                                      CanUserAddRows="False"',
    '                                      CanUserDeleteRows="False">',
    '                                <DataGrid.RowStyle>',
    '                                    <Style TargetType="{x:Type DataGridRow}">',
    '                                        <Style.Triggers>',
    '                                            <Trigger Property="IsMouseOver" Value="True">',
    '                                                <Setter Property="ToolTip">',
    '                                                    <Setter.Value>',
    '                                                        <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                    </Setter.Value>',
    '                                                </Setter>',
    '                                            </Trigger>',
    '                                        </Style.Triggers>',
    '                                    </Style>',
    '                                </DataGrid.RowStyle>',
    '                                <DataGrid.Columns>',
    '                                    <DataGridTextColumn Header="Modified"',
    '                                                        Binding="{Binding Modified}"',
    '                                                        Width="135"/>',
    '                                    <DataGridTextColumn Header="Name"',
    '                                                        Binding="{Binding Name}"',
    '                                                        Width="*"/>',
    '                                    <DataGridTextColumn Header="Source"',
    '                                                        Binding="{Binding Source}"',
    '                                                        Width="*"/>',
    '                                    <DataGridTextColumn Header="Size"',
    '                                                        Binding="{Binding Size}"',
    '                                                        Width="80"/>',
    '                                </DataGrid.Columns>',
    '                            </DataGrid>',
    '                            <Grid Grid.Row="1"',
    '                                      Name="AssignmentEditSourceHeader"',
    '                                      Visibility="Visible">',
    '                                <Grid.ColumnDefinitions>',
    '                                    <ColumnDefinition Width="0"/>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                    <ColumnDefinition Width="25"/>',
    '                                    <ColumnDefinition Width="70"/>',
    '                                </Grid.ColumnDefinitions>',
    '                                <Label Grid.Column="0"',
    '                                       Content="Source:">',
    '                                </Label>',
    '                                <TextBox Grid.Column="1"',
    '                                             Name="AssignmentEditSourcePathText"/>',
    '                                <Image Grid.Column="2"',
    '                                              Name="AssignmentEditSourcePathIcon"/>',
    '                                <Button Grid.Column="3"',
    '                                            Name="AssignmentEditSourcePathAssign"',
    '                                            Content="Assign"',
    '                                            ToolTip="Open "/>',
    '                            </Grid>',
    '                            <TabControl Grid.Row="2">',
    '                                <TabItem Header="Details">',
    '                                    <Grid>',
    '                                        <Grid.RowDefinitions>',
    '                                            <RowDefinition Height="100"/>',
    '                                            <RowDefinition Height="*"/>',
    '                                        </Grid.RowDefinitions>',
    '                                        <DataGrid Grid.Row="0"',
    '                                                  Name="AssignmentEditProperty"',
    '                                                  HeadersVisibility="None"',
    '                                                  SelectionMode="Single">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="&lt;Q3ALive.AssignmentEdit.Detail&gt;"',
    '                                                               TextWrapping="Wrap"',
    '                                                               FontFamily="Consolas"',
    '                                                               Background="#000000"',
    '                                                               Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="Name"',
    '                                                    Binding="{Binding Name}"',
    '                                                    Width="60"/>',
    '                                                <DataGridTextColumn Header="Value"',
    '                                                    Binding="{Binding Value}"',
    '                                                    Width="*"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                        <DataGrid Grid.Row="1"',
    '                                                  Name="AssignmentEditReference"',
    '                                                  HeadersVisibility="Column"',
    '                                                  SelectionMode="Single"',
    '                                                  RowHeaderWidth="0"',
    '                                                  ScrollViewer.VerticalScrollBarVisibility="Visible"',
    '                                                  ClipToBounds="True">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="&lt;Q3ALive.Map.Detail&gt;"',
    '                                                               TextWrapping="Wrap"',
    '                                                               FontFamily="Consolas"',
    '                                                               Background="#000000"',
    '                                                               Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="Reference"',
    '                                                    Binding="{Binding DisplayName}"',
    '                                                    Width="*"/>',
    '                                                <DataGridCheckBoxColumn Header="Default"',
    '                                                Binding="{Binding IsDefault}"',
    '                                                Width="55"/>',
    '                                                <DataGridCheckBoxColumn Header="Texture"',
    '                                                Binding="{Binding IsTexture}"',
    '                                                Width="55"/>',
    '                                                <DataGridCheckBoxColumn Header="Virtual"',
    '                                                Binding="{Binding IsVirtual}"',
    '                                                Width="55"/>',
    '                                                <DataGridCheckBoxColumn Header="Shader"',
    '                                                Binding="{Binding IsShader}"',
    '                                                Width="55"/>',
    '                                                <DataGridCheckBoxColumn Header="/Shader"',
    '                                                Binding="{Binding IsSubshader}"',
    '                                                Width="55"/>',
    '                                                <DataGridCheckBoxColumn Header="Missing"',
    '                                                Binding="{Binding IsMissing}"',
    '                                                Width="55"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                    </Grid>',
    '                                </TabItem>',
    '                                <TabItem Header="Output">',
    '                                    <Grid>',
    '                                        <Grid.RowDefinitions>',
    '                                            <RowDefinition Height="*"/>',
    '                                        </Grid.RowDefinitions>',
    '                                        <DataGrid Grid.Row="1"',
    '                                                  Name="AssignmentEditSourceDirectory"',
    '                                                  SelectionMode="Single">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridTextColumn Header="Label"',
    '                                                                    Binding="{Binding Label}"',
    '                                                                    Width="70"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    Width="70"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                    </Grid>',
    '                                </TabItem>',
    '                                <TabItem Header="Shader">',
    '                                    <Grid>',
    '                                        <Grid.RowDefinitions>',
    '                                            <RowDefinition Height="85"/>',
    '                                            <RowDefinition Height="85"/>',
    '                                            <RowDefinition Height="*"/>',
    '                                        </Grid.RowDefinitions>',
    '                                        <DataGrid Grid.Row="0"',
    '                                      Name="AssignmentEditSourceShaderOutput"',
    '                                      ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                      AutoGenerateColumns="False"',
    '                                      IsReadOnly="True"',
    '                                      SelectionUnit="FullRow"',
    '                                      SelectionMode="Extended"',
    '                                      CanUserAddRows="False"',
    '                                      CanUserDeleteRows="False">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                        Binding="{Binding Modified}"',
    '                                                        Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                        Binding="{Binding DisplayName}"',
    '                                                        Width="*"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                        Binding="{Binding Size}"',
    '                                                        Width="70"/>',
    '                                                <DataGridCheckBoxColumn Header="Used"',
    '                                                                        Binding="{Binding IsReferenced}"',
    '                                                                        Width="55"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                        <DataGrid Grid.Row="1"',
    '                                                  Name="AssignmentEditSourceShaderItemOutput"',
    '                                                  AutoGenerateColumns="False"',
    '                                                  IsReadOnly="True"',
    '                                                  SelectionUnit="FullRow"',
    '                                                  SelectionMode="Extended"',
    '                                                  CanUserAddRows="False"',
    '                                                  CanUserDeleteRows="False">',
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
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridCheckBoxColumn Header="Texture"',
    '                                                                        Binding="{Binding IsTexture}"',
    '                                                                        Width="55"/>',
    '                                                <DataGridCheckBoxColumn Header="Virtual"',
    '                                                                        Binding="{Binding IsVirtual}"',
    '                                                                        Width="55"/>',
    '                                                <DataGridCheckBoxColumn Header="Used"',
    '                                                                        Binding="{Binding IsReferenced}"',
    '                                                                        Width="55"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                        <DataGrid Grid.Row="2"',
    '                                                  Name="AssignmentEditSourceShaderItemContent"',
    '                                                  SelectionMode="Extended"',
    '                                                  HeadersVisibility="None">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="&lt;Q3ALive.Dependency.ItemProperty&gt;"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="#"',
    '                                                                    Binding="{Binding Index}"',
    '                                                                    Width="50"/>',
    '                                                <DataGridTextColumn Header="Line"',
    '                                                                    Binding="{Binding Line}"',
    '                                                                    Width="*"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                    </Grid>',
    '                                </TabItem>',
    '                                <TabItem Header="Texture">',
    '                                    <Grid>',
    '                                        <Grid.RowDefinitions>',
    '                                            <RowDefinition Height="*"/>',
    '                                            <RowDefinition Height="50"/>',
    '                                        </Grid.RowDefinitions>',
    '                                        <DataGrid Grid.Row="0"',
    '                                      Name="AssignmentEditSourceTextureOutput"',
    '                                      ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                      AutoGenerateColumns="False"',
    '                                      IsReadOnly="True"',
    '                                      SelectionUnit="FullRow"',
    '                                      SelectionMode="Extended"',
    '                                      CanUserAddRows="False"',
    '                                      CanUserDeleteRows="False">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                        Binding="{Binding Modified}"',
    '                                                        Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                        Binding="{Binding DisplayName}"',
    '                                                        Width="2*"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                        Binding="{Binding Size}"',
    '                                                        Width="70"/>',
    '                                                <DataGridCheckBoxColumn Header="Used"',
    '                                                                        Binding="{Binding IsReferenced}"',
    '                                                                        Width="55"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                        <DataGrid Grid.Row="1"',
    '                                      Name="AssignmentEditSourceTextureProperty"',
    '                                      ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                      AutoGenerateColumns="False"',
    '                                      IsReadOnly="True"',
    '                                      SelectionUnit="FullRow"',
    '                                      SelectionMode="Extended"',
    '                                      CanUserAddRows="False"',
    '                                      CanUserDeleteRows="False">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="Reference"',
    '                                                        Binding="{Binding Reference}"',
    '                                                        Width="*"/>',
    '                                                <DataGridTextColumn Header="Name"',
    '                                                        Binding="{Binding Name}"',
    '                                                        Width="*"/>',
    '                                                <DataGridTextColumn Header="Label"',
    '                                                        Binding="{Binding Label}"',
    '                                                        Width="50"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                    </Grid>',
    '                                </TabItem>',
    '                                <TabItem Header="Map">',
    '                                    <Grid>',
    '                                        <Grid.RowDefinitions>',
    '                                            <RowDefinition Height="*"/>',
    '                                        </Grid.RowDefinitions>',
    '                                        <DataGrid Grid.Row="1"',
    '                                                  Name="AssignmentEditSourceMapOutput"',
    '                                                  SelectionMode="Single">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    Width="70"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                    </Grid>',
    '                                </TabItem>',
    '                                <TabItem Header="Levelshot">',
    '                                    <Grid>',
    '                                        <Grid.RowDefinitions>',
    '                                            <RowDefinition Height="75"/>',
    '                                            <RowDefinition Height="*"/>',
    '                                            <RowDefinition Height="40"/>',
    '                                        </Grid.RowDefinitions>',
    '                                        <DataGrid Grid.Row="0"',
    '                                      Name="AssignmentEditSourceLevelshotOutput"',
    '                                      ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                      AutoGenerateColumns="False"',
    '                                      IsReadOnly="True"',
    '                                      SelectionUnit="FullRow"',
    '                                      SelectionMode="Extended"',
    '                                      CanUserAddRows="False"',
    '                                      CanUserDeleteRows="False">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    Width="70"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                        <Image Grid.Row="1"',
    '                                               Name="AssignmentEditSourceLevelshotImage"/>',
    '                                        <Grid Grid.Row="2">',
    '                                            <Grid.ColumnDefinitions>',
    '                                                <ColumnDefinition Width="*"/>',
    '                                                <ColumnDefinition Width="90"/>',
    '                                                <ColumnDefinition Width="*"/>',
    '                                            </Grid.ColumnDefinitions>',
    '                                            <Button Grid.Column="1"',
    '                                                    Content="Import"',
    '                                                    Name="AssignmentEditSourceLevelshotImport"/>',
    '                                        </Grid>',
    '                                    </Grid>',
    '                                </TabItem>',
    '                                <TabItem Header="Arena">',
    '                                    <Grid>',
    '                                        <Grid.RowDefinitions>',
    '                                            <RowDefinition Height="90"/>',
    '                                            <RowDefinition Height="*"/>',
    '                                        </Grid.RowDefinitions>',
    '                                        <DataGrid Grid.Row="0"',
    '                                      Name="AssignmentEditSourceArenaOutput"',
    '                                      ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                      AutoGenerateColumns="False"',
    '                                      IsReadOnly="True"',
    '                                      SelectionUnit="FullRow"',
    '                                      SelectionMode="Extended"',
    '                                      CanUserAddRows="False"',
    '                                      CanUserDeleteRows="False">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    Width="70"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                        <TextBox Grid.Row="1"',
    '                                                 Name="AssignmentEditSourceArenaContent"',
    '                                                 VerticalAlignment="Top"',
    '                                                 VerticalContentAlignment="Top"',
    '                                                 AcceptsReturn="True"',
    '                                                 Height="175">',
    '                                        </TextBox>',
    '                                    </Grid>',
    '                                </TabItem>',
    '                                <TabItem Header="Model">',
    '                                    <DataGrid Grid.Row="0"',
    '                                      Name="AssignmentEditSourceModelOutput"',
    '                                      ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                      AutoGenerateColumns="False"',
    '                                      IsReadOnly="True"',
    '                                      SelectionUnit="FullRow"',
    '                                      SelectionMode="Extended"',
    '                                      CanUserAddRows="False"',
    '                                      CanUserDeleteRows="False">',
    '                                        <DataGrid.RowStyle>',
    '                                            <Style TargetType="{x:Type DataGridRow}">',
    '                                                <Style.Triggers>',
    '                                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                                        <Setter Property="ToolTip">',
    '                                                            <Setter.Value>',
    '                                                                <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                            </Setter.Value>',
    '                                                        </Setter>',
    '                                                    </Trigger>',
    '                                                </Style.Triggers>',
    '                                            </Style>',
    '                                        </DataGrid.RowStyle>',
    '                                        <DataGrid.Columns>',
    '                                            <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                            <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                            <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    Width="70"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"/>',
    '                                        </DataGrid.Columns>',
    '                                    </DataGrid>',
    '                                </TabItem>',
    '                                <TabItem Header="Sound">',
    '                                    <DataGrid Grid.Row="0"',
    '                                      Name="AssignmentEditSourceSoundOutput"',
    '                                      ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                      AutoGenerateColumns="False"',
    '                                      IsReadOnly="True"',
    '                                      SelectionUnit="FullRow"',
    '                                      SelectionMode="Extended"',
    '                                      CanUserAddRows="False"',
    '                                      CanUserDeleteRows="False">',
    '                                        <DataGrid.RowStyle>',
    '                                            <Style TargetType="{x:Type DataGridRow}">',
    '                                                <Style.Triggers>',
    '                                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                                        <Setter Property="ToolTip">',
    '                                                            <Setter.Value>',
    '                                                                <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                            </Setter.Value>',
    '                                                        </Setter>',
    '                                                    </Trigger>',
    '                                                </Style.Triggers>',
    '                                            </Style>',
    '                                        </DataGrid.RowStyle>',
    '                                        <DataGrid.Columns>',
    '                                            <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                            <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                            <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    Width="70"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"/>',
    '                                        </DataGrid.Columns>',
    '                                    </DataGrid>',
    '                                </TabItem>',
    '                                <TabItem Header="Music">',
    '                                    <DataGrid Grid.Row="0"',
    '                                      Name="AssignmentEditSourceMusicOutput"',
    '                                      ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                      AutoGenerateColumns="False"',
    '                                      IsReadOnly="True"',
    '                                      SelectionUnit="FullRow"',
    '                                      SelectionMode="Extended"',
    '                                      CanUserAddRows="False"',
    '                                      CanUserDeleteRows="False">',
    '                                        <DataGrid.RowStyle>',
    '                                            <Style TargetType="{x:Type DataGridRow}">',
    '                                                <Style.Triggers>',
    '                                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                                        <Setter Property="ToolTip">',
    '                                                            <Setter.Value>',
    '                                                                <TextBlock Text="{Binding Fullname}"',
    '                                                           TextWrapping="Wrap"',
    '                                                           FontFamily="Consolas"',
    '                                                           Background="#000000"',
    '                                                           Foreground="#00FF00"/>',
    '                                                            </Setter.Value>',
    '                                                        </Setter>',
    '                                                    </Trigger>',
    '                                                </Style.Triggers>',
    '                                            </Style>',
    '                                        </DataGrid.RowStyle>',
    '                                        <DataGrid.Columns>',
    '                                            <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                            <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                            <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    Width="70"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"/>',
    '                                        </DataGrid.Columns>',
    '                                    </DataGrid>',
    '                                </TabItem>',
    '                            </TabControl>',
    '                            <Grid Grid.Row="3">',
    '                                <Grid.ColumnDefinitions>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                    <ColumnDefinition Width="2*"/>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                </Grid.ColumnDefinitions>',
    '                                <Button Grid.Column="0"',
    '                                Name="AssignmentEditCompile"',
    '                                Content="Compile"',
    '                                ToolTip="Compile the (*.map) file into (*.bsp) + (*.aas) files"/>',
    '                                <Button Grid.Column="1"',
    '                                Name="AssignmentEditPackage"',
    '                                Content="Package"',
    '                                ToolTip="Package a (*.pk3) based on all files in map asset folder"/>',
    '                                <Button Grid.Column="2"',
    '                                Name="AssignmentEditTransfer"',
    '                                Content="Transfer"',
    '                                ToolTip="Transfer the (*.pk3) to Q3A + QL base directories to (compile/playtest)"/>',
    '                                <TextBox Grid.Column="3"',
    '                                 Name="AssignmentEditPlayText"',
    '                                 ToolTip="Set :&lt;starting criteria&gt; for Quake Live"/>',
    '                                <Button Grid.Column="4"',
    '                                Name="AssignmentEditPlayButton"',
    '                                Content="Play"',
    '                                ToolTip="Play the (*.pk3) in specific mode"/>',
    '                                <Button Grid.Column="5"',
    '                                Name="AssignmentEditPublish"',
    '                                Content="Publish"',
    '                                ToolTip="Select this (*.pk3) to enable Steam tab and access workshop controls"/>',
    '                            </Grid>',
    '                        </Grid>',
    '                    </TabItem>',
    '                    <TabItem Header="Extract">',
    '                        <Grid>',
    '                            <Grid.RowDefinitions>',
    '                                <RowDefinition Height="40"/>',
    '                                <RowDefinition Height="*"/>',
    '                            </Grid.RowDefinitions>',
    '                        </Grid>',
    '                     </TabItem>',
    '                    <TabItem Header="Decompile">',
    '                        <Grid>',
    '                            <Grid.RowDefinitions>',
    '                                <RowDefinition Height="40"/>',
    '                                <RowDefinition Height="*"/>',
    '                            </Grid.RowDefinitions>',
    '                        </Grid>',
    '                    </TabItem>',
    '                    <TabItem Header="Compile">',
    '                        <Grid>',
    '                            <Grid.RowDefinitions>',
    '                                <RowDefinition Height="40"/>',
    '                                <RowDefinition Height="*"/>',
    '                            </Grid.RowDefinitions>',
    '                        </Grid>',
    '                    </TabItem>',
    '                    <TabItem Header="Package">',
    '                        <Grid>',
    '                            <Grid.RowDefinitions>',
    '                                <RowDefinition Height="40"/>',
    '                                <RowDefinition Height="*"/>',
    '                            </Grid.RowDefinitions>',
    '                        </Grid>',
    '                    </TabItem>',
    '                </TabControl>',
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
            Component
            {
                "Q3A Live"
            }
            Settings
            {
                "Workspace Credential Workshop"
            }
            Radiant
            {
                "GtkRadiant NetRadiant NetRadiant-Custom"
            }
            Dependency
            {
                "7Zip ImageMagick Q3ASE Steam"
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

<#
    ____    ____________________________________________________________________________________________________        
   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
   \\__//¯¯¯ Component [~]                                                                                  ___//¯¯\\   
    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
#>

Class Q3ALiveComponentItem
{
    [UInt32] $Index
    [String] $Name
    [String] $Fullname
    [UInt32] $Installed
    [UInt32] $Selected
    [String] $Base
    [String] $Executable
    Q3ALiveComponentItem([UInt32]$Index,[String]$Name)
    {
        $This.Index      = $Index
        $This.Name       = $Name

        $This.Fullname   = "<not set>"
        $This.Base       = "<not set>"
        $This.Executable = "<not set>"
    }
    Assign([String]$Fullname)
    {
        If ([System.IO.Directory]::Exists($Fullname))
        {
            $This.Fullname   = $Fullname
            $This.Base       = "$Fullname\baseq3"
            $This.Executable = "$Fullname\{0}.exe" -f $This.Engine()

            If ([System.IO.File]::Exists($This.Executable))
            {
                $This.Installed = 1
            }
        }
    }
    [String] Engine()
    {
        Return @{ Q3A = "quake3"; Live = "quakelive_steam" }[$This.Name]
    }
    [String] ToString()
    {
        Return "<Q3ALive.Component.Item>"
    }
}

Class Q3ALiveComponentList
{
    [Object] $Output
    Q3ALiveComponentList()
    {
        $This.Refresh()
    }
    Clear()
    {
        $This.Output = @()
    }
    Refresh()
    {
        $This.Clear()

        ForEach ($Name in "Q3A","Live")
        {
            $This.Add($Name)
        }
    }
    Assign([String]$Name,[String]$Fullname)
    {
        $Item = $This.Output | ? Name -eq $Name
        If ($Item)
        {
            $Item.Assign($Fullname)
        }
    }
    Add([String]$Name)
    {
        $This.Output += $This.Q3ALiveComponentItem($This.Output.Count,$Name)
    }
    [Object] Q3ALiveComponentItem([UInt32]$Index,[String]$Name)
    {
        Return [Q3ALiveComponentItem]::New($Index,$Name)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Component.List>"
    }
}

Class Q3ALiveRadiantItem
{
    [UInt32] $Index
    [String] $Name
    [String] $Fullname
    [UInt32] $Installed
    [UInt32] $Selected
    [Object] $Output
    [String] $Editor
    [String] $Q3Map2
    [String] $Bspc
    Q3ALiveRadiantItem([UInt32]$Index,[String]$Name)
    {
        $This.Index    = $Index
        $This.Name     = $Name

        $This.Clear()
    }
    Assign([String]$Fullname)
    {
        If ([System.IO.Directory]::Exists($Fullname))
        {
            $This.Fullname = $Fullname

            $This.Refresh()

            $This.Editor = $This.Output | ? Name -match "radiant.exe" | % Fullname

            $xQ3Map2     = $This.Output | ? Name -eq "q3map2.exe" | % Fullname

            If ($xQ3Map2.Count -gt 1)
            {
                $This.Q3Map2 = $xQ3Map2 | ? { $_ -match "x64" }
            }
            Else
            {
                $This.Q3Map2 = $xQ3Map2
            }

            $This.Bspc   = $This.Output | ? Name -match "bspc.exe" | % Fullname

            If ($This.Editor -and $This.Bspc -and $This.Q3Map2)
            {
                $This.Installed = 1
            }
        }
    }
    Clear()
    {
        $This.Editor   = "<not set>"
        $This.Q3Map2   = "<not set>"
        $This.Bspc     = "<not set>"
        $This.Output   = @( )
    }
    Refresh()
    {
        $This.Clear()

        $Hash = @{ }
        ForEach ($Item in Get-ChildItem $This.Fullname -Recurse)
        {
            $Hash.Add($Hash.Count,$Item)
        }

        $This.Output   = $Hash[0..($Hash.Count-1)]
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
        $This.Clear()
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
    Q3ALiveDependencyList([String]$Fullname)
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
    [Object] Current()
    {
        If ($This.Selected -in $This.Output.Index)
        {
            Return $This.Output[$This.Selected]
        }
        Else
        {
            Return $Null
        }
    }
    [String] ToString()
    {
        Return "<Q3ALive.Dependency.Master>"
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
    Hidden [UInt32]  $Index
    [String]          $Name
    [String]       $Created
    [String]      $Modified
    [Object]          $Size
    [String]      $Fullname
    [UInt32]      $Selected
    [Object]        $Output
    Q3ALiveWorkspaceEntry([UInt32]$Index,[Object]$Object)
    {
        $This.Index    = $Index
        $This.Name     = $Object.Name
        $This.Fullname = $Object.Fullname
        $This.Modified = $Object.LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss")
        $This.Created  = $Object.CreationTime.ToString("MM/dd/yyyy HH:mm:ss")

        $This.Refresh()
    }
    Refresh()
    {
        $This.Size     = $Null
        $This.Clear()

        $Bytes         = 0
        $Hash          = @{ }
        ForEach ($Item in Get-ChildItem $This.Fullname -File -Recurse)
        {
            $Hash.Add($Hash.Count,$Item)
            $Bytes     = $Bytes + $Item.Length
        }

        $This.Size     = $This.Q3ALiveByteSize($Bytes)
        $This.Output   = Switch ($Hash.Count)
        {
            Default { $Hash[0..($Hash.Count-1)] } 0 { @( ) } 1 { $Hash[0] }
        }
    }
    Clear()
    {
        $This.Size     = $Null
        $This.Output   = @( )
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
    [String]       $Type
    [String]   $Fullname
    [UInt32]     $Exists
    [DateTime]     $Date
    [DateTime]  $Created
    [DateTime] $Modified
    [UInt32]      $Count
    [Object]     $Output
    Q3ALiveWorkspaceLog([String]$Path)
    {
        $This.Type     = "Log"
        $This.Fullname = $Path
        $This.Check()

        If (!$This.Exists)
        {
            $This.Create()
        }
        
        $This.Refresh()
    }
    Check()
    {
        $This.Exists = [UInt32][System.IO.File]::Exists($This.Fullname)
    }
    [Object] Q3ALiveWorkspaceLogEntry([UInt32]$Index,[String]$Line)
    {
        Return [Q3ALiveWorkspaceLogEntry]::New($Index,$Line)
    }
    Refresh()
    {
        If ($This.Exists)
        {
            $Lines       = [System.IO.File]::ReadAllLines($This.Fullname)
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

        $This.Count = $This.Output.Count
    }
    Create()
    {
        If (![System.IO.File]::Exists($This.Log.Fullname))
        {
            $Content    = "{0} {1} {2}" -f [DateTime]::Now.ToString("MM/dd/yyyy HH:mm:ss"), "X".PadLeft(32,"X"), $This.Fullname
            [System.IO.File]::WriteAllLines($This.Log.Fullname,$Content)
            $This.Check()
        }
    }
    [String] LogHeader()
    {
        Return "Date       Time     Hash                             Source"
    }
    [String] ToString()
    {
        Return $This.Fullname
    }
}

Class Q3ALiveWorkspace
{
    [String]     $Name
    [String] $Fullname
    [Object]     $Size
    [Object]      $Log
    [Object]   $Output
    Q3ALiveWorkspace()
    {
        $This.Name     = "Workspace"
    }
    Assign([String]$Fullname)
    {
        If ([System.IO.Directory]::Exists($Fullname))
        {
            $This.Fullname = $Fullname
            $This.Log      = $This.Q3ALiveWorkspaceLog("$($This.Fullname)\Q3ALive-workspace.log")
            $This.Refresh()
        }
    }
    [Object] Q3ALiveWorkspaceLog([String]$Fullname)
    {
        Return [Q3ALiveWorkspaceLog]::New($Fullname)
    }
    [Object[]] GetDirectories()
    {
        Return [System.IO.DirectoryInfo]::new($This.Fullname).EnumerateDirectories()
    }
    [Object[]] GetFiles()
    {
        Return [System.IO.DirectoryInfo]::new($This.Fullname).EnumerateFiles()
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALiveByteSize]::New("Workspace",$Bytes)
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
                 $This.Output = @( )
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

        $Tree        = Get-ChildItem $This.Fullname -Directory
        ForEach ($Item in $Tree)
        {            
            $Entries.Add($Entries.Count,$This.Q3ALiveWorkspaceEntry($Entries.Count,$Item))
        }

        $xOutput    = Switch ($Entries.Count)
        {
            0       { @( )                            }
            1       { $Entries[0]                     }
            Default { $Entries[0..($Entries.Count-1)] }
        }

        $This.Output = $xOutput | Sort-Object Fullname
        $xSize       = 0
        ForEach ($Item in $This.Output)
        {
            $xSize   = $xSize + $Item.Size.Bytes
        }

        $This.Size   = $This.Q3ALiveByteSize($xSize)

        $This.Rerank()
    }
    [String] ToString()
    {
        Return "<Q3ALive.Workspace>"
    }
}

<#
    ____    ____________________________________________________________________________________________________        
   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
   \\__//¯¯¯ Assignment [~]                                                                                 ___//¯¯\\   
    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
#>

Enum Q3ALiveAssignmentEditAssetType
{
    levelshots
    maps
    models
    music
    scripts
    sound
    textures
}

Enum Q3ALiveDefaultShadersType
{
    base_button
    base_door
    base_floor
    base_light
    base_object
    base_support
    base_trim
    base_wall
    common
    ctf
    gothic_block
    gothic_button
    gothic_door
    gothic_floor
    gothic_light
    gothic_trim
    gothic_wall
    liquids
    models
    organics
    sfx
    skin
    skies
}

Class Q3ALiveAssignmentSubshader
{
    [String] $Shader
    [String] $Name
    [String] $DisplayName
    [UInt32] $IsDefault
    [UInt32] $IsMissing
    [String] $Fullname
    [UInt32] $Exists
    Q3ALiveAssignmentSubshader([String]$DisplayName)
    {
        $This.DisplayName = $DisplayName
        $This.Name        = $DisplayName | Split-Path -Leaf
        $This.Shader      = $DisplayName | Split-Path
        $This.Fullname    = "\scripts\{0}.shader" -f $This.Shader
    }
    Check()
    {
        $This.Exists      = [System.IO.File]::New($This.Fullname)
    }
    [String] ToString()
    {
        Return $This.DisplayName
    }
}

Class Q3ALiveAssignmentShaderItemLine
{
    [UInt32] $Index
    [String] $Line
    Q3ALiveAssignmentShaderItemLine([UInt32]$Index,[String]$Line)
    {
        $This.Index = $Index
        $This.Line  = $Line
    }
    [String] ToString()
    {
        Return $This.Line
    }
}

Class Q3ALiveAssignmentShaderItemFormat
{
    [UInt32] $Index
    [String] $DisplayName
    [Object] $Content
    Q3ALiveAssignmentShaderItemFormat([UInt32]$Index,[String]$DisplayName)
    {
        $This.Index       = $Index
        $This.DisplayName = $DisplayName
        $This.Content     = @( )
    }
    Add([String]$Line)
    {
        $This.Content += $This.Q3ALiveAssignmentShaderItemLine($This.Content.Count,$Line)
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

        $Start = $This.Content | ? Line -match "    {" | Select-Object -First 1 | % Index
        
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
    [Object] Q3ALiveAssignmentShaderItemLine([UInt32]$Index,[String]$Line)
    {
        Return [Q3ALiveAssignmentShaderItemLine]::New($Index,$Line)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Assignment.Shader.Item.Format>"
    }
}

Class Q3ALiveAssignmentShaderItem
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
    Q3ALiveAssignmentShaderItem([UInt32]$Index,[String]$DisplayName)
    {
        $This.Index       = $Index
        $This.DisplayName = $DisplayName.Replace("textures/","")
        $This.Name        = $DisplayName | Split-Path -Leaf
        $This.Fullname    = $DisplayName
        $This.Subshader   = @( )
        $This.Content     = @( )
    }
    Add([String]$Line)
    {
        $This.Content    += $This.Q3ALiveAssignmentShaderItemLine($This.Content.Count,$Line)
    }
    GetSubshader()
    {
        [Console]::WriteLine("Shader [~] $($This.DisplayName)")

        $This.Subshader   = @( )

        $xSubshader       = $This.Content | ? { $_ -match "textures\/\S+" }
        If ($xSubshader.Count -gt 0)
        {
            $Filter       = $xSubshader | % { [Regex]::Matches($_,"textures\S+").Value.TrimEnd(" ") }
            $Filter       = $Filter.Replace("textures/","").Replace(".tga","") | Select-Object -Unique

            $This.Subshader = @($Filter | % { $This.Q3ALiveAssignmentSubshader($_) })
        }
    }
    [Object] Q3ALiveAssignmentShaderItemLine([UInt32]$Index,[String]$Line)
    {
        Return [Q3ALiveAssignmentShaderItemLine]::New($Index,$Line)
    }
    [Object] Q3ALiveAssignmentSubshader([String]$DisplayName)
    {
        Return [Q3ALiveAssignmentSubshader]::New($DisplayName)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Assignment.Shader.Item>"
    }
}

Class Q3ALiveAssignmentShaderFileLine
{
    [UInt32]      $Index
    [Int32] $ShaderIndex
    [String]       $Line
    Q3ALiveAssignmentShaderFileLine([UInt32]$Index,[Int32]$ShaderIndex,[String]$Line)
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

Class Q3ALiveAssignmentShaderFileItem
{
    [UInt32] $Index
    [String] $Type
    [String] $Modified
    [String] $Name
    [String] $Shader
    [String] $DisplayName
    [Object] $Size
    [String] $Fullname
    [UInt32] $IsReferenced
    [Object] $Content
    [Object] $Output
    Q3ALiveAssignmentShaderFileItem([UInt32]$Index,[String]$Type,[Object]$Asset)
    {
        $This.Index       = $Index
        $This.Type        = $Type
        $This.Modified    = $Asset.Modified
        $This.Name        = $Asset.Name
        $This.Shader      = $Asset.Name -Replace ".shader",""
        $This.DisplayName = $Asset.DisplayName
        $This.Size        = $Asset.Size
        $This.Fullname    = $Asset.Fullname
        $This.Refresh()
    }
    Refresh()
    {
        $This.Content     = @( )
        $xContent         = $Null
        Switch -Regex ($This.Type)
        {
            "(File|Directory)"
            {
                $xContent   = [System.IO.File]::ReadAllLines($This.Fullname)
            }
            "(Stream|Archive)"
            {
                $xPath      = $This.Fullname.Replace($This.DisplayName,"")
                $xArchive   = [System.IO.Compression.ZipFile]::Open($xPath,"Read")
                $Entry      = $xArchive.Entries | ? Name -eq $This.Name
  
                $xContent   = ([System.IO.StreamReader]::New($Entry.Open()).ReadToEnd()) -split "`r?`n"
                $xArchive.Dispose()
            }
        }        

        # // Prepares the shader content format
        $yContent         = $xContent -Replace "\t"," " -Replace "^\s+" | ? { $_.Length -gt 0 } | ? { $_ -notmatch "^\s*\/\/" }
        $Shaders          = $yContent | ? { $_ -match "^(textures|models)" }

        $Hash = @{ }
        ForEach ($Line in $yContent)
        {
            If ($Line -in $Shaders)
            {
                $Hash.Add($Hash.Count,$This.Q3ALiveAssignmentShaderItemFormat($Hash.Count,$Line))
            }
                
            $Hash[$Hash.Count-1].Add($Line)
        }

        $Array = $Hash[0..($Hash.Count-1)]

        ForEach ($Item in $Array)
        {
            $Item.Format()
            $Item.Add("")
        }

        $xContent         = $Array.Content.Line

        # // Converts all formatted shader data into line by line objects
        $Hash             = @{ }
        $sContent         = @{ }
        $ShaderIndex      = -1
        ForEach ($Line in $xContent)
        {
            $Line = $Line.Replace("\t","    ")

            If ($Line -match "^(textures|models)")
            {
                $ShaderIndex ++
                $Hash.Add($Hash.Count,$This.Q3ALiveAssignmentShaderItem($Hash.Count,$Line))
            }

            $sContent.Add($sContent.Count,$This.Q3ALiveAssignmentShaderFileLine($sContent.Count,$ShaderIndex,$Line))
            If ($ShaderIndex -ge 0)
            {
                $Hash[$ShaderIndex].Add($Line)
            }
        }

        $This.Content = @(Switch ($sContent.Count) { 0 { } 1 { $sContent[0] } Default { $sContent[0..($sContent.Count-1)] } })

        $This.Output  = @(Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } })

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
        Return [System.Enum]::GetNames([Q3ALiveDefaultShadersType])
    }
    [Object] Q3ALiveAssignmentShaderItemFormat([UInt32]$Index,[String]$DisplayName)
    {
        Return [Q3ALiveAssignmentShaderItemFormat]::New($Index,$DisplayName)
    }
    [Object] Q3ALiveAssignmentShaderFileLine([UInt32]$Index,[Int32]$ShaderIndex,[String]$Line)
    {
        Return [Q3ALiveAssignmentShaderFileLine]::New($Index,$ShaderIndex,$Line)
    }
    [Object] Q3ALiveAssignmentShaderItem([UInt32]$Index,[Object[]]$Line)
    {
        Return [Q3ALiveAssignmentShaderItem]::New($Index,$Line)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Assignment.Shader.File.Item>"
    }
}

Class Q3ALiveAssignmentShaderFileList
{
    [String] $Type
    [Object] $Asset
    [Object] $File
    Q3ALiveAssignmentShaderFileList([String]$Type)
    {
        $This.Type = $Type
        $This.Clear()
    }
    Assign([Object[]]$Asset)
    {
        $This.Asset       = $Asset
        $This.Refresh()
    }
    Clear()
    {
        $This.File        = @( )
    }
    Refresh()
    {
        $This.Clear()

        $Hash = @{ } 

        ForEach ($Item in $This.Asset)
        {
            $Hash.Add($Hash.Count,$This.Q3ALiveAssignmentShaderFileItem($Hash.Count,$This.Type,$Item))
        }

        $This.File = @(Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } })
    }
    [String[]] DefaultShaders()
    {
        Return [System.Enum]::GetNames([Q3ALiveDefaultShadersType])
    }
    [Object] Get([String]$DisplayName)
    {
        Return $This.Shader.File.Output | ? DisplayName -eq $DisplayName
    }
    [Object] Q3ALiveAssignmentShaderFileItem([UInt32]$Index,[String]$Type,[Object]$Asset)
    {
        Return [Q3ALiveAssignmentShaderFileItem]::New($Index,$Type,$Asset)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Assignment.Shader.File.List>"
    }
}

Class Q3ALiveAssignmentTextureFileItem
{
    [UInt32]        $Index
    [String]         $Type
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
    Q3ALiveAssignmentTextureFileItem([UInt32]$Index,[Object]$Asset)
    {
        $This.Index       = $Index
        $This.Type        = $Asset.Type
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
        Return @{tga="Targa";jpg="Jpeg";png="Png"}[$This.Extension]
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALiveByteSize]::New("Texture",$Bytes)
    }
    [String] ReferenceString()
    {
        $xDisplayName =  $This.DisplayName -Replace "(\\textures\\|\.(tga|jpg|png))","" -Replace "\\", "/"
        
        Return $xDisplayName.TrimStart("/")
    }
    [String] Leaf()
    {
        Return "{0}.tga" -f $This.Reference
    }
    [String] ToString()
    {
        Return $This.Fullname
    }
}

Class Q3ALiveAssignmentTextureFileList
{
    [String] $Type
    [Object] $Asset
    [Object] $File
    Q3ALiveAssignmentTextureFileList([String]$Type)
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
            $Hash.Add($Hash.Count,$This.Q3ALiveAssignmentTextureFileItem($Hash.Count,$File))
        }

        $This.File = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } }
    }
    [Object] Q3ALiveAssignmentTextureFileItem([UInt32]$Index,[Object]$File)
    {
        Return [Q3ALiveAssignmentTextureFileItem]::New($Index,$File)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Assignment.Texture.File.List>"
    }
}

Class Q3ALiveAssignmentResourceArchiveEntry
{
    [UInt32]       $Index
    [String]        $Type
    [String]    $Modified
    [String]        $Name
    [String]   $Extension
    [String]       $Label
    [String] $DisplayName
    [String]   $Reference
    [Object]        $Size
    [String]    $Fullname
    [UInt32]      $Exists
    Q3ALiveAssignmentResourceArchiveEntry([UInt32]$Index,[String]$Source,[Object]$Entry)
    {
        $This.Index     = $Index
        $This.Type      = @("File","Directory")[$Entry.Length -eq 0]
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
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALiveByteSize]::New("Entry",$Bytes)
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
    Q3ALiveAssignmentResourceArchive([UInt32]$Index,[String]$Fullname)
    {
        $This.Index        = $Index
        $This.Type         = "Archive"
        $This.Fullname     = $Fullname
        $This.Name         = $Fullname | Split-Path -Leaf

        $This.Shader       = $This.Q3ALiveAssignmentShaderFileList("Stream")
        $This.Texture      = $This.Q3ALiveAssignmentTextureFileList("Stream")

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
                        $Hash.Add($Hash.Count,$This.Q3ALiveAssignmentResourceArchiveEntry($Hash.Count,$This.Fullname,$Entry))
                    }

                    $This.Output = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default {$Hash[0..($Hash.Count-1)] } }

                    $xArchive.Dispose()

                    # Process shaders
                    $xShader     = $This.Output | ? Extension -eq Shader
                    $This.Shader.Assign($xShader)

                    # Process textures
                    $xTexture    = $This.Output | ? Type -eq File | ? Label -eq Texture
                    $This.Texture.Assign($xTexture)
                }
            }
            Catch
            {

            }
        }
    }
    [Object] Q3ALiveAssignmentShaderFileList([String]$Type)
    {
        Return [Q3ALiveAssignmentShaderFileList]::New($Type)
    }
    [Object] Q3ALiveAssignmentTextureFileList([String]$Type)
    {
        Return [Q3ALiveAssignmentTextureFileList]::New($Type)
    }
    [Object] Q3ALiveAssignmentResourceArchiveEntry([UInt32]$Index,[String]$Source,[Object]$Entry)
    {
        Return [Q3ALiveAssignmentResourceArchiveEntry]::New($Index,$Source,$Entry)
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALiveByteSize]::New("Archive",$Bytes)
    }
}

Class Q3ALiveAssignmentResourceDirectoryAsset
{
    [UInt32]       $Index
    [String]        $Type
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
        Return [Q3ALiveByteSize]::New("Asset",$Bytes)
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
        $This.Shader   = $This.Q3ALiveAssignmentShaderFileList("File")
        $This.Texture  = $This.Q3ALiveAssignmentTextureFileList("File")

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

            $This.Output   = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } }
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
    [Object] Q3ALiveAssignmentShaderFileList([String]$Type)
    {
        Return [Q3ALiveAssignmentShaderFileList]::New($Type)
    }
    [Object] Q3ALiveAssignmentTextureFileList([String]$Type)
    {
        Return [Q3ALiveAssignmentTextureFileList]::New($Type)
    }
    [Object] Q3ALiveByteSize([UInt64]$Bytes)
    {
        Return [Q3ALiveByteSize]::New("Asset",$Bytes)
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
        $This.Modified  = "XX/XX/XXXX XX:XX:XX"
        $This.Name      = "<not set>"
        $This.Size      = $This.Q3ALiveByteSize(0)
        $This.Extension = $Null
        $This.Label     = $Null
        $This.Reference = $Null
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
        If ($This.Type -eq "Directory")
        {
            $Bytes = 0
        }

        Return [Q3ALiveByteSize]::New("Asset",$Bytes)
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

Class Q3ALiveAssignmentEditLevelshot
{
    [String] $Name
    [String] $Fullname
    [UInt32] $Exists
    Q3ALiveAssignmentEditLevelshot()
    {
        $This.Name     = "<not set>"
        $This.Fullname = "<not set>"
    }
    Assign([String]$Name,[String]$Fullname)
    {
        $this.Name     = $Name
        $this.Fullname = $Fullname
    }
    Check()
    {
        $This.Exists = [System.IO.File]::Exists($This.Fullname)
    }
    [String] ToString()
    {
        Return "<Q3ALive.AssignmentEdit.Levelshot>"
    }
}

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
        Return [Q3ALiveByteSize]::New("Asset",$Bytes)
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
        Return [Q3ALiveByteSize]::New("Archive",$Bytes)
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
        $This.Shader      = $This.Q3ALiveAssignmentShaderFileList("Directory")
        $This.Texture     = $This.Q3ALiveAssignmentTextureFileList("Directory")

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
    SetSource([String]$Source)
    {
        $This.Source      = $This.Q3ALiveAssignmentEditSourceDirectory("Source",$Source)

        $This.CheckAssetTypes("Source")

        $This.SourceRefresh()
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
    SourceRefresh()
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
            $xMap.QueryReferenceList()

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
        $Return = $This.Texture.File | ? Reference -eq $Reference.DisplayName
        If (!$Return)
        {
            Return $Null
        }
        Else
        {
            Return $Return
        }
    }
    CheckReference([Object]$Reference)
    {
        $xTextureFile     = $This.GetTextureFile($Reference)
        $xShaderFile      = $This.GetShaderFile($Reference)
        $xShaderItem      = $This.GetShaderItem($Reference)
        If ($xTextureFile -and $xShaderItem)
        {
            # Reference
            $Reference.IsTexture       = 1
            $Reference.IsShader        = 1

            # Texture File
            $xTextureFile.IsReferenced = 1

            # Shader File/Item
            $xShaderFile.IsReferenced  = 1
            $xShaderItem.IsReferenced  = 1
        }
        If ($xTextureFile -and !$xShaderItem)
        {
            # Reference
            $Reference.IsTexture       = 1

            # Texture file
            $xTextureFile.IsReferenced = 1

            # Shader File/Item $Null
        }
        If (!$xTextureFile -and $xShaderItem)
        {
            # Reference
            $Reference.IsShader        = 1
            $Reference.IsVirtual       = 1

            # Texture file $Null

            # Shader File/Item
            $xShaderFile.IsReferenced  = 1
            $xShaderItem.IsVirtual     = 1
        }
        If (!$xTextureFile -and !$xShaderItem)
        {
            # Reference
            $Reference.IsMissing = 1

            # Texture file $Null
        
            # Shader File/Item $Null
        }

        # Process subshaders
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
                        $xReference = $This.GetTextureFile("$xTexture`_$Flag")
                        $xReference.IsReferenced = 1
                        $xReference.IsSubshader  = 1
                    }
                }
            }
        
            ForEach ($Subshader in $xShaderItem.Subshader | ? IsDefault -eq 0)
            {
                $xSubShaderTexture = $This.Texture.File | ? Reference -eq $Subshader.DisplayName
                If ($xSubshaderTexture)
                {
                    $xSubshaderTexture.IsReferenced = 1
                    $xSubshaderTexture.IsSubshader  = 1
                    $xReference = $This.GetReference($Subshader.DisplayName)
                    If ($xReference)
                    {
                        $xReference.IsSubshader = 1
                    }
                }
            }
        }
    }
    QueryReferenceList()
    {
        $Default = $This.DefaultShaders()
        ForEach ($Reference in $This.Reference)
        {
            $Reference.IsDefault   = 0
            $Reference.IsShader    = 0
            $Reference.IsSubshader = 0
            $Reference.IsVirtual   = 0
            $Reference.IsTexture   = 0
            $Reference.IsMissing   = 0

            If ($Reference.Shader -in $Default)
            {
                $Reference.IsDefault = 1
            }
            Else
            {
                $This.CheckReference($Reference)
            }
        }
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
        Return [System.Enum]::GetNames([Q3ALiveAssignmentEditAssetType])
    }
    [String[]] DefaultShaders()
    {
        Return [System.Enum]::GetNames([Q3ALiveDefaultShadersType])
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
    [Object] Q3ALiveAssignmentShaderFileList([String]$Type)
    {
        Return [Q3ALiveAssignmentShaderFileList]::New($Type)
    }
    [Object] Q3ALiveAssignmentTextureFileList([String]$Type)
    {
        Return [Q3ALiveAssignmentTextureFileList]::New($Type)
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

# Controller

Class Q3ALiveController
{
    [Object] $Module     # Fighting Entropy module (manages logging for console)
    [Object] $Xaml       # GUI I/O (Xaml controls)
    [Object] $Resource   # Resource (dependencies + main logging)
    [Object] $Registry   # Registry (generates and manages persistent keys + properties)
    [Object] $Component  # Quake III Arena/Quake Live (could possibly accommodate other games)
    [Object] $Dependency # Various tools (some required)
    [Object] $Radiant    # Specifically controls Radiant
    [Object] $Workspace  # Source assets (handles archive logging)
    [Object] $Assignment # Used to orchestrate tasks related to selection and management of compilation and assets
    [Object] $Compile    # All of the options for compiling a particular map or array of maps
    [Object] $Asset      # Manages and handles all of the map assets to publish a single map, or multiple
    [Object] $Steam      # Manages the interactions with steamcmd.exe to publish work to the Steam Workshop
    Hidden [Object] $Notifier
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
        Return $This.DefaultLogPath()
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
    GetFEModule()
    {
        $This.Module   = $This.FEModule()
    }
    GetXaml()
    {
        $This.Update(0,"Loaded [~] Xaml")
        $This.Xaml     = $This.Q3ALiveXaml()
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
    GetComponent()
    {
        $This.Update(0,"Component [~] <List>")

        $This.Component = $This.Q3ALiveComponentList()
    }
    GetDependency()
    {
        $This.Update(0,"Dependency [~] <List>")

        $This.Dependency = $This.Q3ALiveDependencyList($This.DefaultDependencyPath())
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

        # Check the registry for installed apps
        $Hash           = @{ }
        $Filter         = "(^Quake III Arena$|^Quake Live|^7-Zip|^ImageMagick)"

        ForEach ($Item in $Ctrl.UninstallPath_x86_64() | % { Get-ItemProperty "$_\*" } | ? DisplayName -match $Filter)
        {
            $Hash.Add($Hash.Count,$Ctrl.Q3ALiveRegistryUninstall($Hash.Count,$Item))
        }

        $Uninstall     = $Hash[0..($Hash.Count-1)]

        $Hash = @{ 

            # Component
            Q3A        = $Ctrl.Registry.Component.Property  | ? Name -eq Q3A
            Live       = $Ctrl.Registry.Component.Property  | ? Name -eq Live

            # Dependency
            Zip        = $Ctrl.Registry.Dependency.Property | ? Name -eq 7Zip
            Magick     = $Ctrl.Registry.Dependency.Property | ? Name -eq ImageMagick
        }

        # Q3A (Detection/Component)
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

        # Live
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

        # 7Zip (Detection/Component)
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

        # ImageMagick (Detection/Component)
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
        $Ctrl.Component.Refresh()
        $Ctrl.Dependency.Refresh()
        $Ctrl.Radiant.Refresh()

        # Determine whether the registry settings are valid
        $Hash          = @{ 

            # Component ====================================================
            Q3A        = $Ctrl.Registry.Component.Property  | ? Name -eq Q3A
            Live       = $Ctrl.Registry.Component.Property  | ? Name -eq Live

            # Settings =========================================================
            Workspace  = $Ctrl.Registry.Settings.Property | ? Name -eq Workspace
            Credential = $Ctrl.Registry.Settings.Property | ? Name -eq Credential
            Workshop   = $Ctrl.Registry.Settings.Property | ? Name -eq Workshop

            # Radiant ==========================================================
            Gtk        = $Ctrl.Registry.Radiant.Property | ? Name -eq GtkRadiant
            Net        = $Ctrl.Registry.Radiant.Property | ? Name -eq NetRadiant
            Garux      = $Ctrl.Registry.Radiant.Property | ? Name -eq "NetRadiant-Custom"

            # Dependency =====================================================
            Zip        = $Ctrl.Registry.Dependency.Property | ? Name -eq 7Zip
            Magick     = $Ctrl.Registry.Dependency.Property | ? Name -eq ImageMagick
            ASE        = $Ctrl.Registry.Dependency.Property | ? Name -eq Q3ASE
            Steam      = $Ctrl.Registry.Dependency.Property | ? Name -eq Steam
        }

        # [Component]
        # Q3A
        Switch ($Hash.Q3A.Valid)
        {
            0
            {
                $Ctrl.Update(0,"Exception [!] <Quake III Arena not found>")
            }
            1
            {
                $Ctrl.Component.Assign("Q3A",$Hash.Q3A.Value)

                $Ctrl.Update(0,"Component [+] Quake III Arena: $($Hash.Q3A.Value)")
            }
        }

        # Live
        Switch ($Hash.Live.Valid)
        {
            0
            {
                $Ctrl.Update(0,"Exception [!] <Quake Live not found>")
            }
            1
            {
                $Ctrl.Component.Assign("Live",$Hash.Live.Value)

                $Ctrl.Update(0,"Component [+] Quake Live: $($Hash.Live.Value)")
            }
        }

        # [Settings]
        # Workspace
        If ($Hash.Workspace.Valid -and $Ctrl.Workspace.Fullname -ne $Hash.Workspace.Value)
        {
            $Path = $Hash.Workspace.Value

            $Ctrl.Update(0,"Workspace [~] Loading: $Path")

            $Ctrl.Workspace.Assign($Path)

            $Ctrl.Update(0,"Workspace [+] <Loaded>")
        }

        # Credential
        # Workshop

        # [Radiant]
        # GtkRadiant
        If ($Hash.Gtk.Valid)
        {
            $Path = $Hash.Gtk.Value

            $Ctrl.Dependency.Assign("GtkRadiant",$Path,"radiant.exe")

            $Ctrl.Radiant.Assign("GtkRadiant",$Path)

            $Ctrl.Update(0,"Radiant [+] GtkRadiant: $Path")
        }

        # NetRadiant
        If ($Hash.Net.Valid)
        {
            $Path = $Hash.Net.Value

            $Ctrl.Dependency.Assign("NetRadiant",$Path,"netradiant.exe")

            $Ctrl.Radiant.Assign("NetRadiant",$Path)

            $Ctrl.Update(0,"Radiant [+] GtkRadiant: $Path")
        }

        # NetRadiant-Custom
        If ($Hash.Garux.Valid)
        {
            $Path = $Hash.Garux.Value

            $Ctrl.Dependency.Assign("NetRadiant-Custom",$Path,"radiant.exe")

            $Ctrl.Radiant.Assign("NetRadiant-Custom",$Path)

            $Ctrl.Update(0,"Radiant [+] GtkRadiant: $Path")
        }

        # [Dependency]
        # 7-Zip Detection/Component
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

                $Ctrl.Update(0,"Dependency [+] 7-Zip: $Path")
            }
        }

        # ImageMagick
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

                $Ctrl.Update(0,"Dependency [+] ImageMagick: $Path")
            }
        }

        # Q3ASE
        If ($Hash.ASE.Valid)
        {
            $Path = $Hash.ASE.Value

            $Ctrl.Dependency.Assign("Q3ASE",$Path,"q3ase.exe")

            $Ctrl.Update(0,"Dependency [+] Q3ASE: $Path")
        }

        # Steam
        If ($Hash.Steam.Valid)
        {
            $Path = $Hash.Steam.Value

            $Ctrl.Dependency.Assign("Steam",$Path,"steamcmd.exe")

            $Ctrl.Update(0,"Dependency [+] Steam: $Path")
        }

        If ($Root)
        {
            # Xaml
            If ($Ctrl.Xaml)
            {
                # Config
                $Ctrl.Xaml.IO.ConfigInstall.IsEnabled   = 0
                $Ctrl.Xaml.IO.ConfigUninstall.IsEnabled = 1

                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigResource,$Ctrl.Resource)
                
                $Ctrl.Xaml.IO.ConfigRegistryPathText.Text = $Ctrl.Registry.Fullname

                $Ctrl.ConfigProperty()
                
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigComponent,  $Ctrl.Registry.Component.Property)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigSettings,   $Ctrl.Registry.Settings.Property)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigRadiant,    $Ctrl.Registry.Radiant.Property)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigDependency, $Ctrl.Registry.Dependency.Property)

                # Components
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentOutput,  $Ctrl.Component.Output)
                $Ctrl.Reset($Ctrl.Xaml.IO.RadiantOutput,    $Ctrl.Radiant.Output)
                $Ctrl.Reset($Ctrl.Xaml.IO.DependencyOutput, $Ctrl.Dependency.Output)

                # Workspace
                If ([System.IO.Directory]::Exists($Ctrl.Workspace.Fullname))
                {
                    $Ctrl.Xaml.IO.WorkspacePathText.Text      = $Ctrl.Workspace.Fullname

                    # Log
                    $Ctrl.Xaml.IO.WorkspaceLogPathText.Text   = $Ctrl.Workspace.Log.Fullname

                    $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceLogOutput,$Ctrl.Workspace.Log.Output)

                    # Output
                    If ($Ctrl.Workspace.Output -eq 0)
                    {
                        $Ctrl.Xaml.IO.WorkspaceOutputSizeText.Text = "<empty>"
                        $Ctrl.Xaml.IO.WorkspaceOutputRefresh.IsEnabled = 0
                        $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceOutput,$Null)
                    }
                    Else
                    {
                        $Ctrl.Xaml.IO.WorkspaceOutputSizeText.Text = "$($Ctrl.Workspace.Size)"
                        $Ctrl.Xaml.IO.WorkspaceOutputRefresh.IsEnabled = 1
                        $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceOutput,$Ctrl.Workspace.Output)
                    }
                }
                # Assignment (gonna have to clean this up later.)
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
                # Config
                $Ctrl.Xaml.IO.ConfigInstall.IsEnabled   = 1
                $Ctrl.Xaml.IO.ConfigUninstall.IsEnabled = 0

                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigResource,$Null)

                $Ctrl.Xaml.IO.ConfigRegistryPathText.Text = "<not installed>"

                $Ctrl.ConfigProperty()

                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigComponent,  $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigSettings,   $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigRadiant,    $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigDependency, $Null)

                # Component
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentOutput,  $Null)

                $Ctrl.Reset($Ctrl.Xaml.IO.DependencyOutput, $Null)

                # Workspace
                $Ctrl.Xaml.IO.WorkspacePathText.Text      = $Null

                #  - Log
                $Ctrl.Xaml.IO.WorkspaceLogPathText.Text   = $Null

                $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceLogOutput,$Null)

                #  - Output
                $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceOutput,$Null)
                $Ctrl.Xaml.IO.WorkspaceOutputSizeText.Text = "<empty>"
                $Ctrl.Xaml.IO.WorkspaceOutputRefresh.IsEnabled = 0
                $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceOutput,$Null)
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

        # Clear all bottom fields
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
    ComponentOutput()
    {
        $Ctrl = $This

        $Ctrl.Xaml.IO.RadiantOutput.SelectedIndex = -1
        $Ctrl.Xaml.IO.DependencyOutput.SelectedIndex = -1

        If ($Ctrl.Xaml.IO.ComponentOutput.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.ComponentOutput.SelectedItem
            $Flag = $Ctrl.CheckDirectory($Item.Fullname)

            $Ctrl.Xaml.IO.DependencyPathText.Text     = $Item.Fullname
            $Ctrl.Xaml.IO.DependencyPathIcon.Source   = $Ctrl.IconStatus($Flag)
            
            $Ctrl.Reset($Ctrl.Xaml.IO.DependencyProperty,$Ctrl.ComponentFilter($Item))
        }
    }
    ComponentSelect()
    {
        $Ctrl = $This
        
        If ($Ctrl.Xaml.IO.ComponentOutput.SelectedIndex -ne -1)
        {
            $Selected = $Ctrl.Xaml.IO.ComponentOutput.SelectedItem
            ForEach ($Item in $Ctrl.Xaml.IO.ComponentOutput.Items)
            {
                $Item.Selected = $Item.Index -eq $Selected.Index
            }

            $Ctrl.Registry.Game = $Selected.Name
            Set-ItemProperty -Path $Ctrl.Registry.Fullname -Name Game -Value $Selected.Name -Verbose
        }
    }
    RadiantOutput()
    {
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.RadiantOutput.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.RadiantOutput.SelectedItem
            $Flag = $Ctrl.CheckDirectory($Item.Fullname)

            $Ctrl.Xaml.IO.DependencyPathText.Text     = $Item.Fullname
            $Ctrl.Xaml.IO.DependencyPathIcon.Source   = $Ctrl.IconStatus($Flag)
            
            $Ctrl.Reset($Ctrl.Xaml.IO.DependencyProperty,$Ctrl.RadiantFilter($Item))
        }
    }
    RadiantSelect()
    {
        $Ctrl = $This
        
        If ($Ctrl.Xaml.IO.RadiantOutput.SelectedIndex -ne -1)
        {
            $Selected = $Ctrl.Xaml.IO.RadiantOutput.SelectedItem
            ForEach ($Item in $Ctrl.Xaml.IO.RadiantOutput.Items)
            {
                $Item.Selected = $Item.Index -eq $Selected.Index
            }

            $Ctrl.Registry.Editor = $Selected.Name
            Set-ItemProperty -Path $Ctrl.Registry.Fullname -Name Editor -Value $Selected.Name -Verbose
        }
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
    WorkspacePathText()
    {
        $Ctrl                    = $This

        $Text                    = $Ctrl.Xaml.Get("WorkspacePathText")
        $Icon                    = $Ctrl.Xaml.Get("WorkspacePathIcon")

        If ($Text.Control.Text -match "(^<not set>$|^$)")
        {
            $Text.Status         = 2
        }
        Else
        {
            $Text.Status         = [System.IO.Directory]::Exists($Text.Control.Text)
        }

        $Icon.Control.Source     = $Ctrl.IconStatus($Text.Status)
    }
    WorkspaceLogPathText()
    {
        $Ctrl                    = $This

        $Text                    = $Ctrl.Xaml.Get("WorkspaceLogPathText")
        $Icon                    = $Ctrl.Xaml.Get("WorkspaceLogPathIcon")

        If ($Text.Control.Text -match "(^<not set>$|^$)")
        {
            $Text.Status         = 2
        }
        Else
        {
            $Text.Status         = [System.IO.File]::Exists($Text.Control.Text)
        }

        $Icon.Control.Source     = $Ctrl.IconStatus($Text.Status)
    }
    WorkspaceOutputRefresh()
    {
        $Ctrl = $This

        $Ctrl.Update(0,"Refreshing [~] Workspace content")
        $Ctrl.Workspace.Refresh()

        If ($Ctrl.Workspace.Output -eq 0)
        {
            $Ctrl.Xaml.IO.WorkspaceOutputSizeText.Text = "<empty>"
            $Ctrl.Xaml.IO.WorkspaceOutputRefresh.IsEnabled = 0
            $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceOutput,$Null)
        }
        Else
        {
            $Ctrl.Xaml.IO.WorkspaceOutputSizeText.Text = "$($Ctrl.Workspace.Size)"
            $Ctrl.Xaml.IO.WorkspaceOutputRefresh.IsEnabled = 1
            $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceOutput,$Ctrl.Workspace.Output)
        }
        
        $Ctrl.Update(0,"Complete [~] Workspace content refreshed")
    }
    WorkspaceOutput()
    {
        $Ctrl = $This
        
        $Ctrl.Xaml.IO.WorkspaceOutputPropertyText.Text   = $null
        $Ctrl.Xaml.IO.WorkspaceOutputPropertyIcon.Source = $null

        If ($Ctrl.Xaml.IO.WorkspaceOutput.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.WorkspaceOutput.SelectedItem

            $Ctrl.Xaml.IO.WorkspaceOutputPropertyText.Text   = $Item.Fullname
        }
    }
    WorkspaceOutputPropertyText()
    {
        $Ctrl                    = $This

        $Text                    = $Ctrl.Xaml.Get("WorkspaceOutputPropertyText")
        $Icon                    = $Ctrl.Xaml.Get("WorkspaceOutputPropertyIcon")

        If ($Text.Control.Text -match "(^<not set>$|^$)")
        {
            $Text.Status         = 2
        }
        Else
        {
            $Text.Status         = [System.IO.Directory]::Exists($Text.Control.Text)
        }

        $Icon.Control.Source     = $Ctrl.IconStatus($Text.Status)
    }
    WorkspaceSlot()
    {
        $Ctrl = $This

        Switch ($Ctrl.Xaml.IO.WorkspaceSlot.SelectedIndex)
        {
            -1
            {
                $Ctrl.Xaml.IO.WorkspaceLogHeader.Visibility    = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceLogOutput.Visibility    = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceOutputHeader.Visibility = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceOutput.Visibility       = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceOutputFooter.Visibility = "Hidden"
            }
            0
            {
                $Ctrl.Xaml.IO.WorkspaceLogHeader.Visibility    = "Visible"
                $Ctrl.Xaml.IO.WorkspaceLogOutput.Visibility    = "Visible"
                $Ctrl.Xaml.IO.WorkspaceOutputHeader.Visibility = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceOutput.Visibility       = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceOutputFooter.Visibility = "Hidden"
            }
            1
            {
                $Ctrl.Xaml.IO.WorkspaceLogHeader.Visibility    = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceLogOutput.Visibility    = "Hidden"
                $Ctrl.Xaml.IO.WorkspaceOutputHeader.Visibility = "Visible"
                $Ctrl.Xaml.IO.WorkspaceOutput.Visibility       = "Visible"
                $Ctrl.Xaml.IO.WorkspaceOutputFooter.Visibility = "Visible"
            }
        }
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
        }
    }
    AssignmentResourcePathText()
    {
        $Ctrl = $This

        $Text = $Ctrl.Xaml.Get("AssignmentResourcePathText")
        $Icon = $Ctrl.Xaml.Get("AssignmentResourcePathIcon")
        
        If ($Text.Control.Text -match "(^<not set>$|^$)")
        {
            $Text.Status         = 2
        }
        Else
        {
            $Text.Status         = Test-Path $Text.Control.Text
        }

        $Icon.Control.Source     = $Ctrl.IconStatus($Text.Status)
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
        }
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
        $Ctrl.Xaml.IO.AssignmentSelectRefresh.IsEnabled    = 1
    }
    AssignmentSelectPathClose()
    {
        $Ctrl = $This

        $Ctrl.Assignment.Clear()

        $Ctrl.Xaml.IO.AssignmentSelectPathText.Text       = $Null
        $Ctrl.Xaml.IO.AssignmentSelectPathOpen.IsEnabled  = 0
        $Ctrl.Xaml.IO.AssignmentSelectPathClose.IsEnabled = 0

        $Ctrl.Xaml.IO.AssignmentSelectFilterText.Text     = $Null
        $Ctrl.Xaml.IO.AssignmentSelectRefresh.IsEnabled   = 0
        $Ctrl.Xaml.IO.AssignmentSelectAssign.IsEnabled    = 0

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

        $Ctrl.Xaml.IO.AssignmentSelectOutput.IsEnabled  = 0
        $Ctrl.Xaml.IO.AssignmentSelectRefresh.IsEnabled = 0
        $Ctrl.Xaml.IO.AssignmentSelectAssign.IsEnabled  = 0

        $Items = $Ctrl.Assignment.Output | ? Selected
        $Ctrl.Assignment.Edit.Assign($Items)
        $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceOutput,$Ctrl.Assignment.Edit.Output)
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

            $Map.SetSource($Ctrl.Xaml.IO.AssignmentEditSourcePathText.Text)

            $Ctrl.Reset($Ctrl.Xaml.IO.AssignmentEditSourceOutput,$Ctrl.Assignment.Edit.Output)

            $Ctrl.Xaml.IO.AssignmentEditSourceOutput.SelectedItem = $Map
            
            $Ctrl.AssignmentEditSourceUpdate()
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

        $Ctrl.Xaml.IO.AssignmentEditSourceLevelshotImage.Source = $Bitmap
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
        Return [Q3ALiveComponentList]::New()
    }
    [Object] Q3ALiveDependencyList([String]$Path)
    {
        Return [Q3ALiveDependencyList]::New($Path)
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
    [Object] FolderBrowserDialog()
    {
        Return [System.Windows.Forms.FolderBrowserDialog]::New()
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
            Component
            {
                $Ctrl.Xaml.IO.ComponentOutput.Add_SelectionChanged(
                {
                    $Ctrl.ComponentOutput()
                })

                $Ctrl.Xaml.IO.ComponentOutput.Add_GotFocus(
                {
                    $Ctrl.Xaml.IO.RadiantOutput.SelectedIndex     = -1
                    $Ctrl.Xaml.IO.DependencyOutput.SelectedIndex  = -1
                })

                $Ctrl.Xaml.IO.ComponentSelect.Add_Click(
                {
                    $Ctrl.ComponentSelect()
                })

                $Ctrl.Xaml.IO.RadiantOutput.Add_SelectionChanged(
                {
                    $Ctrl.RadiantOutput()
                })

                $Ctrl.Xaml.IO.RadiantSelect.Add_Click(
                {
                    $Ctrl.RadiantSelect()
                })

                $Ctrl.Xaml.IO.RadiantOutput.Add_GotFocus(
                {
                    $Ctrl.Xaml.IO.ComponentOutput.SelectedIndex   = -1
                    $Ctrl.Xaml.IO.DependencyOutput.SelectedIndex  = -1
                })

                $Ctrl.Xaml.IO.DependencyOutput.Add_SelectionChanged(
                {
                    $Ctrl.DependencyOutput()
                })

                $Ctrl.Xaml.IO.DependencyOutput.Add_GotFocus(
                {
                    $Ctrl.Xaml.IO.ComponentOutput.SelectedIndex    = -1
                    $Ctrl.Xaml.IO.RadiantOutput.SelectedIndex      = -1
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
            Workspace
            {
                $Ctrl.Xaml.IO.WorkspacePathText.Add_TextChanged(
                {
                    $Ctrl.WorkspacePathText()
                })

                $Ctrl.Xaml.IO.WorkspaceSlot.Add_SelectionChanged(
                {
                    $Ctrl.WorkspaceSlot()
                })

                $Ctrl.Xaml.IO.WorkspaceLogPathText.Add_TextChanged(
                {
                    $Ctrl.WorkspaceLogPathText()
                })

                $Ctrl.Xaml.IO.WorkspaceOutputRefresh.Add_Click(
                {
                    $Ctrl.WorkspaceOutputRefresh()
                })
                
                $Ctrl.Xaml.IO.WorkspaceOutput.Add_SelectionChanged(
                {
                    $Ctrl.WorkspaceOutput()
                })

                $Ctrl.Xaml.IO.WorkspaceOutputPropertyText.Add_TextChanged(
                {
                    $Ctrl.WorkspaceOutputPropertyText()
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

                $Ctrl.Xaml.IO.AssignmentResourceAdd.Add_Click(
                {
                    $Ctrl.AssignmentResourceAdd()
                })

                $Ctrl.Xaml.IO.AssignmentResourceRemove.Add_Click(
                {
                    $Ctrl.AssignmentResourceRemove()
                })

                $Ctrl.Xaml.IO.AssignmentResourceShaderOutput.Add_SelectionChanged(
                {
                    $Ctrl.AssignmentResourceShaderOutput()
                })

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
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigResource,$Null)

                $Ctrl.Xaml.IO.ConfigPropertyNameText.IsEnabled  = 0
                $Ctrl.Xaml.IO.ConfigPropertyValueText.IsEnabled = 1
                $Ctrl.Xaml.IO.ConfigPropertyBrowse.IsEnabled    = 0
                $Ctrl.Xaml.IO.ConfigPropertyApply.IsEnabled     = 0
            }
            Component
            {
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentOutput,$Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.DependencyOutput,$Null)

                $Ctrl.Xaml.IO.DependencyInstall.IsEnabled       = 0
                $Ctrl.Xaml.IO.DependencyClear.IsEnabled         = 0
                $Ctrl.Xaml.IO.DependencyEdit.IsEnabled          = 0
                $Ctrl.Xaml.IO.DependencyPathText.IsEnabled      = 0
                $Ctrl.Xaml.IO.DependencyPathIcon.IsEnabled      = 0
                $Ctrl.Xaml.IO.DependencyPathBrowse.IsEnabled    = 0
                $Ctrl.Xaml.IO.DependencyPathApply.IsEnabled     = 0
            }
            Workspace
            {
                $Ctrl.Xaml.IO.WorkspaceSlot.SelectedIndex       = 0
                $Ctrl.Xaml.IO.WorkspaceOutputRefresh.IsEnabled  = 0
            }
            Assignment
            {
                # Resource

                # Select
                $Ctrl.Xaml.IO.AssignmentSelectPathText.Text         = "<not set>"  
                $Ctrl.Xaml.IO.AssignmentSelectPathIcon.Source       = $Null
                $Ctrl.Xaml.IO.AssignmentSelectPathBrowse.IsEnabled  = 1
                $Ctrl.Xaml.IO.AssignmentSelectPathOpen.IsEnabled    = 0
                $Ctrl.Xaml.IO.AssignmentSelectPathClose.IsEnabled   = 0
                $Ctrl.Xaml.IO.AssignmentSelectRefresh.IsEnabled     = 0

                $Ctrl.Xaml.IO.AssignmentSelectAssign.IsEnabled      = $Ctrl.Assignment

                $Ctrl.Xaml.IO.AssignmentSelectFilterProperty.SelectedIndex = 0

                # Edit
                $Ctrl.Xaml.IO.AssignmentEditSourceLevelshotImage.Source   = $Null
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
        $Ctrl = $This

        $Ctrl.Update(0,"Staging [~] XAML")

        # Event handlers for the xaml
        $Ctrl.Stage("Config")
        $Ctrl.Stage("Component")
        $Ctrl.Stage("Workspace")
        $Ctrl.Stage("Assignment")

        # Initial settings
        $Ctrl.Initial("Config")
        $Ctrl.Initial("Component")
        $Ctrl.Initial("Workspace")
        $Ctrl.Initial("Assignment")

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
        $This.Prime()
        $This.StageXaml()
        $This.ConfigRefresh()
        $This.Xaml.Invoke()
    }
    Reset([Object]$xSender,[Object]$Object)
    {
        # Debugging [Console]::WriteLine($xSender.Name)
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
