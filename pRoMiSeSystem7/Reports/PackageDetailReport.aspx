<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PackageDetailReport.aspx.vb" Inherits="PackageDetailReport.PackageDetailReport"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Package Detail</title>
		<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
		<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText">Package or Course Reports</b>
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
			<tr>
				<td valign="top">
				<asp:radiobutton id="optByPackageName" runat="server" Text="àÅ×Í¡µÒÁª×èÍ Package" CssClass="text" GroupName="SelectDisplayReport" AutoPostBack="True"></asp:radiobutton><br>
				<asp:listbox id="lstPackageName" CssClass="text" runat="server" Width="215px" Height="106px" SelectionMode="Multiple" Rows="1"></asp:listbox></td>
				<td valign="top">
				<asp:radiobutton id="optByMemberName" CssClass="text" runat="server" Text="àÅ×Í¡µÒÁª×èÍ¼Ùé«×éÍ" GroupName="SelectDisplayReport" AutoPostBack="True"></asp:radiobutton><br>
				<asp:listbox id="lstMemberName" CssClass="text" runat="server" Width="215px" Height="106px" SelectionMode="Multiple" Rows="1"></asp:listbox>
				</td>
				<td valign="bottom">
				<asp:checkbox id="chkShowCommissionPrice" CssClass="text" runat="server" Text="áÊ´§¤èÒ commission"></asp:checkbox><p>
				<asp:button id="cmdSubmit" CssClass="text" runat="server" Text="Display Report"></asp:button>
				</p>
				</td>
			</tr>
		</table>
		<table width="100%">
			<tr>
				<td><asp:label id="lblReportHeader" CssClass="text" runat="server"></asp:label><asp:label id="Label1" CssClass="text" runat="server"></asp:label></td>
			</tr>
			<tr>
				<td width="100%">
			<asp:datagrid id="dtgDisplayReport" AllowPaging="true" CssClass="text" CellPadding="3" HeaderStyle-CssClass="tdHeader" HeaderStyle-HorizontalAlign="center" runat="server" PageSize="20" Width="100%" PagerStyle-Mode="NumericPages" CellSpacing="0" ItemStyle-HorizontalAlign="left"></asp:datagrid></td>
			</tr>
		</table>
		</form>
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
</HTML>
