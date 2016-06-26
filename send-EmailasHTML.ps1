# Send email as a HTML body. 
$smtpServer = "SMTP Server Name" 
$MailFrom = "DL or Name of the person from where you need to send email" 
$mailto = "DL or Name of the person where you need to send email" 
$msg = new-object Net.Mail.MailMessage  
$smtp = new-object Net.Mail.SmtpClient($smtpServer)  
$msg.From = $MailFrom 
$msg.IsBodyHTML = $true 
$msg.To.Add($Mailto)  
$msg.Subject = "Report-Test." 
$MailTextT =  Get-Content  -Path C:\temp\Reports\Report.html 
$msg.Body = $MailTextT 
$smtp.Send($msg) 