function Copy-File {
[cmdletbinding()]
param( [string]$from, [string]$to)
$ffile = [io.file]::OpenRead($from)
$tofile = [io.file]::OpenWrite($to)
Write-Progress `
    -Activity "Copying file" `
    -status ($from.Split("\")|select -last 1) `
    -PercentComplete 0
try {
    $sw = [System.Diagnostics.Stopwatch]::StartNew();
    [byte[]]$buff = new-object byte[] (4096*1024)
    [long]$total = [long]$count = 0
    do {
        $count = $ffile.Read($buff, 0, $buff.Length)
        $tofile.Write($buff, 0, $count)
        $total += $count
        [int]$pctcomp = ([int]($total/$ffile.Length* 100));
        [int]$secselapsed = [int]($sw.elapsedmilliseconds.ToString())/1000;
        if ( $secselapsed -ne 0 ) {
            [single]$xferrate = (($total/$secselapsed)/1mb);
        } else {
            [single]$xferrate = 0.0
        }
        if ($total % 1mb -eq 0) {
            if($pctcomp -gt 0)`
                {[int]$secsleft = ((($secselapsed/$pctcomp)* 100)-$secselapsed);
                } else {
                [int]$secsleft = 0};
            Write-Progress `
                -Activity ($pctcomp.ToString() + "% Copying file @ " + "{0:n2}" -f $xferrate + " MB/s")`
                -status ($from.Split("\")|select -last 1) `
                -PercentComplete $pctcomp `
                -SecondsRemaining $secsleft;
        }
    } while ($count -gt 0)
$sw.Stop();
$sw.Reset();
}
finally {
    write-host (($from.Split("\")|select -last 1) + `
     " copied in " + $secselapsed + " seconds at " + `
     "{0:n2}" -f [int](($ffile.length/$secselapsed)/1mb) + " MB/s.");
     $ffile.Close();
     $tofile.Close();
    }
}
$InstallFile = "VMware-workstation-full-11.0.0-2305329.exe"
$InstallFrom = Split-Path -Parent $PSCommandPath
$InstallFrom += $InstallFile

copy-file -from $InstallFrom -to "C:\install\$InstallFile"