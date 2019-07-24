<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSBackOfficeReport" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Sale Report By Product</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script> 
    <style type="text/css">
        .auto-style1 {
            width: 211px;
        }
        .auto-style2 {
            width: 479px;
        }
        .auto-style3 {
            width: 137px;
        }
    </style>
</head>
<body>
<div id="showPage" visible="true" runat="server">

<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="SelShopIDList" runat="server" />
<input type="hidden" id="SelProductGroupIDList" runat="server" />
<input type="hidden" id="SelProductDeptIDList" runat="server" />
<input type="hidden" id="SelProductIDList" runat="server" />
<input type="hidden" id="DisplayVAT" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Sale Report By Product Group" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
<table style="height: 100px; width: 627px">
    <tr>
        <td valign="Top" class="auto-style3">
            <asp:Label ID="lblSelectDate" runat="server" Text="Select Date เลือกวันที่ดู" CssClass="text" ></asp:Label>
        </td>
        <td id="SelectDate" class="auto-style2">
    	    <table>
	    	    <tr>
		            <td><asp:radiobutton ID="optDailyDate" GroupName="ReportSelectDateGroup" runat="server" /></td>
		            <td><synature:date id="DailyDate" runat="server" /></td>
    		    </tr>
	    	    <tr>
    	    	    <td><asp:radiobutton ID="optMonthlyDate" GroupName="ReportSelectDateGroup" runat="server" /></td>
	    	        <td><synature:date id="MonthYearDate" runat="server" /></td>
    		    </tr>
	    	    <tr>
    	    	    <td><asp:radiobutton ID="optYearlyDate" GroupName="ReportSelectDateGroup" runat="server" /></td>
	    	        <td><synature:date id="YearDate" runat="server" /></td>
    		    </tr>
	    	    <tr>
		        <td><asp:radiobutton ID="optRangeDate" GroupName="ReportSelectDateGroup" runat="server" /></td>
		        <td><synature:date id="CurrentDate" runat="server" /></td>
    		    <td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
	    	    <td><synature:date id="ToDate" runat="server" /></td>
	            </tr>
            </table>
        </td>
    </tr>
    <tr id="ShowShop" runat="server">
        <td class="auto-style3"><asp:Label ID="lblSelectShop" runat="server" Text="Select Shop : " CssClass="text" ></asp:Label></td>
        <td colspan ="3">
            <asp:DropDownList ID="ShopInfo" CssClass="text" Width="200" AutoPostBack="true" OnSelectedIndexChanged="SelProductGroupData" runat="server"></asp:DropDownList>
        </td>
    </tr>
</table>

<table style="height: 100px; width: 627px">
<tr>
<td valign="top" >
		<table>
            <tr>
               <td><asp:Checkbox ID="chkIsGroupBySaleDate" Text="Group by Sale Date" runat="server"/></td>
               <td><asp:Checkbox ID="chkDisplayDeleteProduct" Text="Display Deleted Product" AutoPostBack="True" runat="server"  OnCheckedChanged="SelProductGroupData"/></td>
            </tr>
                <Table style="height: 144px; width: 850px">
                    <tr>
                        <td><asp:Label ID="lblSelectProductGroup" runat="server" Text="Select Group" CssClass="text" ></asp:Label></td>
                        <td><asp:Label ID="lblSelectProductDept" runat="server" Text="Select Dept" CssClass="text" ></asp:Label></td>
                        <td><asp:Label ID="lblSelectProduct" runat="server" Text="Select Product" CssClass="text" ></asp:Label></td>                       
                    </tr>
                    <tr>
                        <td><asp:Checkbox ID="chkSelAllProductGroup" Text="Sel All Data" AutoPostBack="True"  runat="server" OnCheckedChanged="CheckAllProductGroup" />
                        <td><asp:Checkbox ID="chkSelAllProductDept" Text="Sel All Data" AutoPostBack="True"  runat="server" OnCheckedChanged="CheckAllProductDept" />
                        <td><asp:Checkbox ID="chkSelAllProduct" Text="Sel All Data" AutoPostBack="True"  runat="server" OnCheckedChanged="CheckAllProduct" />
                    </tr>
                    <tr>
                        <td><div id="pnlProductGroup" style="border-width:1px;border-style:solid;height:120px;width:280px;overflow:auto" >
                            <asp:CheckBoxList ID="chkbProductGroup" runat="server" Width="250px" AutoPostBack="true" OnSelectedIndexChanged="SelProductDeptData" Height="16px" ></asp:CheckBoxList>
                        </div></td>
                        <td><div id="pnlProductDept" style="border-width:1px;border-style:solid;height:120px;width:280px;overflow:auto" >
                            <asp:CheckBoxList ID="chkbProductDept" runat="server" Height="25px" Width="261px" AutoPostBack="true" OnSelectedIndexChanged="SelProductData"></asp:CheckBoxList>
                       </div></td>
                       <td><div id="pnlProduct" style="border-width:1px;border-style:solid;height:120px;width:280px;overflow:auto" >
                            <asp:CheckBoxList ID="chkbProduct" runat="server" Height="21px" Width="215px"></asp:CheckBoxList>
                       </div></td>
                    </tr>
                </Table>
            </tr>
         </table>
        </td>
    </tr>
    <tr>
		<td>&nbsp;</td><td colspan="3" class="text"><asp:button ID="SubmitForm" Font-Size="8" Height="25" Width="120" OnClick="DoSearch" runat="server" /></td>
	</tr>
	</table>
