
If (FORM Event:C1606.code=On Clicked:K2:4)
	If (Bool:C1537(Form:C1466.statusIMAP.success))
		StartReceiving
	End if 
End if 