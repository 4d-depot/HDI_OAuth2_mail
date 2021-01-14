
If (Num:C11(Attachments)>0)
	C_TEXT:C284($doc)
	C_BLOB:C604($content)
	
	// Returns the contents of the attachment object in a BLOB
	$content:=Form:C1466.mail.attachments[Attachments-1].getContent()
	
	// Select the folder and file name
	$doc:=Select document:C905(Folder:C1567(fk documents folder:K87:21).file(Form:C1466.mail.attachments[Attachments-1].name).platformPath;"*.*";"Save attachment";File name entry:K24:17)
	
	If (Bool:C1537(OK))
		
		// creation of the document
		BLOB TO DOCUMENT:C526(Document;$content)
		
	End if 
	
End if 