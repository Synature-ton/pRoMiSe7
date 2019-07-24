<%@ Page Language="VB" EnableViewState="True" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace="System.Diagnostics" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<%@ Register tagprefix="synature" Tagname="province" Src="../UserControls/Province.ascx" %>
<%@ Register tagprefix="synature" Tagname="userRole" Src="../UserControls/UserRole.ascx" %>
<%@ Register tagprefix="synature" Tagname="getLang" Src="../UserControls/GetLang.ascx" %>
<html>
<head>
<title>Manage Users</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css">
        .auto-style1 {
            height: 33px;
        }
    </style>
</head>
<body>
<form enctype="multipart/form-data" runat="server">
<input type="hidden" id="StaffID" runat="server" />
<input type="hidden" id="OldStaffCode" runat="server" />
<input type="hidden" id="ProductLevelID" runat="server" />
<div id="StaffShopData" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText"><ASP:Label id="updateMessage" CssClass="headerText" runat="server" /></b>
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

<table>
<div id="userNameForm" runat="server" />
<div id="validateCode" runat="server" />
<tr>
	<td><div class="requireText" id="StaffCodeParam" runat="server"></div></td>
	<td><asp:textbox ID="StaffCode" MaxLength="50" Width="150" runat="server" /></td>
</tr>

<div id="validatePassword" runat="server" />
<tr id="PasswordSection" visible="false" runat="server">
	<td><div class="requireText" id="StaffPasswordText" runat="server"></div></td>
	<td><asp:textbox id="StaffSetPassword" MaxLength="50" Width="150" runat="server" /></td>
</tr>
<div id="validateConfirmPassword" runat="server" />
<tr id="ConfirmPasswordSection" visible="false" runat="server">
	<td><div class="requireText" id="StaffConfirmPasswordText" runat="server"></div></td>
	<td><asp:textbox id="StaffConfirmPassword" MaxLength="50" Width="150" runat="server" /></td>
</tr>

<div id="validateUserShop" runat="server" />
<tr id="ShowStaffShop" visible="True" runat="server">
	<td><div class="requireText" id="StaffShopParam" runat="server"></div></td>
	<td><span id="ShopText" runat="server"></span></td>
</tr>

<div id="validateUserRole" runat="server" />
<tr>
	<td><div class="requireText" id="StaffRoleParam" runat="server"></div></td>
	<td><synature:userRole id="GetUserRole" runat="server" /></td>
</tr>

<div id="validateUserLang" runat="server" />
<tr>
	<td><div class="requireText" id="StaffLangParam" runat="server"></div></td>
	<td><synature:getLang id="GetUserLang" runat="server" /></td>
</tr>

<div id="validateGender" runat="server" />
<tr>
	<td><div class="requireText" id="StaffGenderParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="StaffGenderMale" name="StaffGender" value="1" runat="server" /><span id="MaleText" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="StaffGenderFemale" name="StaffGender" value="2" runat="server" /><span id="FemaleText" runat="server"></span></td>
</tr>

<div id="validateFirstName" runat="server" />
<tr>
	<td><div class="requireText" id="StaffFirstNameParam" runat="server"></div></td>
	<td><asp:textbox ID="StaffFirstName" MaxLength="50" Width="300" runat="server" /></td>
</tr>
<div id="validateLastName" runat="server" />
<tr>
	<td><div class="requireText" id="StaffLastNameParam" runat="server"></div></td>
	<td><asp:textbox ID="StaffLastName" MaxLength="50" Width="300" runat="server" /></td>
</tr>

<span id="StaffExtData" visible="false" runat="server">
<tr>
	<td class="text">Company</td>
	<td><asp:DropDownList ID="AccountID" CssClass="text" Width="200" runat="server"></asp:DropDownList></td>
</tr>
</span>
<tr>
	<td><div class="text" id="StaffAddress1Param" runat="server"></div></td>
	<td><asp:textbox ID="StaffAddress1" MaxLength="255" Width="300" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="StaffAddress2Param" runat="server"></div></td>
	<td><asp:textbox ID="StaffAddress2" MaxLength="255" Width="300" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="StaffCityParam" runat="server"></div></td>
	<td><asp:textbox ID="StaffCity" MaxLength="100" Width="300" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="StaffProvinceParam" runat="server"></div></td>
	<td><synature:province id="GetProvince" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="StaffZipCodeParam" runat="server"></div></td>
	<td><asp:textbox ID="StaffZipCode" MaxLength="20" Width="150" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="StaffTelephoneParam" runat="server"></div></td>
	<td><asp:textbox ID="StaffTelephone" MaxLength="20" Width="150" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="StaffMobileParam" runat="server"></div></td>
	<td><asp:textbox ID="StaffMobile" MaxLength="20" Width="150" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="StaffEmailParam" runat="server"></div></td>
	<td><asp:textbox ID="StaffEmail" MaxLength="100" Width="300" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="StaffIDNumberParam" runat="server"></div></td>
	<td><asp:textbox ID="StaffIDNumber" MaxLength="50" Width="300" runat="server" /></td>
