import-module C:\users\lee\Documents\Scripts\MPTag\mptag.psm1
$MovieDir = "C:\users\lee\desktop\movie\"
$MovieFiles = dir $MovieDir -filter "*.mp4"

$XMLFile = "test.xml"
$XMLFile = "$movieDir$XMLFile"

echo $XMLFile

$XMLHeader = "<?xml version=""1.0"" encoding=""UTF-8"" standalone=""yes""?>
<feed>
	<resultLength>40</resultLength>
	<endIndex>40</endIndex>"

$XMLHeader | Out-file $XMLFile

foreach ($Moviefile in $MovieFiles)
{

$file =  Get-Item $MovieDir$Moviefile
$media = $file | Get-MediaInfo

$DurationSeconds = $media.properties.duration.totalSeconds
$Runtime = [decimal]::round($DurationSeconds)

$Image = $media.lyrics
$Title = $media.title
$Synopsis = $media.comment

$MovieXML = "		<item sdImg=""$Image"" hdImg=""$Image"" >
		<title>$Title</title>
		<contentId>10001</contentId>
		<contentType>Video</contentType>
		<contentQuality>HD</contentQuality>
		<streamFormat>mp4</streamFormat>
		<media>
		    <streamQuality>HD</streamQuality>
		    <streamBitrate>1500</streamBitrate>
		    <streamUrl>http://192.168.1.70/vids/temp/Warehouse.13.S05E01.mp4</streamUrl>
		</media>
		<synopsis>$Synopsis</synopsis>
		<genres>Clip</genres>
		<runtime>$Runtime</runtime>
		</item>"
$MovieXML | Out-file $XMLFile -Append
}

$XMLClose = "</feed>"
$XmlClose | Out-file $XMLFile -Append