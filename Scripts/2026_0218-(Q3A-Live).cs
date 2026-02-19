//    ____    ____________________________________________________________________________________________________        
//   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
//   \\__//¯¯¯ Assemblies [~]                                                                                 ___//¯¯\\   
//    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
//        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    

using System;
using System.Data;
using System.IO;
using System.IO.Compression;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Linq;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using System.Runtime.InteropServices;
using System.Text.RegularExpressions;
using System.Security.Cryptography;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Threading;
using System.Windows.Media.Imaging;
using System.Windows.Media;
using System.Windows.Controls;

namespace Q3ALive
{
    //    ____    ____________________________________________________________________________________________________        
    //   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
    //   \\__//¯¯¯ Enums [~]                                                                                      ___//¯¯\\   
    //    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
    //        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    

    public enum ResourceInstallType
    {
        dependencies = 0,
        gfx          = 1,
        logs         = 2
    }

    public enum RegistryInstallType
    {
        DisplayName     = 0,
        DisplayIcon     = 1,
        Publisher       = 2,
        DisplayVersion  = 3,
        InstallLocation = 4,
        RegistryPath    = 5,
        UninstallString = 6
    }

    public enum RegistryBaseType
    {
        Resource    = 0,
        Name        = 1,
        DisplayName = 2,
        Version     = 3,
        Fullname    = 4,
        InstallDate = 5,
        Editor      = 6
    }

    public enum RegistryReferenceType
    {
        Settings   = 0,
        Dependency = 1,
        Component  = 2,
        Radiant    = 3,
    }

    public enum DefaultShadersType
    {
        base_button   =  0,
        base_door     =  1,
        base_floor    =  2,
        base_light    =  3,
        base_object   =  4,
        base_support  =  5,
        base_trim     =  6,
        base_wall     =  7,
        common        =  8,
        ctf           =  9,
        gothic_block  = 10,
        gothic_button = 11,
        gothic_door   = 12,
        gothic_floor  = 13,
        gothic_light  = 14,
        gothic_trim   = 15,
        gothic_wall   = 16,
        liquids       = 17,
        models        = 18,
        organics      = 19,
        sfx           = 20,
        skin          = 21,
        skies         = 22
    }

    public enum ComponentType
    {
        Q3A  = 0,
        Live = 1,
        Q4   = 2,
        Q2   = 3
    }

    public enum AssetType
    {
        levelshots = 0,
        maps       = 1,
        models     = 2,
        music      = 3,
        scripts    = 4,
        sound      = 5,
        textures   = 6
    }

    public enum Q1AssetType
    {
        configs = 0,
        gfx     = 1,
        maps    = 2,
        progs   = 3,
        sound   = 4,
    }

    public enum Q2AssetType
    {
        demos     = 0,
        env       = 1,
        maps      = 2,
        models    = 3,
        music     = 4,
        pics      = 5,
        sound     = 6,
        sprites   = 7,
        textures  = 8
    }

    public enum Q3AssetType
    {
        botfiles   =  0,
        demos      =  1,
        docs       =  2,
        env        =  3,
        gfx        =  4,
        icons      =  5,
        levelshots =  6,
        maps       =  7,
        menu       =  8,
        models     =  9,
        music      = 10,
        player     = 11,
        scripts    = 12,
        sound      = 13,
        sprites    = 14,
        textures   = 15,
        video      = 16,
        vm         = 17,
    }

    public enum QLAssetType
    {
        botfiles   =  0,
        demos      =  1,
        env        =  2,
        fonts      =  3,
        gfx        =  4,
        icons      =  5,
        levelshots =  6,
        maps       =  7,
        menu       =  8,
        models     =  9,
        music      = 10,
        scripts    = 11,
        sound      = 12,
        sprites    = 13,
        textures   = 14,
        ui         = 15
    }

    public enum Q4AssetType
    {
        af        = 0,
        cfg       = 1,
        def       = 2,
        docs      = 3,
        effects   = 4,
        efxs      = 5,
        fonts     = 6,
        gfx       = 7,
        glprogs   = 8,
        guides    = 9,
        guis      = 10,
        lipsync   = 11,
        maps      = 12,
        materials = 13,
        models    = 14,
        playbacks = 15,
        progimg   = 16,
        scripts   = 17,
        skins     = 18,
        sound     = 19,
        strings   = 20,
        textures  = 21,
        video     = 22
    }

    //    ____    ____________________________________________________________________________________________________        
    //   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
    //   \\__//¯¯¯ General [~]                                                                                    ___//¯¯\\   
    //    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
    //        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    

    public class ByteSize
    {
        public string     Name { get; set; }
        public long      Bytes { get; set; }
        public string     Unit { get; private set; }
        public string     Size { get; private set; }
        public ByteSize(string name, long bytes)
        {
            this.Name  = name;
            this.Bytes = bytes;
            GetUnit();
            GetSize();
        }
        private void GetUnit()
        {
            if (Bytes < 870)
            {
                Unit = "Byte";
            }
            else if (Bytes >= 870 && Bytes < 891289)
            { 
                Unit = "Kilobyte";
            }
            else if (Bytes >= 891289 && Bytes < 912680550)
            { 
                Unit = "Megabyte";
            }
            else if (Bytes >= 912680550 && Bytes < 934584883609)
            {
                Unit = "Gigabyte";
            }
            else
            {
                Unit = "Terabyte";
            }
        }
        private void GetSize()
        {
            switch (Unit) 
            {
                case "Byte":
                    Size = string.Format("{0}  B", Bytes);
                    break;
                case "Kilobyte":
                    Size = string.Format("{0:n2} KB", (Bytes / 1024.0));
                    break;
                case "Megabyte":
                    Size = string.Format("{0:n2} MB", (Bytes / 1048576.0));
                    break;
                case "Gigabyte":
                    Size = string.Format("{0:n2} GB", (Bytes / 1073741824.0));
                    break;
                case "Terabyte":
                    Size = string.Format("{0:n2} TB", (Bytes / 1099511627776.0));
                    break;
            }
        }
        public override string ToString()
        {
            return Size;
        }
        public static ByteSize New(string name, long bytes)
        {
            return new ByteSize(name, bytes);
        }
    }
    
    public struct FormattedDateTime
    {
        public DateTime Value;
        public FormattedDateTime(DateTime dt)
        {
            this.Value = dt;
        }
        public static implicit operator DateTime(FormattedDateTime fdt)
        {
            return fdt.Value;
        }
        public static implicit operator FormattedDateTime(DateTime dt)
        {
            return new FormattedDateTime(dt);
        }
        public override string ToString()
        {
            return this.Value.ToString("MM/dd/yyyy HH:mm:ss");
        }
    }

    public interface IAssetTypeRules
    {
        object Match(string path);
    }

    public class FolderPrefixAssetRules<TEnum> : IAssetTypeRules
    {
        private Dictionary<string, TEnum> map;
        public FolderPrefixAssetRules(Dictionary<string, TEnum> map)
        {
            this.map = map;
        }
        public object Match(string path)
        {
            if (string.IsNullOrEmpty(path))
                return null;

            string[] parts = path.Replace('\\', '/').Split('/');
            if (parts.Length == 0)
                return null;

            string top = parts[0].ToLowerInvariant();

            foreach (KeyValuePair<string, TEnum> kv in this.map)
            {
                if (top == kv.Key)
                    return kv.Value;
            }

            return null;
        }
    }

    public static class AssetClassifier
    {
        private static Dictionary<string, IAssetTypeRules> rules =
            new Dictionary<string, IAssetTypeRules>();
        static AssetClassifier()
        {
            // Q1
            rules["Q1"] = new FolderPrefixAssetRules<Q1AssetType>(
                new Dictionary<string, Q1AssetType>() {
                    { "configs", Q1AssetType.configs },
                    { "gfx",     Q1AssetType.gfx     },
                    { "maps",    Q1AssetType.maps    },
                    { "progs",   Q1AssetType.progs   },
                    { "sound",   Q1AssetType.sound   }
                }
            );

            // Q2
            rules["Q2"] = new FolderPrefixAssetRules<Q2AssetType>(
                new Dictionary<string, Q2AssetType>() {
                    { "demos",    Q2AssetType.demos    },
                    { "env",      Q2AssetType.env      },
                    { "maps",     Q2AssetType.maps     },
                    { "models",   Q2AssetType.models   },
                    { "music",    Q2AssetType.music    },
                    { "pics",     Q2AssetType.pics     },
                    { "sound",    Q2AssetType.sound    },
                    { "sprites",  Q2AssetType.sprites  },
                    { "textures", Q2AssetType.textures }
                }
            );

            // Q3
            rules["Q3A"] = new FolderPrefixAssetRules<Q3AssetType>(
                new Dictionary<string, Q3AssetType>() {
                    { "botfiles",   Q3AssetType.botfiles   },
                    { "demos",      Q3AssetType.demos      },
                    { "docs",       Q3AssetType.docs       },
                    { "env",        Q3AssetType.env        },
                    { "gfx",        Q3AssetType.gfx        },
                    { "icons",      Q3AssetType.icons      },
                    { "levelshots", Q3AssetType.levelshots },
                    { "maps",       Q3AssetType.maps       },
                    { "menu",       Q3AssetType.menu       },
                    { "models",     Q3AssetType.models     },
                    { "music",      Q3AssetType.music      },
                    { "player",     Q3AssetType.player     },
                    { "scripts",    Q3AssetType.scripts    },
                    { "sound",      Q3AssetType.sound      },
                    { "sprites",    Q3AssetType.sprites    },
                    { "textures",   Q3AssetType.textures   },
                    { "video",      Q3AssetType.video      },
                    { "vm",         Q3AssetType.vm         }
                }
            );

            // QL
            rules["Live"] = new FolderPrefixAssetRules<QLAssetType>(
                new Dictionary<string, QLAssetType>() {
                    { "botfiles",   QLAssetType.botfiles   },
                    { "demos",      QLAssetType.demos      },
                    { "env",        QLAssetType.env        },
                    { "fonts",      QLAssetType.fonts      },
                    { "gfx",        QLAssetType.gfx        },
                    { "icons",      QLAssetType.icons      },
                    { "levelshots", QLAssetType.levelshots },
                    { "maps",       QLAssetType.maps       },
                    { "menu",       QLAssetType.menu       },
                    { "models",     QLAssetType.models     },
                    { "music",      QLAssetType.music      },
                    { "scripts",    QLAssetType.scripts    },
                    { "sound",      QLAssetType.sound      },
                    { "sprites",    QLAssetType.sprites    },
                    { "textures",   QLAssetType.textures   },
                    { "ui",         QLAssetType.ui         }
                }
            );

            // Q4
            rules["Q4"] = new FolderPrefixAssetRules<Q4AssetType>(
                new Dictionary<string, Q4AssetType>() {
                    { "af",        Q4AssetType.af        },
                    { "cfg",       Q4AssetType.cfg       },
                    { "def",       Q4AssetType.def       },
                    { "docs",      Q4AssetType.docs      },
                    { "effects",   Q4AssetType.effects   },
                    { "efxs",      Q4AssetType.efxs      },
                    { "fonts",     Q4AssetType.fonts     },
                    { "gfx",       Q4AssetType.gfx       },
                    { "glprogs",   Q4AssetType.glprogs   },
                    { "guides",    Q4AssetType.guides    },
                    { "guis",      Q4AssetType.guis      },
                    { "lipsync",   Q4AssetType.lipsync   },
                    { "maps",      Q4AssetType.maps      },
                    { "materials", Q4AssetType.materials },
                    { "models",    Q4AssetType.models    },
                    { "playbacks", Q4AssetType.playbacks },
                    { "progimg",   Q4AssetType.progimg   },
                    { "scripts",   Q4AssetType.scripts   },
                    { "skins",     Q4AssetType.skins     },
                    { "sound",     Q4AssetType.sound     },
                    { "strings",   Q4AssetType.strings   },
                    { "textures",  Q4AssetType.textures  },
                    { "video",     Q4AssetType.video     }
                }
            );
        }
        public static object Resolve(string game, string path)
        {
            IAssetTypeRules r;
            if (!rules.TryGetValue(game, out r))
                return null;

