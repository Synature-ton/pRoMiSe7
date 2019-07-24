<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="DynamicProperty" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<%@ Register tagprefix="synature" Tagname="province" Src="../UserControls/Province.ascx" %>

<html>
<head>
<title>Preferences</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>

<div id="showContent" visible="True" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" name="ID" value="1">
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
    	<table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="LangText0" runat="server" /></b></td><td align="right"><asp:Label ID="LangList" runat="server" /></td></tr></table>
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

<div id="updated" class="boldText" runat="server"></div>
<table id="myTable" class="blue" width="100%">

<thead>
	<tr>
		<th align="center"><asp:Label ID="LangText26" Text="Description" runat="server" /></th>
		<th align="center"><asp:Label ID="LangText27" Text="Value" runat="server" /></th>
	</tr>
</thead>
<tbody>
<tr>
	<td><asp:Label ID="LangText1" runat="server" /></td>
	<td class="text"><input type="radio" id="Radio1" name="YearSetting" value="1" runat="server" /><asp:Label ID="LangText15" runat="server" />&nbsp;&nbsp;<input type="radio" id="Radio2" name="YearSetting" value="2" runat="server" /><asp:Label ID="LangText14" runat="server" /></td>
</tr>

<tr id="SmartCardInfo" Visible="false" runat="server">
	<td><div class="text">Smart Card</div></td>
	<td class="text"><input type="radio" id="Radio3" name="UseSmartcardInSystem" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio4" name="UseSmartcardInSystem" value="0" runat="server" />NO</td>
</tr>

<tr id="trEachDiscountRounding" runat="server" visible="false" >
	<td><asp:Label ID="LangText2" runat="server" /></td>
	<td><div class="text" id="EachDiscountText" runat="server"></div></td>
</tr>
<tr>
	<td><asp:Label ID="LangText3" runat="server" /></td>
	<td><div class="text" id="TotalDiscountText" runat="server"></div></td>
</tr>
<tr id="trProductPriceRounding" runat="server" visible="false" >
	<td><asp:Label ID="LangText4" runat="server" /></td>
	<td><div class="text" id="ProductPriceText" runat="server"></div></td>
</tr>
<tr id="trServiceChargeRounding" runat="server" visible="false" >
	<td><asp:Label ID="LangText5" runat="server" /></td>
	<td><div class="text" id="ServiceChargeText" runat="server"></div></td>
</tr>
<tr id="trVATRounding" runat="server" visible="false" >
	<td><asp:Label ID="LangText45" Text="VAT Rounding Type" runat="server" /></td>
	<td><div class="text" id="VATRoundingText" runat="server"></div></td>
</tr>
<tr>
	<td><asp:Label ID="LangText30" runat="server" /></td>
	<td><asp:textbox ID="DigitForRoundingDecimal" Width="50" runat="server" /></td>
</tr>
<tr>
	<td class="text">No Digits for recording VAT value</td>
	<td class="text"><asp:textbox ID="NoDecimalDigitForCalculateVAT" Width="50" runat="server" /></td>
</tr>
<div id="ShowGlobalHeader" runat="server">
<tr>
	<td><div class="text">Global Receipt Header</div></td>
	<td><asp:textbox ID="DocumentTypeHeader" Width="50" runat="server" /></td>
</tr>
<tr>
	<td><div class="text">Global Full Tax Header</div></td>
	<td><asp:textbox ID="FullTaxTypeHeader" Width="50" runat="server" /></td>
</tr>
<tr>
	<td><div class="text">Global Credit Money Header</div></td>
	<td><asp:textbox ID="CreditMoneyTypeHeader" Width="50" runat="server" /></td>
</tr>
</div>
<span id="ShowSystemEdition" visible="true" runat="Server">
<tr>
	<td class="text"><asp:Label ID="LangText6" runat="server" /></td>
	<td class="text"><asp:textbox ID="RemoteImageFolder" Width="300" runat="server" /></td>
</tr>
<tr>
	<td class="text"><asp:Label ID="LangText7" runat="server" /></td>
	<td class="text"><asp:textbox ID="SMTPServer" Width="300" runat="server" /></td>
</tr>
<tr>
	<td class="text"><asp:Label ID="LangText8" runat="server" /></td>
	<td class="text"><asp:textbox ID="WebmasterEmail" Width="300" runat="server" /></td>
</tr>

<tr>
	<td class="text"><asp:Label ID="LangText9" runat="server" /></td>
	<td class="text"><span id="MemberCodeType" runat="server"></span></td>
</tr>
<tr>
	<td class="text"><asp:Label ID="LangText10" runat="server" /></td>
	<td class="text"><span id="MemberCodeError" class="errorText" runat="server"></span><asp:textbox ID="MemberCodeDigit" Width="30" MaxLength="2" runat="server" /></td>
</tr>
<tr>
	<td class="text"><asp:Label ID="LangText11" runat="server" /></td>
	<td class="text"><span id="MemberCodeReset" runat="server"></span></td>
</tr>

<tr>
	<td><div class="text"><asp:Label ID="LangText12" Text="Member Code Year" runat="server" /></td>
	<td class="text"><input type="radio" id="Radio24" name="MemberCodeYearSetting" value="1" runat="server" /><asp:Label ID="LangText25" runat="server" />&nbsp;&nbsp;<input type="radio" id="Radio25" name="MemberCodeYearSetting" value="2" runat="server" /><asp:Label ID="LangText24" runat="server" /></td>
</tr>
</span>

<div id="ShowAfterPaid" runat="server">
<tr>
	<td class="text"><asp:Label ID="LangText13" runat="server" /></td>
	<td class="text"><input type="radio" id="Radio9" name="BackToMainPageAfterPaidBill" value="1" runat="server" />Main page&nbsp;&nbsp;<input type="radio" id="Radio10" name="BackToMainPageAfterPaidBill" value="0" runat="server" />Stay in same page</td>
</tr>
</div>

<div id="ShowPrintPackage" runat="server">
<tr>
	<td class="text"><asp:Label ID="LangText16" runat="server" /></td>
	<td class="text"><input type="radio" id="Radio22" name="PrintCustomerPackageLeftInBill" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio23" name="PrintCustomerPackageLeftInBill" value="0" runat="server" />NO</td>
