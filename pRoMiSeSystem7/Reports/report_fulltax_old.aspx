<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>

<html>
<head>
<title>Full Tax Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<div id="OutputString" visible="false" runat="server">


<OBJECT ID="ctlFullTaxReport"
CLASSID="CLSID:16D0F951-1E05-4B57-8733-E94B3C6C98E8"
CODEBASE="../ActiveX/FullTaxReport.CAB#version=1,0,0,6">
<Param Name="CompanyHeader"  Value="<% = GlobalParam.CompanyHeader %>">
<Param Name="IPAddr"  Value="<% = Request.ServerVariables("HTTP_HOST") %>">
<Param Name="DBName" Value="<% = ConfigurationSettings.AppSettings("DBName")%>">
<Param Name="DBDriver" Value="<% = ConfigurationSettings.AppSettings("DBDriver") %> ">
</OBJECT>

</div>
<div id="errorMsg" runat="server" />
<script language="VB" runat="server">
		
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Report_FullTax") Then	
		
		Try	
			OutputString.Visible = True	
		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	  
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
