//%attributes = {}
// Select the object to show to display the body according the type html / text
// if html body shows "web area"
// if text body shows "input"

var $1; $body : Object

$body:=$1

If ($body.type="text/html")
	WA SET PAGE CONTENT:C1037(*; "web area"; $body.message; "file:///")
	OBJECT SET VISIBLE:C603(*; "web area"; True:C214)
	OBJECT SET VISIBLE:C603(*; "input"; False:C215)
Else 
	Form:C1466.textBody:=$body.message
	OBJECT SET VISIBLE:C603(*; "web area"; False:C215)
	OBJECT SET VISIBLE:C603(*; "input"; True:C214)
End if 