$Files = Get-WMIObject -query "Select * From CIM_DataFile Where drive = 'L:' and extension = 'xml'" -computername "iu-uits-obag0" | Sort-Object -Property CreationDate | select-object -first 5

foreach($File in $Files)
{
    write-host $File.FileName "was created on" $File.CreationDate
    $File.FileSize
    $File.Path
#    $File.Delete()
}