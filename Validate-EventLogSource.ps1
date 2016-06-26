$LogSourceFile = import-csv B:\EventLogSource.csv
$LogName = "VAA_Scripting"
foreach ($LogDetails in $LogSourceFile)
{
    $LogSource = $LogDetails.source

    write-host "$LogName with a source of $LogSource"

    $RegPath = "HKLM:\System\CurrentControlSet\services\eventlog\$LogName"
    $RegVal = gci -Path $RegPath

    foreach($Subkey in $RegVal)
    {
        if(!($SubKey.Name -like "*$LogSource*"))
        {
            write-host 'New-EventLog –LogName $LogName –Source $LogSource'
        }
    }
}