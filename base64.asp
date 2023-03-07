<%
Function Base64EncodeFromFile(byval sFilename)
  Dim objXMLDoc, objDocElem, objStream, sBase64String

  Set objXMLDoc = Server.CreateObject("MSXML2.DOMDocument")
  objXMLDoc.async = False
  objXMLDoc.validateOnParse = False

  Set objStream = Server.CreateObject("ADODB.Stream")
  objStream.Type = 1
  objStream.Open

  objStream.LoadFromFile Server.MapPath(sFilename)
  if err.Number <> 0 then exit function

  Set objDocElem = objXMLDoc.createElement("A")
  objDocElem.dataType = "bin.base64"
  objDocElem.nodeTypedValue = objStream.Read
  sBase64String = objDocElem.text
  objStream.Close

  Set objStream = Nothing
  Set objDocElem = Nothing
  Set objXMLDoc = Nothing

  Base64EncodeFromFile = sBase64String
End Function
%>
