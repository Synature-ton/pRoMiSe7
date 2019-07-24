<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<html>
<head>
<title>Manage User Role</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<ASP:Label id="updateMessage" CssClass="headerText" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText"><div class="headerText" align="left" id="SectionText" runat="server" /></b>
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
<table cellpadding="0" cellspacing="0" width="100%">
<tr>
<td align="left" width="50%"><div id="totalRecord" class="text" runat="server"></div></td>
<td align="right" width="50%"><div id="showAddText" visible=false runat="server"><span id="AddTextParam" runat="server"></span></div></td>
</tr>
</table>
<form id="mainForm" runat="server"> 
<input type="hidden" id="SelShopName" runat="server" />
<input type="hidden" id="ShopIDList" runat="server" />
<input type="hidden" id="QueryStringVal" runat="server" />
<table width="100%">
<tr>
	<td colspan="2">
	<table>
	<tr>
		<td align="left"><span id="ShopText" runat="server"></span></td>
		<td align="left"><div id="StaffRoleText" runat="server"></div></td>
		<td><div class="text" id="StaffFirstNameParam" runat="server"></div></td>
		<td><asp:textbox ID="StaffFirstName" MaxLength="50" Width="100" runat="server" /></td>
		<td><div class="text" id="StaffLastNameParam" runat="server"></div></td>
		<td><asp:textbox ID="StaffLastName" MaxLength="50" Width="100" runat="server" /></td>
		
	</tr>
	<tr>
		<td class="text">Order By:<asp:dropdownlist ID="OrderByParam" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
		<td colspan="5"><asp:button ID="SubmitForm" OnClick="DoSearch" runat="server" /></td>
	</tr>
	</table></td>
</tr>
<tr><td colspan="2">
<table id="myTable" border="1" cellpadding="4" cellspacing="0" width="100%" style="border-collapse:collapse;">
	<tr>
		<td id="headerTD0" align="center" class="tdHeader" runat="server"><div id="StatusText" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" visible="false" runat="server"><div id="ActivationText" runat="server"></div></td>
		<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="CodeText" runat="server"></div></td>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="NameText" runat="server"></div></td>
 		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="RoleText" runat="server"></div></td>
       <td id="headerTD8" align="center" class="tdHeader" runat="server"><div id="ShopAccessText" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="Default_ViewText" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" visible="false" runat="server"><div id="Default_EditText" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" visible="false" runat="server"><div id="Default_DelText" runat="server"></div></td>
	</tr>
	<div id="ResultText" runat="server"></div>

</table></td></tr>
</table>
<div id="testMsg" runat="server"></div>

