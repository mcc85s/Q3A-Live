<#
    [Program Map]

    - General              | classes that don't fit a particular category
    - Xaml                 | classes meant for XAML/WPF
    - Registry             | classes meant to stage and initialize the utility
    - Dependency           | classes that search the registry and elsewhere for installed dependencies
    - Component            | classes meant for Quake III Arena/Quake Live
    - Radiant              | classes meant for GtkRadiant/NetRadiant/NetRadiant-Custom (Garux)
    - Workspace            | classes that partition game directories from project assets, and overall logs
    - Shader               | classes that deal specifically with shader formatting and handling
    - Texture              | classes that deal specifically with textures
    - Media                | Handling sound/music
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
    'using System.IO;',
    'using System.Collections.Generic;',
    'using System.Collections.ObjectModel;',
    'using System.ComponentModel;',
    'using System.Linq;',
    'using System.Runtime.InteropServices;',
    'using System.IO.Compression;',
    '    ',
    'namespace Q3ALive',
    '{',
    '    public enum ResourceInstallType',
    '    {',
    '        dependencies = 0,',
    '        gfx          = 1,',
    '        logs         = 2',
    '    }',
    '    ',
    '    public enum RegistryInstallType',
    '    {',
    '        DisplayName     = 0,',
    '        DisplayIcon     = 1,',
    '        Publisher       = 2,',
    '        DisplayVersion  = 3,',
    '        InstallLocation = 4,',
    '        RegistryPath    = 5,',
    '        UninstallString = 6',
    '    }',
    '    ',
    '    public enum RegistryBaseType',
    '    {',
    '        Resource    = 0,',
    '        Name        = 1,',
    '        DisplayName = 2,',
    '        Version     = 3,',
    '        Fullname    = 4,',
    '        InstallDate = 5,',
    '        Editor      = 6',
    '    }',
    '    ',
    '    public enum RegistryReferenceType',
    '    {',
    '        Settings   = 0,',
    '        Dependency = 1,',
    '        Component  = 2,',
    '        Radiant    = 3,',
    '    }',
    '    ',
    '    public enum DefaultShadersType',
    '    {',
    '        base_button   = 0,',
    '        base_door     = 1,',
    '        base_floor    = 2,',
    '        base_light    = 3,',
    '        base_object   = 4,',
    '        base_support  = 5,',
    '        base_trim     = 6,',
    '        base_wall     = 7,',
    '        common        = 8,',
    '        ctf           = 9,',
    '        gothic_block  = 10,',
    '        gothic_button = 11,',
    '        gothic_door   = 12,',
    '        gothic_floor  = 13,',
    '        gothic_light  = 14,',
    '        gothic_trim   = 15,',
    '        gothic_wall   = 16,',
    '        liquids       = 17,',
    '        models        = 18,',
    '        organics      = 19,',
    '        sfx           = 20,',
    '        skin          = 21,',
    '        skies         = 22',
    '    }',
    '    ',
    '    public enum AssetType',
    '    {',
    '        levelshots = 0,',
    '        maps       = 1,',
    '        models     = 2,',
    '        music      = 3,',
    '        scripts    = 4,',
    '        sound      = 5,',
    '        textures   = 6',
    '    }',
    '    ',
    '    public class ByteSize',
    '    {',
    '        public string Name { get; set; }',
    '        public long  Bytes { get; set; }',
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
    '            if (Bytes < 870)',
    '            {',
    '                Unit = "Byte";',
    '            }',
    '            else if (Bytes >= 870 && Bytes < 891289)',
    '            { ',
    '                Unit = "Kilobyte";',
    '            }',
    '            else if (Bytes >= 891289 && Bytes < 912680550)',
    '            { ',
    '                Unit = "Megabyte";',
    '            }',
    '            else if (Bytes >= 912680550 && Bytes < 934584883609)',
    '            {',
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
    '                    Size = string.Format("{0}  B", Bytes);',
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
    '    public struct FormattedDateTime',
    '    {',
    '        public DateTime Value;',
    '        public FormattedDateTime(DateTime dt)',
    '        {',
    '            this.Value = dt;',
    '        }',
    '        public static implicit operator DateTime(FormattedDateTime fdt)',
    '        {',
    '            return fdt.Value;',
    '        }',
    '        public static implicit operator FormattedDateTime(DateTime dt)',
    '        {',
    '            return new FormattedDateTime(dt);',
    '        }',
    '        public override string ToString()',
    '        {',
    '            return this.Value.ToString("MM/dd/yyyy HH:mm:ss");',
    '        }',
    '    }',
    '    ',
    '    public class FileSystemObject',
    '    {',
    '        public uint                  Index { get; set; }',
    '        public string                 Type { get; set; }',
    '        public string                Label { get; set; }',
    '        [System.Management.Automation.Hidden]',
    '        public FormattedDateTime?  Created { get; set; }',
    '        public FormattedDateTime? Modified { get; set; }',
    '        public string                 Name { get; set; }',
    '        public ByteSize               Size { get; set; }',
    '        public string            Extension { get; set; }',
    '        public string          DisplayName { get; set; }',
    '        public string            Reference { get; set; }',
    '        public string             Fullname { get; set; }',
    '        public uint                 Exists { get; set; } ',
    '    ',
    '        public FileSystemObject(FileSystemInfo fsi)',
    '        {',
    '            this.Type      = (fsi is DirectoryInfo) ? "Directory" : "File";',
    '            this.Created   = fsi.CreationTime;',
    '            this.Modified  = fsi.LastWriteTime;',
    '            this.Name      = fsi.Name;',
    '            this.Fullname  = fsi.FullName;',
    '    ',
    '            long bytes     = 0;',
    '            string ext     = "";',
    '            FileInfo fi    = fsi as FileInfo; ',
    '            if (fi != null)',
    '            {',
    '                bytes      = fi.Length;',
    '                ext        = fi.Extension.TrimStart('.');',
    '            }',
    '            this.Size      = new ByteSize(this.Type, (long)bytes);',
    '            this.Extension = ext;',
    '            this.Exists    = 1;',
    '        }',
    '    }',
    '    ',
    '    public static class FileSystemScanMode',
    '    {',
    '        public const uint     DirsOnly  = 0;',
    '        public const uint    FilesOnly  = 1;',
    '        public const uint DirsAndFiles  = 2;',
    '    }',
    '    ',
    '    public static class FileSystemScanner',
    '    {',
    '        public static IEnumerable<FileSystemObject> Enumerate(string fullname)',
    '        {',
    '            return Enumerate(fullname, FileSystemScanMode.DirsAndFiles, false);',
    '        }       ',
    '    ',
    '        public static IEnumerable<FileSystemObject> Enumerate(string fullname, uint mode)',
    '        {',
    '            return Enumerate(fullname, FileSystemScanMode.DirsAndFiles, false);',
    '        }       ',
    '    ',
    '        public static IEnumerable<FileSystemObject> Enumerate(string fullname, uint mode, bool recurse)',
    '        {',
    '            var raw = EnumerateInternal(fullname, mode, recurse);',
    '    ',
    '            List<FileSystemObject> sorted = new List<FileSystemObject>(raw);',
    '    ',
    '            sorted.Sort(new Comparison<FileSystemObject>(CompareByFullname));',
    '    ',
    '            uint index = 0;',
    '            foreach (var item in sorted)',
    '            {',
    '                item.Index = index++;',
    '                yield return item;',
    '            }',
    '        }',
    '    ',
    '        private static int CompareByFullname(FileSystemObject a, FileSystemObject b)',
    '        {',
    '            return string.Compare(a.Fullname, b.Fullname, StringComparison.OrdinalIgnoreCase);',
    '        }',
    '    ',
    '        private static IEnumerable<FileSystemObject> EnumerateInternal(string root, uint mode, bool recurse)',
    '        {',
    '            var dirs = new Stack<string>();',
    '            dirs.Push(root);',
    '    ',
    '            bool includeDirs  = mode == FileSystemScanMode.DirsOnly || mode == FileSystemScanMode.DirsAndFiles;',
    '            bool includeFiles = mode == FileSystemScanMode.FilesOnly || mode == FileSystemScanMode.DirsAndFiles;',
    '    ',
    '            while (dirs.Count > 0)',
    '            {',
    '                string current = dirs.Pop();',
    '    ',
    '                DirectoryInfo di = null;',
    '                try',
    '                { ',
    '                    di = new DirectoryInfo(current);',
    '                } ',
    '                catch',
    '                {',
    '                    ',
    '                }',
    '    ',
    '                string[] subdirs = null;',
    '                try',
    '                {',
    '                    subdirs = Directory.GetDirectories(current);',
    '                }',
    '                catch',
    '                {',
    '                    ',
    '                }',
    '    ',
    '                if (subdirs != null)',
    '                {',
    '                    foreach (string dir in subdirs)',
    '                    {',
    '                        if (recurse)',
    '                            dirs.Push(dir);',
    '    ',
    '                        if (includeDirs)',
    '                        {',
    '                            DirectoryInfo subdirInfo = null;',
    '                            try',
    '                            {',
    '                                subdirInfo = new DirectoryInfo(dir);',
    '                            }',
    '                            catch',
    '                            {',
    '                                ',
    '                            }',
    '    ',
    '                            if (subdirInfo != null)',
    '                                yield return new FileSystemObject(subdirInfo);',
    '                        }',
    '                    }',
    '                }',
    '    ',
    '                if (includeFiles)',
    '                {',
    '                    string[] files = null;',
    '                    try',
    '                    { ',
    '                        files = Directory.GetFiles(current);',
    '                    }',
    '                    catch',
    '                    {',
    '                        ',
    '                    }',
    '    ',
    '                    if (files != null)',
    '                    {',
    '                        foreach (string file in files)',
    '                        {',
    '                            FileInfo fi = null;',
    '                            try',
    '                            { ',
    '                                fi = new FileInfo(file);',
    '                            } ',
    '                            catch',
    '                            {',
    '                                ',
    '                            }',
    '    ',
    '                            if (fi != null)',
    '                                yield return new FileSystemObject(fi);',
    '                        }',
    '                    }',
    '                }',
    '            }',
    '        }',
    '    }',
    '    ',
    '    public class DirectoryScan',
    '    {',
    '        public uint                    Index { get; set; }',
    '        public string                   Type { get; set; }',
    '        public string                  Label { get; set; }',
    '        [System.Management.Automation.Hidden]',
    '        public FormattedDateTime?    Created { get; set; }',
    '        public FormattedDateTime?   Modified { get; set; }',
    '        public string                   Name { get; set;}',
    '        public uint                   Exists { get; set; }',
    '        public ByteSize                 Size { get; set; }',
    '        public string               Fullname { get; private set; }',
    '        public List<FileSystemObject> Output { get; private set; }',
    '        private uint                    Mode { get; set; }',
    '        private bool                 Recurse { get; set; }',
    '        public DirectoryScan(string fullname) : this(fullname, 2, false)',
    '        {',
    '            ',
    '        }',
    '        public DirectoryScan(string fullname, uint mode) : this(fullname, mode, false)',
    '        {',
    '            ',
    '        }',
    '        public DirectoryScan(string fullname, uint mode, bool recurse)',
    '        {',
    '            this.Index    = 0;',
    '            this.Type     = "";',
    '            this.Label    = "";',
    '            this.Fullname = fullname;',
    '            this.Name     = System.IO.Path.GetFileName(fullname);',
    '    ',
    '            this.SetMode(mode);',
    '            this.SetRecurse(recurse);',
    '            ',
    '            this.Refresh();',
    '        }',
    '        public void SetType(string type)',
    '        {',
    '            this.Type = type;',
    '        }',
    '        public void SetLabel(string label)',
    '        {',
    '            this.Label = label;',
    '        }',
    '        public void SetRecurse(bool recurse)',
    '        {',
    '            this.Recurse = recurse;',
    '        }',
    '        public void SetMode(uint mode)',
    '        {',
    '            this.Mode = mode;',
    '        }',
    '        public void Check()',
    '        {',
    '            DirectoryInfo di = new DirectoryInfo(this.Fullname);',
    '    ',
    '            this.Exists = di.Exists ? 1u : 0u;',
    '    ',
    '            if (this.Exists == 1u)',
    '            {',
    '                this.Created  = di.CreationTime;',
    '                this.Modified = di.LastWriteTime;',
    '            }',
    '            else',
    '            {',
    '                this.Created  = null;',
    '                this.Modified = null;   ',
    '            }',
    '        }',
    '        public void Refresh()',
    '        {',
    '            this.Check();',
    '    ',
    '            if (this.Exists == 0u)',
    '            {',
    '                this.Output = null;',
    '                this.Size   = null;',
    '            }',
    '            if (this.Exists == 1u)',
    '            {',
    '                IEnumerable<FileSystemObject> raw = FileSystemScanner.Enumerate(this.Fullname, this.Mode, this.Recurse);',
    '    ',
    '                this.Output = new List<FileSystemObject>(raw);',
    '    ',
    '                uint index = 0;',
    '                foreach (FileSystemObject item in this.Output)',
    '                    item.Index = index++;',
    '    ',
    '                long totalBytes = 0;',
    '    ',
    '                foreach (FileSystemObject item in this.Output)',
    '                {',
    '                    if (item.Type == "File")',
    '                        totalBytes += item.Size.Bytes;',
    '                }',
    '    ',
    '                this.Size = new ByteSize("Directory", totalBytes);',
    '            }',
    '        }',
    '        public ByteSize GetRecursiveSize()',
    '        {',
    '            try',
    '            {',
    '                System.Type fsoType = System.Type.GetTypeFromProgID("Scripting.FileSystemObject");',
    '                dynamic fso         = System.Activator.CreateInstance(fsoType);',
    '    ',
    '                dynamic folder      = fso.GetFolder(this.Fullname);',
    '                long bytes          = Convert.ToInt64(folder.Size);',
    '    ',
    '                return new ByteSize("Directory", bytes);',
    '            }',
    '            catch',
    '            {',
    '                return new ByteSize("Directory", 0);',
    '            }',
    '        }',
    '        public DirectoryScan SortBy(string property)',
    '        {',
    '            this.Output.Sort(new Comparison<FileSystemObject>(',
    '                delegate(FileSystemObject a, FileSystemObject b)',
    '                {',
    '                    object va = GetPropertyValue(a, property);',
    '                    object vb = GetPropertyValue(b, property);',
    '                    return string.Compare(',
    '                        va == null ? "" : va.ToString(),',
    '                        vb == null ? "" : vb.ToString(),',
    '                        StringComparison.OrdinalIgnoreCase',
    '                    );',
    '                }',
    '            ));',
    '    ',
    '            uint index = 0;',
    '            foreach (FileSystemObject item in this.Output)',
    '                item.Index = index++;',
    '    ',
    '            return this;',
    '        }',
    '    ',
    '        private object GetPropertyValue(FileSystemObject obj, string property)',
    '        {',
    '            var prop = obj.GetType().GetProperty(property);',
    '            if (prop != null)',
    '                return prop.GetValue(obj, null);',
    '            return null;',
    '        }',
    '    }',
    '    ',
    '    public class PackageFileEntry',
    '    {',
    '        public uint                  Index { get; set; }',
    '        public string               Source { get; set; }',
    '        public string                 Type { get; set; }',
    '        public string                Label { get; set; }',
    '        public FormattedDateTime? Modified { get; set; }',
    '        public string                 Name { get; set; }',
    '        public string            Extension { get; set; }',
    '        public string          DisplayName { get; set; }',
    '        public string             Fullname { get; set; }',
    '        public ByteSize Size { get; set; }',
    '    ',
    '        public PackageFileEntry(uint index, string source, ZipArchiveEntry entry)',
    '        {',
    '            this.Index         = index;',
    '            this.Source        = source;',
    '    ',
    '            if (entry.Length == 0)',
    '            {',
    '                this.Type      = "Directory";',
    '                this.Name      = GetName(entry);',
    '                this.Fullname  = entry.FullName.TrimEnd('/');',
    '                this.Extension = null;',
    '            }',
    '            else',
    '            {',
    '                this.Type      = "File";',
    '                this.Name      = entry.Name;',
    '                this.Fullname  = entry.FullName;',
    '                this.Extension = GetExtension(entry.Name);',
    '            }',
    '    ',
    '            this.Modified      = new FormattedDateTime(entry.LastWriteTime.DateTime);',
    '            this.Size          = new ByteSize("Entry", entry.Length);',
    '            this.DisplayName   = string.Format("\\{0}", this.Fullname.Replace("/", "\\"));',
    '            this.Label         = ComputeLabel(this.DisplayName);',
    '        }',
    '    ',
    '        private string GetName(ZipArchiveEntry entry)',
    '        {',
    '            string fullname = entry.FullName.TrimEnd('/');',
    '            int idx         = fullname.LastIndexOf('/');',
    '    ',
    '            if (idx >= 0)',
    '            {',
    '                return fullname.Substring(idx + 1);   ',
    '            }',
    '    ',
    '            return fullname;',
    '        }',
    '    ',
    '        private string GetExtension(string name)',
    '        {',
    '            int idx = name.LastIndexOf('.');',
    '    ',
    '            if (idx >= 0 && idx < name.Length - 1)',
    '            {',
    '                return name.Substring(idx + 1);   ',
    '            }',
    '    ',
    '            return "";',
    '        }',
    '    ',
    '        private string ComputeLabel(string displayName)',
    '        {',
    '            string trimmed = displayName.TrimStart('\\');',
    '            string[] parts = trimmed.Split('\\');',
    '    ',
    '            if (parts.Length == 0)',
    '            {',
    '                return "Other";',
    '            }',
    '    ',
    '            string lead = parts[0].ToLowerInvariant();',
    '    ',
    '            switch (lead)',
    '            {',
    '                case "levelshots": return "Levelshot";',
    '                case "maps":       return "Map";',
    '                case "models":     return "Model";',
    '                case "music":      return "Music";',
    '                case "scripts":    return "Script";',
    '                case "sound":      return "Sound";',
    '                case "textures":   return "Texture";',
    '                default:           return "Other";',
    '            }',
    '        }',
    '        public string ArchiveString()',
    '        {',
    '            return this.DisplayName.Replace("\\","/").TrimStart('/');',
    '        }',
    '    ',
    '        public override string ToString()',
    '        {',
    '            return this.Fullname;',
    '        }',
    '    }',
    '    ',
    '    public class PackageFileItem : INotifyPropertyChanged',
    '    {',
    '        public event PropertyChangedEventHandler PropertyChanged;',
    '        public uint                  Index { get; set; }',
    '        public string                 Type { get; set; }',
    '        public FormattedDateTime? Modified { get; set; }',
    '        public string                 Name { get; set; }',
    '        public string            Extension { get; set; }',
    '        public string             Fullname { get; set; }',
    '        public ByteSize               Size { get; set; }',
    '        public uint                 Exists { get; set; }',
    '		private bool                Opened { get; set; }',
    '        private bool               _loaded;',
    '        public bool                 Loaded',
    '        {',
    '            get { return _loaded; }',
    '            set',
    '            {',
    '                if (_loaded != value)',
    '                {',
    '                    _loaded = value;',
    '                    OnPropertyChanged("Loaded");',
    '                }',
    '            }',
    '        }',
    '        public ObservableCollection<PackageFileEntry> Output { get; set; }',
    '    ',
    '        public FileStream       FileStream { get; set; }',
    '        public ZipArchive          Archive { get; set; }',
    '        public PackageFileItem(uint index, string type, FileSystemObject file)',
    '        {',
    '            this.Index        = index;',
    '            this.Type         = type;',
    '            this.Name         = file.Name;',
    '            this.Extension    = file.Extension;',
    '            this.Fullname     = file.Fullname;',
    '    ',
    '            this.Check();',
    '        }',
    '        public void Clear()',
    '        {',
    '            this.Output       = new ObservableCollection<PackageFileEntry>();',
    '            this.Opened       = false;',
    '            this.Loaded       = false;',
    '        }',
    '        public void Check()',
    '        {',
    '            this.Exists       = (uint)(File.Exists(this.Fullname) ? 1 : 0);',
    '    ',
    '            if (this.Exists == 1)',
    '            {',
    '                FileInfo fi   = new FileInfo(this.Fullname);',
    '                this.Modified = new FormattedDateTime(fi.LastWriteTime);',
    '                this.Size     = new ByteSize("Archive", fi.Length);',
    '            }',
    '        }',
    '        public void Open()',
    '        {',
    '            this.Check();',
    '    ',
    '            if (this.Exists == 0)',
    '            {',
    '                this.FileStream = File.Open(this.Fullname, FileMode.Create);',
    '            }',
    '            else',
    '            {',
    '                this.FileStream = File.Open(this.Fullname, FileMode.Open);',
    '            }',
    '    ',
    '            this.Archive        = new ZipArchive(this.FileStream, ZipArchiveMode.Update);',
    '            this.Opened         = true;',
    '        }',
    '        public void Close()',
    '        {',
    '            if (this.Archive != null)',
    '            {',
    '                this.Archive.Dispose();',
    '                this.Archive = null;',
    '            }',
    '    ',
    '            if (this.FileStream != null)',
    '            {',
    '                this.FileStream.Dispose();',
    '                this.FileStream = null;',
    '            }',
    '    ',
    '            this.Opened          = false;',
    '        }',
    '        public void Remove()',
    '        {',
    '            this.Check();',
    '    ',
    '            if (this.Exists == 1)',
    '            {',
    '                this.Close();',
    '                File.Delete(this.Fullname);',
    '                this.Check();',
    '            }',
    '        }',
    '        public void Refresh()',
    '        {',
    '            if (!this.Loaded)',
    '            {',
    '                this.Clear();',
    '                this.Open();',
    '    ',
    '                int count                   = this.Archive.Entries.Count;',
    '                List<PackageFileEntry> list = new List<PackageFileEntry>(count);',
    '    ',
    '                for (int i = 0; i < count; i++)',
    '                {',
    '                    ZipArchiveEntry entry   = this.Archive.Entries[i];',
    '                    var item                = new PackageFileEntry((uint)i, this.Fullname, entry);',
    '    ',
    '                    Console.WriteLine(String.Format("Asset [+] {0}", entry.FullName));',
    '    ',
    '                    list.Add(item);',
    '                }',
    '    ',
    '                list.Sort(delegate(PackageFileEntry a, PackageFileEntry b)',
    '                {',
    '                    string da = (a == null || a.DisplayName == null) ? "" : a.DisplayName;',
    '                    string db = (b == null || b.DisplayName == null) ? "" : b.DisplayName;',
    '    ',
    '                    return string.Compare(da, db, StringComparison.OrdinalIgnoreCase);',
    '                });',
    '    ',
    '                Console.WriteLine(String.Format("Sorting [~] ({0}) items", count));',
    '                for (int i = 0; i < list.Count; i++)',
    '                {',
    '                    this.Output.Add(list[i]);',
    '                }',
    '    ',
    '                this.Close();',
    '                this.Loaded = true;',
    '            }',
    '        }',
    '		protected void OnPropertyChanged(string name)',
    '        {',
    '            PropertyChangedEventHandler handler = PropertyChanged;',
    '            if (handler != null)',
    '            {',
    '                handler(this, new PropertyChangedEventArgs(name));',
    '            }',
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
    '        public FormattedDateTime? Modified { get; set; }',
    '        public ByteSize Size { get; set; }',
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
    '            this.Index       = index;',
    '            this.Name        = file.Name;',
    '            this.DisplayName = System.IO.Path.GetFileNameWithoutExtension(file.Name);',
    '            this.Fullname    = file.FullName;',
    '            this.Modified    = file.LastWriteTime;',
    '            this.Size        = new ByteSize("Map",file.Length);',
    '            this._selected   = false;',
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
    '    ',
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
    '    ',
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
    '    ',
    '                    var prop = file.GetType().GetProperty(propertyName);',
    '                    if (prop == null) return false;',
    '    ',
    '                    var raw = prop.GetValue(file, null);',
    '                    var value = raw != null ? raw.ToString() : null;',
    '    ',
    '                    return value != null &&',
    '                    value.IndexOf(filterText, StringComparison.OrdinalIgnoreCase) >= 0;',
    '                };',
    '            }',
    '    ',
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
    '        public void FilterSelected()',
    '        {',
    '            View.Filter = item =>',
    '            {',
    '                var f = item as AssignmentSelectFile;',
    '                return f != null && f.Selected;',
    '            };',
    '            View.Refresh();',
    '        }',
    '    ',
    '        public override string ToString()',
    '        {',
    '            return "<Q3ALive.Assignment.SelectFile.List>";',
    '        }',
    '    }',
    '}' -join "`n"

    $AssemblyNames = ('mscorlib;System;System.Core;Microsoft.CSharp;WindowsBase;PresentationCore;'+
                     'PresentationFramework;System.IO.Compression;System.IO.Compression.Filesystem') -Split ";"
                     
    Add-Type -ReferencedAssemblies $AssemblyNames -TypeDefinition $TypeDefinition
    Add-Type -Assembly System.IO.Compression, System.IO.Compression.Filesystem
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
    '            <Setter Property="Foreground" Value="#000000"/>',
    '            <Setter Property="HeaderTemplate">',
    '                <Setter.Value>',
    '                    <DataTemplate>',
    '                        <TextBlock Text="{Binding}"',
    '                                   FontFamily="Consolas"',
    '                                   FontWeight="SemiBold"',
    '                                   FontSize="12"',
    '                                   Foreground="{Binding RelativeSource={RelativeSource AncestorType=TabItem}, Path=Foreground}"/>',
    '                    </DataTemplate>',
    '                </Setter.Value>',
    '            </Setter>',
    '            <Setter Property="Template">',
    '                <Setter.Value>',
    '                    <ControlTemplate TargetType="TabItem">',
    '                        <Border x:Name="Border"',
    '                                BorderThickness="2"',
    '                                BorderBrush="Black"',
    '                                CornerRadius="5"',
    '                                Margin="2"',
    '                                Background="#CFFFBF">',
    '                            <ContentPresenter x:Name="ContentSite"',
    '                                              VerticalAlignment="Center"',
    '                                              HorizontalAlignment="Center"',
    '                                              ContentSource="Header"',
    '                                              Margin="5"/>',
    '                        </Border>',
    '                        <ControlTemplate.Triggers>',
    '                            <Trigger Property="IsMouseOver" Value="True">',
    '                                <Setter TargetName="Border" Property="Background" Value="#BEE6FD"/>',
    '                                <Setter TargetName="Border" Property="BorderBrush" Value="#3C7FB1"/>',
    '                                <Setter Property="Foreground" Value="#000000"/>',
    '                            </Trigger>',
    '                            <Trigger Property="IsSelected" Value="True">',
    '                                <Setter TargetName="Border" Property="Background" Value="#4444FF"/>',
    '                                <Setter TargetName="Border" Property="BorderBrush" Value="Black"/>',
    '                                <Setter Property="Foreground" Value="#FFFFFF"/>',
    '                            </Trigger>',
    '                            <Trigger Property="IsEnabled" Value="False">',
    '                                <Setter TargetName="Border" Property="Background" Value="#9C9C9C"/>',
    '                                <Setter TargetName="Border" Property="BorderBrush" Value="#6B6B6B"/>',
    '                                <Setter Property="Foreground" Value="#4B4B4B"/>',
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
    '        <Style TargetType="TreeView">',
    '            <Setter Property="Margin" Value="5"/>',
    '            <Setter Property="Background"  Value="#000000"/>',
    '            <Setter Property="Foreground" Value="#00FF00"/>',
    '        </Style>',
    '        <Style TargetType="ListView">',
    '            <Setter Property="Margin" Value="5"/>',
    '            <Setter Property="Background"  Value="#000000"/>',
    '            <Setter Property="Foreground" Value="#00FF00"/>',
    '        </Style>',
    '        <Style TargetType="Button">',
    '            <Setter Property="Margin" Value="5"/>',
    '            <Setter Property="Padding" Value="5"/>',
    '            <Setter Property="FontWeight" Value="SemiBold"/>',
    '            <Setter Property="Foreground" Value="Black"/>',
    '            <Setter Property="Background" Value="#CFFFBF"/>',
    '            <Setter Property="BorderBrush" Value="Black"/>',
    '            <Setter Property="BorderThickness" Value="2"/>',
    '            <Setter Property="VerticalContentAlignment" Value="Center"/>',
    '            <Setter Property="Template">',
    '                <Setter.Value>',
    '                    <ControlTemplate TargetType="Button">',
    '                        <Border x:Name="Border"',
    '                                Background="{TemplateBinding Background}"',
    '                                BorderBrush="{TemplateBinding BorderBrush}"',
    '                                BorderThickness="{TemplateBinding BorderThickness}"',
    '                                CornerRadius="5"',
    '                                Padding="{TemplateBinding Padding}">',
    '                            <ContentPresenter HorizontalAlignment="Center"',
    '                                              VerticalAlignment="Center"/>',
    '                        </Border>',
    '                        <ControlTemplate.Triggers>',
    '                            <Trigger Property="IsMouseOver" Value="True">',
    '                                <Setter TargetName="Border" Property="Background" Value="#BEE6FD"/>',
    '                                <Setter TargetName="Border" Property="BorderBrush" Value="#3C7FB1"/>',
    '                                <Setter Property="Foreground" Value="Black"/>',
    '                            </Trigger>',
    '                            <Trigger Property="IsEnabled" Value="False">',
    '                                <Setter TargetName="Border" Property="Background" Value="#9C9C9C"/>',
    '                                <Setter TargetName="Border" Property="BorderBrush" Value="#6B6B6B"/>',
    '                                <Setter Property="Foreground" Value="#4B4B4B"/>',
    '                            </Trigger>',
    '                        </ControlTemplate.Triggers>',
    '                    </ControlTemplate>',
    '                </Setter.Value>',
    '            </Setter>',
    '        </Style>',
    '        <Style x:Key="BlackComboBox" TargetType="ComboBox">',
    '            <Setter Property="Height" Value="24"/>',
    '            <Setter Property="Margin" Value="5"/>',
    '            <Setter Property="Foreground" Value="#00FF00"/>',
    '            <Setter Property="FontFamily" Value="Consolas"/>',
    '            <Setter Property="FontSize" Value="12"/>',
    '            <Setter Property="FontWeight" Value="Normal"/>',
    '            <Setter Property="Background" Value="Black"/>',
    '            <Setter Property="BorderBrush" Value="Gray"/>',
    '            <Setter Property="BorderThickness" Value="1"/>',
    '            <Setter Property="HorizontalContentAlignment" Value="Left"/>',
    '            <Setter Property="ItemContainerStyle">',
    '                <Setter.Value>',
    '                    <Style TargetType="ComboBoxItem">',
    '                        <Setter Property="Foreground" Value="#00FF00"/>',
    '                        <Setter Property="TextElement.Foreground" Value="#00FF00"/>',
    '                        <Setter Property="FontFamily" Value="Consolas"/>',
    '                        <Setter Property="FontSize" Value="12"/>',
    '                        <Setter Property="HorizontalContentAlignment" Value="Left"/>',
    '                        <Setter Property="VerticalContentAlignment" Value="Center"/>',
    '                    </Style>',
    '                </Setter.Value>',
    '            </Setter>',
    '            <Setter Property="Template">',
    '                <Setter.Value>',
    '                    <ControlTemplate TargetType="ComboBox">',
    '                        <Grid>',
    '                            <Border CornerRadius="2"',
    '                                    BorderBrush="{TemplateBinding BorderBrush}"',
    '                                    BorderThickness="{TemplateBinding BorderThickness}"',
    '                                    Background="{TemplateBinding Background}"',
    '                                    ClipToBounds="True">',
    '                                <Border.Effect>',
    '                                    <DropShadowEffect ShadowDepth="1"/>',
    '                                </Border.Effect>',
    '                                <ToggleButton x:Name="ToggleButton"',
    '                                              Background="{TemplateBinding Background}"',
    '                                              BorderThickness="0"',
    '                                              Focusable="False"',
    '                                              ClickMode="Press"',
    '                                              HorizontalContentAlignment="Stretch"',
    '                                              IsChecked="{Binding IsDropDownOpen, Mode=TwoWay, RelativeSource={RelativeSource TemplatedParent}}">',
    '                                    <Grid>',
    '                                        <Grid.ColumnDefinitions>',
    '                                            <ColumnDefinition Width="*" />',
    '                                            <ColumnDefinition Width="Auto"/>',
    '                                        </Grid.ColumnDefinitions>',
    '                                        <ContentPresenter Grid.Column="0"',
    '                                                          Margin="4,0,4,0"',
    '                                                          VerticalAlignment="Center"',
    '                                                          HorizontalAlignment="Left"',
    '                                                          Content="{TemplateBinding SelectionBoxItem}"',
    '                                                          ContentTemplate="{TemplateBinding SelectionBoxItemTemplate}"',
    '                                                          ContentTemplateSelector="{TemplateBinding ItemTemplateSelector}"',
    '                                                          TextElement.Foreground="{TemplateBinding Foreground}" />',
    '                                        <Path Grid.Column="1"',
    '                                              Data="M 0 0 L 4 4 L 8 0 Z"',
    '                                              Fill="{TemplateBinding Foreground}"',
    '                                              Width="8"',
    '                                              Height="4"',
    '                                              Margin="0,0,6,0"',
    '                                              VerticalAlignment="Center"',
    '                                              HorizontalAlignment="Right"/>',
    '                                    </Grid>',
    '                                </ToggleButton>',
    '                            </Border>',
    '                            <Popup x:Name="Popup"',
    '                                   Placement="Bottom"',
    '                                   IsOpen="{TemplateBinding IsDropDownOpen}"',
    '                                   AllowsTransparency="True"',
    '                                   Focusable="False"',
    '                                   PopupAnimation="Slide">',
    '                                <Border Background="{TemplateBinding Background}"',
    '                                        BorderBrush="{TemplateBinding BorderBrush}"',
    '                                        BorderThickness="1"',
    '                                        CornerRadius="2"',
    '                                        ClipToBounds="True"',
    '                                        Width="{Binding ActualWidth, RelativeSource={RelativeSource TemplatedParent}}">',
    '                                    <Border.Effect>',
    '                                        <DropShadowEffect ShadowDepth="1"/>',
    '                                    </Border.Effect>',
    '                                    <ScrollViewer>',
    '                                        <ItemsPresenter HorizontalAlignment="Stretch"',
    '                                                        VerticalAlignment="Top" />',
    '                                    </ScrollViewer>',
    '                                </Border>',
    '                            </Popup>',
    '                        </Grid>',
    '                        <ControlTemplate.Triggers>',
    '                            <Trigger Property="IsMouseOver" Value="True">',
    '                                <Setter Property="Foreground" Value="#000000"/>',
    '                                <Setter Property="BorderBrush" Value="#000000"/>',
    '                            </Trigger>',
    '                        </ControlTemplate.Triggers>',
    '                    </ControlTemplate>',
    '                </Setter.Value>',
    '            </Setter>',
    '        </Style>',
    '        <Style x:Key="DGCombo"',
    '               TargetType="ComboBox"',
    '               BasedOn="{StaticResource BlackComboBox}">',
    '            <Setter Property="Height" Value="16"/>',
    '            <Setter Property="Margin" Value="0"/>',
    '            <Setter Property="Padding" Value="2"/>',
    '            <Setter Property="FontFamily" Value="Consolas"/>',
    '            <Setter Property="FontSize" Value="10"/>',
    '            <Setter Property="FontWeight" Value="SemiBold"/>',
    '        </Style>',
    '        <Style x:Key="RoundedGreenCheckBox" TargetType="CheckBox">',
    '            <Setter Property="Foreground" Value="#00FF00"/>',
    '            <Setter Property="Background" Value="#000000"/>',
    '            <Setter Property="Padding" Value="1"/>',
    '            <Setter Property="HorizontalAlignment" Value="Center"/>',
    '            <Setter Property="Template">',
    '                <Setter.Value>',
    '                    <ControlTemplate TargetType="CheckBox">',
    '                        <Border Background="{TemplateBinding Background}"',
    '                                CornerRadius="3"',
    '                                Padding="{TemplateBinding Padding}">',
    '                            <StackPanel Orientation="Horizontal">',
    '                                <Border Width="12"',
    '                                        Height="12"',
    '                                        Margin="0"',
    '                                        CornerRadius="3"',
    '                                        BorderBrush="#00FF00"',
    '                                        BorderThickness="1"',
    '                                        Background="#000000">',
    '                                    <Path x:Name="CheckMark"',
    '                                          Stroke="#00FF00"',
    '                                          StrokeThickness="2"',
    '                                          Data="M 3 7 L 6 10 L 11 3"',
    '                                          Stretch="Uniform"',
    '                                          StrokeEndLineCap="Round"',
    '                                          StrokeStartLineCap="Round"',
    '                                          Visibility="Collapsed"/>',
    '                                </Border>',
    '                                <ContentPresenter VerticalAlignment="Center"',
    '                                                  RecognizesAccessKey="True"',
    '                                                  TextElement.Foreground="{TemplateBinding Foreground}"/>',
    '                            </StackPanel>',
    '                        </Border>',
    '                        <ControlTemplate.Triggers>',
    '                            <Trigger Property="IsChecked" Value="True">',
    '                                <Setter TargetName="CheckMark" Property="Visibility" Value="Visible"/>',
    '                            </Trigger>',
    '                            <Trigger Property="IsEnabled" Value="False">',
    '                                <Setter Property="Opacity" Value="0.4"/>',
    '                            </Trigger>',
    '                        </ControlTemplate.Triggers>',
    '                    </ControlTemplate>',
    '                </Setter.Value>',
    '            </Setter>',
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
    '            <Setter Property="HorizontalAlignment" Value="Right"/>',
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
    '                     Name="ConfigTab"',
    '                     ToolTip="(Resource + Registry) information for Q3A-Live">',
    '                <Grid>',
    '                    <Grid.RowDefinitions>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="45"/>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="82"/>',
    '                        <RowDefinition Height="100"/>',
    '                        <RowDefinition Height="65"/>',
    '                        <RowDefinition Height="82"/>',
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
    '                                 IsReadOnly="True"',
    '                                 IsHitTestVisible="False"/>',
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
    '                                                <TextBlock Text="&lt;Q3ALive.Registry.Properties&gt;"',
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
    '                             Name="ConfigRegistryPathText"',
    '                             IsReadOnly="True"/>',
    '                    <DataGrid Grid.Row="3"',
    '                              Name="ConfigSettings"',
    '                              CanUserReorderColumns="False"',
    '                              CanUserResizeColumns="False"',
    '                              CanUserSortColumns="False">',
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
    '                            <DataGridTemplateColumn Header="Valid"',
    '                                                    Width="40">',
    '                                <DataGridTemplateColumn.CellTemplate>',
    '                                    <DataTemplate>',
    '                                        <CheckBox IsChecked="{Binding Valid}"',
    '                                                  IsHitTestVisible="False"',
    '                                                  Style="{StaticResource RoundedGreenCheckBox}"',
    '                                                  HorizontalAlignment="Right"/>',
    '                                    </DataTemplate>',
    '                                </DataGridTemplateColumn.CellTemplate>',
    '                            </DataGridTemplateColumn>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <DataGrid Grid.Row="4"',
    '                              Name="ConfigDependency"',
    '                              CanUserReorderColumns="False"',
    '                              CanUserResizeColumns="False"',
    '                              CanUserSortColumns="False">',
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
    '                            <DataGridTemplateColumn Header="Valid"',
    '                                                    Width="40">',
    '                                <DataGridTemplateColumn.CellTemplate>',
    '                                    <DataTemplate>',
    '                                        <CheckBox IsChecked="{Binding Valid}"',
    '                                                  IsHitTestVisible="False"',
    '                                                  Style="{StaticResource RoundedGreenCheckBox}"',
    '                                                  HorizontalAlignment="Right"/>',
    '                                    </DataTemplate>',
    '                                </DataGridTemplateColumn.CellTemplate>',
    '                            </DataGridTemplateColumn>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <DataGrid Grid.Row="5"',
    '                              Name="ConfigComponent"',
    '                              CanUserReorderColumns="False"',
    '                              CanUserResizeColumns="False"',
    '                              CanUserSortColumns="False">',
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
    '                            <DataGridTemplateColumn Header="Valid"',
    '                                                    Width="40">',
    '                                <DataGridTemplateColumn.CellTemplate>',
    '                                    <DataTemplate>',
    '                                        <CheckBox IsChecked="{Binding Valid}"',
    '                                                  IsHitTestVisible="False"',
    '                                                  Style="{StaticResource RoundedGreenCheckBox}"',
    '                                                  HorizontalAlignment="Right"/>',
    '                                    </DataTemplate>',
    '                                </DataGridTemplateColumn.CellTemplate>',
    '                            </DataGridTemplateColumn>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <DataGrid Grid.Row="6"',
    '                              Name="ConfigRadiant"',
    '                              CanUserReorderColumns="False"',
    '                              CanUserResizeColumns="False"',
    '                              CanUserSortColumns="False">',
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
    '                            <DataGridTemplateColumn Header="Valid"',
    '                                                    Width="40">',
    '                                <DataGridTemplateColumn.CellTemplate>',
    '                                    <DataTemplate>',
    '                                        <CheckBox IsChecked="{Binding Valid}"',
    '                                                  IsHitTestVisible="False"',
    '                                                  Style="{StaticResource RoundedGreenCheckBox}"',
    '                                                  HorizontalAlignment="Right"/>',
    '                                    </DataTemplate>',
    '                                </DataGridTemplateColumn.CellTemplate>',
    '                            </DataGridTemplateColumn>',
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
    '            <TabItem Header="Dependency"',
    '                     Name="DependencyTab">',
    '                <Grid>',
    '                    <Grid.RowDefinitions>',
    '                        <RowDefinition Height="*"/>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="*"/>',
    '                    </Grid.RowDefinitions>',
    '                    <Grid Grid.Row="0">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <DataGrid Grid.Column="0"',
    '                                  Name="DependencyOutput"',
    '                                  CanUserReorderColumns="False"',
    '                                  CanUserResizeColumns="False"',
    '                                  CanUserSortColumns="False">',
    '                            <DataGrid.RowStyle>',
    '                                <Style TargetType="{x:Type DataGridRow}">',
    '                                    <Style.Triggers>',
    '                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                            <Setter Property="ToolTip">',
    '                                                <Setter.Value>',
    '                                                    <TextBlock Text="&lt;Q3ALive.Dependency.Item&gt;"',
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
    '                                <DataGridTextColumn Header="Dependency"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="125"/>',
    '                                <DataGridTextColumn Header="Type"',
    '                                                    Binding="{Binding Type}"',
    '                                                    Width="60"/>',
    '                                <DataGridTextColumn Header="Version"',
    '                                                Binding="{Binding Version}"',
    '                                                Width="70"/>',
    '                                <DataGridTextColumn Header="Description"',
    '                                                Binding="{Binding Description}"',
    '                                                Width="*"/>',
    '                                <DataGridTemplateColumn Header="Installed"',
    '                                                        Width="70">',
    '                                    <DataGridTemplateColumn.CellTemplate>',
    '                                        <DataTemplate>',
    '                                            <ComboBox SelectedIndex="{Binding Installed}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                <ComboBoxItem Content="[ ]"/>',
    '                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                            </ComboBox>',
    '                                        </DataTemplate>',
    '                                    </DataGridTemplateColumn.CellTemplate>',
    '                                </DataGridTemplateColumn>',
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
    '                                    Name="DependencyInstall"',
    '                                    Content="Install"/>',
    '                            <Button Grid.Row="1"',
    '                                    Name="DependencyClear"',
    '                                    Content="Clear"/>',
    '                            <Button Grid.Row="2"',
    '                                    Name="DependencyEdit"',
    '                                    Content="Edit"/>',
    '                            <Button Grid.Row="3"',
    '                                    Name="DependencyNew"',
    '                                    Content="New"',
    '                                    IsEnabled="False"/>',
    '                        </Grid>',
    '                    </Grid>',
    '                    <Grid Grid.Row="1">',
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
    '                    <DataGrid Grid.Row="2"',
    '                              Name="DependencyProperty"',
    '                              HeadersVisibility="None">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="&lt;Q3ALive.Property&gt;"',
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
    '            <TabItem Header="Component"',
    '                     Name="ComponentTab"',
    '                     ToolTip="(Components/Prerequisites) for Q3A-Live">',
    '                <Grid>',
    '                    <Grid.RowDefinitions>',
    '                        <RowDefinition Height="85"/>',
    '                        <RowDefinition Height="60"/>',
    '                        <RowDefinition Height="90"/>',
    '                        <RowDefinition Height="*"/>',
    '                    </Grid.RowDefinitions>',
    '                    <DataGrid Grid.Row="0"',
    '                                  Name="ComponentOutput"',
    '                                  SelectionMode="Single"',
    '                                  CanUserReorderColumns="False"',
    '                                  CanUserResizeColumns="False"',
    '                                  CanUserSortColumns="False">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="&lt;Q3ALive.Component.Item&gt;"',
    '                                                               TextWrapping="Wrap"',
    '                                                               FontFamily="Consolas"',
    '                                                               Background="#000000"',
    '                                                               Foreground="#00FF00"/>',
    '                                            </Setter.Value>',
    '                                        </Setter>',
    '                                    </Trigger>',
    '                                </Style.Triggers>',
    '                            </Style>',
    '                        </DataGrid.RowStyle>',
    '                        <DataGrid.Columns>',
    '                            <DataGridTextColumn Header="Component"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="125"/>',
    '                            <DataGridTextColumn Header="Directory"',
    '                                                Binding="{Binding Fullname}"',
    '                                                Width="*"/>',
    '                            <DataGridTemplateColumn Header="Installed"',
    '                                                    Width="70">',
    '                                <DataGridTemplateColumn.CellTemplate>',
    '                                    <DataTemplate>',
    '                                        <ComboBox SelectedIndex="{Binding Installed}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                            <ComboBoxItem Content="[ ]"/>',
    '                                            <ComboBoxItem Content="[&#x2714;]"/>',
    '                                        </ComboBox>',
    '                                    </DataTemplate>',
    '                                </DataGridTemplateColumn.CellTemplate>',
    '                            </DataGridTemplateColumn>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <DataGrid Grid.Row="1"',
    '                              Name="ComponentBase"',
    '                              SelectionMode="Single"',
    '                              CanUserReorderColumns="False"',
    '                              CanUserResizeColumns="False"',
    '                              CanUserSortColumns="False"',
    '                              ScrollViewer.VerticalScrollBarVisibility="Visible">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="{Binding Fullname}"',
    '                                                               TextWrapping="Wrap"',
    '                                                               FontFamily="Consolas"',
    '                                                               Background="#000000"',
    '                                                               Foreground="#00FF00"/>',
    '                                            </Setter.Value>',
    '                                        </Setter>',
    '                                    </Trigger>',
    '                                </Style.Triggers>',
    '                            </Style>',
    '                        </DataGrid.RowStyle>',
    '                        <DataGrid.Columns>',
    '                            <DataGridTextColumn Header="Modified"',
    '                                                Binding="{Binding Modified}"',
    '                                                Width="140"/>',
    '                            <DataGridTextColumn Header="Name"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="*"/>',
    '                            <DataGridTextColumn Header="Size"',
    '                                                Binding="{Binding Size}"',
    '                                                ElementStyle="{StaticResource rTextBlock}"',
    '                                                Width="70"/>',
    '                            <DataGridTemplateColumn Header="Exists"',
    '                                                    Width="45">',
    '                                <DataGridTemplateColumn.CellTemplate>',
    '                                    <DataTemplate>',
    '                                        <CheckBox IsChecked="{Binding Exists}"',
    '                                                  IsHitTestVisible="False"',
    '                                                  Style="{StaticResource RoundedGreenCheckBox}"',
    '                                                  HorizontalAlignment="Right"/>',
    '                                    </DataTemplate>',
    '                                </DataGridTemplateColumn.CellTemplate>',
    '                            </DataGridTemplateColumn>',
    '                            <DataGridTemplateColumn Header="Open"',
    '                                                    Width="35">',
    '                                <DataGridTemplateColumn.CellTemplate>',
    '                                    <DataTemplate>',
    '                                        <CheckBox IsChecked="{Binding Opened}"',
    '                                                  IsHitTestVisible="False"',
    '                                                  Style="{StaticResource RoundedGreenCheckBox}"',
    '                                                  HorizontalAlignment="Right"/>',
    '                                    </DataTemplate>',
    '                                </DataGridTemplateColumn.CellTemplate>',
    '                            </DataGridTemplateColumn>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <DataGrid Grid.Row="2"',
    '                              Name="ComponentBaseOutput"',
    '                              SelectionMode="Single"',
    '                              HeadersVisibility="None"',
    '                              CanUserReorderColumns="False"',
    '                              CanUserResizeColumns="False"',
    '                              CanUserSortColumns="False"',
    '                              ScrollViewer.VerticalScrollBarVisibility="Visible">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="{Binding Fullname}"',
    '                                                               TextWrapping="Wrap"',
    '                                                               FontFamily="Consolas"',
    '                                                               Background="#000000"',
    '                                                               Foreground="#00FF00"/>',
    '                                            </Setter.Value>',
    '                                        </Setter>',
    '                                    </Trigger>',
    '                                </Style.Triggers>',
    '                            </Style>',
    '                        </DataGrid.RowStyle>',
    '                        <DataGrid.Columns>',
    '                            <DataGridTextColumn Header="Modified"',
    '                                                Binding="{Binding Modified}"',
    '                                                Width="140"/>',
    '                            <DataGridTextColumn Header="Name"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="*"/>',
    '                            <DataGridTextColumn Header="Size"',
    '                                                Binding="{Binding Size}"',
    '                                                ElementStyle="{StaticResource rTextBlock}"',
    '                                                Width="70"/>',
    '                            <DataGridTemplateColumn Header="Exists"',
    '                                                    Width="45">',
    '                                <DataGridTemplateColumn.CellTemplate>',
    '                                    <DataTemplate>',
    '                                        <CheckBox IsChecked="{Binding Exists}"',
    '                                                  IsHitTestVisible="False"',
    '                                                  Style="{StaticResource RoundedGreenCheckBox}"',
    '                                                  HorizontalAlignment="Right"/>',
    '                                    </DataTemplate>',
    '                                </DataGridTemplateColumn.CellTemplate>',
    '                            </DataGridTemplateColumn>',
    '                            <DataGridTemplateColumn Header="Open"',
    '                                                    Width="35">',
    '                                <DataGridTemplateColumn.CellTemplate>',
    '                                    <DataTemplate>',
    '                                        <CheckBox IsChecked="{Binding Loaded}"',
    '                                                  IsHitTestVisible="False"',
    '                                                  Focusable="False"',
    '                                                  Style="{StaticResource RoundedGreenCheckBox}"',
    '                                                  HorizontalAlignment="Right"/>',
    '                                    </DataTemplate>',
    '                                </DataGridTemplateColumn.CellTemplate>',
    '                            </DataGridTemplateColumn>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <TabControl Grid.Row="3">',
    '                        <TabItem Header="Output">',
    '                            <Grid>',
    '                                <Grid.RowDefinitions>',
    '                                    <RowDefinition Height="*"/>',
    '                                </Grid.RowDefinitions>',
    '                                <DataGrid Grid.Row="1"',
    '                                          Name="ComponentBaseItemOutput"',
    '                                          SelectionMode="Single"',
    '                                          CanUserReorderColumns="False"',
    '                                          CanUserResizeColumns="False"',
    '                                          CanUserSortColumns="False">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="{Binding Fullname}"',
    '                                                                               TextWrapping="Wrap"',
    '                                                                               FontFamily="Consolas"',
    '                                                                               Background="#000000"',
    '                                                                               Foreground="#00FF00"/>',
    '                                                        </Setter.Value>',
    '                                                    </Setter>',
    '                                                </Trigger>',
    '                                            </Style.Triggers>',
    '                                        </Style>',
    '                                    </DataGrid.RowStyle>',
    '                                    <DataGrid.Columns>',
    '                                        <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                        <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                        <DataGridTextColumn Header="Label"',
    '                                                                    Binding="{Binding Label}"',
    '                                                                    Width="70"/>',
    '                                        <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                                    Width="70"/>',
    '                                    </DataGrid.Columns>',
    '                                </DataGrid>',
    '                            </Grid>',
    '                        </TabItem>',
    '                        <TabItem Header="Shader"',
    '                                 IsEnabled="False">',
    '                            <Grid>',
    '                                <Grid.RowDefinitions>',
    '                                    <RowDefinition Height="85"/>',
    '                                    <RowDefinition Height="85"/>',
    '                                    <RowDefinition Height="*"/>',
    '                                </Grid.RowDefinitions>',
    '                                <DataGrid Grid.Row="0"',
    '                                                  Name="ComponentBaseShaderOutput"',
    '                                                  AutoGenerateColumns="False"',
    '                                                  IsReadOnly="True"',
    '                                                  SelectionUnit="FullRow"',
    '                                                  SelectionMode="Extended"',
    '                                                  CanUserAddRows="False"',
    '                                                  CanUserDeleteRows="False">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="{Binding Fullname}"',
    '                                                                               TextWrapping="Wrap"',
    '                                                                               FontFamily="Consolas"',
    '                                                                               Background="#000000"',
    '                                                                               Foreground="#00FF00"/>',
    '                                                        </Setter.Value>',
    '                                                    </Setter>',
    '                                                </Trigger>',
    '                                            </Style.Triggers>',
    '                                        </Style>',
    '                                    </DataGrid.RowStyle>',
    '                                    <DataGrid.Columns>',
    '                                        <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                        <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                        <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                                    Width="70"/>',
    '                                        <DataGridTemplateColumn Header="Used"',
    '                                                                        Width="55">',
    '                                            <DataGridTemplateColumn.CellTemplate>',
    '                                                <DataTemplate>',
    '                                                    <ComboBox SelectedIndex="{Binding IsReferenced}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                        <ComboBoxItem Content="[ ]"/>',
    '                                                        <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                    </ComboBox>',
    '                                                </DataTemplate>',
    '                                            </DataGridTemplateColumn.CellTemplate>',
    '                                        </DataGridTemplateColumn>',
    '                                    </DataGrid.Columns>',
    '                                </DataGrid>',
    '                                <DataGrid Grid.Row="1"',
    '                                                  Name="ComponentBaseShaderItemOutput"',
    '                                                  AutoGenerateColumns="False"',
    '                                                  IsReadOnly="True"',
    '                                                  SelectionUnit="FullRow"',
    '                                                  SelectionMode="Extended"',
    '                                                  CanUserAddRows="False"',
    '                                                  CanUserDeleteRows="False">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="{Binding Fullname}"',
    '                                                                               TextWrapping="Wrap"',
    '                                                                               FontFamily="Consolas"',
    '                                                                               Background="#000000"',
    '                                                                               Foreground="#00FF00"/>',
    '                                                        </Setter.Value>',
    '                                                    </Setter>',
    '                                                </Trigger>',
    '                                            </Style.Triggers>',
    '                                        </Style>',
    '                                    </DataGrid.RowStyle>',
    '                                    <DataGrid.Columns>',
    '                                        <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                        <DataGridTemplateColumn Header="Texture"',
    '                                                                        Width="55">',
    '                                            <DataGridTemplateColumn.CellTemplate>',
    '                                                <DataTemplate>',
    '                                                    <ComboBox SelectedIndex="{Binding IsTexture}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                        <ComboBoxItem Content="[ ]"/>',
    '                                                        <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                    </ComboBox>',
    '                                                </DataTemplate>',
    '                                            </DataGridTemplateColumn.CellTemplate>',
    '                                        </DataGridTemplateColumn>',
    '                                        <DataGridTemplateColumn Header="Virtual"',
    '                                                                        Width="55">',
    '                                            <DataGridTemplateColumn.CellTemplate>',
    '                                                <DataTemplate>',
    '                                                    <ComboBox SelectedIndex="{Binding IsVirtual}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                        <ComboBoxItem Content="[ ]"/>',
    '                                                        <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                    </ComboBox>',
    '                                                </DataTemplate>',
    '                                            </DataGridTemplateColumn.CellTemplate>',
    '                                        </DataGridTemplateColumn>',
    '                                        <DataGridTemplateColumn Header="Used"',
    '                                                                        Width="55">',
    '                                            <DataGridTemplateColumn.CellTemplate>',
    '                                                <DataTemplate>',
    '                                                    <ComboBox SelectedIndex="{Binding IsReferenced}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                        <ComboBoxItem Content="[ ]"/>',
    '                                                        <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                    </ComboBox>',
    '                                                </DataTemplate>',
    '                                            </DataGridTemplateColumn.CellTemplate>',
    '                                        </DataGridTemplateColumn>',
    '                                    </DataGrid.Columns>',
    '                                </DataGrid>',
    '                                <DataGrid Grid.Row="2"',
    '                                                  Name="ComponentBaseShaderItemContent"',
    '                                                  SelectionMode="Extended"',
    '                                                  HeadersVisibility="None">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="&lt;Q3ALive.Shader.Item.Content&gt;"',
    '                                                                               TextWrapping="Wrap"',
    '                                                                               FontFamily="Consolas"',
    '                                                                               Background="#000000"',
    '                                                                               Foreground="#00FF00"/>',
    '                                                        </Setter.Value>',
    '                                                    </Setter>',
    '                                                </Trigger>',
    '                                            </Style.Triggers>',
    '                                        </Style>',
    '                                    </DataGrid.RowStyle>',
    '                                    <DataGrid.Columns>',
    '                                        <DataGridTextColumn Header="#"',
    '                                                                    Binding="{Binding Index}"',
    '                                                                    Width="50"/>',
    '                                        <DataGridTextColumn Header="Line"',
    '                                                                    Binding="{Binding Line}"',
    '                                                                    Width="*"/>',
    '                                    </DataGrid.Columns>',
    '                                </DataGrid>',
    '                            </Grid>',
    '                        </TabItem>',
    '                        <TabItem Header="Texture"',
    '                                 IsEnabled="False">',
    '                            <Grid>',
    '                                <Grid.RowDefinitions>',
    '                                    <RowDefinition Height="*"/>',
    '                                    <RowDefinition Height="50"/>',
    '                                </Grid.RowDefinitions>',
    '                                <DataGrid Grid.Row="0"',
    '                                                  Name="ComponentBaseTextureOutput"',
    '                                                  AutoGenerateColumns="False"',
    '                                                  IsReadOnly="True"',
    '                                                  SelectionUnit="FullRow"',
    '                                                  SelectionMode="Extended"',
    '                                                  CanUserAddRows="False"',
    '                                                  CanUserDeleteRows="False">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="{Binding Fullname}"',
    '                                                                               TextWrapping="Wrap"',
    '                                                                               FontFamily="Consolas"',
    '                                                                               Background="#000000"',
    '                                                                               Foreground="#00FF00"/>',
    '                                                        </Setter.Value>',
    '                                                    </Setter>',
    '                                                </Trigger>',
    '                                            </Style.Triggers>',
    '                                        </Style>',
    '                                    </DataGrid.RowStyle>',
    '                                    <DataGrid.Columns>',
    '                                        <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                        <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="2*"/>',
    '                                        <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                                    Width="70"/>',
    '                                        <DataGridTemplateColumn Header="Used"',
    '                                                                        Width="55">',
    '                                            <DataGridTemplateColumn.CellTemplate>',
    '                                                <DataTemplate>',
    '                                                    <ComboBox SelectedIndex="{Binding IsReferenced}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                        <ComboBoxItem Content="[ ]"/>',
    '                                                        <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                    </ComboBox>',
    '                                                </DataTemplate>',
    '                                            </DataGridTemplateColumn.CellTemplate>',
    '                                        </DataGridTemplateColumn>',
    '                                    </DataGrid.Columns>',
    '                                </DataGrid>',
    '                                <DataGrid Grid.Row="1"',
    '                                                  Name="ComponentBaseTextureProperty"',
    '                                                  AutoGenerateColumns="False"',
    '                                                  IsReadOnly="True"',
    '                                                  SelectionUnit="FullRow"',
    '                                                  SelectionMode="Extended"',
    '                                                  CanUserAddRows="False"',
    '                                                  CanUserDeleteRows="False">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="{Binding Fullname}"',
    '                                                                               TextWrapping="Wrap"',
    '                                                                               FontFamily="Consolas"',
    '                                                                               Background="#000000"',
    '                                                                               Foreground="#00FF00"/>',
    '                                                        </Setter.Value>',
    '                                                    </Setter>',
    '                                                </Trigger>',
    '                                            </Style.Triggers>',
    '                                        </Style>',
    '                                    </DataGrid.RowStyle>',
    '                                    <DataGrid.Columns>',
    '                                        <DataGridTextColumn Header="Reference"',
    '                                                                    Binding="{Binding Reference}"',
    '                                                                    Width="*"/>',
    '                                        <DataGridTextColumn Header="Name"',
    '                                                                    Binding="{Binding Name}"',
    '                                                                    Width="*"/>',
    '                                        <DataGridTextColumn Header="Label"',
    '                                                                    Binding="{Binding Label}"',
    '                                                                    Width="50"/>',
    '                                    </DataGrid.Columns>',
    '                                </DataGrid>',
    '                            </Grid>',
    '                        </TabItem>',
    '                        <TabItem Header="Map"',
    '                                 IsEnabled="False">',
    '                            <Grid>',
    '                                <Grid.RowDefinitions>',
    '                                    <RowDefinition Height="*"/>',
    '                                </Grid.RowDefinitions>',
    '                                <DataGrid Grid.Row="1"',
    '                                                  Name="ComponentBaseMapOutput"',
    '                                                  SelectionMode="Single">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="{Binding Fullname}"',
    '                                                                               TextWrapping="Wrap"',
    '                                                                               FontFamily="Consolas"',
    '                                                                               Background="#000000"',
    '                                                                               Foreground="#00FF00"/>',
    '                                                        </Setter.Value>',
    '                                                    </Setter>',
    '                                                </Trigger>',
    '                                            </Style.Triggers>',
    '                                        </Style>',
    '                                    </DataGrid.RowStyle>',
    '                                    <DataGrid.Columns>',
    '                                        <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                        <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                        <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                                    Width="70"/>',
    '                                    </DataGrid.Columns>',
    '                                </DataGrid>',
    '                            </Grid>',
    '                        </TabItem>',
    '                        <TabItem Header="Levelshot"',
    '                                 IsEnabled="False">',
    '                            <Grid>',
    '                                <Grid.RowDefinitions>',
    '                                    <RowDefinition Height="75"/>',
    '                                    <RowDefinition Height="*"/>',
    '                                </Grid.RowDefinitions>',
    '                                <DataGrid Grid.Row="0"',
    '                                                  Name="ComponentBaseLevelshotOutput"',
    '                                                  AutoGenerateColumns="False"',
    '                                                  IsReadOnly="True"',
    '                                                  SelectionUnit="FullRow"',
    '                                                  SelectionMode="Extended"',
    '                                                  CanUserAddRows="False"',
    '                                                  CanUserDeleteRows="False">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="{Binding Fullname}"',
    '                                                                               TextWrapping="Wrap"',
    '                                                                               FontFamily="Consolas"',
    '                                                                               Background="#000000"',
    '                                                                               Foreground="#00FF00"/>',
    '                                                        </Setter.Value>',
    '                                                    </Setter>',
    '                                                </Trigger>',
    '                                            </Style.Triggers>',
    '                                        </Style>',
    '                                    </DataGrid.RowStyle>',
    '                                    <DataGrid.Columns>',
    '                                        <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                        <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                        <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                                    Width="70"/>',
    '                                    </DataGrid.Columns>',
    '                                </DataGrid>',
    '                                <Image Grid.Row="1"',
    '                                               Name="ComponentBaseLevelshotImage"/>',
    '                                <Grid Grid.Row="2">',
    '                                    <Grid.ColumnDefinitions>',
    '                                        <ColumnDefinition Width="*"/>',
    '                                        <ColumnDefinition Width="90"/>',
    '                                        <ColumnDefinition Width="*"/>',
    '                                    </Grid.ColumnDefinitions>',
    '                                </Grid>',
    '                            </Grid>',
    '                        </TabItem>',
    '                        <TabItem Header="Arena"',
    '                                 IsEnabled="False">',
    '                            <Grid>',
    '                                <Grid.RowDefinitions>',
    '                                    <RowDefinition Height="90"/>',
    '                                    <RowDefinition Height="*"/>',
    '                                </Grid.RowDefinitions>',
    '                                <DataGrid Grid.Row="0"',
    '                                                  Name="ComponentBaseArenaOutput"',
    '                                                  AutoGenerateColumns="False"',
    '                                                  IsReadOnly="True"',
    '                                                  SelectionUnit="FullRow"',
    '                                                  SelectionMode="Extended"',
    '                                                  CanUserAddRows="False"',
    '                                                  CanUserDeleteRows="False">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="{Binding Fullname}"',
    '                                                                               TextWrapping="Wrap"',
    '                                                                               FontFamily="Consolas"',
    '                                                                               Background="#000000"',
    '                                                                               Foreground="#00FF00"/>',
    '                                                        </Setter.Value>',
    '                                                    </Setter>',
    '                                                </Trigger>',
    '                                            </Style.Triggers>',
    '                                        </Style>',
    '                                    </DataGrid.RowStyle>',
    '                                    <DataGrid.Columns>',
    '                                        <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                        <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                        <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                                    Width="70"/>',
    '                                    </DataGrid.Columns>',
    '                                </DataGrid>',
    '                                <TextBox Grid.Row="1"',
    '                                                 Name="ComponentBaseSourceArenaContent"',
    '                                                 VerticalAlignment="Top"',
    '                                                 VerticalContentAlignment="Top"',
    '                                                 AcceptsReturn="True"',
    '                                                 Height="175">',
    '                                </TextBox>',
    '                            </Grid>',
    '                        </TabItem>',
    '                        <TabItem Header="Model"',
    '                                 IsEnabled="False">',
    '                            <DataGrid Grid.Row="0"',
    '                                              Name="ComponentBaseModelOutput"',
    '                                              AutoGenerateColumns="False"',
    '                                              IsReadOnly="True"',
    '                                              SelectionUnit="FullRow"',
    '                                              SelectionMode="Extended"',
    '                                              CanUserAddRows="False"',
    '                                              CanUserDeleteRows="False">',
    '                                <DataGrid.RowStyle>',
    '                                    <Style TargetType="{x:Type DataGridRow}">',
    '                                        <Style.Triggers>',
    '                                            <Trigger Property="IsMouseOver" Value="True">',
    '                                                <Setter Property="ToolTip">',
    '                                                    <Setter.Value>',
    '                                                        <TextBlock Text="{Binding Fullname}"',
    '                                                                           TextWrapping="Wrap"',
    '                                                                           FontFamily="Consolas"',
    '                                                                           Background="#000000"',
    '                                                                           Foreground="#00FF00"/>',
    '                                                    </Setter.Value>',
    '                                                </Setter>',
    '                                            </Trigger>',
    '                                        </Style.Triggers>',
    '                                    </Style>',
    '                                </DataGrid.RowStyle>',
    '                                <DataGrid.Columns>',
    '                                    <DataGridTextColumn Header="Modified"',
    '                                                                Binding="{Binding Modified}"',
    '                                                                Width="135"/>',
    '                                    <DataGridTextColumn Header="DisplayName"',
    '                                                                Binding="{Binding DisplayName}"',
    '                                                                Width="*"/>',
    '                                    <DataGridTextColumn Header="Size"',
    '                                                                Binding="{Binding Size}"',
    '                                                                ElementStyle="{StaticResource rTextBlock}"',
    '                                                                Width="70"/>',
    '                                </DataGrid.Columns>',
    '                            </DataGrid>',
    '                        </TabItem>',
    '                        <TabItem Header="Sound"',
    '                                 IsEnabled="False">',
    '                            <DataGrid Grid.Row="0"',
    '                                              Name="ComponentBaseSoundOutput"',
    '                                              AutoGenerateColumns="False"',
    '                                              IsReadOnly="True"',
    '                                              SelectionUnit="FullRow"',
    '                                              SelectionMode="Extended"',
    '                                              CanUserAddRows="False"',
    '                                              CanUserDeleteRows="False">',
    '                                <DataGrid.RowStyle>',
    '                                    <Style TargetType="{x:Type DataGridRow}">',
    '                                        <Style.Triggers>',
    '                                            <Trigger Property="IsMouseOver" Value="True">',
    '                                                <Setter Property="ToolTip">',
    '                                                    <Setter.Value>',
    '                                                        <TextBlock Text="{Binding Fullname}"',
    '                                                                           TextWrapping="Wrap"',
    '                                                                           FontFamily="Consolas"',
    '                                                                           Background="#000000"',
    '                                                                           Foreground="#00FF00"/>',
    '                                                    </Setter.Value>',
    '                                                </Setter>',
    '                                            </Trigger>',
    '                                        </Style.Triggers>',
    '                                    </Style>',
    '                                </DataGrid.RowStyle>',
    '                                <DataGrid.Columns>',
    '                                    <DataGridTextColumn Header="Modified"',
    '                                                                Binding="{Binding Modified}"',
    '                                                                Width="135"/>',
    '                                    <DataGridTextColumn Header="DisplayName"',
    '                                                                Binding="{Binding DisplayName}"',
    '                                                                Width="*"/>',
    '                                    <DataGridTextColumn Header="Size"',
    '                                                                Binding="{Binding Size}"',
    '                                                                ElementStyle="{StaticResource rTextBlock}"',
    '                                                                Width="70"/>',
    '                                </DataGrid.Columns>',
    '                            </DataGrid>',
    '                        </TabItem>',
    '                        <TabItem Header="Music"',
    '                                 IsEnabled="False">',
    '                            <DataGrid Grid.Row="0"',
    '                                              Name="ComponentMusicOutput"',
    '                                              AutoGenerateColumns="False"',
    '                                              IsReadOnly="True"',
    '                                              SelectionUnit="FullRow"',
    '                                              SelectionMode="Extended"',
    '                                              CanUserAddRows="False"',
    '                                              CanUserDeleteRows="False">',
    '                                <DataGrid.RowStyle>',
    '                                    <Style TargetType="{x:Type DataGridRow}">',
    '                                        <Style.Triggers>',
    '                                            <Trigger Property="IsMouseOver" Value="True">',
    '                                                <Setter Property="ToolTip">',
    '                                                    <Setter.Value>',
    '                                                        <TextBlock Text="{Binding Fullname}"',
    '                                                                           TextWrapping="Wrap"',
    '                                                                           FontFamily="Consolas"',
    '                                                                           Background="#000000"',
    '                                                                           Foreground="#00FF00"/>',
    '                                                    </Setter.Value>',
    '                                                </Setter>',
    '                                            </Trigger>',
    '                                        </Style.Triggers>',
    '                                    </Style>',
    '                                </DataGrid.RowStyle>',
    '                                <DataGrid.Columns>',
    '                                    <DataGridTextColumn Header="Modified"',
    '                                                                Binding="{Binding Modified}"',
    '                                                                Width="135"/>',
    '                                    <DataGridTextColumn Header="DisplayName"',
    '                                                                Binding="{Binding DisplayName}"',
    '                                                                Width="*"/>',
    '                                    <DataGridTextColumn Header="Size"',
    '                                                                Binding="{Binding Size}"',
    '                                                                ElementStyle="{StaticResource rTextBlock}"',
    '                                                                Width="70"/>',
    '                                </DataGrid.Columns>',
    '                            </DataGrid>',
    '                        </TabItem>',
    '                    </TabControl>',
    '                </Grid>',
    '            </TabItem>',
    '            <TabItem Header="Radiant"',
    '                     Name="RadiantTab">',
    '                <Grid>',
    '                    <Grid.RowDefinitions>',
    '                        <RowDefinition Height="85"/>',
    '                        <RowDefinition Height="65"/>',
    '                        <RowDefinition Height="*"/>',
    '                        <RowDefinition Height="40"/>',
    '                    </Grid.RowDefinitions>',
    '                    <DataGrid Grid.Row="0"',
    '                              Name="RadiantOutput"',
    '                              SelectionMode="Single"',
    '                              CanUserReorderColumns="False"',
    '                              CanUserResizeColumns="False"',
    '                              CanUserSortColumns="False">',
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
    '                            <DataGridTextColumn Header="Radiant"',
    '                                                Binding="{Binding Name}"',
    '                                                Width="125"/>',
    '                            <DataGridTextColumn Header="Directory"',
    '                                                Binding="{Binding Fullname}"',
    '                                                Width="*"/>',
    '                            <DataGridTemplateColumn Header="Installed"',
    '                                                    Width="70">',
    '                                <DataGridTemplateColumn.CellTemplate>',
    '                                    <DataTemplate>',
    '                                        <CheckBox IsChecked="{Binding Installed}"',
    '                                                  IsHitTestVisible="False"',
    '                                                  Style="{StaticResource RoundedGreenCheckBox}"',
    '                                                  HorizontalAlignment="Right"/>',
    '                                    </DataTemplate>',
    '                                </DataGridTemplateColumn.CellTemplate>',
    '                            </DataGridTemplateColumn>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <DataGrid Grid.Row="1"',
    '                              Name="RadiantProperty"',
    '                              HeadersVisibility="None">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="&lt;Q3ALive.Property&gt;"',
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
    '                    <DataGrid Grid.Row="2"',
    '                                          Name="RadiantItemOutput"',
    '                                          SelectionMode="Single">',
    '                        <DataGrid.RowStyle>',
    '                            <Style TargetType="{x:Type DataGridRow}">',
    '                                <Style.Triggers>',
    '                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                        <Setter Property="ToolTip">',
    '                                            <Setter.Value>',
    '                                                <TextBlock Text="{Binding Fullname}"',
    '                                                                       TextWrapping="Wrap"',
    '                                                                       FontFamily="Consolas"',
    '                                                                       Background="#000000"',
    '                                                                       Foreground="#00FF00"/>',
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
    '                            <DataGridTextColumn Header="DisplayName"',
    '                                                Binding="{Binding DisplayName}"',
    '                                                Width="*"/>',
    '                            <DataGridTextColumn Header="Size"',
    '                                                Binding="{Binding Size}"',
    '                                                ElementStyle="{StaticResource rTextBlock}"',
    '                                                Width="70"/>',
    '                            <DataGridTemplateColumn Header="Exists"',
    '                                                    Width="70">',
    '                                <DataGridTemplateColumn.CellTemplate>',
    '                                    <DataTemplate>',
    '                                        <CheckBox IsChecked="{Binding Exists}"',
    '														  IsHitTestVisible="False"',
    '														  Style="{StaticResource RoundedGreenCheckBox}"',
    '														  HorizontalAlignment="Right"/>',
    '                                    </DataTemplate>',
    '                                </DataGridTemplateColumn.CellTemplate>',
    '                            </DataGridTemplateColumn>',
    '                        </DataGrid.Columns>',
    '                    </DataGrid>',
    '                    <Grid Grid.Row="3">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="70"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="25"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                            <ColumnDefinition Width="70"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <Button Grid.Column="0"',
    '                                Content="Launch"',
    '                                Name="RadiantLaunch"/>',
    '                        <TextBox Grid.Column="1"',
    '                                 Name="RadiantLaunchParamText"/>',
    '                        <Image Grid.Column="2"',
    '                               Name="RadiantLaunchParamIcon"/>',
    '                        <Button Grid.Column="3"',
    '                                Content="Browse"',
    '                                Name="RadiantBrowse"/>',
    '                        <Button Grid.Column="4"',
    '                                Content="Close"',
    '                                Name="RadiantClose"/>',
    '                    </Grid>',
    '                </Grid>',
    '            </TabItem>',
    '            <TabItem Header="Workspace"',
    '                     Name="WorkspaceTab">',
    '                <Grid>',
    '                    <Grid.RowDefinitions>',
    '                        <RowDefinition Height="50"/>',
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="*"/>',
    '                    </Grid.RowDefinitions>',
    '                    <Grid Grid.Row="0">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="80"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <DataGrid Grid.Column="0"',
    '                                  Name="WorkspaceProperty"',
    '                                  IsHitTestVisible="False">',
    '                            <DataGrid.RowStyle>',
    '                                <Style TargetType="{x:Type DataGridRow}">',
    '                                    <Style.Triggers>',
    '                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                            <Setter Property="ToolTip">',
    '                                                <Setter.Value>',
    '                                                    <TextBlock Text="{Binding Fullname}"',
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
    '                                <DataGridTextColumn Header="Modified"',
    '                                                Binding="{Binding Modified}"',
    '                                                Width="135"/>',
    '                                <DataGridTextColumn Header="Fullname"',
    '                                                Binding="{Binding Fullname}"',
    '                                                Width="*"/>',
    '                                <DataGridTextColumn Header="Size"',
    '                                                Binding="{Binding Size}"',
    '                                                ElementStyle="{StaticResource rTextBlock}"',
    '                                                Width="70"/>',
    '                                <DataGridTemplateColumn Header="Exists"',
    '                                                    Width="55">',
    '                                    <DataGridTemplateColumn.CellTemplate>',
    '                                        <DataTemplate>',
    '                                            <ComboBox SelectedIndex="{Binding Exists}"',
    '                                                  Style="{StaticResource DGCombo}"',
    '                                                  IsHitTestVisible="False">',
    '                                                <ComboBoxItem Content="[ ]"/>',
    '                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                            </ComboBox>',
    '                                        </DataTemplate>',
    '                                    </DataGridTemplateColumn.CellTemplate>',
    '                                </DataGridTemplateColumn>',
    '                            </DataGrid.Columns>',
    '                        </DataGrid>',
    '                        <ComboBox Grid.Column="1"',
    '                                  Name="WorkspaceSlot"',
    '                                  Style="{StaticResource BlackComboBox}">',
    '                            <ComboBoxItem Content="Log"/>',
    '                            <ComboBoxItem Content="Output"/>',
    '                        </ComboBox>',
    '                    </Grid>',
    '                    <Grid Grid.Row="1"',
    '                          Name="WorkspaceLogHeader"',
    '                          Visibility="Hidden">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="80"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <DataGrid Grid.Column="0"',
    '                                  Name="WorkspaceLogProperty"',
    '                                  IsHitTestVisible="False"',
    '                                  HeadersVisibility="None"',
    '                                  Height="25">',
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
    '                                <DataGridTextColumn Header="Modified"',
    '                                                    Binding="{Binding Modified}"',
    '                                                    Width="135"/>',
    '                                <DataGridTextColumn Header="Fullname"',
    '                                                    Binding="{Binding Fullname}"',
    '                                                    Width="*"/>',
    '                                <DataGridTextColumn Header="Size"',
    '                                                    Binding="{Binding Size}"',
    '                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                    Width="70"/>',
    '                                <DataGridTemplateColumn Header="Exists"',
    '                                                        Width="55">',
    '                                    <DataGridTemplateColumn.CellTemplate>',
    '                                        <DataTemplate>',
    '                                            <ComboBox SelectedIndex="{Binding Exists}"',
    '                                                      Style="{StaticResource DGCombo}"',
    '                                                      IsHitTestVisible="False">',
    '                                                <ComboBoxItem Content="[ ]"/>',
    '                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                            </ComboBox>',
    '                                        </DataTemplate>',
    '                                    </DataGridTemplateColumn.CellTemplate>',
    '                                </DataGridTemplateColumn>',
    '                            </DataGrid.Columns>',
    '                        </DataGrid>',
    '                        <Button Grid.Column="1"',
    '                                Name="WorkspaceLogRefresh"',
    '                                Content="Refresh"',
    '                                Height="30"/>',
    '                    </Grid>',
    '                    <Grid Grid.Row="2"',
    '                          Name="WorkspaceLogPanel"',
    '                          Visibility="Hidden">',
    '                        <Grid.RowDefinitions>',
    '                            <RowDefinition Height="*"/>',
    '                        </Grid.RowDefinitions>',
    '                        <DataGrid Grid.Row="2"',
    '                                  Name="WorkspaceLogOutput"',
    '                                  SelectionMode="Single"',
    '                                  VerticalScrollBarVisibility="Visible">',
    '                            <DataGrid.RowStyle>',
    '                                <Style TargetType="{x:Type DataGridRow}">',
    '                                    <Style.Triggers>',
    '                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                            <Setter Property="ToolTip">',
    '                                                <Setter.Value>',
    '                                                    <TextBlock Text="&lt;Q3ALive.Workspace.Log.Entry&gt;"',
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
    '                                <DataGridTextColumn Header="#"',
    '                                                    Binding="{Binding Index}"',
    '                                                    Width="40"/>',
    '                                <DataGridTextColumn Header="Date"',
    '                                                    Binding="{Binding Date}"',
    '                                                    Width="75"/>',
    '                                <DataGridTextColumn Header="Time"',
    '                                                    Binding="{Binding Time}"',
    '                                                    Width="60"/>',
    '                                <DataGridTextColumn Header="Hash"',
    '                                                    Binding="{Binding Hash}"',
    '                                                    Width="220"/>',
    '                                <DataGridTextColumn Header="Source"',
    '                                                    Binding="{Binding Source}"',
    '                                                    Width="*"/>',
    '                            </DataGrid.Columns>',
    '                        </DataGrid>',
    '                    </Grid>',
    '                    <Grid Grid.Row="1"',
    '                          Name="WorkspaceOutputHeader"',
    '                          Visibility="Hidden">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="25"/>',
    '                            <ColumnDefinition Width="40"/>',
    '                            <ColumnDefinition Width="40"/>',
    '                            <ColumnDefinition Width="80"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <TextBox Grid.Column="0"',
    '                                 Name="WorkspaceOutputPathText"/>',
    '                        <Image Grid.Column="1"',
    '                               Name="WorkspaceOutputPathIcon"/>',
    '                        <Button Grid.Column="2"',
    '                                Name="WorkspaceOutputAdd"',
    '                                Content="+"/>',
    '                        <Button Grid.Column="3"',
    '                                Name="WorkspaceOutputRemove"',
    '                                Content="-"/>',
    '                        <Button Grid.Column="4"',
    '                                Name="WorkspaceOutputRefresh"',
    '                                Content="Refresh"/>',
    '                    </Grid>',
    '                    <Grid Grid.Row="2"',
    '                          Name="WorkspaceOutputPanel"',
    '                          Visibility="Hidden">',
    '                        <Grid.RowDefinitions>',
    '                            <RowDefinition Height="*"/>',
    '                        </Grid.RowDefinitions>',
    '                        <DataGrid Grid.Row="0"',
    '                                  Name="WorkspaceOutput"',
    '                                  SelectionMode="Single"',
    '                                  VerticalScrollBarVisibility="Visible">',
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
    '                                <DataGridTextColumn Header="Modified"',
    '                                                    Binding="{Binding Modified}"',
    '                                                    Width="135"/>',
    '                                <DataGridTextColumn Header="Name"',
    '                                                    Binding="{Binding Name}"',
    '                                                    Width="*"/>',
    '                                <DataGridTextColumn Header="Size"',
    '                                                    Binding="{Binding Size}"',
    '                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                    Width="70"/>',
    '                            </DataGrid.Columns>',
    '                        </DataGrid>',
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
    '                                                        ElementStyle="{StaticResource rTextBlock}"',
    '                                                        Width="80"/>',
    '                                </DataGrid.Columns>',
    '                            </DataGrid>',
    '                            <Grid Grid.Row="1">',
    '                                <Grid.ColumnDefinitions>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                    <ColumnDefinition Width="25"/>',
    '                                    <ColumnDefinition Width="160"/>',
    '                                </Grid.ColumnDefinitions>',
    '                                <TextBox Grid.Column="0"',
    '                                         Name="AssignmentResourcePathText"/>',
    '                                <Image Grid.Column="1"',
    '                                       Name="AssignmentResourcePathIcon"/>',
    '                                <Grid Grid.Column="2"',
    '                                      Name="AssignmentResourceBrowseHeader"',
    '                                      Visibility="Visible">',
    '                                    <Grid.ColumnDefinitions>',
    '                                        <ColumnDefinition Width="80"/>',
    '                                        <ColumnDefinition Width="40"/>',
    '                                        <ColumnDefinition Width="40"/>',
    '                                    </Grid.ColumnDefinitions>',
    '                                    <Button Grid.Column="0"',
    '                                            Name="AssignmentResourceBrowse"',
    '                                            Content="Browse"/>',
    '                                    <Button Grid.Column="1"',
    '                                            Name="AssignmentResourceAdd"',
    '                                            Content="+"/>',
    '                                    <Button Grid.Column="2"',
    '                                            Name="AssignmentResourceRemove"',
    '                                            Content="-"/>',
    '                                </Grid>',
    '                                <Grid Grid.Column="2"',
    '                                      Name="AssignmentResourceSelectHeader"',
    '                                      Visibility="Hidden">',
    '                                    <Grid.ColumnDefinitions>',
    '                                        <ColumnDefinition Width="80"/>',
    '                                        <ColumnDefinition Width="40"/>',
    '                                        <ColumnDefinition Width="40"/>',
    '                                    </Grid.ColumnDefinitions>',
    '                                    <Button Grid.Column="0"',
    '                                            Name="AssignmentResourceSelect"',
    '                                            Content="Select"/>',
    '                                    <Button Grid.Column="1"',
    '                                            Name="AssignmentResourceBack"',
    '                                            Content="&#x2190;"',
    '                                            ToolTip="Back"/>',
    '                                    <Button Grid.Column="2"',
    '                                            Name="AssignmentResourceCancel"',
    '                                            Content="X"',
    '                                            ToolTip="Cancel"/>',
    '                                </Grid>',
    '                            </Grid>',
    '                            <TabControl Grid.Row="2"',
    '                                        Name="AssignmentResourceBrowsePanel"',
    '                                        Visibility="Visible">',
    '                                <TabItem Header="Output">',
    '                                    <DataGrid Grid.Row="2"',
    '                                              Name="AssignmentResourceContent"',
    '                                              SelectionMode="Single">',
    '                                        <DataGrid.RowStyle>',
    '                                            <Style TargetType="{x:Type DataGridRow}">',
    '                                                <Style.Triggers>',
    '                                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                                        <Setter Property="ToolTip">',
    '                                                            <Setter.Value>',
    '                                                                <TextBlock Text="{Binding Fullname}"',
    '                                                                           TextWrapping="Wrap"',
    '                                                                           FontFamily="Consolas"',
    '                                                                           Background="#000000"',
    '                                                                           Foreground="#00FF00"/>',
    '                                                            </Setter.Value>',
    '                                                        </Setter>',
    '                                                    </Trigger>',
    '                                                </Style.Triggers>',
    '                                            </Style>',
    '                                        </DataGrid.RowStyle>',
    '                                        <DataGrid.Columns>',
    '                                            <DataGridTextColumn Header="Modified"',
    '                                                                Binding="{Binding Modified}"',
    '                                                                Width="135"/>',
    '                                            <DataGridTextColumn Header="DisplayName"',
    '                                                                Binding="{Binding DisplayName}"',
    '                                                                Width="*"/>',
    '                                            <DataGridTextColumn Header="Label"',
    '                                                                Binding="{Binding Label}"',
    '                                                                Width="70"/>',
    '                                            <DataGridTextColumn Header="Size"',
    '                                                                Binding="{Binding Size}"',
    '                                                                ElementStyle="{StaticResource rTextBlock}"',
    '                                                                Width="70"/>',
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
    '                                                  Name="AssignmentResourceShaderOutput"',
    '                                                  ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
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
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                                    Width="70"/>',
    '                                                <DataGridTemplateColumn Header="Used"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsReferenced}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
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
    '                                                <DataGridTemplateColumn Header="Texture"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsTexture}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
    '                                                <DataGridTemplateColumn Header="Virtual"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsVirtual}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
    '                                                <DataGridTemplateColumn Header="Used"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsReferenced}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
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
    '                                                                    <TextBlock Text="&lt;Q3ALive.Shader.Item.Content&gt;"',
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
    '                                                  Name="AssignmentResourceTextureOutput"',
    '                                                  ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
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
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="2*"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                                    Width="70"/>',
    '                                                <DataGridTemplateColumn Header="Used"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsReferenced}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                        <DataGrid Grid.Row="1"',
    '                                                  Name="AssignmentResourceTextureProperty"',
    '                                                  ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
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
    '                                                <DataGridTextColumn Header="Reference"',
    '                                                                    Binding="{Binding Reference}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridTextColumn Header="Name"',
    '                                                                    Binding="{Binding Name}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridTextColumn Header="Label"',
    '                                                                    Binding="{Binding Label}"',
    '                                                                    Width="50"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                    </Grid>',
    '                                </TabItem>',
    '                                <TabItem Header="Map"',
    '                                         IsEnabled="False">',
    '                                </TabItem>',
    '                                <TabItem Header="Levelshot"',
    '                                         IsEnabled="False">',
    '                                </TabItem>',
    '                                <TabItem Header="Arena"',
    '                                         IsEnabled="False">',
    '                                </TabItem>',
    '                                <TabItem Header="Model"',
    '                                         IsEnabled="False">',
    '                                </TabItem>',
    '                                <TabItem Header="Sound">',
    '                                    <Grid>',
    '                                        <Grid.RowDefinitions>',
    '                                            <RowDefinition Height="*"/>',
    '                                            <RowDefinition Height="40"/>',
    '                                        </Grid.RowDefinitions>',
    '                                        <DataGrid Grid.Row="0"',
    '                                              Name="AssignmentResourceSoundOutput"',
    '                                              ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                              AutoGenerateColumns="False"',
    '                                              IsReadOnly="True"',
    '                                              SelectionUnit="FullRow"',
    '                                              SelectionMode="Extended"',
    '                                              CanUserAddRows="False"',
    '                                              CanUserDeleteRows="False">',
    '                                            <DataGrid.RowStyle>',
    '                                                <Style TargetType="{x:Type DataGridRow}">',
    '                                                    <Style.Triggers>',
    '                                                        <Trigger Property="IsMouseOver" Value="True">',
    '                                                            <Setter Property="ToolTip">',
    '                                                                <Setter.Value>',
    '                                                                    <TextBlock Text="{Binding Fullname}"',
    '                                                                           TextWrapping="Wrap"',
    '                                                                           FontFamily="Consolas"',
    '                                                                           Background="#000000"',
    '                                                                           Foreground="#00FF00"/>',
    '                                                                </Setter.Value>',
    '                                                            </Setter>',
    '                                                        </Trigger>',
    '                                                    </Style.Triggers>',
    '                                                </Style>',
    '                                            </DataGrid.RowStyle>',
    '                                            <DataGrid.Columns>',
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                                Binding="{Binding Modified}"',
    '                                                                Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                                Binding="{Binding DisplayName}"',
    '                                                                Width="*"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                                Binding="{Binding Size}"',
    '                                                                ElementStyle="{StaticResource rTextBlock}"',
    '                                                                Width="70"/>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                        <Grid Grid.Row="1">',
    '                                            <Grid.ColumnDefinitions>',
    '                                                <ColumnDefinition Width="*"/>',
    '                                                <ColumnDefinition Width="60"/>',
    '                                                <ColumnDefinition Width="180"/>',
    '                                                <ColumnDefinition Width="60"/>',
    '                                                <ColumnDefinition Width="*"/>',
    '                                            </Grid.ColumnDefinitions>',
    '                                            <Button Grid.Column="1"',
    '                                                    Content="Play"',
    '                                                    Name="AssignmentResourceSoundPlay"/>',
    '                                            <Slider Grid.Column="2"',
    '                                                    Name="AssignmentResourceSoundTrack"',
    '                                                    Margin="5"',
    '                                                    HorizontalContentAlignment="Center"',
    '                                                    VerticalAlignment="Center"/>',
    '                                            <Button Grid.Column="3"',
    '                                                    Content="Stop"',
    '                                                    Name="AssignmentResourceSoundStop"/>',
    '                                        </Grid>',
    '                                    </Grid>',
    '                                </TabItem>',
    '                                <TabItem Header="Music"',
    '                                         IsEnabled="False">',
    '                                </TabItem>',
    '                            </TabControl>',
    '                            <Grid Grid.Row="2"',
    '                                  Name="AssignmentResourceSelectPanel"',
    '                                  Visibility="Hidden">',
    '                                <Grid.ColumnDefinitions>',
    '                                    <ColumnDefinition Width="160"/>',
    '                                    <ColumnDefinition Width="*"/>',
    '                                </Grid.ColumnDefinitions>',
    '                                <DataGrid Grid.Column="0"',
    '                                          Name="AssignmentResourceBrowseTree">',
    '                                    <DataGrid.Columns>',
    '                                        <DataGridTextColumn Header="Drive"',
    '                                                            Binding="{Binding Root}"',
    '                                                            Width="*"/>',
    '                                    </DataGrid.Columns>',
    '                                </DataGrid>',
    '                                <DataGrid Grid.Column="1"',
    '                                          Name="AssignmentResourceBrowseList"',
    '                                          SelectionMode="Single">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="{Binding Fullname}"',
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
    '                                        <DataGridTextColumn Header="Modified"',
    '                                                            Binding="{Binding Modified}"',
    '                                                            Width="135"/>',
    '                                        <DataGridTextColumn Header="Name"',
    '                                                            Binding="{Binding Name}"',
    '                                                            Width="*"/>',
    '                                        <DataGridTextColumn Header="Type"',
    '                                                            Binding="{Binding Type}"',
    '                                                            Width="70"/>',
    '                                        <DataGridTextColumn Header="Size"',
    '                                                            Binding="{Binding Size}"',
    '                                                            ElementStyle="{StaticResource rTextBlock}"',
    '                                                            Width="80"/>',
    '                                    </DataGrid.Columns>',
    '                                </DataGrid>',
    '                            </Grid>',
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
    '                                          Name="AssignmentSelectFilterProperty"',
    '                                          Style="{StaticResource BlackComboBox}">',
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
    '                                    <DataGridTextColumn Header="Modified"',
    '                                                        Binding="{Binding Modified}"',
    '                                                        Width="135"/>',
    '                                    <DataGridTextColumn Header="Name"',
    '                                                        Binding="{Binding Name}"',
    '                                                        Width="*"/>',
    '                                    <DataGridTextColumn Header="Size"',
    '                                                        Binding="{Binding Size}"',
    '                                                        ElementStyle="{StaticResource rTextBlock}"',
    '                                                        Width="80"/>',
    '                                    <DataGridTemplateColumn Header="&#x2714;"',
    '                                                            Width="20"',
    '                                                            IsReadOnly="False">',
    '                                        <DataGridTemplateColumn.CellTemplate>',
    '                                            <DataTemplate>',
    '                                                <CheckBox IsChecked="{Binding Selected, Mode=TwoWay, UpdateSourceTrigger=PropertyChanged}"',
    '                                                          Focusable="False"',
    '                                                          Style="{StaticResource RoundedGreenCheckBox}"/>',
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
    '                    <TabItem Header="Edit"',
    '                             Name="AssignmentEditTab">',
    '                        <Grid>',
    '                            <Grid.RowDefinitions>',
    '                                <RowDefinition Height="80"/>',
    '                                <RowDefinition Height="40"/>',
    '                                <RowDefinition Height="*"/>',
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
    '                                                        ElementStyle="{StaticResource rTextBlock}"',
    '                                                        Width="80"/>',
    '                                </DataGrid.Columns>',
    '                            </DataGrid>',
    '                            <Grid Grid.Row="1"',
    '                                  Name="AssignmentEditSourceHeader"',
    '                                  Visibility="Visible">',
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
    '                                         Name="AssignmentEditSourcePathText"/>',
    '                                <Image Grid.Column="2"',
    '                                       Name="AssignmentEditSourcePathIcon"/>',
    '                                <Button Grid.Column="3"',
    '                                        Name="AssignmentEditSourcePathAssign"',
    '                                        Content="Assign"',
    '                                        ToolTip="Open "/>',
    '                            </Grid>',
    '                            <TabControl Grid.Row="2">',
    '                                <TabItem Header="Details">',
    '                                    <Grid>',
    '                                        <Grid.RowDefinitions>',
    '                                            <RowDefinition Height="100"/>',
    '                                            <RowDefinition Height="*"/>',
    '                                        </Grid.RowDefinitions>',
    '                                        <Grid Grid.Row="0">',
    '                                            <Grid.ColumnDefinitions>',
    '                                                <ColumnDefinition Width="250"/>',
    '                                                <ColumnDefinition Width="*"/>',
    '                                            </Grid.ColumnDefinitions>',
    '                                            <DataGrid Grid.Row="0"',
    '                                                      Name="AssignmentEditProperty"',
    '                                                      HeadersVisibility="None"',
    '                                                      SelectionMode="Single">',
    '                                                <DataGrid.RowStyle>',
    '                                                    <Style TargetType="{x:Type DataGridRow}">',
    '                                                        <Style.Triggers>',
    '                                                            <Trigger Property="IsMouseOver" Value="True">',
    '                                                                <Setter Property="ToolTip">',
    '                                                                    <Setter.Value>',
    '                                                                        <TextBlock Text="&lt;Q3ALive.Assignment.Edit.Detail&gt;"',
    '                                                                                   TextWrapping="Wrap"',
    '                                                                                   FontFamily="Consolas"',
    '                                                                                   Background="#000000"',
    '                                                                                   Foreground="#00FF00"/>',
    '                                                                    </Setter.Value>',
    '                                                                </Setter>',
    '                                                            </Trigger>',
    '                                                        </Style.Triggers>',
    '                                                    </Style>',
    '                                                </DataGrid.RowStyle>',
    '                                                <DataGrid.Columns>',
    '                                                    <DataGridTextColumn Header="Name"',
    '                                                                        Binding="{Binding Name}"',
    '                                                                        Width="60"/>',
    '                                                    <DataGridTextColumn Header="Value"',
    '                                                                        Binding="{Binding Value}"',
    '                                                                        Width="*"/>',
    '                                                </DataGrid.Columns>',
    '                                            </DataGrid>',
    '                                            <Grid Grid.Column="1">',
    '                                                <Grid.RowDefinitions>',
    '                                                    <RowDefinition Height="10"/>',
    '                                                    <RowDefinition Height="40"/>',
    '                                                    <RowDefinition Height="40"/>',
    '                                                    <RowDefinition Height="*"/>',
    '                                                </Grid.RowDefinitions>',
    '                                                <Grid Grid.Row="1">',
    '                                                    <Grid.ColumnDefinitions>',
    '                                                        <ColumnDefinition Width="70"/>',
    '                                                        <ColumnDefinition Width="*"/>',
    '                                                        <ColumnDefinition Width="70"/>',
    '                                                    </Grid.ColumnDefinitions>',
    '                                                    <Button Grid.Column="0"',
    '                                                            Name="AssignmentEditMapPrecompile"',
    '                                                            Content="Precomp"',
    '                                                            ToolTip="Prepare (shaders/textures/models) for compilation + lightmap"/>',
    '                                                    <ComboBox Grid.Column="1"',
    '                                                              Name="AssignmentEditMapCompileParameters"',
    '                                                              SelectedIndex="5"',
    '                                                              Style="{StaticResource BlackComboBox}">',
    '                                                        <ComboBoxItem Content="Meta (Test for leaks)"/>',
    '                                                        <ComboBoxItem Content="Meta, Vis (Test Bsp tree)"/>',
    '                                                        <ComboBoxItem Content="Meta, Vis, Light (Lightmap)"/>',
    '                                                        <ComboBoxItem Content="Meta, Vis, Light, AAS (Full)"/>',
    '                                                        <ComboBoxItem Content="Meta, Vis, Light, AAS, Package"/>',
    '                                                        <ComboBoxItem Content="Meta, Vis, Light, AAS, Package, Publish"/>',
    '                                                    </ComboBox>',
    '                                                    <Button Grid.Column="2"',
    '                                                            Name="AssignmentEditMapCompile"',
    '                                                            Content="Compile"',
    '                                                            ToolTip="Compile the (*.map) file into (*.bsp) + (*.aas) files"/>',
    '                                                </Grid>',
    '                                                <Grid Grid.Row="2">',
    '                                                    <Grid.ColumnDefinitions>',
    '                                                        <ColumnDefinition Width="70"/>',
    '                                                        <ColumnDefinition Width="*"/>',
    '                                                        <ColumnDefinition Width="70"/>',
    '                                                    </Grid.ColumnDefinitions>',
    '                                                    <Button Grid.Column="0"',
    '                                                            Name="AssignmentEditMapLaunchEditor"',
    '                                                            Content="Edit"',
    '                                                            ToolTip="Launches the selected editor"/>',
    '                                                    <TextBox Grid.Column="1"',
    '                                                             Name="AssignmentEditMapTestParameters"',
    '                                                             ToolTip="Enter script to test the map"/>',
    '                                                    <Button Grid.Column="2"',
    '                                                            Name="AssignmentEditMapTest"',
    '                                                            Content="Test"',
    '                                                            ToolTip="Playtest the currently selected map"/>',
    '                                                </Grid>',
    '                                            </Grid>',
    '                                        </Grid>',
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
    '                                                                    <TextBlock Text="&lt;Q3ALive.Assignment.Edit.Reference&gt;"',
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
    '                                                <DataGridTextColumn Header="Reference"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridTemplateColumn Header="Default"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsDefault}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
    '                                                <DataGridTemplateColumn Header="Texture"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsTexture}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
    '                                                <DataGridTemplateColumn Header="Virtual"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsVirtual}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
    '                                                <DataGridTemplateColumn Header="Shader"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsShader}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
    '                                                <DataGridTemplateColumn Header="/Shader"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsSubshader}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
    '                                                <DataGridTemplateColumn Header="Missing"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsMissing}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
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
    '                                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                                    Width="70"/>',
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
    '                                                  Name="AssignmentEditSourceShaderOutput"',
    '                                                  ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
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
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                                    Width="70"/>',
    '                                                <DataGridTemplateColumn Header="Used"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsReferenced}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
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
    '                                                <DataGridTemplateColumn Header="Texture"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsTexture}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
    '                                                <DataGridTemplateColumn Header="Virtual"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsVirtual}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
    '                                                <DataGridTemplateColumn Header="Used"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsReferenced}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
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
    '                                                                    <TextBlock Text="&lt;Q3ALive.Shader.Item.Content&gt;"',
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
    '                                                  Name="AssignmentEditSourceTextureOutput"',
    '                                                  ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
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
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="2*"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                                    Width="70"/>',
    '                                                <DataGridTemplateColumn Header="Used"',
    '                                                                        Width="55">',
    '                                                    <DataGridTemplateColumn.CellTemplate>',
    '                                                        <DataTemplate>',
    '                                                            <ComboBox SelectedIndex="{Binding IsReferenced}"',
    '                                                                      Style="{StaticResource DGCombo}"',
    '                                                                      IsHitTestVisible="False">',
    '                                                                <ComboBoxItem Content="[ ]"/>',
    '                                                                <ComboBoxItem Content="[&#x2714;]"/>',
    '                                                            </ComboBox>',
    '                                                        </DataTemplate>',
    '                                                    </DataGridTemplateColumn.CellTemplate>',
    '                                                </DataGridTemplateColumn>',
    '                                            </DataGrid.Columns>',
    '                                        </DataGrid>',
    '                                        <DataGrid Grid.Row="1"',
    '                                                  Name="AssignmentEditSourceTextureProperty"',
    '                                                  ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
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
    '                                                <DataGridTextColumn Header="Reference"',
    '                                                                    Binding="{Binding Reference}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridTextColumn Header="Name"',
    '                                                                    Binding="{Binding Name}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridTextColumn Header="Label"',
    '                                                                    Binding="{Binding Label}"',
    '                                                                    Width="50"/>',
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
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                                    Width="70"/>',
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
    '                                                  Name="AssignmentEditSourceLevelshotOutput"',
    '                                                  ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
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
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                                    Width="70"/>',
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
    '                                                  Name="AssignmentEditSourceArenaOutput"',
    '                                                  ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
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
    '                                                <DataGridTextColumn Header="Modified"',
    '                                                                    Binding="{Binding Modified}"',
    '                                                                    Width="135"/>',
    '                                                <DataGridTextColumn Header="DisplayName"',
    '                                                                    Binding="{Binding DisplayName}"',
    '                                                                    Width="*"/>',
    '                                                <DataGridTextColumn Header="Size"',
    '                                                                    Binding="{Binding Size}"',
    '                                                                    ElementStyle="{StaticResource rTextBlock}"',
    '                                                                    Width="70"/>',
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
    '                                              Name="AssignmentEditSourceModelOutput"',
    '                                              ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                              AutoGenerateColumns="False"',
    '                                              IsReadOnly="True"',
    '                                              SelectionUnit="FullRow"',
    '                                              SelectionMode="Extended"',
    '                                              CanUserAddRows="False"',
    '                                              CanUserDeleteRows="False">',
    '                                        <DataGrid.RowStyle>',
    '                                            <Style TargetType="{x:Type DataGridRow}">',
    '                                                <Style.Triggers>',
    '                                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                                        <Setter Property="ToolTip">',
    '                                                            <Setter.Value>',
    '                                                                <TextBlock Text="{Binding Fullname}"',
    '                                                                           TextWrapping="Wrap"',
    '                                                                           FontFamily="Consolas"',
    '                                                                           Background="#000000"',
    '                                                                           Foreground="#00FF00"/>',
    '                                                            </Setter.Value>',
    '                                                        </Setter>',
    '                                                    </Trigger>',
    '                                                </Style.Triggers>',
    '                                            </Style>',
    '                                        </DataGrid.RowStyle>',
    '                                        <DataGrid.Columns>',
    '                                            <DataGridTextColumn Header="Modified"',
    '                                                                Binding="{Binding Modified}"',
    '                                                                Width="135"/>',
    '                                            <DataGridTextColumn Header="DisplayName"',
    '                                                                Binding="{Binding DisplayName}"',
    '                                                                Width="*"/>',
    '                                            <DataGridTextColumn Header="Size"',
    '                                                                Binding="{Binding Size}"',
    '                                                                ElementStyle="{StaticResource rTextBlock}"',
    '                                                                Width="70"/>',
    '                                        </DataGrid.Columns>',
    '                                    </DataGrid>',
    '                                </TabItem>',
    '                                <TabItem Header="Sound">',
    '                                    <Grid>',
    '                                        <Grid.RowDefinitions>',
    '                                            <RowDefinition Height="*"/>',
    '                                            <RowDefinition Height="40"/>',
    '                                        </Grid.RowDefinitions>',
    '                                        <DataGrid Grid.Row="0"',
    '                                              Name="AssignmentEditSourceSoundOutput"',
    '                                              ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                              AutoGenerateColumns="False"',
    '                                              IsReadOnly="True"',
    '                                              SelectionUnit="FullRow"',
    '                                              SelectionMode="Extended"',
    '                                              CanUserAddRows="False"',
    '                                              CanUserDeleteRows="False">',
    '                                        <DataGrid.RowStyle>',
    '                                            <Style TargetType="{x:Type DataGridRow}">',
    '                                                <Style.Triggers>',
    '                                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                                        <Setter Property="ToolTip">',
    '                                                            <Setter.Value>',
    '                                                                <TextBlock Text="{Binding Fullname}"',
    '                                                                           TextWrapping="Wrap"',
    '                                                                           FontFamily="Consolas"',
    '                                                                           Background="#000000"',
    '                                                                           Foreground="#00FF00"/>',
    '                                                            </Setter.Value>',
    '                                                        </Setter>',
    '                                                    </Trigger>',
    '                                                </Style.Triggers>',
    '                                            </Style>',
    '                                        </DataGrid.RowStyle>',
    '                                        <DataGrid.Columns>',
    '                                            <DataGridTextColumn Header="Modified"',
    '                                                                Binding="{Binding Modified}"',
    '                                                                Width="135"/>',
    '                                            <DataGridTextColumn Header="DisplayName"',
    '                                                                Binding="{Binding DisplayName}"',
    '                                                                Width="*"/>',
    '                                            <DataGridTextColumn Header="Size"',
    '                                                                Binding="{Binding Size}"',
    '                                                                ElementStyle="{StaticResource rTextBlock}"',
    '                                                                Width="70"/>',
    '                                        </DataGrid.Columns>',
    '                                    </DataGrid>',
    '                                        <Grid Grid.Row="1">',
    '                                            <Grid.ColumnDefinitions>',
    '                                                <ColumnDefinition Width="*"/>',
    '                                                <ColumnDefinition Width="60"/>',
    '                                                <ColumnDefinition Width="180"/>',
    '                                                <ColumnDefinition Width="60"/>',
    '                                                <ColumnDefinition Width="*"/>',
    '                                            </Grid.ColumnDefinitions>',
    '                                            <Button Grid.Column="1"',
    '                                                    Content="Play"',
    '                                                    Name="AssignmentEditSourceSoundPlay"/>',
    '                                            <Slider Grid.Column="2"',
    '                                                    Name="AssignmentEditSourceSoundTrack"',
    '                                                    Margin="5"',
    '                                                    HorizontalContentAlignment="Center"',
    '                                                    VerticalAlignment="Center"/>',
    '                                            <Button Grid.Column="3"',
    '                                                    Content="Stop"',
    '                                                    Name="AssignmentEditSourceSoundStop"/>',
    '                                        </Grid>',
    '                                    </Grid>',
    '                                </TabItem>',
    '                                <TabItem Header="Music">',
    '                                    <DataGrid Grid.Row="0"',
    '                                              Name="AssignmentEditSourceMusicOutput"',
    '                                              ItemsSource="{Binding Source={StaticResource AssignmentSelectView}}"',
    '                                              AutoGenerateColumns="False"',
    '                                              IsReadOnly="True"',
    '                                              SelectionUnit="FullRow"',
    '                                              SelectionMode="Extended"',
    '                                              CanUserAddRows="False"',
    '                                              CanUserDeleteRows="False">',
    '                                        <DataGrid.RowStyle>',
    '                                            <Style TargetType="{x:Type DataGridRow}">',
    '                                                <Style.Triggers>',
    '                                                    <Trigger Property="IsMouseOver" Value="True">',
    '                                                        <Setter Property="ToolTip">',
    '                                                            <Setter.Value>',
    '                                                                <TextBlock Text="{Binding Fullname}"',
    '                                                                           TextWrapping="Wrap"',
    '                                                                           FontFamily="Consolas"',
    '                                                                           Background="#000000"',
    '                                                                           Foreground="#00FF00"/>',
    '                                                            </Setter.Value>',
    '                                                        </Setter>',
    '                                                    </Trigger>',
    '                                                </Style.Triggers>',
    '                                            </Style>',
    '                                        </DataGrid.RowStyle>',
    '                                        <DataGrid.Columns>',
    '                                            <DataGridTextColumn Header="Modified"',
    '                                                                Binding="{Binding Modified}"',
    '                                                                Width="135"/>',
    '                                            <DataGridTextColumn Header="DisplayName"',
    '                                                                Binding="{Binding DisplayName}"',
    '                                                                Width="*"/>',
    '                                            <DataGridTextColumn Header="Size"',
    '                                                                Binding="{Binding Size}"',
    '                                                                ElementStyle="{StaticResource rTextBlock}"',
    '                                                                Width="70"/>',
    '                                        </DataGrid.Columns>',
    '                                    </DataGrid>',
    '                                </TabItem>',
    '                            </TabControl>',
    '                        </Grid>',
    '                    </TabItem>',
    '                    <TabItem Header="Extract">',
    '                        <Grid>',
    '                            <Grid.RowDefinitions>',
    '                                <RowDefinition Height="40"/>',
    '                                <RowDefinition Height="*"/>',
    '                            </Grid.RowDefinitions>',
    '                        </Grid>',
    '                    </TabItem>',
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
    '                                  Name="SteamSlot"',
    '                                  Style="{StaticResource BlackComboBox}">',
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
    '                                      Name="SteamWorkshopProjectSlot"',
    '                                      Style="{StaticResource BlackComboBox}">',
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
    '                                          Name="SteamWorkshopProjectDetailsSelected"',
    '                                          HeadersVisibility="None"',
    '                                          Height="20"',
    '                                          VerticalAlignment="Center"',
    '                                          SelectionMode="Single">',
    '                                    <DataGrid.RowStyle>',
    '                                        <Style TargetType="{x:Type DataGridRow}">',
    '                                            <Style.Triggers>',
    '                                                <Trigger Property="IsMouseOver" Value="True">',
    '                                                    <Setter Property="ToolTip">',
    '                                                        <Setter.Value>',
    '                                                            <TextBlock Text="&lt;Q3ALive.Steam.Workshop.Item&gt;"',
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
    '                        <RowDefinition Height="40"/>',
    '                        <RowDefinition Height="*"/>',
    '                        <RowDefinition Height="40"/>',
    '                    </Grid.RowDefinitions>',
    '                    <Grid Grid.Row="0">',
    '                        <Grid.ColumnDefinitions>',
    '                            <ColumnDefinition Width="120"/>',
    '                            <ColumnDefinition Width="*"/>',
    '                            <ColumnDefinition Width="90"/>',
    '                        </Grid.ColumnDefinitions>',
    '                        <ComboBox Grid.Column="0"',
    '                                  Name="ConsoleProperty"',
    '                                  SelectedIndex="3"',
    '                                  Style="{StaticResource BlackComboBox}">',
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
    '                    <DataGrid Grid.Row="1"',
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
    '                    <Grid Grid.Row="2">',
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
   \\__//¯¯¯ Component [~]                                                                                  ___//¯¯\\   
    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
