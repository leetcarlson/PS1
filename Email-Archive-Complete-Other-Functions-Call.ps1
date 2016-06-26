. ("B:\AA Git Hub Repo\github.iu.edu\lcadmin\powershell\trunk\get-archiveID.ps1")
. ("B:\AA Git Hub Repo\github.iu.edu\lcadmin\powershell\trunk\InboxArchive.ps1")
. ("B:\AA Git Hub Repo\github.iu.edu\lcadmin\powershell\trunk\add-pst.ps1")

$PSTPath = "B:\archive.pst"

# Check File Size of current PST File
$Size = ((get-item $PSTPath).Length / 1GB)
if($SizeinGB -gt 1.5)  #if the files is too big, we archive it otherwise we let it be
{
    Move-Item $PSTPath "B:\archive.date.pst"
}

add-pst $PSTPath
#Send-InboxtoArchive -ArchiveID $archiveID -Age 120
#remove-pst $PSTPath