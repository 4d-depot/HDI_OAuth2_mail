
var $status : Object

If (Form:C1466.trace)
	TRACE:C157
End if 


If (String:C10(<>oauth2.authorizationCode)#"")
	// ask for the token to the Gmail server
	$status:=<>oauth2.getToken()
	If (Not:C34($status.success))
		ALERT:C41("Error when asking for a token")
	End if 
Else 
	ALERT:C41("You need to be authenticated")
End if 
ShowConnectBt($status.success)