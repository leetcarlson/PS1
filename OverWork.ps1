$Processes = get-process chr*
$processes
#<foreach ($Process in $Processes)
{

if($Process.cpu -gt 25)
    {
        write-host "Boy this is using memory!" $PRocess.Name
    }
    else
    {
        write-host "Not using much"
    }

}#>