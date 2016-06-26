$o = New-Object -com Shell.application
$folder = $o.NameSpace("C:\windows")
$file = $folder.parseName("explorer.exe")
$file.verbs() | select Name