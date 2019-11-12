<%@ page language="VB" autoeventwireup="false" inherits="LinkOtherSystem_LinkValueDesignSetting, App_Web_linkvaluedesignsetting.aspx.5253a923" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>ValueDesignSetting</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

</head>


<script type="text/javascript">

    function UseValueDesignOption() {
        if (document.getElementById("<%= optUseAPI.ClientID%>").checked)
        {
            document.getElementById("tr_HostIPAddress").style.display = "none";
            document.getElementById("tr_HostPortNo").style.display = "none";
            document.getElementById("tr_APIServiceURL").style.display = "";
            document.getElementById("tr_APIAccessKey").style.display = "";
            document.getElementById("tr_APIPinCode").style.display = "";
            document.getElementById("tr_APIVersion").style.display = "";
        }
        else
        {
            document.getElementById("tr_HostIPAddress").style.display = "";
            document.getElementById("tr_HostPortNo").style.display = "";
            document.getElementById("tr_APIServiceURL").style.display = "none";
            document.getElementById("tr_APIAccessKey").style.display = "none";
            document.getElementById("tr_APIPinCode").style.display = "none";
            document.getElementById("tr_APIVersion").style.display = "none";        
        }
    }
     
</script>


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
<td>[<a href="LinkValueDesignComputerSetting.aspx" ><asp:Label ID="lblComputerSetting" runat="server" Text="ComputerSetting" />]</a>
</tr>

<tr>
<td>&nbsp;</td>
<td>
<div id="dvUpdateText" class="boldText" runat="server"></div>

<table id="myTable" class="blue" width="100%">
<thead>
	<tr>
		<th align="center" style="width: 35%" ><asp:Label ID="lblDescription" Text="Description" runat="server" /></th>
		<th align="center" style="width: 65%" ><asp:Label ID="lblValue" Text="Value" runat="server" /></th>
	</tr>
</thead>
<tbody>

<tr>
	<td><asp:Label ID="lblIsUseServiceAPI" Text="Use Value Design By" runat="server" /></td>
	<td class="text">
        <asp:RadioButton ID="optUseAPI" runat="server" Text="From Service API" GroupName="UseValueDesign" onchange="UseValueDesignOption();"  />
        &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:RadioButton ID="optUseDLL" runat="server" Text="From DLL" GroupName="UseValueDesign" onchange="UseValueDesignOption();" />
    </td>
</tr>
<tr id="tr_HostIPAddress" runat="server" >
	<td><asp:Label ID="lblHostIPAddress" Text="Host IPAddress " runat="server" /></td>
	<td class="text"><asp:textbox ID="txtHostIPAddress" Width="250" runat="server" /></td>
</tr>
<tr id="tr_HostPortNo" runat="server" >
	<td><asp:Label ID="lblHostPortNo" Text="Host Port No. " runat="server" /></td>
	<td class="text"><asp:textbox ID="txtHostPortNo" Width="250" runat="server" /></td>
</tr>
<tr id="tr_APIServiceURL" runat="server" >
	<td><asp:Label ID="lblAPIServiceURL" Text="API - Service URL " runat="server" /></td>
	<td class="text"><asp:textbox ID="txtAPIServiceURL" Width="350" runat="server" /></td>
</tr>
<tr id="tr_APIAccessKey" runat="server" >
	<td><asp:Label ID="lblAPIAccessKey" Text="API - Access Key" runat="server" /></td>
	<td class="text"><asp:textbox ID="txtAPIAccessKey" Width="350" runat="server" /></td>
</tr>
<tr id="tr_APIPinCode" runat="server" >
	<td><asp:Label ID="lblAPIPinCode" Text="API - PIN Code" runat="server" /></td>
	<td class="text"><asp:textbox ID="txtAPIPinCode" Width="150" runat="server" /></td>
</tr>
<tr id="tr_APIVersion" runat="server" >
	<td><asp:Label ID="lblAPIVersion" Text="API - Version" runat="server" /></td>
	<td class="text"><asp:textbox ID="txtAPIVersion" Width="150" runat="server" /></td>
</tr>
<tr id="tr_SendRewardPoint" runat="server" >
	<td><asp:Label ID="lblSendRewardPoint" Text="Send Reward Point To Value Design" runat="server" /></td>
	<td class="text">
        <asp:RadioButton ID="optSendRewardPoint_Yes" runat="server" Text="Yes" GroupName="SendRewardPointGroup"  />
        &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:RadioButton ID="optSendRewardPoint_No" runat="server" Text="No" GroupName="SendRewardPointGroup" />
    </td>
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
