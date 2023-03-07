<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include file="../aspJSON1.19.asp" -->
<!--#include file="../messages.asp" -->
<%
Dim fileInfo, fileId, resultJSON

' 이미지 업로드 (200KB 이하 JPG 이미지만 가능)
Set fileInfo = UploadMMSImage("test.jpg")
fileId = fileInfo.data("fileId")

Set oJSON = New aspJSON
With oJSON.data
  .Add "messages", oJSON.Collection()
  With oJSON.data("messages")
    .Add 0, oJSON.Collection()
    With .item(0)
      .Add "to", "01012345678"
      .Add "from", "0212345678"
      .Add "subject", "MMS 제목"
      .Add "text", "MMS 문자 테스트"
      .Add "imageId", fileId ' 이미지ID에 fileId값을 입력
    End With
  End With
End With

Set resultJSON = SendMessages(oJSON)
Response.Write resultJSON.JSONoutput()
%>
