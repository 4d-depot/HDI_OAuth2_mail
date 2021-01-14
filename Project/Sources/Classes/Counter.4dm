Class constructor($initValue : Integer)
	
	This:C1470._value:=0
	
	If (Count parameters:C259=1)
		This:C1470._value:=$initValue
	End if 
	
Function value->$result : Integer
	$result:=This:C1470._value
	
Function inc->$result : Integer
	This:C1470._value:=This:C1470._value+1
	$result:=This:C1470._value
	
Function dec->$result : Integer
	This:C1470._value:=This:C1470._value-1
	$result:=This:C1470._value
	