<%@ Page Language="VB" ContentType="text/html" EnableViewState="false" debug="True" %>
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
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Sale Summary Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body<% = GlobalParam.BodyProp %>>
<div id="showPage" visible="true" runat="server">
<form runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="ShopIDList" runat="server" />
<input type="hidden" id="IsMobile" runat="server" />
<a name="TopPage" id="TopPage"></a>
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><b class="headerText"><div class="headerText" align="left" id="HeaderText" runat="server" /></b></div>
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
				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
			</tr>
		</table></td>
	<td valign="top">
	<table>
		<tr id="showDay" visible="false" runat="Server">
		<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="DailyDate" runat="server" /></td>
		<td colspan="2"><asp:CheckBox ID="ExpandReceipt" Visible="false" CssClass="text" Checked="false" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
		<td colspan="2"><synature:date id="MonthYearDate" runat="server" /></td>
		<td><asp:dropdownlist ID="GroupByParam" visible="false" Width="200" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
		</tr>
		<tr id="showyear" visible="false" runat="server">
		<td><asp:radiobutton ID="Radio_4" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="YearDate" runat="server" /></td>
		</tr>
		<tr id="showPeriod" visible="false" runat="Server">
		<td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="CurrentDate" runat="server" /></td>
		<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
		<td><synature:date id="ToDate" runat="server" /></td>
	</tr>
	
	</table>
    <table>
    	<tr>
        	<td>&nbsp;</td>
            <td class="smalltext" bgcolor="#ff8080" width="30px;">&nbsp;&nbsp;</td>
            <td class="smalltext">No Data</td>
        	<td class="smalltext" bgcolor="#ffdab9" width="30px;">&nbsp;&nbsp;</td>
            <td class="smalltext">Not End Day Yet</td>
            <td>&nbsp;</td>
            <td class="smalltext" bgcolor="#d3d3d3" width="30px;">&nbsp;&nbsp;</td>
            <td class="smalltext">No End Day Data</td>
            <td>&nbsp;</td>
            <td class="smalltext" bgcolor="#ffd700" width="30px;">&nbsp;&nbsp;</td>
            <td class="smalltext">Sale Bill &lt;&gt; Summary End Day</td>
         </tr>
    </table>
	</td>
</tr>
</table>
</div>

<div id="showResults" visible="false" runat="server">
<table width="100%">

<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>
</table>
<span id="MyTable">
<table width="100%">
<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>

<span id="startTable" runat="server"></span>

	<span id="TableHeaderText" runat="server"></span>
	
	<div id="ResultText" runat="server"></div>

	<div id="SummaryResult" runat="server"></div>

<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" ChartPadding=40 runat="Server" />
</asp:Panel></td></tr>
</table></span>

<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>

</div>

</form>
</div>
<div id="errorMsg1" runat="server" />
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
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
		
Sub Page_Load()
	If User.Identity.IsAuthenticated Then
		
	'Try	
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)

		SubmitForm.Text = textTable.Rows(8)("TextParamValue")
		
		Dim CultureString As String = Util.GetCultureByLangID(Session("LangID"), objCnn)
		Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
		
		StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
		
		DocumentToDateParam.InnerHtml = defaultTextTable.Rows(91)("TextParamValue")
		
		HeaderText.InnerHtml = "Summary Sale Report"
			
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
		MonthYearDate.Lang_Data = LangDefault
		MonthYearDate.Culture = CultureString
		
		YearDate.YearType = GlobalParam.YearType
		YearDate.FormName = "YearDate"
		YearDate.StartYear = GlobalParam.StartYear
		YearDate.EndYear = GlobalParam.EndYear
		YearDate.LangID = Session("LangID")
		YearDate.ShowDay = False
		YearDate.ShowMonth = False
		
		ResultText.InnerHtml = ""
		ResultSearchText.InnerHtml = ""
		errorMsg.InnerHtml = ""
		
		GroupByParam.Items(0).Text = "Display Sale Qty"
		GroupByParam.Items(0).Value = "1"
		GroupByParam.Items(1).Text = "Display Sale Amount"
		GroupByParam.Items(1).Value = "2"
		If Request.Form("GroupByParam") = 1 Then
			GroupByParam.Items(0).Selected = True
		ElseIf Request.Form("GroupByParam") = 2 Then
			GroupByParam.Items(1).Selected = True
		Else
			GroupByParam.Items(0).Selected = True
		End If
		
		If IsNumeric(Request.Form("DocDaily_Day")) Then 
			Session("DocDailyDay") = Request.Form("DocDaily_Day")
		Else If IsNumeric(Request.QueryString("DocDaily_Day")) Then 
			Session("DocDailyDay") = Request.QueryString("DocDaily_Day")
		Else If Trim(Session("DocDailyDay")) = "" Then
			Session("DocDailyDay") = DateTime.Now.Day
