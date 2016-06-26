function invoke-eventexit{
<#
.Synopisis
This function checks if there was an error code in Powershell

.Description
This script is designed to run on exit and push out log data to the event log.  The script
will verify that the script exited as part of the normal process or was an unexpected error.
If will log which happened.

.Parameter
No Parameters are necessary

.Dependencies
Initalize-ErrorLog.ps1


.Notes
This is designed as an exit script only.

.Author
Lee Carlson

.Verson 1.0.0

.lastupdated
7.2.14
#>

$LogName = $EventLog.LogName
$Source = $EventLog.Source
$EntryType = $EventLog.EntryType
$EventID = $EventLog.EventID
$Message = $EventLog.Message

$EventOutput = "
LogName = $LogName
Source = $Source
EntryType = $EntryType
EventID = $EventID
Message = $Message
"

#$EventOutput | out-file "B:\outfile.txt"
#$Error | out-file "B:\outfile.txt" -Append

#>
Write-EventLog –LogName $EventLog.LogName –Source $EventLog.Source –EntryType $EventLog.EntryType –EventID $EventLog.EventID –Message $EventLog.Message

}