            return r.Match(path);
        }
    }

    //    ____    ____________________________________________________________________________________________________        
    //   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
    //   \\__//¯¯¯ Filesystem [~]                                                                                 ___//¯¯\\   
    //    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
    //        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    

    // Extended version of a (file/folder) object with additional properties
    public class FileSystemObject
    {
        public uint                  Index { get; set; }
        public string                 Type { get; set; }
        public string                Label { get; set; }
        [System.Management.Automation.Hidden]
        public FormattedDateTime?  Created { get; set; }
        public FormattedDateTime? Modified { get; set; }
        public string                 Name { get; set; }
        public ByteSize               Size { get; set; }
        public string            Extension { get; set; }
        public string          DisplayName { get; set; }
        public string            Reference { get; set; }
        public string             Fullname { get; set; }
        public uint                 Exists { get; set; } 
        public byte[]                Bytes { get; set; }
        public FileSystemObject(FileSystemInfo fsi)
        {
            this.Type      = (fsi is DirectoryInfo) ? "Directory" : "File";
            this.Created   = fsi.CreationTime;
            this.Modified  = fsi.LastWriteTime;
            this.Name      = fsi.Name;
            this.Fullname  = fsi.FullName;

            long xbytes    = 0;
            string ext     = "";
            FileInfo fi    = fsi as FileInfo; 
            if (fi != null)
            {
                xbytes     = fi.Length;
                ext        = fi.Extension.TrimStart('.');
            }
            this.Size      = new ByteSize(this.Type, (long)xbytes);
            this.Extension = ext;
            this.Exists    = 1;
        }
        public void Clear()
        {
            this.Bytes     = null;
        }
        public void ReadAllBytes()
        {
            this.Clear();
            this.Bytes     = File.ReadAllBytes(this.Fullname);
        }
    }

    // Specifically for the (FileSystem + DirectoryScan) objects
    public static class FileSystemScanMode
    {
        public const uint     DirsOnly  = 0;
        public const uint    FilesOnly  = 1;
        public const uint DirsAndFiles  = 2;
    }

    // Scans a specified directory for above criteria, with options for recursion and filtering
    public static class FileSystemScanner
    {
        public static IEnumerable<FileSystemObject> Enumerate(string fullname)
        {
            return Enumerate(fullname, FileSystemScanMode.DirsAndFiles, false);
        }       
        public static IEnumerable<FileSystemObject> Enumerate(string fullname, uint mode)
        {
            return Enumerate(fullname, FileSystemScanMode.DirsAndFiles, false);
        }       
        public static IEnumerable<FileSystemObject> Enumerate(string fullname, uint mode, bool recurse)
        {
            var raw = EnumerateInternal(fullname, mode, recurse);

            List<FileSystemObject> sorted = new List<FileSystemObject>(raw);

            sorted.Sort(new Comparison<FileSystemObject>(CompareByFullname));

            uint index = 0;
            foreach (var item in sorted)
            {
                item.Index = index++;
                yield return item;
            }
        }
        private static int CompareByFullname(FileSystemObject a, FileSystemObject b)
        {
            return string.Compare(a.Fullname, b.Fullname, StringComparison.OrdinalIgnoreCase);
        }
        private static IEnumerable<FileSystemObject> EnumerateInternal(string root, uint mode, bool recurse)
        {
            var dirs = new Stack<string>();
            dirs.Push(root);

            bool includeDirs  = mode == FileSystemScanMode.DirsOnly || mode == FileSystemScanMode.DirsAndFiles;
            bool includeFiles = mode == FileSystemScanMode.FilesOnly || mode == FileSystemScanMode.DirsAndFiles;

            while (dirs.Count > 0)
            {
                string current = dirs.Pop();

                DirectoryInfo di = null;
                try
                { 
                    di = new DirectoryInfo(current);
                } 
                catch
                {
                    
                }

                string[] subdirs = null;
                try
                {
                    subdirs = Directory.GetDirectories(current);
                }
                catch
                {
                    
                }

                if (subdirs != null)
                {
                    foreach (string dir in subdirs)
                    {
                        if (recurse)
                            dirs.Push(dir);

                        if (includeDirs)
                        {
                            DirectoryInfo subdirInfo = null;
                            try
                            {
                                subdirInfo = new DirectoryInfo(dir);
                            }
                            catch
                            {
                                
                            }

                            if (subdirInfo != null)
                                yield return new FileSystemObject(subdirInfo);
                        }
                    }
                }

                if (includeFiles)
                {
                    string[] files = null;
                    try
                    { 
                        files = Directory.GetFiles(current);
                    }
                    catch
                    {
                        
                    }

                    if (files != null)
                    {
                        foreach (string file in files)
                        {
                            FileInfo fi = null;
                            try
                            { 
                                fi = new FileInfo(file);
                            } 
                            catch
                            {
                                
                            }

                            if (fi != null)
                                yield return new FileSystemObject(fi);
                        }
                    }
                }
            }
        }
    }

    // Provides a clean C# based version of PowerShell's Get-ChildItem with extended abilities
    public class DirectoryScan
    {
        public uint                    Index { get; set; }
        public string                   Type { get; set; }
        public string                  Label { get; set; }
        [System.Management.Automation.Hidden]
        public FormattedDateTime?    Created { get; set; }
        public FormattedDateTime?   Modified { get; set; }
        public string                   Name { get; set; }
        public uint                   Exists { get; set; }
        public ByteSize                 Size { get; set; }
        public string               Fullname { get; private set; }
        public List<FileSystemObject> Output { get; private set; }
        private uint                    Mode { get; set; }
        private bool                 Recurse { get; set; }
        public string                 Filter { get; private set; }
        public DirectoryScan(string fullname) : this(fullname, 2, false)
        {
            
        }
        public DirectoryScan(string fullname, uint mode) : this(fullname, mode, false)
        {
            
        }
        public DirectoryScan(string fullname, uint mode, bool recurse, string pattern) : this(fullname, mode, recurse)
        {
            this.SetFilter(pattern);
            this.Refresh();
        }
        public DirectoryScan(string fullname, uint mode, bool recurse)
        {
            this.Index    = 0;
            this.Type     = "";
            this.Label    = "";
            this.Fullname = fullname;
            this.Name     = System.IO.Path.GetFileName(fullname);

            this.SetMode(mode);
            this.SetRecurse(recurse);
            
            this.Refresh();
        }
        public void SetType(string type)
        {
            this.Type = type;
        }
        public void SetLabel(string label)
        {
            this.Label = label;
        }
        public void SetRecurse(bool recurse)
        {
            this.Recurse = recurse;
        }
        public void SetMode(uint mode)
        {
            this.Mode = mode;
        }
        public void SetFilter(string pattern)
        {
            this.Filter = pattern;
        }
        public void Check()
        {
            DirectoryInfo di = new DirectoryInfo(this.Fullname);

            this.Exists = di.Exists ? 1u : 0u;

            if (this.Exists == 1u)
            {
                this.Created  = di.CreationTime;
                this.Modified = di.LastWriteTime;
            }
            else
            {
                this.Created  = null;
                this.Modified = null;   
            }
        }
        public void Refresh()
        {
            this.Check();

            if (this.Exists == 0u)
            {
                this.Output = null;
                this.Size   = null;
            }
            if (this.Exists == 1u)
            {
                IEnumerable<FileSystemObject> raw = FileSystemScanner.Enumerate(this.Fullname, this.Mode, this.Recurse);

                this.Output = new List<FileSystemObject>(raw);

                if (!string.IsNullOrEmpty(this.Filter))
                {
                    try
                    {
                        Regex rx = new Regex(this.Filter,RegexOptions.IgnoreCase);

                        List<FileSystemObject> filtered = new List<FileSystemObject>();

                        foreach (FileSystemObject item in this.Output)
                        {
                            if (rx.IsMatch(item.Name))
                                filtered.Add(item);
                        }

                        this.Output = filtered;
                    }
                    catch
                    {
                        // Invalid regex → ignore filter
                    }
                }

                uint index = 0;
                foreach (FileSystemObject item in this.Output)
                    item.Index = index++;

                long totalBytes = 0;

                foreach (FileSystemObject item in this.Output)
                {
                    if (item.Type == "File")
                        totalBytes += item.Size.Bytes;
                }

                this.Size = new ByteSize("Directory", totalBytes);
            }
        }
        public ByteSize GetRecursiveSize()
        {
            try
            {
                System.Type fsoType = System.Type.GetTypeFromProgID("Scripting.FileSystemObject");
                dynamic fso         = System.Activator.CreateInstance(fsoType);

                dynamic folder      = fso.GetFolder(this.Fullname);
                long bytes          = Convert.ToInt64(folder.Size);

                return new ByteSize("Directory", bytes);
            }
            catch
            {
                return new ByteSize("Directory", 0);
            }
        }
        public DirectoryScan SortBy(string property)
        {
            this.Output.Sort(new Comparison<FileSystemObject>(
                delegate(FileSystemObject a, FileSystemObject b)
                {
                    object va = GetPropertyValue(a, property);
                    object vb = GetPropertyValue(b, property);
                    return string.Compare(
                        va == null ? "" : va.ToString(),
                        vb == null ? "" : vb.ToString(),
                        StringComparison.OrdinalIgnoreCase
                    );
                }
            ));

            uint index = 0;
            foreach (FileSystemObject item in this.Output)
                item.Index = index++;

            return this;
        }
        private object GetPropertyValue(FileSystemObject obj, string property)
        {
            var prop = obj.GetType().GetProperty(property);
            if (prop != null)
                return prop.GetValue(obj, null);
            return null;
        }
    }

    //    ____    ____________________________________________________________________________________________________        
    //   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
    //   \\__//¯¯¯ Packages [~]                                                                                   ___//¯¯\\   
    //    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
    //        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    