</tr>
</div>

<div id="ShowFormat" runat="server">
<tr>
	<td class="text"><asp:Label ID="LangText17" runat="server" /></td>
	<td class="text"><asp:textbox ID="CurrencySymbol" Width="200" MaxLength="10" runat="server" /></td>
</tr>
<tr>
	<td class="text"><asp:Label ID="LangText18" runat="server" /></td>
	<td class="text"><asp:textbox ID="CurrencyCode" Width="200" MaxLength="10" runat="server" /></td>
</tr>
<tr>
	<td class="text"><asp:Label ID="LangText19" runat="server" /></td>
	<td class="text"><asp:textbox ID="CurrencyName" Width="200" MaxLength="20" runat="server" /></td>
</tr>
<tr>
	<td class="text"><asp:Label ID="LangText20" runat="server" /></td>
	<td class="text"><asp:textbox ID="CurrencyFormat" Width="200" MaxLength="20" runat="server" /></td>
</tr>
<tr>
	<td class="text"><asp:Label ID="LangText21" runat="server" /></td>
	<td class="text"><asp:textbox ID="DateFormat" Width="200" MaxLength="20" runat="server" /></td>
</tr>
<tr>
	<td class="text"><asp:Label ID="LangText22" runat="server" /></td>
	<td class="text"><asp:textbox ID="TimeFormat" Width="200" MaxLength="20" runat="server" /></td>
</tr>
<tr>
	<td class="text"><asp:Label ID="LangText23" runat="server" /></td>
	<td class="text"><asp:textbox ID="QtyFormat" Width="200" MaxLength="20" runat="server" /></td>
</tr>
<tr>
	<td class="text">Short Date Format</td>
	<td class="text"><asp:textbox ID="ShortDate" Width="200" MaxLength="20" runat="server" /></td>
</tr>
<tr>
	<td class="text">Short Date Time Format</td>
	<td class="text"><asp:textbox ID="ShortDateTime" Width="200" MaxLength="20" runat="server" /></td>
</tr>
<tr>
	<td class="text">Material Qty Format</td>
	<td class="text"><asp:textbox ID="MaterialQtyFormat" Width="200" MaxLength="20" runat="server" /></td>
</tr>
<tr>
	<td class="text">Percent Format</td>
	<td class="text"><asp:textbox ID="PercentFormat" Width="200" MaxLength="20" runat="server" /></td>
</tr>
<tr>
	<td class="text">Numeric Format</td>
	<td class="text"><asp:textbox ID="NumericFormat" Width="200" MaxLength="20" runat="server" /></td>
</tr>
<tr>
	<td class="text">Full Date Format</td>
	<td class="text"><asp:textbox ID="FullDateFormat" Width="200" MaxLength="20" runat="server" /></td>
</tr>
<tr>
	<td class="text">Full Date Time Format</td>
	<td class="text"><asp:textbox ID="FullDateTimeFormat" Width="200" MaxLength="20" runat="server" /></td>
</tr>
<tr>
	<td class="text">Accounting Format</td>
	<td class="text"><asp:textbox ID="AccountingFormat" Width="200" MaxLength="20" runat="server" /></td>
</tr>
</div>

<span id="DynamicPropUser" runat="server"></span>

</tbody>
</table>
<br>
<table id="myTable2" class="blue" width="100%">

<thead>
	<tr>
		<th colspan="8" align="center"><asp:Label ID="LangText31" Text="Sale Mode Configuration" runat="server" /></td>
	</tr> 
	<tr>
		<th align="center"><asp:Label ID="LangText33" Text="Sale Mode ID" runat="server" /></th>
		<th align="center"><asp:Label ID="LangText34" Text="Sale Mode Name" runat="server" /></th>
        <th align="center"><asp:Label ID="LangText46" Text="Receipt Header Text" runat="server" /></th>
        <th align="center"><asp:Label ID="LangText35" Text="Position Prefix" runat="server" /></th>
        <th align="center"><asp:Label ID="LangText36" Text="Prefix Text" runat="server" /></th>
        <th align="center"><asp:Label ID="LangText37" Text="Prefix Text for Printing" runat="server" /></th>
        <th align="center"><asp:Label ID="LangText38" Text="Service Charge" runat="server" /></th>
        <th align="center"><asp:Label ID="LangText39" Text="Activate" runat="server" /></th>
	</tr>
</thead>

<tbody>
	<span id="SaleModeData" runat="server" />
</tbody>
</table>

<div id="showAdmin" runat="server"> 
<br>
<table id="myTable2" class="blue" width="100%">

<thead>
	<tr>
		<th colspan="2" align="center"><asp:Label ID="LangText32" Text="Administration Area" runat="server" /></td>
	</tr>
	<tr>
		<th align="center"><asp:Label ID="LangText28" Text="Description" runat="server" /></th>
		<th align="center"><asp:Label ID="LangText29" Text="Value" runat="server" /></th>
	</tr>
</thead>



<tr id="ShowFrontSystemType" visible="true" runat="server">
	<td class="text" valign="top">Front System Type<br><span class="smalltext">(1=Receipt Header based on Computer Name)<br>(0=For Global Receipt Header)</span></td>
	<td class="text"><asp:textbox ID="FrontSystemType" Width="30" runat="server" /></td>
</tr>

<div id="ShowSpa" visible="false" runat="server">
<tr>
	<td class="text">Service Product</td>
	<td class="text"><input type="radio" id="Radio5" name="ServiceProduct" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio6" name="ServiceProduct" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td class="text">Show Staff in Online Reservation</td>
	<td class="text"><input type="radio" id="Radio11" name="ReserveAllowSelectStaff" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio12" name="ReserveAllowSelectStaff" value="0" runat="server" />NO</td>
</tr>
<tr>
	<td class="text">Show Room in Online Reservation</td>
	<td class="text"><input type="radio" id="Radio13" name="ReserveAllowSelectRoom" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio14" name="ReserveAllowSelectRoom" value="0" runat="server" />NO</td>
