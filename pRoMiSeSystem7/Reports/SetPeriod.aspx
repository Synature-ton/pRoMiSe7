<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@Import Namespace="System.Globalization" %>
<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Set Period</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<form id="mainForm" runat="server">
<input type="hidden" id="PeriodID" runat="server" />
<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText"><div class="headerText" align="left" id="Text_SectionParam" runat="server" /></b>
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
<table cellpadding="2" cellspacing="2" width="100%">
<tr id="showAdd" visible="True" runat="server">
<td><a href="../Members/member_group_edit.aspx"><div id="Text_AddParam" runat="server"></div></a></td>
</tr></table>

<table>
<div id="ValidateError" runat="Server"></div>
<tr>
	<td class="text">Period:</td>
    <td><asp:TextBox ID="PeriodName" MaxLength="20" runat="server" /></td>
	<td class="text">Start Period:</td>
	<td><synature:date id="StartDate" runat="server" /></td>
	<td width="20px"></td>
	<td class="text">End Period:</td>
	<td><synature:date id="EndDate" runat="server" /></td>
    </tr>
    <tr>
    <td class="text">Activate:</td>
    <td><asp:RadioButtonList ID="Activate" runat="server" RepeatDirection="Horizontal" CssClass="text">
            <asp:ListItem Value="1">Yes</asp:ListItem>
            <asp:ListItem Value="0" Selected="True">No.</asp:ListItem>
        </asp:RadioButtonList>
    </td>
    <td class="text">Release Billing:</td>
    <td><asp:RadioButtonList ID="ReleaseBilling" runat="server" RepeatDirection="Horizontal" CssClass="text">
            <asp:ListItem Value="1">Yes</asp:ListItem>
            <asp:ListItem Value="0" Selected="True">No.</asp:ListItem>
        </asp:RadioButtonList>
    </td>
	<td colspan="3" align="right"><asp:button ID="SubmitForm" OnClick="DoAddUpdate" Width="100px" runat="server" />&nbsp;<asp:button ID="CancelButton" Text=" Cancel " OnClick="DoCancel" Width="100px" runat="server" /></td>
</tr>
</table>
<p>&nbsp;</p>
<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="500">
	<tr>
		<td id="headerTD0" align="center" class="tdHeader" runat="server"><div id="IDParam" runat="server"></div></td>
        <td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="GroupName" runat="server"></div></td>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="StartParam" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="EndParam" runat="server"></div></td>
        <td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="ActivateText" runat="server"></div></td>
        <td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="Release" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Default_EditText" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Default_DelText" runat="server"></div></td>

	</tr>
	
	<div id="ResultText" runat="server"></div>

</table>
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
</table></form>
<script language="VB" runat="server">
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getStaff As New CMembers()
Dim getPageText As New DefaultText()
Dim getProp As New CPreferences()
Dim CostInfo As New CostClass()
Dim objDB As New CDBUtil()


