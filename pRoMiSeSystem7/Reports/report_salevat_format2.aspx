<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSTypeClass" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Sale VAT Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body<% = GlobalParam.BodyProp %>>
<div id="showPage" visible="true" runat="server">
<form runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />

<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">

<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><b class="headerText"><div class="headerText" align="left" id="HeaderText" runat="server"></div></b></div>
	</td>
	<td width="1" nowrap rowspan="99" bgcolor="003366"><img src="../images/clear.gif" height="1" width="1"></td>
</tr>
<tr bgcolor="666666">
	<td width="3%" height="1"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	<td width="94%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="252"></p></td>
	<td width="3%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	
</tr>
<tr><td colspan="3" class="smalltext" align="right"><span id="DBText" class="smalltext" runat="server" /></td></tr>

<tr>
<td>&nbsp;</td>
<td>
<div class="noprint">
<table>
<tr id="ShowShop" runat="server">
	<td valign="top">
		<table>
			<tr>
				<td><span id="ShopText" runat="server"></span></td>
			</tr>
            <tr>
                <td><asp:CheckBox ID="chkDisplayVoidReceipt" Text="Display Void Receipt" runat="server" /></td>
            </tr>
			<tr>
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
			</tr>

		</table></td>
	<td>
	<table>
		<tr>
			<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
			<td colspan="4"><table cellpadding="0" cellspacing="0"><tr><td><synature:date id="DailyDate" runat="server" /></td><td>&nbsp;&nbsp;</td><td><span id="ItemNameText" class="text" runat="server"></span>&nbsp;<asp:TextBox ID="ItemNameVal" runat="server"></asp:TextBox></td></tr></table></td>
		</tr>
		<tr>
			<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
			<td colspan="3"><synature:date id="MonthYearDate" runat="server" /></td>
		</tr>
		<tr>
			<td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
			<td><synature:date id="CurrentDate" runat="server" /></td>
			<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
			<td><synature:date id="ToDate" runat="server" /></td>
		</tr>
	
	</table>
	</td>
</tr>


</table>
</div>
<span id="showResults" runat="server">
<table width="100%">
<div class="noprint">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr></div>
</table>
<span id="MyTable">
<table width="100%">
<tr>
	<td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td>
</tr>
<tr>
	<td width="100%">
	<table width="100%">
		<tr>
			<td valign="top"><span id="CompanyInfoText1" runat="server"></span></td>
			<td align="right" valign="top"><span id="CompanyInfoText2" runat="server"></span></td>
		</tr>
	</table>
	</td>
</tr>
<tr><td>
	<asp:DataGrid ID="Results" AutoGenerateColumns="false" CellPadding="3" CssClass="text" HeaderStyle-BackColor="#507093" HeaderStyle-CssClass="tdHeader" HeaderStyle-HorizontalAlign="center" AllowPaging="false" OnPageIndexChanged="ChangeGridPage" Width="100%" OnItemDataBound="Results_ItemDataBound" runat="server">
		<columns>
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="#"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="Date"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="FullTaxInvoice"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="TerminalNumber"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" Visible="false" ItemStyle-CssClass="smallText" DataField="CustomerName"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="ItemName"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="PriceBeforeVAT"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="VAT"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="SubTotal"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="RefNo"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="VoidReceiptNo"></asp:BoundColumn> 
		</columns>
	</asp:DataGrid></td></tr>
