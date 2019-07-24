<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Administration</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<form id="mainForm" runat="server">
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

<table cellpadding="2" cellspacing="2" width="90%"><span id="show" visible="false" runat="Server">
<tr>
<td align="left"><table cellpadding="0" cellspacing="0"><tr><td><synature:date id="PMonthYearDate" runat="server" /></td><td><input type="submit" value="Submit"></td></tr></table></td><td align="right"><div class="text" id="GoBackText" runat="server"></div></td>
</tr></span>
</form>
</table>
<table border="0" width="100%">
<tr>
<td valign="top" width="100%" class="text">

	
	<div id="ResultText" runat="server"></div>
	

<div id="moreInfoText" runat="server"></div>
</td>
</tr>
</table>
<div id="errorMsg" runat="server" />
</td>
<td>&nbsp;</td>
</tr>

<tr><td colspan="3" height="30">&nbsp;</td></tr>

</table>
<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getInfo As New CCategory()
Dim getPageText As New DefaultText()
Dim DateTimeUtil As New MyDateTime()
Dim objDB As New CDBUtil()
Dim CostInfo As New CostClass()
Dim FormatDocNumber As New FormatText()
Dim getProp As New CPreferences()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture

Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Inv_Product_Category") Then
	  
	  If IsNumeric(Request.QueryString("ProductID")) Then
		
		HeaderText.InnerHtml = "Product Details"
		
		'Try
		objCnn = getCnn.EstablishConnection()
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(8,Session("LangID"),objCnn)
		
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(7,Session("LangID"),objCnn)
		
		PMonthYearDate.YearType = GlobalParam.YearType
		PMonthYearDate.FormName = "PMonthYearDate"
		PMonthYearDate.StartYear = 1
		PMonthYearDate.EndYear = 2
		PMonthYearDate.LangID = Session("LangID")
		PMonthYearDate.ShowDay = False
		
		Dim CostType As Integer = CostInfo.ChkCostingType(objCnn)
		
		If IsNumeric(Request.Form("PMonthYearDate_Month")) Then 
			Session("PMonthYearDate_Month") = Request.Form("PMonthYearDate_Month")
		Else If IsNumeric(Request.QueryString("PMonthYearDate_Month")) Then 
			Session("PMonthYearDate_Month") = Request.QueryString("PMonthYearDate_Month")
		Else If Trim(Session("PMonthYearDate_Month")) = "" Then
			Session("PMonthYearDate_Month") = DateTime.Now.Month
		End If
		If Page.IsPostBack AND Request.Form("PMonthYearDate_Month") = "" Then Session("PMonthYearDate_Month") = 0
		PMonthYearDate.SelectedMonth = Session("PMonthYearDate_Month")
		
		If IsNumeric(Request.Form("PMonthYearDate_Year")) Then 
			Session("PMonthYearDate_Year") = Request.Form("PMonthYearDate_Year")
		Else If IsNumeric(Request.QueryString("PMonthYearDate_Year")) Then 
			Session("PMonthYearDate_Year") = Request.QueryString("PMonthYearDate_Year")
		Else If Trim(Session("PMonthYearDate_Year")) = "" Then
			Session("PMonthYearDate_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("PMonthYearDate_Year") = "" Then Session("PMonthYearDate_Year") = 0
		PMonthYearDate.SelectedYear = Session("PMonthYearDate_Year")
		
		Dim displayTable As New DataTable()
                displayTable = getInfo.GetProductInfo(0, Request.QueryString("ProductID"), objCnn)

		Dim bolDisplayInExpandReceipt as Boolean
		Dim outputString As String = ""
		
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)

		GoBackText.InnerHtml = "<a href=""javascript:window.print()"">" + defaultTextTable.Rows(6)("TextParamValue") + "</a>"
		
                bolDisplayInExpandReceipt = False
                If IsNumeric(Request.QueryString("ExpandReceipt")) Then
                    If Request.QueryString("ExpandReceipt") = 1 Then
                        bolDisplayInExpandReceipt = True
                    End If
                End If
                Dim dtTable As New DataTable()
                dtTable = CostInfo.FlexibleProductStdCost(Request.QueryString("ProductID"), Request.QueryString("ProductLevelID"), Session("PMonthYearDate_Month"), Session("PMonthYearDate_Year"), Request.QueryString("StartDate"), Request.QueryString("EndDate"), bolDisplayInExpandReceipt, objCnn)
                If dtTable.Rows.Count > 0 Then HeaderText.InnerHtml = textTable.Rows(26)("TextParamValue") + " " + dtTable.Rows(0)("ProductName")
		
                outputString += "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
                outputString += "<tr>"
                If bolDisplayInExpandReceipt = True Then
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Sale Date" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Receipt" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Product Code" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Product Name" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Selected Code" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Selected Product" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Selected Amount" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Material Code" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Material Name" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Unit Name" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Recipe Amount" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Total Amount" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Price/Unit" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "SubTotal Cost" + "</td>"
                Else
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Selected Code" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Selected Product" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Selected Amount" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Material Code" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Material Name" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Unit Name" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Recipe Amount" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Total Amount" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "Price/Unit" + "</td>"
                    outputString += "<td bgColor=""" + GlobalParam.AdminBGColor + """ align=""center"" class=""smallTdHeader"">" + "SubTotal Cost" + "</td>"		
                End If
                outputString += "</tr>"
                Dim SelectedText As String = "smalltext"
                Dim AdditionalHeaderText, HText, RText As String
                Dim ReceiptHeaderData As DataTable
		
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
		
                Dim DigitRunning As Integer
                Dim ChkRunning As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramtypeID = 1 AND PropertyID = 29 AND KeyID = 1", objCnn)
                If ChkRunning.Rows.Count > 0 Then
                    If ChkRunning.Rows(0)("PropertyValue") > 5 Then
                        DigitRunning = ChkRunning.Rows(0)("PropertyValue")
                    End If
                End If
                AdditionalHeaderText = ""
                If bolDisplayInExpandReceipt = True Then
                    ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, 1, objCnn)
                    If ReceiptHeaderData.Rows.Count > 0 Then
                        If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
                            AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
                        End If
                    End If
                End If
                
                Dim strDisplayPriceFormat As String = "#,##0.0000"
                Dim colSpan As Integer
                Dim TotalCost As Double = 0
                Dim i As Integer
                For i = 0 To dtTable.Rows.Count - 1
                    If bolDisplayInExpandReceipt = True Then
                        HText = ""
                        If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
                            If DigitRunning > 5 Then
                                HText = "Running," + DigitRunning.ToString
                            Else
                                If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
                                    HText = dtTable.Rows(i)("DocumentTypeHeader")
                                End If
                            End If
                        ElseIf DigitRunning > 5 Then
                            HText = "Running," + DigitRunning.ToString
                        Else
                            HText = AdditionalHeaderText
                        End If
                        If IsDBNull(dtTable.Rows(i)("ReceiptID")) Or IsDBNull(dtTable.Rows(i)("ReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("ReceiptYear")) Then
                            RText = "-"
                        Else
                            RText = FormatDocNumber.GetReceiptHeader(HText, dtTable.Rows(i)("ReceiptYear"), dtTable.Rows(i)("ReceiptMonth"), dtTable.Rows(i)("ReceiptID"))
                        End If
                        outputString += "<tr>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly") & "</td>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """><a class=""smallText"" href=""JavaScript: newWindow = window.open( '../Reports/BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&ShopID=" + dtTable.Rows(i)("ShopID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a></td>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("ProductCode") & "</td>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("ProductName") & "</td>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("SubProductCode") & "</td>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("SubProductName") & "</td>"
                        outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("SubAmount"), "##,##0.00") & "</td>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("MaterialCode") & "</td>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("MaterialName") & "</td>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("UnitSmallName") & "</td>"
                        outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("MaterialAmount"), "##,##0.00") & "</td>"
                        outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("MaterialAmount") * dtTable.Rows(i)("SubAmount"), "##,##0.00") & "</td>"
                        If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                            If dtTable.Rows(i)("TotalAmount") <> 0 Then
                                If CostType >= 0 Then
                                    outputString += "<td align=""right"" class=""" + SelectedText + """><a class=""smalltext"" href=""JavaScript: newWindow = window.open( 'product_stdcost.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&SelMonth=" & Session("PMonthYearDate_Month").ToString & "&SelYear=" & Session("PMonthYearDate_Year").ToString & "&ProductLevelID=" & Request.QueryString("ProductLevelID").ToString + "', '', 'width=800,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & Format(dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount"), "##,##0.0000") & "</a></td>"
                                Else
                                    outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount"), "##,##0.0000") & "</td>"
                                End If
                                outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format((dtTable.Rows(i)("MaterialAmount") * dtTable.Rows(i)("SubAmount") * dtTable.Rows(i)("TotalPrice")) / dtTable.Rows(i)("TotalAmount"), "##,##0.00") & "</td>"
                                TotalCost += (dtTable.Rows(i)("MaterialAmount") * dtTable.Rows(i)("SubAmount") * dtTable.Rows(i)("TotalPrice")) / dtTable.Rows(i)("TotalAmount")
                            Else
                                outputString += "<td align=""right"" class=""" + SelectedText + """>" & "-" & "</td>"
                                outputString += "<td align=""right"" class=""" + SelectedText + """>" & "0.00" & "</td>"
                            End If
                        Else
                            outputString += "<td align=""right"" class=""" + SelectedText + """>" & "-" & "</td>"
                            outputString += "<td align=""right"" class=""" + SelectedText + """>" & "0.00" & "</td>"
                        End If
                        outputString += "</tr>"
                    Else
                        outputString += "<tr>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("SubProductCode") & "</td>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("SubProductName") & "</td>"
                        outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("SubAmount"), "##,##0.00") & "</td>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("MaterialCode") & "</td>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("MaterialName") & "</td>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("UnitSmallName") & "</td>"
                        outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("MaterialAmount"), "##,##0.00") & "</td>"
                        outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("MaterialAmount") * dtTable.Rows(i)("SubAmount"), "##,##0.00") & "</td>"
                        If Not IsDBNull(dtTable.Rows(i)("TotalPrice")) And Not IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                            If dtTable.Rows(i)("TotalAmount") <> 0 Then
                                If CostType >= 0 Then
                                    outputString += "<td align=""right"" class=""" + SelectedText + """><a class=""smalltext"" href=""JavaScript: newWindow = window.open( 'product_stdcost.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&SelMonth=" & Session("PMonthYearDate_Month").ToString & "&SelYear=" & Session("PMonthYearDate_Year").ToString & "&ProductLevelID=" & Request.QueryString("ProductLevelID").ToString + "', '', 'width=800,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & Format(dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount"), strDisplayPriceFormat) & "</a></td>"
                                Else
                                    outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount"), strDisplayPriceFormat) & "</td>"
                                End If
                                outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format((dtTable.Rows(i)("MaterialAmount") * dtTable.Rows(i)("SubAmount") * dtTable.Rows(i)("TotalPrice")) / dtTable.Rows(i)("TotalAmount"), strDisplayPriceFormat) & "</td>"
                                TotalCost += (dtTable.Rows(i)("MaterialAmount") * dtTable.Rows(i)("SubAmount") * dtTable.Rows(i)("TotalPrice")) / dtTable.Rows(i)("TotalAmount")
                            Else
                                outputString += "<td align=""right"" class=""" + SelectedText + """>" & "-" & "</td>"
                                outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(0, strDisplayPriceFormat) & "</td>"
                            End If
                        Else
                            outputString += "<td align=""right"" class=""" + SelectedText + """>" & "-" & "</td>"
                            outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(0, strDisplayPriceFormat) & "</td>"
                        End If
                        outputString += "</tr>"
                    End If
                Next
                
                If bolDisplayInExpandReceipt = True Then
                    colSpan = 13
                Else
                    colSpan = 9
                End If
                
                outputString += "<tr>"
                outputString += "<td align=""right"" colspan=""" & colSpan & """ class=""" + SelectedText + """>" & "Total Cost" & "</td>"
                If bolDisplayInExpandReceipt = True Then
                    outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(TotalCost, "##,##0.00") & "</td>"
                Else
                    outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(TotalCost, strDisplayPriceFormat ) & "</td>"
                End If
                outputString += "</tr>"
                ResultText.InnerHtml = outputString
		
                'Catch ex As Exception
                '	errorMsg.InnerHtml = ex.Message
                'End Try
            Else
                updateMessage.Text = "Invalid Parameters"
            End If
        Else
            updateMessage.Text = "Access Denied"
        End If
End Sub

        Public Function GetProductLevel(ByVal ProductLevelID As Integer, ByVal objCnn As MySqlConnection) As DataTable
            Dim sqlStatement As String
            If ProductLevelID = 0 Or Not IsNumeric(ProductLevelID) Then
                sqlStatement = "SELECT * FROM ProductLevel WHERE Deleted=0 AND ProductLevelID > 1 ORDER BY ProductLevelOrder,ProductLevelName"
            ElseIf ProductLevelID = -1 Then
                sqlStatement = "SELECT * FROM ProductLevel WHERE Deleted=0 ORDER BY ProductLevelOrder,ProductLevelName"
            ElseIf ProductLevelID = -99 Then
                sqlStatement = "SELECT * FROM ProductLevel WHERE Deleted=0 AND IsInv=1 ORDER BY ProductLevelOrder,ProductLevelName"
            ElseIf ProductLevelID = -999 Then
                sqlStatement = "SELECT * FROM ProductLevel WHERE Deleted=0 AND IsShop=1 AND ProductLevelID > 1 ORDER BY ProductLevelOrder,ProductLevelName"
            ElseIf ProductLevelID = -9999 Then
                sqlStatement = "SELECT * FROM ProductLevel WHERE Deleted=0 AND IsShop=1 ORDER BY ProductLevelOrder,ProductLevelName"
            Else
                sqlStatement = "SELECT * FROM ProductLevel WHERE Deleted=0 AND ProductLevelID=" + ProductLevelID.ToString + " ORDER BY ProductLevelOrder,ProductLevelName"
            End If
            Return objDB.List(sqlStatement, objCnn)
        End Function
		
		
		
		
		
		
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>