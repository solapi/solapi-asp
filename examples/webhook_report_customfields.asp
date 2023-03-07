<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include file="../aspJSON1.19.asp" -->
<!--#include file="../messages.asp" -->
<%
' 아래와 같은 형식으로 솔라피로부터 웹훅이 호출됩니다.
'[
'  {
'    "messageId": "M4V202212291118233WFNUDAXMX1A001",
'    "groupId": "G4V20221229111823FFGLDPAQEP3FF86",
''    "type": "ATA",
'    "to": "01000000001",
'    "from": "029302266",
'    "statusCode": "4000",
'    "dateProcessed": "2022-12-29T02:18:40.713Z",
'    "dateReported": "2022-12-29T02:18:45.000Z",
'    "dateReceived": "2022-12-29T02:18:44.000Z",
'    "networkCode": "90901",
'    "customFields": {
'      "name": "홍길동"
'    }
'  },
']

' 보안을 위해 솔라피에서 보내온 것이 맞는지 체크한다.
Dim eventName, secret
eventName = Trim(Request.ServerVariables("HTTP_X_SOLAPI_EVENT_NAME"))
secret = Trim(Request.ServerVariables("HTTP_X_SOLAPI_SECRET"))
If eventName <> "SINGLE-REPORT" Then
  Response.End
End If
If StrComp(secret, webhookSecretKey, vbTextCompare) <> 0 Then
  Response.End
End If

If Request.TotalBytes > 0 Then
  Dim lngBytesCount, body
  lngBytesCount = Request.TotalBytes
  body = BytesToStr(Request.BinaryRead(lngBytesCount))

  Dim rJSON
  Set rJSON = New aspJSON
  rJSON.loadJSON(body)

  For Each index In rJSON.data
    Set message = rJSON.data(index)
    ' 알림톡이고 발송실패인 경우
    If message.item("type") = "ATA" And message.item("statusCode") <> "4000" Then
      ' 여기에 리포트 처리 로직 삽입
      Set customFields = message.item("customFields")
      ' Custom Fields 값 가져오기
      Dim key1, key2
      key1 = customFields("key1")
      key2 = customFields("key2")
    End If
  Next
End If

Function BytesToStr(bytes)
    Dim Stream
    Set Stream = Server.CreateObject("ADODB.Stream")
        Stream.Type = 1 'adTypeBinary
        Stream.Open
        Stream.Write bytes
        Stream.Position = 0
        Stream.Type = 2 'adTypeText
        Stream.Charset = "UTF-8"
        BytesToStr = Stream.ReadText
        Stream.Close
    Set Stream = Nothing
End Function
%>
