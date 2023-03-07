<%
function RandomString()
    Randomize()

    dim CharacterSetArray
    CharacterSetArray = Array(_
        Array(10, "abcdefghijklmnopqrstuvwxyz"), _
        Array(3, "0123456789") _
    )

    dim i
    dim j
    dim Count
    dim Chars
    dim Index
    dim Temp

    for i = 0 to UBound(CharacterSetArray)

        Count = CharacterSetArray(i)(0)
        Chars = CharacterSetArray(i)(1)

        for j = 1 to Count

            Index = Int(Rnd() * Len(Chars)) + 1
            Temp = Temp & Mid(Chars, Index, 1)

        next

    next

    dim TempCopy

    do until Len(Temp) = 0

        Index = Int(Rnd() * Len(Temp)) + 1
        TempCopy = TempCopy & Mid(Temp, Index, 1)
        Temp = Mid(Temp, 1, Index - 1) & Mid(Temp, Index + 1)

    loop

    RandomString = TempCopy
end function

Public Function ToIsoDateTime(datetime) 
    ToIsoDateTime = ToIsoDate(datetime) & "T" & ToIsoTime(datetime) & "+09:00"
End Function

Public Function ToIsoDate(datetime)
    ToIsoDate = CStr(Year(datetime)) & "-" & StrN2(Month(datetime)) & "-" & StrN2(Day(datetime))
End Function    

Public Function ToIsoTime(datetime) 
    ToIsoTime = StrN2(Hour(datetime)) & ":" & StrN2(Minute(datetime)) & ":" & StrN2(Second(datetime))
End Function

Private Function StrN2(n)
    If Len(CStr(n)) < 2 Then StrN2 = "0" & n Else StrN2 = n
End Function
%>
