<%@ page language="VB" autoeventwireup="true" inherits="LinkOtherSystem_LinkBuzzeBeeComputerSetting, App_Web_linkbuzzebeecomputersetting.aspx.5253a923" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>BuzzeBeeComputerSetting</title>
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
<tr><td>&nbsp;</td>
    <td>
        <table width="100%">
            <tr><td align="left" width="70%"><b class="headerText"><asp:DropDownList ID="cboShopName" AutoPostBack="true" runat="server"></asp:DropDownList>
                </b></td>
                <td align="right">[<a href="LinkBuzzeBeeSetting.aspx" ><asp:Label ID="lblGoBack" runat="server" Text="Back" /></a>]</td>
            </tr>
        </table>
    </td>
    <td>&nbsp;</td>
</tr>

<tr>
<td>&nbsp;</td>
<td>
<div id="dvUpdateText" class="boldText" runat="server"></div>
    
<table id="myTable" class="blue" width="100%">
 
<thead>
	<tr>
		<th id="thComputerID" align="center" width="5%" runat="server" ><asp:Label ID="lblComputerID" Text="ID"  runat="server" /></th>
		<th id="thShopName" align="center" width="35%" runat="server" ><asp:Label ID="lblShopName" Text="Shop Name" runat="server" /></th>
		<th id="thComputerName" align="center" width="25%" runat="server" ><asp:Label ID="lblComputerName" Text="Computer Name" runat="server" /></th>
		<th id="thTerminalID" align="center" width="35%" runat="server" ><asp:Label ID="lblBuzzeBeeTerminalID" Text="BuzzeBee TerminalID" runat="server" /></th>
	</tr>
</thead>
<tbody>
    <div id="dvComputerSetting" runat="server"  ></div>

<tr>
    <td></td>
    <td></td> 
    <td></td> 
    <td></td> 
</tr>
<tr>
	<td></td>
	<td></td>
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

