<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>

<html>
<head>
<title>Inventory View</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">
<form id="mainForm" runat="server">
<input type="hidden" id="StaffRoleID" runat="server">
<input type="hidden" id="TypeID" runat="server">
<SCRIPT language="JavaScript">
		function CheckAll(checked) {
			len = document.forms[0].SelProductLevelID.length;
			var i=0;
			for( i=0; i<len; i++) {
				document.forms[0].SelProductLevelID[i].checked=checked;
			}
		}
</script>
<table width="95%">
	<tr>
	<td width="10%" class="text"><a href="javascript: window.close()">Close</a></td>
	<td width="90%" align="right"><div id="showHeaderText" class="headerText" runat="server"></div></td>
	</tr>
	<tr>
		<td class="text" colspan="2"><a href="javascript:CheckAll(true)">Select&nbsp;All</a> - <a href="javascript:CheckAll(false)">Clear&nbsp;All</a></td>
	</tr>
</table>
<div id="ValidateSaveData" class="requireText" runat="server"></div>
<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="95%">
	<tr>
		<td id="headerTD1" width="10%"  align="center" class="tdHeader" runat="server"><div id="OrderText" runat="server"></div></td>
		<td id="headerTD3" width="5%"  align="center" class="tdHeader" runat="server"><div id="SelectText" runat="server"></div></td>
		<td id="headerTD2"  align="center" class="tdHeader" runat="server"><div id="SelectShopText" runat="server"></div></td>
		<td id="headerTD4"  align="center" class="tdHeader" runat="server"><div id="ActionText" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>
	
	
	<tr id="AddDataText" runat="server">
		<td align="center"><div id="counterText" class="text" runat="server"></div></td>
		
		<td colspan="2" align="left"><table cellpadding="0" cellspacing="0"><tr><td><asp:button ID="SubmitForm" Font-Size="10" Height="30" Width="100" OnClick="DoAddUpdate" runat="server" /></td><td width="5"></td><td><div class="boldText" id="MsgText" runat="server"></div></td></tr></table></td>

	</tr>

</table></form>
<div id="errorMsg" runat="server" />

<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getData As New CStaffRole()
Dim cls As New CCategory()
Dim objDB As New CDBUtil()
Dim CostInfo As New CostClass()
Dim DateTimeUtil As New MyDateTime()
		
    Sub Page_Load()
        If User.Identity.IsAuthenticated Then
		
            SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
            headerTD1.BgColor = GlobalParam.AdminBGColor
            headerTD2.BgColor = GlobalParam.AdminBGColor
            headerTD3.BgColor = GlobalParam.AdminBGColor
            headerTD4.BgColor = GlobalParam.AdminBGColor
            headerTD4.Visible = False
            Try
                objCnn = getCnn.EstablishConnection()
			
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(11, Session("LangID"), objCnn)
			
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
                OrderText.InnerHtml = textTable.Rows(31)("TextParamValue")
                SelectShopText.InnerHtml = "Inventory" 'textTable.Rows(32)("TextParamValue")
			
                If Request.QueryString("update") = "yes" Then
                    Dim TimeNow As DateTime = Now()
                    MsgText.InnerHtml = "Data have been updated (" + TimeNow.ToString + ")"
                End If
			
                If IsNumeric(Request.QueryString("TypeID")) Then
                    TypeID.Value = Request.QueryString("TypeID")
                Else
                    TypeID.Value = 0
                End If
			
                Dim i As Integer
                Dim SelectedText As String
			    Dim counter As Integer = 1
                Dim AccessIDList As String = ""
			
                Dim CompareStringList As String = cls.CostGroupData(TypeID.Value, Request.QueryString("GroupID"), objCnn)
			
                Dim dtTable As New DataTable()
                Select Case TypeID.Value
                    Case 2          'ProductCostGroup (List Shop)
                        dtTable = cls.GetProductLevel(-999, objCnn)
                    
                    Case Else       'Other Table (List Inventory)
                        dtTable = cls.GetProductLevel(-99, objCnn)
                End Select
                			
                Dim outputString As String = ""
                Dim compareString, Checked As String
                SelectedText = "text"
                For i = 0 To dtTable.Rows.Count - 1
                    compareString = "," + dtTable.Rows(i)("ProductLevelID").ToString + ","
                    Checked = ""
                    If CompareStringList.IndexOf(compareString) <> -1 Then
                        Checked = "checked"
                    End If
                    outputString += "<tr><td align=""center"" class=""" + SelectedText + """>" & counter.ToString & "</td>"
				
                    outputString += "<td class=""text""><input type=""checkbox"" name=""SelProductLevelID"" value=""" + dtTable.Rows(i)("ProductLevelID").ToString + """ " + Checked + "></td>"
                    outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("ProductLevelName") & "</td>"
                    outputString += "</tr>"
                    counter = counter + 1
                Next
			
                ResultText.InnerHtml = outputString
                Dim HMsg As String
                Dim getData As DataTable
                Select Case TypeID.Value
                    Case 1
                        HMsg = "Set Inventory List for "
                        getData = CostInfo.MaterialCostGroup(Request.QueryString("GroupID"), objCnn)
       
                    Case 2          'ProductCostGroup
                        HMsg = "Set Shop List for "
                        getData = CostInfo.ProductCostGroup(Request.QueryString("GroupID"), objCnn)
                 
                    Case Else
                        HMsg = "Set Inventory List for "
                        getData = CostInfo.MaterialPriceGroup(Request.QueryString("GroupID"), objCnn)
        
                End Select
                If getData.Rows.Count > 0 Then
                    showHeaderText.InnerHtml = HMsg + getData.Rows(0)("CostGroupName")
                End If
				
                SubmitForm.Text = " Submit "
                'AttachEditText = "&b=null"
			
            Catch ex As Exception
                errorMsg.InnerHtml = ex.Message
            End Try
        Else
            errorMsg.InnerHtml = "Access Denied"
        End If
    End Sub

    Sub DoAddUpdate(Source As Object, E As EventArgs)
        Dim textTable As New DataTable()
        textTable = getPageText.GetText(11, Session("LangID"), objCnn)
	
        Dim FoundError As Boolean = False
	
        If FoundError = False Then
            Dim Result As Boolean
		
            Application.Lock()
            Result = cls.AddCostGroupLink(TypeID.Value, Request.QueryString("GroupID"), Request.Form("SelProductLevelID"), objCnn)
            Application.UnLock()
            'errorMsg.InnerHtml = Result
            If Result = True Then
                Response.Redirect("manage_costgrouplink.aspx?GroupID=" + Request.QueryString("GroupID").ToString + "&update=yes" + "&TypeID=" + TypeID.Value.ToString)
            End If
        End If
    End Sub
		
    Sub Page_UnLoad()
        objCnn.Close()
    End Sub

</script>
</body>
</html>
