$outlook = new-object -com Outlook.Application

$calendar = $outlook.Session.folders.Item(1).Folders.Item(“Calendar”)

$appt = $calendar.Items.Add(1) # == olAppointmentItem

#$appt | gm

$appt.Start = [datetime]”06/11/2016"
$appt.End = [datetime]”06/11/2016"
$appt.Alldayevent = $True


$appt.Subject = “JobName”

$appt.Location = “ServerName”

$appt.Body = “Job Details”

$appt.Categories = “SQL server Agent Job”

$appt.Save()