</tr>
<div id="validateIssueDate" runat="server" />
<tr>
	<td><div class="text" id="StaffIDIssueDateParam" runat="server"></div></td>
	<td><synature:date id="IDIssueDate" runat="server" /></td>
</tr>
<div id="validateExpireDate" runat="server" />
<tr>
	<td><div class="text" id="StaffIDExpireDateParam" runat="server"></div></td>
	<td><synature:date id="IDExpireDate" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="StaffBloodParam" runat="server"></div></td>
	<td><asp:textbox ID="StaffBlood" MaxLength="5" Width="150" runat="server" /></td>
</tr>
<div id="ShowSalary" visible="True" runat="server">
<div id="validateSalary" runat="server" />
<tr>
	<td><div class="text" id="SalaryParam" runat="server"></div></td>
	<td><asp:textbox ID="BasedSalary" MaxLength="5" Width="150" runat="server" /></td>
</tr>
<div id="validateMinPerDay" runat="server" />
<tr id="showMinPerDay" visible="false" runat="server">
	<td><div class="text" id="MinPerDayParam" runat="server"></div></td>
	<td class="text"><asp:textbox ID="MinPerDay" Width="70" Text="0" runat="server" /> <span id="MinPerDayUnit" class="text" runat="server" /></td>
</tr>
</div>
<div id="validateBirthDayDate" runat="server" />
<tr>
	<td><div class="text" id="StaffBirthDayParam" runat="server"></div></td>
	<td><synature:date id="BirthDay" runat="server" /></td>
</tr>
<div id="validateUploadFile" runat="server" />
<tr>
	<td><div class="text" id="StaffPictureParam" runat="server"></div></td>
	<td><input id="StaffPicture" type="file" accept="image/*" style="width:300px" runat="server" /><asp:CheckBox ID="RemoveImage" Text="Remove Picture" CssClass="text" Visible="false" runat="server"></asp:CheckBox></td>
</tr>
<tr>
	<td valign="top"><div class="text" id="StaffAdditionalParam" runat="server"></div></td>
	<td><asp:textbox ID="StaffAdditional" TextMode="MultiLine" Columns="50" Rows="5" Width="300" runat="server" /></td>
</tr>

<tr id="ActivateSection" visible="false" runat="server">
	<td><div class="text" id="UserActivateText" runat="server"></div></td>
	<td class="text"><input type="radio" id="StaffEnable" name="Activated" value="1" runat="server" /><span id="YesText" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="StaffDisable" name="Activated" value="0" runat="server" /><span id="NoText" runat="server"></span></td>
</tr>

<div id="validateItem" runat="server" />
<div id="htmlResult" runat="server" />
<tr>
	<td class="auto-style1"></td>
	<td class="auto-style1"><asp:button ID="SubmitForm" OnClick="DoAddUpdate" runat="server" />&nbsp;<asp:button ID="CancelButton" OnClick="DoCancel" runat="server" /></td>
</tr>
</table>
</form>


<div id="errorMsg" runat="server" />
<!--<hr><div id="showTracking" runat="server" />
<hr>-->
<div id="stext" runat="server"></div>
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

Dim userInfo As New CStaffs()
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim DateTimeUtil As New MyDateTime()
Dim getInfo As New CPreferences()
Dim getProp As New CPreferences()
Dim getData As New CCategory()
Dim objDB As New CDBUtil()

