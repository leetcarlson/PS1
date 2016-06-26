Function Get-OutlookCalendar
{
  <#
   .Synopsis
    This function returns appointment items from default Outlook profile
   .Description
    This function returns appointment items from default Outlook profile. It
    uses the Outlook interop assembly to use the olFolderCalendar enumeration.
    It creates a custom object consisting of Subject, Start, Duration, Location
    for each appointment item.
   .Example
    Get-OutlookCalendar |
    where-object { $_.start -gt [datetime]"5/10/2011" -AND $_.start -lt `
    [datetime]"5/17/2011" } | sort-object Duration
    Displays subject, start, duration and location for all appointments that
    occur between 5/10/11 and 5/17/11 and sorts by duration of the appointment.
    The sort is shortest appointment on top.
   .Notes
    NAME:  Get-OutlookCalendar
    AUTHOR: ed wilson, msft
    LASTEDIT: 05/10/2011 08:36:42
    KEYWORDS: Microsoft Outlook, Office
    HSG: HSG-05-24-2011
   .Link
     Http://www.ScriptingGuys.com/blog
 #Requires -Version 2.0
 #>

Add-type -assembly "Microsoft.Office.Interop.Outlook" | out-null
$olFolders = "Microsoft.Office.Interop.Outlook.OlDefaultFolders" -as [type]
$outlook = new-object -comobject outlook.application
$namespace = $outlook.GetNameSpace("MAPI")
$folder = $namespace.getDefaultFolder($olFolders::olFolderCalendar)
$CalendarEvents = $folder.items | select-object -property Subject, start, duration, location
return $CalendarEvents
} #end function Get-OutlookCalendar

$today = get-date
$Future = (get-date).adddays(30)

#$today.date
#$Future.Date

$CalendarEvents = Get-OutlookCalendar |
    where-object { $_.start -gt [datetime]$Today.date -AND $_.start -lt `
    [datetime]$Future.date } | sort-object $start

foreach ($Event in $CalendarEvents)
{
echo $Event.start
echo $Event.Duration
echo $Event.Subject
echo `r
}
