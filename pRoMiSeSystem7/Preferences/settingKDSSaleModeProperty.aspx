<%@ page language="VB" autoeventwireup="false" inherits="Preferences_settingKDSSaleModeProperty, App_Web_settingkdssalemodeproperty.aspx.475a53d1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>KDS SaleMode Setting</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

</head>
<body>

<div id="dvAccessDenied" runat="server" />
<div id="showContent" visible="True" runat="server">
<form id="mainForm" runat="server">
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
<tr><td  colspan="3">&nbsp;</td></tr>

<tr>
    <td>&nbsp;</td>
    <td>
        <table width="100%">
            <tr><td align="left" width="70%"><b class="headerText"><asp:DropDownList ID="cboShopName" AutoPostBack="true" runat="server"></asp:DropDownList>
                </b></td>
                <td align="right"><asp:Button ID="cmdSaveData" runat="server" Text="Save" width="100px" /></td>
            </tr>
        </table>
    </td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td><div id="dvUpdateText" class="boldText" runat="server"></div>
    </td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td><div id="dvDisplaySetting" runat="server"></div>
    </td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td>
        <table width="100%">
            <tr>
                <td align="right" colspan="2"><asp:Button ID="cmdSaveData2" runat="server" Text="Save"  width="100px" /></td>
            </tr>
        </table>
    </td>
</tr>
</table>
</form>
    <div id="dvErrorMsg" class="red" runat="server" />
</div>
</body>
</html>

