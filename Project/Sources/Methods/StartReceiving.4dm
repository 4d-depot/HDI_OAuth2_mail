//%attributes = {}
// Start receiving of the mail list according to the number of mail defined by Form.numberMails
var $itemID; ListRef : Integer
var $isSelectable : Boolean

$isSelectable:=True:C214
ARRAY LONGINT:C221($arr; 0)
If (Is a list:C621(ListRef))
	$itemID:=Selected list items:C379(ListRef; $arr; *)
	
	// search the box information of the selected box
	Form:C1466.currentMailbox:=Form:C1466.mailboxes.search($itemID)
	
	If (Form:C1466.currentMailbox#Null:C1517)
		If (Form:C1466.currentMailbox.selectable)
			// select the box as current box on the IMAP server
			Form:C1466.imap.selectBox(Form:C1466.currentMailbox.name)
		Else 
			$isSelectable:=False:C215
		End if 
	Else 
		// select the box as current box on the IMAP server
		Form:C1466.currentMailbox:=Form:C1466.imap.selectBox("inbox")
		
	End if 
	If ($isSelectable)
		// start the downoad of the emails
		Form:C1466.receiveMails:=cs:C1710.EmailDownloading.new(Form:C1466.imap; Form:C1466.numberMails)
		Form:C1466.receiveMails.startTimer()
	Else 
		Form:C1466.receiveMails:=New object:C1471
		Form:C1466.receiveMails.mails:=New collection:C1472
		CLEAR VARIABLE:C89(Attachments)
	End if 
End if 
