﻿function Add-errorlog{
.Description
It will create an object and maintain its state, allowing coders to merely send what data they want 
.Parameter
.Dependencies
.Notes
.Author
.Verson 1.0.1
.changelog
.lastupdated
#>param 
#EventLog Object Definition Area Begin
    $Global:EventLog = New-Object -TypeName PSObject
    Add-Member -InputObject $EventLog -MemberType NoteProperty -Name Message -Value " "
#EventLog Object Definition Area End
    $EventLog.Environment = $EnvRun
#Other Functions in this script
function set-eventmsg {
    $EventTime = Get-Date -Format "yy-MM-dd HH:mm:ss.ffff"
    if($EventLog.Message -eq "")
    {