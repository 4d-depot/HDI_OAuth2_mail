Class constructor($user : Text; $token : Text)
	// Creation of the parameters for IMAP, POP3 and SMTP transporter
	
	// mail address used as user in the transporter
	This:C1470.user:=$user
	// token used to create the connection
	This:C1470.token:=$token
	
Function pop3->$parameters : Object
	$parameters:=New object:C1471
	$parameters.accessTokenOAuth2:=This:C1470.token
	$parameters.authenticationMode:=POP3 authentication OAUTH2:K90:22
	$parameters.user:=This:C1470.user
	$parameters.host:="pop.gmail.com"
	$parameters.port:=995
	
	$parameters.logFile:="pop.log"
	
Function imap->$parameters : Object
	$parameters:=New object:C1471
	$parameters.accessTokenOAuth2:=This:C1470.token
	$parameters.authenticationMode:=IMAP authentication OAUTH2:K90:23
	$parameters.user:=This:C1470.user
	$parameters.host:="imap.gmail.com"
	$parameters.port:=993
	
	$parameters.logFile:="imap.log"
	
Function smtp->$parameters : Object
	$parameters:=New object:C1471
	$parameters.accessTokenOAuth2:=This:C1470.token
	$parameters.authenticationMode:=SMTP authentication OAUTH2:K90:21
	$parameters.user:=This:C1470.user
	$parameters.host:="smtp.gmail.com"
	$parameters.port:=587
	
	$parameters.logFile:="smtp.log"