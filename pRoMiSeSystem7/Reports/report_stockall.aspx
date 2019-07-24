<%@ Page Language="VB" ContentType="text/html" EnableViewState="True"  debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@Import Namespace="POSDBFront" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Stock Summary Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="../StyleSheet/webscript.js"></script> 
</head>
<body>

<div id="ShowContent" visible="false" runat="server">
<form id="mainForm" runat="server">
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
<table border="0">
<span id="showShop" runat="server">
<tr>
	<td><span id="SelectMonth" class="text" runat="server"></span></td>
	<td><synature:date id="MonthYearDate" runat="server" /></td>
	<td><asp:dropdownlist ID="OrderParam" Width="250" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
	<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
</tr>
    <tr>
        <td></td>
        <td colspan ="2"><asp:dropdownlist ID="cboMaterialGroup"  runat="server">
		</asp:dropdownlist></td>
    </tr>
</span>
</table>
</div>
<br>
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

<span id="myTable" visible="false" runat="server">
<span id="startTable" runat="server"></span>
	<span id="headerTextString" runat="server"></span>
	
	<div id="ResultText" runat="server"></div>
</table>
</span></td></tr>
</table></span>
<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
<span id="ResultString" runat="server"></span>
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
Dim getInfo As New CCategory()
Dim objDB As New CDBUtil()
Dim DateTimeUtil As New MyDateTime()
Dim getReport As New GenReports()
Dim CostInfo As New CostClass()
Dim getProp As New CPreferences
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PageID As Integer  = 998

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Report_StockAll") Then
		
            Try
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true;" & GetPostBackEventReference(SubmitForm).ToString
                objCnn = getCnn.EstablishConnection()
                ShowContent.Visible = True
                errorMsg.InnerHtml = ""
		
                startTable.InnerHtml = "<table border=""1"" cellpadding=""4"" cellspacing=""0"" style=""border-collapse:collapse;"" width=""100%"">"
			
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
                
                Dim selIndex, selValue As Integer
                Dim strGroupValue As String
                Dim dtMaterialGroup As DataTable
                strGroupValue = ""
                If Trim(Request.Form("cboMaterialGroup")) <> "" Then
                    strGroupValue = Request.Form("cboMaterialGroup").ToString
                ElseIf Trim(Request.QueryString("cboMaterialGroup")) <> "" Then
                    strGroupValue = Request.QueryString("cboMaterialGroup").ToString
                End If
                If Not IsNumeric(strGroupValue) Then
                    selValue = -1
                Else
                    selValue = CInt(strGroupValue)
                End If
                                
                selIndex = -1
                dtMaterialGroup = getInfo.GetMaterialGroup(0, 0, objCnn)
                cboMaterialGroup.Items.Clear()
                cboMaterialGroup.Items.Add("-------- All --------")
                cboMaterialGroup.Items(0).Value = 0
                For i = 0 To dtMaterialGroup.Rows.Count - 1
                    cboMaterialGroup.Items.Add(dtMaterialGroup.Rows(i)("MaterialGroupName"))
                    cboMaterialGroup.Items(cboMaterialGroup.Items.Count - 1).Value = dtMaterialGroup.Rows(i)("MaterialGroupID")
                    If selValue = dtMaterialGroup.Rows(i)("MaterialGroupID") Then
                        selIndex = i
                    End If
                Next i
                If selIndex <> -1 Then
                    cboMaterialGroup.SelectedIndex = selIndex + 1
                Else
                    cboMaterialGroup.SelectedIndex = 0
                End If
                                
                
                SubmitForm.Text = LangDefault.Rows(3)(LangText)
		
                LangText0.Text = "Stock Card Summary Report"

			
                MonthYearDate.YearType = GlobalParam.YearType
                MonthYearDate.FormName = "MonthYearDate"
                MonthYearDate.StartYear = GlobalParam.StartYear
                MonthYearDate.EndYear = GlobalParam.EndYear
                MonthYearDate.LangID = Session("LangID")
                MonthYearDate.ShowDay = False
                MonthYearDate.Lang_Data = LangDefault
                MonthYearDate.Culture = CultureString
			
                OrderParam.Items(0).Text = "Order By Group -> Material Code"
                OrderParam.Items(0).Value = "a.MaterialGroupCode,a.MaterialCode"
                OrderParam.Items(1).Text = "Order By Group -> Material Name"
                OrderParam.Items(1).Value = "a.MaterialGroupCode,a.MaterialName"
                OrderParam.Items(2).Text = "Order By Material Code"
                OrderParam.Items(2).Value = "a.MaterialCode"
                OrderParam.Items(3).Text = "Order By Material Name"
                OrderParam.Items(3).Value = "a.MaterialName"
			
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
			
			
            Catch ex As Exception
                errorMsg.InnerHtml = ex.Message
            End Try
	  
        Else
            errorMsg.InnerHtml = "Access Denied"
        End If
    End Sub

