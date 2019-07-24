<%@ Page Language="VB" ContentType="text/html" EnableViewState="true" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="DynamicProperty" %>
<html>
<head>
<title>Manage Computer</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form id="mainForm" runat="server">
<input type="hidden" id="ComputerID" runat="server" />
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
<table id="myTable" class="blue" width="100%">

<thead>
	<tr>
		<th align="center"><asp:Label ID="LangText1" Text="Description" runat="server" /></th>
		<th align="center"><asp:Label ID="LangText2" Text="Value" runat="server" /></th>
	</tr>
</thead>
<tbody>

<div id="validateLevel" runat="server" />
<tr id="levelRow" runat="server">
	<td><div class="requireText" id="LevelParam" runat="server"></div></td>
	<td><div id="SelectionText" runat="server"></div></td>
</tr>
<div id="validateName" runat="server" />
<tr>
	<td><asp:Label ID="LangText3" Text="Computer Name" CssClass="requireText" runat="server" /></td>
	<td><asp:textbox ID="ComputerName" Width="200" runat="server" /></td>
</tr>

<tr>
	<td class="text">Computer Code</td>
	<td><asp:textbox ID="Description" Width="200" runat="server" /></td>
</tr>

<tr>
	<td><asp:Label ID="LangText4" Text="Is Main Computer" runat="server" /></td>
	<td class="text"><input type="radio" id="Radio33" name="IsMainComputer" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio34" name="IsMainComputer" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td><asp:Label ID="LangText5" Text="Has Second Display" runat="server" /></td>
	<td class="text"><input type="radio" id="Radio35" name="IsSecondDisplay" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio36" name="IsSecondDisplay" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td><div class="text" id="RegisParam" runat="server"></div></td>
	<td><asp:textbox ID="RegistrationNumber" Width="200" runat="server" /></td>
</tr>

<tr id="DisplayComputerType" visible="false" runat="server">
	<td><div class="text" id="ComputerTypeParam" runat="server"></div></td>
	<td><asp:dropdownlist ID="ComputerType" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
                            <asp:listitem></asp:listitem>
                            <asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
</tr>

<div id="ShowDeviceCode" runat="server">
<tr>
	<td><div class="text" id="DeviceCodeParam" runat="server"></div></td>
	<td><asp:textbox ID="DeviceCode" Width="300" MaxLength="50" runat="server" /></td>
</tr>
</div>

<tr>
	<td><div class="text" id="PrinterNameParam" runat="server"></div></td>
	<td><asp:textbox ID="PrinterName" Width="200" runat="server" /></td>
</tr>

<tr>
	<td><div class="text" id="ShortenBillParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio1" name="ShortenBillWhenCheckbill" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio2" name="ShortenBillWhenCheckbill" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td><div class="text" id="PrintToKithenParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio7" name="PrintToKitchen" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio8" name="PrintToKitchen" value="0" runat="server" />NO&nbsp;&nbsp;<input type="radio" id="Radio888" name="PrintToKitchen" value="2" runat="server" />YES (Print After Receipt for Fast Food)</td>
</tr>

<tr>
	<td><div class="text" id="PrintToKithenNotPrintParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio7_1" name="ShowNotPrintToKitchenButton" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio8_1" name="ShowNotPrintToKitchenButton" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td><div class="text" id="PrintBillDetailParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio9" name="PrintBillDetail" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio10" name="PrintBillDetail" value="0" runat="server" />NO&nbsp;&nbsp;<input type="radio" id="Radio100" name="PrintBillDetail" value="2" runat="server" />YES (Required password if print more than once)&nbsp;&nbsp;<input type="radio" id="Radio1000" name="PrintBillDetail" value="3" runat="server" />Show Bill Detail</td>
</tr>
<tr>
	<td><div class="text" id="CheckCCParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio11" name="CheckCreditCardDetail" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio12" name="CheckCreditCardDetail" value="0" runat="server" />NO&nbsp;&nbsp;<input type="radio" id="Radio11_1" name="CheckCreditCardDetail" value="2" runat="server" />YES (Only CC Type)</td>
</tr>
<tr>
	<td><div class="text" id="IsTouchScreenParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio13" name="IsTouchScreen" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio14" name="IsTouchScreen" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td><div class="text" id="ShowFastPayButtonParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio17" name="ShowFastPayButton" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio18" name="ShowFastPayButton" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td class="text">Print Discount Detail in Receipt</td>
	<td class="text"><input type="radio" id="Radio21" name="PrintDiscountDetailInBill" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio22" name="PrintDiscountDetailInBill" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td class="text">Enable Print Receipt Copy</td>
	<td class="text"><input type="radio" id="Radio26" name="PrintReceiptHasCopy" value="0" runat="server" />NO&nbsp;&nbsp;<input type="radio" id="Radio25" name="PrintReceiptHasCopy" value="2" runat="server" />2 copies&nbsp;&nbsp;<input type="radio" id="Radio25_1" name="PrintReceiptHasCopy" value="3" runat="server" />3 copies&nbsp;&nbsp;<input type="radio" id="Radio25_2" name="PrintReceiptHasCopy" value="99" runat="server" />Pop Up to select no. of copy</td>
</tr>

<tr>
	<td class="text">Enable Card Reader Feature</td>
	<td class="text"><input type="radio" id="Radio23" name="ComputerHasBarCodeReader" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio24" name="ComputerHasBarCodeReader" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td><div class="text" id="PrintVoidOptionParam" runat="server"></div></td>
	<td class="text"><div id="PrintVoidOrderOptionList" runat="server"></div></td>
</tr>

<tr>
	<td><div class="text" id="PrintMoveOptionParam" runat="server"></div></td>
	<td class="text"><div id="PrintMoveOrderOptionList" runat="server"></div></td>
</tr>

<tr>
	<td><div class="text" id="PrintReceiptParam" runat="server"></div></td>
	<td class="text"><div id="PrintReceiptOptionList" runat="server"></div></td>
</tr>

<div id="validatePaymentList" runat="server" />
<tr>
	<td><div class="text" id="PaymentTypeListParam" runat="server"></div></td>
	<td><div id="PaymentTypeList" class="text" runat="Server"></div></td>
</tr>

<div id="validatePaymentDefault" runat="server" />
<tr>
	<td><div class="text" id="PaymentDefaultParam" runat="server"></div></td>
	<td><div id="PaymentDefault" runat="Server"></div></td>
