<#
    .SYNOPSIS   
        Creates a quick "Advanced Calendar" for my classes
         
    .DESCRIPTION   
        This program grabs XML data (from file provided) and generates my advanced schedule.  It also puts in dates for all class 
        automagically. 
        
    .PARAMETER 
        In the progam (today)

    .NOTES   
        Author: Lee T Carlson
        Version: 1.0
            -Generates HTML Schedule Framework
            -Populates dates automatically
            -Auto populates Session number

        Version: 1.1
            -Reads XML files to populate additional HTML data
            -Summer Semester Check Bit
            -Reads Header Data from file
            -Saves Output to a file

#>



$Sessions = 1
$Date = get-date "8/24/2015 11:00:00 am"
#$DueDate = get-date "8/31/2015"
$SessionDue = 2
$MeetingRoom = "in B216 (Main campus)"
$Summer = 0
$HeaderFile = Get-Content "C:\Users\lcarlson16\Documents\scripts\Calendar_Header.html"
$Code = $HeaderFile
[xml]$ClassInfo = Get-Content "C:\Users\lcarlson16\Documents\scripts\class.xml"

foreach($Session in $ClassInfo.sessions)
{
    if(($ClassInfo.sessions.session.readings.assigned) -eq 1) #Are there any assigned readings
    {
        $Readings = "Readings Today"
    }
    else
    {
        $Readings = "No Readings"
    }
}

do
{
    $FormatedDate = get-date $Date -format "ddd MMM d @ h:mm tt"
    $FormatedDueDate = get-date $Date.AddDays(7) -format "MMM d"
    $code+= "`t<tr>"
    $code+= "`t`t<td>$Sessions</td>"
    $code+= "`t`t<td>$Assignments</td>"
    $code+= "`t`t<td>$Readings</td>"
    $code+= "`t`t<td><b>Lecture:</b></td>"
    $SessionFormated = $SessionDue.tostring("00")
    $SessionFormated = "(S$SessionFormated)"
    $code+= "`t`t<td><b>All Due:  $FormatedDueDate $SessionFormated</b></td>"
    $code+= "`t`t<td>$FormatedDate<br/>$MeetingRoom</td>"
    $code+= "`t</tr>"

    $Sessions++

    if($Summer -eq 1) #Check if it is a summer class
    {
        if($Sessions % 2 -eq 1)
        {
            $Date = $Date.AddDays(5)
            $SessionDue = $SessionDue + 2
        }
        elseif($Sessions % 2 -eq 0)
        {
            $Date = $Date.AddDays(2)
            $Assignments = "Nothing Due"
        }
    }
    else
    {
            $Date = $Date.AddDays(7)
            $SessionDue = $SessionDue + 1
    }

}until($Sessions -eq 17)

$Code += "</table>"
$Code += "</html>"

$code | clip.exe

#write-host $code
$code | Out-File "C:\Users\lcarlson16\Documents\scripts\Calendar.test.html"