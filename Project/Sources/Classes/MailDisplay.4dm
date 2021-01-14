Class constructor
	
Function from($mail : Object)->$from : Text
	If ($mail#Null:C1517)
		$from:=This:C1470._emailAddresses($mail.from)
	Else 
		$from:=""
	End if 
	
Function to($mail : Object)->$to : Text
	If ($mail#Null:C1517)
		$to:=This:C1470._emailAddresses($mail.to)
	Else 
		$to:=""
	End if 
	
Function cc($mail : Object)->$cc : Text
	If ($mail#Null:C1517)
		$cc:=This:C1470._emailAddresses($mail.cc)
	Else 
		$cc:=""
	End if 
	
Function _emailAddresses($addresses : Collection)->$result : Text
	// Transform a collection of email address to a string to display it in the UI
	// all the emails are converted as "name <emailAddress>" separated by ","
	// $addresses -> collection of email address object
	// result -> string containing all the addresses as string
	
	var $address : Object
	
	If ($addresses=Null:C1517)
		$result:=""
	Else 
		
		// string construction
		For each ($address; $addresses)
			
			If ($result#"")
				$result:=$result+", "
			End if 
			
			$result:=$result+String:C10($address.name)+" <"+String:C10($address.email)+">"
			
		End for each 
		
	End if 
	
Function subject($mail : Object)->$subject : Text
	If ($mail#Null:C1517)
		$subject:=String:C10(Form:C1466.mail.subject)
	Else 
		$subject:=""
	End if 
	
Function sentDate($mail : Object)->$sentDate : Text
	If ($mail#Null:C1517)
		$sentDate:=String:C10(Date:C102(Form:C1466.mail.sendAt); Date RFC 1123:K1:11; Time:C179(Form:C1466.mail.sendAt))
	Else 
		$sentDate:=""
	End if 
	
Function attachments($mail : Object)->$attachments : Collection
	If ($mail#Null:C1517)
		$attachments:=$mail.attachments
	Else 
		$attachments:=New collection:C1472
	End if 
	
Function body($mail : Object)->$body : Object
	//  Determines the body to display
	//  Search in first if HTML body is present.
	// Else search a Text body
	
	var $message; $type : Text
	If ($mail#Null:C1517)
		// Looking for a HTML body
		$type:="text/html"
		$message:=This:C1470._searchBodyByType($mail; $type)
		
		If ($message="")
			// Looking for a text body
			$type:="text/plain"
			$message:=This:C1470._searchBodyByType($mail; $type)
		End if 
		
		$body:=New object:C1471("message"; $message; "type"; $type)
	Else 
		// if no mail, diplay an empty body
		$body:=New object:C1471("message"; ""; "type"; "text/plain")
	End if 
	
Function _searchBodyByType($email : Object; $type : Text)->$message : Text
	// Search in the bodyStructure if a part with the asked type is present
	// If a part with the good type is present returns the corresponding body present in the boyValues 
	// $email -> email in which to search
	// $type -> type of body 
	// $message -> returns body content if finded, else empty string
	
	var $partId : Text
	var $result : Collection
	
	If ($email.bodyStructure.subParts#Null:C1517)
		
		// look up for all the subparts that contain the type
		$result:=$email.bodyStructure.subParts.query("type=:1"; $type)
		
		If ($result.length>0)
			
			// we take the first subpart with the searched type
			$partId:=String:C10($result[0].partId)
			
		End if 
		
	End if 
	
	If ($partId#"")
		
		$message:=String:C10($email.bodyValues[$partId].value)
		
	End if 
	
	$0:=$message
	