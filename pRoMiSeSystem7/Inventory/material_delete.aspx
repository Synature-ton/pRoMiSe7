<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<html>
<head>
<title>Delete Material</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText"><div class="headerText" align="left" id="SectionText" runat="server" /></b>
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

<form id="mainForm" runat="server">
<input type="hidden" id="MaterialID" runat="server" />

<table border="0">
<tr><td colspan="2" class="headerText">
<div id="DelSectionText" class="headerText" runat="server"></div>
</td></tr>


<div id="NeedValidate" visible="false" runat="server">
	<tr><td colspan="2" height="10"></td></tr>
	<tr>
		<td></td>
		<td class="text"><span id="DetailText" class="text" runat="server"></span></td>
	</tr>
	<tr><td colspan="2" height="10"></td></tr>
	<span id="ErrorText" class="text" runat="server"></span>
	<tr>
		<td class="text"><asp:radiobutton ID="Radio1" GroupName="Group1" runat="server" /></td>
		<td class="text"><label for="Radio1">Delete this material from all link to product component</label><br><span class="smalltext">This option will delete component that used this material from all products.</span></td>
	</tr>
	<tr>
		<td class="text"><asp:radiobutton ID="Radio2" GroupName="Group1" runat="server" /></td>
		<td class="text"><label for="Radio2">I would like to change to new material <span id="MaterialList" runat="server" /> with amount <asp:TextBox ID="MaterialAmount" CssClass="text" Width="70" runat="server" /></label><br><span class="smalltext">This option will change the component from all products that used this materials with new selected material with specified amount.</span></td>
	</tr>
</div>
<tr><td height="10" colspan="2"></td></tr>
<tr>
	<td></td>
	<td><asp:button ID="SubmitForm" OnClick="DoChange" runat="server" />&nbsp;<asp:button ID="CancelButton" OnClick="DoCancel" runat="server" /></td>
</tr>
</table>

