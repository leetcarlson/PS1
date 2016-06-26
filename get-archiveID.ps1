Function Get-ArchiveID 
{ 
  <# 
.Synopsis 
    Searches the email box for Archive\inbox and then returns the Outlook Folder ID

.Description 
    Searches all folders on the users default outlook profile to find \\archive\inbox.  It then returns the archiveID as
    $ArchiveID

.Author
    Lee Carlson

.Version
    1.0.0

 #>
$outlook = New-Object -ComObject Outlook.Application

$folders = $outlook.Session.Folders.Folders

    foreach($mailfolder in $folders ) {            

#        write-host "Fullfolderpath " $mailfolder.FullFolderPath
#        write-host "FolderName " $mailfolder.Name
#        write-host "ParentFolder " $mailfolder.Parent.FullFolderPath

        if($mailfolder.fullfolderpath -eq "\\Outlook Data File\Inbox")
        {
            $MailFolderID = $mailfolder.EntryID
#            write-host "ID " $MailFolderID
            return $MailFolderID
        }
    }
}
