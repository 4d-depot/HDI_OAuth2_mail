If (FORM Event:C1606.code=On Selection Change:K2:29)
	If (Bool:C1537(Form:C1466.statusIMAP.success))
		StartReceiving
	End if 
	
End if 