<%@ Page Language="VB" ContentType="text/html" EnableViewState="true" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<html>
<head>
<title>Manage Shift Close Receipt</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<ASP:Label id="updateMessage" Cssclass="smallText" runat="server" />
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
<div id="MLevelText" runat="server"></div>
<form action="manage_headerfooter.aspx" method="post">
<table cellpadding="2" cellspacing="2">
<tr>
<td><div id="HeaderFooterText" class="smallText" runat="server"></div></td>
<td><div id="LinkText" class="smallText" runat="server"></div></td>
<td><input type="submit" name="submit" value=" Submit " style="font-size:12px;"></td>
</tr>
</table>
</form>
<span id="showResult" visible="false" runat="server">
<table width="100%">
<tr><td valign="top" width="70%">
<table>

<tr>
	<td colspan="2" class="HeaderText"><div id="HText" runat="server"></div></td>
</tr>
<div id="validateName" runat="server" />
<form action="manage_headerfooter.aspx" method="post">
<input id="LineType" name="LineType" type="hidden" runat="server">
<input id="ProductLevelID_1" name="ProductLevelID" type="hidden" runat="server">
<tr>
	<td><div class="requireText" id="AddHeaderParam" runat="server"></div></td>
	<td><input type="text" name="TextInLine" value="" size="40"></td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td><span id="HeaderSelection" runat="server"></span>&nbsp;&nbsp;<input type="submit" name="add" value="Add" style="font-size:12px;"></td>
</tr>
</form>
<tr>
	<td colspan="2" height="5" width="100%"></td>
</tr>
<span id="HeaderFData" runat="server"></span>
<div id="showF" visible="false" runat="Server">
<tr>
	<td colspan="2" height="5"><hr size="0"></td>
</tr>

<tr>
	<td colspan="2" class="HeaderText"><div id="FText" runat="server"></div></td>
</tr>
<div id="validateFName" runat="server" />
<form action="manage_headerfooter.aspx" method="post">
<input id="ProductLevelID_2" name="ProductLevelID" type="hidden" runat="server">
<tr>
	<td><div class="requireText" id="AddFooterParam" runat="server"></div></td>
	<td><input type="text" name="TextInLine" value="" size="40"></td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td><span id="FooterSelection" runat="server"></span>&nbsp;&nbsp;<input type="submit" name="add" value="Add" style="font-size:10px;"></td>
</tr>
</form>
<tr>
	<td colspan="2" height="5"></td>
</tr>
<span id="HeaderFData1" runat="server"></span>
</div>
</table>

</td>
<td valign="top" align="right" visible="false" id="Example" runat="server">
	<table><tr><td align="center"><div id="ExampleText" class="boldText" runat="Server"></div></td></tr>
	<tr><td>
	<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="250">
	<tr><td>
		<table width="100%">
			<span id="ReceiptHeaderText" runat="server"></span>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td class="smallText">DATE dd/mm/yyyy hh:mm</td>
			</tr>
			<tr>
				<td class="smallText">Receipt No: RCxxxxxx/xxxxxx</td>
			</tr>
			<tr>
				<td class="smallText">CASHIER: xxxx</td>
			</tr>
			<tr>
				<td width="100%"><hr size="0"></td>
			</tr>
			<tr>
				<td width="100%">
					<table width="100%">
						<tr>
							<td class="smallText" align="left">Maki Mono Set</td>
							<td class="smallText" align="right">1</td>
							<td class="smallText" align="right">140.00</td>
						</tr>
						<tr>
							<td class="smallText" align="left">Morokyu</td>
							<td class="smallText" align="right">1</td>
							<td class="smallText" align="right">60.00</td>
						</tr>
						<tr>
							<td class="smallText" align="left">Nigiri-Ebi</td>
							<td class="smallText" align="right">1</td>
							<td class="smallText" align="right">50.00</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="100%"><hr size="0"></td>
			</tr>
			<tr>
				<td width="100%">
					<table width="100%">
						<tr>
							<td width="50%" class="smallText">ITEMS: 3</td>
							<td width="50%" class="smallText" align="right">233.64</td>
						</tr>
						<tr>
							<td width="50%" class="smallText">VAT</td>
							<td width="50%" class="smallText" align="right">16.36</td>
						</tr>
						<tr>
							<td width="50%" class="smallText">Total.........</td>
							<td width="50%" class="smallText" align="right">250.00</td>
						</tr>
						<tr>
							<td width="50%" class="smallText">Cash Pay: 300</td>
							<td width="50%" class="smallText" align="right">Change: 50.00</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="100%"><hr size="0"></td>
			</tr>
			<tr>
				<td width="100%" class="smallText">Table 2</td>
			</tr>
			<span id="ReceiptFooterText" runat="server"></span>
		</table>
	</td></tr>
	</table>
	</td></tr></table>
