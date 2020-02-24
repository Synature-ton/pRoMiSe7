<%@ Page Language="VB" ContentType="text/html" EnableViewState="true" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSDBFront" %>

<html>
<head>
<title>Manage Material Data</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<form id="mainForm" runat="server">
<input type="hidden" id="MaterialID" runat="server" />
<input type="hidden" id="MaterialCode_Old" runat="server" />
<input type="hidden" id="Keyword" runat="server" />
<input type="hidden" name="MaterialCost" value="0">
<input type="hidden" id="UnitNew" runat="server" />
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
	<td colspan="3"><div id="LevelSelectionText" runat="server"></div></td>
</tr>
<div id="validateGroup" runat="server" />
<tr>
	<td><div class="requireText" id="GroupParam" runat="server"></div></td>
	<td colspan="3"><div id="GroupSelectionText" runat="server"></div></td>
</tr>
<div id="validateDept" runat="server" />
<tr>
	<td><div class="requireText" id="DeptParam" runat="server"></div></td>
	<td colspan="3"><div id="DeptSelectionText" runat="server"></div></td>
</tr>
<div id="validateCode" runat="server" />
<tr>
	<td><div class="requireText" id="CodeParam" runat="server"></div></td>
	<td colspan="3"><asp:textbox ID="MaterialCode" Width="200" MaxLength="50" runat="server" /></td>
</tr>
<div id="validateName" runat="server" />
<tr>
	<td><div class="requireText" id="NameParam" runat="server"></div></td>
	<td colspan="3"><asp:textbox ID="MaterialName" Width="200" MaxLength="100" runat="server" /></td>
</tr>
<div id="validateType" runat="server" />
<tr>
	<td><div class="requireText" id="TypeParam" runat="server"></div></td>
	<td colspan="3"><div id="TypeSelectionText" runat="server"></div></td>
</tr>

<tr id="AccountCodeSetting" visible="false" runat="server">
	<td><div class="requireText" id="AccountCodeParam" runat="server"></div></td>
	<td colspan="3"><div id="AccountCodeSelectionText" runat="server"></div></td>
</tr>

<span id="ShowOldUnit" visible="false" runat="server">
<div id="validateUnit" runat="server" />
<tr>
	<td><div class="requireText" id="CostParam" runat="server"></div></td>
	<td colspan="3"><div id="UnitSelectionText" runat="server"></div></td>
</tr>
</span>

<span id="ShowNewUnit" visible="false" runat="server">
<div id="validateNewUnit" runat="server" />
<tr>
	<td class="requireText">Unit Small Name</td>
	<td class="text"><asp:textbox ID="USmall" Width="100" MaxLength="500" runat="server" />&nbsp;&nbsp;Ratio:1 <span id="EditUnitNote" class="requireText" runat="server"></span></td>
    <td class="text">Barcode Unit Small:</td>
    <td class="text"><asp:textbox ID="BarcodeUnitSmall" Width="150" MaxLength="500" runat="server" /></td>
</tr>
<tr>
	<td class="text">Unit Large Name 1</td>
	<td class="text"><asp:textbox ID="ULarge1" Width="100" MaxLength="500" runat="server" />&nbsp;&nbsp;Ratio:<asp:textbox ID="URatio1" Width="70" MaxLength="500" runat="server" /> based on unit small</td>
    <td class="text">Barcode Large 1:</td>
    <td class="text"><asp:textbox ID="BarcodeUnitLarge1" Width="150" MaxLength="500" runat="server" /></td>
</tr>
<span id="MoreUnit" visible="True" runat="server">
<tr>
	<td class="text">Unit Large Name 2</td>
	<td class="text"><asp:textbox ID="ULarge2" Width="100" MaxLength="500" runat="server" />&nbsp;&nbsp;Ratio:<asp:textbox ID="URatio2" Width="70" MaxLength="500" runat="server" /> based on unit small</td>
    <td class="text">Barcode Large 2:</td>
    <td class="text"><asp:textbox ID="BarcodeUnitLarge2" Width="150" MaxLength="500" runat="server" /></td>
</tr>
<tr>
	<td class="text">Unit Large Name 3</td>
	<td class="text"><asp:textbox ID="ULarge3" Width="100" MaxLength="500" runat="server" />&nbsp;&nbsp;Ratio:<asp:textbox ID="URatio3" Width="70" MaxLength="500" runat="server" /> based on unit small</td>
    <td class="text">Barcode Large 3:</td>
    <td class="text"><asp:textbox ID="BarcodeUnitLarge3" Width="150" MaxLength="500" runat="server" /></td>
</tr>
<tr>
	<td class="text">Unit Large Name 4</td>
	<td class="text"><asp:textbox ID="ULarge4" Width="100" MaxLength="500" runat="server" />&nbsp;&nbsp;Ratio:<asp:textbox ID="URatio4" Width="70" MaxLength="500" runat="server" /> based on unit small</td>
    <td class="text">Barcode Large 4:</td>
    <td class="text"><asp:textbox ID="BarcodeUnitLarge4" Width="150" MaxLength="500" runat="server" /></td>
</tr>
<tr>
	<td class="text">Unit Large Name 5</td>
	<td class="text"><asp:textbox ID="ULarge5" Width="100" MaxLength="500" runat="server" />&nbsp;&nbsp;Ratio:<asp:textbox ID="URatio5" Width="70" MaxLength="500" runat="server" /> based on unit small</td>
    <td class="text">Barcode Large 5:</td>
    <td class="text"><asp:textbox ID="BarcodeUnitLarge5" Width="150" MaxLength="500" runat="server" /></td>
