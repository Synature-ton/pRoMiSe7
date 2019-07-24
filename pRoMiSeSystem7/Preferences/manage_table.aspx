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
<title>Manage Tables</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<ASP:Label id="updateMessage" CssClass="boldtext" runat="server" />
<div id="ShowContent" visible="false" runat="server">
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

<table id="showHeader" cellpadding="2" cellspacing="2" width="100%" runat="server">
<tr>
<td><div id="LinkText" class="text" runat="server"></div></td>

</tr>

</table>

<table width="90%">
<tr><div id="FormAction" runat="server"></div>
	<td align="left"><div id="SelectionText" class="text" runat="server"></div></td></form>
	<td align="right"><div id="showAddText" visible=true runat="server"></div></td>
</tr>
<tr>
<td colspan="2">

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="CodeText" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="NameText" runat="server"></div></td>
        <td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="OrderingText" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Default_EditText" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Default_DelText" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>

</table>
</td></tr></table>


<div id="errorMsg" runat="server" />
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
</div>

<script language="VB" runat="server">
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getInfo As New CCategory()
Dim getPageText As New DefaultText()
Dim getData As New CPreferences()
		
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Manage_Table") Then
            Try
                objCnn = getCnn.EstablishConnection()
                Dim getProp As DataTable
                getProp = getData.PropertyInfo(1, objCnn)
                'If getProp.Rows(0)("SystemTypeID") = 1 Or getProp.Rows(0)("SystemTypeID") = 0 Then
                If 0 = 0 Then
                    headerTD1.BgColor = GlobalParam.AdminBGColor
                    headerTD2.BgColor = GlobalParam.AdminBGColor
                    headerTD3.BgColor = GlobalParam.AdminBGColor
                    headerTD4.BgColor = GlobalParam.AdminBGColor
                    headerTD5.BgColor = GlobalParam.AdminBGColor
                    ShowContent.Visible = True
			
                    Dim textTable As New DataTable()
                    textTable = getPageText.GetText(9, Session("LangID"), objCnn)
			
                    Dim defaultTextTable As New DataTable()
                    defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
                    'Additional Language (Use Language in xml)
                    Dim dtManageTableLang As DataTable = getData.GetLangData(1000, 2, -1, Request)
                    Dim LangText As String = "lang" + Session("LangID").ToString
                    
                    HeaderText.InnerHtml = textTable.Rows(48)("TextParamValue")
                    Default_EditText.InnerHtml = defaultTextTable.Rows(0)("TextParamValue")
                    Default_DelText.InnerHtml = defaultTextTable.Rows(1)("TextParamValue")
                    OrderingText.InnerHtml = "Ordering"
			
                    Dim LinkString As String = ""
                    Dim outputString As String = ""
                    Dim PageSection As Integer = 1
                    Dim i As Integer
                    Dim j As Integer
                    Dim FormSelected As String
                    Dim ShowTableContent As Boolean = True
			
                    Dim IDValue As Integer = -1
                    If IsNumeric(Request.Form("ProductLevelID")) Then
                        IDValue = Request.Form("ProductLevelID")
                    ElseIf IsNumeric(Request.QueryString("ProductLevelID")) Then
                        IDValue = Request.QueryString("ProductLevelID")
                    End If
			
                    Dim GroupIDValue As Integer = -1
                    If IsNumeric(Request.Form("ZoneID")) Then
                        GroupIDValue = Request.Form("ZoneID")
                    ElseIf IsNumeric(Request.QueryString("ZoneID")) Then
                        GroupIDValue = Request.QueryString("ZoneID")
                    End If
			
                    If Not Request.QueryString("EditID") And IsNumeric(Request.QueryString("EditID")) Then
                        If Request.QueryString("EditID") = 1 Then
                            LinkString = "[" + textTable.Rows(49)("TextParamValue") + "]&nbsp;&nbsp;[<a href=""manage_table.aspx?EditID=2" + "&ProductLevelID=" + IDValue.ToString + """>" + textTable.Rows(50)("TextParamValue") + "</a>]"
                        ElseIf Request.QueryString("EditID") = 2 Then
                            LinkString = "[<a href=""manage_table.aspx?EditID=1" + "&ProductLevelID=" + IDValue.ToString + """>" + textTable.Rows(49)("TextParamValue") + "</a>]&nbsp;&nbsp;[" + textTable.Rows(50)("TextParamValue") + "</a>]"
                            PageSection = 2
                        End If
                    Else
                        LinkString = "[" + textTable.Rows(49)("TextParamValue") + "]&nbsp;&nbsp;[<a href=""manage_table.aspx?EditID=2" + "&ProductLevelID=" + IDValue.ToString + """>" + textTable.Rows(50)("TextParamValue") + "</a>]"
                    End If
                    LinkText.InnerHtml = LinkString
			
                    If IsNumeric(Request.QueryString("DelID")) And IsNumeric(Request.QueryString("Type")) Then
                        Dim ResultDel As Boolean = getData.DelTableInfo(Request.QueryString("Type"), Request.QueryString("DelID"), objCnn)
                        If ResultDel = True Then
                            Response.Redirect("manage_table.aspx?EditID=" + PageSection.ToString + "&ProductLevelID=" + IDValue.ToString + "&ZoneID=" + GroupIDValue.ToString)
                        End If
                    End If
					
                    Dim selectionTable As New DataTable()
                    selectionTable = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn) 'getInfo.GetPLevel(-999,1,objCnn)
                    If selectionTable.Rows.Count = 0 Then
                        showAddText.Visible = False
                        SelectionText.InnerHtml = textTable.Rows(19)("TextParamValue")
                    Else
                        If selectionTable.Rows.Count > 1 Then
					
                            Dim SelectString As String = textTable.Rows(53)("TextParamValue")
                            If IDValue = -1 Then
                                FormSelected = " selected"
                            Else
                                FormSelected = ""
                            End If
                            outputString = "<select name=""ProductLevelID"" onchange=""submit()""> <option value=""-1""" + FormSelected + ">" & textTable.Rows(51)("TextParamValue")
                            If IDValue = 0 Then
                                FormSelected = " selected"
                            Else
                                FormSelected = ""
                            End If
                            outputString += "<option value=""0""" + FormSelected + ">" & SelectString
                            For i = 0 To selectionTable.Rows.Count - 1
                                If IDValue = selectionTable.Rows(i)("ProductLevelID") Then
                                    FormSelected = " selected"
                                Else
                                    FormSelected = ""
                                End If
                                outputString += "<option value=""" & selectionTable.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & selectionTable.Rows(i)("ProductLevelName")
                            Next
                            outputString += "</select>"
                        Else
                            IDValue = selectionTable.Rows(0)("ProductLevelID")
                            outputString = selectionTable.Rows(0)("ProductLevelName")
                        End If
				
                    End If
			
                    Dim PropertyInfo As DataTable = getData.PropertyInfo(1, objCnn)
                    If PropertyInfo.Rows(0)("HeadOrBranch") = 1 Then
                        showAddText.Visible = False
                        headerTD3.Visible = False
                        headerTD4.Visible = False
                    End If
                    'Page Section ---> 1 = Display/Edit Zone, 2 = Display/Edit Table
                    If PageSection = 1 Then
                        Dim bolHasPrinterZone As Boolean
                        Dim dtHasPrinterByZone As DataTable
                        dtHasPrinterByZone = getData.PropertyValue(1, 10, IDValue, objCnn)
                        If dtHasPrinterByZone.Rows.Count = 0 Then
                            bolHasPrinterZone = False
                        ElseIf dtHasPrinterByZone.Rows(0)("PropertyValue") = 1 Then
                            bolHasPrinterZone = True
                        End If
			
                        CodeText.InnerHtml = "&nbsp;"
                        NameText.InnerHtml = textTable.Rows(52)("TextParamValue")

                        If bolHasPrinterZone = True Then
                            headerTD5.Visible = True
                            OrderingText.InnerHtml = BackOfficeReport.GetLanguageText(dtManageTableLang, 1, LangText, "Set Zone's Printer")
                        Else
                            headerTD5.Visible = False
                        End If
            	
                        SelectionText.InnerHtml = outputString
				
                        Dim displayTable As New DataTable()
                        displayTable = getData.TableInfo(1, IDValue, 0, 0, objCnn)
					
                        outputString = ""
                        For i = 0 To displayTable.Rows.Count - 1
                            j = i + 1
                            outputString += "<tr><td align=""left"" class=""text"">" & j.ToString & "</td>"
					
                            outputString += "<td align=""left"" class=""text""><a href=""manage_table.aspx?EditID=2&ZoneID=" + displayTable.Rows(i)("ZoneID").ToString + "&ProductLevelID=" + IDValue.ToString + """>" & displayTable.Rows(i)("ZoneName") & "</a></td>"
					
                            'Edit PrinterByZone
                            If bolHasPrinterZone = True Then
                                outputString += "<td align=""center"" class=""text""><a class=""smallText"" href=""JavaScript: newWindow = window.open( 'printerbytablezone.aspx?ZoneID=" & displayTable.Rows(i)("ZoneID") & "', '', 'width=850,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & BackOfficeReport.GetLanguageText(dtManageTableLang, 1, LangText, "Set Printer") & "</a></td>"
                            End If
                            
                            If headerTD3.Visible = True Then
                                outputString += "<td align=""center"" class=""text""><a href=""manage_table_edit.aspx?EditID=1&ZoneID=" & displayTable.Rows(i)("ZoneID") & "&ProductLevelID=" & IDValue.ToString & """>" & defaultTextTable.Rows(0)("TextParamValue") & "</a></td>"
                            End If
					
                            If headerTD4.Visible = True Then
                                outputString += "<td align=""center"" class=""text""><a href=""manage_table.aspx?Type=1&DelID=" & displayTable.Rows(i)("ZoneID") & "&ProductLevelID=" + IDValue.ToString + "&EditID=1" & "&ZoneID=" & displayTable.Rows(i)("ZoneID") & """ onClick=""javascript: return confirm('" & defaultTextTable.Rows(14)("TextParamValue") & " " & Replace(displayTable.Rows(i)("ZoneName"), "'", "\'") & " " & defaultTextTable.Rows(15)("TextParamValue") & "')"">" & defaultTextTable.Rows(1)("TextParamValue") & "</a></td>"
                            End If
	
                            outputString += "</tr>"
                        Next
                        ResultText.InnerHtml = outputString
				
                        showAddText.InnerHtml = "<a href=""manage_table_edit.aspx?EditID=" + PageSection.ToString + "&ProductLevelID=" + IDValue.ToString + """>" + textTable.Rows(54)("TextParamValue") + "</a>"
                        FormAction.InnerHtml = "<form action=""manage_table.aspx"" method=""post"">"
                    ElseIf PageSection = 2 Then
				
                        CodeText.InnerHtml = "&nbsp;"
                        NameText.InnerHtml = textTable.Rows(55)("TextParamValue")
                        headerTD5.Visible = True

				
                        Dim groupTable As New DataTable()
                        groupTable = getData.TableInfo(1, IDValue, 0, 0, objCnn)
				
                        Dim GroupString As String = ""
				
				
                        If groupTable.Rows.Count = 0 Then
                            showAddText.Visible = False
                            SelectionText.InnerHtml = textTable.Rows(56)("TextParamValue")
                        Else
					
                            Dim CheckGroupIDValue As Boolean = False
                            For i = 0 To groupTable.Rows.Count - 1
                                'If GroupIDValue = groupTable.Rows(i)("VendorLevelID") Then
                                If GroupIDValue = groupTable.Rows(i)("ZoneID") Then
                                    FormSelected = "selected"
                                    CheckGroupIDValue = True
                                Else
                                    FormSelected = ""
                                End If
                                GroupString += "<option value=""" & groupTable.Rows(i)("ZoneID") & """ " & FormSelected & ">" & groupTable.Rows(i)("ZoneName")
                                'End If
                            Next
                            If CheckGroupIDValue = False Then GroupIDValue = -1
					
					
					
                            GroupString = "<select name=""ZoneID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" + textTable.Rows(57)("TextParamValue") + GroupString + "</select>"

                            SelectionText.InnerHtml = outputString + "&nbsp;&nbsp;" + GroupString
				
                            FormAction.InnerHtml = "<form action=""manage_table.aspx?EditID=" + PageSection.ToString + """ method=""post"">"
					
                            showAddText.InnerHtml = "<a href=""manage_table_edit1.aspx?EditID=" + PageSection.ToString + "&ZoneID=" + GroupIDValue.ToString + "&ProductLevelID=" & IDValue.ToString + """>" + textTable.Rows(58)("TextParamValue") + "</a>"
					
                            Dim displayTable As New DataTable()
                            displayTable = getData.TableInfo(2, IDValue, GroupIDValue, 0, objCnn)

                            outputString = ""
                            For i = 0 To displayTable.Rows.Count - 1
						
                                j = i + 1
                                outputString += "<tr><td align=""left"" class=""text"">" & j.ToString & "</td>"
						
                                outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("TableName") & "</td>"
						
                                If headerTD5.Visible = True Then
                                    outputString += "<td align=""center"" class=""text"">" & displayTable.Rows(i)("TableNumber").ToString & "</td>"
                                End If
						
                                If headerTD3.Visible = True Then
                                    outputString += "<td align=""center"" class=""text""><a href=""manage_table_edit1.aspx?ZoneID=" & displayTable.Rows(i)("ZoneID").ToString & "&TableID=" + displayTable.Rows(i)("TableID").ToString + "&EditID=2" + "&ProductLevelID=" + IDValue.ToString & """>" & defaultTextTable.Rows(0)("TextParamValue") & "</a></td>"
                                End If
						
                                If headerTD4.Visible = True Then
                                    outputString += "<td align=""center"" class=""text""><a href=""manage_table.aspx?Type=2&EditID=2&DelID=" & displayTable.Rows(i)("TableID").ToString & "&ZoneID=" & GroupIDValue.ToString & "&ProductLevelID=" & IDValue.ToString & """ onClick=""javascript: return confirm('" & defaultTextTable.Rows(14)("TextParamValue") & " " & Replace(displayTable.Rows(i)("TableName"), "'", "\'") & " " & defaultTextTable.Rows(15)("TextParamValue") & "')"">" & defaultTextTable.Rows(1)("TextParamValue") & "</a></td>"
                                End If
							

						
                                outputString += "</tr>"
                            Next
                            ResultText.InnerHtml = outputString
                        End If
                    End If
			
			
		
                Else
                    ShowContent.Visible = False
                    updateMessage.Text = "Your system configuration is not permit to use this page."
                End If
            Catch ex As Exception
                errorMsg.InnerHtml = ex.Message
            End Try
        Else
            ShowContent.Visible = False
            updateMessage.Text = "Access Denied"
        End If
    End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
