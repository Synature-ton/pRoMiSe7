<%@ Page Language="VB" ContentType="text/html" EnableViewState="False" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="POSBackOfficeReport" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../../UserControls/Date.ascx" %>

<html>
<head>
<title>Credit Card Reports</title>
<link href="../../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="../../StyleSheet/webscript.js"></script> 
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="headerTD1" runat="server" />
<input type="hidden" id="headerTD2" runat="server" />
<input type="hidden" id="headerTD3" runat="server" />
<input type="hidden" id="headerTD4" runat="server" />
<input type="hidden" id="headerTD5" runat="server" />
<input type="hidden" id="headerTD6" runat="server" />
<input type="hidden" id="headerCardHolderName" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Sale Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
	</td>
	<td width="1" nowrap rowspan="99" bgcolor="003366"><img src="../../images/clear.gif" height="1" width="1"></td>
</tr>
<tr bgcolor="666666">
	<td width="3%" height="1"><p style="line-height:1px;"><img src="../../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	<td width="94%"><p style="line-height:1px;"><img src="../../images/clear.gif" height="1" width="1" border="0" hspace="252"></p></td>
	<td width="3%"><p style="line-height:1px;"><img src="../../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	
</tr>
<tr><td height="10" colspan="3">&nbsp;</td></tr>
<tr>
<td>&nbsp;</td>
<td>
<SCRIPT language="JavaScript">
			function CheckAll(checked) {
				len = document.forms[0].ShopList.length;
				var i=0;
				for( i=0; i<len; i++) {
					document.forms[0].ShopList.options[i].selected=checked;
				}
			}
	</script>
<div class="noprint">
<table>
<tr id="ShowShop" runat="server">
	<td><span id="SelectShop" class="text" runat="server"></span><br><a href="javascript:CheckAll(true)">Select&nbsp;All</a> - <a href="javascript:CheckAll(false)">Clear&nbsp;All</a><br><span id="ShopText" runat="server"></span></td>
	<td>
	<table>
		<tr><td>&nbsp;</td><td colspan="4"><span id="DocumentDateParam" class="text" runat="server"></span></td></tr>
		<tr>
		<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
		<td colspan="4"><synature:date id="MonthYearDate" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="CurrentDate" runat="server" /></td>
		<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
		<td><synature:date id="ToDate" runat="server" /></td>
	</tr>
	<tr><td>&nbsp;</td>
		<td colspan="3"><table cellpadding="0" cellspacing="0"><tr><td><asp:dropdownlist ID="GroupByParam" runat="server">
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
<br>
</div>
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print Report" runat="server" /></a> | <asp:LinkButton ID="Export" Text="Export to Excel" OnClick="ExportData" runat="server"></asp:LinkButton></div></td>
</tr>
</table>
<span id="MyTable">
<table width="100%">
<tr><td align="center"><div id="ResultSearchText" runat="server"></div></td></tr>
<tr><td align="right"><asp:Label ID="CreateReportDate" Text="" runat="server" /></td></tr>
<tr><td>
<span id="startTable" runat="server"></span>
	<tr>
    	<span id="TableHeaderText" runat="server"></span>
		<span id="ExtraHeader" runat="server"></span>
	</tr>
	
	<div id="ResultText" runat="server"></div>
</table></td></tr>
</table></span>
</form>
</div>
<div id="errorMsg" runat="server" />
</td>
<td>&nbsp;</td>
</tr>

<tr><td colspan="3" height="30">&nbsp;</td></tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../../images/clear.gif" height="1" width="1"></p></td></tr>
<tr>
	<td height="50" colspan="3" background="../../images/footerbg2000.gif">&nbsp;</td>
</tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../../images/clear.gif" height="1" width="1"></p></td></tr>
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
Dim FormatDocNumber As New FormatText()
Dim objDB As New CDBUtil()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer = 14
		
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Report_CreditCard") Then
		
            Try
                objCnn = getCnn.EstablishConnection()
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                ServiceProduct.Value = PropertyInfo.Rows(0)("ServiceProduct")
                Dim MultipleShop As String = ""
                If PropertyInfo.Rows(0)("ImportDataToCopyTable") = 0 Then
                    MultipleShop = "multiple"
                End If
		
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
                LangList.Text = Replace(LangListText, "../", "../../")
		
                Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
		
                Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
                If LangDefault.Rows.Count >= 2 Then
                    PrintText.Text = LangDefault.Rows(0)(LangText)
                    Export.Text = LangDefault.Rows(1)(LangText)
                End If

                SubmitForm.Text = LangDefault.Rows(3)(LangText)
		
                startTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"

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
		
                GroupByParam.Items(0).Text = LangData2.Rows(0)(LangText)
                GroupByParam.Items(0).Value = "1"
                GroupByParam.Items(1).Text = LangData2.Rows(1)(LangText)
                GroupByParam.Items(1).Value = "2"
                GroupByParam.Items(2).Text = LangData2.Rows(2)(LangText)
                GroupByParam.Items(2).Value = "3"
                GroupByParam.Items(3).Text = LangData2.Rows(3)(LangText)
                GroupByParam.Items(3).Value = "4"
                GroupDate.Text = LangData2.Rows(4)(LangText)
		
                If Request.Form("GroupByParam") = 1 Then
                    GroupByParam.Items(0).Selected = True
                ElseIf Request.Form("GroupByParam") = 2 Then
                    GroupByParam.Items(1).Selected = True
                ElseIf Request.Form("GroupByParam") = 3 Then
                    GroupByParam.Items(2).Selected = True
                ElseIf Request.Form("GroupByParam") = 4 Then
                    GroupByParam.Items(3).Selected = True
                Else
                    GroupByParam.Items(0).Selected = True
                End If
		
                ResultText.InnerHtml = ""
                ResultSearchText.InnerHtml = ""
                errorMsg.InnerHtml = ""

                DocumentToDateParam.InnerHtml = LangDefault.Rows(22)(LangText)

                SelectShop.InnerHtml = LangData2.Rows(12)(LangText)
		
                headerTD1.Value = 1
                headerTD2.Value = 1
                headerTD3.Value = 1
                headerTD4.Value = 1
                headerTD5.Value = 1
                headerTD6.Value = 1
                headerCardHolderName.Value = 0
		
                Dim HeaderString As String
                
                HeaderString = ""
                If GroupByParam.SelectedItem.Value = 1 And GroupDate.Checked = True Then
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(5)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(10)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(11)(LangText) + "</td>"
                    headerTD1.Value = 0
                    headerTD2.Value = 0
                    headerTD3.Value = 0
                    headerTD4.Value = 0
                ElseIf GroupByParam.SelectedItem.Value = 2 Then
                    headerTD1.Value = 0
                    headerTD2.Value = 0
                    headerTD3.Value = 0
                    headerTD5.Value = 0
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(5)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(9)(LangText) + "</td>"
                    If GroupDate.Checked = True Then
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(10)(LangText) + "</td>"
                        headerTD5.Value = 1
                    End If
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(11)(LangText) + "</td>"
                ElseIf GroupByParam.SelectedItem.Value = 3 Then
                    headerTD1.Value = 0
                    headerTD2.Value = 0
                    headerTD4.Value = 0
                    headerTD5.Value = 0
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(5)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(8)(LangText) + "</td>"
                    If GroupDate.Checked = True Then
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(10)(LangText) + "</td>"
                        headerTD5.Value = 1
                    End If
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(11)(LangText) + "</td>"
                ElseIf GroupByParam.SelectedItem.Value = 4 Then
                    headerTD1.Value = 0
                    headerTD2.Value = 0
                    headerTD5.Value = 0
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(5)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(8)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(9)(LangText) + "</td>"
                    If GroupDate.Checked = True Then
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(10)(LangText) + "</td>"
                        headerTD5.Value = 1
                    End If
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(11)(LangText) + "</td>"
                Else
                    Dim ccAdditionalColumn As POSBackOfficeReport.Report_CreditCard_DisplayAdditionalColumn
                    ccAdditionalColumn = POSBackOfficeReport.BackOfficeReport.CreditCardReport_GetDisplayAdditionalColumn(getCnn, objCnn)
                                        
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(5)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(6)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(7)(LangText) + "</td>"
                    If ccAdditionalColumn.Column_CardHolderName = True Then
                        HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & _
                                            POSBackOfficeReport.BackOfficeReport.GetLanguageText(LangData2, 14, LangText, "Card Holder Name") & "</td>"
                        headerCardHolderName.Value = 1
                    End If
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(8)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(9)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(10)(LangText) + "</td>"
                    HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(11)(LangText) + "</td>"
                End If
                TableHeaderText.InnerHtml = HeaderString
		
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
                        Radio_2.Checked = True
                    End If

                    Dim ShopIDValue As String = "0"
                    If IsNumeric(Request.Form("ShopID")) Then
                        ShopIDValue = Request.Form("ShopID").ToString
                    ElseIf IsNumeric(Request.QueryString("ShopID")) Then
                        ShopIDValue = Request.QueryString("ShopID").ToString
                    End If

                    'If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
                    Dim i As Integer
                    Dim outputString, FormSelected, compareString As String

                    ShopIDValue = "," + ShopIDValue + ","
                    Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999, Session("StaffRole"), objCnn)
                    If ShopData.Rows.Count > 0 Then

                        outputString = "<select id=""ShopList"" name=""ShopID"" " + MultipleShop + ">"
                        For i = 0 To ShopData.Rows.Count - 1
                            compareString = "," & CStr(ShopData.Rows(i)("ProductLevelID")) & ","
                            If ShopIDValue.IndexOf(compareString) <> -1 Then
					
                                FormSelected = "selected"
                            Else
                                If Not Page.IsPostBack And i = 0 Then
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
        Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
        Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
	
        Dim DateFromValue As String = ""
        Dim DateToValue As String = ""
        Try
            If Radio_2.Checked = True Then
                Dim InvC As CultureInfo = CultureInfo.InvariantCulture
                DateFromValue = DateTimeUtil.FormatDate(Request.Form("Doc_Day"), Request.Form("Doc_Month"), Request.Form("Doc_Year"))
                Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
                CheckDate = DateAdd("d", 1, CheckDate)
                DateToValue = DateTimeUtil.FormatDate(Day(CheckDate), Month(CheckDate), CheckDate.ToString("yyyy", InvC))
		
                If Trim(DateFromValue) = "InvalidDate" Or Trim(DateToValue) = "InvalidDate" Then
                    ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
                    FoundError = True
                    DateFromValue = ""
                    DateToValue = ""
                Else
                    ResultSearchText.InnerHtml = ""
                End If
            Else
                DateFromValue = ""
                DateToValue = ""
            End If
	
            If Radio_1.Checked = True Then
                If Not (IsNumeric(Request.Form("MonthYearDate_Month")) And IsNumeric(Request.Form("MonthYearDate_Year"))) Then
                    FoundError = True
                End If
            End If
        Catch ex As Exception
            FoundError = True
        End Try
	
        If FoundError = False Then
            ShowPrint.Visible = True
            Dim i As Integer
		

            Dim outputString As StringBuilder = New StringBuilder
            Dim counter As Integer
            Dim ShowString As String = ""
            Dim bgColor As String = "e9e9e9"
            Dim strCreditCardNo As String
            Dim sumTotal As Double = 0
            Dim sumTotalPlus As Double = 0
            Dim sumTotalMinus As Double = 0
            Dim SelMonth As Integer = 0
            Dim SelYear As Integer = 0
		
            If IsNumeric(Request.Form("MonthYearDate_Month")) Then SelMonth = Request.Form("MonthYearDate_Month")
            If IsNumeric(Request.Form("MonthYearDate_Year")) Then SelYear = Request.Form("MonthYearDate_Year")
		
            Dim R1, R2, GroupDateVal As Boolean
            R1 = False
            R2 = False
            GroupDateVal = False
            If Request.Form("Group1") = "Radio_1" Then
                R1 = True
            ElseIf Request.Form("Group1") = "Radio_2" Then
                R2 = True
            End If
            If Not Request.Form("GroupDate") Is Nothing Then
                GroupDateVal = True
            End If
            'Application.Lock()
            Dim dtTable As DataTable = getReport.CreditCardReport(Session("LangID"), R1, R2, SelMonth, SelYear, DateFromValue, DateToValue, Request.Form("ShopID"), _
                                                        Request.Form("GroupByParam"), GroupDateVal, objCnn)
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
                outputString = outputString.Append("<tr>")
                outputString = outputString.Append("<td align=""left"" class=""text"">" & dtTable.Rows(i)("ProductLevelName") & "</td>")
                If headerTD1.Value = 1 Then
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
                        outputString = outputString.Append("<td align=""left"" class=""text""><a href=""JavaScript: newWindow = window.open( '../../Reports/BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "&ShopID=" + dtTable.Rows(i)("ShopID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a></td>")
                    Else
                        outputString = outputString.Append("<td align=""left"" class=""text"">" & RText & "</td>")
                    End If
                    ColSpan += 1
                End If
                If headerTD2.Value = 1 Then
                    If Not IsDBNull(dtTable.Rows(i)("CreditCardNo")) Then
                        strCreditCardNo = ReportModule.ReportV6.DisplayCreditCardNumberInReport(dtTable.Rows(i)("CreditCardNo"))
                    Else
                        strCreditCardNo = "-"
                    End If
                    outputString = outputString.Append("<td align=""left"" class=""text"">" & strCreditCardNo & "</td>")
                    ColSpan += 1
                End If
                If headerCardHolderName.Value = 1 Then
                    If dtTable.Columns.Contains("CardHolderName") = False Then
                        strCreditCardNo = ""
                    ElseIf IsDBNull(dtTable.Rows(i)("CardHolderName")) Then
                        strCreditCardNo = ""
                    Else
                        strCreditCardNo = Trim(dtTable.Rows(i)("CardHolderName"))
                    End If
                    outputString = outputString.Append("<td align=""left"" class=""text"">" & strCreditCardNo & "</td>")
                    ColSpan += 1
                End If
                If headerTD3.Value = 1 Then
                    If Not IsDBNull(dtTable.Rows(i)("BankName")) Then
                        outputString = outputString.Append("<td align=""left"" class=""text"">" & dtTable.Rows(i)("BankName") & "</td>")
                    Else
                        outputString = outputString.Append("<td align=""left"" class=""text"">" & "-" & "</td>")
                    End If
                    ColSpan += 1
                End If
                If headerTD4.Value = 1 Then
                    If Not IsDBNull(dtTable.Rows(i)("CreditCardType")) Then
                        outputString = outputString.Append("<td align=""left"" class=""text"">" & dtTable.Rows(i)("CreditCardType") & "</td>")
                    Else
                        outputString = outputString.Append("<td align=""left"" class=""text"">" & "-" & "</td>")
                    End If
                    ColSpan += 1
                End If
                If headerTD5.Value = 1 Then
                    outputString = outputString.Append("<td align=""right"" class=""text"">" & DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly", Session("LangID"), objCnn) & "</td>")
                    ColSpan += 1
                End If
                If headerTD6.Value = 1 Then
                    outputString = outputString.Append("<td align=""right"" class=""text"">" & Format(dtTable.Rows(i)("totalAmount"), FormatData.Rows(0)("CurrencyFormat")) & "</td>")
                End If
			
                outputString = outputString.Append("</tr>")
                sumTotal += Format(dtTable.Rows(i)("totalAmount"), FormatData.Rows(0)("CurrencyFormat"))

                counter = counter + 1
			
            Next
            outputString = outputString.Append("<tr><td colspan=""" + ColSpan.ToString + """ class=""boldText"" align=""right"">" + LangData2.Rows(13)(LangText) & _
                                   "</td><td align=""right"" class=""boldText"">" + Format(sumTotal, FormatData.Rows(0)("CurrencyFormat")) + "</td></tr>")
		
            If dtTable.Rows.Count = 0 Then
                ResultText.InnerHtml = "<tr><td class=""boldText"" colspan=""" + ColSpan.ToString + """>" + LangDefault.Rows(26)(LangText) + "</td></tr>"
            Else
                ResultText.InnerHtml = outputString.ToString
            End If
		
            Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"
        End If
	
    End Sub

    Sub ExportData(Source As Object, E As EventArgs)
	
        Dim FileName As String = "CCData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
        Dim OutputText As String = ""
        Dim CSSFile As String = Replace(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED")), "Reports\CreditCard", "") & "StyleSheet\admin.css"
	
        Util.ExportData(Session("ReportResult"), FileName, CSSFile, GlobalParam.ExportCharSet, -1)
    End Sub

    Public Function DisplayCCNumber(ByVal CCNumber As String) As String
        Dim strCCNo As String
        Dim ccLen As Integer
        Dim i As Integer
        strCCNo = CCNumber
        ccLen = Len(strCCNo)
        If ccLen <= 4 Then
            Return CCNumber
        Else
            strCCNo = ""
            For i = 0 To ccLen - 5
                If ((i Mod 4) = 0) And (i <> 0) Then
                    strCCNo &= "-"
                End If
                strCCNo &= "x"
            Next i
            strCCNo &= "-" & Mid(CCNumber, ccLen - 3)
            Return strCCNo
        End If
        If Trim(Len(CCNumber)) >= 14 Then
            strCCNo = CCNumber.Insert(4, "-")
            strCCNo = strCCNo.Insert(9, "-")
            strCCNo = strCCNo.Insert(14, "-")
            Return strCCNo
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