</td>
</tr>
</table>
</span>
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
Dim cls As New CCategory()
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getData As New CPreferences()
Dim objDB As New CDBUtil()

Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("ConfigHeaderFooter") Then
	
		'Try
			objCnn = getCnn.EstablishConnection()
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(9,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			'CancelForm.Text = defaultTextTable.Rows(2)("TextParamValue")
			HText.InnerHtml = "Header/Footer"'textTable.Rows(89)("TextParamValue")
			AddHeaderParam.InnerHtml = textTable.Rows(92)("TextParamValue")
			HeaderText.InnerHtml = "Manage Header and Footer"'textTable.Rows(88)("TextParamValue")
			ExampleText.InnerHtml = textTable.Rows(91)("TextParamValue")
			FText.InnerHtml = textTable.Rows(90)("TextParamValue")
			AddFooterParam.InnerHtml = textTable.Rows(93)("TextParamValue")
			
			Dim getProp As DataTable = objDB.List("select * from Property where ID=1", objCnn)
			Dim MultiBranch As Boolean = False
            If getProp.Rows.Count > 0 Then
                If getProp.Rows(0)("MultiBranch") = 1 Then
                    MultiBranch = True
                End If
            End If
			
			Dim outputString,FormSelected As String
			Dim i,IDValue As Integer
						
			Dim LineTypeValue, selGlobalConfig As Integer
			If IsNumeric(Request.Form("LineType")) Then
				LineTypeValue = Request.Form("LineType")
			ElseIf IsNumeric(Request.QueryString("LineType")) Then
				LineTypeValue = Request.QueryString("LineType")
			Else
				LineTypeValue = -99
			End If
			
			LineType.Value = LineTypeValue
			selGlobalConfig = 1
			
			Dim HFData As DataTable = objDB.List("select LineType,Description, GlobalConfig from receiptheaderfooterdescription where Deleted=0 AND GlobalConfig<>0 order by LineType", objCnn)
			outputString = "<select name=""LineType"" >"
			For i = 0 to HFData.Rows.Count - 1
				If LineTypeValue = HFData.Rows(i)("LineType") Then
                    FormSelected = "selected"
					selGlobalConfig = HFData.Rows(i)("GlobalConfig")
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & HFData.Rows(i)("LineType").ToString & """ " & FormSelected & ">" & HFData.Rows(i)("Description") & " (" & HFData.Rows(i)("LineType").ToString & ")"
			Next
			HeaderFooterText.InnerHtml = outputString
			
			Dim selectionTable As New DataTable()
			selectionTable = cls.GetProductLevel(-9988,objCnn)
			
			If IsNumeric(Request.Form("ProductLevelID")) Then
				IDValue = Request.Form("ProductLevelID")
			ElseIf IsNumeric(Request.Form("ProductLevelID_1")) Then
				IDValue = Request.Form("ProductLevelID_1")
			ElseIf IsNumeric(Request.Form("ProductLevelID_2")) Then
				IDValue = Request.Form("ProductLevelID_2")
			ElseIf selectionTable.Rows.Count > 0 Then
				IDValue = selectionTable.Rows(0)("ProductLevelID")
			Else
				IDValue = 0
			End If
			ProductLevelID_1.Value = IDValue
			ProductLevelID_2.Value = IDValue
			outputString = "<select name=""ProductLevelID"">"
			For i = 0 to selectionTable.Rows.Count - 1
				If IDValue = selectionTable.Rows(i)("ProductLevelID") Then
					FormSelected = "selected"
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & selectionTable.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & selectionTable.Rows(i)("ProductLevelName")
			Next
			LinkText.InnerHtml = outputString	
			
            Dim dtShopList, ChkIndex, getID As DataTable
            Dim AddIndex, LineOrder, SelID, selShopID() As Integer
			If MultiBranch = True Then
				Dim getLink As DataTable = objDB.List("select * from ProductLevel where ProductLevelID=" + IDValue.ToString, objCnn)
				Dim ShopLinkID As Integer = 0
                If getLink.Rows.Count > 0 Then
                    ShopLinkID = getLink.Rows(0)("MasterShop")
                End If
                dtShopList = objDB.List("select ProductLevelID As ShopID from ProductLevel where Deleted=0 AND MasterShopLink=" + ShopLinkID.ToString, objCnn)
                
                ReDim selShopID(0)
                selShopID(0) = IDValue
                For i = 0 To dtShopList.Rows.Count - 1
                    ReDim Preserve selShopID(selShopID.Length)
                    selShopID(selShopID.Length - 1) = dtShopList.Rows(i)("ShopID")
                Next i
            Else
                dtShopList = New DataTable
                ReDim selShopID(-1)
            End If
						
			If Request.Form("update") = "update" Then
                If (MultiBranch = True) And (selGlobalConfig = 1) Then
                    getData.ReceiptUpdateForGlobalConfig(Request.Form("UpdateID"), Request.Form("TextInLine"), selShopID, objCnn)
                Else
                    getData.ReceiptUpdate(IDValue, Request.Form("UpdateID"), Request.Form("TextInLine"), objCnn)
                End If
												
			Else If Request.Form("delete") = "delete" Then
                If (MultiBranch = True) And (selGlobalConfig = 1) Then
                    getData.ReceiptDelForGlobalConfig(Request.Form("LineType"), Request.Form("UpdateID"), selShopID, objCnn)
                Else
                    getData.ReceiptDel(IDValue, Request.Form("LineType"), Request.Form("UpdateID"), objCnn)
                End If
							
			Else If Request.Form("add") = "Add" Then
                If (MultiBranch = True) And (selGlobalConfig = 1) Then
                    getData.ReceiptAddForGlobalConfig(Request.Form("AddPosition"), Request.Form("LineType"), Request.Form("TextInLine"), selShopID, objCnn)
                Else
                    getData.ReceiptAdd(IDValue, Request.Form("AddPosition"), Request.Form("LineType"), Request.Form("TextInLine"), objCnn)
                End If
            End If
								
			Dim HeaderData,FooterData As String
			Dim HSel,FSel As String
            Dim HCount As Integer = 0
			Dim FCount As Integer = 0
			Dim NextHCount As Integer = 0
			Dim NextFCount As Integer = 0
			Dim HeaderFormData,FooterFormData As String
			
			HSel = "<option value=""-1"">" + textTable.Rows(94)("TextParamValue")
			FSel = "<option value=""-1"">" + textTable.Rows(94)("TextParamValue")
			
			Dim ReceiptData As New DataTable()
			ReceiptData = getData.ReceiptInfo(IDValue,LineTypeValue,objCnn)
			
			'errorMsg.InnerHtml = IDValue.ToString & "::" & LineTypeValue.ToString
			
			If LineTypeValue <> -99 Then
				showResult.Visible = True
				Dim ChkHF As DataTable = objDB.List("select * from receiptheaderfooterdescription where LineType=" + LineTypeValue.ToString, objCnn)
				If ChkHF.Rows.Count > 0 Then
					If ChkHF.Rows(0)("HeaderOrFooter") = 1 Then
						HText.InnerHtml = textTable.Rows(89)("TextParamValue")
						AddHeaderParam.InnerHtml = textTable.Rows(92)("TextParamValue")
					Else
						HText.InnerHtml = textTable.Rows(90)("TextParamValue")
						AddHeaderParam.InnerHtml = textTable.Rows(93)("TextParamValue")
					End If
				End If
			Else
				showResult.Visible = False
			End If
            
            HeaderData = ""
            HeaderFormData = ""
            FooterData = ""
            For i = 0 To ReceiptData.Rows.Count - 1
                HeaderData += "<tr><td class=""smallText"" align=""center"" widht=""100%"">" + ReceiptData.Rows(i)("TextInLine") + "</td></tr>"
                NextHCount = NextHCount + 1
                If HCount <> 0 Then
                    HSel += "<option value=""" + ReceiptData.Rows(i)("ID").ToString + """>" + textTable.Rows(95)("TextParamValue") + " Line" + HCount.ToString + " - Line" + NextHCount.ToString
                End If
                HCount = NextHCount
                HeaderFormData += "<form action=""manage_headerfooter.aspx"" method=""post""><input type=""hidden"" name=""UpdateID"" value=""" + ReceiptData.Rows(i)("ID").ToString + """>" + "<input type=""hidden"" name=""ProductLevelID"" + value=""" + IDValue.ToString + """>" + "<input type=""hidden"" name=""LineType"" + value=""" + LineTypeValue.ToString + """>"
                HeaderFormData += "<tr><td class=""text"" align=""left"">" + textTable.Rows(97)("TextParamValue") + " Line" + NextHCount.ToString + "</td><td><input type=""text"" size=""30"" name=""TextInLine"" value=""" + ReceiptData.Rows(i)("TextInLine") + """>"
                HeaderFormData += "<input type=""submit"" name=""update"" value=""update"" style=""font-size:12px;"">&nbsp;<input type=""submit"" name=""delete"" value=""delete"" style=""font-size:12px;"" onclick=""javascript: return confirm('" + textTable.Rows(98)("TextParamValue") + "')""></td></tr></form>"
				
            Next
			ReceiptHeaderText.InnerHtml = HeaderData
			ReceiptFooterText.InnerHtml = FooterData
			
			HeaderFData.InnerHtml = HeaderFormData
			
			If HCount > 0 Then
				HSel += "<option value=""-99"" selected>" + textTable.Rows(96)("TextParamValue")
			End If
			HeaderSelection.InnerHtml = "<select name=""AddPosition"">" + HSel + "</select>"
			
			If FCount > 0 Then
				FSel += "<option value=""-99"" selected>" + textTable.Rows(96)("TextParamValue")
			End If
			FooterSelection.InnerHtml = "<select name=""AddPosition"">" + FSel + "</select>"
			HeaderFData1.InnerHtml = FooterFormData
	
		
		'Catch ex As Exception
			'errorMsg.InnerHtml = ex.Message
		'End Try
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
