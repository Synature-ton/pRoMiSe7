<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>


<html>
<head>
<title>Preview Stock Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<div id="OutputString" visible="false" runat="server">


<OBJECT ID="ctlTStockPreview"
CLASSID="CLSID:80D1E8A9-010B-41BE-BE61-F76E9AE67A56"
CODEBASE="../ActiveX/TransferstockPreview.CAB#version=1,0,0,4">
<Param Name="CompanyHeader"  Value="<% = GlobalParam.CompanyHeader %>">
<Param Name="IPAddr"  Value="<% = Request.ServerVariables("HTTP_HOST") %>">
<Param Name="DBName" Value="<% = ConfigurationSettings.AppSettings("DBName")%>">
<Param Name="DBDriver" Value="<% = ConfigurationSettings.AppSettings("DBDriver") %> ">
</OBJECT>

</div>
<div id="errorMsg" runat="server" />
<script language="VB" runat="server">
		
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Report_PreviewTransfer") Then
	  	OutputString.Visible = True
	Else
		errorMsg.InnerHtml = "Access Denied"
	End If
End Sub


Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
