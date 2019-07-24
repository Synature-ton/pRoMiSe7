<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSBackOfficeReport" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Move Data History Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script> 
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="FrontSystemType" runat="server" />
<input type="hidden" id="AllShopID" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="ShopIDList" runat="server" />
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
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>
</table>
<span id="MyTable">
<table width="100%">
<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>
	<asp:DataGrid ID="Results" AutoGenerateColumns="false" CellPadding="3" CssClass="smalltext" HeaderStyle-BackColor="#507093" HeaderStyle-CssClass="smallTdHeader" HeaderStyle-HorizontalAlign="center" AllowPaging="false" OnItemDataBound="Results_ItemDataBound"  runat="server">
		<columns>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="FromTableName"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="ToTableName"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="OperationCode"></asp:BoundColumn>  
            <asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="OperationDesp"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="ProductName"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="PricePerUnit"></asp:BoundColumn>  
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="MoveAmount"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="TotalMoveAmountPrice"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="AfterMoveAmount"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="TotalAfterMoveAmountPrice"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="MoveStaff"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="OrderDateTime"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="MoveDateTime"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="DiffMinute"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="MoveFromReference"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="FromPayTypeName"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="MoveToReference"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="ToPayTypeName"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="HistoryNote"></asp:BoundColumn>
		</columns>
	</asp:DataGrid>
</td></tr>

<span id="startTable" runat="server"></span>
<tr><span id="HeaderForSummary" runat="server"></span></tr>
<div id="ResultForSummary" runat="server"></div>