#>

Class Q3ALiveComponentBase
{
    [String]     $Type
    [String] $Modified
    [String]     $Name
    [String] $Fullname
    [UInt32]   $Exists
    [Object]     $Size
    [UInt32]   $Opened
    [Object]   $Output
    Q3ALiveComponentBase([String]$Type)
    {
        $This.Type     = $Type
        $This.Fullname = "<not set>"
    }
    Assign([String]$Fullname)
    {
        $This.Fullname = $Fullname
        $This.Name     = $Fullname | Split-Path -Leaf
        $This.Refresh()
    }
    Clear()
    {
        $This.Output   = @( )
        $This.Opened   = 0
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
            $List          = $Tree.Output | ? Extension -eq $This.ExtensionFilter()
            $Hash          = @{ }
            ForEach ($Item in $List)
            {
                $Hash.Add($Hash.Count,$This.Q3ALivePackageFileItem($Hash.Count,$Item))
            }

            $This.Modified = $Tree.Modified
            $This.Output   = Switch ($Hash.Count) { 0 { } 1 { $Hash[0] } Default { $Hash[0..($Hash.Count-1)] } }
            $This.Size     = $Tree.Size
            $This.Opened   = 1
        }
    }
    [String] ExtensionFilter()
    {
        Return @{ Q2 = "pak"; Q3A = "pk3"; Live = "pk3"; Q4 = "pk4" }[$This.Type]
    }
    [Object] Q3ALiveDirectoryScan()
    {
        Return [Q3ALive.DirectoryScan]::New($This.Fullname,2,1)
    }
    [Object] Q3ALivePackageFileItem([UInt32]$Index,[Object]$Object)
    {
        Return [Q3ALive.PackageFileItem]::New($Index,$This.ExtensionFilter(),$Object)
    }
    [String] ToString()
    {
        Return $This.Fullname
    }
}

