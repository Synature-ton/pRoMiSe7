<%@ Page Language="VB" ContentType="text/html" EnableViewState="True" debug="True" %>
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
<%@Import Namespace="POSBackOfficeReport" %>
<%@Import Namespace="POSTypeClass" %>
<%@Import Namespace="System.IO" %>


<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Sales Report</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script> 
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
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="ServiceProduct" runat="server" />
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="ShopIDList" runat="server" />
<input type="hidden" id="DisplayVAT" runat="server" />
<input type="hidden" id="AllShopID" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" Text="Sales Report" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table></div>
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
        <div id="ShowMasterShop" runat="server" >
		<table>
 			<tr>
                <td width="160px">
                    <asp:Panel ID="pnlMasterShop" runat="server" Height="180px" ScrollBars="Auto" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px">
                    <asp:CheckBoxList ID="chklMasterShop" runat="server" AutoPostBack="true" OnSelectedIndexChanged="SelShop" Height="16px" Width="140px"></asp:CheckBoxList>       
                     </asp:Panel>
                </td> 
		    </tr>
		</table>
	    </div>
    </td>
 	<td valign="top"> 
     	<table>
            <tr>
	            <td width="210px" id="ShowShopInfoList" runat="server">
                    <asp:Panel ID="pnlShop" runat="server" Height="180px" ScrollBars="Auto" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px">
                    &nbsp;<asp:CheckBox ID="chkSelectAllShop" runat="server" Text="Select All" />
                    <asp:CheckBoxList ID="chklShopInfo" runat="server" Height="16px" Width="190px"></asp:CheckBoxList>       
                    </asp:Panel>
                </td>                   
			</tr>
		</table>
	</td>
	<td valign="top">
		<table>
			<tr>
                <td id="ShowShopInfoCombo" runat="server">                    
                    <asp:DropDownList ID="cboShopInfo" runat="server"></asp:DropDownList>                    
                </td> 
			</tr>
			<tr>
				<td><asp:radiobutton ID="optReportByDate" GroupName="grReportType" CssClass="text" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:radiobutton ID="optReportByProduct" GroupName="grReportType" CssClass="text" runat="server" /></td>
			</tr>
            <tr>
            	<td>
                	<table>
                    	<tr><td width="20">&nbsp;</td><td><asp:dropdownlist ID="ReportProductOrdering" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td></tr>
                        <tr id="ShowBySaleMode" visible="false" runat="server"><td>&nbsp;</td><td><asp:CheckBox ID="BySaleMode" Text="Group By Sale Mode" Checked="false" runat="server"></asp:CheckBox></td></tr>
                    </table>
                </td>
            </tr>
			<tr>
				<td><asp:radiobutton ID="optReportByTime" GroupName="grReportType" CssClass="text" runat="server" />
				<asp:dropdownlist ID="GroupByParam" Width="200" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
			</tr>
		</table></td>
	<td valign="top">
	<table>
		<tr>
		<td><asp:radiobutton ID="optViewByDate" GroupName="grReportViewDate" runat="server" /></td>
		<td><synature:date id="DailyDate" runat="server" /></td>
		<td colspan="2"><asp:CheckBox ID="ExpandReceipt" CssClass="text" Checked="false" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="optViewByMonth" GroupName="grReportViewDate" runat="server" /></td>
		<td><synature:date id="MonthYearDate" runat="server" /></td>
		<td colspan="2"><asp:radiobutton ID="Linechart" Text="Line Chart" Checked="true" GroupName="Group3" CssClass="text" runat="server" />
			&nbsp;<asp:radiobutton ID="Barchart" Text="Column Chart" GroupName="Group3" CssClass="text" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="optViewByYear" GroupName="grReportViewDate" runat="server" /></td>
		<td colspan="3"><synature:date id="YearDate" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="optViewByDateRange" GroupName="grReportViewDate" runat="server" /></td>
		<td><synature:date id="CurrentDate" runat="server" /></td>
		<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
		<td><synature:date id="ToDate" runat="server" /></td>
	</tr>
	<tr><td>&nbsp;</td>
		<td colspan="4"><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" />&nbsp;<asp:CheckBox ID="DisplayGraph" CssClass="text" Checked="true" runat="server" /></td>
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
	<span id="ExtraHeader" runat="server"></span>
	
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
<div id="outString" runat="server" />
<div id="errorMsg" runat="server" />
<div id="errorMsg2" runat="server" />
<div id="errorMsg3" runat="server" />
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
Dim Fm As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New GenReports()
Dim Reports As New ReportV6()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer = 6

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Report_Sale_New") Then
		
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
		
                ResultText.InnerHtml = ""
                ResultSearchText.InnerHtml = ""
                errorMsg.InnerHtml = ""
                ExtraHeader.InnerHtml = ""
		
                Dim SMData As DataTable = objDB.List("select * from SaleMode where Deleted=0 order by SaleModeID", objCnn)
		
                ShowBySaleMode.Visible = False
                If SMData.Rows.Count > 1 Then
                    ShowBySaleMode.Visible = True
                End If
		
                Dim strTemp As String
                Dim strSelShopID As String
                Dim bolSelAllShop, bolSelMultipleShop, bolShopTypeTable As Boolean
                Dim strHeaderBuild As StringBuilder
                Dim dtShopData As DataTable
                strSelShopID = ""
                bolSelAllShop = False
                bolSelMultipleShop = False
                GetSelectShopIDAndName(strSelShopID, "", bolSelAllShop, bolSelMultipleShop)
                
                dtShopData = objDB.List("Select * From ProductLevel Where ProductLevelID IN (" & strSelShopID & ") AND ShopType = 1 ", objCnn)
                                
                If dtShopData.Rows.Count = 0 Then
                    bolShopTypeTable = False
                Else
                    bolShopTypeTable = True
                End If
                                
                strHeaderBuild = New StringBuilder
                
                If (optReportByDate.Checked = True And (optViewByMonth.Checked = True Or optViewByDateRange.Checked = True Or optViewByYear.Checked = True)) Or _
                   optReportByTime.Checked = True Or (bolSelMultipleShop = True And optReportByProduct.Checked = False) Or _
                        (optReportByDate.Checked = True And optViewByDate.Checked = True And ExpandReceipt.Checked = False) Then
                    If optReportByDate.Checked = True And optViewByDate.Checked = True And ExpandReceipt.Checked = False Then
                        If bolSelAllShop = True Then
                            strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(64)(LangText) + "</td>")
                            strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(20)(LangText) + "</td>")
                        Else
                            strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(18)(LangText) & "</td>")
                        End If
				
                        If bolShopTypeTable = True Then
                            If bolSelAllShop = False Then
                                strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(19)(LangText) & "</td>")
                            End If
                            strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(21)(LangText) & "</td>")
                        End If
                        
                        Dim bolAddBeginEndTimeColumn As Boolean
                        If pRoMiSeProgramProperty.ProgramPropertyFunction.GetProgramPropertyValueInDB(objDB, objCnn, POSAdditionalProgramVariable.PROGRAMTYPE_BACKOFFICEREPORT, _
                                    1, POSAdditionalProgramVariable.BACKOFFICE_REPORT_SALEREPORT_DISPLAYBUFFETTIME, 0) = 1 Then
                            bolAddBeginEndTimeColumn = True
                        Else
                            bolAddBeginEndTimeColumn = False
                        End If
                        If bolAddBeginEndTimeColumn = True Then
                            strTemp = BackOfficeReport.GetLanguageText(LangData2, 152, LangText, "Open Time (A)")
                            strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>")
                            strTemp = BackOfficeReport.GetLanguageText(LangData2, 153, LangText, "End Time (B)")
                            strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>")
                            strTemp = BackOfficeReport.GetLanguageText(LangData2, 154, LangText, "Paid Time (C)")
                            strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>")
                            strTemp = BackOfficeReport.GetLanguageText(LangData2, 155, LangText, "End - Begin Time (B - A)")
                            strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>")
                            strTemp = BackOfficeReport.GetLanguageText(LangData2, 156, LangText, "End - Paid Time (B - C)")
                            strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>")
                            strTemp = BackOfficeReport.GetLanguageText(LangData2, 157, LangText, "ผู้ทำรายการ")
                            strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>")
                        End If
                    Else
                        If optReportByTime.Checked = True Then
                            If Request.Form("GroupByParam") = 1 Then
                                strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(61)(LangText) & "</td>")
                            Else
                                strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(60)(LangText) + "</td>")
                            End If
                        ElseIf optViewByYear.Checked = True Then
                            strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(63)(LangText) + "</td>")
                        Else
                            If bolSelAllShop = True Then
                                strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(64)(LangText) + "</td>")
                            Else
                                strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(65)(LangText) + "</td>")
                            End If
                        End If
                        strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(20)(LangText) + "</td>")
                        If bolShopTypeTable = True Then
                            strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(21)(LangText) & "</td>")
                        End If
                    End If
			
                    Dim DisplayVATType As String = "V"
                    Dim dtShopInfo As DataTable
                    dtShopInfo = objDB.List("select * from ProductLevel where ProductLevelID IN (" & strSelShopID & ") AND DisplayReceiptVATableType = 2 ", objCnn)
                    If dtShopInfo.Rows.Count <> 0 Then
                        DisplayVATType = "E"
                    End If
                    DisplayVAT.Value = DisplayVATType
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(22)(LangText) + "</td>")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(23)(LangText) + "</td>")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(24)(LangText) + "</td>")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(25)(LangText) + "</td>")
                    'HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(26)(LangText) + "</td>"
                    'If Request.Form("ShopID") >= 0 Then
                    '	If DisplayVATType = "E" Then
                    '		HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(27)(LangText) + "</td>"
                    '					HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(28)(LangText) + "</td>"
                    '				End If
                    '			End If

                    '			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(29)(LangText) + "</td>"
                    '			HeaderString += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(30)(LangText) + "</td>"
			
                ElseIf optReportByProduct.Checked = True Then
                    Dim bolAddVATPriceInProduct As Boolean
                    If pRoMiSeProgramProperty.ProgramPropertyFunction.GetProgramPropertyValueInDB(objDB, objCnn, POSAdditionalProgramVariable.PROGRAMTYPE_BACKOFFICEREPORT, _
                                1, POSAdditionalProgramVariable.BACKOFFICE_REPORT_ADDVATPRICE_SUMMARYPRODUCTREPORT, 0) = 1 Then
                        bolAddVATPriceInProduct = True
                    Else
                        bolAddVATPriceInProduct = False
                    End If
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>")
                    'Product Code
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(33)(LangText) + "</td>")
                    'Product Name
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(34)(LangText) + "</td>")
                    'Price PerUnit
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(36)(LangText) + "</td>")
                    'Amount
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(37)(LangText) + "</td>")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(35)(LangText) + "</td>")
                    'Sub Total
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(38)(LangText) + "</td>")
                    If bolAddVATPriceInProduct = True Then
                        strTemp = POSBackOfficeReport.BackOfficeReport.GetLanguageText(LangData2, 148, LangText, "Sub Total Before VAT")
                        strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>")
                        strTemp = POSBackOfficeReport.BackOfficeReport.GetLanguageText(LangData2, 149, LangText, "VAT")
                        strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>")
                    End If
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(35)(LangText) + "</td>")
                    'Discount
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(39)(LangText) + "</td>")
                    'Total Price
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(40)(LangText) + "</td>")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(35)(LangText) + "</td>")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>")
                End If
				
                If (optViewByDate.Checked = True And optReportByDate.Checked = True And ExpandReceipt.Checked = True And bolSelMultipleShop = False) Then
                    startTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """></td>")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(33)(LangText) + "</td>")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(34)(LangText) + "</td>")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(36)(LangText) + "</td>")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(37)(LangText) + "</td>")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(38)(LangText) + "</td>")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "" + "</td>")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(127)(LangText) + "</td>")
                    'If GlobalParam.ShowSubmitOrderDetail = True Then
                    strTemp = POSBackOfficeReport.BackOfficeReport.GetLanguageText(LangData2, 144, LangText, "Terminal")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>")
                    strTemp = POSBackOfficeReport.BackOfficeReport.GetLanguageText(LangData2, 145, LangText, "Order Staff")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>")
                    strTemp = POSBackOfficeReport.BackOfficeReport.GetLanguageText(LangData2, 146, LangText, "Order Time")
                    strHeaderBuild.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & strTemp & "</td>")
                    'End If
                Else
                    startTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
                End If
		
                TableHeaderText.InnerHtml = strHeaderBuild.ToString
                
                GroupByParam.Items(0).Text = LangData2.Rows(4)(LangText)
                GroupByParam.Items(0).Value = "1"
                GroupByParam.Items(1).Text = LangData2.Rows(5)(LangText) & BackOfficeReport.GetLanguageText(LangData2, 139, LangText, "(Open Time)")
                GroupByParam.Items(1).Value = "2"
                GroupByParam.Items(2).Text = LangData2.Rows(5)(LangText) & BackOfficeReport.GetLanguageText(LangData2, 140, LangText, "(Paid Time)")
                GroupByParam.Items(2).Value = "3"
                If Request.Form("GroupByParam") = 1 Then
                    GroupByParam.Items(0).Selected = True
                ElseIf Request.Form("GroupByParam") = 2 Then
                    GroupByParam.Items(1).Selected = True
                ElseIf Request.Form("GroupByParam") = 3 Then
                    GroupByParam.Items(2).Selected = True
                Else
                    GroupByParam.Items(0).Selected = True
                End If
		
        ReportProductOrdering.Items(0).Text = LangData2.Rows(2)(LangText)
        ReportProductOrdering.Items(0).Value = "p.ProductCode"
        ReportProductOrdering.Items(1).Text = LangData2.Rows(3)(LangText)
        ReportProductOrdering.Items(1).Value = "p.ProductName"
        If Request.Form("ReportProductOrdering") = "p.ProductCode" Then
            ReportProductOrdering.Items(0).Selected = True
        ElseIf Request.Form("ReportProductOrdering") = "p.ProductName" Then
            ReportProductOrdering.Items(1).Selected = True
        Else
            ReportProductOrdering.Items(0).Selected = True
        End If
		
        ExpandReceipt.Text = LangData2.Rows(6)(LangText)
        DisplayGraph.Text = LangData2.Rows(7)(LangText)
		
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
		
        YearDate.YearType = GlobalParam.YearType
        YearDate.FormName = "YearDate"
        YearDate.StartYear = GlobalParam.StartYear
        YearDate.EndYear = GlobalParam.EndYear
        YearDate.LangID = Session("LangID")
        YearDate.ShowDay = False
        YearDate.ShowMonth = False
        YearDate.Lang_Data = LangDefault
        YearDate.Culture = CultureString
		
        optReportByDate.Text = LangData2.Rows(0)(LangText)
        optReportByProduct.Text = LangData2.Rows(1)(LangText)
        Linechart.Text = LangData2.Rows(8)(LangText)
        Barchart.Text = LangData2.Rows(9)(LangText)
		
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
        ElseIf Trim(Session("YearDate_Year")) = 0 And Not Page.IsPostBack Then
            Session("YearDate_Year") = DateTime.Now.Year
        End If
        If Page.IsPostBack And Request.Form("YearDate_Year") = "" Then Session("YearDate_Year") = 0
        YearDate.SelectedYear = Session("YearDate_Year")
		
        If Not Page.IsPostBack Then
            InitialLoadMasterShopIntoCombo()
            optViewByDate.Checked = True
            optReportByDate.Checked = True
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
	
        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
        Dim FoundError As Boolean
        FoundError = False
        Session("ReportResult") = ""
	
        Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
        Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
        Dim LangText As String = "lang" + Session("LangID").ToString
	
        Dim DateFromValue As String = ""
        Dim DateToValue As String = ""
        Dim DailyDateValue As String = ""
        Dim InvC As CultureInfo = CultureInfo.InvariantCulture
        Dim AdditionalHeader As String = ""
        Dim PayTypeList As DataTable
        Dim i As Integer
	
        Dim StartDate, EndDate As String
        Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
        Dim outputString As String = ""
        Dim additionalColumnName() As String
        Dim grandTotal As Double = 0
        Dim VATTotal As Double = 0
        Dim GraphData As New DataSet()
        Dim dsAdditionalData As DataSet
        Dim ReportDate As String
        Dim YearValue4 As Integer
        Dim bolViewByMonth, bolViewByRange, bolViewByDate, bolViewByYear, bolReportByDate, bolReportByProduct, bolReportByTime As Boolean
        Dim strSelShopID, strSelShopName As String
        Dim bolSelAllShop, bolSelMultipleShop As Boolean
        
        bolViewByMonth = False
        bolViewByRange = False
        bolViewByDate = False
        bolViewByYear = False
        If Request.Form("grReportViewDate") = "optViewByMonth" Then
            bolViewByMonth = True
        ElseIf Request.Form("grReportViewDate") = "optViewByDateRange" Then
            bolViewByRange = True
        ElseIf Request.Form("grReportViewDate") = "optViewByDate" Then ' Date
            bolViewByDate = True
        Else
            bolViewByYear = True
        End If
	
        Dim ReportType As String
        If Request.Form("grReportType") = "optReportByDate" Then
            bolReportByDate = True
            If bolViewByDate = True Then
                ReportType = LangData2.Rows(11)(LangText)
            ElseIf bolViewByRange = True Then
                ReportType = LangData2.Rows(14)(LangText)
            ElseIf bolViewByMonth = True Then
                ReportType = LangData2.Rows(12)(LangText)
            Else
                ReportType = LangData2.Rows(13)(LangText)
            End If
        ElseIf Request.Form("grReportType") = "optReportByProduct" Then
            bolReportByProduct = True
            ReportType = LangData2.Rows(15)(LangText)
        ElseIf Request.Form("grReportType") = "optReportByTime" Then
            bolReportByTime = True
            Select Case Request.Form("GroupByParam")
                Case 2          'By Time (Open Time)
                    ReportType = LangData2.Rows(17)(LangText)

                Case 3          'By Time (Paid Time)
                    ReportType = BackOfficeReport.GetLanguageText(LangData2, 138, LangText, "Sale Report By Hourly (Paid Time) of")
                    
                Case Else
                    ReportType = LangData2.Rows(16)(LangText)
            End Select
        End If
	
        Dim ExpReceipt As Boolean = False
        If Request.Form("ExpandReceipt") = "on" Then ExpReceipt = True
	
        Dim DGraph As Boolean = False
        If Request.Form("DisplayGraph") = "on" Then DGraph = True
	
        Dim SMode As Boolean = False
        If Request.Form("BySaleMode") = "on" Then SMode = True
	
        If bolViewByMonth = True Then
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
                errorMsg.InnerHtml = ex.Message
            End Try
        ElseIf bolViewByRange = True Then
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
                errorMsg.InnerHtml = ex.Message
            End Try
        ElseIf bolViewByDate = True Then
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
        ElseIf bolViewByYear = True Then
            Try
                StartDate = DateTimeUtil.FormatDate(1, 1, Request.Form("YearDate_Year"))
		 
                YearValue4 = Request.Form("YearDate_Year") + 1
                EndDate = DateTimeUtil.FormatDate(1, 1, YearValue4)
                Dim SDate4 As New Date(Request.Form("YearDate_Year"), 1, 1)
                ReportDate = DateTimeUtil.FormatDateTime(SDate4, "yyyy", Session("LangID"), objCnn)
            Catch ex As Exception
                FoundError = True
                errorMsg.InnerHtml = ex.Message
            End Try
        Else
            DateFromValue = ""
            DateToValue = ""
            DailyDateValue = ""
            StartDate = ""
            EndDate = ""
        End If

        'Get All Shop
        strSelShopID = ""
        strSelShopName = ""
        bolSelAllShop = False
        bolSelMultipleShop = False
        GetSelectShopIDAndName(strSelShopID, strSelShopName, bolSelAllShop, bolSelMultipleShop)
        
        If bolSelAllShop = True And bolViewByYear = True Then
            'errorMsg.InnerHtml = "Report is not support option All Shop with total year data"
            'FoundError = True
        End If
	
        If strSelShopID = "" Or strSelShopID = "-1" Then
            FoundError = True
            errorMsg.InnerHtml = "Please select shop before submission"
        End If
	
        If FoundError = False Then
            Reports.CheckConfigReport(1, objCnn)
		
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If
            Dim displayTable As New DataTable()
		
            ShowPrint.Visible = True
            showResults.Visible = True
		
            Dim ViewOption As Integer
            If bolViewByMonth = True Then
                ViewOption = 1
            ElseIf bolViewByRange = True Then
                ViewOption = 2
            ElseIf bolViewByYear = True Then
                ViewOption = 4
            Else
                ViewOption = 0
            End If
		
            'Application.Lock()
            Dim HavePrepaid As Boolean = False
            Dim HavePrepaidDiscount As Boolean = False
            Dim ExtraPayText As String
            Dim IncomeType As DataTable
            Dim LangPath As String = Util.GetLangPath(Request.PhysicalApplicationPath)

            ReDim additionalColumnName(-1)
            dsAdditionalData = New DataSet
            ResultText.InnerHtml = Reports.SaleReports(IncomeType, PayTypeList, dsAdditionalData, outputString, grandTotal, VATTotal, GraphData, _
                                          additionalColumnName, True, GlobalParam.GrayBGColor, GlobalParam.AdminBGColor, Session("LangID"), _
                                          ViewOption, bolReportByDate, bolReportByProduct, bolReportByTime, 1, "", Request.Form("GroupByParam"), _
                                          StartDate, EndDate, Request.Form("ReportProductOrdering"), "", "", "", strSelShopID, 0, 0, True, _
                                          ExpReceipt, DGraph, LangPath, SMode, Session("StaffRole"), objCnn)
	
            If (bolReportByDate = True And (bolViewByMonth = True Or bolViewByRange = True Or bolViewByYear = True)) Or _
                bolReportByTime = True Or (bolReportByDate = True And bolViewByDate = True And (ExpReceipt = False Or (ExpReceipt = True And bolSelMultipleShop = True))) Then
                'Exempt VAT
                If additionalColumnName.Length > 0 Then
                    If additionalColumnName(0) <> "" Then
                        AdditionalHeader &= "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & additionalColumnName(0) & "</td>"
                    End If
                End If
                'Other Income                
                For i = 0 To IncomeType.Rows.Count - 1
                    AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + IncomeType.Rows(i)("IncomeName") + "</td>"
                Next
			
                AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(26)(LangText) + "</td>"
                If strSelShopID <> "-1" Then
                    If DisplayVAT.Value = "E" Then
                        AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(27)(LangText) + "</td>"
                        AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(28)(LangText) + "</td>"
                    End If
                End If
                If DisplayVAT.Value <> "E" Then
                    AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(134)(LangText) + "</td>"
                    AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(30)(LangText) + "</td>"
                End If
								
                For i = 0 To PayTypeList.Rows.Count - 1
                    ExtraPayText = ""
                    If PayTypeList.Rows(i)("PrepaidDiscountPercent") > 0 Then
                        HavePrepaidDiscount = True
                        ExtraPayText = "<br>Total/Disc"
                    End If
                    AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + PayTypeList.Rows(i)("PayTypeName") + ExtraPayText + "</td>"
                    If PayTypeList.Rows(i)("IsSale") = 0 Then
                        If PropertyInfo.Rows(0)("SummaryPrepaidInSaleReport") = 1 Then
                            HavePrepaid = True
                        End If
                    End If
                Next
                Dim bolShopTableType As Boolean
                Dim dtShopData As DataTable
                dtShopData = objDB.List("Select * From ProductLevel Where ProductLevelID IN (" & strSelShopID & ") AND ShopType = 1 ", objCnn)
                If dtShopData.Rows.Count = 0 Then
                    bolShopTableType = False
                Else
                    bolShopTableType = True
                End If
                AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(31)(LangText) + "</td>"
                AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(32)(LangText) + "</td>"

                'Insert Cash Out/ Cash Balance For Bonchon
                If dsAdditionalData.Tables.Count > 0 Then
                    If dsAdditionalData.Tables.Contains("CashInOutData") = True Then
                        'CashOunt                
                        AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & "CASH OUT" & "</td>"
                        'Cash Balance
                        AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & "CASH BALANCE" & "</td>"
                    End If
                End If
                
                AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(88)(LangText) & "</td>"
                If bolShopTableType = True Then
                    AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & LangData2.Rows(87)(LangText) & "</td>"
                End If
			
                Dim NotInRevenueBit As Boolean = False
                Try
                    NotInRevenueBit = PropertyInfo.Rows(0)("EnableNotInRevenue")
                Catch ex As Exception
                    NotInRevenueBit = False
                End Try
                Try
                    If NotInRevenueBit = True Then
                        Dim NotInRevenueData As DataTable = getReport.NotInRevenueType(objCnn)
                        For i = 0 To NotInRevenueData.Rows.Count - 1
                            AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + NotInRevenueData.Rows(i)("NotInRevenueName") + "</td>"
                        Next
                        AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(66)(LangText) + "</td>"
                        HavePrepaidDiscount = True
                    End If
                Catch ex As Exception
                    NotInRevenueBit = False
                End Try
                If HavePrepaidDiscount = True Then
                    AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(67)(LangText) + "</td>"
                End If
                If HavePrepaid = True Then
                    AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(68)(LangText) + "</td>"
                    AdditionalHeader += "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + LangData2.Rows(69)(LangText) + "</td>"
                End If
				
                ExtraHeader.InnerHtml = AdditionalHeader
            End If

            Dim ShopDisplay As String
            If bolSelAllShop = True Then
                ShopDisplay = LangData2.Rows(70)(LangText)
            Else
                ShopDisplay = strSelShopName
            End If
            ResultSearchText.InnerHtml = ReportType + " " + ShopDisplay + " (" + ReportDate + ")"
            'Application.UnLock()
		
            Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & _
                                    "</td></tr><tr><td>" & startTable.InnerHtml & "<tr>" & TableHeaderText.InnerHtml & ExtraHeader.InnerHtml & "</tr>" & ResultText.InnerHtml & "</td></tr></table>"

            If DGraph = True And (bolViewByDate = False Or (bolViewByDate = True And bolSelAllShop = True) Or _
                   (bolViewByDate = True And ExpReceipt = False And (Request.Form("GroupByParam") = 2 Or Request.Form("GroupByParam") = 3))) And _
                    (bolReportByDate = True Or bolReportByTime = True) Then

                showGraph.Visible = True
                Dim view As DataView = GraphData.Tables(0).DefaultView
				
                If view.Count > 0 Then
            
                    If Barchart.Checked = True Then
                        Dim chart As New ColumnChart()
                        chart.Fill.Color = Color.FromArgb(80, Color.SpringGreen)
                        chart.Line.Color = Color.SteelBlue
                        chart.Line.Width = 2
                        chart.ShowLegend = True
                        chart.DataSource = view
                        chart.DataXValueField = "Description"
                        chart.DataYValueField = "Value1"
                        chart.DataBind()
                        ChartControl1.Charts.Add(chart)
                        ConfigureColors(ReportType & " " + ShopDisplay + " (" + ReportDate + ")")
			
                        ChartControl1.RedrawChart()
                    Else
                        Dim chart As New SmoothLineChart()
                        chart.Fill.Color = Color.FromArgb(80, Color.SpringGreen)
                        chart.Line.Color = Color.SteelBlue
                        chart.Line.Width = 2
                        chart.ShowLegend = True
                        chart.DataSource = view
                        chart.DataXValueField = "Description"
                        chart.DataYValueField = "Value1"
                        chart.DataBind()
                        ChartControl1.Charts.Add(chart)
                        ConfigureColors(ReportType & " " + ShopDisplay + " (" + ReportDate + ")")
			
                        ChartControl1.RedrawChart()

                    End If
                Else
                    showGraph.Visible = False
                End If
            ElseIf bolReportByProduct = True And DGraph = True Then
                showGraph.Visible = True
			
                Dim view As DataView = GraphData.Tables(0).DefaultView
                If view.Count > 0 Then
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
                    ConfigureColors(ReportType + " " + ShopDisplay + " (" + ReportDate + ")")
        
                    ChartControl1.RedrawChart()
                End If
            Else
                showGraph.Visible = False
            End If
        End If
    End Sub

    
    Private Sub GetSelectShopIDAndName(ByRef selShopID As String, ByRef selShopName As String, ByRef bolSelAllShop As Boolean, byref bolSelMultipleShop as Boolean)
        Dim i, noSelShop As Integer
        bolSelAllShop = False
        bolSelMultipleShop = False
        selShopID = ""
        selShopName = ""
        If ShowShopInfoCombo.Visible = True Then
            If cboShopInfo.Items.Count > 0 Then
                If cboShopInfo.SelectedIndex = 0 Then
                    bolSelAllShop = True
                    bolSelMultipleShop = True
                    For i = 1 To cboShopInfo.Items.Count - 1
                        selShopID &= cboShopInfo.Items(i).Value & ", "
                        selShopName &= cboShopInfo.Items(i).Text & ", "
                    Next i
                Else
                    bolSelAllShop = False
                    selShopID &= cboShopInfo.SelectedItem.Value & ", "
                    selShopName &= cboShopInfo.SelectedItem.Text & ", "
                End If
            End If
        Else
            bolSelAllShop = chkSelectAllShop.Checked
            noSelShop = 0
            For i = 0 To chklShopInfo.Items.Count - 1
                If chklShopInfo.Items(i).Selected = True Then
                    selShopID &= chklShopInfo.Items(i).Value & ", "
                    selShopName &= chklShopInfo.Items(i).Text & ", "
                    noSelShop += 1
                End If
            Next
            If noSelShop > 1 Then
                bolSelMultipleShop = True
            End If
        End If
        If selShopID <> "" Then
            selShopID = Mid(selShopID, 1, Len(selShopID) - 2)
        Else
            selShopID = "-1"
        End If
        If selShopName <> "" Then
            selShopName = Mid(selShopName, 1, Len(selShopName) - 2)
        End If
    End Sub
           
    Private Sub InitialLoadMasterShopIntoCombo()
        If POSBackOfficeReport.ReportShareSQL.BackOfficeReport_IsDisplayShopByMasterShop(objDB, objCnn) <> 0 Then
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
            If chklMasterShop.Items.Count <= 1 Then
                ShowMasterShop.Visible = False
            Else
                ShowMasterShop.Visible = True
            End If
            ShowShopInfoList.Visible = True
            ShowShopInfoCombo.Visible = False
        Else
            chklMasterShop.Items.Clear()
            ShowMasterShop.Visible = False
            ShowShopInfoList.Visible = False
            ShowShopInfoCombo.Visible = True
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
        
        cboShopInfo.Items.Clear()
        chklShopInfo.Items.Clear()
        
        'All Shop For Combo
        lstItem = New ListItem
        lstItem.Text = "----- All Shops -----"
        lstItem.Value = 0
        cboShopInfo.Items.Add(lstItem)
        For i = 0 To dtShopData.Rows.Count - 1
            lstItem = New ListItem
            lstItem.Text = dtShopData.Rows(i)("ProductLevelName")
            lstItem.Value = dtShopData.Rows(i)("ProductLevelID")
            chklShopInfo.Items.Add(lstItem)
            lstItem = New ListItem
            lstItem.Text = dtShopData.Rows(i)("ProductLevelName")
            lstItem.Value = dtShopData.Rows(i)("ProductLevelID")
            cboShopInfo.Items.Add(lstItem)
        Next i
        
        If dtShopData.Rows.Count >= 1 Then
            cboShopInfo.SelectedIndex = 1
        End If
    End Sub
    
    Sub ConfigureColors(TitleName As String)
        'ChartControl1.Background.Color = Color.FromArgb(75, Color.SteelBlue)
        Dim ChartWidth As Integer = 650
        Dim ChartHeight As Integer = 500
        If Request.Form("grReportType") = "optReportByProduct" Then
            ChartWidth = 700
            ChartHeight = 550
        ElseIf Request.Form("grReportType") = "optReportByTime" Then
            If Request.Form("GroupByParam") = 1 Then
                ChartWidth = 650
                ChartHeight = 450
            Else
                ChartWidth = 650
                ChartHeight = 450
            End If
        End If
        ChartControl1.Background.Type = InteriorType.LinearGradient
        ChartControl1.Background.ForeColor = Color.SteelBlue
        ChartControl1.Background.EndPoint = New Point(ChartWidth, ChartHeight)
        ChartControl1.Legend.Position = LegendPosition.Bottom
        'ChartControl1.Legend.Width = 40
        ChartControl1.Width = Unit.Parse(ChartWidth.ToString + "px")
        ChartControl1.Height = Unit.Parse(ChartHeight.ToString + "px")
 
        ChartControl1.YAxisFont.ForeColor = Color.SteelBlue
        ChartControl1.XAxisFont.ForeColor = Color.SteelBlue
            
        ChartControl1.ChartTitle.Text = TitleName
        ChartControl1.ChartTitle.ForeColor = Color.White
      
        ChartControl1.Border.Color = Color.SteelBlue

        'ChartControl1.BorderStyle = BorderStyle.Ridge
    End Sub
	
    Sub ExportData(Source As Object, E As EventArgs)
        Dim FileName As String = "SaleData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
        Dim CSSFile As String = Replace(UCase(Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))), "REPORTS", "") & "StyleSheet\admin.css"
	
        Util.ExportData(Session("ReportResult"), FileName, CSSFile, GlobalParam.ExportCharSet, -1)
    End Sub
	
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