</table></span>
</span>
</form>
</div>
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
    
    Dim POS_VOIDRECEIPTNO As Integer = 10

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
    Dim InvC As CultureInfo = CultureInfo.InvariantCulture
    Dim PageID As Integer = 13
		
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Report_SaleVAT") Then
		
            Try
                objCnn = getCnn.EstablishConnection()
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
                showResults.Visible = False
		
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(13, Session("LangID"), objCnn)
                Dim textTable1 As New DataTable()
                textTable1 = getPageText.GetText(12, Session("LangID"), objCnn)
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)

                SubmitForm.Text = textTable.Rows(8)("TextParamValue")
                ItemNameText.InnerHtml = textTable.Rows(21)("TextParamValue")
		
                HeaderText.InnerHtml = textTable.Rows(17)("TextParamValue")
			
                DailyDate.YearType = GlobalParam.YearType
                DailyDate.FormName = "DocDaily"
                DailyDate.StartYear = GlobalParam.StartYear
                DailyDate.EndYear = GlobalParam.EndYear
                DailyDate.LangID = Session("LangID")
		
                CurrentDate.YearType = GlobalParam.YearType
                CurrentDate.FormName = "Doc"
                CurrentDate.StartYear = GlobalParam.StartYear
                CurrentDate.EndYear = GlobalParam.EndYear
                CurrentDate.LangID = Session("LangID")
		
                ToDate.YearType = GlobalParam.YearType
                ToDate.FormName = "DocTo"
                ToDate.StartYear = GlobalParam.StartYear
                ToDate.EndYear = GlobalParam.EndYear
                ToDate.LangID = Session("LangID")
		
                MonthYearDate.YearType = GlobalParam.YearType
                MonthYearDate.FormName = "MonthYearDate"
                MonthYearDate.StartYear = GlobalParam.StartYear
                MonthYearDate.EndYear = GlobalParam.EndYear
                MonthYearDate.LangID = Session("LangID")
                MonthYearDate.ShowDay = False

                errorMsg.InnerHtml = ""
		
                If IsNumeric(Request.Form("DocDaily_Day")) Then
                    Session("DocDailyDay") = Request.Form("DocDaily_Day")
                ElseIf IsNumeric(Request.QueryString("DocDaily_Day")) Then
                    Session("DocDailyDay") = Request.QueryString("DocDaily_Day")
                ElseIf Trim(Session("DocDailyDay")) = "" Then
                    Session("DocDailyDay") = DateTime.Now.Day
                End If
                If Page.IsPostBack And Request.Form("DocDaily_Day") = "" Then Session("DocDailyDay") = 0
                DailyDate.SelectedDay = Session("DocDailyDay")
		
		
                If IsNumeric(Request.Form("DocDaily_Month")) Then
                    Session("DocDaily_Month") = Request.Form("DocDaily_Month")
                ElseIf IsNumeric(Request.QueryString("DocDaily_Month")) Then
                    Session("DocDaily_Month") = Request.QueryString("DocDaily_Month")
                ElseIf Trim(Session("DocDaily_Month")) = "" Then
                    Session("DocDaily_Month") = DateTime.Now.Month
                End If
                If Page.IsPostBack And Request.Form("DocDaily_Month") = "" Then Session("DocDaily_Month") = 0
                DailyDate.SelectedMonth = Session("DocDaily_Month")
		
                If IsNumeric(Request.Form("DocDaily_Year")) Then
                    Session("DocDaily_Year") = Request.Form("DocDaily_Year")
                ElseIf IsNumeric(Request.QueryString("DocDaily_Year")) Then
                    Session("DocDaily_Year") = Request.QueryString("DocDaily_Year")
                ElseIf Trim(Session("DocDaily_Year")) = "" Then
                    Session("DocDaily_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("DocDaily_Year") = "" Then Session("DocDaily_Year") = 0
                DailyDate.SelectedYear = Session("DocDaily_Year")
		
                If IsNumeric(Request.Form("Doc_Day")) Then
                    Session("DocDay") = Request.Form("Doc_Day")
                ElseIf IsNumeric(Request.QueryString("Doc_Day")) Then
                    Session("DocDay") = Request.QueryString("Doc_Day")
                ElseIf Trim(Session("DocDay")) = "" Then
                    Session("DocDay") = DateTime.Now.Day
                End If
                If Page.IsPostBack And Request.Form("Doc_Day") = "" Then Session("DocDay") = 0
                CurrentDate.SelectedDay = Session("DocDay")
		
		
                If IsNumeric(Request.Form("Doc_Month")) Then
                    Session("Doc_Month") = Request.Form("Doc_Month")
                ElseIf IsNumeric(Request.QueryString("Doc_Month")) Then
                    Session("Doc_Month") = Request.QueryString("Doc_Month")
                ElseIf Trim(Session("Doc_Month")) = "" Then
                    Session("Doc_Month") = DateTime.Now.Month
                End If
                If Page.IsPostBack And Request.Form("Doc_Month") = "" Then Session("Doc_Month") = 0
                CurrentDate.SelectedMonth = Session("Doc_Month")
		
                If IsNumeric(Request.Form("Doc_Year")) Then
                    Session("Doc_Year") = Request.Form("Doc_Year")
                ElseIf IsNumeric(Request.QueryString("Doc_Year")) Then
                    Session("Doc_Year") = Request.QueryString("Doc_Year")
                ElseIf Trim(Session("Doc_Year")) = "" Then
                    Session("Doc_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("Doc_Year") = "" Then Session("Doc_Year") = 0
                CurrentDate.SelectedYear = Session("Doc_Year")
		
                If IsNumeric(Request.Form("DocTo_Day")) Then
                    Session("DocTo_Day") = Request.Form("DocTo_Day")
                ElseIf IsNumeric(Request.QueryString("DocTo_Day")) Then
                    Session("DocTo_Day") = Request.QueryString("DocTo_Day")
                ElseIf Trim(Session("DocTo_Day")) = "" Then
                    Session("DocTo_Day") = DateTime.Now.Day
                End If
                If Page.IsPostBack And Request.Form("DocTo_Day") = "" Then Session("DocTo_Day") = 0
                ToDate.SelectedDay = Session("DocTo_Day")
		
		
                If IsNumeric(Request.Form("DocTo_Month")) Then
                    Session("DocTo_Month") = Request.Form("DocTo_Month")
                ElseIf IsNumeric(Request.QueryString("DocTo_Month")) Then
                    Session("DocTo_Month") = Request.QueryString("DocTo_Month")
                ElseIf Trim(Session("DocTo_Month")) = "" Then
                    Session("DocTo_Month") = DateTime.Now.Month
                End If
                If Page.IsPostBack And Request.Form("DocTo_Month") = "" Then Session("DocTo_Month") = 0
                ToDate.SelectedMonth = Session("DocTo_Month")
		
                If IsNumeric(Request.Form("DocTo_Year")) Then
                    Session("DocTo_Year") = Request.Form("DocTo_Year")
                ElseIf IsNumeric(Request.QueryString("DocTo_Year")) Then
                    Session("DocTo_Year") = Request.QueryString("DocTo_Year")
                ElseIf Trim(Session("DocTo_Year")) = "" Then
                    Session("DocTo_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("DocTo_Year") = "" Then Session("DocTo_Year") = 0
                ToDate.SelectedYear = Session("DocTo_Year")
		
                If IsNumeric(Request.Form("MonthYearDate_Day")) Then
                    Session("MonthYearDate_Day") = Request.Form("MonthYearDate_Day")
                ElseIf IsNumeric(Request.QueryString("MonthYearDate_Day")) Then
                    Session("MonthYearDate_Day") = Request.QueryString("MonthYearDate_Day")
                ElseIf Trim(Session("DocDay")) = "" Then
                    Session("MonthYearDate_Day") = DateTime.Now.Day
                End If
                If Page.IsPostBack And Request.Form("MonthYearDate_Day") = "" Then Session("MonthYearDate_Day") = 0
                MonthYearDate.SelectedDay = Session("MonthYearDate_Day")
		
		
                If IsNumeric(Request.Form("MonthYearDate_Month")) Then
                    Session("MonthYearDate_Month") = Request.Form("MonthYearDate_Month")
                ElseIf IsNumeric(Request.QueryString("MonthYearDate_Month")) Then
                    Session("MonthYearDate_Month") = Request.QueryString("MonthYearDate_Month")
                ElseIf Trim(Session("MonthYearDate_Month")) = "" Then
                    Session("MonthYearDate_Month") = DateTime.Now.Month
                End If
                If Page.IsPostBack And Request.Form("MonthYearDate_Month") = "" Then Session("MonthYearDate_Month") = 0
                MonthYearDate.SelectedMonth = Session("MonthYearDate_Month")
		
                If IsNumeric(Request.Form("MonthYearDate_Year")) Then
                    Session("MonthYearDate_Year") = Request.Form("MonthYearDate_Year")
                ElseIf IsNumeric(Request.QueryString("MonthYearDate_Year")) Then
                    Session("MonthYearDate_Year") = Request.QueryString("MonthYearDate_Year")
                ElseIf Trim(Session("MonthYearDate_Year")) = "" Then
                    Session("MonthYearDate_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("MonthYearDate_Year") = "" Then Session("MonthYearDate_Year") = 0
                MonthYearDate.SelectedYear = Session("MonthYearDate_Year")
		
                If Not Page.IsPostBack Then
                    Radio_3.Checked = True
                    ItemNameVal.Text = textTable.Rows(26)("TextParamValue")
                End If

                Dim ShopIDValue As String = "0"
                If IsNumeric(Request.Form("ShopID")) Then
                    ShopIDValue = Request.Form("ShopID").ToString
                ElseIf IsNumeric(Request.QueryString("ShopID")) Then
                    ShopIDValue = Request.QueryString("ShopID").ToString
                End If
			
                Dim i As Integer
                Dim outputString, FormSelected, compareString As String
                Dim SelectString As String
		
                Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn) 'getInfo.GetProductLevel(-999,objCnn)
                If ShopData.Rows.Count > 0 Then

                    outputString = "<select name=""ShopID"">"
                    'If ShopData.Rows.Count > 1 Then
                    '	If Not Page.IsPostBack Then 
                    '		FormSelected = "selected"
                    '		SelShopName.Value = "All Shops"
                    '	ElseIf ShopIDValue = 0 Then
                    '		FormSelected = "selected"
                    '		SelShopName.Value = "All Shops"
                    '	Else
                    '		FormSelected = ""
                    '	End If
                    '	outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All Shops ---"
                    'End If
                    For i = 0 To ShopData.Rows.Count - 1
                        If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
                            FormSelected = "selected"
                            SelShopName.Value = ShopData.Rows(i)("ProductLevelName")
                        Else
                            FormSelected = ""
                        End If
                        outputString += "<option value=""" & ShopData.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & ShopData.Rows(i)("ProductLevelName")
                    Next
                    outputString += "</select>"
                    ShopText.InnerHtml = outputString
                    ShowShop.Visible = True
                Else
                    ShowShop.Visible = False
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
	
        Dim FoundError As Boolean
        FoundError = False
        Dim textTable As New DataTable()
        textTable = getPageText.GetText(12, Session("LangID"), objCnn)
        Dim textTable1 As New DataTable()
        textTable1 = getPageText.GetText(13, Session("LangID"), objCnn)
        Dim textTable2 As New DataTable()
        textTable2 = getPageText.GetText(9, Session("LangID"), objCnn)
			
        Dim defaultTextTable As New DataTable()
        defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
	
        Dim ViewOption As Integer
        Dim DateFromValue As String = ""
        Dim DateToValue As String = ""
        Dim DailyDateValue As String = ""
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	
        Dim StartDate, EndDate As String
        Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
        Dim outputString As String = ""
        Dim grandTotal As Double = 0
        Dim GraphData As New DataSet()
        Dim ReportDate As String
			
        If Radio_1.Checked = True Then
            Try
                If Request.Form("MonthYearDate_Month") = 12 Then
                    StartMonthValue = Request.Form("MonthYearDate_Month")
                    EndMonthValue = 1
                    StartYearValue = Request.Form("MonthYearDate_Year")
                    EndYearValue = Request.Form("MonthYearDate_Year") + 1
                Else
                    StartMonthValue = Request.Form("MonthYearDate_Month")
                    EndMonthValue = Request.Form("MonthYearDate_Month") + 1
                    StartYearValue = Request.Form("MonthYearDate_Year")
                    EndYearValue = Request.Form("MonthYearDate_Year")
                End If
                StartDate = DateTimeUtil.FormatDate(1, StartMonthValue, StartYearValue)
                EndDate = DateTimeUtil.FormatDate(1, EndMonthValue, EndYearValue)
                Dim SDate As New Date(StartYearValue, StartMonthValue, 1)
                ReportDate = Format(SDate, "MMMM yyyy")
                ViewOption = 1
            Catch ex As Exception
                FoundError = True
            End Try
        ElseIf Radio_2.Checked = True Then
            Try
                StartDate = DateTimeUtil.FormatDate(Request.Form("Doc_Day"), Request.Form("Doc_Month"), Request.Form("Doc_Year"))
                Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
                CheckDate = DateAdd("d", 1, CheckDate)
                EndDate = DateTimeUtil.FormatDate(Day(CheckDate), Month(CheckDate), CheckDate.ToString("yyyy", InvC))
		
                If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
                    ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + defaultTextTable.Rows(45)("TextParamValue") + "</td></tr></table>"
                    FoundError = True
                    DateFromValue = ""
                    DateToValue = ""
                    DailyDateValue = ""
                Else
                    ResultSearchText.InnerHtml = ""
                    Dim SDate1 As New Date(Request.Form("Doc_Year"), Request.Form("Doc_Month"), Request.Form("Doc_Day"))
                    Dim EDate1 As New Date(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"))
                    ReportDate = Format(SDate1, "dd MMMM yyyy") + " - " + Format(EDate1, "dd MMMM yyyy")
                End If
                ViewOption = 2
            Catch ex As Exception
                FoundError = True
            End Try
        ElseIf Radio_3.Checked = True Then
            Try
                StartDate = DateTimeUtil.FormatDate(Request.Form("DocDaily_Day"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Year"))
                Dim CheckDate As New DateTime(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"), 0, 0, 0)
                CheckDate = DateAdd("d", 1, CheckDate)
                EndDate = DateTimeUtil.FormatDate(Day(CheckDate), Month(CheckDate), CheckDate.ToString("yyyy", InvC))

                If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
                    ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + defaultTextTable.Rows(45)("TextParamValue") + "</td></tr></table>"
                    FoundError = True
                    DateFromValue = ""
                    DateToValue = ""
                    DailyDateValue = ""
                Else
                    ResultSearchText.InnerHtml = ""
                    Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
                    ReportDate = Format(SDate2, "d MMMM yyyy")
                End If
                ViewOption = 3
            Catch ex As Exception
                FoundError = True
            End Try
        Else
            DateFromValue = ""
            DateToValue = ""
            DailyDateValue = ""
            ViewOption = 0
        End If
	
        If FoundError = False Then
            objDB.sqlExecute("update TextParamValue Set TextParamValue='" + ItemNameVal.Text + "' where TextParamValueID=1752", objCnn)
            Dim displayTable As New DataTable()
		
            showResults.Visible = True
            ShowPrint.Visible = True

            'Application.Lock()
            Dim dtVoidReceipt As DataTable
            Dim rResult() As DataRow
            Dim i, j As Integer
            
            dtVoidReceipt = New DataTable
            Dim dtTable As DataTable = SaleVATReports(StartDate, EndDate, Request.Form("ShopID"), Session("LangID"), ViewOption, _
                                                chkDisplayVoidReceipt.Checked, dtVoidReceipt, objCnn)
            ResultSearchText.InnerHtml = textTable1.Rows(17)("TextParamValue")
            'Application.UnLock()
            Dim GlobalRCHeaderText, GlobalFTHeaderText, GlobalCMHeaderText, HText, RText As String
            Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

            Dim ReceiptHeaderData As DataTable
            ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, 1, objCnn)
            If ReceiptHeaderData.Rows.Count > 0 Then
                If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
                    GlobalRCHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
                End If
            End If
            ReceiptHeaderData = getInfo.GetDocType(1, 0, 11, 1, objCnn)
            If ReceiptHeaderData.Rows.Count > 0 Then
                If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
                    GlobalFTHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
                End If
            End If
            ReceiptHeaderData = getInfo.GetDocType(1, 0, 33, 1, objCnn)
            If ReceiptHeaderData.Rows.Count > 0 Then
                If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
                    GlobalCMHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
                End If
            End If
		
            Dim myDataTable As DataTable = New DataTable("FullTax")
            Dim myDataColumn As DataColumn
            Dim myDataRow As DataRow
	
            myDataColumn = New DataColumn()
            myDataColumn.DataType = System.Type.GetType("System.String")
            myDataColumn.ColumnName = "#"
            myDataColumn.ReadOnly = True
            myDataColumn.Unique = False
            myDataTable.Columns.Add(myDataColumn)
		
            myDataColumn = New DataColumn()
            myDataColumn.DataType = System.Type.GetType("System.String")
            myDataColumn.ColumnName = "Date"
            myDataTable.Columns.Add(myDataColumn)
		
            myDataColumn = New DataColumn()
            myDataColumn.DataType = System.Type.GetType("System.String")
            myDataColumn.ColumnName = "FullTaxInvoice"
            myDataTable.Columns.Add(myDataColumn)
		
            myDataColumn = New DataColumn()
            myDataColumn.DataType = System.Type.GetType("System.String")
            myDataColumn.ColumnName = "TerminalNumber"
            myDataTable.Columns.Add(myDataColumn)
		
            myDataColumn = New DataColumn()
            myDataColumn.DataType = System.Type.GetType("System.String")
            myDataColumn.ColumnName = "RefNo"
            myDataTable.Columns.Add(myDataColumn)

            myDataColumn = New DataColumn()
            myDataColumn.DataType = System.Type.GetType("System.String")
            myDataColumn.ColumnName = "VoidReceiptNo"
            myDataTable.Columns.Add(myDataColumn)
		
            myDataColumn = New DataColumn()
            myDataColumn.DataType = System.Type.GetType("System.String")
            myDataColumn.ColumnName = "CustomerName"
            myDataTable.Columns.Add(myDataColumn)
		
            myDataColumn = New DataColumn()
            myDataColumn.DataType = System.Type.GetType("System.String")
            myDataColumn.ColumnName = "ItemName"
            myDataTable.Columns.Add(myDataColumn)
		
            myDataColumn = New DataColumn()
            myDataColumn.DataType = System.Type.GetType("System.String")
            myDataColumn.ColumnName = "PriceBeforeVAT"
            myDataTable.Columns.Add(myDataColumn)
		
            myDataColumn = New DataColumn()
            myDataColumn.DataType = System.Type.GetType("System.String")
            myDataColumn.ColumnName = "VAT"
            myDataTable.Columns.Add(myDataColumn)
		
            myDataColumn = New DataColumn()
            myDataColumn.DataType = System.Type.GetType("System.String")
            myDataColumn.ColumnName = "SubTotal"
            myDataTable.Columns.Add(myDataColumn)
	
            Dim TotalVAT As Double = 0
            Dim TotalProductDiscount As Double = 0
            Dim TotalSale As Double = 0
            Dim grandTotalBeforeVAT As Double = 0
            Dim grandTotalVAT As Double = 0
            Dim grandTotalAfterVAT As Double = 0
            Dim DateString, InvoiceString, CustomerString, ItemString, ItemValString, VatString, ItemSubTotalString, NoteString, TerminalString As String
            Dim strVoidReceiptNo As String
            Dim MaxRText As String

            For i = 0 To dtTable.Rows.Count - 1
                TotalSale = dtTable.Rows(i)("TransactionVatable")
			
                HText = ""
                If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
                    If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
                        HText = dtTable.Rows(i)("DocumentTypeHeader")
                    End If
                Else
                    HText = GlobalRCHeaderText
                End If
                If IsDBNull(dtTable.Rows(i)("ReceiptID")) Or IsDBNull(dtTable.Rows(i)("ReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("ReceiptYear")) Then
                    RText = "-"
                Else
                    RText = FormatDocNumber.GetReceiptHeader(HText, dtTable.Rows(i)("ReceiptYear"), dtTable.Rows(i)("ReceiptMonth"), dtTable.Rows(i)("ReceiptID"))
                End If
				
                If IsDBNull(dtTable.Rows(i)("MaxReceiptID")) Or IsDBNull(dtTable.Rows(i)("MaxReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("MaxReceiptYear")) Then
                    MaxRText = "- N/A"
                Else
                    MaxRText = " - " + FormatDocNumber.GetReceiptHeader(HText, dtTable.Rows(i)("MaxReceiptYear"), dtTable.Rows(i)("MaxReceiptMonth"), dtTable.Rows(i)("MaxReceiptID"))
                End If
                If Not IsDBNull(dtTable.Rows(i)("RegistrationNumber")) Then
                    TerminalString = dtTable.Rows(i)("RegistrationNumber")
                Else
                    TerminalString = "-"
                End If
				
                If Request.Form("ShopID") = 0 Then
                    DateString = dtTable.Rows(i)("ShopName")
                Else
                    DateString = DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly")
                End If
                InvoiceString = RText + MaxRText
                CustomerString = "-"
                ItemString = ItemNameVal.Text
                ItemValString = Format(TotalSale - dtTable.Rows(i)("TransactionVAT"), "##,##0.00")
                VatString = Format(dtTable.Rows(i)("TransactionVAT"), "##,##0.00")
                ItemSubTotalString = Format(TotalSale, "##,##0.00")
                grandTotalBeforeVAT += Format(TotalSale - dtTable.Rows(i)("TransactionVAT"), "0.00")
                grandTotalVAT += Format(dtTable.Rows(i)("TransactionVAT"), "0.00")
                grandTotalAfterVAT += Format(TotalSale, "0.00")
                NoteString = "-"
    
                myDataRow = myDataTable.NewRow()
                myDataRow("#") = (i + 1).ToString
                myDataRow("FullTaxInvoice") = InvoiceString
                myDataRow("TerminalNumber") = TerminalString
                myDataRow("ItemName") = ItemString
                myDataRow("RefNo") = NoteString
                myDataRow("CustomerName") = CustomerString
                myDataRow("Date") = DateString

			
                myDataRow("PriceBeforeVAT") = ItemValString
                myDataRow("VAT") = VatString
                myDataRow("SubTotal") = ItemSubTotalString
                
                strVoidReceiptNo = ""
                If chkDisplayVoidReceipt.Checked = True Then
                    If dtVoidReceipt.Rows.Count <> 0 Then
                        rResult = dtVoidReceipt.Select("LinkRef = '" & dtTable.Rows(i)("LinkRef") & "'")
                        For j = 0 To rResult.Length - 1
                            If IsDBNull(rResult(j)("DocumentTypeHeader")) Then
                                rResult(j)("DocumentTypeHeader") = ""
                            End If
                            strVoidReceiptNo &= pRoMiSeUtil.pRoMiSeUtil.GetReceiptHeader(rResult(j)("DocumentTypeHeader"), rResult(j)("ReceiptYear"), _
                                                                      rResult(j)("ReceiptMonth"), rResult(j)("ReceiptID")) & ","
                        Next j
                        If strVoidReceiptNo <> "" Then
                            strVoidReceiptNo = Mid(strVoidReceiptNo, 1, Len(strVoidReceiptNo) - 1)
                        End If
                    End If
                End If
                myDataRow("VoidReceiptNo") = strVoidReceiptNo
                
                myDataTable.Rows.Add(myDataRow)
            Next
            myDataRow = myDataTable.NewRow()
            myDataRow("ItemName") = "Grand Total"
            myDataRow("PriceBeforeVAT") = Format(grandTotalBeforeVAT, "##,##0.00")
            myDataRow("VAT") = Format(grandTotalVAT, "##,##0.00")
            myDataRow("SubTotal") = Format(grandTotalAfterVAT, "##,##0.00")
            myDataTable.Rows.Add(myDataRow)
            Results.DataSource = myDataTable
            Results.DataBind()
		
            If chkDisplayVoidReceipt.Checked = False Then
                Results.Columns(POS_VOIDRECEIPTNO).Visible = False
            Else
                Results.Columns(POS_VOIDRECEIPTNO).Visible = True
            End If
            
            Dim sw As New System.IO.StringWriter()
            Dim htw As New System.Web.UI.HtmlTextWriter(sw)
            Results.RenderControl(htw)
		
            Dim CompanyInfo As DataTable
            Dim ShopIDData As Integer = 1
            If Request.Form("ShopID") > 0 Then
                ShopIDData = Request.Form("ShopID")
            End If
            CompanyInfo = getInfo.GetCompanyInfo(ShopIDData, objCnn)
            Dim CompanyInfo1, CompanyInfo2 As String
            Dim Add2 As String = ""
		
            If CompanyInfo.Rows.Count > 0 Then
                CompanyInfo1 += "<table>"
                CompanyInfo1 += "<tr><td class=""text"">" + CompanyInfo.Rows(0)("CompanyName") + "</td></tr>"
                If Not IsDBNull(CompanyInfo.Rows(0)("CompanyAddress1")) Then
                    CompanyInfo1 += "<tr><td class=""text"">" + CompanyInfo.Rows(0)("CompanyAddress1") + "</td></tr>"
                End If
			
                If Not IsDBNull(CompanyInfo.Rows(0)("CompanyAddress2")) Then
                    Add2 += CompanyInfo.Rows(0)("CompanyAddress2")
                End If
                If Not IsDBNull(CompanyInfo.Rows(0)("CompanyCity")) Then
                    If Add2 <> "" Then Add2 += " "
                    Add2 += CompanyInfo.Rows(0)("CompanyCity")
                End If
			
                If Add2 <> "" Then
                    CompanyInfo1 += "<tr><td class=""text"">" + Add2 + "</td></tr>"
                End If
			
                Dim Province As DataTable = objDB.List("select * from provinces where provinceid=" + CompanyInfo.Rows(0)("CompanyProvince").ToString + " and LangID=" + Session("LangID").ToString, objCnn)
			
                Add2 = ""
                If Province.Rows.Count > 0 Then
                    Add2 += Province.Rows(0)("ProvinceName")
                End If
                If Not IsDBNull(CompanyInfo.Rows(0)("CompanyZipcode")) Then
                    If Add2 <> "" Then Add2 += " "
                    Add2 += CompanyInfo.Rows(0)("CompanyZipcode")
                End If
                If Add2 <> "" Then
                    CompanyInfo1 += "<tr><td class=""text"">" + Add2 + "</td></tr>"
                End If

                CompanyInfo1 += "</table>"
			
                CompanyInfo2 = "<table>"
                CompanyInfo2 += "<tr><td class=""text"">" + ReportDate + "</td></tr>"
                If Not IsDBNull(CompanyInfo.Rows(0)("CompanyTaxID")) Then
                    CompanyInfo2 += "<tr><td class=""text"">" + textTable2.Rows(10)("TextParamValue") + "</td></tr>"
                    CompanyInfo2 += "<tr><td class=""text"">" + CompanyInfo.Rows(0)("CompanyTaxID") + "</td></tr>"
                End If
                'CompanyInfo2 += "<tr><td class=""text"">" + "VAT Included" + "</td></tr>"
                CompanyInfo2 += "</table>"
			
            End If
            CompanyInfoText1.InnerHtml = CompanyInfo1
            CompanyInfoText2.InnerHtml = CompanyInfo2
		
            Session("ReportResult") = "<table width=""100%""><tr><td align=""center"">" + ResultSearchText.InnerHtml + "</td></tr><tr><td width=""100%""><table width=""100%""><tr><td valign=""top"" colspan=""7"">" + CompanyInfoText1.InnerHtml + "</td><td align=""right"" valign=""top"" colspan=""2"">" + CompanyInfoText2.InnerHtml + "</td></tr></table></td></tr><tr><td>" + sw.ToString() + "</td></tr></table>"
		
        End If
	
    End Sub

Sub ChangeGridPage(objSender As Object, objArgs As DataGridPageChangedEventArgs)
	
   Results.CurrentPageIndex = objArgs.NewPageIndex

	
End Sub
		
    Private Sub Results_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs)
        Dim textTable As New DataTable()
        textTable = getPageText.GetText(13, Session("LangID"), objCnn)
        Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
        If e.Item.ItemType = ListItemType.Header Then
            e.Item.Cells(0).Text = LangData2.Rows(4)(LangText)
            If Request.Form("ShopID") = 0 Then
                If textTable.Rows.Count > 29 Then
                    e.Item.Cells(1).Text = textTable.Rows(29)("TextParamValue")
                Else
                    e.Item.Cells(1).Text = "Branch"
                End If
            Else
                e.Item.Cells(1).Text = textTable.Rows(18)("TextParamValue")
            End If
            e.Item.Cells(2).Text = LangData2.Rows(6)(LangText)
            e.Item.Cells(3).Text = LangData2.Rows(7)(LangText)
            e.Item.Cells(4).Text = LangData2.Rows(13)(LangText)
            e.Item.Cells(5).Text = LangData2.Rows(8)(LangText)
            e.Item.Cells(6).Text = LangData2.Rows(9)(LangText)
            e.Item.Cells(7).Text = LangData2.Rows(10)(LangText)
            e.Item.Cells(8).Text = LangData2.Rows(11)(LangText)
            e.Item.Cells(9).Text = LangData2.Rows(12)(LangText)
            e.Item.Cells(POS_VOIDRECEIPTNO).Text = POSBackOfficeReport.BackOfficeReport.GetLanguageText(LangData2, 16, LangText, "Void Receipt No.")
        End If
        
    End Sub

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "SaleVATData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub	

    Public Function SaleVATReports(ByVal StartDate As String, ByVal EndDate As String, ByVal ShopID As Integer, ByVal LangID As Integer, ByVal ViewOption As Integer, _
    isIncludeDisplayVoidReceipt As Boolean, ByRef dtVoidReceipt As DataTable, ByVal objCnn As MySqlConnection) As DataTable
        Dim sqlStatement, strSQLVoid As String
        Dim AdditionalQuery, strVoidStatus As String
        Dim ResultString As String = ""
        Dim GetData As DataTable

        Dim getProp As New CPreferences

        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)

        AdditionalQuery = ""
        If ShopID > 0 Then
            AdditionalQuery += " AND a.ShopID IN (" + ShopID.ToString + ")"
        End If

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
        End If

        AdditionalQuery += " AND a.DocType=8"
        strVoidStatus = POSType.TRANSACTION_VOIDALLNOPRODUCE & ", " & POSType.TRANSACTION_VOIDALL

        Dim OrderBy As String = " a.ReceiptYear,a.ReceiptMonth,a.ReceiptID,b.OrderDetailID,d.PayTypeID"

        strSQLVoid = ""
        sqlStatement = ""
        
        objDB.sqlExecute("DROP TABLE IF EXISTS DummyMinMaxTran", objCnn)
        If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
            If ShopID = 0 Then
                objDB.sqlExecute("create table DummyMinMaxTran (ShopID int,ComputerID int, MinID int, MinMonth int, MinYear int, MaxID int, MaxMonth int, MaxYear int)", objCnn)
                sqlStatement = "select a.ShopID,a.CloseComputerID,MIN(a.ReceiptID) AS ReceiptID,MIN(a.ReceiptMonth) AS ReceiptMonth,MIN(a.ReceiptYear) AS ReceiptYear,MAX(a.ReceiptID) AS MaxReceiptID,MAX(a.ReceiptMonth) AS MaxReceiptMonth,MAX(a.ReceiptYear) AS MaxReceiptYear From OrderTransaction a WHERE a.ReceiptID > 0 " + AdditionalQuery + " group by a.ShopID,a.CloseComputerID"

                objDB.sqlExecute("insert into DummyMinMaxTran " + sqlStatement, objCnn)
                sqlStatement = "select a.ShopID,pl.ProductLevelName AS ShopName, CAST(Concat(e.ShopID, ':', a.CloseComputerID) AS CHAR) as LinkRef, " & _
                             " a.CloseComputerID AS ComputerID,t.RegistrationNumber,e.ReceiptID,e.ReceiptMonth, " & _
                             " e.ReceiptYear,e.MaxReceiptID,e.MaxReceiptMonth,e.MaxReceiptYear,DocumentTypeHeader,SUM(a.TransactionVatable) AS TransactionVatable, " & _
                             " SUM(a.TransactionVAT) AS TransactionVAT " & _
                             " from ordertransaction a inner join (select a.ShopID,a.CloseComputerID As ComputerID, " & _
                             "   MIN(a.ReceiptID) AS ReceiptID,MIN(a.ReceiptMonth) AS ReceiptMonth,MIN(a.ReceiptYear) AS ReceiptYear,MAX(a.ReceiptID) AS MaxReceiptID, " & _
                             "   MAX(a.ReceiptMonth) AS MaxReceiptMonth,MAX(a.ReceiptYear) AS MaxReceiptYear " & _
                             "   From OrderTransaction a WHERE a.ReceiptID > 0 " + AdditionalQuery & _
                             "   group by a.ShopID,a.CloseComputerID) e ON a.ShopID=e.ShopID AND a.CloseComputerID=e.ComputerID " & _
                             " inner join ComputerName t ON a.CloseComputerID=t.ComputerID " & _
                             " inner join ProductLevel pl ON a.ShopID=pl.ProductLevelID " & _
                             " left outer join DocumentType dt ON a.DocType=dt.DocumentTypeID AND a.CloseComputerID=dt.ComputerID " & _
                             " where a.TransactionStatusID=2 AND a.ReceiptID > 0 AND dt.LangID=" + LangID.ToString + AdditionalQuery & _
                             " group by a.ShopID,pl.ProductLevelName,a.CloseComputerID,t.RegistrationNumber " & _
                             " Order By a.ShopID,a.CloseComputerID"

                strSQLVoid = "Select a.ShopID, CAST(Concat(e.ShopID, ':', a.CloseComputerID) AS CHAR) as LinkRef, " & _
                            "a.CloseComputerID, dt.DocumentTypeHeader, a.ReceiptYear, a.ReceiptMonth, a.ReceiptID " & _
                            "From OrderTransaction a LEFT OUTER JOIN DocumentType dt ON " & _
                            " a.DocType = dt.DocumentTypeID AND dt.ShopID = 0 AND a.CloseComputerID = dt.ComputerID AND dt.LangID = 1 " & _
                            "Where a.TransactionStatusID IN (" & strVoidStatus & ") " & AdditionalQuery & _
                            " Order By a.ShopID, a.CloseComputerID, a.SaleDate, a.ReceiptYear, a.ReceiptMonth, a.ReceiptID "
                
            Else
                sqlStatement = "select a.SaleDate, a.SaleDate, Day(a.SaleDate) as SaleDay, Month(a.SaleDate) as SaleMonth, Year(a.SaleDate) as SaleYear, " & _
                            " CAST(Concat(a.ShopID, ':', a.CloseComputerID, ':', Day(a.SaleDate), ':', Month(a.SaleDate), ':', Year(a.SaleDate)) AS CHAR) as LinkRef, " & _
                            " a.CloseComputerID AS ComputerID,t.RegistrationNumber,e.ReceiptID,e.ReceiptMonth,e.ReceiptYear,e.MaxReceiptID,e.MaxReceiptMonth, " & _
                            " e.MaxReceiptYear,DocumentTypeHeader,SUM(a.TransactionVatable) AS TransactionVatable,SUM(a.TransactionVAT) AS TransactionVAT " & _
                            " from ordertransaction a inner join (select a.SaleDate,a.CloseComputerID AS ComputerID,MIN(a.ReceiptID) AS ReceiptID, " & _
                            "   MIN(a.ReceiptMonth) AS ReceiptMonth,MIN(a.ReceiptYear) AS ReceiptYear,MAX(a.ReceiptID) AS MaxReceiptID,MAX(a.ReceiptMonth) AS MaxReceiptMonth, " & _
                            "   MAX(a.ReceiptYear) AS MaxReceiptYear From OrderTransaction a WHERE a.ReceiptID > 0 " + AdditionalQuery & _
                            "   group by a.SaleDate,a.CloseComputerID) e ON a.SaleDate=e.SaleDate AND a.CloseComputerID=e.ComputerID " & _
                            " inner join ComputerName t ON a.CloseComputerID=t.ComputerID " & _
                            " left outer join DocumentType dt ON a.DocType=dt.DocumentTypeID AND a.CloseComputerID=dt.ComputerID " & _
                            " where a.TransactionStatusID=2 AND a.ReceiptID > 0 AND dt.LangID=" + LangID.ToString + AdditionalQuery & _
                            " group by a.SaleDate,a.CloseComputerID,t.RegistrationNumber " & _
                            " Order By a.SaleDate,a.CloseComputerID"
                
                strSQLVoid = "Select a.ShopID, a.SaleDate, Day(a.SaleDate) as SaleDay, Month(a.SaleDate) as SaleMonth, Year(a.SaleDate) as SaleYear, " & _
                            "CAST(Concat(a.ShopID, ':', a.CloseComputerID, ':', Day(a.SaleDate), ':', Month(a.SaleDate), ':', Year(a.SaleDate)) AS CHAR) as LinkRef, " & _
                            " a.CloseComputerID, dt.DocumentTypeHeader, a.ReceiptYear, a.ReceiptMonth, a.ReceiptID " & _
                            "From OrderTransaction a LEFT OUTER JOIN DocumentType dt ON " & _
                            " a.DocType = dt.DocumentTypeID AND dt.ShopID = 0 AND a.CloseComputerID = dt.ComputerID AND dt.LangID = 1 " & _
                            "Where a.TransactionStatusID IN (" & strVoidStatus & ") " & AdditionalQuery & _
                            " Order By a.ShopID, a.SaleDate, a.CloseComputerID, a.ReceiptYear, a.ReceiptMonth, a.ReceiptID "
            End If
        Else
            'objDB.sqlExecute("create table DummyMinMaxTran (SaleDate date, MinID int, MinMonth int, MinYear int, MaxID int, MaxMonth int, MaxYear int)", objCnn)
            'sqlStatement = "select a.SaleDate,MIN(a.ReceiptID) AS ReceiptID,MIN(a.ReceiptMonth) AS ReceiptMonth,MIN(a.ReceiptYear) AS ReceiptYear,MAX(a.ReceiptID) AS MaxReceiptID,MAX(a.ReceiptMonth) AS MaxReceiptMonth,MAX(a.ReceiptYear) AS MaxReceiptYear From OrderTransaction" + BranchStr + " a WHERE a.ReceiptID > 0 " + AdditionalQuery + " group by a.SaleDate Order By a.SaleDate"

            'objDB.sqlExecute("insert into DummyMinMaxTran " + sqlStatement, objCnn)
            'sqlStatement = "select a.SaleDate,MinID AS ReceiptID,MinMonth AS ReceiptMonth,MinYear AS ReceiptYear,MaxID AS MaxReceiptID,MaxMonth AS MaxReceiptMonth,MaxYear AS MaxReceiptYear,DocumentTypeHeader,SUM(a.TransactionVatable) AS TransactionVatable,SUM(a.TransactionVAT) AS TransactionVAT,'' AS RegistrationNumber from ordertransaction" + BranchStr + " a , DummyMinMaxTran e left outer join DocumentType dt ON a.DocType=dt.DocumentTypeID AND a.CloseComputerID=dt.ComputerID  where a.SaleDate=e.SaleDate AND a.TransactionStatusID=2 AND a.ReceiptID > 0 AND dt.LangID=" + LangID.ToString + AdditionalQuery + " group by a.SaleDate Order By a.SaleDate"

        End If

        If sqlStatement <> "" Then
            GetData = objDB.List(sqlStatement, objCnn)
        Else
            GetData = New DataTable
        End If
        
        If isIncludeDisplayVoidReceipt = False Then
            strSQLVoid = ""
        End If

        If strSQLVoid <> "" Then
            dtVoidReceipt = objDB.List(strSQLVoid, objCnn)
        Else
            dtVoidReceipt = New DataTable
        End If

        objDB.sqlExecute("DROP TABLE IF EXISTS DummyDocType", objCnn)
        objDB.sqlExecute("DROP TABLE IF EXISTS DummyMinMaxTran", objCnn)
        Return GetData


    End Function

Sub Page_UnLoad()
	objCnn.Close()
End Sub
</script>
</body>
</html>
