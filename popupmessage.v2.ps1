$ErrorMessage = "Please remain calm"
$ErrorDescription = "I am not going to tell you what I found out"
$xaml = @"
<Window xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation'>
 
<Border BorderThickness="50" BorderBrush="Blue" CornerRadius="100" Background='Green'>
 
</Border>

</Window>
"@
 
$reader = [System.XML.XMLReader]::Create([System.IO.StringReader] $xaml)
$window = [System.Windows.Markup.XAMLReader]::Load($reader)
$Window.AllowsTransparency = $True
$window.SizeToContent = 'WidthAndHeight'
$window.ResizeMode = 'NoResize'
$Window.Opacity = .9
$window.Topmost = $true
$window.WindowStartupLocation = 'CenterScreen'
$window.WindowStyle = 'None'
$window.ShowInTaskbar = $true
$window.Cursor = [System.Windows.Input.Cursors]::Arrow

# show message for 5 seconds:
$null = $window.Show()
Start-Sleep -Seconds 5
$window.Close()
