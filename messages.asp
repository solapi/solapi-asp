<!--#include file="base64.asp" -->
<!--#include file="request.asp" -->
<%
' 메시지 발송
function SendMessages(oJSON)

  Set SendMessages = RequestAPI("/messages/v4/send-many/detail", oJSON)

end function

' MMS 이미지 파일 업로드
function UploadMMSImage(fileName)

  Dim imageContent, resultJSON
  imageContent = Base64EncodeFromFile(fileName)

  Set oJSON = New aspJSON
  With oJSON.data
    .Add "type", "MMS"
    .Add "file", imageContent
  End With

  Set resultJSON = RequestAPI("/storage/v1/files", oJSON)
  Set UploadMMSImage = resultJSON

end function

' 메시지 목록 조회
' to, from, type, statusCode, startDate, endDate, messageId, groupId
function ListMessages(queryString)

  Set ListMessages = RequestGET("/messages/v4/list" & queryString)

end function
%>
