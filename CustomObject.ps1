$EventLog = New-Object -TypeName PSObject

Add-Member -InputObject $EventLog -MemberType NoteProperty -Name Msg -Value ""
Add-Member -InputObject $EventLog -MemberType NoteProperty -Name ScriptName -Value ""
Add-Member -InputObject $EventLog -MemberType NoteProperty -Name Source -Value ""
Add-Member -InputObject $EventLog -MemberType NoteProperty -Name EntryType -Value ""
Add-Member -InputObject $EventLog -MemberType ScriptMethod -Name Message {param ([String]$MessageText) $EventLog.msg += "$MessageText `n"}
Add-Member -InputObject $EventLog -MemberType ScriptMethod -Name SetAsWarning {$EventLog.EntryType = "Warning"}
Add-Member -InputObject $EventLog -MemberType ScriptMethod -Name SetAsError {$EventLog.EntryType = "Error"}
Add-Member -InputObject $EventLog -MemberType ScriptMethod -Name OUT {([String]$OutType)$EventLog.EntryType = $OutType} #OnUnexpectedTermination
Add-Member -InputObject $EventLog -MemberType AliasProperty -Name OnUnexpectedTermination -Value OUT

$EventLog.ScriptName = $MyInvocation.ScriptName

$EventLog.Message("Error Text")
$EventLog.Message("Another error Text")
$EventLog.Message($this)

#$EventLog.SetAsWarning()
#$EventLog.SetAsError()

$Eventlog.OnUnexpectedTermination("Error")

echo $EventLog.OUT