</tr>
<tr>
	<td class="text">Running Package Number</td>
	<td class="text"><input type="radio" id="Radio17" name="RunningPackageNumber" value="1" runat="server" />Manual&nbsp;&nbsp;<input type="radio" id="Radio18" name="RunningPackageNumber" value="2" runat="server" />Auto By ShopMonthYear&nbsp;&nbsp;<input type="radio" id="Radio19" name="RunningPackageNumber" value="3" runat="server" />Auto By ShopProductID</td>
</tr>
</div>

<tr>
	<td class="text">Head or Branch</td>
	<td class="text"><input type="radio" id="Radio7" name="HeadOrBranch" value="1" runat="server" />Branch&nbsp;&nbsp;<input type="radio" id="Radio8" name="HeadOrBranch" value="0" runat="server" />Head Office</td>
</tr>
<tr>
	<td><div class="text">Multi Branch Management</div></td>
	<td class="text"><input type="radio" id="Radio411" name="MultiBranch" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio421" name="MultiBranch" value="0" runat="server" />NO</td>
</tr>
<tr>
	<td class="text">Calculate VAT  when amount  of receipt is zero </td>
	<td class="text"><input type="radio" id="Radio38" name="CalculateVATWhenFreeBill" value="2" runat="server" />YES (based on Promotion Setting)&nbsp;&nbsp;<input type="radio" id="Radio20" name="CalculateVATWhenFreeBill" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio21" name="CalculateVATWhenFreeBill" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td class="text">Auto Close Bill After Paid</td>
	<td class="text"><input type="radio" id="Radio15" name="AutoCloseTransactionAfterPaid" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio16" name="AutoCloseTransactionAfterPaid" value="0" runat="server" />NO</td>
</tr>



<tr>
	<td><div class="text">Allow Approve Document Online</div></td>
	<td class="text"><input type="radio" id="Radio26" name="AllowApproveDocumentOnline" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio27" name="AllowApproveDocumentOnline" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td><div class="text">Allow Transfer When No Material In Stock</div></td>
	<td class="text"><input type="radio" id="Radio28" name="AllowTranferWhenNoMaterialInStock" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio29" name="AllowTranferWhenNoMaterialInStock" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td><div class="text">SMS Feature</div></td>
	<td class="text"><input type="radio" id="Radio30" name="SMSFeature" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio31" name="SMSFeature" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td><div class="text">Hot Spot Feature</div></td>
	<td class="text"><input type="radio" id="Radio32" name="HotSpotFeature" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio33" name="HotSpotFeature" value="0" runat="server" />NO</td>
</tr>

<tr id="showPocket" visible="true" runat="server">
	<td><div class="text">Pocket PC Feature</div></td>
	<td class="text"><input type="radio" id="Radio34" name="PocketPCFeature" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio35" name="PocketPCFeature" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td><div class="text">Show Prepaid Summary in Sale Report</div></td>
	<td class="text"><input type="radio" id="Radio36" name="SummaryPrepaidInSaleReport" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio37" name="SummaryPrepaidInSaleReport" value="0" runat="server" />NO</td>
</tr>

<tr>
	<td><div class="text">Use Lock Table in Fanalize Bill</div></td>
	<td class="text"><input type="radio" id="Radio39" name="UseLockTableFunction" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio40" name="UseLockTableFunction" value="0" runat="server" />NO</td>
</tr>

<tr id="twsc" visible="false" runat="server">
	<td><div class="text">Take Away Service Charge</div></td>
	<td class="text"><input type="radio" id="Radio41" name="SynTakeAwayServiceCharge" value="1" runat="server" />Based on Regular Product&nbsp;&nbsp;<input type="radio" id="Radio42" name="SynTakeAwayServiceCharge" value="0" runat="server" />Always No Service Charge</td>
</tr>

<tr>
	<td><div class="text">Language</div></td>
	<td class="text"><input type="radio" id="Radio43" name="LockFrontLanguage" value="1" runat="server" />Sigle Langauge&nbsp;&nbsp;<input type="radio" id="Radio44" name="LockFrontLanguage" value="0" runat="server" />Multi Language</td>
</tr>

<tr>
	<td><div class="text">System Type</div></td>
	<td class="text"><asp:DropDownList ID="SystemTypeID" Width="200" CssClass="text" runat="server" /></td>
</tr>
<tr>
	<td><div class="text">System Edition</div></td>
	<td class="text"><asp:DropDownList ID="SystemEditionID"  Width="200" CssClass="text" runat="server" /></td>
</tr>
</tbody>
</table>
<BR>
<table id="myTable3" class="blue" width="100%">
<thead>
	<tr>
		<th colspan="4" align="center"><asp:Label ID="LangText40" Text="System Parameters" runat="server" /></td>
	</tr>
	<tr>
    	<th align="center"><asp:Label ID="LangText41" Text="TypeID" runat="server" /></th>
    	<th align="center"><asp:Label ID="LangText42" Text="ID" runat="server" /></th>
		<th align="center"><asp:Label ID="LangText43" Text="Description" runat="server" /></th>
		<th align="center"><asp:Label ID="LangText44" Text="Value" runat="server" /></th>
	</tr>
</thead>
<tbody>
<span id="DynamicPropAdmin" runat="server"></span>
</tbody>
</table>
</div>
<table width="100%">
<tr>
	<td align="right"><asp:button ID="SubmitForm" OnClick="DoAddUpdate" Text=" Submit Changes " runat="server" /></td>
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
</div>

