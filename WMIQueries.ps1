#$data = Get-WmiObject win32_desktopmonitor
#$query = "SELECT * FROM CIM_DataFile WHERE Drive='C:' AND Path='\\scripts\\'"
#$data = Get-WmiObject -Query $query #Get members and you can compress this data
#write-host $data.PSStatus

#$query = "SELECT * FROM CIM_OperatingSystem"
#$data = Get-WmiObject -Query $query
#write-host $data.name #Gets OS "Name" also ServicePackMajorVersion

$query = "SELECT * FROM Win32_ScheduledJob"
Get-WmiObject -Query $query
#write-host $data
