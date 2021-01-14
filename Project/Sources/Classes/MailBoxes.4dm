Class constructor($transporter : Object)
	
	This:C1470._transporter:=$transporter
	// List of mailboxes returned by the server
	This:C1470._mailboxes:=This:C1470._transporter.getBoxList()
	// delimiter used by the server to separate mailboxe name
	This:C1470._separator:=This:C1470._transporter.getDelimiter()
	// id used to identify a mailbox name in the list
	This:C1470._UID:=cs:C1710.Counter.new()
	
	This:C1470._count:=cs:C1710.Counter.new()
	This:C1470.lvlMin:=1
	
	// Creation of a list to display the mailbox names in a hierarchical list
Function createList($lvl : Integer)->$listRef : Integer
	var $countTmp; $ref : Integer
	var $names : Collection
	
	$listRef:=New list:C375
	
	$names:=Split string:C1554(This:C1470._mailboxes[This:C1470._count.value()].name; This:C1470._separator)
	
	//loop on all the mailboxes
	While (($names.length>=$lvl) & (This:C1470._mailboxes.length>This:C1470._count.value()))
		// test if it is necessary to create a new hierarchy
		If ($names.length>$lvl)
			$countTmp:=This:C1470._count.value()
			$ref:=This:C1470.createList($names.length)
			DELETE FROM LIST:C624(This:C1470._mailboxes[$countTmp-1].listRef; This:C1470._mailboxes[$countTmp-1].listId)
			// create a new hierarchy with the mailbox information 
			APPEND TO LIST:C376($listRef; $names[$names.length-2]; This:C1470._UID.inc(); $ref; False:C215)
			// add utils information in _mailboxes collection for the search
			This:C1470._mailboxes[$countTmp-1].listRef:=$listRef
			This:C1470._mailboxes[$countTmp-1].listId:=This:C1470._UID.value(); 
		Else   // add to the current hierarchy
			// add the mailbox information to the current hierachy
			APPEND TO LIST:C376($listRef; $names[$names.length-1]; This:C1470._UID.inc())
			// add utils information in _mailboxes collection for the search
			This:C1470._mailboxes[This:C1470._count.value()].listRef:=$listRef
			This:C1470._mailboxes[This:C1470._count.value()].listId:=This:C1470._UID.value(); 
		End if 
		
		If (This:C1470._count.inc()<This:C1470._mailboxes.length)
			$names:=Split string:C1554(This:C1470._mailboxes[This:C1470._count.value()].name; This:C1470._separator)
		End if 
		
	End while 
	
	This:C1470._count.dec()
	
	// Search mailbox information according to the hierarchical list Id
Function search($listId : Integer)->$mailbox : Object
	
	var $mailboxes : Collection
	var $0 : Object
	
	// search bi listId in the _mailboxes collection
	$mailboxes:=This:C1470._mailboxes.query("listId=:1"; $listId)
	
	If ($mailboxes.length=0)
		$mailbox:=Null:C1517
	Else 
		$mailbox:=$mailboxes[0]
	End if 