<div id="errorMsg" style="color:red;" runat="server" />
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
</form>
<script language="VB" runat="server">
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getStaff As New CStaffs()
Dim getStaffRole As New CStaffRole()
Dim getPageText As New DefaultText()
Dim getProp As New CPreferences()
Dim getInfo As New CCategory()
Dim DateTimeUtil As New MyDateTime()
Dim Multiple As Boolean = False
Dim objDB As New CDBUtil()

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("User_ManageUsers") Then
	
            Try
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
                objCnn = getCnn.EstablishConnection()
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                Dim bolCanAddNewStaff As Boolean

                Dim textTable As New DataTable()
                textTable = getPageText.GetText(4, Session("LangID"), objCnn)
                Dim textTable1 As New DataTable()
                textTable1 = getPageText.GetText(5, Session("LangID"), objCnn)
			
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
                If Session("User_ManageUsers_Add") Then showAddText.Visible = True
                If PropertyInfo.Rows(0)("HeadOrBranch") = 0 Then
                    bolCanAddNewStaff = True
                    If Session("User_ManageUsers_Edit") Then headerTD3.Visible = True
                    If Session("User_ManageUsers_Del") Then headerTD4.Visible = True
                    If Session("User_ManageUsers_Activation") Then headerTD5.Visible = True
                Else
                    bolCanAddNewStaff = False
                    
                    'Check Property Can Add At Branch
                    Dim dtProperty As DataTable
                    dtProperty = getProp.PropertyValue(2, POSTypeClass.POSAdditionalProgramVariable.BACKOFFICE_CANADDNEWSTAFF_ATBRANCHDB, 1, objCnn)
                    If dtProperty.Rows.Count > 0 Then
                        If dtProperty.Rows(0)("PropertyValue") = 1 Then
                            bolCanAddNewStaff = True
                        End If
                    End If
                End If
			    
                headerTD0.BgColor = GlobalParam.AdminBGColor
                headerTD1.BgColor = GlobalParam.AdminBGColor
                headerTD2.BgColor = GlobalParam.AdminBGColor
                headerTD3.BgColor = GlobalParam.AdminBGColor
                headerTD4.BgColor = GlobalParam.AdminBGColor
                headerTD5.BgColor = GlobalParam.AdminBGColor
                headerTD6.BgColor = GlobalParam.AdminBGColor
                headerTD7.BgColor = GlobalParam.AdminBGColor
                headerTD8.BgColor = GlobalParam.AdminBGColor
			
                SubmitForm.Text = "Search"
			
                SectionText.InnerHtml = textTable.Rows(0)("TextParamValue")
                NameText.InnerHtml = textTable.Rows(2)("TextParamValue")
                RoleText.InnerHtml = textTable.Rows(3)("TextParamValue")
                StatusText.InnerHtml = textTable.Rows(7)("TextParamValue")
                ActivationText.InnerHtml = textTable.Rows(8)("TextParamValue")
                Default_EditText.InnerHtml = defaultTextTable.Rows(0)("TextParamValue")
                Default_DelText.InnerHtml = defaultTextTable.Rows(1)("TextParamValue")
                Default_ViewText.InnerHtml = defaultTextTable.Rows(5)("TextParamValue")
                CodeText.InnerHtml = "Staff Code"
                ShopAccessText.InnerHtml = "Staff Shop"
			
                StaffFirstNameParam.InnerHtml = textTable1.Rows(4)("TextParamValue")
                StaffLastNameParam.InnerHtml = textTable1.Rows(5)("TextParamValue")
			
                OrderByParam.Items(0).Text = "Staff Name"
                OrderByParam.Items(0).Value = "StaffFirstName,StaffLastName"
                OrderByParam.Items(1).Text = "Staff Code"
                OrderByParam.Items(1).Value = "StaffCode"
                OrderByParam.Items(2).Text = "Staff Role"
                OrderByParam.Items(2).Value = "StaffRoleName,StaffFirstName,StaffLastName"
			
                Dim QueryStringList As String
			
                Dim i As Integer
                Dim outputString As String = ""
                Dim FormSelected As String
						
                Dim StaffRoleIDValue As Integer = 0
                If IsNumeric(Request.Form("StaffRoleID")) Then
                    StaffRoleIDValue = Request.Form("StaffRoleID")
                ElseIf IsNumeric(Request.QueryString("StaffRoleID")) Then
                    StaffRoleIDValue = Request.QueryString("StaffRoleID")
                End If
			
                Dim ShopIDValue As String = "0"
                If IsNumeric(Request.Form("ShopID")) Then
                    ShopIDValue = Request.Form("ShopID").ToString
                ElseIf IsNumeric(Request.QueryString("ShopID")) Then
                    ShopIDValue = Request.QueryString("ShopID").ToString
                End If

                Dim ShopList As String = ""

                Dim ShopData As DataTable = getInfo.GetProductLevel(-999, objCnn)
                If ShopData.Rows.Count > 0 Then
                    outputString = "<select name=""ShopID""><option value=""0"">" & "All Shops"
	
                    For i = 0 To ShopData.Rows.Count - 1
                        If ShopIDValue = ShopData.Rows(i)("ProductLevelID") Then
                            FormSelected = "selected"
                            SelShopName.Value = ShopData.Rows(i)("ProductLevelName")
                        Else
                            FormSelected = ""
                        End If
                        outputString += "<option value=""" & ShopData.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & ShopData.Rows(i)("ProductLevelName")
                        ShopList += "," + ShopData.Rows(i)("ProductLevelID").ToString
                    Next
                    outputString += "</select>"
                    ShopText.InnerHtml = outputString
	
                    ShopList = "0" + ShopList
                    ShopIDList.Value = ShopList
                Else
                    ShopIDList.Value = "0"
	
                End If
			
                QueryStringList = "&StaffRoleID=" + StaffRoleIDValue.ToString + "&ShopID=" + ShopIDValue.ToString + "&StaffFirstName=" + StaffFirstName.Text + "&StaffLastName=" + StaffLastName.Text + "&OrderByParam=" + Request.Form("OrderByParam") + "&submit=yes"
                QueryStringVal.Value = QueryStringList

                Dim staffRoleTable As New DataTable()
                staffRoleTable = getStaffRole.GetAccessStaffRole(Session("StaffRole"), objCnn)
			
                Dim SelectString As String = textTable.Rows(6)("TextParamValue")
                outputString = "<select name=""StaffRoleID""><option value=""0"">" & SelectString
                For i = 0 To staffRoleTable.Rows.Count - 1
                    If StaffRoleIDValue = staffRoleTable.Rows(i)("StaffRoleID") Then
                        FormSelected = "selected"
                    Else
                        FormSelected = ""
                    End If
                    outputString += "<option value=""" & staffRoleTable.Rows(i)("StaffRoleID") & """ " & FormSelected & ">" & staffRoleTable.Rows(i)("StaffRoleName")
                Next
                StaffRoleText.InnerHtml = outputString
			
                If Not Page.IsPostBack Then
                    If Request.QueryString("submit") = "yes" Then
                        StaffFirstName.Text = Request.QueryString("StaffFirstName")
                        StaffLastName.Text = Request.QueryString("StaffLastName")
                        If Request.QueryString("OrderByParam") = "StaffFirstName,StaffLastName" Then
                            OrderByParam.Items(0).Selected = True
                        ElseIf Request.QueryString("OrderByParam") = "StaffCode" Then
                            OrderByParam.Items(1).Selected = True
                        Else
                            OrderByParam.Items(2).Selected = True
                        End If
                        QueryStringList = "&StaffRoleID=" + StaffRoleIDValue.ToString + "&ShopID=" + ShopIDValue.ToString + "&StaffFirstName=" + StaffFirstName.Text + "&StaffLastName=" + StaffLastName.Text + "&OrderByParam=" + Request.QueryString("OrderByParam") + "&submit=yes"
                        QueryStringVal.Value = QueryStringList
                        SearchStaff(Session("StaffRole"), StaffRoleIDValue, ShopIDValue, StaffFirstName.Text, StaffLastName.Text, Request.QueryString("OrderByParam"), objCnn)
                    End If
                End If
              
                If bolCanAddNewStaff = True Then
                    AddTextParam.InnerHtml = "<a href=""user_manage_edit.aspx?Add=" & "yes" & QueryStringVal.Value & """>" & textTable.Rows(1)("TextParamValue") & "</a>"
                Else
                    AddTextParam.InnerHtml = ""
                End If
                                
            Catch ex As Exception
                errorMsg.InnerHtml = ex.Message
            End Try
        Else
            updateMessage.Text = "Access Denied"
        End If
    End Sub

