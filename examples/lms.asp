<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include file="../aspJSON1.19.asp" -->
<!--#include file="../messages.asp" -->
<%
Set oJSON = New aspJSON
With oJSON.data
  .Add "messages", oJSON.Collection()
  With oJSON.data("messages")
    .Add 0, oJSON.Collection()
    With .item(0)
      .Add "to", "01012345678"
      .Add "from", "0212345678"
      .Add "subject", "LMS 제목"
      .Add "text", "LMS 문자 발송 테스트"
    End With
  End With
End With

Dim resultJSON
resultJSON = SendMessages(oJSON)
Response.Write resultJSON.JSONoutput()
%>
