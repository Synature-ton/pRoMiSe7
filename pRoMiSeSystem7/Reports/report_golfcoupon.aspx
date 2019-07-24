<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>

<html>
<head>
<title>Golf Coupon Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<div id="OutputString" visible="false" runat="server">


<OBJECT ID="ctlGolfCoupon"
CLASSID="CLSID:7C3291AA-34BA-4838-9DE9-9F349953A450"
CODEBASE="../ActiveX/GolfCouponReport.CAB#version=1,0,0,6">
<Param Name="DBName" Value="<% = ConfigurationSettings.AppSettings("DBName")%> ">
<Param Name="DBDriver" Value="<% = ConfigurationSettings.AppSettings("DBDriver")%> ">
<Param Name="IPAddr" Value="<% = Request.ServerVariables("HTTP_HOST")%> ">
</OBJECT>

</div>
<div id="errorMsg" runat="server" />
<script language="VB" runat="server">
		
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Report_GolfCoupon") Then

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
