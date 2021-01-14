
var $transporterParam : Object

If (Form:C1466.trace)
	TRACE:C157
End if 


// ask for the token to the Gmail server
If (String:C10(<>oauth2.token.accessToken)#"")
	If (String:C10(Form:C1466.user)#"")
		Form:C1466.mailsmtp.from:=Form:C1466.user
		Form:C1466.connectResultSMTP:=""
		Form:C1466.connectResultIMAP:=""
		
		// Init the transporter parameter object with the token obtained
		$transporterParam:=cs:C1710.GoogleTransporter.new(Form:C1466.user; <>oauth2.token.accessToken)
		
		
		// ********************** SMTP ********************
		
		// Init transporter with token
		Form:C1466.smtp:=SMTP New transporter:C1608($transporterParam.smtp())
		
		Form:C1466.statusSMTP:=Form:C1466.smtp.checkConnection()
		
		If (Form:C1466.statusSMTP.success)
			Form:C1466.connectResultSMTP:="Connected to SMTP server"
		Else 
			ALERT:C41("Access denied to SMTP server")
		End if 
		
		// ********************** IMAP ********************
		
		// Init transporter with token
		Form:C1466.imap:=IMAP New transporter:C1723($transporterParam.imap())
		
		Form:C1466.statusIMAP:=Form:C1466.imap.checkConnection()
		
		If (Form:C1466.statusIMAP.success)
			
			Form:C1466.connectResultIMAP:="Connected to IMAP server"
			
			Form:C1466.mailboxes:=cs:C1710.MailBoxes.new(Form:C1466.imap)
			ListRef:=Form:C1466.mailboxes.createList(Form:C1466.mailboxes.lvlMin)
		Else 
			ALERT:C41("Access denied to IMAP server")
		End if 
	Else 
		ALERT:C41("Please enter a user email address")
	End if 
Else 
	ALERT:C41("No token present")
End if 
