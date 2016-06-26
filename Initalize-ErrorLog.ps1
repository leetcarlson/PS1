function Add-errorlog{<#.SynopisisScript to create an object for easier event logging.
.DescriptionThis script is designed to create an object to facilitate and ease the event logging process.
It will create an object and maintain its state, allowing coders to merely send what data they want to the object and not worry about handeling variables.  It will also fire off an event when the script dies unexpectedly,capturing errors.
.Parameter$ScriptName = The name of the script that is being logged$EventLogSource = Source listed in event log for easy sorting later$EnvRun = Environment in which the scripts are being run against (Dev, Test, or Production)
.DependenciesNo Dependencies
.NotesBy Calling this object, it creates a number of processes automatically.  This is something to note when loading this module.I am using OUT for On Unexpected Termination
.AuthorLee Carlson
.Verson 1.0.1
.changelogI added better Parameter handling and converted some parameters to automated processes
.lastupdated7.7.14
#>param ([string]$ScriptName,[string]$EventLogSource,[string]$EnvRun)
#EventLog Object Definition Area Begin
    $Global:EventLog = New-Object -TypeName PSObject
    Add-Member -InputObject $EventLog -MemberType NoteProperty -Name Message -Value " "    Add-Member -InputObject $EventLog -MemberType NoteProperty -Name ScriptName -Value ""    Add-Member -InputObject $EventLog -MemberType NoteProperty -Name Source -Value ""    Add-Member -InputObject $EventLog -MemberType NoteProperty -Name EntryType -Value "Information"    Add-Member -InputObject $EventLog -MemberType NoteProperty -Name EventID -Value "0"    Add-Member -InputObject $EventLog -MemberType NoteProperty -Name Environment -Value ""    Add-Member -InputObject $EventLog -MemberType NoteProperty -Name LogName -Value "VAA_Scripting"    Add-Member -InputObject $EventLog -MemberType ScriptMethod -Name Log {param ([String]$MessageText) $MessageText | set-eventmsg}    Add-Member -InputObject $EventLog -MemberType ScriptMethod -Name SetAsWarning {$EventLog.EntryType = "Warning"}    Add-Member -InputObject $EventLog -MemberType ScriptMethod -Name SetAsError {$EventLog.EntryType = "Error"}
#EventLog Object Definition Area End
    $EventLog.Environment = $EnvRun	$EventLog.Source = $EventLogSource	$EventLog.ScriptName = $ScriptName	$EventLog.Log("This log is for a PowerShell script")}
#Other Functions in this script
function set-eventmsg {param([Parameter(Mandatory=$True,ValueFromPipeline=$True)][string]$MessageText)
    $EventTime = Get-Date -Format "yy-MM-dd HH:mm:ss.ffff"
    if($EventLog.Message -eq "")
    {        $EventLog.Message = "$MessageText`r"    }    else    {        $EventLog.Message += "$EventTime - $MessageText`r"    }}