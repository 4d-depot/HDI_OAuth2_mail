
C_OBJECT:C1216($status)

If (Bool:C1537(Form:C1466.statusSMTP.success))
	ON ERR CALL:C155("onerr")
	// Send the mail according to the mail information entered in the form
	$status:=Form:C1466.smtp.send(Form:C1466.mailsmtp)
	ON ERR CALL:C155("")
	
	// Verification if send mail is a success or not and display a message
	If ($status.success)
		ALERT:C41("Mail has been sent")
	Else 
		If ($status.status=0)
			ARRAY LONGINT:C221($tcodes; 0)
			ARRAY LONGINT:C221($tcmps; 0)
			ARRAY TEXT:C222($tmess; 0)
			GET LAST ERROR STACK:C1015($tcodes; $tcmps; $tmess)
			ALERT:C41("An error occurred: "+$tmess{1})
		Else 
			ALERT:C41("An error occurred: "+$status.statusText)
		End if 
	End if 
End if 