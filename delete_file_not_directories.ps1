$ObStaging = dir '\\dtt.iu.edu\BRTE$\OB\Staging'

$ObStaging | Get-Member

foreach($file in $ObStaging)
{
   #remove-item $file.fullname -Force
   write-host $file.fullname " Deleted"
}
