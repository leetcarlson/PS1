[xml]$ClassesList = Get-Content -Path e:\test.xml

<#
$ClassesList.class.details.room
$ClassesList.class.details.CourseName
$ClassesList.class.details.CourseNumber
$ClassesList.class.details.CRN
#>

foreach($Class in $Classeslist.class.Sessions.session)
{
    echo $Class.Number
    echo $Class.Start
}