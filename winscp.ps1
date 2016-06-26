try
{
    [Environment]::CurrentDirectory = "C:\Program Files (x86)\WinSCP\" 
    # Load WinSCP .NET assembly
    [Reflection.Assembly]::LoadFrom("WinSCPnet.dll") | Out-Null
 
    # Setup session options
    $sessionOptions = New-Object WinSCP.SessionOptions
    $sessionOptions.Protocol = [WinSCP.Protocol]::Sftp
    $sessionOptions.HostName = "webserve.iu.edu"
    $sessionOptions.UserName = "vaa"
    $sessionOptions.Password = "ride the waves of sand 2013."
    $sessionOptions.SshHostKeyFingerprint = "ssh-rsa 1024 95:79:4b:79:cd:4e:c5:ef:24:33:59:09:70:9e:76:1e"
 
    $session = New-Object WinSCP.Session
 
    try
    {
        # Connect
        $session.Open($sessionOptions)
 
        # Upload files
        $transferOptions = New-Object WinSCP.TransferOptions
        $transferOptions.TransferMode = [WinSCP.TransferMode]::Binary
 
        $transferResult = $session.PutFiles("\\ads\uis\OnBase\Test\Automated\Reports\report.html", "/ip/vaa/wwws/onbase/", $False, $transferOptions)
 
        # Throw on any error
        $transferResult.Check()
 
        # Print results
        foreach ($transfer in $transferResult.Transfers)
        {
            Write-Host ("Upload of {0} succeeded" -f $transfer.FileName)
        }
    }
    finally
    {
        # Disconnect, clean up
        $session.Dispose()
    }
 
    exit 0
}
catch [Exception]
{
    Write-Host $_.Exception.Message
    exit 1
}