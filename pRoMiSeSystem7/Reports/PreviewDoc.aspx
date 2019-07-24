<%@ Page Language="VB" ContentType="text/html" %>

<HTML>
<HEAD>
<TITLE>Preview Document</TITLE>
</HEAD>
<BODY>
<!--	If any of the controls on this page require licensing, you must
	create a license package file. Run LPK_TOOL.EXE to create the
	required LPK file. LPK_TOOL.EXE can be found on the ActiveX SDK,
	http://www.microsoft.com/intdev/sdk/sdk.htm. If you have the Visual
	Basic 6.0 CD, it can also be found in the \Tools\LPK_TOOL directory.

	The following is an example of the Object tag:

<OBJECT CLASSID="clsid:5220cb21-c88d-11cf-b347-00aa00a28331">
	<PARAM NAME="LPKPath" VALUE="LPKfilename.LPK">
</OBJECT>
-->

<OBJECT ID="ctlTDocumentPreview"
CLASSID="CLSID:FA99B4C3-21F6-40CA-8EC3-B2EA367901C6"
CODEBASE="../ActiveX/TDocPreviewProject.CAB#version=1,0,0,4">
<Param Name="IPAddr" Value="<% = Request.ServerVariables("HTTP_HOST") %>">
<Param Name="DBName" Value="<% = ConfigurationSettings.AppSettings("DBName") %>">
<Param Name="DBDriver" Value="<% = ConfigurationSettings.AppSettings("DBDriver")%>">
<Param Name="DocumentID" Value="<% = Request.QueryString("DocumentID") %>" >
<Param Name="CompanyHeader" Value="<% = GlobalParam.CompanyHeader %>">
<Param Name="StockTemplateDoc" Value="<% = Request.QueryString("TemplateType") %>">
<Param Name="DocumentOrderBy" value="DocDetailID">
<span id="ParamValue" runat="server"></span>
</OBJECT>

<script language="VB" runat="server">

Sub Page_Load()
	Dim DeptID As Integer = -1
	Dim GroupID As Integer = -1
	Dim OutputString As String = ""
	If IsNumeric(Request.QueryString("CurrentStockGroupID")) AND Request.QueryString("CurrentStockGroupID") > 0 Then
		GroupID = Request.QueryString("CurrentStockGroupID")
	End IF
	If IsNumeric(Request.QueryString("CurrentStockDeptID")) AND Request.QueryString("CurrentStockDeptID") > 0 Then
		DeptID = Request.QueryString("CurrentStockDeptID")
	End IF
	ParamValue.InnerHtml = "<Param name=""CurrentStockGroupID"" value=""" + GroupID.ToString + """>" + "<Param name=""CurrentStockDeptID"" value=""" + DeptID.ToString + """>"
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>


