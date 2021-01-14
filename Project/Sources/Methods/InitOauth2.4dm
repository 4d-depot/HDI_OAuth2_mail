//%attributes = {}
var $clientSecret : Object

Form:C1466.connectResultSMTP:=""
Form:C1466.connectResultIMAP:=""

Form:C1466.Office_bt:=False:C215
Form:C1466.Gmail_bt:=True:C214
$clientSecret:=cs:C1710.GoogleClientSecrets.new()
$clientSecret.load(Get 4D folder:C485(Current resources folder:K5:16)+"credentials.json")

<>oauth2:=cs:C1710.GoogleWebAuthorizationBroker.new($clientSecret)