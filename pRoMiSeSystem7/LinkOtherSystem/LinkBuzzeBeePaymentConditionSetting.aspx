<%@ page language="VB" autoeventwireup="false" inherits="LinkOtherSystem_LinkToCondition, App_Web_linkbuzzebeepaymentconditionsetting.aspx.5253a923" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>BuzzeBee Payment Config Setting</title>
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
            <tr>
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
		<th id="thPayTypeID" align="center" width="5%" runat="server" ><asp:Label ID="lblPayTypeID" Text="ID"  runat="server" /></th>
		<th id="thPaymentName" align="center" width="45%" runat="server" ><asp:Label ID="lblPaymentName" Text="Payment Name" runat="server" /></th>
		<th id="thStarCharacter" align="center" width="10%" runat="server" ><asp:Label ID="lblStartCharacter" Text="Start Character" runat="server" /></th>
		<th id="thValidLen_Start" align="center" width="10%" runat="server" ><asp:Label ID="lblValidLen_Start" Text="Valid Length Start" runat="server" /></th>
		<th id="thValidLen_End" align="center" width="10%" runat="server" ><asp:Label ID="lblValidLen_End" Text="Valid Length End" runat="server" /></th>
		<th id="thNumericOnly" align="center" width="10%" runat="server" ><asp:Label ID="lblNumericOnly" Text="Numeric Only" runat="server" /></th>
		<th id="thIsManualPayment" align="center" width="10%" runat="server" ><asp:Label ID="lblIsManualPayment" Text="Is Manual Payment" runat="server" /></th>
		<th id="thEdit" align="center" width="10%" runat="server" ><asp:Label ID="lblEdit" Text="Edit" runat="server" /></th>
	</tr>
</thead>
<tbody>
    <div id="dvPaymentCondition" runat="server"  ></div>

</tbody>
</table>
<br />

    </form>
    <div id="dvErrorMsg" class="red" runat="server" />
</div>
</body>

</html>
