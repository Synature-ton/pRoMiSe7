<%@ Page Language="VB" ContentType="text/html" debug="true"%>
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
<%@Import Namespace="ReportModuleMySQL5" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<%@ Register tagprefix="synature" Tagname="time" Src="../UserControls/Time2.ascx" %>

<html>
<head>
<title>Top Sale Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    
    <script src="../Scripts/jquery.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

    <script type="text/javascript">

        jQuery(document).ready(function ($) {

            $('#chkSelectAllShop').live('click', function () {
                $("#chklShopInfo INPUT[type='checkbox']").attr('checked', $(this).is(':checked') ? 'checked' : '');
            });

            $("#chklShopInfo input").live("click", function () {
                if ($("#chklShopInfo input[type='checkbox']:checked").length == $("#chklShopInfo input").length) {
                    $('#chkSelectAllShop').attr('checked', 'checked').next();
                }
                else {
                    $('#chkSelectAllShop').removeAttr('checked');
                }

            });
        });
    </script>


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
		<div class="noprint"><b class="headerText"><div class="headerText" align="left" id="HeaderText" runat="server" /></b></div>
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
        <div id="ShowMasterShop" runat="server" >
		<table>
 			<tr>
                <td width="170px">
                    <asp:Panel ID="pnlMasterShop" runat="server" Height="180px" ScrollBars="Auto" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px">
                    <asp:CheckBoxList ID="chklMasterShop" runat="server" AutoPostBack="true" OnSelectedIndexChanged="SelShop" Height="16px" Width="145px"></asp:CheckBoxList>       
                     </asp:Panel>
                </td> 
		    </tr>
		</table>
	    </div>
    </td>
 	<td valign="top">
		<table>
    		<tr>
	            <td width="225px">
                    <asp:Panel ID="pnlShop" runat="server" Height="180px" ScrollBars="Auto" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px">
                    &nbsp;<asp:CheckBox ID="chkSelectAllShop" runat="server" Text="Select All" />
                    <asp:CheckBoxList ID="chklShopInfo" runat="server" Height="16px" Width="200px"></asp:CheckBoxList>       
                     </asp:Panel>
                </td>    
			</tr>
		</table>
	</td>
	<td valign="top">
		<table>
			<tr>
				<td><asp:DropDownList ID="cboGroupInfo" CssClass="text" Width="200" AutoPostBack="true" OnSelectedIndexChanged="SelDept" runat="server"></asp:DropDownList></td>
			</tr>
			<tr>
				<td><asp:DropDownList ID="cboDeptInfo" Width="200" CssClass="text" runat="server"></asp:DropDownList></td>
			</tr>
			<tr>
				<td><asp:dropdownlist ID="GroupByParam" Width="200" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
			</tr>
		</table>
	</td>
	<td>
	    <table>
		    <tr>
		        <td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
		        <td colspan="3"><synature:date id="DailyDate" runat="server" /></td>
		    </tr>
		    <tr>
		        <td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
		        <td colspan="3"><synature:date id="MonthYearDate" runat="server" /></td>
		    </tr>
		    <tr>
		        <td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
		        <td><synature:date id="CurrentDate" runat="server" /></td>
            </tr>
            <tr>
		        <td></td><td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div><synature:date id="ToDate" runat="server" /></td>
	        </tr>
	        <tr>
		        <td>&nbsp;</td>
		        <td colspan="3"><table cellpadding="0" cellspacing="0"><tr><td><synature:time id="FromTime" runat="server" /></td><td> : </td><td><synature:time id="ToTime" runat="server" /></td></tr></table></td>
	        </tr>
	        <tr>
                <td>&nbsp;</td>
		        <td colspan="4" class="text"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" />&nbsp;
                    <asp:CheckBox ID="DisplayGraph" CssClass="text" Checked="True" runat="server" />&nbsp;&nbsp;Display 
                    <asp:TextBox ID="NumDisplay" CssClass="text" Width="30" Text="10" runat="server" /></td>
	        </tr>
	    </table>
	</td>
