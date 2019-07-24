<%@ Page Language="VB" EnableViewState="false" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<%@ Register tagprefix="synature" Tagname="province" Src="../UserControls/Province.ascx" %>
<%@ Register tagprefix="synature" Tagname="userGroup" Src="../UserControls/UserGroup.ascx" %>
<%@ Register tagprefix="synature" Tagname="getLang" Src="../UserControls/GetLang.ascx" %>
<%@ Register tagprefix="synature" Tagname="MemberMenu" Src="../UserControls/MemberMenu.ascx" %>
<html>
<head>
<title>Manage Members</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body<% = GlobalParam.BodyProp %>>
<form enctype="multipart/form-data" runat="server">
<input type="hidden" id="MemberID" runat="server" />
<input type="hidden" id="MemberOrStaff" runat="server" />
<input type="hidden" id="OldMemberCode" runat="server" />
<input type="hidden" id="MemberStaffID" runat="server" />
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


<synature:MemberMenu id="MMenu" runat="server" />
<asp:Panel ID="showContent" runat="server" Visible="false">
<table width="100%">
<tr><td width="100%" align="left"><asp:button ID="SubmitForm" OnClick="DoAddUpdate" runat="server" /></td></tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="1" style="border-collapse:collapse;">
<div id="userNameForm" runat="server" />

<tr>
	<td><div class="requireText" id="MemberCodeParam" runat="server"></div></td>
	<td><div id="validateCode" class="errorText" runat="server" /><asp:textbox ID="MemberCode" MaxLength="50" Width="150" runat="server" /></td>
	
	<td><div class="text" id="MemberPasswordText" runat="server"></div></td>
	<td><div id="validatePassword" class="errorText" runat="server" /><asp:TextBox TextMode="Password" id="MemberSetPassword" MaxLength="50" Width="150" runat="server" /></td>
	
	<td><div class="text" id="MemberConfirmPasswordText" runat="server"></div></td>
	<td><div id="validateConfirmPassword" class="errorText" runat="server" /><asp:textbox TextMode="Password" id="MemberConfirmPassword" MaxLength="50" Width="150" runat="server" /></td>
</tr>



<tr>
	<td><div class="requireText" id="MemberGroupParam" runat="server"></div></td>
	<td><div id="validateUserGroup" class="errorText" runat="server" /><synature:userGroup id="GetUserGroup" runat="server" /></td>
	
	<td><div class="requireText" id="MemberGenderParam" runat="server"></div></td>
	<td class="text"><div id="validateGender" class="errorText" runat="server" /><input type="radio" id="MemberGenderMale" name="MemberGender" value="1" runat="server" /><span id="MaleText" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="MemberGenderFemale" name="MemberGender" value="2" runat="server" /><span id="FemaleText" runat="server"></span></td>
	
	<td><div class="requireText" id="MemberLangParam" runat="server"></div></td>
	<td><div id="validateUserLang" class="errorText" runat="server" /><synature:getLang id="GetUserLang" runat="server" /></td>
</tr>


<tr>
	<td><div class="requireText" id="MemberFirstNameParam" runat="server"></div></td>
	<td><div id="validateFirstName" class="errorText" runat="server" /><asp:textbox ID="MemberFirstName" MaxLength="50" Width="150" runat="server" /></td>
	
	<td><div class="requireText" id="MemberLastNameParam" runat="server"></div></td>
	<td><div id="validateLastName" class="errorText" runat="server" /><asp:textbox ID="MemberLastName" MaxLength="50" Width="150" runat="server" /></td>
	
	<td><div class="text" id="MemberCityParam" runat="server"></div></td>
	<td><asp:textbox ID="MemberCity" MaxLength="100" Width="150" runat="server" /></td>
</tr>

<tr>
	<td><div class="text" id="MemberAddress1Param" runat="server"></div></td>
	<td colspan="3"><asp:textbox ID="MemberAddress1" MaxLength="255" Width="448" runat="server" /></td>
	<td><div class="text" id="MemberProvinceParam" runat="server"></div></td>
	<td><synature:province id="GetProvince" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="MemberAddress2Param" runat="server"></div></td>
	<td colspan="3"><asp:textbox ID="MemberAddress2" MaxLength="255" Width="448" runat="server" /></td>
	<td><div class="text" id="MemberZipCodeParam" runat="server"></div></td>
	<td><asp:textbox ID="MemberZipCode" MaxLength="20" Width="150" runat="server" /></td>
</tr>


<tr>
	<td><div class="text" id="MemberTelephoneParam" runat="server"></div></td>
	<td><asp:textbox ID="MemberTelephone" MaxLength="20" Width="150" runat="server" /></td>
	<td><div class="text" id="MemberMobileParam" runat="server"></div></td>
	<td><asp:textbox ID="MemberMobile" MaxLength="20" Width="150" runat="server" /></td>
	<td><div class="text" id="MemberFaxParam" runat="server"></div></td>
	<td><asp:textbox ID="MemberFax" Width="150" MaxLength="20" runat="server" /></td>
</tr>

<tr>
	<td><div class="text" id="MemberEmailParam" runat="server"></div></td>
	<td><asp:textbox ID="MemberEmail" MaxLength="100" Width="150" runat="server" /></td>
	<td><div class="text" id="MemberBloodParam" runat="server"></div></td>
	<td><asp:textbox ID="MemberBlood" MaxLength="5" Width="150" runat="server" /></td>
	<td><div class="text" id="MemberBirthDayParam" runat="server"></div></td>
	<td><div id="validateBirthDayDate" class="errorText" runat="server" /><synature:date id="BirthDay" runat="server" /></td>
</tr>

<tr>
	<td><div class="text" id="MemberIDNumberParam" runat="server"></div></td>
	<td><asp:textbox ID="MemberIDNumber" MaxLength="50" Width="150" runat="server" /></td>
	<td><div class="text" id="MemberIDIssueDateParam" runat="server"></div></td>
	<td><div id="validateIssueDate" class="errorText" runat="server" /><synature:date id="IDIssueDate" runat="server" /></td>
	<td><div class="text" id="MemberIDExpireDateParam" runat="server"></div></td>
	<td><div id="validateExpireDate" class="errorText" runat="server" /><synature:date id="IDExpireDate" runat="server" /></td>
</tr>

