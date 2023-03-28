<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include file="../aspJSON1.19.asp" -->
<!--#include file="../request.asp" -->
<%
Dim resultJSON

Set resultJSON = RequestGET("/exclusive-account/v1/accounts")
If resultJSON.data.item("accountNumber") Then
  Response.Write "은행명: " & resultJSON.data.item("bankName")
  Response.Write "계좌번호: " & resultJSON.data.item("accountNumber")
Else
  Response.Write "발급된 계좌가 없습니다."
End If

Set resultJSON = Nothing
%>
