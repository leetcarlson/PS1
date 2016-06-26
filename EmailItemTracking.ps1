Add-Type -assembly "Microsoft.Office.Interop.Outlook"

$Outlook = New-Object -comobject Outlook.Application
$namespace = $Outlook.GetNameSpace("MAPI")
$inbox = $namespace.GetDefaultFolder([Microsoft.Office.Interop.Outlook.OlDefaultFolders]::olFolderInbox)

#$trash = $namespace.GetDefaultFolder([Microsoft.Office.Interop.Outlook.OlDefaultFolders]::olFolderDeletedItems)
#$trash = $namespace.GetDefaultFolder([Microsoft.Office.Interop.Outlook.OlDefaultFolders]::olFolderDrafts)
#$trash = "\\Archive\Inbox"

#$Trash = $inbox.folders.item("Scripts")

write-host $inbox.items.count "Messages in inbox"

#$inbox.items | gm


foreach($Message in $Inbox.items)
{
    write-host "Subject " $Message.Subject
#    write-host "Body " $Message.Body
    write-host "EntryID " $Message.EntryID
    write-host "Sender Name" $Message.SenderName
    write-host "Received Time " $Message.ReceivedTime
    write-host "ConversationID " $Message.ConversationID
    write-host ""
}
