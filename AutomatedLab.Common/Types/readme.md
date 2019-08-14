All .NET types belong in this directory as cs files. The first line of the file may be a single-line
comment `//` which may look like this:

//WindowsOnly;ReferenceAssemblies:C:\Full\Path\To\Library.dll,C:\Another\Library.dll

The point of this is to properly import any references that might be needed before importing
the type, and to skip Windows-only types on Linux systems.