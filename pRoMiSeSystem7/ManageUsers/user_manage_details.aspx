<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<html>
<head>
<title>User Details</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<script language="VB" runat="server">

Dim userInfo As New CStaffs()
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
    Sub Page_Load()
        If User.Identity.IsAuthenticated And (Session("User_ManageUsers") Or Session("User_EditMyProfile")) Then
		
            Try
                objCnn = getCnn.EstablishConnection()

            Catch ex As Exception
                errorMsg.InnerHtml = ex.Message
            End Try
		
            Dim textTable As New DataTable()
            textTable = getPageText.GetText(5, Session("LangID"), objCnn)
		
            Dim defaultTextTable As New DataTable()
            defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
		
            Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
            Dim StaffInfo As DataTable
            Dim dtProperty As DataTable
            Dim bolCanEditAtBranch As Boolean
                        
            If IsNumeric(Request.QueryString("StaffID")) And Session("User_ManageUsers") Then
                'Get Can Edit StaffDetail at Branch 
                dtProperty = getProp.PropertyValue(2, POSTypeClass.POSAdditionalProgramVariable.BACKOFFICE_EDITSTAFFDETAIL_ATBRANCHDB, 1, objCnn)
                bolCanEditAtBranch = False
                If dtProperty.Rows.Count > 0 Then
                    If dtProperty.Rows(0)("PropertyValue") = 1 Then
                        bolCanEditAtBranch = True
                    End If
                End If
                
                StaffInfo = userInfo.GetStaffInfo(Request.QueryString("StaffID"), objCnn)
                If Session("User_ManageUsers_Edit") And ((PropertyInfo.Rows(0)("HeadOrBranch") = 0) Or (bolCanEditAtBranch = True)) Then
                    If (Request.QueryString("StaffID") = 1 And Session("StaffID") = 1) Or (Request.QueryString("StaffID") = 2 And (Session("StaffID") = 1 Or Session("StaffID") = 2)) Or (Request.QueryString("StaffID") > 2) Then
                        EditMyProfileText.InnerHtml = "[<a href=""user_manage_edit.aspx?StaffID=" + Request.QueryString("StaffID").ToString + "&from=profile"">" + textTable.Rows(46)("TextParamValue") + "</a>]"
                    End If
                End If
                If Session("User_ManageUsers_Password") And ((PropertyInfo.Rows(0)("HeadOrBranch") = 0) Or (bolCanEditAtBranch = True)) Then
                    If (Request.QueryString("StaffID") = 1 And Session("StaffID") = 1) Or (Request.QueryString("StaffID") = 2 And (Session("StaffID") = 1 Or Session("StaffID") = 2)) Or (Request.QueryString("StaffID") > 2) Then
                        EditMyPasswordText.InnerHtml = "[<a href=""user_manage_password.aspx?StaffID=" + Request.QueryString("StaffID").ToString + "&from=profile"">" + textTable.Rows(47)("TextParamValue") + "</a>]"
                    End If
                End If
            Else
                StaffInfo = userInfo.GetStaffInfo(Session("StaffID"), objCnn)
                EditMyProfileText.InnerHtml = "[<a href=""user_manage_edit.aspx?StaffID=" + Session("StaffID").ToString + "&from=profileonly"">" + textTable.Rows(46)("TextParamValue") + "</a>]"
                EditMyPasswordText.InnerHtml = "[<a href=""user_manage_password.aspx?StaffID=" + Session("StaffID").ToString + "&from=profileonly"">" + textTable.Rows(47)("TextParamValue") + "</a>]"
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
            headerTD9.BgColor = GlobalParam.AdminBGColor
            headerTD10.BgColor = GlobalParam.AdminBGColor
            headerTD11.BgColor = GlobalParam.AdminBGColor
            headerTD12.BgColor = GlobalParam.AdminBGColor
            headerTD13.BgColor = GlobalParam.AdminBGColor
            headerTD14.BgColor = GlobalParam.AdminBGColor
            headerTD15.BgColor = GlobalParam.AdminBGColor
		
            CodeText.InnerHtml = textTable.Rows(2)("TextParamValue")
            RoleText.InnerHtml = textTable.Rows(22)("TextParamValue")
            NameText.InnerHtml = textTable.Rows(42)("TextParamValue")
            AddressText.InnerHtml = textTable.Rows(43)("TextParamValue")
            EmailText.InnerHtml = textTable.Rows(6)("TextParamValue")
            ProvinceText.InnerHtml = textTable.Rows(10)("TextParamValue")
            ZipText.InnerHtml = textTable.Rows(11)("TextParamValue")
            TelephoneText.InnerHtml = textTable.Rows(12)("TextParamValue")
            MobileText.InnerHtml = textTable.Rows(13)("TextParamValue")
            BirthDayText.InnerHtml = textTable.Rows(14)("TextParamValue")
            AdditionalText.InnerHtml = textTable.Rows(15)("TextParamValue")
            IDNumberText.InnerHtml = textTable.Rows(16)("TextParamValue")
            IDIssueText.InnerHtml = textTable.Rows(17)("TextParamValue")
            IDExpText.InnerHtml = textTable.Rows(18)("TextParamValue")
            BloodGroupText.InnerHtml = textTable.Rows(19)("TextParamValue")
            LastUpdateText.InnerHtml = textTable.Rows(44)("TextParamValue")
            SectionText.InnerHtml = textTable.Rows(45)("TextParamValue")
		
            PrintText.InnerHtml = defaultTextTable.Rows(6)("TextParamValue")
		
            If StaffInfo.Rows.Count > 0 Then
		
                If Not IsDBNull(StaffInfo.Rows(0)("StaffCode")) Then CodeValue.InnerHtml = StaffInfo.Rows(0)("StaffCode")
			
                If Not IsDBNull(StaffInfo.Rows(0)("StaffFirstName")) Then NameValue.InnerHtml = StaffInfo.Rows(0)("StaffFirstName")
			
                If Not IsDBNull(StaffInfo.Rows(0)("StaffLastName")) Then
                    NameValue.InnerHtml += " " + StaffInfo.Rows(0)("StaffLastName")
                End If
			
                If Not IsDBNull(StaffInfo.Rows(0)("StaffAddress1")) Then
                    AddressValue.InnerHtml = StaffInfo.Rows(0)("StaffAddress1") + "<br>"
                End If
			
                If Not IsDBNull(StaffInfo.Rows(0)("StaffAddress2")) Then
                    If Trim(StaffInfo.Rows(0)("StaffAddress2")) <> "" Then
                        AddressValue.InnerHtml += StaffInfo.Rows(0)("StaffAddress2") + " "
                    End If
                End If
                If Not IsDBNull(StaffInfo.Rows(0)("StaffCity")) Then
                    AddressValue.InnerHtml += StaffInfo.Rows(0)("StaffCity")
                End If
			
                If Not IsDBNull(StaffInfo.Rows(0)("StaffZipCode")) Then ZipValue.InnerHtml = StaffInfo.Rows(0)("StaffZipCode")
                If Not IsDBNull(StaffInfo.Rows(0)("StaffTelephone")) Then TelephoneValue.InnerHtml = StaffInfo.Rows(0)("StaffTelephone")
                If Not IsDBNull(StaffInfo.Rows(0)("StaffMobile")) Then MobileValue.InnerHtml = StaffInfo.Rows(0)("StaffMobile")
                If Not IsDBNull(StaffInfo.Rows(0)("StaffEmail")) Then EmailValue.InnerHtml = StaffInfo.Rows(0)("StaffEmail")
                If Not IsDBNull(StaffInfo.Rows(0)("StaffIDNumber")) Then IDNumberValue.InnerHtml = StaffInfo.Rows(0)("StaffIDNumber")
                If Not IsDBNull(StaffInfo.Rows(0)("StaffMobile")) Then MobileValue.InnerHtml = StaffInfo.Rows(0)("StaffMobile")
                If Not IsDBNull(StaffInfo.Rows(0)("StaffBlood")) Then BloodGroupValue.InnerHtml = StaffInfo.Rows(0)("StaffBlood")
                If Not IsDBNull(StaffInfo.Rows(0)("StaffBirthDay")) Then
                    BirthDayValue.InnerHtml = DateTimeUtil.FormatDateTime(StaffInfo.Rows(0)("StaffBirthDay"), "DateOnly")
                End If
                If Not IsDBNull(StaffInfo.Rows(0)("UpdateDate")) Then LastUpdateValue.InnerHtml = DateTimeUtil.FormatDateTime(StaffInfo.Rows(0)("UpdateDate"), "DateAndTime")
                If Not IsDBNull(StaffInfo.Rows(0)("StaffIDIssueDate")) Then IDIssueValue.InnerHtml = DateTimeUtil.FormatDateTime(StaffInfo.Rows(0)("StaffIDIssueDate"), "DateOnly")
                If Not IsDBNull(StaffInfo.Rows(0)("StaffIDExpiration")) Then IDExpValue.InnerHtml = DateTimeUtil.FormatDateTime(StaffInfo.Rows(0)("StaffIDExpiration"), "DateOnly")
                If Not IsDBNull(StaffInfo.Rows(0)("StaffAdditional")) Then AdditionalValue.InnerHtml = StaffInfo.Rows(0)("StaffAdditional")
			
                If Not IsDBNull(StaffInfo.Rows(0)("StaffPictureFileServer")) Then
                    If Trim(StaffInfo.Rows(0)("StaffPictureFileServer")) <> "" Then
                        myImage.Src = "../images/Staffs/" + StaffInfo.Rows(0)("StaffPictureFileServer")
                    Else
                        myImage.Src = "../images/Staffs/no_photo.jpg"
                    End If
                Else
                    myImage.Src = "../images/Staffs/no_photo.jpg"
                End If
			
                If Not IsDBNull(StaffInfo.Rows(0)("StaffRoleID")) Then
                    Dim StaffRoleN As DataTable
                    StaffRoleN = getPageText.GetStaffRoleName(StaffInfo.Rows(0)("StaffRoleID"), objCnn)
				
                    If StaffRoleN.Rows.Count <> 0 Then
                        RoleValue.InnerHtml = StaffRoleN.Rows(0)("StaffRoleName")
                    End If
                End If
			
                If Not IsDBNull(StaffInfo.Rows(0)("StaffProvince")) Then
                    If IsNumeric(StaffInfo.Rows(0)("StaffProvince")) Then
                        Dim StaffProvinceN As DataTable
                        StaffProvinceN = getPageText.GetProvinceName(StaffInfo.Rows(0)("StaffProvince"), Session("LangID"), objCnn)
					
                        If StaffProvinceN.Rows.Count <> 0 Then
                            ProvinceValue.InnerHtml = StaffProvinceN.Rows(0)("ProvinceName")
                        End If
                    End If
                End If
            End If
		
		
            GoBackURL.InnerHtml = "<a href=""user_manage.aspx?" + Request.QueryString.ToString + """>" + defaultTextTable.Rows(51)("TextParamValue") + "</a>"
        Else
            errorMsg.InnerHtml = "Access Denied"
        End If
    End Sub

</script>
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
<table width="100%">
<tr><td>
<table>
	<tr>
		<td class="text"><div id="EditMyProfileText" runat="server"></div></td>
		<td>&nbsp;</td>
		<td class="text"><div id="EditMyPasswordText" runat="server"></div></td>
		<td>&nbsp;</td>
		<td class="text">[<a href="javascript:window.print()"><span id="PrintText" runat="server"></span></a>]</td>
	</tr>
</table></td>
<td align="right"><div id="GoBackURL" runat="server"></div></td>
</tr>
</table>

<table width="100%" border="1" cellspacing="0" cellpadding="5" style="border-collapse:collapse;">
  <tr> 
    <td width="16%" id="headerTD13" class="tdHeader" runat="server"><span id="CodeText" runat="server"></span></td>
    <td><span id="CodeValue" class="text" runat="server"></span></td>
	<td id="headerTD15" class="tdHeader" runat="server"><span id="LastUpdateText" runat="server"></span></td>
    <td><span id="LastUpdateValue" class="text" runat="server"></span></td>
    <td width="10%" align="center" rowspan="5"><img id="myImage" width="120" height="155" runat="server"></td>
  </tr>
  <tr> 
    <td id="headerTD0" class="tdHeader" runat="server"><span id="NameText" runat="server"></span></td>
    <td><span id="NameValue" class="text" runat="server"></span></td>
	<td id="headerTD14" class="tdHeader" runat="server"><span id="RoleText" runat="server"></span></td>
    <td><span id="RoleValue" class="text" runat="server"></span></td>
	
  </tr>
  <tr> 
    <td height="59" id="headerTD1" class="tdHeader" runat="server"><span id="AddressText" runat="server"></span></td>
    <td colspan="3"><span id="AddressValue" class="text" runat="server"></span></td>
  </tr>
  <tr> 
    <td id="headerTD2" class="tdHeader" runat="server"><span id="ProvinceText" runat="server"></span></td>
    <td width="27%"><span id="ProvinceValue" class="text" runat="server"></span></td>
    <td width="13%" id="headerTD3" class="tdHeader" runat="server"><span id="ZipText" runat="server"></span></td>
    <td width="22%"><span id="ZipValue" class="text" runat="server"></span></td>
  </tr>
  <tr> 
    <td id="headerTD4" class="tdHeader" runat="server"><span id="TelephoneText" runat="server"></span></td>
    <td><span id="TelephoneValue" class="text" runat="server"></span></td>
    <td id="headerTD5" class="tdHeader" runat="server"><span id="MobileText" runat="server"></span></td>
    <td><span id="MobileValue" class="text" runat="server"></span></td>
  </tr>
  <tr> 
    <td id="headerTD6" class="tdHeader" runat="server"><span id="EmailText" runat="server"></span></td>
    <td><span id="EmailValue" class="text" runat="server"></span></td>
    <td id="headerTD7" class="tdHeader" runat="server"><span id="BirthDayText" runat="server"></span></td>
    <td><span id="BirthDayValue" class="text" runat="server"></span></td>
    <td><span id="LastUpdated" class="text" runat="server"></span></td>
  </tr>

  <tr> 
    <td id="headerTD8" class="tdHeader" runat="server"><span id="IDNumberText" runat="server"></span></td>
    <td><span id="IDNumberValue" class="text" runat="server"></span></td>
    <td id="headerTD9" class="tdHeader" runat="server"><span id="IDIssueText" runat="server"></span></td>
    <td colspan="2"><span id="IDIssueValue" class="text" runat="server"></span></td>
  </tr>
  <tr> 
    <td id="headerTD10" class="tdHeader" runat="server"><span id="IDExpText" runat="server"></span></td>
    <td><span id="IDExpValue" class="text" runat="server"></span></td>
    <td id="headerTD11" class="tdHeader" runat="server"><span id="BloodGroupText" runat="server"></span></td>
    <td colspan="2"><span id="BloodGroupValue" class="text" runat="server"></span></td>
  </tr>

  <tr> 
    <td id="headerTD12" class="tdHeader" runat="server"><span id="AdditionalText" runat="server"></span></td>
    <td colspan="4"><span id="AdditionalValue" class="text" runat="server"></span></td>
  </tr>

</table>

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
</body>
</html>