<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getInfo As New CPreferences()
Dim updateDB As New CCategory()
Dim objDB As New CDBUtil()
Dim Prop As New ConfigProperty()
Dim PageID As Integer = 1

    Sub Page_Load()

        If User.Identity.IsAuthenticated And Session("Admin_Preference") Then
            'Try
            objCnn = getCnn.EstablishConnection()
			
            Dim getData As DataTable
            getData = getInfo.PropertyInfo(1, objCnn)
			
            SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
			
            Dim i As Integer
			
            If Not Request.QueryString("ToLangID") Is Nothing Then
                If IsNumeric(Request.QueryString("ToLangID")) Then
                    Session("LangID") = Request.QueryString("ToLangID")
                End If
            End If
            Dim PageName As String = System.IO.Path.GetFileName(Request.ServerVariables("SCRIPT_NAME"))
            Dim LangListText As String = ""
            Dim LangListData As DataTable
            Dim LangData As DataTable = getInfo.GetLang(LangListText, LangListData, PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"), PageID, 1, -1, Request, objCnn)
            Dim LangText As String = "lang" + Session("LangID").ToString
			
            For i = 0 To LangData.Rows.Count - 1
                Dim TestLabel = Util.FindControlRecursive(mainForm, "LangText" & i)
                Try
                    TestLabel.Text = LangData.Rows(i)(LangText)
                Catch ex As Exception
                End Try
            Next
            LangList.Text = LangListText
			
            ShowFormat.Visible = False
			
            Dim ColExist As Boolean = getInfo.TableColCheck("Property", "CurrencyCode", objCnn)
			
            If ColExist = True Then
                ShowFormat.Visible = True
            End If
			
            If getData.Rows.Count > 0 Then
                showAdmin.Visible = False
                If Session("StaffRole") = 1 Then
                    showAdmin.Visible = True
                End If
				
                If ShowFormat.Visible = True Then
                    If Not IsDBNull(getData.Rows(0)("CurrencySymbol")) Then
                        CurrencySymbol.Text = getData.Rows(0)("CurrencySymbol")
                    End If
                    If Not IsDBNull(getData.Rows(0)("CurrencyCode")) Then
                        CurrencyCode.Text = getData.Rows(0)("CurrencyCode")
                    End If
                    If Not IsDBNull(getData.Rows(0)("CurrencyName")) Then
                        CurrencyName.Text = getData.Rows(0)("CurrencyName")
                    End If
                    If Not IsDBNull(getData.Rows(0)("CurrencyFormat")) Then
                        CurrencyFormat.Text = getData.Rows(0)("CurrencyFormat")
                    End If
                    If Not IsDBNull(getData.Rows(0)("DateFormat")) Then
                        DateFormat.Text = getData.Rows(0)("DateFormat")
                    End If
                    If Not IsDBNull(getData.Rows(0)("TimeFormat")) Then
                        TimeFormat.Text = getData.Rows(0)("TimeFormat")
                    End If
                    If Not IsDBNull(getData.Rows(0)("QtyFormat")) Then
                        QtyFormat.Text = getData.Rows(0)("QtyFormat")
                    End If
					
                    If Not IsDBNull(getData.Rows(0)("ShortDate")) Then
                        ShortDate.Text = getData.Rows(0)("ShortDate")
                    End If
                    If Not IsDBNull(getData.Rows(0)("ShortDateTime")) Then
                        ShortDateTime.Text = getData.Rows(0)("ShortDateTime")
                    End If
                    If Not IsDBNull(getData.Rows(0)("MaterialQtyFormat")) Then
                        MaterialQtyFormat.Text = getData.Rows(0)("MaterialQtyFormat")
                    End If
                    If Not IsDBNull(getData.Rows(0)("PercentFormat")) Then
                        PercentFormat.Text = getData.Rows(0)("PercentFormat")
                    End If
                    If Not IsDBNull(getData.Rows(0)("NumericFormat")) Then
                        NumericFormat.Text = getData.Rows(0)("NumericFormat")
                    End If
                    If Not IsDBNull(getData.Rows(0)("FullDateFormat")) Then
                        FullDateFormat.Text = getData.Rows(0)("FullDateFormat")
                    End If
                    If Not IsDBNull(getData.Rows(0)("FullDateTimeFormat")) Then
                        FullDateTimeFormat.Text = getData.Rows(0)("FullDateTimeFormat")
                    End If
                    If Not IsDBNull(getData.Rows(0)("AccountingFormat")) Then
                        AccountingFormat.Text = getData.Rows(0)("AccountingFormat")
                    End If
                End If
				
                If Not IsDBNull(getData.Rows(0)("NoDecimalDigitForCalculateVAT")) Then
                    NoDecimalDigitForCalculateVAT.Text = getData.Rows(0)("NoDecimalDigitForCalculateVAT")
                Else
                    NoDecimalDigitForCalculateVAT.Text = ""
                End If
				
				
                If getData.Rows(0)("SystemEditionID") = 1 And Session("StaffRole") <> 1 Then
                    ShowSystemEdition.Visible = False
                Else
                    ShowSystemEdition.Visible = True
                End If
				
                If getData.Rows(0)("FrontSystemType") = 0 Then
                    ShowGlobalHeader.Visible = True
                Else
                    ShowGlobalHeader.Visible = False
                End If
				
                If getData.Rows(0)("SystemTypeID") = 0 Or getData.Rows(0)("SystemTypeID") = 3 Then ' All and Spa
                    ShowPrintPackage.Visible = True
                Else
                    ShowPrintPackage.Visible = False
                End If
				
                If getData.Rows(0)("SystemTypeID") = 2 Or getData.Rows(0)("SystemTypeID") = 4 Then ' All and Spa
                    ShowAfterPaid.Visible = False
                Else
                    ShowAfterPaid.Visible = True
                End If
			
                If Request.QueryString("done") = "yes" Then updated.InnerHtml = "Updated " + Now().ToString("F") + "<hr size=""0"">"
				
                If Not Page.IsPostBack Then
                    Dim getReceipt As DataTable = getInfo.ComputerReceipt(0, Session("LangID"), objCnn)
                    If getReceipt.Rows.Count > 0 Then
                        If Not IsDBNull(getReceipt.Rows(0)("DocumentTypeHeader")) Then
                            DocumentTypeHeader.Text = getReceipt.Rows(0)("DocumentTypeHeader")
                        Else
                            DocumentTypeHeader.Text = ""
                        End If
                    End If
					
                    Dim getFullTax As DataTable = getInfo.ComputerReceipt(0, 11, Session("LangID"), objCnn)
                    If getFullTax.Rows.Count > 0 Then
                        If Not IsDBNull(getFullTax.Rows(0)("DocumentTypeHeader")) Then
                            FullTaxTypeHeader.Text = getFullTax.Rows(0)("DocumentTypeHeader")
                        Else
                            FullTaxTypeHeader.Text = ""
                        End If
                    End If
					
                    Dim getCreditMoney As DataTable = getInfo.ComputerReceipt(0, 33, Session("LangID"), objCnn)
                    If getCreditMoney.Rows.Count > 0 Then
                        If Not IsDBNull(getCreditMoney.Rows(0)("DocumentTypeHeader")) Then
                            CreditMoneyTypeHeader.Text = getCreditMoney.Rows(0)("DocumentTypeHeader")
                        Else
                            CreditMoneyTypeHeader.Text = ""
                        End If
                    End If
                End If
				
                If Not IsDBNull(getData.Rows(0)("SMTPServer")) Then
                    SMTPServer.Text = getData.Rows(0)("SMTPServer")
                Else
                    SMTPServer.Text = ""
                End If
                If Not IsDBNull(getData.Rows(0)("WebmasterEmail")) Then
                    WebmasterEmail.Text = getData.Rows(0)("WebmasterEmail")
                Else
                    WebmasterEmail.Text = ""
                End If
						
                If getData.Rows(0)("YearSetting") = 1 Then
                    Radio1.Checked = True
                Else
                    Radio2.Checked = True
                End If
                If getData.Rows(0)("UseSmartcardInSystem") = True Or getData.Rows(0)("UseSmartcardInSystem") = 1 Then
                    Radio3.Checked = True
                Else
                    Radio4.Checked = True
                End If
                If getData.Rows(0)("ServiceProduct") = 1 Then
                    Radio5.Checked = True
                Else
                    Radio6.Checked = True
                End If
                If getData.Rows(0)("HeadOrBranch") = 1 Then
                    Radio7.Checked = True
                Else
                    Radio8.Checked = True
                End If
                If getData.Rows(0)("BackToMainPageAfterPaidBill") = 1 Then
                    Radio9.Checked = True
                Else
                    Radio10.Checked = True
                End If
                If getData.Rows(0)("ReserveAllowSelectStaff") = 1 Then
                    Radio11.Checked = True
                Else
                    Radio12.Checked = True
                End If
                If getData.Rows(0)("ReserveAllowSelectRoom") = 1 Then
                    Radio13.Checked = True
                Else
                    Radio14.Checked = True
                End If
                If getData.Rows(0)("AutoCloseTransactionAfterPaid") = 1 Then
                    Radio15.Checked = True
                Else
                    Radio16.Checked = True
                End If
                If getData.Rows(0)("RunningPackageNumber") = 1 Then
                    Radio17.Checked = True
                ElseIf getData.Rows(0)("RunningPackageNumber") = 2 Then
                    Radio18.Checked = True
                Else
                    Radio19.Checked = True
                End If
                If getData.Rows(0)("CalculateVATWhenFreeBill") = 1 Then
                    Radio20.Checked = True
                ElseIf getData.Rows(0)("CalculateVATWhenFreeBill") = 2 Then
                    Radio38.Checked = True
                Else
                    Radio21.Checked = True
                End If
                If getData.Rows(0)("PrintCustomerPackageLeftInBill") = 1 Then
                    Radio22.Checked = True
                Else
                    Radio23.Checked = True
                End If
                If getData.Rows(0)("MemberCodeYearSetting") = 1 Then
                    Radio24.Checked = True
                Else
                    Radio25.Checked = True
                End If
				
                If getData.Rows(0)("AllowApproveDocumentOnline") = 1 Then
                    Radio26.Checked = True
                Else
                    Radio27.Checked = True
                End If
                If getData.Rows(0)("AllowTranferWhenNoMaterialInStock") = 1 Then
                    Radio28.Checked = True
                Else
                    Radio29.Checked = True
                End If
				
                If getData.Rows(0)("SMSFeature") = 1 Then
                    Radio30.Checked = True
                Else
                    Radio31.Checked = True
                End If
				
                If getData.Rows(0)("HotSpotFeature") = 1 Then
                    Radio32.Checked = True
                Else
                    Radio33.Checked = True
                End If
				
                If getData.Rows(0)("PocketPCFeature") = 1 Then
                    Radio34.Checked = True
                Else
                    Radio35.Checked = True
                End If
				
                If getData.Rows(0)("SummaryPrepaidInSaleReport") = 1 Then
                    Radio36.Checked = True
                Else
                    Radio37.Checked = True
                End If
				
                If getData.Rows(0)("UseLockTableFunction") = 1 Then
                    Radio39.Checked = True
                Else
                    Radio40.Checked = True
                End If
				
                If getData.Rows(0)("SynTakeAwayServiceCharge") = 1 Then
                    Radio41.Checked = True
                Else
                    Radio42.Checked = True
                End If
				
                If getData.Rows(0)("LockFrontLanguage") = 1 Then
                    Radio43.Checked = True
                Else
                    Radio44.Checked = True
                End If
				
                If getData.Rows(0)("MultiBranch") = 1 Then
                    Radio411.Checked = True
                Else
                    Radio421.Checked = True
                End If
				
                FrontSystemType.Text = getData.Rows(0)("FrontSystemType").ToString
                RemoteImageFolder.Text = getData.Rows(0)("RemoteImageFolder").ToString
                MemberCodeDigit.Text = getData.Rows(0)("MemberCodeDigit").ToString
				
                'EachDiscountRoundType
                EachDiscountText.InnerHtml = CreateRoundTypeCombo("EachDiscountRoundType", getData.Rows(0)("EachDiscountRoundType"))
                'TotalDiscountRoundType
                TotalDiscountText.InnerHtml = CreateRoundTypeCombo("TotalDiscountRoundType", getData.Rows(0)("TotalDiscountRoundType"))
                'ProductPriceRoundType
                ProductPriceText.InnerHtml = CreateRoundTypeCombo("ProductPriceRoundType", getData.Rows(0)("ProductPriceRoundType"))
                'ServiceChargeRoundType
                ServiceChargeText.InnerHtml = CreateRoundTypeCombo("ServiceChargeRoundType", getData.Rows(0)("ServiceChargeRoundType"))
                'VATRoundType
                VATRoundingText.InnerHtml = CreateRoundTypeCombo("VATRoundType", getData.Rows(0)("VATRoundType"))
								
                If Not IsDBNull(getData.Rows(0)("DigitForRoundingDecimal")) Then
                    DigitForRoundingDecimal.Text = getData.Rows(0)("DigitForRoundingDecimal")
                Else
                    DigitForRoundingDecimal.Text = "0"
                End If

                Dim MCTypeData As DataTable = getCnn.List("select * from codesettingtype order by settingtype", objCnn)
                Dim MCTypeString As String = ""
				
                Dim selected As String
                For i = 0 To MCTypeData.Rows.Count - 1
                    If MCTypeData.Rows(i)("SettingType") = getData.Rows(0)("MemberCodeSettingType") Then
                        selected = " selected"
                    Else
                        selected = ""
                    End If
                    MCTypeString += "<option value=""" + MCTypeData.Rows(i)("SettingType").ToString + """" + selected + ">" + MCTypeData.Rows(i)("Description")
                Next
                MemberCodeType.InnerHtml = "<select name=""MemberCodeSettingType"">" + MCTypeString + "</select>"
				
                MCTypeData = getCnn.List("select * from coderesettype order by resettype", objCnn)
                MCTypeString = ""

                For i = 0 To MCTypeData.Rows.Count - 1
                    If MCTypeData.Rows(i)("ResetType") = getData.Rows(0)("MemberCodeResetType") Then
                        selected = " selected"
                    Else
                        selected = ""
                    End If
                    MCTypeString += "<option value=""" + MCTypeData.Rows(i)("ResetType").ToString + """" + selected + ">" + MCTypeData.Rows(i)("Description")
                Next
                MemberCodeReset.InnerHtml = "<select name=""MemberCodeResetType"">" + MCTypeString + "</select>"
				
                Dim SystemType As DataTable = getInfo.GetSystemType(objCnn)
                SystemTypeID.DataSource = SystemType
                SystemTypeID.DataValueField = "SystemTypeID"
                SystemTypeID.DataTextField = "SystemTypeDesp"
                SystemTypeID.DataBind()
				
                For i = 0 To SystemType.Rows.Count - 1
                    If getData.Rows(0)("SystemTypeID") = SystemType.Rows(i)("SystemTypeID") Then
                        SystemTypeID.Items(i).Selected = True
                    End If
                Next
				
                Dim SystemEdition As DataTable = getInfo.GetSystemEdition(objCnn)
                SystemEditionID.DataSource = SystemEdition
                SystemEditionID.DataValueField = "SystemEditionID"
                SystemEditionID.DataTextField = "SystemEditionDesp"
                SystemEditionID.DataBind()
				
                For i = 0 To SystemEdition.Rows.Count - 1
                    If getData.Rows(0)("SystemEditionID") = SystemEdition.Rows(i)("SystemEditionID") Then
                        SystemEditionID.Items(i).Selected = True
                    End If
                Next
				
                Dim outputString As String = ""
                Dim ParamString, ParamStringVal As String
                Dim ValueString, TextString As String
                Dim dtTable As DataTable = Prop.DynamicPropInfo(0, 1, 1, 1, objCnn)
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
				
                dtTable = Prop.DynamicPropInfo(0, 0, 1, 1, objCnn)
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
				
                Dim SaleModeName, PrefixText, PrefixTextPrinting, ReceiptHeaderText As String
                Dim PositionPrefix As Integer
                Dim SaleMode As DataTable = objDB.List("select * from SaleMode where SaleModeID>1 order by SaleModeID", objCnn)
                outputString = ""
                For i = 0 To SaleMode.Rows.Count - 1
                    outputString += "<tr>"
                    outputString += "<td class=""text"" align=""center"">" + SaleMode.Rows(i)("SaleModeID").ToString + "</td>"
                    If Not IsDBNull(SaleMode.Rows(i)("SaleModeName")) Then
                        SaleModeName = SaleMode.Rows(i)("SaleModeName")
                    Else
                        SaleModeName = ""
                    End If
                    outputString += "<td class=""text"" align=""center""><input type=""text"" style=""width:150px"" name=""" + "SaleModeName" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + SaleModeName + """>" + "</td>"
					
                    If Not IsDBNull(SaleMode.Rows(i)("ReceiptHeaderText")) Then
                        ReceiptHeaderText = SaleMode.Rows(i)("ReceiptHeaderText")
                    Else
                        ReceiptHeaderText = ""
                    End If
                    outputString += "<td class=""text"" align=""center""><input type=""text"" style=""width:100px"" name=""" + "ReceiptHeaderText" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + ReceiptHeaderText + """>" + "</td>"
					
                    If Not IsDBNull(SaleMode.Rows(i)("PositionPrefix")) Then
                        PositionPrefix = SaleMode.Rows(i)("PositionPrefix")
                    Else
                        PositionPrefix = 0
                    End If
                    If PositionPrefix = 0 Then
                        outputString += "<td class=""text"" align=""center"" width=""150px""><table border=""0""><tr><td><input type=""Radio"" name=""" + "PositionPrefix" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + "0" + """ checked>Before" + "</td><td><input type=""Radio"" name=""" + "PositionPrefix" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + "1" + """>After" + "</td></tr></table></td>"
                    Else
                        outputString += "<td class=""text"" align=""center"" width=""150px""><table border=""0""><tr><td><input type=""Radio"" name=""" + "PositionPrefix" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + "0" + """>Before" + "</td><td><input type=""Radio"" name=""" + "PositionPrefix" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + "1" + """ checked>After" + "</td></tr></table></td>"
                    End If
					
                    If Not IsDBNull(SaleMode.Rows(i)("PrefixText")) Then
                        PrefixText = SaleMode.Rows(i)("PrefixText")
                    Else
                        PrefixText = ""
                    End If
                    outputString += "<td class=""text"" align=""center""><input type=""text"" style=""width:100px"" name=""" + "PrefixText" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + PrefixText + """>" + "</td>"
					
                    If Not IsDBNull(SaleMode.Rows(i)("PrefixTextPrinting")) Then
                        PrefixTextPrinting = SaleMode.Rows(i)("PrefixTextPrinting")
                    Else
                        PrefixTextPrinting = ""
                    End If
                    outputString += "<td class=""text"" align=""center""><input type=""text"" style=""width:100px"" name=""" + "PrefixTextPrinting" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + PrefixTextPrinting + """>" + "</td>"
					
                    If SaleMode.Rows(i)("HasServiceCharge") = 0 Then
                        outputString += "<td class=""text"" align=""center"" width=""100px""><table border=""0""><tr><td><input type=""Radio"" name=""" + "HasServiceCharge" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + "1" + """>YES" + "</td><td><input type=""Radio"" name=""" + "HasServiceCharge" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + "0" + """ checked>NO" + "</td></tr></table></td>"
                    Else
                        outputString += "<td class=""text"" align=""center"" width=""100px""><table border=""0""><tr><td><input type=""Radio"" name=""" + "HasServiceCharge" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + "1" + """ checked>YES" + "</td><td><input type=""Radio"" name=""" + "HasServiceCharge" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + "0" + """>NO" + "</td></tr></table></td>"
                    End If
					
                    If SaleMode.Rows(i)("Deleted") = 1 Then
                        outputString += "<td class=""text"" align=""center"" width=""100px""><table border=""0""><tr><td><input type=""Radio"" name=""" + "Deleted" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + "1" + """>YES" + "</td><td><input type=""Radio"" name=""" + "Deleted" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + "0" + """ checked>NO" + "</td></tr></table></td>"
                    Else
                        outputString += "<td class=""text"" align=""center"" width=""100px""><table border=""0""><tr><td><input type=""Radio"" name=""" + "Deleted" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + "1" + """ checked>YES" + "</td><td><input type=""Radio"" name=""" + "Deleted" + SaleMode.Rows(i)("SaleModeID").ToString + """ value=""" + "0" + """>NO" + "</td></tr></table></td>"
                    End If
					
                    outputString += "</tr>"
                Next
				
                If SaleMode.Rows.Count > 0 Then
                    SaleModeData.InnerHtml = outputString
                End If
				
            Else
                errorMsg.InnerHtml = "No property info"
            End If
            'Catch ex As Exception
            '	errorMsg.InnerHtml = ex.Message
            'End Try
		

        Else
            errorMsg.InnerHtml = "Access Denied"
            showContent.Visible = False
        End If
        
		
    End Sub

Sub DoAddUpdate(Source As Object, E As EventArgs)
	'Try
	
	Dim FoundError As Boolean = False
	Dim Result As String
	Dim ExtraSQL(1) As String
	ExtraSQL(0) = ""
	ExtraSQL(1) = ""
	
	MemberCodeError.InnerHtml = ""

	If FoundError = False Then
		Application.Lock()
		Result = updateDB.AddUpdateCategory(Request, ExtraSQL, "Property", "ID", objCnn)
		Application.UnLock()
		If Result = "Success" Then
			Dim ResultDynamic As String = Prop.UpdateDynamicPropInfo("Update",1,1,Request,objCnn)
			Dim ResultUpdate As Boolean = getInfo.UpdateComputerReceipt(0,Trim(DocumentTypeHeader.Text),Trim(FullTaxTypeHeader.Text),Trim(CreditMoneyTypeHeader.Text),Session("LangID"),objCnn)
			UpdateSaleMode(Request, objCnn)
			Response.Redirect("main.aspx?done=yes")
		Else
			errorMsg.InnerHtml = Result
		End If
	End If
	'Catch ex As Exception
			'errorMsg.InnerHtml = "Unexpected Error"
	'End Try
End Sub

    Private Function CreateRoundTypeCombo(comboRoundTypeName As String, currentRoundTypeValue As Integer) As String
        Dim strSelectText As String
        strSelectText = "<select name=""" & comboRoundTypeName & """>"
        strSelectText += "<option value=""0"""
        If currentRoundTypeValue = 0 Then
            strSelectText += " selected"
        End If
        strSelectText += ">No Rounding"
        strSelectText += "<option value=""1"""
        If currentRoundTypeValue = 1 Then
            strSelectText += " selected"
        End If
        strSelectText += ">Round Up 0 and 1"
        strSelectText += "<option value=""2"""
        If currentRoundTypeValue = 2 Then
            strSelectText += " selected"
        End If
        strSelectText += ">Round Up 0, 0.50, 1"
        strSelectText += "<option value=""3"""
        If currentRoundTypeValue = 3 Then
            strSelectText += " selected"
        End If
        strSelectText += ">Round Up 0, 0.25, 0.50, 1"
				
        strSelectText += "<option value=""4"""
        If currentRoundTypeValue = 4 Then
            strSelectText += " selected"
        End If
        strSelectText += ">Round Down 0 and 1"
        strSelectText += "<option value=""5"""
        If currentRoundTypeValue = 5 Then
            strSelectText += " selected"
        End If
        strSelectText += ">Round Down 0, 0.50, 1"
        strSelectText += "<option value=""6"""
        If currentRoundTypeValue = 6 Then
            strSelectText += " selected"
        End If
        strSelectText += ">Round Down 0, 0.25, 0.50, 1"
				
        strSelectText += "<option value=""7"""
        If currentRoundTypeValue = 7 Then
            strSelectText += " selected"
        End If
        strSelectText += ">Round Based On Function 0 and 1"
        strSelectText += "<option value=""8"""
        If currentRoundTypeValue = 8 Then
            strSelectText += " selected"
        End If
        strSelectText += ">Round Based On Function 0, 0.50, 1"
        strSelectText += "<option value=""9"""
        If currentRoundTypeValue = 9 Then
            strSelectText += " selected"
        End If
        strSelectText += ">Round Based On Function 0, 0.25, 0.50, 1"
				
        strSelectText += "<option value=""10"""
        If currentRoundTypeValue = 10 Then
            strSelectText += " selected"
        End If
        strSelectText += ">Round Based On Function 0, 1(0.5 RoundDown)"
				
        strSelectText += "<option value=""11"""
        If currentRoundTypeValue = 11 Then
            strSelectText += " selected"
        End If
        strSelectText += ">Round Based On Function 0, 0.50, 1(0.5 RoundDown)"
			
        strSelectText += "<option value=""12"""
        If currentRoundTypeValue = 12 Then
            strSelectText += " selected"
        End If
        strSelectText += ">Round Based On Function 0, 0.25, 0.50, 1(0.5 RoundDown)"
				
        strSelectText += "<option value=""13"""
        If currentRoundTypeValue = 13 Then
            strSelectText += " selected"
        End If
        strSelectText += ">Round Based on Malaysia"

        strSelectText += "</select>"
        
        Return strSelectText
    End Function
    
    Public Function UpdateSaleMode(ByVal Request As Object, ByVal objCnn As MySqlConnection) As String
        Dim SaleMode As DataTable = objDB.List("select * from SaleMode where SaleModeID>1 order by SaleModeID", objCnn)
        Dim UpString, sqlStatement, TestString As String
        Dim i As Integer
        For i = 0 To SaleMode.Rows.Count - 1
            UpString = ""
            If Not Request.Form("SaleModeName" & SaleMode.Rows(i)("SaleModeID").ToString) Is Nothing Then
                If Trim(Request.Form("SaleModeName" & SaleMode.Rows(i)("SaleModeID").ToString)) <> "" Then
                    If UpString = "" Then
                        UpString = "SaleModeName='" + Replace(Request.Form("SaleModeName" & SaleMode.Rows(i)("SaleModeID").ToString), "'", "''") + "'"
                    Else
                        UpString += ",SaleModeName='" + Replace(Request.Form("SaleModeName" & SaleMode.Rows(i)("SaleModeID").ToString), "'", "''") + "'"
                    End If
                End If
            End If
		
            If Not Request.Form("ReceiptHeaderText" & SaleMode.Rows(i)("SaleModeID").ToString) Is Nothing Then
                If Trim(Request.Form("ReceiptHeaderText" & SaleMode.Rows(i)("SaleModeID").ToString)) <> "" Then
                    If UpString = "" Then
                        UpString = "ReceiptHeaderText='" + Replace(Request.Form("ReceiptHeaderText" & SaleMode.Rows(i)("SaleModeID").ToString), "'", "''") + "'"
                    Else
                        UpString += ",ReceiptHeaderText='" + Replace(Request.Form("ReceiptHeaderText" & SaleMode.Rows(i)("SaleModeID").ToString), "'", "''") + "'"
                    End If
                End If
            End If
		
            If Not Request.Form("PrefixText" & SaleMode.Rows(i)("SaleModeID").ToString) Is Nothing Then
                If Trim(Request.Form("PrefixText" & SaleMode.Rows(i)("SaleModeID").ToString)) <> "" Then
                    If UpString = "" Then
                        UpString = "PrefixText='" + Replace(Request.Form("PrefixText" & SaleMode.Rows(i)("SaleModeID").ToString), "'", "''") + "'"
                    Else
                        UpString += ",PrefixText='" + Replace(Request.Form("PrefixText" & SaleMode.Rows(i)("SaleModeID").ToString), "'", "''") + "'"
                    End If
                End If
            End If
		
            If Not Request.Form("PrefixTextPrinting" & SaleMode.Rows(i)("SaleModeID").ToString) Is Nothing Then
                If Trim(Request.Form("PrefixTextPrinting" & SaleMode.Rows(i)("SaleModeID").ToString)) <> "" Then
                    If UpString = "" Then
                        UpString = "PrefixTextPrinting='" + Replace(Request.Form("PrefixTextPrinting" & SaleMode.Rows(i)("SaleModeID").ToString), "'", "''") + "'"
                    Else
                        UpString += ",PrefixTextPrinting='" + Replace(Request.Form("PrefixTextPrinting" & SaleMode.Rows(i)("SaleModeID").ToString), "'", "''") + "'"
                    End If
                End If
            End If
		
            If Not Request.Form("PositionPrefix" & SaleMode.Rows(i)("SaleModeID").ToString) Is Nothing Then
                If IsNumeric(Request.Form("PositionPrefix" & SaleMode.Rows(i)("SaleModeID").ToString)) Then
                    If UpString = "" Then
                        UpString = "PositionPrefix=" + Replace(Request.Form("PositionPrefix" & SaleMode.Rows(i)("SaleModeID").ToString), "'", "''")
                    Else
                        UpString += ",PositionPrefix=" + Replace(Request.Form("PositionPrefix" & SaleMode.Rows(i)("SaleModeID").ToString), "'", "''")
                    End If
                End If
            End If
		
            If Not Request.Form("HasServiceCharge" & SaleMode.Rows(i)("SaleModeID").ToString) Is Nothing Then
                If IsNumeric(Request.Form("HasServiceCharge" & SaleMode.Rows(i)("SaleModeID").ToString)) Then
                    If UpString = "" Then
                        UpString = "HasServiceCharge=" + Replace(Request.Form("HasServiceCharge" & SaleMode.Rows(i)("SaleModeID").ToString), "'", "''")
                    Else
                        UpString += ",HasServiceCharge=" + Replace(Request.Form("HasServiceCharge" & SaleMode.Rows(i)("SaleModeID").ToString), "'", "''")
                    End If
                End If
            End If
		
            If Not Request.Form("Deleted" & SaleMode.Rows(i)("SaleModeID").ToString) Is Nothing Then
                If IsNumeric(Request.Form("Deleted" & SaleMode.Rows(i)("SaleModeID").ToString)) Then
                    If Request.Form("Deleted" & SaleMode.Rows(i)("SaleModeID").ToString) = 0 Then
                        UpString += ",Deleted=1"
                    Else
                        UpString += ",Deleted=0"
                    End If
                End If
            End If
		
            If UpString <> "" Then
                sqlStatement = "UPDATE SaleMode SET " + UpString + " WHERE SaleModeID=" + SaleMode.Rows(i)("SaleModeID").ToString
                objDB.sqlExecute(sqlStatement, objCnn)
                TestString += "<BR>" + sqlStatement
            End If
		
        Next
        'errorMsg.InnerHtml = "Results<P>" + TestString
    End Function

Sub Page_UnLoad()
	objCnn.Close()
End Sub
</script>


</body>
</html>