Class Q3ALiveComponentItem
{
    [UInt32]      $Index
    [String]       $Name
    [String]   $Fullname
    [UInt32]  $Installed
    [UInt32]   $Selected
    [Object]       $Base
    [Object] $Executable
    Q3ALiveComponentItem([UInt32]$Index,[String]$Name)
    {
        $This.Index      = $Index
        $This.Name       = $Name

        $This.Fullname   = "<not set>"
        $This.Base       = $This.Q3ALiveComponentBase()
        $This.Executable = "<not set>"
    }
    Assign([String]$Fullname)
    {
        If ([System.IO.Directory]::Exists($Fullname))
        {
            $This.Fullname   = $Fullname
            $This.Base.Assign("$($This.Fullname)\baseq3")
            $This.Executable = "$Fullname\{0}.exe" -f $This.Engine()

            If ([System.IO.File]::Exists($This.Executable))
            {
                $This.Installed = 1
            }
        }
    }
    [Object] Q3ALiveComponentBase()
    {
        Return [Q3ALiveComponentBase]::New($This.Name)
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
    [Object] Q3ALiveComponentItem([UInt32]$Index,[String]$Name)
    {
        Return [Q3ALiveComponentItem]::New($Index,$Name)
    }
    [String] ToString()
    {
        Return "<Q3ALive.Component.List>"
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
    [Object]    $Output
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
        $This.Output   = @( )
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
            $This.Output   = Switch ($Hash.Count) { 0 { @( ) } 1 { @($Hash[0]) } Default { $Hash[0..($Hash.Count-1)] } }
            $This.SetDisplayName()
            $This.Size     = $Tree.GetRecursiveSize()
        }
    }
    SetDisplayName()
    {
        ForEach ($Item in $This.Output)
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
    [String]         $Type
    [String]       $Source
    [String]     $Modified
    [String]         $Name
    [String]       $Shader
    [String]  $DisplayName
    [Object]         $Size
    [String]     $Fullname
    [UInt32] $IsReferenced
    [Object]      $Content
    [Object]       $Output
    Q3ALiveShaderFileItem([UInt32]$Index,[String]$Type,[Object]$Asset)
    {
        $This.Index         = $Index
        $This.Type          = $Type
        $This.Source        = $Asset.Source
        $This.Modified      = $Asset.Modified
        $This.Name          = $Asset.Name
        $This.Shader        = $Asset.Name -Replace ".shader",""
        $This.DisplayName   = $Asset.DisplayName
        $This.Size          = $Asset.Size
        $This.Fullname      = $Asset.Fullname
        $This.Refresh()
    }
    Refresh()
    {
        $This.Content       = @( )
        $xContent           = $Null
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
        $yContent           = $xContent -Replace "\t"," " -Replace "^\s+" | ? { $_.Length -gt 0 } | ? { $_ -notmatch "^\s*\/\/" }
        $Shaders            = $yContent | ? { $_ -match "^(textures|models)" }

        $Hash               = @{ }
        ForEach ($Line in $yContent)
        {
            If ($Line -in $Shaders)
            {
                $Hash.Add($Hash.Count,$This.Q3ALiveShaderItemFormat($Hash.Count,$Line))
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
   \\__//¯¯¯ Media [~]                                                                                      ___//¯¯\\   
    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
#>

Class Q3ALiveSoundFileItem
{
    [UInt32]      $Index
    [String]       $Type
    [Object]   $Modified
    [String]       $Name
    [String]   $Fullname
    [Object]       $Size
    [Object]   $Duration
    [Object]   $Position
    Q3ALiveSoundFileItem([UInt32]$Index)
    {

    }
}

Class Q3ALiveSoundFileList
{
    [Object] $Player
    [Object] $Output
    Q3ALiveSoundFileList()
    {
        $This.Player = $This.MediaPlayer()
        # $player.Open($Sound.Fullname)
         
        # $player.Play()
        # $player.Position = [TimeSpan]"00:00:00"
        # $Player.Stop()
    }
    [Object] MediaPlayer()
    {
        Return [System.Windows.Media.MediaPlayer]::New()
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
    [Object] $Module     # Fighting Entropy module (manages logging for console)
    [Object] $Xaml       # GUI I/O (Xaml controls)
    [Object] $Resource   # Resource (dependencies + main logging)
    [Object] $Registry   # Registry (generates and manages persistent keys + properties)
    [Object] $Dependency # Various tools (some required)
    [Object] $Component  # Quake III Arena/Quake Live (could possibly accommodate other games)
    [Object] $Radiant    # Specifically controls Radiant
    [Object] $Workspace  # Source assets (handles archive logging)
    [Object] $Assignment # Used to orchestrate tasks related to selection and management of compilation and assets
    [Object] $Compile    # All of the options for compiling a particular map or array of maps
    [Object] $Asset      # Manages and handles all of the map assets to publish a single map, or multiple
    [Object] $Steam      # Manages the interactions with steamcmd.exe to publish work to the Steam Workshop
    Hidden [Object] $Search
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

            # Dependency
            Zip        = $Ctrl.Registry.Dependency.Property | ? Name -eq 7Zip
            Magick     = $Ctrl.Registry.Dependency.Property | ? Name -eq ImageMagick

            # Component
            Q3A        = $Ctrl.Registry.Component.Property  | ? Name -eq Q3A
            Live       = $Ctrl.Registry.Component.Property  | ? Name -eq Live
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
        $Ctrl.Component.Refresh()
        $Ctrl.Radiant.Refresh()

        # Determine whether the registry settings are valid
        $Hash          = @{ 

            # Settings =========================================================
            Workspace  = $Ctrl.Registry.Settings.Property | ? Name -eq Workspace
            Credential = $Ctrl.Registry.Settings.Property | ? Name -eq Credential
            Workshop   = $Ctrl.Registry.Settings.Property | ? Name -eq Workshop

            # Dependency =====================================================
            Zip        = $Ctrl.Registry.Dependency.Property | ? Name -eq 7Zip
            Magick     = $Ctrl.Registry.Dependency.Property | ? Name -eq ImageMagick
            ASE        = $Ctrl.Registry.Dependency.Property | ? Name -eq Q3ASE
            Steam      = $Ctrl.Registry.Dependency.Property | ? Name -eq Steam

            # Component ====================================================
            Q3A        = $Ctrl.Registry.Component.Property  | ? Name -eq Q3A
            Live       = $Ctrl.Registry.Component.Property  | ? Name -eq Live

            # Radiant ==========================================================
            Gtk        = $Ctrl.Registry.Radiant.Property | ? Name -eq GtkRadiant
            Net        = $Ctrl.Registry.Radiant.Property | ? Name -eq NetRadiant
            Garux      = $Ctrl.Registry.Radiant.Property | ? Name -eq "NetRadiant-Custom"
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

                $Ctrl.Update(0,"Dependency [+] 7-Zip: [$Path]")
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

                $Ctrl.Update(0,"Dependency [+] ImageMagick: [$Path]")
            }
        }

        # Q3ASE
        If ($Hash.ASE.Valid)
        {
            $Path = $Hash.ASE.Value

            $Ctrl.Dependency.Assign("Q3ASE",$Path,"q3ase.exe")

            $Ctrl.Update(0,"Dependency [+] Q3ASE: [$Path]")
        }

        # Steam
        If ($Hash.Steam.Valid)
        {
            $Path = $Hash.Steam.Value

            $Ctrl.Dependency.Assign("Steam",$Path,"steamcmd.exe")

            $Ctrl.Update(0,"Dependency [+] Steam: [$Path]")
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

                $Ctrl.Update(0,"Component [+] Quake III Arena: [$($Hash.Q3A.Value)]")
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

                $Ctrl.Update(0,"Component [+] Quake Live: [$($Hash.Live.Value)]")
            }
        }

        # [Radiant]
        # GtkRadiant
        If ($Hash.Gtk.Valid)
        {
            $Path = $Hash.Gtk.Value

            $Ctrl.Dependency.Assign("GtkRadiant",$Path,"radiant.exe")

            $Ctrl.Radiant.Assign("GtkRadiant",$Path)

            $Ctrl.Update(0,"Radiant [+] GtkRadiant: [$Path]")
        }

        # NetRadiant
        If ($Hash.Net.Valid)
        {
            $Path = $Hash.Net.Value

            $Ctrl.Dependency.Assign("NetRadiant",$Path,"netradiant.exe")

            $Ctrl.Radiant.Assign("NetRadiant",$Path)

            $Ctrl.Update(0,"Radiant [+] GtkRadiant: [$Path]")
        }

        # NetRadiant-Custom
        If ($Hash.Garux.Valid)
        {
            $Path = $Hash.Garux.Value

            $Ctrl.Dependency.Assign("NetRadiant-Custom",$Path,"radiant.exe")

            $Ctrl.Radiant.Assign("NetRadiant-Custom",$Path)

            $Ctrl.Update(0,"Radiant [+] GtkRadiant: [$Path]")
        }

        # [Settings]
        # Workspace
        If ($Hash.Workspace.Valid -and $Ctrl.Workspace.Fullname -ne $Hash.Workspace.Value)
        {
            $Path = $Hash.Workspace.Value

            $Ctrl.Update(0,"Workspace [~] Loading: [$Path]")

            $Ctrl.Workspace.Assign($Path)

            $Ctrl.Update(0,"Workspace [+] <Loaded>")
        }

        # Credential
        # Workshop

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
                
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigSettings,   $Ctrl.Registry.Settings.Property)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigDependency, $Ctrl.Registry.Dependency.Property)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigComponent,  $Ctrl.Registry.Component.Property)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigRadiant,    $Ctrl.Registry.Radiant.Property)

                # Components
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentOutput,  $Ctrl.Component.Output)
                $Ctrl.Reset($Ctrl.Xaml.IO.RadiantOutput,    $Ctrl.Radiant.Output)
                $Ctrl.Reset($Ctrl.Xaml.IO.DependencyOutput, $Ctrl.Dependency.Output)

                # Workspace
                If ([System.IO.Directory]::Exists($Ctrl.Workspace.Fullname))
                {
                    $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceProperty,$Ctrl.Workspace)

                    # Log
                    $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceLogProperty,$Ctrl.Workspace.Log)
                    $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceLogOutput,$Ctrl.Workspace.Log.Output)

                    # Output
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

                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigSettings,       $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigDependency,     $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigComponent,      $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ConfigRadiant,        $Null)

                # Component
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentOutput,      $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBase,        $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseOutput,  $Null)

                $Ctrl.Reset($Ctrl.Xaml.IO.DependencyOutput,     $Null)

                # Workspace
                $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceProperty,    $Null)

                # Log
                $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceLogProperty, $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.WorkspaceLogOutput,   $Null)

                # Output
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
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.ComponentOutput.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.ComponentOutput.SelectedItem

            $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBase,$Item.Base)

            $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseOutput,$Null)
            $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseItemOutput,$Null)
        }
    }
    ComponentBase()
    {
        $Ctrl = $This
        If ($Ctrl.Xaml.IO.ComponentBase.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.ComponentBase.SelectedItem

            $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseOutput,$Item.Output)
            $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseItemOutput,$Null)
        }
    }
    ComponentBaseOutput()
    {
        $Ctrl  = $This

        If ($Ctrl.Xaml.IO.ComponentBaseOutput.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.ComponentBaseOutput.SelectedItem
            
            $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseItemOutput,$Item.Output)
        }
    }
    ComponentBaseOutputPopulate()
    {
        $Ctrl  = $This

        If ($Ctrl.Xaml.IO.ComponentBaseOutput.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.ComponentBaseOutput.SelectedItem

            If (!$Item.Opened)
            {
                $Item.Refresh()
                
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseItemOutput,$Item.Output)
            }
        }
    }
    ComponentSelect()
    {
        $Ctrl  = $This
        $Index = $Ctrl.Xaml.IO.ComponentOutput.SelectedIndex

        If ($Index -ne -1)
        {
            $Ctrl.Component.SetSelected($Index)

            $Ctrl.Reset($Ctrl.Xaml.IO.ComponentOutput,$Ctrl.Component.Output)

            $Current            = $Ctrl.Component.Current()

            $Ctrl.Registry.Game = $Current.Name

            Set-ItemProperty -Path $Ctrl.Registry.Fullname -Name Game -Value $Current.Name -Verbose
        }
    }
    RadiantOutput()
    {
        $Ctrl = $This

        If ($Ctrl.Xaml.IO.RadiantOutput.SelectedIndex -ne -1)
        {
            $Item = $Ctrl.Xaml.IO.RadiantOutput.SelectedItem
            
            $Ctrl.Reset($Ctrl.Xaml.IO.RadiantProperty,$Ctrl.RadiantFilter($Item))
            $Ctrl.Reset($Ctrl.Xaml.IO.RadiantItemOutput,$Item.Output)
        }
    }
    RadiantSelect()
    {
        $Ctrl  = $This
        $Index = $Ctrl.Xaml.IO.RadiantOutput.SelectedIndex
        
        If ($Index -ne -1)
        {
            $Ctrl.Radiant.SetSelected($Index)
            
            $Ctrl.Reset($Ctrl.Xaml.IO.RadiantOutput,$Ctrl.Radiant.Output)

            $Current = $Ctrl.Radiant.Current()

            $Ctrl.Registry.Editor = $Current.Name

            Set-ItemProperty -Path $Ctrl.Registry.Fullname -Name Editor -Value $Current.Name -Verbose

            $Ctrl.Xaml.IO.RadiantLaunch.IsEnabled          = 1
            $Ctrl.Xaml.IO.RadiantLaunchParamText.IsEnabled = 1
            $Ctrl.Xaml.IO.RadiantLaunchParamIcon.IsEnabled = 1
            $Ctrl.Xaml.IO.RadiantBrowse.IsEnabled          = 1
            $Ctrl.Xaml.IO.RadiantClose.IsEnabled           = 0

            $Ctrl.Xaml.IO.RadiantLaunchParamText.Text      = "<not set>"
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
        # If ($Ctrl.Xaml.IO.WorkspaceOutput.SelectedIndex -eq -1 -and $Ctrl.)
        # {
        #    $Ctrl.Xaml.IO.WorkspaceOutputPathText.Text = "<not set>"
        # }
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

                $Ctrl.Xaml.IO.ComponentBase.Add_SelectionChanged(
                {
                    $Ctrl.ComponentBase()
                })

                $Ctrl.Xaml.IO.ComponentBaseOutput.Add_SelectionChanged(
                {
                    $Ctrl.ComponentBaseOutput()
                })

                $Ctrl.Xaml.IO.ComponentBaseOutput.Add_MouseDoubleClick(
                {
                    $Ctrl.ComponentBaseOutputPopulate()
                })
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
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentOutput,      $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBase,        $Null)
                $Ctrl.Reset($Ctrl.Xaml.IO.ComponentBaseOutput,  $Null)
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

        # Initial settings
        $Ctrl.Initial("Config")
        $Ctrl.Initial("Dependency")
        $Ctrl.Initial("Component")
        $Ctrl.Initial("Radiant")
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
    ScrollToTop([Object]$xSender)
    {
        If ($xSender.Items.Count -gt 0)
        {
            $First = $xSender.Items[0]
            $xSender.ScrollIntoView($First)
        }
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
$Ctrl.Reload()
