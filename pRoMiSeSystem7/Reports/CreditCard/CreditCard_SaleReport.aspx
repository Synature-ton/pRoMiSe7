<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="POSBackOfficeReport" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../../UserControls/Date.ascx" %>

<html>
<head>
<title>Credit Card Reports</title>
<link href="../../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:#FFF">
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">

<div class="noprint">
<table>
<tr id="ShowShop" runat="server">
	<td>
	<table>
	<tr>
		<td><table cellpadding="0" cellspacing="0"><tr><td><asp:dropdownlist ID="GroupByParam" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td><td>&nbsp;</td><td><asp:CheckBox ID="GroupDate" CssClass="text" runat="server" /></td><td>&nbsp;</td><td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td></tr></table></td>
	</tr>
	</table>
	</td>
</tr>

</table>
</div>
<br>



<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
	<tr>
		<td colspan="8">
			<table width="100%">
				<tr><td><div id="ResultSearchText" class="text" runat="server"></div></td>
				<td align="right"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print" runat="server" /></a> | <a href="javascript: window.close()"><asp:Label ID="CloseText" Text="Close Windows" runat="server" /></a></div></td></tr>
			</table>
		</td>
	</tr>
	<tr>
    	<td id="headerShopName" align="center" class="tdHeader" runat="server"><div id="txtShopName" runat="server"></div></td>
		<td id="headerReceiptNo" align="center" class="tdHeader" runat="server"><div id="txtReceiptNo" runat="server"></div></td>
		<td id="headerCreditCardNo" align="center" class="tdHeader" runat="server"><div id="txtCreditCardNo" runat="server"></div></td>
		<td id="headerCardHolderName" align="center" class="tdHeader" runat="server"><div id="txtCardHolderName" runat="server"></div></td>
		<td id="headerBankName" align="center" class="tdHeader" runat="server"><div id="txtBankName" runat="server"></div></td>
		<td id="headerCCType" align="center" class="tdHeader" runat="server"><div id="txtCCType" runat="server"></div></td>
		<td id="headerSaleDate" align="center" class="tdHeader" runat="server"><div id="txtSaleDate" runat="server"></div></td>
		<td id="headerPayAmount" align="center" class="tdHeader" runat="server"><div id="txtPayAmount" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>
</table>
</form>
</div>
<div id="errorMsg" runat="server" />

