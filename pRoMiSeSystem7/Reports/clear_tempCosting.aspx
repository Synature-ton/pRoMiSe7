<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<html>
<head>
<title>Clear Temp Data</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">
<div align="center">
<ASP:Label id="updateMessage" CssClass="text" runat="server" /><p>
<a href="javascript: window.close()">Close Windows</a>
</p>
</div>


<script language="VB" runat="server">
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim objCnn As New MySqlConnection()
Dim getInfo As New CCategory()
Dim objDB As New CDBUtil()

Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Report_ListProducts") Then
	  	objCnn = getCnn.EstablishConnection()	
		Dim Result As String = getInfo.ClearCostingTemp(objCnn)
	
		If Result = "Success" Then
			UpdateMessage.Text = "Clear temporary data of costing report successfully"
		Else
			UpdateMessage.Text = Result
		End If
	Else
		updateMessage.Text = "Access Denied"
	End If
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
