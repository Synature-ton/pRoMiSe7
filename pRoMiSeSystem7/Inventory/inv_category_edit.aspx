<%@ Page Language="VB" ContentType="text/html" EnableViewState="true" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="DynamicProperty" %>


<%@ Register tagprefix="synature" Tagname="province" Src="../UserControls/Province.ascx" %>
<%@ Register tagprefix="synature" Tagname="time" Src="../UserControls/Time.ascx" %>
<html>
<head>
<title>Manage Shop Info</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<form id="mainForm" runat="server">
<input type="hidden" id="ProductLevelID" runat="server" />
<input type="hidden" id="OldShopCode" runat="server" />
<input type="hidden" id="CompanyID" runat="server" />
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
	<td><asp:textbox ID="ProductLevelName" Width="200" runat="server" /></td>
</tr>
<span id="ShowLevelCode" visible="true" runat="server">
<div id="validateCode" runat="server" />
<tr>
	<td><div class="Text" id="CodeParam" runat="server"></div></td>
	<td><asp:textbox ID="ProductLevelCode" Width="200" runat="server" /><span id="CodeDigit" class="text" runat="server" /></td>
</tr>
</span>

<span id="invcode" visible="false" runat="server">
<tr>
	<td><div class="Text" id="InvCodeParam" runat="server"></div></td>
	<td><asp:textbox ID="StockInventoryCode" Width="200" MaxLength="50" runat="server" /></td>
</tr>
</span>

<tr>
		<td class="text">Shop Category</td>
		<td class="text"><asp:DropDownList ID="ShopTypeID" CssClass="text" Width="250" Visible="true" AutoPostBack="false" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="CompanyNameParam" runat="server"></div></td>
	<td><asp:textbox ID="CompanyName" Width="300" runat="server" /></td>
</tr>

<tr>
	<td><div class="text" id="CompanyName2Param" runat="server"></div></td>
	<td><asp:textbox ID="AccountingCode" Width="300" runat="server" /></td>
</tr>

<span id="showFullTaxProp" visible="True" runat="server">
<tr>
	<td><div class="text" id="CompanyLocationParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="RadioHQ" name="HQBranch" value="1" runat="server" />HQ&nbsp;&nbsp;<input type="radio" id="RadioBranch" name="HQBranch" value="0" runat="server" />Branch No. <asp:textbox ID="BranchNo" Width="50" runat="server" /></td>
</tr>

<tr>
	<td><div class="text" id="CompanyName3Param" runat="server"></div></td>
	<td><asp:textbox ID="FullTaxBranchName" Width="300" runat="server" /></td>
</tr>

</span>

<tr>
	<td><div class="text" id="CompanyAddress1Param" runat="server"></div></td>
	<td><asp:textbox ID="CompanyAddress1" Width="300" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="CompanyAddress2Param" runat="server"></div></td>
	<td><asp:textbox ID="CompanyAddress2" Width="300" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="CompanyCityParam" runat="server"></div></td>
	<td><asp:textbox ID="CompanyCity" Width="300" runat="server" /></td>
</tr>


<tr>
	<td><div class="text" id="CompanyProvinceParam" runat="server"></div></td>
	<td><synature:province id="GetProvince" runat="server" /></td>
</tr>

<tr>
	<td><div class="text" id="CompanyProvinceInFullTaxParam" runat="server"></div></td>
	<td><asp:DropDownList ID="DisplayCompanyProvinceLangID" CssClass="text" runat="server"></asp:DropDownList></td>
</tr>

<tr>
	<td><div class="text" id="CompanyZipCodeParam" runat="server"></div></td>
	<td><asp:textbox ID="CompanyZipCode" Width="150" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="CompanyTelParam" runat="server"></div></td>
	<td><asp:textbox ID="CompanyTelephone" Width="150" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="CompanyFaxParam" runat="server"></div></td>
	<td><asp:textbox ID="CompanyFax" Width="150" runat="server" /></td>
</tr>
<tr>
	<td><div class="text" id="CompanyTaxIDParam" runat="server"></div></td>
	<td><asp:textbox ID="CompanyTaxID" Width="150" runat="server" /></td>
</tr>
<span id="showAddress2" visible="false" runat="server">

<tr>
	<td class="text">Delivery Name</td>
	<td><asp:textbox ID="DeliveryName" Width="300" runat="server" /></td>
</tr>

<tr>
	<td class="text">Delivery Address 1</td>
	<td><asp:textbox ID="DeliveryAddress1" Width="300" runat="server" /></td>
</tr>
<tr>
	<td class="text">Delivery Address2</td>
	<td><asp:textbox ID="DeliveryAddress2" Width="300" runat="server" /></td>
</tr>
<tr>
	<td class="text">Delivery City</td>
	<td><asp:textbox ID="DeliveryCity" Width="300" runat="server" /></td>
</tr>


<tr>
	<td class="text">Delivery Province</td>
	<td><synature:province id="DeliveryProvince" runat="server" /></td>
</tr>

<tr>
	<td class="text">Delivery Zip Code</td>
	<td><asp:textbox ID="DeliveryZipCode" Width="150" runat="server" /></td>
</tr>
<tr>
	<td class="text">Delivery Tel</td>
	<td><asp:textbox ID="DeliveryTelephone" Width="150" runat="server" /></td>
</tr>
<tr>
	<td class="text">Delivery Fax</td>
	<td><asp:textbox ID="DeliveryFax" Width="150" runat="server" /></td>
</tr>

</span>
<tr>
	<td><div class="text" id="CompanyRegIDParam" runat="server"></div></td>
	<td><asp:textbox ID="CompanyRegisterID" Width="150" runat="server" /></td>
</tr>
<div id="ValidateVAT" runat="server"></div>
<tr>
	<td><div class="text" id="CompanyVATParam" runat="server"></div></td>
	<td class="text"><asp:textbox ID="CompanyVAT" Width="40" runat="server" />%</td>
</tr>
<tr>
		<td class="text">IP Address for Remote Access</td>
		<td class="text"><asp:textbox ID="IPAddress" Width="150" runat="server" /></td>
	</tr>

<div id="validateFromTime" runat="server" />
<tr>
	<td><div class="text" id="FromTimeParam" runat="server"></div></td>
	<td><synature:time id="OpenHour" runat="server" /></td>
</tr>
<div id="validateToTime" runat="server" />
<tr>
	<td><div class="text" id="ToTimeParam" runat="server"></div></td>
	<td><synature:time id="CloseHour" runat="server" /></td>
</tr>

<div id="validateEndDayFromTime" runat="server" />
<tr>
	<td><div class="text" id="EndDayFromTimeParam" runat="server"></div></td>
	<td><synature:time id="EndDayOpenHour" runat="server" /></td>
</tr>
<div id="validateEndDayToTime" runat="server" />
<tr>
	<td><div class="text" id="EndDayToTimeParam" runat="server"></div></td>
	<td><synature:time id="EndDayCloseHour" runat="server" /></td>
</tr>

<div id="ShowShopData" runat="server">
<div id="ValidateServiceCharge" runat="server"></div>
<tr>
	<td><div class="text" id="ServiceChargeParam" runat="server"></div></td>
	<td class="text"><asp:textbox ID="ServiceCharge" Width="40" runat="server" />%</td>
</tr>
<tr>
	<td><div class="text" id="ServiceChargeTypeParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio13" name="ServiceChargeType" value="1" runat="server" /><span id="BeforeDiscount" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio14" name="ServiceChargeType" value="2" runat="server" /><span id="AfterDiscount" runat="server"></span></td>
</tr>
<tr id="showSCType" visible="false" runat="server">
	<td class="text"><div class="text" id="IsIncludeVAT" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio15" name="IsServiceChargeIncludeVAT" value="1" runat="server" /><span id="YesText3" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio16" name="IsServiceChargeIncludeVAT" value="0" runat="server" /><span id="NoText3" runat="server"></span></td>
</tr>

<div id="validateSessionTime" runat="server" />
<tr id="lastsession" visible="false" runat="server">
	<td class="text">Last Session Duration</td>
	<td><table cellpadding="0" cellspacing="0"><tr><td><synature:time id="StartHourForCheckingCloseSession" runat="server" /></td><td class="text">&nbsp;&nbsp;to&nbsp;&nbsp;</td><td><synature:time id="EndHourForCheckingCloseSession" runat="server" /></td></table></td>
</tr>

<span id="showService" runat="server">
<tr>
	<td class="text">Ignore Checking Staff</td>
	<td class="text"><input type="radio" id="Radio20" name="SpaIgnoreStaffAtFront" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio21" name="SpaIgnoreStaffAtFront" value="0" runat="server" />NO</td>
</tr>
<tr>
	<td class="text">Ignore Checking Room</td>
	<td class="text"><input type="radio" id="Radio30" name="SpaIgnoreRoomAtFront" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio31" name="SpaIgnoreRoomAtFront" value="0" runat="server" />NO</td>
</tr>
<div id="Reservation" visible="false" runat="server">
<tr>
	<td class="text">Ignore Checking Staff (Reservation)</td>
	<td class="text"><input type="radio" id="Radio32" name="SpaIgnoreStaffWhenReserve" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio33" name="SpaIgnoreStaffWhenReserve" value="0" runat="server" />NO</td>
</tr>
<tr>
	<td class="text">Ignore Checking Room (Reservation)</td>
	<td class="text"><input type="radio" id="Radio34" name="SpaIgnoreRoomWhenReserve" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio35" name="SpaIgnoreRoomWhenReserve" value="0" runat="server" />NO</td>
</tr>
</div>
<tr>
	<td class="text">Order Staff By Queue</td>
	<td class="text"><input type="radio" id="Radio22" name="OrderSpaStaffByQueue" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio23" name="OrderSpaStaffByQueue" value="0" runat="server" />NO</td>
</tr>
<tr>
		<td class="text">Print Component</td>
		<td class="text"><input type="radio" id="Radio26" name="PrintProductComponentAmountToKitchen" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio27" name="PrintProductComponentAmountToKitchen" value="0" runat="server" />NO&nbsp;&nbsp;<input type="radio" id="Radio100" name="PrintProductComponentAmountToKitchen" value="2" runat="server" />YES (With amount of component)</td>
	</tr>
	
