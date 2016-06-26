<#
	.SYNOPSIS
		Just a small Powershell Function to create Outlook Calendar Meeting on the fly.

	.DESCRIPTION
		If you are a Powershell Scripter or Programmer, then most of your time is spent
		On the Powershell Console. I want to write a small function which helps me to
		Create a calendar invites from the Powershell console. So that I can add calendar
		Invites on the fly and add them as reminder

	.PARAMETER  Subject
		Using -Subject parameter please provide the subject of the calendar meeting.

	.PARAMETER  Body
		Using -Body, you can add a more information in to the calendar invite.

	.PARAMETER  Location
		The location of your Meeting, for example can be meeting room1 or any country.

	.PARAMETER  Importance
		By Default the importance is set to 2 which is normal
		You can set to -Importance high by providing 2 as an argument
    	0 = Low
    	1 = Normal
    	2 = High.
    
	.PARAMETER  AllDayEvent
		Include switch to make it All Day Event

    .PARAMETER BusyStatus
        To set your status to Busy, Free Tenative, or out of office, By default it is set to Busy
        0 = Free
        1 = Tentative
        2 = Busy
        3 = Out of Office


	.PARAMETER  MeetingStart
		Provide the Date and time of meeting to start from.

	.PARAMETER  MeetingDuration
		By default meeting duration is set to 30 Minutes. You can change the duration Of the meeting using -MeetingDuration Parameter.
        If AllDayEvent then Duration is in Days

	.PARAMETER  Reminder
		If no reminder time is set, then there will not be a reminder
         You can use -Reminder to set the reminder duration. The value is in Minutes.'

    .Last Updated
        6/11/16

    .Version
        1.1

    .ChangeLog
        Changed -AllDayEvent parameter to Switch
        Removed -EventReminder Status

	.EXAMPLE
		PS C:\>Add-CalendarMeeting -Subject "Powershell" -Body "Show how to use Powershell with Outlook" -Location "Conf Room 1" -AllDayEvent
		
	.EXAMPLE
		PS C:\>Add-CalendarMeeting -Subject "Powershell" -Body "Show how to use Powershell with Outlook" -Location "Conf Room 1" -MeetingStart "08/08/2013 22:30" -Reminder 30 
	

	.EXAMPLE
		PS C:\>Add-CalendarMeeting -Subject "Powershell" -Body "Show how to use Powershell with Outlook" -Location "Conf Room 1" -Importance 2 

    .Credits
        Based on script created by Aman Dhally (amandally@gmail.com)
        Forked by Lee T Carlson

	.LINK
		www.amandhally.net

#>

function Add-CalendarMeeting {

param (

[cmdletBinding()]

	# Subject Parameter	
    [Parameter(
        Mandatory = $True,
        HelpMessage="Please provide a subject of your calendar.")]
    [string] $Subject,

	#Body parameter
    [Parameter(
        Mandatory = $False)]
    [string] $Body,

	#Location Parameter
    [Parameter(
        Mandatory = $True,
        HelpMessage="Please provide the location of your meeting.")]
    [string] $Location,

	# Importance Parameter
	[int] $Importance = 1,

	# All Day event Parameter
	[Switch] $AllDayEvent,

	# Busy Status Parameter
	[string] $BusyStatus = 2,

	# Metting Start Time Parameter
	[datetime] $MeetingStart =(Get-Date),

	# Meeting time duration parameter
	[int] $MeetingDuration = 30, 

	# by Default Reminder Duration
	[int] $Reminder

)

BEGIN { 
        
        Write-Verbose " Creating Outlook as an Object"
        
        # Create a new appointments using Powershell
        $outlookApplication = New-Object -ComObject 'Outlook.Application'
        # Creating a instatance of Calenders
        $newCalenderItem = $outlookApplication.CreateItem('olAppointmentItem')
      }


PROCESS { 

        if($Reminder -gt 0)
        {
            $EnableReminder = $true
        }
        else
        {
            $EnableReminder = $False
        }
         Write-Verbose "Creating Calender Invite"
    
         $newCalenderItem.AllDayEvent = $AllDayEvent
         $newCalenderItem.Subject = $Subject
         $newCalenderItem.Body = $Body
         $newCalenderItem.Location  = $Location
         $newCalenderItem.ReminderSet = $EnableReminder
         $newCalenderItem.Importance = $importance


         if ( ! ($AllDayEvent)) {

         $newCalenderItem.Start = $MeetingStart
         $newCalenderItem.Duration = $MeetingDuration
         
         }
         else
         {
            $newCalenderItem.Start = $MeetingStart
            $MeetingDuration = $MeetingDuration * (60*24)
            $newCalenderItem.Duration = $MeetingDuration
         }
         
         $newCalenderItem.ReminderMinutesBeforeStart = $Reminder
         # 2 is busy, 3 is out of office
         $newCalenderItem.BusyStatus = $BusyStatus
             
    }

END {
    
        Write-Verbose "Saving Calender Item"
        $newCalenderItem.Save()
      
        # if you want to see the calener invite un-comment the below line
            #un-comment it ==>  $newCalenderItem.Display($True)

      }

	}

### end of the script


Add-CalendarMeeting -Subject "Powershell" -Body "PS" -Location "Rm1" -MeetingStart 6/11/16 -MeetingDuration 7 -AllDayEvent