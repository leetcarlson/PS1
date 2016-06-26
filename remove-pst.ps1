Function remove-pst{
  <# 
.Synopsis 
    Checks size of PST and removes it if it is too big

.Description 
    This script determines the size of the .pst file and will remove it from outlook.
    The script will move the archive.pst file to a backup location and change its name if it is large enough.

.Author
    Lee Carlson

.Version
    1.0.0
#>
Param 
    (
        # Enter the path to the PST file, must be an absolute path
        [parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        valuefrompipelinebypropertyname=$true)]
        [Alias('fullname')]
        [ValidateScript({([System.IO.Path]::IsPathRooted($_)) -and ($_.endswith('.pst'))})]
        [string]$path
    ) 
$PSTPath = $Path #Correction for whan I made this a function
$Outlook = new-object -com outlook.application 
$Namespace = $Outlook.getNamespace("MAPI") 
$Namespace.addStore($pstpath)
$PSTFolder = $Namespace.Folders.Item('Outlook Data File')

$Namespace.GetType().InvokeMember(
  'RemoveStore',
  [System.Reflection.BindingFlags]::InvokeMethod,
  $null,
  $Namespace,
  ($PSTFolder))
}remove-pst