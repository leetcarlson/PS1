function Wait-KeyPress($prompt='Press a key!') {
	Write-Host $prompt 
	
	do {
		Start-Sleep -milliseconds 100
	} until ($Host.UI.RawUI.KeyAvailable)

	$Host.UI.RawUI.FlushInputBuffer()
}

Wait-KeyPress