<tr>
	<td><div class="text" id="MemberExpirationParam" runat="server"></div></td>
	<td><div id="validateMemberExpireDate" class="errorText" runat="server" /><synature:date id="MemberExpireDate" runat="server" /></td>
	<td><div class="text" id="MemberPictureParam" runat="server"></div></td>
	<td colspan="3"><div id="validateUploadFile" class="errorText" runat="server" /><input id="MemberPicture" type="file" accept="image/*" style="width:300px" runat="server" /><asp:CheckBox ID="RemoveImage" Text="Remove Picture" CssClass="text" Visible="false" runat="server"></asp:CheckBox></td>
</tr>


<tr>
	<td><div class="text" id="UserActivateText" runat="server"></div></td>
	<td class="text"><input type="radio" id="MemberEnable" name="Activated" value="1" runat="server" /><span id="YesText" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="MemberDisable" name="Activated" value="0" runat="server" /><span id="NoText" runat="server"></span></td>
	<td valign="top"><div class="text" id="MemberAdditionalParam" runat="server"></div></td>
	<td colspan="3"><asp:textbox ID="MemberAdditional" TextMode="MultiLine" Columns="80" Rows="3" Width="300" runat="server" /></td>
</tr>
</table>


<div id="ExtraInfo" runat="server"></div>


<table width="100%">
<tr><td width="100%" align="left"><asp:button ID="SubmitForm1" OnClick="DoAddUpdate" runat="server" /></td></tr>
</table>


</asp:Panel>
<table><tr><td>
<div id="errorMsg" class="boldText" runat="server" />

<div id="stext" class="text" runat="server"></div>
</td></tr></table>

</td>
<td>&nbsp;</td>
</tr>

<tr><td colspan="4" height="30">&nbsp;</td></tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
<tr>
	<td height="50" colspan="3" background="../images/footerbg2000.gif">&nbsp;</td>
</tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
</table>
</form>
<script language="VB" runat="server">

Dim userInfo As New CMembers()
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim getPageText As New DefaultText()
Dim DateTimeUtil As New MyDateTime()
Dim getInfo As New CPreferences()
Dim objDB As New CDBUtil()

