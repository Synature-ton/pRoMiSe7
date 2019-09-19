<%@ page language="VB" autoeventwireup="false" inherits="Preferences_MemberSetFrontExpiration_Edit, App_Web_membersetfrontexpiration_edit.aspx.475a53d1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Member Expiration Setting</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

</head>
<body>

<div id="dvAccessDenied" runat="server" />
<div id="showContent" visible="True" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" name="SettingID" value="1">
<input type="hidden" name="ID" value="1">
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
    	<table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="lblHeader" runat="server" /></b></td><td align="right"></td></tr></table>
	</td>
	<td width="1" nowrap rowspan="99" bgcolor="003366"><img src="../images/clear.gif" height="1" width="1"></td>
</tr>
 <tr style="background-color: #eeeeee">
    <td width="3%" height="1"></td>
    <td width="94%"></td>
    <td width="3%"></td>
</tr>
<tr><td  colspan="3"><asp:HiddenField ID="settingForValue" runat="server" /><asp:HiddenField ID="settingIDValue" runat="server" />&nbsp;</td></tr>

<tr>
<td>&nbsp;</td>
<td>
<div id="dvUpdateText" class="boldText" runat="server"></div>

<table id="myTable" >
<tbody>
<tr>
	<td><asp:Label ID="lblSettingDescription" Text="Name " runat="server" /></td>
	<td class="text"><asp:TextBox ID="txtSettingDescription" runat="server" Width="427px" ></asp:TextBox></td>
</tr>
<tr>
	<td><asp:Label ID="lblExpireDateType" Text="Expire Date  " runat="server" /></td>
	<td class="text">
        <asp:RadioButton ID="optExpireDateManualSetting" runat="server" GroupName="ExpireTypeGroup" Text="Manual Setting" />
        &nbsp;&nbsp;&nbsp;<asp:RadioButton ID="optExpireDateAutoSetting" runat="server" GroupName="ExpireTypeGroup" Text="Expire After Add/ Activate" />
        &nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtNumberExpireDate" runat="server" MaxLength="5" Width="50px" ></asp:TextBox>
        &nbsp;&nbsp;&nbsp;<asp:DropDownList ID="cboExpireDateType" runat="server"></asp:DropDownList>
	</td>
</tr>
<tr>
	<td></td>
	<td class="text"><asp:CheckBox ID="chkEndOfMonthYear" runat="server" Text="Expire at end of Month/ Year" /></td>
</tr>
<tr>
	<td></td>
	<td class="text"><asp:CheckBox ID="chkIsDefaultSetting" runat="server" Text="Default Setting" /></td>
</tr>
<tr>
    <td></td> 
    <td></td> 
</tr>
<tr>
	<td></td>
    <td>
        <asp:button ID="cmdUpdate" Text="บันทึก" Width="120px" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="cmdCancel" Text="ยกเลิก" runat="server"  Width="120px" Height="25px" />
    </td>
</tr>

</tbody>
</table>
<br />

    </form>
    <div id="dvErrorMsg" class="red" runat="server" />
</div>
</body>
</html>

