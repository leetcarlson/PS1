Function Send-InboxtoArchive 
{ 
  <# 
.Synopsis 
    Sends emails from default Inbox to Archive\Inbox Folder

.Description 
    This script moves emails from the default Inbox to Archive\Inbox for archival.
    This will allow us to keep the inbox clear of excess emails but still allow us to save a backlog of emails.
    The parameters set how old the email to be copied is (in minutes)
    This script will NOT copy unread emails.

.Author
    Lee Carlson

.Version
    1.0.0

.Notes
   Many parts of this script were borrowed from  
    NAME:  Get-OutlookInbox 
    AUTHOR: ed wilson, msft

.Parameter
    -age (emails older than this time, in minutes, will be moved to archive)
    -ArchiveID (Outlook FolderID of Archive Email Folder that you wish to copy the messages to)

.Example
Send-InboxtoArchive -ArchiveID "00000000BD48B5E4998BC848963CA6DE3436203582800000" -Age 120

 #>
 param 
(
[Parameter(Mandatory=$true)][Int]$Age,
[Parameter(Mandatory=$true)][string]$ArchiveID
)
 Add-type -assembly "Microsoft.Office.Interop.Outlook" | out-null 
 $olFolders = "Microsoft.Office.Interop.Outlook.olDefaultFolders" -as [type]  
 $outlook = new-object -comobject outlook.application 
 $namespace = $outlook.GetNameSpace("MAPI") 

 $folder = $namespace.getDefaultFolder($olFolders::olFolderInBox) 
 $NewLocation = $namespace.GetDefaultFolder($olFolders::olFolderDrafts)

 $NewLocation = $NewLocation.parent
 
 $Newlocation = $namespace.GetFolderFromID($ArchiveID)

 $FolderItems = $folder.Items

 $Date = Get-date

 foreach ($Message in $FolderItems) #Loops through inbox one item at a time
 {
    if($Message.ReceivedTime -lt $Date.AddMinutes(-$Age) -and $Message.unread -eq $False) #verifies that it is old enough and has been read (Unread = false)
    {
        $Message.move($NewLocation)
#        write-host $Message.CreationTime
    }
 }

}