</span>
	<tr>
		<td class="text">Print Receipt Datetime Option</td>
		<td class="text"><input type="radio" id="Radio92" name="PrintOpenTimeInReceipt" value="1" runat="server" />Print Open and Paid date time&nbsp;&nbsp;<input type="radio" id="Radio92_2" name="PrintOpenTimeInReceipt" value="2" runat="server" />Print Receipt date only&nbsp;&nbsp;<input type="radio" id="Radio93" name="PrintOpenTimeInReceipt" value="0" runat="server" />Print Receipt date and time</td>
	</tr>
	<tr>
		<td class="text">Print Avg/Customer in Receipt</td>
		<td class="text"><input type="radio" id="Radio90" name="PrintAveragePricePerCustomer" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio91" name="PrintAveragePricePerCustomer" value="0" runat="server" />NO</td>
	</tr>
	<tr>
		<td class="text">Print Customer Detail in Receipt</td>
		<td class="text"><input type="radio" id="Radio24" name="PrintCustomerDetailInBill" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio25" name="PrintCustomerDetailInBill" value="0" runat="server" />NO</td>
	</tr>
	
	<tr>
		<td class="text">Print Flexible Product Details in Bill</td>
		<td class="text"><input type="radio" id="Radio42" name="PrintFlexibleProductDetailInBill" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio43" name="PrintFlexibleProductDetailInBill" value="0" runat="server" />NO</td>
	</tr>
	
	<tr>
		<td class="text">Print Promotion Details in Bill</td>
		<td class="text"><input type="radio" id="Radio44" name="PrintSummaryEachPromotionDetailInBill" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio45" name="PrintSummaryEachPromotionDetailInBill" value="0" runat="server" />NO</td>
	</tr>
	
	<tr>
		<td class="text">Print Summary Product Group in Bill</td>
		<td class="text"><input type="radio" id="Radio64" name="PrintSummaryProductGroupInBill" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio65" name="PrintSummaryProductGroupInBill" value="0" runat="server" />NO</td>
	</tr>
	
	<tr>
		<td class="text">Void Bill Time Condition</td>
		<td class="text"><input type="radio" id="Radio40_0" name="VoidSearchTimeCondition" value="0" runat="server" />No time limit&nbsp;&nbsp;<input type="radio" id="Radio40_1" name="VoidSearchTimeCondition" value="1" runat="server" />Only same day&nbsp;&nbsp;<input type="radio" id="Radio40_2" name="VoidSearchTimeCondition" value="2" runat="server" />Only same day and only not closed session</td>
	</tr>
	
	<tr>
		<td class="text">Void Bill Terminal Condition</td>
		<td class="text"><input type="radio" id="Radio41_0" name="VoidSearchComputerCondition" value="0" runat="server" />Search all terminals&nbsp;&nbsp;<input type="radio" id="Radio41_1" name="VoidSearchComputerCondition" value="1" runat="server" />Search only its own terminal</td>
	</tr>
	
	<tr>
		<td class="text">Reprint Bill Time Condition</td>
		<td class="text"><input type="radio" id="Radio42_0" name="ReprintSearchTimeCondition" value="0" runat="server" />No time limit&nbsp;&nbsp;<input type="radio" id="Radio42_1" name="ReprintSearchTimeCondition" value="1" runat="server" />Only same day&nbsp;&nbsp;<input type="radio" id="Radio42_2" name="ReprintSearchTimeCondition" value="2" runat="server" />Only same day and only not closed session</td>
	</tr>
	
	<tr>
		<td class="text">Reprint Bill Terminal Condition</td>
		<td class="text"><input type="radio" id="Radio43_0" name="ReprintSearchComputerCondition" value="0" runat="server" />Search all terminals&nbsp;&nbsp;<input type="radio" id="Radio43_1" name="ReprintSearchComputerCondition" value="1" runat="server" />Search only its own terminal</td>
	</tr>
	
	<tr id="Budjeting" visible="false" runat="server">
		<td class="text">Budgeting View Type</td>
		<td class="text"><asp:radiobuttonlist ID="TypeList" RepeatDirection="Horizontal" CssClass="text" Visible="true" AutoPostBack="false" runat="server">
		<asp:ListItem></asp:ListItem>
		<asp:ListItem></asp:ListItem>
		<asp:ListItem></asp:ListItem>
	</asp:radiobuttonlist></td>
	</tr>
	
	<tr>
		<td class="text">Display Transaction Time</td>
		<td class="text"><input type="radio" id="Radio28" name="DisplayTransactionTime" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio29" name="DisplayTransactionTime" value="0" runat="server" />NO</td>
	</tr>
	
	<tr>
		<td class="text">Insert Staff When Submit Order</td>
		<td class="text"><input type="radio" id="Radio866" name="InsertStaffWhenSubmitOrder" value="3" runat="server" />YES (Staff Clock In)&nbsp;&nbsp;<input type="radio" id="Radio86" name="InsertStaffWhenSubmitOrder" value="2" runat="server" />YES (With Password)&nbsp;&nbsp;<input type="radio" id="Radio84" name="InsertStaffWhenSubmitOrder" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio85" name="InsertStaffWhenSubmitOrder" value="0" runat="server" />NO</td>
	</tr>
	
	<tr>
		<td class="text">Lock Editing Order After Print Bill</td>
		<td class="text"><input type="radio" id="Radio87" name="LockEditOrderAfterPrintBillDetail" value="1" runat="server" />YES (With Authorize)&nbsp;&nbsp;<input type="radio" id="Radio88" name="LockEditOrderAfterPrintBillDetail" value="2" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio88_3" name="LockEditOrderAfterPrintBillDetail" value="3" runat="server" />YES (Full Lock)&nbsp;&nbsp;<input type="radio" id="Radio89" name="LockEditOrderAfterPrintBillDetail" value="0" runat="server" />NO</td>
	</tr>
	
	<tr>
		<td class="text">Refresh Front</td>
		<td class="text"><asp:textbox ID="RefreshpRoMiSeFrontTransaction" Text="60" Width="40" runat="server" /> second(s) NOTE: 0=Not Refresh</td>
	</tr>
	
	<tr>
		<td><div class="text" id="PrinterParam" runat="server"></div></td>
		<td><div id="PrinterSelectionText" runat="server"></div></td>
	</tr>
	
	<tr>
		<td class="text">Print Bill Detail Ordering</td>
		<td class="text"><asp:DropDownList ID="OrderingPrintBillDetailBy" CssClass="text" Visible="true" AutoPostBack="false" runat="server" /></td>
	</tr>
	<!---
	<tr>
		<td class="text">Print Discount Promotion Detail in Receipt</td>
		<td class="text"><input type="radio" id="Radio54" name="PrintSummaryEachPromotionDetailInBill" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio55" name="PrintSummaryEachPromotionDetailInBill" value="0" runat="server" />NO</td>
	</tr>--->
	
	<tr>
		<td class="text"><div class="text" id="PrintVATParam" runat="server"></div></td>
		<td class="text"><input type="radio" id="Radio9" name="PrintVATInReceipt" value="1" runat="server" /><span id="YesText2" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio10" name="PrintVATInReceipt" value="0" runat="server" /><span id="NoText2" runat="server"></span></td>
	</tr>
	<tr>
		<td class="text"><div class="text" id="AllowPrintedOrderParam" runat="server"></div></td>
		<td class="text"><input type="radio" id="Radio11" name="AllowEditPrintedOrder" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio12" name="AllowEditPrintedOrder" value="0" runat="server" />NO</td>
	</tr>
    
    <tr>
		<td class="text">Print Receipt Reference with Barcode</td>
		<td class="text"><div id="DisplayPrintReferenceYesNo" runat="server" visible="true">
            <input type="radio" id="optPrintReferenceInBill" name="PrintReferenceBarCodeInReceipt" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="optNotPrintReferenceInBill" name="PrintReferenceBarCodeInReceipt" value="0" runat="server" />NO
            </div><asp:DropDownList ID="cboPrintReferenceBarCode" CssClass="text" Visible="false" AutoPostBack="false" runat="server" /></td>
	</tr>
    
     <tr>
		<td class="text">Print Coupon Barcode in Redeem Receipt</td>
		<td class="text"><input type="radio" id="Radio202" name="PrintBarCodeForCouponVoucherInReciept" value="1" runat="server" />Both Number and Barcode&nbsp;&nbsp;<input type="radio" id="Radio203" name="PrintBarCodeForCouponVoucherInReciept" value="0" runat="server" />Only Number</td>
	</tr>
    
    <tr>
		<td class="text">Has Call for Check Bill for Tablet</td>
		<td class="text"><input type="radio" id="Radio204" name="HasCallForCheckBillFeature" value="1" runat="server" />YES (To Cashier)&nbsp;&nbsp;<input type="radio" id="Radio204_2" name="HasCallForCheckBillFeature" value="2" runat="server" />YES (Print Bill to Printer)&nbsp;&nbsp;<input type="radio" id="Radio205" name="HasCallForCheckBillFeature" value="0" runat="server" />NO</td>
	</tr>
	
	
	<span id="DynamicPropUser" runat="server"></span>
	
</div>

	<tr>
		<td class="text">Ordering</td>
		<td class="text"><asp:textbox ID="ProductLevelOrder" Text="60" Width="40" runat="server" /></td>
	</tr>
</table>
<div id="showAdminFeature" visible="false" runat="server">
	<BR>
	<table id="myTable2" class="blue" width="100%">
	<thead>
	<tr>
		<th class="boldText" colspan="2" align="left">Administration Area</td>
	</tr>
    <tr>
    	<th align="center">Description</th>
        <th align="center">Value</th>
    </tr>
    </thead>

    <tbody>
    <span id="ShowMulti" visible="false" runat="server">
	<span id="ValidateMasterShop" runat="server"></span>
	<tr>
		<td class="text">Master Shop ID</td>
		<td class="text"><asp:textbox ID="MasterShop" Width="40" runat="server" /> 0=Regular, >0 = Master Shop</td>
	</tr>
	<span id="ValidateMasterShopLink" runat="server"></span>
	<tr>
		<td class="text">Master Shop Link</td>
		<td class="text"><asp:textbox ID="MasterShopLink" Width="40" runat="server" /> 0=No Link to Master Shop, >0 = Link to Master Shop (If MasterShopID>0, MasterShopLink must be 0)</td>
	</tr>
    
    
    
	</span>
    
    <tr>
		<td class="text">Show In Report (for MultiShop)</td>
		<td class="text"><input type="radio" id="Radio114" name="ShowInReport" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio115" name="ShowInReport" value="0" runat="server" />NO</td>
	</tr>
    
	<tr>
		<td><div class="text" id="IsShopParam" runat="server"></div></td>
		<td class="text"><input type="radio" id="Radio1" name="IsShop" value="1" runat="server" /><span id="YesText" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio2" name="IsShop" value="0" runat="server" /><span id="NoText" runat="server"></span></td>
	</tr>
	<tr>
		<td><div class="text" id="IsInvParam" runat="server"></div></td>
		<td class="text"><input type="radio" id="Radio3" name="IsInv" value="1" runat="server" /><span id="YesText1" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio4" name="IsInv" value="0" runat="server" /><span id="NoText1" runat="server"></span></td>
	</tr>
    
    
	
	<tr>
		<td class="text"><div class="text" id="ShopTypeParam" runat="server"></div></td>
		<td class="text"><input type="radio" id="Radio5" name="ShopType" value="1" runat="server" />Table&nbsp;&nbsp;<input type="radio" id="Radio6" name="ShopType" value="2" runat="server" />Fast Food<span id="showSpa" runat="server">&nbsp;&nbsp;<input type="radio" id="Radio19" name="ShopType" value="3" runat="server" />Spa</span></td>
	</tr>
    
    <tr>
		<td class="text">Fast Food Type</td>
		<td class="text"><input type="radio" id="Radio555" name="FastFoodType" value="1" runat="server" />Input Table Number&nbsp;&nbsp;<input type="radio" id="Radio556" name="FastFoodType" value="2" runat="server" />Direct to Order Screen</td>
	</tr>
    
    <tr>
		<td class="text">Table Type (For Tablet)</td>
		<td class="text"><input type="radio" id="Radio5555" name="TableType" value="1" runat="server" />Table List&nbsp;&nbsp;<input type="radio" id="Radio5556" name="TableType" value="2" runat="server" />Table Layout&nbsp;&nbsp;<input type="radio" id="Radio5557" name="TableType" value="3" runat="server" />Fix to Table</td>
	</tr>
	
<span id="ProductFeature" runat="server">
	<tr>
		<td class="text"><div class="text" id="FastFoodVoidParam" runat="server"></div></td>
		<td class="text"><input type="radio" id="Radio17" name="FastFoodVoidOrder" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio18" name="FastFoodVoidOrder" value="0" runat="server" />NO</td>
	</tr>