    // Specifically extends [ZipArchiveEntry] to mirror [Q3ALive.FileSystemObject]
    public class PackageFileEntry : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        public uint                  Index { get; set; }
        public string               Source { get; set; }
        public string        ArchiveString { get; set; }
        public string                 Type { get; set; }
        public string                Label { get; set; }
        public FormattedDateTime? Modified { get; set; }
        public string                 Name { get; set; }
        public string            Extension { get; set; }
        public string          DisplayName { get; set; }
        public string             Fullname { get; set; }
        public ByteSize               Size { get; set; }
        public uint                 Exists { get; set; }
        public byte[]                Bytes { get; private set; }
        public int               AssetType { get; set; }
        internal uint               Offset; // PAK only
        internal uint               Length; // PAK only
        internal PackageFileItem    Parent;
        private bool _selected;
        public bool Selected
        {
            get { return _selected; }
            set
            {
                if (_selected != value)
                {
                    _selected = value;
                    OnPropertyChanged("Selected");
                }
            }
        }
        public PackageFileEntry(uint index, string source, ZipArchiveEntry entry, PackageFileItem parent)
        {
            Parent        = parent;
            Index         = index;
            Source        = source;
            ArchiveString = entry.FullName;

            if (entry.Length == 0 && entry.FullName.EndsWith("/"))
            {
                Type      = "Directory";
                Name      = GetName(entry.FullName);
                Fullname  = entry.FullName.TrimEnd('/');
                Extension = null;
            }
            else
            {
                Type      = "File";
                Name      = entry.Name;
                Fullname  = entry.FullName;
                Extension = GetExtension(entry.Name);
            }

            Modified      = new FormattedDateTime(entry.LastWriteTime.DateTime);
            Size          = new ByteSize("Entry", entry.Length);
            DisplayName   = "\\" + Fullname.Replace("/", "\\");
            Label         = ComputeLabel(Fullname);
            Exists        = 1;

            this.Classify();
        }
        public PackageFileEntry(uint index, string source, string fullname, uint offset, uint length, PackageFileItem parent)
        {
            Parent        = parent;
            Index         = index;
            Source        = source;
            Type          = "File";
            Name          = GetName(fullname);
            Fullname      = fullname;
            Offset        = offset;
            Length        = length;

            Extension     = GetExtension(Name);
            Modified      = new FormattedDateTime(new FileInfo(parent.Fullname).CreationTime);
            Size          = new ByteSize("Entry", length);
            DisplayName   = "\\" + Fullname.Replace("/", "\\");
            Label         = ComputeLabel(Fullname);
            Exists        = 1;

            this.Classify();
        }
        private string GetName(string fullname)
        {
            fullname      = fullname.TrimEnd('/', '\\');
            int idx       = fullname.LastIndexOfAny(new char[] { '/', '\\' });
            if (idx >= 0)
            {
                return fullname.Substring(idx + 1);
            }
            return fullname;
        }
        private string GetExtension(string name)
        {
            int idx = name.LastIndexOf('.');
            if (idx >= 0 && idx < name.Length - 1)
            {
                return name.Substring(idx + 1);
            }
            return "";
        }
        private string ComputeLabel(string fullname)
        {
            string trimmed = fullname.TrimStart('/', '\\');
            string[] parts = trimmed.Split(new char[] { '/', '\\' });

            if (parts.Length == 0)
            {
                return "Other";
            }

            string lead = parts[0].ToLowerInvariant();

            switch (lead)
            {
                case "maps"       : return "Map";
                case "models"     : return "Model";
                case "sound"      : return "Sound";
                case "textures"   : return "Texture";
                case "music"      : return "Music";
                case "sprites"    : return "Sprite";
                case "pics"       : return "Pic";
                case "env"        : return "Env";
                case "demos"      : return "Demo";
                case "levelshots" : return "Levelshot";
                case "gfx"        : return "Graphics";
                case "menu"       : return "Menu";
                default: return "Other";
            }
        }
        private void Classify()
        {
            if (this.Parent == null)
                return;

            // Parent.Type is the game name ("Q3A", "Live", "Q4", "Q2", "Q1")
            string game = this.Parent.Type;
            string path = this.ArchiveString;

            object result = AssetClassifier.Resolve(game, path);

            if (result != null)
            {
                this.Label = result.ToString();
                this.AssetType = Convert.ToInt32(result);
            }
            else
            {
                // fallback to your existing ComputeLabel
                this.Label = ComputeLabel(path);
                this.AssetType = -1;
            }
        }
        public void ReadAllBytes()
        {
            // If parent archive is not open, open it temporarily
            bool openedHere = false;
            if (!Parent.IsOpen)
            {
                Parent.Open();
                openedHere = true;
            }

            try
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    if (Parent.IsPak)
                    {
                        // PAK extraction into memory
                        Parent.FileStream.Seek(Offset, SeekOrigin.Begin);

                        byte[] buffer = new byte[8192];
                        uint remaining = Length;

                        while (remaining > 0)
                        {
                            int read = Parent.FileStream.Read(buffer, 0, (int)Math.Min(buffer.Length, remaining));
                            if (read == 0)
                                break;

                            ms.Write(buffer, 0, read);
                            remaining -= (uint)read;
                        }
                    }
                    else
                    {
                        // ZIP extraction into memory
                        ZipArchiveEntry zipEntry = Parent.ZipArchive.GetEntry(Fullname);
                        if (zipEntry != null)
                        {
                            using (Stream s = zipEntry.Open())
                            {
                                s.CopyTo(ms);
                            }
                        }
                    }

                    Bytes = ms.ToArray();
                }
            }
            finally
            {
                if (openedHere)
                    Parent.Close();
            }
        }
        public void Extract(string targetDirectory, bool overwrite)
        {
            string outPath = Path.Combine(targetDirectory, Fullname.Replace('/', '\\'));
            string dir = Path.GetDirectoryName(outPath);

            if (!Directory.Exists(dir))
            {
                Directory.CreateDirectory(dir);
            }

            if (!overwrite && File.Exists(outPath))
            {
                return;
            }

            bool openedHere = false;

            if (!Parent.IsOpen)
            {
                Parent.Open();
                openedHere  = true;
            }

            try
            {
                if (Parent.IsPak)
                {
                    ExtractFromOpenPak(outPath);
                }
                else
                {
                    ExtractFromOpenZip(outPath);
                }
            }
            finally
            {
                if (openedHere)
                {
                    Parent.Close();
                }
            }
        }
        internal void ExtractFromOpenZip(string outPath)
        {
            ZipArchive zip = Parent.ZipArchive;
            if (zip == null)
            {
                return;
            }

            ZipArchiveEntry zipEntry = zip.GetEntry(Fullname);
            if (zipEntry == null)
            {
                return;
            }

            using (Stream inStream = zipEntry.Open())
            using (FileStream outStream = File.Create(outPath))
            {
                inStream.CopyTo(outStream);
            }
        }
        internal void ExtractFromOpenPak(string outPath)
        {
            FileStream fs = Parent.FileStream;
            if (fs == null)
            {
                return;
            }

            fs.Seek(Offset, SeekOrigin.Begin);

            using (FileStream outStream = File.Create(outPath))
            {
                byte[]  buffer = new byte[8192];
                uint remaining = Length;

                while (remaining > 0)
                {
                    int read   = fs.Read(buffer, 0, (int)Math.Min(buffer.Length, remaining));
                    if (read == 0)
                        break;

                    outStream.Write(buffer, 0, read);
                    remaining -= (uint)read;
                }
            }
        }
        protected void OnPropertyChanged(string name)
        {
            PropertyChangedEventHandler handler = PropertyChanged;
            if (handler != null)
            {
                handler(this, new PropertyChangedEventArgs(name));
            }
        }
        public override string ToString()
        {
            return Fullname;
        }
    }

    // Specifically extends [ZipArchive]
    public class PackageFileItem : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        public uint                  Index { get; set; }
        public string                 Type { get; set; }
        public FormattedDateTime? Modified { get; set; }
        public string                 Name { get; set; }
        public string            Extension { get; set; }
        public string             Fullname { get; set; }
        public ByteSize               Size { get; set; }
        public uint                 Exists { get; set; }
        private bool _opened;
        private bool _loaded;
        public bool Loaded
        {
            get { return _loaded; }
            private set
            {
                if (_loaded != value)
                {
                    _loaded = value;
                    OnPropertyChanged("Loaded");
                }
            }
        }
        public ObservableCollection<PackageFileEntry> Entry { get; set; }
        internal FileStream FileStream { get; private set; }
        internal ZipArchive ZipArchive { get; private set; }
        internal bool IsOpen { get { return _opened; } }
        internal bool IsPak { get { return Extension.Equals("pak", StringComparison.OrdinalIgnoreCase); } }
        private bool ForceOverwrite;
        public PackageFileItem(uint index, string type, FileSystemObject file)
        {
            Index     = index;
            Type      = type;
            Name      = file.Name;
            Extension = file.Extension.TrimStart('.').ToLowerInvariant();
            Fullname  = file.Fullname;
            Modified  = file.Modified.HasValue ? new FormattedDateTime(file.Modified.Value) : (FormattedDateTime?)null;
            Size      = file.Size;
            Entry     = new ObservableCollection<PackageFileEntry>();

            Check();
        }
        public void Clear()
        {
            Entry.Clear();
            Loaded = false;
        }
        public void Check()
        {
            Exists = (uint)(File.Exists(Fullname) ? 1 : 0);

            if (Exists == 1)
            {
                FileInfo fi = new FileInfo(Fullname);
                Modified    = new FormattedDateTime(fi.LastWriteTime);
                Size        = new ByteSize("Archive", fi.Length);
            }
        }
        internal void Open()
        {
            if (_opened)
                return;

            Check();
            if (Exists == 0)
                throw new FileNotFoundException("Archive not found.", Fullname);

            FileStream = File.Open(Fullname, FileMode.Open, FileAccess.Read, FileShare.Read);

            if (!IsPak)
                ZipArchive = new ZipArchive(FileStream, ZipArchiveMode.Read, true);

            _opened = true;
        }
        internal void Close()
        {
            if (!_opened)
                return;

            if (ZipArchive != null)
            {
                ZipArchive.Dispose();
                ZipArchive = null;
            }

            if (FileStream != null)
            {
                FileStream.Dispose();
                FileStream = null;
            }

            _opened = false;
        }
        public void Remove()
        {
            Check();

            if (Exists == 1)
            {
                Close();
                File.Delete(Fullname);
                Check();
                Clear();
            }
        }
        public void Refresh()
        {
            if (Loaded)
                return;

            Clear();
            Check();

            if (Exists == 0)
                return;

            Open();

            try
            {
                if (IsPak)
                    LoadPakEntries();
                else
                    LoadZipEntries();

                Loaded = true;
            }
            finally
            {
                Rerank();
                Close();
            }
        }
        public void Rerank()
        {
            List<PackageFileEntry> list = new List<PackageFileEntry>(Entry);

            list.Sort(delegate(PackageFileEntry a, PackageFileEntry b)
            {
                string da = (a == null || a.DisplayName == null) ? "" : a.DisplayName;
                string db = (b == null || b.DisplayName == null) ? "" : b.DisplayName;
                return string.Compare(da, db, StringComparison.OrdinalIgnoreCase);
            });
            Entry.Clear();

            uint index = 0;
            foreach (PackageFileEntry item in list)
            {
                item.Index = index++;
                Entry.Add(item);
            }
        }
        private void LoadZipEntries()
        {
            if (ZipArchive == null)
                throw new InvalidOperationException("ZIP archive is not open.");

            int count = ZipArchive.Entries.Count;
            List<PackageFileEntry> list = new List<PackageFileEntry>(count);

            for (int i = 0; i < count; i++)
            {
                ZipArchiveEntry entry = ZipArchive.Entries[i];
                PackageFileEntry item = new PackageFileEntry((uint)i, Fullname, entry, this);
                list.Add(item);
            }

            list.Sort(delegate(PackageFileEntry a, PackageFileEntry b)
            {
                string da = (a == null || a.DisplayName == null) ? "" : a.DisplayName;
                string db = (b == null || b.DisplayName == null) ? "" : b.DisplayName;
                return string.Compare(da, db, StringComparison.OrdinalIgnoreCase);
            });

            for (int i = 0; i < list.Count; i++)
            {
                list[i].Index = (uint)i;
                Entry.Add(list[i]);
            }
        }
        private void LoadPakEntries()
        {
            if (FileStream == null)
                throw new InvalidOperationException("PAK file stream is not open.");

            using (BinaryReader reader = new BinaryReader(FileStream, System.Text.Encoding.ASCII, true))
            {
                FileStream.Seek(0, SeekOrigin.Begin);
                string magic = new string(reader.ReadChars(4));
                if (!magic.Equals("PACK"))
                    throw new InvalidDataException("Invalid PAK file: " + Fullname);

                int dirOffset = reader.ReadInt32();
                int dirLength = reader.ReadInt32();

                FileStream.Seek(dirOffset, SeekOrigin.Begin);

                int entryCount = dirLength / 64;
                List<PackageFileEntry> list = new List<PackageFileEntry>(entryCount);

                for (int i = 0; i < entryCount; i++)
                {
                    byte[] nameBytes = reader.ReadBytes(56);
                    string  fullname = System.Text.Encoding.ASCII.GetString(nameBytes).TrimEnd('\0');
                    uint      offset = reader.ReadUInt32();
                    uint      length = reader.ReadUInt32();

                    PackageFileEntry item = new PackageFileEntry((uint)i, Fullname, fullname, offset, length, this);
                    list.Add(item);
                }

                list.Sort(delegate(PackageFileEntry a, PackageFileEntry b)
                {
                    string da = (a == null || a.Fullname == null) ? "" : a.Fullname;
                    string db = (b == null || b.Fullname == null) ? "" : b.Fullname;
                    return string.Compare(da, db, StringComparison.OrdinalIgnoreCase);
                });

                for (int i = 0; i < list.Count; i++)
                {
                    list[i].Index = (uint)i;
                    Entry.Add(list[i]);
                }
            }
        }
        public void ExtractSelected(string targetDirectory)
        {
            List<PackageFileEntry> selected = new List<PackageFileEntry>();
            foreach (PackageFileEntry e in Entry)
            {
                if (e.Selected)
                    selected.Add(e);
            }

            if (selected.Count == 0)
                return;

            List<string> conflicts = DetectConflicts(selected, targetDirectory);

            if (conflicts.Count > 0 && !ForceOverwrite)
            {
                bool userConfirmed = ShowConflictDialog(conflicts);
                if (!userConfirmed)
                    return;

                ForceOverwrite = true;
            }

            if (selected.Count == 1)
            {
                selected[0].Extract(targetDirectory, ForceOverwrite);
            }
            else
            {
                ExtractSelectedBatch(selected, targetDirectory, ForceOverwrite);
            }

            ForceOverwrite = false;
        }
        private List<string> DetectConflicts(List<PackageFileEntry> entries, string targetDirectory)
        {
            List<string> conflicts = new List<string>();

            foreach (PackageFileEntry entry in entries)
            {
                string outPath = Path.Combine(targetDirectory, entry.Fullname.Replace('/', '\\'));
                if (File.Exists(outPath))
                    conflicts.Add(outPath);
            }

            return conflicts;
        }
        private bool ShowConflictDialog(List<string> conflicts)
        {
            // Placeholder: always allow overwrite.
            // Replace with your WPF dialog logic.
            return true;
        }
        private void ExtractSelectedBatch(List<PackageFileEntry> entries, string targetDirectory, bool overwrite)
        {
            Open();

            try
            {
                foreach (PackageFileEntry entry in entries)
                {
                    string outPath = Path.Combine(targetDirectory, entry.Fullname.Replace('/', '\\'));
                    string dir     = Path.GetDirectoryName(outPath);

                    if (!Directory.Exists(dir))
                        Directory.CreateDirectory(dir);

                    if (!overwrite && File.Exists(outPath))
                        continue;

                    if (IsPak)
                        entry.ExtractFromOpenPak(outPath);
                    else
                        entry.ExtractFromOpenZip(outPath);
                }
            }
            finally
            {
                Close();
            }
        }
        protected void OnPropertyChanged(string name)
        {
            PropertyChangedEventHandler handler = PropertyChanged;
            if (handler != null)
                handler(this, new PropertyChangedEventArgs(name));
        }
        public override string ToString()
        {
            return Fullname;
        }
    }

    //    ____    ____________________________________________________________________________________________________        
    //   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
    //   \\__//¯¯¯ Component [~]                                                                                  ___//¯¯\\   
    //    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
    //        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
    
    public class ComponentBase : INotifyPropertyChanged
    {
        public uint                 Index { get; set; }
        public string                Type { get; set; }
        public FormattedDateTime? Modified { get; set; }
        public string                Name { get; set; }
        public string            Fullname { get; set; }
        public uint                Exists { get; set; }
        private bool            _selected;
        public bool              Selected
        {
            get { return _selected; }
            set
            {
                if (_selected != value)
                {
                    _selected = value;
                    OnPropertyChanged("Selected");
                }
            }
        }
        public ByteSize              Size { get; set; }
        public bool               Default { get; set; }
        private bool              _opened;
        public bool                Opened
        {
            get { return _opened; }
            set
            {
                if (_opened != value)
                {
                    _opened = value;
                    OnPropertyChanged("Opened");
                }
            }
        }
        public ObservableCollection<PackageFileItem> Package { get; set; }
        public ComponentItem       Parent { get; set; }
        public event PropertyChangedEventHandler PropertyChanged;
        protected void OnPropertyChanged(string name)
        {
            var h = PropertyChanged;
            if (h != null) h(this, new PropertyChangedEventArgs(name));
        }
        public ComponentBase(uint index, string type)
        {
            this.Index    = index;
            this.Type     = type;
            this.Fullname = "<not set>";
            this.Package  = new ObservableCollection<PackageFileItem>();
        }
        public ComponentBase(uint index, string type, string fullname)
        {
            this.Index    = index;
            this.Type     = type;
            this.Package  = new ObservableCollection<PackageFileItem>();
            this.Assign(fullname);
        }
        public void Assign(string fullname)
        {
            this.Fullname = fullname;
            this.Name     = Path.GetFileName(fullname);
            this.Refresh();
            this.Default  = (this.Index == 0);
        }
        public void Clear()
        {
            this.Package.Clear();
            this.Opened = false;
        }
        public void Check()
        {
            this.Exists = Directory.Exists(this.Fullname) ? 1u : 0u;
        }
        public void Refresh()
        {
            this.Clear();
            this.Check();

            if (this.Exists == 0)
                return;

            DirectoryScan tree = this.Q3ALiveDirectoryScan();
            if (tree == null)
                return;

            string filter = this.ExtensionFilter();
            this.Package.Clear();

            if (tree.Output != null)
            {
                foreach (FileSystemObject fso in tree.Output)
                {
                    if (fso.Extension.Equals(filter, StringComparison.OrdinalIgnoreCase))
                    {
                        var pfi = new PackageFileItem((uint)this.Package.Count, filter, fso);
                        this.Package.Add(pfi);
                    }
                }
            }

            this.Modified = tree.Modified;
            this.Size     = tree.Size;
            this.Opened   = true;
        }
        public string ExtensionFilter()
        {
            if (string.Equals(this.Type,  "Q3A", StringComparison.OrdinalIgnoreCase)) return "pk3";
            if (string.Equals(this.Type, "Live", StringComparison.OrdinalIgnoreCase)) return "pk3";
            if (string.Equals(this.Type,   "Q4",  StringComparison.OrdinalIgnoreCase)) return "pk4";
            if (string.Equals(this.Type,   "Q2",  StringComparison.OrdinalIgnoreCase)) return "pak";
            if (string.Equals(this.Type,   "Q1",  StringComparison.OrdinalIgnoreCase)) return "pak";
            return null;
        }
        public DirectoryScan Q3ALiveDirectoryScan()
        {
            return new DirectoryScan(this.Fullname, 2u, true);
        }
        public override string ToString()
        {
            return base.ToString();
        }
    }

    public class ComponentExecutable
    {
        public FormattedDateTime?  Modified { get; set; }
        public string                  Name { get; set; }
        public string              Fullname { get; set; }
        public ByteSize                Size { get; set; }
        public bool                  Exists { get; set; }
        public string                  Hash { get; set; }
        public ComponentExecutable(string name)
        {
            this.Name = name;
            this.Clear();
        }
        public void Assign(string gamePath)
        {
            if (String.IsNullOrEmpty(gamePath))
            {
                this.Clear();
                return;
            }

            string combined = Path.Combine(gamePath,this.Name);

            if (!File.Exists(combined))
            {
                this.Clear();
                return;
            }

            FileInfo info = new FileInfo(combined);

            this.Modified = new FormattedDateTime(info.LastWriteTime);
            this.Fullname = info.FullName;
            this.Size     = new ByteSize("Executable", info.Length);
            this.Exists   = true;
            this.Hash     = ComputeSHA256(info.FullName);
        }
        public void Clear()
        {
            this.Modified = null;
            this.Fullname = "<not set>";
            this.Size     = new ByteSize("Executable", 0);
            this.Exists   = false;
            this.Hash     = null;
        }
        private string ComputeSHA256(string path)
        {
            using (SHA256 sha = SHA256.Create())
            using (FileStream fs = File.OpenRead(path))
            {
                byte[] hash = sha.ComputeHash(fs);
                return BitConverter.ToString(hash).Replace("-", "");
            }
        }
        public override string ToString()
        {
            if (this.Fullname == "<not set>" || this.Fullname == null)
            {
                return this.Name;
            }
            else
            {
                return this.Fullname;
            }
        }
    }

    public class ComponentItem : INotifyPropertyChanged
    {
        public uint                        Index { get; set; }
        public FormattedDateTime?       Modified { get; set; } 
        public string                       Name { get; set; }
        public string                   Fullname { get; set; }
        public ByteSize                     Size { get; set; } 
        public bool                       Exists { get; set; } 
        public bool                    Installed { get; set; }
        private bool                   _selected;
        public bool                     Selected
        {
            get { return _selected; }
            set
            {
                if (_selected != value)
                {
                    _selected = value;
                    OnPropertyChanged("Selected");
                }
            }
        }
        public ObservableCollection<ComponentBase> Base { get; set; }
        public ComponentExecutable           Executable { get; set; }
        public event PropertyChangedEventHandler PropertyChanged;
        protected void OnPropertyChanged(string name)
        {
            var h = PropertyChanged;
            if (h != null) h(this, new PropertyChangedEventArgs(name));
        }
        public ComponentItem(uint index, string name, string executableName)
        {
            this.Index      = index;
            this.Name       = name;
            this.Fullname   = "<not set>";
            this.Base       = new ObservableCollection<ComponentBase>();
            this.Executable = new ComponentExecutable(executableName);
            this.Installed  = false;
            this.Selected   = false;
        }
        public void Assign(string fullname)
        {
            if (String.IsNullOrEmpty(fullname) || !Directory.Exists(fullname))
            {
                this.Clear();
                return;
            }

            DirectoryInfo info = new DirectoryInfo(fullname);

            this.Fullname = info.FullName;
            this.Exists   = true;
            this.Modified = new FormattedDateTime(info.LastWriteTime);
            this.Size     = new ByteSize("Directory",this.GetRecursiveSize(info.FullName));

            this.GameSignature();
        }
        public void Clear()
        {
            this.Fullname  = "<not set>";
            this.Exists    = false;
            this.Modified  = null;
            this.Size      = new ByteSize("Directory", 0);

            this.Base.Clear();
            this.Installed = false;

            if (this.Executable != null)
                this.Executable.Clear();
        }
        public void GameSignature()
        {
            string basePattern = null;

            if (this.Name.Equals("Q3A", StringComparison.OrdinalIgnoreCase)) basePattern = "{0}\\baseq3";
            else if (this.Name.Equals("Live", StringComparison.OrdinalIgnoreCase)) basePattern = "{0}\\baseq3";
            else if (this.Name.Equals("Q4",  StringComparison.OrdinalIgnoreCase)) basePattern = "{0}\\q4base";
            else if (this.Name.Equals("Q2",  StringComparison.OrdinalIgnoreCase)) basePattern = "{0}\\baseq2";
            else if (this.Name.Equals("Q1",  StringComparison.OrdinalIgnoreCase)) basePattern = "{0}\\id1";

            string basePath = basePattern != null ? String.Format(basePattern, this.Fullname) : null;

            this.Base.Clear();
            this.AddBase(0u, basePath);

            this.Executable.Assign(this.Fullname);

            if (this.Executable.Exists)
                this.Installed = true;
        }
        public void AddBase(uint index, string fullname)
        {
            ComponentBase cb = new ComponentBase(index, this.Name, fullname);
            cb.Parent = this;
            this.Base.Add(cb);
            this.Rerank();
        }
        private long GetRecursiveSize(string path)
        {
            try
            {
                Type fsoType = System.Type.GetTypeFromProgID("Scripting.FileSystemObject");
                object fso   = Activator.CreateInstance(fsoType);

                object folder = fsoType.InvokeMember(
                    "GetFolder",
                    System.Reflection.BindingFlags.InvokeMethod,
                    null,
                    fso,
                    new object[] { path }
                );

                Type folderType = folder.GetType();
                object sizeObj  = folderType.InvokeMember(
                    "Size",
                    System.Reflection.BindingFlags.GetProperty,
                    null,
                    folder,
                    null
                );

                return Convert.ToInt64(sizeObj);
            }
            catch
            {
                return 0;
            }
        }
        public void Rerank()
        {
            uint i = 0;
            foreach (ComponentBase cb in this.Base)
                cb.Index = i++;
        }
        public override string ToString()
        {
            return base.ToString();
        }
    }

    public class ComponentList
    {
        public ObservableCollection<ComponentItem> Output { get; set; }
        public ComponentList()
        {
            this.Stage();
        }
        public void Clear()
        { 
            if (this.Output == null) 
                this.Output = new ObservableCollection<ComponentItem>(); 
            else 
                this.Output.Clear(); 
        }
        public void Stage()
        {
            this.Clear();

            foreach (string name in this.ComponentType())
                this.Add(name);
        }
        private void RefreshItem(ComponentItem item)
        {
            if (item != null && item.Base != null && item.Base.Count > 0)
            {
                foreach (ComponentBase b in item.Base)
                {
                    if (b.Package != null && b.Package.Count > 0)
                    {
                        foreach (PackageFileItem pkg in b.Package)
                            pkg.Refresh();
                    }
                }
            }
        }
        public void Refresh(string name)
        {
            ComponentItem item = this.FindByName(name);
            this.RefreshItem(item);
        }
        public void Refresh()
        {
            foreach (ComponentItem item in this.Output)
                this.RefreshItem(item);
        }
        public void Assign(string name, string fullname)
        {
            ComponentItem item = this.FindByName(name);

            if (item != null)
            {
                if (Directory.Exists(fullname))
                    item.Assign(fullname);
            }
        }
        public string DefaultExecutable(string name)
        {
            string select = "";

            if (name.Equals("Q3A", StringComparison.OrdinalIgnoreCase)) select = "3";
            else if (name.Equals("Live", StringComparison.OrdinalIgnoreCase)) select = "live_steam";
            else if (name.Equals("Q4",  StringComparison.OrdinalIgnoreCase)) select = "4";
            else if (name.Equals("Q2",  StringComparison.OrdinalIgnoreCase)) select = "2";
            else if (name.Equals("Q1",  StringComparison.OrdinalIgnoreCase)) select = "";

            return String.Format("quake{0}.exe", select);
        }
        public void Add(string name)
        {
            if (!this.IsComponentType(name))
                return;

            if (this.FindByName(name) != null)
                return;

            string exe = this.DefaultExecutable(name);

            ComponentItem item = this.Q3ALiveComponentItem(
                (uint)this.Output.Count,
                name,
                exe
            );

            this.Output.Add(item);
        }
        public void Remove(string name)
        {
            if (!this.IsComponentType(name))
                return;

            ComponentItem item = this.FindByName(name);

            if (item != null)
                item.Clear();
        }
        public void SetSelected(uint index)
        {
            foreach (ComponentItem item in this.Output)
                item.Selected = (item.Index == index);
        }
        public ComponentItem Current()
        {
            foreach (ComponentItem item in this.Output)
            {
                if (item.Selected)
                    return item;
            }

            return null;
        }
        public string[] ComponentType()
        {
            return Enum.GetNames(typeof(ComponentType));
        }
        private bool IsComponentType(string name)
        {
            foreach (string s in this.ComponentType())
            {
                if (s.Equals(name, StringComparison.OrdinalIgnoreCase))
                    return true;
            }
            return false;
        }
        private ComponentItem FindByName(string name)
        {
            foreach (ComponentItem item in this.Output)
            {
                if (item.Name.Equals(name, StringComparison.OrdinalIgnoreCase))
                    return item;
            }
            return null;
        }
        public ComponentItem Q3ALiveComponentItem(uint index, string name, string executable)
        {
            return new ComponentItem(index, name, executable);
        }

        public override string ToString()
        {
            return "<Q3ALive.Component.List>";
        }
    }

    //    ____    ____________________________________________________________________________________________________        
    //   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
    //   \\__//¯¯¯ Graphics [~]                                                                                   ___//¯¯\\   
    //    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
    //        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    

    // Provides a template for (*.tga) metadata 
    public class TgaInfo
    {
        public int        Width;
        public int       Height;
        public int BitsPerPixel;
        public int    ImageType;
    }

    // Loads (*.tga) files and converts into a bitmap (needs work) -> expand TGA+DDS capabilities
    // Exception calling "GetBitmap" with "0" argument(s): "Only uncompressed TGA (type 2) is supported." 
    public static class TgaLoader
    {
        public static TgaInfo ReadHeader(string path)
        {
            using (var fs = File.OpenRead(path))
            using (var br = new BinaryReader(fs))
            {
                br.ReadByte();
                br.ReadByte();
                int imageType = br.ReadByte();

                br.ReadBytes(5);
                br.ReadBytes(4);

                int width         = br.ReadInt16();
                int height        = br.ReadInt16();
                int bpp           = br.ReadByte();

                br.ReadByte();

                TgaInfo info      = new TgaInfo();
                info.Width        = width;
                info.Height       = height;
                info.BitsPerPixel = bpp;
                info.ImageType    = imageType;

                return info;
            }
        }
        public static TgaInfo ReadHeaderFromBytes(byte[] bytes)
        {
            using (var ms = new MemoryStream(bytes))
            using (var br = new BinaryReader(ms))
            {
                br.ReadByte();
                br.ReadByte();
                int imageType = br.ReadByte();

                br.ReadBytes(5);
                br.ReadBytes(4);

                int width         = br.ReadInt16();
                int height        = br.ReadInt16();
                int bpp           = br.ReadByte();

                br.ReadByte();

                TgaInfo info      = new TgaInfo();
                info.Width        = width;
                info.Height       = height;
                info.BitsPerPixel = bpp;
                info.ImageType    = imageType;

                return info;
            }
        }
        public static BitmapSource Load(string path)
        {
            using (var fs = File.OpenRead(path))
            using (var br = new BinaryReader(fs))
            {
                return LoadInternal(br);
            }
        }
        public static BitmapSource LoadFromBytes(byte[] bytes)
        {
            using (var ms = new MemoryStream(bytes))
            using (var br = new BinaryReader(ms))
            {
                return LoadInternal(br);
            }
        }
        private static BitmapSource LoadInternal(BinaryReader br)
        {
            int idLength      = br.ReadByte();
            br.ReadByte();
            int imageType     = br.ReadByte();

            br.ReadBytes(5);
            br.ReadBytes(4);

            int width         = br.ReadInt16();
            int height        = br.ReadInt16();
            int bpp           = br.ReadByte();
            br.ReadByte();

            if (idLength > 0)
            {
                br.ReadBytes(idLength);
            }

            if (imageType != 2)
            {
                throw new Exception("Only uncompressed TGA (type 2) is supported.");
            }

            int bytesPerPixel = bpp / 8;
            int imageSize     = width * height * bytesPerPixel;

            byte[] data       = br.ReadBytes(imageSize);

            // TGA stores pixels in BGR(A) order, bottom-up | WPF expects BGRA, top-down

            int stride        = width * 4;
            byte[] output     = new byte[height * stride];

            int srcIndex      = 0;

            for (int y = height - 1; y >= 0; y--)
            {
                int row       = y * stride;

                for (int x = 0; x < width; x++)
                {
                    byte b    = data[srcIndex++];
                    byte g    = data[srcIndex++];
                    byte r    = data[srcIndex++];

                    byte a    = 255;
                    if (bytesPerPixel == 4)
                    {
                        a = data[srcIndex++];
                    }

                    int dst   = row + (x * 4);
                    output[dst + 0] = b;
                    output[dst + 1] = g;
                    output[dst + 2] = r;
                    output[dst + 3] = a;
                }
            }

            return BitmapSource.Create(width, height, 96, 96, PixelFormats.Bgra32, null, output, stride);
        }
    }

    // Container object for (FileSystemObject/PackageFileEntry) -> to view as an [image]
    public class ImageObject
    {
        public uint                  Index { get; private set; }
        public string                 Type { get; private set; }
        public string                Label { get; private set; }
        public FormattedDateTime? Modified { get; private set; }
        public string                 Name { get; private set; }
        public string            Extension { get; private set; }
        public string          DisplayName { get; private set; }
        public string             Fullname { get; private set; }
        public ByteSize               Size { get; private set; }
        public byte[]                Bytes { get; private set; }
        public int                   Width { get; private set; }
        public int                  Height { get; private set; }
        public int            BitsPerPixel { get; private set; }
        private FileSystemObject     _file;
        private PackageFileEntry    _entry;
        public ImageObject(FileSystemObject file)
        {
            _file = file;

            Index       = file.Index;
            Type        = file.Type;
            Label       = file.Label;
            Modified    = file.Modified;
            Name        = file.Name;
            Extension   = file.Extension;
            DisplayName = file.DisplayName;
            Fullname    = file.Fullname;
            Size        = file.Size;
        }
        public ImageObject(PackageFileEntry entry)
        {
            _entry = entry;

            Index       = entry.Index;
            Type        = entry.Type;
            Label       = entry.Label;
            Modified    = entry.Modified;
            Name        = entry.Name;
            Extension   = entry.Extension;
            DisplayName = entry.DisplayName;
            Fullname    = entry.Fullname;
            Size        = entry.Size;
        }
        private void EnsureBytes()
        {
            if (Bytes != null)
            {
                return;
            }

            if (_file != null)
            {
                Bytes = File.ReadAllBytes(_file.Fullname);
                return;
            }

            if (_entry != null)
            {
                _entry.ReadAllBytes();
                Bytes = _entry.Bytes;
                return;
            }
        }
        public void LoadMetadata()
        {
            EnsureBytes();

            if (Bytes == null || Bytes.Length == 0)
            {
                return;
            }

            string ext = (Extension ?? "").ToLower();

            if (ext == "tga")
            {
                TgaInfo info = TgaLoader.ReadHeaderFromBytes(Bytes);
                Width        = info.Width;
                Height       = info.Height;
                BitsPerPixel = info.BitsPerPixel;
                return;
            }

            using (MemoryStream ms = new MemoryStream(Bytes))
            {
                BitmapDecoder decoder = BitmapDecoder.Create(
                    ms,
                    BitmapCreateOptions.PreservePixelFormat,
                    BitmapCacheOption.OnLoad
                );

                BitmapFrame frame = decoder.Frames[0];
                Width             = frame.PixelWidth;
                Height            = frame.PixelHeight;
                BitsPerPixel      = frame.Format.BitsPerPixel;
            }
        }
        public BitmapSource GetBitmap()
        {
            EnsureBytes();

            if (Bytes == null || Bytes.Length == 0)
            {
                return null;
            }

            string ext       = (Extension ?? "").ToLower();

            if (ext == "tga")
            {
                var bmp      = TgaLoader.LoadFromBytes(Bytes);
                Width        = bmp.PixelWidth;
                Height       = bmp.PixelHeight;
                BitsPerPixel = bmp.Format.BitsPerPixel;

                return bmp;
            }

            using (MemoryStream ms = new MemoryStream(Bytes))
            {
                BitmapImage bmp = new BitmapImage();
                bmp.BeginInit();
                bmp.CacheOption  = BitmapCacheOption.OnLoad;
                bmp.StreamSource = ms;
                bmp.EndInit();
                bmp.Freeze();

                Width        = bmp.PixelWidth;
                Height       = bmp.PixelHeight;
                BitsPerPixel = bmp.Format.BitsPerPixel;

                return bmp;
            }
        }
    }

    //    ____    ____________________________________________________________________________________________________        
    //   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
    //   \\__//¯¯¯ Audio [~]                                                                                      ___//¯¯\\   
    //    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
    //        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    

    // Decodes a (*.wav) file
    public class WavDecoder
    {
        public int       SampleRate { get; private set; }
        public int         Channels { get; private set; }
        public int    BitsPerSample { get; private set; }
        public float[]      Samples { get; private set; }
        public TimeSpan    Duration { get; private set; }
        public byte[]         Pcm16 { get; private set; }
        public WavDecoder(byte[] data)
        {
            using (var ms = new MemoryStream(data))
            {
                Parse(ms);
            }
        }
        private void Parse(Stream stream)
        {
            using (var br = new BinaryReader(stream))
            {
                string riff = new string(br.ReadChars(4));
                if (riff != "RIFF")
                {
                    throw new InvalidDataException("Not a RIFF file.");
                }

                br.ReadInt32();

                string wave = new string(br.ReadChars(4));
                if (wave != "WAVE")
                {
                    throw new InvalidDataException("Not a WAVE file.");
                }

                while (br.BaseStream.Position < br.BaseStream.Length)
                {
                    string chunkId = new string(br.ReadChars(4));
                    int chunkSize  = br.ReadInt32();

                    if (chunkId == "fmt ")
                    {
                        short audioFormat = br.ReadInt16();
                        Channels = br.ReadInt16();
                        SampleRate = br.ReadInt32();
                        br.ReadInt32();
                        br.ReadInt16();
                        BitsPerSample = br.ReadInt16();

                        if (audioFormat != 1)
                        {
                            throw new NotSupportedException("Only PCM WAV files are supported.");
                        }

                        if (chunkSize > 16)
                        {
                            br.ReadBytes(chunkSize - 16);
                        }
                    }
                    else if (chunkId == "data")
                    {
                        byte[] pcm = br.ReadBytes(chunkSize);
                        Pcm16      = pcm;
                        Samples    = ConvertPcmToFloat(pcm, BitsPerSample, Channels);
                        Duration   = TimeSpan.FromSeconds((double)Samples.Length / Channels / SampleRate);
                    }
                    else
                    {
                        // Skip unknown chunks
                        br.ReadBytes(chunkSize);
                    }
                }
            }
        }
        private float[] ConvertPcmToFloat(byte[] pcm, int bits, int channels)
        {
            int sampleCount = pcm.Length / (bits / 8);
            float[] samples = new float[sampleCount];

            if (bits == 16)
            {
                for (int i = 0; i < sampleCount; i++)
                {
                    short s = BitConverter.ToInt16(pcm, i * 2);
                    samples[i] = s / 32768f;
                }
            }
            else if (bits == 8)
            {
                for (int i = 0; i < sampleCount; i++)
                {
                    samples[i] = (pcm[i] - 128) / 128f;
                }
            }
            else
            {
                throw new NotSupportedException("Only 8-bit and 16-bit PCM supported.");
            }

            return samples;
        }
    }

    // Container object for (FileSystemObject/PackageFileEntry) -> to hear as a [sound]
    public class AudioObject
    {
        public uint                  Index { get; private set; }
        public string               Source { get; private set; }
        public string                 Type { get; private set; }
        public string                Label { get; private set; }
        public FormattedDateTime? Modified { get; private set; }
        public string                 Name { get; private set; }
        public string            Extension { get; private set; }
        public string          DisplayName { get; private set; }
        public string             Fullname { get; private set; }
        public ByteSize               Size { get; private set; }
        public uint                 Exists { get; private set; }
        public byte[]                Bytes { get; private set; }
        public int              SampleRate { get; private set; }
        public int                Channels { get; private set; }
        public int           BitsPerSample { get; private set; }
        public float[]             Samples { get; private set; }
        public TimeSpan           Duration { get; private set; }
        public byte[]                  Pcm { get; private set; }
        private FileSystemObject     _file;
        private PackageFileEntry    _entry;
        public AudioObject(FileSystemObject file)
        {
            _file = file;

            Index       = file.Index;
            Source      = null;
            Type        = file.Type;
            Label       = file.Label;
            Modified    = file.Modified;
            Name        = file.Name;
            Extension   = file.Extension;
            DisplayName = file.DisplayName;
            Fullname    = file.Fullname;
            Size        = file.Size;
            Exists      = file.Exists;

            LoadBytes();
            LoadAudioMetadata();
        }
        public AudioObject(PackageFileEntry entry)
        {
            _entry = entry;

            Index       = entry.Index;
            Source      = entry.Source;
            Type        = entry.Type;
            Label       = entry.Label;
            Modified    = entry.Modified;
            Name        = entry.Name;
            Extension   = entry.Extension;
            DisplayName = entry.DisplayName;
            Fullname    = entry.Fullname;
            Size        = entry.Size;
            Exists      = entry.Exists;

            LoadBytes();
            LoadAudioMetadata();
        }
        private void LoadBytes()
        {
            if (_file != null)
            {
                Bytes = File.ReadAllBytes(_file.Fullname);
            }
            else if (_entry != null)
            {
                _entry.ReadAllBytes();
                Bytes = _entry.Bytes;
            }
        }
        private void LoadAudioMetadata()
        {
            if (Bytes == null || Bytes.Length == 0)
                return;

            // Only WAV for now
            if (Extension.ToLower() == "wav")
            {
                var decoder = new WavDecoder(Bytes);
                SampleRate    = decoder.SampleRate;
                Channels      = decoder.Channels;
                BitsPerSample = decoder.BitsPerSample;
                Samples       = decoder.Samples;
                Duration      = decoder.Duration;
                Pcm           = decoder.Pcm16;
            }
        }
    }
    
    //    ____    ____________________________________________________________________________________________________        
    //   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
    //   \\__//¯¯¯ Audio Player [~]                                                                               ___//¯¯\\   
    //    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
    //        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    

    // Class factory for audio
    public class AudioPlayer
    {
        private byte[]                       _pcm;
        private int                   _sampleRate;
        private int                     _channels;
        private float[]                 _floatPcm;
        private int             _deviceSampleRate;
        private int               _deviceChannels;
        private int          _deviceBytesPerFrame;

        private IAudioClient         _audioClient;
        private IAudioRenderClient  _renderClient;

        private uint            _bufferFrameCount;
        private int                _bytesPerFrame;

        private bool                     _playing;
        private bool               _stopRequested;

        private bool               _seekRequested = false;
        private double      _seekRequestedSeconds = 0;

        private Thread               _audioThread;
        private AutoResetEvent         _workEvent = new AutoResetEvent(false);

        private readonly Queue<Action> _workQueue = new Queue<Action>();
        private readonly object         _workLock = new object();
        private Runspace              _uiRunspace;

        public TimeSpan                  Duration { get; private set; }
        public TimeSpan                  Position { get; private set; }

        [System.Management.Automation.Hidden]
        public bool                       Verbose;

        public event EventHandler<double> PositionChanged;
        public AudioPlayer()
        {
            this.SetVerbose(false);   // DEFAULT = FALSE

            WriteStatus("[AudioPlayer.ctor] Thread=" + Thread.CurrentThread.ManagedThreadId);

            _uiRunspace  = Runspace.DefaultRunspace;

            _audioThread = new Thread(AudioThreadStart);
            _audioThread.IsBackground = true;
            _audioThread.SetApartmentState(ApartmentState.MTA);
            _audioThread.Start();
        }
        private void WriteStatus(string message)
        {
            if (this.Verbose)
            {
                Console.WriteLine(message);
            }
        }
        public void SetVerbose(bool verbose)
        {
            this.Verbose = verbose;
        }
        public void ToggleVerbose()
        {
            this.Verbose = !this.Verbose;
        }
        private void AudioThreadStart()
        {
            WriteStatus("[AudioThreadStart] BEGIN Thread=" + Thread.CurrentThread.ManagedThreadId);

            try
            {
                int hr = CoInitializeEx(IntPtr.Zero, COINIT_MULTITHREADED);
                WriteStatus("[AudioThreadStart] CoInitializeEx HR=" + hr);

                while (true)
                {
                    _workEvent.WaitOne();
                    WriteStatus("[AudioThreadStart] Work event signaled");

                    while (true)
                    {
                        Action work = null;

                        lock (_workLock)
                        {
                            if (_workQueue.Count > 0)
                            {
                                work = _workQueue.Dequeue();
                                WriteStatus("[AudioThreadStart] Dequeued work item");
                            }
                        }

                        if (work == null)
                        {
                            WriteStatus("[AudioThreadStart] No more work");
                            break;
                        }

                        try
                        {
                            work();
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine("[AudioThreadStart] Work exception: " + ex.Message);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("[AudioThreadStart] FATAL: " + ex.Message);
            }
        }
        private void Post(Action action)
        {
            WriteStatus("[Post] Enqueue work Thread=" + Thread.CurrentThread.ManagedThreadId);

            lock (_workLock)
            {
                _workQueue.Enqueue(action);
            }

            _workEvent.Set();
        }
        public void Load(byte[] pcm16, int sampleRate, int channels)
        {
            WriteStatus("[Load] Thread=" + Thread.CurrentThread.ManagedThreadId);

            _pcm        = pcm16;
            _sampleRate = sampleRate;
            _channels   = channels;

            _bytesPerFrame = channels * 2;
            Duration       = TimeSpan.FromSeconds((double)pcm16.Length / _bytesPerFrame / sampleRate);
            Position       = TimeSpan.Zero;

            WriteStatus("[Load] PCM length=" + pcm16.Length);
            WriteStatus("[Load] Duration=" + Duration);

            Post(new Action(InitializeAudioClient));
        }
        public void Load(AudioObject current)
        {
            WriteStatus("[Load] Thread=" + Thread.CurrentThread.ManagedThreadId);

            _pcm        = current.Pcm;        // <-- correct property name
            _sampleRate = current.SampleRate; // <-- correct property name
            _channels   = current.Channels;   // <-- correct property name

            _bytesPerFrame = _channels * 2;

            Duration = TimeSpan.FromSeconds(
                (double)_pcm.Length / _bytesPerFrame / _sampleRate
            );

            Position = TimeSpan.Zero;

            WriteStatus("[Load] PCM length=" + _pcm.Length);
            WriteStatus("[Load] Duration=" + Duration);

            Post(new Action(InitializeAudioClient));
        }
        private float[] ConvertPcm16ToFloat(byte[] pcm16)
        {
            int samples    = pcm16.Length / 2;
            float[] result = new float[samples];

            for (int i = 0; i < samples; i++)
            {
                short s   = BitConverter.ToInt16(pcm16, i * 2);
                result[i] = s / 32768f;
            }

            return result;
        }
        private float[] ResampleFloat(float[] input, int inRate, int outRate, int channels)
        {
            if (inRate == outRate)
            {
                return input;
            }

            int inFrames  = input.Length / channels;
            double ratio  = (double)outRate / (double)inRate;
            int outFrames = (int)(inFrames * ratio);
            float[] output = new float[outFrames * channels];

            for (int of = 0; of < outFrames; of++)
            {
                double srcFrame = of / ratio;
                int i0 = (int)srcFrame;
                int i1 = i0 + 1;
                if (i1 >= inFrames)
                {
                    i1 = inFrames - 1;
                }
                double frac = srcFrame - i0;

                for (int ch = 0; ch < channels; ch++)
                {
                    int idx0 = i0 * channels + ch;
                    int idx1 = i1 * channels + ch;
                    float s0 = input[idx0];
                    float s1 = input[idx1];
                    output[of * channels + ch] = (float)((1.0 - frac) * s0 + frac * s1);
                }
            }

            return output;
        }
        private void InitializeAudioClient()
        {
            WriteStatus("[InitializeAudioClient] Thread=" + Thread.CurrentThread.ManagedThreadId);

            IMMDeviceEnumerator enumerator = (IMMDeviceEnumerator)new MMDeviceEnumerator();
            IMMDevice device;

            int hr = enumerator.GetDefaultAudioEndpoint(0, 1, out device);
            WriteStatus("[InitializeAudioClient] GetDefaultAudioEndpoint HR=0x" + hr.ToString("X8"));
            if (hr != 0 || device == null)
            {
                Console.WriteLine("[InitializeAudioClient] ERROR: No default audio endpoint.");
                return;
            }

            Guid iid = typeof(IAudioClient).GUID;
            IntPtr clientPtr;

            hr = device.Activate(ref iid, 23, IntPtr.Zero, out clientPtr);
            WriteStatus("[InitializeAudioClient] Activate HR=0x" + hr.ToString("X8") + " Ptr=" + clientPtr);
            if (hr != 0 || clientPtr == IntPtr.Zero)
            {
                Console.WriteLine("[InitializeAudioClient] ERROR: Activate failed.");
                return;
            }

            try
            {
                _audioClient = (IAudioClient)Marshal.GetObjectForIUnknown(clientPtr);
            }
            catch (Exception ex)
            {
                Console.WriteLine("[InitializeAudioClient] ERROR: Marshal.GetObjectForIUnknown failed: " + ex.Message);
                return;
            }

            WriteStatus("[InitializeAudioClient] AudioClient activated");

            IntPtr mixFormatPtr = IntPtr.Zero;

            try
            {
                hr = _audioClient.GetMixFormat(out mixFormatPtr);
                WriteStatus("[InitializeAudioClient] GetMixFormat HR=0x" + hr.ToString("X8"));
                if (hr != 0 || mixFormatPtr == IntPtr.Zero)
                {
                    Console.WriteLine("[InitializeAudioClient] ERROR: GetMixFormat failed.");
                    return;
                }

                WAVEFORMATEX baseFmt = (WAVEFORMATEX)Marshal.PtrToStructure(mixFormatPtr, typeof(WAVEFORMATEX));

                _deviceSampleRate    = (int)baseFmt.nSamplesPerSec;
                _deviceChannels      = baseFmt.nChannels;
                _deviceBytesPerFrame = baseFmt.nBlockAlign;

                if (baseFmt.wFormatTag == 65534)
                {
                    WAVEFORMATEXTENSIBLE ext = (WAVEFORMATEXTENSIBLE)Marshal.PtrToStructure(mixFormatPtr, typeof(WAVEFORMATEXTENSIBLE));

                    WriteStatus("[MixFormat] EXTENSIBLE");
                    WriteStatus("  SampleRate=" + ext.Format.nSamplesPerSec);
                    WriteStatus("  Bits=" + ext.Format.wBitsPerSample);
                    WriteStatus("  Channels=" + ext.Format.nChannels);
                    WriteStatus("  SubFormat=" + ext.SubFormat);

                    _deviceSampleRate    = (int)ext.Format.nSamplesPerSec;
                    _deviceChannels      = ext.Format.nChannels;
                    _deviceBytesPerFrame = ext.Format.nBlockAlign;
                }

                if (_pcm != null)
                {
                    float[] tmp = ConvertPcm16ToFloat(_pcm);
                    tmp = ResampleFloat(tmp, _sampleRate, _deviceSampleRate, _channels);

                    if (_channels == 1 && _deviceChannels == 2)
                    {
                        float[] stereo = new float[tmp.Length * 2];
                        for (int i = 0; i < tmp.Length; i++)
                        {
                            stereo[i * 2]     = tmp[i];
                            stereo[i * 2 + 1] = tmp[i];
                        }
                        tmp = stereo;
                    }

                    _floatPcm = tmp;

                    WriteStatus("[InitializeAudioClient] _floatPcm length=" + _floatPcm.Length);
                }

                hr = _audioClient.Initialize(0, 0, 0, 0, mixFormatPtr, IntPtr.Zero);
                WriteStatus("[InitializeAudioClient] Initialize HR=0x" + hr.ToString("X8"));
                if (hr != 0)
                {
                    Console.WriteLine("[InitializeAudioClient] ERROR: Initialize failed.");
                    return;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("[InitializeAudioClient] EXCEPTION: " + ex.Message);
                return;
            }
            finally
            {
                if (mixFormatPtr != IntPtr.Zero)
                {
                    Marshal.FreeCoTaskMem(mixFormatPtr);
                }
            }

            hr = _audioClient.GetBufferSize(out _bufferFrameCount);
            WriteStatus("[InitializeAudioClient] GetBufferSize HR=0x" + hr.ToString("X8"));
            if (hr != 0)
            {
                Console.WriteLine("[InitializeAudioClient] ERROR: GetBufferSize failed.");
                return;
            }

            Guid renderGuid = typeof(IAudioRenderClient).GUID;
            IntPtr renderPtr;

            hr = _audioClient.GetService(ref renderGuid, out renderPtr);
            WriteStatus("[InitializeAudioClient] GetService HR=0x" + hr.ToString("X8"));
            if (hr != 0 || renderPtr == IntPtr.Zero)
            {
                Console.WriteLine("[InitializeAudioClient] ERROR: GetService failed.");
                return;
            }

            try
            {
                _renderClient = (IAudioRenderClient)Marshal.GetObjectForIUnknown(renderPtr);
            }
            catch (Exception ex)
            {
                Console.WriteLine("[InitializeAudioClient] ERROR: Marshal.GetObjectForIUnknown(RenderClient) failed: " + ex.Message);
                return;
            }

            WriteStatus("[InitializeAudioClient] RenderClient acquired");
        }
        public void Play()
        {
            WriteStatus("[Play]");

            if (_audioClient == null)
            {
                Console.WriteLine("[Play] ERROR: AudioClient NULL");
                return;
            }

            if (_playing)
            {
                WriteStatus("[Play] Already playing");
                return;
            }

            _playing       = true;
            _stopRequested = false;

            Post(new Action(PlaybackThread));
        }
        public void Pause()
        {
            WriteStatus("[Pause]");

            Post(delegate()
            {
                WriteStatus("[Pause->Worker] Thread=" + Thread.CurrentThread.ManagedThreadId);

                _playing = false;
                if (_audioClient != null)
                {
                    _audioClient.Stop();
                }
            });
        }
        public void Stop()
        {
            WriteStatus("[Stop] Thread=" + Thread.CurrentThread.ManagedThreadId);

            _stopRequested = true;
            _playing       = false;

            if (_audioClient != null)
            {
                _audioClient.Stop();
            }

            _workEvent.Set();

            Position = TimeSpan.Zero;
            FirePositionChanged(0);
        }
        public void Clear()
        {
            WriteStatus("[Clear] Thread=" + Thread.CurrentThread.ManagedThreadId);

            Stop();

            _pcm              = null;
            _floatPcm         = null;
            _sampleRate       = 0;
            _channels         = 0;
            _bytesPerFrame    = 0;
            _bufferFrameCount = 0;

            _deviceSampleRate    = 0;
            _deviceChannels      = 0;
            _deviceBytesPerFrame = 0;

            Duration          = TimeSpan.Zero;
            Position          = TimeSpan.Zero;

            _audioClient      = null;
            _renderClient     = null;

            _playing          = false;
            _stopRequested    = false;
        }
        public void Seek(double seconds)
        {
            WriteStatus("[Seek] Requested seek to " + seconds);

            _seekRequestedSeconds = seconds;
            _seekRequested = true;

            // Wake the audio thread so it processes the seek immediately
            _workEvent.Set();
        }
        private void PlaybackThread()
        {
            WriteStatus("[PlaybackThread] START Thread=" + Thread.CurrentThread.ManagedThreadId);

            if (_audioClient == null)
            {
                Console.WriteLine("[PlaybackThread] ERROR: _audioClient is NULL");
                return;
            }

            if (_renderClient == null)
            {
                Console.WriteLine("[PlaybackThread] ERROR: _renderClient is NULL");
                return;
            }

            if (_floatPcm == null)
            {
                Console.WriteLine("[PlaybackThread] ERROR: _floatPcm buffer is NULL");
                return;
            }

            int hr = _audioClient.Start();
            WriteStatus("[PlaybackThread] Start HR=0x" + hr.ToString("X8"));
            if (hr != 0)
            {
                Console.WriteLine("[PlaybackThread] ERROR: AudioClient.Start failed.");
                return;
            }

            int totalFrames = _floatPcm.Length / _deviceChannels;
            int frameIndex  = 0;

            WriteStatus("[PlaybackThread] TotalFrames=" + totalFrames);

            while (frameIndex < totalFrames)
            {
                if (_stopRequested)
                {
                    WriteStatus("[PlaybackThread] Stop requested — breaking loop");
                    break;
                }

                if (_seekRequested)
                {
                    _seekRequested = false;

                    int newFrame = (int)(_seekRequestedSeconds * _deviceSampleRate);
                    if (newFrame < 0) 
                    {
                        newFrame = 0;
                    }

                    int totalFramesLocal = _floatPcm.Length / _deviceChannels;
                    if (newFrame > totalFramesLocal) 
                    {
                        newFrame = totalFramesLocal;
                    }

                    WriteStatus("[PlaybackThread] Seeking to frame " + newFrame);

                    frameIndex = newFrame;
                    Position = TimeSpan.FromSeconds(_seekRequestedSeconds);
                    FirePositionChanged(_seekRequestedSeconds);
                }

                uint padding;
                hr = _audioClient.GetCurrentPadding(out padding);
                if (hr != 0)
                {
                    Console.WriteLine("[PlaybackThread] ERROR: GetCurrentPadding HR=0x" + hr.ToString("X8"));
                    break;
                }

                int framesAvailable = (int)_bufferFrameCount - (int)padding;

                WriteStatus("[PlaybackThread] padding=" + padding + " available=" + framesAvailable);

                if (framesAvailable > 0)
                {
                    int framesToWrite = Math.Min(framesAvailable, totalFrames - frameIndex);

                    IntPtr bufferPtr;
                    hr = _renderClient.GetBuffer(framesToWrite, out bufferPtr);
                    if (hr != 0 || bufferPtr == IntPtr.Zero)
                    {
                        Console.WriteLine("[PlaybackThread] ERROR: GetBuffer failed.");
                        break;
                    }

                    int sampleIndex = frameIndex * _deviceChannels;
                    int sampleCount = framesToWrite * _deviceChannels;

                    WriteStatus("[PlaybackThread] Writing frames=" + framesToWrite);

                    Marshal.Copy(_floatPcm, sampleIndex, bufferPtr, sampleCount);

                    hr = _renderClient.ReleaseBuffer(framesToWrite, 0);
                    if (hr != 0)
                    {
                        Console.WriteLine("[PlaybackThread] ERROR: ReleaseBuffer failed.");
                        break;
                    }

                    frameIndex += framesToWrite;
                    Position    = TimeSpan.FromSeconds((double)frameIndex / _deviceSampleRate);

                    FirePositionChanged(Position.TotalSeconds);
                }

                Thread.Sleep(5);
            }

            _audioClient.Stop();
            _playing = false;

            WriteStatus("[PlaybackThread] STOPPING");
        }
        private void FirePositionChanged(double seconds)
        {
            if (PositionChanged == null)
            {
                return;
            }

            var handler = PositionChanged;
            var pos     = seconds;

            ThreadPool.QueueUserWorkItem(delegate
            {
                try
                {
                    Runspace.DefaultRunspace = _uiRunspace;
                    handler(this, pos);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("[FirePositionChanged] Error: " + ex.Message);
                }
            });
        }
        [DllImport("ole32.dll")]
        private static extern int CoInitializeEx(IntPtr pvReserved, uint dwCoInit);
        private const uint COINIT_MULTITHREADED = 0x0;
    }

    //    ____    ____________________________________________________________________________________________________        
    //   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
    //   \\__//¯¯¯ Audio Player [~]                                                                               ___//¯¯\\   
    //    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
    //        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    

    [StructLayout(LayoutKind.Sequential)]
    public struct WAVEFORMATEX
    {
        public ushort     wFormatTag;
        public ushort      nChannels;
        public uint   nSamplesPerSec;
        public uint  nAvgBytesPerSec;
        public ushort    nBlockAlign;
        public ushort wBitsPerSample;
        public ushort         cbSize;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct WAVEFORMATEXTENSIBLE
    {
        public WAVEFORMATEX        Format;
        public ushort wValidBitsPerSample;
        public uint         dwChannelMask;
        public Guid             SubFormat;
    }

    [ComImport]
    [Guid("D666063F-1587-4E43-81F1-B948E807363F")]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    interface IMMDevice
    {
        int Activate(ref Guid iid, int dwClsCtx, IntPtr pActivationParams, out IntPtr ppInterface);

        int OpenPropertyStore(int stgmAccess, out IntPtr ppProperties);

        int GetId(out IntPtr ppstrId);

        int GetState(out int pdwState);
    }

    [ComImport]
    [Guid("A95664D2-9614-4F35-A746-DE8DB63617E6")]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    interface IMMDeviceEnumerator
    {
        int EnumAudioEndpoints(int dataFlow, int dwStateMask, out IntPtr ppDevices);

        int GetDefaultAudioEndpoint(int dataFlow, int role, out IMMDevice ppEndpoint);

        int GetDevice(string pwstrId, out IMMDevice ppDevice);

        int RegisterEndpointNotificationCallback(IntPtr pClient);

        int UnregisterEndpointNotificationCallback(IntPtr pClient);
    }

    [ComImport]
    [Guid("1CB9AD4C-DBFA-4c32-B178-C2F568A703B2")]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    interface IAudioClient
    {
        int Initialize(int shareMode,
                       int streamFlags,
                       long hnsBufferDuration,
                       long hnsPeriodicity,
                       IntPtr pFormat,
                       IntPtr audioSessionGuid);

        int GetBufferSize(out uint pNumBufferFrames);
        int GetStreamLatency(out long phnsLatency);
        int GetCurrentPadding(out uint pNumPaddingFrames);
        int IsFormatSupported(int shareMode, IntPtr pFormat, out IntPtr ppClosestMatch);
        int GetMixFormat(out IntPtr ppDeviceFormat);
        int GetDevicePeriod(out long phnsDefaultDevicePeriod, out long phnsMinimumDevicePeriod);
        int Start();
        int Stop();
        int Reset();
        int SetEventHandle(IntPtr eventHandle);
        int GetService(ref Guid iid, out IntPtr ppv);
    }

    [ComImport]
    [Guid("F294ACFC-3146-4483-A7BF-ADDCA7C260E2")]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    interface IAudioRenderClient
    {
        int GetBuffer(int NumFramesRequested, out IntPtr ppData);
        int ReleaseBuffer(int NumFramesWritten, int dwFlags);
    }

    [ComImport]
    [Guid("BCDE0395-E52F-467C-8E3D-C4579291692E")]
    class MMDeviceEnumerator
    {
    }

    //    ____    ____________________________________________________________________________________________________        
    //   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
    //   \\__//¯¯¯ Assignment [~]                                                                                 ___//¯¯\\   
    //    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
    //        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    

    public class AssignmentSelectFile : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        public uint                  Index { get; set; }
        public string                 Name { get; set; }
        public string          DisplayName { get; set; }
        public string             Fullname { get; set; }
        public FormattedDateTime? Modified { get; set; }
        public ByteSize               Size { get; set; }
        private bool _selected;
        public bool Selected {
            get { return _selected; }
            set
            {
                if (_selected != value)
                {
                    _selected = value;
                    OnPropertyChanged("Selected");
                }
            }
        }
        public AssignmentSelectFile(uint index, FileInfo file)
        {
            this.Index       = index;
            this.Name        = file.Name;
            this.DisplayName = System.IO.Path.GetFileNameWithoutExtension(file.Name);
            this.Fullname    = file.FullName;
            this.Modified    = file.LastWriteTime;
            this.Size        = new ByteSize("Map",file.Length);
            this._selected   = false;
        }
        protected void OnPropertyChanged(string propertyName)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
            }
        }
        public override string ToString()
        {
            return this.Name;
        }
    }

    public class AssignmentSelectFileList : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        public string  Fullname { get; private set; }
        public uint      Exists { get; private set; }
        public object  Resource { get; set; }
        public ObservableCollection<AssignmentSelectFile> Output { get; private set; }
        public System.ComponentModel.ICollectionView View { get; set; }
        public object     Edit { get; set; }
        public AssignmentSelectFileList()
        {
            Clear();
        }
        public void Assign(string fullname)
        {
            if (Directory.Exists(fullname))
            {
                Fullname = fullname;
                Exists = 1;
                Refresh();
            }
            else
            {
                Exists = 0;
                Clear();
            }
        }
        public void Clear()
        {
            Output = new ObservableCollection<AssignmentSelectFile>();
            View = System.Windows.Data.CollectionViewSource.GetDefaultView(Output);
            OnPropertyChanged("Output");
            OnPropertyChanged("View");
        }
        public void Refresh()
        {
            Clear();

            var files = new DirectoryInfo(Fullname)
                .GetFiles("*.map")
                .OrderBy(f => f.Name);
        
            uint index = 0;
            foreach (var file in files)
            {
                AssignmentSelectFile item = new AssignmentSelectFile(index++, file);
                item.PropertyChanged += Item_PropertyChanged;
                Output.Add(item);
            }
        
            OnPropertyChanged("Output");
            OnPropertyChanged("View");
            OnPropertyChanged("AnySelected");
        }
        private void Item_PropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            if (e.PropertyName == "Selected")
                OnPropertyChanged("AnySelected");
        }
        public void ApplyFilter(string propertyName, string filterText)
        {
            if (string.IsNullOrEmpty(propertyName) || string.IsNullOrEmpty(filterText))
            {
                View.Filter = null;
            }
            else
            {
                View.Filter = item =>
                {
                    var file = item as AssignmentSelectFile;
                    if (file == null) return false;
    
                    var prop = file.GetType().GetProperty(propertyName);
                    if (prop == null) return false;
    
                    var raw = prop.GetValue(file, null);
                    var value = raw != null ? raw.ToString() : null;
    
                    return value != null &&
                    value.IndexOf(filterText, StringComparison.OrdinalIgnoreCase) >= 0;
                };
            }

            View.Refresh();
        }
        protected void OnPropertyChanged(string propertyName)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
            }
        }
        public bool AnySelected
        {
            get
            {
                foreach (AssignmentSelectFile f in Output)
                {
                    if (f.Selected)
                        return true;
                }
                return false;
            }
        }
        public void FilterSelected()
        {
            View.Filter = item =>
            {
                var f = item as AssignmentSelectFile;
                return f != null && f.Selected;
            };
            View.Refresh();
        }
        public override string ToString()
        {
            return "<Q3ALive.Assignment.SelectFile.List>";
        }
    }

    //    ____    ____________________________________________________________________________________________________        
    //   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
    //   \\__//¯¯¯ Threading [~]                                                                                  ___//¯¯\\   
    //    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
    //        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    

    public class ThreadingService
    {
        private Dispatcher _dispatcher;
        public Action        _uiAction;
        public Action         _uiStart;
        public Action           _uiEnd;
        public ThreadingService(object dispatcherObject)
        {
            _dispatcher = dispatcherObject as Dispatcher;
            if (_dispatcher == null)
            {
                throw new Exception("Invalid dispatcher passed to ThreadingService.");
            }
        }
        public Action Wrap(object target, string methodName)
        {
            var method = target.GetType().GetMethod(methodName);
            if (method == null)
            {
                throw new Exception("Method not found: " + methodName);
            }

            return (Action)Delegate.CreateDelegate(typeof(Action), target, method);
        }
        public void RunAsync(Action work, Action ui)
        {
            _uiAction = ui;

            Task task = Task.Run(work);

            task.ContinueWith(
                new Action<Task>(
                    delegate(Task t)
                    {
                        _dispatcher.Invoke(_uiAction);
                    }
                )
            );
        }
        public void RunAsyncWithProgress(Action work, Action uiStart, Action uiEnd, Action ui)
        {
            _uiStart  = uiStart;
            _uiEnd    = uiEnd;
            _uiAction = ui;

            _dispatcher.Invoke(_uiStart);

            Task task = Task.Run(work);

            task.ContinueWith(
                new Action<Task>(
                    delegate(Task t)
                    {
                        _dispatcher.Invoke(_uiEnd);

                        _dispatcher.Invoke(_uiAction);
                    }
                )
            );
        }
    }

    //    ____    ____________________________________________________________________________________________________        
    //   //¯¯\\__//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\\___    
    //   \\__//¯¯¯ Xaml [~]                                                                                       ___//¯¯\\   
    //    ¯¯¯\\__________________________________________________________________________________________________//¯¯\\__//   
    //        ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯    ¯¯¯¯    
    
    public class DataGridEx : DataGrid
    {
        public static readonly DependencyProperty TopRightHeaderTemplateProperty =
            DependencyProperty.Register("TopRightHeaderTemplate",
                                        typeof(DataTemplate),
                                        typeof(DataGridEx),
                                        new FrameworkPropertyMetadata(null, FrameworkPropertyMetadataOptions.AffectsMeasure));
        public DataTemplate TopRightHeaderTemplate
        {
            get { return (DataTemplate)GetValue(TopRightHeaderTemplateProperty); }
            set { SetValue(TopRightHeaderTemplateProperty, value); }
        }
        static DataGridEx()
        {
            DefaultStyleKeyProperty.OverrideMetadata(typeof(DataGridEx),
                                                     new FrameworkPropertyMetadata(typeof(DataGridEx)));
        }
    }
}
