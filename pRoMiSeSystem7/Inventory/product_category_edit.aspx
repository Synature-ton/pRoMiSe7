<%@ Page Language="VB" ContentType="text/html" EnableViewState="true" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<html>
<head>
<title>Manage Category</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form id="mainForm" runat="server">
<input type="hidden" id="ProductGroupID" runat="server" />
<input type="hidden" id="ProductGroupCode_Old" runat="server" />
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
	<td><div id="SelectionText" runat="server"></div></td>
</tr>
<div id="validateCode" runat="server" />
<tr>
	<td><div class="requireText" id="CodeParam" runat="server"></div></td>
	<td><asp:textbox ID="ProductGroupCode" Width="200" runat="server" /></td>
</tr>
<div id="validateName" runat="server" />
<tr>
	<td><div class="requireText" id="NameParam" runat="server"></div></td>
	<td><asp:textbox ID="ProductGroupName" Width="200" runat="server" /></td>
</tr>

<span id="DisplayProductInv" visible="false" runat="server">
<div id="validateInv" runat="server" />
<tr>
	<td><div class="text" id="InvParam" runat="server"></div></td>
	<td><asp:textbox ID="StockInventoryCode" Width="200" MaxLength="50" runat="server" /></td>
</tr>
</span>

<div id="validateOrdering" runat="server" />
<tr>
	<td><div class="requireText" id="OrderingParam" runat="server"></div></td>
	<td><asp:textbox ID="ProductGroupOrdering" Width="50" runat="server" /></td>
</tr>
<tr>
	<td class="text"><span id="PrintDeptForSessionText" class="text" runat="Server"></span></td>
	<td class="text"><input type="radio" id="Radio3" name="PrintDeptForSession" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio4" name="PrintDeptForSession" value="0" runat="server" />NO</td>
</tr>
<span id="PocketPC" visible="false" runat="server">
<tr>
	<td class="text"><span id="PocketPCText" class="text" runat="Server"></span></td>
	<td class="text"><input type="radio" id="Radio5" name="PocketPCAvailable" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio6" name="PocketPCAvailable" value="0" runat="server" />NO</td>
</tr>
</span>

<tr id="DisplayTablet" visible="false" runat="server">
	<td class="text">Display in Tablet</td>
	<td class="text"><input type="radio" id="Radio10" name="TabletActivate" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio11" name="TabletActivate" value="0" runat="server" />NO</td>
</tr>

