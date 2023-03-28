<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include file="../aspJSON1.19.asp" -->
<!--#include file="../request.asp" -->
<%
Dim resultJSON

Set resultJSON = RequestGET("/cash/v1/balance")
Response.Write "잔액: " & resultJSON.data.item("balance")
Response.Write "포인트: " & resultJSON.data.item("point")

Set resultJSON = Nothing
%>