<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim FormatDocNumber As New FormatText()
Dim objDB As New CDBUtil()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer = 9
		
    Sub Page_Load()
        If User.Identity.IsAuthenticated Then
		
            Try
                objCnn = getCnn.EstablishConnection()
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
		
                If Not Request.QueryString("ToLangID") Is Nothing Then
                    If IsNumeric(Request.QueryString("ToLangID")) Then
                        Session("LangID") = Request.QueryString("ToLangID")
                    End If
                End If
		
                Dim CultureString As String = Util.GetCultureByLangID(Session("LangID"), objCnn)
                Dim PageName As String = System.IO.Path.GetFileName(Request.ServerVariables("SCRIPT_NAME"))
                Dim LangListText As String = ""
                Dim LangListData As DataTable
                Dim ccDisplayAdditionColumn As POSBackOfficeReport.Report_CreditCard_DisplayAdditionalColumn
                Dim LangData As DataTable = getProp.GetLang(LangListText, LangListData, PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"), PageID, 1, -1, Request, objCnn)
                Dim LangText As String = "lang" + Session("LangID").ToString
		
                Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
                If LangDefault.Rows.Count >= 4 Then
                    PrintText.Text = LangDefault.Rows(20)(LangText)
                    CloseText.Text = LangDefault.Rows(21)(LangText)
                End If
		
                Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
		
                headerShopName.BgColor = GlobalParam.AdminBGColor
                headerReceiptNo.BgColor = GlobalParam.AdminBGColor
                headerCreditCardNo.BgColor = GlobalParam.AdminBGColor
                headerCardHolderName.BgColor = GlobalParam.AdminBGColor
                headerBankName.BgColor = GlobalParam.AdminBGColor
                headerCCType.BgColor = GlobalParam.AdminBGColor
                headerSaleDate.BgColor = GlobalParam.AdminBGColor
                headerPayAmount.BgColor = GlobalParam.AdminBGColor
		
                GroupByParam.Items(0).Text = LangData2.Rows(0)(LangText)
                GroupByParam.Items(0).Value = "1"
                GroupByParam.Items(1).Text = LangData2.Rows(1)(LangText)
                GroupByParam.Items(1).Value = "2"
                GroupByParam.Items(2).Text = LangData2.Rows(2)(LangText)
                GroupByParam.Items(2).Value = "3"
                GroupByParam.Items(3).Text = LangData2.Rows(3)(LangText)
                GroupByParam.Items(3).Value = "4"
                GroupDate.Text = LangData2.Rows(4)(LangText)
		
                ResultText.InnerHtml = ""
                ResultSearchText.InnerHtml = ""
                errorMsg.InnerHtml = ""
		
                ccDisplayAdditionColumn = POSBackOfficeReport.BackOfficeReport.CreditCardReport_GetDisplayAdditionalColumn(objDB, objCnn)

                headerReceiptNo.Visible = True
                headerCreditCardNo.Visible = True
                headerCardHolderName.Visible = ccDisplayAdditionColumn.Column_CardHolderName               
                headerBankName.Visible = True
                headerCCType.Visible = True
                headerSaleDate.Visible = True
                headerPayAmount.Visible = True
                If GroupByParam.SelectedItem.Value = 1 And GroupDate.Checked = True Then
                    headerReceiptNo.Visible = False
                    headerCreditCardNo.Visible = False
                    headerCardHolderName.Visible = False
                    headerBankName.Visible = False
                    headerCCType.Visible = False
                ElseIf GroupByParam.SelectedItem.Value = 2 Then
                    headerReceiptNo.Visible = False
                    headerCreditCardNo.Visible = False
                    headerCardHolderName.Visible = False
                    headerBankName.Visible = False
                    If GroupDate.Checked = True Then
                        headerSaleDate.Visible = True
                    Else
                        headerSaleDate.Visible = False
                    End If
                ElseIf GroupByParam.SelectedItem.Value = 3 Then
                    headerReceiptNo.Visible = False
                    headerCreditCardNo.Visible = False
                    headerCardHolderName.Visible = False
                    headerCCType.Visible = False
                    If GroupDate.Checked = True Then
                        headerSaleDate.Visible = False
                    Else
                        headerSaleDate.Visible = True
                    End If
                ElseIf GroupByParam.SelectedItem.Value = 4 Then
                    headerReceiptNo.Visible = False
                    headerCreditCardNo.Visible = False
                    headerCardHolderName.Visible = False
                    If GroupDate.Checked = True Then
                        headerSaleDate.Visible = False
                    Else
                        headerSaleDate.Visible = True
                    End If
                End If
		
                Dim ShopIDValue As String = "0"
                If Not Request.Form("ShopID") Is Nothing Then
                    ShopIDValue = Request.Form("ShopID").ToString
                ElseIf Not Request.QueryString("ShopID") Is Nothing Then
                    ShopIDValue = Request.QueryString("ShopID").ToString
                End If
			
			
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(13, Session("LangID"), objCnn)
                Dim textTable1 As New DataTable()
                textTable1 = getPageText.GetText(12, Session("LangID"), objCnn)
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)

                SubmitForm.Text = LangDefault.Rows(3)(LangText)
                txtShopName.InnerHtml = LangData2.Rows(5)(LangText)
                txtReceiptNo.InnerHtml = LangData2.Rows(6)(LangText)
                txtCreditCardNo.InnerHtml = LangData2.Rows(7)(LangText)
                txtCardHolderName.InnerHtml = POSBackOfficeReport.BackOfficeReport.GetLanguageText(LangData2, 17, LangText, "Card Holder Name")
                txtBankName.InnerHtml = LangData2.Rows(8)(LangText)
                txtCCType.InnerHtml = LangData2.Rows(9)(LangText)
                txtSaleDate.InnerHtml = LangData2.Rows(10)(LangText)
                txtPayAmount.InnerHtml = LangData2.Rows(11)(LangText)
		

                'If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then

                If Not Request.QueryString("ShopID") Is Nothing And Trim(Request.QueryString("StartDate")) <> "" And Trim(Request.QueryString("EndDate")) <> "" Then
                    Dim SDate, EDate As String
                    Dim startDate, endDate As Date
                    Dim strData() As String
                    SDate = Replace(Request.QueryString("StartDate"), "{", "")
                    SDate = Trim(Replace(Replace(Replace(SDate, "}", ""), "'", ""), "d", ""))
                    EDate = Replace(Request.QueryString("EndDate"), "{", "")
                    EDate = Trim(Replace(Replace(Replace(EDate, "}", ""), "'", ""), "d", ""))
                    
                    strData = Split(SDate, "-")
                    startDate = New Date(strData(0), strData(1), strData(2))
                    
                    strData = Split(EDate, "-")
                    endDate = New Date(strData(0), strData(1), strData(2))

                    ResultSearchText.InnerHtml = LangData2.Rows(15)(LangText) + " " + DateTimeUtil.FormatDateTime(startDate, "DateOnly", Session("LangID"), objCnn) + " " + LangData2.Rows(16)(LangText) + " " + DateTimeUtil.FormatDateTime(DateAdd(DateInterval.Day, -1, endDate), "DateOnly", Session("LangID"), objCnn)
                    If Not Page.IsPostBack Then
                        GetResult(Request.QueryString("ShopID"), Request.QueryString("StartDate"), Request.QueryString("EndDate"), Request.QueryString("SaleModeID"), _
                                  GroupByParam.SelectedItem.Value, GroupDate.Checked, Request.QueryString("CCTypeID"), Request.QueryString("OriginalPayTypeID"), "", objCnn)
                    End If
                Else
                    ResultSearchText.InnerHtml = LangData2.Rows(12)(LangText)
                End If
			
            Catch ex As Exception
                errorMsg.InnerHtml = ex.Message
            End Try
	  
        Else
            showPage.Visible = False
            errorMsg.InnerHtml = "Access Denied"
        End If
    End Sub

    Sub DoSearch(Source As Object, E As EventArgs)
        Dim CCType As Integer = -1
        Dim forOriginalPayTypeID As Integer = 2
        If Not Request.QueryString("CCTypeID") Is Nothing Then
            If IsNumeric(Request.QueryString("CCTypeID")) Then
                CCType = Request.QueryString("CCTypeID")
            End If
        End If
        If Not Request.QueryString("OriginalPayTypeID") Is Nothing Then
            If IsNumeric(Request.QueryString("OriginalPayTypeID")) Then
                forOriginalPayTypeID = Request.QueryString("OriginalPayTypeID")
            End If
        End If

        GetResult(Request.QueryString("ShopID"), Request.QueryString("StartDate"), Request.QueryString("EndDate"), Request.QueryString("SaleModeID"), _
                    GroupByParam.SelectedItem.Value, GroupDate.Checked, CCType, forOriginalPayTypeID, "", objCnn)
    End Sub

    Public Function GetResult(ByVal ShopID As String, ByVal StartDate As String, ByVal EndDate As String, filterSaleModeID As String, ByVal GroupByParam As Integer, _
    ByVal GroupDate As Boolean, ByVal CCTypeID As Integer, forOriginalPayTypeID As Integer, ByVal OrderBy As String, ByVal objCnn As MySqlConnection) As String
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
        Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
        Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
		
        Dim i As Integer

        Dim outputString As String = ""
        Dim counter As Integer
        Dim ShowString As String = ""
        Dim bgColor As String = "e9e9e9"
        Dim strCreditCardNo As String
        Dim sumTotal As Double = 0
        Dim sumTotalPlus As Double = 0
        Dim sumTotalMinus As Double = 0
        'Application.Lock()
        Dim dtTable As DataTable = getReport.CreditCardReport(Session("LangID"), False, True, 0, 0, StartDate, EndDate, ShopID, _
                                                filterSaleModeID, GroupByParam, GroupDate, CCTypeID, forOriginalPayTypeID, OrderBy, objCnn)
        'Application.UnLock()
		
        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
        Dim AdditionalHeaderText, HText, RText As String
        Dim ReceiptHeaderData As DataTable
        ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, Session("LangID"), objCnn)

        If ReceiptHeaderData.Rows.Count > 0 Then
            If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
                AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
            End If
        End If
        Dim ColSpan As Integer = 0
		
        Dim DigitRunning As Integer
        Dim ChkRunning As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramtypeID = 1 AND PropertyID = 29 AND KeyID = 1", objCnn)
        If ChkRunning.Rows.Count > 0 Then
            If ChkRunning.Rows(0)("PropertyValue") > 5 Then
                DigitRunning = ChkRunning.Rows(0)("PropertyValue")
            End If
        End If
		
        For i = 0 To dtTable.Rows.Count - 1
            ColSpan = 1
            outputString += "<tr>"
            outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("ProductLevelName") & "</td>"
            If headerReceiptNo.Visible = True Then
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
                If RText <> "-" Then
                    outputString += "<td align=""left"" class=""text""><a href=""JavaScript: newWindow = window.open( '../../Reports/BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "&ShopID=" + dtTable.Rows(i)("ShopID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a></td>"
                Else
                    outputString += "<td align=""left"" class=""text"">" & RText & "</td>"
                End If
                ColSpan += 1
            End If
            If headerCreditCardNo.Visible = True Then
                If Not IsDBNull(dtTable.Rows(i)("CreditCardNo")) Then
                    strCreditCardNo = ReportModule.ReportV6.DisplayCreditCardNumberInReport(dtTable.Rows(i)("CreditCardNo"))
                Else
                    strCreditCardNo = "-"
                End If
                outputString += "<td align=""left"" class=""text"">" & strCreditCardNo & "</td>"
                ColSpan += 1
            End If
            If headerCardHolderName.Visible = True Then
                If dtTable.Columns.Contains("CardHolderName") = False Then
                    strCreditCardNo = ""
                ElseIf Not IsDBNull(dtTable.Rows(i)("CardHolderName")) Then
                    strCreditCardNo = Trim(dtTable.Rows(i)("CardHolderName"))
                Else
                    strCreditCardNo = ""
                End If
                outputString += "<td align=""left"" class=""text"">" & strCreditCardNo & "</td>"
                ColSpan += 1
            End If
            If headerBankName.Visible = True Then
                If Not IsDBNull(dtTable.Rows(i)("BankName")) Then
                    outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("BankName") & "</td>"
                Else
                    outputString += "<td align=""left"" class=""text"">" & "-" & "</td>"
                End If
                ColSpan += 1
            End If
                If headerCCType.Visible = True Then
                    If Not IsDBNull(dtTable.Rows(i)("CreditCardType")) Then
                        outputString += "<td align=""left"" class=""text"">" & dtTable.Rows(i)("CreditCardType") & "</td>"
                    Else
                        outputString += "<td align=""left"" class=""text"">" & "-" & "</td>"
                    End If
                    ColSpan += 1
                End If
                If headerSaleDate.Visible = True Then
                    outputString += "<td align=""right"" class=""text"">" & DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly", Session("LangID"), objCnn) & "</td>"
                    ColSpan += 1
                End If
                If headerPayAmount.Visible = True Then
                    outputString += "<td align=""right"" class=""text"">" & Format(dtTable.Rows(i)("totalAmount"), FormatData.Rows(0)("CurrencyFormat")) & "</td>"
                End If
			
                outputString += "</tr>"
                sumTotal += Format(dtTable.Rows(i)("totalAmount"), FormatData.Rows(0)("CurrencyFormat"))

                counter = counter + 1
        Next
        outputString += "<tr><td colspan=""" + ColSpan.ToString + """ class=""boldText"" align=""right"">" + LangData2.Rows(13)(LangText) & _
                        "</td><td align=""right"" class=""boldText"">" + Format(sumTotal, FormatData.Rows(0)("CurrencyFormat")) + "</td></tr>"
        If dtTable.Rows.Count = 0 Then
            outputString = "<tr><td class=""boldText"" colspan=""4"">" + LangData2.Rows(14)(LangText) + "</td></tr>"
        End If
        ResultText.InnerHtml = outputString

    End Function

Public Function DisplayCCNumber(ByVal CCNumber As String) As String
	Dim NewCC As String
	If Trim(LEN(CCNumber)) >= 14 Then
		NewCC = CCNumber.Insert(4,"-")
		NewCC = NewCC.Insert(9,"-")
		NewCC = NewCC.Insert(14,"-")
		Return NewCC
	Else
		Return CCNumber
	End If
End Function

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
