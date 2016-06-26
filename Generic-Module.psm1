#$ScriptRoot = Folder that contains you Powershell Scripts you wish to add to the module.
### REMEMBER: The scripts will be run when you import the module so have them wrapped in a function to avoid unwanted situations.
$ScriptRoot = "c:\some folder\where scripts\are"
Get-ChildItem -recurse $ScriptRoot | where { $_.Extension -eq ".ps1" } | foreach { . $_.FullName }