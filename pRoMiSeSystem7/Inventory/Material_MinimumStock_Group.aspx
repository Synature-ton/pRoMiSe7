<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@Import Namespace="System.Globalization" %>
<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head> 
<title>Manage Minimum Stock Group</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<form id="mainForm" runat="server">
<input type="hidden" id="MinimumStockGroupID" runat="server" />
<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText"><div class="headerText" align="left" id="Text_SectionParam" runat="server" /></b>
	</td>
	<td width="1" nowrap rowspan="99" bgcolor="003366"><img src="../images/clear.gif" height="1" width="1"></td>
</tr>
<tr bgcolor="666666">
	<td width="3%" height="1"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	<td width="94%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="252"></p></td>
	<td width="3%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	
</tr>
<tr><td height="10" colspan="3">&nbsp;</td></tr>
<tr>
<td>&nbsp;</td>
<td>
<table cellpadding="2" cellspacing="2" width="100%">
<tr id="showAdd" visible="True" runat="server">
</tr></table>

<table>
<div id="ValidateError" runat="Server"></div>
<tr>
	<td class="text">Name:</td>
    <td><asp:TextBox ID="txtMinimumStockGroupName" MaxLength="50" runat="server" /></td>
	<td><asp:button ID="SubmitForm" OnClick="DoAddUpdate" runat="server" />&nbsp;<asp:button ID="CancelButton" Text=" Cancel " OnClick="DoCancel" runat="server" /></td>
</tr>
</table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="500">
	<tr>
		<td id="headerTDGroupID" align="center" class="tdHeader" runat="server"><div id="IDParam" runat="server"></div></td>
        <td id="headerTDGroupName" align="center" class="tdHeader" runat="server"><div id="GroupName" runat="server"></div></td>
		<td id="headerTDEdit" align="center" class="tdHeader" runat="server"><div id="Default_EditText" runat="server"></div></td>
		<td id="headerTDDelete" align="center" class="tdHeader" runat="server"><div id="Default_DelText" runat="server"></div></td>
        <td id="headerTDShopLink" align="center" class="tdHeader" runat="server"><div id="ShopLink" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>

</table>
<div id="errorMsg" runat="server" />
</td>
<td>&nbsp;</td>
</tr>

<tr><td colspan="3" height="30">&nbsp;</td></tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
<tr>
	<td height="50" colspan="3" background="../images/footerbg2000.gif">&nbsp;</td>
</tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
</table></form>
<script language="VB" runat="server">
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getStaff As New CMembers()
Dim getPageText As New DefaultText()
    Dim getProp As New CPreferences()
    Dim getCate As New CCategory
    Dim objDB As New CDBUtil()


    Sub Page_Load()
        If User.Identity.IsAuthenticated Then
            'AND Session("SetMaterialCostGroup")
            headerTDGroupID.BgColor = GlobalParam.AdminBGColor
            headerTDGroupName.BgColor = GlobalParam.AdminBGColor
            headerTDEdit.BgColor = GlobalParam.AdminBGColor
            headerTDDelete.BgColor = GlobalParam.AdminBGColor
            headerTDShopLink.BgColor = GlobalParam.AdminBGColor
			
            Try
                objCnn = getCnn.EstablishConnection()
                Dim getInfo As DataTable
                Dim dtTable As New DataTable()
                dtTable = getCate.GetMaterialMinimumStockGroup(-1, objCnn)
                Dim i As Integer
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(11, Session("LangID"), objCnn)
			
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
                Text_SectionParam.InnerHtml = "Manage Material Minimum Stock Group"
                IDParam.InnerHtml = "ID"
                Default_EditText.InnerHtml = defaultTextTable.Rows(0)("TextParamValue")
                Default_DelText.InnerHtml = defaultTextTable.Rows(1)("TextParamValue")
                SubmitForm.Text = " Add "
                CancelButton.Visible = False
                ShopLink.InnerHtml = "Set Inventory"
                GroupName.InnerHtml = "Name"
             
                If Not Page.IsPostBack Then
                    MinimumStockGroupID.Value = -1
                    If IsNumeric(Request.QueryString("MinimumStockGroupID")) And Request.QueryString("Action") = "Edit" Then
                        MinimumStockGroupID.Value = Request.QueryString("MinimumStockGroupID")
                        getInfo = getCate.GetMaterialMinimumStockGroup(MinimumStockGroupID.Value, objCnn)
                        If getInfo.Rows.Count > 0 Then
                            If Not IsDBNull(getInfo.Rows(i)("MinimumStockGroupName")) Then
                                txtMinimumStockGroupName.Text = getInfo.Rows(i)("MinimumStockGroupName")
                            Else
                                txtMinimumStockGroupName.Text = ""
                            End If
                        End If
                        
                        SubmitForm.Text = " Update "
                        CancelButton.Visible = True
                    ElseIf IsNumeric(Request.QueryString("MinimumStockGroupID")) And Request.QueryString("Action") = "Delete" Then
                        getCate.DeleteMaterialMinimumStockGroup(Request.QueryString("MinimumStockGroupID"), Session("StaffID"), objCnn)
                        Response.Redirect("Material_MinimumStock_Group.aspx")
                    End If
                End If
			
                Dim outputString As String = ""
                For i = 0 To dtTable.Rows.Count - 1
                    outputString += "<tr><td align=""center"" class=""text"">" & dtTable.Rows(i)("MinimumStockGroupID").ToString & "</td>"
                    outputString += "<td align=""Left"" class=""text"">" & dtTable.Rows(i)("MinimumStockGroupName").ToString & "</td>"
                    outputString += "<td align=""center"" class=""text""><a href=""Material_MinimumStock_Group.aspx?Action=Edit&MinimumStockGroupID=" & dtTable.Rows(i)("MinimumStockGroupID").ToString & """>" & defaultTextTable.Rows(0)("TextParamValue") & "</a></td>"
                    outputString += "<td align=""center"" class=""text""><a href=""Material_MinimumStock_Group.aspx?Action=Delete&MinimumStockGroupID=" & dtTable.Rows(i)("MinimumStockGroupID").ToString & """>" & defaultTextTable.Rows(1)("TextParamValue") & "</a></td>"
                    outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'manage_costgrouplink.aspx?TypeID=10&GroupID=" + dtTable.Rows(i)("MinimumStockGroupID").ToString + "', '', 'width=700,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Set Inventory" + "</a></td>"
                    outputString += "</tr>"
                Next
                ResultText.InnerHtml = outputString
			
            Catch ex As Exception
                errorMsg.InnerHtml = ex.Message
            End Try
        Else
            updateMessage.Text = "Access Denied"
        End If
    End Sub

    Sub DoAddUpdate(Source As Object, E As EventArgs)
        Dim AddUpdate As New CCategory()
        Dim FoundError As Boolean = False
        ValidateError.InnerHtml = ""
        If FoundError = False Then
            Try
                Dim Result As String
                Application.Lock()
                Result = getCate.AddUpdateMaterialMinimumStockGroup(MinimumStockGroupID.Value, txtMinimumStockGroupName.Text, Session("StaffID"), objCnn)
                Application.UnLock()
                Response.Redirect("Material_MinimumStock_Group.aspx")
            Catch ex As Exception
                errorMsg.InnerHtml = ex.ToString
            End Try
        End If
    End Sub

    Sub DoCancel(Source As Object, E As EventArgs)
        Response.Redirect("Material_MinimumStock_Group.aspx")
    End Sub


</script>

</body>
</html>
