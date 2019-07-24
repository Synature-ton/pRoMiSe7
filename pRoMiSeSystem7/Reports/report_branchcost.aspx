<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="CostClassDoro.pRoMiSeCosting" %>
<%@Import Namespace="DoroReports" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Stock Card Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>

<div id="ShowContent" visible="false" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="ShopIDList" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><table width="100%"><tr><td align="left" width="70%"><b class="headerText"><span id="headerText" runat="server" /></b></td><td align="right"></td></tr></table></div>
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
	<td><span id="SelectShop" class="text" runat="server"></span></td>
	<td><span id="ShopText" runat="server"></span></td>
	<td><span id="SelectMonth" class="text" runat="server"></span></td>
	<td><synature:date id="MonthYearDate" runat="server" /></td>
	<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
	<td><asp:CheckBox ID="DisplayOnly" Checked="true" Text="Display only materials that have movement" CssClass="text" Visible="false" runat="server" /></td>
</tr>
<tr>
	<td></td>
	<td><span id="ReportTypeText" runat="server"></span></td>
	<td colspan="4"><asp:dropdownlist ID="OrderParam" Visible="false" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
</tr>
</span>
</table>
</div>
<br>
<table width="100%">

<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
<tr><td align="left"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
</table>

<span id="myTable" visible="false" runat="server">
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
	<span id="headerTextString" runat="server"></span>
	
	<div id="ResultText" runat="server"></div>
