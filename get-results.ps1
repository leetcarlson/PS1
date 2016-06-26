$DirtoSearch = 'B:\'
$StringSearch = "compass"

$Files = dir $DirtoSearch -File

foreach($File in $Files)
{
    write-host $File.Directory
    $line = 0
    $UNCFile = $File.Directory + $File
    foreach ($line in [System.IO.File]::ReadLines($UNCFile)) 
    {
    $linenum++
        if($line -match $StringSearch)
        {
            Write-host "$DirtoSearch$File at line $linenum found $StringSearch"
        }
    }
}