</table></span>
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
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer = 16

    Private Const SHOWDATATYPE_PAYMENTDETAIL As Integer = 0
    
    Private Const COLUMN_FROMTABLE As Integer = 0
    Private Const COLUMN_TOTABLE As Integer = 1
    Private Const COLUMN_OPERATIONCODE As Integer = 2
    Private Const COLUMN_OPERATIONDESP As Integer = 3
    Private Const COLUMN_PRODUCTNAME As Integer = 4
    Private Const COLUMN_PRICEPERUNIT As Integer = 5
    Private Const COLUMN_MOVEAMOUNT As Integer = 6
    Private Const COLUMN_TOTALMOVEAMOUNTPRICE As Integer = 7
    Private Const COLUMN_AFTERMOVEAMOUNT As Integer = 8
    Private Const COLUMN_TOTALAFTERMOVEAMOUNTPRICE As Integer = 9
    Private Const COLUMN_MOVESTAFF As Integer = 10
    Private Const COLUMN_ORDERDATETIME As Integer = 11
    Private Const COLUMN_MOVEDATETIME As Integer = 12
    Private Const COLUMN_DIFFMINUTE As Integer = 13
    Private Const COLUMN_MOVEFROMREF As Integer = 14
    Private Const COLUMN_PAYMENTFROMREF As Integer = 15
    Private Const COLUMN_MOVETOREF As Integer = 16
    Private Const COLUMN_PAYMENTTOREF As Integer = 17
    Private Const COLUMN_HISTORYNOTE As Integer = 18
    
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Report_MoveData") Then
		
            Try
                objCnn = getCnn.EstablishConnection()
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
                FrontSystemType.Value = PropertyInfo.Rows(0)("FrontSystemType")
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString

                Dim z As Integer
                If Not Request.QueryString("ToLangID") Is Nothing Then
                    If IsNumeric(Request.QueryString("ToLangID")) Then
                        Session("LangID") = Request.QueryString("ToLangID")
                    End If
                End If

                Dim CultureString As String = Util.GetCultureByLangID(Session("LangID"), objCnn)
                Dim PageName As String = System.IO.Path.GetFileName(Request.ServerVariables("SCRIPT_NAME"))
                Dim LangListText As String = ""
                Dim LangListData As DataTable
                Dim LangData As DataTable = getProp.GetLang(LangListText, LangListData, PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"), PageID, 1, -1, Request, objCnn)
                Dim LangText As String = "lang" + Session("LangID").ToString
		
                For z = 0 To LangData.Rows.Count - 1
                    Dim TestLabel = Util.FindControlRecursive(mainForm, "LangText" & z)
                    Try
                        TestLabel.Text = LangData.Rows(z)(LangText)
                    Catch ex As Exception
                    End Try
                Next
                LangList.Text = LangListText
		
                Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
		
                Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
                If LangDefault.Rows.Count >= 2 Then
                    PrintText.Text = LangDefault.Rows(0)(LangText)
                    Export.Text = LangDefault.Rows(1)(LangText)
                End If

                SubmitForm.Text = LangDefault.Rows(3)(LangText)
		
                DocumentToDateParam.InnerHtml = LangDefault.Rows(22)(LangText)

                DailyDate.YearType = GlobalParam.YearType
                DailyDate.FormName = "DocDaily"
                DailyDate.StartYear = GlobalParam.StartYear
                DailyDate.EndYear = GlobalParam.EndYear
                DailyDate.LangID = Session("LangID")
                DailyDate.Lang_Data = LangDefault
                DailyDate.Culture = CultureString
		
                CurrentDate.YearType = GlobalParam.YearType
                CurrentDate.FormName = "Doc"
                CurrentDate.StartYear = GlobalParam.StartYear
                CurrentDate.EndYear = GlobalParam.EndYear
                CurrentDate.LangID = Session("LangID")
                CurrentDate.Lang_Data = LangDefault
                CurrentDate.Culture = CultureString
		
                ToDate.YearType = GlobalParam.YearType
                ToDate.FormName = "DocTo"
                ToDate.StartYear = GlobalParam.StartYear
                ToDate.EndYear = GlobalParam.EndYear
                ToDate.LangID = Session("LangID")
                ToDate.Lang_Data = LangDefault
                ToDate.Culture = CultureString
		
                MonthYearDate.YearType = GlobalParam.YearType
                MonthYearDate.FormName = "MonthYearDate"
                MonthYearDate.StartYear = GlobalParam.StartYear
                MonthYearDate.EndYear = GlobalParam.EndYear
                MonthYearDate.LangID = Session("LangID")
                MonthYearDate.ShowDay = False
                MonthYearDate.Lang_Data = LangDefault
                MonthYearDate.Culture = CultureString
		
                HeaderForSummary.InnerHtml = ""
                ResultForSummary.InnerHtml = ""
                ResultSearchText.InnerHtml = ""
                errorMsg.InnerHtml = ""
		
                ViewTypeList.Items(0).Text = LangData2.Rows(0)(LangText)
                ViewTypeList.Items(0).Value = "0"
                ViewTypeList.Items(1).Text = LangData2.Rows(1)(LangText)
                ViewTypeList.Items(1).Value = "1"
                ViewTypeList.Items(2).Text = LangData2.Rows(2)(LangText)
                ViewTypeList.Items(2).Value = "2"
                ViewTypeList.Items(3).Text = LangData2.Rows(3)(LangText)
                ViewTypeList.Items(3).Value = "3"
		
                If IsNumeric(Request.Form("DocDaily_Day")) Then
                    Session("DocDailyDay") = Request.Form("DocDaily_Day")
                ElseIf IsNumeric(Request.QueryString("DocDaily_Day")) Then
                    Session("DocDailyDay") = Request.QueryString("DocDaily_Day")
                ElseIf Trim(Session("DocDailyDay")) = "" Then
                    Session("DocDailyDay") = DateTime.Now.Day
                ElseIf Trim(Session("DocDailyDay")) = 0 And Not Page.IsPostBack Then
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
                ElseIf Trim(Session("DocDaily_Month")) = 0 And Not Page.IsPostBack Then
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
                ElseIf Trim(Session("DocDaily_Year")) = 0 And Not Page.IsPostBack Then
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
                ElseIf Trim(Session("DocDay")) = 0 And Not Page.IsPostBack Then
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
                ElseIf Trim(Session("Doc_Month")) = 0 And Not Page.IsPostBack Then
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
                ElseIf Trim(Session("Doc_Year")) = 0 And Not Page.IsPostBack Then
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
                ElseIf Trim(Session("DocTo_Day")) = 0 And Not Page.IsPostBack Then
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
                ElseIf Trim(Session("DocTo_Month")) = 0 And Not Page.IsPostBack Then
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
                ElseIf Trim(Session("DocTo_Year")) = 0 And Not Page.IsPostBack Then
                    Session("DocTo_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("DocTo_Year") = "" Then Session("DocTo_Year") = 0
                ToDate.SelectedYear = Session("DocTo_Year")
		
                If IsNumeric(Request.Form("MonthYearDate_Day")) Then
                    Session("MonthYearDate_Day") = Request.Form("MonthYearDate_Day")
                ElseIf IsNumeric(Request.QueryString("MonthYearDate_Day")) Then
                    Session("MonthYearDate_Day") = Request.QueryString("MonthYearDate_Day")
                ElseIf Trim(Session("MonthYearDate_Day")) = "" Then
                    Session("MonthYearDate_Day") = DateTime.Now.Day
                ElseIf Trim(Session("MonthYearDate_Day")) = 0 And Not Page.IsPostBack Then
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
                ElseIf Trim(Session("MonthYearDate_Month")) = 0 And Not Page.IsPostBack Then
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
                ElseIf Trim(Session("MonthYearDate_Year")) = 0 And Not Page.IsPostBack Then
                    Session("MonthYearDate_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("MonthYearDate_Year") = "" Then Session("MonthYearDate_Year") = 0
                MonthYearDate.SelectedYear = Session("MonthYearDate_Year")
		
                If Not Page.IsPostBack Then
                    Radio_3.Checked = True
                End If

                Dim ShopIDValue As String = "0"
                If IsNumeric(Request.Form("ShopID")) Then
                    ShopIDValue = Request.Form("ShopID").ToString
                ElseIf IsNumeric(Request.QueryString("ShopID")) Then
                    ShopIDValue = Request.QueryString("ShopID").ToString
                End If
                Dim bolDisplayDetailForChangeCombineTable, bolShopDataType() As Boolean
                ReDim bolShopDataType(-1)
                bolDisplayDetailForChangeCombineTable = getReport.ShowDetailForChangeCombineInHistoryOfOrderReport(objCnn, "", bolShopDataType)

                Dim i As Integer
                Dim outputString, FormSelected As String
                Dim Multiple As Boolean = False
                Dim ShopList As String = ""
		
                Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn)
                Dim ShopIDListValue As String
                AllShopID.Value = ShopIDListValue
		
                If ShopData.Rows.Count > 0 Then
                    outputString = "<select name=""ShopID"">"
                    If (ShopData.Rows.Count > 1) And (bolDisplayDetailForChangeCombineTable = True) Then
                        If Not Page.IsPostBack Then
                            FormSelected = "selected"
                        ElseIf ShopIDValue = 0 Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        outputString += "<option value=""" & "0" & """ " & FormSelected & ">" & "--- All Shops ---"
                        Multiple = True
                    End If
                    For i = 0 To ShopData.Rows.Count - 1
                        If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
                            FormSelected = "selected"
                            SelShopName.Value = ShopData.Rows(i)("ProductLevelName")
                        Else
                            If Not Page.IsPostBack And i = 0 And Multiple = False Then
                                FormSelected = "selected"
                            Else
                                FormSelected = ""
                            End If
                        End If
                        outputString += "<option value=""" & ShopData.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & ShopData.Rows(i)("ProductLevelName")
                        ShopList += "," + ShopData.Rows(i)("ProductLevelID").ToString
                    Next
                    outputString += "</select>"
                    ShopText.InnerHtml = outputString
                    ShowShop.Visible = True
                    ShopList = "0" + ShopList
                    ShopIDList.Value = ShopList
                Else
                    ShowShop.Visible = False
                End If
		
                'Hide Column TotalPrice, OrderDateTime, DiffMinute
                Results.Columns(COLUMN_PRICEPERUNIT).Visible = bolDisplayDetailForChangeCombineTable
                Results.Columns(COLUMN_TOTALMOVEAMOUNTPRICE).Visible = bolDisplayDetailForChangeCombineTable
                Results.Columns(COLUMN_TOTALAFTERMOVEAMOUNTPRICE).Visible = bolDisplayDetailForChangeCombineTable
                Results.Columns(COLUMN_ORDERDATETIME).Visible = bolDisplayDetailForChangeCombineTable
                Results.Columns(COLUMN_DIFFMINUTE).Visible = bolDisplayDetailForChangeCombineTable
				          
                If bolShopDataType.Length > 0 Then
                    Results.Columns(COLUMN_PAYMENTFROMREF).Visible = bolShopDataType(0)
                    Results.Columns(COLUMN_PAYMENTTOREF).Visible = bolShopDataType(0)
                Else
                    Results.Columns(COLUMN_PAYMENTFROMREF).Visible = False
                    Results.Columns(COLUMN_PAYMENTTOREF).Visible = False
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
        Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
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
                ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy", Session("LangID"), objCnn)
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
                    ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
                    FoundError = True
                    DateFromValue = ""
                    DateToValue = ""
                    DailyDateValue = ""
                Else
                    ResultSearchText.InnerHtml = ""
                    Dim SDate1 As New Date(Request.Form("Doc_Year"), Request.Form("Doc_Month"), Request.Form("Doc_Day"))
                    Dim EDate1 As New Date(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"))
                    ReportDate = DateTimeUtil.FormatDateTime(SDate1, "DateOnly", Session("LangID"), objCnn) + " - " + DateTimeUtil.FormatDateTime(EDate1, "DateOnly", Session("LangID"), objCnn)
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
                    ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
                    FoundError = True
                    DateFromValue = ""
                    DateToValue = ""
                    DailyDateValue = ""
                Else
                    ResultSearchText.InnerHtml = ""
                    Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
                    ReportDate = DateTimeUtil.FormatDateTime(SDate2, "DateOnly", Session("LangID"), objCnn)
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
            ShowPrint.Visible = True
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If
            Dim ShopDisplay As String
            If Request.Form("ShopID") = 0 Then
                ShopDisplay = "All Shops"
            Else
                ShopDisplay = SelShopName.Value
            End If
            ResultSearchText.InnerHtml = LangData2.Rows(4)(LangText) + " " + ShopDisplay + " (" + ReportDate + ")"
		
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
		
            Dim bolDisplayDetailForChangeCombineTable, bolDisplayDataType() As Boolean
            ReDim bolDisplayDataType(-1)
            If Request.Form("ShopID") > 0 Then
                startTable.InnerHtml = ""
                ResultForSummary.InnerHtml = ""
                HeaderForSummary.InnerHtml = ""
			
                Dim reportID As Integer
                If Not IsNumeric(Session("StaffID")) Then
                    reportID = 999
                Else
                    reportID = Session("StaffID")
                End If
                dtTable = getReport.CreateHistoryOfOrderReport(objCnn, Request.Form("ShopID"), StartDate, EndDate, Request.Form("FrontSystemType"), reportID, _
                                         MoveTable, MoveOrder, DelOrder, Session("LangID"), bolDisplayDetailForChangeCombineTable, bolDisplayDataType)
                Dim displayTable As DataTable
                displayTable = getReport.CreateHistoryOrderReportDataTable(dtTable, bolDisplayDetailForChangeCombineTable, bolDisplayDataType, _
                                                Request.Form("ShopID"), Session("LangID"), objCnn)
		
                Results.Visible = True
                Results.DataSource = displayTable
                Results.DataBind()
			
                Dim sw As New System.IO.StringWriter()
                Dim htw As New System.Web.UI.HtmlTextWriter(sw)
                Results.RenderControl(htw)

                Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & sw.ToString() & "</td></tr></table>"
            Else
                Dim dtShopData, dtFrontFunctionColumn As DataTable
                Dim strHeader As String = ""
                dtShopData = New DataTable
                dtFrontFunctionColumn = New DataTable
                bolDisplayDetailForChangeCombineTable = False
			
                dtTable = getReport.CreateAllHistoryOfOrderReport(objCnn, ShopIDList.Value, StartDate, EndDate, Request.Form("FrontSystemType"), 999, _
                                  MoveTable, MoveOrder, DelOrder, Session("LangID"), True, dtShopData, dtFrontFunctionColumn, _
                                  bolDisplayDetailForChangeCombineTable, bolDisplayDataType)

                Results.Visible = False
						
                'ResultSearchText.InnerHtml = "All Shop " & ShopIDList.Value		
			
                startTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
                ResultForSummary.InnerHtml = getReport.GenerateResultAllHistoryOrderDataTable(dtShopData, dtFrontFunctionColumn, dtTable, _
                                                             GlobalParam.GrayBGColor, GlobalParam.AdminBGColor, LangData2, LangText, strHeader)
                HeaderForSummary.InnerHtml = strHeader

                Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & HeaderForSummary.InnerHtml & "</tr>" & ResultForSummary.InnerHtml & "</td></tr></table>"
			
            End If
        End If
	
    End Sub

    Private Sub Results_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs)
        Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
        If e.Item.ItemType = ListItemType.Header Then
            e.Item.Cells(COLUMN_FROMTABLE).Text = LangData2.Rows(5)(LangText)
            e.Item.Cells(COLUMN_TOTABLE).Text = LangData2.Rows(6)(LangText)
            e.Item.Cells(COLUMN_OPERATIONCODE).Text = LangData2.Rows(7)(LangText)
            e.Item.Cells(COLUMN_OPERATIONDESP).Text = LangData2.Rows(8)(LangText)
            e.Item.Cells(COLUMN_PRODUCTNAME).Text = LangData2.Rows(9)(LangText)
            e.Item.Cells(COLUMN_PRICEPERUNIT).Text = "à¸£à¸²à¸à¸²"
            e.Item.Cells(COLUMN_MOVEAMOUNT).Text = LangData2.Rows(10)(LangText)
            e.Item.Cells(COLUMN_TOTALMOVEAMOUNTPRICE).Text = "à¸£à¸²à¸à¸²à¸£à¸§à¸¡"
            e.Item.Cells(COLUMN_AFTERMOVEAMOUNT).Text = "à¸à¸³à¸à¸§à¸à¸«à¸¥à¸±à¸à¸¢à¹à¸²à¸¢"
            e.Item.Cells(COLUMN_TOTALAFTERMOVEAMOUNTPRICE).Text = "à¸£à¸²à¸à¸²à¸£à¸§à¸¡"
            e.Item.Cells(COLUMN_MOVESTAFF).Text = LangData2.Rows(12)(LangText)
            e.Item.Cells(COLUMN_ORDERDATETIME).Text = "à¹à¸§à¸¥à¸²à¸ªà¸±à¹à¸"
            e.Item.Cells(COLUMN_MOVEDATETIME).Text = LangData2.Rows(13)(LangText)
            e.Item.Cells(COLUMN_DIFFMINUTE).Text = "à¸à¸¥à¸à¹à¸²à¸à¹à¸§à¸¥à¸²"
            e.Item.Cells(COLUMN_MOVEFROMREF).Text = LangData2.Rows(14)(LangText)
            e.Item.Cells(COLUMN_MOVETOREF).Text = LangData2.Rows(15)(LangText)
            e.Item.Cells(COLUMN_HISTORYNOTE).Text = LangData2.Rows(16)(LangText)
            
            If LangData2.Rows.Count > 16 Then
                e.Item.Cells(COLUMN_PRICEPERUNIT).Text = LangData2.Rows(17)(LangText)
                e.Item.Cells(COLUMN_TOTALMOVEAMOUNTPRICE).Text = LangData2.Rows(22)(LangText)
                e.Item.Cells(COLUMN_AFTERMOVEAMOUNT).Text = LangData2.Rows(23)(LangText)
                e.Item.Cells(COLUMN_TOTALAFTERMOVEAMOUNTPRICE).Text = LangData2.Rows(22)(LangText)
                e.Item.Cells(COLUMN_ORDERDATETIME).Text = LangData2.Rows(18)(LangText)
                e.Item.Cells(COLUMN_DIFFMINUTE).Text = LangData2.Rows(19)(LangText)
            End If
            e.Item.Cells(COLUMN_PAYMENTFROMREF).Text = POSBackOfficeReport.BackOfficeReport.GetLanguageText(LangData2, 24, LangText, "วิธีจ่ายเงิน")
            e.Item.Cells(COLUMN_PAYMENTTOREF).Text = POSBackOfficeReport.BackOfficeReport.GetLanguageText(LangData2, 24, LangText, "วิธีจ่ายเงิน")
        End If
End Sub

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "MoveData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
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
