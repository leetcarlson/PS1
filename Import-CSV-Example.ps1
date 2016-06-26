$Content = import-csv B:\OutPut.csv

foreach ($line in $Content)
{
    $ID = $line.SCHEDPROCNUM
    $Name = $line.schedprocname.trimend() #get rid of white space at the end of the line
    $Instance = $line.LOCALINSTANCEID.trimend()
    $UserNum = $line.REGISTERNUM
}