</form>
<div id="Message" class="text" runat="server"></div>
<div id="errorMsg" class="headerText" runat="server"></div>
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

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getProp As New CPreferences()
Dim DateTimeUtil As New MyDateTime()
Dim objDB As New CDBUtil()

    Dim ChkPackageResult As Boolean
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Inv_Material_Category") Then
            If Request.QueryString("MaterialID") And IsNumeric(Request.QueryString("MaterialID")) Then
                Try
                    objCnn = getCnn.EstablishConnection()
                    Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
			
                    If PropertyInfo.Rows(0)("HeadOrBranch") = 1 Then
                        Exit Sub
                    End If
			
                    SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
			
                    MaterialID.Value = Request.QueryString("MaterialID")
			
                    Dim getData As DataTable
                    getData = getInfo.GetMaterialInfo(0, MaterialID.Value, objCnn)

                    Dim textTable As New DataTable()
                    textTable = getPageText.GetText(7, Session("LangID"), objCnn)
			
                    Dim defaultTextTable As New DataTable()
                    defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
			
                    SectionText.InnerHtml = "Delete Material Confirmation"
                    DelSectionText.InnerHtml = "Are you sure you want to delete material """ + getData.Rows(0)("MaterialName") + """ from database?" 'textTable.Rows(3)("TextParamValue") & " " & getData.Rows(0)("MaterialName") & " " & textTable.Rows(4)("TextParamValue")
                    SubmitForm.Text = " Delete this Material "
			
                    CancelButton.Text = " Cancel "
                    Dim TotalLinkRecord As Integer
                    ChkPackageResult = ChkMaterialLink(TotalLinkRecord, MaterialID.Value, objCnn)
			
                    Dim dtTable As DataTable = GetMaterialInfoUnit(0, MaterialID.Value.ToString, objCnn)
                    Dim i As Integer
                    Dim outputString As StringBuilder = New StringBuilder
                    Dim FormSelected As String = ""
                    For i = 0 To dtTable.Rows.Count - 1
                        If dtTable.Rows(i)("MaterialID") = Request.Form("NewMaterialID") Then
                            FormSelected = " selected"
                        Else
                            FormSelected = ""
                        End If
                        outputString = outputString.Append("<option value=""" + dtTable.Rows(i)("MaterialID").ToString + """" + FormSelected + ">" & _
                                            dtTable.Rows(i)("MaterialCode") & " : " & dtTable.Rows(i)("MaterialName") & " (" + dtTable.Rows(i)("UnitSmallName") & ")")
                    Next
			
                    Dim ResultString As String = "<select name=""NewMaterialID"" class=""text"">"
                    ResultString += "<option value=""0"">-- Select New Material --"
                    ResultString += outputString.ToString
                    ResultString += "</select>"
                    MaterialList.InnerHtml = ResultString
	
                    If ChkPackageResult = True Then
                        NeedValidate.Visible = True
                        DetailText.InnerHtml = "There are products component that link to this material.<br>Please choose the option below before deleting this material."
                    End If
			
                Catch ex As Exception
                    errorMsg.InnerHtml = ex.Message
                End Try
            Else
                Message.InnerHtml = "You are not permit to access this page"
            End If
		
        Else
            Message.InnerHtml = "You are not permit to access this page"
        End If
    End Sub

    Sub DoChange(Source As Object, E As EventArgs)
        Dim textTable As New DataTable()
        textTable = getPageText.GetText(7, Session("LangID"), objCnn)
        Dim FoundError As Boolean = False
        ErrorText.InnerHtml = ""
	
        If NeedValidate.Visible = True Then
            If Radio1.Checked = False And Radio2.Checked = False Then
                ErrorText.InnerHtml = "<tr><td></td><td class=""errorText"">Please choose at least one option before submission.</td></tr>"
                FoundError = True
            ElseIf Radio2.Checked = True Then
                If Request.Form("NewMaterialID") = 0 Then
                    ErrorText.InnerHtml = "<tr><td></td><td class=""errorText"">Please select new material you want to change.</td></tr>"
                    FoundError = True
                Else
                    Dim TestDec As Decimal
                    Try
                        TestDec = CDec(MaterialAmount.Text)
                        If CInt(MaterialAmount.Text) <> CDec(MaterialAmount.Text) Then
                            ErrorText.InnerHtml = "<tr><td></td><td class=""errorText"">Material amount must be integer value.</td></tr>"
                            FoundError = True
                        End If
                    Catch ex As Exception
                        ErrorText.InnerHtml = "<tr><td></td><td class=""errorText"">Material amount must be numeric number.</td></tr>"
                        FoundError = True
                    End Try
                End If
            End If
        End If
        If FoundError = False Then
            Dim SelOption As Integer = 0
            If Radio1.Checked = True Then
                SelOption = 1
            ElseIf Radio2.Checked = True Then
                SelOption = 2
            End If
            DeleteMaterial(MaterialID.Value, Request.Form("NewMaterialID"), MaterialAmount.Text, SelOption, objCnn)
            Response.Redirect("material_category.aspx?" + Request.QueryString.ToString)
		
        End If
    End Sub

    Sub DoCancel(Source As Object, E As EventArgs)
        Response.Redirect("material_category.aspx?" + Request.QueryString.ToString)
    End Sub

    Public Function DeleteMaterial(ByRef MaterialID As Integer, ByVal NewMaterialID As Integer, ByVal MaterialAmount As String, _
    ByVal SelOption As Integer, ByVal objCnn As MySqlConnection) As Boolean
        Dim TimeNow As String = DateTimeUtil.CurrentDateTime
        If SelOption > 0 Then
            Dim sqlStatement As String
            Dim AdditionalQuery As String = ""
		
            Dim dtTable As DataTable
            sqlStatement = "Select m.SaleMode,m.PGroupID,m.ProductID,m.ShowOnOrder " & _
                         "From ProductComponent m, Products p, ProductType pt " & _
                         "Where m.ProductID=p.ProductID AND p.Deleted=0 AND p.ProductSet=pt.ProductTypeID AND pt.ComponentLevel=1 AND m.MaterialID=" + MaterialID.ToString
            dtTable = objDB.List(sqlStatement, objCnn)
		
            Dim MaterialInfo As DataTable = objDB.List("select * from Materials where MaterialID=" + NewMaterialID.ToString, objCnn)
		
            Dim strSQL As String
            Dim IDList As StringBuilder = New StringBuilder
            Dim InsertString As StringBuilder = New StringBuilder
            Dim DelString As StringBuilder = New StringBuilder
            Dim DelIDList As String = ""
            Dim i As Integer
		
            For i = 0 To dtTable.Rows.Count - 1
                strSQL = "DELETE FROM ProductComponent " & _
                         "WHERE SaleMode=" + dtTable.Rows(i)("SaleMode").ToString + " AND PGroupID=" + dtTable.Rows(i)("PGroupID").ToString & " AND " & _
                         " ProductID=" + dtTable.Rows(i)("ProductID").ToString + " AND MaterialID=" + MaterialID.ToString
                objDB.sqlExecute(strSQL, objCnn)
                If i = 0 Then
                    If SelOption = 2 Then
                        strSQL = "INSERT INTO ProductComponent (ProductID,SaleMode,MaterialID,MaterialAmount,UnitSmallID,ShowOnOrder,PGroupID) " & _
                                 "Values (" + dtTable.Rows(i)("ProductID").ToString & ", " & dtTable.Rows(i)("SaleMode") & "," + NewMaterialID.ToString + "," & _
                                 MaterialAmount.ToString & "," & _
                                 MaterialInfo.Rows(0)("UnitSmallID").ToString + "," + dtTable.Rows(i)("ShowOnOrder").ToString + "," + dtTable.Rows(i)("PGroupID").ToString + ")"
                        InsertString = InsertString.Append(strSQL)
                    End If
                Else
                    If SelOption = 2 Then
                        strSQL = ",(" + dtTable.Rows(i)("ProductID").ToString & ", " & dtTable.Rows(i)("SaleMode") & "," + NewMaterialID.ToString + "," & _
                                MaterialAmount.ToString + "," & MaterialInfo.Rows(0)("UnitSmallID").ToString + "," + dtTable.Rows(i)("ShowOnOrder").ToString + "," & _
                                dtTable.Rows(i)("PGroupID").ToString + ")"
                        InsertString = InsertString.Append(strSQL)
                    End If
                End If
            Next
		
            Dim DelStatement As String = ""
            Dim InsertStatement As String = ""
            If dtTable.Rows.Count > 0 Then
                DelIDList = IDList.ToString
                'DelStatement = "DELETE FROM ProductComponent WHERE PComponentID IN (" + DelIDList + ")"
                If SelOption = 2 Then
                    InsertStatement = InsertString.ToString
                End If
            End If
		
            'errorMsg.InnerHtml = DelStatement + "<p>" + InsertStatement
            If SelOption = 1 Then
                If DelStatement <> "" Then
                    'objDB.sqlExecute(DelStatement, objCnn)
                End If
            ElseIf SelOption = 2 Then
                If DelStatement <> "" Then
                    objDB.sqlExecute(DelStatement, objCnn)
                End If
                If InsertStatement <> "" Then
                    objDB.sqlExecute(InsertStatement, objCnn)
                End If
            End If
            
            'Delete/ Insert New Material For ProductComponentOverWrite
            
            sqlStatement = "Select m.ProductLevelID, m.SaleMode,m.PGroupID,m.ProductID,m.ShowOnOrder " & _
                        "From ProductComponentOverWrite m, Products p, ProductType pt " & _
                        "Where m.ProductID=p.ProductID AND p.Deleted=0 AND p.ProductSet=pt.ProductTypeID AND pt.ComponentLevel=1 AND m.MaterialID=" + MaterialID.ToString
            dtTable = objDB.List(sqlStatement, objCnn)

            IDList = New StringBuilder
            InsertString = New StringBuilder
            DelString = New StringBuilder
            DelIDList = ""
            
            For i = 0 To dtTable.Rows.Count - 1
                strSQL = "DELETE FROM ProductComponentOverWrite " & _
                         "WHERE SaleMode=" + dtTable.Rows(i)("SaleMode").ToString + " AND PGroupID=" + dtTable.Rows(i)("PGroupID").ToString & " AND " & _
                         " ProductID=" + dtTable.Rows(i)("ProductID").ToString + " AND ProductLevelID = " & dtTable.Rows(i)("ProductLevelID") & " AND " & _
                         " MaterialID=" + MaterialID.ToString
                objDB.sqlExecute(strSQL, objCnn)
                If i = 0 Then
                    If SelOption = 2 Then
                        strSQL = "INSERT INTO ProductComponentOverWrite(ProductLevelID, ProductID,SaleMode,MaterialID,MaterialAmount,UnitSmallID,ShowOnOrder,PGroupID) " & _
                                 "Values (" & dtTable.Rows(i)("ProductLevelID") & ", " & dtTable.Rows(i)("ProductID").ToString & ", " & dtTable.Rows(i)("SaleMode") & "," & _
                                 NewMaterialID.ToString + "," & MaterialAmount.ToString & "," & _
                                 MaterialInfo.Rows(0)("UnitSmallID").ToString + "," + dtTable.Rows(i)("ShowOnOrder").ToString + "," + dtTable.Rows(i)("PGroupID").ToString + ")"
                        InsertString = InsertString.Append(strSQL)
                    End If
                Else
                    If SelOption = 2 Then
                        strSQL = ",(" & dtTable.Rows(i)("ProductLevelID") & ", " & dtTable.Rows(i)("ProductID").ToString & ", " & dtTable.Rows(i)("SaleMode") & "," & _
                                NewMaterialID.ToString + "," & _
                                MaterialAmount.ToString + "," & MaterialInfo.Rows(0)("UnitSmallID").ToString + "," + dtTable.Rows(i)("ShowOnOrder").ToString + "," & _
                                dtTable.Rows(i)("PGroupID").ToString + ")"
                        InsertString = InsertString.Append(strSQL)
                    End If
                End If
            Next
            DelStatement = ""
            InsertStatement = ""
            If dtTable.Rows.Count > 0 Then
                DelIDList = IDList.ToString
                'DelStatement = "DELETE FROM ProductComponent WHERE PComponentID IN (" + DelIDList + ")"
                If SelOption = 2 Then
                    InsertStatement = InsertString.ToString
                End If
            End If
            'errorMsg.InnerHtml = DelStatement + "<p>" + InsertStatement
            If SelOption = 1 Then
                If DelStatement <> "" Then
                    'objDB.sqlExecute(DelStatement, objCnn)
                End If
            ElseIf SelOption = 2 Then
                If DelStatement <> "" Then
                    objDB.sqlExecute(DelStatement, objCnn)
                End If
                If InsertStatement <> "" Then
                    objDB.sqlExecute(InsertStatement, objCnn)
                End If
            End If
        End If
        'Delete Materials
        objDB.sqlExecute("Update Materials set Deleted=1,UpdateDate=" + TimeNow + " WHERE MaterialID=" + MaterialID.ToString, objCnn)
        Return True
    End Function

    Public Function ChkMaterialLink(ByRef TotalLinkRecord As Integer, ByVal MaterialID As Integer, ByVal objCnn As MySqlConnection) As Boolean
        Dim sqlStatement As String
        Dim AdditionalQuery As String = ""

        Dim dtTable As DataTable

        sqlStatement = "Select count(*) AS TotalRecord " & _
                       "From ProductComponent m, Products p, ProductType pt " & _
                       "Where m.ProductID=p.ProductID AND p.Deleted=0 AND p.ProductSet=pt.ProductTypeID AND pt.ComponentLevel=1 AND m.MaterialID=" + MaterialID.ToString
        dtTable = objDB.List(sqlStatement, objCnn)
        TotalLinkRecord = dtTable.Rows(0)("TotalRecord")
        If dtTable.Rows(0)("TotalRecord") > 0 Then
            Return True
        Else
            Return False
        End If
           
    End Function

    Public Function GetMaterialInfoUnit(ByVal MaterialID As Integer, ByVal MaterialIDListNOTIn As String, ByVal objCnn As MySqlConnection) As DataTable
        Dim sqlStatement As String
        Dim AdditionalQuery As String = ""

        Dim dtTable As DataTable
			
        If MaterialID > 0 Then
            AdditionalQuery += " AND m.MaterialID=" + MaterialID.ToString
        End If
			
        If Trim(MaterialIDListNOTIn) <> "" Then
            AdditionalQuery += " AND m.MaterialID NOT IN (" + MaterialIDListNOTIn + ")"
        End If

        sqlStatement = "select * from Materials m, UnitSmall u where m.Deleted=0 AND m.UnitSmallID=u.UnitSmallID" + AdditionalQuery + " order by m.MaterialName"
        dtTable = objDB.List(sqlStatement, objCnn)
        Return dtTable
           
    End Function
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