Else If Trim(Session("DocDailyDay")) = 0 And Not Page.IsPostBack Then
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
Else If Trim(Session("DocDaily_Month")) = 0 And Not Page.IsPostBack Then
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
Else If Trim(Session("DocDaily_Year")) = 0 And Not Page.IsPostBack Then
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
Else If Trim(Session("DocDay")) = 0 And Not Page.IsPostBack Then
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
Else If Trim(Session("Doc_Month")) = 0 And Not Page.IsPostBack Then
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
Else If Trim(Session("Doc_Year")) = 0 And Not Page.IsPostBack Then
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
Else If Trim(Session("DocTo_Day")) = 0 And Not Page.IsPostBack Then
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
Else If Trim(Session("DocTo_Month")) = 0 And Not Page.IsPostBack Then
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
Else If Trim(Session("DocTo_Year")) = 0 And Not Page.IsPostBack Then
			Session("DocTo_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("DocTo_Year") = "" Then Session("DocTo_Year") = 0
		ToDate.SelectedYear = Session("DocTo_Year")
		
		If IsNumeric(Request.Form("MonthYearDate_Day")) Then 
			Session("MonthYearDate_Day") = Request.Form("MonthYearDate_Day")
		Else If IsNumeric(Request.QueryString("MonthYearDate_Day")) Then 
			Session("MonthYearDate_Day") = Request.QueryString("MonthYearDate_Day")
		Else If Trim(Session("MonthYearDate_Day")) = "" Then
			Session("MonthYearDate_Day") = DateTime.Now.Day
Else If Trim(Session("MonthYearDate_Day")) = 0 And Not Page.IsPostBack Then
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
Else If Trim(Session("MonthYearDate_Month")) = 0 And Not Page.IsPostBack Then
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
Else If Trim(Session("MonthYearDate_Year")) = 0 And Not Page.IsPostBack Then
			Session("MonthYearDate_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("MonthYearDate_Year") = "" Then Session("MonthYearDate_Year") = 0
		MonthYearDate.SelectedYear = Session("MonthYearDate_Year")
		
		If IsNumeric(Request.Form("YearDate_Year")) Then 
			Session("YearDate_Year") = Request.Form("YearDate_Year")
		Else If IsNumeric(Request.QueryString("YearDate_Year")) Then 
			Session("YearDate_Year") = Request.QueryString("YearDate_Year")
		Else If Trim(Session("YearDate_Year")) = "" Then
			Session("YearDate_Year") = DateTime.Now.Year
		End If
		If Page.IsPostBack AND Request.Form("YearDate_Year") = "" Then Session("YearDate_Year") = 0
		YearDate.SelectedYear = Session("YearDate_Year")
		
		If Not Page.IsPostBack Then
			Radio_1.Checked = True
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
		Dim ShopList As String = ""
		
		Dim ShopData As DataTable = objDB.List("select * from ShopType where Deleted=0 order by ShopTypeOrdering", objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"">"

			For i = 0 to ShopData.Rows.Count - 1
				If ShopIDValue = ShopData.Rows(i)("ShopTypeID") Then
					FormSelected = "selected"
					SelShopName.Value = ShopData.Rows(i)("ShopTypeName")
				Else
					If Not Page.IsPostBack And i=0 And Multiple = False Then
						FormSelected = "selected"
					Else
						FormSelected = ""
					End If
				End If
				If ShopData.Rows(i)("ShopTypeID") = 0 Then
                        outputString += "<option value=""" & ShopData.Rows(i)("ShopTypeID") & """ " & FormSelected & ">" & "-- All Shop Type --"
				Else
					outputString += "<option value=""" & ShopData.Rows(i)("ShopTypeID") & """ " & FormSelected & ">" & ShopData.Rows(i)("ShopTypeName")
				End If
				ShopList += "," + ShopData.Rows(i)("ShopTypeID").ToString
			Next
			outputString += "</select>"
			ShopText.InnerHtml = outputString
			ShowShop.Visible = True
			ShopList = "0" + ShopList
			ShopIDList.Value = ShopList
		Else
			ShowShop.Visible = False
		End If
				
		'Catch ex As Exception
		'	errorMsg.InnerHtml = ex.Message
		'End Try
	  
	Else
		showPage.Visible = False
		errorMsg.InnerHtml = "Access Denied"
	End If
End Sub

    Sub DoSearch(Source As Object, E As EventArgs)

        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
	
        Dim FoundError As Boolean
        FoundError = False
        Dim textTable As New DataTable()
        textTable = getPageText.GetText(12, Session("LangID"), objCnn)
			
        Dim defaultTextTable As New DataTable()
        defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
	
        Dim DateFromValue As String = ""
        Dim DateToValue As String = ""
        Dim DailyDateValue As String = ""
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	
        Dim StartDate, EndDate As String
        Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
        Dim outputString As String = ""

        Dim ReportDate As String
        Dim YearValue4 As Integer
        Dim LastDay As Integer = 0
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
                'ReportDate = Format(SDate,"MMMM yyyy")
                ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy", Session("LangID"), objCnn)
                Dim LastDate As New Date(EndYearValue, EndMonthValue, 1)
                LastDay = Day(DateAdd("d", -1, LastDate))
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
            Catch ex As Exception
                FoundError = True
            End Try
        ElseIf Radio_4.Checked = True Then
            Try
                StartDate = DateTimeUtil.FormatDate(1, 1, Request.Form("YearDate_Year"))
		 
                YearValue4 = Request.Form("YearDate_Year") + 1
                EndDate = DateTimeUtil.FormatDate(1, 1, YearValue4)
                Dim SDate4 As New Date(Request.Form("YearDate_Year"), 1, 1)
                ReportDate = Format(SDate4, "yyyy")
            Catch ex As Exception
                FoundError = True
            End Try
        Else
            DateFromValue = ""
            DateToValue = ""
            DailyDateValue = ""
        End If
	
        If FoundError = False Then
		
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If

            Dim displayTable As New DataTable()
		
            ShowPrint.Visible = True
            showResults.Visible = True
		
            Dim ResultData As New DataSet

            getReport.SaleSummaryReport(ResultData, StartDate, EndDate, Request.Form("ShopID"), "", Session.SessionID.ToString, False, objCnn)

            Dim i, j As Integer
            Dim HeaderString As String = ""
            Dim ColData As New DataTable
            ColData = ResultData.Tables("ColumnData")
            HeaderString = "<tr>"
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "#" + "</td>"
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "ID" + "</td>"
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Shop Name" + "<br>" + "<img src=""images/blank.gif"" width=""180"" height=""0"">" + "</td>"
            For i = 1 To LastDay
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + i.ToString + "</td>"
            Next
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Total" + "</td>"
            HeaderString += "</tr>"
            TableHeaderText.InnerHtml = HeaderString

            Dim TextClass As String = "smallText"
            Dim ColSpan As String = "1"
            Dim Align As String = ""
            Dim outString As StringBuilder = New StringBuilder
            Dim dtTable As DataTable = ResultData.Tables("DataOutput")
            Dim RowTable As DataTable = ResultData.Tables("RowData")
            Dim foundRows() As DataRow
            Dim expression As String
            Dim grandTotal(LastDay) As Double
            Dim sumDept(LastDay) As Double
            Dim subTotal As Double = 0
            Align = "center"
		
            Dim CompareString As String = ""
            Dim DummyCompareString As String = "-1"
            Dim DummyDeptCode As String = "-1"
            Dim ChkExist As DataTable
            Dim colColor As String
            Dim counter As Integer = 1
            Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn)
		
            For i = 0 To RowTable.Rows.Count - 1
                DummyDeptCode = RowTable.Rows(i)("ShopTypeCode")
                If Not (DummyCompareString = RowTable.Rows(i)("ProductLevelCode")) Then
                    outString = outString.Append("<tr>")
                    outString = outString.Append("<td align=""" + "center" + """ class=""" + TextClass + """>" + counter.ToString + "</td>")
                    outString = outString.Append("<td align=""" + "center" + """ class=""" + TextClass + """>" + RowTable.Rows(i)("ProductLevelID").ToString + "</td>")
                    outString = outString.Append("<td align=""" + "left" + """ class=""" + TextClass + """>" + "(" + RowTable.Rows(i)("ProductLevelCode") + ")" + RowTable.Rows(i)("ProductLevelName") + "</td>")
                    subTotal = 0
                    For j = 1 To LastDay
                        expression = "ProductLevelCode='" + RowTable.Rows(i)("ProductLevelCode") + "' AND SaleDay = " + j.ToString + " AND SaleMonth = " + StartMonthValue.ToString + " AND SaleYear=" + StartYearValue.ToString
					
                        foundRows = dtTable.Select(expression)
                        colColor = "white"
                        If foundRows.GetUpperBound(0) >= 0 Then
                            'If Request.Form("GroupByParam") = 1 Then
                            'outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + Format(foundRows(0)("TotalQty"), "##,##0;(##,##0)") + "</td>") 
                            'subTotal += foundRows(0)("TotalQty")
                            'grandTotal(j) += foundRows(0)("TotalQty")
                            'sumDept(j) += foundRows(0)("TotalQty")
                            'Else
						
                            If Not IsDBNull(foundRows(0)("TotalSale")) Then
                                If foundRows(0)("EndDayStatus") = 0 Then
                                    colColor = "#ffdab9"
                                ElseIf foundRows(0)("EndDayStatus") = -1 Then
                                    colColor = "#d3d3d3"
                                ElseIf foundRows(0)("DiffAmount") <> 0 Then
                                    colColor = "#ffd700"
                                End If
                                outString = outString.Append("<td bgColor=""" + colColor + """ align=""" + Align + """ class=""" + TextClass + """>" + Format(foundRows(0)("TotalActualSale"), "##,##0.00;(##,##0.00)") + "</td>")
                                subTotal += foundRows(0)("TotalActualSale")
                                grandTotal(j) += foundRows(0)("TotalActualSale")
                                sumDept(j) += foundRows(0)("TotalActualSale")
                            Else
                                outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + "-" + "</td>")
                            End If
                            'End If
                        Else
                            Dim CheckDate As New DateTime(StartYearValue, StartMonthValue, j, 0, 0, 0)
                            If CheckDate.Date < Now.Date Then
                                ChkExist = objDB.List("select * from SessionEndDayDetail where SessionDate = " + DateTimeUtil.FormatDate(j.ToString, StartMonthValue.ToString, StartYearValue.ToString) + " AND ProductLevelID=" + RowTable.Rows(i)("ProductLevelID").ToString, objCnn)
                                If ChkExist.Rows.Count > 0 Then
                                    If ChkExist.Rows(0)("TotalPayPrice") = 0 Then
                                        outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>0.00</td>")
                                    Else
                                        outString = outString.Append("<td bgColor=""#ffd700"" align=""" + Align + """ class=""" + TextClass + """>" + Format(ChkExist.Rows(0)("TotalPayPrice"), "##,##0.00;(##,##0.00)") + "</td>")
                                    End If
                                Else
                                    outString = outString.Append("<td bgColor=""#ffd700"" align=""" + Align + """ class=""" + TextClass + """>" + "" + "</td>")
                                End If
                            Else
                                outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """></td>")
                            End If
                        End If
                    Next
                    'If Request.Form("GroupByParam") = 1 Then
                    'outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + Format(subTotal, "##,##0;(##,##0)") + "</td>") 
                    'Else
                    outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + Format(subTotal, "##,##0.00;(##,##0.00)") + "</td>")
                    'End If
                    outString = outString.Append("</tr>")
                    If i > 0 Then
                        If i < RowTable.Rows.Count - 1 Then
                            If RowTable.Rows(i + 1)("ShopTypeCode") <> DummyDeptCode Then
                                outString = outString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
                                outString = outString.Append("<td align=""" + "right" + """ class=""" + TextClass + """>Total for " + "(" + RowTable.Rows(i)("ShopTypeCode") + ")" + RowTable.Rows(i)("ShopTypeName") + "</td>")
                                subTotal = 0
                                'If Request.Form("GroupByParam") = 1 Then
                                '	For j = 1 to LastDay
                                '		If sumDept(j) = 0 Then
                                '			outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + "" + "</td>") 
                                '		Else
                                '			outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + Format(sumDept(j), "##,##0;(##,##0)") + "</td>") 
                                '		End If
                                '		subTotal += sumDept(j)
                                '		sumDept(j) = 0
                                '	Next
                                '	outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + Format(subTotal, "##,##0;(##,##0)") + "</td>") 
                                'Else
                                For j = 1 To LastDay
                                    If sumDept(j) = 0 Then
                                        outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + "" + "</td>")
                                    Else
                                        outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + Format(sumDept(j), "##,##0.00;(##,##0.00)") + "</td>")
                                    End If
                                    subTotal += sumDept(j)
                                    sumDept(j) = 0
                                Next
                                outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + Format(subTotal, "##,##0.00;(##,##0.00)") + "</td>")
                                'End If
                                outString = outString.Append("</tr>")
						
                            End If
                        Else
                            outString = outString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
                            outString = outString.Append("<td colspan=""3"" align=""" + "right" + """ class=""" + TextClass + """>Total for " + "(" + RowTable.Rows(i)("ShopTypeCode") + ")" + RowTable.Rows(i)("ShopTypeName") + "</td>")
                            subTotal = 0
                            'If Request.Form("GroupByParam") = 1 Then
                            '	For j = 1 to LastDay
                            '		If sumDept(j) = 0 Then
                            '			outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + "" + "</td>") 
                            '		Else
                            '			outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + Format(sumDept(j), "##,##0;(##,##0)") + "</td>") 
                            '		End If
                            '		subTotal += sumDept(j)
                            '		sumDept(j) = 0
                            '	Next
                            '	outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + Format(subTotal, "##,##0;(##,##0)") + "</td>") 
                            'Else
                            For j = 1 To LastDay
                                If sumDept(j) = 0 Then
                                    outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + "" + "</td>")
                                Else
                                    outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + Format(sumDept(j), "##,##0.00;(##,##0.00)") + "</td>")
                                End If
                                subTotal += sumDept(j)
                                sumDept(j) = 0
                            Next
                            outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + Format(subTotal, "##,##0.00;(##,##0.00)") + "</td>")
                            'End If
                            outString = outString.Append("</tr>")
                        End If
                    End If
                    counter += 1
                End If
                DummyCompareString = RowTable.Rows(i)("ProductLevelCode")
			
            Next
            TextClass = "smallboldtext"
            outString = outString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
            outString = outString.Append("<td colspan=""3"" align=""" + "right" + """ class=""" + TextClass + """>Grand Total</td>")
            subTotal = 0
            'If Request.Form("GroupByParam") = 1 Then
            '	For j = 1 to LastDay
            '		outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + Format(grandTotal(j), "##,##0;(##,##0)") + "</td>") 
            '		subTotal += grandTotal(j)
            '	Next
            '	outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + Format(subTotal, "##,##0;(##,##0)") + "</td>") 
            'Else
            For j = 1 To LastDay
                outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + Format(grandTotal(j), "##,##0.00;(##,##0.00)") + "</td>")
                subTotal += grandTotal(j)
            Next
            outString = outString.Append("<td align=""" + Align + """ class=""" + TextClass + """>" + Format(subTotal, "##,##0.00;(##,##0.00)") + "</td>")
            'End If
            outString = outString.Append("</tr>")
            outString = outString.Append("</table>")
            ResultText.InnerHtml = outString.ToString

            Dim ShopDisplay As String
            If Request.Form("ShopID") = 0 Then
                ShopDisplay = "All Shop Types"
            Else
                ShopDisplay = SelShopName.Value
            End If

            ResultSearchText.InnerHtml = "Sale Summary of " + ShopDisplay + "<br>" + ReportDate + ""
		
            Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & TableHeaderText.InnerHtml & ResultText.InnerHtml & "</td></tr></table>"
		
        End If
    End Sub

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "SummarySaleData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
	Dim OutputText As String = ""
	Dim CSSFile as String = Replace(UCASE(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))),"REPORTS","") & "StyleSheet\admin.css"
	
	Util.ExportData(Session("ReportResult"),FileName,CSSFile,GlobalParam.ExportCharSet,-1)
End Sub		
	
Sub Page_UnLoad()
	objCnn.Close()
End Sub
	
</script>
</body>
</html>
