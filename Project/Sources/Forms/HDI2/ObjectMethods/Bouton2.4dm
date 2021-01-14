C_TEXT:C284($doc)

$doc:=Select document:C905(""; "*"; "Select an attachment"; Use sheet window:K24:11)
If (Bool:C1537(ok))
	// create new attachment
	Form:C1466.mailsmtp.attachments:=New collection:C1472(MAIL New attachment:C1644(document))
	Form:C1466.attachmentsmtp:=document
Else 
	// remove attachment
	Form:C1466.mailsmtp.attachments:=Null:C1517
	Form:C1466.attachmentsmtp:=""
End if 