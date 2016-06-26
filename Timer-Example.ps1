$timeout = new-timespan -Minutes 1
$sw = [diagnostics.stopwatch]::StartNew()
while ($sw.elapsed -lt $timeout){

    Write-host $Sw.Elapsed.Seconds "Seconds"
    start-sleep -seconds 5
}
 
write-host "Timed out"