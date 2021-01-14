Case of 
		
	: (FORM Event:C1606.code=On Load:K2:1)
		
		InitInfo
		
		Init
		
		InitOauth2(1)
		
		InitSMTP
		
	: (FORM Event:C1606.code=On Page Change:K2:54)
		var $position : Integer
		
		If (FORM Get current page:C276=3)
			
			If ((Form:C1466.mails=Null:C1517) & (Form:C1466.imap#Null:C1517))
				Form:C1466.imap.selectBox("INBOX")
				Form:C1466.receiveMails:=cs:C1710.EmailDownloading.new(Form:C1466.imap; Form:C1466.numberMails)
				Form:C1466.receiveMails.startTimer()
				$position:=Find in list:C952(ListRef; "INBOX"; 0)
				If (Bool:C1537($position))
					SELECT LIST ITEMS BY POSITION:C381(ListRef; $position)
				End if 
				
			End if 
		End if 
		
	: (Form event code:C388=On Timer:K2:25)
		If (Form:C1466.trace)
			TRACE:C157
		End if 
		
		Form:C1466.receiveMails.startDownload()
		
		OBJECT SET VISIBLE:C603(*; "Download"; False:C215)
		
End case 