</tr>
    
</table>
</div>
<br>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
<tr><td align="center">
<div id="ResultSearchText" class="boldText" runat="server"></div></td></tr></table>
<span id="startTable" runat="server"></span>

	<tr>
		<td id="headerNo" align="center" class="tdHeader" runat="server"><div id="txtNo" runat="server"></div></td>
		<td id="headerProductCode" align="center" class="tdHeader" runat="server"><div id="txtProductCode" runat="server"></div></td>
		<td id="headerProductName" align="center" class="tdHeader" runat="server"><div id="txtProductName" runat="server"></div></td>
		<td id="headerPricePerUnit" align="center" class="tdHeader" runat="server"><div id="txtPricePerUnit" runat="server"></div></td>
		<td id="headerAmount" align="center" class="tdHeader" runat="server"><div id="txtAmount" runat="server"></div></td>
		<td id="headerTotalPrice" align="center" class="tdHeader" runat="server"><div id="txtTotalPrice" runat="server"></div></td>
		<td id="headerDiscountPrice" align="center" class="tdHeader" runat="server"><div id="txtDiscountPrice" runat="server"></div></td>
		<td id="headerSalePrice" align="center" class="tdHeader" runat="server"><div id="txtSalePrice" runat="server"></div></td>
		<td id="headerSalePercent" align="center" class="tdHeader" runat="server"><div id="txtSalePercent" runat="server"></div></td>
		<td id="headerTD10" align="center" class="tdHeader" runat="server"><div id="Text10" runat="server"></div></td>
		<td id="headerTD11" align="center" class="tdHeader" runat="server"><div id="Text11" runat="server"></div></td>



	</tr>
	
	<div id="ResultText" runat="server"></div>
</table>
	<div id="SummaryResult" runat="server"></div>

