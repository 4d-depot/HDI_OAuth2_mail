Class constructor($clientSecret : Object)
	
	// client secret used for authorization and token request
	This:C1470.clientSecret:=$clientSecret
	This:C1470.authorizationCode:=""
	This:C1470.token:=New object:C1471
	This:C1470.token.accessToken:=""
	This:C1470.token.expiresInSecond:=0
	This:C1470.token.refreshToken:=""
	This:C1470.token.scope:=""
	This:C1470.token.tokenType:=""
	This:C1470.token.Issued:=Current time:C178
	
	// ************************* Authorization *************************
	
	// Creation of the url needed for authorization request
Function authorizationCodeURL->$url : Text
	// create the request from the client secrets
	$url:=This:C1470.clientSecret.auth_uri+\
		"?access_type=offline"+\
		"&scope="+This:C1470.urlEscape(This:C1470.clientSecret.scope)+\
		"&client_id="+This:C1470.clientSecret.client_id+\
		"&response_type=code"+\
		"&redirect_uri="+This:C1470.urlEscape(This:C1470.clientSecret.redirect_uri)
	
	// Read the answer returned by google and extract the authorization code
Function setAuthorizationCode($query : Object)->$status : Object
	
	If ($query.code#Null:C1517)
		This:C1470.authorizationCode:=$query.code
		$status:=New object:C1471("success"; True:C214)
	Else 
		$status:=New object:C1471("success"; False:C215)
		$status.error:=String:C10($query.error)
	End if 
	
	// ************************* Token *************************
	
	// Request the token using the authorization code
Function getToken->$status : Object
	var $params : Text
	var $request : Blob
	var $response : Object
	var $result : Integer
	
	$params:="code="+String:C10(This:C1470.authorizationCode)+\
		"&client_id="+This:C1470.clientSecret.client_id+\
		"&client_secret="+This:C1470.clientSecret.client_secret+\
		"&grant_type=authorization_code"+\
		"&redirect_uri="+This:C1470.urlEscape(This:C1470.clientSecret.redirect_uri)
	
	CONVERT FROM TEXT:C1011($params; "utf-8"; $request)
	
	ARRAY TEXT:C222($headerNames; 1)
	ARRAY TEXT:C222($headerValues; 1)
	
	$headerNames{1}:="Content-Type"
	$headerValues{1}:="application/x-www-form-urlencoded"
	
	// send the http request for token
	$result:=HTTP Request:C1158(HTTP POST method:K71:2; This:C1470.clientSecret.token_uri; $request; $response; $headerNames; $headerValues)
	
	If ($result=200)
		// if result ok, creation of a token object with all the useful information
		This:C1470.token.Issued:=Current time:C178
		This:C1470.token.expiresInSecond:=$response.expires_in
		This:C1470.token.accessToken:=$response.access_token
		This:C1470.token.refreshToken:=$response.refresh_token
		This:C1470.token.tokenType:=$response.token_type
		This:C1470.token.scope:=$response.scope
		
		$status:=New object:C1471("success"; True:C214)
	Else 
		// if result not ok, create a status object with error elements
		$status:=New object:C1471("success"; False:C215)
		$status.error:=$result
		$status.errorDetails:=$response
		
	End if 
	
	// Escape special caracters in url
Function urlEscape($value : Text)->$escaped : Text
	
	var $i; $j; $code : Integer
	var $shouldEscape : Boolean
	var $data : Blob
	var $char; $hex : Text
	
	If ($value="urn:ietf:wg:oauth:2.0:oob")
		
		$escaped:=$value
		
	Else 
		
		For ($i; 1; Length:C16($value))
			
			$char:=Substring:C12($value; $i; 1)
			$code:=Character code:C91($char)
			
			$shouldEscape:=False:C215
			
			Case of 
				: ($code=45)
				: ($code=46)
				: ($code>47) & ($code<58)
				: ($code>63) & ($code<91)
				: ($code=95)
				: ($code>96) & ($code<123)
				: ($code=126)
				Else 
					$shouldEscape:=True:C214
			End case 
			
			If ($shouldEscape)
				CONVERT FROM TEXT:C1011($char; "utf-8"; $data)
				For ($j; 0; BLOB size:C605($data)-1)
					$hex:=String:C10($data{$j}; "&x")
					$escaped:=$escaped+"%"+Substring:C12($hex; Length:C16($hex)-1)
				End for 
			Else 
				$escaped:=$escaped+$char
			End if 
			
		End for 
	End if 