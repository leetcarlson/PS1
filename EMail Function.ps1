Function Send-Email {
<#
.Synopisis
Simple SMTP Emailer to Attach to Scripts

.Description
Sends message text specified to email address sepcified

.Parameter
-EmailTo = Address (or Addresses to Send message to) [REQUIRED]
-EmailTitle = Title of the EMail Message [REQUIRED]
-EMailBody = The Acutal Message being Sent [REQUIRED]
-SMTPServer = SMTP Server to Send Message [Optional]
-EMailFrom = The Address that is sending the message [Optional]
-EMailReplayTo = The reply to address [Optional]

.Dependencies
No Dependencies

.Author
Lee Carlson

.Verson 1.0

.lastupdated
5.29.14
#>
param 
(
[Parameter(Mandatory=$true)][string]$EmailTo,
[Parameter(Mandatory=$true)][string]$EmailTitle,
[Parameter(Mandatory=$true)][string]$EmailBody,
[string]$SMTPServer = "mail-relay.iu.edu",
[string]$EMailFrom = "ips@indiana.edu",
[string]$EMailReplyTo = "no.one@iu.edu"
)

    $msg = new-object Net.Mail.MailMessage
    #Creating SMTP server object
    $smtp = new-object Net.Mail.SmtpClient($smtpServer)

    #Email structure 
    $msg.From = $EMailFrom
    $msg.ReplyTo = $EMailReplyTo
    $msg.To.Add($EmailTo)
    $msg.subject = $EmailTitle
    $msg.body = $EmailBody

    #Sending email 
    $smtp.Send($msg)
}