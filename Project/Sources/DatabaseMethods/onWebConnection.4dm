If ($1#"")
	var $split : Collection
	var $status; $query : Object
	var $i : Integer
	
	$split:=Split string:C1554($1; "/")
	// if the url contains in first element "authorize", it is the server response for authorisation request
	If ($split[1]="authorize")
		$query:=New object:C1471
		ARRAY TEXT:C222($anames; 0)
		ARRAY TEXT:C222($avalues; 0)
		// Read url parameters
		WEB GET VARIABLES:C683($anames; $avalues)
		
		// transform url parameters in object
		For ($i; 1; Size of array:C274($anames))
			$query[$anames{$i}]:=$avalues{$i}
		End for 
		
		$status:=<>oauth2.setAuthorizationCode($query)
		
		CALL FORM:C1391(<>oauth2.windowRef; "ShowTokenBt"; $status.success)
		
		If ($status.success)
			WEB SEND TEXT:C677("<html><head></head><body><h1>Verification code received</h1>You may now close this window.</body></html>")
		Else 
			CALL FORM:C1391(<>oauth2.windowRef; "ShowConnectBt"; $status.success)
			WEB SEND TEXT:C677("<html><head></head><body><h1>Access denied</h1>You may now close this window.<br /><br /><b>Error:</b> "+String:C10($status.error)+"<br /> </body></html>")
		End if 
		
	End if 
End if 


