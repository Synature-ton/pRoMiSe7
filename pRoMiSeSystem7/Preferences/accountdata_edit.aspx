<%@ Page Language="VB" ContentType="text/html" EnableViewState="true" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>

<html>
<head>
<title>Manage Category</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form id="mainForm" runat="server">
<input type="hidden" id="MaterialAccountID" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White"> 
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText"><ASP:Label id="updateMessage" CssClass="headerText" runat="server" /></b>
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


<table>
<div id="validateName" runat="server" />

<tr>
	<td><div class="requireText" id="NameParam" runat="server"></div></td>
	<td><asp:textbox ID="MaterialAccountCode" Width="300" runat="server" /></td>
</tr>
<tr>
	<td class="text">Account Name</td>
	<td><asp:textbox ID="MaterialAccountName" Width="300" runat="server" /></td>
</tr>

<tr>
	<td colspan="2" height="5"></td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td><asp:button ID="SubmitForm" OnClick="DoAddUpdate" runat="server" />&nbsp;<asp:button ID="CancelButton" OnClick="DoCancel" runat="server" /></td>
</tr>
</table>
</form>

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
</table>
<script language="VB" runat="server">
Dim getInfo As New POSConfiguration()
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim cc As New CCategory()

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("AccountDataSetting") Then
            'Try
            objCnn = getCnn.EstablishConnection()
            SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
            Dim textTable As New DataTable()
            textTable = getPageText.GetText(9, Session("LangID"), objCnn)
		
            Dim defaultTextTable As New DataTable()
            defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
				
            NameParam.InnerHtml = "Account Code"

            SubmitForm.Text = textTable.Rows(12)("TextParamValue")
		
		
            Dim PropData As DataTable = objDB.List("select * from propertytextdesp where propertytypeid=101 order by PropertyPosition", objCnn)
            Dim PropList As String
            Dim i As Integer
            Dim PrinterParam() As String
		
            If Not Request.QueryString("MaterialAccountID") And IsNumeric(Request.QueryString("MaterialAccountID")) Then
			
                MaterialAccountID.Value = Request.QueryString("MaterialAccountID")
			
                If Not Page.IsPostBack Then
					
                    CancelButton.Text = defaultTextTable.Rows(2)("TextParamValue")
					
                    updateMessage.Text = textTable.Rows(42)("TextParamValue")
                    SubmitForm.Text = textTable.Rows(42)("TextParamValue")
					
                    Dim DataInfo As DataTable
                    DataInfo = objDB.List("select * from MaterialAccountData where MaterialAccountID=" + MaterialAccountID.Value.ToString, objCnn)
					
					
                    For i = 0 To DataInfo.Rows.Count - 1
                        If IsDBNull(DataInfo.Rows(i)("MaterialAccountCode")) Then
                            MaterialAccountCode.Text = ""
                        Else
                            MaterialAccountCode.Text = DataInfo.Rows(i)("MaterialAccountCode")
                        End If
                        If IsDBNull(DataInfo.Rows(i)("MaterialAccountName")) Then
                            MaterialAccountName.Text = ""
                        Else
                            MaterialAccountName.Text = DataInfo.Rows(i)("MaterialAccountName")
                        End If
					
						
                    Next
					
					
                End If
			
            Else
					
                CancelButton.Text = defaultTextTable.Rows(2)("TextParamValue")
			
                updateMessage.Text = textTable.Rows(40)("TextParamValue")
                SubmitForm.Text = textTable.Rows(40)("TextParamValue")
			
                MaterialAccountID.Value = -1


            End If
	
            'Catch ex As Exception
            'errorMsg.InnerHtml = ex.Message
            'End Try
        Else
            updateMessage.Text = "Access Denied"
        End If
    End Sub


Sub DoAddUpdate(Source As Object, E As EventArgs)
	Dim FoundError AS Boolean = False
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(9,Session("LangID"),objCnn)
	validateName.InnerHtml = ""
	If Len(Trim(MaterialAccountCode.Text)) = 0 Then
		validateName.InnerHtml = "<tr><td></td><td class=""errorText"">*" & "Account Code must be filled before submmission" & "</td></tr>"
		FoundError = True
	End If	
	If FoundError = False Then
		Dim Result As String
		Dim ExtraSQL(1) As String

		ExtraSQL(0) = ""
		ExtraSQL(1) = ""
		
		If IsNumeric(MaterialAccountID.Value) Then
			If MaterialAccountID.Value = -1 Then
				Dim getMax As DataTable = objDB.List("select MAX(MaterialAccountID) As MaxID from MaterialAccountData", objCnn)
				Dim InsertID As Integer = 1
				If getMax.Rows.Count > 0 Then
					If IsNumeric(getMax.Rows(0)("MaxID")) Then
						InsertID = getMax.Rows(0)("MaxID") + 1
					End If
				End If
				objDB.sqlExecute("INSERT INTO MaterialAccountData (MaterialAccountID,MaterialAccountCode,MaterialAccountName) values (" + InsertID.ToString + ",'" + Replace(MaterialAccountCode.Text,"'","''") + "','" + Replace(MaterialAccountName.Text,"'","''") + "')",objCnn)
			Else
				objDB.sqlExecute("UPDATE MaterialAccountData set MaterialAccountCode='" + Replace(MaterialAccountCode.Text,"'","''") + "',MaterialAccountName='" + Replace(MaterialAccountName.Text,"'","''") + "' where MaterialAccountID=" + MaterialAccountID.Value.ToString, objCnn)
			End If
		End If

		Response.Redirect("accountdatasetting.aspx")


	End If
End Sub

Sub DoCancel(Source As Object, E As EventArgs)
	
	Response.Redirect("accountdatasetting.aspx")

End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
