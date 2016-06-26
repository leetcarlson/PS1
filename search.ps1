$SearchTerm = "*iu-uits-tls*"
$SearchDir = "C:\Users\lcarlson\Documents\Scratch\E Train\wwwroot"
$Directory = Get-ChildItem $SearchDir -Recurse

foreach($file in $Directory)
{
    try
    {
        $FileData = get-content $file.FullName
        $lineno = 0
        foreach($line in $fileData)
        {
            $lineno++
        
            if($line -contains $SearchTerm)
            {
                write-host "Found $SearchTerm " $file.fullname " at $lineno "
            }
        }
    }
    catch
    {
    }

}