Sub Page_Load()
	If User.Identity.IsAuthenticated AND (Session("User_ManageUsers") Or Session("User_EditMyProfile")) Then
		If Session("User_ManageUsers_Activation") Then 
			If Request.QueryString("StaffID") <> 1 AND Request.QueryString("StaffID") <> 2 Then
				ActivateSection.Visible = True
			End If
		End If
		
		Try
			objCnn = getCnn.EstablishConnection()

		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
		
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
		Dim permissionItemList As String = ""
		
		Dim textTable As New DataTable()
		textTable = getPageText.GetText(5,Session("LangID"),objCnn)
		
		Dim defaultTextTable As New DataTable()
		defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
		
		Dim propData As DataTable
        propData = getInfo.PropertyInfo(1, objCnn)
		
		If propData.Rows(0)("SystemEditionID") = 1 Then
			ShowStaffShop.Visible = False
			ShowSalary.Visible = False
			Dim StaffShopID As Integer = 2
			Dim getStaffShop As DataTable = getData.GetProductLevel(-999,objCnn)
			If getStaffShop.Rows.Count > 0 Then
				StaffShopID = getStaffShop.Rows(0)("ProductLevelID")
			End If
			StaffShopData.InnerHtml = "<input type=""hidden"" name=""ShopID"" value=""" + StaffShopID.ToString + """>"
		Else
			StaffShopData.InnerHtml = ""
		End If
		
		ShowStaffShop.Visible = False
		
		Dim Exist As Boolean = getProp.CheckTableExist("StaffExtData", objCnn)
		
		StaffExtData.Visible = Exist
		
		Dim MultiBranch As Boolean = False
		If propData.Rows.Count > 0 Then
			If propData.Rows(0)("MultiBranch") = 1 Then
				MultiBranch = True
			End If
		End If
		
		If MultiBranch = False AND propData.Rows(0)("HeadOrBranch") = 0 Then
			ProductLevelID.Value = 0
		Else			
		  Dim ChkShop As DataTable = objDB.List("select * from ProductLevel where Deleted=0 AND IsShop=1 AND MasterShop>0 order by ProductLevelID", objCnn)		  
		  If ChkShop.Rows.Count > 0 Then
		  		ProductLevelID.Value = 0
		  Else
		  		ChkShop = objDB.List("select * from ProductLevel where Deleted=0 AND IsShop=1 AND MasterShop=0 order by ProductLevelID", objCnn)
				If ChkShop.Rows.Count > 0 Then
					ProductLevelID.Value = ChkShop.Rows(0)("ProductLevelID")
				Else
					ProductLevelID.Value = 0
				End If
		  End If
		End If
		
		StaffCodeParam.InnerHtml = textTable.Rows(2)("TextParamValue") 		
		StaffRoleParam.InnerHtml = textTable.Rows(22)("TextParamValue")
		StaffFirstNameParam.InnerHtml = textTable.Rows(4)("TextParamValue")
		StaffLastNameParam.InnerHtml = textTable.Rows(5)("TextParamValue")
		StaffGenderParam.InnerHtml = textTable.Rows(3)("TextParamValue")
		MaleText.InnerHtml = textTable.Rows(23)("TextParamValue")
		FemaleText.InnerHtml = textTable.Rows(24)("TextParamValue")
		StaffEmailParam.InnerHtml = textTable.Rows(6)("TextParamValue")
		StaffAddress1Param.InnerHtml = textTable.Rows(7)("TextParamValue")
		StaffAddress2Param.InnerHtml = textTable.Rows(8)("TextParamValue")
		StaffCityParam.InnerHtml = textTable.Rows(9)("TextParamValue")
		StaffProvinceParam.InnerHtml = textTable.Rows(10)("TextParamValue")
		StaffZipCodeParam.InnerHtml = textTable.Rows(11)("TextParamValue")
		StaffTelephoneParam.InnerHtml = textTable.Rows(12)("TextParamValue")
		StaffMobileParam.InnerHtml = textTable.Rows(13)("TextParamValue")
		StaffBirthDayParam.InnerHtml = textTable.Rows(14)("TextParamValue")
		StaffAdditionalParam.InnerHtml = textTable.Rows(15)("TextParamValue")
		StaffIDNumberParam.InnerHtml = textTable.Rows(16)("TextParamValue")
		StaffIDIssueDateParam.InnerHtml = textTable.Rows(17)("TextParamValue")
		StaffIDExpireDateParam.InnerHtml = textTable.Rows(18)("TextParamValue")
		StaffBloodParam.InnerHtml = textTable.Rows(19)("TextParamValue")
		StaffPictureParam.InnerHtml = textTable.Rows(30)("TextParamValue")
		StaffLangParam.InnerHtml = textTable.Rows(32)("TextParamValue")
		UserActivateText.InnerHtml = textTable.Rows(34)("TextParamValue")
		StaffPasswordText.InnerHtml = textTable.Rows(38)("TextParamValue")
		StaffConfirmPasswordText.InnerHtml = textTable.Rows(39)("TextParamValue")
		SalaryParam.InnerHtml = textTable.Rows(48)("TextParamValue")
		StaffShopParam.InnerHtml = "Staff Shop"
		
		CancelButton.Text = defaultTextTable.Rows(2)("TextParamValue")
		YesText.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
		NoText.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
		
		MinPerDayParam.InnerHtml = textTable.Rows(50)("TextParamValue")
		MinPerDayUnit.InnerHtml = textTable.Rows(51)("TextParamValue")
		
		'Set Form name for province
		GetProvince.FormName = "StaffProvince"
		GetProvince.LangID = Session("LangID")
		
		GetUserLang.FormName = "LangID"
		GetUserLang.LangID = Session("LangID")
		
		GetUserRole.FormName = "StaffRoleID"
		GetUserRole.LangID = Session("LangID")
		GetUserRole.StaffRoleID = Session("StaffRole")
		
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
		IDExpireDate.StartYear = 3
		IDExpireDate.EndYear = 10
		
		Dim ShopIDValue As Integer = 0
		Dim StaffShopInfo As DataTable
		Dim i As Integer
		If NOT Request.QueryString("StaffID") AND IsNumeric(Request.QueryString("StaffID")) Then
			
			updateMessage.Text = textTable.Rows(0)("TextParamValue")
			SubmitForm.Text = textTable.Rows(21)("TextParamValue")
			StaffID.Value = Request.QueryString("StaffID")
			
			IF Not Page.IsPostBack Then
				
				'Try
					If Exist = True Then
						Dim AccountData As DataTable = objDB.List("select 0 As AccountID,'--- Please Select ---' As AccountName,0 As Ordering UNION select AccountID,AccountName,Ordering from AccountData where Deleted=0 order by Ordering", objCnn)
						AccountID.DataSource = AccountData
						AccountID.DataValueField = "AccountID"
						AccountID.DataTextField = "AccountName"
						AccountID.DataBind()
						
						Dim getStaffCompany As DataTable = objDB.List("select * from StaffExtData where StaffID=" + StaffID.Value.ToString, objCnn)
						Dim j As Integer
						If getStaffCompany.Rows.Count > 0 Then
							For j = 0 to AccountData.Rows.Count - 1
								If getStaffCompany.Rows(0)("AccountID") = AccountData.Rows(j)("AccountID") Then
									AccountID.Items(j).Selected = True
								End If
							Next
						End If
					End If
					Dim StaffInfo As DataTable
        			StaffInfo = userInfo.GetStaffInfo(Request.QueryString("StaffID"), objCnn)
					
					
					For i = 0 To StaffInfo.Rows.Count - 1
						BasedSalary.Text = StaffInfo.Rows(i)("BasedSalary").ToString
						If IsDBNull(StaffInfo.Rows(i)("StaffCode")) Then
							StaffCode.Text = ""
						Else
							StaffCode.Text = StaffInfo.Rows(i)("StaffCode")
						End If
						If Not IsDBNull(StaffInfo.Rows(i)("StaffRoleID")) Then
							GetUserRole.SelectedUserRole = StaffInfo.Rows(i)("StaffRoleID")
						End If
						If Not IsDBNull(StaffInfo.Rows(i)("LangID")) Then
							GetUserLang.SelectedLang = StaffInfo.Rows(i)("LangID")
						End If
						If IsDBNull(StaffInfo.Rows(i)("StaffFirstName")) Then
							StaffFirstName.Text = ""
						Else
							StaffFirstName.Text = StaffInfo.Rows(i)("StaffFirstName")
						End If
						If IsDBNull(StaffInfo.Rows(i)("StaffLastName")) Then
							StaffLastName.Text = ""
						Else
							StaffLastName.Text = StaffInfo.Rows(i)("StaffLastName")
						End If
						If IsDBNull(StaffInfo.Rows(i)("StaffAddress1")) Then
							StaffAddress1.Text = ""
						Else
							StaffAddress1.Text = StaffInfo.Rows(i)("StaffAddress1")
						End If
						If IsDBNull(StaffInfo.Rows(i)("StaffAddress2")) Then
							StaffAddress2.Text = ""
						Else
							StaffAddress2.Text = StaffInfo.Rows(i)("StaffAddress2")
						End If
						If IsDBNull(StaffInfo.Rows(i)("StaffCity")) Then
							StaffCity.Text = ""
						Else
							StaffCity.Text = StaffInfo.Rows(i)("StaffCity")
						End If
						If IsDBNull(StaffInfo.Rows(i)("StaffZipCode")) Then
							StaffZipCode.Text = ""
						Else
							StaffZipCode.Text = StaffInfo.Rows(i)("StaffZipCode")
						End If
						If IsDBNull(StaffInfo.Rows(i)("StaffTelephone")) Then
							StaffTelephone.Text = ""
						Else
							StaffTelephone.Text = StaffInfo.Rows(i)("StaffTelephone")
						End If
						If IsDBNull(StaffInfo.Rows(i)("StaffMobile")) Then
							StaffMobile.Text = ""
						Else
							StaffMobile.Text = StaffInfo.Rows(i)("StaffMobile")
						End If
						If IsDBNull(StaffInfo.Rows(i)("StaffEmail")) Then
							StaffEmail.Text = ""
						Else
							StaffEmail.Text = StaffInfo.Rows(i)("StaffEmail")
						End If
						If IsDBNull(StaffInfo.Rows(i)("StaffAdditional")) Then
							StaffAdditional.Text = ""
						Else
							StaffAdditional.Text = StaffInfo.Rows(i)("StaffAdditional")
						End If
						If Not IsDBNull(StaffInfo.Rows(i)("StaffProvince")) Then
							GetProvince.SelectedProvince = StaffInfo.Rows(i)("StaffProvince")
						End If
						If IsDate(StaffInfo.Rows(i)("StaffBirthDay")) Then
							BirthDay.SelectedDay = StaffInfo.Rows(i)("StaffBirthDay").Day
							BirthDay.SelectedMonth = StaffInfo.Rows(i)("StaffBirthDay").Month
							BirthDay.SelectedYear = StaffInfo.Rows(i)("StaffBirthDay").Year
						End If
						If IsDBNull(StaffInfo.Rows(i)("StaffIDNumber")) Then
							StaffIDNumber.Text = ""
						Else
							StaffIDNumber.Text = StaffInfo.Rows(i)("StaffIDNumber")
						End If
						If IsDBNull(StaffInfo.Rows(i)("StaffBlood")) Then
							StaffBlood.Text = ""
						Else
							StaffBlood.Text = StaffInfo.Rows(i)("StaffBlood")
						End If
						If IsDate(StaffInfo.Rows(i)("StaffIDIssueDate")) Then
							IDIssueDate.SelectedDay = StaffInfo.Rows(i)("StaffIDIssueDate").Day
							IDIssueDate.SelectedMonth = StaffInfo.Rows(i)("StaffIDIssueDate").Month
							IDIssueDate.SelectedYear = StaffInfo.Rows(i)("StaffIDIssueDate").Year
						End If
						If IsDate(StaffInfo.Rows(i)("StaffIDExpiration")) Then
							IDExpireDate.SelectedDay = StaffInfo.Rows(i)("StaffIDExpiration").Day
							IDExpireDate.SelectedMonth = StaffInfo.Rows(i)("StaffIDExpiration").Month
							IDExpireDate.SelectedYear = StaffInfo.Rows(i)("StaffIDExpiration").Year
						End If
						If Not IsDBNull(StaffInfo.Rows(i)("StaffGender")) Then
							If StaffInfo.Rows(i)("StaffGender") = 1 Then
								StaffGenderMale.Checked = True
							Else If StaffInfo.Rows(i)("StaffGender") = 2 Then
								StaffGenderFemale.Checked = True
							End If
						End If
						If Not IsDBNull(StaffInfo.Rows(i)("Activated")) Then
							If StaffInfo.Rows(i)("Activated") = True Or StaffInfo.Rows(i)("Activated") = 1 Then
								StaffEnable.Checked = True
							Else
								StaffDisable.Checked = True
							End If
						Else
							StaffDisable.Checked = True
						End If
						
						MinPerDay.Text = StaffInfo.Rows(i)("MinPerDay")
						
						OldStaffCode.Value = StaffInfo.Rows(i)("StaffCode")
						
						StaffShopInfo = userInfo.StaffShopData(StaffInfo.Rows(i)("StaffID"),0,objCnn)
						If StaffShopInfo.Rows.Count > 0 Then
							ShopIDValue = StaffShopInfo.Rows(0)("ProductLevelID")
						End If
						
						If Not IsDBNull(StaffInfo.Rows(i)("StaffPictureFileServer")) Then
							RemoveImage.Visible = True
						End If
					Next
						
				'Catch ex As Exception
					'errorMsg.InnerHtml = ex.Message
				'End Try
				
			End If

		Else
			updateMessage.Text = textTable.Rows(1)("TextParamValue")
			SubmitForm.Text = textTable.Rows(20)("TextParamValue")
			StaffID.Value = 0
			OldStaffCode.Value = ""
			If Not Page.IsPostBack Then 
				StaffEnable.Checked = True
				BasedSalary.Text = "0"
				MinPerDay.Text = "0"
			End If
			If Session("User_ManageUsers_Password") Then 
				PasswordSection.Visible = True
				ConfirmPasswordSection.Visible = True
				StaffSetPassword.TextMode = TextBoxMode.Password
				StaffConfirmPassword.TextMode = TextBoxMode.Password
			End If
		End If
		
		If NOT Session("User_ManageUsers_Add") AND StaffID.Value = 0 Then Response.Redirect("../Admin_Messages.aspx")
		Dim ChkEditMyProfile As Boolean = False
		If Session("User_EditMyProfile") AND Session("StaffID") = StaffID.Value Then
			ChkEditMyProfile = True
		End If
		If ChkEditMyProfile = False Then
			If NOT Session("User_ManageUsers_Edit") AND StaffID.Value <> 0 Then Response.Redirect("../Admin_Messages.aspx")
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
		
		If IsNumeric(Request.Form("StaffProvince")) Then 
			GetProvince.SelectedProvince = Request.Form("StaffProvince")
		End If
		If IsNumeric(Request.Form("StaffRoleID")) Then 
			GetUserRole.SelectedUserRole = Request.Form("StaffRoleID")
		End If
		If IsNumeric(Request.Form("LangID")) Then 
			GetUserLang.SelectedLang = Request.Form("LangID")
		End If
		
		Dim ShopIDVal As Integer
		
		If IsNumeric(Request.Form("ShopID")) Then
			ShopIDVal = Request.Form("ShopID")
		ElseIf IsNumeric(ShopIDValue) Then
			ShopIDVal = ShopIDValue
		End If
		Dim outputString As String = ""
		Dim FormSelected As String
		Dim ShopData As DataTable = getData.GetProductLevel(-999,objCnn)
		If ShopData.Rows.Count > 0 Then
			outputString = "<select name=""ShopID""><option value=""0"">" & "-- Select Staff Shop --"

			For i = 0 to ShopData.Rows.Count - 1
				If ShopIDVal = ShopData.Rows(i)("ProductLevelID") Then
					FormSelected = "selected"
				ElseIf Not Page.IsPostBack AND i=1 AND ShopData.Rows.Count = 1 Then
					FormSelected = "selected"
				Else
					FormSelected = ""
				End If
				outputString += "<option value=""" & ShopData.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & ShopData.Rows(i)("ProductLevelName")
			Next
			outputString += "</select>"
			ShopText.InnerHtml = outputString

		End If
	Else
		updateMessage.Text = "Access Denied"
	End If
