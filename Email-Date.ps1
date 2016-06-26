 Add-type -assembly "Microsoft.Office.Interop.Outlook" | out-null 
 $olFolders = "Microsoft.Office.Interop.Outlook.olDefaultFolders" -as [type]  
 $outlook = new-object -comobject outlook.application 
 $namespace = $outlook.GetNameSpace("MAPI") 

 #$folder = $namespace.getDefaultFolder($olFolders::olFolderInBox) 
 $NewLocation = $namespace.GetDefaultFolder($olFolders::olFolderDrafts)

 $NewLocation = $NewLocation.parent
 
 $Newlocation = $namespace.GetFolderFromID("0000000098EC6E479B68C84FB1458738164B304482800000")

 $FolderItems = $Newlocation.Items

 $Date = Get-date
 
 $FolderItems | sort -Property ReceivedTime | Out-Null

 foreach ($Message in $FolderItems) #Loops through inbox one item at a time
 {
        $FormatedDate = $Message.ReceivedTime.ToShortDateString() -replace '/', ""
        write-host $formatedDate

 }