<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" runat="Server" />
</asp:Panel>
<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>
</form>
</div>
<div id="errorMsg" class="boldText" runat="server" />
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
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New stReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
		
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Report_TopSale2") Then
		
            Try
                objCnn = getCnn.EstablishConnection()
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
		
                Dim GetReportLog As DataTable = getReport.ReportLog(objCnn)
                If GetReportLog.Rows.Count > 0 Then
                    DBText.InnerHtml = "Report Database: " + Format(GetReportLog.Rows(0)("LogDateTime"), "dd MMMM yyyy HH:mm:ss") + "&nbsp;&nbsp;"
                Else
                    DBText.InnerHtml = "Report Database&nbsp;&nbsp;"
                End If
			
                headerNo.BgColor = GlobalParam.AdminBGColor
                headerProductCode.BgColor = GlobalParam.AdminBGColor
                headerProductName.BgColor = GlobalParam.AdminBGColor
                headerPricePerUnit.BgColor = GlobalParam.AdminBGColor
                headerAmount.BgColor = GlobalParam.AdminBGColor
                headerTotalPrice.BgColor = GlobalParam.AdminBGColor
                headerDiscountPrice.BgColor = GlobalParam.AdminBGColor
                headerSalePrice.BgColor = GlobalParam.AdminBGColor
                headerSalePercent.BgColor = GlobalParam.AdminBGColor
                headerTD10.BgColor = GlobalParam.AdminBGColor
                headerTD11.BgColor = GlobalParam.AdminBGColor
		
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(13, Session("LangID"), objCnn)
                Dim textTable1 As New DataTable()
                textTable1 = getPageText.GetText(12, Session("LangID"), objCnn)
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)

                SubmitForm.Text = textTable.Rows(8)("TextParamValue")
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
                headerNo.Visible = True
                headerProductCode.Visible = True
                headerProductName.Visible = True
                headerPricePerUnit.Visible = True
                headerAmount.Visible = True
                headerTotalPrice.Visible = True
                headerDiscountPrice.Visible = True 
                headerSalePrice.Visible = True
                headerSalePercent.Visible = True
                headerTD10.Visible = False
                headerTD11.Visible = False
		
                StartTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"

                txtNo.InnerHtml = ""
                txtProductCode.InnerHtml = "Code"
                txtProductName.InnerHtml = "Product Name"
                txtPricePerUnit.InnerHtml = "Price Per Unit"
                txtAmount.InnerHtml = "Qty"
                txtTotalPrice.InnerHtml = "Amount"
                txtDiscountPrice.InnerHtml = "Discount"
                txtSalePrice.InnerHtml = "Net Amount"
                txtSalePercent.InnerHtml = "%"
		
                GroupByParam.Items(0).Text = "Top Product Sale By Price"
                GroupByParam.Items(0).Value = "1"
                GroupByParam.Items(1).Text = "Top Product Sale By Qty"
                GroupByParam.Items(1).Value = "2"
                GroupByParam.Items(2).Text = "Lowest Product Sale By Price"
                GroupByParam.Items(2).Value = "3"
                GroupByParam.Items(3).Text = "Lowest Product Sale By Qty"
                GroupByParam.Items(3).Value = "4"
		
                DisplayGraph.Text = "Display Graph"
		
                DocumentToDateParam.InnerHtml = defaultTextTable.Rows(91)("TextParamValue")
		
                HeaderText.InnerHtml = "Top Sale Report"
		
		
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
		
                FromTime.LangID = Session("LangID")
                FromTime.FormName = "FromTime"
                FromTime.SelectedHour = -1
                FromTime.SelectedMinute = -1
		
                ToTime.LangID = Session("LangID")
                ToTime.FormName = "ToTime"
                ToTime.SelectedHour = -1
                ToTime.SelectedMinute = -1
		
                ResultText.InnerHtml = ""
                ResultSearchText.InnerHtml = ""
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
		
                If IsNumeric(Request.Form("FromTime_Hour")) Then
                    FromTime.SelectedHour = Request.Form("FromTime_Hour")
                End If
                If IsNumeric(Request.Form("FromTime_Minute")) Then
                    FromTime.SelectedMinute = Request.Form("FromTime_Minute")
                End If
                If IsNumeric(Request.Form("ToTime_Hour")) Then
                    ToTime.SelectedHour = Request.Form("ToTime_Hour")
                End If
                If IsNumeric(Request.Form("ToTime_Minute")) Then
                    ToTime.SelectedMinute = Request.Form("ToTime_Minute")
                End If
		
                If Not Page.IsPostBack Then
                    Radio_3.Checked = True
                End If

                If Not Page.IsPostBack Then
                    LoadMasterShopIntoCheckBoxList()
                End If
				
            Catch ex As Exception
                errorMsg.InnerHtml = "No Shop Data" 'ex.Message
                SubmitForm.Enabled = False
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
			
        Dim defaultTextTable As New DataTable()
        defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
	
        Dim i As Integer
        Dim strShopID As String
        Dim DateFromValue As String = ""
        Dim DateToValue As String = ""
        Dim DailyDateValue As String = ""
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	
        Dim StartDate, EndDate As String
        Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
        Dim strBuild As StringBuilder
        Dim colSpan As Integer
        Dim dclGrandSalePrice, dclGrandTotalPrice, dclGrandDiscountPrice, dclGrandQty, dclPrice As Decimal
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
                    ReportDate = Format(SDate1, "d MMMM yyyy") + " - " + Format(EDate1, "d MMMM yyyy")
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
                    Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
                    ReportDate = Format(SDate2, "d MMMM yyyy")
                    ResultSearchText.InnerHtml = ""
                End If
            Catch ex As Exception
                FoundError = True
            End Try
        Else
            DateFromValue = ""
            DateToValue = ""
            DailyDateValue = ""
        End If
	
        If Not IsNumeric(NumDisplay.Text) Then
            FoundError = True
        End If
	
        Dim StartTime As String = ""
        Dim EndTime As String = ""
        If (IsNumeric(Request.Form("FromTime_Hour")) And IsNumeric(Request.Form("FromTime_Minute"))) Then
            StartTime = Request.Form("FromTime_Hour").ToString + ":" + Request.Form("FromTime_Minute").ToString + ":00"
        Else
            StartTime = ""
        End If
		
        If (IsNumeric(Request.Form("ToTime_Hour")) And IsNumeric(Request.Form("ToTime_Minute"))) Then
            EndTime = Request.Form("ToTime_Hour").ToString + ":" + Request.Form("ToTime_Minute").ToString + ":00"
        Else
            EndTime = ""
        End If
	
        If FoundError = False Then
            Dim dtTable As New DataTable()
            
            ShowPrint.Visible = True
		
            Dim ViewOption As Integer
            If Radio_1.Checked = True Then
                ViewOption = 1
            ElseIf Radio_2.Checked = True Then
                ViewOption = 2
            Else
                ViewOption = 0
            End If
            
            strShopID = ""
            For i = 0 To chklShopInfo.Items.Count - 1
                If chklShopInfo.Items(i).Selected = True Then
                    strShopID &= chklShopInfo.Items(i).Value & ", "
                End If
            Next i
            If strShopID <> "" Then
                strShopID = Mid(strShopID, 1, Len(strShopID) - 2)
            Else
                strShopID = "-1"
            End If
               'Application.Lock()

            dclGrandTotalPrice = 0
            dclGrandSalePrice = 0
            dclGrandQty = 0
            getReport.TopSaleReports(dtTable, dclGrandQty, dclGrandTotalPrice, dclGrandSalePrice, GraphData, GroupByParam.SelectedItem.Value, _
                            StartDate, EndDate, StartTime, EndTime, strShopID, cboGroupInfo.SelectedItem.Value, cboDeptInfo.SelectedItem.Value, _
                            NumDisplay.Text, DisplayGraph.Checked, Session("LangID"), "", 1, objCnn)
            dclGrandDiscountPrice = dclGrandTotalPrice - dclGrandSalePrice
            
            'Application.UnLock()

            txtSalePercent.InnerHtml = "% (based on " + Format(dclGrandSalePrice, "##,##0.00") + ")"
            strBuild = New StringBuilder
            Dim TextClass As String = "text"
            Dim totalDisplay As Integer
            If NumDisplay.Text > 0 And NumDisplay.Text <= dtTable.Rows.Count Then
                totalDisplay = NumDisPlay.Text
            Else
                totalDisplay = dtTable.Rows.Count
            End If
		
            Dim gData As New DataSet()
            Dim table As DataTable = gData.Tables.Add("Data")
            table.Columns.Add("Description")
            table.Columns.Add("Value1", GetType(Double))
            Dim subTotalSalePrice, subTotalPrice, subTotalDiscountPrice As Double
            Dim subtotalQty As Double
            
            subTotalPrice = 0
            subTotalSalePrice = 0
            subTotalDiscountPrice = 0
            subtotalQty = 0
            colSpan = 4
            For i = 0 To totalDisplay - 1
                strBuild.Append("<tr>")
                strBuild.Append("<td align=""left"" class=""" + TextClass + """>" & (i + 1).ToString & "</td>")
                If Not IsDBNull(dtTable.Rows(i)("ProductCode")) Then
                    strBuild.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("ProductCode") & "</td>")
                Else
                    strBuild.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
                End If
                'Product Name
                strBuild.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("ProductName") & "</td>")
                'Price Per Unit
                If dtTable.Rows(i)("TotalQty") = 0 Then
                    dclPrice = 0
                Else
                    dclPrice = dtTable.Rows(i)("TotalRetailPrice") / dtTable.Rows(i)("TotalQty")
                End If
                strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(dclPrice, "##,##0.00") & "</td>")
                'Amount
                If Not IsDBNull(dtTable.Rows(i)("TotalQty")) Then
                    strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(dtTable.Rows(i)("TotalQty"), "##,##0.00") & "</td>")
                    subtotalQty += dtTable.Rows(i)("TotalQty")
                Else
                    strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                End If
                'TotalPrice
                If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) Then
                    strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(dtTable.Rows(i)("TotalRetailPrice"), "##,##0.00") & "</td>")
                    subTotalPrice += dtTable.Rows(i)("TotalRetailPrice")
                Else
                    strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                End If
                'Discount
                If Not IsDBNull(dtTable.Rows(i)("TotalRetailPrice")) Then
                    dclPrice = dtTable.Rows(i)("TotalRetailPrice") - dtTable.Rows(i)("TotalSale")
                    strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(dclPrice, "##,##0.00") & "</td>")
                    subTotalDiscountPrice += dclPrice
                Else
                    strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                End If
                'Sale Price
                If Not IsDBNull(dtTable.Rows(i)("TotalSale")) Then
                    strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(dtTable.Rows(i)("TotalSale"), "##,##0.00") & "</td>")
                    'Sale Percent
                    If dclGrandSalePrice = 0 Then
                        strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                    Else
                        strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format((dtTable.Rows(i)("TotalSale")) * 100 / dclGrandSalePrice, "##,##0.00") & "%</td>")
                    End If
                    subTotalSalePrice += dtTable.Rows(i)("TotalSale")
				
                    Dim row As DataRow = table.NewRow()
                    row("Description") = dtTable.Rows(i)("ProductName")
                    If dclGrandSalePrice = 0 Then
                        row("Value1") = Format(0, "##,##0.00")
                    Else
                        row("Value1") = Format((dtTable.Rows(i)("TotalSale")) * 100 / dclGrandSalePrice, "##,##0.00")
                    End If
                    
                    table.Rows.Add(row)
                Else
                    strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                    strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                End If
                strBuild.Append("</tr>")
            Next
            strBuild.Append("<tr bgcolor=""" + GlobalParam.GrayBGColor + """>")
            strBuild.Append("<td align=""right"" colspan=""" & colSpan & """ class=""" + TextClass + """>Sub Total</td>")
            strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(subtotalQty, "##,##0.00") & "</td>")
            strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(subTotalPrice, "##,##0.00") & "</td>")
            strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(subTotalDiscountPrice, "##,##0.00") & "</td>")
            strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(subTotalSalePrice, "##,##0.00") & "</td>")
            If dclGrandSalePrice = 0 Then
                strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
            Else
                strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(subTotalSalePrice * 100 / dclGrandSalePrice, "##,##0.00") & "%</td>")
            End If
            strBuild.Append("</tr>")
            If subTotalSalePrice <> dclGrandSalePrice Then
                Dim row As DataRow = table.NewRow()
                row("Description") = "Others"
                row("Value1") = Format((dclGrandSalePrice - subTotalSalePrice) * 100 / dclGrandSalePrice, "##,##0.00")
                table.Rows.Add(row)
                strBuild.Append("<tr bgcolor=""" + GlobalParam.GrayBGColor + """>")
                strBuild.Append("<td align=""right"" colspan=""" & colSpan & """ class=""" + TextClass + """>Others</td>")
                strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(dclGrandQty - subtotalQty, "##,##0.00") & "</td>")
                strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(dclGrandTotalPrice - subTotalPrice, "##,##0.00") & "</td>")
                strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(dclGrandDiscountPrice - subTotalDiscountPrice, "##,##0.00") & "</td>")
                strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(dclGrandSalePrice - subTotalSalePrice, "##,##0.00") & "</td>")
                If dclGrandSalePrice = 0 Then
                    strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                Else
                    strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format((dclGrandSalePrice - subTotalSalePrice) * 100 / dclGrandSalePrice, "##,##0.00") & "%</td>")
                End If
                strBuild.Append("</tr>")
                strBuild.Append("<tr><td colspan=""7"" height=""10px""></td></tr>")
                strBuild.Append("<tr bgcolor=""" + GlobalParam.GrayBGColor + """>")
                strBuild.Append("<td align=""right"" colspan=""" & colSpan & """ class=""" + TextClass + """>Grand Total</td>")
                strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(dclGrandQty, "##,##0.00") & "</td>")
                strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(dclGrandTotalPrice, "##,##0.00") & "</td>")
                strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(dclGrandDiscountPrice, "##,##0.00") & "</td>")
                strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format(dclGrandSalePrice, "##,##0.00") & "</td>")
                If dclGrandSalePrice = 0 Then
                    strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & "-" & "</td>")
                Else
                    strBuild.Append("<td align=""right"" class=""" + TextClass + """>" & Format((dclGrandSalePrice) * 100 / dclGrandSalePrice, "##,##0.00") & "%</td>")
                End If
                
                strBuild.Append("</tr>")
            End If
            ResultText.InnerHtml = strBuild.ToString
            Dim strShopGroupDept As String
            strShopGroupDept = ""
            If chkSelectAllShop.Checked = True Then
                For i = 0 To chklMasterShop.Items.Count - 1
                    If chklMasterShop.Items(i).Selected = True Then
                        strShopGroupDept &= chklMasterShop.Items(i).Text & ","
                    End If
                Next i
            Else
                For i = 0 To chklShopInfo.Items.Count - 1
                    If chklShopInfo.Items(i).Selected = True Then
                        strShopGroupDept &= chklShopInfo.Items(i).Text & ","
                    End If
                Next i
            End If
            If strShopGroupDept <> "" Then
                strShopGroupDept = Mid(strShopGroupDept, 1, Len(strShopGroupDept) - 1)
            End If
            
            If cboGroupInfo.SelectedItem.Value <> "0" Then
                strShopGroupDept += ":" + cboGroupInfo.SelectedItem.Text
            End If
            If cboDeptInfo.SelectedItem.Value <> "0" Then
                strShopGroupDept += ":" + cboDeptInfo.SelectedItem.Text
            End If
            ResultSearchText.InnerHtml = "Top Product Sale Report of " & strShopGroupDept & " (" + ReportDate + ")"
            If DisplayGraph.Checked = True Then

                showGraph.Visible = True
                Dim view As DataView = gData.Tables(0).DefaultView
            
                Dim chart As New PieChart()
                chart.Explosion = 3
                chart.Fill.Color = Color.FromArgb(80, Color.SpringGreen)
                chart.Line.Color = Color.SteelBlue
                chart.Line.Width = 1
                chart.ShowLegend = True
                chart.DataLabels.Visible = True
                chart.DataSource = view
                chart.DataXValueField = "Description"
                chart.DataYValueField = "Value1"
                chart.DataBind()
                ChartControl1.Charts.Add(chart)
                ConfigureColors("Top Product Sale Report of " & strShopGroupDept & " (" + ReportDate + ")")
        
                ChartControl1.RedrawChart()
            Else
                showGraph.Visible = False
            End If
        End If
    End Sub

    Sub ConfigureColors(TitleName)
        'ChartControl1.Background.Color = Color.FromArgb(75, Color.SteelBlue)
        Dim ChartWidth As Integer = 700
        Dim ChartHeight As Integer = 550
			
			
        ChartControl1.Background.Type = InteriorType.LinearGradient
        ChartControl1.Background.ForeColor = Color.SteelBlue
        ChartControl1.Background.EndPoint = New Point(ChartWidth, ChartHeight)
        ChartControl1.Legend.Position = LegendPosition.Bottom
        ' ChartControl1.Legend.Width = 40
        ChartControl1.Width = Unit.Parse(ChartWidth.ToString + "px")
        ChartControl1.Height = Unit.Parse(ChartHeight.ToString + "px")
 
        ChartControl1.YAxisFont.ForeColor = Color.SteelBlue
        ChartControl1.XAxisFont.ForeColor = Color.SteelBlue
            
        ChartControl1.ChartTitle.Text = TitleName
        ChartControl1.ChartTitle.ForeColor = Color.White
      
        ChartControl1.Border.Color = Color.SteelBlue
        'ChartControl1.BorderStyle = BorderStyle.Ridge
    End Sub

    Private Sub LoadMasterShopIntoCheckBoxList()
        Dim lstItem As ListItem
        Dim i As Integer
        Dim dtShopMaster As DataTable
        dtShopMaster = getInfo.ListMasterShop(Session("StaffRole"), objCnn)
        chklMasterShop.Items.Clear()
        For i = 0 To dtShopMaster.Rows.Count - 1
            lstItem = New ListItem
            lstItem.Text = dtShopMaster.Rows(i)("ProductLevelName")
            lstItem.Value = dtShopMaster.Rows(i)("ProductLevelID")
                    
            chklMasterShop.Items.Add(lstItem)
        Next i
        If chklMasterShop.Items.Count = 0 Then
            ShowMasterShop.Visible = False
        Else
            ShowMasterShop.Visible = True
        End If
        LoadShopIntoCheckBoxList()
    End Sub
    
    Sub SelShop(sender As Object, e As System.EventArgs)
        LoadShopIntoCheckBoxList()
    End Sub
    
    Private Sub LoadShopIntoCheckBoxList()
        Dim dtShopData As DataTable
        Dim lstItem As ListItem
        Dim i As Integer
        Dim strSelMasterShopID As String
        
        strSelMasterShopID = ""
        For i = 0 To chklMasterShop.Items.Count - 1
            If chklMasterShop.Items(i).Selected = True Then
                strSelMasterShopID &= chklMasterShop.Items(i).Value & ", "
            End If
        Next i
        
        If strSelMasterShopID = "" Then
            dtShopData = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn)
        Else
            dtShopData = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), Mid(strSelMasterShopID, 1, Len(strSelMasterShopID) - 2), objCnn)
        End If
        chklShopInfo.Items.Clear()
        For i = 0 To dtShopData.Rows.Count - 1
            lstItem = New ListItem
            lstItem.Text = dtShopData.Rows(i)("ProductLevelName")
            lstItem.Value = dtShopData.Rows(i)("ProductLevelID")
            chklShopInfo.Items.Add(lstItem)
        Next i
        
        ShowGroup()
    End Sub
    
    Sub SelGroup(sender As Object, e As System.EventArgs)
        ShowGroup()
    End Sub
    
    Private Function GetSelectShopIDForListProductGroupOrDept() As String
       Dim strSelShopID As String
        Dim i As Integer
        strSelShopID = ""
        
        For i = 0 To chklShopInfo.Items.Count - 1
            If chklShopInfo.Items(i).Selected = True Then
                strSelShopID &= chklShopInfo.Items(i).Value & ", "
            End If
        Next i
        If strSelShopID = "" Then
            If chklMasterShop.Items.Count > 0 Then
                'No Shop Select ---> Check For MasterShop
                For i = 0 To chklMasterShop.Items.Count - 1
                    If chklMasterShop.Items(i).Selected = True Then
                        strSelShopID &= chklMasterShop.Items(i).Value & ", "
                    End If
                Next i
                'No Check For MasterShop ---> Select All MasterShop
                If strSelShopID = "" Then
                    For i = 0 To chklMasterShop.Items.Count - 1
                        strSelShopID &= chklMasterShop.Items(i).Value & ", "
                    Next i
                End If
            Else
                'No MasterShop ----> Select All Shop
                For i = 0 To chklShopInfo.Items.Count - 1
                    strSelShopID &= chklShopInfo.Items(i).Value & ", "
                Next i
            End If
        End If
        If strSelShopID = "" Then
            strSelShopID = "-1"
        Else
            strSelShopID = Mid(strSelShopID, 1, Len(strSelShopID) - 2)
        End If
        Return strSelShopID
    End Function
   
    Sub ShowGroup()
        showGraph.Visible = False
        Dim i As Integer
        Dim strSelShopID As String
        Dim gpTable As DataTable
        
        strSelShopID = GetSelectShopIDForListProductGroupOrDept()
        gpTable = getInfo.GetProductGroupCodeNew(strSelShopID, 0, objCnn)
			
        Dim groupTable As DataTable = New DataTable("GroupData")
        groupTable.Columns.Add("ProductGroupName")
        groupTable.Columns.Add("ProductGroupID", GetType(String))
        Dim myrow As DataRow = groupTable.NewRow()
        myrow("ProductGroupName") = "-- Display All Groups --"
        myrow("ProductGroupID") = "0"
        groupTable.Rows.Add(myrow)
        If strSelShopID <> "-1" Then
            For i = 0 To gpTable.Rows.Count - 1
                If gpTable.Rows(i)("ProductGroupCode").IndexOf("TW:") = -1 Then
                    myrow = groupTable.NewRow()
                    myrow("ProductGroupName") = gpTable.Rows(i)("ProductGroupName")
                    myrow("ProductGroupID") = gpTable.Rows(i)("ProductGroupCode")
                    groupTable.Rows.Add(myrow)
                End If
            Next
        End If
        cboGroupInfo.DataSource = groupTable
        cboGroupInfo.DataValueField = "ProductGroupID"
        cboGroupInfo.DataTextField = "ProductGroupName"
        cboGroupInfo.DataBind()
	
        Dim deptTable As DataTable = New DataTable("DeptData")
        deptTable.Columns.Add("ProductDeptName")
        deptTable.Columns.Add("ProductDeptID", GetType(String))
        Dim deptRow As DataRow = deptTable.NewRow()
        deptRow("ProductDeptName") = "-- Display All Dept --"
        deptRow("ProductDeptID") = "0"
        deptTable.Rows.Add(deptRow)
        cboDeptInfo.DataSource = deptTable
        cboDeptInfo.DataValueField = "ProductDeptID"
        cboDeptInfo.DataTextField = "ProductDeptName"
        cboDeptInfo.DataBind()
        cboDeptInfo.Enabled = False
    End Sub

    Sub SelDept(sender As Object, e As System.EventArgs)
        ShowDept()
    End Sub

    Sub ShowDept()
        showGraph.Visible = False
        Dim i As Integer
        Dim deptTable As DataTable = New DataTable("DeptData")
        deptTable.Columns.Add("ProductDeptName")
        deptTable.Columns.Add("ProductDeptID", GetType(String))
        Dim deptRow As DataRow = deptTable.NewRow()
        If cboGroupInfo.SelectedItem.Value = "" Then
            cboDeptInfo.Enabled = False
		
            deptRow("ProductDeptName") = "-- Display All Dept --"
            deptRow("ProductDeptID") = "0"
            deptTable.Rows.Add(deptRow)
            cboDeptInfo.Enabled = False
        Else
            cboDeptInfo.Enabled = True
            Dim strSelShopID As String
            Dim dpTable As DataTable
            strSelShopID = GetSelectShopIDForListProductGroupOrDept()
            dpTable = getInfo.GetProductDeptCode(strSelShopID, cboGroupInfo.SelectedItem.Value, 0, objCnn)
            deptRow("ProductDeptName") = "-- Display All Dept --"
            deptRow("ProductDeptID") = "0"
            deptTable.Rows.Add(deptRow)
            For i = 0 To dpTable.Rows.Count - 1
                deptRow = deptTable.NewRow()
                deptRow("ProductDeptName") = dpTable.Rows(i)("ProductDeptName")
                deptRow("ProductDeptID") = dpTable.Rows(i)("ProductDeptCode")
                deptTable.Rows.Add(deptRow)
            Next
            cboDeptInfo.DataSource = deptTable
            cboDeptInfo.DataValueField = "ProductDeptID"
            cboDeptInfo.DataTextField = "ProductDeptName"
            cboDeptInfo.DataBind()
        End If
    End Sub
		
Sub Page_UnLoad()
	objCnn.Close()
End Sub
</script>
</body>
</html>
