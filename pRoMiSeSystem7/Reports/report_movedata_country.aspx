<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="pRoMiSeReports.pRoMiSeReports" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Move Data History Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="FrontSystemType" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Sale Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
<div class="noprint">
<table>
<tr id="ShowShop" runat="server">
	<td valign="top">
		<table>
			<tr>
				<td><span id="ShopText" runat="server"></span></td>
			</tr>
			<tr>
				<td><asp:DropDownList ID="ViewTypeList" CssClass="text" Width="150" runat="server">
						<asp:listitem></asp:listitem>
						<asp:listitem></asp:listitem>
						<asp:listitem></asp:listitem>
						<asp:listitem></asp:listitem>
				</asp:DropDownList></td>
			</tr>
			<tr>
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
			</tr>


		</table></td>
	<td>
	<table>
		<tr>
			<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
			<td colspan="4"><synature:date id="DailyDate" runat="server" /></td>
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
<br>
</div>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
<tr><td align="left">
<div id="ResultSearchText" class="boldText" runat="server"></div></td></tr></table>

	<asp:DataGrid ID="Results" AutoGenerateColumns="false" CellPadding="3" CssClass="smalltext" HeaderStyle-BackColor="#507093" HeaderStyle-CssClass="smallTdHeader" HeaderStyle-HorizontalAlign="center" AllowPaging="false" OnItemDataBound="Results_ItemDataBound"  runat="server">
		<columns>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="FromTableName"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="ToTableName"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="OperationCode"></asp:BoundColumn>  
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="ProductName"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="OriginalAmount"></asp:BoundColumn>  
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="MoveAmount"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="MoveStaff"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="MoveDateTime"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="MoveFromReference"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="MoveToReference"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="HistoryNote"></asp:BoundColumn>
		</columns>
	</asp:DataGrid>

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

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim DBUtil As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim pRoMiSeReport As New ReportModule()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Report_MoveData") Then
		
	Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		FrontSystemType.Value = PropertyInfo.Rows(0)("FrontSystemType")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)

		SubmitForm.Text = textTable.Rows(8)("TextParamValue")
		
		DocumentToDateParam.InnerHtml = defaultTextTable.Rows(91)("TextParamValue")
		
		HeaderText.InnerHtml = "Move Table and/or Order Report"
			
		DailyDate.YearType = GlobalParam.YearType
		DailyDate.FormName = "DocDaily"
		DailyDate.StartYear = 1
		DailyDate.EndYear = 2
		DailyDate.LangID = Session("LangID")
		DailyDate.Lang_Data = LangDefault
		DailyDate.Culture = CultureString
		
		CurrentDate.YearType = GlobalParam.YearType
		CurrentDate.FormName = "Doc"
		CurrentDate.StartYear = 1
		CurrentDate.EndYear = 2
		CurrentDate.LangID = Session("LangID")
		CurrentDate.Lang_Data = LangDefault
		CurrentDate.Culture = CultureString
		
		ToDate.YearType = GlobalParam.YearType
		ToDate.FormName = "DocTo"
		ToDate.StartYear = 1
		ToDate.EndYear = 2
		ToDate.LangID = Session("LangID")
		ToDate.Lang_Data = LangDefault
		ToDate.Culture = CultureString
		
		MonthYearDate.YearType = GlobalParam.YearType
		MonthYearDate.FormName = "MonthYearDate"
		MonthYearDate.StartYear = 1
		MonthYearDate.EndYear = 2
		MonthYearDate.LangID = Session("LangID")
		MonthYearDate.ShowDay = False
		
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		
		ViewTypeList.Items(0).Text = "-- Display All Types --"
		ViewTypeList.Items(0).Value = "0"
		ViewTypeList.Items(1).Text = "Only Move Table"
		ViewTypeList.Items(1).Value = "1"
		ViewTypeList.Items(2).Text = "Only Move Order"
		ViewTypeList.Items(2).Value = "2"
		ViewTypeList.Items(3).Text = "Only Delete Order"
		ViewTypeList.Items(3).Value = "3"
		
		If IsNumeric(Request.Form("DocDaily_Day")) Then 
			Session("DocDailyDay") = Request.Form("DocDaily_Day")
		Else If IsNumeric(Request.QueryString("DocDaily_Day")) Then 
			Session("DocDailyDay") = Request.QueryString("DocDaily_Day")
		Else If Trim(Session("DocDailyDay")) = "" Then
			Session("DocDailyDay") = DateTime.Now.Day
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Day") = "" Then Session("DocDailyDay") = 0
		DailyDate.SelectedDay = Session("DocDailyDay")
		
		
		If IsNumeric(Request.Form("DocDaily_Month")) Then 
			Session("DocDaily_Month") = Request.Form("DocDaily_Month")
		Else If IsNumeric(Request.QueryString("DocDaily_Month")) Then 
			Session("DocDaily_Month") = Request.QueryString("DocDaily_Month")
		Else If Trim(Session("DocDaily_Month")) = "" Then
			Session("DocDaily_Month") = DateTime.Now.Month
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Month") = "" Then Session("DocDaily_Month") = 0
		DailyDate.SelectedMonth = Session("DocDaily_Month")
		
		If IsNumeric(Request.Form("DocDaily_Year")) Then 
			Session("DocDaily_Year") = Request.Form("DocDaily_Year")
		Else If IsNumeric(Request.QueryString("DocDaily_Year")) Then 
			Session("DocDaily_Year") = Request.QueryString("DocDaily_Year")
		Else If Trim(Session("DocDaily_Year")) = "" Then
			Session("DocDaily_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("DocDaily_Year") = "" Then Session("DocDaily_Year") = 0
		DailyDate.SelectedYear = Session("DocDaily_Year")
		
		If IsNumeric(Request.Form("Doc_Day")) Then 
			Session("DocDay") = Request.Form("Doc_Day")
		Else If IsNumeric(Request.QueryString("Doc_Day")) Then 
			Session("DocDay") = Request.QueryString("Doc_Day")
		Else If Trim(Session("DocDay")) = "" Then
			Session("DocDay") = DateTime.Now.Day
		End If
		If Page.IsPostBack AND Request.Form("Doc_Day") = "" Then Session("DocDay") = 0
		CurrentDate.SelectedDay = Session("DocDay")
		
		
		If IsNumeric(Request.Form("Doc_Month")) Then 
			Session("Doc_Month") = Request.Form("Doc_Month")
		Else If IsNumeric(Request.QueryString("Doc_Month")) Then 
			Session("Doc_Month") = Request.QueryString("Doc_Month")
		Else If Trim(Session("Doc_Month")) = "" Then
			Session("Doc_Month") = DateTime.Now.Month
		End If
		If Page.IsPostBack AND Request.Form("Doc_Month") = "" Then Session("Doc_Month") = 0
		CurrentDate.SelectedMonth = Session("Doc_Month")
		
		If IsNumeric(Request.Form("Doc_Year")) Then 
			Session("Doc_Year") = Request.Form("Doc_Year")
		Else If IsNumeric(Request.QueryString("Doc_Year")) Then 
			Session("Doc_Year") = Request.QueryString("Doc_Year")
		Else If Trim(Session("Doc_Year")) = "" Then
			Session("Doc_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("Doc_Year") = "" Then Session("Doc_Year") = 0
		CurrentDate.SelectedYear = Session("Doc_Year")
		
		If IsNumeric(Request.Form("DocTo_Day")) Then 
			Session("DocTo_Day") = Request.Form("DocTo_Day")
		Else If IsNumeric(Request.QueryString("DocTo_Day")) Then 
			Session("DocTo_Day") = Request.QueryString("DocTo_Day")
		Else If Trim(Session("DocTo_Day")) = "" Then
			Session("DocTo_Day") = DateTime.Now.Day
		End If
		If Page.IsPostBack AND Request.Form("DocTo_Day") = "" Then Session("DocTo_Day") = 0
		ToDate.SelectedDay = Session("DocTo_Day")
		
		
		If IsNumeric(Request.Form("DocTo_Month")) Then 
			Session("DocTo_Month") = Request.Form("DocTo_Month")
		Else If IsNumeric(Request.QueryString("DocTo_Month")) Then 
			Session("DocTo_Month") = Request.QueryString("DocTo_Month")
		Else If Trim(Session("DocTo_Month")) = "" Then
			Session("DocTo_Month") = DateTime.Now.Month
		End If
		If Page.IsPostBack AND Request.Form("DocTo_Month") = "" Then Session("DocTo_Month") = 0
		ToDate.SelectedMonth = Session("DocTo_Month")
		
		If IsNumeric(Request.Form("DocTo_Year")) Then 
			Session("DocTo_Year") = Request.Form("DocTo_Year")
		Else If IsNumeric(Request.QueryString("DocTo_Year")) Then 
			Session("DocTo_Year") = Request.QueryString("DocTo_Year")
		Else If Trim(Session("DocTo_Year")) = "" Then
			Session("DocTo_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("DocTo_Year") = "" Then Session("DocTo_Year") = 0
		ToDate.SelectedYear = Session("DocTo_Year")
		
		If IsNumeric(Request.Form("MonthYearDate_Day")) Then 
			Session("MonthYearDate_Day") = Request.Form("MonthYearDate_Day")
		Else If IsNumeric(Request.QueryString("MonthYearDate_Day")) Then 
			Session("MonthYearDate_Day") = Request.QueryString("MonthYearDate_Day")
		Else If Trim(Session("DocDay")) = "" Then
			Session("MonthYearDate_Day") = DateTime.Now.Day
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate_Day") = "" Then Session("MonthYearDate_Day") = 0
		MonthYearDate.SelectedDay = Session("MonthYearDate_Day")
		
		
		If IsNumeric(Request.Form("MonthYearDate_Month")) Then 
			Session("MonthYearDate_Month") = Request.Form("MonthYearDate_Month")
		Else If IsNumeric(Request.QueryString("MonthYearDate_Month")) Then 
			Session("MonthYearDate_Month") = Request.QueryString("MonthYearDate_Month")
		Else If Trim(Session("MonthYearDate_Month")) = "" Then
			Session("MonthYearDate_Month") = DateTime.Now.Month
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate_Month") = "" Then Session("MonthYearDate_Month") = 0
		MonthYearDate.SelectedMonth = Session("MonthYearDate_Month")
		
		If IsNumeric(Request.Form("MonthYearDate_Year")) Then 
			Session("MonthYearDate_Year") = Request.Form("MonthYearDate_Year")
		Else If IsNumeric(Request.QueryString("MonthYearDate_Year")) Then 
			Session("MonthYearDate_Year") = Request.QueryString("MonthYearDate_Year")
		Else If Trim(Session("MonthYearDate_Year")) = "" Then
			Session("MonthYearDate_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate_Year") = "" Then Session("MonthYearDate_Year") = 0
		MonthYearDate.SelectedYear = Session("MonthYearDate_Year")
		
		If Not Page.IsPostBack Then
			Radio_3.Checked = True
		End If

		Dim ShopIDValue As String = "0"
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If
			
		Dim i As Integer
		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		Dim Multiple As Boolean = False
		Dim ShopData As DataTable = getInfo.GetProductLevel(-999,objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"">"
			For i = 0 to ShopData.Rows.Count - 1
				If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
					FormSelected = "selected"
					SelShopName.Value = ShopData.Rows(i)("ProductLevelName")
				Else
					If Not Page.IsPostBack And i=0 And Multiple = False Then
						FormSelected = "selected"
					Else
						FormSelected = ""
					End If
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
	Session("ReportResult") = ""
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(12,Session("LangID"),objCnn)
			
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	Dim DailyDateValue As String = ""
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
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
		StartDate = DateTimeUtil.FormatDate(1,StartMonthValue,StartYearValue)
		EndDate = DateTimeUtil.FormatDate(1,EndMonthValue,EndYearValue)
		Dim SDate As New Date(StartYearValue,StartMonthValue,1)
		ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy",Session("LangID"),objCnn)
		Catch ex As Exception
			FoundError = True
		End Try
	ElseIf Radio_2.Checked = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(Request.Form("Doc_Day"),Request.Form("Doc_Month"),Request.Form("Doc_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
		
		If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
			FoundError = True
			DateFromValue = ""
			DateToValue = ""
			DailyDateValue = ""
		Else
			ResultSearchText.InnerHtml = ""
			Dim SDate1 As New Date(Request.Form("Doc_Year"), Request.Form("Doc_Month"), Request.Form("Doc_Day"))
			Dim EDate1 As New Date(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"))
			ReportDate = DateTimeUtil.FormatDateTime(SDate1, "DateOnly",Session("LangID"),objCnn) + " - " + DateTimeUtil.FormatDateTime(EDate1, "DateOnly",Session("LangID"),objCnn)
		End If
		Catch ex As Exception
			FoundError = True
		End Try
	Else If Radio_3.Checked = True Then
		Try
		StartDate = DateTimeUtil.FormatDate(Request.Form("DocDaily_Day"),Request.Form("DocDaily_Month"),Request.Form("DocDaily_Year"))
		Dim CheckDate As New DateTime(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"), 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))

		If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
			FoundError = True
			DateFromValue = ""
			DateToValue = ""
			DailyDateValue = ""
		Else
			ResultSearchText.InnerHtml = ""
			Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
			ReportDate = DateTimeUtil.FormatDateTime(SDate2, "DateOnly",Session("LangID"),objCnn)
		End If
		Catch ex As Exception
			FoundError = True
		End Try
	Else
		DateFromValue = ""
		DateToValue = ""
		DailyDateValue = ""
	End If	
	If FoundError = False Then
		showPrint.Visible = True
		Dim ShopDisplay As String
		If Request.Form("ShopID") = 0 Then
			ShopDisplay = "All Shops"
		Else
			ShopDisplay = SelShopName.Value
		End If
		ResultSearchText.InnerHtml = "Move Table and/or Order Report of " + ShopDisplay + " (" + ReportDate + ")"
		
		Dim MoveTable As Boolean = True
		Dim MoveOrder As Boolean = True
		Dim DelOrder As Boolean = True
		
		If ViewTypeList.SelectedItem.Value = 1 Then
			MoveTable = True
			MoveOrder = False
			DelOrder = False
		ElseIf ViewTypeList.SelectedItem.Value = 2 Then
			MoveTable = False
			MoveOrder = True
			DelOrder = False
		ElseIf ViewTypeList.SelectedItem.Value = 3 Then
			MoveTable = False
			MoveOrder = False
			DelOrder = True
		End If
		Dim dtTable As DataTable 
		dtTable = CreateHistoryOfOrderReport(objCnn, Request.Form("ShopID"), StartDate, EndDate, Request.Form("FrontSystemType"), 999, MoveTable, MoveOrder, DelOrder, 1)
		Dim displayTable As DataTable 
		displayTable = CreateHistoryOrderReportDataTable(dtTable, Request.Form("ShopID"), Session("LangID"), objCnn)

		Results.DataSource = displayTable
		Results.DataBind()
	End If
	
End Sub

Private Sub Results_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) 
	
	If e.Item.ItemType = ListItemType.Header Then
		e.Item.Cells(0).Text = "From Table"
		e.Item.Cells(1).Text = "To Table"
		e.Item.Cells(2).Text = "Opt Code"
		e.Item.Cells(3).Text = "Product Name"
		e.Item.Cells(4).Text = "Org Qty"
		e.Item.Cells(5).Text = "Move Qty"
		e.Item.Cells(6).Text = "Staff Name"
		e.Item.Cells(7).Text = "Time"
		e.Item.Cells(8).Text = "Move From Ref"
		e.Item.Cells(9).Text = "Move To Ref"
		e.Item.Cells(10).Text = "Reason"
	End If
End Sub

Public Function CreateHistoryOfOrderReport(ByVal objCnn As MySqlConnection, ByVal shopID As Integer, _
    ByVal startSaleDate As String, ByVal endSaleDate As String, ByVal fSystemType As Integer, _
    ByVal posComID As Integer, ByVal viewMoveTable As Boolean, ByVal viewMoveOrder As Boolean, _
    ByVal viewDeleteOrder As Boolean, ByVal LangID As Integer) As DataTable
            Dim strSQL As String
            Dim strTemp, strReceipt As String
            Dim dtResult As DataTable

            If startSaleDate <> "" Then
                strTemp = " AND SaleDate >= " & startSaleDate & " "
            End If
            If endSaleDate <> "" Then
                strTemp &= " AND SaleDate < " & endSaleDate & " "
            End If

            '**********************************************************************************
            ' Generate MoveTable/ Order Data Section
            'Create table Temp for Select Transaction
            strSQL = "Drop Table If Exists SelectTransactionTemp" & posComID & ";"
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Create Table If Not Exists SelectTransactionTemp" & posComID & _
                    " (TransactionID int NOT NULL, ComputerID int NOT NULL); "
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Insert INTO SelectTransactionTemp" & posComID & _
                    " Select TransactionID, ComputerID " & _
                    "From OrderTransaction " & _
                    "Where ShopID = " & shopID & strTemp
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Insert INTO SelectTransactionTemp" & posComID & _
                    " Select TransactionID, ComputerID " & _
                    "From OrderTransactionFront " & _
                    "Where ShopID = " & shopID & strTemp
            DBUtil.sqlExecute(strSQL, objCnn)

            'Create table Temp for MoveTableTemp
            strSQL = "Drop Table If Exists MoveTableTemp" & posComID & ";"
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Create Table If Not Exists MoveTableTemp" & posComID & _
                    " (TransactionID int NOT NULL, ComputerID int NOT NULL, TableID int NOT NULL, " & _
                    " TableName varchar(100), ToTransactionID int NOT NULL, ToComputerID int NOT NULL, " & _
                    " ToTableID int NOT NULL, ToTableName varchar(100), MoveStaffID int NOT NULL, " & _
                    " MoveStaffCode varchar(20) NULL, MoveStaffFirstName varchar(50), MoveStaffLastName varchar(50), " & _
                    " MoveDateTime datetime, FrontFunctionID int NOT NULL, HistoryNote varchar(255) NULL); "
            DBUtil.sqlExecute(strSQL, objCnn)
            If viewMoveTable = True Then
                strSQL = "Insert INTO MoveTableTemp" & posComID & _
                        " Select hmt.TransactionID, hmt.ComputerID, hmt.TableID, t1.TableName, hmt.ToTransactionID, " & _
                        " hmt.ToComputerID, hmt.ToTableID, t2.TableName, hmt.MoveStaffID, s.StaffCode, " & _
                        " s.StaffFirstName, s.StaffLastName, hmt.MoveDateTime, hmt.FrontFunctionID, hmt.HistoryNote " & _
                        "From SelectTransactionTemp" & posComID & " ot, HistoryOfMoveTable hmt, Staffs s, " & _
                        " TableNo t1, TableNo t2 " & _
                        "Where ot.TransactionID = hmt.TransactionID AND ot.ComputerID = hmt.ComputerID AND " & _
                        " s.StaffID = hmt.MoveStaffID AND t1.TableID = hmt.TableID AND t2.TableID = hmt.ToTableID "
                DBUtil.sqlExecute(strSQL, objCnn)
            End If

            'Create table Temp for MoveOrderTemp
            strSQL = "Drop Table If Exists MoveOrderTemp" & posComID & ";"
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Create Table If Not Exists MoveOrderTemp" & posComID & _
                    " (TransactionID int NOT NULL, ComputerID int NOT NULL, TableID int NOT NULL, ProductID int NOT NULL, " & _
                    " ProductName varchar(100), OrderAmount decimal(18,4), ToTransactionID int NOT NULL, " & _
                    " ToComputerID int NOT NULL, ToTableID int NOT NULL, MoveAmount decimal(18,4), MoveStaffID int NOT NULL, " & _
                    " MoveStaffCode varchar(20) NULL, MoveStaffFirstName varchar(50), MoveStaffLastName varchar(50), " & _
                    " MoveDateTime datetime, FrontFunctionID int NOT NULL, HistoryNote varchar(255) NULL); "
            DBUtil.sqlExecute(strSQL, objCnn)
            If viewMoveOrder = True Then
                'For Normal Product
                strSQL = "Insert INTO MoveOrderTemp" & posComID & _
                        " Select hmo.TransactionID, hmo.ComputerID, hmo.TableID, hmo.ProductID, p.ProductName, " & _
                        " hmo.OrderAmount, hmo.ToTransactionID, hmo.ToComputerID, hmo.ToTableID, hmo.MoveAmount, " & _
                        " hmo.MoveStaffID, s.StaffCode, s.StaffFirstName, s.StaffLastName, hmo.MoveDateTime, " & _
                        " hmo.FrontFunctionID, hmo.HistoryNote " & _
                        "From SelectTransactionTemp" & posComID & " ot, HistoryOfMoveOrderDetail hmo, " & _
                        " Staffs s, Products p " & _
                        "Where ot.TransactionID = hmo.TransactionID AND ot.ComputerID = hmo.ComputerID AND " & _
                        " s.StaffID = hmo.MoveStaffID AND p.ProductID = hmo.ProductID AND hmo.ProductID <> 0 AND " & _
                        " hmo.FrontFunctionID IN (10,13) "
                DBUtil.sqlExecute(strSQL, objCnn)
                'For Other Product
                strSQL = "Insert INTO MoveOrderTemp" & posComID & _
                        " Select hmo.TransactionID, hmo.ComputerID, hmo.TableID, hmo.ProductID, hmo.OtherProductName, " & _
                        " hmo.OrderAmount, hmo.ToTransactionID, hmo.ToComputerID, hmo.ToTableID, hmo.MoveAmount, " & _
                        " hmo.MoveStaffID, s.StaffCode, s.StaffFirstName, s.StaffLastName, hmo.MoveDateTime, " & _
                        " hmo.FrontFunctionID, hmo.HistoryNote " & _
                        "From SelectTransactionTemp" & posComID & " ot, HistoryOfMoveOrderDetail hmo, " & _
                        " Staffs s " & _
                        "Where ot.TransactionID = hmo.TransactionID AND ot.ComputerID = hmo.ComputerID AND " & _
                        " s.StaffID = hmo.MoveStaffID AND hmo.ProductID = 0 AND " & _
                        " hmo.FrontFunctionID IN (10,13) "
                DBUtil.sqlExecute(strSQL, objCnn)
            End If

            'Create table Temp for DeleteOrderTemp
            strSQL = "Drop Table If Exists DeleteOrderTemp" & posComID & ";"
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Create Table If Not Exists DeleteOrderTemp" & posComID & _
                    " (TransactionID int NOT NULL, ComputerID int NOT NULL, TableID int NOT NULL, ProductID int NOT NULL, " & _
                    " ProductName varchar(100), DeleteAmount decimal(10,4) NOT NULL, DeleteStaffID int NOT NULL, " & _
                    " DeleteStaffCode varchar(20) NULL, DeleteStaffFirstName varchar(50), DeleteStaffLastName varchar(50), " & _
                    " DeleteDateTime datetime, FrontFunctionID int NOT NULL, HistoryNote varchar(255) NULL); "
            DBUtil.sqlExecute(strSQL, objCnn)
            'For Delete/Void Product (FrontFunction = 1/7)
            If viewDeleteOrder = True Then
                strSQL = "Insert INTO DeleteOrderTemp" & posComID & _
                        " Select hcs.TransactionID, hcs.ComputerID, hcs.TableID, hcs.ProductID, hcs.ProductName, " & _
                        " hcs.OrderAmount, hcs.StaffID, s.StaffCode, s.StaffFirstName, s.StaffLastName, hcs.ChangeDateTime, " & _
                        " hcs.FrontFunctionID, hcs.HistoryNote " & _
                        "From SelectTransactionTemp" & posComID & " ot, HistoryOfChangeDetailSubmitOrder hcs, Staffs s " & _
                        "Where ot.TransactionID = hcs.TransactionID AND ot.ComputerID = hcs.ComputerID AND " & _
                        " s.StaffID = hcs.StaffID AND hcs.FrontFunctionID IN (1,6,7,27,28) "
                DBUtil.sqlExecute(strSQL, objCnn)
            End If

            'Create table Temp for TransactionID/ComputerID that has invole in MoveFrom/To Table and Order
            strSQL = "Delete From SelectTransactionTemp" & posComID & ";"
            DBUtil.sqlExecute(strSQL, objCnn)
            'From MoveTable Temp
            If viewMoveTable = True Then
                strSQL = "Insert INTO SelectTransactionTemp" & posComID & _
                        " Select TransactionID, ComputerID " & _
                        "From MoveTableTemp" & posComID
                DBUtil.sqlExecute(strSQL, objCnn)
                strSQL = "Insert INTO SelectTransactionTemp" & posComID & _
                        " Select ToTransactionID, ToComputerID " & _
                        "From MoveTableTemp" & posComID
                DBUtil.sqlExecute(strSQL, objCnn)
            End If
            'From Move Order Temp
            If viewMoveOrder = True Then
                strSQL = "Insert INTO SelectTransactionTemp" & posComID & _
                        " Select TransactionID, ComputerID " & _
                        "From MoveOrderTemp" & posComID
                DBUtil.sqlExecute(strSQL, objCnn)
                strSQL = "Insert INTO SelectTransactionTemp" & posComID & _
                        " Select ToTransactionID, ToComputerID " & _
                        "From MoveOrderTemp" & posComID
                DBUtil.sqlExecute(strSQL, objCnn)
            End If
            'From Delete Order Temp
            If viewDeleteOrder = True Then
                strSQL = "Insert INTO SelectTransactionTemp" & posComID & _
                         " Select TransactionID, ComputerID " & _
                         "From DeleteOrderTemp" & posComID
                DBUtil.sqlExecute(strSQL, objCnn)
            End If
            '****************************************************************************
            ' Get TransactionDetail Section
            'Create Temp Table for Distinct TransactionID, ComputerID from SelectTransactionTemp
            strSQL = "Drop Table If Exists MoveTransTemp" & posComID & ";"
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Create Table If Not Exists MoveTransTemp" & posComID & _
                    " (TransactionID int NOT NULL, ComputerID int NOT NULL); "
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Insert INTO MoveTransTemp" & posComID & _
                    " Select Distinct TransactionID, ComputerID " & _
                    "From SelectTransactionTemp" & posComID
            DBUtil.sqlExecute(strSQL, objCnn)

            'Create Temp Table For TransactionDetail from MoveTransTemp
            strSQL = "Drop Table If Exists MoveTransactionDetailTemp" & posComID & ";"
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Create Table If Not Exists MoveTransactionDetailTemp" & posComID & _
                    " (TransactionID int NOT NULL, ComputerID int NOT NULL, DocType int NOT NULL, " & _
                    " ReceiptYear int NOT NULL, ReceiptMonth tinyint NOT NULL, ReceiptID int NOT NULL, " & _
                    " DocumentTypeHeader varchar(20) NULL, TransactionStatusID int NOT NULL, SaleDate Date NULL, " & _
                    " ShopID int NOT NULL); "
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "ALTER TABLE MoveTransactionDetailTemp" & posComID & " ADD INDEX MoveTransDetailIndex (TransactionID, ComputerID);"
            DBUtil.sqlExecute(strSQL, objCnn)
            'The shop is in one system. Use main header
            If fSystemType = 0 Then
                strReceipt = " AND dt.ComputerID = 0 "
            ElseIf fSystemType = 1 Then
                'The shop is in branch system. Use each shop header
                strReceipt = " AND dt.ComputerID = ot.CloseComputerID "
            End If
            'Insert Transaction that has receiptid 
            strSQL = "Insert INTO MoveTransactionDetailTemp" & posComID & " " & _
                     "Select mt.TransactionID, mt.ComputerID, ot.DocType, ot.ReceiptYear, ot.ReceiptMonth, " & _
                     " ot.ReceiptID, dt.DocumentTypeHeader, ot.TransactionStatusID, ot.SaleDate, ot.ShopID " & _
                     "From MoveTransTemp" & posComID & " mt, OrderTransaction ot, DocumentType dt " & _
                     "Where mt.TransactionID = ot.TransactionID AND mt.ComputerID = ot.ComputerID AND " & _
                     " ot.DocType = dt.DocumentTypeID AND dt.ShopID = 0 AND dt.LangID = 1 " & _
                     strReceipt & " AND ot.ReceiptID <> 0 "
            DBUtil.sqlExecute(strSQL, objCnn)
            'Insert Transaction that receiptid  = 0
            strSQL = "Insert INTO MoveTransactionDetailTemp" & posComID & " " & _
                     "Select mt.TransactionID, mt.ComputerID, ot.DocType, ot.ReceiptYear, ot.ReceiptMonth, " & _
                     " ot.ReceiptID, '', ot.TransactionStatusID, ot.SaleDate, ot.ShopID " & _
                     "From MoveTransTemp" & posComID & " mt, OrderTransaction ot " & _
                     "Where mt.TransactionID = ot.TransactionID AND mt.ComputerID = ot.ComputerID AND " & _
                     " ot.ReceiptID = 0 "
            DBUtil.sqlExecute(strSQL, objCnn)
            'Insert Transaction that not in OrderTransaction
            strSQL = "Insert INTO MoveTransactionDetailTemp" & posComID & " " & _
                     "Select mt.TransactionID, mt.ComputerID, 0,0,0,0, '', -1, NULL, 0 " & _
                     "From MoveTransTemp" & posComID & " mt LEFT OUTER JOIN OrderTransaction ot ON " & _
                     " mt.TransactionID = ot.TransactionID AND mt.ComputerID = ot.ComputerID " & _
                     "Where ot.TransactionID Is NULL "
            DBUtil.sqlExecute(strSQL, objCnn)

            '**********************************************************************************
            ' Generate Report Section
            'Create Temp Table For GenerateReport (Using Multiple Union Create MySQL Stop for Unknown reason)
            strSQL = "Drop Table If Exists GenerateHistoryReportTemp" & posComID & ";"
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Create Table If Not Exists GenerateHistoryReportTemp" & posComID & _
                    " (TransactionID int NOT NULL, ComputerID int NOT NULL, TableName varchar(100) NULL, " & _
                    " ToTransactionID int NOT NULL, ToComputerID int NOT NULL, ToTableName varchar(100) NULL, " & _
                    " MoveStaffCode varchar(50) NULL, MoveStaffFirstName varchar(100) NULL, " & _
                    " MoveStaffLastName varchar(100), MoveDateTime datetime NULL, FrontFunctionID int NOT NULL, " & _
                    " ProductName varchar(100), OrderAmount decimal(18,4), MoveAmount decimal(18,4), " & _
                    " FromDocType int NOT NULL, FromReceiptYear int NOT NULL, FromReceiptMonth tinyint NOT NULL, " & _
                    " FromReceiptID int NOT NULL, " & _
                    " FromDocumentTypeHeader varchar(20), FromTransactionStatusID tinyint, FromSaleDate date NULL, " & _
                    " ToDocType int NOT NULL, ToReceiptYear int NOT NULL, ToReceiptMonth tinyint NOT NULL, " & _
                    " ToReceiptID int NOT NULL, " & _
                    " ToDocumentTypeHeader varchar(20), ToTransactionStatusID tinyint, ToSaleDate date NULL, " & _
                    " FrontFunctionCode varchar(10) NULL, HistoryNote varchar(255) NULL); "
            DBUtil.sqlExecute(strSQL, objCnn)


            'Data From MoveOrder
            strSQL = "Insert INTO GenerateHistoryReportTemp" & posComID & "(TransactionID, ComputerID, TableName, " & _
                     " ToTransactionID, ToComputerID, ToTableName, MoveStaffCode, MoveStaffFirstName, MoveStaffLastName, " & _
                     " MoveDateTime, FrontFunctionID, ProductName, OrderAmount, MoveAmount, FromDocType, " & _
                     " FromReceiptYear, FromReceiptMonth, FromReceiptID, FromDocumentTypeHeader, " & _
                     " FromTransactionStatusID, FromSaleDate, ToDocType, " & _
                     " ToReceiptYear, ToReceiptMonth, ToReceiptID, ToDocumentTypeHeader, " & _
                     " ToTransactionStatusID, ToSaleDate, FrontFunctionCode, HistoryNote) " & _
                     "Select  mt.TransactionID, mt.ComputerID, t1.TableName, mt.ToTransactionID, mt.ToComputerID, " & _
                     " t2.TableName as ToTableName, mt.MoveStaffCode, mt.MoveStaffFirstName, mt.MoveStaffLastName, " & _
                     " mt.MoveDateTime, mt.FrontFunctionID, mt.ProductName, mt.OrderAmount, mt.MoveAmount, " & _
                     " ot1.DocType as FromDocType, ot1.ReceiptYear as FromReceiptYear, ot1.ReceiptMonth as FromReceiptMonth, " & _
                     " ot1.ReceiptID as FromReceiptID, ot1.DocumentTypeHeader as FromDocumentTypeHeader, " & _
                     " ot1.TransactionStatusID as FromTransactionStatusID, ot1.SaleDate as FromSaleDate, " & _
                     " ot2.DocType as ToDocType, ot2.ReceiptYear as ToReceiptYear, ot2.ReceiptMonth as ToReceiptMonth, " & _
                     " ot2.ReceiptID as ToReceiptID, ot2.DocumentTypeHeader as ToDocumentTypeHeader, " & _
                     " ot2.TransactionStatusID as ToTransactionStatusID, ot2.SaleDate as ToSaleDate, ff.FrontFunctionCode, " & _
                     " mt.HistoryNote " & _
                    "From MoveOrderTemp" & posComID & " mt, MoveTransactionDetailTemp" & posComID & " ot1, " & _
                    " TableNo t1, TableNo t2, MoveTransactionDetailTemp" & posComID & " ot2, FrontFunctionDescription ff " & _
                    "Where mt.TransactionID = ot1.TransactionID AND mt.ComputerID = ot1.ComputerID AND " & _
                    " t1.TableID = mt.TableID AND t2.TableID = mt.ToTableID AND mt.TableID <> 0 AND mt.TableID <> 0 AND " & _
                    " mt.ToTransactionID = ot2.TransactionID AND mt.ToComputerID = ot2.ComputerID AND " & _
                    " ff.FrontFunctionID = mt.FrontFunctionID "
            DBUtil.sqlExecute(strSQL, objCnn)

            strSQL = "Insert INTO GenerateHistoryReportTemp" & posComID & "(TransactionID, ComputerID, TableName, " & _
                     " ToTransactionID, ToComputerID, ToTableName, MoveStaffCode, MoveStaffFirstName, MoveStaffLastName, " & _
                     " MoveDateTime, FrontFunctionID, ProductName, OrderAmount, MoveAmount, FromDocType, " & _
                     " FromReceiptYear, FromReceiptMonth, FromReceiptID, FromDocumentTypeHeader, " & _
                     " FromTransactionStatusID, FromSaleDate, ToDocType, " & _
                     " ToReceiptYear, ToReceiptMonth, ToReceiptID, ToDocumentTypeHeader, " & _
                     " ToTransactionStatusID, ToSaleDate, FrontFunctionCode, HistoryNote) " & _
                     "Select  mt.TransactionID, mt.ComputerID, '', mt.ToTransactionID, mt.ToComputerID, " & _
                     "'' as ToTableName, mt.MoveStaffCode, mt.MoveStaffFirstName, mt.MoveStaffLastName, " & _
                     " mt.MoveDateTime, mt.FrontFunctionID, mt.ProductName, mt.OrderAmount, mt.MoveAmount, " & _
                     " ot1.DocType as FromDocType, ot1.ReceiptYear as FromReceiptYear, ot1.ReceiptMonth as FromReceiptMonth, " & _
                     " ot1.ReceiptID as FromReceiptID, ot1.DocumentTypeHeader as FromDocumentTypeHeader, " & _
                     " ot1.TransactionStatusID as FromTransactionStatusID, ot1.SaleDate as FromSaleDate, " & _
                     " ot2.DocType as ToDocType, ot2.ReceiptYear as ToReceiptYear, ot2.ReceiptMonth as ToReceiptMonth, " & _
                     " ot2.ReceiptID as ToReceiptID, ot2.DocumentTypeHeader as ToDocumentTypeHeader, " & _
                     " ot2.TransactionStatusID as ToTransactionStatusID, ot2.SaleDate as ToSaleDate, ff.FrontFunctionCode, " & _
                     " mt.HistoryNote " & _
                    "From MoveOrderTemp" & posComID & " mt, MoveTransactionDetailTemp" & posComID & " ot1, " & _
                     " MoveTransactionDetailTemp" & posComID & " ot2, FrontFunctionDescription ff " & _
                    "Where mt.TransactionID = ot1.TransactionID AND mt.ComputerID = ot1.ComputerID AND " & _
                    " mt.TableID = 0 AND mt.TableID = 0 AND mt.ToTransactionID = ot2.TransactionID AND " & _
                    " mt.ToComputerID = ot2.ComputerID AND ff.FrontFunctionID = mt.FrontFunctionID "
            DBUtil.sqlExecute(strSQL, objCnn)

            'Data From MoveTable
            strSQL = "Insert INTO GenerateHistoryReportTemp" & posComID & "(TransactionID, ComputerID, TableName, " & _
                     " ToTransactionID, ToComputerID, ToTableName, MoveStaffCode, MoveStaffFirstName, MoveStaffLastName, " & _
                     " MoveDateTime, FrontFunctionID, ProductName, OrderAmount, MoveAmount, FromDocType, " & _
                     " FromReceiptYear, FromReceiptMonth, FromReceiptID, FromDocumentTypeHeader, " & _
                     " FromTransactionStatusID, FromSaleDate, ToDocType, " & _
                     " ToReceiptYear, ToReceiptMonth, ToReceiptID, ToDocumentTypeHeader, " & _
                     " ToTransactionStatusID, ToSaleDate, FrontFunctionCode, HistoryNote) " & _
                     "Select mt.TransactionID, mt.ComputerID, mt.TableName, mt.ToTransactionID, mt.ToComputerID, " & _
                     "mt.ToTableName, mt.MoveStaffCode, mt.MoveStaffFirstName, mt.MoveStaffLastName, mt.MoveDateTime, " & _
                     " mt.FrontFunctionID, '' as ProductName, 0 as OrderAmount, 0 as MoveAmount,  " & _
                     " ot1.DocType as FromDocType, ot1.ReceiptYear as FromReceiptYear, ot1.ReceiptMonth as FromReceiptMonth, " & _
                     " ot1.ReceiptID as FromReceiptID, ot1.DocumentTypeHeader as FromDocumentTypeHeader, " & _
                     " ot1.TransactionStatusID as FromTransactionStatusID, ot1.SaleDate as FromSaleDate, " & _
                     " ot2.DocType as ToDocType, ot2.ReceiptYear as ToReceiptYear, ot2.ReceiptMonth as ToReceiptMonth, " & _
                     " ot2.ReceiptID as ToReceiptID, ot2.DocumentTypeHeader as ToDocumentTypeHeader, " & _
                     " ot2.TransactionStatusID as ToTransactionStatusID, ot2.SaleDate as ToSaleDate, ff.FrontFunctionCode, " & _
                     " mt.HistoryNote " & _
                    "From MoveTableTemp" & posComID & " mt, MoveTransactionDetailTemp" & posComID & " ot1, " & _
                    " MoveTransactionDetailTemp" & posComID & " ot2, FrontFunctionDescription ff " & _
                    "Where mt.TransactionID = ot1.TransactionID AND mt.ComputerID = ot1.ComputerID AND " & _
                    " mt.ToTransactionID = ot2.TransactionID AND mt.ToComputerID = ot2.ComputerID AND " & _
                    " ff.FrontFunctionID = mt.FrontFunctionID "
            DBUtil.sqlExecute(strSQL, objCnn)

            'Data From Delete Order
            strSQL = "Insert INTO GenerateHistoryReportTemp" & posComID & "(TransactionID, ComputerID, TableName, " & _
                     " ToTransactionID, ToComputerID, ToTableName, MoveStaffCode, MoveStaffFirstName, MoveStaffLastName, " & _
                     " MoveDateTime, FrontFunctionID, ProductName, OrderAmount, MoveAmount, FromDocType, " & _
                     " FromReceiptYear, FromReceiptMonth, FromReceiptID, FromDocumentTypeHeader, " & _
                     " FromTransactionStatusID, FromSaleDate, ToDocType, " & _
                     " ToReceiptYear, ToReceiptMonth, ToReceiptID, ToDocumentTypeHeader, " & _
                     " ToTransactionStatusID, ToSaleDate, FrontFunctionCode, HistoryNote) " & _
                     "Select dt.TransactionID, dt.ComputerID, t.TableName, 0 as ToTransactionID, 0 as ToComputerID, " & _
                     " '' as ToTableName, dt.DeleteStaffCode, dt.DeleteStaffFirstName, dt.DeleteStaffLastName, " & _
                     " dt.DeleteDateTime, dt.FrontFunctionID, dt.ProductName, DeleteAmount as OrderAmount, 0 as MoveAmount,  " & _
                     " ot.DocType as FromDocType, ot.ReceiptYear as FromReceiptYear, ot.ReceiptMonth as FromReceiptMonth, " & _
                     " ot.ReceiptID as FromReceiptID, ot.DocumentTypeHeader as FromDocumentTypeHeader, " & _
                     " ot.TransactionStatusID as FromTransactionStatusID, ot.SaleDate as FromSaleDate, " & _
                     " 0 as ToDocType, 0 as ToReceiptYear, 0 as ToReceiptMonth, 0 as ToReceiptID, '' as ToDocumentTypeHeader, " & _
                     " 0 as ToTransactionStatusID, NULL as ToSaleDate, ff.FrontFunctionCode, dt.HistoryNote " & _
                     "From DeleteOrderTemp" & posComID & " dt, MoveTransactionDetailTemp" & posComID & " ot, " & _
                    " TableNo t, FrontFunctionDescription ff " & _
                    "Where dt.TransactionID = ot.TransactionID AND dt.ComputerID = ot.ComputerID AND " & _
                    " dt.TableID = t.TableID AND dt.TableID <> 0 AND ff.FrontFunctionID = dt.FrontFunctionID "
            DBUtil.sqlExecute(strSQL, objCnn)

            strSQL = "Insert INTO GenerateHistoryReportTemp" & posComID & "(TransactionID, ComputerID, TableName, " & _
                     " ToTransactionID, ToComputerID, ToTableName, MoveStaffCode, MoveStaffFirstName, MoveStaffLastName, " & _
                     " MoveDateTime, FrontFunctionID, ProductName, OrderAmount, MoveAmount, FromDocType, " & _
                     " FromReceiptYear, FromReceiptMonth, FromReceiptID, FromDocumentTypeHeader, " & _
                     " FromTransactionStatusID, FromSaleDate, ToDocType, " & _
                     " ToReceiptYear, ToReceiptMonth, ToReceiptID, ToDocumentTypeHeader, " & _
                     " ToTransactionStatusID, ToSaleDate, FrontFunctionCode, HistoryNote) " & _
                    "Select dt.TransactionID, dt.ComputerID, '' as TableName, 0 as ToTransactionID, 0 as ToComputerID, " & _
                     " '' as ToTableName, dt.DeleteStaffCode, dt.DeleteStaffFirstName, dt.DeleteStaffLastName, " & _
                     " dt.DeleteDateTime, dt.FrontFunctionID, dt.ProductName, DeleteAmount as OrderAmount, 0 as MoveAmount,  " & _
                     " ot.DocType as FromDocType, ot.ReceiptYear as FromReceiptYear, ot.ReceiptMonth as FromReceiptMonth, " & _
                     " ot.ReceiptID as FromReceiptID, ot.DocumentTypeHeader as FromDocumentTypeHeader, " & _
                     " ot.TransactionStatusID as FromTransactionStatusID, ot.SaleDate as FromSaleDate, " & _
                     " 0 as ToDocType, 0 as ToReceiptYear, 0 as ToReceiptMonth, 0 as ToReceiptID, '' as ToDocumentTypeHeader, " & _
                     " 0 as ToTransactionStatusID, NULL as ToSaleDate, ff.FrontFunctionCode, dt.HistoryNote " & _
                    "From DeleteOrderTemp" & posComID & " dt, MoveTransactionDetailTemp" & posComID & " ot, " & _
                    " FrontFunctionDescription ff " & _
                    "Where dt.TransactionID = ot.TransactionID AND dt.ComputerID = ot.ComputerID AND " & _
                    " dt.TableID = 0 AND ff.FrontFunctionID = dt.FrontFunctionID "
            DBUtil.sqlExecute(strSQL, objCnn)
            Dim DespText As String = "b.Description"
            If LangID = 1 Then
                DespText = ",b.Description As Description"
            ElseIf LangID = 2 Then
                DespText = ",b.Description_TH As Description"
            End If
            strSQL = "Select a.*" + DespText + " From GenerateHistoryReportTemp" & posComID & _
         " a left outer join FrontFunctionDescription b ON a.FrontFunctionID=b.FrontFunctionID where 0=0 " & _
                     " Order by MoveDateTime "
            dtResult = DBUtil.List(strSQL, objCnn)

            'Drop All Temp Table
            strSQL = "Drop Table If Exists GenerateHistoryReportTemp" & posComID & ";"
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Drop Table If Exists SelectTransactionTemp" & posComID & ";"
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Drop Table If Exists MoveTableTemp" & posComID & ";"
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Drop Table If Exists MoveOrderTemp" & posComID & ";"
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Drop Table If Exists MoveTransactionDetailTemp" & posComID & ";"
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Drop Table If Exists MoveTransTemp" & posComID & ";"
            DBUtil.sqlExecute(strSQL, objCnn)
            strSQL = "Drop Table If Exists DeleteOrderTemp" & posComID & ";"
            DBUtil.sqlExecute(strSQL, objCnn)
            Return dtResult

        End Function

        Private Function CreateHistoryOrderDataTableStructure() As DataTable
            Dim dtHist As New DataTable
            dtHist.Columns.Clear()
            dtHist.Columns.Add("FromTransactionID", System.Type.GetType("System.Int32"))
            dtHist.Columns.Add("FromComputerID", System.Type.GetType("System.Int32"))
            dtHist.Columns.Add("ToTransactionID", System.Type.GetType("System.Int32"))
            dtHist.Columns.Add("ToComputerID", System.Type.GetType("System.Int32"))
            dtHist.Columns.Add("FromTableName", System.Type.GetType("System.String"))
            dtHist.Columns.Add("ToTableName", System.Type.GetType("System.String"))
            dtHist.Columns.Add("FrontFunctionID", System.Type.GetType("System.Int16"))
            dtHist.Columns.Add("OperationCode", System.Type.GetType("System.String"))
            dtHist.Columns.Add("OperationDesp", System.Type.GetType("System.String"))
            dtHist.Columns.Add("MoveStaff", System.Type.GetType("System.String"))
            dtHist.Columns.Add("MoveDateTime", System.Type.GetType("System.String"))
            dtHist.Columns.Add("ProductName", System.Type.GetType("System.String"))
            dtHist.Columns.Add("OriginalAmount", System.Type.GetType("System.String"))
            dtHist.Columns.Add("MoveAmount", System.Type.GetType("System.String"))
            dtHist.Columns.Add("MoveFromReference", System.Type.GetType("System.String"))
            dtHist.Columns.Add("MoveToReference", System.Type.GetType("System.String"))
            dtHist.Columns.Add("HistoryNote", System.Type.GetType("System.String"))
            Return dtHist
        End Function

        Private Sub InsertDataIntoHistoryOrderDataTable(ByVal dtHistory As DataTable, ByVal fromTransID As Integer, _
        ByVal fromComID As Integer, ByVal toTransID As Integer, ByVal toComID As Integer, ByVal fromTableName As String, _
        ByVal toTableName As String, ByVal frontFunctionID As Integer, ByVal optCode As String, ByVal optDesp As String, ByVal moveStaff As String, _
        ByVal moveDateTime As String, ByVal productName As String, ByVal originalAmount As String, ByVal moveAmount As String, _
        ByVal moveFromRef As String, ByVal moveToRef As String, ByVal historyNote As String)
            Dim rData As DataRow
            rData = dtHistory.NewRow
            rData("OperationCode") = optCode
            rData("OperationDesp") = optDesp
            rData("FromTableName") = fromTableName
            rData("ToTableName") = toTableName
            rData("ProductName") = productName
            rData("OriginalAmount") = originalAmount
            rData("MoveAmount") = moveAmount
            rData("MoveStaff") = moveStaff
            rData("MoveDateTime") = moveDateTime
            rData("MoveFromReference") = moveFromRef
            rData("MoveToReference") = moveToRef
            rData("FromTransactionID") = fromTransID
            rData("FromComputerID") = fromComID
            rData("ToTransactionID") = toTransID
            rData("ToComputerID") = toComID
            rData("FrontFunctionID") = frontFunctionID
            rData("HistoryNote") = historyNote
            dtHistory.Rows.Add(rData)
        End Sub

        Public Function CreateHistoryOrderReportDataTable(ByVal dtHistRawData As DataTable, ByVal ShopID As Integer, ByVal LangID As Integer, ByVal objCnn As MySqlConnection) As DataTable
            Dim dtHist As DataTable
            Dim curDate As Date
            Dim moveDateTime As DateTime
            Dim i As Integer
            Dim strTableName, strToTableName, strOptCode, strMoveStaff, strHistoryNote As String
            Dim strMoveDateTime, strProductName, strOriginalAmount, strMoveAmount, optDesp As String
            Dim strFromRef, strToRef As String

            dtHist = CreateHistoryOrderDataTableStructure()
            If dtHistRawData.Rows.Count > 0 Then
                moveDateTime = dtHistRawData.Rows(0)("MoveDateTime")
                curDate = moveDateTime.Date.AddDays(-1)
            End If

            For i = 0 To dtHistRawData.Rows.Count - 1
                moveDateTime = dtHistRawData.Rows(i)("MoveDateTime")

                If curDate <> moveDateTime.Date Then
                    curDate = moveDateTime.Date
                    strProductName = Format(curDate, "dd MMMM yyyy")
                    InsertDataIntoHistoryOrderDataTable(dtHist, -1, -1, -1, -1, "", "", -1, "", "", "", _
                        "", strProductName, "", "", "", "", "")
                End If

                If Not IsDBNull(dtHistRawData.Rows(i)("TableName")) Then
                    strTableName = dtHistRawData.Rows(i)("TableName")
                Else
                    strTableName = ""
                End If
                If Not IsDBNull(dtHistRawData.Rows(i)("ToTableName")) Then
                    strToTableName = dtHistRawData.Rows(i)("ToTableName")
                Else
                    strToTableName = ""
                End If
                strOptCode = dtHistRawData.Rows(i)("FrontFunctionCode")
                Select Case dtHistRawData.Rows(i)("FrontFunctionID")
                    Case 10, 13     'Move Order, Move Order After Print Bill Detail
                        strProductName = dtHistRawData.Rows(i)("ProductName")
                        strOriginalAmount = Format(dtHistRawData.Rows(i)("OrderAmount"), "#,##0.##")
                        strMoveAmount = Format(dtHistRawData.Rows(i)("MoveAmount"), "#,##0.##")

                    Case 1, 6, 7, 27, 28    'Delete Submit Order, Void Order, Delete Normal Order
                        strProductName = dtHistRawData.Rows(i)("ProductName")
                        strOriginalAmount = Format(dtHistRawData.Rows(i)("OrderAmount"), "#,##0.##")
                        strMoveAmount = ""

                    Case Else
                        strProductName = "-"
                        strOriginalAmount = ""
                        strMoveAmount = ""
                End Select
                'MoveFrom Ref --> ReceiptID = 0 use TransID/ComID
                If dtHistRawData.Rows(i)("FromReceiptID") = 0 Then
                    strFromRef = "(" & dtHistRawData.Rows(i)("TransactionID") & "/" & dtHistRawData.Rows(i)("ComputerID") & ")"
                Else
                    If Not IsDBNull(dtHistRawData.Rows(i)("FromDocumentTypeHeader")) Then
                        strFromRef = "#" & dtHistRawData.Rows(i)("FromDocumentTypeHeader")
                    Else
                        strFromRef = "#"
                    End If
                    strFromRef &= "/" & dtHistRawData.Rows(i)("FromReceiptID")

                    strFromRef = "<a class=""smallText"" href=""JavaScript: newWindow = window.open( 'BillDetails.aspx?ComputerID=" + dtHistRawData.Rows(i)("ComputerID").ToString + "&ShopID=" + ShopID.ToString + "&TransactionID=" + dtHistRawData.Rows(i)("TransactionID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & strFromRef & "</a>"
                End If
                'MoveTo Ref --> ReceiptID = 0 use TransID/ComID
                Select Case dtHistRawData.Rows(i)("FrontFunctionID")
                    Case 1, 6, 7, 27, 28    'Delete Submit Order, Void Order, Delete Normal Order
                        strToRef = ""
                    Case Else
                        If dtHistRawData.Rows(i)("ToReceiptID") = 0 Then
                            strToRef = "(" & dtHistRawData.Rows(i)("ToTransactionID") & "/" & dtHistRawData.Rows(i)("ToComputerID") & ")"
                        Else
                            If Not IsDBNull(dtHistRawData.Rows(i)("ToDocumentTypeHeader")) Then
                                strToRef = "#" & dtHistRawData.Rows(i)("ToDocumentTypeHeader")
                            Else
                                strToRef = "#"
                            End If
                            strToRef &= "/" & dtHistRawData.Rows(i)("ToReceiptID")

                            strToRef = "<a class=""smallText"" href=""JavaScript: newWindow = window.open( 'BillDetails.aspx?ComputerID=" + dtHistRawData.Rows(i)("ToComputerID").ToString + "&ShopID=" + ShopID.ToString + "&TransactionID=" + dtHistRawData.Rows(i)("ToTransactionID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & strToRef & "</a>"
                        End If
                End Select
                strMoveDateTime = Format(moveDateTime, "HH:mm")
                strMoveStaff = dtHistRawData.Rows(i)("MoveStaffCode") & "  " & dtHistRawData.Rows(i)("MoveStaffFirstName") & _
                                " " & dtHistRawData.Rows(i)("MoveStaffLastName")

                If Not IsDBNull(dtHistRawData.Rows(i)("HistoryNote")) Then
                    strHistoryNote = Trim(dtHistRawData.Rows(i)("HistoryNote"))
                Else
                    strHistoryNote = ""
                End If

                If Not IsDBNull(dtHistRawData.Rows(i)("Description")) Then
                    optDesp = Trim(dtHistRawData.Rows(i)("Description"))
                Else
                    optDesp = ""
                End If

                InsertDataIntoHistoryOrderDataTable(dtHist, dtHistRawData.Rows(i)("TransactionID"), _
                    dtHistRawData.Rows(i)("ComputerID"), dtHistRawData.Rows(i)("ToTransactionID"), _
                    dtHistRawData.Rows(i)("ToComputerID"), strTableName, strToTableName, dtHistRawData.Rows(i)("FrontFunctionID"), _
                    strOptCode, optDesp, strMoveStaff, strMoveDateTime, strProductName, strOriginalAmount, strMoveAmount, _
                    strFromRef, strToRef, strHistoryNote)
            Next i
            Return dtHist
        End Function
     
</script>
</body>
</html>
