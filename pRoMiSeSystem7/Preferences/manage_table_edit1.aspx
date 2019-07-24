<%@ Page Language="VB" ContentType="text/html" EnableViewState="true" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<html>
<head>
<title>Manage Tables</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form id="mainForm" runat="server">
<input type="hidden" id="TableID" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText"><div class="headerText" align="left" id="HeaderText" runat="server" /></b>
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
<div id="MLevelText" runat="server"></div>

<table cellpadding="2" cellspacing="2" width="100%">
<tr>
<td><div id="LinkText" class="text" runat="server"></div></td>
</tr>
</table>

<ASP:Label id="updateMessage" CssClass="headerText" runat="server" />
<br/>&nbsp;
<table>
<div id="validateLevel" runat="server" />
<tr id="levelRow" runat="server">
	<td><div class="requireText" id="LevelParam" runat="server"></div></td>
	<td><div id="LevelSelectionText" runat="server"></div></td>
</tr>
<div id="validateGroup" runat="server" />
<tr>
	<td><div class="requireText" id="GroupParam" runat="server"></div></td>
	<td><div id="GroupSelectionText" runat="server"></div></td>
</tr>

<div id="validateName" runat="server" />
<tr>
	<td><div class="requireText" id="NameParam" runat="server"></div></td>
	<td><asp:textbox ID="TableName" Width="200" runat="server" /></td>
</tr>
<div id="validateCode" runat="server" />
<tr>
	<td><div class="requireText" id="CodeParam" runat="server"></div></td>
	<td><asp:textbox ID="Capacity" Width="50" runat="server" /></td>
</tr>

<div id="validateSpecialTable" runat="server" />
<tr id="showExtra" visible="false" runat="server">
	<td><div class="requireText" id="SpecialTableParam" runat="server"></div></td>
	<td><asp:textbox ID="SpecialTable" Width="50" runat="server" /></td>
</tr>
<div id="validateTableNumber" runat="server" />
<tr>
	<td><div class="requireText" id="TableNumberParam" runat="server"></div></td>
	<td><asp:textbox ID="TableNumber" Width="50" Text="0" runat="server" /></td>
