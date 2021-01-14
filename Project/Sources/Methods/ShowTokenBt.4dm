//%attributes = {}
var $1 : Boolean

OBJECT SET ENABLED:C1123(*; "token_bt"; $1)

If (String:C10(<>oauth2.token.accessToken)#"")
	<>oauth2.token.accessToken:=""
End if 
