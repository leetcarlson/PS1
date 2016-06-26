function Get_ErrorDetails  #This script gathers all of the error information, formats for easier reading later
{
    $ErrorLog = $Error | format-list | Out-String
    
    $EventLog.Log($ErrorLog)
    $EventLog.SetAsError()
}

### Variables to Set for Event Logging ###

$EventLogSource = "" #This is the source listed in the Event Log under Source (this source must be registered)
$EnvRun = "" #Environment Which the script is running (Usually, dev, test, or dev and Test or PRODUCTION)

### End Variables to Set for Event Logging###

import-module errorlog-module
Register-EngineEvent PowerShell.Exiting –Action { invoke-EventExit} #This is the exit code that will send the event details to the eventlog
Add-Errorlog -ScriptName ($MyInvocation.InvocationName) -EventLogSource $EventLogSource -EnvRun $EnvRun

### End Error Logging Header ###