</tr>
</span>
</span>

<span id="ShowInvenUnit" visible="false" runat="server">
<tr>
	<td class="text" valign="top">Set Inventory Unit<br>(Def=Default)</td>
	<td valign="top" colspan="3">
	<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
		<tr>
			<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="Text1" runat="server"></div></td>
			<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text2" runat="server"></div></td>
			<td></td>
			<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Text3" runat="server"></div></td>
			<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Text4" runat="server"></div></td>
			<td></td>
			<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="Text5" runat="server"></div></td>
			<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="Text6" runat="server"></div></td>
			<td></td>
			<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="Text7" runat="server"></div></td>
			<td id="headerTD8" align="center" class="tdHeader" runat="server"><div id="Text8" runat="server"></div></td>
			<td id="h78" runat="server"></td>
			<td id="headerTD9" align="center" class="tdHeader" runat="server"><div id="Text9" runat="server"></div></td>
			<td id="headerTD10" align="center" class="tdHeader" runat="server"><div id="Text10" runat="server"></div></td>
			<td id="h910" runat="server"></td>
			<td id="headerTD12" align="center" class="tdHeader" runat="server"><div id="Text12" runat="server"></div></td>
			<td id="headerTD13" align="center" class="tdHeader" runat="server"><div id="Text13" runat="server"></div></td>
			<td></td>
			<td id="headerTD14" align="center" class="tdHeader" runat="server"><div id="Text14" runat="server"></div></td>
			<td id="headerTD15" align="center" class="tdHeader" runat="server"><div id="Text15" runat="server"></div></td>
			<td id="h1415" runat="server"></td>
			<td id="headerTD11" align="center" class="tdHeader" runat="server"><div id="Text11" runat="server"></div></td>
		</tr>
		<div id="ResultText" runat="server"></div>
	
	</table>
	</td>
</span>

<div id="validateMinStock" runat="server" />
<tr>
	<td><div class="requireText" id="MinStockParam" runat="server"></div></td>
	<td colspan="3"><asp:textbox ID="MinimumStock" Width="100" MaxLength="500" Text="0.00" runat="server" /> <span id="SmallUnitText" class="text" runat="server"></span></td>
</tr>

<tr id="ShowStockType" visible="false" runat="server">
	<td><div class="requireText">Stock Type</div></td>
	<td colspan="3"><asp:radiobutton GroupName="StockTypeOption" ID="Daily" CssClass="text" runat="server" />
	<asp:radiobutton GroupName="StockTypeOption" ID="Monthly" CssClass="text" runat="server" />
	<asp:radiobutton GroupName="StockTypeOption" ID="NotCount" CssClass="text" runat="server" /></td>
</tr>

<tr>
	<td><div class="requireText">VAT</div></td>
	<td colspan="3"><asp:radiobutton GroupName="VATOption" ID="VATIn" CssClass="text" runat="server" />
	<asp:radiobutton GroupName="VATOption" ID="VATOut" CssClass="text" runat="server" />
	<asp:radiobutton GroupName="VATOption" ID="NoVAT" CssClass="text" runat="server" /></td>
</tr>