Sub Page_Load()
	If  User.Identity.IsAuthenticated And (Session("Member_Info")) Then
	
		
		
		If Session("Member_Info_Activation") Then '
			MemberEnable.Disabled = False
			MemberDisable.Disabled = False
		Else
			MemberEnable.Disabled = True
			MemberDisable.Disabled = True
		End If
		showContent.Visible = True
		objCnn = getCnn.EstablishConnection()
		MemberOrStaff.Value = 1
		Dim permissionItemList As String = ""
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(11,Session("LangID"),objCnn)
		
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
		
		Dim propData As DataTable
        propData = getInfo.PropertyInfo(1, objCnn)
		
		SectionText.InnerHtml = textTable.Rows(9)("TextParamValue")
		
		MemberCodeParam.InnerHtml = textTable.Rows(19)("TextParamValue")
		MemberGroupParam.InnerHtml = textTable.Rows(18)("TextParamValue")
		MemberFirstNameParam.InnerHtml = defaultTextTable.Rows(16)("TextParamValue")
		MemberLastNameParam.InnerHtml = defaultTextTable.Rows(17)("TextParamValue")
		MemberGenderParam.InnerHtml = defaultTextTable.Rows(28)("TextParamValue")
		MaleText.InnerHtml = defaultTextTable.Rows(29)("TextParamValue")
		FemaleText.InnerHtml = defaultTextTable.Rows(30)("TextParamValue")
		MemberEmailParam.InnerHtml = defaultTextTable.Rows(25)("TextParamValue")
		MemberAddress1Param.InnerHtml = defaultTextTable.Rows(18)("TextParamValue")
		MemberAddress2Param.InnerHtml = defaultTextTable.Rows(19)("TextParamValue")
		MemberCityParam.InnerHtml = defaultTextTable.Rows(20)("TextParamValue")
		MemberProvinceParam.InnerHtml = defaultTextTable.Rows(21)("TextParamValue")
		MemberZipCodeParam.InnerHtml = defaultTextTable.Rows(22)("TextParamValue")
		MemberTelephoneParam.InnerHtml = defaultTextTable.Rows(23)("TextParamValue")
		MemberFaxParam.InnerHtml = defaultTextTable.Rows(24)("TextParamValue")
		MemberMobileParam.InnerHtml = defaultTextTable.Rows(27)("TextParamValue")
		MemberBirthDayParam.InnerHtml = defaultTextTable.Rows(31)("TextParamValue")
		MemberAdditionalParam.InnerHtml = defaultTextTable.Rows(26)("TextParamValue")
		MemberIDNumberParam.InnerHtml = defaultTextTable.Rows(32)("TextParamValue")
		MemberIDIssueDateParam.InnerHtml = defaultTextTable.Rows(33)("TextParamValue")
		MemberIDExpireDateParam.InnerHtml = defaultTextTable.Rows(34)("TextParamValue")
		MemberBloodParam.InnerHtml = defaultTextTable.Rows(35)("TextParamValue")
		
		MemberLangParam.InnerHtml = defaultTextTable.Rows(36)("TextParamValue")
		UserActivateText.InnerHtml = textTable.Rows(21)("TextParamValue")
		MemberPasswordText.InnerHtml = defaultTextTable.Rows(37)("TextParamValue")
		MemberConfirmPasswordText.InnerHtml = defaultTextTable.Rows(38)("TextParamValue")
		MemberExpirationParam.InnerHtml = textTable.Rows(36)("TextParamValue")
		
		YesText.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
		NoText.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
		
		'Set Form name for province
		GetProvince.FormName = "MemberProvince"
		GetProvince.LangID = Session("LangID")
		
		GetUserLang.FormName = "LangID"
		GetUserLang.LangID = Session("LangID")
		
		GetUserGroup.FormName = "MemberGroupID"
		GetUserGroup.LangID = Session("LangID")
		GetUserGroup.MemberGroupID = Session("MemberGroup")
		
		BirthDay.LangID = Session("LangID")
		BirthDay.FormName = "BirthDayFormName"
		BirthDay.YearType = propData.Rows(0)("YearSetting")
		IDIssueDate.LangID = Session("LangID")
		IDIssueDate.FormName = "IDIssueDateFormName"
		IDIssueDate.YearType = propData.Rows(0)("YearSetting")
		IDIssueDate.StartYear = 10
		IDExpireDate.LangID = Session("LangID")
		IDExpireDate.FormName = "IDExpireDateFormName"
		IDExpireDate.YearType = propData.Rows(0)("YearSetting")
		IDExpireDate.StartYear = 1
		IDExpireDate.EndYear = 10
		MemberExpireDate.LangID = Session("LangID")
		MemberExpireDate.FormName = "MemberExpireDateFormName"
		MemberExpireDate.YearType = propData.Rows(0)("YearSetting")
		MemberExpireDate.StartYear = 1
		MemberExpireDate.EndYear = 10
		
		Dim i,j As Integer
		If Request.QueryString("Logout") = "yes" Then
			MMenu.Logout = 1
		Else
			MMenu.Logout = 0
		End If
		
		
		If NOT Request.QueryString("MemberID") AND IsNumeric(Request.QueryString("MemberID")) Then
			MMenu.MemberPage = 5
			
			'updateMessage.Text = textTable.Rows(23)("TextParamValue")
			SubmitForm.Text = textTable.Rows(25)("TextParamValue")
			SubmitForm1.Text = textTable.Rows(25)("TextParamValue")
			MemberID.Value = Request.QueryString("MemberID")
			MemberSetPassword.Enabled = False
			MemberConfirmPassword.Enabled = False
			
			IF Not Page.IsPostBack Then
				
				'Try

					Dim MemberInfo As DataTable
        			MemberInfo = userInfo.GetMemberInfo(1,-1,Request.QueryString("MemberID"),-1,"CodeOrder", objCnn)
					
					
					For i = 0 To MemberInfo.Rows.Count - 1
						If IsDBNull(MemberInfo.Rows(i)("MemberPictureFileServer")) Then
							MemberPictureParam.InnerHtml = textTable.Rows(20)("TextParamValue")
							RemoveImage.Visible = False
						Else
							If trim(MemberInfo.Rows(i)("MemberPictureFileServer")) = "" Then
								MemberPictureParam.InnerHtml = textTable.Rows(20)("TextParamValue")
							Else
								MemberPictureParam.InnerHtml = "<a href=""JavaScript: newWindow = window.open( '../images/members/" + Replace(MemberInfo.Rows(i)("MemberPictureFileServer"),"\","/") + "', '', 'width=600,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + textTable.Rows(20)("TextParamValue") + "</a>"
							End If
							RemoveImage.Visible = True
						End If
						
						If IsDBNull(MemberInfo.Rows(i)("MemberCode")) Then
							MemberCode.Text = ""
						Else
							MemberCode.Text = MemberInfo.Rows(i)("MemberCode")
						End If
						If Not IsDBNull(MemberInfo.Rows(i)("MemberGroupID")) Then
							GetUserGroup.SelectedUserGroup = MemberInfo.Rows(i)("MemberGroupID")
						End If
						If Not IsDBNull(MemberInfo.Rows(i)("LangID")) Then
							GetUserLang.SelectedLang = MemberInfo.Rows(i)("LangID")
						End If
						If IsDBNull(MemberInfo.Rows(i)("MemberFirstName")) Then
							MemberFirstName.Text = ""
						Else
							MemberFirstName.Text = MemberInfo.Rows(i)("MemberFirstName")
						End If
						If IsDBNull(MemberInfo.Rows(i)("MemberLastName")) Then
							MemberLastName.Text = ""
						Else
							MemberLastName.Text = MemberInfo.Rows(i)("MemberLastName")
						End If
						If IsDBNull(MemberInfo.Rows(i)("MemberAddress1")) Then
							MemberAddress1.Text = ""
						Else
							MemberAddress1.Text = MemberInfo.Rows(i)("MemberAddress1")
						End If
						If IsDBNull(MemberInfo.Rows(i)("MemberAddress2")) Then
							MemberAddress2.Text = ""
						Else
							MemberAddress2.Text = MemberInfo.Rows(i)("MemberAddress2")
						End If
						If IsDBNull(MemberInfo.Rows(i)("MemberCity")) Then
							MemberCity.Text = ""
						Else
							MemberCity.Text = MemberInfo.Rows(i)("MemberCity")
						End If
						If IsDBNull(MemberInfo.Rows(i)("MemberZipCode")) Then
							MemberZipCode.Text = ""
						Else
							MemberZipCode.Text = MemberInfo.Rows(i)("MemberZipCode")
						End If
						If IsDBNull(MemberInfo.Rows(i)("MemberTelephone")) Then
							MemberTelephone.Text = ""
						Else
							MemberTelephone.Text = MemberInfo.Rows(i)("MemberTelephone")
						End If
						If IsDBNull(MemberInfo.Rows(i)("MemberMobile")) Then
							MemberMobile.Text = ""
						Else
							MemberMobile.Text = MemberInfo.Rows(i)("MemberMobile")
						End If
						If IsDBNull(MemberInfo.Rows(i)("MemberFax")) Then
							MemberFax.Text = ""
						Else
							MemberFax.Text = MemberInfo.Rows(i)("MemberFax")
						End If
						If IsDBNull(MemberInfo.Rows(i)("MemberEmail")) Then
							MemberEmail.Text = ""
						Else
							MemberEmail.Text = MemberInfo.Rows(i)("MemberEmail")
						End If
						If IsDBNull(MemberInfo.Rows(i)("MemberAdditional")) Then
							MemberAdditional.Text = ""
						Else
							MemberAdditional.Text = MemberInfo.Rows(i)("MemberAdditional")
						End If
						If Not IsDBNull(MemberInfo.Rows(i)("MemberProvince")) Then
							GetProvince.SelectedProvince = MemberInfo.Rows(i)("MemberProvince")
						End If
						If IsDate(MemberInfo.Rows(i)("MemberBirthDay")) Then
							BirthDay.SelectedDay = MemberInfo.Rows(i)("MemberBirthDay").Day
							BirthDay.SelectedMonth = MemberInfo.Rows(i)("MemberBirthDay").Month
							BirthDay.SelectedYear = MemberInfo.Rows(i)("MemberBirthDay").Year
						End If
						If IsDBNull(MemberInfo.Rows(i)("MemberIDNumber")) Then
							MemberIDNumber.Text = ""
						Else
							MemberIDNumber.Text = MemberInfo.Rows(i)("MemberIDNumber")
						End If
						If IsDBNull(MemberInfo.Rows(i)("MemberBlood")) Then
							MemberBlood.Text = ""
						Else
							MemberBlood.Text = MemberInfo.Rows(i)("MemberBlood")
						End If
						If IsDate(MemberInfo.Rows(i)("MemberIDIssueDate")) Then
							IDIssueDate.SelectedDay = MemberInfo.Rows(i)("MemberIDIssueDate").Day
							IDIssueDate.SelectedMonth = MemberInfo.Rows(i)("MemberIDIssueDate").Month
							IDIssueDate.SelectedYear = MemberInfo.Rows(i)("MemberIDIssueDate").Year
						End If
						If IsDate(MemberInfo.Rows(i)("MemberIDExpiration")) Then
							IDExpireDate.SelectedDay = MemberInfo.Rows(i)("MemberIDExpiration").Day
							IDExpireDate.SelectedMonth = MemberInfo.Rows(i)("MemberIDExpiration").Month
							IDExpireDate.SelectedYear = MemberInfo.Rows(i)("MemberIDExpiration").Year
						End If
						If IsDate(MemberInfo.Rows(i)("MemberExpiration")) Then
							MemberExpireDate.SelectedDay = MemberInfo.Rows(i)("MemberExpiration").Day
							MemberExpireDate.SelectedMonth = MemberInfo.Rows(i)("MemberExpiration").Month
							MemberExpireDate.SelectedYear = MemberInfo.Rows(i)("MemberExpiration").Year
						End If
						If Not IsDBNull(MemberInfo.Rows(i)("MemberGender")) Then
							If MemberInfo.Rows(i)("MemberGender") = 1 Then
								MemberGenderMale.Checked = True
							Else If MemberInfo.Rows(i)("MemberGender") = 2 Then
								MemberGenderFemale.Checked = True
							End If
						End If
						If Not IsDBNull(MemberInfo.Rows(i)("Activated")) Then
							If MemberInfo.Rows(i)("Activated") = True OR MemberInfo.Rows(i)("Activated") = 1 Then
								MemberEnable.Checked = True
							Else
								MemberDisable.Checked = True
							End If
						Else
							MemberDisable.Checked = True
						End If
						OldMemberCode.Value = MemberInfo.Rows(i)("MemberCode")
					Next
						
				'Catch ex As Exception
					'errorMsg.InnerHtml = ex.Message
				'End Try
				
			End If

		Else
			MemberPictureParam.InnerHtml = textTable.Rows(20)("TextParamValue")
			'EditMyProfileText.InnerHtml = "[" + textTable.Rows(22)("TextParamValue") + "]"
			'updateMessage.Text = textTable.Rows(22)("TextParamValue")
			SubmitForm.Text = textTable.Rows(24)("TextParamValue")
			SubmitForm1.Text = textTable.Rows(24)("TextParamValue")
			MemberID.Value = 0
			OldMemberCode.Value = ""
			If Not Page.IsPostBack Then 
				MemberEnable.Checked = True
			End If
			MMenu.MemberPage = 7
			If propData.Rows(0)("HeadOrBranch") = 1 Then
				SubmitForm.Visible = False
				SubmitForm1.Visible = False
			End If
		End If
		
		MemberStaffID.Value = MemberID.Value
		
		'---------Extra Info Section----------
		Dim UDDGroup As DataTable = getInfo.GetUDDGInfo1(1,0,1,objCnn)
		
		Dim OptionData As New DataTable()
		Dim ExtraInfoText As String = ""
		Dim DummyValue As String = ""
		Dim ddDummy,mmDummy,yyDummy As Integer
		Dim Arr() As String
		Dim getUDD As New DataTable()
		Dim OptionType,FormValue,FormName,FormValueList,compareString,OptionList,TestStr As String
		Dim numCount,jj,indexj As Integer
		For indexj = 0 To UDDGroup.Rows.Count - 1
		  ExtraInfoText += "<br><table width=""100%"" border=""1"" cellspacing=""0"" cellpadding=""3"" style=""border-collapse:collapse;"">"
		  ExtraInfoText += "<tr><td colspan=""2"" class=""boldText"">" + UDDGroup.Rows(indexj)("UDDGName") + "</td></tr>"
		  Dim UDDData As DataTable = getInfo.UserDefineData(UDDGroup.Rows(indexj)("UDDGID"),0,1,objCnn)
		  For i=0 to UDDData.Rows.Count - 1 
			If UDDData.Rows(i)("UDDPropID") = 1 Or UDDData.Rows(i)("UDDPropID") = 3 Then
				DummyValue = ""
				ddDummy = 0
				mmDummy = 0
				yyDummy = 0
				If Not Page.IsPostBack Then
					getUDD = getInfo.UDDValue(MemberStaffID.Value,MemberOrStaff.Value,UDDData.Rows(i)("UDDID"),0,objCnn)
					If getUDD.Rows.Count > 0 Then
						If Not IsDBNull(getUDD.Rows(0)("UDVText")) Then
							DummyValue = getUDD.Rows(0)("UDVText")
						ElseIf getUDD.Rows(0)("OptionID") <> 0 Then
							For j = 0 to getUDD.Rows.Count - 1
								DummyValue += "," + getUDD.Rows(j)("OptionID").ToString
							Next
							DummyValue += ","
						ElseIf Not IsDBNull(getUDD.Rows(0)("UDVDate")) Then
							ddDummy = getUDD.Rows(0)("UDVDate").Day
							mmDummy = getUDD.Rows(0)("UDVDate").Month
							yyDummy = getUDD.Rows(0)("UDVDate").Year
						Else
							DummyValue = getUDD.Rows(0)("UDVValue").ToString
						End If 
					End If
				End If
				
				
			
				FormName = "_ID:" + UDDData.Rows(i)("UDDTypeID").ToString + ":" + UDDData.Rows(i)("UDDID").ToString
				ExtraInfoText += "<tr><td class=""text"" valign=""top"">"
				If UDDData.Rows(i)("UDDTypeID") = 6 Then
					If trim(DummyValue) = "" Then
						ExtraInfoText += UDDData.Rows(i)("UDDName") + "</td>"
					Else
						ExtraInfoText += "<a href=""JavaScript: newWindow = window.open( '../images/members/" + Replace(DummyValue,"\","/") + "', '', 'width=600,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + UDDData.Rows(i)("UDDName") + "</a></td>"
					End If
				Else
					ExtraInfoText += UDDData.Rows(i)("UDDName") + "</td>"
				End If
				If UDDData.Rows(i)("UDDTypeID") = 1 Or UDDData.Rows(i)("UDDTypeID") = 2 Then
					If Trim(Request.Form(FormName)) <> "" Then
						FormValue = Request.Form(FormName)
					ElseIf Trim(DummyValue) <> ""
						FormValue = DummyValue
					Else
						FormValue = ""
					End If
					ExtraInfoText += "<td><input type=""text"" style=""width:150px;"" name=""" + FormName + """ value=""" + FormValue + """></td>"
				ElseIf UDDData.Rows(i)("UDDTypeID") = 5 Then
					Dim ddName,mmName,yyName,selected,yyyyValue As String
					Dim ddValue,mmValue,yyValue As Integer
					ddName = "dd" + FormName
					mmName = "mm" + FormName
					yyName = "yy" + FormName
					If Trim(Request.Form(ddName)) <> "" Then
						ddValue = Request.Form(ddName)
					ElseIf ddDummy > 0
						ddValue = ddDummy
					Else
						ddValue = 0
					End If
					If Trim(Request.Form(mmName)) <> "" Then
						mmValue = Request.Form(mmName)
					ElseIf ddDummy > 0
						mmValue = mmDummy
					Else
						mmValue = 0
					End If
					If IsNumeric(Request.Form(yyName)) Then
						yyValue = Request.Form(yyName)
					ElseIf ddDummy > 0
						yyValue = yyDummy
					Else
						yyValue = 0
					End If
					If yyValue > 0 Then
						yyyyValue = yyValue.ToString
					Else
						yyyyValue = ""
					End If
					If propData.Rows(0)("YearSetting") = 1 AND IsNumeric(yyyyValue)  Then
						yyyyValue += 543
					End If
				
					ExtraInfoText += "<td class=""text"">"
					ExtraInfoText += "<select name=""" + "dd" + FormName + """>"
					ExtraInfoText += "<option value="""">-Day-"
					For jj=1 To 31 
						If jj = ddValue Then
							selected = " selected"
						Else
							selected = ""
						End If
						ExtraInfoText += "<option value=""" + jj.ToString + """" + selected + ">" + jj.ToString
					Next
					ExtraInfoText += "</select> / "
					ExtraInfoText += "<select name=""" + "mm" + FormName + """>"
					ExtraInfoText += "<option value="""">-Month-"
					For jj=1 To 12
						If jj = mmValue Then
							selected = " selected"
						Else
							selected = ""
						End If
						ExtraInfoText += "<option value=""" + jj.ToString + """" + selected + ">" + jj.ToString
					Next
					ExtraInfoText += "</select> / "
					ExtraInfoText += "<input type""text"" name=""yy" + FormName + """ size=""4"" maxlength=""4"" value=""" + yyyyValue + """> dd/mm/yyyy"
				ElseIf UDDData.Rows(i)("UDDTypeID") = 6 Then
					ExtraInfoText += "<td><input id=""" + FormName + """ type=""file"" style=""width:300px;"" name=""" + FormName + """></td>"
				Else
					If UDDData.Rows(i)("UDDTypeID") = 3 Then
						OptionType = " multiple"
					Else
						OptionType = ""
					End If
					
					If Trim(Request.Form(FormName)) <> "" Then
						FormValueList = "," & Request.Form(FormName) & ","
					ElseIf Trim(DummyValue) <> ""
						FormValueList = DummyValue
					Else
						FormValueList = ""
					End If
					TestStr += "<br>" + FormValueList
					OptionData = getInfo.UDDOption(UDDData.Rows(i)("UDDID"), objCnn)
					ExtraInfoText += "<td class=""text"">"
					OptionList = ""
					numCount = 0
					For j=0 to OptionData.Rows.Count - 1
						compareString = "," & OptionData.Rows(j)("OptionID").ToString & ","
						FormValue = ""
						If FormValueList.IndexOf(compareString) <> -1 Then
							FormValue = " selected"
							numCount += 1
						End If
						OptionList += "<option value=""" + OptionData.Rows(j)("OptionID").ToString + """" + FormValue + ">" + OptionData.Rows(j)("OptionName")
					Next
					If numCount > 0 Then
						FormValue = ""
					Else
						FormValue = " selected"
					End If
					ExtraInfoText += "<select style=""width:300px;height=100px"" name=""" + FormName + """" + OptionType + ">" + "<option value=""0""" + FormValue + ">" + defaultTextTable.Rows(102)("TextParamValue") + OptionList + "</select>"
					ExtraInfoText += "</td>"	
				End If
				ExtraInfoText += "</tr>"
			End If 
		  Next
		  ExtraInfoText += "</table>"
		Next
		ExtraInfo.InnerHtml = ExtraInfoText
		'-------------------------------------
		
		If NOT Session("Member_Info_Add") AND MemberID.Value = 0 Then 
			showContent.Visible = False
			errorMsg.InnerHtml = "You're not permit to add member data"
		End If
		Dim ChkEditMyProfile As Boolean = False
		If Session("User_EditMyProfile") AND Session("MemberID") = MemberID.Value Then
			ChkEditMyProfile = True
		End If
		If ChkEditMyProfile = False Then
			If NOT Session("Member_Info_Edit") AND MemberID.Value <> 0 Then 
				showContent.Visible = False
				errorMsg.InnerHtml = "You're not permist to edit member data"
			End If
		End If

		
		If IsNumeric(Request.Form("BirthDayFormName_Day")) Then 
			BirthDay.SelectedDay = Request.Form("BirthDayFormName_Day")
		End If
		If IsNumeric(Request.Form("BirthDayFormName_Month")) Then 
			BirthDay.SelectedMonth = Request.Form("BirthDayFormName_Month")
		End If
		If IsNumeric(Request.Form("BirthDayFormName_Year")) Then 
			BirthDay.SelectedYear = Request.Form("BirthDayFormName_Year")
		End If
		
		If IsNumeric(Request.Form("IDIssueDateFormName_Day")) Then 
			IDIssueDate.SelectedDay = Request.Form("IDIssueDateFormName_Day")
		End If
		If IsNumeric(Request.Form("IDIssueDateFormName_Month")) Then 
			IDIssueDate.SelectedMonth = Request.Form("IDIssueDateFormName_Month")
		End If
		If IsNumeric(Request.Form("IDIssueDateFormName_Year")) Then 
			IDIssueDate.SelectedYear = Request.Form("IDIssueDateFormName_Year")
		End If
		
		If IsNumeric(Request.Form("IDExpireDateFormName_Day")) Then 
			IDExpireDate.SelectedDay = Request.Form("IDExpireDateFormName_Day")
		End If
		If IsNumeric(Request.Form("IDExpireDateFormName_Month")) Then 
			IDExpireDate.SelectedMonth = Request.Form("IDExpireDateFormName_Month")
		End If
		If IsNumeric(Request.Form("IDExpireDateFormName_Year")) Then 
			IDExpireDate.SelectedYear = Request.Form("IDExpireDateFormName_Year")
		End If
		
		If IsNumeric(Request.Form("MemberExpireDateFormName_Day")) Then 
			MemberExpireDate.SelectedDay = Request.Form("MemberExpireDateFormName_Day")
		End If
		If IsNumeric(Request.Form("MemberExpireDateFormName_Month")) Then 
			MemberExpireDate.SelectedMonth = Request.Form("MemberExpireDateFormName_Month")
		End If
		If IsNumeric(Request.Form("MemberExpireDateFormName_Year")) Then 
			MemberExpireDate.SelectedYear = Request.Form("MemberExpireDateFormName_Year")
		End If
		
		If IsNumeric(Request.Form("MemberProvince")) Then 
			GetProvince.SelectedProvince = Request.Form("MemberProvince")
		End If
		If IsNumeric(Request.Form("MemberGroupID")) Then 
			GetUserGroup.SelectedUserGroup = Request.Form("MemberGroupID")
		End If
		If IsNumeric(Request.Form("LangID")) Then 
			GetUserLang.SelectedLang = Request.Form("LangID")
		End If
		'GetProvinces()
		'ProvinceData.SelectedIndex = SelectedProvince
	Else
		showContent.Visible = False
		If Request.QueryString("Logout") = "yes" Then
			errorMsg.InnerHtml = "Session Expired. Please <a href=""../Logout.aspx?goto=member"">Click Here</a> to relogin again"
		Else
			errorMsg.InnerHtml = "Session Expired. Please <a href=""../Logout.aspx"">Click Here</a> to relogin again"
		End If
	End If
End Sub

Sub DoAddUpdate(Source As Object, E As EventArgs)
	validateCode.InnerHtml = ""
	
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(11,Session("LangID"),objCnn)
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	Dim ChkMemberCode As DataTable
    ChkMemberCode = getCnn.List("select count(*) AS totalRecords from Members where Deleted=0 AND MemberCode='" + MemberCode.Text + "'",  objCnn)
	
	Dim FoundError AS Boolean = False
	If Len(Trim(MemberCode.Text)) = 0 Then
		validateCode.InnerHtml = textTable.Rows(26)("TextParamValue") & "<br>"
		FoundError = True
	Else If ChkMemberCode.Rows(0)("totalRecords") <> 0 And (MemberID.Value = 0 Or (MemberID.Value <> 0 And String.Compare(UCase(OldMemberCode.Value),UCase(MemberCode.Text)) <> 0)) Then
		validateCode.InnerHtml = textTable.Rows(27)("TextParamValue") & "<br>"
		FoundError = True
	End If

	If Session("Member_Info_Password") And MemberID.Value = 0 Then
		'If Trim(Request.Form("MemberSetPassword")) = "" Then
			'validatePassword.InnerHtml = defaultTextTable.Rows(39)("TextParamValue") & "<br>"
			'FoundError = True
		'End If
		If String.Compare(UCase(Request.Form("MemberSetPassword")),UCase(Request.Form("MemberConfirmPassword"))) <> 0 Then
			validateConfirmPassword.InnerHtml = defaultTextTable.Rows(40)("TextParamValue") & "<br>"
			FoundError = True
		End If
	End If
	
	If Not IsNumeric(Request.Form("MemberGroupID")) OR Request.Form("MemberGroupID") = 0 Then
		validateUserGroup.InnerHtml = textTable.Rows(28)("TextParamValue") & "<br>"
		FoundError = True
	End If
	If MemberGenderMale.Checked = False AND MemberGenderFemale.Checked = False Then
		validateGender.InnerHtml = defaultTextTable.Rows(42)("TextParamValue") & "<br>"
		FoundError = True
	End If
	If Len(Trim(MemberFirstName.Text)) = 0 Then
		validateFirstName.InnerHtml =  defaultTextTable.Rows(43)("TextParamValue") & "<br>"
		FoundError = True
	End If
	If Len(Trim(MemberLastName.Text)) = 0 Then
		validateLastName.InnerHtml =  defaultTextTable.Rows(44)("TextParamValue") & "<br>"
		FoundError = True
	End If
	
	Dim FileTransfer As Boolean = True
	Try
		If MemberPicture.PostedFile.ContentType.IndexOf("image/") = -1 AND Trim(MemberPicture.PostedFile.FileName) <> ""
			validateUploadFile.InnerHtml = defaultTextTable.Rows(11)("TextParamValue") & "<br>"
			FoundError = True
		End If
	Catch ex As Exception
		FileTransfer = False
	End Try
	
	If Not IsNumeric(Request.Form("LangID")) OR Request.Form("LangID") = 0 Then
		validateUserLang.InnerHtml = defaultTextTable.Rows(41)("TextParamValue") & "<br>"
		FoundError = True
	End If

	Dim MemberBirthDay,MemberIDIssueDate,MemberIDExpireDate,MemberExpiration As String
	
	MemberBirthDay = DateTimeUtil.FormatDate(Request.Form("BirthDayFormName_Day"),Request.Form("BirthDayFormName_Month"),Request.Form("BirthDayFormName_Year"))
	
	If Trim(MemberBirthDay) = "InvalidDate" Then
		validateBirthDayDate.InnerHtml = defaultTextTable.Rows(45)("TextParamValue") & "<br>"
		FoundError = True
	End If
	
	MemberIDIssueDate = DateTimeUtil.FormatDate(Request.Form("IDIssueDateFormName_Day"),Request.Form("IDIssueDateFormName_Month"),Request.Form("IDIssueDateFormName_Year"))
	
	If Trim(MemberIDIssueDate) = "InvalidDate" Then
		validateIssueDate.InnerHtml = defaultTextTable.Rows(45)("TextParamValue") & "<br>"
		FoundError = True
	End If
	
	MemberIDExpireDate = DateTimeUtil.FormatDate(Request.Form("IDExpireDateFormName_Day"),Request.Form("IDExpireDateFormName_Month"),Request.Form("IDExpireDateFormName_Year"))
	
	If Trim(MemberIDExpireDate) = "InvalidDate" Then
		validateExpireDate.InnerHtml = defaultTextTable.Rows(45)("TextParamValue") & "<br>"
		FoundError = True
	End If
	
	MemberExpiration = DateTimeUtil.FormatDate(Request.Form("MemberExpireDateFormName_Day"),Request.Form("MemberExpireDateFormName_Month"),Request.Form("MemberExpireDateFormName_Year"))
	
	If Trim(MemberExpiration) = "InvalidDate" Then
		validateMemberExpireDate.InnerHtml = defaultTextTable.Rows(45)("TextParamValue") & "<br>"
		FoundError = True
	End If
	
	Dim updateDB AS New DBInfo()
	
	If FoundError = False Then
		'Application.Lock()
		Dim ExtraSQL(1) As String
		Dim DownloadDir,MemberPictureFileServer,MemberPictureFileClient As String
		Dim DownloadPath As String
		DownloadDir = Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED")).ToLower
		DownloadDir = DownloadDir.Replace("members","images\Members")
		
		Dim FolderID As Integer = getInfo.GetFolder("Members","MemberID",MemberID.Value,objCnn)
		
		DownloadDir += "\" + FolderID.ToString
		If Not Directory.Exists(DownloadDir) Then
			Directory.CreateDirectory(DownloadDir)
		End If
		Try
		If Trim(MemberPicture.PostedFile.FileName) <> "" Then
			Dim DownloadCompleted As Boolean = False
			Dim ServerFile As String
			ServerFile = Path.GetFileName(MemberPicture.PostedFile.FileName)
			
			DownloadPath = DownloadDir + "\" + ServerFile
			MemberPicture.PostedFile.SaveAs(DownloadPath)
			MemberPictureFileServer = FolderID.ToString + "\\" + ServerFile
			MemberPictureFileClient = Path.GetFileName(MemberPicture.PostedFile.FileName)

		Else
			MemberPictureFileServer = ""
			MemberPictureFileClient = ""
		End If
		Catch ex As Exception
			MemberPictureFileServer = ""
			MemberPictureFileClient = ""
		End Try
		
		Dim TimeNow,ResultStatus As String
		TimeNow = DateTimeUtil.CurrentDateTime

		ExtraSQL(0) = ""
		ExtraSQL(1) = ""
		If MemberID.Value = 0 Then
			
			ExtraSQL(0) = "MemberBirthDay,MemberIDIssueDate,MemberIDExpiration,MemberExpiration,MemberPictureFileServer,MemberPictureFileClient,InputBy,InputDate,UpdateDate,UpdateBy,ImageFolder"
			
			If Trim(MemberBirthDay) = "" Then 
				ExtraSQL(1) += "NULL"
			Else
				ExtraSQL(1) += MemberBirthDay
			End If
			If Trim(MemberIDIssueDate) = "" Then 
				ExtraSQL(1) += ",NULL"
			Else
				ExtraSQL(1) += "," + MemberIDIssueDate
			End If
			If Trim(MemberIDExpireDate) = "" Then 
				ExtraSQL(1) += ",NULL"
			Else
				ExtraSQL(1) += "," + MemberIDExpireDate
			End If
			If Trim(MemberExpiration) = "" Then 
				ExtraSQL(1) += ",NULL"
			Else
				ExtraSQL(1) += "," + MemberExpiration
			End If
			
			If Trim(MemberPictureFileServer) = "" Then
				ExtraSQL(1) += ",NULL"
			Else
				ExtraSQL(1) += ",'" + MemberPictureFileServer.Replace("'","''") + "'"
			End If
			If Trim(MemberPictureFileClient) = "" Then
				ExtraSQL(1) += ",NULL"
			Else
				ExtraSQL(1) += ",'" + MemberPictureFileClient.Replace("'","''") + "'"
			End If
			
			ExtraSQL(1) += "," & Session("StaffID").ToString() & "," & TimeNow & "," & TimeNow & "," + Session("StaffID").ToString()
			ExtraSQL(1) += "," & FolderID.ToString
			
			If Trim(Request.Form("MemberSetPassword")) <> "" Then
				Dim strHash As String
				strHash = FormsAuthentication.HashPasswordForStoringInConfigFile(Request.Form("MemberSetPassword"), "SHA1")
				ExtraSQL(0) += ",MemberPassword"
				ExtraSQL(1) += ",'" + Replace(Request.Form("MemberSetPassword"),"'","''") + "'"
			End If
			
			ResultStatus = updateDB.AddUpdateDB(Request, ExtraSQL, "Members", "MemberID", objCnn)
			Dim AddExtra As String
			AddExtra = getInfo.AddUpdateUDD(Request, objCnn)
			
			Dim IDRangeType As Integer
			Dim getRangeType As DataTable = objDB.List("select * from IDRangeType WHERE Description='Members'", objCnn)
			If getRangeType.Rows.Count > 0 Then
				IDRangeType = getRangeType.Rows(0)("IDRangeTypeID")
			End If
			Dim IDRangeData As DataTable
			Dim getMaxID As DataTable
			IDRangeData = objDB.List("select * from IDRange WHERE ProductLevelID=0 AND IDRangeTypeID=" + IDRangeType.ToString, objCnn)
			If IDRangeData.Rows.Count > 0 Then		
			 	getMaxID = objDB.List("SELECT MAX(MemberID) AS MaxID FROM Members WHERE MemberID between " + IDRangeData.Rows(0)("MinID").ToString + " AND " + IDRangeData.Rows(0)("MaxID").ToString, objCnn)
			Else
				getMaxID = objDB.List("SELECT MAX(MemberID) AS MaxID FROM Members", objCnn)
			End If
			Dim NewMemberID As Integer = getMaxID.Rows(0)("MaxID")
			Dim myArray() As String
			Dim KeyS As String
			Dim MyPostedMember As HttpPostedFile
			Dim key As String
			Dim DLPath,IDString As String
			Dim chkData As DataTable
			For Each key in Request.Files
			  If Key.Indexof("_ID") <> -1 Then
				MyPostedMember=Request.Files(key)
				
				if MyPostedMember.ContentLength <>0  then
					Keys += "<br>" + Key
					Dim fi As New FileInfo(MyPostedMember.Filename)
					DLPath = DownloadDir + "\" + fi.Name
					MyPostedMember.SaveAs(DLPath)
					myArray = Key.Split(":"c)
					IDString = myArray(2)
					chkData = objDB.List("SELECT count(*) AS totalRecord FROM UserDefineValue WHERE HistoryGroupID=0 AND MemberOrStaff = " + Request.Form("MemberOrStaff").ToString + " AND MemberStaffID = " + NewMemberID.ToString + " AND UDDID=" + IDString, objCnn)
					If chkData.Rows(0)("totalRecord") = 0 Then
						objDB.sqlExecute("INSERT INTO UserDefineValue (MemberStaffID,MemberOrStaff,UDDID,UDVText) values (" + NewMemberID.ToString + "," + Request.Form("MemberOrStaff").ToString + "," + IDString + ",'" + FolderID.ToString + "\\" + fi.Name + "')", objCnn)
					Else
						objDB.sqlExecute("UPDATE UserDefineValue SET UDVText='" + FolderID.ToString + "\\" + fi.Name + "',UDVValue=0,OptionID=0,UDVDate=NULL WHERE HistoryGroupID=0 AND MemberOrStaff = " + Request.Form("MemberOrStaff").ToString + " AND MemberStaffID = " + NewMemberID.ToString + " AND UDDID=" + IDString, objCnn)
					End If
				end if
			  End If
			Next
			If ResultStatus = "Success" Then
				Response.Redirect("member_info_details.aspx?MemberID=" + NewMemberID.ToString + "&" + Request.QueryString.ToString)
			Else
				sText.InnerHtml = ResultStatus
			End If
			
		Else
			
			If Trim(MemberBirthDay) = "" Then 
				ExtraSQL(0) += "MemberBirthDay=NULL"
			Else
				ExtraSQL(0) += "MemberBirthDay=" + MemberBirthDay
			End If
			If Trim(MemberIDIssueDate) = "" Then 
				ExtraSQL(0) += ",MemberIDIssueDate=NULL"
			Else
				ExtraSQL(0) += ",MemberIDIssueDate=" + MemberIDIssueDate
			End If
			If Trim(MemberIDExpireDate) = "" Then 
				ExtraSQL(0) += ",MemberIDExpiration=NULL"
			Else
				ExtraSQL(0) += ",MemberIDExpiration=" + MemberIDExpireDate
			End If
			If Trim(MemberExpiration) = "" Then 
				ExtraSQL(0) += ",MemberExpiration=NULL"
			Else
				ExtraSQL(0) += ",MemberExpiration=" + MemberExpiration
			End If
			
			If RemoveImage.Checked = True Then
				ExtraSQL(0) += ",MemberPictureFileServer=NULL"
				ExtraSQL(0) += ",MemberPictureFileClient=NULL"
			Else
				If Trim(MemberPictureFileServer) <> "" Then
					ExtraSQL(0) += ",MemberPictureFileServer='" + MemberPictureFileServer.Replace("'","''") + "'"
				End If
				If Trim(MemberPictureFileClient) <> "" Then
					ExtraSQL(0) += ",MemberPictureFileClient='" + MemberPictureFileClient.Replace("'","''") + "'"
				End If
			End If
			ExtraSQL(0) += ",UpdateDate=" + TimeNow + ",UpdateBy=" + Session("StaffID").ToString()
			
			Dim ChkFolder As DataTable = objDB.List("SELECT ImageFolder FROM Members WHERE MemberID=" + MemberID.Value.ToString, objCnn)
			If ChkFolder.Rows(0)("ImageFolder") = 0 Then
				ExtraSQL(0) += ",ImageFolder=" + FolderID.ToString
			End If
			
			ResultStatus = updateDB.AddUpdateDB(Request, ExtraSQL, "Members", "MemberID", objCnn)
			Dim AddExtra As String
			AddExtra = getInfo.AddUpdateUDD(Request, objCnn)
			
			Dim myArray() As String
			Dim KeyS As String
			Dim MyPostedMember As HttpPostedFile
			Dim key As String
			Dim DLPath,IDString As String
			Dim chkData As DataTable
			For Each key in Request.Files
			  If Key.Indexof("_ID") <> -1 Then
				MyPostedMember=Request.Files(key)
				
				if MyPostedMember.ContentLength <>0  then
					Keys += "<br>" + Key
					Dim fi As New FileInfo(MyPostedMember.Filename)
					DLPath = DownloadDir + "\" + fi.Name
					MyPostedMember.SaveAs(DLPath)
					myArray = Key.Split(":"c)
					IDString = myArray(2)
					chkData = objDB.List("SELECT count(*) AS totalRecord FROM UserDefineValue WHERE HistoryGroupID=0 AND MemberOrStaff = " + Request.Form("MemberOrStaff").ToString + " AND MemberStaffID = " + MemberID.Value.ToString + " AND UDDID=" + IDString, objCnn)
					If chkData.Rows(0)("totalRecord") = 0 Then
						objDB.sqlExecute("INSERT INTO UserDefineValue (MemberStaffID,MemberOrStaff,UDDID,UDVText) values (" + MemberID.Value.ToString + "," + Request.Form("MemberOrStaff").ToString + "," + IDString + ",'" + FolderID.ToString + "\\" + fi.Name + "')", objCnn)
					Else
						objDB.sqlExecute("UPDATE UserDefineValue SET UDVText='" + FolderID.ToString + "\\" + fi.Name + "',UDVValue=0,OptionID=0,UDVDate=NULL WHERE HistoryGroupID=0 AND MemberOrStaff = " + Request.Form("MemberOrStaff").ToString + " AND MemberStaffID = " + MemberID.Value.ToString + " AND UDDID=" + IDString, objCnn)
					End If
				end if
			  End If
			Next
			
			If ResultStatus = "Success" Then
				If Request.QueryString("from") = "profileonly" Then
					Response.Redirect("member_info_details.aspx")
				Else If Request.QueryString("from") = "profile" Then
					Response.Redirect("member_info_details.aspx?" +  Request.QueryString.ToString)
				Else
					Response.Redirect("member_info.aspx?" + Request.QueryString.ToString)
				End If
			Else
				errorMsg.InnerHtml = ResultStatus'Request.Form("Activated")
			End If
		End If
		
		'Application.UnLock()
	Else
		errorMsg.InnerHtml = "FoundError"
	End If
End Sub


Sub DoCancel(Source As Object, E As EventArgs)
	If Request.QueryString("from") = "profileonly" Then
		Response.Redirect("member_info_details.aspx")
	Else If Request.QueryString("from") = "profile" Then
		Response.Redirect("member_info_details.aspx?" + Request.QueryString.ToString)
	Else
		Response.Redirect("member_info.aspx?" + Request.QueryString.ToString)
	End If
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
