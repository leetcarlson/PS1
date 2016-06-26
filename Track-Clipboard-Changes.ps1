 $ClipBoardTextOriginal = [System.Windows.Forms.Clipboard]::GetText()
 do{  
    $ClipBoardText = [System.Windows.Forms.Clipboard]::GetText()
    echo $ClipboardText
    Start-Sleep -m 500
    }
    until ($ClipboardText -ne $ClipboardTextOriginal)

    echo "Clipboard changed"