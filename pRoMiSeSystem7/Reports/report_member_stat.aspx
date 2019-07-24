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
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Member Statistics Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<div id="showPage" visible="true" runat="server">
<form id="mainForm" runat="server">

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

				<td><asp:DropDownList ID="ColList" runat="server"></asp:DropDownList></td>

				<td><asp:DropDownList ID="YearList" runat="server"></asp:DropDownList></td>

				<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="110" OnClick="DoSearch" runat="server" /></td>
				
				<td><asp:CheckBox ID="DisplayOption" CssClass="text" runat="server"></asp:CheckBox></td>
			</tr>

		</table></td>
</tr>
<div id="NoData"  runat="server">
<tr>
	<td class="boldText">No option member option data to be displayed. Please go to member section and create the option member data before using this report.</td>
</tr>
</div>

</table>
</div>
<br>
<div id="showResults" runat="server">
<table width="100%">
<tr id="ShowPrint" visible="false" runat="server">
	<td align="left"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td>
</tr>
<tr>
	<td><div id="ResultSearchText" class="boldText" runat="server"></div></td>
</tr>
<tr><td>
	<asp:DataGrid ID="Results" AutoGenerateColumns="false" CellPadding="3" CssClass="text" HeaderStyle-BackColor="#507093" HeaderStyle-CssClass="tdHeader" OnItemDataBound="Item_Bound" HeaderStyle-HorizontalAlign="center" AllowPaging="false" OnPageIndexChanged="ChangeGridPage" Width="100%"  runat="server">
		<columns>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" DataField="Option Name"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="1"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="2"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="3"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="4"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="5"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="6"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="7"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="8"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="9"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="10"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="11"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="12"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="Summary"></asp:BoundColumn>
		</columns>
	</asp:DataGrid></td></tr>
</table>
</div>
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
Dim getData As New CMembers()
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim GCounter As Integer = 0
		
Sub Page_Load()
	If User.Identity.IsAuthenticated  AND Session("Member_Stat") Then
		
	Try	
		Dim InvC As CultureInfo = CultureInfo.InvariantCulture
		objCnn = getCnn.EstablishConnection()
		Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
		Dim YearType As Integer = PropertyInfo.Rows(0)("YearSetting")

		showResults.Visible = False
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(13,Session("LangID"),objCnn)
		Dim textTable1 As New DataTable()
		textTable1 = getPageText.GetText(12,Session("LangID"),objCnn)
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)

		SubmitForm.Text = textTable.Rows(8)("TextParamValue")
		DisplayOption.Text = "Caluculate based on unique member"
		
		LangText0.Text = "Member Statistics"
		Dim ShopIDValue As String = "0"
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDValue = Request.Form("ShopID").ToString
		Else If IsNumeric(Request.QueryString("ShopID"))
			ShopIDValue = Request.QueryString("ShopID").ToString
		End If
			
		Dim i As Integer
		Dim outputString,FormSelected,compareString As String
		Dim SelectString As String 
		
		Dim ShopData As DataTable = getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
		If ShopData.Rows.Count > 0 Then

			outputString = "<select name=""ShopID"">"
			For i = 0 to ShopData.Rows.Count - 1
				If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
					FormSelected = "selected"
					SelShopName.Value = ShopData.Rows(i)("ProductLevelName")
				Else
					If Not Page.IsPostBack And i=0 Then
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
		NoData.Visible = False
		
		If Not Page.IsPostBack Then
			UDDDataBound(objCnn)
			
			If ColList.Items.Count = 0 Then
				SubmitForm.Enabled = False
				NoData.Visible = True
			End If
			
			Dim myDataTable As DataTable = new DataTable("YearTable")
			Dim myDataColumn As DataColumn 
			Dim myDataRow As DataRow
	
			myDataColumn = New DataColumn()
			myDataColumn.DataType = System.Type.GetType("System.String")
			myDataColumn.ColumnName = "YearValue"
			myDataColumn.ReadOnly = True
			myDataColumn.Unique = False
			myDataTable.Columns.Add(myDataColumn)
			
			myDataColumn = New DataColumn()
			myDataColumn.DataType = System.Type.GetType("System.String")
			myDataColumn.ColumnName = "Year"
			myDataTable.Columns.Add(myDataColumn)
			
			Dim YearValue As Integer
			YearValue = CInt(DateTime.Now.ToString("yyyy", InvC))
			For i = (YearValue-6) To YearValue
				myDataRow = myDataTable.NewRow()
				myDataRow("YearValue") = i.ToString
				If YearType = 1 Then
					myDataRow("Year") = i.ToString + 543
				Else
					myDataRow("Year") = i.ToString
				End If
				myDataTable.Rows.Add(myDataRow)
			Next
			YearList.DataSource = myDataTable
			YearList.DataValueField = "YearValue"
			YearList.DataTextField = "Year"
			YearList.DataBind()
			YearList.Items(YearList.Items.Count-1).Selected = True
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
	
	ShowPrint.Visible = True
	
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	Dim dtTable As DataTable = getReport.MemberStat(Request.Form("ShopID"),ColList.SelectedItem.Value,YearList.SelectedItem.Value,DisplayOption.Checked,objCnn)
	
	Dim myDataTable As DataTable = new DataTable("DataTable")
	Dim myDataColumn As DataColumn 
	Dim myDataRow As DataRow

	myDataColumn = New DataColumn()
	myDataColumn.DataType = System.Type.GetType("System.String")
	myDataColumn.ColumnName = "Option Name"
	myDataColumn.ReadOnly = True
	myDataColumn.Unique = False
	myDataTable.Columns.Add(myDataColumn)
	
	Dim i As Integer
	For i = 1 To 12 
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = i.ToString
		myDataTable.Columns.Add(myDataColumn)
	Next
	myDataColumn = New DataColumn()
	myDataColumn.DataType = System.Type.GetType("System.String")
	myDataColumn.ColumnName = "Summary"
	myDataTable.Columns.Add(myDataColumn)
	
	Dim SummaryTotal(12) As Integer
	Dim Summary As Integer = 0
	Dim DummyOptionID As Integer = 0
	Dim counter As Integer = 1
	For i = 0 To dtTable.Rows.Count - 1
		If dtTable.Rows(i)("OptionID") <> DummyOptionID Then
			If i = 0 Then
				myDataRow = myDataTable.NewRow()
			Else
				myDataRow("Summary") = Summary.ToString
				myDataTable.Rows.Add(myDataRow)
				myDataRow = myDataTable.NewRow()
			End If
			myDataRow("Option Name") = dtTable.Rows(i)("OptionName")
			Summary = 0
		End If
		myDataRow(dtTable.Rows(i)("Month")) = dtTable.Rows(i)("TotalNum").ToString
		DummyOptionID = dtTable.Rows(i)("OptionID")
		Summary += dtTable.Rows(i)("TotalNum")
		SummaryTotal(dtTable.Rows(i)("Month")) += dtTable.Rows(i)("TotalNum")
	Next
	myDataRow("Summary") = Summary.ToString
	myDataTable.Rows.Add(myDataRow)
	
	myDataRow = myDataTable.NewRow()
	myDataRow("Option Name") = "Grand Total"
	Dim GrandTotal As Integer
	For i = 1 To 12 
		myDataRow(i) = SummaryTotal(i)
		GrandTotal += SummaryTotal(i)
	Next
	myDataRow("Summary") = GrandTotal.ToString
	myDataTable.Rows.Add(myDataRow)
	showResults.Visible = True
	
	GCounter = myDataTable.Rows.Count
	Results.DataSource = myDataTable
	
	Results.DataBind()
	
