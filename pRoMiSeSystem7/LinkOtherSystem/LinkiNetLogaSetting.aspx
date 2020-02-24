<%@ page language="VB" autoeventwireup="false" inherits="LinkOtherSystem_LinkiNetLogaSetting, App_Web_linkinetlogasetting.aspx.5253a923" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>iNetLogaSetting</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

</head>
<body>
   
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

<tr height="35">
<td>&nbsp;</td>
<td runat="server" visible="false" >[<a href="LinkBuzzeBeeShopSetting.aspx" ><asp:Label ID="lblShopSetting" runat="server" Text="ShopSetting" /></a>]</td>

</tr>

<tr>
<td>&nbsp;</td>
<td>
<div id="dvUpdateText" class="boldText" runat="server"></div>

<table id="myTable" class="blue" width="100%">
<thead>
	<tr>
		<th align="center"><asp:Label ID="lblDescription" Text="Description" runat="server" /></th>
		<th align="center"><asp:Label ID="lblValue" Text="Value" runat="server" /></th>
	</tr>
</thead>
<tbody>
<tr>
	<td><asp:Label ID="lblURL" Text="Webservice URL " runat="server" /></td>
	<td class="text"><asp:textbox ID="txtURL" Width="400" runat="server" /></td>
</tr>
<tr>
	<td><asp:Label ID="lblUserName" Text="User Name " runat="server" /></td>
	<td class="text"><asp:textbox ID="txtUserName" Width="400" runat="server" /></td>
</tr>
<tr>
	<td><asp:Label ID="lblPassword" Text="Password " runat="server" /></td>
	<td class="text"><asp:textbox ID="txtPassword" Width="400px" runat="server" /></td>
</tr>
<tr>
	<td><asp:Label ID="lblLogaCardID" Text="CardID" runat="server" /></td>
	<td class="text"><asp:textbox ID="txtLogaCardID" Width="200px" runat="server" /></td>
</tr>
<tr>
	<td><asp:Label ID="lblDefaultAddMemberGroupID" Text="Default MemberGroup For Add in DB" runat="server" /></td>
	<td class="text"><asp:DropDownList ID="cboDefaultMemberGroup" Width="200px" runat="server"></asp:DropDownList></td>
</tr>
<tr id="trUseSSL" runat="server" >
	<td><asp:Label ID="lblUseSSLTLS" Text="Use SSL TLS 1.2 protocol" runat="server" /></td>
	<td class="text"><asp:RadioButton ID="optUseSSL_Yes" runat="server" Text="Yes" GroupName="UseSSLGroup" /> &nbsp;&nbsp;&nbsp; 
                     <asp:RadioButton ID="optUseSSL_No" runat="server" Text="No" GroupName="UseSSLGroup" /> </td>
</tr>
<tr>
    <td></td> 
    <td></td> 
</tr>
<tr>
	<td></td>
    <td><asp:button ID="cmdSubmit" Text="Update" Width="120px" runat="server" /></td>
</tr>

</tbody>
</table>
<br />

    </form>
    <div id="dvErrorMsg" class="red" runat="server" />
</div>
</body>
</html>
