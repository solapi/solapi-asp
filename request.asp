<%response.charset = "utf-8"%>
<!--#include file="index_HMAC.asp" -->
<!--#include file="config.asp" -->
<!--#include file="utils.asp" -->
<%
function RequestAPI(resourcePath, oJSON)

  Dim dateStr, salt, dateSalt, signature
  Dim oXMLHTTP, resultJSON
  dateStr = ToIsoDateTime(Now)
  salt = RandomString()
  dateSalt = dateStr & salt
  signature = generateSHA256(dateSalt, apiSecret)

  Set oXMLHTTP = CreateObject("MSXML2.XMLHTTP.3.0")
  oXMLHTTP.Open "POST", serviceHost & resourcePath, False
  oXMLHTTP.setRequestHeader "Content-Type", "application/json;charset=UTF-8"
  oXMLHTTP.setRequestHeader "Authorization", "HMAC-SHA256 apiKey=" & apiKey & ", date=" & dateStr & ", salt=" & salt & ", signature=" & signature
  oXMLHTTP.Send oJSON.JSONoutput()

  Set resultJSON = New aspJSON

  If oXMLHTTP.Status <> 200 Then
    Response.Write oXMLHTTP.statusText
    Response.Write oXMLHTTP.responseText
  End If

  resultJSON.loadJSON(oXMLHTTP.responseText)

  Set oXMLHTTP = Nothing

  Set RequestAPI = resultJSON

end function

function RequestGET(resourcePath)

  Dim dateStr, salt, dateSalt, signature
  Dim oXMLHTTP, resultJSON
  dateStr = ToIsoDateTime(Now)
  salt = RandomString()
  dateSalt = dateStr & salt
  signature = generateSHA256(dateSalt, apiSecret)

  Set oXMLHTTP = CreateObject("MSXML2.XMLHTTP.3.0")
  oXMLHTTP.Open "GET", serviceHost & resourcePath, False
  oXMLHTTP.setRequestHeader "Content-Type", "application/json;charset=UTF-8"
  oXMLHTTP.setRequestHeader "Authorization", "HMAC-SHA256 apiKey=" & apiKey & ", date=" & dateStr & ", salt=" & salt & ", signature=" & signature
  oXMLHTTP.Send

  Set resultJSON = New aspJSON

  If oXMLHTTP.Status <> 200 Then
    Response.Write oXMLHTTP.statusText
    Response.Write oXMLHTTP.responseText
  End If

  resultJSON.loadJSON(oXMLHTTP.responseText)

  Set oXMLHTTP = Nothing

  Set RequestGET = resultJSON

end function
%>
