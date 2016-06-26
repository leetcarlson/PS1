import-module C:\users\lee\Documents\Scripts\MPTag\mptag.psm1
$MovieDir = "C:\users\lee\desktop\movie\"
$MovieFiles = dir $MovieDir

foreach ($Moviefile in $MovieFiles)
{

$file =  Get-Item $MovieDir$Moviefile
$media = $file | Get-MediaInfo

$DurationSeconds = $media.properties.duration.totalSeconds
$DurationSeconds = [decimal]::round($DurationSeconds)

$DurationSeconds

$media.lyrics
$media.title
$media.comment
$media.VideoHeight
$media.VideoWidth
}