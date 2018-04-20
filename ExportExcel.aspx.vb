

Public Class ExportExcel
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Session("ses_Comp_ID") = Nothing Then
            Response.Redirect("Login.aspx")
        End If

        Try

            Dim str_Search As String = Request.QueryString("strSearch")
            Dim str_Status As String = Request.QueryString("Status")
            Dim dt_FromServiceDate As Date = Request.QueryString("fromDate")
            Dim dt_ToServiceDate As Date = Request.QueryString("toDate")

            Me.SqlDS_CargoList.SelectParameters.Clear()
            Me.SqlDS_CargoList.SelectParameters.Add("Comp_ID", Session("ses_Comp_ID"))
            Me.SqlDS_CargoList.SelectParameters.Add("FServiceDate", dt_FromServiceDate)
            Me.SqlDS_CargoList.SelectParameters.Add("TServiceDate", dt_ToServiceDate)
            If str_Search <> Nothing Then Me.SqlDS_CargoList.SelectParameters.Add("StrToSearch", str_Search)
            Me.SqlDS_CargoList.SelectParameters.Add("Export", "Y")
            Me.SqlDS_CargoList.SelectParameters.Add("StatOption", str_Status)

            Me.SqlDS_CargoList.DataBind()
            Me.grdViewCargoList.DataBind()

        Catch ex As Exception

            Err.Clear()
        End Try


    End Sub



    Private Sub btn_ExportCargotoExcel_Click(sender As Object, e As System.EventArgs) Handles btn_ExportCargotoExcel.Click


        Try
            'Response.ClearContent()
            Response.Clear()
            Response.Buffer = True

            Dim strTheDate As String = Replace(Today, "/", "-")
            Dim strName As String = "attachment;filename=" & strTheDate & "_CargoList.csv"

            Response.AddHeader("Content-Disposition", strName)
            Response.ContentType = "text/plain"

            ' Dim strBuilder As New StringBuilder

            'strBuilder.Append("""CTRL_NUM""," & _
            '            """BOX_NUM""," & _
            '            """S_FIRST""," & _
            '            """S_LAST""," & _
            '            """S_ADDRESS""," & _
            '            """S_STATE""," & _
            '            """S_ZIP""," & _
            '            """S_PHONE""," & _
            '            """C_FIRST""," & _
            '            """C_LAST""," & _
            '            """C_ADDRESS""," & _
            '            """C_PROVINCE""," & _
            '            """C_PHONE""," & _
            '            """SERVICE DATE""," & _
            '            """SERVICE CHARGE""," & _
            '            """AGENT CHARGE""," & _
            '            """AGENT CODE""," & Chr(13) + Chr(10))

            Dim sBuilder As StringBuilder = New System.Text.StringBuilder()
            For index As Integer = 0 To grdViewCargoList.Columns.Count - 1
                sBuilder.Append(grdViewCargoList.Columns(index).HeaderText + ","c)
            Next
            sBuilder.Append(vbCr & vbLf)
            For i As Integer = 0 To grdViewCargoList.Rows.Count - 1
                For k As Integer = 0 To grdViewCargoList.HeaderRow.Cells.Count - 1
                    sBuilder.Append(grdViewCargoList.Rows(i).Cells(k).Text.Replace(",", "") & ",")
                Next
                sBuilder.Append(vbCr & vbLf)
            Next
            Response.Output.Write(sBuilder.ToString())
            Response.Flush()
            Response.End()

        Catch ex As Exception
            Err.Clear()
        End Try


    End Sub
End Class