Sub DoSearch(Source As Object, E As EventArgs)
	SearchStaff(Session("StaffRole"),Request.Form("StaffRoleID"),Request.Form("ShopID"),StaffFirstName.Text,StaffLastName.Text,Request.Form("OrderByParam"),objCnn)
	
End Sub

Public Function SearchStaff(ByVal RoleProp As Integer, ByVal StaffRoleID As Integer, ByVal ShopID As String, ByVal StaffFirstName As String, ByVal StaffLastName As String,ByVal OrderBy As String, ByVal objCnn As MySqlConnection) As String
	Dim TimeNow As String 
	
	Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
			
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(4,Session("LangID"),objCnn)
	Dim textTable1 As New DataTable()
	textTable1 = getPageText.GetText(5,Session("LangID"),objCnn)
	
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	TimeNow += "<br>" + DateTimeUtil.CurrentDateTime
	Dim dtTable As New DataTable()
	dtTable = getStaff.GetStaffs(RoleProp,StaffRoleID,ShopID,StaffFirstName,StaffLastName,OrderBy,objCnn)
	TimeNow += "<br>" + DateTimeUtil.CurrentDateTime
		
	If dtTable.Rows.Count > 0 Then
		If dtTable.Rows.Count > 1 Then
			totalRecord.InnerHtml = dtTable.Rows.Count.ToString + " records found"
		Else
			totalRecord.InnerHtml = dtTable.Rows.Count.ToString + " record found"
		End If
	End If
	
	Dim outputString As StringBuilder = New StringBuilder
	Dim i,ChangeActivateValue As Integer
	Dim StatusImage,ActivationMsg,ConfigProductLink,StaffFullName As String
	For i = 0 to dtTable.Rows.Count - 1
		StaffFullName = dtTable.Rows(i)("StaffFirstName") & " " & dtTable.Rows(i)("StaffLastName")
		If dtTable.Rows(i)("Activated") = True Or dtTable.Rows(i)("Activated") = 1 Then
			StatusImage = "../images/checkbl.gif"
			ActivationMsg = textTable.Rows(10)("TextParamValue")
			ChangeActivateValue = 0
		Else
			StatusImage = "../images/crossbl.gif"
			ActivationMsg = textTable.Rows(9)("TextParamValue")
			ChangeActivateValue = 1
		End If
		outputString = outputString.Append("<tr><td align=""center""><img border=0 src=""" & StatusImage & """></td>")
		If headerTD5.Visible = True Then
			If dtTable.Rows(i)("StaffID") = 1 Or dtTable.Rows(i)("StaffID") = 2 Then
				outputString = outputString.Append("<td align=""center"" class=""disabledText"">" & "-" & "</td>")
			Else
				outputString = outputString.Append("<td align=""left"" class=""text""><a href=""user_manage_action.aspx?StaffID=" & dtTable.Rows(i)("StaffID") & "&ChangeActivateValue=" & ChangeActivateValue.ToString & "&action=activate_user" & QueryStringVal.Value & """>" & ActivationMsg & "</a></td>")
			End If
		End If
		
		If (PropertyInfo.Rows(0)("ServiceProduct") = 1 Or PropertyInfo.Rows(0)("ServiceProduct") = True) Then
			ConfigProductLink = "<br>" + "<a href=""JavaScript: newWindow = window.open( '../Promotions/select_products.aspx?LinkID=" + dtTable.Rows(i)("StaffID").ToString + "&TypeID=99&EditID=1', '', 'width=640,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + textTable.Rows(19)("TextParamValue") + "</a>" 
		Else
			ConfigProductLink = ""
		End If
		
		outputString = outputString.Append("<td align=""left"" class=""text"">" & dtTable.Rows(i)("StaffCode") & "</td>")
		
		outputString = outputString.Append("<td align=""left"" class=""text"">" & StaffFullName & ConfigProductLink & "</td><td align=""left"" class=""text"">" & dtTable.Rows(i)("StaffRoleName") & "</td>")
		
		If headerTD8.Visible = True Then
			outputString = outputString.Append("<td class=""text"" align=""center""><a href=""JavaScript: newWindow = window.open( 'manage_staff_shop.aspx?StaffID=" + dtTable.Rows(i)("StaffID").ToString + "', '', 'width=700,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Staff Shop" + "</a></td>")
		End If
		
		If (dtTable.Rows(i)("StaffID") = 1 AND Session("StaffID") = 1) Or (dtTable.Rows(i)("StaffID") = 2 AND (Session("StaffID") = 1 Or Session("StaffID") = 2)) Or (dtTable.Rows(i)("StaffID") > 2) Then
			outputString = outputString.Append("<td align=""left"" class=""text""><a href=""user_manage_details.aspx?StaffID=" & dtTable.Rows(i)("StaffID") & QueryStringVal.Value & """>" & defaultTextTable.Rows(5)("TextParamValue") & "</a></td>")
		Else
			outputString = outputString.Append("<td align=""center"" class=""disabledText"">" & "-" & "</td>")
		End If
		
		If headerTD3.Visible = True Then
			If (dtTable.Rows(i)("StaffID") = 1 AND Session("StaffID") = 1) Or (dtTable.Rows(i)("StaffID") = 2 AND (Session("StaffID") = 1 Or Session("StaffID") = 2)) Or (dtTable.Rows(i)("StaffID") > 2) Then
				outputString = outputString.Append("<td align=""center"" class=""text""><a href=""user_manage_edit.aspx?StaffID=" & dtTable.Rows(i)("StaffID") & QueryStringVal.Value & """>" & defaultTextTable.Rows(0)("TextParamValue") & "</a></td>")
			Else
				outputString = outputString.Append("<td align=""center"" class=""disabledText"">" & "-" & "</td>")
			End If
		End If
		If headerTD4.Visible = True Then
			If dtTable.Rows(i)("StaffID") = 1 Or dtTable.Rows(i)("StaffID") = 2 Then
				outputString = outputString.Append("<td align=""center"" class=""disabledText"">" & "-" & "</td>")
			Else
				outputString = outputString.Append("<td align=""center"" class=""text""><a href=""user_manage_action.aspx?StaffID=" & dtTable.Rows(i)("StaffID") & "&action=delete_user" &  QueryStringVal.Value & """ onClick=""javascript: return confirm('" & textTable.Rows(4)("TextParamValue") & " " & Replace(StaffFullName,"'","\'") & " " & textTable.Rows(5)("TextParamValue") & "')"">" & defaultTextTable.Rows(1)("TextParamValue") & "</a></td>")
			End If
		End If
		outputString = outputString.Append("</tr>")
	Next
	TimeNow += "<br>" + DateTimeUtil.CurrentDateTime
	ResultText.InnerHtml = outputString.ToString

End Function

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