</span>
	<tr>
		<td class="text"><div class="text" id="ShowInProfitLossParam" runat="server"></div></td>
		<td class="text"><input type="radio" id="Radio7" name="ShowInProfitLossReport" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio8" name="ShowInProfitLossReport" value="0" runat="server" />NO</td>
	</tr>
	
	
	
	<tr>
		<td class="text"><div class="text" id="DisplayVATTypeParam" runat="server"></div></td>
		<td class="text"><input type="radio" id="Radio50" name="DisplayReceiptVATableType" value="1" runat="server" />Include VAT&nbsp;&nbsp;<input type="radio" id="Radio51" name="DisplayReceiptVATableType" value="2" runat="server" />Exclude VAT</td>
	</tr>
	
	<tr>
		<td class="text"><div class="text" id="IsStockAtRealTimeParam" runat="server"></div></td>
		<td class="text"><input type="radio" id="Radio52" name="IsStockAtRealTime" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio53" name="IsStockAtRealTime" value="0" runat="server" />NO</td>
	</tr>
	
	<tr>
		<td class="text">Auto Close Session When Log Off</td>
		<td class="text"><input type="radio" id="Radio56" name="AutoCloseSessionWhenLogOff" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio57" name="AutoCloseSessionWhenLogOff" value="0" runat="server" />NO</td>
	</tr>
	
	<tr>
		<td><div class="text">Calculate Costing Type</div></td>
		<td><div class="text" id="CostingSelection" runat="server"></div></td>
	</tr>
	
	<tr>
		<td class="text">Database Name for Remote Access</td>
		<td class="text"><asp:textbox ID="DatabaseName" Width="150" runat="server" /></td>
	</tr>
	<tr>
		<td class="text">Print Receipt Type ID</td>
		<td class="text"><asp:textbox ID="PrintFunction" Width="40" runat="server" /> 0=Default</td>
	</tr>
	
	<tr>
		<td class="text">Is Branch (For Adding Members)</td>
		<td class="text"><input type="radio" id="Radio36" name="IsBranch" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio37" name="IsBranch" value="0" runat="server" />NO (YES=Branch cannot add member, must select from "xx")</td>
	</tr>
	
	<tr>
		<td class="text">Can Custom Receipt Select Printer</td>
		<td class="text"><input type="radio" id="Radio38" name="CanCustomReceiptSelectPrinter" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio39" name="CanCustomReceiptSelectPrinter" value="0" runat="server" />NO (Effect only printer function is not 0: custom receipt)</td>
	</tr>
	
	<tr>
		<td class="text">List Materials Based on Monthly Stock</td>
		<td class="text"><input type="radio" id="Radio58" name="ListMaterialSetByMonthlyStock" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio59" name="ListMaterialSetByMonthlyStock" value="0" runat="server" />NO</td>
	</tr>
	<span id="SpaFeature" runat="server">
	<tr>
		<td class="text">Number Of Time Slot for One Hour</td>
		<td class="text"><asp:textbox ID="NoSlotInOneHour" Width="40" runat="server" /> Ex: 6 => 1 Slot = 10 minutes</td>
	</tr>
	</span>
	<tr id="holdorder" visible="false" runat="server">
		<td class="text">Number of Day for Delete Hold Order</td>
		<td class="text"><asp:textbox ID="NoDayForDeleteHoldTransaction" Text="60" Width="40" runat="server" /> day(s) NOTE: 0=No Deletion</td>
	</tr>
	<tr>
		<td class="text"><div class="text" id="PrintBillDetailBeforeCheckBillParam" runat="server"></div></td>
		<td class="text"><input type="radio" id="Radio80" name="PrintBillDetailBeforeCheckBill" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio81" name="PrintBillDetailBeforeCheckBill" value="0" runat="server" />NO</td>
	</tr>
	<tr>
		<td class="text"><div class="text" id="AllowAddCommentInOrderParam" runat="server"></div></td>
		<td class="text"><input type="radio" id="Radio68" name="AllowAddCommentInOrder" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio69" name="AllowAddCommentInOrder" value="0" runat="server" />NO</td>
	</tr>
	<tr>
		<td class="text">Asking reason when void transaction</td>
		<td class="text"><input type="radio" id="Radio70" name="RequiredNoteForVoidTransaction" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio71" name="RequiredNoteForVoidTransaction" value="0" runat="server" />NO</td>
	</tr>
	<tr>
		<td class="text">Asking reason when reprint transaction</td>
		<td class="text"><input type="radio" id="Radio72" name="RequiredNoteForReprintTransaction" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio73" name="RequiredNoteForReprintTransaction" value="0" runat="server" />NO</td>
	</tr>
	<tr>
		<td class="text">Asking reason when print bill more than one</td>
		<td class="text"><input type="radio" id="Radio74" name="RequiredNoteForPrintBillDetail" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio75" name="RequiredNoteForPrintBillDetail" value="0" runat="server" />NO</td>
	</tr>
	<tr>
		<td class="text">Asking reason when void printed order</td>
		<td class="text"><input type="radio" id="Radio76" name="RequiredNoteForVoidOrder" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio77" name="RequiredNoteForVoidOrder" value="0" runat="server" />NO</td>
	</tr>
    
   
	
	<span id="ResFeature" runat="server">
	<tr>
		<td class="text">Asking reason when move order/table</td>
		<td class="text"><input type="radio" id="Radio78" name="RequiredNoteMoveTableAndOrder" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio79" name="RequiredNoteMoveTableAndOrder" value="0" runat="server" />NO</td>
	</tr>
    
     <tr>
		<td class="text">Redeem Feature</td>
		<td class="text"><input type="radio" id="Radio94" name="HasRedeemFeature" value="1" runat="server" />Stand Alone&nbsp;&nbsp;<input type="radio" id="Radio104" name="HasRedeemFeature" value="2" runat="server" />Multishop Online&nbsp;&nbsp;<input type="radio" id="Radio95" name="HasRedeemFeature" value="0" runat="server" />NO</td>
	</tr>
    
    <tr>
		<td class="text">Deposit Bank Feature</td>
		<td class="text"><input type="radio" id="Radio96" name="HasBankAccountFeature" value="1" runat="server" />Print at End Shift&nbsp;&nbsp;<input type="radio" id="Radio106" name="HasBankAccountFeature" value="2" runat="server" />Print at End Day&nbsp;&nbsp;<input type="radio" id="Radio97" name="HasBankAccountFeature" value="0" runat="server" />NO</td>
	</tr>
    
	<tr>
		<td class="text"><div class="text" id="HasCheckerSystemParam" runat="server"></div></td>
		<td class="text"><input type="radio" id="Radio60" name="HasCheckerSystem" value="1" runat="server" />Move process when close bill&nbsp;&nbsp;<input type="radio" id="Radio600" name="HasCheckerSystem" value="2" runat="server" />Move process after end day&nbsp;&nbsp;<input type="radio" id="Radio601" name="HasCheckerSystem" value="3" runat="server" />Full KDS System&nbsp;&nbsp;<input type="radio" id="Radio61" name="HasCheckerSystem" value="0" runat="server" />NO</td>
	</tr>
    <tr>
		<td class="text">Print ticket after check out from KDS</td>
		<td class="text"><input type="radio" id="Radio110" name="PrintOrderAfterFinishOrderProcess" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio111" name="PrintOrderAfterFinishOrderProcess" value="0" runat="server" />NO</td>
	</tr>
     <tr>
		<td class="text">Not Print order to kitchen that use KDS</td>
		<td class="text"><input type="radio" id="Radio112" name="NotPrintOrderWhenCreateOrderProcess" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio113" name="NotPrintOrderWhenCreateOrderProcess" value="0" runat="server" />NO</td>
	</tr>
    <tr>
		<td class="text">Void Item in Bill Option</td>
		<td class="text"><input type="radio" id="Radio119" name="VoidBillProduceProductOption" value="1" runat="server" />Move deleted items to history&nbsp;&nbsp;<input type="radio" id="Radio120" name="VoidBillProduceProductOption" value="2" runat="server" />Show Deleted Items</td>
	</tr>
	
	<tr>
		<td class="text"><div class="text" id="AllowMoveOrderAfterPrintBillDetailParam" runat="server"></div></td>
		<td class="text"><input type="radio" id="Radio66" name="AllowMoveOrderAfterPrintBillDetail" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio67" name="AllowMoveOrderAfterPrintBillDetail" value="0" runat="server" />NO</td>
	</tr>
    
    <tr id="reserve" visible="true" runat="server">
		<td class="text"><div class="text" id="HasReserveFeatureParam" runat="server"></div></td>
		<td class="text"><input type="radio" id="Radio62" name="HasReserveFeature" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio63" name="HasReserveFeature" value="0" runat="server" />NO</td>
	</tr>
	
	<div id="validateReleaseTime" runat="server" />
	<tr id="reserve2" visible="false" runat="server">
		<td class="text"><div class="text" id="ReleaseReserveTimeParam" runat="server"></div></td>
		<td class="text"><asp:textbox ID="ReleaseReserveTime" Text="60" Width="40" runat="server" /> minute(s) NOTE: If < 0, it means over the specified time.</td>
	</tr>
    
    <div id="validatePopup" runat="server" />
	<tr>
		<td class="text">Open Pop Up Setting<br><span class="smalltext">(Table: 0=Normal, 1=Open with Popup for input number of customer)<br>(Fast Food:0=No pop up, 1=Pop up with manual input number, &gt;=100 Auto reset from number setting</span></td>
		<td class="text"><asp:textbox ID="FastFoodAddCustomerDetailForNewTransaction" Text="0" Width="40" runat="server" /></td>
	</tr>
	
	<tr>
		<td class="text"><div class="text" id="HasSplitTransactionFeatureParam" runat="server"></div></td>
		<td class="text"><input type="radio" id="Radio82" name="HasSplitTransactionFeature" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio83" name="HasSplitTransactionFeature" value="0" runat="server" />NO</td>
	</tr>
    
    <tr>
		<td class="text">Buffet Feature</td>
		<td class="text"><input type="radio" id="Radio101" name="HasBuffetFeature" value="1" runat="server" />Start time when open table&nbsp;&nbsp;<input type="radio" id="Radio102" name="HasBuffetFeature" value="2" runat="server" />Start time when first dish finish&nbsp;&nbsp;<input type="radio" id="Radio103" name="HasBuffetFeature" value="0" runat="server" />NO</td>
	</tr>
    
    <tr>
		<td class="text">Buffet Time</td>
		<td class="text"><asp:textbox ID="BuffetTime" Text="60" Width="40" runat="server" /> minute(s)</td>
	</tr>
    
    <tr>
		<td class="text">Print Warning Time for Buffet</td>
		<td class="text"><asp:textbox ID="BuffetWarningTime" Text="60" Width="40" runat="server" /> minute(s)</td>
	</tr>
    
    <tr>
		<td class="text">Search Member Online</td>
		<td class="text"><input type="radio" id="Radio116" name="SearchMemberOnline" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio117" name="SearchMemberOnline" value="0" runat="server" />NO</td>
	</tr>
    
    <tr>
		<td class="text">Print Stock Only in Session</td>
		<td class="text"><input type="radio" id="Radio500" name="PrintStockOnlyInSession" value="0" runat="server" />Not Print&nbsp;&nbsp;<input type="radio" id="Radio501" name="PrintStockOnlyInSession" value="1" runat="server" />Print same as setting&nbsp;&nbsp;<input type="radio" id="Radio502" name="PrintStockOnlyInSession" value="2" runat="server" />Print every product detail</td>
	</tr>
    
    
	</span>
    <tbody>
    </table>
    
    <span id="SaleModeProp" runat="server"></span>

	<span id="DynamicPropAdmin" runat="server"></span>

</div>



<table width="100%">
<tr>
	<td align="center"><asp:button ID="SubmitForm" OnClick="DoAddUpdate" runat="server" />&nbsp;<asp:button ID="CancelButton" OnClick="DoCancel" runat="server" /></td>
</tr>
</table>
</form>

<div id="errorMsg" runat="server" />
<div id="errorMsg2" runat="server" />
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
Dim getProp As New CPreferences()
Dim getConfig As New POSConfiguration()
Dim objDB As New CDBUtil()
Dim Prop As New ConfigProperty()

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Inv_Inventory_Category") Then
            SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
            errorMsg.InnerHtml = ""
            'Try
            If Session("StaffRole") = 1 Then showAdminFeature.Visible = True
            objCnn = getCnn.EstablishConnection()
			
            Dim textTable As New DataTable()
            textTable = getPageText.GetText(9, Session("LangID"), objCnn)
			
            Dim defaultTextTable As New DataTable()
            defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
            CompanyNameParam.InnerHtml = textTable.Rows(2)("TextParamValue")
            CompanyAddress1Param.InnerHtml = textTable.Rows(3)("TextParamValue")
            CompanyAddress2Param.InnerHtml = textTable.Rows(4)("TextParamValue")
            CompanyCityParam.InnerHtml = textTable.Rows(5)("TextParamValue")
            CompanyProvinceParam.InnerHtml = textTable.Rows(6)("TextParamValue")
            CompanyZipCodeParam.InnerHtml = textTable.Rows(7)("TextParamValue")
            CompanyTelParam.InnerHtml = textTable.Rows(8)("TextParamValue")
            CompanyFaxParam.InnerHtml = textTable.Rows(9)("TextParamValue")
            CompanyTaxIDParam.InnerHtml = textTable.Rows(10)("TextParamValue")
            CompanyRegIDParam.InnerHtml = textTable.Rows(11)("TextParamValue")
            SubmitForm.Text = textTable.Rows(12)("TextParamValue")
            CompanyVATParam.InnerHtml = textTable.Rows(13)("TextParamValue")
            IsShopParam.InnerHtml = textTable.Rows(45)("TextParamValue")
            PrintVATParam.InnerHtml = textTable.Rows(99)("TextParamValue")
            ShopTypeParam.InnerHtml = textTable.Rows(100)("TextParamValue")
            ShowInProfitLossParam.InnerHtml = textTable.Rows(101)("TextParamValue")
            AllowPrintedOrderParam.InnerHtml = textTable.Rows(102)("TextParamValue")
            ServiceChargeParam.InnerHtml = textTable.Rows(103)("TextParamValue")
            ServiceChargeTypeParam.InnerHtml = textTable.Rows(105)("TextParamValue")
            BeforeDiscount.InnerHtml = textTable.Rows(106)("TextParamValue")
            AfterDiscount.InnerHtml = textTable.Rows(107)("TextParamValue")
            IsIncludeVAT.InnerHtml = textTable.Rows(104)("TextParamValue")
            FastFoodVoidParam.InnerHtml = textTable.Rows(118)("TextParamValue")
            DisplayVATTypeParam.InnerHtml = "Display Summary VAT Type"
            IsStockAtRealTimeParam.InnerHtml = "Calculate Stock At Front in Real-time"
            CodeParam.InnerHtml = "Shop Code"
            HasCheckerSystemParam.InnerHtml = "Has Checker System"
            HasReserveFeatureParam.InnerHtml = "Has Restaurant Reservation System"
            ReleaseReserveTimeParam.InnerHtml = "Cancel Reservation Time if late from appointment"
            AllowMoveOrderAfterPrintBillDetailParam.InnerHtml = "Allow move order after printing bill"
            AllowAddCommentInOrderParam.InnerHtml = "Enable Comment Feature"
            PrintBillDetailBeforeCheckBillParam.InnerHtml = "Must Print Bill before Check Bill"
            HasSplitTransactionFeatureParam.InnerHtml = "Has Split Bill Feature"
            CompanyName2Param.InnerHtml = "Branch Name"
            CompanyLocationParam.InnerHtml = "Company Register Location"
            CompanyName3Param.InnerHtml = "Branch Name in Full Tax Report"
            InvCodeParam.InnerHtml = "Inventory Code"
			
            YesText.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
            IsInvParam.InnerHtml = textTable.Rows(46)("TextParamValue")
            YesText1.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText1.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
            YesText2.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText2.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
            YesText3.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText3.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
			
            CompanyProvinceInFullTaxParam.InnerHtml = "Print province name in Full Tax in langauge:"
			
            FromTimeParam.InnerHtml = defaultTextTable.Rows(77)("TextParamValue")
            ToTimeParam.InnerHtml = defaultTextTable.Rows(78)("TextParamValue")
            OpenHour.LangID = Session("LangID")
            OpenHour.FormName = "OpenHour"
            OpenHour.SelectedHour = -1
            OpenHour.SelectedMinute = -1
			
            CloseHour.LangID = Session("LangID")
            CloseHour.FormName = "CloseHour"
            CloseHour.SelectedHour = -1
            CloseHour.SelectedMinute = -1
			
            EndDayFromTimeParam.InnerHtml = "Enable Lock Start Time for End of Day"
            EndDayToTimeParam.InnerHtml = "Enable Lock End Time for End of Day"
            EndDayOpenHour.FormName = "StartHourForCheckingCloseSession"
            EndDayOpenHour.SelectedHour = -1
            EndDayOpenHour.SelectedMinute = -1
			
            EndDayCloseHour.LangID = Session("LangID")
            EndDayCloseHour.FormName = "EndHourForCheckingCloseSession"
            EndDayCloseHour.SelectedHour = -1
            EndDayCloseHour.SelectedMinute = -1

            StartHourForCheckingCloseSession.LangID = Session("LangID")
            StartHourForCheckingCloseSession.FormName = "StartHourForCheckingCloseSession"
            StartHourForCheckingCloseSession.SelectedHour = -1
            StartHourForCheckingCloseSession.SelectedMinute = -1
			
            EndHourForCheckingCloseSession.LangID = Session("LangID")
            EndHourForCheckingCloseSession.FormName = "EndHourForCheckingCloseSession"
            EndHourForCheckingCloseSession.SelectedHour = -1
            EndHourForCheckingCloseSession.SelectedMinute = -1
			
            GetProvince.FormName = "CompanyProvince"
            GetProvince.LangID = Session("LangID")
			
            DeliveryProvince.FormName = "DeliveryProvince"
            DeliveryProvince.LangID = Session("LangID")
			
            PrinterParam.InnerHtml = "Printer for Printing Items Copy"
			
            TypeList.Items(0).Text = "Product Group"
            TypeList.Items(0).Value = "1"
            TypeList.Items(1).Text = "Product Dept"
            TypeList.Items(1).Value = "2"
            TypeList.Items(2).Text = "Product"
            TypeList.Items(2).Value = "3"
			
            Dim LangData As DataTable = objDB.List("SELECT * FROM Language", objCnn)
            DisplayCompanyProvinceLangID.DataSource = LangData
            DisplayCompanyProvinceLangID.DataValueField = "LangID"
            DisplayCompanyProvinceLangID.DataTextField = "LangName"
            DisplayCompanyProvinceLangID.DataBind()
					
            Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
            If PropertyInfo.Rows(0)("SystemTypeID") = 0 Or PropertyInfo.Rows(0)("SystemTypeID") = 3 Then
                showService.Visible = True
                showSpa.Visible = True
                SpaFeature.Visible = True
                ProductFeature.Visible = False
            Else
                SpaFeature.Visible = False
                showService.Visible = False
                showSpa.Visible = False
                ProductFeature.Visible = True
            End If
			
            If PropertyInfo.Rows(0)("SystemTypeID") = 0 Or PropertyInfo.Rows(0)("SystemTypeID") = 1 Or PropertyInfo.Rows(0)("SystemTypeID") = 2 Then
                ResFeature.Visible = True
            Else
                ResFeature.Visible = False
            End If
            If PropertyInfo.Rows(0)("SystemEditionID") = 1 Then
                ShowLevelCode.Visible = False
            End If
			
            If PropertyInfo.Rows(0)("MultiBranch") = 1 Then
                ShowMulti.Visible = True
            Else
                ShowMulti.Visible = False
            End If
			
            Dim ChkInvCode As Boolean = getProp.CheckTableColumn("ProductLevel", "StockInventoryCode", objCnn)
			
            invcode.Visible = False
            If ChkInvCode = False Then
                invcode.Visible = True
                Dim ChkInvTable As Boolean = getProp.CheckTableExist("ProductStockToInvSetting", objCnn)
                If ChkInvTable = False Then
                    objDB.sqlExecute("CREATE TABLE ProductStockToInvSetting (SettingID int Auto_Increment,SettingTypeID tinyint NOT NULL DEFAULT '0',StockInventoryCode varchar(50) NULL,ForGroupCode varchar(50) NULL,ForGroupID int NOT NULL DEFAULT '0',PRIMARY KEY (SettingID)) TYPE=INNODB", objCnn)
                End If
                Dim ChkInvID As Boolean = getProp.CheckTableColumn("ProductStockToInvSetting", "StockInventoryID", objCnn)
                If ChkInvID = True Then
                    objDB.sqlExecute("ALTER TABLE ProductStockToInvSetting ADD StockInventoryID int Not NULL DEFAULT '0' After StockInventoryCode", objCnn)
                End If
            End If
			
            Dim ChkDeliveryAddress As Boolean = getProp.CheckTableColumn("CompanyProfile", "DeliveryName", objCnn)
            showAddress2.Visible = False
            If ChkDeliveryAddress = False Then
                showAddress2.Visible = True
            End If
		
            Dim PrinterIDValueFromDB, CostingValueFromDB As Integer
            Dim i, j As Integer
            Dim orderingData As DataTable = objDB.List("select * from OrderingPrintBillDetailType order by orderingid", objCnn)
            Dim dtPrintReference As New DataTable
            If Not Page.IsPostBack Then
                OrderingPrintBillDetailBy.DataSource = orderingData
                OrderingPrintBillDetailBy.DataValueField = "OrderingID"
                OrderingPrintBillDetailBy.DataTextField = "Description"
                OrderingPrintBillDetailBy.DataBind()
            End If
            
            If Not Page.IsPostBack Then
                If getProp.CheckTableExist("PrintReferenceInReceiptType", objCnn) = False Then
                    DisplayPrintReferenceYesNo.Visible = True
                    cboPrintReferenceBarCode.Visible = False
                    dtPrintReference = New DataTable
                Else
                    DisplayPrintReferenceYesNo.Visible = False
                    cboPrintReferenceBarCode.Visible = True
                
                    dtPrintReference = objDB.List("Select * From PrintReferenceInReceiptType Where Deleted = 0 Order By PrintReferenceID", objCnn)
                    cboPrintReferenceBarCode.DataSource = dtPrintReference
                    cboPrintReferenceBarCode.DataValueField = "PrintReferenceID"
                    cboPrintReferenceBarCode.DataTextField = "Description"
                    cboPrintReferenceBarCode.DataBind()
                End If
            End If
		
            Dim ShopTypeData As DataTable = objDB.List("select * from ShopType where Deleted=0 order by ShopTypeOrdering", objCnn)
            If Not Page.IsPostBack Then
                ShopTypeID.DataSource = ShopTypeData
                ShopTypeID.DataValueField = "ShopTypeID"
                ShopTypeID.DataTextField = "ShopTypeName"
                ShopTypeID.DataBind()
            End If
		
            Dim ShopDefault As DataTable
            ShopDefault = getInfo.FirstLevel("ProductLevel", "ProductLevelID", 1, "", objCnn)
 		
            If ShopDefault.Rows.Count > 0 Then
                CodeDigit.InnerHtml = "Code must be " + Len(ShopDefault.Rows(0)("ProductLevelCode")).ToString + " digits"
            End If
		
            If Not Request.QueryString("ProductLevelID") And IsNumeric(Request.QueryString("ProductLevelID")) Then
		        ProductLevelID.Value = Request.QueryString("ProductLevelID")
                CompanyID.Value = Request.QueryString("ProductLevelID")
			
                If Not Page.IsPostBack Then
                    Dim getData As DataTable
                    getData = getInfo.FirstLevel("ProductLevel", "ProductLevelID", Request.QueryString("ProductLevelID"), "", objCnn)
					
                    If invcode.Visible = True Then
                        If Not IsDBNull(getData.Rows(0)("StockInventoryCode")) Then
                            StockInventoryCode.Text = getData.Rows(0)("StockInventoryCode")
                        End If
                    End If
                    If getData.Rows(0)("IsShop") = 0 Then
                        ShowShopData.Visible = False
                    Else
                        ShowShopData.Visible = True
                    End If
					
                    textTable = getPageText.GetText(7, Session("LangID"), objCnn)
							
                    If ProductLevelID.Value = 1 Then
                        ProductLevelCode.ReadOnly = False
                    Else
                        ProductLevelCode.ReadOnly = False
                    End If
					
                    If getData.Rows(0)("ProductLevelID") = 1 Then
                        CodeDigit.InnerHtml = ""
                    End If
					
                    For i = 0 To orderingData.Rows.Count - 1
                        If orderingData.Rows(i)("OrderingID") = getData.Rows(0)("OrderingPrintBillDetailBy") Then
                            OrderingPrintBillDetailBy.Items(i).Selected = True
                        End If
                    Next
					
                    For i = 0 To ShopTypeData.Rows.Count - 1
                        If ShopTypeData.Rows(i)("ShopTypeID") = getData.Rows(0)("ShopTypeID") Then
                            ShopTypeID.Items(i).Selected = True
                        End If
                    Next
					
                    CancelButton.Text = " Cancel " 'defaultTextTable.Rows(2)("TextParamValue")
					
                    If getData.Rows(0)("BudgetType") = 1 Then
                        TypeList.Items(0).Selected = True
                    ElseIf getData.Rows(0)("BudgetType") = 2 Then
                        TypeList.Items(1).Selected = True
                    Else
                        TypeList.Items(2).Selected = True
                    End If
					
                    If IsDBNull(getData.Rows(0)("PrinterForPrintToKitchenCopy")) Then
                        PrinterIDValueFromDB = 0
                    Else
                        PrinterIDValueFromDB = getData.Rows(0)("PrinterForPrintToKitchenCopy")
                    End If
					
                    CostingValueFromDB = getData.Rows(0)("CalculateCostType")
					
                    If getData.Rows(0)("DisplayReceiptVATableType") = 1 Then
                        Radio50.Checked = True
                    Else
                        Radio51.Checked = True
                    End If
					
                    If getData.Rows(0)("IsStockAtRealTime") = 1 Then
                        Radio52.Checked = True
                    Else
                        Radio53.Checked = True
                    End If
					
                    If IsDBNull(getData.Rows(0)("MasterShop")) Then
                        MasterShop.Text = ""
                    Else
                        MasterShop.Text = getData.Rows(0)("MasterShop")
                    End If
					
                    If IsDBNull(getData.Rows(0)("MasterShopLink")) Then
                        MasterShopLink.Text = ""
                    Else
                        MasterShopLink.Text = getData.Rows(0)("MasterShopLink")
                    End If
					
                    If getData.Rows(0)("ShowInReport") = 1 Then
                        Radio114.Checked = True
                    Else
                        Radio115.Checked = True
                    End If
					
                    If getData.Rows(0)("SearchMemberOnline") = 1 Then
                        Radio116.Checked = True
                    Else
                        Radio117.Checked = True
                    End If
					
                    'If getData.Rows(0)("PrintSummaryEachPromotionDetailInBill") = 1 Then
                    'Radio54.Checked = True
                    'Else
                    'Radio55.Checked = True
                    'End If
					
                    If getData.Rows(0)("AutoCloseSessionWhenLogOff") = 1 Then
                        Radio56.Checked = True
                    Else
                        Radio57.Checked = True
                    End If
					
                    If getData.Rows(0)("ListMaterialSetByMonthlyStock") = 1 Then
                        Radio58.Checked = True
                    Else
                        Radio59.Checked = True
                    End If
					
                    If getData.Rows(0)("VoidBillProduceProductOption") = 1 Then
                        Radio119.Checked = True
                    Else
                        Radio120.Checked = True
                    End If
					
                    ProductLevelName.Text = getData.Rows(0)("ProductLevelName")
                    If IsDate(getData.Rows(0)("OpenHour")) Then
                        OpenHour.SelectedHour = getData.Rows(0)("OpenHour").Hour
                        OpenHour.SelectedMinute = getData.Rows(0)("OpenHour").Minute
                    End If
                    If IsDate(getData.Rows(0)("CloseHour")) Then
                        CloseHour.SelectedHour = getData.Rows(0)("CloseHour").Hour
                        CloseHour.SelectedMinute = getData.Rows(0)("CloseHour").Minute
                    End If
					
                    If IsDate(getData.Rows(0)("StartHourForCheckingCloseSession")) Then
                        EndDayOpenHour.SelectedHour = getData.Rows(0)("StartHourForCheckingCloseSession").Hour
                        EndDayOpenHour.SelectedMinute = getData.Rows(0)("StartHourForCheckingCloseSession").Minute
                    End If
                    If IsDate(getData.Rows(0)("EndHourForCheckingCloseSession")) Then
                        EndDayCloseHour.SelectedHour = getData.Rows(0)("EndHourForCheckingCloseSession").Hour
                        EndDayCloseHour.SelectedMinute = getData.Rows(0)("EndHourForCheckingCloseSession").Minute
                    End If
					
                    If IsDate(getData.Rows(0)("StartHourForCheckingCloseSession")) Then
                        StartHourForCheckingCloseSession.SelectedHour = getData.Rows(0)("StartHourForCheckingCloseSession").Hour
                        StartHourForCheckingCloseSession.SelectedMinute = getData.Rows(0)("StartHourForCheckingCloseSession").Minute
                    End If
                    If IsDate(getData.Rows(0)("EndHourForCheckingCloseSession")) Then
                        EndHourForCheckingCloseSession.SelectedHour = getData.Rows(0)("EndHourForCheckingCloseSession").Hour
                        EndHourForCheckingCloseSession.SelectedMinute = getData.Rows(0)("EndHourForCheckingCloseSession").Minute
                    End If
					
                    If IsDBNull(getData.Rows(0)("PrintFunction")) Then
                        PrintFunction.Text = "0"
                    Else
                        PrintFunction.Text = getData.Rows(0)("PrintFunction")
                    End If
					
                    If IsDBNull(getData.Rows(0)("NoSlotInOneHour")) Then
                        NoSlotInOneHour.Text = "6"
                    Else
                        NoSlotInOneHour.Text = getData.Rows(0)("NoSlotInOneHour")
                    End If
					
                    If IsDBNull(getData.Rows(0)("IPAddress")) Then
                        IPAddress.Text = ""
                    Else
                        IPAddress.Text = getData.Rows(0)("IPAddress")
                    End If
                    If IsDBNull(getData.Rows(0)("DatabaseName")) Then
                        DatabaseName.Text = ""
                    Else
                        DatabaseName.Text = getData.Rows(0)("DatabaseName")
                    End If
                    If IsDBNull(getData.Rows(0)("RefreshpRoMiSeFrontTransaction")) Then
                        RefreshpRoMiSeFrontTransaction.Text = "0"
                    Else
                        RefreshpRoMiSeFrontTransaction.Text = getData.Rows(0)("RefreshpRoMiSeFrontTransaction")
                    End If
                    NoDayForDeleteHoldTransaction.Text = getData.Rows(0)("NoDayForDeleteHoldTransaction")
                    If getData.Rows(0)("IsShop") = True Or getData.Rows(0)("IsShop") = 1 Then
                        Radio1.Checked = True
                    Else
                        Radio2.Checked = True
                    End If
					
                    If getData.Rows(0)("IsInv") = True Or getData.Rows(0)("IsInv") = 1 Then
                        Radio3.Checked = True
                    Else
                        Radio4.Checked = True
                    End If
					
                    If getData.Rows(0)("ShopType") = 1 Then
                        Radio5.Checked = True
                    ElseIf getData.Rows(0)("ShopType") = 2 Then
                        Radio6.Checked = True
                    ElseIf getData.Rows(0)("ShopType") = 3 Then
                        Radio19.Checked = True
                    Else
                        Radio5.Checked = True
                    End If
					
                    If getData.Rows(0)("ShowInProfitLossReport") = True Or getData.Rows(0)("ShowInProfitLossReport") = 1 Then
                        Radio7.Checked = True
                    Else
                        Radio8.Checked = True
                    End If
					
                    If getData.Rows(0)("PrintVATInReceipt") = True Or getData.Rows(0)("PrintVATInReceipt") = 1 Then
                        Radio9.Checked = True
                    Else
                        Radio10.Checked = True
                    End If
					
                    If getData.Rows(0)("AllowEditPrintedOrder") = True Or getData.Rows(0)("AllowEditPrintedOrder") = 1 Then
                        Radio11.Checked = True
                    Else
                        Radio12.Checked = True
                    End If
					
                    If getData.Rows(0)("ServiceChargeType") = 1 Then
                        Radio13.Checked = True
                    Else
                        Radio14.Checked = True
                    End If
					
                    If IsDBNull(getData.Rows(0)("ServiceCharge")) Then
                        ServiceCharge.Text = "0"
                    Else
                        ServiceCharge.Text = getData.Rows(0)("ServiceCharge")
                    End If
					
                    If getData.Rows(0)("IsServiceChargeIncludeVAT") = True Or getData.Rows(0)("IsServiceChargeIncludeVAT") = 1 Then
                        Radio15.Checked = True
                    Else
                        Radio16.Checked = True
                    End If
					
                    If getData.Rows(0)("FastFoodVoidOrder") = True Or getData.Rows(0)("FastFoodVoidOrder") = 1 Then
                        Radio17.Checked = True
                    Else
                        Radio18.Checked = True
                    End If
					
                    If getData.Rows(0)("OrderSpaStaffByQueue") = True Or getData.Rows(0)("OrderSpaStaffByQueue") = 1 Then
                        Radio22.Checked = True
                    Else
                        Radio23.Checked = True
                    End If
					
                    If getData.Rows(0)("PrintCustomerDetailInBill") = True Or getData.Rows(0)("PrintCustomerDetailInBill") = 1 Then
                        Radio24.Checked = True
                    Else
                        Radio25.Checked = True
                    End If
					
                    If getData.Rows(0)("PrintProductComponentAmountToKitchen") = 1 Then
                        Radio26.Checked = True
                    ElseIf getData.Rows(0)("PrintProductComponentAmountToKitchen") = 2 Then
                        Radio100.Checked = True
                    Else
                        Radio27.Checked = True
                    End If
					
                    If getData.Rows(0)("DisplayTransactionTime") = True Or getData.Rows(0)("DisplayTransactionTime") = 1 Then
                        Radio28.Checked = True
                    Else
                        Radio29.Checked = True
                    End If
					
                    If getData.Rows(0)("SpaIgnoreStaffAtFront") = True Or getData.Rows(0)("SpaIgnoreStaffAtFront") = 1 Then
                        Radio20.Checked = True
                    Else
                        Radio21.Checked = True
                    End If
					
                    If getData.Rows(0)("SpaIgnoreRoomAtFront") = True Or getData.Rows(0)("SpaIgnoreRoomAtFront") = 1 Then
                        Radio30.Checked = True
                    Else
                        Radio31.Checked = True
                    End If
					
                    If getData.Rows(0)("SpaIgnoreStaffWhenReserve") = True Or getData.Rows(0)("SpaIgnoreStaffWhenReserve") = 1 Then
                        Radio32.Checked = True
                    Else
                        Radio33.Checked = True
                    End If
					
                    If getData.Rows(0)("SpaIgnoreRoomWhenReserve") = True Or getData.Rows(0)("SpaIgnoreRoomWhenReserve") = 1 Then
                        Radio34.Checked = True
                    Else
                        Radio35.Checked = True
                    End If
                    If getData.Rows(0)("IsBranch") = True Or getData.Rows(0)("IsBranch") = 1 Then
                        Radio36.Checked = True
                    Else
                        Radio37.Checked = True
                    End If
                    If getData.Rows(0)("CanCustomReceiptSelectPrinter") = True Or getData.Rows(0)("CanCustomReceiptSelectPrinter") = 1 Then
                        Radio38.Checked = True
                    Else
                        Radio39.Checked = True
                    End If
					
                    If getData.Rows(0)("PrintFlexibleProductDetailInBill") = True Or getData.Rows(0)("PrintFlexibleProductDetailInBill") = 1 Then
                        Radio42.Checked = True
                    Else
                        Radio43.Checked = True
                    End If
					
                    If getData.Rows(0)("VoidSearchTimeCondition") = 0 Then
                        Radio40_0.Checked = True
                    ElseIf getData.Rows(0)("VoidSearchTimeCondition") = 1 Then
                        Radio40_1.Checked = True
                    Else
                        Radio40_2.Checked = True
                    End If
					
                    If getData.Rows(0)("VoidSearchComputerCondition") = 0 Then
                        Radio41_0.Checked = True
                    Else
                        Radio41_1.Checked = True
                    End If
					
                    If getData.Rows(0)("ReprintSearchTimeCondition") = 0 Then
                        Radio42_0.Checked = True
                    ElseIf getData.Rows(0)("ReprintSearchTimeCondition") = 1 Then
                        Radio42_1.Checked = True
                    Else
                        Radio42_2.Checked = True
                    End If
					
                    If getData.Rows(0)("ReprintSearchComputerCondition") = 0 Then
                        Radio43_0.Checked = True
                    Else
                        Radio43_1.Checked = True
                    End If
					
                    If getData.Rows(0)("PrintSummaryEachPromotionDetailInBill") = True Or getData.Rows(0)("PrintSummaryEachPromotionDetailInBill") = 1 Then
                        Radio44.Checked = True
                    Else
                        Radio45.Checked = True
                    End If
					
                    If IsDBNull(getData.Rows(0)("ProductLevelOrder")) Then
                        ProductLevelOrder.Text = "0"
                    Else
                        ProductLevelOrder.Text = getData.Rows(0)("ProductLevelOrder")
                    End If
					
                    If IsDBNull(getData.Rows(0)("ProductLevelCode")) Then
                        ProductLevelCode.Text = ""
                        OldShopCode.Value = ""
                    Else
                        ProductLevelCode.Text = getData.Rows(0)("ProductLevelCode")
                        OldShopCode.Value = getData.Rows(0)("ProductLevelCode")
                    End If
					
                    If getData.Rows(0)("HasCheckerSystem") = 1 Then
                        Radio60.Checked = True
                    ElseIf getData.Rows(0)("HasCheckerSystem") = 2 Then
                        Radio600.Checked = True
                    ElseIf getData.Rows(0)("HasCheckerSystem") = 3 Then
                        Radio601.Checked = True
                    Else
                        Radio61.Checked = True
                    End If
					
                    If IsDBNull(getData.Rows(0)("ReleaseReserveTime")) Then
                        ReleaseReserveTime.Text = "0"
                    Else
                        ReleaseReserveTime.Text = getData.Rows(0)("ReleaseReserveTime")
                    End If
					
                    If getData.Rows(0)("HasReserveFeature") = 1 Then
                        Radio62.Checked = True
                    Else
                        Radio63.Checked = True
                    End If
					
                    If getData.Rows(0)("PrintSummaryProductGroupInBill") = 1 Then
                        Radio64.Checked = True
                    Else
                        Radio65.Checked = True
                    End If
					
                    If getData.Rows(0)("AllowMoveOrderAfterPrintBillDetail") = 1 Then
                        Radio66.Checked = True
                    Else
                        Radio67.Checked = True
                    End If
					
                    If getData.Rows(0)("AllowAddCommentInOrder") = 1 Then
                        Radio68.Checked = True
                    Else
                        Radio69.Checked = True
                    End If
					
                    If getData.Rows(0)("RequiredNoteForVoidTransaction") = 1 Then
                        Radio70.Checked = True
                    Else
                        Radio71.Checked = True
                    End If
                    If getData.Rows(0)("RequiredNoteForReprintTransaction") = 1 Then
                        Radio72.Checked = True
                    Else
                        Radio73.Checked = True
                    End If
                    If getData.Rows(0)("RequiredNoteForPrintBillDetail") = 1 Then
                        Radio74.Checked = True
                    Else
                        Radio75.Checked = True
                    End If
                    If getData.Rows(0)("RequiredNoteForVoidOrder") = 1 Then
                        Radio76.Checked = True
                    Else
                        Radio77.Checked = True
                    End If
                    If getData.Rows(0)("RequiredNoteMoveTableAndOrder") = 1 Then
                        Radio78.Checked = True
                    Else
                        Radio79.Checked = True
                    End If
                    If getData.Rows(0)("PrintBillDetailBeforeCheckBill") = 1 Then
                        Radio80.Checked = True
                    Else
                        Radio81.Checked = True
                    End If
					
                    If getData.Rows(0)("HasSplitTransactionFeature") = 1 Then
                        Radio82.Checked = True
                    Else
                        Radio83.Checked = True
                    End If
					
                    If getData.Rows(0)("InsertStaffWhenSubmitOrder") = 1 Then
                        Radio84.Checked = True
                    ElseIf getData.Rows(0)("InsertStaffWhenSubmitOrder") = 2 Then
                        Radio86.Checked = True
                    ElseIf getData.Rows(0)("InsertStaffWhenSubmitOrder") = 3 Then
                        Radio866.Checked = True
                    Else
                        Radio85.Checked = True
                    End If
					
                    If getData.Rows(0)("LockEditOrderAfterPrintBillDetail") = 1 Then
                        Radio87.Checked = True
                    ElseIf getData.Rows(0)("LockEditOrderAfterPrintBillDetail") = 2 Then
                        Radio88.Checked = True
                    ElseIf getData.Rows(0)("LockEditOrderAfterPrintBillDetail") = 3 Then
                        Radio88_3.Checked = True
                    Else
                        Radio89.Checked = True
                    End If
					
                    If getData.Rows(0)("PrintAveragePricePerCustomer") = 1 Then
                        Radio90.Checked = True
                    Else
                        Radio91.Checked = True
                    End If
                    If getData.Rows(0)("PrintOpenTimeInReceipt") = 1 Then
                        Radio92.Checked = True
                    ElseIf getData.Rows(0)("PrintOpenTimeInReceipt") = 2 Then
                        Radio92_2.Checked = True
                    Else
                        Radio93.Checked = True
                    End If
					
                    If getData.Rows(0)("HasRedeemFeature") = 1 Then
                        Radio94.Checked = True
                    ElseIf getData.Rows(0)("HasRedeemFeature") = 2 Then
                        Radio104.Checked = True
                    Else
                        Radio95.Checked = True
                    End If
					
                    If getData.Rows(0)("HasBankAccountFeature") = 1 Then
                        Radio96.Checked = True
                    ElseIf getData.Rows(0)("HasBankAccountFeature") = 2 Then
                        Radio106.Checked = True
                    Else
                        Radio97.Checked = True
                    End If
									
					
                    If getData.Rows(0)("HasBuffetFeature") = 1 Then
                        Radio101.Checked = True
                    ElseIf getData.Rows(0)("HasBuffetFeature") = 2 Then
                        Radio102.Checked = True
                    Else
                        Radio103.Checked = True
                    End If
					
                    If IsDBNull(getData.Rows(0)("BuffetTime")) Then
                        BuffetTime.Text = "0"
                    Else
                        BuffetTime.Text = getData.Rows(0)("BuffetTime")
                    End If
					
                    If IsDBNull(getData.Rows(0)("BuffetWarningTime")) Then
                        BuffetWarningTime.Text = "0"
                    Else
                        BuffetWarningTime.Text = getData.Rows(0)("BuffetWarningTime")
                    End If
					
                    If getData.Rows(0)("PrintOrderAfterFinishOrderProcess") = 1 Then
                        Radio110.Checked = True
                    Else
                        Radio111.Checked = True
                    End If
					
                    If getData.Rows(0)("NotPrintOrderWhenCreateOrderProcess") = 1 Then
                        Radio112.Checked = True
                    Else
                        Radio113.Checked = True
                    End If
					
                    If getData.Rows(0)("FastFoodType") = 1 Then
                        Radio555.Checked = True
                    Else
                        Radio556.Checked = True
                    End If
					
                    If getData.Rows(0)("PrintStockOnlyInSession") = 0 Then
                        Radio500.Checked = True
                    ElseIf getData.Rows(0)("PrintStockOnlyInSession") = 1 Then
                        Radio501.Checked = True
                    Else
                        Radio502.Checked = True
                    End If
                    'PrintReferenceBarCodeInReceipt --> Set From Radio Button or ComboBox
                    If getData.Rows(0)("PrintReferenceBarCodeInReceipt") = 1 Then
                        optPrintReferenceInBill.Checked = True
                    Else
                        optNotPrintReferenceInBill.Checked = True
                    End If
					
                    If cboPrintReferenceBarCode.Visible = True Then
                        For i = 0 To dtPrintReference.Rows.Count - 1
                            If dtPrintReference.Rows(i)("PrintReferenceID") = getData.Rows(0)("PrintReferenceBarCodeInReceipt") Then
                                cboPrintReferenceBarCode.Items(i).Selected = True
                            End If
                        Next i
                    End If
                    
                    If getData.Rows(0)("PrintBarCodeForCouponVoucherInReciept") = 1 Then
                        Radio202.Checked = True
                    Else
                        Radio203.Checked = True
                    End If
					
                    If getData.Rows(0)("HasCallForCheckBillFeature") = 1 Then
                        Radio204.Checked = True
                    ElseIf getData.Rows(0)("HasCallForCheckBillFeature") = 2 Then
                        Radio204_2.Checked = True
                    Else
                        Radio205.Checked = True
                    End If
					
                    If getData.Rows(0)("TableType") = 1 Then
                        Radio5555.Checked = True
                    ElseIf getData.Rows(0)("TableType") = 2 Then
                        Radio5556.Checked = True
                    ElseIf getData.Rows(0)("TableType") = 3 Then
                        Radio5557.Checked = True
                    Else
                        Radio5555.Checked = True
                    End If
					
                    FastFoodAddCustomerDetailForNewTransaction.Text = getData.Rows(0)("FastFoodAddCustomerDetailForNewTransaction")
										
                    updateMessage.Text = "Update Shop Data" 'textTable.Rows(6)("TextParamValue")
                    SubmitForm.Text = " Update " 'textTable.Rows(9)("TextParamValue")
                    NameParam.InnerHtml = "Shop Name" 'textTable.Rows(7)("TextParamValue")
					
                    Dim CompanyInfo As DataTable
                    CompanyInfo = getInfo.GetCompanyInfo(CompanyID.Value, objCnn)
					
					
                    For i = 0 To CompanyInfo.Rows.Count - 1
                        If IsDBNull(CompanyInfo.Rows(i)("CompanyName")) Then
                            CompanyName.Text = ""
                        Else
                            CompanyName.Text = CompanyInfo.Rows(i)("CompanyName")
                        End If
						
                        If IsDBNull(CompanyInfo.Rows(i)("AccountingCode")) Then
                            AccountingCode.Text = ""
                        Else
                            AccountingCode.Text = CompanyInfo.Rows(i)("AccountingCode")
                        End If
						
                        If IsDBNull(CompanyInfo.Rows(i)("CompanyAddress1")) Then
                            CompanyAddress1.Text = ""
                        Else
                            CompanyAddress1.Text = CompanyInfo.Rows(i)("CompanyAddress1")
                        End If
						
                        If IsDBNull(CompanyInfo.Rows(i)("CompanyAddress2")) Then
                            CompanyAddress2.Text = ""
                        Else
                            CompanyAddress2.Text = CompanyInfo.Rows(i)("CompanyAddress2")
                        End If
						
                        If IsDBNull(CompanyInfo.Rows(i)("CompanyCity")) Then
                            CompanyCity.Text = ""
                        Else
                            CompanyCity.Text = CompanyInfo.Rows(i)("CompanyCity")
                        End If
						
                        If Not IsDBNull(CompanyInfo.Rows(i)("CompanyProvince")) Then
                            GetProvince.SelectedProvince = CompanyInfo.Rows(i)("CompanyProvince")
                        End If
								
                        If IsDBNull(CompanyInfo.Rows(i)("CompanyZipcode")) Then
                            CompanyZipCode.Text = ""
                        Else
                            CompanyZipCode.Text = CompanyInfo.Rows(i)("CompanyZipcode")
                        End If
						
                        If IsDBNull(CompanyInfo.Rows(i)("CompanyTelephone")) Then
                            CompanyTelephone.Text = ""
                        Else
                            CompanyTelephone.Text = CompanyInfo.Rows(i)("CompanyTelephone")
                        End If
						
                        If IsDBNull(CompanyInfo.Rows(i)("CompanyFax")) Then
                            CompanyFax.Text = ""
                        Else
                            CompanyFax.Text = CompanyInfo.Rows(i)("CompanyFax")
                        End If
						
                        If IsDBNull(CompanyInfo.Rows(i)("CompanyTaxID")) Then
                            CompanyTaxID.Text = ""
                        Else
                            CompanyTaxID.Text = CompanyInfo.Rows(i)("CompanyTaxID")
                        End If
						
                        If IsDBNull(CompanyInfo.Rows(i)("CompanyRegisterID")) Then
                            CompanyRegisterID.Text = ""
                        Else
                            CompanyRegisterID.Text = CompanyInfo.Rows(i)("CompanyRegisterID")
                        End If
						
                        If IsDBNull(CompanyInfo.Rows(i)("CompanyVAT")) Then
                            CompanyVAT.Text = ""
                        Else
                            CompanyVAT.Text = CompanyInfo.Rows(i)("CompanyVAT")
                        End If
						
                        If IsDBNull(CompanyInfo.Rows(i)("Addtional")) Then
                            RadioHQ.Checked = True
                        Else
                            Dim ParameterData() As String
                            ParameterData = CompanyInfo.Rows(i)("Addtional").Split(":"c)
                            If ParameterData.Length >= 1 Then
                                If ParameterData(0) = 1 Then
                                    RadioHQ.Checked = True
                                Else
                                    RadioBranch.Checked = True
                                End If
                            End If
                            If ParameterData.Length >= 2 Then
                                BranchNo.Text = ParameterData(1)
                            End If
                            If ParameterData.Length >= 3 Then
                                FullTaxBranchName.Text = ParameterData(2)
                            End If
                        End If
						
                        For j = 0 To LangData.Rows.Count - 1
                            If LangData.Rows(j)("LangID") = CompanyInfo.Rows(i)("DisplayCompanyProvinceLangID") Then
                                DisplayCompanyProvinceLangID.Items(j).Selected = True
                            End If
                        Next
						
                        If showAddress2.Visible = True Then
                            If IsDBNull(CompanyInfo.Rows(i)("DeliveryName")) Then
                                DeliveryName.Text = ""
                            Else
                                DeliveryName.Text = CompanyInfo.Rows(i)("DeliveryName")
                            End If
							
                            If IsDBNull(CompanyInfo.Rows(i)("DeliveryAddress1")) Then
                                DeliveryAddress1.Text = ""
                            Else
                                DeliveryAddress1.Text = CompanyInfo.Rows(i)("DeliveryAddress1")
                            End If
							
                            If IsDBNull(CompanyInfo.Rows(i)("DeliveryAddress2")) Then
                                DeliveryAddress2.Text = ""
                            Else
                                DeliveryAddress2.Text = CompanyInfo.Rows(i)("DeliveryAddress2")
                            End If
							
                            If IsDBNull(CompanyInfo.Rows(i)("DeliveryCity")) Then
                                DeliveryCity.Text = ""
                            Else
                                DeliveryCity.Text = CompanyInfo.Rows(i)("DeliveryCity")
                            End If
							
                            If Not IsDBNull(CompanyInfo.Rows(i)("DeliveryProvince")) Then
                                DeliveryProvince.SelectedProvince = CompanyInfo.Rows(i)("DeliveryProvince")
                            End If
									
                            If IsDBNull(CompanyInfo.Rows(i)("DeliveryZipcode")) Then
                                DeliveryZipCode.Text = ""
                            Else
                                DeliveryZipCode.Text = CompanyInfo.Rows(i)("DeliveryZipcode")
                            End If
							
                            If IsDBNull(CompanyInfo.Rows(i)("DeliveryTelephone")) Then
                                DeliveryTelephone.Text = ""
                            Else
                                DeliveryTelephone.Text = CompanyInfo.Rows(i)("DeliveryTelephone")
                            End If
							
                            If IsDBNull(CompanyInfo.Rows(i)("DeliveryFax")) Then
                                DeliveryFax.Text = ""
                            Else
                                DeliveryFax.Text = CompanyInfo.Rows(i)("DeliveryFax")
                            End If
                        End If
						
                    Next
					

                End If
			
            Else

                textTable = getPageText.GetText(7, Session("LangID"), objCnn)
			
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
					
                CancelButton.Text = " Cancel " 'defaultTextTable.Rows(2)("TextParamValue")
			
                updateMessage.Text = "Add Shop Data" 'textTable.Rows(5)("TextParamValue")
                SubmitForm.Text = " Add Shop " 'textTable.Rows(8)("TextParamValue")
                NameParam.InnerHtml = "Shop Name" 'textTable.Rows(7)("TextParamValue")
			
                ProductLevelID.Value = 0
                CompanyID.Value = 0
                Radio2.Checked = True
                Radio3.Checked = True
                Radio5.Checked = True
                Radio7.Checked = True
                Radio9.Checked = True
                Radio12.Checked = True
                Radio13.Checked = True
                Radio16.Checked = True
                Radio18.Checked = True
                Radio21.Checked = True
                Radio23.Checked = True
                Radio25.Checked = True
                Radio27.Checked = True
                Radio29.Checked = True
                Radio31.Checked = True
                Radio33.Checked = True
                Radio35.Checked = True
                Radio37.Checked = True
                Radio39.Checked = True
                Radio40_1.Checked = True
                Radio42_1.Checked = True
                Radio41_0.Checked = True
                Radio43_0.Checked = True
                Radio42.Checked = True
                Radio50.Checked = True
                Radio45.Checked = True
                Radio52.Checked = True
                'Radio55.Checked = True
                Radio57.Checked = True
                Radio58.Checked = True
                Radio61.Checked = True
                Radio63.Checked = True
                Radio65.Checked = True
                Radio66.Checked = True
                Radio68.Checked = True
                Radio71.Checked = True
                Radio73.Checked = True
                Radio75.Checked = True
                Radio77.Checked = True
                Radio79.Checked = True
                Radio81.Checked = True
                Radio83.Checked = True
                Radio85.Checked = True
                Radio89.Checked = True
                Radio91.Checked = True
                Radio93.Checked = True
                Radio95.Checked = True
                Radio97.Checked = True
                Radio103.Checked = True
                Radio113.Checked = True
                Radio111.Checked = True
                Radio114.Checked = True
                Radio117.Checked = True
                Radio119.Checked = True
                Radio556.Checked = True
                Radio500.Checked = True
                optNotPrintReferenceInBill.Checked = True
                Radio203.Checked = True
                Radio205.Checked = True
                Radio5555.Checked = True
                ReleaseReserveTime.Text = "0"
                PrintFunction.Text = "0"
                NoSlotInOneHour.Text = "6"
                NoDayForDeleteHoldTransaction.Text = "0"
                ProductLevelOrder.Text = "999"
                TypeList.Items(0).Selected = True
                OrderingPrintBillDetailBy.Items(2).Selected = True
                MasterShop.Text = "0"
                MasterShopLink.Text = "0"
                OldShopCode.Value = ""
            End If
            If IsNumeric(Request.Form("DeliveryProvince")) Then
                DeliveryProvince.SelectedProvince = Request.Form("DeliveryProvince")
            End If
            If IsNumeric(Request.Form("CompanyProvince")) Then
                GetProvince.SelectedProvince = Request.Form("CompanyProvince")
            End If
            If IsNumeric(Request.Form("OpenHour_Hour")) Then
                OpenHour.SelectedHour = Request.Form("OpenHour_Hour")
            End If
            If IsNumeric(Request.Form("OpenHour_Minute")) Then
                OpenHour.SelectedMinute = Request.Form("OpenHour_Minute")
            End If
            If IsNumeric(Request.Form("CloseHour_Hour")) Then
                CloseHour.SelectedHour = Request.Form("CloseHour_Hour")
            End If
            If IsNumeric(Request.Form("CloseHour_Minute")) Then
                CloseHour.SelectedMinute = Request.Form("CloseHour_Minute")
            End If
		
            If IsNumeric(Request.Form("EndDayOpenHour_Hour")) Then
                EndDayOpenHour.SelectedHour = Request.Form("EndDayOpenHour_Hour")
            End If
            If IsNumeric(Request.Form("EndDayOpenHour_Minute")) Then
                EndDayOpenHour.SelectedMinute = Request.Form("EndDayOpenHour_Minute")
            End If
            If IsNumeric(Request.Form("EndDayCloseHour_Hour")) Then
                EndDayCloseHour.SelectedHour = Request.Form("EndDayCloseHour_Hour")
            End If
            If IsNumeric(Request.Form("EndDayCloseHour_Minute")) Then
                EndDayCloseHour.SelectedMinute = Request.Form("EndDayCloseHour_Minute")
            End If
		
            Dim PrinterIDValue As Integer = -1
            If IsNumeric(Request.Form("PrinterForPrintToKitchenCopy")) Then
                PrinterIDValue = Request.Form("PrinterForPrintToKitchenCopy")
            ElseIf IsNumeric(Request.QueryString("PrinterForPrintToKitchenCopy")) Then
                PrinterIDValue = Request.QueryString("PrinterForPrintToKitchenCopy")
            ElseIf IsNumeric(PrinterIDValueFromDB) Then
                PrinterIDValue = PrinterIDValueFromDB
            End If
		
            Dim PrinterString As String = ""
            Dim AllPrinters As DataTable
            AllPrinters = getConfig.GetPrinters(-1, objCnn)
            Dim FormSelected As String
            For i = 0 To AllPrinters.Rows.Count - 1
                If AllPrinters.Rows(i)("PrinterID") >= -1 Then
                    If PrinterIDValue = AllPrinters.Rows(i)("PrinterID") Then
                        FormSelected = "selected"
                    Else
                        FormSelected = ""
                    End If
                    PrinterString += "<option value=""" & AllPrinters.Rows(i)("PrinterID") & """ " & FormSelected & ">" & AllPrinters.Rows(i)("PrinterName")
                End If
            Next
            PrinterSelectionText.InnerHtml = "<select name=""PrinterForPrintToKitchenCopy"">" + PrinterString + "</select>"

            Dim CostingValue As Integer = -1
            If IsNumeric(Request.Form("CalculateCostType")) Then
                CostingValue = Request.Form("CalculateCostType")
            ElseIf IsNumeric(Request.QueryString("CalculateCostType")) Then
                CostingValue = Request.QueryString("CalculateCostType")
            ElseIf IsNumeric(CostingValueFromDB) Then
                CostingValue = CostingValueFromDB
            End If
		
            Dim LoopString As String = ""
            Dim shopInfo As New DataTable()
            shopInfo = getInfo.GetProductLevel(-99, objCnn)
            If CostingValue = 0 Then
                LoopString += "<option value=""0"" " & "selected" & ">" & "Calculate cost from product setting"
            Else
                LoopString += "<option value=""0"">" & "Calculate cost from product setting"
            End If
            If CostingValue = -2 Then
                LoopString += "<option value=""-2"" " & "selected" & ">" & "Calculate cost from material setting"
            Else
                LoopString += "<option value=""-2"">" & "Calculate cost from material setting"
            End If
            If CostingValue = -1 Then
                LoopString += "<option value=""-1"" " & "selected" & ">" & "Calculate cost from average receiving cost"
            Else
                LoopString += "<option value=""-1"">" & "Calculate cost from average receiving cost"
            End If
            For i = 0 To shopInfo.Rows.Count - 1
                If CostingValue = shopInfo.Rows(i)("ProductLevelID") Then
                    FormSelected = "selected"
                Else
                    FormSelected = ""
                End If
                LoopString += "<option value=""" & shopInfo.Rows(i)("ProductLevelID").ToString & """ " & FormSelected & ">Calculate cost from average receiving cost from outlet " & shopInfo.Rows(i)("ProductLevelName")
            Next
            CostingSelection.InnerHtml = "<select name=""CalculateCostType"">" + LoopString + "</select>"
		
            Dim outputString As String = ""
            Dim ParamString, ParamStringVal, PropName, Desp As String
            Dim ValueString, TextString As String
            Dim dtTable As DataTable = Prop.DynamicPropInfo(0, 1, 2, ProductLevelID.Value, objCnn)
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
                    outputString += "<td align=""center"" class=""text"">" + Trim(dtTable.Rows(i)("PropertyName")) + "<br><span class=""smalltext"">(" + Trim(dtTable.Rows(i)("Description")) + ")</span></td>"
                    outputString += "<td class=""text""><input type=""text"" style=""width:30px"" name=""" + ParamString + """ value=""" + ValueString + """> (Value)&nbsp;&nbsp;<input type=""text"" style=""width:200px"" name=""" + ParamStringVal + """ value=""" + TextString + """> (Text)" + "</td>"
                    outputString += "</tr>"
                Next
                DynamicPropUser.InnerHtml = outputString
            End If
		
            dtTable = Prop.DynamicPropInfo(0, 0, 2, ProductLevelID.Value, objCnn)
            If dtTable.Rows.Count > 0 Then
                outputString += "<br><table id=""myTable3"" class=""blue"" width=""100%"">"
                outputString += "<thead><tr>"
                outputString += "<th align=""center"">Type</th>"
                outputString += "<th align=""center"">ID</th>"
                outputString += "<th align=""center"">Property Name</th>"
                outputString += "<th align=""center"">Property Value</th>"
                outputString += "</tr></thead><tbody>"
                Dim bColor As String
                For i = 0 To dtTable.Rows.Count - 1
                    If i Mod 2 = 0 Then
                        bColor = "white"
                    Else
                        bColor = GlobalParam.RowBGColor
                    End If
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
                    'outputString += "<tr bgColor=""" + bColor + """>"
                    outputString += "<tr>"
                    outputString += "<td align=""center"" class=""text"">" + dtTable.Rows(i)("ProgramTypeID").ToString + "</td>"
                    outputString += "<td align=""center"" class=""text"">" + dtTable.Rows(i)("PropertyID").ToString + "</td>"
                    If Not IsDBNull(dtTable.Rows(i)("PropertyName")) Then
                        PropName = dtTable.Rows(i)("PropertyName")
                    Else
                        PropName = "-"
                    End If
                    If Not IsDBNull(dtTable.Rows(i)("Description")) Then
                        Desp = dtTable.Rows(i)("Description")
                    Else
                        Desp = "-"
                    End If
                    outputString += "<td class=""text"" width=""60%"">" + Trim(PropName) + "<br><span class=""smalltext"">(" + Trim(Desp) + ")</span></td>"
                    outputString += "<td class=""text""><input type=""text"" style=""width:30px"" name=""" + ParamString + """ value=""" + ValueString + """> (Value)&nbsp;&nbsp;<input type=""text"" style=""width:200px"" name=""" + ParamStringVal + """ value=""" + TextString + """> (Text)" + "</td>"
                    outputString += "</tr>"
                Next
                outputString += "</tbody></table>"
                DynamicPropAdmin.InnerHtml = outputString
            End If
		
            If Not Page.IsPostBack Then
                Dim foundRows() As DataRow
                Dim expression As String
                Dim SString As StringBuilder = New StringBuilder
                Dim SaleMode As DataTable = objDB.List("select * from SaleMode where SaleModeID>1 AND Deleted=0 order by SaleModeID", objCnn)
			
                Dim SaleModeData As DataTable = objDB.List("select * from salemodeproductlevelproperty where ProductLevelID=" + ProductLevelID.Value.ToString, objCnn)
			
                Dim colID As Integer
                Dim rData As DataRow
                Dim ColData As New DataTable
                ColData.Columns.Clear()
			
                ColData.Columns.Add("ColumnID", System.Type.GetType("System.Int32"))
                ColData.Columns.Add("ColumnName", System.Type.GetType("System.String"))
                ColData.Columns.Add("ColumnDesp", System.Type.GetType("System.String"))
                ColData.Columns.Add("ColumnDataType", System.Type.GetType("System.String"))

                colID = 0
                rData = ColData.NewRow
                colID += 1
                rData("ColumnID") = colID
                rData("ColumnName") = "PrintToKitchen"
                rData("ColumnDesp") = "Print To Kitchen: 0=NO, 1=YES, 2=YES (Print after payment for fast food)"
                rData("ColumnDataType") = "numeric"
                ColData.Rows.Add(rData)
			
                rData = ColData.NewRow
                colID += 1
                rData("ColumnID") = colID
                rData("ColumnName") = "ServiceCharge"
                rData("ColumnDesp") = "Service Charge (%)"
                rData("ColumnDataType") = "numeric"
                ColData.Rows.Add(rData)
			
                rData = ColData.NewRow
                colID += 1
                rData("ColumnID") = colID
                rData("ColumnName") = "AutoCloseTransactionAfterPaid"
                rData("ColumnDesp") = "Auto Close Transaction After Paid: 0=NO, 1=YES"
                rData("ColumnDataType") = "numeric"
                ColData.Rows.Add(rData)
			
                rData = ColData.NewRow
                colID += 1
                rData("ColumnID") = colID
                rData("ColumnName") = "PrintReceiptCopyToPrinter"
                rData("ColumnDesp") = "List of Printer Name for Receipt Copy (use , as delimeter for multi printer)"
                rData("ColumnDataType") = "string"
                ColData.Rows.Add(rData)
			
                rData = ColData.NewRow
                colID += 1
                rData("ColumnID") = colID
                rData("ColumnName") = "PrintCheckSummaryWhenPrintJobOrder"
                rData("ColumnDesp") = "Print Summary Bill After Print to Kitchen: 0=NO, 1=Detail and Price, 2=Detail only, 3=Same as Kitchen"
                rData("ColumnDataType") = "numeric"
                ColData.Rows.Add(rData)
			
                rData = ColData.NewRow
                colID += 1
                rData("ColumnID") = colID
                rData("ColumnName") = "PrinterNameForCheckSummaryWhenPrintJobOrder"
                rData("ColumnDesp") = "Printer Name for Summary Bill (use , as delimeter for multi printer)"
                rData("ColumnDataType") = "string"
                ColData.Rows.Add(rData)
			
                rData = ColData.NewRow
                colID += 1
                rData("ColumnID") = colID
                rData("ColumnName") = "PrintBillDetailBeforeCheckBill"
                rData("ColumnDesp") = "Print Check Bill Before Payment: 0=No, 1=YES"
                rData("ColumnDataType") = "numeric"
                ColData.Rows.Add(rData)
			
                If SaleModeData.Columns.Contains("StockToInvID") = True Then
                    rData =ColData.NewRow 
                    colID += 1
                    rData("ColumnID") = colID
                    rData("ColumnName") = "StockToInvID"
                    rData("ColumnDesp") = "Stock InvID For Sale Mode : "
                    rData("ColumnDataType") = "numeric"
                    ColData.Rows.Add(rData)
                End If
                Session("ColDataSaleMode") = ColData
		
                If SaleMode.Rows.Count > 0 Then
                    SString = SString.Append("<br><table id=""myTable4"" class=""blue"" width=""100%"">")
                    SString = SString.Append("<thead><tr>")
                    SString = SString.Append("<th align=""center"">#</th>")
                    SString = SString.Append("<th align=""center"" width=""50%"">Sale Mode Parameter Name</th>")
                    For i = 0 To SaleMode.Rows.Count - 1
                        SString = SString.Append("<th align=""center"">" + SaleMode.Rows(i)("SaleModeName") + "</th>")
                    Next
                    SString = SString.Append("</tr></thead><tbody>")
				
                    For j = 0 To ColData.Rows.Count - 1
                        SString = SString.Append("<tr><td align=""center"">" + (j + 1).ToString + "</td><td>" + ColData.Rows(j)("ColumnDesp") + "</td>")
                        For i = 0 To SaleMode.Rows.Count - 1
                            TextString = ""
                            expression = "SaleMode=" + SaleMode.Rows(i)("SaleModeID").ToString + " AND ProductLevelID=" + ProductLevelID.Value.ToString
                            foundRows = SaleModeData.Select(expression)
                            If foundRows.GetUpperBound(0) >= 0 Then
                                TextString = foundRows(0)(ColData.Rows(j)("ColumnName")).ToString
                            End If
                            ParamStringVal = "SM_" + ColData.Rows(j)("ColumnName") + "|" + SaleMode.Rows(i)("SaleModeID").ToString + ":" + ProductLevelID.Value.ToString
                            SString = SString.Append("<td align=""center""><input type=""text"" style=""width:50px"" name=""" + ParamStringVal + """ value=""" + TextString + """></td>")
                        Next
                        SString = SString.Append("</tr>")
                    Next
				
                    SString = SString.Append("</tbody></table>")
                    SaleModeProp.InnerHtml = SString.ToString
                End If
            End If
		
            'Catch ex As Exception
            'errorMsg.InnerHtml = ex.Message
            'End Try
        Else
            updateMessage.Text = "Access Denied"
        End If
    End Sub


    Sub DoAddUpdate(Source As Object, E As EventArgs)
        Dim FoundError As Boolean = False
        Dim textTable As New DataTable()
        textTable = getPageText.GetText(7, Session("LangID"), objCnn)
        Dim defaultTextTable As New DataTable()
        defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
        validateName.InnerHtml = ""
	
        If Len(Trim(ProductLevelName.Text)) = 0 Then
            validateName.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(10)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
	
        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
        If PropertyInfo.Rows(0)("SystemEditionID") > 1 Then
            Dim ShopDefault As DataTable
            ShopDefault = getInfo.FirstLevel("ProductLevel", "ProductLevelID", 1, "", objCnn)
            validateCode.InnerHtml = ""
		
            If ShopDefault.Rows.Count > 0 And ProductLevelID.Value <> 1 Then
                If Len(ShopDefault.Rows(0)("ProductLevelCode")) > 0 Then
                    'Check ShopCode Only New ProductLevel
                    If Len(ShopDefault.Rows(0)("ProductLevelCode")) <> Len(ProductLevelCode.Text) And (ProductLevelID.Value = 0) Then
                        validateCode.InnerHtml = "<tr><td></td><td class=""errorText"">*" & "Shop Code must be " & Len(ShopDefault.Rows(0)("ProductLevelCode")).ToString & " digits</td></tr>"
                        FoundError = True
                    End If
                End If
            End If
        End If
	
        textTable = getPageText.GetText(9, Session("LangID"), objCnn)
        Dim TestDec As Decimal
        Try
            TestDec = CDec(CompanyVAT.Text)
            ValidateVAT.InnerHtml = ""
        Catch ex As Exception
            ValidateVAT.InnerHtml = "<tr><td>&nbsp;</td><td class=""errorText"">" + textTable.Rows(14)("TextParamValue") + "</td></tr>"
            FoundError = True
        End Try
	
	
        If ShowShopData.Visible = True Then
            ValidateServiceCharge.InnerHtml = ""
            If Not IsNumeric(Request.Form("ServiceCharge")) Then
                ValidateServiceCharge.InnerHtml = "<tr><td>&nbsp;</td><td class=""errorText"">" + textTable.Rows(108)("TextParamValue") + "</td></tr>"
                FoundError = True
            End If
		
            If (Not IsNumeric(Request.Form("OpenHour_Hour")) And IsNumeric(Request.Form("OpenHour_Minute"))) Or (IsNumeric(Request.Form("OpenHour_Hour")) And Not IsNumeric(Request.Form("OpenHour_Minute"))) Then
                validateFromTime.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(73)("TextParamValue") & "</td></tr>"
                FoundError = True
            Else
                validateFromTime.InnerHtml = ""
            End If
	
            If (Not IsNumeric(Request.Form("CloseHour_Hour")) And IsNumeric(Request.Form("CloseHour_Minute"))) Or (IsNumeric(Request.Form("CloseHour_Hour")) And Not IsNumeric(Request.Form("CloseHour_Minute"))) Then
                validateToTime.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(73)("TextParamValue") & "</td></tr>"
                FoundError = True
            Else
                validateToTime.InnerHtml = ""
            End If
		
            If (Not IsNumeric(Request.Form("EndDayOpenHour_Hour")) And IsNumeric(Request.Form("EndDayOpenHour_Minute"))) Or (IsNumeric(Request.Form("EndDayOpenHour_Hour")) And Not IsNumeric(Request.Form("EndDayOpenHour_Minute"))) Then
                validateEndDayFromTime.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(73)("TextParamValue") & "</td></tr>"
                FoundError = True
            Else
                validateEndDayFromTime.InnerHtml = ""
            End If
	
            If (Not IsNumeric(Request.Form("EndDayCloseHour_Hour")) And IsNumeric(Request.Form("EndDayCloseHour_Minute"))) Or (IsNumeric(Request.Form("EndDayCloseHour_Hour")) And Not IsNumeric(Request.Form("EndDayCloseHour_Minute"))) Then
                validateEndDayToTime.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(73)("TextParamValue") & "</td></tr>"
                FoundError = True
            Else
                validateEndDayToTime.InnerHtml = ""
            End If
        End If
	
        validateReleaseTime.InnerHtml = ""
        If ResFeature.Visible = True And reserve2.Visible = True Then
            If Not IsNumeric(Request.Form("ReleaseReserveTime")) Then
                validateReleaseTime.InnerHtml = "<tr><td>&nbsp;</td><td class=""errorText"">" + textTable.Rows(108)("TextParamValue") + "</td></tr>"
                FoundError = True
            End If
        End If
	
        ValidateMasterShop.InnerHtml = ""
        ValidateMasterShopLink.InnerHtml = ""
        If ShowMulti.Visible = True Then
            If Not IsNumeric(Request.Form("MasterShop")) Then
                ValidateMasterShop.InnerHtml = "<tr><td>&nbsp;</td><td class=""errorText"">" + "Master Shop ID must be numeric number" + "</td></tr>"
                FoundError = True
            End If
            If Not IsNumeric(Request.Form("MasterShopLink")) Then
                ValidateMasterShop.InnerHtml = "<tr><td>&nbsp;</td><td class=""errorText"">" + "Master Shop Link must be numeric number" + "</td></tr>"
                FoundError = True
            End If
        End If
	
        validatePopup.InnerHtml = ""
        If ResFeature.Visible = True Then
            If Not IsNumeric(Request.Form("FastFoodAddCustomerDetailForNewTransaction")) Then
                validatePopup.InnerHtml = "<tr><td>&nbsp;</td><td class=""errorText"">" + "This must numeric number" + "</td></tr>"
                FoundError = True
            End If
        End If
	
        If FoundError = False Then
            Dim Result, Result1, StartTime, EndTime, SessionStartTime, SessionEndTime As String
            Dim ExtraSQL(1) As String
            Dim TimeNow As String
            TimeNow = DateTimeUtil.CurrentDateTime
		
            If (IsNumeric(Request.Form("StartHourForCheckingCloseSession_Hour")) And IsNumeric(Request.Form("StartHourForCheckingCloseSession_Minute"))) Then
                SessionStartTime = "{ ts '2003-01-01 " + Request.Form("StartHourForCheckingCloseSession_Hour").ToString + ":" + Request.Form("StartHourForCheckingCloseSession_Minute").ToString + ":00' }"
            Else
                SessionStartTime = "NULL"
            End If
		
            If (IsNumeric(Request.Form("EndHourForCheckingCloseSession_Hour")) And IsNumeric(Request.Form("EndHourForCheckingCloseSession_Minute"))) Then
                SessionEndTime = "{ ts '2003-01-01 " + Request.Form("EndHourForCheckingCloseSession_Hour").ToString + ":" + Request.Form("EndHourForCheckingCloseSession_Minute").ToString + ":00' }"
            Else
                SessionEndTime = "NULL"
            End If
		
            If (IsNumeric(Request.Form("OpenHour_Hour")) And IsNumeric(Request.Form("OpenHour_Minute"))) Then
                StartTime = "{ ts '2003-01-01 " + Request.Form("OpenHour_Hour").ToString + ":" + Request.Form("OpenHour_Minute").ToString + ":00' }"
            Else
                StartTime = "NULL"
            End If
		
            If (IsNumeric(Request.Form("CloseHour_Hour")) And IsNumeric(Request.Form("CloseHour_Minute"))) Then
                EndTime = "{ ts '2003-01-01 " + Request.Form("CloseHour_Hour").ToString + ":" + Request.Form("CloseHour_Minute").ToString + ":00' }"
            Else
                EndTime = "NULL"
            End If
		            
            Dim SelType As Integer
            If TypeList.Items(0).Selected = True Then
                SelType = 1
            ElseIf TypeList.Items(1).Selected = True Then
                SelType = 2
            Else
                SelType = 3
            End If
            Application.Lock()
            Dim KeyID As Integer = ProductLevelID.Value
            If ProductLevelID.Value = 0 Then
                ExtraSQL(0) = "OpenHour,CloseHour,BudgetType,StartHourForCheckingCloseSession,EndHourForCheckingCloseSession"
                ExtraSQL(1) = StartTime + "," + EndTime + "," + SelType.ToString + "," + SessionStartTime + "," + SessionEndTime
            Else
                ExtraSQL(0) = "OpenHour=" + StartTime + ",CloseHour=" + EndTime + ",BudgetType=" + SelType.ToString + ",StartHourForCheckingCloseSession=" + SessionStartTime + ",EndHourForCheckingCloseSession=" + SessionEndTime
            End If
            Result = getInfo.AddUpdateCategory(Request, ExtraSQL, "ProductLevel", "ProductLevelID", objCnn)

            If PropertyInfo.Rows(0)("SystemEditionID") > 1 Then
                getInfo.UpdateDocType(1, ProductLevelID.Value, OldShopCode.Value, objCnn)
            End If
		
            Dim ShopPropText As String
            If showFullTaxProp.Visible = False Then
                If CompanyID.Value = 0 Then
                    ExtraSQL(0) = "InsertDate,UpdateDate"
                    ExtraSQL(1) = TimeNow + "," + TimeNow
                Else
                    ExtraSQL(0) = "UpdateDate=" + TimeNow
                End If
            Else
                If CompanyID.Value = 0 Then
                    If RadioHQ.Checked = True Then
                        ShopPropText = "1::" + Replace(FullTaxBranchName.Text, "'", "''")
                    Else
                        ShopPropText = "0:" + Replace(BranchNo.Text, "'", "''") + ":" + Replace(FullTaxBranchName.Text, "'", "''")
                    End If
                    ExtraSQL(0) = "InsertDate,UpdateDate,Addtional"
                    ExtraSQL(1) = TimeNow + "," + TimeNow + ",'" + ShopPropText + "'"
                Else
                    If RadioHQ.Checked = True Then
                        ShopPropText = ",Addtional='1:'"
                    Else
                        ShopPropText = ",Addtional='0:" + Replace(BranchNo.Text, "'", "''") + ":" + Replace(FullTaxBranchName.Text, "'", "''") + "'"
                    End If
                    ExtraSQL(0) = "UpdateDate=" + TimeNow + ShopPropText
                End If
            End If
            Result1 = getInfo.CompanyAction(Request, ExtraSQL, False, objCnn)
            Result1 = getInfo.UpdateInventoryView(Request, objCnn)
            If KeyID = 0 Then
                Dim GetMax As DataTable = objDB.List("select MAX(ProductLevelID) AS MaxID from ProductLevel", objCnn)
                KeyID = GetMax.Rows(0)("MaxID")
            End If
            Dim InsertShopID As Integer
            getInfo.GetCurrentShopID(InsertShopID, ProductLevelID.Value, objCnn)
            Dim ResultDynamic As String = Prop.UpdateDynamicPropInfo("Update", KeyID, 2, Request, objCnn)
            Result1 = getInfo.UpdateExtraShopInfo(InsertShopID, Request, objCnn)
            Dim ColData As DataTable = Session("ColDataSaleMode")
            getInfo.UpdateSaleModeProp(InsertShopID, Request, ColData, objCnn)
		
            If invcode.Visible = True Then
                objDB.sqlExecute("UPDATE ProductStockToInvSetting SET StockInventoryCode='" + Replace(Request.Form("StockInventoryCode"), "'", "''") + "' where StockInventoryID=" + InsertShopID.ToString, objCnn)
            End If
        
            'Update PrintReference BarCode In ProductLevel
            If cboPrintReferenceBarCode.Visible = True Then
                Dim printReferenceBarCodeValue As Integer
                printReferenceBarCodeValue = cboPrintReferenceBarCode.SelectedValue

                Dim strSQL As String
                strSQL = "Update ProductLevel Set PrintReferenceBarCodeInReceipt = " & printReferenceBarCodeValue & " Where ProductLevelID = " & InsertShopID
                objDB.sqlExecute(strSQL, objCnn)
            End If

            Application.UnLock()
            If Result = "Success" Then
                Dim shopInfo As New DataTable()
                shopInfo = getInfo.GetProductLevel(-999, objCnn)
                If shopInfo.Rows.Count = 1 Then
                    getInfo.DelInventoryView(1, 1, objCnn)
                    getInfo.AddInventoryView(1, 1, objCnn)
                    getInfo.DelInventoryView(1, shopInfo.Rows(0)("ProductLevelID"), objCnn)
                    getInfo.AddInventoryView(1, shopInfo.Rows(0)("ProductLevelID"), objCnn)
                    getInfo.DelInventoryView(shopInfo.Rows(0)("ProductLevelID"), 1, objCnn)
                    getInfo.AddInventoryView(shopInfo.Rows(0)("ProductLevelID"), 1, objCnn)
                    getInfo.DelInventoryView(shopInfo.Rows(0)("ProductLevelID"), shopInfo.Rows(0)("ProductLevelID"), objCnn)
                    getInfo.AddInventoryView(shopInfo.Rows(0)("ProductLevelID"), shopInfo.Rows(0)("ProductLevelID"), objCnn)
                End If
                Response.Redirect("inv_category.aspx?" + Request.QueryString.ToString)
            Else
                errorMsg.InnerHtml = "Result=" + Result
            End If
        Else
		
            'errorMsg.InnerHtml = "xxx" + FoundError.ToString

        End If
    End Sub

Sub DoCancel(Source As Object, E As EventArgs)
	
	Response.Redirect("inv_category.aspx")

End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>