</div>	

</td>
</tr>
    
<div id="showResults" visible="false" runat="server" bgcolor="white">
<table style="height: 50px; width: 100%" bgcolor="white">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>
</table>
<span id="MyTable"> 
<table width="100%" bgcolor="white" >
<tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>
<span id="startTable" runat="server"></span>
    	<span id="TableHeaderText" runat="server"></span>
		<div id="ResultText" runat="server"></div>
</td></tr>
</table></span>
<table>
	<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
</table>
</div>
</form>
</div>

<table style="width:100%;" bgcolor="white">
     <tr>
        <td>&nbsp;</td>
    </tr>
</table>

<div id="errorMsg" class="boldText" runat="server" />

<table style ="width:100%" bgcolor="white">
        <tr><td colspan="9999" height="30">&nbsp;</td></tr>
    <tr><td height="1" colspan="9999" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
    <tr>
	    <td height="50" colspan="9999" background="../images/footerbg2000.gif">&nbsp;</td>
    </tr>
    <tr><td height="1" colspan="9999" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
</table>

<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
    Dim reports As New POSBackOfficeReport.BackOfficeReport

Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
    Dim SaleReportPageID As Integer = 6
    Dim saleByProductPageID As Integer = 105

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("New_Sale_Report_by_Product") Then
		
            Try
                objCnn = getCnn.EstablishConnection()

                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
                Dim z As Integer
                If Not Request.QueryString("ToLangID") Is Nothing Then
                    If IsNumeric(Request.QueryString("ToLangID")) Then
                        Session("LangID") = Request.QueryString("ToLangID")
                    End If
                End If

                Dim i As Integer
                Dim CultureString As String = Util.GetCultureByLangID(Session("LangID"), objCnn)
                Dim PageName As String = System.IO.Path.GetFileName(Request.ServerVariables("SCRIPT_NAME"))
                Dim LangListText As String = ""
                Dim LangListData As New DataTable
                Dim LangData As DataTable = getProp.GetLang(LangListText, LangListData, PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"), saleByProductPageID, 1, -1, Request, objCnn)
                Dim LangText As String = "lang" + Session("LangID").ToString
		
                For z = 0 To LangData.Rows.Count - 1
                    Dim TestLabel = Util.FindControlRecursive(mainForm, "LangText" & z)
                    Try
                        TestLabel.Text = LangData.Rows(z)(LangText)
                    Catch ex As Exception
                    End Try
                Next
                LangList.Text = LangListText
		
                Dim LangData2 As DataTable = getProp.GetLangData(SaleReportPageID, 2, -1, Request)
                Dim saleByProductLangData As DataTable = getProp.GetLangData(saleByProductPageID, 2, -1, Request)
                Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
                If LangDefault.Rows.Count >= 2 Then
                    PrintText.Text = LangDefault.Rows(0)(LangText)
                    Export.Text = LangDefault.Rows(1)(LangText)
                End If
                               
                Dim HeaderString As String = ""
                Dim ShopProp1 As DataTable = getInfo.GetProductLevel(Request.Form("ShopID"), objCnn)
		
                If Request.Form("ShopID") = 0 Then
                    'Set The First Shop's ShopType = 1 When View All Shop, If At Least 1 of All Shop Has ShopType = 1, There is Column that Show Only ShopType = 1
                    If ShopProp1.Rows(0)("ShopType") <> 1 Then
                        For i = 0 To ShopProp1.Rows.Count - 1
                            If ShopProp1.Rows(i)("ShopType") = 1 Then
                                ShopProp1.Rows(0)("ShopType") = 1
                                Exit For
                            End If
                        Next i
                    End If
                End If
		                
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(saleByProductLangData, 7, LangText, "Product") & "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(saleByProductLangData, 8, LangText, "Price/Unit") & "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(saleByProductLangData, 9, LangText, "Qty.") & "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(saleByProductLangData, 10, LangText, "Total Price") & "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(saleByProductLangData, 11, LangText, "Discount") & "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & BackOfficeReport.GetLanguageText(saleByProductLangData, 12, LangText, "Net Price") & "</td>"

                TableHeaderText.InnerHtml = HeaderString
                                
                SubmitForm.Text = LangDefault.Rows(3)(LangText)
                DocumentToDateParam.InnerHtml = LangDefault.Rows(22)(LangText)
		
                lblSelectDate.Text = BackOfficeReport.GetLanguageText(saleByProductLangData, 1, LangText, "Select Date")
                lblSelectShop.Text = BackOfficeReport.GetLanguageText(saleByProductLangData, 2, LangText, "Select Shop")
                lblSelectProductGroup.Text = BackOfficeReport.GetLanguageText(saleByProductLangData, 3, LangText, "Group :")
                lblSelectProductDept.Text = BackOfficeReport.GetLanguageText(saleByProductLangData, 4, LangText, "Dept :")
                lblSelectProduct.Text = BackOfficeReport.GetLanguageText(saleByProductLangData, 5, LangText, "Product :")

                chkSelAllProductGroup.Text = BackOfficeReport.GetLanguageText(saleByProductLangData, 6, LangText, "Select All")
                chkSelAllProductDept.Text = BackOfficeReport.GetLanguageText(saleByProductLangData, 6, LangText, "Select All")
                chkSelAllProduct.Text = BackOfficeReport.GetLanguageText(saleByProductLangData, 6, LangText, "Select All")

                chkDisplayDeleteProduct.Text = BackOfficeReport.GetLanguageText(saleByProductLangData, 24, LangText, "แสดงสินค้าที่ลบไปแล้ว")
                
                startTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"	
                		
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
		
                YearDate.YearType = GlobalParam.YearType
                YearDate.FormName = "YearDate"
                YearDate.StartYear = GlobalParam.StartYear
                YearDate.EndYear = GlobalParam.EndYear
                YearDate.LangID = Session("LangID")
                YearDate.ShowDay = False
                YearDate.ShowMonth = False
                YearDate.Lang_Data = LangDefault
                YearDate.Culture = CultureString
		
                ResultText.InnerHtml = ""
                ResultSearchText.InnerHtml = ""
                CreateReportDate.Text = ""
                errorMsg.InnerHtml = ""
                
                ShowPrint.Visible = False
		
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
 		
                If IsNumeric(Request.Form("YearDate_Year")) Then
                    Session("YearDate_Year") = Request.Form("YearDate_Year")
                ElseIf IsNumeric(Request.QueryString("YearDate_Year")) Then
                    Session("YearDate_Year") = Request.QueryString("YearDate_Year")
                ElseIf Trim(Session("YearDate_Year")) = "" Then
                    Session("YearDate_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("YearDate_Year") = "" Then Session("YearDate_Year") = 0
                YearDate.SelectedYear = Session("YearDate_Year")

                If Not Page.IsPostBack Then
                    optDailyDate.Checked = True
                End If
		
                If Not Page.IsPostBack Then
                    Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn)
                    'Add All Shop
                    If ShopData.Rows.Count > 1 Then
                        Dim rNew As DataRow
                        rNew = ShopData.NewRow
                        rNew("ProductLevelID") = 0
                        rNew("ProductLevelName") = "----- All Shops -----"
                        ShopData.Rows.InsertAt(rNew, 0)
                    End If
                    ShopInfo.DataSource = ShopData
                    ShopInfo.DataValueField = "ProductLevelID"
                    ShopInfo.DataTextField = "ProductLevelName"
                    ShopInfo.DataBind()
			
                    ShowProductGroupData()
                End If
                
                SelShopIDList.Value = ShopInfo.SelectedItem.Value
                Dim strTemp As String
                'Group
                strTemp = ""
                For i = 0 To chkbProductGroup.Items.Count - 1
                    If chkbProductGroup.Items(i).Selected = True Then
                        strTemp &= chkbProductGroup.Items(i).Value & ", "
                    End If
                Next i
                If strTemp <> "" Then
                    strTemp = Mid(strTemp, 1, Len(strTemp) - 2)
                End If
                SelProductGroupIDList.Value = strTemp
                'Dept
                strTemp = ""
                For i = 0 To chkbProductDept.Items.Count - 1
                    If chkbProductDept.Items(i).Selected = True Then
                        strTemp &= chkbProductDept.Items(i).Value & ", "
                    End If
                Next i
                If strTemp <> "" Then
                    strTemp = Mid(strTemp, 1, Len(strTemp) - 2)
                End If
                SelProductDeptIDList.Value = strTemp
                'Product
                strTemp = ""
                For i = 0 To chkbProduct.Items.Count - 1
                    If chkbProduct.Items(i).Selected = True Then
                        strTemp &= chkbProduct.Items(i).Value & ", "
                    End If
                Next i
                If strTemp <> "" Then
                    strTemp = Mid(strTemp, 1, Len(strTemp) - 2)
                End If
                SelProductIDList.Value = strTemp
                
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
        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
        Dim FoundError As Boolean
        FoundError = False
        Session("ReportResult") = ""
        Dim SaleLangData As DataTable = getProp.GetLangData(SaleReportPageID, 2, -1, Request)
        Dim SaleByProductLangData As DataTable = getProp.GetLangData(saleByProductPageID, 2, -1, Request)
        
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
        Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
	
        Dim DateFromValue As String = ""
        Dim DateToValue As String = ""
        Dim DailyDateValue As String = ""
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
        
        Dim StartDate, EndDate As String
        Dim viewReportBy As POSBackOfficeReport.ViewSaleReportBy
        Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
        Dim outputString As String = ""
        Dim grandTotal As Double = 0
        Dim ReportDate As String
        Dim i As Integer
        Dim ReportType As String
        
        ReportType = BackOfficeReport.GetLanguageText(SaleByProductLangData, 17, LangText, "Sale By Product Report")
        ReportDate = ""
        StartDate = ""
        EndDate = ""
        If optMonthlyDate.Checked = True Then
            viewReportBy = ViewSaleReportBy.ByMonth
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
        ElseIf optRangeDate.Checked = True Then
            viewReportBy = ViewSaleReportBy.ByDateRange
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
                    ReportDate = Format(SDate1, "d MMMM yyyy") + " - " + Format(EDate1, "d MMMM yyyy")
                End If
            Catch ex As Exception
                FoundError = True
            End Try
        ElseIf optDailyDate.Checked = True Then
            viewReportBy = ViewSaleReportBy.ByDay
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
                    Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
                    ReportDate = DateTimeUtil.FormatDateTime(SDate2, "DateOnly", Session("LangID"), objCnn)
                    ResultSearchText.InnerHtml = ""
                End If
            Catch ex As Exception
                FoundError = True
            End Try
        Else
            viewReportBy = ViewSaleReportBy.ByYear
            DateFromValue = ""
            DateToValue = ""
            DailyDateValue = ""
            Try
                StartYearValue = Request.Form("YearDate_Year")
                EndYearValue = Request.Form("YearDate_Year") + 1

                StartDate = DateTimeUtil.FormatDate(1, 1, StartYearValue)
                EndDate = DateTimeUtil.FormatDate(1, 1, EndYearValue)
                Dim SDate As New Date(StartYearValue, 1, 1)
                ReportDate = DateTimeUtil.FormatDateTime(SDate, "yyyy", Session("LangID"), objCnn)
            Catch ex As Exception
                FoundError = True
            End Try
        End If
        
        If FoundError = False Then
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If
            Dim LangPath As String = Util.GetLangPath(Request.PhysicalApplicationPath)

            'Application.Lock()

            Dim k As Integer
            Dim bolAllShop As Boolean
            'Select Shop
            SelShopIDList.Value = ""
            SelShopName.Value = ""
            If ShopInfo.SelectedItem.Value = "0" Then
                For k = 0 To ShopInfo.Items.Count - 1
                    SelShopIDList.Value &= ShopInfo.Items(k).Value & ", "
                    SelShopName.Value &= ShopInfo.Items(k).Text & ", "
                Next k
                SelShopIDList.Value = Mid(SelShopIDList.Value, 1, Len(SelShopIDList.Value) - 2)
                SelShopName.Value = Mid(SelShopName.Value, 1, Len(SelShopName.Value) - 2)
                bolAllShop = True
            Else
                SelShopIDList.Value = ShopInfo.SelectedItem.Value
                SelShopName.Value = ShopInfo.SelectedItem.Text
                bolAllShop = False
            End If
            'Select ProductGroup
            SelProductGroupIDList.Value = ""
            For i = 0 To chkbProductGroup.Items.Count - 1
                If chkbProductGroup.Items(i).Selected = True Then
                    SelProductGroupIDList.Value &= chkbProductGroup.Items(i).Value & ", "
                End If
            Next i
            If SelProductGroupIDList.Value <> "" Then
                SelProductGroupIDList.Value = Mid(SelProductGroupIDList.Value, 1, Len(SelProductGroupIDList.Value) - 2)
            End If
            'Select ProductDept
            SelProductDeptIDList.Value = ""
            For i = 0 To chkbProductDept.Items.Count - 1
                If chkbProductDept.Items(i).Selected = True Then
                    SelProductDeptIDList.Value &= chkbProductDept.Items(i).Value & ", "
                End If
            Next i
            If SelProductDeptIDList.Value <> "" Then
                SelProductDeptIDList.Value = Mid(SelProductDeptIDList.Value, 1, Len(SelProductDeptIDList.Value) - 2)
            End If
            'Select Product
            SelProductIDList.Value = ""
            For i = 0 To chkbProduct.Items.Count - 1
                If chkbProduct.Items(i).Selected = True Then
                    SelProductIDList.Value &= chkbProduct.Items(i).Value & ", "
                End If
            Next i
            If SelProductIDList.Value <> "" Then
                SelProductIDList.Value = Mid(SelProductIDList.Value, 1, Len(SelProductIDList.Value) - 2)
            End If
            
            If SelProductGroupIDList.Value = "" And SelProductDeptIDList.Value = "" And SelProductIDList.Value = "" Then
                errorMsg.InnerHtml = "Please select product to view report."
                showResults.Visible = False
                ShowPrint.Visible = False
                
                Exit Sub
            Else
                errorMsg.InnerHtml = ""
                showResults.Visible = True
                ShowPrint.Visible = True
            End If

            If bolAllShop = False Then
                ResultText.InnerHtml = reports.SaleByProduct_New(objCnn, GlobalParam.GrayBGColor, GlobalParam.AdminBGColor, Session("LangID"), _
                                         StartDate, EndDate, SelShopIDList.Value, SelProductGroupIDList.Value, SelProductDeptIDList.Value, _
                                         SelProductIDList.Value, chkIsGroupBySaleDate.Checked, LangPath)
            Else
                TableHeaderText.InnerHtml = ""
                ResultText.InnerHtml = reports.SaleByProduct_NewForAllShop(objCnn, GlobalParam.GrayBGColor, GlobalParam.AdminBGColor, Session("LangID"), _
                                                 StartDate, EndDate, SelShopIDList.Value, SelProductGroupIDList.Value, SelProductDeptIDList.Value, _
                                                SelProductIDList.Value, LangPath)
            End If
        End If
            
        'Application.UnLock()
            
        Dim ShopDisplay As String
        If ShopInfo.SelectedItem.Value = "0" Then
            ShopDisplay = SaleLangData.Rows(70)(LangText)
        Else
            ShopDisplay = SelShopName.Value
        End If
        ResultSearchText.InnerHtml = ReportType + " " + ShopDisplay + " (" + ReportDate + ")"
            
        Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
    End Sub
    
    Sub SelProductGroupData(sender As Object, e As System.EventArgs)
        ShowProductGroupData()
    End Sub
	
    Sub ShowProductGroupData()
        Dim i, j, noSelect As Integer
        Dim dtProductGroup As DataTable = New DataTable("ProductGroupData")
        Dim rNew As DataRow
        Dim dtData As DataTable
        Dim selGroupID(), strSelShopID As String
        
        dtProductGroup.Columns.Add("ProductGroupName", GetType(String))
        dtProductGroup.Columns.Add("ProductGroupID", GetType(Integer))
        
        If ShopInfo.SelectedItem.Value = 0 Then
            strSelShopID = ""
            For i = 1 To ShopInfo.Items.Count - 1
                strSelShopID &= ShopInfo.Items(i).Value & ", "
            Next
            If strSelShopID <> "" Then
                strSelShopID = Mid(strSelShopID, 1, Len(strSelShopID) - 2)
            End If
        Else
            strSelShopID = ShopInfo.SelectedItem.Value
        End If
        dtData = ReportShareSQL.ListProductGroupByGroupOfShop(objDB, objCnn, strSelShopID, chkDisplayDeleteProduct.Checked)
        For i = 0 To dtData.Rows.Count - 1
            rnew = dtProductGroup.NewRow()
            rNew("ProductGroupName") = dtData.Rows(i)("ProductGroupName")
            rNew("ProductGroupID") = dtData.Rows(i)("ProductGroupID")
            dtProductGroup.Rows.Add(rNew)
        Next i
	
        chkbProductGroup.DataSource = dtProductGroup
        chkbProductGroup.DataValueField = "ProductGroupID"
        chkbProductGroup.DataTextField = "ProductGroupName"
        chkbProductGroup.DataBind()

        chkSelAllProductGroup.Checked = False
        chkSelAllProductDept.Checked = False
        chkSelAllProduct.Checked = False
        chkbProductDept.Items.Clear()
        chkbProduct.Items.Clear()
        
        'Try To Check the last select value
        If SelProductGroupIDList.Value <> "" Then
            selGroupID = Split(SelProductGroupIDList.Value, ",")
            noSelect = 0
            For i = 0 To selGroupID.Length - 1
                For j = 0 To chkbProductGroup.Items.Count - 1
                    If chkbProductGroup.Items(j).Value = Trim(selGroupID(i)) Then
                        chkbProductGroup.Items(j).Selected = True
                        noSelect += 1
                        Exit For
                    End If
                Next j
            Next i
            If noSelect > 0 Then
                ShowProductDeptData()
            End If
        End If
    End Sub
    
    Sub CheckAllProductGroup(sender As Object, e As System.EventArgs)
        Dim i As Integer
        For i = 0 To chkbProductGroup.Items.Count - 1
            chkbProductGroup.Items(i).Selected = chkSelAllProductGroup.Checked
        Next i
        ShowProductDeptData()
    End Sub
    
    Sub SelProductDeptData(sender As Object, e As System.EventArgs)
        ShowProductDeptData()
    End Sub
	
    Sub ShowProductDeptData()
        Dim i, j, noSelect As Integer
        Dim strGroupID As String
        Dim dtProductDept As DataTable = New DataTable("ProductDeptData")
        Dim selDeptID() As String
        Dim rNew As DataRow
        Dim dtData As DataTable
        strGroupID = ""
        For i = 0 To chkbProductGroup.Items.Count - 1
            If chkbProductGroup.Items(i).Selected = True Then
                strGroupID &= chkbProductGroup.Items(i).Value & ", "
            End If
        Next
        If strGroupID = "" Then
            strGroupID = "-1"
        Else
            strGroupID = Mid(strGroupID, 1, Len(strGroupID) - 2)
        End If
        dtProductDept.Columns.Add("ProductDeptName", GetType(String))
        dtProductDept.Columns.Add("ProductDeptID", GetType(Integer))
        dtData = ReportShareSQL.ListProductDeptByProductGroup(objDB, objCnn, strGroupID, chkDisplayDeleteProduct.Checked)
        For i = 0 To dtData.Rows.Count - 1
            rNew = dtProductDept.NewRow()
            rNew("ProductDeptName") = dtData.Rows(i)("ProductDeptName")
            rNew("ProductDeptID") = dtData.Rows(i)("ProductDeptID")
            dtProductDept.Rows.Add(rNew)
        Next i
	
        chkbProductDept.DataSource = dtProductDept
        chkbProductDept.DataValueField = "ProductDeptID"
        chkbProductDept.DataTextField = "ProductDeptName"
        chkbProductDept.DataBind()
        
        chkSelAllProductDept.Checked = False
        chkSelAllProduct.Checked = False
        chkbProduct.Items.Clear()
                
        'Try To Check the last select value
        If SelProductDeptIDList.Value <> "" Then
            selDeptID = Split(SelProductDeptIDList.Value, ",")
            noSelect = 0
            For i = 0 To selDeptID.Length - 1
                For j = 0 To chkbProductDept.Items.Count - 1
                    If chkbProductDept.Items(j).Value = Trim(selDeptID(i)) Then
                        chkbProductDept.Items(j).Selected = True
                        noSelect += 1
                        Exit For
                    End If
                Next j
            Next i
            If noSelect > 0 Then
                ShowProductData()
            End If
        End If
    End Sub
    
    Sub CheckAllProductDept(sender As Object, e As System.EventArgs)
        Dim i As Integer
        For i = 0 To chkbProductDept.Items.Count - 1
            chkbProductDept.Items(i).Selected = chkSelAllProductDept.Checked
        Next i
        ShowProductData()
    End Sub
    
    Sub SelProductData(sender As Object, e As System.EventArgs)
        ShowProductData()
    End Sub
	
    Sub ShowProductData()
        Dim i, j, noSelect As Integer
        Dim selProductID() As String
        Dim strDeptID As String
        Dim dtProduct As DataTable = New DataTable("ProductData")
        Dim rNew As DataRow
        Dim dtData As DataTable
        strDeptID = ""
        For i = 0 To chkbProductDept.Items.Count - 1
            If chkbProductDept.Items(i).Selected = True Then
                strDeptID &= chkbProductDept.Items(i).Value & ", "
            End If
        Next
        If strDeptID = "" Then
            strDeptID = "-1"
        Else
            strDeptID = Mid(strDeptID, 1, Len(strDeptID) - 2)
        End If
        dtProduct.Columns.Add("ProductName", GetType(String))
        dtProduct.Columns.Add("ProductID", GetType(Integer))
        dtData = ReportShareSQL.ListProductByProductDept(objDB, objCnn, strDeptID, chkDisplayDeleteProduct.Checked)

        For i = 0 To dtData.Rows.Count - 1
            rNew = dtProduct.NewRow()
            rNew("ProductName") = dtData.Rows(i)("ProductName")
            rNew("ProductID") = dtData.Rows(i)("ProductID")
            dtProduct.Rows.Add(rNew)
        Next i
        chkbProduct.DataSource = dtProduct
        chkbProduct.DataValueField = "ProductID"
        chkbProduct.DataTextField = "ProductName"
        chkbProduct.DataBind()
        
        chkSelAllProduct.Checked = False
        
        'Try To Check the last select value
        If SelProductIDList.Value <> "" Then
            selProductID = Split(SelProductIDList.Value, ",")
            noSelect = 0
            For i = 0 To selProductID.Length - 1
                For j = 0 To chkbProduct.Items.Count - 1
                    If chkbProduct.Items(j).Value = Trim(selProductID(i)) Then
                        chkbProduct.Items(j).Selected = True
                        noSelect += 1
                        Exit For
                    End If
                Next j
            Next i
        End If
    End Sub
        
    Sub CheckAllProduct(sender As Object, e As System.EventArgs)
        Dim i As Integer
        For i = 0 To chkbProduct.Items.Count - 1
            chkbProduct.Items(i).Selected = chkSelAllProduct.Checked
        Next i
    End Sub
    
    Sub ExportData(Source As Object, E As EventArgs)
	
        Dim FileName As String = "SaleByProductData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
        Dim OutputText As String = ""
        Dim CSSFile As String = Replace(UCase(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))), "REPORTS", "") & "StyleSheet\admin.css"
	
        Util.ExportData(Session("ReportResult"), FileName, CSSFile, GlobalParam.ExportCharSet, -1)
    End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