Sub DoSearch(Source As Object, E As EventArgs)
	Dim FoundError As Boolean
	FoundError = False
	Session("ReportResult") = ""
	Dim LangData2 As DataTable = getProp.GetLangData(PageID,2,-1,Request)
	Dim LangDefault As DataTable = getProp.GetLangData(999,2,-1,Request)
	Dim LangText As String = "lang" + Session("LangID").ToString
	Dim FormatData As DataTable = Util.FormatParam(FormatObject,Session("LangID"),objCnn)
	Dim ci As New CultureInfo(FormatObject.CultureString)
	myTable.Visible = False
	'Try
	
        Dim i As Integer
        Dim selGroupID As String
	Dim SelMonth As Integer = 0
	Dim SelYear As Integer = 0
	If IsNumeric(Request.Form("MonthYearDate_Month")) Then SelMonth = Request.Form("MonthYearDate_Month")
	If IsNumeric(Request.Form("MonthYearDate_Year")) Then SelYear = Request.Form("MonthYearDate_Year")
	
	Dim ShowGroup As Boolean = False
	If Trim(Request.Form("MaterialGroup")) = "" AND (OrderParam.SelectedIndex = 0 Or OrderParam.SelectedIndex = 1) Then
		ShowGroup = True
        End If

        If cboMaterialGroup.SelectedIndex = 0 Then
            selGroupID = ""
            For i = 1 To cboMaterialGroup.Items.Count - 1
                selGroupID &= cboMaterialGroup.Items(i).Value & ", "
            Next i
            If selGroupID <> "" Then
                selGroupID = Mid(selGroupID, 1, Len(selGroupID) - 2)
            End If
        Else
            selGroupID = cboMaterialGroup.Items(cboMaterialGroup.SelectedIndex).Value
        End If
        	
        If SelMonth = 0 Or SelYear = 0 Then
            FoundError = True
        End If
        If FoundError = False Then
            If LangDefault.Rows.Count >= 3 Then
                CreateReportDate.Text = LangDefault.Rows(2)(LangText) & " " & DateTimeUtil.FormatDateTime(Now(), "DateAndTime", Session("LangID"), objCnn)
            End If
            ShowPrint.Visible = True
            myTable.Visible = True
            Dim TestTime, Result As String
            Dim dtTable As DataTable
            Dim displayTable As New DataTable()
            Dim ShopData As DataTable = getInfo.GetProductLevel(-99, objCnn)
            Dim TableNameString As String = "DummyMaterialCostTableAllStock" 'Session.SessionID + "AllStock"
		
            'Application.Lock()
            dtTable = New DataTable
            Result = getReport.StockCardAllReport(dtTable, TableNameString, ShopData, SelMonth, SelYear, selGroupID, Request.Form("OrderParam"), objCnn)
            'Application.UnLock()
		
            'errorMsg.InnerHtml = ShopData.Rows.Count.ToString + "::" + ShopData.Rows(0)("ProductLevelID").ToString

            Dim ReportDate As String
            Dim SDate As New Date(Request.Form("MonthYearDate_Year"), Request.Form("MonthYearDate_Month"), 1)
            ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy", Session("LangID"), objCnn)
            ResultSearchText.InnerHtml = "Stock Card All Shop Report " + " (" + ReportDate + ")"
		
            Dim totalSale As Double = 0
            Dim totalCost As Double = 0
            Dim deptCost As Double = 0
            Dim groupCost As Double = 0
            
            Dim StartDate, EndDate As String
            Dim StartMonthValue, StartYearValue, EndMonthValue, EndYearValue As Integer
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

            Dim totalStandardCost As Double = 0
            Dim SubTotalQty As Double = 0
            Dim GroupTotalPrice As Double = 0
            Dim SubTotalPrice As Double = 0
            Dim TotalPrice As Double = 0
            Dim TotalQty As Double = 0
            Dim EndingSum As Double = 0
            Dim TotalSum As Double = 0
		
            Dim HeaderString As String = "<tr>"
            If ShowGroup = True Then
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Group Code" + "</td>"
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Group Name" + "</td>"
            End If
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Material Code" + "</td>"
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Material Name" + "</td>"
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Unit" + "</td>"
            For i = 0 To ShopData.Rows.Count - 1
                HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + ShopData.Rows(i)("ProductLevelName") + "</td>"
            Next

            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Total Qty" + "</td>"
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Cost @" + "</td>"
            HeaderString += "<td align=""center"" class=""smallTdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "Total Cost" + "</td>"
            HeaderString += "</tr>"
            headerTextString.InnerHtml = HeaderString
		
            Dim QtyString As String
            Dim resultString As StringBuilder = New StringBuilder
            Dim showData As Boolean
            Dim j As Integer
            Dim UnitInfo As DataTable
            Dim PricePerUnit As Double
		
            Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
            Dim outString As String = ""
            Dim UnitText As String
            Dim UnitRatioVal As Double = 1
            Dim DummyGroupID As Integer
            Dim DummyGroupName As String
            Dim groupDocCount As Integer
            Dim ColSpan As Integer
            ColSpan = 5 + ShopData.Rows.Count
            If ShowGroup = True Then
                ColSpan += 2
            End If

            groupDocCount = 0
            DummyGroupID = -1
            DummyGroupName = ""
            For i = 0 To dtTable.Rows.Count
                outString = ""
                If ShowGroup = True Then
                    Dim bolDisplaySummary As Boolean
                    Dim outputS As StringBuilder = New StringBuilder
                    bolDisplaySummary = False
                    If i = 0 Then
                        bolDisplaySummary = False
                    ElseIf i = dtTable.Rows.Count Then
                        bolDisplaySummary = True
                    ElseIf DummyGroupID <> dtTable.Rows(i)("MaterialGroupID") Then
                        bolDisplaySummary = True
                    Else
                        bolDisplaySummary = False
                    End If
                    If bolDisplaySummary = True Then
                        If groupDocCount > 0 Then
                            outputS = outputS.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
                            outputS = outputS.Append("<td class=""smallText"" align=""right"" colspan=""" + ColSpan.ToString + """>Summary for " + DummyGroupName + "</td>")
                            outputS = outputS.Append("<td class=""smallText"" align=""right"">" + (GroupTotalPrice).ToString(FormatObject.AccountingFormat, ci) + "</td>")
                            outputS = outputS.Append("</tr>")
                            outString = outputS.ToString
                        End If
                        groupDocCount = 0
                        GroupTotalPrice = 0
                        If Trim(outString) <> "" Then
                            resultString = resultString.Append(outString)
                        End If
                    End If
                End If
						
                If i = dtTable.Rows.Count Then
                    Exit For
                End If
                                
                Dim outputString As StringBuilder = New StringBuilder
                UnitRatioVal = 1
                If Not IsDBNull(dtTable.Rows(i)("UnitSmallName")) Then
                    UnitText = dtTable.Rows(i)("UnitSmallName")
                Else
                    UnitText = "-"
                End If
                UnitInfo = getInfo.GetUnitSetting(dtTable.Rows(i)("MaterialID"), dtTable.Rows(i)("UnitSmallID"), objCnn)
                If UnitInfo.Rows.Count <> 0 Then
                    UnitRatioVal = UnitInfo.Rows(0)("UnitSmallRatio")
                    UnitText = UnitInfo.Rows(0)("UnitLargeName")
                End If
                showData = False
                SubTotalQty = 0
		
                outputString = outputString.Append("<tr>")
                If ShowGroup = True Then
                    outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialGroupCode") + "</td>")
                    outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialGroupName") + "</td>")
                End If
                outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialCode") + "</td>")
                outputString = outputString.Append("<td class=""smallText"" align=""left"">" + dtTable.Rows(i)("MaterialName") + "</td>")
                outputString = outputString.Append("<td class=""smallText"" align=""left"">" + UnitText + "</td>")
                For j = 0 To ShopData.Rows.Count - 1
                    QtyString = "Qty" + ShopData.Rows(j)("ProductLevelID").ToString
                    If Not IsDBNull(dtTable.Rows(i)(QtyString)) Then
                        outputString = outputString.Append("<td class=""smallText"" align=""center""><a  class=""smallText"" href=""JavaScript: newWindow = window.open( 'report_material_movement.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&SelMonth=" & Request.Form("MonthYearDate_Month").ToString & "&SelYear=" & Request.Form("MonthYearDate_Year").ToString & "&ProductLevelID=" & ShopData.Rows(j)("ProductLevelID").ToString + "', '', 'width=900,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + CDbl(dtTable.Rows(i)(QtyString) / UnitRatioVal).ToString(FormatObject.AccountingFormat, ci) + "</a></td>")
                        SubTotalQty += dtTable.Rows(i)(QtyString)
                    Else
                        outputString = outputString.Append("<td class=""smallText"" align=""center"">" + "0" + "</td>")
                    End If
                Next
                outputString = outputString.Append("<td class=""smallText"" align=""center"" bgColor=""" + GlobalParam.GrayBGColor + """>" + (SubTotalQty / UnitRatioVal).ToString(FormatObject.AccountingFormat, ci) + "</td>")
                Try
                    If Not IsDBNull(dtTable.Rows(i)("PricePerUnit")) Then
                        PricePerUnit = dtTable.Rows(i)("PricePerUnit")
                    Else
                        PricePerUnit = 0
                    End If
                Catch ex As Exception
                    PricePerUnit = 0
                End Try
                outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """><a  class=""smallText"" href=""JavaScript: newWindow = window.open( '../Inventory/product_stdcost.aspx?MaterialID=" + dtTable.Rows(i)("MaterialID").ToString + "&SelMonth=" & Request.Form("MonthYearDate_Month").ToString & "&SelYear=" & Request.Form("MonthYearDate_Year").ToString & "&ProductLevelID=" & ShopData.Rows(0)("ProductLevelID").ToString + "', '', 'width=900,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + (PricePerUnit * UnitRatioVal).ToString(FormatObject.MaterialQtyFormat, ci) + "</a></td>")
                outputString = outputString.Append("<td class=""smallText"" align=""right"" bgColor=""" + GlobalParam.GrayBGColor + """>" + (PricePerUnit * SubTotalQty).ToString(FormatObject.AccountingFormat, ci) + "</td>")
                outputString = outputString.Append("</tr>")
			
                TotalQty += SubTotalQty
                TotalPrice += PricePerUnit * SubTotalQty
                GroupTotalPrice += PricePerUnit * SubTotalQty
			              
                'Remove All Material that sum of All Qty = 0 and DocCount =0 (No DocumentAtAll)
                If IsDBNull(dtTable.Rows(i)("DocCount")) Then
                    dtTable.Rows(i)("DocCount") = 0
                End If
                If (dtTable.Rows(i)("DocCount") <> 0) Then
                    groupDocCount += dtTable.Rows(i)("DocCount")
                    resultString = resultString.Append(outputString.ToString)
                End If
                DummyGroupID = dtTable.Rows(i)("MaterialGroupID")
                DummyGroupName = dtTable.Rows(i)("MaterialGroupName")
            Next
				
            resultString = resultString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """>")
            resultString = resultString.Append("<td class=""smallText"" align=""right"" colspan=""" + ColSpan.ToString + """>Summary</td>")
		
            resultString = resultString.Append("<td class=""smallText"" align=""right"">" + (TotalPrice).ToString(FormatObject.AccountingFormat, ci) + "</td>")
		
            resultString = resultString.Append("</tr>")
		
            ResultText.InnerHtml = resultString.ToString
            TestTime += "<br>" + DateTimeUtil.CurrentDateTime
		
            Session("ReportResult") = "<table><tr><td align=""center"">" & ResultSearchText.InnerHtml & "</td></tr><tr><td align=""right"">" & CreateReportDate.Text & "</td></tr><tr><td>" & startTable.InnerHtml & headerTextString.InnerHtml & ResultText.InnerHtml & "</td></tr></table>"
        End If
        'Catch ex As Exception
        'FoundError = True
        'End Try
    End Sub

Sub ExportData(Source As Object, E As EventArgs)
	
	Dim FileName As String = "StockAllData_" & DateTime.Now.ToString("yyyyMMdd_HHmmss", InvC) & ".xls"
	
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
