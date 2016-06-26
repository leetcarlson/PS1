$DialogFilename = Get-FileName-From-Dialog
#echo $DialogFilename

$Classes = import-csv $DialogFilename

foreach($Class in $Classes)
{
    if($Class -eq 100)
    {
        $Week = $Class.SessionTopic
        $Due = $Class.Due
        $WeekStart = $Class.ClassStart
        $WeekLength = $Class.ClassLength
        $AllDay = $True
    }
    elseif($Class.Session -eq 0)
    {
        $CourseNumber= $Class.CourseNumber
        $CourseName = $Class.CourseName
        $ClassLength = $Class.ClassLength
        $Room = $Class.Room 
    }
    else
    {
        $CourseStart = $Class.ClassStart
        $CourseSession = $Class.Session
        $CourseTopic = $Class.SessionTopic

        $CourseTopic = $CourseTopic -replace ";", "`r"

        $CourseDue = $Class.Due

        $CourseDue = $CourseDue -replace ";", "`r"

        $MeetingDetails = "$CourseNumber Session $CourseSession"
        $MeetingBody = "Lesson:  $CourseTopic `r`nDue:  $CourseDue"
        $AllDay = $False
        
    }
    echo "Adding Calendar Item $MeetingDetails @ $CourseStart"
echo Add-CalendarMeeting -Subject $MeetingDetails -Body $MeetingBody -Location $Room -MeetingStart $CourseStart -MeetingDuration $ClassLength -AllDayEvent $AllDay
}

