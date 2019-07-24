<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<html>
<head>
<title>Manage Shop Data</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

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

<table cellpadding="2" cellspacing="2" width="100%">
<tr id="ShowAddText" visible="false" runat="Server">
<td><a href="../Inventory/inv_category_edit.aspx"><div id="AddText" runat="server"></div></a></td>
</tr></table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server">ID</td>
        <td id="headerTD13" align="center" class="tdHeader" runat="server">License</td>
        <td id="headerTD10" align="center" class="tdHeader" runat="server">Shop Code</td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="NameText" runat="server"></div></td>
        <td id="headerTD11" align="center" class="tdHeader" runat="server">Master Shop</td>
        <td id="headerTD12" align="center" class="tdHeader" runat="server"><span id="ExtData" runat="server" /></td>
		<td id="headerTD9" align="center" class="tdHeader" runat="server"><div id="StockCardAtFrontText" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="DocSetUpText" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="InvViewText" runat="server"></div></td>
		<td id="headerTD8" align="center" class="tdHeader" runat="server"><div id="InvViewTransferText" runat="server"></div></td>
		<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="SaveAsText" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Default_EditText" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Default_DelText" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>

</table>

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
<script language="VB" runat="server">
Dim getProp As New CPreferences()
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getInfo As New CCategory()
Dim objDB As New CDBUtil()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Inv_Inventory_Category") Then
		
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD7.BgColor = GlobalParam.AdminBGColor
		headerTD8.BgColor = GlobalParam.AdminBGColor
		headerTD9.BgColor = GlobalParam.AdminBGColor
		headerTD10.BgColor = GlobalParam.AdminBGColor
		headerTD11.BgColor = GlobalParam.AdminBGColor
		headerTD12.BgColor = GlobalParam.AdminBGColor
		headerTD13.BgColor = GlobalParam.AdminBGColor
		Dim getPageText As New DefaultText()

		Try
			objCnn = getCnn.EstablishConnection()
			headerTD4.Visible = False
			headerTD7.Visible = False
			headerTD9.Visible = False
			headerTD11.Visible = False
			headerTD12.Visible = False
			
			headerTD13.Visible = getInfo.CheckShopLicense(objCnn)
			
			Dim foundRows() As DataRow
            Dim expression As String
			Dim LicData As DataTable
			
			If headerTD13.Visible = True Then
				LicData = getInfo.GetShopLicense(objCnn)
			End If
			
			Dim shopInfo As New DataTable()
			shopInfo = getInfo.GetProductLevel(-999,objCnn)
			
			If shopInfo.Rows.Count = 1 Then
				headerTD5.Visible = False
			End If
			
			Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
			If PropertyInfo.Rows(0)("SystemEditionID") = 1 Then
				headerTD5.Visible = False
				headerTD8.Visible = False
				headerTD7.Visible = False
			End If
			
			headerTD11.Visible = False
			If PropertyInfo.Rows(0)("MultiBranch") = 1 Then
				headerTD11.Visible = True
				headerTD12.Visible = True
			End If
			
			If Session("StaffID") = 1 AND PropertyInfo.Rows(0)("SystemEditionID") > 1 Then 
				headerTD4.Visible = True
				headerTD7.Visible = True
				ShowAddText.Visible = True
			End If
			
			If PropertyInfo.Rows(0)("HeadOrBranch") = 1 Then
				headerTD3.Visible = False
				headerTD4.Visible = False
				headerTD7.Visible = False
				ShowAddText.Visible = False
			End If
			
			headerTD8.Visible = False

        	Dim dtTable As New DataTable()
        	dtTable = getInfo.GetProductLevel(-1,objCnn)'getInfo.FirstLevel("ProductLevel","ProductLevelID",-1,"ProductLevelOrder,ProductLevelName",objCnn)	
			
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(7,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			HeaderText.InnerHtml = "Manage Shop Data"'textTable.Rows(0)("TextParamValue")
			AddText.InnerHtml = "Add New Shop"'textTable.Rows(1)("TextParamValue")
			NameText.InnerHtml = textTable.Rows(2)("TextParamValue")
			InvViewText.InnerHtml = "Set up Inventory View"
			DocSetUpText.InnerHtml = "Document Header"
			Default_EditText.InnerHtml = defaultTextTable.Rows(0)("TextParamValue")
			Default_DelText.InnerHtml = defaultTextTable.Rows(1)("TextParamValue")
			SaveAsText.InnerHtml = "Save As"
			InvViewTransferText.InnerHtml = "Transfer Inventory"
			StockCardAtFrontText.InnerHtml = "Set Stock Card"
			
			Dim i As integer
			Dim outputString As String = ""
			Dim ShopLink As DataTable
			Dim ShowExtra As Boolean 
			
			Dim ChkTable As DataTable = objDB.List("show tables like 'ShopExtData'", objCnn)
			Dim ShopData As DataTable
			If ChkTable.Rows.Count > 0 Then
				ShopData = objDB.List("select * from ShopExtData", objCnn)
			End If

                ExtData.InnerHtml = "Extra Data"
                Dim ShowMapping As Integer = 0
                Dim strLink, strExtraDataLink As String
                Dim ChkMapping As DataTable = getCnn.List("select * from programpropertyvalue where ProgramTypeID=8 AND PropertyID=1 AND KeyID=1", objCnn)
                strExtraDataLink = ""
                If ChkMapping.Rows.Count > 0 Then
                    If ChkMapping.Rows(0)("PropertyValue") > 0 Then
                        ShowMapping = ChkMapping.Rows(0)("PropertyValue")
                        Select Case ShowMapping
                            Case 1              'For Ootoya
                                ExtData.InnerHtml = "ERP Mapping Data"
                            Case 99             'Always Show extra data
                                headerTD12.Visible = True
                            Case Is > 1         'Extra Data Only For MultiBranch
                                
                        End Select
                    End If
                    If IsDBNull(ChkMapping.Rows(0)("PropertyTextValue")) Then
                        ChkMapping.Rows(0)("PropertyTextValue") = ""
                    End If
                    strExtraDataLink = ChkMapping.Rows(0)("PropertyTextValue")
                End If
                Dim ShortName As String
                Dim StatusImage As String

                For i = 0 To dtTable.Rows.Count - 1
                    If (PropertyInfo.Rows(0)("SystemEditionID") = 1 And dtTable.Rows(i)("ProductLevelID") > 1) Or PropertyInfo.Rows(0)("SystemEditionID") <> 1 Then
                        ShowExtra = False
                        outputString += "<tr><td align=""center"" class=""text"">" & dtTable.Rows(i)("ProductLevelID").ToString & "</td>"
                        If headerTD13.Visible = True Then
                            StatusImage = "../images/crossbl.gif"
                            expression = "ShopID=" + dtTable.Rows(i)("ProductLevelID").ToString
                            foundRows = LicData.Select(expression)
                            If foundRows.GetUpperBound(0) >= 0 Then
                                If foundRows(0)("LicenseStatus") = 1 Then
                                    StatusImage = "../images/checkbl.gif"
                                End If
                            End If
                            outputString += "<td align=""center"" class=""text"">" & "<img border=""0"" src=""" & StatusImage & """>" & "</td>"
                        End If
                        outputString += "<td align=""center"" class=""text"">" & dtTable.Rows(i)("ProductLevelCode").ToString & "</td>"
                        outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("ProductLevelName") & "</td>"
                        If headerTD11.Visible = True Then
                            ShopLink = objDB.List("select * from ProductLevel where MasterShop>0 AND MasterShop=" + dtTable.Rows(i)("MasterShopLink").ToString, objCnn)
                            If ShopLink.Rows.Count > 0 Then
                                If Not IsDBNull(ShopLink.Rows(0)("ProductLevelName")) Then
                                    outputString += "<td align=""left"" class=""text"">" & ShopLink.Rows(0)("ProductLevelName") & "</td>"
                                    ShowExtra = True
                                Else
                                    outputString += "<td align=""left"" class=""text"">" & "-" & "</td>"
                                End If
                            Else
                                outputString += "<td align=""left"" class=""text"">" & "" & "</td>"
                            End If
                        End If
                        If headerTD12.Visible = True Then
                            If ShowMapping = 1 Then
                                ShortName = ""
                                If ChkTable.Rows.Count > 0 Then
                                    expression = "ShopID=" + dtTable.Rows(i)("ProductLevelID").ToString
                                    foundRows = ShopData.Select(expression)
                                    If foundRows.GetUpperBound(0) >= 0 Then
                                        If Not IsDBNull(foundRows(0)("ShopCodeAbb")) Then
                                            ShortName = foundRows(0)("ShopCodeAbb") + ":"
                                        End If
                                    End If
                                End If
                                outputString += "<td class=""text"" align=""center""><a href=""JavaScript: newWindow = window.open( 'ERP_Mapping_Ootoya.aspx?ProductLevelID=" + dtTable.Rows(i)("ProductLevelID").ToString + "', '', 'width=700,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + ShortName + "ERP Mapping Data" + "</a></td>"
                            Else
                                Select Case ShowMapping
                                    Case 99                 'Always Show Extra Data
                                        ShowExtra = True
                                End Select
                                If ShowExtra = True Then
                                    If strExtraDataLink = "" Then
                                        strLink = "ERP_Mapping.aspx"
                                    Else
                                        strLink = strExtraDataLink
                                    End If
                                    outputString += "<td class=""text"" align=""center""><a href=""JavaScript: newWindow = window.open( '" & strLink & "?ProductLevelID=" + dtTable.Rows(i)("ProductLevelID").ToString + "', '', 'width=700,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Extra Data" + "</a></td>"
                                Else
                                    outputString += "<td align=""left"" class=""text"">" & "-" & "</td>"
                                End If
                            End If
                        End If
                        outputString += "<td class=""text"" align=""center""><a href=""JavaScript: newWindow = window.open( 'manage_shop_docheader.aspx?ProductLevelID=" + dtTable.Rows(i)("ProductLevelID").ToString + "', '', 'width=700,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "View Document Header" + "</a></td>"
                        If headerTD5.Visible = True Then
                            outputString += "<td class=""text"" align=""center""><a href=""JavaScript: newWindow = window.open( 'manage_shop_inv.aspx?TypeID=1&ViewFromProductLevelID=" + dtTable.Rows(i)("ProductLevelID").ToString + "', '', 'width=700,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Set Inventory View" + "</a></td>"
                        End If
                        If headerTD8.Visible = True Then
                            outputString += "<td class=""text"" align=""center""><a href=""JavaScript: newWindow = window.open( 'manage_shop_inv.aspx?TypeID=2&ViewFromProductLevelID=" + dtTable.Rows(i)("ProductLevelID").ToString + "', '', 'width=700,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Transfer Inv View" + "</a></td>"
                        End If
                        If headerTD7.Visible = True Then
                            If dtTable.Rows(i)("ProductLevelID") = 1 Then
                                outputString += "<td align=""center"" class=""text"">" & "-" & "</td>"
                            Else
                                If PropertyInfo.Rows(0)("MultiBranch") = 1 And dtTable.Rows(i)("MasterShopLink") > 0 Then
                                    outputString += "<td align=""center"" class=""text"">" & "-" & "</td>"
                                Else
                                    outputString += "<td align=""center"" class=""text""><a href=""inv_category_saveas.aspx?ProductLevelID=" & dtTable.Rows(i)("ProductLevelID") & """>" & "Save As" & "</a></td>"
                                End If
                            End If
                        End If
                        If dtTable.Rows(i)("ProductLevelID") = 1 Then
                            'outputString += "<td align=""center"" class=""disabledText"">" & defaultTextTable.Rows(0)("TextParamValue") & "</td>"
                            If headerTD3.Visible = True Then
                                outputString += "<td align=""center"" class=""text""><a href=""inv_category_edit.aspx?ProductLevelID=" & dtTable.Rows(i)("ProductLevelID") & """>" & defaultTextTable.Rows(0)("TextParamValue") & "</a></td>"
                            End If
                            If headerTD4.Visible = True Then
                                outputString += "<td align=""center"" class=""disabledText"">" & defaultTextTable.Rows(1)("TextParamValue") & "</td>"
                            End If
                        Else
                            If headerTD3.Visible = True Then
                                outputString += "<td align=""center"" class=""text""><a href=""inv_category_edit.aspx?ProductLevelID=" & dtTable.Rows(i)("ProductLevelID") & """>" & defaultTextTable.Rows(0)("TextParamValue") & "</a></td>"
                            End If
                            If headerTD4.Visible = True Then
                                outputString += "<td align=""center"" class=""text""><a href=""inv_category_action.aspx?action=delete_category&action_to=productlevel&DelID=" & dtTable.Rows(i)("ProductLevelID") & """ onClick=""javascript: return confirm('" & textTable.Rows(3)("TextParamValue") & " " & Replace(dtTable.Rows(i)("ProductLevelName"), "'", "\'") & " " & textTable.Rows(4)("TextParamValue") & "')"">" & defaultTextTable.Rows(1)("TextParamValue") & "</a></td>"
                            End If
                        End If

                        outputString += "</tr>"
                    End If
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
