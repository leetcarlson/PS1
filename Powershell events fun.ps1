#get-help Register-EngineEvent
#get-help New-Event -examples

#Register-EngineEvent PowerShell.ErrorHandling –Action { out-file "B:\Error.txt" -OutVariable "Something"}

#asdf

[System.Management.Automation.PsEngineEvent].GetMethods()