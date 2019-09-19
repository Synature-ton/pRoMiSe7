<%@ page language="VB" autoeventwireup="false" inherits="Preferences_MemberSetFrontFeature, App_Web_membersetfrontfeature.aspx.475a53d1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Set Member Feature At Front</title>
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
<div id="dvUpdateText" class="boldText" runat="server"></div>

<table id="myTable" class="blue" width="100%">
<thead>
	<tr>
		<th id="Th1" align="center" width="40%" runat="server" ><asp:Label ID="lblFeautreName" Text="Feature" runat="server" /></th>
		<th id="Th2" align="center" width="50%" runat="server" ><asp:Label ID="lblValue" Text="Value" runat="server" /></th>
	</tr>
</thead>
<tbody>
<tr>
	<td><asp:Label ID="lblAddNewActivateMember" Text="Create New Member " runat="server" /></td>
	<td class="text">
        <table id="tblAddNew"   style="border-style: none; border-collapse: collapse; ">
        <tr style="border-style: none" >
            <td style="margin: 20px; border-style: none;">
                <asp:RadioButton ID="optAddNewMember" GroupName="NewMemberGroup" Text="Add new member" runat="server" AutoPostBack="true"  />
            </td>
            <td  style="border-style: none" >
                &nbsp;&nbsp;&nbsp;<asp:Button ID="cmdNewMemberExpireSetting" Text=" Expiration Setting" runat="server" />
            </td>
        </tr>
        <tr style="border-style: none" >
            <td style="border-style: none" >
                <asp:RadioButton ID="optActivateMember" GroupName="NewMemberGroup" Text="Activate from exist member" runat="server"  AutoPostBack="true"  />
            </td>
            <td style="border-style: none" >
                &nbsp;&nbsp;&nbsp;<asp:Button ID="cmdActivateMemberExpireSetting" Text=" Expiration Setting" runat="server" />
            </td>
        </tr>
        </table>
    </td>
</tr>
<tr>
	<td><asp:Label ID="lblReNewMember" Text="ReNew/ Change Member Code " runat="server" /></td>
	<td class="text"><asp:RadioButton ID="optReNewYes" GroupName="ReNewGroup" Text="Yes" runat="server"  AutoPostBack="true" />
        &nbsp;&nbsp;&nbsp;<asp:Button ID="cmdReNewMemberExpireSetting" Text=" Expiration Setting" runat="server" Width="120px" />
        &nbsp;&nbsp;&nbsp;<asp:RadioButton ID="optReNewNo" GroupName="ReNewGroup" Text="No" runat="server"  AutoPostBack="true" /></td>
</tr>
<tr>
	<td><asp:Label ID="lblCancelActivateMember" Text="Can Cancel Activate Member" runat="server" /></td>
	<td class="text"><asp:RadioButton ID="optCancelActivateMemberYes" GroupName="CancelActivateGroup" Text="Yes" runat="server" />
        &nbsp;&nbsp;&nbsp;<asp:RadioButton ID="optCancelActivateMemberNo" GroupName="CancelActivateGroup" Text="No" runat="server" /></td>
</tr>
<tr>
	<td><asp:Label ID="lblEditInfo" Text="Edit Member Info" runat="server" /></td>
	<td class="text"><asp:RadioButton ID="optEditMemberInfoYes" GroupName="EditMemberInfoGroup" Text="Yes" runat="server"  AutoPostBack="true" />
        &nbsp;&nbsp;&nbsp;<asp:RadioButton ID="optEditMemberInfoNo" GroupName="EditMemberInfoGroup" Text="No" runat="server"  AutoPostBack="true" /></td>
</tr>
<tr id="trEditExpire" runat="server" >
	<td><asp:Label ID="lblEditExpireInfo" Text="Edit Member Expiration" runat="server" /></td>
	<td class="text"><asp:RadioButton ID="optEditExpireYes" GroupName="EditMemberExpireGroup" Text="Yes" runat="server" />
        &nbsp;&nbsp;&nbsp;<asp:RadioButton ID="optEditExpireNo" GroupName="EditMemberExpireGroup" Text="No" runat="server" /></td>
</tr>
<tr id="trRetrieveFromHQ_UDD" runat="server" >
	<td><asp:Label ID="lblRetrieveUDD" Text="Retrieve From HQ (From Online) - User Define Data" runat="server" /></td>
	<td class="text"><asp:RadioButton ID="optRetrieveUDDYes" GroupName="RetrieveUDDGroup" Text="Yes" runat="server" />
        &nbsp;&nbsp;&nbsp;<asp:RadioButton ID="optRetrieveUDDNo" GroupName="RetrieveUDDGroup" Text="No" runat="server" /></td>
</tr>
<tr id="trRetrieveFromHQ_HistoryChange" runat="server" >
	<td><asp:Label ID="lblRetrieveHistoryChage" Text="Retrieve From HQ (From Online) - History of Change Member Code" runat="server" /></td>
	<td class="text"><asp:RadioButton ID="optRetrieveHistoryChangeYes" GroupName="RetrieveHistoryChangeGroup" Text="Yes" runat="server" />
        &nbsp;&nbsp;&nbsp;<asp:RadioButton ID="optRetrieveHistoryChangeNo" GroupName="RetrieveHistoryChangeGroup" Text="No" runat="server" /></td>
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
