<#
$os = gwmi win32_operatingsystem
$os.ConvertToDateTime($os.installDate)
$os.ConvertToDateTime($os.LastBootUpTime)
($os.FreePhysicalMemory / 1MB)
$OS.caption

gwmi win32_operatingsystem | Select-Object -Property * | Format-List

clear-host
#>
#gwmi CIM_DesktopMonitor | select-object -Property * -Verbose | format-list

#gwmi CIM_DiskDrive | select-object -Property * -Verbose | format-list

#gwmi CIM_Memory | select-object -Property * -Verbose | format-list

#gwmi CIM_Thread | select-object -Property * -Verbose | format-list

#gwmi CIM_Product | select-object -Property * -Verbose | format-list

#gwmi  CIM_DataFile | select-object -Property * | format-list

#OS Information
$os = gwmi win32_operatingsystem
write-host "OS Information"
$os.ConvertToDateTime($os.installDate) #Install Date
$os.ConvertToDateTime($os.LastBootUpTime) #Last Boot Up Time
($os.FreePhysicalMemory / 1MB) #Ram Free
$OS.caption #OS Name
$OS.ServicePackMajorVersion
$OS.ServicePackMinorVersion
$OS.Version

#Disk Drive Information
write-host "`nDisk Drive Information"
$Drive = gwmi -query "Select * from Win32_Volume Where Name = 'C:\\'"
($Drive.capacity / 1GB)
($Drive.FreeSpace / 1GB)
#$Drive.DefragAnalysis()

#Hardware Information
write-host "`nHardware Information"
$Hardware = GWMI win32_computersystem
($hardware.TotalPhysicalMemory / 1GB)
$Hardware.NumberOfLogicalProcessors
$hardware.NumberOfProcessors

<#
write-host "`nProcessor Information"
$CPU = GWMI win32_processor
$CPU.ProcessorID
$CPU.maxclockspeed
#>

write-host "`nSoftware Installed"
$Software = GWMI Win32_Product
$software | sort -Property "Caption"
foreach($Program in $Software)
{
    write-host $Program.name " = " $Program.version " = " $Program.InstallDate " = " $Program.Caption
}