End Sub

Public Function UDDDataBound(ByVal objCnn As MySqlConnection) As Boolean
	Dim DynamicUDD As New DataTable()
	DynamicUDD = getData.UDDSelection(Session("StaffID"),objCnn)
	ColList.DataSource = DynamicUDD
	ColList.DataValueField = "UDDID"
	ColList.DataTextField = "UDDName"
	ColList.DataBind()
	
End Function
		
Sub ChangeGridPage(objSender As Object, objArgs As DataGridPageChangedEventArgs)
	
   Results.CurrentPageIndex = objArgs.NewPageIndex

	
End Sub

Private Sub Item_Bound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) 
	GCounter -= 1
	Dim i As Integer
	If e.Item.ItemType = ListItemType.Header Then
		e.Item.Cells(0).Text = "Option Name"
		e.Item.Cells(1).Text = "Jan"
		e.Item.Cells(2).Text = "Feb"
		e.Item.Cells(3).Text = "Mar"
		e.Item.Cells(4).Text = "Apr"
		e.Item.Cells(5).Text = "May"
		e.Item.Cells(6).Text = "Jun"
		e.Item.Cells(7).Text = "Jul"
		e.Item.Cells(8).Text = "Aug"
		e.Item.Cells(9).Text = "Sep"
		e.Item.Cells(10).Text = "Oct"
		e.Item.Cells(11).Text = "Nov"
		e.Item.Cells(12).Text = "Dec"
		e.Item.Cells(13).Text = "Total"
	End If
	
	If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
		e.Item.Cells(13).BackColor = Color.FromArgb(235,235,235)
		If GCounter = -1 Then
			e.Item.Cells(0).HorizontalAlign = HorizontalAlign.Right
			For i = 0 To 13 
				e.Item.Cells(i).BackColor = Color.FromArgb(235,235,235)
				e.Item.Cells(i).CssClass = "boldText"
			Next
		End If
	End If

End Sub


Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
