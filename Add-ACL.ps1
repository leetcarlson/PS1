function Add-ACL {
<#
.Synopisis
Add ACL to a FSO.

.Description
Allows the addition of Access Control information to a File System Object.

.Author
Lee Carlson

.Created
3/11/2016

.Current Version
1.00 

.VersionDates
1.00 - 3/11/2016

.Parameter

#>
[CmdletBinding()]
param 
(
[Parameter()]
[string]$File,
[string]$User,
[switch]$Read,
[switch]$Execute,
[switch]$FullControl
)

if($Read.ispresent)
{
    $Permission = "Read"
}
if($Execute.ispresent)
{
    $Permission = "Execute"
}
if($FullControl.ispresent)
{
    $Permission = "FullControl"
}

$ACL = get-acl $File
$ACE = New-Object  system.security.accesscontrol.filesystemaccessrule($User,$Permission,"Allow")

$ACL.AddAccessRule($ACE)

set-acl $File $ACL

}

Add-Acl -file "C:\Users\lcarlson16\Documents\testfile.txt" -user "Everyone" -Read

get-acl "C:\Users\lcarlson16\Documents\testfile.txt" | format-list
