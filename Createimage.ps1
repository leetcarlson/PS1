Function Out-PNG {
<#
.Synopisis
Creates a PNG Image File

.Description
Creates a PNG image based on data below

.Dependencies
System.Drawing

.Author
Lee Carlson

.Verson 1.0
#>
param 
(
[Parameter(Mandatory=$true)][int]$Height,
[Parameter(Mandatory=$true)][int]$Width,
[Parameter(Mandatory=$true)][string]$File,
[string]$BgColor = "",
[string]$Message = "",
[string]$MsgColor = "",
[int]$FontSize = 40
)

Add-Type -AssemblyName System.Drawing

$png = new-object System.Drawing.Bitmap $Width,$Height
$font = new-object System.Drawing.Font Arial,$FontSize

$colorl = [System.Drawing.Brushes]::$MsgColor
$backColor = [System.Drawing.Brushes]::$BgColor
$graphics = [System.Drawing.Graphics]::FromImage($png)

$graphics.FillRectangle($backColor,0,0,$png.Width,$png.Height)

$graphics.DrawString($Message,$font,$colorl,350,5)

$graphics.Dispose()
$png.Save($file)
}

$screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
$Width = $screen.width
$Height = $screen.Height

$Width = $Width / 2

$Texts = "Hi There!"
$ImageFile = "C:\Users\lcarlson16\Desktop\this.png"
Out-png -Height $Height -Width $Width -File $ImageFile -Message $Texts -BgColor "Black" -MsgColor "White" -FontSize 40

invoke-item $ImageFile