$Sessions = 1
$code = ""
$Date = get-date "6/9/2015 11:00:00 am"
$DueDate = get-date "6/16/2015"
$SessionDue = 3
do
{
    $FormatedDate = get-date $Date -format "ddd MMM d @ h:mm tt"
    $FormatedDueDate = get-date $DueDate -format "MMM d"
    $code+= "`t<tr>`n"
    $code+= "`t`t<td>$Sessions</td>`n"
    $code+= "`t`t<td>$Assignments</td>`n"
    $code+= "`t`t<td>Readings</td>`n"
    $code+= "`t`t<td><b>Lecture:</b></td>`n"
    $SessionFormated = $SessionDue.tostring("00")
    $SessionFormated = "(S$SessionFormated)"
    $code+= "`t`t<td><b>All Due:  $FormatedDueDate $SessionFormated</b></td>`n"
    $code+= "`t`t<td>$FormatedDate<br/>in B216 (Main campus)</td>`n"
    $code+= "`t</tr>`n"

    $Sessions++

    if($Sessions % 2 -eq 1)
    {
        $Date = $Date.AddDays(5)
        $DueDate = $DueDate.AddDays(7)
        $SessionDue = $SessionDue + 2
        $Assignments = ""
    }
    elseif($Sessions % 2 -eq 0)
    {
        $Date = $Date.AddDays(2)
        $Assignments = "Nothing Due"
    }

}until($Sessions -eq 17)

$code | clip.exe

write-host $code