Sub Page_Load()
	If User.Identity.IsAuthenticated  Then
		'AND Session("SetMaterialCostGroup")
		headerTD0.BgColor = GlobalParam.AdminBGColor
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		headerTD4.BgColor = GlobalParam.AdminBGColor
		headerTD5.BgColor = GlobalParam.AdminBGColor	
		headerTD6.BgColor = GlobalParam.AdminBGColor
		headerTD7.BgColor = GlobalParam.AdminBGColor	
		headerTD0.Visible = False
		headerTD4.Visible = False
			
		Try
			objCnn = getCnn.EstablishConnection()
			Dim getInfo As DataTable
        	Dim dtTable As New DataTable()
        	dtTable = objDB.List("select *,DATE_FORMAT(StartDate,'%e-%b-%y') As StartDateString,DATE_FORMAT(EndDate,'%e-%b-%y') As EndDateString from MyK_Period order by StartDate", objCnn)
			Dim i As integer
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(11,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
			Text_SectionParam.InnerHtml = "Manage Period"
			Text_AddParam.InnerHtml = ""
			StartParam.InnerHtml = "Start Period"
			EndParam.InnerHtml = "End Period"
			IDParam.InnerHtml = "ID"
			Default_EditText.InnerHtml = "Edit" 'defaultTextTable.Rows(0)("TextParamValue")
			Default_DelText.InnerHtml = "Delete" 'defaultTextTable.Rows(1)("TextParamValue")
			SubmitForm.Text = " Add "
			ActivateText.InnerHtml = "Activate"
			Release.InnerHtml = "Release Billing"
			CancelButton.Visible = False
			headerTD0.Visible = False
			GroupName.InnerHtml = "Period"
			Dim InvC As CultureInfo = CultureInfo.InvariantCulture
			Dim ChkYear As DataTable = objDB.List("SELECT MIN(YEAR(StartDate)) AS StartYear FROM MaterialCostGroup", objCnn)
			Dim stYear As Integer = 2
			Dim todayYear As Integer = CInt(DateTime.Now.ToString("yyyy", InvC))
			If ChkYear.Rows.Count > 0 Then
				If Not IsDBNull(ChkYear.Rows(0)("StartYear")) Then
				  If todayYear - ChkYear.Rows(0)("StartYear") > 2 Then
					  stYear = todayYear - ChkYear.Rows(0)("StartYear")
				  End If
				End If
			End If
			
			StartDate.LangID = Session("LangID")
			StartDate.FormName = "StartDate"
			StartDate.ShowDay = True
			StartDate.StartYear = stYear
			StartDate.EndYear = 1
			StartDate.Culture = "en-US"
			
			EndDate.LangID = Session("LangID")
			EndDate.FormName = "EndDate"
			EndDate.ShowDay = True
			EndDate.StartYear = stYear
			EndDate.EndYear = 1
			EndDate.Culture = "en-US"
			
			If Not Page.IsPostBack Then
				PeriodID.Value = -1
				If IsNumeric(Request.QueryString("PeriodID")) AND Request.QueryString("Action") = "Edit" Then
					PeriodID.Value = Request.QueryString("PeriodID")
					getInfo = objDB.List("select *,DAYOFMONTH(StartDate) As StartDate_Day,MONTH(StartDate) As StartDate_Month, YEAR(StartDate) As StartDate_Year,DAYOFMONTH(EndDate) As EndDate_Day,MONTH(EndDate) As EndDate_Month, YEAR(EndDate) As EndDate_Year from MyK_Period where PeriodID=" & PeriodID.Value & " order by StartDate", objCnn)	
					For i = 0 To getInfo.Rows.Count - 1
						If IsNumeric(getInfo.Rows(i)("StartDate_Day")) Then StartDate.SelectedDay = getInfo.Rows(i)("StartDate_Day")
						If IsNumeric(getInfo.Rows(i)("StartDate_Month")) Then StartDate.SelectedMonth = getInfo.Rows(i)("StartDate_Month")
						If IsNumeric(getInfo.Rows(i)("StartDate_Year")) Then StartDate.SelectedYear = getInfo.Rows(i)("StartDate_Year")
						
						If IsNumeric(getInfo.Rows(i)("EndDate_Day")) Then EndDate.SelectedDay = getInfo.Rows(i)("EndDate_Day")
						If IsNumeric(getInfo.Rows(i)("EndDate_Month")) Then EndDate.SelectedMonth = getInfo.Rows(i)("EndDate_Month")
						If IsNumeric(getInfo.Rows(i)("EndDate_Year")) Then EndDate.SelectedYear = getInfo.Rows(i)("EndDate_Year")
						
						If Not IsDBNull(getInfo.Rows(i)("PeriodName")) Then
							PeriodName.Text = getInfo.Rows(i)("PeriodName")
						Else
							PeriodName.Text = ""
						End If
						Activate.SelectedValue = getInfo.Rows(i)("Activate")
						ReleaseBilling.SelectedValue = getInfo.Rows(i)("ReleaseBilling")
					Next
					SubmitForm.Text = " Update "
					CancelButton.Visible = True
				
				End If
			Else
				If IsNumeric(Request.Form("StartDate_Day")) Then StartDate.SelectedDay = Request.Form("StartDate_Day")
				If IsNumeric(Request.Form("StartDate_Month")) Then StartDate.SelectedMonth = Request.Form("StartDate_Month")
				If IsNumeric(Request.Form("StartDate_Year")) Then StartDate.SelectedYear = Request.Form("StartDate_Year")
				If IsNumeric(Request.Form("EndDate_Day")) Then EndDate.SelectedDay = Request.Form("EndDate_Day")
				If IsNumeric(Request.Form("EndDate_Month")) Then EndDate.SelectedMonth = Request.Form("EndDate_Month")
				If IsNumeric(Request.Form("EndDate_Year")) Then EndDate.SelectedYear = Request.Form("EndDate_Year")
			End If
			
			
			Dim outputString As String = ""
			Dim string1 As String
        	For i = 0 to dtTable.Rows.Count - 1

				outputString += "<tr><td align=""left"" class=""text"">" & dtTable.Rows(i)("PeriodName").ToString & "</td>"
				outputString += "<td align=""center"" class=""text"">" & dtTable.Rows(i)("StartDateString") & "</td>"
				outputString += "<td align=""center"" class=""text"">" & dtTable.Rows(i)("EndDateString") & "</td>"
				If dtTable.Rows(i)("Activate") = 1 Then
					outputString += "<td align=""center"" class=""text"">" & "<img border=0 src=""../images/checkbl.gif"">" & "</td>"
				Else
					outputString += "<td align=""center"" class=""text"">" & "<img border=0 src=""../images/crossbl.gif"">" & "</td>"
				End If
				If dtTable.Rows(i)("ReleaseBilling") = 1 Then
					outputString += "<td align=""center"" class=""text"">" & "<img border=0 src=""../images/checkbl.gif"">" & "</td>"
				Else
					outputString += "<td align=""center"" class=""text"">" & "<img border=0 src=""../images/crossbl.gif"">" & "</td>"
				End If
				outputString += "<td align=""center"" class=""text""><a href=""SetPeriod.aspx?Action=Edit&PeriodID=" & dtTable.Rows(i)("PeriodID").ToString & """>" & "Edit" & "</a></td>"
				'outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'manage_costgrouplink.aspx?TypeID=1&GroupID=" + dtTable.Rows(i)("MaterialCostGroupID").ToString + "', '', 'width=700,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Set Inventory" + "</a></td>"

				outputString += "</tr>"

			Next
			ResultText.InnerHtml = outputString
			
		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	Else
		updateMessage.Text = "Access Denied"
	End If
End Sub

Sub DoAddUpdate(Source As Object, E As EventArgs)
	Dim AddUpdate As New CCategory()
	Dim FoundError AS Boolean = False
	Dim sqlStatement As String
	validateError.InnerHtml = ""

	If Not IsNumeric(Request.Form("StartDate_Day")) OR Not IsNumeric(Request.Form("StartDate_Month")) OR Not IsNumeric(Request.Form("StartDate_Year")) Or Not IsNumeric(Request.Form("EndDate_Day")) Or Not IsNumeric(Request.Form("EndDate_Month")) OR Not IsNumeric(Request.Form("EndDate_Year")) Then
		validateError.InnerHtml =  "<tr><td></td><td class=""errorText"" colspan=""5"">" & "Please select start date and end date" & "</td></tr>"
		FoundError = True
	End If	
	If Trim(PeriodName.Text) = "" Then
		validateError.InnerHtml =  "<tr><td></td><td class=""errorText"" colspan=""5"">" & "Please input period name." & "</td></tr>"
		FoundError = True
	End If
	If FoundError = False Then
		Dim Result As String

		Dim StartString As String = "{ d '" + Request.Form("StartDate_Year").ToString + "-" + Request.Form("StartDate_Month").ToString + "-" + Request.Form("StartDate_Day").ToString + "'}"
		Dim EndString As String =  "{ d '" + Request.Form("EndDate_Year").ToString + "-" + Request.Form("EndDate_Month").ToString + "-" + Request.Form("EndDate_Day").ToString + "'}"
		Dim PeriodIDVal As Integer = PeriodID.Value
		If PeriodID.Value > 0 Then
			sqlStatement = "update MyK_Period set PeriodName='" & Replace(Trim(PeriodName.Text),"'","''") & "'" & ",StartDate=" & StartString & ",EndDate=" & EndString & ",Activate=" & Activate.SelectedItem.Value.ToString & ",ReleaseBilling=" & ReleaseBilling.SelectedItem.Value.ToString & " where PeriodID=" & PeriodIDVal
			objDB.sqlExecute(sqlStatement, objCnn)
			Result = "Success"
		Else
			Dim Max As DataTable = objDB.List("select MAX(PeriodID) As MaxID from MyK_Period", objCnn)
			If Not IsDBNull(Max.Rows(0)("MaxID")) Then
				PeriodIDVal = Max.Rows(0)("MaxID")+1
			Else
				PeriodIDVal = 1
			End If
			sqlStatement = "insert into MyK_Period (PeriodID,PeriodName,StartDate,EndDate,Activate,ReleaseBilling) values (" & PeriodIDVal & ",'" & Replace(Trim(PeriodName.Text),"'","''") & "'," & StartString & "," & EndString & "," & Activate.SelectedItem.Value.ToString & "," & ReleaseBilling.SelectedItem.Value.ToString & ")"
			objDB.sqlExecute(sqlStatement, objCnn)
			Result = "Success"
		End If

		If Result = "Success" Then
			Response.Redirect("SetPeriod.aspx")
		Else
			errorMsg.InnerHtml = Result
		End If
	End If
End Sub

Sub DoCancel(Source As Object, E As EventArgs)

	Response.Redirect("SetPeriod.aspx")

End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub
</script>

</body>
</html>
