<%@ page language="VB" autoeventwireup="false" inherits="LinkOtherSystem_LinkBuzzeBeeSetting, App_Web_linkbuzzebeesetting.aspx.5253a923" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>BuzzeBeeSetting</title>
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
<td>[<a href="LinkBuzzeBeeShopSetting.aspx" ><asp:Label ID="lblShopSetting" runat="server" Text="ShopSetting" /></a>]&nbsp;&nbsp;
    [<a href="LinkBuzzeBeeComputerSetting.aspx" ><asp:Label ID="lblComputerSetting" runat="server" Text="ComputerSetting" />]</a>&nbsp;&nbsp;
    [<a href="LinkBuzzeBeePaymentConditionSetting.aspx" ><asp:Label ID="lblPaymentSetting" runat="server" Text="Payment Condition" />]</a>
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
	<td class="text"><asp:textbox ID="txtURL" Width="250" runat="server" /></td>
</tr>
<tr>
	<td><asp:Label ID="lblToken" Text="Webservice Token " runat="server" /></td>
	<td class="text"><asp:textbox ID="txtToken" Width="700" runat="server" /></td>
</tr>
<tr>
	<td><asp:Label ID="lblBrandID" Text="BrandID" runat="server" /></td>
	<td class="text"><asp:textbox ID="txtBrandID" Width="150" MaxLength="20" runat="server" /></td>
</tr>
<tr>
	<td><asp:Label ID="lblMessageForVoidManual" Text="Message for void manual payment" runat="server" /></td>
	<td class="text"><asp:textbox ID="txtMessageForVoidManual" Width="700" runat="server" /></td>
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
