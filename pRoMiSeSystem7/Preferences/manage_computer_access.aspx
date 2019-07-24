<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>

<html>
<head>
<title>Computer Access</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">

<table width="95%">
	<tr>
	<td width="50%" class="text"><a href="javascript: window.close()">Close</a></td>
	<td width="50%" align="right"><div id="showHeaderText" class="headerText" runat="server"></div></td>
	</tr>
</table>
<div id="ValidateSaveData" class="requireText" runat="server"></div>
<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="95%">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="OrderText" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="SelectShopText" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="StockShopText" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="ActionText" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>
	
<form id="mainForm" runat="server">
<input type="hidden" id="ComputerID" runat="server">
	<tr id="AddDataText" runat="server">
		<td align="center"><div id="counterText" class="text" runat="server"></div></td>

		<td align="left"><div id="ValidateSelection" class="errorText" runat="server"></div><div id="LevelSelection" class="text" runat="server"></div></td>
		<td id="h3" runat="server"></td>
		<td align="center"><table cellpadding="0" cellspacing="0"><tr><td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="45" OnClick="DoAddUpdate" runat="server" /></td><td width="5"></td><td><div id="CancelUpdate" runat="server"></div></td></tr></table></td>

	</tr>

</table></form>
<div id="errorMsg" runat="server" />

