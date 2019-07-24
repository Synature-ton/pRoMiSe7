<%@ Page Language="VB" ContentType="text/html" %>

<HTML>
<HEAD>
<TITLE>RO Summary</TITLE>
</HEAD>
<BODY>


<OBJECT ID="ctlVendorSummary"
CLASSID="CLSID:01397C4C-4F62-432E-8C55-738ACE127535"
CODEBASE="../ActiveX/VendorROSummary.CAB#version=1,0,0,6">
<Param Name="CompanyHeader"  Value="<% = GlobalParam.CompanyHeader %>">
<Param Name="IPAddr"  Value="<% = Request.ServerVariables("HTTP_HOST") %>">
<Param Name="DBName" Value="<% = ConfigurationSettings.AppSettings("DBName")%>">
<Param Name="DBDriver" Value="<% = ConfigurationSettings.AppSettings("DBDriver") %> ">
</OBJECT>
</BODY>
</HTML>


