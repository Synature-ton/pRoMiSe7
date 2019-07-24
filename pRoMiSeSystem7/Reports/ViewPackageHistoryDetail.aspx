<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ViewPackageHistoryDetail.aspx.vb" Inherits="PackageDetailReport.ViewPackageHistoryDetail"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>View Package History Detail</title>
		<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table>
			<tr>
				<td><asp:Label CssClass="headerText" id="lblHeader" runat="server"></asp:Label></td>
			</tr>
			<tr>
				<td><asp:DataGrid HeaderStyle-HorizontalAlign="center" HeaderStyle-CssClass="tdHeader" CssClass="text" id="dtgDisplayHistoryDetail" runat="server" ></asp:DataGrid></td>
			</tr>
			<tr>
				<td><asp:Label CssClass="text" id="lblFooter" runat="server" ></asp:Label></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			</table>
			</form>
	</body>
</HTML>
