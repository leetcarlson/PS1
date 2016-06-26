Function Start-iseTranscript
{
  Param(
    [string]$path 
  )
  $transcriptHeader = @"
**************************************
Windows PowerShell ISE Transcript Start
Start Time: $(get-date)
UserName: $env:username
UserDomain: $env:USERDNSDOMAIN
ComputerName: $env:COMPUTERNAME
Windows version: $((Get-WmiObject win32_operatingsystem).version)
**************************************
Transcript started. Output file is $path
"@
  $transcriptHeader >> $path
  $psISE.CurrentPowerShellTab.Output.Text >> $path
} #end function start-iseTranscript

Start-iseTranscript -Path b:\trans.txt



$Freespace = 
@{
  Expression = {[int]($_.Freespace/1GB)}
  Name = 'Free Space (GB)'
}

$PercentFree = 
@{
  Expression = {[int]($_.Freespace*100/$_.Size)}
  Name = 'Free (%)'
}
Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType = 3 or DriveType = 4"| Select-Object -Property DriveType, DeviceID, VolumeName, $Freespace, $PercentFree 