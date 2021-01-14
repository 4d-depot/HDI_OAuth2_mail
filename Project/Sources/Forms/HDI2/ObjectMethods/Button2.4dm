
If (Form:C1466.trace)
	TRACE:C157
End if 

// Memorize the windows for CALL FORM in on Web Connection method
<>oauth2.windowRef:=Current form window:C827

// Open web browser for authentication
OPEN URL:C673(<>oauth2.authorizationCodeURL(); *)

Form:C1466.connectResultSMTP:=""
Form:C1466.connectResultIMAP:=""
