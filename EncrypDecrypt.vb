

Public Module EncryptDecrypt

    Dim str_Decrypted
    Dim str_Encrypted

    Function Decrypt_Str(ByRef Str_ToDecrypt As String) As String

        'DECRYPT THE PASSWORD HERE

        Dim dblCountLength
        Dim intLengthChar
        Dim strCurrentChar
        Dim dblCurrentChar
        Dim intCountChar
        Dim intRandomSeed
        Dim intBeforeMulti
        Dim intAfterMulti
        Dim intSubNinetyNine
        Dim intInverseAsc
        Dim Decrypt As String = Nothing
        'MainCode:
        '   Store the current value of the mouse pointer
        For dblCountLength = 1 To Len(Str_ToDecrypt)
            intLengthChar = Mid(Str_ToDecrypt, dblCountLength, 1)
            strCurrentChar = Mid(Str_ToDecrypt, dblCountLength + 1, intLengthChar)
            dblCurrentChar = 0
            For intCountChar = 1 To Len(strCurrentChar)
                dblCurrentChar = dblCurrentChar + (Asc(Mid(strCurrentChar, _
                intCountChar, 1)) - 33) * (93 ^ (Len(strCurrentChar) - _
                intCountChar))
            Next
            intRandomSeed = Mid(dblCurrentChar, 3, 2)
            intBeforeMulti = Mid(dblCurrentChar, 1, 2) & Mid(dblCurrentChar, 5, 2)
            intAfterMulti = intBeforeMulti / intRandomSeed
            intSubNinetyNine = intAfterMulti - 99
            intInverseAsc = 256 - intSubNinetyNine
            Decrypt = Decrypt & Chr(intInverseAsc)
            dblCountLength = dblCountLength + intLengthChar
        Next
        Str_ToDecrypt = Decrypt
        Return Nothing

    End Function

    Function Encrypt_Str(ByRef str_ToEncrypt As String)

        Dim dblCountLength
        Dim intRandomNumber
        Dim strCurrentChar
        Dim intAscCurrentChar
        Dim intInverseAsc
        Dim intAddNinetyNine
        Dim dblMultiRandom
        Dim dblWithRandom
        Dim intCountPower
        Dim intPower As Integer
        Dim strConvertToBase
        Dim Encrypt As String = Nothing
        'Constants:
        Const intLowerBounds = 15
        Const intUpperBounds = 28

        'MainCode:

        For dblCountLength = 1 To Len(str_ToEncrypt)
            Randomize()
            intRandomNumber = Int((intUpperBounds - intLowerBounds + 1) * Rnd() + _
            intLowerBounds)
            strCurrentChar = Mid(str_ToEncrypt, dblCountLength, 1)
            intAscCurrentChar = Asc(strCurrentChar)
            intInverseAsc = 256 - intAscCurrentChar
            intAddNinetyNine = intInverseAsc + 99
            dblMultiRandom = intAddNinetyNine * intRandomNumber
            dblWithRandom = Mid(dblMultiRandom, 1, 2) & intRandomNumber & _
            Mid(dblMultiRandom, 3, 2)
            For intCountPower = 0 To 5
                If dblWithRandom / (93 ^ intCountPower) >= 1 Then
                    intPower = intCountPower
                End If
            Next
            strConvertToBase = ""
            For intCountPower = intPower To 0 Step -1
                strConvertToBase = strConvertToBase & _
                    Chr(Int(dblWithRandom / (93 ^ intCountPower)) + 33)
                dblWithRandom = dblWithRandom Mod 93 ^ intCountPower
            Next
            Encrypt = Encrypt & Len(strConvertToBase) & strConvertToBase
        Next

        If InStr(Encrypt, "'") > 0 Then 'if single quote is found
            Encrypt_Str(str_ToEncrypt) ' re encrypt the string
        Else
            str_ToEncrypt = Encrypt
        End If
        Return Nothing

    End Function


End Module