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
<title>Manage Product Cost Group</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<form id="mainForm" runat="server">
<input type="hidden" id="ProductCostGroupID" runat="server" />
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
<td></td>
</tr></table>

<table>
<div id="ValidateError" runat="Server"></div>
<tr>
	<td class="text">Name:</td>
    <td><asp:TextBox ID="CostGroupName" MaxLength="50" runat="server" /></td>
	<td class="text">Start Date:</td>
	<td><synature:date id="StartDate" runat="server" /></td>
	<td width="20px"></td>
	<td class="text">End Date:</td>
	<td><synature:date id="EndDate" runat="server" /></td>
	<td><asp:button ID="SubmitForm" OnClick="DoAddUpdate" runat="server" />&nbsp;<asp:button ID="CancelButton" Text=" Cancel " OnClick="DoCancel" runat="server" /></td>
</tr>
</table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="500">
	<tr>
		<td id="headerTD0" align="center" class="tdHeader" runat="server"><div id="IDParam" runat="server"></div></td>
        <td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="GroupName" runat="server"></div></td>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="StartParam" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="EndParam" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Default_EditText" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Default_DelText" runat="server"></div></td>
        <td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="ShopLink" runat="server"></div></td>
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
        If User.Identity.IsAuthenticated Then
            'AND Session("SetMaterialCostGroup")
            headerTD0.BgColor = GlobalParam.AdminBGColor
            headerTD1.BgColor = GlobalParam.AdminBGColor
            headerTD2.BgColor = GlobalParam.AdminBGColor
            headerTD3.BgColor = GlobalParam.AdminBGColor
            headerTD4.BgColor = GlobalParam.AdminBGColor
            headerTD5.BgColor = GlobalParam.AdminBGColor
            headerTD6.BgColor = GlobalParam.AdminBGColor
            headerTD4.Visible = False
			
            Try
                objCnn = getCnn.EstablishConnection()
                Dim getInfo As DataTable
                Dim dtTable As New DataTable()
                dtTable = CostInfo.ProductCostGroup(-1, objCnn)
                Dim i As Integer
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(11, Session("LangID"), objCnn)
			
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
                Text_SectionParam.InnerHtml = "Manage Product Cost Group"
                StartParam.InnerHtml = "Date From"
                EndParam.InnerHtml = "Date To"
                IDParam.InnerHtml = "ID"
                Default_EditText.InnerHtml = defaultTextTable.Rows(0)("TextParamValue")
                Default_DelText.InnerHtml = defaultTextTable.Rows(1)("TextParamValue")
                SubmitForm.Text = " Add "
                CancelButton.Visible = False
                ShopLink.InnerHtml = "Set Shop"
                GroupName.InnerHtml = "Name"
                Dim CultureString As String = Util.GetCultureByLangID(Session("LangID"), objCnn)
                Dim InvC As CultureInfo = CultureInfo.InvariantCulture
                Dim ChkYear As DataTable = objDB.List("SELECT MIN(YEAR(StartDate)) AS StartYear FROM ProductCostGroup", objCnn)
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
                StartDate.ShowDay = False
                StartDate.StartYear = stYear
                StartDate.EndYear = 2
                
                StartDate.YearType = GlobalParam.YearType
                'StartDate.Lang_Data = LangDefault
                StartDate.Culture = CultureString

          	
                EndDate.LangID = Session("LangID")
                EndDate.FormName = "EndDate"
                EndDate.ShowDay = False
                EndDate.StartYear = stYear
                EndDate.EndYear = 2
			
                EndDate.YearType = GlobalParam.YearType
                'EndDate.Lang_Data = LangDefault
                EndDate.Culture = CultureString
                                 
                If Not Page.IsPostBack Then
                    ProductCostGroupID.Value = -1
                    If IsNumeric(Request.QueryString("ProductCostGroupID")) And Request.QueryString("Action") = "Edit" Then
                        ProductCostGroupID.Value = Request.QueryString("ProductCostGroupID")
                        getInfo = CostInfo.ProductCostGroup(ProductCostGroupID.Value, objCnn)
                        For i = 0 To getInfo.Rows.Count - 1
                            If IsNumeric(getInfo.Rows(i)("StartMonth")) Then StartDate.SelectedMonth = getInfo.Rows(i)("StartMonth")
                            If IsNumeric(getInfo.Rows(i)("StartYear")) Then StartDate.SelectedYear = getInfo.Rows(i)("StartYear")
                            If IsNumeric(getInfo.Rows(i)("EndMonth")) Then EndDate.SelectedMonth = getInfo.Rows(i)("EndMonth")
                            If IsNumeric(getInfo.Rows(i)("EndYear")) Then EndDate.SelectedYear = getInfo.Rows(i)("EndYear")
                            If Not IsDBNull(getInfo.Rows(i)("CostGroupName")) Then
                                CostGroupName.Text = getInfo.Rows(i)("CostGroupName")
                            Else
                                CostGroupName.Text = ""
                            End If
                        Next
                        SubmitForm.Text = " Update "
                        CancelButton.Visible = True
                    ElseIf IsNumeric(Request.QueryString("ProductCostGroupID")) And Request.QueryString("Action") = "Delete" Then
                        Response.Redirect("Product_Cost_Group.aspx")
                    End If
                Else
                    If IsNumeric(Request.Form("StartDate_Month")) Then StartDate.SelectedMonth = Request.Form("StartDate_Month")
                    If IsNumeric(Request.Form("StartDate_Year")) Then StartDate.SelectedYear = Request.Form("StartDate_Year")
                    If IsNumeric(Request.Form("EndDate_Month")) Then EndDate.SelectedMonth = Request.Form("EndDate_Month")
                    If IsNumeric(Request.Form("EndDate_Year")) Then EndDate.SelectedYear = Request.Form("EndDate_Year")
                End If
		
                Dim outputString As String = ""
                For i = 0 To dtTable.Rows.Count - 1
                    outputString += "<tr><td align=""center"" class=""text"">" & dtTable.Rows(i)("ProductCostGroupID").ToString & "</td>"
                    outputString += "<td align=""center"" class=""text"">" & dtTable.Rows(i)("CostGroupName").ToString & "</td>"
                    outputString += "<td align=""center"" class=""text"">" & dtTable.Rows(i)("StartMonth").ToString + "/" + dtTable.Rows(i)("StartYear").ToString & "</td>"
                    outputString += "<td align=""center"" class=""text"">" & dtTable.Rows(i)("EndMonth").ToString + "/" + dtTable.Rows(i)("EndYear").ToString & "</td>"
                    outputString += "<td align=""center"" class=""text""><a href=""Product_Cost_Group.aspx?Action=Edit&ProductCostGroupID=" & dtTable.Rows(i)("ProductCostGroupID").ToString & """>" & defaultTextTable.Rows(0)("TextParamValue") & "</a></td>"
                    outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'manage_costgrouplink.aspx?TypeID=2&GroupID=" + dtTable.Rows(i)("ProductCostGroupID").ToString + "', '', 'width=700,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Set Shop" + "</a></td>"
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
        Dim FoundError As Boolean = False

        ValidateError.InnerHtml = ""

        If Not IsNumeric(Request.Form("StartDate_Month")) Or Not IsNumeric(Request.Form("StartDate_Year")) Or Not IsNumeric(Request.Form("EndDate_Month")) Or Not IsNumeric(Request.Form("EndDate_Year")) Then
            ValidateError.InnerHtml = "<tr><td></td><td class=""errorText"" colspan=""5"">" & "Please select start date and end date" & "</td></tr>"
            FoundError = True
        End If
        If FoundError = False Then
            Dim Result As String

            Dim StartString As String = "{ d '" + Request.Form("StartDate_Year").ToString + "-" + Request.Form("StartDate_Month").ToString + "-1'}"
            Dim EndString As String = "{ d '" + Request.Form("EndDate_Year").ToString + "-" + (Request.Form("EndDate_Month") + 1).ToString + "-1'}"
            If Request.Form("EndDate_Month") = 12 Then
                EndString = "{ d '" + (Request.Form("EndDate_Year") + 1).ToString + "-1-1'}"
            End If
		
            Application.Lock()
            Result = CostInfo.AddUpdateProductCostGroup(CostGroupName.Text, ProductCostGroupID.Value, StartString, EndString, Session("StaffID"), objCnn)
            Application.UnLock()
            If Result = "Success" Then
                Response.Redirect("Product_Cost_Group.aspx")
            Else
                errorMsg.InnerHtml = Result
            End If
        End If
    End Sub

    Sub DoCancel(Source As Object, E As EventArgs)
        Response.Redirect("Product_Cost_Group.aspx")
    End Sub

    </script>

</body>
</html>