<tr id="trDisplayInSession" visible="false" runat="server">
	<td class="text">Display in Session/ End Day</td>
	<td class="text"><input type="radio" id="optDisplayInSession" name="groupDisplayInSession" value="1" runat="server" />YES&nbsp;&nbsp;
        <input type="radio" id="optNotDisplayInSession" name="groupDisplayInSession" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td><div class="requireText" id="ActivateParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio1" name="ProductGroupActivate" value="1" runat="server" /><span id="YesText1" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio2" name="ProductGroupActivate" value="0" runat="server" /><span id="NoText1" runat="server"></span></td>
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
<!--<hr><div id="showString" runat="server"></div>
<hr><div id="showString1" runat="server"></div>
<hr><div id="showString2" runat="server"></div>-->
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
Dim cls As New CCategory()
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim DateTimeUtil As New MyDateTime()

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Inv_Product_Category") Then
	
            Try
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
                objCnn = getCnn.EstablishConnection()
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(7, Session("LangID"), objCnn)
			
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
			
                If PropertyInfo.Rows(0)("PocketPCFeature") = 1 Then
                    PocketPC.Visible = True
                Else
                    PocketPC.Visible = False
                End If
                PocketPCText.InnerHtml = "Display At Pocket PC"
                CancelForm.Text = defaultTextTable.Rows(2)("TextParamValue")
			
                CodeParam.InnerHtml = textTable.Rows(14)("TextParamValue")
                NameParam.InnerHtml = textTable.Rows(15)("TextParamValue")
                LevelParam.InnerHtml = textTable.Rows(16)("TextParamValue")
                YesText1.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
                NoText1.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
                ActivateParam.InnerHtml = textTable.Rows(60)("TextParamValue")
                OrderingParam.InnerHtml = defaultTextTable.Rows(107)("TextParamValue")
                PrintDeptForSessionText.InnerHtml = textTable.Rows(93)("TextParamValue")
                InvParam.InnerHtml = "Stock Code"
			
                Dim ChkmPOS As DataTable = getProp.PropertyValue(2, 10, Request.QueryString("ProductLevelID"), objCnn)
                Dim mPOS As Boolean = False
                Dim bolHasDisplayInSession As Boolean

                If ChkmPOS.Rows.Count > 0 Then
                    If ChkmPOS.Rows(0)("PropertyValue") = 1 Then
                        mPOS = True
                    End If
                End If
			
                Dim ChkStockInv As DataTable = getProp.PropertyValue(2, 12, 1, objCnn)
                Dim ProductInv As Boolean = False
                If ChkStockInv.Rows.Count > 0 Then
                    If ChkStockInv.Rows(0)("PropertyValue") = 1 Then
                        ProductInv = True
                    End If
                End If
			
                bolHasDisplayInSession = POSDBSQLFront.POSUtilSQL.IsFieldNameExist(getCnn, objCnn, "ProductGroup", "DisplayInSession")

                trDisplayInSession.Visible = bolHasDisplayInSession
                DisplayTablet.Visible = mPOS
                DisplayProductInv.Visible = ProductInv
			
                Dim IDValueFromDB As Integer
			
                If Not Request.QueryString("ProductGroupID") And IsNumeric(Request.QueryString("ProductGroupID")) Then
			
                    ProductGroupID.Value = Request.QueryString("ProductGroupID")
						
                    If Not Page.IsPostBack Then

                        Dim getInfo As DataTable
                        getInfo = cls.GetProductGroup(0, Request.QueryString("ProductGroupID"), objCnn)
					
                        ProductGroupName.Text = getInfo.Rows(0)("ProductGroupName")
                        ProductGroupCode.Text = getInfo.Rows(0)("ProductGroupCode")
                        IDValueFromDB = getInfo.Rows(0)("ProductLevelID")
					
                        If ProductInv = True Then
                            Dim getInvCode As DataTable = objDB.List("select * from  ProductStockToInvSetting where ForGroupID=" + getInfo.Rows(0)("ProductGroupID").ToString, objCnn)
                            If getInvCode.Rows.Count > 0 Then
                                If Not IsDBNull(getInvCode.Rows(0)("StockInventoryCode")) Then
                                    StockInventoryCode.Text = getInvCode.Rows(0)("StockInventoryCode")
                                End If
                            End If
                        End If
					
                        If getInfo.Rows(0)("ProductGroupActivate") = True Or getInfo.Rows(0)("ProductGroupActivate") = 1 Then
                            Radio1.Checked = True
                        Else
                            Radio2.Checked = True
                        End If
					
                        If getInfo.Rows(0)("PrintDeptForSession") = True Or getInfo.Rows(0)("PrintDeptForSession") = 1 Then
                            Radio3.Checked = True
                        Else
                            Radio4.Checked = True
                        End If
					
                        If getInfo.Rows(0)("PocketPCAvailable") = True Or getInfo.Rows(0)("PocketPCAvailable") = 1 Then
                            Radio5.Checked = True
                        Else
                            Radio6.Checked = True
                        End If
					
                        ProductGroupOrdering.Text = getInfo.Rows(0)("ProductGroupOrdering")
					
                        ProductGroupCode_Old.Value = getInfo.Rows(0)("ProductGroupCode")
					
                        HeaderText.InnerHtml = textTable.Rows(11)("TextParamValue")
                        updateMessage.Text = textTable.Rows(21)("TextParamValue") + """" + getInfo.Rows(0)("ProductGroupName") + """"
                        SubmitForm.Text = textTable.Rows(9)("TextParamValue")
					
                        If mPOS = True Then
                            Dim getmPOS As DataTable = objDB.List("select * from MenuGroup where MenuGroupID=" + Request.QueryString("ProductGroupID").ToString + " AND ProductLevelID=" + getInfo.Rows(0)("ProductLevelID").ToString, objCnn)
                            Radio10.Checked = True
                            If getmPOS.Rows.Count > 0 Then
                                If getmPOS.Rows(0)("Activate") = 0 Then
                                    Radio11.Checked = 1
                                End If
                            End If
                        End If
					
                        If bolHasDisplayInSession = True Then
                            If getInfo.Rows(0)("DisplayInSession") = 1 Then
                                optDisplayInSession.Checked = True
                                optNotDisplayInSession.Checked = False
                            Else
                                optDisplayInSession.Checked = False
                                optNotDisplayInSession.Checked = True
                            End If
                        Else
                            optDisplayInSession.Checked = True
                            optNotDisplayInSession.Checked = False
                        End If
                    End If
                Else
			
                    HeaderText.InnerHtml = textTable.Rows(11)("TextParamValue")
                    updateMessage.Text = textTable.Rows(20)("TextParamValue")
                    SubmitForm.Text = textTable.Rows(8)("TextParamValue")
                    ProductGroupOrdering.Text = "0"
			
                    ProductGroupID.Value = 0
                    ProductGroupCode_Old.Value = ""
			
                    If Not Page.IsPostBack Then
                        Radio1.Checked = True
                        Radio3.Checked = True
                        Radio5.Checked = True
                        If mPOS = True Then
                            Radio10.Checked = True
                        End If
                        If bolHasDisplayInSession = True Then
                            optDisplayInSession.Checked = True
                        End If
                    End If

                End If
		
                Dim IDValue As Integer = 0
                If IsNumeric(Request.Form("ProductLevelID")) Then
                    IDValue = Request.Form("ProductLevelID")
                ElseIf IsNumeric(Request.QueryString("ProductLevelID")) Then
                    IDValue = Request.QueryString("ProductLevelID")
                ElseIf IsNumeric(IDValueFromDB) Then
                    IDValue = IDValueFromDB
                End If
		
                Dim SelectString As String = textTable.Rows(25)("TextParamValue")
                Dim selectionTable As New DataTable()
                selectionTable = cls.GetProductLevel(0, objCnn)
		
                Dim i As Integer
                If selectionTable.Rows.Count = 1 Then
                    levelRow.Visible = False
                    MLevelText.InnerHtml = "<input type=""hidden"" name=""ProductLevelID"" value=""" + selectionTable.Rows(0)("ProductLevelID").ToString + """>"
                Else
                    Dim outputString, FormSelected As String
                    outputString = "<select name=""ProductLevelID""><option value=""0"">" & SelectString
			
                    For i = 0 To selectionTable.Rows.Count - 1
                        If IDValue = selectionTable.Rows(i)("ProductLevelID") Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        outputString += "<option value=""" & selectionTable.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & selectionTable.Rows(i)("ProductLevelName")
                    Next
                    SelectionText.InnerHtml = outputString
                End If
		
                If i > 1 Then
                    'AllBranches.Visible = True
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
        textTable = getPageText.GetText(6, Session("LangID"), objCnn)
        Dim defaultTextTable As New DataTable()
        defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
        validateCode.InnerHtml = ""
        validateName.InnerHtml = ""
        validateLevel.InnerHtml = ""
	
        Dim ChkmPOS As DataTable = getProp.PropertyValue(2, 10, Request.QueryString("ProductLevelID"), objCnn)
        Dim mPOS As Boolean = False
        If ChkmPOS.Rows.Count > 0 Then
            If ChkmPOS.Rows(0)("PropertyValue") = 1 Then
                mPOS = True
            End If
        End If
	
        If Not IsNumeric(Request.Form("ProductLevelID")) Or Request.Form("ProductLevelID") = 0 Then
            validateLevel.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(24)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If Len(Trim(ProductGroupName.Text)) = 0 Then
            validateName.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(22)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If Len(Trim(ProductGroupCode.Text)) = 0 Then
            validateCode.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(23)("TextParamValue") & "</td></tr>"
            FoundError = True
        ElseIf ProductGroupCode_Old.Value = "" Or (ProductGroupCode_Old.Value <> ProductGroupCode.Text) Then
            Dim ChkExist As DataTable
            ChkExist = getCnn.List("SELECT * FROM ProductGroup WHERE Deleted=0 AND ProductGroupCode='" + Trim(Replace(ProductGroupCode.Text, "'", "''")) + "' AND ProductLevelID=" + Request.Form("ProductLevelID"), objCnn)
            If ChkExist.Rows.Count > 0 Then
                validateCode.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(54)("TextParamValue") & "</td></tr>"
                FoundError = True
            End If
        End If
	
        If Not IsNumeric(ProductGroupOrdering.Text) Then
            validateOrdering.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(101)("TextParamValue") & "</td></tr>"
            FoundError = True
        ElseIf ProductGroupOrdering.Text < 0 Then
            validateOrdering.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(101)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
	
        If DisplayProductInv.Visible = True Then
            Dim ChkInvCode As DataTable = objDB.List("select * from productlevel where Deleted=0 And StockInventoryCode='" + Replace(StockInventoryCode.Text, "'", "''") + "'", objCnn)
            If ChkInvCode.Rows.Count = 0 And StockInventoryCode.Text <> "" Then
                validateInv.InnerHtml = "<tr><td></td><td class=""errorText"">" & "Cannot find inventory code from database" & "</td></tr>"
                FoundError = True
            End If
        End If
	
        If FoundError = False Then
            Dim Result As String
            Dim ExtraSQL(1) As String
            ExtraSQL(0) = ""
            ExtraSQL(1) = ""
		
            Application.Lock()
            Result = cls.AddUpdateCategory(Request, ExtraSQL, "ProductGroup", "ProductGroupID", objCnn)
            getProp.ExpenseMaterialProduct(objCnn)
            Dim GroupID As Integer = Request.Form("ProductGroupID")
            If GroupID = 0 Then
                GroupID = cls.GetInsertID("ProductGroup", "ProductGroupID", 1, Request.Form("ProductLevelID"), objCnn)
            End If
            Dim Activate As Integer = 1
            If mPOS = True Then
                If Radio11.Checked = True Then
                    Activate = 0
                End If
            End If
            cls.iPadManager("ProductGroup", GroupID, Activate, objCnn)
            If DisplayProductInv.Visible = True Then
                If StockInventoryCode.Text = "" Then
                    objDB.sqlExecute("delete from ProductStockToInvSetting where ForGroupID=" + GroupID.ToString, objCnn)
                Else
                    Dim ChkInvCode As DataTable = objDB.List("select * from productlevel where Deleted=0 And StockInventoryCode='" + Replace(StockInventoryCode.Text, "'", "''") + "'", objCnn)
                    If ChkInvCode.Rows.Count > 0 Then
                        Dim getPStock As DataTable = objDB.List("select * from ProductStockToInvSetting where ForGroupID=" + GroupID.ToString, objCnn)
                        If getPStock.Rows.Count = 0 Then
                            objDB.sqlExecute("insert into ProductStockToInvSetting (SettingTypeID,StockInventoryCode,StockInventoryID,ForGroupCode,ForGroupID) values (1,'" + ChkInvCode.Rows(0)("StockInventoryCode") + "'," + ChkInvCode.Rows(0)("ProductLevelID").ToString + ",'" + Replace(Request.Form("ProductGroupCode"), "'", "''") + "'," + GroupID.ToString + ")", objCnn)
                        Else
                            objDB.sqlExecute("UPDATE ProductStockToInvSetting SET StockInventoryCode='" + ChkInvCode.Rows(0)("StockInventoryCode") + "',StockInventoryID=" + ChkInvCode.Rows(0)("ProductLevelID").ToString + ",ForGroupCode='" + Replace(Request.Form("ProductGroupCode"), "'", "''") + "' where SettingID=" + getPStock.Rows(0)("SettingID").ToString, objCnn)
						
                            objDB.sqlExecute("UPDATE ProductStockToInvSetting SET ForGroupCode='" + Replace(Request.Form("ProductGroupCode"), "'", "''") + "' where ForGroupID=" + GroupID.ToString, objCnn)
                        End If
                    End If
                End If
            End If
            
            If trDisplayInSession.Visible = True Then
                Dim displayInSession As Integer
                If optDisplayInSession.Checked = True Then
                    displayInSession = 1
                Else
                    displayInSession = 0
                End If
                objDB.sqlExecute("UPDATE ProductGroup SET DisplayInSession = " & displayInSession & " Where ProductGroupID=" & GroupID.ToString, objCnn)
            End If
            Application.UnLock()
            If Result = "Success" Then
                Response.Redirect("product_category.aspx?" + Request.QueryString.ToString)
            Else
                errorMsg.InnerHtml = Result
            End If

        End If
    End Sub

Sub DoCancel(Source As Object, E As EventArgs)
	Response.Redirect("product_category.aspx?" + Request.QueryString.ToString)
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
