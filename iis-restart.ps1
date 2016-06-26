Function Email {
<#
.Synopisis
Simple SMTP Emailer to Attach to Scripts

.Description
Sends message text specified to email address sepcified

.Parameter
-EmailTo = Address (or Addresses to Send message to) [REQUIRED]
-EmailTitle = Title of the EMail Message [REQUIRED]
-EMailBody = The Acutal Message being Sent [REQUIRED]
-SMTPServer = SMTP Server to Send Message [Optional]
-EMailFrom = The Address that is sending the message [Optional]
-EMailReplayTo = The reply to address [Optional]

.Dependencies
No Dependencies

.Author
Lee Carlson

.Verson 1.0
#>
param 
(
[Parameter(Mandatory=$true)][string]$EmailTo,
[Parameter(Mandatory=$true)][string]$EmailTitle,
[Parameter(Mandatory=$true)][string]$EmailBody,
[string]$SMTPServer = "mail-relay.iu.edu",
[string]$EMailFrom = "ips@indiana.edu",
[string]$EMailReplyTo = "no.one@iu.edu"
)

    $msg = new-object Net.Mail.MailMessage
    #Creating SMTP server object
    $smtp = new-object Net.Mail.SmtpClient('mail-relay.iu.edu')

    #Email structure 
    $msg.From = $EMailFrom
    $msg.ReplyTo = $EMailReplyTo
    $msg.To.Add($EmailTo)
    $msg.subject = $EmailTitle
    $msg.body = $EmailBody

    #Sending email 
    $smtp.Send($msg)
}
function log-update {
<#
.Synopisis
A Log file creator.  The file will be [scriptname].dateexecuted.log in the same directory as the PS Script.

.Description
Helps to provide a uniform log file output system for easier reading later. The file will be PSLog.txt in the same directory as the PS Script.

.Parameter
-OutputText = Is the text that will display in the log file
#>
param 
(
[string]$OutputText,
[string]$ErrorLevel = "Info"
)
$outputtext = (Get-Date -Format "MM-dd HH:mm:ss.ffff") + " - " + $ErrorLevel + " - " + $OutputText

$scriptfileName = $PSCommandPath -replace ".ps1", ""
$Scriptfile = $scriptfileName + ".log"

#Write-host $PSCommandPath

out-file -Append $Scriptfile -InputObject $OutputText
}


#Beginning of Actual Script
import-module webadministration
$ErrorStatus = 0
$Computer = $env:computername

$scriptfileName = $PSCommandPath -replace ".ps1", ""
$Scriptfile = $scriptfileName + ".log"
if($scriptfile) #if there is an old log file delete it
{
remove-item $Scriptfile
}

log-update -outputtext "Script Started "
log-update -outputtext "AppPool Service"
$AppPools = Get-Item IIS:\AppPools\ | Get-ChildItem #Get all AppPools

foreach ($AppPool in $AppPools) #Loop through each app in the apppool one at a time
{
    $Stop = stop-WebAppPool -name $AppPool.name | wait-job -timeout 60
    $APName = $AppPool.name
    log-update -outputtext "Stopping - $APName"
    start-sleep -seconds 5  #Pause to let maching catch up (the wait is not always enough

    $AppStatus = Get-Item IIS:\AppPools\$ApName
    $APState =  $AppStatus.state
    if($APState -eq "Stopped") #Verify that the app has stopped
        {
            log-update "Verified - $APName is $APState"
        }
        else #App is not stopped (This is a problem)
        {
            log-update "Not verified stopped, $APName is $APState" -errorlevel "ERROR"
            $ErrorStatus++
        }

    $Start = start-WebAppPool -name $APName | wait-job -timeout 60  #Start WebAppPool
    log-update -outputtext "Starting - $APName"
    start-sleep -seconds 5  #Pause to let maching catch up (the wait is not always enough

    $AppStatus = Get-Item IIS:\AppPools\$ApName
    $APState =  $AppStatus.state
    if($APState -eq "Started") #Verify that the app has stopped
        {
            log-update "Verified - $APName is $APState"
            log-update -outputtext "$APName has been restarted"
        }
        else #App is not stopped (This is a problem)
        {
            log-update "Not verified started, $APName is $APState" -errorlevel "ERROR"
            $ErrorStatus++
        }
        
}
log-update -outputtext "WebSite Service"
Stop-Website -name AppServer | wait-job -timeout 60 # Stop Website
log-update -outputtext "Stopping - AppServer"
start-sleep -seconds 5  #Pause to let maching catch up (the wait is not always enough

$WebStatus = Get-Website -name AppServer #Verify Website is stopped
$WebState = $WebStatus.state
if($Webstate -eq "Stopped")
{
    log-update "Verified - AppServer is $WebState"
}
else
{
    log-update "Not verified stopped, AppServer is $WEbState" -errorlevel "ERROR"
    $ErrorStatus++
}

Start-Website -name AppServer | wait-job -timeout 60 # Stop Website
log-update -outputtext "Starting - AppServer"
start-sleep -seconds 5  #Pause to let maching catch up (the wait is not always enough

$WebStatus = Get-Website -name AppServer #Verify Website is stopped
$WebState = $WebStatus.state
if($Webstate -eq "Started")
{
    log-update "Verified - AppServer is $WebState"
}
else
{
    log-update "Not verified started, AppServer is $WebState" -errorlevel "ERROR"
}


$EmailBody = Get-content $ScriptFile  | out-string
$EmailBody = "ERROR $Computer WebServer restart Failure `n`r`n`r$EmailBody"
if($ErrorStatus -eq 0)
    {
    log-update "Process complete with $ErrorStatus errors"
    email -EmailTo 'bl-uits-vaa-OBADM-L@exchange.iu.edu' -EmailTitle "$Computer WebServer restart Successful" -EmailBody "$Computer WebServer restart Successful"
    #email -EmailTo 'lcarlson@iu.edu' -EmailTitle "$Computer WebServer restart Successful" -EmailBody $EmailBody
    }
else
   {
   log-update "Process complete with $ErrorStatus errors" -ErrorLevel "Error"
   email -EmailTo 'bl-uits-vaa-OBADM-L@exchange.iu.edu' -EmailTitle "ERROR $Computer WebServer restart Failure" -EmailBody $EmailBody 
   #email -EmailTo 'lcarlson@iu.edu' -EmailTitle "ERROR $Computer WebServer restart Failure" -EmailBody $EmailBody 
   }