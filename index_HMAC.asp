<!--#include file="KISA_HMAC.asp" -->
<%
function convertTextToHexString(myString)
  Dim hexString
  hexString = ""
  For i = 1 To Len(myString)
      hexString = hexString & Right("0" & Hex(Asc(Mid(myString, i, 1))), 2)
  Next
  convertTextToHexString = hexString
end function

Function LPad(StringToPad, Length, CharacterToPad)
  Dim x : x = 0
  If Length > Len(StringToPad) Then x = Length - len(StringToPad)
  LPad = String(x, CharacterToPad) & StringToPad
End Function

function generateSHA256(input, key)
	dim i 
	dim result
	dim vinput()
	dim vkey()
	dim inputLen
	dim klen
	dim vmacLen
	dim vmac(31)
  dim mac
  dim inputHex

  inputHex = convertTextToHexString(input)
  keyHex = convertTextToHexString(key)

	inputLen = Len(inputHex)/2
	klen = Len(keyHex)/2
	vmacLen = CInt("1")

	redim vinput(inputLen)
	for i = 0 to inputLen - 1
		vinput(i) = (Cbyte)("&H" & (MID(inputHex,(2*i)+1,2)))
	next
	
	redim vkey(klen)
	for i = 0 to klen - 1
		vkey(i) = (Cbyte)("&H" & (MID(keyHex,(2*i)+1,2)))
	next

	result = KISA_HMAC.HMAC_SHA256(vinput, inputLen, vkey, klen, vmac)
  if result <> 0 then
    Response.Wirte(result & ", Failure!")
    exit function
  end if
	
	for i = 0 to 31
		mac = mac & LPad(CStr(Hex(vmac(i))), 2, "0")
	next

  generateSHA256 = mac
end function
%>
