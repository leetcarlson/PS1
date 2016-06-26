import-module C:\users\lee\Documents\Scripts\MPTag\mptag.psm1
$MovieDir = "\\backup\vids\VT\"
$MovieFiles = dir $MovieDir -filter "*.mp4"

    #$MovieFile = "C:\users\lee\desktop\movie\Abe_and_the_Amazing_Promise.mp4"

foreach($movieFile in $MovieFiles)
{
    $MovieFileName = get-item $MovieDir$movieFile | select -expand basename

    $MovieName = $MovieFileName -replace "_", "%20"
    $URL = "http://www.omdbapi.com/?t=$MovieName&r=xml"

    write-host "Getting $URL"

    $page = New-Object System.Xml.XmlDocument
    $page.Load("$url")

    if($Page.root.response -eq $true)
    {
        $title = $Page.root.movie.title
        $Year = $Page.root.movie.year
        $Plot = $Page.root.movie.plot
        $Poster = $page.root.movie.poster

        $file =  Get-Item $movieFile
        $media = $file | Get-MediaInfo

        $media.title = $title
        $media.year = $year
        $media.comment = $Plot
        $media.lyrics = $Poster
        $media.save()
    }
    else
    {
        write-host "File Not Found"
    }
}