<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getData As New CPreferences()
Dim cls As New CCategory()
Dim objDB As New CDBUtil()
		
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Manage_Computer") And IsNumeric(Request.QueryString("ComputerID")) Then
	
            ComputerID.Value = Request.QueryString("ComputerID")
            headerTD1.BgColor = GlobalParam.AdminBGColor
            headerTD2.BgColor = GlobalParam.AdminBGColor
            headerTD3.BgColor = GlobalParam.AdminBGColor
            headerTD4.BgColor = GlobalParam.AdminBGColor
            Try
                objCnn = getCnn.EstablishConnection()
			
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(11, Session("LangID"), objCnn)
			
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
                OrderText.InnerHtml = textTable.Rows(31)("TextParamValue")
                SelectShopText.InnerHtml = textTable.Rows(32)("TextParamValue")
                StockShopText.InnerHtml = "Stock"
			
                Dim stockData As New DataTable()
                stockData = cls.GetProductLevel(-99, objCnn)
                headerTD3.Visible = False
			
                If Session("StaffID") = 1 Then headerTD3.Visible = True
                h3.Visible = headerTD3.Visible
			
                If IsNumeric(Request.QueryString("ProductLevelID")) And IsNumeric(Request.QueryString("ComputerID")) And Request.QueryString("action") = "delete" Then
			
                    getData.DelComputerAccess(Request.QueryString("ComputerID"), Request.QueryString("ProductLevelID"), objCnn)

                    Response.Redirect("manage_computer_access.aspx?ComputerID=" + Request.QueryString("ComputerID").ToString)
                ElseIf Request.Form("UpdateStock") = "Update Stock" Then

                    getData.UpdateComputerAccess(Request.QueryString("ComputerID"), Request.Form("StockToInvID"), objCnn)
                    Response.Redirect("manage_computer_access.aspx?ComputerID=" + Request.QueryString("ComputerID").ToString)
                End If
			
                Dim i, j As Integer
                Dim FormSelected, SelectedText As String
			
                Dim IDValueFromDB As Integer
                Dim counter As Integer = 1
                Dim AccessIDList As String = ""
			
                Dim outputString As String = ""
                Dim GetDataInfo As New DataTable()
                Dim dtResult As DataTable
                Dim computerShopID As Integer
                
                dtResult = getData.ComputerInfo(0, Request.QueryString("ComputerID"), objCnn)
                If dtResult.Rows.Count = 0 Then
                    computerShopID = 0
                Else
                    computerShopID = dtResult.Rows(0)("ProductLevelID")
                End If
                
                GetDataInfo = getData.ComputerAccessInfo(Request.QueryString("ComputerID"), 0, objCnn)
                For i = 0 To GetDataInfo.Rows.Count - 1

                    SelectedText = "text"
                    outputString += "<form action=""manage_computer_access.aspx?ComputerID=" + Request.QueryString("ComputerID").ToString + """ method=""post"">"
                    outputString += "<tr><td align=""center"" class=""" + SelectedText + """>" & counter.ToString & "</td>"
                    outputString += "<td align=""left"" class=""" + SelectedText + """>" & GetDataInfo.Rows(i)("ProductLevelName") & "</td>"
                    If headerTD3.Visible = True Then
                        outputString += "<td align=""center"" class=""text"">"
                        If stockData.Rows.Count > 0 Then
                            outputString += "<select name=""StockToInvID"">"
                            For j = 0 To stockData.Rows.Count - 1
                                FormSelected = ""
                                If GetDataInfo.Rows(i)("StockToInvID") = stockData.Rows(j)("ProductLevelID") Then
                                    FormSelected = " selected"
                                End If
                                outputString += "<option value=""" & GetDataInfo.Rows(i)("ProductLevelID") & "," & stockData.Rows(j)("ProductLevelID").ToString & """ " & FormSelected & ">" & stockData.Rows(j)("ProductLevelName")
                            Next
                            outputString += "</select> <input type=""submit"" name=""UpdateStock"" value=""Update Stock"">"
                        End If
                        outputString += "</td>"
                    End If
                    
                    'Can not Delete Shop that belong to ComputerID
                    If computerShopID = GetDataInfo.Rows(i)("ProductLevelID") Then
                        outputString += "<td align=""center"" class=""text""></td>"
                    Else
                        outputString += "<td align=""center"" class=""text""><a href=""manage_computer_access.aspx?action=delete&ComputerID=" + Request.QueryString("ComputerID").ToString + "&ProductLevelID=" + GetDataInfo.Rows(i)("ProductLevelID").ToString + """ onClick=""javascript: return confirm('" & defaultTextTable.Rows(14)("TextParamValue") & " " & Replace(GetDataInfo.Rows(i)("ProductLevelName"), "'", "\'") & " " & defaultTextTable.Rows(15)("TextParamValue") & "')"">" + "Del</a></td>"
                    End If
                   
                    outputString += "</tr></form>"
                    counter = counter + 1
                    AccessIDList += "," + GetDataInfo.Rows(i)("ProductLevelID").ToString
                Next
			
                AccessIDList += ","
			
                ResultText.InnerHtml = outputString
			
                Dim IDValue As Integer = 0
                If IsNumeric(Request.Form("ProductLevelID")) Then
                    IDValue = Request.Form("ProductLevelID")
                ElseIf IsNumeric(Request.QueryString("ProductLevelID")) Then
                    IDValue = Request.QueryString("ProductLevelID")
                ElseIf IsNumeric(IDValueFromDB) Then
                    IDValue = IDValueFromDB
                End If
			
                If GetDataInfo.Rows.Count > 0 Then
                    showHeaderText.InnerHtml = GetDataInfo.Rows(0)("ComputerName")
                End If
			
                Dim dtTable As New DataTable()
                dtTable = cls.GetProductLevel(-9999, objCnn)
			
                outputString = "<select name=""ProductLevelID"">"
                If IDValue = 0 Then
                    outputString += "<option value=""0"" selected>" + textTable.Rows(30)("TextParamValue")
                Else
                    outputString += "<option value=""0"">" + textTable.Rows(30)("TextParamValue")
                End If
			
			
                Dim showString As String
                Dim compareString As String
                For i = 0 To dtTable.Rows.Count - 1
                    compareString = "," + dtTable.Rows(i)("ProductLevelID").ToString + ","
                    If AccessIDList.IndexOf(compareString) = -1 Then
                        outputString += "<option value=""" & dtTable.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & dtTable.Rows(i)("ProductLevelName")
                    End If
                    showString += compareString
                Next
			
                'errorMsg.InnerHtml = AccessIDList + "<br>" + showString
			
                If Request.QueryString("a") <> "yes" Then
                    LevelSelection.InnerHtml = outputString
                End If
			
                Dim AttachEditText As String
                counterText.InnerHtml = counter.ToString
                SubmitForm.Text = "Add"
                AttachEditText = "&b=null"
			
            Catch ex As Exception
                errorMsg.InnerHtml = ex.Message
            End Try
        Else
            errorMsg.InnerHtml = "Access Denied" + "::" + User.Identity.IsAuthenticated.ToString + "::" + Session("Manage_Computer").ToString + "::" + Request.QueryString("ComputerID").ToString
        End If
    End Sub

    Sub DoAddUpdate(Source As Object, E As EventArgs)
        Dim textTable As New DataTable()
        textTable = getPageText.GetText(11, Session("LangID"), objCnn)
	
        Dim FoundError As Boolean = False
	
        If (Not IsNumeric(Request.Form("ProductLevelID")) Or Request.Form("ProductLevelID") <= 0) Then
            ValidateSelection.InnerHtml = textTable.Rows(35)("TextParamValue") + "<br>"
            FoundError = True
        Else
            ValidateSelection.InnerHtml = ""
        End If
        If FoundError = False Then
            Dim Result As Boolean
		
            Application.Lock()
            Result = getData.AddComputerAccess(Request.Form("ComputerID"), Request.Form("ProductLevelID"), Request.Form("ProductLevelID"), objCnn)
            Application.UnLock()
            'errorMsg.InnerHtml = Result
            If Result = True Then
                Response.Redirect("manage_computer_access.aspx?ComputerID=" + Request.QueryString("ComputerID").ToString)
            End If
        End If
    End Sub


Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