<tr>
	<td class="text">Auto Update Material Price</td>
	<td class="text" colspan="3"><input type="radio" id="Radio1" name="AutoUpdateMaterialPrice" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio2" name="AutoUpdateMaterialPrice" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td colspan="4" height="5"></td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td colspan="3"><asp:button ID="SubmitForm" OnClick="DoAddUpdate" runat="server" />&nbsp;&nbsp;&nbsp;<asp:button ID="CancelForm" OnClick="DoCancel" runat="server" /></td>
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
Dim getInfo As New CCategory()
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim DateTimeUtil As New MyDateTime()
Dim objDB As New CDBUtil()
Dim getProp As New CPreferences()

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Inv_Material_Category") Then
	
            Try
                objCnn = getCnn.EstablishConnection()
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(6, Session("LangID"), objCnn)
			
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
			
                headerTD1.BgColor = GlobalParam.AdminBGColor
                headerTD2.BgColor = GlobalParam.AdminBGColor
                headerTD3.BgColor = GlobalParam.AdminBGColor
                headerTD4.BgColor = GlobalParam.AdminBGColor
                headerTD5.BgColor = GlobalParam.AdminBGColor
                headerTD6.BgColor = GlobalParam.AdminBGColor
                headerTD7.BgColor = GlobalParam.AdminBGColor
                headerTD8.BgColor = GlobalParam.AdminBGColor
                headerTD9.BgColor = GlobalParam.AdminBGColor
                headerTD10.BgColor = GlobalParam.AdminBGColor
                headerTD11.BgColor = GlobalParam.AdminBGColor
                headerTD12.BgColor = GlobalParam.AdminBGColor
                headerTD13.BgColor = GlobalParam.AdminBGColor
                headerTD14.BgColor = GlobalParam.AdminBGColor
                headerTD15.BgColor = GlobalParam.AdminBGColor
			
                Text1.InnerHtml = "Def"
                Text2.InnerHtml = "PO"
                Text3.InnerHtml = "Def"
                Text4.InnerHtml = "Stock Count"
                Text5.InnerHtml = "Def"
                Text6.InnerHtml = "Receive"
                Text7.InnerHtml = "Def"
                Text8.InnerHtml = "Transfer"
                Text9.InnerHtml = "Def"
                Text10.InnerHtml = "Request"
                Text12.InnerHtml = "Def"
                Text13.InnerHtml = "Adjust"
                Text14.InnerHtml = "Def"
                Text15.InnerHtml = "PreFinish"
                Text11.InnerHtml = "Unit"
			
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                MoreUnit.Visible = True
                If PropertyInfo.Rows(0)("SystemEditionID") = 1 Then
                    MoreUnit.Visible = False
                    headerTD7.Visible = False
                    headerTD8.Visible = False
                    headerTD9.Visible = False
                    headerTD10.Visible = False
                    headerTD14.Visible = False
                    headerTD15.Visible = False
                    h78.Visible = False
                    h910.Visible = False
                    h1415.Visible = False
                End If
			
                Dim chk As Boolean = getProp.CheckTableColumn("Materials", "MaterialAccountID", objCnn)
			
                Dim AccountCodeExist As Boolean = False
                If chk = False Then
                    AccountCodeExist = True
                End If
			
                AccountCodeSetting.Visible = AccountCodeExist
                AccountCodeParam.InnerHtml = "Account Code"
			
                VATIn.Text = defaultTextTable.Rows(87)("TextParamValue")
                VATOut.Text = defaultTextTable.Rows(88)("TextParamValue")
                NoVAT.Text = defaultTextTable.Rows(89)("TextParamValue")
			
                Daily.Text = "Daily"
                Monthly.Text = "Monthly"
                NotCount.Text = "Not Count"
			
                CancelForm.Text = defaultTextTable.Rows(2)("TextParamValue")
			
                CodeParam.InnerHtml = textTable.Rows(40)("TextParamValue")
                NameParam.InnerHtml = textTable.Rows(41)("TextParamValue")
                TypeParam.InnerHtml = textTable.Rows(46)("TextParamValue")
                CostParam.InnerHtml = textTable.Rows(58)("TextParamValue")
                LevelParam.InnerHtml = textTable.Rows(7)("TextParamValue")
                GroupParam.InnerHtml = textTable.Rows(15)("TextParamValue")
                DeptParam.InnerHtml = textTable.Rows(28)("TextParamValue")
                MinStockParam.InnerHtml = textTable.Rows(56)("TextParamValue")
			
                Dim EditUnit As Boolean = True
                Dim IDValueFromDB, GroupIDValueFromDB, DeptIDValueFromDB, TypeIDValueFromDB, UnitIDValueFromDB, AccountIDValueFromDB As Integer
                Dim i As Integer
			
                UnitNew.Value = 1
                Dim ChkUnitSetting As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramTypeID=2 and PropertyID=7 and KeyID=1", objCnn)
                If ChkUnitSetting.Rows.Count = 1 Then
                    If ChkUnitSetting.Rows(0)("PropertyValue") = 1 Then
                        UnitNew.Value = 1
                    End If
                End If
			
                If UnitNew.Value = 1 Then
                    ShowOldUnit.Visible = False
                    ShowNewUnit.Visible = True
                Else
                    ShowOldUnit.Visible = True
                    ShowNewUnit.Visible = False
                End If
                
                ShowInvenUnit.Visible = True
                Dim GetProperty As DataTable = getProp.PropertyValue(2, 1, 1, objCnn)
                If GetProperty.Rows.Count = 1 Then
                    If GetProperty.Rows(0)("PropertyValue") = 1 Then
                        ShowInvenUnit.Visible = True
                    End If
                End If
			
                If UnitNew.Value = 0 Then
                    ShowInvenUnit.Visible = False
                End If
                
                If Not Request.QueryString("MaterialID") And IsNumeric(Request.QueryString("MaterialID")) Then
                    MaterialID.Value = Request.QueryString("MaterialID")
                    Keyword.Value = Request.QueryString("Keyword")
			
                    Dim MaterialBarCode As String = ""
					
                    If Not Page.IsPostBack Then
                        Dim getData As DataTable
                        getData = getInfo.GetMaterialInfo(0, MaterialID.Value, objCnn)
					
                        If UnitNew.Value = 1 And getData.Rows.Count > 0 Then
                            Dim getUnit As DataTable = getInfo.GetUnitInfo(2, getData.Rows(0)("UnitSmallID"), objCnn)
                            
                            URatio1.ReadOnly = False
                            URatio2.ReadOnly = False
                            URatio3.ReadOnly = False
                            URatio4.ReadOnly = False
                            URatio5.ReadOnly = False
                            
                            For i = 0 To getUnit.Rows.Count - 1
                                If Not IsDBNull(getUnit.Rows(i)("MaterialUnitRatioCode")) Then
                                    MaterialBarCode = getUnit.Rows(i)("MaterialUnitRatioCode")
                                Else
                                    MaterialBarCode = ""
                                End If
                                Select Case i
                                    Case 0
                                        USmall.Text = getUnit.Rows(i)("UnitLargeName")
                                        BarcodeUnitSmall.Text = MaterialBarCode
                                    Case 1
                                        ULarge1.Text = getUnit.Rows(i)("UnitLargeName")
                                        URatio1.Text = getUnit.Rows(i)("UnitSmallRatio")
                                        BarcodeUnitLarge1.Text = MaterialBarCode
                                    Case 2
                                        ULarge2.Text = getUnit.Rows(i)("UnitLargeName")
                                        URatio2.Text = getUnit.Rows(i)("UnitSmallRatio")
                                        BarcodeUnitLarge2.Text = MaterialBarCode
                                    Case 3
                                        ULarge3.Text = getUnit.Rows(i)("UnitLargeName")
                                        URatio3.Text = getUnit.Rows(i)("UnitSmallRatio")
                                        BarcodeUnitLarge3.Text = MaterialBarCode
                                    Case 4
                                        ULarge4.Text = getUnit.Rows(i)("UnitLargeName")
                                        URatio4.Text = getUnit.Rows(i)("UnitSmallRatio")
                                        BarcodeUnitLarge4.Text = MaterialBarCode
                                    Case 5
                                        ULarge5.Text = getUnit.Rows(i)("UnitLargeName")
                                        URatio5.Text = getUnit.Rows(i)("UnitSmallRatio")
                                        BarcodeUnitLarge5.Text = MaterialBarCode
                                End Select
                            Next
                        End If
					
                        MaterialName.Text = getData.Rows(0)("MaterialName")
                        MaterialCode.Text = getData.Rows(0)("MaterialCode")
                        IDValueFromDB = getData.Rows(0)("MaterialLevelID")
                        GroupIDValueFromDB = getData.Rows(0)("MaterialGroupID")
                        DeptIDValueFromDB = getData.Rows(0)("MaterialDeptID")
                        TypeIDValueFromDB = getData.Rows(0)("MaterialTypeID")
                        UnitIDValueFromDB = getData.Rows(0)("UnitSmallID")
                        MinimumStock.Text = Format(getData.Rows(0)("MinimumStock"), "##,##0.00")
					
                        If AccountCodeSetting.Visible = True Then
                            AccountIDValueFromDB = getData.Rows(0)("MaterialAccountID")
                        End If
					
                        MaterialCode_Old.Value = getData.Rows(0)("MaterialCode")
					
                        HeaderText.InnerHtml = textTable.Rows(11)("TextParamValue")
                        updateMessage.Text = textTable.Rows(34)("TextParamValue")
                        SubmitForm.Text = textTable.Rows(9)("TextParamValue")
                        If getData.Rows(0)("MaterialTaxType") = 0 Then
                            NoVAT.Checked = True
                        ElseIf getData.Rows(0)("MaterialTaxType") = 1 Then
                            VATOut.Checked = True
                        ElseIf getData.Rows(0)("MaterialTaxType") = 2 Then
                            VATIn.Checked = True
                        Else
                            NoVAT.Checked = True
                        End If
					
                        If getData.Rows(0)("AutoUpdateMaterialPrice") = 1 Then
                            Radio1.Checked = True
                        Else
                            Radio2.Checked = True
                        End If
					
                        If getData.Rows(0)("StockType") = 1 Then
                            Daily.Checked = True
                        ElseIf getData.Rows(0)("StockType") = 0 Then
                            Monthly.Checked = True
                        ElseIf getData.Rows(0)("StockType") = -1 Then
                            NotCount.Checked = True
                        Else
                            Monthly.Checked = True
                        End If
                    End If
                    Dim bolMaterialIsUse As Boolean
                    bolMaterialIsUse = getInfo.CheckUnit(MaterialID.Value, objCnn)
                    If bolMaterialIsUse = False Then
                        USmall.ReadOnly = True
                        EditUnitNote.InnerHtml = "(Cannot change unit small name because this material already has movement in document)"
                        
                        If URatio1.Text <> "" Then
                            URatio1.ReadOnly = True
                        End If
                        If URatio2.Text <> "" Then
                            URatio2.ReadOnly = True
                        End If
                        If URatio3.Text <> "" Then
                            URatio3.ReadOnly = True
                        End If
                        If URatio4.Text <> "" Then
                            URatio4.ReadOnly = True
                        End If
                        If URatio5.Text <> "" Then
                            URatio5.ReadOnly = True
                        End If
                    Else
                        USmall.ReadOnly = False
                        EditUnitNote.InnerHtml = ""
                    End If
                    EditUnit = bolMaterialIsUse
                Else
                    HeaderText.InnerHtml = textTable.Rows(11)("TextParamValue")
                    updateMessage.Text = textTable.Rows(44)("TextParamValue")
                    SubmitForm.Text = textTable.Rows(8)("TextParamValue")
			
                    MaterialID.Value = 0
			
                    MaterialCode_Old.Value = ""
			
                    If Not Page.IsPostBack Then
                        VATOut.Checked = True
                        Monthly.Checked = True
                        Radio1.Checked = True
                    End If

                End If
		
                Dim FormSelected As String
		
                If AccountCodeSetting.Visible = True Then
                    Dim AccountIDValue As Integer = 0
                    If IsNumeric(Request.Form("MaterialAccountID")) Then
                        AccountIDValue = Request.Form("MaterialAccountID")
                    ElseIf IsNumeric(Request.QueryString("MaterialAccountID")) Then
                        AccountIDValue = Request.QueryString("MaterialAccountID")
                    ElseIf IsNumeric(AccountIDValueFromDB) Then
                        AccountIDValue = AccountIDValueFromDB
                    End If
                    Dim ACode As DataTable = objDB.List("select * from MaterialAccountData where Deleted=0 order by MaterialAccountCode", objCnn)
                    Dim ACodeString As String = ""
                    For i = 0 To ACode.Rows.Count - 1

                        If AccountIDValue = ACode.Rows(i)("MaterialAccountID") Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        If ACode.Rows(i)("MaterialAccountID") = 0 Then
                            ACodeString += "<option value=""" & ACode.Rows(i)("MaterialAccountID") & """ " & FormSelected & ">" & ACode.Rows(i)("MaterialAccountName")
                        Else
                            ACodeString += "<option value=""" & ACode.Rows(i)("MaterialAccountID") & """ " & FormSelected & ">" & ACode.Rows(i)("MaterialAccountCode") & ":" & ACode.Rows(i)("MaterialAccountName")
                        End If

                    Next
                    AccountCodeSelectionText.InnerHtml = "<select name=""MaterialAccountID"" style=""width:200px"">" + ACodeString + "</select>"
                End If
		
                Dim IDValue As Integer = 0
                If IsNumeric(Request.Form("MaterialLevelID")) Then
                    IDValue = Request.Form("MaterialLevelID")
                ElseIf IsNumeric(Request.QueryString("MaterialLevelID")) Then
                    IDValue = Request.QueryString("MaterialLevelID")
                ElseIf IsNumeric(IDValueFromDB) Then
                    IDValue = IDValueFromDB
                End If
		
                Dim GroupIDValue As Integer = 0
                If IsNumeric(Request.Form("MaterialGroupID")) Then
                    GroupIDValue = Request.Form("MaterialGroupID")
                ElseIf IsNumeric(Request.QueryString("MaterialGroupID")) Then
                    GroupIDValue = Request.QueryString("MaterialGroupID")
                ElseIf IsNumeric(GroupIDValueFromDB) Then
                    GroupIDValue = GroupIDValueFromDB
                End If
		
                Dim DeptIDValue As Integer = 0
                If IsNumeric(Request.Form("MaterialDeptID")) Then
                    DeptIDValue = Request.Form("MaterialDeptID")
                ElseIf IsNumeric(Request.QueryString("MaterialDeptID")) Then
                    DeptIDValue = Request.QueryString("MaterialDeptID")
                ElseIf IsNumeric(DeptIDValueFromDB) Then
                    DeptIDValue = DeptIDValueFromDB
                End If
		
                Dim TypeIDValue As Integer = 0
                If IsNumeric(Request.Form("MaterialTypeID")) Then
                    TypeIDValue = Request.Form("MaterialTypeID")
                ElseIf IsNumeric(Request.QueryString("MaterialTypeID")) Then
                    TypeIDValue = Request.QueryString("MaterialTypeID")
                ElseIf IsNumeric(TypeIDValueFromDB) Then
                    TypeIDValue = TypeIDValueFromDB
                End If
		
                Dim UnitIDValue As Integer = 0
                If IsNumeric(Request.Form("UnitSmallID")) Then
                    UnitIDValue = Request.Form("UnitSmallID")
                ElseIf IsNumeric(Request.QueryString("UnitSmallID")) Then
                    UnitIDValue = Request.QueryString("UnitSmallID")
                ElseIf IsNumeric(UnitIDValueFromDB) Then
                    UnitIDValue = UnitIDValueFromDB
                End If
		
                Dim levelTable As New DataTable()
                levelTable = getInfo.GetMaterialLevel(0, objCnn)
		
                Dim groupTable As New DataTable()
                groupTable = getInfo.GetMaterialGroup(IDValue, 0, objCnn)
		
                Dim deptTable As New DataTable()
                deptTable = getInfo.GetMaterialDept(GroupIDValue, 0, objCnn)
		
                Dim typeTable As New DataTable()
		
                Dim ChkPrefinish As DataTable = objDB.List("select * from programpropertyvalue where ProgramTypeID=3 AND PropertyID=9 AND KeyID=1", objCnn)
                Dim bolEnablePrefinish As Boolean = False
                If ChkPrefinish.Rows.Count > 0 Then
                    If ChkPrefinish.Rows(0)("PropertyValue") <> 0 Then
                        bolEnablePrefinish = True
                    End If
                End If
                If bolEnablePrefinish = False Then
                    typeTable = getInfo.GetMaterialType(1, Session("LangID"), objCnn)
                Else
                    typeTable = getInfo.GetMaterialType(0, Session("LangID"), objCnn)
                End If
                'typeTable = getInfo.GetMaterialType(1,Session("LangID"),objCnn)
		
                Dim MaterialLevelString As String = ""
                Dim MaterialGroupString As String = ""
                Dim MaterialDeptString As String = ""
                Dim MaterialTypeString As String = ""
                Dim MaterialUnitString As String = ""
		
                If levelTable.Rows.Count > 1 Then
                    For i = 0 To levelTable.Rows.Count - 1
                        If IDValue = levelTable.Rows(i)("MaterialLevelID") Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        MaterialLevelString += "<option value=""" & levelTable.Rows(i)("MaterialLevelID") & """ " & FormSelected & ">" & levelTable.Rows(i)("MaterialLevelName")
                    Next
                Else
                    levelRow.Visible = False
                End If
                
                For i = 0 To groupTable.Rows.Count - 1
                    If GroupIDValue = groupTable.Rows(i)("MaterialGroupID") Then
                        FormSelected = "selected"
                    Else
                        FormSelected = ""
                    End If
                    MaterialGroupString += "<option value=""" & groupTable.Rows(i)("MaterialGroupID") & """ " & FormSelected & ">" & groupTable.Rows(i)("MaterialGroupName")
                Next

                For i = 0 To deptTable.Rows.Count - 1
                    If GroupIDValue = deptTable.Rows(i)("MaterialGroupID") Then
                        If DeptIDValue = deptTable.Rows(i)("MaterialDeptID") Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        MaterialDeptString += "<option value=""" & deptTable.Rows(i)("MaterialDeptID") & """ " & FormSelected & ">" & deptTable.Rows(i)("MaterialDeptName")
                    End If
                Next
		
                EditUnit = True
                
                
                '  POSDBSQLFront.POSUtilSQL.InsertErrorDetail(objDB, objCnn, "Unit")

                'Load All Unit Into Combo --> Only For Old Setting
                If ShowOldUnit.Visible = True Then
                    Dim UnitTable As New DataTable()
                    unitTable = getInfo.GetUnitInfo(0, 0, objCnn) 'getInfo.GetUnit(1,0,objCnn)
                    Dim DummyUnitSmallID As Integer = 0
                    Dim UnitString As String = ""
                    For i = 0 To unitTable.Rows.Count - 1
                        If UnitIDValue = unitTable.Rows(i)("UnitSmallID") Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        If (EditUnit = True Or (EditUnit = False And FormSelected = "selected")) Then
                            If DummyUnitSmallID <> unitTable.Rows(i)("UnitSmallID") Then
                                UnitString = unitTable.Rows(i)("UnitSmallID").ToString + ":" + unitTable.Rows(i)("UnitSmallName") 'unitTable.Rows(i)("UnitSmallName") + ":" + unitTable.Rows(i)("UnitLargeName")
                                If MaterialID.Value <> 0 And UnitIDValue = unitTable.Rows(i)("UnitSmallID") Then
                                    SmallUnitText.InnerHtml = unitTable.Rows(i)("UnitSmallName")
                                End If
                            Else
                                UnitString += ":" + unitTable.Rows(i)("UnitLargeName")
                            End If
                            DummyUnitSmallID = unitTable.Rows(i)("UnitSmallID")
                            If i < unitTable.Rows.Count - 1 Then
                                If DummyUnitSmallID <> unitTable.Rows(i + 1)("UnitSmallID") Then
                                    MaterialUnitString += "<option value=""" & unitTable.Rows(i)("UnitSmallID") & """ " & FormSelected & ">" & UnitString
                                End If
                            Else
                                MaterialUnitString += "<option value=""" & unitTable.Rows(i)("UnitSmallID") & """ " & FormSelected & ">" & UnitString
                            End If
                        End If
                    Next
                End If
                
                If levelRow.Visible = True Then
                    If IDValue = 0 Then
                        FormSelected = "selected"
                    Else
                        FormSelected = ""
                    End If
                    LevelSelectionText.InnerHtml = "<select name=""MaterialLevelID"" onchange=""submit()""><option value=""0""" + FormSelected + ">" + textTable.Rows(18)("TextParamValue") + MaterialLevelString + "</select>"
                Else
                    MLevelText.InnerHtml = "<input type=""hidden"" name=""MaterialLevelID"" value=""" + levelTable.Rows(0)("MaterialLevelID").ToString + """>"
                End If
		
                If GroupIDValue = 0 Then
                    FormSelected = "selected"
                Else
                    FormSelected = ""
                End If
                GroupSelectionText.InnerHtml = "<select name=""MaterialGroupID"" onchange=""submit()"" style=""width:200px""><option value=""0""" + FormSelected + ">" + textTable.Rows(31)("TextParamValue") + MaterialGroupString + "</select>"
		
                If DeptIDValue = 0 Then
                    FormSelected = "selected"
                Else
                    FormSelected = ""
                End If
                DeptSelectionText.InnerHtml = "<select name=""MaterialDeptID"" onchange=""submit()"" style=""width:200px""><option value=""0""" + FormSelected + ">" + textTable.Rows(43)("TextParamValue") + MaterialDeptString + "</select>"
		
                If MaterialID.Value > 0 Then
                    For i = 0 To typeTable.Rows.Count - 1
                        If typeTable.Rows(i)("MaterialTypeID") = TypeIDValue Then
                            TypeSelectionText.InnerHtml = typeTable.Rows(i)("MaterialTypeName") + "<input type=""hidden"" name=""MaterialTypeID"" value=""" + TypeIDValue.ToString + """>"
                        End If
                    Next
                Else
                    For i = 0 To typeTable.Rows.Count - 1
                        If TypeIDValue = typeTable.Rows(i)("MaterialTypeID") Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        MaterialTypeString += "<option value=""" & typeTable.Rows(i)("MaterialTypeID") & """ " & FormSelected & ">" & typeTable.Rows(i)("MaterialTypeName")
                    Next
                    
                    If TypeIDValue = 0 Then
                        FormSelected = "selected"
                    Else
                        FormSelected = ""
                    End If
                    If PropertyInfo.Rows(0)("SystemEditionID") = 1 Then
                        TypeSelectionText.InnerHtml = "<select name=""MaterialTypeID"" style=""width:200px"">" + MaterialTypeString + "</select>"
                    Else
                        TypeSelectionText.InnerHtml = "<select name=""MaterialTypeID"" style=""width:200px""><option value=""0""" + FormSelected + ">" + textTable.Rows(48)("TextParamValue") + MaterialTypeString + "</select>"
                    End If
                End If
                                
                If UnitIDValue = 0 Then
                    FormSelected = "selected"
                Else
                    FormSelected = ""
                End If
                If EditUnit = True Then
                    UnitSelectionText.InnerHtml = "<select name=""UnitSmallID"" style=""width:200px""><option value=""0""" + FormSelected + ">" + textTable.Rows(52)("TextParamValue") + MaterialUnitString + "</select>"
                Else
                    UnitSelectionText.InnerHtml = "<select name=""UnitSmallID"" style=""width:200px"">" + MaterialUnitString + "</select>"
                End If
		               
                If Page.IsPostBack Then
                    validateLevel.InnerHtml = ""
                    validateGroup.InnerHtml = ""
                    validateDept.InnerHtml = ""
			
                    If Not IsNumeric(Request.Form("MaterialLevelID")) Or Request.Form("MaterialLevelID") = 0 Then
                        validateLevel.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(37)("TextParamValue") & "</td></tr>"
                    End If
                    If Not IsNumeric(Request.Form("MaterialGroupID")) Or Request.Form("MaterialGroupID") = 0 Then
                        validateGroup.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(38)("TextParamValue") & "</td></tr>"
                    End If
                    If Not IsNumeric(Request.Form("MaterialDeptID")) Or Request.Form("MaterialDeptID") = 0 Then
                        validateDept.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(49)("TextParamValue") & "</td></tr>"
                    End If
                End If
                Dim outputString As StringBuilder
                Dim Checked As String = ""
                Dim DChecked As String = ""
                Dim UnitText As String = ""
                
                Dim bgColor As String = "white"
                Dim UnitRows As Integer = 5
                If PropertyInfo.Rows(0)("SystemEditionID") = 1 Then
                    UnitRows = 1
                End If
                outputString = New StringBuilder
                Dim selDocType As Integer
                Dim dtMaterialUnit, dtUnitInfo As DataTable
                Dim rResult() As DataRow
                dtUnitInfo = New DataTable
                dtMaterialUnit = getInfo.GetMaterialAllInvenUnitAndUnitInfo(objCnn, 1, MaterialID.Value, dtUnitInfo)
                
                For i = 0 To UnitRows
                    If i Mod 2 = 0 Then
                        bgColor = "white"
                    Else
                        bgColor = "#e1e1e1"
                    End If
                        
                    'PO Document
                    selDocType = 1
                    SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit, dtUnitInfo, i, selDocType, Checked, DChecked)
                    outputString.Append("<tr bgColor=""" + bgColor + """>")
                    outputString.Append("<td class=""text"" align=""center""><input type=""Radio"" value=""" + i.ToString + """ name=""UnitDefault_1""" + DChecked + "></td>")
                    outputString.Append("<td class=""text"" align=""center""><input type=""checkbox"" value=""1"" name=""UnitLargeID_1_" + i.ToString + """" + Checked + "></td>")
                    outputString.Append("<td></td>")
			
                    'Stock Count Document
                    selDocType = 7
                    SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit, dtUnitInfo, i, selDocType, Checked, DChecked)
                    outputString.Append("<td class=""text"" align=""center""><input type=""Radio"" value=""" + i.ToString + """ name=""UnitDefault_7""" + DChecked + "></td>")
                    outputString.Append("<td class=""text"" align=""center""><input type=""checkbox"" value=""1"" name=""UnitLargeID_7_" + i.ToString + """" + Checked + "></td>")
                    outputString.Append("<td></td>")

                    'DRO Document
                    selDocType = 39
                    SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit, dtUnitInfo, i, selDocType, Checked, DChecked)
                    outputString.Append("<td class=""text"" align=""center""><input type=""Radio"" value=""" + i.ToString + """ name=""UnitDefault_39""" + DChecked + "></td>")
                    outputString.Append("<td class=""text"" align=""center""><input type=""checkbox"" value=""1"" name=""UnitLargeID_39_" + i.ToString + """" + Checked + "></td>")
                    outputString.Append("<td></td>")
			
                    If PropertyInfo.Rows(0)("SystemEditionID") <> 1 Then
                        'Transfer Document
                        selDocType = 3
                        SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit, dtUnitInfo, i, selDocType, Checked, DChecked)
                        outputString.Append("<td class=""text"" align=""center""><input type=""Radio"" value=""" + i.ToString + """ name=""UnitDefault_3""" + DChecked + "></td>")
                        outputString.Append("<td class=""text"" align=""center""><input type=""checkbox"" value=""1"" name=""UnitLargeID_3_" + i.ToString + """" + Checked + "></td>")
                        outputString.Append("<td></td>")
			
                        'Request Document
                        selDocType = 17
                        SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit, dtUnitInfo, i, selDocType, Checked, DChecked)
                        outputString.Append("<td class=""text"" align=""center""><input type=""Radio"" value=""" + i.ToString + """ name=""UnitDefault_17""" + DChecked + "></td>")
                        outputString.Append("<td class=""text"" align=""center""><input type=""checkbox"" value=""1"" name=""UnitLargeID_17_" + i.ToString + """" + Checked + "></td>")
                        outputString.Append("<td></td>")
                    End If
                    'Adjust Document
                    selDocType = 0
                    SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit, dtUnitInfo, i, selDocType, Checked, DChecked)
                    outputString.Append("<td class=""text"" align=""center""><input type=""Radio"" value=""" + i.ToString + """ name=""UnitDefault_0""" + DChecked + "></td>")
                    outputString.Append("<td class=""text"" align=""center""><input type=""checkbox"" value=""1"" name=""UnitLargeID_0_" + i.ToString + """" + Checked + "></td>")
                    outputString.Append("<td></td>")
			
                    If PropertyInfo.Rows(0)("SystemEditionID") <> 1 Then
                        'Prefinish Document
                        selDocType = 26
                        SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit, dtUnitInfo, i, selDocType, Checked, DChecked)
                        outputString.Append("<td class=""text"" align=""center""><input type=""Radio"" value=""" + i.ToString + """ name=""UnitDefault_26""" + DChecked + "></td>")
                        outputString.Append("<td class=""text"" align=""center""><input type=""checkbox"" value=""1"" name=""UnitLargeID_26_" + i.ToString + """" + Checked + "></td>")
			  
                        outputString.Append("<td></td>")
                    End If
                    'UnitName
                    If dtUnitInfo.Rows.Count > i Then
                        If IsDBNull(dtUnitInfo.Rows(i)("UnitLargeName")) Then
                            dtUnitInfo.Rows(i)("UnitLargeName") = ""
                        End If
                        UnitText = dtUnitInfo.Rows(i)("UnitLargeName")
                    Else
                        If i = 0 Then
                            UnitText = "Small Unit"
                        Else
                            UnitText = "Large " & i
                        End If
                    End If
                    outputString.Append("<td class=""text"">" + UnitText + "</td>")
                    outputString.Append("</tr>")
                Next i
                
                ResultText.InnerHtml = outputString.ToString
		
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
        validateCode.InnerHtml = ""
        validateName.InnerHtml = ""
        validateLevel.InnerHtml = ""
        validateGroup.InnerHtml = ""
        validateDept.InnerHtml = ""
        validateType.InnerHtml = ""
        validateMinStock.InnerHtml = ""
        validateUnit.InnerHtml = ""
	
        If UnitNew.Value = 1 Then
            If Trim(USmall.Text) = "" Then
                validateNewUnit.InnerHtml = "<tr><td></td><td class=""errorText"">" & "Unit Small Name must be filled before submission" & "</td></tr>"
                FoundError = True
            End If
        Else
            If Not IsNumeric(Request.Form("UnitSmallID")) Then
                validateUnit.InnerHtml = "<tr><td></td><td class=""errorText"">" & "Unit must be selected before submission" & "</td></tr>"
                FoundError = True
            ElseIf Request.Form("UnitSmallID") <= 0 Then
                validateUnit.InnerHtml = "<tr><td></td><td class=""errorText"">" & "Unit must be selected before submission" & "</td></tr>"
                FoundError = True
            End If
        End If
	
        If Not IsNumeric(Request.Form("MinimumStock")) Then
            validateMinStock.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(55)("TextParamValue") & "</td></tr>"
            FoundError = True
        ElseIf Request.Form("MinimumStock") < 0 Then
            validateMinStock.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(57)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
	
        If Not IsNumeric(Request.Form("MaterialLevelID")) Or Request.Form("MaterialLevelID") = 0 Then
            validateLevel.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(37)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If Not IsNumeric(Request.Form("MaterialGroupID")) Or Request.Form("MaterialGroupID") = 0 Then
            validateGroup.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(38)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If Not IsNumeric(Request.Form("MaterialDeptID")) Or Request.Form("MaterialDeptID") = 0 Then
            validateDept.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(49)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If Not IsNumeric(Request.Form("MaterialTypeID")) Or Request.Form("MaterialTypeID") = 0 Then
            validateType.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(50)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
	

        If Len(Trim(MaterialName.Text)) = 0 Then
            validateName.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(35)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If Len(Trim(MaterialCode.Text)) = 0 Then
            validateCode.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(36)("TextParamValue") & "</td></tr>"
            FoundError = True
        ElseIf MaterialCode_Old.Value = "" Or (MaterialCode_Old.Value <> MaterialCode.Text) Then
            Dim ChkExist As DataTable
            ChkExist = getCnn.List("SELECT * FROM Materials WHERE Deleted=0 AND MaterialCode='" + Trim(MaterialCode.Text + "'"), objCnn)
            If ChkExist.Rows.Count > 0 Then
                validateCode.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(54)("TextParamValue") & "</td></tr>"
                FoundError = True
            End If
        End If
        If FoundError = False Then
            Dim Result As String
            Dim ExtraSQL(1) As String
            Dim TimeNow, TaxOption, StockType As String
            TimeNow = DateTimeUtil.CurrentDateTime
            ExtraSQL(0) = ""
            ExtraSQL(1) = ""
		
            If VATOut.Checked = True Then
                TaxOption = "1"
            ElseIf VATIn.Checked = True Then
                TaxOption = "2"
            Else
                TaxOption = "0"
            End If
		
            If Daily.Checked = True Then
                StockType = "1"
            ElseIf Monthly.Checked = True Then
                StockType = "0"
            Else
                StockType = "-1"
            End If
		
            If MaterialID.Value = 0 Then
                ExtraSQL(0) = "InsertDate,UpdateDate,MaterialTaxType,StockType"
                ExtraSQL(1) = TimeNow + "," + TimeNow + "," + TaxOption + "," + StockType
            Else
                ExtraSQL(0) = "UpdateDate=" + TimeNow + ",MaterialTaxType=" + TaxOption + ",StockType=" + StockType
            End If
		
            Application.Lock()
            Result = getInfo.AddUpdateCategory(Request, ExtraSQL, "Materials", "MaterialID", objCnn)
            If UnitNew.Value = 1 Then
                getInfo.UpdateUnitSetting(Request, objCnn)
                getInfo.MaterialInvenUnit_Update(1, Request, objCnn)
            End If
            Application.UnLock()
            If Result = "Success" Then
                Response.Redirect("material_category.aspx?" + Request.QueryString.ToString)
            Else
                errorMsg.InnerHtml = Result
            End If

        End If
    End Sub

    Private Sub SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit As DataTable, dtUnitInfo As DataTable, unitIndex As Integer, selDocType As Integer, _
    ByRef strChecked As String, ByRef strDefaultChecked As String)
        Dim rResult() As DataRow
        strChecked = ""
        strDefaultChecked = ""
        If dtUnitInfo.Rows.Count > unitIndex Then
            rResult = dtMaterialUnit.Select("SelectUnitLargeID = " & dtUnitInfo.Rows(unitIndex)("UnitLargeID") & " AND DocumentTypeID = " & selDocType)
            If rResult.Length > 0 Then
                strChecked = " checked"
                If rResult(0)("IsDefault") = 1 Then
                    strDefaultChecked = " checked"
                End If
            End If
        End If
    End Sub
    
    
    Sub DoCancel(Source As Object, E As EventArgs)
        Response.Redirect("material_category.aspx?" + Request.QueryString.ToString)
    End Sub

    Sub Page_UnLoad()
        objCnn.Close()
    End Sub
</script>
</body>
</html>
