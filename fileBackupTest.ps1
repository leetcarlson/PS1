$OnBaseRoot = '\\ads\uis\onbase\devdata\'
$InportFolder = $OnBaseRoot + '\automated\'
$files = Get-ChildItem $InportFolder -File -Recurse | select lastwritetime, fullname, basename, extension, hour, minute, DirectoryName | % {write-output ($_.basename) ($_.lastwritetime).Year ($_.LastWriteTime).Month.tostring().PadLeft(2,"0") ($_.LastWriteTime).Day.tostring().PadLeft(2,"0") ($_.LastWriteTime).Hour.tostring().PadLeft(2,"0") ($_.LastWriteTime).Minute.tostring().PadLeft(2,"0") ($_.Extension) ($_.DirectoryName) ($_.FullName)}
$i = 0
$LogTime = Get-Date -Format yyyyMMdd
$logfile = $OnBaseRoot + '\backup\logs\backuplog.' + $logtime + '.txt'

$logstarttime = Get-Date
write-output "File backup process started $logstarttime `n`r`n`r" | out-file $logfile -Append

do 
{
    $OldFileName = $files.Item($i+8)
    $toPath = $files.Item($i+7) -replace "Automated", "Backup"
    $newname = $files.Item($i) + "." + $files.Item($i+1) + $files.item($i+2)  + $files.item($i+3)  + "." + $files.item($i+4) + $files.item($i+5) + $files.item($i+6)
    $newfilename = $toPath + "\" + $newname 
    
    $ShortPath = $toPath -replace "\\ads\\uis\\onbase\\devdata\\backup\\", ""
    $newname = ".." + $ShortPath + "\" + $newname

    if ((test-path -path $newfilename) -ne "True") {
        Copy-Item $OldFileName $newfilename 
        write-output "$newname -- New File Copy Created" | out-file $logfile -Append
    }
    else
    {
        write-output "$newname -- File Exists No Action Taken" | out-file $logfile -Append
    }
    $i = $i + 9
} while ($i -lt $files.length)

$logendtime = Get-Date
write-output "`n`r`n`rFile backup process ended $logendtime `n`r`n`r" | out-file $logfile -Append
write-output "=================================================================================================================`n`r`n`r" | out-file $logfile -Append
