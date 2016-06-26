function Find-LowDiskSpace{
$RemoteMachine = "localhost"

$Drives = Get-WmiObject win32_logicaldisk | Where-Object { $_.DriveType -eq 3 }

    foreach($Drive in $Drives)
    {

    $DeviceID = $Drive.deviceID
    $FreeSpace = "{0:N2}" -f ($Drive.FreeSpace / 1GB)
    $DriveSize = "{0:N2}" -f ($Drive.Size / 1GB)
    $PercentFree = ($Drive.FreeSpace / $Drive.Size) * 100
    $PercentFreeFormated = "{0:P1}" -f ($Drive.FreeSpace / $Drive.Size)

    if($PercentFree -lt "90")
        {
        echo "Low Space"
        echo $RemoteMachine
        echo "Drive: $DeviceID"
        echo "FreeSpace: $FreeSpace"
        echo "DriveSize: $DriveSize"
        echo "Percent Free: $PercentFreeFormated"
        }
    }
}
Find-LowDiskSpace