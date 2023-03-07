<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include file="../aspJSON1.19.asp" -->
<!--#include file="../messages.asp" -->
<%
Dim oJSON, resultJSON

Set oJSON = New aspJSON
With oJSON.data
  .Add "messages", oJSON.Collection()
  With oJSON.data("messages")
    .Add 0, oJSON.Collection()
    With .item(0)
      .Add "from", "021234567"
      .Add "to", "01012345678" ' 수신번호 입력
      .Add "kakaoOptions", oJSON.Collection()
      With .item("kakaoOptions")
        .Add "pfId", "KA01PF1903260033550428GGGGGGGGab" ' 실제 PFID 값으로 수정
        .Add "templateId", "KA01TP2301260109382045fWJtLZUIab" ' 실제 템플릿ID 값으로 수정
        .Add "disableSms", False ' False: 실패시 문자 대체발송, True: 대체발송 안함
        .Add "variables", oJSON.Collection()
        With .item("variables")
          .Add "#{변수1}", "값1" ' 실제 변수, 값으로 입력
          .Add "#{변수2}", "값2"
        End With
      End With
    End With
  End With
End With

Set resultJSON = SendMessages(oJSON)
Response.Write resultJSON.JSONoutput()

Set oJSON = Nothing
Set resultJSON = Nothing
%>
