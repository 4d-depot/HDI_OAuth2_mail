//%attributes = {}
// Creates a text array with all the attachment names and put them in the golbal variable Attachments
// $1 -> attachment collection

var $1; $attachments : Collection

CLEAR VARIABLE:C89(Attachments)

$attachments:=$1

If ($attachments#Null:C1517)
	COLLECTION TO ARRAY:C1562($attachments; Attachments; "name")
	Attachments:=1
End if 
