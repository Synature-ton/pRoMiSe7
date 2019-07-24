<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Data.OleDb" %>
<%@Import Namespace="POSControlLibrary.POSControl" %>
<%@Import Namespace="POSControlLibrary.GlobalFunctions" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Sale Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<form id="mainForm" runat="server">
<input type="hidden" id="DocumentTypeID" runat="server">
<table border="0" width="100%">
<tr>
	<td></td>
	<td align="right"><div id="HeaderText" class="headerText" runat="server"></div></td>
</tr>
<tr>
	<td colspan="2"><hr size="0"></td>
</tr>
</table>


<div id="ResultSearchText" runat="server"></div>

</form>


<div id="errorMsg" runat="server" />

<script language="VB" runat="server">

Dim objCnn As New OleDbConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getInfo As New CCategory()
Dim getPageText As New DefaultText()
Dim FormatDocNumber As New FormatText()
Dim DateTimeUtil As New MyDateTime()
		
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Report_Sale") Then

		
		Try
			objCnn = getCnn.EstablishConnection()
			
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(13,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			HeaderText.InnerHtml = textTable.Rows(3)("TextParamValue")	
					
		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	  
	Else
		errorMsg.InnerHtml = "Access Denied"
	End If
End Sub

Sub DoSearch(Source As Object, E As EventArgs)
	Dim FoundError As Boolean
	FoundError = False
	Session("ReportResult") = ""
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(10,Session("LangID"),objCnn)
			
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
				
	
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