</tr>

<div id="validateDiscountList" runat="server" />
<tr>
	<td><div class="text" id="DiscountListParam" runat="server"></div></td>
	<td><div id="DiscountList" class="text" runat="Server"></div></td>
</tr>

<tr>
	<td><div class="text" id="DefaultSearchMemberParam" runat="server"></div></td>
	<td class="text"><div id="DefaultSearchMemberOptionList" runat="server"></div></td>
</tr>

<tr>
	<td><div class="text" id="DefaultOpenTranParam" runat="server"></div></td>
	<td><asp:dropdownlist ID="DefaultEditCustomerDetail" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
</tr>

<div id="ShowComputerReceipt" runat="Server">
<tr>
	<td><div class="text">Receipt Header</div></td>
	<td><asp:textbox ID="DocumentTypeHeader" Width="100" runat="server" /></td>
</tr>
<tr>
	<td><div class="text">Full Tax Header</div></td>
	<td><asp:textbox ID="DocumentTypeHeaderFT" Width="100" runat="server" /></td>
</tr>
<tr>
	<td><div class="text">Credit Money Header</div></td>
	<td><asp:textbox ID="DocumentTypeHeaderCM" Width="100" runat="server" /></td>
</tr>
<tr>
	<td><div class="text">Deposit Header</div></td>
	<td><asp:textbox ID="DocumentTypeHeaderDP" Width="100" runat="server" /></td>
</tr>
</div>
<tr>
	<td><div class="text">IP Address</div></td>
	<td><asp:textbox ID="IPAddress" Width="150" runat="server" /></td>
</tr>
<div id="ShowWireless" visible="false" runat="server">
<tr>
	<td><div class="text" id="IsWirelessFeatureParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio19" name="IsWirelessFeature" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio20" name="IsWirelessFeature" value="0" runat="server" />NO</td>
</tr>
</div>

<span id="DynamicPropUser" runat="server"></span>
</tbody>
</table>
<br>

<div id="ShowAdmin" visible="false" runat="server">
<table id="myTable" class="blue" width="100%">
<thead>
	<tr>
		<th class="boldText" colspan="4" align="left">Administration Area</td>
	</tr>
	<tr>
    	<th align="center"><asp:Label ID="LangText28" Text="TypeID" runat="server" /></th>
		<th align="center"><asp:Label ID="LangText29" Text="ID" runat="server" /></th>
		<th align="center"><asp:Label ID="LangText26" Text="Description" runat="server" /></th>
		<th align="center"><asp:Label ID="LangText27" Text="Value" runat="server" /></th>
	</tr>
</thead>
<tbody>

<tr>
	<td class="text" valign="top">-</td>
    <td class="text" valign="top">-</td>
	<td><div class="text" id="POSFunctionParam" runat="server"></div></td>
	<td class="text"><div id="POSFunctionOptionList" runat="server"></div></td>
</tr>
<tr id="ShowComputerSystemType" visible="true" runat="server">
	<td class="text" valign="top">-</td>
    <td class="text" valign="top">-</td>
	<td class="text" valign="top">Computer Order Interface</td>
	<td class="text"><asp:DropDownList ID="ShopTypeForThisComputer" Width="200" CssClass="text" runat="server" /></td>
</tr>
<tr id="posdate" visible="false" runat="server">
	<td><div class="text" id="DisplayPOSDateParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio3" name="CanChangeTransactionDate" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio4" name="CanChangeTransactionDate" value="0" runat="server" />NO</td>
</tr>

<tr id="autoclose" visible="false" runat="server">
	<td class="text" valign="top">-</td>
    <td class="text" valign="top">-</td>
	<td><div class="text" id="CloseSessionParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio5" name="CloseYesterdaySession" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio6" name="CloseYesterdaySession" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td class="text" valign="top">-</td>
    <td class="text" valign="top">-</td>
	<td><div class="text" id="RecordInOrderBookParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio15" name="RecordInOrderBook" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio16" name="RecordInOrderBook" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td class="text" valign="top">-</td>
    <td class="text" valign="top">-</td>
	<td class="text">Reprint Bill Option</td>
	<td class="text"><input type="radio" id="Radio27" name="RePrintBillOption" value="2" runat="server" />YES (With Authorization)&nbsp;&nbsp;<input type="radio" id="Radio28" name="RePrintBillOption" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio29" name="RePrintBillOption" value="0" runat="server" />NO</td>
</tr>
<tr>
	<td class="text" valign="top">-</td>
    <td class="text" valign="top">-</td>
	<td class="text">Reprint Order Option</td>
	<td class="text"><input type="radio" id="Radio30" name="RePrintOrderOption" value="2" runat="server" />YES (With Authorization)&nbsp;&nbsp;<input type="radio" id="Radio31" name="RePrintOrderOption" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio32" name="RePrintOrderOption" value="0" runat="server" />NO</td>
</tr>

<span id="DynamicPropAdmin" runat="server"></span>

</tbody>
</table>
</div>

<table width="100%">
<tr>
	<td colspan="2" height="5"></td>
</tr>
<tr>
	<td colspan="2" align="center"><asp:button ID="SubmitForm" OnClick="DoAddUpdate" Enabled="false" runat="server" />&nbsp;&nbsp;&nbsp;<asp:button ID="CancelForm" OnClick="DoCancel" Enabled="false" runat="server" /></td>
</tr>
<tr id="ShowMsg" visible="True" runat="server">
	<td>&nbsp;</td>
	<td class="boldText">The configuration is not permit to edit this computer data!</td>
</tr>
</table>
</form>

