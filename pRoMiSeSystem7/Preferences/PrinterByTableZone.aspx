<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSBackOfficeReport" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<html>
<head>
<title>Manage Printer For Table Zone</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form id="mainForm" runat="server">
<input type="hidden" id="ZoneID" runat="server" />
<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText"><div class="headerText" align="left" id="HeaderText" runat="server" /></b>
	</td>
	<td width="1" nowrap rowspan="99" bgcolor="003366"><img src="../images/clear.gif" height="1" width="1"></td>
</tr>
<tr bgcolor="666666">
	<td width="3%" height="1"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	<td width="94%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="252"></p></td>
	<td width="3%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	
</tr>
<tr><td height="10" colspan="3">&nbsp;</td></tr>
<tr>
<td>&nbsp;</td>
<td>

<table id="myTable" class="blue" width="100%">
	<thead>
	<tr>
    	<th id="headerTD1" align="center" runat="server"><asp:Label ID="LangText1" Text="ID" runat="server" /></th>
		<th id="headerTD2" align="center" runat="server"><div id="NameText" runat="server"></div></th>
        <th id="headerTD5" align="center" runat="server"><asp:Label ID="LangText3" Text="Device Name" runat="server" /></th>
        <th id="headerTD6" align="center" runat="server"><asp:Label ID="LangText4" Text="Property" runat="server" /></th>
		<th id="headerTD3" align="center" runat="server"><div id="Default_EditText" runat="server"></div></th>
		<th id="headerTD4" align="center" runat="server"><div id="Default_DelText" runat="server"></div></th>
	</tr>
	</thead>
    <tbody>
	<div id="ResultText" runat="server"></div>
	</tbody>
</table>



<div id="errorMsg" runat="server" />
</form>
</td>
<td>&nbsp;</td>
</tr>

<tr><td colspan="3" height="30">&nbsp;</td></tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
<tr>
	<td height="50" colspan="3" background="../images/footerbg2000.gif">&nbsp;</td>
</tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
</table>
<script language="VB" runat="server">
Dim getProp As New CPreferences()
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getInfo As New POSConfiguration()
Dim PageID As Integer = 99

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Manage_Printer") Then
		           
            If IsNumeric(Request.QueryString("ZoneID")) Then
                ZoneID.Value = Request.QueryString("ZoneID")
            Else
                ZoneID.Value = -1
            End If
            
            Dim getPageText As New DefaultText()
		
            Try
                objCnn = getCnn.EstablishConnection()
                'Delete Printer By Zone
                If IsNumeric(Request.QueryString("DelID")) And Request.QueryString("action") = "delete" Then
                    Dim ActionResult As String
                    getInfo.DeletePrinterByTableZone(ZoneID.Value, Request.QueryString("DelID"), objCnn)
                    Response.Redirect("PrinterByTableZone.aspx?ZoneID=" & ZoneID.Value)
                End If
			
                'Additional Language (Use Language in xml)
                Dim dtManageTableLang As DataTable = getProp.GetLangData(1000, 2, -1, Request)
                Dim LangText As String = "lang" + Session("LangID").ToString
                Dim strUseDefault As String
                
                Dim dtTable As DataTable
                dtTable = getInfo.GetPrinterByTableZone(ZoneID.Value, -1, objCnn)
			
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(9, Session("LangID"), objCnn)
			
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
                HeaderText.InnerHtml = BackOfficeReport.GetLanguageText(dtManageTableLang, 3, LangText, "Update Printer For Zone : ") & _
                                                getProp.GetTableZoneName(ZoneID.Value, objCnn)
                NameText.InnerHtml = textTable.Rows(41)("TextParamValue")
                Default_EditText.InnerHtml = defaultTextTable.Rows(0)("TextParamValue")
                Default_DelText.InnerHtml = defaultTextTable.Rows(1)("TextParamValue")
			
                Dim i As Integer
                Dim outputString As String = ""
			
                If Not Request.QueryString("ToLangID") Is Nothing Then
                    If IsNumeric(Request.QueryString("ToLangID")) Then
                        Session("LangID") = Request.QueryString("ToLangID")
                    End If
                End If
                Dim PageName As String = System.IO.Path.GetFileName(Request.ServerVariables("SCRIPT_NAME"))
                Dim LangListText As String = ""
                Dim LangListData As DataTable
                Dim LangData As DataTable = getProp.GetLang(LangListText, LangListData, PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"), PageID, 1, -1, Request, objCnn)
			
                For i = 0 To LangData.Rows.Count - 1
                    Dim TestLabel = Util.FindControlRecursive(mainForm, "LangText" & i)
                    Try
                        TestLabel.Text = LangData.Rows(i)(LangText)
                    Catch ex As Exception
                    End Try
                Next
                'LangList.Text = LangListText
			
                Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
                Dim DelText1 As String = "Are you sure you want to delete"
                Dim DelText2 As String = "?"
                If LangData2.Rows.Count >= 2 Then
                    DelText1 = LangData2.Rows(0)(LangText)
                    DelText2 = LangData2.Rows(1)(LangText)
                End If
                strUseDefault = "--Use Default--"
                For i = 0 To dtTable.Rows.Count - 1
                    outputString += "<tr>"
                    outputString += "<td align=""center"" class=""text"">" & dtTable.Rows(i)("PrinterID").ToString & "</td>"
                    outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("PrinterName") & "</td>"
                    
                    'ZoneID = NULL ---> This Printer does not has data in Table PrinterByTableZone
                    If IsDBNull(dtTable.Rows(i)("ZoneID")) Then
                        outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("PrinterDeviceName") & "</td>"
                        outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("PrinterDeviceNameFor98") & "</td>"
				        If headerTD3.Visible = True Then
                            outputString += "<td align=""center"" class=""text""><a href=""printer_edit.aspx?ZoneID=" & ZoneID.Value & "&PrinterID=" & dtTable.Rows(i)("PrinterID") & """>" & "<img src=""../images/BackOffice/edit.png"" border=""0"" title=""Edit " + dtTable.Rows(i)("PrinterName") & """>" & "</a></td>"
                        End If
                        If headerTD4.Visible = True Then
                            outputString += "<td align=""center"" class=""text"">" & strUseDefault & "</td>"
                        End If
                    Else
                        'Use Data In PrinterByTableZone
                        If IsDBNull(dtTable.Rows(i)("ZonePrinterDeviceName")) Then
                            dtTable.Rows(i)("ZonePrinterDeviceName") = ""
                        End If
                        If IsDBNull(dtTable.Rows(i)("ZonePrinterProperty")) Then
                            dtTable.Rows(i)("ZonePrinterProperty") = ""
                        End If
                        outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("ZonePrinterDeviceName") & "</td>"
                        outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("ZonePrinterProperty") & "</td>"
                        If headerTD3.Visible = True Then
                            outputString += "<td align=""center"" class=""text""><a href=""printer_edit.aspx?ZoneID=" & ZoneID.Value & "&PrinterID=" & dtTable.Rows(i)("PrinterID") & """>" & "<img src=""../images/BackOffice/edit.png"" border=""0"" title=""Edit " + dtTable.Rows(i)("PrinterName") & """>" & "</a></td>"
                        End If
                        If headerTD4.Visible = True Then
                            outputString += "<td align=""center"" class=""text""><a href=""PrinterByTableZone.aspx?ZoneID=" & ZoneID.Value & "&action=delete&DelID=" & dtTable.Rows(i)("PrinterID") & """ onClick=""javascript: return confirm('" & DelText1 & " " & Trim(Replace(dtTable.Rows(i)("PrinterName"), "'", "\'")) & " " & DelText2 & "')"">" & "<img src=""../images/BackOffice/delete.png"" border=""0"" title=""Delete " + dtTable.Rows(i)("PrinterName") & """>" & "</a></td>"
                        End If
                    End If
                    outputString += "</tr>"
                Next
                ResultText.InnerHtml = outputString
			
            Catch ex As Exception
                errorMsg.InnerHtml = ex.Message
            End Try
        Else
            updateMessage.Text = "Access Denied"
        End If
    End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
