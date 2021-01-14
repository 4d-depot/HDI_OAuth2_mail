Class constructor
	// OAuth 2.0 client secrets model 
	This:C1470.applicationType:="installed"  // "web" if web application, installed if  "Installed" application
	This:C1470.client_id:=""
	This:C1470.client_secret:=""
	This:C1470.redirect_uri:="http://127.0.0.1:50993/authorize/"  //"urn:ietf:wg:oauth:2.0:oob"
	This:C1470.auth_uri:="https://accounts.google.com/o/oauth2/auth"
	This:C1470.token_uri:="https://accounts.google.com/o/oauth2/token"
	This:C1470.scope:="https://mail.google.com/"
	
	// load the Google client secrets from a json file
Function load($path : Text)
	var $content : Text
	var $secret : Object
	
	If ($path#"")
		$content:=Document to text:C1236($path)
		$secret:=JSON Parse:C1218($content)
		
		This:C1470.client_id:=$secret[This:C1470.applicationType].client_id
		This:C1470.client_secret:=$secret[This:C1470.applicationType].client_secret
	End if 
	
	