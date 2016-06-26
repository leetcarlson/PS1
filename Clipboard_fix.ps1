$ClipboardText = [System.Windows.Forms.Clipboard]::GetText()

$ClipboardText = $ClipboardText -replace "`r", ";" -replace "`n", "" -replace "; ;", ";"

$ClipboardText | clip

