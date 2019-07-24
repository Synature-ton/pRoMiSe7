<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>


<html>
<head>
<title>Room Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<div id="OutputString" visible="false" runat="server">


<OBJECT ID="ctlVoidReport"
CLASSID="CLSID:7E38EAF2-5C08-4BE1-95B9-0185065E92FA"
CODEBASE="../ActiveX/SpaRoomSale.CAB#version=1,0,0,6">
<Param Name="CompanyHeader"  Value="<% = GlobalParam.CompanyHeader %>">
<Param Name="IPAddr"  Value="<% = Request.ServerVariables("HTTP_HOST") %>">
<Param Name="DBName" Value="<% = ConfigurationSettings.AppSettings("DBName")%>">
<Param Name="DBDriver" Value="<% = ConfigurationSettings.AppSettings("DBDriver") %> ">
</OBJECT>

</div>
<div id="errorMsg" runat="server" />
<script language="VB" runat="server">
		
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Report_Room") Then
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
