if(!$global:CommandTranscriptPrompt) {
   ## Record the original prompt so we can put it back if they change their minds...
   $global:CommandTranscriptPrompt = ${Function:Prompt}
}

function Test-CommandTranscript {
#.Synopsis
#  Tests whether or not a current command transcript is in place.
return $global:CommandTranscriptPrompt -ne ${Function:Prompt}
}

function Get-CommandTranscript {
#.Synopsis
#  Returns the current (or most recent) transcript log
#.Example
#  notepad $(Get-CommandTranscript)
[CmdletBinding()]
param()
end {
   if(!(Test-CommandTranscript)) {
      Write-Warning "Not currently logging transcript. Output is last transcript if any."
   }
   if($global:CommandTranscriptPath -and (Test-Path $global:CommandTranscriptPath)) {
      Get-Item -LiteralPath $global:CommandTranscriptPath
   }
}
}

function Start-CommandTranscript {
#.Synopsis
#  Start a transcript recording the commands you enter, and optionally, the success and duration of them
#.Description
#  Each time your prompt is displayed, the previous command is logged to the transcript. 
#  If you specify plain (or ps1) output, the result is basically a PowerShell script containing the commands you enter.
#  If you specify Full (or csv) output, the result is a csv file with start and end times, success, etc.
#  If you specify Annotated (the default) the duration and success of the command are appended as a comment
#.Parameter Output
#  What output format you prefer
#
#  If you specify plain (or ps1) output, the result is basically a PowerShell script containing the commands you enter.
#  If you specify Full (or csv) output, the result is a csv file with start and end times, success, etc.
#  If you specify Annotated (the default) the duration and success of the command are appended as a comment
#.Parameter Append
#  Whether to overwrite the file or append to it.
#.Parameter Path
#  The path to the file to log to
#.Example
#  Start-CommandTranscript "$(Split-Path $Profile)\Session-$(Get-Date -f 'yyyy-mm-dd').ps1" -Output Plain
#
#  Description
#  -----------
#  Logs commands as a script to the profile directory with and output file something like: Session-2010-07-04.ps1
#.Example
#  Start-CommandTranscript "~\Documents\Logs\Session $(Get-Date -f 'yyyy-mm-dd').csv" -Output Full
#
#  Description
#  -----------
#  Logs commands in CSV format to the specified file. Note that you must have a Documents\Logs folder in your $home directory.
[CmdletBinding()]
param(
   [Parameter(Position=0, Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
   [Alias("PSPath","Name")]
   [string]$Path = "CommandTranscript"
,
   [Parameter(Position=1,Mandatory=$false)]
   [ValidateSet("Annotated","Plain","Ps1","Csv","Full")]
   [string]$Output = "Annotated"
,
   [switch]$Append
)
begin {
   if(Test-CommandTranscript) {
      Write-Warning "Already writing a command transcript to $global:CommandTranscriptPath"
      return
   }
}
end {
   switch -regex ($Output) {
      "Csv|Full"  { $extension = $Output = "csv" }
      "Plain|Ps1" { $extension = $Output = "ps1" }
      "Annotated" { $extension = "ps1" }
   }
   
   $global:CommandTranscriptOutput = $Output
   

   if( test-path $path -PathType Container ) {
      $path = Join-Path $path "CommandTranscript.$extension"
   }
#  else ## You can uncomment this block to FORCE the csv/ps1 extension.
#  {
#     $path = [System.Io.Path]::ChangeExtension($path,$extension)
#  }
   
   $global:CommandTranscriptPath = $path

   $Start = "# Command Transcript Started $(Get-Date)"
   
   if(!$Append) {
      switch($CommandTranscriptOutput) {
         "Csv" { 
            $Type, $Header, $Value = Get-History -count 1 | Add-Member -MemberType NoteProperty -Name Success -Value $? -Passthru | ConvertTo-CSV
            Set-Content -LiteralPath $global:CommandTranscriptPath -Value $Type, $Start, $Header
         }
         default {
            Set-Content -LiteralPath $global:CommandTranscriptPath -Value "$Start`n`n"
         }
      }
   } else {
      Add-Content -LiteralPath $global:CommandTranscriptPath -Value "`n`n$Start`n`n"
   }
   
   $global:CommandTranscriptPath = Resolve-Path $global:CommandTranscriptPath
   
   
   ## Insert our transcript prompt
   Function Global:Prompt {
      $last = Get-History -count 1 | Add-Member -MemberType NoteProperty -Name Success -Value $? -Passthru
      
      switch($CommandTranscriptOutput) {
         "ps1" {
            $Value = $last.CommandLine.Trim()
         }
         "csv" { 
            $null, $Value = ConvertTo-CSV -Input $last -NoTypeInformation
         }
         "annotated" {
            $Value = "{0,-75} ## Success: {1}, Execution Time: {2} " -f $last.CommandLine.Trim(), $last.Success, ($last.EndExecutionTime - $last.StartExecutionTime)
         }
      }
      
      Add-Content -LiteralPath $global:CommandTranscriptPath -Value $Value
      return &$global:CommandTranscriptPrompt @args
   }

   Write-Host $Start -Foreground Yellow -Background Black
   Write-Host "Logging commands to $global:CommandTranscriptPath" -Foreground Yellow -Background Black
}
}

function Stop-CommandTranscript {
#.Synopsis 
#  End a transcript session
#.Description
#  Terminates transcription and writes out the file item where logging occurred.
[CmdletBinding()]
param()
end {
   $End = "# Command Transcript Ended $(Get-Date)"
   Add-Content -LiteralPath $global:CommandTranscriptPath -Value "`n`n$End"
   ${Function:Prompt} = $Global:CommandTranscriptPrompt
   
   Write-Host $End -Foreground Yellow -Background Black
   Write-Host "Transcript is at $global:CommandTranscriptPath" -Foreground Yellow -Background Black
   
   Get-Item $global:CommandTranscriptPath
}
}
Start-CommandTranscript "b:\this" -Output Full

$Freespace = 
@{
  Expression = {[int]($_.Freespace/1GB)}
  Name = 'Free Space (GB)'
}

$PercentFree = 
@{
  Expression = {[int]($_.Freespace*100/$_.Size)}
  Name = 'Free (%)'
}
Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType = 3 or DriveType = 4"| Select-Object -Property DriveType, DeviceID, VolumeName, $Freespace, $PercentFree

Stop-CommandTranscript