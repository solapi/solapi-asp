<%@Language="VBScript" CODEPAGE="65001" %>
<!--#include file="../aspJSON1.19.asp" -->
<!--#include file="../messages.asp" -->
<%
Dim toField, from, limit, startKey, startDate, endDate
toField = Request.QueryString("to")
from = Request.QueryString("from")
limit = Request.QueryString("limit")
startDate = Request.QueryString("startDate")
endDate = Request.QueryString("endDate")
startKey = Request.QueryString("startKey")

If IsEmpty(limit) Then
  limit = 20
End If
%>

<form>
<table>
<tr>
  <td>생성일</td><td>수신번호</td> <td>발신번호</td><td>내용</td>
</tr>
<%
Dim resultJSON, queryString

queryString = "?limit=" & limit

If IsEmpty(startKey) = False And startKey <> "" Then
  queryString = queryString & "&startKey=" & startKey
End If
If IsEmpty(toField) = False And toField <> "" Then
  queryString = queryString & "&to=" & toField
End If
If IsEmpty(from) = False And from <> "" Then
  queryString = queryString & "&from=" & from
End If
If Not IsEmpty(startDate) And startDate <> "" Then
  queryString = queryString & "&startDate=" & Server.URLEncode(startDate)
End If
If Not IsEmpty(endDate) And endDate <> "" Then
  queryString = queryString & "&endDate=" & Server.URLEncode(endDate)
End If

Set resultJSON = ListMessages(queryString)

For Each messageId In resultJSON.data("messageList")
  Set message = resultJSON.data("messageList").item(messageId)

  ' ISO8601 -> 한국시간으로 변경
  Dim isoDate, datetime, localdatetime
  isoDate = message.item("dateCreated")
  datetime = CDate(Left(isoDate, 10) & " " & Mid(isoDate, 12, 8))
  datetime = DateAdd("h", 9, datetime)
  localdatetime =  FormatDateTime(datetime, vbGeneralDate)

  Response.Write "<tr>"
  Response.Write "<td>" & localdatetime & "</td>"
  Response.Write "<td>" & message.item("to") & "</td>"
  Response.Write "<td>" & message.item("from") & "</td>"
  Response.Write "<td>" & message.item("text") & "</td>"
  Response.Write "</tr>"
Next

dim nextKey
nextKey = resultJSON.data("nextKey")

' 전체 출력
' Response.Write resultJSON.JSONoutput()

Set resultJSON = Nothing
%>
<div>
  <label for="to">수신번호</label>
  <input name="to" type="text" value="<%=toField%>" placeholder="010123456789" />
</div>
<div>
  <label for="from">발신번호</label>
  <input name="from" type="text" value="<%=from%>" placeholder="0212345678" />
</div>
<div>
  <label for="limit">출력개수</label>
  <input name="limit" type="text" value="<%=limit%>" />
</div>
<div>
  <label for="startDate">시작일시</label>
  <input name="startDate" type="text" value="<%=startDate%>" />
</div>
<div>
  <label for="endDate">종료일시</label>
  <input name="endDate" type="text" value="<%=endDate%>" />
</div>


<input name="startKey" type="hidden" value="" />
<input type="submit" value="조회" />
<input type="button" value="다음 페이지" onClick="this.form.startKey.value = '<%=nextKey%>'; this.form.submit();" />
</table>
</form>
