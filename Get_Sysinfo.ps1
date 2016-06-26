function Get-Sysinfo{

$SystemInfo = New-Object -TypeName PSObject

Add-Member -InputObject $SystemInfo -MemberType NoteProperty -Name OSName -Value ""
Add-Member -InputObject $SystemInfo -MemberType NoteProperty -Name OSVersion -Value ""
Add-Member -InputObject $SystemInfo -MemberType NoteProperty -Name OSPath -Value ""
Add-Member -InputObject $SystemInfo -MemberType NoteProperty -Name RegisterdOrg -Value ""
Add-Member -InputObject $SystemInfo -MemberType NoteProperty -Name RegisterdUser -Value ""
Add-Member -InputObject $SystemInfo -MemberType NoteProperty -Name RAM -Value ""
Add-Member -InputObject $SystemInfo -MemberType NoteProperty -Name CPU -Value ""

#Get OS FriendlyName
$RegPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\"
$OSInfo = Get-ItemProperty -Path $RegPath
$SystemInfo.OSName = $OSInfo.ProductName
$SystemInfo.OSPath = $OSInfo.PathName
$SystemInfo.RegisterdUser = $OSInfo.RegisteredOrginazation

}
get-sysinfo

#echo "System OSName =" $systeminfo.OSName

<#Get OS Friendly Name
$OSFriendly = (Get-WmiObject Win32_OperatingSystem).name

#Get RAM Rounded to the nearest GB (it displayes as usually .9+ GB so I have this rounding for easier viewing)
$Memory = Get-WmiObject -Class Win32_ComputerSystem | select totalphysicalmemory
$RAM =  [math]::round(($memory.totalphysicalmemory/1GB),0)
write-host "$RAM GB"

#[environment]::OSVersion | Format-List
 #(Get-WmiObject Win32_OperatingSystem).name
 #Get-WmiObject Win32_Processor
 #$mem = Get-WmiObject -Class Win32_ComputerSystem
 #($mem.totalphysicalmemory / 1GB)

 $colItems = Get-WmiObject Win32_NetworkAdapterConfiguration -Namespace "root\CIMV2" | where{$_.IPEnabled -eq “True”}

foreach($objItem in $colItems) {
	Write-Host "IP Address:" $objItem.IPAddress
	Write-Host "MAC Address:" $objItem.MACAddress
	}
#>