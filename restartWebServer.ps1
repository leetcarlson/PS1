#Beginning of Actual Script
import-module webadministration
$ErrorStatus = 0
#$Computer = $env:computername

$Computer = "iu-uits-obad"

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
start-sleep -seconds 5  #Pause to let maching catch up (the wait is not be always enough)

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
    #email -EmailTo 'bl-uits-vaa-OBADM-L@exchange.iu.edu' -EmailTitle "$Computer WebServer restart Successful" -EmailBody "$Computer WebServer restart Successful"
    email -EmailTo 'lcarlson@iu.edu' -EmailTitle "$Computer WebServer restart Successful" -EmailBody $EmailBody
    }
else
   {
   log-update "Process complete with $ErrorStatus errors" -ErrorLevel "Error"
   #email -EmailTo 'bl-uits-vaa-OBADM-L@exchange.iu.edu' -EmailTitle "ERROR $Computer WebServer restart Failure" -EmailBody $EmailBody 
   email -EmailTo 'lcarlson@iu.edu' -EmailTitle "ERROR $Computer WebServer restart Failure" -EmailBody $EmailBody 
   }