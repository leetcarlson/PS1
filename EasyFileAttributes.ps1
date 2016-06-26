$path = '\\backup\video\1Temp\Warehouse.13.S05E01.mp4'
$shell = New-Object -COMObject Shell.Application
$folder = Split-Path $path
$file = Split-Path $path -Leaf
$shellfolder = $shell.Namespace($folder)
$shellfile = $shellfolder.ParseName($file)

$attribute = @(0,18,21,27,180,283,284,285,286)

foreach($a in $attribute)
{
    $shellfolder.GetDetailsOf($shellfile, $a)
}