<div id="errorMsg" runat="server" />
<div id="errorMsg1" runat="server" />
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
Dim getData As New CPreferences()
Dim objDB As New CDBUtil()
Dim Prop As New ConfigProperty()

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Manage_Computer") Then
	
            Try
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
                errorMsg.InnerHtml = ""
                objCnn = getCnn.EstablishConnection()
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(9, Session("LangID"), objCnn)
			
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
                Dim getProp As DataTable
                getProp = getData.PropertyInfo(1, objCnn)
                If getProp.Rows(0)("FrontSystemType") = 1 Then
                    ShowComputerReceipt.Visible = True
                Else
                    ShowComputerReceipt.Visible = False
                End If
                If getProp.Rows(0)("HotSpotFeature") = 1 Then
                    ShowWireless.Visible = True
                End If
			
                If getProp.Rows(0)("PocketPCFeature") = 1 Then
                    DisplayComputerType.Visible = True
                End If
			
                If Session("StaffRole") = 1 Then
                    ShowAdmin.Visible = True
                End If
			
                If getProp.Rows(0)("HeadOrBranch") = 0 Then
                    If Session("StaffRole") = 1 Or Session("StaffRole") = 2 Then
                        ShowMsg.Visible = False
                        SubmitForm.Enabled = True
                        CancelForm.Enabled = True
                    End If
                End If
			
                Dim NotExist As Boolean = getData.CheckTableColumn("ComputerName", "ShopTypeForThisComputer", objCnn)
                If NotExist = True Then
                    ShowComputerSystemType.Visible = False
                End If
			
                ShowDeviceCode.Visible = False
			
                Dim ColExist As Boolean = getData.TableColCheck("ComputerName", "DeviceCode", objCnn)
			
                If ColExist = True Then
                    ShowDeviceCode.Visible = True
                End If
			
                If getProp.Rows(0)("SystemEditionID") <> 3 Then
                    ShowComputerSystemType.Visible = False
                End If
			
                If getProp.Rows(0)("SystemTypeID") < 0 And getProp.Rows(0)("SystemTypeID") > 2 Then
                    ShowComputerSystemType.Visible = False
                End If
			
                Dim SystemType As DataTable = objDB.List("select 0 As SystemTypeID,'--- Select Interface Type---' As SystemTypeDesp UNION select SystemTypeID,SystemTypeDesp from SystemType where SystemTypeID IN (1,2)", objCnn)
                ShopTypeForThisComputer.DataSource = SystemType
                ShopTypeForThisComputer.DataValueField = "SystemTypeID"
                ShopTypeForThisComputer.DataTextField = "SystemTypeDesp"
                ShopTypeForThisComputer.DataBind()
				
                CancelForm.Text = defaultTextTable.Rows(2)("TextParamValue")
                LevelParam.InnerHtml = textTable.Rows(59)("TextParamValue")
                RegisParam.InnerHtml = "Registration Number"
                HeaderText.InnerHtml = textTable.Rows(66)("TextParamValue")
			
                ShortenBillParam.InnerHtml = textTable.Rows(70)("TextParamValue")
                DisplayPOSDateParam.InnerHtml = textTable.Rows(71)("TextParamValue")
                CloseSessionParam.InnerHtml = textTable.Rows(72)("TextParamValue")
                'DrawerPortParam.InnerHtml = textTable.Rows(73)("TextParamValue")
                PaymentTypeListParam.InnerHtml = textTable.Rows(74)("TextParamValue")
                PaymentDefaultParam.InnerHtml = textTable.Rows(75)("TextParamValue")
                PrintToKithenParam.InnerHtml = textTable.Rows(76)("TextParamValue")
                PrintReceiptParam.InnerHtml = textTable.Rows(77)("TextParamValue")
                PrinterNameParam.InnerHtml = textTable.Rows(78)("TextParamValue")
                DiscountListParam.InnerHtml = textTable.Rows(81)("TextParamValue")
                PrintBillDetailParam.InnerHtml = textTable.Rows(83)("TextParamValue")
                CheckCCParam.InnerHtml = textTable.Rows(84)("TextParamValue")
                IsTouchScreenParam.InnerHtml = textTable.Rows(85)("TextParamValue")
                RecordInOrderBookParam.InnerHtml = textTable.Rows(86)("TextParamValue")
                ShowFastPayButtonParam.InnerHtml = textTable.Rows(87)("TextParamValue")
                POSFunctionParam.InnerHtml = "POS Function"
                DefaultSearchMemberParam.InnerHtml = "Default Search Member Page"
                IsWirelessFeatureParam.InnerHtml = "Hotspot Internet"
                ComputerTypeParam.InnerHtml = "Computer Type"
                DefaultOpenTranParam.InnerHtml = "Default Cursor When Open Transaction"
                PrintToKithenNotPrintParam.InnerHtml = "Show Submit Order wihtout Printing"
			
                PrintVoidOptionParam.InnerHtml = "Print Void Order Option"
                PrintMoveOptionParam.InnerHtml = "Print Move Order Option"
                DeviceCodeParam.InnerHtml = "Device Code"

                Dim IDValueFromDB, PayTypeIDValueFromDB, ReceiptValueFromDB, POSFunctionFromDB, DefaultSearchMemberFromDB, VoidOrderValueFromDB, MoveOrderValueFromDB As Integer
                Dim PayTypeListFromDB As String = ""
                Dim DiscountTypeListFromDB As String = ""
			
                ComputerType.Items(0).Text = "Computer"
                ComputerType.Items(0).Value = "0"
                ComputerType.Items(1).Text = "Tablet Device"
                ComputerType.Items(1).Value = "2"
                ComputerType.Items(2).Text = "KDS Station"
                ComputerType.Items(2).Value = "3"
                ComputerType.Items(3).Text = "Queue Terminal"
                ComputerType.Items(3).Value = "4"
			
                DefaultEditCustomerDetail.Items(0).Text = "Default to Regular Customer"
                DefaultEditCustomerDetail.Items(0).Value = "1"
                DefaultEditCustomerDetail.Items(1).Text = "Default to Member"
                DefaultEditCustomerDetail.Items(1).Value = "2"
                DefaultEditCustomerDetail.Items(2).Text = "Default to Number of Customer"
                DefaultEditCustomerDetail.Items(2).Value = "3"
                DefaultEditCustomerDetail.Items(3).Text = "Default to Sale Staff"
                DefaultEditCustomerDetail.Items(3).Value = "4"
			
                Dim j As Integer
			
                If Not Request.QueryString("ComputerID") And IsNumeric(Request.QueryString("ComputerID")) Then
			
                    If Not Page.IsPostBack Then
                        ComputerID.Value = Request.QueryString("ComputerID")
			
                        Dim getInfo As DataTable
                        getInfo = getData.ComputerInfo(0, ComputerID.Value, objCnn)
                        Dim getReceipt As DataTable = getData.ComputerReceipt(ComputerID.Value, 8, Session("LangID"), objCnn)
                        If getReceipt.Rows.Count > 0 Then
                            If Not IsDBNull(getReceipt.Rows(0)("DocumentTypeHeader")) Then
                                DocumentTypeHeader.Text = getReceipt.Rows(0)("DocumentTypeHeader")
                            Else
                                DocumentTypeHeader.Text = ""
                            End If
                        End If
					
                        getReceipt = getData.ComputerReceipt(ComputerID.Value, 11, Session("LangID"), objCnn)
                        If getReceipt.Rows.Count > 0 Then
                            If Not IsDBNull(getReceipt.Rows(0)("DocumentTypeHeader")) Then
                                DocumentTypeHeaderFT.Text = getReceipt.Rows(0)("DocumentTypeHeader")
                            Else
                                DocumentTypeHeaderFT.Text = ""
                            End If
                        End If
					
                        getReceipt = getData.ComputerReceipt(ComputerID.Value, 33, Session("LangID"), objCnn)
                        If getReceipt.Rows.Count > 0 Then
                            If Not IsDBNull(getReceipt.Rows(0)("DocumentTypeHeader")) Then
                                DocumentTypeHeaderCM.Text = getReceipt.Rows(0)("DocumentTypeHeader")
                            Else
                                DocumentTypeHeaderCM.Text = ""
                            End If
                        End If
					
                        getReceipt = getData.ComputerReceipt(ComputerID.Value, 61, Session("LangID"), objCnn)
                        If getReceipt.Rows.Count > 0 Then
                            If Not IsDBNull(getReceipt.Rows(0)("DocumentTypeHeader")) Then
                                DocumentTypeHeaderDP.Text = getReceipt.Rows(0)("DocumentTypeHeader")
                            Else
                                DocumentTypeHeaderDP.Text = ""
                            End If
                        End If
					
                        Dim EditName As String = ""
                        If getInfo.Rows.Count > 0 Then
						
                            For j = 0 To SystemType.Rows.Count - 1
                                If getInfo.Rows(0)("ShopTypeForThisComputer") = SystemType.Rows(j)("SystemTypeID") Then
                                    ShopTypeForThisComputer.Items(j).Selected = True
                                End If
                            Next
				
                            ComputerName.Text = getInfo.Rows(0)("ComputerName")
						
                            If Not IsDBNull(getInfo.Rows(0)("Description")) Then
                                Description.Text = getInfo.Rows(0)("Description")
                            End If
						
                            If ShowDeviceCode.Visible = True Then
                                If Not IsDBNull(getInfo.Rows(0)("DeviceCode")) Then
                                    DeviceCode.Text = getInfo.Rows(0)("DeviceCode")
                                End If
                            End If
						
                            If getInfo.Rows(0)("ComputerType") = 0 Then
                                ComputerType.Items(0).Selected = True
                            ElseIf getInfo.Rows(0)("ComputerType") = 2 Then
                                ComputerType.Items(1).Selected = True
                            ElseIf getInfo.Rows(0)("ComputerType") = 3 Then
                                ComputerType.Items(2).Selected = True
                            ElseIf getInfo.Rows(0)("ComputerType") = 4 Then
                                ComputerType.Items(3).Selected = True
                            Else
                                ComputerType.Items(0).Selected = True
                            End If
						
                            For j = 0 To 3
                                If getInfo.Rows(0)("DefaultEditCustomerDetail") = DefaultEditCustomerDetail.Items(j).Value Then
                                    DefaultEditCustomerDetail.Items(j).Selected = True
                                End If
                            Next
					
                            EditName = getInfo.Rows(0)("ComputerName")
                            If Not IsDBNull(getInfo.Rows(0)("ProductLevelID")) Then
                                IDValueFromDB = getInfo.Rows(0)("ProductLevelID")
                            End If
                            If Not IsDBNull(getInfo.Rows(0)("PayTypeDefault")) Then
                                PayTypeIDValueFromDB = getInfo.Rows(0)("PayTypeDefault")
                            End If
                            If Not IsDBNull(getInfo.Rows(0)("PrinterName")) Then
                                PrinterName.Text = getInfo.Rows(0)("PrinterName")
                            End If
                            If Not IsDBNull(getInfo.Rows(0)("RegistrationNumber")) Then
                                RegistrationNumber.Text = getInfo.Rows(0)("RegistrationNumber")
                            End If
                            If Not IsDBNull(getInfo.Rows(0)("PayTypeAvailable")) Then
                                PayTypeListFromDB = getInfo.Rows(0)("PayTypeAvailable")
                            End If
                            If Not IsDBNull(getInfo.Rows(0)("DiscountTypeAvailable")) Then
                                DiscountTypeListFromDB = getInfo.Rows(0)("DiscountTypeAvailable")
                            End If
                            If Not IsDBNull(getInfo.Rows(0)("PrintReceiptOption")) Then
                                ReceiptValueFromDB = getInfo.Rows(0)("PrintReceiptOption")
                            End If
                            If Not IsDBNull(getInfo.Rows(0)("POSFunction")) Then
                                POSFunctionFromDB = getInfo.Rows(0)("POSFunction")
                            End If
                            If Not IsDBNull(getInfo.Rows(0)("IPAddress")) Then
                                IPAddress.Text = getInfo.Rows(0)("IPAddress")
                            End If
						
                            If Not IsDBNull(getInfo.Rows(0)("PrintVoidOrderOption")) Then
                                VoidOrderValueFromDB = getInfo.Rows(0)("PrintVoidOrderOption")
                            End If
						
                            If Not IsDBNull(getInfo.Rows(0)("PrintMoveOrderOption")) Then
                                MoveOrderValueFromDB = getInfo.Rows(0)("PrintMoveOrderOption")
                            End If
						
                            If getInfo.Rows(0)("ShortenBillWhenCheckbill") = True Or getInfo.Rows(0)("ShortenBillWhenCheckbill") = 1 Then
                                Radio1.Checked = True
                            Else
                                Radio2.Checked = True
                            End If
                            If getInfo.Rows(0)("CanChangeTransactionDate") = True Or getInfo.Rows(0)("CanChangeTransactionDate") = 1 Then
                                Radio3.Checked = True
                            Else
                                Radio4.Checked = True
                            End If
                            If getInfo.Rows(0)("CloseYesterdaySession") = True Or getInfo.Rows(0)("CloseYesterdaySession") = 1 Then
                                Radio5.Checked = True
                            Else
                                Radio6.Checked = True
                            End If
                            If getInfo.Rows(0)("PrintToKitchen") = True Or getInfo.Rows(0)("PrintToKitchen") = 1 Then
                                Radio7.Checked = True
                            ElseIf getInfo.Rows(0)("PrintToKitchen") = 2 Then
                                Radio888.Checked = True
                            Else
                                Radio8.Checked = True
                            End If
                            If getInfo.Rows(0)("ShowNotPrintToKitchenButton") = True Or getInfo.Rows(0)("ShowNotPrintToKitchenButton") = 1 Then
                                Radio7_1.Checked = True
                            Else
                                Radio8_1.Checked = True
                            End If
                            If getInfo.Rows(0)("PrintBillDetail") = 1 Then
                                Radio9.Checked = True
                            ElseIf getInfo.Rows(0)("PrintBillDetail") = 2 Then
                                Radio100.Checked = True
                            ElseIf getInfo.Rows(0)("PrintBillDetail") = 3 Then
                                Radio1000.Checked = True
                            Else
                                Radio10.Checked = True
                            End If
                            If getInfo.Rows(0)("CheckCreditCardDetail") = 1 Then
                                Radio11.Checked = True
                            ElseIf getInfo.Rows(0)("CheckCreditCardDetail") = 2 Then
                                Radio11_1.Checked = True
                            Else
                                Radio12.Checked = True
                            End If
                            If getInfo.Rows(0)("IsTouchScreen") = True Or getInfo.Rows(0)("IsTouchScreen") = 1 Then
                                Radio13.Checked = True
                            Else
                                Radio14.Checked = True
                            End If
                            If getInfo.Rows(0)("RecordInOrderBook") = True Or getInfo.Rows(0)("RecordInOrderBook") = 1 Then
                                Radio15.Checked = True
                            Else
                                Radio16.Checked = True
                            End If
                            If getInfo.Rows(0)("ShowFastPayButton") = True Or getInfo.Rows(0)("ShowFastPayButton") = 1 Then
                                Radio17.Checked = True
                            Else
                                Radio18.Checked = True
                            End If
                            If getInfo.Rows(0)("IsWirelessFeature") = True Or getInfo.Rows(0)("IsWirelessFeature") = 1 Then
                                Radio19.Checked = True
                            Else
                                Radio20.Checked = True
                            End If
                            If getInfo.Rows(0)("PrintDiscountDetailInBill") = True Or getInfo.Rows(0)("PrintDiscountDetailInBill") = 1 Then
                                Radio21.Checked = True
                            Else
                                Radio22.Checked = True
                            End If
                            If getInfo.Rows(0)("ComputerHasBarCodeReader") = True Or getInfo.Rows(0)("ComputerHasBarCodeReader") = 1 Then
                                Radio23.Checked = True
                            Else
                                Radio24.Checked = True
                            End If
                            If getInfo.Rows(0)("PrintReceiptHasCopy") = 1 Or getInfo.Rows(0)("PrintReceiptHasCopy") = 0 Then
                                Radio26.Checked = True
                            ElseIf getInfo.Rows(0)("PrintReceiptHasCopy") = 2 Then
                                Radio25.Checked = True
                            ElseIf getInfo.Rows(0)("PrintReceiptHasCopy") = 3 Then
                                Radio25_1.Checked = True
                            ElseIf getInfo.Rows(0)("PrintReceiptHasCopy") = 99 Then
                                Radio25_2.Checked = True
                            Else
                                Radio26.Checked = True
                            End If
						
                            If getInfo.Rows(0)("RePrintBillOption") = 2 Then
                                Radio27.Checked = True
                            ElseIf getInfo.Rows(0)("RePrintBillOption") = 1 Then
                                Radio28.Checked = True
                            Else
                                Radio29.Checked = True
                            End If
                            If getInfo.Rows(0)("RePrintOrderOption") = 2 Then
                                Radio30.Checked = True
                            ElseIf getInfo.Rows(0)("RePrintOrderOption") = 1 Then
                                Radio31.Checked = True
                            Else
                                Radio32.Checked = True
                            End If
						
                            If getInfo.Rows(0)("IsMainComputer") = True Or getInfo.Rows(0)("IsMainComputer") = 1 Then
                                Radio33.Checked = True
                            Else
                                Radio34.Checked = True
                            End If
						
                            If getInfo.Rows(0)("IsSecondDisplay") = True Or getInfo.Rows(0)("IsSecondDisplay") = 1 Then
                                Radio35.Checked = True
                            Else
                                Radio36.Checked = True
                            End If

                            If Not IsDBNull(getInfo.Rows(0)("DefaultDisplayListMember")) Then
                                DefaultSearchMemberFromDB = getInfo.Rows(0)("DefaultDisplayListMember")
                            End If
                        End If
                        updateMessage.Text = textTable.Rows(27)("TextParamValue") + " " + EditName
                        SubmitForm.Text = textTable.Rows(12)("TextParamValue")
                    End If
                Else
                    updateMessage.Text = textTable.Rows(26)("TextParamValue")
                    SubmitForm.Text = textTable.Rows(26)("TextParamValue")
			
                    ComputerID.Value = 0
                    If Not Page.IsPostBack Then
                        Radio2.Checked = True
                        Radio4.Checked = True
                        Radio5.Checked = True
                        Radio8.Checked = True
                        Radio8_1.Checked = True
                        Radio9.Checked = True
                        Radio11_1.Checked = True
                        Radio14.Checked = True
                        Radio16.Checked = True
                        Radio18.Checked = True
                        Radio20.Checked = True
                        Radio21.Checked = True
                        Radio24.Checked = True
                        Radio26.Checked = True
                        Radio27.Checked = True
                        Radio30.Checked = True
                        Radio34.Checked = True
                        Radio36.Checked = True
                        ComputerType.Items(0).Selected = True
                    End If
                End If
			
                Dim IDValue As Integer = 0
                If ComputerID.Value = 0 Then
                    If IsNumeric(Request.Form("ProductLevelID")) Then
                        IDValue = Request.Form("ProductLevelID")
                    ElseIf IsNumeric(Request.QueryString("ProductLevelID")) Then
                        IDValue = Request.QueryString("ProductLevelID")
                    ElseIf IsNumeric(IDValueFromDB) Then
                        IDValue = IDValueFromDB
                    End If
                Else
                    If IsNumeric(Request.Form("ProductLevelID")) Then
                        IDValue = Request.Form("ProductLevelID")
                    ElseIf IsNumeric(IDValueFromDB) Then
                        IDValue = IDValueFromDB
                    ElseIf IsNumeric(Request.QueryString("ProductLevelID")) Then
                        IDValue = Request.QueryString("ProductLevelID")
                    End If
                End If
				
                Dim i As Integer
                Dim outputString, FormSelected, FormChecked As String
		
                Dim PayTypeTable As New DataTable()
                PayTypeTable = getData.PayTypeInfo(0, objCnn)
                Dim PayTypeIDValue As Integer = 1
                If IsNumeric(Request.Form("PayTypeDefault")) Then
                    PayTypeIDValue = Request.Form("PayTypeDefault")
                ElseIf IsNumeric(Request.QueryString("PayTypeDefault")) Then
                    PayTypeIDValue = Request.QueryString("PayTypeDefault")
                ElseIf IsNumeric(PayTypeIDValueFromDB) Then
                    PayTypeIDValue = PayTypeIDValueFromDB
                End If
		
                If Page.IsPostBack And Trim(Request.Form("PayTypeList")) <> "" Then
                    PayTypeListFromDB = "," + Request.Form("PayTypeList") + ","
                End If
		
                Dim PayTypeSelection As String = ""
                Dim PayTypeSelString As String = ""
                Dim compareString As String = ""
                For i = 0 To PayTypeTable.Rows.Count - 1
                    If PayTypeIDValue = PayTypeTable.Rows(i)("TypeID") Then
                        FormSelected = "selected"
                    Else
                        FormSelected = ""
                    End If
                    PayTypeSelection += "<option value=""" & PayTypeTable.Rows(i)("TypeID").ToString & """ " & FormSelected & ">" & PayTypeTable.Rows(i)("PayType")
			
                    compareString = "," + PayTypeTable.Rows(i)("TypeID").ToString + ","
                    If PayTypeListFromDB.IndexOf(compareString) <> -1 Then
                        FormChecked = " checked"
                    Else
                        FormChecked = ""
                    End If
                    PayTypeSelString += "<input type=""checkbox"" name=""PayTypeList"" value=""" + PayTypeTable.Rows(i)("TypeID").ToString + """" + FormChecked + ">" + PayTypeTable.Rows(i)("PayType") + "<br>"
			
                Next
		
                PaymentDefault.InnerHtml = "<select name=""PayTypeDefault"">" + PayTypeSelection + "</select>"
                PaymentTypeList.InnerHtml = PayTypeSelString
		
                If Page.IsPostBack And Trim(Request.Form("DiscountTypeList")) <> "" Then
                    DiscountTypeListFromDB = "," + Request.Form("DiscountTypeList") + ","
                End If
                Dim DiscountSelString As String = ""
                Dim DiscountTypeTable As New DataTable()
                DiscountTypeTable = getData.DiscountTypeInfo(0, objCnn)
                For i = 0 To DiscountTypeTable.Rows.Count - 1
                    compareString = "," + DiscountTypeTable.Rows(i)("TypeID").ToString + ","
                    If DiscountTypeListFromDB.IndexOf(compareString) <> -1 Then
                        FormChecked = " checked"
                    Else
                        FormChecked = ""
                    End If
                    DiscountSelString += "<input type=""checkbox"" name=""DiscountTypeList"" value=""" + DiscountTypeTable.Rows(i)("TypeID").ToString + """" + FormChecked + ">" + DiscountTypeTable.Rows(i)("DiscountName") + "&nbsp;&nbsp;"
                Next
                DiscountList.InnerHtml = DiscountSelString
		
                Dim strSelectShopString As String = textTable.Rows(51)("TextParamValue")
                Dim selectionTable As New DataTable()
                selectionTable = cls.GetProductLevel(-9999, objCnn)
		
                If selectionTable.Rows.Count = 1 Then
                    levelRow.Visible = False
                    MLevelText.InnerHtml = "<input type=""hidden"" name=""ProductLevelID"" value=""" + selectionTable.Rows(0)("ProductLevelID").ToString + """>"
                Else
                    Dim inputHiddenString As String
                    Dim strSelectName, strDisable As String
                    Dim bolFoundShop As Boolean
                    bolFoundShop = False
                    If ComputerID.Value > 0 Then
                        For i = 0 To selectionTable.Rows.Count - 1
                            If IDValue = selectionTable.Rows(i)("ProductLevelID") Then
                                bolFoundShop = True
                                Exit For
                            End If
                        Next i
                    End If
                    
                    'For Computer that already add --> Disable Select Form (Must add input type hidden to store ProductLevelID value
                    ', because when disabled select form it can not get value of the select form
                    If bolFoundShop = True Then
                        strSelectName = "ProductLevelID_Select"
                        inputHiddenString = "<input type=""hidden"" name=""ProductLevelID"" value=""" & IDValue & """>"
                        strDisable = "disabled"
                    Else
                        strSelectName = "ProductLevelID"
                        inputHiddenString = ""
                        strDisable = ""
                    End If
                    
                    outputString = "<select name=""" & strSelectName & """ " & strDisable & " ><option value=""0"">" & strSelectShopString
                    For i = 0 To selectionTable.Rows.Count - 1
                        If IDValue = selectionTable.Rows(i)("ProductLevelID") Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        outputString += "<option value=""" & selectionTable.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & selectionTable.Rows(i)("ProductLevelName")
                    Next
                    SelectionText.InnerHtml = inputHiddenString & outputString
                End If
		
                    Dim ReceiptValue As Integer = 1
                    If IsNumeric(Request.Form("PrintReceiptOption")) Then
                        ReceiptValue = Request.Form("PrintReceiptOption")
                    ElseIf IsNumeric(Request.QueryString("PrintReceiptOption")) Then
                        ReceiptValue = Request.QueryString("PrintReceiptOption")
                    ElseIf IsNumeric(ReceiptValueFromDB) Then
                        ReceiptValue = ReceiptValueFromDB
                    End If
		
                    outputString = ""
                    outputString = "<select name=""PrintReceiptOption"">"
                    If ReceiptValue = 0 Then
                        outputString += "<option value=""0"" selected>Show Print Option"
                    Else
                        outputString += "<option value=""0"">Show Print Option"
                    End If
                    If ReceiptValue = 1 Then
                        outputString += "<option value=""1"" selected>Always Print"
                    Else
                        outputString += "<option value=""1"">Always Print"
                    End If
                    If ReceiptValue = 2 Then
                        outputString += "<option value=""2"" selected>Not Print"
                    Else
                        outputString += "<option value=""2"">Not Print"
                    End If
                    outputString += "</select>"
                    PrintReceiptOptionList.InnerHtml = outputString
		
		
                    Dim VoidOrderValue As Integer = 1
                    If IsNumeric(Request.Form("PrintVoidOrderOption")) Then
                        VoidOrderValue = Request.Form("PrintVoidOrderOption")
                    ElseIf IsNumeric(Request.QueryString("PrintVoidOrderOption")) Then
                        VoidOrderValue = Request.QueryString("PrintVoidOrderOption")
                    ElseIf IsNumeric(VoidOrderValueFromDB) Then
                        VoidOrderValue = VoidOrderValueFromDB
                    End If
		
                    outputString = ""
                    outputString = "<select name=""PrintVoidOrderOption"">"
                    If VoidOrderValue = 0 Then
                        outputString += "<option value=""0"" selected>Ask Before Print"
                    Else
                        outputString += "<option value=""0"">Ask Before Print"
                    End If
                    If VoidOrderValue = 1 Then
                        outputString += "<option value=""1"" selected>Always Print"
                    Else
                        outputString += "<option value=""1"">Always Print"
                    End If
                    If VoidOrderValue = 2 Then
                        outputString += "<option value=""2"" selected>Not Print"
                    Else
                        outputString += "<option value=""2"">Not Print"
                    End If
                    outputString += "</select>"
                    PrintVoidOrderOptionList.InnerHtml = outputString
		
                    Dim MoveOrderValue As Integer = 1
                    If IsNumeric(Request.Form("PrintMoveOrderOption")) Then
                        MoveOrderValue = Request.Form("PrintMoveOrderOption")
                    ElseIf IsNumeric(Request.QueryString("PrintMoveOrderOption")) Then
                        MoveOrderValue = Request.QueryString("PrintMoveOrderOption")
                    ElseIf IsNumeric(MoveOrderValueFromDB) Then
                        MoveOrderValue = MoveOrderValueFromDB
                    End If
		
                    outputString = ""
                    outputString = "<select name=""PrintMoveOrderOption"">"
                    If MoveOrderValue = 0 Then
                        outputString += "<option value=""0"" selected>Ask Before Print"
                    Else
                        outputString += "<option value=""0"">Ask Before Print"
                    End If
                    If MoveOrderValue = 1 Then
                        outputString += "<option value=""1"" selected>Always Print"
                    Else
                        outputString += "<option value=""1"">Always Print"
                    End If
                    If MoveOrderValue = 2 Then
                        outputString += "<option value=""2"" selected>Not Print"
                    Else
                        outputString += "<option value=""2"">Not Print"
                    End If
                    outputString += "</select>"
                    PrintMoveOrderOptionList.InnerHtml = outputString
		
                    Dim POSFunctionValue As Integer = 1
                    If IsNumeric(Request.Form("POSFunction")) Then
                        POSFunctionValue = Request.Form("POSFunction")
                    ElseIf IsNumeric(Request.QueryString("POSFunction")) Then
                        POSFunctionValue = Request.QueryString("POSFunction")
                    ElseIf IsNumeric(POSFunctionFromDB) Then
                        POSFunctionValue = POSFunctionFromDB
                    End If
                    outputString = ""
                    outputString = "<select name=""POSFunction"">"
                    If POSFunctionValue = 1 Then
                        outputString += "<option value=""1"" selected>Full Function"
                    Else
                        outputString += "<option value=""1"">Full Function"
                    End If
                    If POSFunctionValue = 2 Then
                        outputString += "<option value=""2"" selected>Placing Order Only"
                    Else
                        outputString += "<option value=""2"">Placing Order Only"
                    End If
                    If POSFunctionValue = 3 Then
                        outputString += "<option value=""3"" selected>Check Bill Only"
                    Else
                        outputString += "<option value=""3"">Check Bill Only"
                    End If
                    outputString += "</select>"
                    POSFunctionOptionList.InnerHtml = outputString
		
                    Dim DefaultSearchMemberValue As Integer = 1
                    If IsNumeric(Request.Form("DefaultDisplayListMember")) Then
                        DefaultSearchMemberValue = Request.Form("DefaultDisplayListMember")
                    ElseIf IsNumeric(Request.QueryString("DefaultDisplayListMember")) Then
                        DefaultSearchMemberValue = Request.QueryString("DefaultDisplayListMember")
                    ElseIf IsNumeric(DefaultSearchMemberFromDB) Then
                        DefaultSearchMemberValue = DefaultSearchMemberFromDB
                    End If
		
                    Dim SearchMemberList As DataTable = getData.DisplayListMember(-99, objCnn)
                    outputString = "<select name=""DefaultDisplayListMember"">"
                    For i = 0 To SearchMemberList.Rows.Count - 1
                        If DefaultSearchMemberValue = SearchMemberList.Rows(i)("DisplayID") Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        outputString += "<option value=""" & SearchMemberList.Rows(i)("DisplayID") & """ " & FormSelected & ">" & SearchMemberList.Rows(i)("Description")
                    Next
                    outputString += "</select>"
                    DefaultSearchMemberOptionList.InnerHtml = outputString
		
                    Dim ParamString, ParamStringVal As String
                    Dim ValueString, TextString As String
                    Dim dtTable As DataTable = Prop.DynamicPropInfo(0, 1, 3, ComputerID.Value, objCnn)
                    If dtTable.Rows.Count > 0 Then
                        outputString = ""
                        For i = 0 To dtTable.Rows.Count - 1
                            ValueString = ""
                            TextString = ""
                            If Not IsDBNull(dtTable.Rows(i)("PropertyValue")) Then
                                ValueString = dtTable.Rows(i)("PropertyValue").ToString
                            End If
                            If Not IsDBNull(dtTable.Rows(i)("PropertyTextValue")) Then
                                TextString = dtTable.Rows(i)("PropertyTextValue").ToString
                            End If
                            ParamString = "PropertyValue|" + dtTable.Rows(i)("ProgramTypeID").ToString + ":" + dtTable.Rows(i)("PropertyID").ToString
                            ParamStringVal = "PropertyTextValue|" + dtTable.Rows(i)("ProgramTypeID").ToString + ":" + dtTable.Rows(i)("PropertyID").ToString
                            outputString += "<tr>"
                            outputString += "<td class=""text"">" + Trim(dtTable.Rows(i)("PropertyName")) + "<br><span class=""smalltext"">(" + Trim(dtTable.Rows(i)("Description")) + ")</span></td>"
                            outputString += "<td class=""text""><input type=""text"" style=""width:30px"" name=""" + ParamString + """ value=""" + ValueString + """> (Value)&nbsp;&nbsp;<input type=""text"" style=""width:200px"" name=""" + ParamStringVal + """ value=""" + TextString + """> (Text)" + "</td>"
                            outputString += "</tr>"
                        Next
                        DynamicPropUser.InnerHtml = outputString
                    End If
		
                    dtTable = Prop.DynamicPropInfo(0, 0, 3, ComputerID.Value, objCnn)
                    If dtTable.Rows.Count > 0 Then
                        outputString = ""
                        For i = 0 To dtTable.Rows.Count - 1
                            ValueString = ""
                            TextString = ""
                            If Not IsDBNull(dtTable.Rows(i)("PropertyValue")) Then
                                ValueString = dtTable.Rows(i)("PropertyValue").ToString
                            End If
                            If Not IsDBNull(dtTable.Rows(i)("PropertyTextValue")) Then
                                TextString = dtTable.Rows(i)("PropertyTextValue").ToString
                            End If
                            ParamString = "PropertyValue|" + dtTable.Rows(i)("ProgramTypeID").ToString + ":" + dtTable.Rows(i)("PropertyID").ToString
                            ParamStringVal = "PropertyTextValue|" + dtTable.Rows(i)("ProgramTypeID").ToString + ":" + dtTable.Rows(i)("PropertyID").ToString
                            outputString += "<tr>"
                            outputString += "<td class=""text"" align=""center"">" + dtTable.Rows(i)("ProgramTypeID").ToString + "</td>"
                            outputString += "<td class=""text"" align=""center"">" + dtTable.Rows(i)("PropertyID").ToString + "</td>"
                            outputString += "<td class=""text"">" + Trim(dtTable.Rows(i)("PropertyName")) + "<br><span class=""smalltext"">(" + Trim(dtTable.Rows(i)("Description")) + ")</span></td>"
                            outputString += "<td class=""text""><input type=""text"" style=""width:30px"" name=""" + ParamString + """ value=""" + ValueString + """> (Value)&nbsp;&nbsp;<input type=""text"" style=""width:200px"" name=""" + ParamStringVal + """ value=""" + TextString + """> (Text)" + "</td>"
                            outputString += "</tr>"
                        Next
                        DynamicPropAdmin.InnerHtml = outputString
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
        validateName.InnerHtml = ""
        validateLevel.InnerHtml = ""
        validatePaymentList.InnerHtml = ""
	
        If Not IsNumeric(Request.Form("ProductLevelID")) Or Request.Form("ProductLevelID") = 0 Then
            validateLevel.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(60)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If Len(Trim(ComputerName.Text)) = 0 Then
            validateName.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(79)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If Trim(Request.Form("PayTypeList")) = "" Then
            validatePaymentList.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(80)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If FoundError = False Then
            Dim Result As String
            Dim ExtraSQL(1) As String
		
            If ComputerID.Value = 0 Then
                ExtraSQL(0) = "PayTypeAvailable,DiscountTypeAvailable"
                If Trim(Request.Form("PayTypeList")) = "" Then
                    ExtraSQL(1) = "','"
                Else
                    ExtraSQL(1) = "'," + Request.Form("PayTypeList") + ",'"
                End If
                If Trim(Request.Form("DiscountTypeList")) = "" Then
                    ExtraSQL(1) += ",','"
                Else
                    ExtraSQL(1) += ",'," + Request.Form("DiscountTypeList") + ",'"
                End If
            Else
                If Trim(Request.Form("PayTypeList")) <> "" Then
                    ExtraSQL(0) = "PayTypeAvailable=" + "'," + Request.Form("PayTypeList") + ",'"
                Else
                    ExtraSQL(0) = "PayTypeAvailable=','"
                End If
                If Trim(Request.Form("DiscountTypeList")) <> "" Then
                    ExtraSQL(0) += ",DiscountTypeAvailable=" + "'," + Request.Form("DiscountTypeList") + ",'"
                Else
                    ExtraSQL(0) += ",DiscountTypeAvailable=','"
                End If
                ExtraSQL(1) = ""
            End If
		
            Application.Lock()

            Result = cls.AddUpdateCategory(Request, ExtraSQL, "ComputerName", "ComputerID", objCnn)
		
            If Result = "Success" Then
                Dim ComputerIDValue As Integer
                If ComputerID.Value > 0 Then
                    ComputerIDValue = ComputerID.Value
                Else
                    Dim getMax As DataTable = objDB.List("select MAX(ComputerID) AS MaxID from ComputerName", objCnn)
                    ComputerIDValue = getMax.Rows(0)("MaxID")
                End If
			
                Dim getProp As DataTable
                getProp = getData.PropertyInfo(1, objCnn)
			
                If getProp.Rows(0)("FrontSystemType") = 1 Then
                    Dim ResultUpdate As Boolean = getData.UpdateComputerReceipt(ComputerIDValue, Trim(DocumentTypeHeader.Text), Trim(DocumentTypeHeaderFT.Text), Trim(DocumentTypeHeaderCM.Text), Trim(DocumentTypeHeaderDP.Text), Session("LangID"), objCnn)
                End If
                Dim shopInfo As New DataTable()
                shopInfo = cls.GetProductLevel(-9999, objCnn)
                If shopInfo.Rows.Count = 1 Then
                    getData.DelComputerAccess(ComputerIDValue, Request.Form("ProductLevelID"), objCnn)
                    getData.AddComputerAccess(ComputerIDValue, Request.Form("ProductLevelID"), objCnn)
                End If
			
                Dim ResultDynamic As String = Prop.UpdateDynamicPropInfo("Update", ComputerIDValue, 3, Request, objCnn)
			
                Response.Redirect("manage_computer.aspx?" + Request.QueryString.ToString)
            Else
                errorMsg.InnerHtml = Result
            End If
            Application.UnLock()
        End If
    End Sub

Sub DoCancel(Source As Object, E As EventArgs)
	Response.Redirect("manage_computer.aspx?" + Request.QueryString.ToString)
End Sub
		
		
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
