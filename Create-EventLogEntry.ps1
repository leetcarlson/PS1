function Create-eventlogEntry {
<#
.Synopisis
Script to write an event to event log.

.Description
This script is designed to automate our script logging.  It does this by providing automated
parameters for commonly used parameters.  It also makes it easier to drop data into a temp file
for complete output later.

.Parameter
-Message - This is the text that will be displayed when the error is displayed
-Source - This is the event source in the event list
-LogName - This is the log where the event will be placed.  Defaults to VAA_Scriptign
-EventID - This is the event ID assigned to specific event.  Defaults to 0.
-EntryType - This indicates the level of the issue.  (See EntryType list in notes)  This Defaults to Information

.Dependencies
No Dependencies

.Notes
Here is a list of the EntryTypes
Information
Warning
Error
Audit Success
Audit Failure

.Author
Lee Carlson

.Verson 1.0

.lastupdated
7.1.14
#>
param 
(
[Parameter(Mandatory=$true)][string]$Message,
[Parameter(Mandatory=$true)][string]$Source,
[string][ValidateSet("Information", "Warning", "Error", "Audit Success", "Audit Failure")]$EntryType = "Information",
[int]$EventID = 0,
[string]$LogName = "VAA_Scripting"
)

    Write-EventLog –LogName $LogName –Source $Source –EntryType $EntryType –EventID $EventID –Message $Message

}