End Sub

    Sub DoAddUpdate(Source As Object, E As EventArgs)
        validateCode.InnerHtml = ""
        validateItem.InnerHtml = ""
        validateSalary.InnerHtml = ""
        validateUserShop.InnerHtml = ""
	
        Dim textTable As New DataTable()
        textTable = getPageText.GetText(5, Session("LangID"), objCnn)
	
        Dim ChkStaffCode As DataTable
        ChkStaffCode = getCnn.List("select count(*) AS totalRecords from Staffs where Deleted=0 AND StaffCode='" + StaffCode.Text + "'", objCnn)
	
        Dim FoundError As Boolean = False
        If Len(Trim(StaffCode.Text)) = 0 Then
            validateCode.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(25)("TextParamValue") & "</td></tr>"
            FoundError = True
        ElseIf ChkStaffCode.Rows(0)("totalRecords") <> 0 And (StaffID.Value = 0 Or (StaffID.Value <> 0 And String.Compare(UCase(OldStaffCode.Value), UCase(StaffCode.Text)) <> 0)) Then
            validateCode.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(36)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If

        If Session("User_ManageUsers_Password") And StaffID.Value = 0 Then
            If Trim(Request.Form("StaffSetPassword")) = "" Then
                validatePassword.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(40)("TextParamValue") & "</td></tr>"
                FoundError = True
            End If
            If String.Compare(UCase(Request.Form("StaffSetPassword")), UCase(Request.Form("StaffConfirmPassword"))) <> 0 Then
                validateConfirmPassword.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(41)("TextParamValue") & "</td></tr>"
                FoundError = True
            End If
            Dim strHash As String
            strHash = FormsAuthentication.HashPasswordForStoringInConfigFile(Request.Form("StaffSetPassword"), "SHA1")
            Dim ChkPassword As DataTable = getCnn.List("select count(*) AS totalRecords from Staffs where Deleted=0 AND StaffPassword='" + strHash + "'", objCnn)
            If ChkPassword.Rows(0)("totalRecords") <> 0 Then
                validatePassword.InnerHtml = "<tr><td></td><td class=""errorText"">" & "This password is already taken. Please choose another password." & "</td></tr>"
                FoundError = True
            End If
        End If
	
        If Not IsNumeric(Request.Form("StaffRoleID")) Or Request.Form("StaffRoleID") = 0 Then
            validateUserRole.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(26)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If StaffGenderMale.Checked = False And StaffGenderFemale.Checked = False Then
            validateGender.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(27)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If Len(Trim(StaffFirstName.Text)) = 0 Then
            validateFirstName.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(28)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If Len(Trim(StaffLastName.Text)) = 0 Then
            validateLastName.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(29)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
	
        Dim FileTransfer As Boolean = True
        Try
            If StaffPicture.PostedFile.ContentType.IndexOf("image/") = -1 And Trim(StaffPicture.PostedFile.FileName) <> "" Then
                validateUploadFile.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(31)("TextParamValue") & "</td></tr>"
                FoundError = True
            End If
        Catch ex As Exception
            FileTransfer = False
        End Try
	
        If Not IsNumeric(Request.Form("LangID")) Or Request.Form("LangID") = 0 Then
            validateUserLang.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(33)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
	
        'If Not IsNumeric(Request.Form("ShopID")) OR Request.Form("ShopID") = 0 Then
        'validateUserShop.InnerHtml = "<tr><td></td><td class=""errorText"">" & "Please select staff shop before submission" & "</td></tr>"
        'FoundError = True
        'End If

        Dim StaffBirthDay, StaffIDIssueDate, StaffIDExpireDate As String
	
        StaffBirthDay = DateTimeUtil.FormatDate(Request.Form("BirthDayFormName_Day"), Request.Form("BirthDayFormName_Month"), Request.Form("BirthDayFormName_Year"))
	
        'If Not IsDate(StaffBirthDay) AND Trim(StaffBirthDay) <> "" Then
        If Trim(StaffBirthDay) = "InvalidDate" Then
            validateBirthDayDate.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(35)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
	
        StaffIDIssueDate = DateTimeUtil.FormatDate(Request.Form("IDIssueDateFormName_Day"), Request.Form("IDIssueDateFormName_Month"), Request.Form("IDIssueDateFormName_Year"))
	
        'If Not IsDate(StaffIDIssueDate) AND Trim(StaffIDIssueDate) <> "" Then
        If Trim(StaffIDIssueDate) = "InvalidDate" Then
            validateIssueDate.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(35)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
	
        StaffIDExpireDate = DateTimeUtil.FormatDate(Request.Form("IDExpireDateFormName_Day"), Request.Form("IDExpireDateFormName_Month"), Request.Form("IDExpireDateFormName_Year"))
	
        'If Not IsDate(StaffIDExpireDate) AND Trim(StaffIDExpireDate) <> "" Then
        If Trim(StaffIDExpireDate) = "InvalidDate" Then
            validateExpireDate.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(35)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
	
        If ShowSalary.Visible = True Then
            If Not IsNumeric(BasedSalary.Text) Then
                validateSalary.InnerHtml = "<tr><td></td><td class=""errorText"">" + textTable.Rows(49)("TextParamValue") + "</td></tr>"
                FoundError = True
            ElseIf CInt(BasedSalary.Text) < 0 Then
                validateSalary.InnerHtml = "<tr><td></td><td class=""errorText"">" + textTable.Rows(49)("TextParamValue") + "</td></tr>"
                FoundError = True
            End If
	  
            If Not IsNumeric(MinPerDay.Text) Then
                validateMinPerDay.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(52)("TextParamValue") & "</td></tr>"
                FoundError = True
            ElseIf MinPerDay.Text < 0 Then
                validateMinPerDay.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(52)("TextParamValue") & "</td></tr>"
                FoundError = True
            End If
        End If
        If FoundError = False Then
            Dim ExtraSQL(1) As String
            Dim DownloadDir, StaffPictureFileServer, StaffPictureFileClient As String
            Dim DownloadPath As String
            DownloadDir = Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED")).Replace("ManageUsers", "images\Staffs")
		
            Try
                If Trim(StaffPicture.PostedFile.FileName) <> "" Then
                    Dim DownloadCompleted As Boolean = False
                    Dim ServerFile As String
                    ServerFile = Path.GetFileName(StaffPicture.PostedFile.FileName)
			
                    DownloadPath = DownloadDir + "\" + ServerFile
                    StaffPicture.PostedFile.SaveAs(DownloadPath)
                    StaffPictureFileServer = ServerFile
                    StaffPictureFileClient = Path.GetFileName(StaffPicture.PostedFile.FileName)

                Else
                    StaffPictureFileServer = ""
                    StaffPictureFileClient = ""
                End If
            Catch ex As Exception
                StaffPictureFileServer = ""
                StaffPictureFileClient = ""
            End Try
		
            Dim TimeNow, ResultStatus As String
            TimeNow = DateTimeUtil.CurrentDateTime

            ExtraSQL(0) = ""
            ExtraSQL(1) = ""
            If StaffID.Value = 0 Then
                stext.InnerHtml = "Add Success"
			
                ExtraSQL(0) = "StaffBirthDay,StaffIDIssueDate,StaffIDExpiration,StaffPictureFileServer,StaffPictureFileClient,InputBy,InputDate,UpdateDate,UpdateBy"
			
                If Trim(StaffBirthDay) = "" Then
                    ExtraSQL(1) += "NULL"
                Else
                    ExtraSQL(1) += StaffBirthDay
                End If
                If Trim(StaffIDIssueDate) = "" Then
                    ExtraSQL(1) += ",NULL"
                Else
                    ExtraSQL(1) += "," + StaffIDIssueDate
                End If
                If Trim(StaffIDExpireDate) = "" Then
                    ExtraSQL(1) += ",NULL"
                Else
                    ExtraSQL(1) += "," + StaffIDExpireDate
                End If
                If Trim(StaffPictureFileServer) = "" Then
                    ExtraSQL(1) += ",NULL"
                Else
                    ExtraSQL(1) += ",'" + StaffPictureFileServer.Replace("'", "''") + "'"
                End If
                If Trim(StaffPictureFileClient) = "" Then
                    ExtraSQL(1) += ",NULL"
                Else
                    ExtraSQL(1) += ",'" + StaffPictureFileClient.Replace("'", "''") + "'"
                End If
			
                ExtraSQL(1) += "," & Session("StaffID").ToString() & "," & TimeNow & "," & TimeNow & "," + Session("StaffID").ToString()
			
                If Trim(Request.Form("StaffSetPassword")) <> "" Then
                    Dim strHash As String
                    strHash = FormsAuthentication.HashPasswordForStoringInConfigFile(Request.Form("StaffSetPassword"), "SHA1")
                    ExtraSQL(0) += ",StaffPassword"
                    ExtraSQL(1) += ",'" + strHash + "'"
                End If
                Application.Lock()
			
                ResultStatus = userInfo.AddUpdateStaff(Request, ExtraSQL, objCnn)
                Application.UnLock()
                If ResultStatus = "Success" Then
                    'userInfo.StaffShopUpdate(StaffID.Value,Request.Form("ShopID"),objCnn)
                    'sText.InnerHtml = "Add Success"
                    Response.Redirect("user_manage.aspx?" + Request.QueryString.ToString)
                    'query.InnerHtml = ResultStatus
                Else
                    stext.InnerHtml = "Error : " & ResultStatus
                End If
            Else
                If Trim(StaffBirthDay) = "" Then
                    ExtraSQL(0) += "StaffBirthDay=NULL"
                Else
                    ExtraSQL(0) += "StaffBirthDay=" + StaffBirthDay
                End If
                If Trim(StaffIDIssueDate) = "" Then
                    ExtraSQL(0) += ",StaffIDIssueDate=NULL"
                Else
                    ExtraSQL(0) += ",StaffIDIssueDate=" + StaffIDIssueDate
                End If
                If Trim(StaffIDExpireDate) = "" Then
                    ExtraSQL(0) += ",StaffIDExpiration=NULL"
                Else
                    ExtraSQL(0) += ",StaffIDExpiration=" + StaffIDExpireDate
                End If
                If RemoveImage.Visible = True Then
                    If RemoveImage.Checked = True Then
                        ExtraSQL(0) += ",StaffPictureFileServer=NULL"
                        ExtraSQL(0) += ",StaffPictureFileClient=NULL"
                    Else
                        If Trim(StaffPictureFileServer) <> "" Then
                            ExtraSQL(0) += ",StaffPictureFileServer='" + StaffPictureFileServer.Replace("'", "''") + "'"
                        End If
                        If Trim(StaffPictureFileClient) <> "" Then
                            ExtraSQL(0) += ",StaffPictureFileClient='" + StaffPictureFileClient.Replace("'", "''") + "'"
                        End If
                    End If
                Else
                    If Trim(StaffPictureFileServer) <> "" Then
                        ExtraSQL(0) += ",StaffPictureFileServer='" + StaffPictureFileServer.Replace("'", "''") + "'"
                    End If
                    If Trim(StaffPictureFileClient) <> "" Then
                        ExtraSQL(0) += ",StaffPictureFileClient='" + StaffPictureFileClient.Replace("'", "''") + "'"
                    End If
                End If
			
                ExtraSQL(0) += ",UpdateDate=" + TimeNow + ",UpdateBy=" + Session("StaffID").ToString()
			
                Dim Exist As Boolean = getProp.CheckTableExist("StaffExtData", objCnn)
                Application.Lock()
                ResultStatus = userInfo.AddUpdateStaff(Request, ExtraSQL, objCnn)
                'userInfo.StaffShopUpdate(StaffID.Value,Request.Form("ShopID"),objCnn)
                Dim StaffIDValue As Integer = StaffID.Value
                'If StaffID.Value = 0 Then
                ' Dim getMax As DataTable = objDB.List("select MAX(StaffID) as MaxID from staffs", objCnn)
                'StaffIDValue = getMax.Rows(0)("MaxID")
                'End If
                'If Exist = True Then
                'If  AccountID.SelectedItem.Value > 0 Then
                'Dim ChkExt As DataTable = objDB.List("select * from StaffExtData where StaffID=" + StaffIDValue.ToString, objCnn)
                'If ChkExt.Rows.Count = 0 Then
                'objDB.sqlExecute("insert into StaffExtData (StaffID,AccountID) values (" + StaffIDValue.ToString + "," + AccountID.SelectedItem.Value.ToString + ")", objCnn)
                'Else
                'objDB.sqlExecute("update StaffExtData set AccountID=" +  AccountID.SelectedItem.Value.ToString + " where StaffID=" + StaffIDValue.ToString, objCnn)
                'End If
                'End If
                'End If
                Application.UnLock()
                If ResultStatus = "Success" Then
				
                    'sText.InnerHtml = "Update Success"
                    If Request.QueryString("from") = "profileonly" Then
                        Response.Redirect("user_manage_details.aspx")
                    ElseIf Request.QueryString("from") = "profile" Then
                        Response.Redirect("user_manage_details.aspx?" + Request.QueryString.ToString)
                    Else
                        Response.Redirect("user_manage.aspx?" + Request.QueryString.ToString)
                    End If
                    'query.InnerHtml = ResultStatus
                Else
                    stext.InnerHtml = "Error : " & vbLf & ResultStatus
                    errorMsg.InnerHtml = "Error : ?? : " & Request.Form("Activated")
                End If
            End If
				
            'FileName.InnerHtml = Path.GetFileName(StaffPicture.PostedFile.FileName)
            'MyContentType.InnerHtml = StaffPicture.PostedFile.ContentType
            'ContentLength.InnerHtml = StaffPicture.PostedFile.ContentLength.ToString()
            'CurrentDir.InnerHtml = QueryString 'Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED"))
            'FileDetails.Visible = true
        End If
    End Sub


Sub DoCancel(Source As Object, E As EventArgs)
	If Request.QueryString("from") = "profileonly" Then
		Response.Redirect("user_manage_details.aspx")
	Else If Request.QueryString("from") = "profile" Then
		Response.Redirect("user_manage_details.aspx?" + Request.QueryString.ToString)
	Else
		Response.Redirect("user_manage.aspx?" + Request.QueryString.ToString)
	End If
End Sub


Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
