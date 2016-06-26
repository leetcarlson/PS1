# $PSScriptRoot is the currnet directory of the script
#$ScriptRoot = $PSScriptRoot + "\Functions"
$ScriptRoot = "B:\AA Git Hub Repo\github.iu.edu\lcadmin\PSModules\trunk\LeesModule"
Get-ChildItem -recurse $ScriptRoot | where { $_.Extension -eq ".ps1" } | foreach { . $_.FullName } | out-host