</tr>
<tr>
	<td colspan="2" height="5"></td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td><asp:button ID="SubmitForm" OnClick="DoAddUpdate" runat="server" />&nbsp;&nbsp;&nbsp;<asp:button ID="CancelForm" OnClick="DoCancel" runat="server" /></td>
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
Dim getInfo As New CCategory()
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getTable As New CPreferences()
Dim objDB As New CDBUtil()

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Manage_Table") Then
	
            Try
                objCnn = getCnn.EstablishConnection()
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(9, Session("LangID"), objCnn)
			
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
                CancelForm.Text = defaultTextTable.Rows(2)("TextParamValue")
			
                CodeParam.InnerHtml = textTable.Rows(62)("TextParamValue")
                NameParam.InnerHtml = textTable.Rows(55)("TextParamValue")
                LevelParam.InnerHtml = textTable.Rows(59)("TextParamValue")
                GroupParam.InnerHtml = textTable.Rows(49)("TextParamValue")
                TableNumberParam.InnerHtml = "Ordering"
                SpecialTableParam.InnerHtml = "No. of Special Table(s)"
			
                Dim Chk As Boolean = getTable.CheckTableColumn("tableno", "ParentTableID", objCnn)
                showExtra.Visible = False
                If Chk = False Then
                    showExtra.Visible = True
                End If
			
                Dim IDValueFromDB, GroupIDValueFromDB As Integer
			
                If Not Request.QueryString("TableID") And IsNumeric(Request.QueryString("TableID")) Then
                    TableID.Value = Request.QueryString("TableID")
					
                    If Not Page.IsPostBack Then
                        Dim getData As DataTable
                        getData = getTable.TableInfo(2, 0, 0, TableID.Value, objCnn)
					
                        TableName.Text = getData.Rows(0)("TableName")
                        Capacity.Text = getData.Rows(0)("Capacity")
                        TableNumber.Text = getData.Rows(0)("TableNumber")
                        IDValueFromDB = getData.Rows(0)("ShopID")
                        GroupIDValueFromDB = getData.Rows(0)("ZoneID")
									
					    If showExtra.Visible = True Then
                            Dim ExtraTable As DataTable = objDB.List("select count(*) As TotalExtra from TableNo where IsDummy=1 AND ParentTableID=" + TableID.Value.ToString, objCnn)
                            SpecialTable.Text = ExtraTable.Rows(0)("TotalExtra").ToString
                        End If
                        HeaderText.InnerHtml = textTable.Rows(48)("TextParamValue")
                        updateMessage.Text = defaultTextTable.Rows(95)("TextParamValue") + """" + getData.Rows(0)("TableName") + """"
                        SubmitForm.Text = defaultTextTable.Rows(97)("TextParamValue")
			        End If
                Else
                    TableID.Value = 0
                    If Not Page.IsPostBack Then
                        SpecialTable.Text = 0
                        
                        HeaderText.InnerHtml = textTable.Rows(48)("TextParamValue")
                        updateMessage.Text = defaultTextTable.Rows(98)("TextParamValue")
                        SubmitForm.Text = defaultTextTable.Rows(96)("TextParamValue")
                    End If
                End If
		
                Dim IDValue As Integer = 0
                If IsNumeric(Request.Form("ShopID")) Then
                    IDValue = Request.Form("ShopID")
                ElseIf IsNumeric(Request.QueryString("ProductLevelID")) Then
                    IDValue = Request.QueryString("ProductLevelID")
                ElseIf IsNumeric(IDValueFromDB) Then
                    IDValue = IDValueFromDB
                End If
		
                Dim GroupIDValue As Integer = 0
                If IsNumeric(Request.Form("ZoneID")) Then
                    GroupIDValue = Request.Form("ZoneID")
                ElseIf IsNumeric(Request.QueryString("ZoneID")) Then
                    GroupIDValue = Request.QueryString("ZoneID")
                ElseIf IsNumeric(GroupIDValueFromDB) Then
                    GroupIDValue = GroupIDValueFromDB
                End If
		
                Dim levelTable As New DataTable()
                levelTable = getInfo.GetPLevel(-999, "", objCnn) 'getInfo.GetPLevel(-999,1,objCnn)
		
                Dim groupTable As New DataTable()
                groupTable = getTable.TableInfo(1, IDValue, 0, 0, objCnn)
		
                Dim ProductLevelString As String = ""
                Dim ProductGroupString As String = ""
		
                Dim i As Integer
                Dim FormSelected As String
		
                If levelTable.Rows.Count > 1 Then
                    For i = 0 To levelTable.Rows.Count - 1
                        If IDValue = levelTable.Rows(i)("ProductLevelID") Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        ProductLevelString += "<option value=""" & levelTable.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & levelTable.Rows(i)("ProductLevelName")
                    Next
                Else
                    levelRow.Visible = False
                End If
		
                For i = 0 To groupTable.Rows.Count - 1
                    If IDValue = groupTable.Rows(i)("ShopID") Then
                        If GroupIDValue = groupTable.Rows(i)("ZoneID") Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        ProductGroupString += "<option value=""" & groupTable.Rows(i)("ZoneID") & """ " & FormSelected & ">" & groupTable.Rows(i)("ZoneName")
                    End If
                Next
		
                If levelRow.Visible = True Then
                    If IDValue = 0 Then
                        FormSelected = "selected"
                    Else
                        FormSelected = ""
                    End If
                    LevelSelectionText.InnerHtml = "<select name=""ShopID"" onchange=""submit()""><option value=""0""" + FormSelected + ">" + textTable.Rows(51)("TextParamValue") + ProductLevelString + "</select>"
                Else
                    MLevelText.InnerHtml = "<input type=""hidden"" name=""ShopID"" value=""" + levelTable.Rows(0)("ProductLevelID").ToString + """>"
                End If
		
                If GroupIDValue = 0 Then
                    FormSelected = "selected"
                Else
                    FormSelected = ""
                End If
                GroupSelectionText.InnerHtml = "<select name=""ZoneID"" onchange=""submit()""><option value=""0""" + FormSelected + ">" + textTable.Rows(57)("TextParamValue") + ProductGroupString + "</select>"
		
                If Page.IsPostBack Then
                    validateLevel.InnerHtml = ""
                    validateGroup.InnerHtml = ""
			
                    If Not IsNumeric(Request.Form("ShopID")) Or Request.Form("ShopID") = 0 Then
                        validateLevel.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(60)("TextParamValue") & "</td></tr>"
                    End If
                    If Not IsNumeric(Request.Form("ZoneID")) Or Request.Form("ZoneID") = 0 Then
                        validateGroup.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(63)("TextParamValue") & "</td></tr>"
                    End If
                End If
		
            Catch ex As Exception
                errorMsg.InnerHtml = ex.Message
            End Try
        Else
            updateMessage.Text = "Access Denied"
        End If
    End Sub

    Sub DoAddUpdate(Source As Object, E As EventArgs)
        Dim FoundError As Boolean = False
        Dim textTable As New DataTable()
        textTable = getPageText.GetText(9, Session("LangID"), objCnn)
        validateCode.InnerHtml = ""
        validateName.InnerHtml = ""
        validateLevel.InnerHtml = ""
        validateGroup.InnerHtml = ""
        validateTableNumber.InnerHtml = ""
	
        If Not IsNumeric(Request.Form("ShopID")) Or Request.Form("ShopID") = 0 Then
            validateLevel.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(60)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If Not IsNumeric(Request.Form("ZoneID")) Or Request.Form("ZoneID") = 0 Then
            validateGroup.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(63)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If Len(Trim(TableName.Text)) = 0 Then
            validateName.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(64)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If Not IsNumeric(Capacity.Text) Then
            validateCode.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(65)("TextParamValue") & "</td></tr>"
            FoundError = True
        ElseIf Capacity.Text <= 0 Then
            validateCode.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(65)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
	
        If showExtra.Visible = True Then
            If Not IsNumeric(SpecialTable.Text) Then
                validateSpecialTable.InnerHtml = "<tr><td></td><td class=""errorText"">*" & "Special Table must be numberic number that greater than zero" & "</td></tr>"
                FoundError = True
            ElseIf SpecialTable.Text < 0 Then
                validateSpecialTable.InnerHtml = "<tr><td></td><td class=""errorText"">*" & "Special Table must be numberic number that greater than zero" & "</td></tr>"
                FoundError = True
            End If
        End If
	
        If Not IsNumeric(TableNumber.Text) Then
            validateTableNumber.InnerHtml = "<tr><td></td><td class=""errorText"">*" & "Ordering must be numeric number" & "</td></tr>"
            FoundError = True
        End If
        
        If IsTableNameExist(Request.Form("ShopID"), Request.Form("ZoneID"), Request.Form("TableID"), TableName.Text) = True Then
            validateName.InnerHtml = "<tr><td></td><td class=""errorText"">*" & "Table name already exist." & "</td></tr>"
            FoundError = True

        End If
                
        If FoundError = False Then
            Dim Result, Result1 As String
            Dim ExtraSQL(1) As String
            ExtraSQL(0) = ""
            ExtraSQL(1) = ""
		
            Application.Lock()
            Result = getInfo.AddUpdateCategory(Request, ExtraSQL, "TableNo", "TableID", objCnn)
            Result1 = getInfo.RoomCapacity(Request.Form("Capacity"), Request.Form("TableID"), objCnn)
            If showExtra.Visible = True Then
                Dim getMax As DataTable
                Dim InsertID As Integer
                Dim UpdateTableID As Integer = Request.Form("TableID")
                
                If UpdateTableID = 0 Then
                    getMax = objDB.List("SELECT MAX(TableID) AS MAXID FROM TableNo", objCnn)
                    If Not IsDBNull(getMax.Rows(0)("MaxID")) Then
                        UpdateTableID = getMax.Rows(0)("MaxID")
                    Else
                        UpdateTableID = 1
                    End If
                End If
                Dim ChkStatus As DataTable = objDB.List("select * from TableNo where IsDummy=1 AND Status <>0 AND ParentTableID=" + UpdateTableID.ToString, objCnn)
                If ChkStatus.Rows.Count = 0 Then
                    Dim ExtraTable As DataTable = objDB.List("select count(*) As TotalExtra from TableNo where IsDummy=1 AND ParentTableID=" + UpdateTableID.ToString, objCnn)
                    Dim NoExtra As Integer = CInt(SpecialTable.Text)
                    Dim InsertRow As Integer = NoExtra - ExtraTable.Rows(0)("TotalExtra")
                    Dim i As Integer
                    getMax = objDB.List("SELECT MAX(TableID) AS MAXID FROM TableNo", objCnn)
                    If Not IsDBNull(getMax.Rows(0)("MaxID")) Then
                        InsertID = getMax.Rows(0)("MaxID") + 1
                    Else
                        InsertID = 1
                    End If
                    For i = 1 To InsertRow
                        objDB.sqlExecute("INSERT INTO TableNo (TableID,ZoneID,TableNumber,TableName,Capacity,IsDummy,ParentTableID,Deleted) values (" + InsertID.ToString + "," + Request.Form("ZoneID").ToString + "," + Request.Form("TableNumber").ToString + ",'" + Replace(Request.Form("TableName"), "'", "''") + "'," + Request.Form("Capacity").ToString + ",1," + UpdateTableID.ToString + ",1)", objCnn)
                        InsertID += 1
                    Next
                    objDB.sqlExecute("UPDATE TableNo SET IsDummy=0,Deleted=1 WHERE ParentTableID=" + UpdateTableID.ToString, objCnn)
				
                    ExtraTable = objDB.List("select * from TableNo where ParentTableID=" + UpdateTableID.ToString, objCnn)
                    For i = 1 To NoExtra
                        objDB.sqlExecute("UPDATE TableNo SET IsDummy=1, Deleted=1, TableName='" + Replace(Request.Form("TableName"), "'", "''") + "/" + i.ToString + "', TableNumber=" + Request.Form("TableNumber").ToString + ",ZoneID=" + Request.Form("ZoneID").ToString + ",Capacity=" + Request.Form("Capacity").ToString + " WHERE TableID=" + ExtraTable.Rows(i - 1)("TableID").ToString, objCnn)
                    Next
                End If
            End If
            Application.UnLock()
            If Result = "Success" Then
                Response.Redirect("manage_table.aspx?" + Request.QueryString.ToString)
            Else
                errorMsg.InnerHtml = Result
            End If

        End If
    End Sub   
    
    Private Function IsTableNameExist(shopID As Integer, zoneID As Integer, tableID As Integer, tableName As String) As Boolean
        Dim strSQL As String
        Dim dtResult As DataTable
        
        strSQL = "Select t.* " & _
                 "From TableNo t, TableZone tz " & _
                 "Where t.Deleted = 0 AND TableName = '" & Replace(tableName, "'", "''") & "' AND " & _
                 " t.ZoneID = tz.ZoneID AND t.TableID <> " & tableID & " AND tz.ZoneID = " & zoneID
        dtResult = objDB.List(strSQL, objCnn)
        If dtResult.Rows.Count = 0 Then
            Return False
        Else
            Return True
        End If
    End Function
    
    
    Sub DoCancel(Source As Object, E As EventArgs)
        Response.Redirect("manage_table.aspx?" + Request.QueryString.ToString)
    End Sub

    Sub Page_UnLoad()
        objCnn.Close()
    End Sub

</script>
</body>
</html>