</table>
</span>
<asp:DataGrid ID="DataResult" runat="server"></asp:DataGrid>
<span id="ResultString" runat="server"></span>
</form>
</div>
<div id="errorMsg" runat="server" />
<div id="errorMsg2" runat="server" />
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
Dim getInfo As New CCategory()
Dim objDB As New CDBUtil()
Dim DateTimeUtil As New MyDateTime()
Dim CostInfo As New CostClass()
Dim getPageText As New DefaultText()
Dim promiseData As New stReports()
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Reports_BranchCost") Then
		
		Try	
			SubmitForm.Attributes.Item("onclick") = "this.disabled=true;" & GetPostBackEventReference(SubmitForm).ToString
			objCnn = getCnn.EstablishConnection()
			
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(100,Session("LangID"),objCnn)
				
			ShowContent.Visible = True		
			
			SubmitForm.Text = textTable.Rows(9)("TextParamValue")
			HeaderText.InnerHtml = textTable.Rows(0)("TextParamValue")
			
			MonthYearDate.YearType = GlobalParam.YearType
			MonthYearDate.FormName = "MonthYearDate"
			MonthYearDate.StartYear = GlobalParam.StartYear
			MonthYearDate.EndYear = GlobalParam.EndYear
			MonthYearDate.LangID = Session("LangID")
			MonthYearDate.ShowDay = False
			
			OrderParam.Items(0).Text = "Order By Material Code"
			OrderParam.Items(0).Value = "a.MaterialCode"
			OrderParam.Items(1).Text = "Order By Material Name"
			OrderParam.Items(1).Value = "a.MaterialName"
			
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
			
			Dim ShopIDValue As String = "0"
			If IsNumeric(Request.Form("ShopID")) Then
				ShopIDValue = Request.Form("ShopID").ToString
			Else If IsNumeric(Request.QueryString("ShopID"))
				ShopIDValue = Request.QueryString("ShopID").ToString
			End If
			
			Dim i As Integer
                Dim outputString, FormSelected As String
			Dim Multiple As Boolean = False
			Dim ShopList As String = ""
			Dim ShopData As DataTable = getInfo.GetProductLevel(-999,objCnn)
			If ShopData.Rows.Count > 0 Then
	
				outputString = "<select name=""ShopID"" style=""width:200px"">"
				If ShopData.Rows.Count > 1 Then
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
			
			Dim ReportTypeID As String = "2"
			If IsNumeric(Request.Form("ReportTypeID")) Then
				ReportTypeID = Request.Form("ReportTypeID")
			Else If IsNumeric(Request.QueryString("ReportTypeID"))
				ReportTypeID = Request.QueryString("ReportTypeID")
			End If
			
			Dim ReportType As DataTable = promiseData.ReportProductList("",objCnn)
			
			outputString = "<select name=""ReportTypeID"" style=""width:200px"">"

			If ReportTypeID = 2 Then
                    FormSelected = "selected"
                Else
                    FormSelected = ""
                End If
                outputString += "<option value=""" & "2" & """ " & FormSelected & ">" & textTable.Rows(10)("TextParamValue")
                If ReportTypeID = 1 Then
                    FormSelected = "selected"
                Else
                    FormSelected = ""
                End If
                outputString += "<option value=""" & "1" & """ " & FormSelected & ">" & textTable.Rows(11)("TextParamValue")
                If ReportTypeID = 3 Then
                    FormSelected = "selected"
                Else
                    FormSelected = ""
                End If
                outputString += "<option value=""" & "3" & """ " & FormSelected & ">" & "Frozen"
                outputString += "</select>"
                ReportTypeText.InnerHtml = outputString
		
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
	myTable.Visible = False
	Try
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(100,Session("LangID"),objCnn)
	Dim SelMonth As Integer = 0
	Dim SelYear As Integer = 0
	If IsNumeric(Request.Form("MonthYearDate_Month")) Then SelMonth = Request.Form("MonthYearDate_Month")
	If IsNumeric(Request.Form("MonthYearDate_Year")) Then SelYear = Request.Form("MonthYearDate_Year")
	
	Dim TableString As String = "ReportBranchCostTable_" + SelMonth.ToString + "_" + SelYear.ToString
	Dim DocTypeTableString As String = "DocTypeGroup_" + SelMonth.ToString + "_" + SelYear.ToString
	Dim ChkTable As DataTable = objDB.List("show tables like '" + TableString + "'", objCnn)
	Dim ChkTable1 As DataTable = objDB.List("show tables like '" + DocTypeTableString + "'", objCnn)
	If ChkTable.Rows.Count = 0 Or ChkTable1.Rows.Count = 0 Then
		FoundError = True
		ResultSearchText.InnerHtml = "Cannot Find Data for This Month"
		Exit Sub
	End If
	Dim ChkData As DataTable = objDB.List("select count(*) AS TotalRecord from " + TableString, objCnn)
	If ChkData.Rows(0)("TotalRecord") = 0 Then
		FoundError = True
		ResultSearchText.InnerHtml = "No Data for This Month"
		Exit Sub
	End If
	If SelMonth = 0 Or SelYear = 0 Then
		FoundError = True
	End If	
	If FoundError = False Then
		ShowPrint.Visible = True
		myTable.Visible = True
                Dim TestTime As String
                Dim dtTable, groupData As DataTable
		Dim displayTable As New DataTable()
		Dim DocGroup, DocType, ShopGroup As DataTable

                Dim strSQL As String
		Dim DeptCode As String = ""
		Dim GroupCode As String = ""
		
		Application.Lock()
			'Result = StockCardReport(Request.Form("ReportTypeID"),Request.Form("ShopID"),SelMonth, SelYear,OrderParam.SelectedItem.Value,objCnn)
		Application.UnLock()
		
                DocGroup = objDB.List("select * from " + DocTypeTableString + " where GroupProperty IN (1,-1) order by GroupProperty DESC, Ordering", objCnn)
                strSQL = "Select count(*),GroupingID, SubGroupingID,GroupingName from Report_Material_Grouping " & _
                          "Where GroupingID IN (" + Request.Form("ReportTypeID").ToString + ") Group By GroupingID, SubGroupingID,GroupingName " & _
                          "Order by Ordering, GroupingName "
                DocType = objDB.List(strSQL, objCnn)
		
		'errorMsg.InnerHtml = "select count(*),SubGroupingID,GroupingName from Report_Material_Grouping where GroupingID IN (" + Request.Form("ReportTypeID").ToString + ") group by SubGroupingID,GroupingName order by Ordering"
		
		If Request.Form("ShopID") = 0 Then
			shopGroup = objDB.List("select * from ProductLevel where ProductLevelID IN (" + ShopIDList.Value + ") order by ProductLevelOrder, ProductLevelName", objCnn)
		Else
			shopGroup = objDB.List("select * from ProductLevel where ProductLevelID IN (" + Request.Form("ShopID").ToString + ") order by ProductLevelOrder, ProductLevelName", objCnn)
		End If

		Dim ReportDate As String
		Dim SDate As New Date(Request.Form("MonthYearDate_Year"),Request.Form("MonthYearDate_Month"),1)
		Dim ReportGenDate As String = "-"
		ReportDate = Format(SDate, "MMMM yyyy")
		Dim GetDateTime As DataTable = objDB.List("select * from HistoryGenData where GenDataID=1 AND GenMonth=" + SelMonth.ToString + " AND GenYear=" + SelYear.ToString + " order by GenDateTime DESC LIMIT 0,1", objCnn)
                If GetDateTime.Rows.Count > 0 Then
                    ReportGenDate = Format(GetDateTime.Rows(0)("GenDateTime"), "dd MMMM yyyy HH:mm:ss")
                End If
                ResultSearchText.InnerHtml = textTable.Rows(0)("TextParamValue") + " (" + ReportDate + ")" + "  " + textTable.Rows(6)("TextParamValue") + ":" + ReportGenDate
                Dim i As Integer
		
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
		StartDate = DateTimeUtil.FormatDate(1,StartMonthValue,StartYearValue)
		EndDate = DateTimeUtil.FormatDate(1,EndMonthValue,EndYearValue)

		Dim totalStandardCost As Double = 0
		Dim AmountDiff As Double = 0
		Dim StdUse As Double = 0
		Dim TotalUse As Double = 0
		Dim SubTotalUse As Double = 0
		Dim SubTotalPrice As Double = 0
		Dim TotalPrice As Double = 0
		Dim BeginningSum As Double = 0
		Dim EndingSum As Double = 0
		Dim TotalSum As Double = 0
		Dim TotalColSum As Integer = ShopGroup.Rows.Count
		Dim ColumnSum(TotalColSum) As Double
		Dim ColumnSaleSum(20) As Double
		
		Dim HeaderString As String = "<tr>"
		HeaderString += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + "<img src=""images/clear.gif"" border=""0"" width=""30"" height=""0"">" + "</td>"
		HeaderString += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>"  + "<img src=""images/clear.gif"" border=""0"" width=""150"" height=""0"">" + "</td>"
		For i = 0 To ShopGroup.Rows.Count - 1
			HeaderString += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + ShopGroup.Rows(i)("ProductLevelName") + "</td>"
		Next
		HeaderString += "<td align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + textTable.Rows(8)("TextParamValue") + "</td>"
		HeaderString += "</tr>"
		headerTextString.InnerHtml = HeaderString

		Dim outputString As StringBuilder = New StringBuilder
		Dim j As Integer
		Dim ii As Integer
		
		TestTime = "<P>" + DateTimeUtil.CurrentDateTime
		
                Dim getData As DataTable = objDB.List("select * from " + TableString, objCnn)
                Dim foundRows() As DataRow
                Dim expression As String
		
                For j = 0 To DocType.Rows.Count - 1
                    For i = 0 To TotalColSum
                        ColumnSum(i) = 0
                    Next
                    SubTotalPrice = 0
                    outputString = outputString.Append("<tr>")
                    outputString = outputString.Append("<td class=""smallText"" colSpan=""" + (3 + ShopGroup.Rows.Count).ToString + """ align=""left"">" + DocType.Rows(j)("GroupingName") + "</td>")
                    outputString = outputString.Append("</tr>")
                    outputString = outputString.Append("<tr>")
                    outputString = outputString.Append("<td class=""smallText"" align=""right"">" + textTable.Rows(1)("TextParamValue") + "</td>")
                    outputString = outputString.Append("<td class=""smallText"" align=""left"">" + textTable.Rows(2)("TextParamValue") + "</td>")
			
                    For i = 0 To ShopGroup.Rows.Count - 1
                        expression = "ShopID=" + ShopGroup.Rows(i)("ProductLevelID").ToString + " AND GroupingID = " & DocType.Rows(j)("GroupingID") & _
                                    " AND SubGroupingID=" + DocType.Rows(j)("SubGroupingID").ToString + " AND GroupProperty=99"
                        foundRows = getData.Select(expression)
                        'dtTable = objDB.List("select * from " + TableString + " where ShopID=" + ShopGroup.Rows(i)("ProductLevelID").ToString + " AND SubGroupingID=" + DocType.Rows(j)("SubGroupingID").ToString + " AND GroupProperty=99", objCnn)
                        If foundRows.GetUpperBound(0) >= 0 Then
                            outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(foundRows(0)("TotalPrice"), "##,##0.00") + "</td>")
                            SubTotalPrice += foundRows(0)("TotalPrice")
                            ColumnSum(i) += foundRows(0)("TotalPrice")
                        Else
                            outputString = outputString.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
                        End If
                    Next
                    outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(SubTotalPrice, "##,##0.00;(##,##0.00)") + "</td>")
                    outputString = outputString.Append("<tr>")
			
                    groupData = objDB.List("select * from " + DocTypeTableString + " where GroupProperty IN (1) order by GroupProperty DESC, Ordering", objCnn)

                    For ii = 0 To groupData.Rows.Count - 1
                        If ii = 0 Then
                            outputString = outputString.Append("<td class=""smallText"" align=""right"">" + textTable.Rows(4)("TextParamValue") + "</td>")
                        Else
                            outputString = outputString.Append("<td class=""smallText"" align=""right"">" + "" + "</td>")
                        End If
                        outputString = outputString.Append("<td class=""smallText"" align=""left"">" + groupData.Rows(ii)("GroupHeader") + "</td>")
                        SubTotalPrice = 0
                        For i = 0 To ShopGroup.Rows.Count - 1
                            expression = "ShopID=" + ShopGroup.Rows(i)("ProductLevelID").ToString + " AND GroupingID = " & DocType.Rows(j)("GroupingID") & _
                                        " AND SubGroupingID=" + DocType.Rows(j)("SubGroupingID").ToString + " AND GroupProperty=" + groupData.Rows(ii)("GroupProperty").ToString + " AND DocumentTypeGroupID=" + groupData.Rows(ii)("DocumentTypeGroupID").ToString
                            foundRows = getData.Select(expression)
                            If foundRows.GetUpperBound(0) >= 0 Then
                                outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(foundRows(0)("TotalPrice"), "##,##0.00;(##,##0.00)") + "</td>")
                                SubTotalPrice += foundRows(0)("TotalPrice")
                                ColumnSum(i) += foundRows(0)("TotalPrice")
                            Else
                                outputString = outputString.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
                            End If
                        Next
                        outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(SubTotalPrice, "##,##0.00;(##,##0.00)") + "</td>")
                        outputString = outputString.Append("<tr>")
                    Next
			
                    SubTotalPrice = 0
                    outputString = outputString.Append("<tr>")
                    outputString = outputString.Append("<td class=""smallText"" align=""right"">" + textTable.Rows(5)("TextParamValue") + "</td>")
                    outputString = outputString.Append("<td class=""smallText"" align=""left"">" + textTable.Rows(3)("TextParamValue") + "</td>")
			
                    For i = 0 To ShopGroup.Rows.Count - 1
                        strSQL = "select -TotalPrice As TotalPrice from " + TableString & _
                                " where ShopID=" + ShopGroup.Rows(i)("ProductLevelID").ToString + " AND GroupingID = " & DocType.Rows(j)("GroupingID") & " AND " & _
                                " SubGroupingID=" + DocType.Rows(j)("SubGroupingID").ToString + " AND GroupProperty=77"
                        dtTable = objDB.List(strSQL, objCnn)
                        If dtTable.Rows.Count > 0 Then
                            If Not IsDBNull(dtTable.Rows(0)("TotalPrice")) Then
                                outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(dtTable.Rows(0)("TotalPrice"), "##,##0.00;(##,##0.00)") + "</td>")
                                SubTotalPrice += dtTable.Rows(0)("TotalPrice")
                                ColumnSum(i) += dtTable.Rows(0)("TotalPrice")
                            Else
                                outputString = outputString.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
                            End If
                        Else
                            outputString = outputString.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
                        End If
                    Next
			
                    outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(SubTotalPrice, "##,##0.00;(##,##0.00)") + "</td>")
                    outputString = outputString.Append("<tr>")
			
                    groupData = objDB.List("select * from " + DocTypeTableString + " where GroupProperty IN (-1) order by GroupProperty DESC, Ordering", objCnn)
                    For ii = 0 To groupData.Rows.Count - 1
                        outputString = outputString.Append("<td class=""smallText"" align=""right"">" + "" + "</td>")
                        outputString = outputString.Append("<td class=""smallText"" align=""left"">" + groupData.Rows(ii)("GroupHeader") + "</td>")
                        SubTotalPrice = 0
                        For i = 0 To ShopGroup.Rows.Count - 1
                            expression = "ShopID=" + ShopGroup.Rows(i)("ProductLevelID").ToString + " AND GroupingID = " & DocType.Rows(j)("GroupingID") & _
                                        " AND SubGroupingID=" + DocType.Rows(j)("SubGroupingID").ToString + " AND GroupProperty=" + groupData.Rows(ii)("GroupProperty").ToString + " AND DocumentTypeGroupID=" + groupData.Rows(ii)("DocumentTypeGroupID").ToString
                            foundRows = getData.Select(expression)
                            If foundRows.GetUpperBound(0) >= 0 Then
                                outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(foundRows(0)("TotalPrice"), "##,##0.00;(##,##0.00)") + "</td>")
                                If groupData.Rows(ii)("DocumentTypeGroupID") <> 21 And groupData.Rows(ii)("DocumentTypeGroupID") <> 25 And groupData.Rows(ii)("DocumentTypeGroupID") <> 4 Then
                                    ColumnSum(i) += foundRows(0)("TotalPrice")
                                End If
                                SubTotalPrice += foundRows(0)("TotalPrice")
                            Else
                                outputString = outputString.Append("<td class=""smallText"" align=""right"">" + "-" + "</td>")
                            End If
                        Next
                        outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(SubTotalPrice, "##,##0.00;(##,##0.00)") + "</td>")
                        outputString = outputString.Append("<tr>")
                    Next
			
                    SubTotalPrice = 0
                    outputString = outputString.Append("<tr>")
                    outputString = outputString.Append("<td class=""smallText"" colspan=""2"" align=""right"">" + textTable.Rows(7)("TextParamValue") + DocType.Rows(j)("GroupingName") + "</td>")
                    For i = 0 To ShopGroup.Rows.Count - 1
                        outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(ColumnSum(i), "##,##0.00;(##,##0.00)") + "</td>")
                        SubTotalPrice += ColumnSum(i)
                    Next
                    outputString = outputString.Append("<td class=""smallText"" align=""right"">" + Format(SubTotalPrice, "##,##0.00;(##,##0.00)") + "</td>")
                    outputString = outputString.Append("<tr>")
                Next
		
		ResultText.InnerHtml = outputString.ToString
		
		TestTime += "<br>" + DateTimeUtil.CurrentDateTime
		'errorMsg.InnerHtml = TableString + TestTime
		
	End If
	Catch ex As Exception
			FoundError = True
		End Try
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub
</script>
</body>
</html>
