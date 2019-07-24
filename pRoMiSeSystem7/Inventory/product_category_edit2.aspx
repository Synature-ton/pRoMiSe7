<%@ Page Language="VB" ContentType="text/html" EnableViewState="true" debug="True"%>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="System.IO" %>
<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<%@ Register tagprefix="synature" Tagname="time" Src="../UserControls/Time.ascx" %>
<html>
<head>
<title>Manage Products</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body<% = GlobalParam.BodyProp %>>

<form enctype="multipart/form-data" runat="server">
<input type="hidden" id="ProductID" runat="server" />
<input type="hidden" id="ProductCode_Old" runat="server" />
<input type="hidden" id="IsCommentVal" runat="server" />
<input type="hidden" id="MenuImage_iPad" runat="server" />
<input type="hidden" name="DisplayAtCheckerSystem" value="1">
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
<div id="showContent" visible="True" runat="server">
<table>
<div id="validateLevel" runat="server" />
<tr id="levelRow" runat="server">
	<td><div class="requireText" id="LevelParam" runat="server"></div></td>
	<td><div id="LevelSelectionText" runat="server"></div></td>
</tr>
<div id="validateGroup" runat="server" />
<tr id="showGroup" runat="server">
	<td><div class="requireText" id="GroupParam" runat="server"></div></td>
	<td><div id="GroupSelectionText" runat="server"></div></td>
</tr>
<div id="validateDept" runat="server" />
<tr>
	<td><div class="requireText" id="DeptParam" runat="server"></div></td>
	<td><div id="DeptSelectionText" runat="server"></div></td>
</tr>
<tr>
	<td><div class="requireText" id="IsProductSetParam" runat="server"></div></td>
	<td class="text"><div id="ProductSetSelection" runat="server"></div></td>
</tr>
<div id="validateCode" runat="server" />
<tr>
	<td><div class="requireText" id="CodeParam" runat="server"></div></td>
	<td><asp:textbox ID="ProductCode" Width="300" MaxLength="50" runat="server" /></td>
</tr>
<span id="ShowBuffet" visible="false" runat="server">
	<div id="validateBuffet" runat="server" />
	<tr>
        <td class="text">Is Buffet Product</td>
        <td class="text">            
            <table>
                <tr>
                    <td>            
                        <input type="radio" id="Radio110" name="ProductBuffet" value="1" runat="server" />YES
                    </td>            
                    <td>
                        : Over Every <asp:textbox ID="ExtentTimeEvery" Width="50" MaxLength="100" runat="server" /> minutes (
                        <input type="radio" id="Radio112" name="ExtentTimeRoundUp" value="0" runat="server" /> Round Down&nbsp;&nbsp;
                        <input type="radio" id="Radio113" name="ExtentTimeRoundUp" value="1" runat="server" />Round Up) will charge with product code: 
                        <asp:textbox ID="ProductCodeBuffet" Width="100" MaxLength="50" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        : Buffet Time(Only This Product) : <asp:textbox ID="ProductBuffetTime" Width="50" MaxLength="3" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="radio" id="Radio111" name="ProductBuffet" value="0" runat="server" />NO
                    </td>
                    <td></td>
                </tr>
             </table>
       </td>
    </tr>
</span>
<tr id="showBarCode" runat="server">
	<td><div class="text" id="BarCodeParam" runat="server"></div></td>
	<td><asp:textbox ID="ProductBarCode" Width="300" MaxLength="50" runat="server" /></td>
</tr>
<div id="validateName" runat="server" />
<tr>
	<td><div class="requireText" id="NameParam" runat="server"></div></td>
	<td><asp:textbox ID="ProductName" Width="300" MaxLength="100" runat="server" /></td>
</tr>

<div id="ShowName2" visible="false" runat="server">
<div id="validateName2" runat="server" />
<tr>
	<td><div class="text" id="Name2Param" runat="server"></div></td>
	<td><asp:textbox ID="ProductNameExtra" Width="300" MaxLength="100" runat="server" /></td>
</tr>
</div>

<div id="ShowPocketName" visible="false" runat="server">
<div id="validatePocketName" runat="server" />
<tr>
	<td><div class="text" id="PocketNameParam" runat="server"></div></td>
	<td><asp:textbox ID="ProductPocketName" Width="300" MaxLength="100" runat="server" /></td>
</tr>
</div>

<tr id="showShortName" visible="false" runat="server">
	<td><div class="text" id="ShortNameParam" runat="server"></div></td>
	<td><asp:textbox ID="MenuShortName" Width="50" MaxLength="2" runat="server" /></td>
</tr>

<span id="showPrice" visible="true" runat="server">
<div id="validatePrice" runat="server" />
<tr>
	<td><div class="text" id="PriceParam" runat="server"></div></td>
	<td><asp:textbox ID="ProductMainPrice" Width="100" MaxLength="100" runat="server" /></td>
</tr>
<div id="validatePriceSM2" runat="server" />
<tr id="PriceSM2" visible="false" runat="server">
	<td><div class="text" id="PriceParamSM2" runat="server"></div></td>
	<td><asp:textbox ID="ProductPriceSM2" Width="100" MaxLength="100" runat="server" /></td>
</tr>
<div id="validatePriceSM3" runat="server" />
<tr id="PriceSM3" visible="false" runat="server">
	<td><div class="text" id="PriceParamSM3" runat="server"></div></td>
	<td><asp:textbox ID="ProductPriceSM3" Width="100" MaxLength="100" runat="server" /></td>
</tr>
<div id="validatePriceSM4" runat="server" />
<tr id="PriceSM4" visible="false" runat="server">
	<td><div class="text" id="PriceParamSM4" runat="server"></div></td>
	<td><asp:textbox ID="ProductPriceSM4" Width="100" MaxLength="100" runat="server" /></td>
</tr>
<div id="validatePriceSM5" runat="server" />
<tr id="PriceSM5" visible="false" runat="server">
	<td><div class="text" id="PriceParamSM5" runat="server"></div></td>
	<td><asp:textbox ID="ProductPriceSM5" Width="100" MaxLength="100" runat="server" /></td>
</tr>
</span>
<span id="ShowMultiplePrice" visible="false" runat="server">
	<div id="validatePrice2" runat="server" />
	<tr>
		<td><div class="text" id="PriceParam2" runat="server"></div></td>
		<td><asp:textbox ID="ProductPrice2" Width="100" MaxLength="100" runat="server" /></td>
	</tr>
	<div id="validatePrice3" runat="server" />
	<tr>
		<td><div class="text" id="PriceParam3" runat="server"></div></td>
		<td><asp:textbox ID="ProductPrice3" Width="100" MaxLength="100" runat="server" /></td>
	</tr>
	<div id="validatePrice4" runat="server" />
	<tr>
		<td><div class="text" id="PriceParam4" runat="server"></div></td>
		<td><asp:textbox ID="ProductPrice4" Width="100" MaxLength="100" runat="server" /></td>
	</tr>
	<div id="validatePrice5" runat="server" />
	<tr>
		<td><div class="text" id="PriceParam5" runat="server"></div></td>
		<td><asp:textbox ID="ProductPrice5" Width="100" MaxLength="100" runat="server" /></td>
	</tr>
</span>

<div id="showPrinter" runat="server">
<tr>
	<td><div class="text" id="PrinterParam" runat="server"></div></td>
	<td class="text"><div id="PrinterSelectionText" runat="server"></div></td>
</tr>

<tr>
	<td><div class="text" id="PrintTypeNameParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio10" name="PrintGroup" value="1" runat="server" /><span id="CombineText" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio11" name="PrintGroup" value="0" runat="server" /><span id="SeperateText" runat="server"></span></td>
</tr>
</div>
<span id="showUpload" runat="server">
<div id="validateUploadFile" runat="server" />
<tr id="showUploadPicture" runat="server">
	<td><div class="text" id="ProductPictureParam" runat="server"></div><div id="ViewCurrentPicture" runat="server"></div></td>
	<td><input id="ProductPicture" type="file" accept="image/*" style="width:300px" runat="server" /><asp:CheckBox ID="RemoveImage" Text="Remove Picture" CssClass="text" Visible="false" runat="server"></asp:CheckBox></td>
</tr>

<div id="validateUploadFile_iPad" runat="server" />
<tr id="showUploadPicture_iPad" runat="server">
	<td><div class="text" id="ProductPictureParam_iPad" runat="server"></div><div id="ViewCurrentPicture_iPad" runat="server"></div></td>
	<td><input id="ProductPicture_iPad" type="file" accept="image/*" style="width:300px" runat="server" /><asp:CheckBox ID="RemoveImage_iPad" Text="Remove Picture" CssClass="text" Visible="false" runat="server"></asp:CheckBox></td>
</tr>
</span>
<tr id="showProductShortDesp" runat="server">
	<td valign="top"><div class="text" id="ProductShortDespParam" runat="server"></div></td>
	<td><asp:textbox ID="ProductShortDesp" TextMode="MultiLine" Columns="70" Rows="5" Width="400" MaxLength="255" runat="server" /></td>
</tr>
<tr id="showProductDesp" runat="server">
	<td valign="top"><div class="text" id="ProductDespParam" runat="server"></div></td>
	<td><asp:textbox ID="ProductDesp" TextMode="MultiLine" Columns="70" Rows="5" Width="400" MaxLength="255" runat="server" /></td>
</tr>

<div id="ShowPrepaid" visible="false" runat="Server">
<span id="validatePrepaid" runat="server"></span>
<tr>
	
	<td><div class="requireText" id="PrepaidParam" runat="server"></div></td>
	<td><asp:textbox ID="PrepaidPrice" Width="100" MaxLength="100" runat="server" /></td>
</tr>
</div>

<div id="showDuration" visible="false" runat="Server">
<span id="validateDuration" runat="server"></span>
<tr>
	
	<td><div class="requireText" id="DurationParam" runat="server"></div></td>
	<td><asp:textbox ID="DurationTime" Width="100" MaxLength="100" runat="server" /> <span id="MinuteText" class="text" runat="server"></span></td>
</tr>
<span id="ShowStaffDuration" visible="false" runat="Server">
<span id="validateDurationStaff1" runat="server"></span>
<tr>
	
	<td><div class="requireText" id="Staff1DurationParam" runat="server"></div></td>
	<td><asp:textbox ID="Staff1DurationTime" Width="100" MaxLength="100" runat="server" /> <span id="MinuteText1" class="text" runat="server"></span></td>
</tr>
</span>
<span id="ShowMultiDuration" visible="false" runat="server">
<span id="validateDurationStaff2" runat="server"></span>
<tr>
	
	<td><div class="requireText" id="Staff2DurationParam" runat="server"></div></td>
	<td><asp:textbox ID="Staff2DurationTime" Width="100" MaxLength="100" runat="server" /> <span id="MinuteText2" class="text" runat="server"></span></td>
</tr>
<span id="validateDurationStaff3" runat="server"></span>
<tr>
	
	<td><div class="requireText" id="Staff3DurationParam" runat="server"></div></td>
	<td><asp:textbox ID="Staff3DurationTime" Width="100" MaxLength="100" runat="server" /> <span id="MinuteText3" class="text" runat="server"></span></td>
</tr>
</span>
</div>

<span id="showCommentAmount" runat="server">
<span id="validateAddAmount" runat="server"></span>
<tr>
	
	<td><div class="requireText" id="AddAmountParam" runat="server"></div></td>
	<td><input type="radio" id="Radio_01" name="RequireAddAmountForProduct" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio_02" name="RequireAddAmountForProduct" value="0" runat="server" />NO</td>
</tr>
</span>

<span id="ShowAddAmount" visible="false" runat="server">

<span id="validateFlexiblePrice" runat="server"></span>
<tr>
	
	<td><div class="requireText" id="FlexiblePriceParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio21" name="FlexibleProductIncludePrice" value="1" runat="server" /><span id="YesText7" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio22" name="FlexibleProductIncludePrice" value="0" runat="server" /><span id="NoText7" runat="server"></span></td>
</tr>
</span>

<tr id="ShowPrintOption" runat="server">
	<td><div class="text" id="PrintOptionNameParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio100" name="PrintFlexibleProductFromItsOwnPrinter" value="1" runat="server" /><span id="ItsOwnText" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio101" name="PrintFlexibleProductFromItsOwnPrinter" value="0" runat="server" /><span id="InSideText" runat="server"></span></td>
</tr>

<tr id="showVAT" runat="server">
	<td><div class="requireText" id="VATTypeParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="optNoVAT" name="VATType" value="0" runat="server" /><span id="NoVAT" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="optIncludeVAT" name="VATType" value="1" runat="server" /><span id="IncludeVAT" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="optExcludeVAT" name="VATType" value="2" runat="server" /><span id="ExcludeVAT" runat="server"></span></td>
</tr>

<div id="validateDiscount" runat="server" />
<tr id="showDiscount" runat="server">
	<td><div class="requireText" id="DiscountParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="optDiscountAllow" name="DiscountAllow" value="1" runat="server" /><span id="YesText1" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="optNotDiscountAllow" name="DiscountAllow" value="0" runat="server" /><span id="NoText1" runat="server"></span></td>
</tr>
<div id="validateZero" runat="server" />
<tr id="showZeroAllow" runat="Server">
	<td><div class="requireText" id="ZeroParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="optZeroPriceAllow" name="ZeroPriceAllow" value="1" runat="server" /><span id="YesText2" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="optNotZeroPriceAllow" name="ZeroPriceAllow" value="0" runat="server" /><span id="NoText2" runat="server"></span></td>
</tr>
<tr>
	<td><div class="requireText" id="ActivateParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio5" name="ProductActivate" value="1" runat="server" /><span id="YesText3" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio6" name="ProductActivate" value="0" runat="server" /><span id="NoText3" runat="server"></span></td>
</tr>

<tr id="DisplayTablet" visible="false" runat="server">
	<td class="text">Display in Tablet</td>
	<td class="text"><input type="radio" id="Radio1000" name="TabletActivate" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio1111" name="TabletActivate" value="0" runat="server" />NO</td>
</tr>

<div id="validateEnableDateTime" runat="server" />
<tr>
	<td><div class="text" id="ProductEnableDateTimeParam" runat="server"></div></td>
	<td><synature:date id="ProductEnableDateTime" runat="server" /></td>
</tr>

<div id="validateExpireDateTime" runat="server" />
<tr>
	<td><div class="text" id="ProductExpireDateTimeParam" runat="server"></div></td>
	<td><synature:date id="ProductExpireDateTime" runat="server" /></td>
</tr>

<div id="validateTime" runat="server" />
<tr>
	<td class="text">Enable Time Criteria</td>
	<td><table><tr><td><synature:time id="FromTime" runat="server" /></td><td> To </td><td><synature:time id="ToTime" runat="server" /></td></tr></table></td>
</tr>

<span id="ShowWeekly" runat="server">
<tr>
	<td class="text">Enable Weekly</td>
    <td><table><span id="WeeklyOptionString" runat="server"></span></table></td>
</tr>
</span>

<span id="showChecker" runat="server">
<tr>
	<td class="text">Critical Time</td>
	<td class="text"><asp:textbox ID="CriticalTime" Width="80" MaxLength="10" Text="15" runat="server" /> minutes</td>
</tr>
<tr>
	<td class="text">Warning Time</td>
	<td class="text"><asp:textbox ID="WarningTime" Width="80" MaxLength="10" Text="10" runat="server" /> minutes</td>
</tr>
</span>

<tr id="ShowServiceCharge" runat="server">
	<td><div class="text" id="ServiceChargeParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio17" name="HasServiceCharge" value="1" runat="server" /><span id="YesText5" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio18" name="HasServiceCharge" value="0" runat="server" /><span id="NoText5" runat="server"></span></td>
</tr>

<tr id="showTakeAway" visible="false" runat="server">
	<td><div class="text" id="TakeAwayParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio19" name="TakeAway" value="1" runat="server" /><span id="YesText6" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio20" name="TakeAway" value="0" runat="server" /><span id="NoText6" runat="server"></span></td>
</tr>

<tr id="SM1" visible="false" runat="server">
	<td><div class="text" id="SaleMode1Param" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio25" name="SaleMode1" value="1" runat="server" /><span id="YesText9" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio26" name="SaleMode1" value="0" runat="server" /><span id="NoText9" runat="server"></span></td>
</tr>
<tr id="SM2" visible="false" runat="server">
	<td><div class="text" id="SaleMode2Param" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio27" name="SaleMode2" value="1" runat="server" /><span id="YesText10" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio28" name="SaleMode2" value="0" runat="server" /><span id="NoText10" runat="server"></span></td>
</tr>
<tr id="SM3" visible="false" runat="server">
	<td><div class="text" id="SaleMode3Param" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio29" name="SaleMode3" value="1" runat="server" /><span id="YesText11" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio30" name="SaleMode3" value="0" runat="server" /><span id="NoText11" runat="server"></span></td>
</tr>
<tr id="SM4" visible="false" runat="server">
	<td><div class="text" id="SaleMode4Param" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio31" name="SaleMode4" value="1" runat="server" /><span id="YesText12" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio32" name="SaleMode4" value="0" runat="server" /><span id="NoText12" runat="server"></span></td>
</tr>
<tr id="SM5" visible="false" runat="server">
	<td><div class="text" id="SaleMode5Param" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio33" name="SaleMode5" value="1" runat="server" /><span id="YesText13" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio34" name="SaleMode5" value="0" runat="server" /><span id="NoText13" runat="server"></span></td>
</tr>

<span id="showReturn" runat="server">
<tr>
	<td><div class="text" id="ReturnProductParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio23" name="CanReturnProduct" value="1" runat="server" /><span id="YesText8" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio24" name="CanReturnProduct" value="0" runat="server" /><span id="NoText8" runat="server"></span></td>
</tr>
</span>
<tr id="showPromo" visible="False" runat="server">
	<td><div class="text" id="PromoParam" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio15" name="SelPromo" value="1" runat="server" /><span id="YesText4" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio16" name="SelPromo" value="0" runat="server" /><span id="NoText4" runat="server"></span></td>
</tr>
<div id="validateOrdering" runat="server" />
<tr>
	<td><div class="requireText" id="OrderingParam" runat="server"></div></td>
	<td><asp:textbox ID="ProductOrdering" Width="50" runat="server" /></td>
</tr>
<div id="validatePrintOrdering" runat="server" />
<tr>
	<td><div class="requireText" id="PrintOrderingParam" runat="server"></div></td>
	<td><asp:textbox ID="PrintOrdering" Width="50" runat="server" /></td>
</tr>
<tr>
	<td colspan="2" height="5"></td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td><asp:button ID="SubmitForm" OnClick="DoAddUpdate" runat="server" />&nbsp;&nbsp;&nbsp;<asp:button ID="CancelForm" OnClick="DoCancel" runat="server" /></td>
</tr>

</table>
</div>

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
Dim getPageText As New DefaultText()
Dim DateTimeUtil As New MyDateTime()
Dim getConfig As New POSConfiguration()
Dim getProp As New CPreferences()
Dim getPromo As New CPromotions()
Dim objDB As New CDBUtil()
Dim getDB As New DBInfo()
Dim Util As New UtilityFunction()

Dim PriceBeginDate As String = "{ d '2000-01-01' }"
Dim PriceEndDate As String = "{ d '9999-01-01' }"

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Inv_Product_Category") Then
	
            'Try
            objCnn = getCnn.EstablishConnection()
			
            SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
			
            Dim textTable As New DataTable()
            textTable = getPageText.GetText(7, Session("LangID"), objCnn)
			
            Dim textTable1 As New DataTable()
            textTable1 = getPageText.GetText(8, Session("LangID"), objCnn)
			
            Dim defaultTextTable As New DataTable()
            defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
            Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
			
            If PropertyInfo.Rows(0)("SystemEditionID") = 1 Then
                showUpload.Visible = False
                showTakeAway.Visible = False
                showReturn.Visible = False
            End If
			
            Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
            Dim CultureString As String = Util.GetCultureByLangID(Session("LangID"), objCnn)
			
            Dim Exist As Boolean = getProp.CheckTableColumn("Products", "ProductPocketName", objCnn)
            If Exist = True Then
                ShowPocketName.Visible = False
            Else
                ShowPocketName.Visible = True
            End If
            If PropertyInfo.Rows(0)("PocketPCFeature") = 0 Then
                ShowPocketName.Visible = False
            End If
            ShowName2.Visible = True
			
            Dim WeeklyExist As Boolean = getProp.CheckTableColumn("Products", "ProductEnableDayString", objCnn)
            If WeeklyExist = True Then
                ShowWeekly.Visible = False
            Else
                ShowWeekly.Visible = True
            End If
			
            Dim ChkmPOS As DataTable = getProp.PropertyValue(2, 10, Request.QueryString("ProductLevelID"), objCnn)
            Dim mPOS As Boolean = False
            If ChkmPOS.Rows.Count > 0 Then
                If ChkmPOS.Rows(0)("PropertyValue") = 1 Then
                    mPOS = True
                End If
            End If
            DisplayTablet.Visible = mPOS
			
            If mPOS = True Then
                showUploadPicture_iPad.Visible = True
                showProductShortDesp.Visible = True
                showShortName.Visible = True
            Else
                showUploadPicture_iPad.Visible = False
                showProductShortDesp.Visible = False
                showShortName.Visible = False
            End If
			
            Dim PriceRegion As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramtypeID = 2 AND PropertyID =14 AND KeyID = 1", objCnn)
            Dim PriceRegFeature As Boolean = False
            If PriceRegion.Rows.Count > 0 Then
                If PriceRegion.Rows(0)("PropertyValue") = 1 Or PriceRegion.Rows(0)("PropertyValue") = 2 Then
                    PriceRegFeature = True
                End If
            End If
			
            If PriceRegFeature = True Then
                showPrice.Visible = False
            End If
			
            CancelForm.Text = defaultTextTable.Rows(2)("TextParamValue")
            YesText1.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText1.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
            YesText2.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText2.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
            YesText3.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText3.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
            YesText4.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText4.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
            YesText5.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText5.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
            YesText6.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText6.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
            MinuteText.InnerHtml = defaultTextTable.Rows(100)("TextParamValue")
            MinuteText1.InnerHtml = defaultTextTable.Rows(100)("TextParamValue")
            MinuteText2.InnerHtml = defaultTextTable.Rows(100)("TextParamValue")
            MinuteText3.InnerHtml = defaultTextTable.Rows(100)("TextParamValue")
            YesText7.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText7.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
            YesText8.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText8.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
            YesText9.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText9.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
            YesText10.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText10.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
            YesText11.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText11.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
            YesText12.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText12.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
            YesText13.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
            NoText13.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
			
            VATTypeParam.InnerHtml = defaultTextTable.Rows(99)("TextParamValue")
            NoVAT.InnerHtml = defaultTextTable.Rows(89)("TextParamValue")
            IncludeVAT.InnerHtml = defaultTextTable.Rows(87)("TextParamValue")
            ExcludeVAT.InnerHtml = defaultTextTable.Rows(88)("TextParamValue")
			
            BarCodeParam.InnerHtml = "Product Bar Code"
            CodeParam.InnerHtml = textTable.Rows(40)("TextParamValue")
            NameParam.InnerHtml = textTable.Rows(41)("TextParamValue")
            DiscountParam.InnerHtml = textTable.Rows(52)("TextParamValue")
            ZeroParam.InnerHtml = textTable.Rows(53)("TextParamValue")
            LevelParam.InnerHtml = textTable.Rows(7)("TextParamValue")
            GroupParam.InnerHtml = textTable.Rows(15)("TextParamValue")
            DeptParam.InnerHtml = textTable.Rows(28)("TextParamValue")
            ProductPictureParam.InnerHtml = textTable.Rows(59)("TextParamValue")
            ActivateParam.InnerHtml = textTable.Rows(60)("TextParamValue")
            PrinterParam.InnerHtml = textTable.Rows(65)("TextParamValue")
            IsProductSetParam.InnerHtml = textTable.Rows(67)("TextParamValue")
            DurationParam.InnerHtml = textTable.Rows(76)("TextParamValue")
            Staff1DurationParam.InnerHtml = "Therapist Duration"
            Staff2DurationParam.InnerHtml = "Therapist 2 Duration"
            Staff3DurationParam.InnerHtml = "Therapist 3 Duration"
            AddAmountParam.InnerHtml = textTable.Rows(88)("TextParamValue")
            PrintOptionNameParam.InnerHtml = textTable.Rows(89)("TextParamValue")
            ItsOwnText.InnerHtml = textTable.Rows(90)("TextParamValue")
            InSideText.InnerHtml = textTable.Rows(91)("TextParamValue")
			
            PrintTypeNameParam.InnerHtml = textTable.Rows(71)("TextParamValue")
            CombineText.InnerHtml = textTable.Rows(72)("TextParamValue")
            SeperateText.InnerHtml = textTable.Rows(73)("TextParamValue")
            ProductDespParam.InnerHtml = textTable.Rows(84)("TextParamValue")
			
            HeaderText.InnerHtml = textTable.Rows(11)("TextParamValue")
            PriceParam.InnerHtml = textTable1.Rows(20)("TextParamValue")
			
            PromoParam.InnerHtml = "Add to Promotion"
            ServiceChargeParam.InnerHtml = "Service Charge"
            TakeAwayParam.InnerHtml = "Take Away"
            OrderingParam.InnerHtml = "Display Ordering" 'defaultTextTable.Rows(107)("TextParamValue")
            FlexiblePriceParam.InnerHtml = textTable.Rows(92)("TextParamValue")
			
            PrepaidParam.InnerHtml = "Prepaid Amount"
            ReturnProductParam.InnerHtml = "Can Return Product"
            ProductEnableDateTimeParam.InnerHtml = "Activate Date"
            ProductExpireDateTimeParam.InnerHtml = "Expiry Date"
			
            Name2Param.InnerHtml = "Product Name 1"
            PocketNameParam.InnerHtml = "Product Name (Tablet)"
            ProductPictureParam_iPad.InnerHtml = "Product Image for Tablet"
            ProductShortDespParam.InnerHtml = "Product Short Description"
            ShortNameParam.InnerHtml = "Product Short Name"
			
            Dim i As Integer
            Dim SMData As DataTable = objDB.List("select * from SaleMode where Deleted=0 order by SaleModeID", objCnn)
			
            SM1.Visible = False
            SM2.Visible = False
            SM3.Visible = False
            SM4.Visible = False
            SM5.Visible = False
            For i = 0 To SMData.Rows.Count - 1
                If SMData.Rows(i)("SaleModeID") = 1 Then
                    SM1.Visible = True
                    SaleMode1Param.InnerHtml = SMData.Rows(i)("SaleModeName")
                ElseIf SMData.Rows(i)("SaleModeID") = 2 Then
                    SM2.Visible = True
                    SaleMode2Param.InnerHtml = SMData.Rows(i)("SaleModeName")
                    PriceSM2.Visible = True
                    PriceParamSM2.InnerHtml = textTable1.Rows(20)("TextParamValue") + " " + SMData.Rows(i)("SaleModeName")
                ElseIf SMData.Rows(i)("SaleModeID") = 3 Then
                    SM3.Visible = True
                    SaleMode3Param.InnerHtml = SMData.Rows(i)("SaleModeName")
                    PriceSM3.Visible = True
                    PriceParamSM3.InnerHtml = textTable1.Rows(20)("TextParamValue") + " " + SMData.Rows(i)("SaleModeName")
                ElseIf SMData.Rows(i)("SaleModeID") = 4 Then
                    SM4.Visible = True
                    SaleMode4Param.InnerHtml = SMData.Rows(i)("SaleModeName")
                    PriceSM4.Visible = True
                    PriceParamSM4.InnerHtml = textTable1.Rows(20)("TextParamValue") + " " + SMData.Rows(i)("SaleModeName")
                ElseIf SMData.Rows(i)("SaleModeID") = 5 Then
                    SM5.Visible = True
                    SaleMode5Param.InnerHtml = SMData.Rows(i)("SaleModeName")
                    PriceSM5.Visible = True
                    PriceParamSM5.InnerHtml = textTable1.Rows(20)("TextParamValue") + " " + SMData.Rows(i)("SaleModeName")
                End If
            Next

            PrintOrderingParam.InnerHtml = "Print Ordering"
			
            ProductEnableDateTime.LangID = Session("LangID")
            ProductEnableDateTime.FormName = "ProductEnableDateTime"
            ProductEnableDateTime.StartYear = -1
            ProductEnableDateTime.EndYear = 2
            ProductEnableDateTime.LangID = Session("LangID")
            ProductEnableDateTime.Lang_Data = LangDefault
            ProductEnableDateTime.Culture = CultureString
			
            ProductExpireDateTime.LangID = Session("LangID")
            ProductExpireDateTime.FormName = "ProductExpireDateTime"
            ProductExpireDateTime.StartYear = -1
            ProductExpireDateTime.EndYear = 2
            ProductExpireDateTime.LangID = Session("LangID")
            ProductExpireDateTime.Lang_Data = LangDefault
            ProductExpireDateTime.Culture = CultureString
			
            FromTime.LangID = Session("LangID")
            FromTime.FormName = "FromTime"
            FromTime.SelectedHour = -1
            FromTime.SelectedMinute = -1
			
            ToTime.LangID = Session("LangID")
            ToTime.FormName = "ToTime"
            ToTime.SelectedHour = -1
            ToTime.SelectedMinute = -1
			
            Dim IDValueFromDB, GroupIDValueFromDB, DeptIDValueFromDB, ProductSetValueFromDB As Integer
            Dim PrinterIDValueFromDB As String = ""
			
            Dim WeeklyStringFromDB As String = ""
            Dim j As Integer
			
            Dim InvC As CultureInfo = CultureInfo.InvariantCulture
            Dim CurrentYear As Integer = CInt(DateTime.Now.ToString("yyyy", InvC))
			
            ShowBuffet.Visible = False
            showChecker.Visible = False
            Dim HasServiceChargeValue As Boolean = False
            Dim VATTypeVal As Integer = 1
            Dim getShopInfo As DataTable = getInfo.GetProductLevel(Request.QueryString("ProductLevelID"), objCnn)
            If getShopInfo.Rows.Count > 0 Then
                If getShopInfo.Rows(0)("HasBuffetFeature") > 0 Then
                    ShowBuffet.Visible = True
                End If
                If getShopInfo.Rows(0)("HasCheckerSystem") > 0 Then
                    showChecker.Visible = True
                End If
                If getShopInfo.Rows(0)("ServiceCharge") > 0 Then
                    HasServiceChargeValue = True
                End If
                If getShopInfo.Rows(0)("DisplayReceiptVATableType") > 0 Then
                    VATTypeVal = getShopInfo.Rows(0)("DisplayReceiptVATableType")
                End If
            End If
			
			
            If Not Request.QueryString("ProductID") And IsNumeric(Request.QueryString("ProductID")) Then
		
                Dim ShopTypeData As New DataTable()
                ShopTypeData = getInfo.GetProductLevel(Request.QueryString("ProductLevelID"), objCnn)
			
                If ShopTypeData.Rows.Count > 0 Then
                    If ShopTypeData.Rows(0)("ShopType") = 4 Then
                        'ShowMultiplePrice.Visible = True
                        PriceParam.InnerHtml = textTable1.Rows(20)("TextParamValue") + " 1"
                        PriceParam2.InnerHtml = textTable1.Rows(20)("TextParamValue") + " 2"
                        PriceParam3.InnerHtml = textTable1.Rows(20)("TextParamValue") + " 3"
                        PriceParam4.InnerHtml = textTable1.Rows(20)("TextParamValue") + " 4"
                        PriceParam5.InnerHtml = textTable1.Rows(20)("TextParamValue") + " 5"
                    End If
                End If
			
			
                ProductID.Value = Request.QueryString("ProductID")
			
                Dim getData As DataTable
                getData = getInfo.GetProductInfo(0, ProductID.Value, objCnn)
                Dim productPriceTable As New DataTable()
                Dim multiplePriceTable As DataTable
                Dim CheckDigit As Double
                Dim Check2Digit As Double
			
                If Request.QueryString("SaveAs") = "yes" Then
                    updateMessage.Text = textTable.Rows(61)("TextParamValue") + " """ + getData.Rows(0)("ProductName") + """ " + textTable.Rows(62)("TextParamValue")
                    SubmitForm.Text = textTable.Rows(8)("TextParamValue")
                    If Not Page.IsPostBack Then
					
                        If ShowBuffet.Visible = True Then
                            Dim GetBuffet As DataTable = objDB.List("select * from ProductBuffetSetting where ProductBuffetID=" + ProductID.Value.ToString, objCnn)
                            If GetBuffet.Rows.Count > 0 Then
                                Radio110.Checked = True
                                ExtentTimeEvery.Text = GetBuffet.Rows(0)("ExtentTimeEvery").ToString
                                If GetBuffet.Rows(0)("ExtentTimeRoundUp") = 0 Then
                                    Radio112.Checked = True
                                Else
                                    Radio113.Checked = True
                                End If
                                Dim getP As DataTable = objDB.List("select * from Products where deleted=0 AND ProductID=" + GetBuffet.Rows(0)("ExtentProductID").ToString, objCnn)
                                If getP.Rows.Count > 0 Then
                                    ProductCodeBuffet.Text = getP.Rows(0)("ProductCode")
                                End If
                                If GetBuffet.Rows(0)("ProductBuffetTime") > 0 Then
                                    ProductBuffetTime.Text = GetBuffet.Rows(0)("ProductBuffetTime")
                                Else
                                    ProductBuffetTime.Text = ""
                                End If
                            Else
                                Radio111.Checked = True
                                Radio112.Checked = True
                                ProductCodeBuffet.Text = ""
                                ProductBuffetTime.Text = ""
                            End If
                        End If
					
                        If ShowWeekly.Visible = True Then
                            If Not IsDBNull(getData.Rows(0)("ProductEnableDayString")) Then
                                If Trim(getData.Rows(0)("ProductEnableDayString")) <> "" Then
                                    WeeklyStringFromDB = getData.Rows(0)("ProductEnableDayString")
                                End If
                            End If
                        End If
					
                        If ShowName2.Visible = True Then
                            If Not IsDBNull(getData.Rows(0)("ProductName1")) Then
                                ProductNameExtra.Text = getData.Rows(0)("ProductName1")
                            End If
                        End If
					
                        If ShowPocketName.Visible = True Then
                            If Not IsDBNull(getData.Rows(0)("ProductPocketName")) Then
                                ProductPocketName.Text = getData.Rows(0)("ProductPocketName")
                            End If
                        End If
					
                        ProductName.Text = getData.Rows(0)("ProductName")
                        ProductCode.Text = getData.Rows(0)("ProductCode")
                        ProductSetValueFromDB = getData.Rows(0)("ProductSet")
                        If getData.Rows(0)("DiscountAllow") = True Or getData.Rows(0)("DiscountAllow") = 1 Then
                            optDiscountAllow.Checked = True
                        Else
                            optNotDiscountAllow.Checked = True
                        End If
                        If getData.Rows(0)("ZeroPriceAllow") = True Or getData.Rows(0)("ZeroPriceAllow") = 1 Then
                            optZeroPriceAllow.Checked = True
                        Else
                            optNotZeroPriceAllow.Checked = True
                        End If
                        Radio5.Checked = True
                        Radio11.Checked = True
                        Select Case getData.Rows(0)("VATType")
                            Case 0
                                optNoVAT.Checked = True
                            Case 2
                                optExcludeVAT.Checked = True
                            Case Else
                                optIncludeVAT.Checked = True
                        End Select
                        Radio16.Checked = True
                        If HasServiceChargeValue = True Then
                            Radio17.Checked = True
                        Else
                            Radio18.Checked = True
                        End If
                        Radio20.Checked = True
                        Radio22.Checked = True
                        Radio25.Checked = True
                        ProductCode_Old.Value = ""
                        Radio1000.Checked = True
					
                        Dim SaleMode2 As DataTable = objDB.List("select * from SaleModeProductLevelProperty where SaleMode=2 AND ProductlevelID=" + Request.QueryString("ProductLevelID").ToString, objCnn)
                        If SaleMode2.Rows.Count > 0 Then
                            Radio27.Checked = True
                        Else
                            Radio28.Checked = True
                        End If
                        Dim SaleMode3 As DataTable = objDB.List("select * from SaleModeProductLevelProperty where SaleMode=3 AND ProductlevelID=" + Request.QueryString("ProductLevelID").ToString, objCnn)
                        If SaleMode3.Rows.Count > 0 Then
                            Radio29.Checked = True
                        Else
                            Radio30.Checked = True
                        End If
					
                        Dim SaleMode4 As DataTable = objDB.List("select * from SaleModeProductLevelProperty where SaleMode=4 AND ProductlevelID=" + Request.QueryString("ProductLevelID").ToString, objCnn)
                        If SaleMode4.Rows.Count > 0 Then
                            Radio31.Checked = True
                        Else
                            Radio32.Checked = True
                        End If
					
                        Dim SaleMode5 As DataTable = objDB.List("select * from SaleModeProductLevelProperty where SaleMode=5 AND ProductlevelID=" + Request.QueryString("ProductLevelID").ToString, objCnn)
                        If SaleMode5.Rows.Count > 0 Then
                            Radio33.Checked = True
                        Else
                            Radio34.Checked = True
                        End If
                        Radio24.Checked = True
                        ProductOrdering.Text = "0"
                        PrintOrdering.Text = "0"
                    End If
                    Dim promoData1 As New DataTable()
                    promoData1 = getPromo.GetPromotionInfo(-1, -1, "", objCnn)
                    If promoData1.Rows.Count > 0 Then
                        showPromo.Visible = True
                    End If
					
                Else
                    If Not Page.IsPostBack Then
                        multiplePriceTable = getInfo.GetProductPriceInfo(ProductID.Value, 0, 0, objCnn)
                        For i = 0 To multiplePriceTable.Rows.Count - 1
                            Select Case multiplePriceTable.Rows(i)("MainPrice")
                                Case 2
                                    ProductPrice2.Text = Format(multiplePriceTable.Rows(i)("ProductPrice"), "##0")
                                Case 3
                                    ProductPrice3.Text = Format(multiplePriceTable.Rows(i)("ProductPrice"), "##0")
                                Case 4
                                    ProductPrice4.Text = Format(multiplePriceTable.Rows(i)("ProductPrice"), "##0")
                                Case 5
                                    ProductPrice5.Text = Format(multiplePriceTable.Rows(i)("ProductPrice"), "##0")
                            End Select
                        Next
					
                        productPriceTable = getInfo.GetProductPriceInfo(ProductID.Value, 1, 0, 1, objCnn)
					
                        If productPriceTable.Rows.Count > 0 Then
                            CheckDigit = productPriceTable.Rows(0)("ProductPrice") Mod 1
                            Check2Digit = (productPriceTable.Rows(0)("ProductPrice") Mod 1) * 100 Mod 1
                            If CheckDigit = 0 Then
                                ProductMainPrice.Text = Format(productPriceTable.Rows(0)("ProductPrice"), "##0")
                                If Not IsDBNull(productPriceTable.Rows(0)("PrepaidPrice")) Then
                                    PrepaidPrice.Text = Format(productPriceTable.Rows(0)("PrepaidPrice"), "##0")
                                End If
                            ElseIf Check2Digit = 0 Then
                                ProductMainPrice.Text = Format(productPriceTable.Rows(0)("ProductPrice"), "##0.00")
                                If Not IsDBNull(productPriceTable.Rows(0)("PrepaidPrice")) Then
                                    PrepaidPrice.Text = Format(productPriceTable.Rows(0)("PrepaidPrice"), "##0.00")
                                End If
                            Else
                                ProductMainPrice.Text = Format(productPriceTable.Rows(0)("ProductPrice"), "##0.0000")
                                If Not IsDBNull(productPriceTable.Rows(0)("PrepaidPrice")) Then
                                    PrepaidPrice.Text = Format(productPriceTable.Rows(0)("PrepaidPrice"), "##0.0000")
                                End If
                            End If

                        End If
					
                        If SM2.Visible = True Then
                            productPriceTable = getInfo.GetProductPriceInfo(ProductID.Value, 2, 0, 1, objCnn)
                            If productPriceTable.Rows.Count > 0 Then
                                CheckDigit = productPriceTable.Rows(0)("ProductPrice") Mod 1
                                Check2Digit = (productPriceTable.Rows(0)("ProductPrice") Mod 1) * 100 Mod 1
                                If CheckDigit = 0 Then
                                    ProductPriceSM2.Text = Format(productPriceTable.Rows(0)("ProductPrice"), "##0")
                                ElseIf Check2Digit = 0 Then
                                    ProductPriceSM2.Text = Format(productPriceTable.Rows(0)("ProductPrice"), "##0.00")
                                Else
                                    ProductPriceSM2.Text = Format(productPriceTable.Rows(0)("ProductPrice"), "##0.0000")
                                End If
	
                            End If
                        End If
					
                        If SM3.Visible = True Then
                            productPriceTable = getInfo.GetProductPriceInfo(ProductID.Value, 3, 0, 1, objCnn)
                            If productPriceTable.Rows.Count > 0 Then
                                CheckDigit = productPriceTable.Rows(0)("ProductPrice") Mod 1
                                Check2Digit = (productPriceTable.Rows(0)("ProductPrice") Mod 1) * 100 Mod 1
                                If CheckDigit = 0 Then
                                    ProductPriceSM3.Text = Format(productPriceTable.Rows(0)("ProductPrice"), "##0")
                                ElseIf Check2Digit = 0 Then
                                    ProductPriceSM3.Text = Format(productPriceTable.Rows(0)("ProductPrice"), "##0.00")
                                Else
                                    ProductPriceSM3.Text = Format(productPriceTable.Rows(0)("ProductPrice"), "##0.0000")
                                End If
	
                            End If
                        End If
					
                        If SM4.Visible = True Then
                            productPriceTable = getInfo.GetProductPriceInfo(ProductID.Value, 4, 0, 1, objCnn)
                            If productPriceTable.Rows.Count > 0 Then
                                CheckDigit = productPriceTable.Rows(0)("ProductPrice") Mod 1
                                Check2Digit = (productPriceTable.Rows(0)("ProductPrice") Mod 1) * 100 Mod 1
                                If CheckDigit = 0 Then
                                    ProductPriceSM4.Text = Format(productPriceTable.Rows(0)("ProductPrice"), "##0")
                                ElseIf Check2Digit = 0 Then
                                    ProductPriceSM4.Text = Format(productPriceTable.Rows(0)("ProductPrice"), "##0.00")
                                Else
                                    ProductPriceSM4.Text = Format(productPriceTable.Rows(0)("ProductPrice"), "##0.0000")
                                End If
	
                            End If
                        End If
					
                        If SM5.Visible = True Then
                            productPriceTable = getInfo.GetProductPriceInfo(ProductID.Value, 5, 0, 1, objCnn)
                            If productPriceTable.Rows.Count > 0 Then
                                CheckDigit = productPriceTable.Rows(0)("ProductPrice") Mod 1
                                Check2Digit = (productPriceTable.Rows(0)("ProductPrice") Mod 1) * 100 Mod 1
                                If CheckDigit = 0 Then
                                    ProductPriceSM5.Text = Format(productPriceTable.Rows(0)("ProductPrice"), "##0")
                                ElseIf Check2Digit = 0 Then
                                    ProductPriceSM5.Text = Format(productPriceTable.Rows(0)("ProductPrice"), "##0.00")
                                Else
                                    ProductPriceSM5.Text = Format(productPriceTable.Rows(0)("ProductPrice"), "##0.0000")
                                End If
	
                            End If
                        End If
					
                        If ShowBuffet.Visible = True Then
                            Dim GetBuffet As DataTable = objDB.List("select * from ProductBuffetSetting where ProductBuffetID=" + ProductID.Value.ToString, objCnn)
                            If GetBuffet.Rows.Count > 0 Then
                                Radio110.Checked = True
                                ExtentTimeEvery.Text = GetBuffet.Rows(0)("ExtentTimeEvery").ToString
                                If GetBuffet.Rows(0)("ExtentTimeRoundUp") = 0 Then
                                    Radio112.Checked = True
                                Else
                                    Radio113.Checked = True
                                End If
                                Dim getP As DataTable = objDB.List("select * from Products where deleted=0 AND ProductID=" + GetBuffet.Rows(0)("ExtentProductID").ToString, objCnn)
                                If getP.Rows.Count > 0 Then
                                    ProductCodeBuffet.Text = getP.Rows(0)("ProductCode")
                                End If
                                If GetBuffet.Rows(0)("ProductBuffetTime") > 0 Then
                                    ProductBuffetTime.Text = GetBuffet.Rows(0)("ProductBuffetTime")
                                Else
                                    ProductBuffetTime.Text = ""
                                End If
                            Else
                                Radio111.Checked = True
                                Radio112.Checked = True
                                ProductCodeBuffet.Text = ""
                                ProductBuffetTime.Text = ""
                            End If
                        End If
					
                        If IsDBNull(getData.Rows(0)("PrinterID")) Then
                            PrinterIDValueFromDB = ""
                        Else
                            PrinterIDValueFromDB = getData.Rows(0)("PrinterID")
                        End If
					
                        If Not IsDBNull(getData.Rows(0)("ProductDesp")) Then
                            ProductDesp.Text = getData.Rows(0)("ProductDesp")
                        End If
					
                        If Not IsDBNull(getData.Rows(0)("ProductBarCode")) Then
                            ProductBarCode.Text = getData.Rows(0)("ProductBarCode")
                        End If
					
                        If Not IsDBNull(getData.Rows(0)("Criticaltime")) Then
                            CriticalTime.Text = getData.Rows(0)("Criticaltime")
                        End If
                        If Not IsDBNull(getData.Rows(0)("WarningTime")) Then
                            WarningTime.Text = getData.Rows(0)("WarningTime")
                        End If
					
                        If ShowWeekly.Visible = True Then
                            If Not IsDBNull(getData.Rows(0)("ProductEnableDayString")) Then
                                If Trim(getData.Rows(0)("ProductEnableDayString")) <> "" Then
                                    WeeklyStringFromDB = getData.Rows(0)("ProductEnableDayString")
                                End If
                            End If
                        End If
					
                        If getData.Rows(0)("RequireAddAmountForProduct") = 0 Then
                            Radio_02.Checked = True
                        Else
                            Radio_01.Checked = True
                        End If
					
					
                        If ShowName2.Visible = True Then
                            If Not IsDBNull(getData.Rows(0)("ProductName1")) Then
                                ProductNameExtra.Text = getData.Rows(0)("ProductName1")
                            End If
                        End If
					
                        If ShowPocketName.Visible = True Then
                            If Not IsDBNull(getData.Rows(0)("ProductPocketName")) Then
                                ProductPocketName.Text = getData.Rows(0)("ProductPocketName")
                            End If
                        End If
					
                        ProductName.Text = getData.Rows(0)("ProductName")
                        ProductCode.Text = getData.Rows(0)("ProductCode")
                        IDValueFromDB = getData.Rows(0)("ProductLevelID")
                        GroupIDValueFromDB = getData.Rows(0)("ProductGroupID")
                        DeptIDValueFromDB = getData.Rows(0)("ProductDeptID")
                        ProductSetValueFromDB = getData.Rows(0)("ProductSet")
                        If getData.Rows(0)("DiscountAllow") = True Or getData.Rows(0)("DiscountAllow") = 1 Then
                            optDiscountAllow.Checked = True
                        Else
                            optNotDiscountAllow.Checked = True
                        End If
                        If getData.Rows(0)("ZeroPriceAllow") = True Or getData.Rows(0)("ZeroPriceAllow") = 1 Then
                            optZeroPriceAllow.Checked = True
                        Else
                            optNotZeroPriceAllow.Checked = True
                        End If
                        If getData.Rows(0)("ProductActivate") = True Or getData.Rows(0)("ProductActivate") = 1 Then
                            Radio5.Checked = True
                        Else
                            Radio6.Checked = True
                        End If

                        If getData.Rows(0)("PrintGroup") = True Or getData.Rows(0)("PrintGroup") = 1 Then
                            Radio10.Checked = True
                        Else
                            Radio11.Checked = True
                        End If
					
                        If getData.Rows(0)("PrintFlexibleProductFromItsOwnPrinter") = True Or getData.Rows(0)("PrintFlexibleProductFromItsOwnPrinter") = 1 Then
                            Radio100.Checked = True
                        Else
                            Radio101.Checked = True
                        End If
					
                        If getData.Rows(0)("VATType") = 0 Then
                            optNoVAT.Checked = True
                        ElseIf getData.Rows(0)("VATType") = 2 Then
                            optExcludeVAT.Checked = True
                        Else
                            optIncludeVAT.Checked = True
                        End If
					
                        If getData.Rows(0)("HasServiceCharge") = True Or getData.Rows(0)("HasServiceCharge") = 1 Then
                            Radio17.Checked = True
                        Else
                            Radio18.Checked = True
                        End If
					
                        If getData.Rows(0)("TakeAway") = 1 Then
                            Radio19.Checked = True
                        Else
                            Radio20.Checked = True
                        End If
					
                        If getData.Rows(0)("FlexibleProductIncludePrice") = True Or getData.Rows(0)("FlexibleProductIncludePrice") = 1 Then
                            Radio21.Checked = True
                        Else
                            Radio22.Checked = True
                        End If
					
                        If getData.Rows(0)("CanReturnProduct") = True Or getData.Rows(0)("CanReturnProduct") = 1 Then
                            Radio23.Checked = True
                        Else
                            Radio24.Checked = True
                        End If
					
                        If getData.Rows(0)("SaleMode1") = True Or getData.Rows(0)("SaleMode1") = 1 Then
                            Radio25.Checked = True
                        Else
                            Radio26.Checked = True
                        End If
					
                        If getData.Rows(0)("SaleMode2") = True Or getData.Rows(0)("SaleMode2") = 1 Then
                            Radio27.Checked = True
                        Else
                            Radio28.Checked = True
                        End If
					
                        If getData.Rows(0)("SaleMode3") = True Or getData.Rows(0)("SaleMode3") = 1 Then
                            Radio29.Checked = True
                        Else
                            Radio30.Checked = True
                        End If
					
                        If getData.Rows(0)("SaleMode4") = True Or getData.Rows(0)("SaleMode4") = 1 Then
                            Radio31.Checked = True
                        Else
                            Radio32.Checked = True
                        End If
					
                        If getData.Rows(0)("SaleMode5") = True Or getData.Rows(0)("SaleMode5") = 1 Then
                            Radio33.Checked = True
                        Else
                            Radio34.Checked = True
                        End If
					
                        ProductOrdering.Text = getData.Rows(0)("ProductOrdering")
                        PrintOrdering.Text = getData.Rows(0)("PrintOrdering")
					
                        ProductCode_Old.Value = getData.Rows(0)("ProductCode")
					
                        updateMessage.Text = textTable.Rows(58)("TextParamValue") + """" + getData.Rows(0)("ProductName") + """"
                        SubmitForm.Text = textTable.Rows(9)("TextParamValue")
					
                        If Not IsDBNull(getData.Rows(0)("ProductPictureServer")) Then
                            If Trim(getData.Rows(0)("ProductPictureServer")) <> "" Then
                                ViewCurrentPicture.InnerHtml = "<a href=""JavaScript: newWindow = window.open('../images/Products/" + getData.Rows(0)("ProductPictureServer") + "', '', 'width=400,height=400,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + defaultTextTable.Rows(12)("TextParamValue") + "</a>"
                                RemoveImage.Visible = True
                            End If
                        Else
                            RemoveImage.Visible = False
                        End If
					
                        If mPOS = True Then
                            Exist = getProp.CheckTableExist("menuitem", objCnn)
                            If Exist = True Then
                                Dim getmMenu As DataTable = objDB.List("select * from menuitem where ProductID=" + getData.Rows(0)("ProductID").ToString, objCnn)
                                Radio1000.Checked = True
                                If getmMenu.Rows.Count > 0 Then

                                    If getmMenu.Rows(0)("Activate") = 0 Then
                                        Radio1111.Checked = 1
                                    End If
					
                                    If Not IsDBNull(getmMenu.Rows(0)("MenuDesc_0")) Then
                                        ProductShortDesp.Text = getmMenu.Rows(0)("MenuDesc_0")
                                    Else
                                        ProductShortDesp.Text = ""
                                    End If
                                    If Not IsDBNull(getmMenu.Rows(0)("MenuShortName_0")) Then
                                        MenuShortName.Text = getmMenu.Rows(0)("MenuShortName_0")
                                    Else
                                        MenuShortName.Text = ""
                                    End If
                                    If Trim(ProductDesp.Text) = "" And Not IsDBNull(getmMenu.Rows(0)("MenuLongDesc_0")) Then
                                        If Trim(getmMenu.Rows(0)("MenuLongDesc_0")) <> "" Then
                                            ProductDesp.Text = getmMenu.Rows(0)("MenuLongDesc_0")
                                        End If
                                    End If
								
                                    If Not IsDBNull(getmMenu.Rows(0)("MenuImageLink")) Then
                                        If Trim(getmMenu.Rows(0)("MenuImageLink")) <> "" Then
                                            ViewCurrentPicture_iPad.InnerHtml = "<a href=""JavaScript: newWindow = window.open('../Resources/Shop/MenuImage/" + getmMenu.Rows(0)("MenuImageLink") + "', '', 'width=750,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "View Image" + "</a>"
                                            RemoveImage_iPad.Visible = True
                                        End If
                                    Else
                                        RemoveImage_iPad.Visible = False
                                    End If
                                    If Not IsDBNull(getmMenu.Rows(0)("MenuImageLink")) Then
                                        MenuImage_iPad.Value = getmMenu.Rows(0)("MenuImageLink")
                                    Else
                                        MenuImage_iPad.Value = "NULL"
                                    End If
                                End If
                            End If
                        End If
					
                        If getData.Rows(0)("ProductSet") = 3 Or getData.Rows(0)("ProductSet") = 12 Or getData.Rows(0)("ProductSet") = 9 Then DurationTime.Text = getData.Rows(0)("DurationTime").ToString
					
                        Dim SpaStaff As DataTable = getInfo.SpaProductStaffNumber(getData.Rows(0)("ProductID"), objCnn)
                        Select Case SpaStaff.Rows.Count
                            Case 0
                            Case 1
                                Staff1DurationTime.Text = SpaStaff.Rows(0)("DurationTime").ToString
                            Case 2
                                Staff1DurationTime.Text = SpaStaff.Rows(0)("DurationTime").ToString
                                Staff2DurationTime.Text = SpaStaff.Rows(1)("DurationTime").ToString
                            Case 3
                                Staff1DurationTime.Text = SpaStaff.Rows(0)("DurationTime").ToString
                                Staff2DurationTime.Text = SpaStaff.Rows(1)("DurationTime").ToString
                                Staff3DurationTime.Text = SpaStaff.Rows(2)("DurationTime").ToString
                            Case Else
                                Staff1DurationTime.Text = SpaStaff.Rows(0)("DurationTime").ToString
                                Staff2DurationTime.Text = SpaStaff.Rows(1)("DurationTime").ToString
                                Staff3DurationTime.Text = SpaStaff.Rows(2)("DurationTime").ToString
                        End Select
					
                        If IsDate(getData.Rows(0)("ProductEnableDateTime")) Then
                            If getData.Rows(0)("ProductEnableDateTime").Year > 2000 Then
                                ProductEnableDateTime.SelectedDay = getData.Rows(0)("ProductEnableDateTime").Day
                                ProductEnableDateTime.SelectedMonth = getData.Rows(0)("ProductEnableDateTime").Month
                                ProductEnableDateTime.SelectedYear = getData.Rows(0)("ProductEnableDateTime").Year
                                If ProductEnableDateTime.SelectedYear < CurrentYear Then
                                    ProductEnableDateTime.StartYear = CurrentYear - ProductEnableDateTime.SelectedYear
                                End If
                            End If
                        End If
					
                        If IsDate(getData.Rows(0)("ProductExpireDateTime")) Then
                            If getData.Rows(0)("ProductExpireDateTime").Year < 9999 Then
                                ProductExpireDateTime.SelectedDay = getData.Rows(0)("ProductExpireDateTime").Day
                                ProductExpireDateTime.SelectedMonth = getData.Rows(0)("ProductExpireDateTime").Month
                                ProductExpireDateTime.SelectedYear = getData.Rows(0)("ProductExpireDateTime").Year
                                If ProductExpireDateTime.SelectedYear < CurrentYear Then
                                    ProductExpireDateTime.StartYear = CurrentYear - ProductExpireDateTime.SelectedYear
                                End If
                            End If
                        End If
					
                        If IsDate(getData.Rows(0)("ProductEnableDateTime")) Then
                            If getData.Rows(0)("ProductEnableDateTime").Hour = 0 And getData.Rows(0)("ProductEnableDateTime").Minute = 0 Then
						
                            Else
                                FromTime.SelectedHour = getData.Rows(0)("ProductEnableDateTime").Hour
                                FromTime.SelectedMinute = getData.Rows(0)("ProductEnableDateTime").Minute
                            End If
                        End If
                        If IsDate(getData.Rows(0)("ProductExpireDateTime")) Then
                            If getData.Rows(0)("ProductExpireDateTime").Hour = 0 And getData.Rows(0)("ProductExpireDateTime").Minute = 0 Then
						
                            Else
                                ToTime.SelectedHour = getData.Rows(0)("ProductExpireDateTime").Hour
                                ToTime.SelectedMinute = getData.Rows(0)("ProductExpireDateTime").Minute
                            End If
                        End If
					
                    End If
				
                End If
			
            Else
			
                updateMessage.Text = textTable.Rows(44)("TextParamValue")
                SubmitForm.Text = textTable.Rows(8)("TextParamValue")
                If Not Page.IsPostBack Then
                    optDiscountAllow.Checked = True
                    optZeroPriceAllow.Checked = True
                    Radio5.Checked = True
                    Radio11.Checked = True
                    If VATTypeVal = 2 Then
                        optExcludeVAT.Checked = True
                    Else
                        optIncludeVAT.Checked = True
                    End If
                    Radio16.Checked = True
                    If HasServiceChargeValue = True Then
                        Radio17.Checked = True
                    Else
                        Radio18.Checked = True
                    End If
                    Radio20.Checked = True
                    Radio22.Checked = True
                    Radio25.Checked = True
                    Dim SaleMode2 As DataTable = objDB.List("select * from SaleModeProductLevelProperty where SaleMode=2 AND ProductlevelID=" + Request.QueryString("ProductLevelID").ToString, objCnn)
                    If SaleMode2.Rows.Count > 0 Then
                        Radio27.Checked = True
                    Else
                        Radio28.Checked = True
                    End If
                    Dim SaleMode3 As DataTable = objDB.List("select * from SaleModeProductLevelProperty where SaleMode=3 AND ProductlevelID=" + Request.QueryString("ProductLevelID").ToString, objCnn)
                    If SaleMode3.Rows.Count > 0 Then
                        Radio29.Checked = True
                    Else
                        Radio30.Checked = True
                    End If
				
                    Dim SaleMode4 As DataTable = objDB.List("select * from SaleModeProductLevelProperty where SaleMode=4 AND ProductlevelID=" + Request.QueryString("ProductLevelID").ToString, objCnn)
                    If SaleMode4.Rows.Count > 0 Then
                        Radio31.Checked = True
                    Else
                        Radio32.Checked = True
                    End If
				
                    Dim SaleMode5 As DataTable = objDB.List("select * from SaleModeProductLevelProperty where SaleMode=5 AND ProductlevelID=" + Request.QueryString("ProductLevelID").ToString, objCnn)
                    If SaleMode5.Rows.Count > 0 Then
                        Radio33.Checked = True
                    Else
                        Radio34.Checked = True
                    End If
				
                    Radio100.Checked = True
                    Radio111.Checked = True
                    Radio112.Checked = True
                    Radio1000.Checked = True
                    ProductCodeBuffet.Text = ""
                    ProductBuffetTime.Text = ""
                    Radio_02.Checked = True
                    Radio24.Checked = True
                End If
			
                ProductID.Value = 0
                ProductCode_Old.Value = ""
                ProductOrdering.Text = "0"
                PrintOrdering.Text = "0"
                Dim promoData As New DataTable()
                promoData = getPromo.GetPromotionInfo(-1, -1, "", objCnn)
                If promoData.Rows.Count > 0 Then
                    showPromo.Visible = True
                End If
            End If
		
            Dim FormSelected As String
		
            Dim PrinterIDValue As String = ""
            If IsNumeric(Request.Form("PrinterID")) Then
                PrinterIDValue = Request.Form("PrinterID")
            ElseIf IsNumeric(Request.QueryString("PrinterID")) Then
                PrinterIDValue = Request.QueryString("PrinterID")
            ElseIf IsNumeric(PrinterIDValueFromDB) Then
                PrinterIDValue = PrinterIDValueFromDB
            End If
		
            PrinterIDValue = "," + PrinterIDValue + ","
            Dim CompareString As String
            Dim PrinterString As String = ""
            Dim AllPrinters As DataTable
            AllPrinters = getConfig.GetPrinters(-1, objCnn)
            If AllPrinters.Rows.Count > 0 Then
                showPrinter.Visible = True
                For i = 0 To AllPrinters.Rows.Count - 1
                    If AllPrinters.Rows(i)("PrinterID") >= 0 Then
                        CompareString = "," + AllPrinters.Rows(i)("PrinterID").ToString + ","
                        If PrinterIDValue.IndexOf(CompareString) = -1 Then
                            FormSelected = ""
                        Else
                            FormSelected = "checked"
                        End If
                        PrinterString += "<input type=""checkbox"" name=""PrinterID"" value=""" + AllPrinters.Rows(i)("PrinterID").ToString + """ " + FormSelected + ">" + AllPrinters.Rows(i)("PrinterName") + "&nbsp;&nbsp;"
                    End If
                Next
                PrinterSelectionText.InnerHtml = PrinterString
            Else
                showPrinter.Visible = False
            End If
		
            If IsNumeric(Request.Form("FromTime_Hour")) Then
                FromTime.SelectedHour = Request.Form("FromTime_Hour")
            End If
            If IsNumeric(Request.Form("FromTime_Minute")) Then
                FromTime.SelectedMinute = Request.Form("FromTime_Minute")
            End If
            If IsNumeric(Request.Form("ToTime_Hour")) Then
                ToTime.SelectedHour = Request.Form("ToTime_Hour")
            End If
            If IsNumeric(Request.Form("ToTime_Minute")) Then
                ToTime.SelectedMinute = Request.Form("ToTime_Minute")
            End If
		
            If IsNumeric(Request.Form("ProductEnableDateTime_Day")) Then
                ProductEnableDateTime.SelectedDay = Request.Form("ProductEnableDateTime_Day")
            End If
            If IsNumeric(Request.Form("ProductEnableDateTime_Month")) Then
                ProductEnableDateTime.SelectedMonth = Request.Form("ProductEnableDateTime_Month")
            End If
            If IsNumeric(Request.Form("ProductEnableDateTime_Year")) Then
                ProductEnableDateTime.SelectedYear = Request.Form("ProductEnableDateTime_Year")
            End If
		
            If IsNumeric(Request.Form("ProductExpireDateTime_Day")) Then
                ProductExpireDateTime.SelectedDay = Request.Form("ProductExpireDateTime_Day")
            End If
            If IsNumeric(Request.Form("ProductExpireDateTime_Month")) Then
                ProductExpireDateTime.SelectedMonth = Request.Form("ProductExpireDateTime_Month")
            End If
            If IsNumeric(Request.Form("ProductExpireDateTime_Year")) Then
                ProductExpireDateTime.SelectedYear = Request.Form("ProductExpireDateTime_Year")
            End If
		
            Dim WeeklyString As String = "<tr>"
		
            Dim CompareStringList, Checked As String
		
            CompareStringList = ""
            If Trim(Request.Form("SelWeekly")) <> "" Then
                CompareStringList = "," + Trim(Request.Form("SelWeekly")) + ","
            ElseIf Trim(WeeklyStringFromDB) <> "" Then
                CompareStringList = WeeklyStringFromDB
            End If

            For i = 54 To 60
                j = i - 53
                CompareString = "," + j.ToString + ","
                Checked = ""
                If CompareStringList.IndexOf(CompareString) <> -1 Then
                    Checked = "checked"
                End If
                WeeklyString += "<td class=""text""><input type=""checkbox"" name=""SelWeekly"" value=""" + j.ToString + """ " + Checked + ">" + defaultTextTable.Rows(i)("TextParamValue") + "&nbsp;&nbsp;</td>"
            Next
            WeeklyString += "</tr>"
            WeeklyOptionString.InnerHtml = WeeklyString
		
            Dim ProductSetValue As Integer = 0
            If IsNumeric(Request.Form("ProductSet")) Then
                ProductSetValue = Request.Form("ProductSet")
            ElseIf IsNumeric(Request.QueryString("ProductSet")) Then
                ProductSetValue = Request.QueryString("ProductSet")
            ElseIf IsNumeric(ProductSetValueFromDB) Then
                ProductSetValue = ProductSetValueFromDB
            End If
		
            Dim IDValue As Integer = 0
            If IsNumeric(Request.Form("ProductLevelID")) Then
                IDValue = Request.Form("ProductLevelID")
            ElseIf IsNumeric(Request.QueryString("ProductLevelID")) Then
                IDValue = Request.QueryString("ProductLevelID")
            ElseIf IsNumeric(IDValueFromDB) Then
                IDValue = IDValueFromDB
            End If
		
            Dim GroupIDValue As Integer = 0
            If IsNumeric(Request.Form("ProductGroupID")) Then
                GroupIDValue = Request.Form("ProductGroupID")
            ElseIf IsNumeric(Request.QueryString("ProductGroupID")) Then
                GroupIDValue = Request.QueryString("ProductGroupID")
            ElseIf IsNumeric(GroupIDValueFromDB) Then
                GroupIDValue = GroupIDValueFromDB
            End If
		
            Dim DeptIDValue As Integer = 0
            If IsNumeric(Request.Form("ProductDeptID")) Then
                DeptIDValue = Request.Form("ProductDeptID")
            ElseIf IsNumeric(Request.QueryString("ProductDeptID")) Then
                DeptIDValue = Request.QueryString("ProductDeptID")
            ElseIf IsNumeric(DeptIDValueFromDB) Then
                DeptIDValue = DeptIDValueFromDB
            End If
		
		
            Dim levelTable As New DataTable()
            levelTable = getInfo.GetProductLevel(0, objCnn)
		
            Dim groupTable As New DataTable()
            groupTable = getInfo.GetProductGroup(IDValue, 0, objCnn)

            Dim deptTable As New DataTable()
            deptTable = getInfo.GetProductDept(GroupIDValue, 0, objCnn)
		
            Dim chkGroupTable As New DataTable()
            chkGroupTable = getInfo.GetProductGroup(0, GroupIDValue, objCnn)
            Dim IsComment As Integer = chkGroupTable.Rows(0)("IsComment")
            IsCommentVal.Value = IsComment
		
            showCommentAmount.Visible = False
            Dim DisableText As String = ""
            If IsComment > 0 Then
                DisableText = " disabled"
                showUploadPicture_iPad.Visible = False
                showProductShortDesp.Visible = False
                showShortName.Visible = False
                showCommentAmount.Visible = True
            Else
                AddAmountParam.InnerHtml = "Select items based on qty (for producttype=7)"
                If ProductSetValue = 7 Then
                    showCommentAmount.Visible = True
                End If
            End If
		
            If IsComment > 0 Then
                levelRow.Visible = False
                showGroup.Visible = False
                showBarCode.Visible = False
                If IsComment = 1 Then
                    showPrinter.Visible = False
                End If
                showUploadPicture.Visible = False
                showProductDesp.Visible = False
			
			
                showTakeAway.Visible = False
                ShowServiceCharge.Visible = False
                'showVAT.Visible = False
                showPromo.Visible = False
                If IsComment <> 1 Then
                    showPrice.Visible = False
                    showDiscount.Visible = False
                    showZeroAllow.Visible = False
                Else
                    If Not Page.IsPostBack Then
                        If ProductSetValue = 14 Or ProductSetValue = 0 Then
                            showPrice.Visible = False
                        Else
                            showPrice.Visible = True
                            ShowServiceCharge.Visible = True
                        End If
                    ElseIf Request.Form("ProductSet") = 15 Then
                        showPrice.Visible = True
                        ShowServiceCharge.Visible = True
                    Else
                        showPrice.Visible = False
                    End If
                End If
            End If
		
            If PropertyInfo.Rows(0)("SystemEditionID") = 1 And PropertyInfo.Rows(0)("SystemTypeID") = 2 Then
                showPrinter.Visible = False
            End If
		
            Dim shopInfo As New DataTable()
            shopInfo = getInfo.GetProductLevel(IDValue, objCnn)
            Dim ProductType As DataTable = getInfo.ProductTypeData(shopInfo.Rows(0)("ShopType"), Session("LangID"), IsComment, objCnn)

            Dim ProductSetText As String = ""
		
            Dim ChkProp As DataTable = getProp.PropertyValue(1, 53, 1, objCnn)
            Dim UpSizeProduct As Boolean = False
            If ChkProp.Rows.Count > 0 Then
                If ChkProp.Rows(0)("PropertyValue") = 1 Then
                    UpSizeProduct = True
                End If
            End If
		
            Dim PackageProduct As DataTable = objDB.List("select * from programpropertyvalue where propertyid=83 and ProgramTypeID=1 AND KeyID=" + IDValue.ToString, objCnn)
            Dim ProductPackageType As Integer = 0
            If PackageProduct.Rows.Count > 0 Then
                If PackageProduct.Rows(0)("PropertyValue") = 1 Then
                    ProductPackageType = 4
                End If
            End If
            Dim PackageData As DataTable = objDB.List("select * from ProductType a, ProductTypeName b where a.ProductTypeID=b.ProductTypeID AND LangID=" + Session("LangID").ToString + " AND a.ProductTypeID=" + ProductPackageType.ToString, objCnn)

            Dim ExistPackage As Boolean = False
		
            If ProductID.Value <> 0 Then
                For i = 0 To ProductType.Rows.Count - 1
                    If ProductType.Rows(i)("ProductTypeID") = ProductSetValue Then
                        ProductSetSelection.InnerHtml = ProductType.Rows(i)("ProductTypeName") + "<input type=""hidden"" name=""ProductSet"" value=""" + ProductSetValue.ToString + """>"
                    End If
                Next
            Else
                ProductSetText += "<select name=""ProductSet"" style=""width:200px;"" onchange=""javascript: submit();"">"
                For i = 0 To ProductType.Rows.Count - 1
                    If ProductType.Rows(i)("ProductTypeID") <> 19 Or (ProductType.Rows(i)("ProductTypeID") = 19 And UpSizeProduct = True) Then
                        If PropertyInfo.Rows(0)("SystemEditionID") > 1 Or (PropertyInfo.Rows(0)("SystemEditionID") = 1 And ProductType.Rows(i)("ProductTypeID") <> 6 And ProductType.Rows(i)("ProductTypeID") <> 7) Then
                            If ProductType.Rows(i)("ProductTypeID") = ProductSetValue Then
                                FormSelected = "selected"
                            Else
                                FormSelected = ""
                            End If
                            ProductSetText += "<option value=""" & ProductType.Rows(i)("ProductTypeID") & """ " & FormSelected & ">" & ProductType.Rows(i)("ProductTypeName")
                        End If
                    End If
				
                    If ProductType.Rows(i)("ProductTypeID") = 4 Then
                        ExistPackage = True
                    End If
                Next
                If ExistPackage = False And PackageData.Rows.Count > 0 And ProductPackageType = 4 Then
                    For i = 0 To PackageData.Rows.Count - 1
                        If PackageData.Rows(i)("ProductTypeID") = ProductSetValue Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        ProductSetText += "<option value=""" & PackageData.Rows(i)("ProductTypeID") & """ " & FormSelected & ">" & PackageData.Rows(i)("ProductTypeName")
                    Next
                End If
                ProductSetText += "</select>"
                ProductSetSelection.InnerHtml = ProductSetText
            End If
		
            If ProductSetValue = 10 Or ProductSetValue = 11 Then
                ShowPrepaid.Visible = True
            Else
                ShowPrepaid.Visible = False
            End If
            If ProductSetValue = 3 Or ProductSetValue = 12 Or ProductSetValue = 9 Then
                showDuration.Visible = True
                If ProductSetValue = 12 Then
                    ShowMultiDuration.Visible = True
                    ShowStaffDuration.Visible = True
                ElseIf ProductSetValue = 3 Then
                    ShowMultiDuration.Visible = False
                    ShowStaffDuration.Visible = True
                Else
                    ShowMultiDuration.Visible = False
                    ShowStaffDuration.Visible = False
                End If
            Else
                showDuration.Visible = False
                ShowMultiDuration.Visible = False
            End If
            If ProductSetValue = 6 Then
                ShowAddAmount.Visible = True
            Else
                ShowAddAmount.Visible = False
            End If
            If ProductSetValue = 6 Or ProductSetValue = 7 Then
                ShowPrintOption.Visible = True
            Else
                ShowPrintOption.Visible = False
            End If
		

            Dim ProductLevelString As String = ""
            Dim ProductGroupString As String = ""
            Dim ProductDeptString As String = ""
		
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
            levelRow.Visible = False

            For i = 0 To groupTable.Rows.Count - 1
                If groupTable.Rows(i)("ProductGroupTakeAway") = 0 Then
                    If GroupIDValue = groupTable.Rows(i)("ProductGroupID") Then
                        FormSelected = "selected"
                    Else
                        FormSelected = ""
                    End If
                    ProductGroupString += "<option value=""" & groupTable.Rows(i)("ProductGroupID") & """ " & FormSelected & ">" & groupTable.Rows(i)("ProductGroupName")
                End If
            Next

            For i = 0 To deptTable.Rows.Count - 1
                If deptTable.Rows(i)("ProductDeptTakeAway") = 0 Then
                    If GroupIDValue = deptTable.Rows(i)("ProductGroupID") Then
                        If DeptIDValue = deptTable.Rows(i)("ProductDeptID") Then
                            FormSelected = "selected"
                        Else
                            FormSelected = ""
                        End If
                        ProductDeptString += "<option value=""" & deptTable.Rows(i)("ProductDeptID") & """ " & FormSelected & ">" & deptTable.Rows(i)("ProductDeptName")
                    End If
                End If
            Next

		
            If levelRow.Visible = True Then
                If IDValue = 0 Then
                    FormSelected = "selected"
                Else
                    FormSelected = ""
                End If
                LevelSelectionText.InnerHtml = "<select name=""ProductLevelID"" onchange=""submit()""" + DisableText + "><option value=""0""" + FormSelected + ">" + textTable.Rows(18)("TextParamValue") + ProductLevelString + "</select>"
            Else
                MLevelText.InnerHtml = "<input type=""hidden"" name=""ProductLevelID"" value=""" + Request.QueryString("ProductLevelID").ToString + """>"
            End If
		
            If GroupIDValue = 0 Then
                FormSelected = "selected"
            Else
                FormSelected = ""
            End If
            GroupSelectionText.InnerHtml = "<select name=""ProductGroupID"" style=""width:200px;"" onchange=""submit()""" + DisableText + "><option value=""0""" + FormSelected + ">" + textTable.Rows(31)("TextParamValue") + ProductGroupString + "</select>"
		
            If DeptIDValue = 0 Then
                FormSelected = "selected"
            Else
                FormSelected = ""
            End If
            DeptSelectionText.InnerHtml = "<select name=""ProductDeptID"" style=""width:200px;"" onchange=""submit()""><option value=""0""" + FormSelected + ">" + textTable.Rows(43)("TextParamValue") + ProductDeptString + "</select>"
		
		
		
		
            If Page.IsPostBack Then
                validateLevel.InnerHtml = ""
                validateGroup.InnerHtml = ""
                validateDept.InnerHtml = ""
                If levelRow.Visible = True Then
                    If Not IsNumeric(Request.Form("ProductLevelID")) Or Request.Form("ProductLevelID") = 0 Then
                        validateLevel.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(37)("TextParamValue") & "</td></tr>"
                    End If
                End If
                If showGroup.Visible = True Then
                    If Not IsNumeric(Request.Form("ProductGroupID")) Or Request.Form("ProductGroupID") = 0 Then
                        validateGroup.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(38)("TextParamValue") & "</td></tr>"
                    End If
                End If
                If Not IsNumeric(Request.Form("ProductDeptID")) Or Request.Form("ProductDeptID") = 0 Then
                    validateDept.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(49)("TextParamValue") & "</td></tr>"
                End If
            End If
		
            showPromo.Visible = False
		
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
        Dim textTable1 As New DataTable()
        textTable1 = getPageText.GetText(8, Session("LangID"), objCnn)
        Dim defaultTextTable As New DataTable()
        Dim strSQL As String

        defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
        validateCode.InnerHtml = ""
        validateName.InnerHtml = ""
        validateLevel.InnerHtml = ""
        validateGroup.InnerHtml = ""
        validateDept.InnerHtml = ""
        validateDuration.InnerHtml = ""
        validateDurationStaff1.InnerHtml = ""
        validateDurationStaff2.InnerHtml = ""
        validateDurationStaff3.InnerHtml = ""
        validatePrice.InnerHtml = ""
        validatePrice2.InnerHtml = ""
        validatePrice3.InnerHtml = ""
        validatePrice4.InnerHtml = ""
        validatePrice5.InnerHtml = ""
        validatePriceSM2.InnerHtml = ""
        validatePriceSM3.InnerHtml = ""
        validatePriceSM4.InnerHtml = ""
        validatePriceSM5.InnerHtml = ""
        Dim ModifyPackageDetail As Boolean = False
        Dim ModifyPackageHistory As Boolean = False
	
        Dim ChkmPOS As DataTable = getProp.PropertyValue(2, 10, Request.QueryString("ProductLevelID"), objCnn)
        Dim mPOS As Boolean = False
        If ChkmPOS.Rows.Count > 0 Then
            If ChkmPOS.Rows(0)("PropertyValue") = 1 Then
                mPOS = True
            End If
        End If
	
        If (Not IsNumeric(Request.Form("ProductLevelID")) Or Request.Form("ProductLevelID") = 0) And levelRow.Visible = True Then
            validateLevel.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(37)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If showGroup.Visible = True Then
            If Not IsNumeric(Request.Form("ProductGroupID")) Or Request.Form("ProductGroupID") = 0 Then
                validateGroup.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(38)("TextParamValue") & "</td></tr>"
                FoundError = True
            End If
        End If
        If Not IsNumeric(Request.Form("ProductDeptID")) Or Request.Form("ProductDeptID") = 0 Then
            validateDept.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable.Rows(49)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
	
        If Trim(ProductMainPrice.Text) <> "" Then
            If Not IsNumeric(ProductMainPrice.Text) Then
                validatePrice.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable1.Rows(24)("TextParamValue") & "</td></tr>"
                FoundError = True
            End If
        End If
	
        If SM2.Visible = True Then
            If Trim(ProductPriceSM2.Text) <> "" Then
                If Not IsNumeric(ProductPriceSM2.Text) Then
                    validatePriceSM2.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable1.Rows(24)("TextParamValue") & "</td></tr>"
                    FoundError = True
                End If
            End If
        End If
	
        If SM3.Visible = True Then
            If Trim(ProductPriceSM3.Text) <> "" Then
                If Not IsNumeric(ProductPriceSM3.Text) Then
                    validatePriceSM3.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable1.Rows(24)("TextParamValue") & "</td></tr>"
                    FoundError = True
                End If
            End If
        End If
	
        If SM4.Visible = True Then
            If Trim(ProductPriceSM4.Text) <> "" Then
                If Not IsNumeric(ProductPriceSM4.Text) Then
                    validatePriceSM4.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable1.Rows(24)("TextParamValue") & "</td></tr>"
                    FoundError = True
                End If
            End If
        End If
	
        If SM5.Visible = True Then
            If Trim(ProductPriceSM5.Text) <> "" Then
                If Not IsNumeric(ProductPriceSM5.Text) Then
                    validatePriceSM5.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable1.Rows(24)("TextParamValue") & "</td></tr>"
                    FoundError = True
                End If
            End If
        End If
	
        If ShowMultiplePrice.Visible = True Then
            If Trim(ProductPrice2.Text) <> "" Then
                If Not IsNumeric(ProductPrice2.Text) Then
                    validatePrice2.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable1.Rows(24)("TextParamValue") & "</td></tr>"
                    FoundError = True
                End If
            End If
            If Trim(ProductPrice3.Text) <> "" Then
                If Not IsNumeric(ProductPrice3.Text) Then
                    validatePrice3.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable1.Rows(24)("TextParamValue") & "</td></tr>"
                    FoundError = True
                End If
            End If
            If Trim(ProductPrice4.Text) <> "" Then
                If Not IsNumeric(ProductPrice4.Text) Then
                    validatePrice4.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable1.Rows(24)("TextParamValue") & "</td></tr>"
                    FoundError = True
                End If
            End If
            If Trim(ProductPrice5.Text) <> "" Then
                If Not IsNumeric(ProductPrice5.Text) Then
                    validatePrice5.InnerHtml = "<tr><td></td><td class=""errorText"">" & textTable1.Rows(24)("TextParamValue") & "</td></tr>"
                    FoundError = True
                End If
            End If
        End If
	
        If ShowPrepaid.Visible = True Then
            If Trim(PrepaidPrice.Text) <> "" Then
                If Not IsNumeric(PrepaidPrice.Text) Then
                    validatePrepaid.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(101)("TextParamValue") & "</td></tr>"
                    FoundError = True
                ElseIf PrepaidPrice.Text < 0 Then
                    validatePrepaid.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(101)("TextParamValue") & "</td></tr>"
                    FoundError = True
                End If
            End If
        End If
	
        If showDuration.Visible = True Then
            If Not IsNumeric(DurationTime.Text) Then
                validateDuration.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(101)("TextParamValue") & "</td></tr>"
                FoundError = True
            ElseIf DurationTime.Text < 0 Then
                validateDuration.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(101)("TextParamValue") & "</td></tr>"
                FoundError = True
            End If
		
            If ShowStaffDuration.Visible = True Then
                If Not IsNumeric(Staff1DurationTime.Text) Then
                    validateDurationStaff1.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(101)("TextParamValue") & "</td></tr>"
                    FoundError = True
                ElseIf Staff1DurationTime.Text < 0 Then
                    validateDurationStaff1.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(101)("TextParamValue") & "</td></tr>"
                    FoundError = True
                End If
            End If
		
        End If
	
        If ShowAddAmount.Visible = True Then
            'If Not IsNumeric(RequireAddAmountForProduct.Text) Then
            '	validateAddAmount.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(101)("TextParamValue") & "</td></tr>"
            '	FoundError = True
            'ElseIf RequireAddAmountForProduct.Text < -1 Then
            '	validateAddAmount.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(101)("TextParamValue") & "</td></tr>"
            '	FoundError = True
            'End If
        End If
	
        If Not IsNumeric(ProductOrdering.Text) Then
            validateOrdering.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(101)("TextParamValue") & "</td></tr>"
            FoundError = True
        ElseIf ProductOrdering.Text < 0 Then
            validateOrdering.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(101)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
	
        If Not IsNumeric(PrintOrdering.Text) Then
            validatePrintOrdering.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(101)("TextParamValue") & "</td></tr>"
            FoundError = True
        ElseIf PrintOrdering.Text < 0 Then
            validatePrintOrdering.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(101)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If

        If Len(Trim(ProductName.Text)) = 0 Then
            validateName.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(55)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If Len(Trim(ProductCode.Text)) = 0 Then
            validateCode.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(54)("TextParamValue") & "</td></tr>"
            FoundError = True
        ElseIf ProductCode_Old.Value = "" Or (Trim(ProductCode_Old.Value) <> Trim(ProductCode.Text)) Then
            Dim ChkExist, ChkPackage As Boolean
            ChkExist = getInfo.CheckModifyProduct(1, 0, Trim(ProductCode.Text), Request.Form("ProductLevelID"), objCnn)
            If ChkExist = False Then
                validateCode.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(63)("TextParamValue") & "</td></tr>"
                FoundError = True
            ElseIf ProductID.Value > 0 And Request.QueryString("SaveAs") <> "yes" Then
			
                If Request.Form("ProductSet") = 4 Then
                    ChkPackage = getInfo.CheckModifyProduct(3, 0, Trim(ProductCode_Old.Value), Request.Form("ProductLevelID"), objCnn)
                    If ChkPackage = False Then
                        ModifyPackageDetail = True
                    End If
                Else
                    ChkPackage = getInfo.CheckModifyProduct(2, 0, Trim(ProductCode_Old.Value), Request.Form("ProductLevelID"), objCnn)
                    If ChkPackage = False Then
                        ModifyPackageHistory = True
                    End If
                End If

            End If
        End If
	
        If showUploadPicture.Visible = True Then
            Dim FileTransfer As Boolean = True
            Try
                If ProductPicture.PostedFile.ContentType.IndexOf("image/") = -1 And Trim(ProductPicture.PostedFile.FileName) <> "" Then
                    validateUploadFile.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(11)("TextParamValue") & "</td></tr>"
                    FoundError = True
                End If
            Catch ex As Exception
                FileTransfer = False
            End Try
        End If
	
        If showUploadPicture_iPad.Visible = True Then
            Dim FileTransfer_iPad As Boolean = True
            Try
                If ProductPicture_iPad.PostedFile.ContentType.IndexOf("image/") = -1 And Trim(ProductPicture.PostedFile.FileName) <> "" Then
                    validateUploadFile_iPad.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(11)("TextParamValue") & "</td></tr>"
                    FoundError = True
                End If
            Catch ex As Exception
                FileTransfer_iPad = False
            End Try
        End If
	
        Dim ActivateDateTime As String = DateTimeUtil.FormatDate(Request.Form("ProductEnableDateTime_Day"), Request.Form("ProductEnableDateTime_Month"), Request.Form("ProductEnableDateTime_Year"))
	
        If Trim(ActivateDateTime) = "InvalidDate" Then
            validateEnableDateTime.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(45)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
	
        Dim ExpireDateTime As String = DateTimeUtil.FormatDate(Request.Form("ProductExpireDateTime_Day"), Request.Form("ProductExpireDateTime_Month"), Request.Form("ProductExpireDateTime_Year"))
	
        If Trim(ExpireDateTime) = "InvalidDate" Then
            validateExpireDateTime.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(45)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        Dim ExtentProductID As Integer = 0
        If ShowBuffet.Visible = True Then
            If Radio110.Checked = True Then
                If Not IsNumeric(ExtentTimeEvery.Text) Then
                    validateBuffet.InnerHtml = "<tr><td></td><td class=""errorText"">" & "Buffet over time must be numeric number" & "</td></tr>"
                    FoundError = True
                Else
                    Dim ChkP As DataTable = objDB.List("select * from Products p, ProductDept pd, ProductGroup pg where p.ProductDeptID=pd.ProductDeptID AND pd.ProductGroupID=pg.ProductGroupID AND pg.ProductlevelID=" + Request.QueryString("ProductLevelID").ToString + " AND p.ProductCode='" + Trim(Replace(ProductCodeBuffet.Text, "'", "''")) + "' AND p.Deleted=0 AND pd.Deleted=0 AND pg.Deleted=0", objCnn)
                    If ChkP.Rows.Count = 0 Then
                        validateBuffet.InnerHtml = "<tr><td></td><td class=""errorText"">" & "Cannot find product code for buffet charge" & "</td></tr>"
                        FoundError = True
                    Else
                        ExtentProductID = ChkP.Rows(0)("ProductID")
                    End If
                End If
            End If
        End If
	
        If Not IsNumeric(Request.Form("FromTime_Hour")) And Not IsNumeric(Request.Form("FromTime_Minute")) And Not IsNumeric(Request.Form("ToTime_Hour")) And Not IsNumeric(Request.Form("ToTime_Minute")) Then
	
        Else
            If (Not IsNumeric(Request.Form("FromTime_Hour")) And IsNumeric(Request.Form("FromTime_Minute"))) Or (IsNumeric(Request.Form("FromTime_Hour")) And Not IsNumeric(Request.Form("FromTime_Minute"))) Then
                validateTime.InnerHtml = "<tr><td></td><td class=""errorText"">" & "Invalid time range value" & "</td></tr>"
                FoundError = True
            ElseIf Not IsNumeric(Request.Form("ToTime_Hour")) Or Not IsNumeric(Request.Form("ToTime_Minute")) Then
                validateTime.InnerHtml = "<tr><td></td><td class=""errorText"">" & "Invalid time range value" & "</td></tr>"
                FoundError = True
            End If
		
            If (Not IsNumeric(Request.Form("ToTime_Hour")) And IsNumeric(Request.Form("ToTime_Minute"))) Or (IsNumeric(Request.Form("ToTime_Hour")) And Not IsNumeric(Request.Form("ToTime_Minute"))) Then
                validateTime.InnerHtml = "<tr><td></td><td class=""errorText"">" & "Invalid time range value" & "</td></tr>"
                FoundError = True
            ElseIf Not IsNumeric(Request.Form("FromTime_Hour")) Or Not IsNumeric(Request.Form("FromTime_Minute")) Then
                validateTime.InnerHtml = "<tr><td></td><td class=""errorText"">" & "Invalid time range value" & "</td></tr>"
                FoundError = True
            End If
        End If
	
        If FoundError = False Then
            Dim Result As String
            Dim ExtraSQL(1) As String
            Dim TimeNow As String
            TimeNow = DateTimeUtil.CurrentDateTime
		
            Dim ToTimeString As String = "00:00:00"
            Dim EndTimeString As String = "00:00:00"
		
            If IsNumeric(Request.Form("FromTime_Hour")) And IsNumeric(Request.Form("FromTime_Minute")) And IsNumeric(Request.Form("ToTime_Hour")) And IsNumeric(Request.Form("ToTime_Minute")) Then
                ToTimeString = Request.Form("FromTime_Hour").ToString + ":" + Request.Form("FromTime_Minute").ToString + ":00"
                EndTimeString = Request.Form("ToTime_Hour").ToString + ":" + Request.Form("ToTime_Minute").ToString + ":00"
            End If
		
            If Trim(ActivateDateTime) = "" Then
                ActivateDateTime = "{ ts '2000-01-01 " + ToTimeString + "'}"
            Else
                ActivateDateTime = Trim(Replace(Replace(Replace(Replace(ActivateDateTime, "'", ""), "{", ""), "}", ""), "d", ""))
                ActivateDateTime = "{ ts '" + ActivateDateTime + " " + ToTimeString + "'}"
            End If
            If Trim(ExpireDateTime) = "" Then
                ExpireDateTime = "{ ts '9999-01-01 " + EndTimeString + "'}"
            Else
                ExpireDateTime = Trim(Replace(Replace(Replace(Replace(ExpireDateTime, "'", ""), "{", ""), "}", ""), "d", ""))
                ExpireDateTime = "{ ts '" + ExpireDateTime + " " + EndTimeString + "'}"
            End If
		
            Dim WeeklyValue As String = ""
		
            If ShowWeekly.Visible = True Then
                If Trim(Request.Form("SelWeekly")) = "" Then
                    WeeklyValue = ""
                Else
                    WeeklyValue = "," + Trim(Request.Form("SelWeekly")) + ","
                End If
            End If
		
            ExtraSQL(0) = ""
            ExtraSQL(1) = ""
		
		
            Dim DownloadDir, PictureFileServer, PictureFileClient, PictureFileServer_iPad, PictureFileClient_iPad As String
            Dim DownloadPath, ResourcePath As String
            DownloadDir = Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED")).Replace("Inventory", "images\Products")
            ResourcePath = Path.GetDirectoryName(Request.ServerVariables("PATH_TRANSLATED")).Replace("Inventory", "Resources\Shop\MenuImage")
		
            If Not Directory.Exists(ResourcePath) Then
                Directory.CreateDirectory(ResourcePath)
            End If
		
            If showUploadPicture.Visible = True Then
                If Trim(ProductPicture.PostedFile.FileName) <> "" Then
                    Dim DownloadCompleted As Boolean = False
                    Dim ServerFile As String

                    ServerFile = Replace(Path.GetFileName(ProductPicture.PostedFile.FileName), " ", "_")
				
                    DownloadPath = DownloadDir + "\" + ServerFile
                    ProductPicture.PostedFile.SaveAs(DownloadPath)
                    PictureFileServer = ServerFile
                    PictureFileClient = Path.GetFileName(ProductPicture.PostedFile.FileName)
	
                Else
                    PictureFileServer = ""
                    PictureFileClient = ""
                End If
            Else
                PictureFileServer = ""
                PictureFileClient = ""
            End If
		
            Dim ImageLinkCol As String = ",MenuImageLink"
            PictureFileServer_iPad = ",'" + Replace(MenuImage_iPad.Value, "'", "''") + "'"
		
            If showUploadPicture_iPad.Visible = True Then
                If Trim(ProductPicture_iPad.PostedFile.FileName) <> "" Then
                    Dim DownloadCompleted_iPad As Boolean = False
                    Dim ServerFile_iPad As String

                    ServerFile_iPad = Replace(Path.GetFileName(ProductPicture_iPad.PostedFile.FileName), " ", "_")
				
                    ResourcePath = ResourcePath + "\" + ServerFile_iPad
                    ProductPicture_iPad.PostedFile.SaveAs(ResourcePath)
                    ImageLinkCol = ",MenuImageLink"
                    PictureFileServer_iPad = ",'" + Replace(ServerFile_iPad, "'", "''") + "'"
	
                End If
			
                If RemoveImage_iPad.Visible = True Then
                    If RemoveImage_iPad.Checked = True Then
                        ImageLinkCol = ",MenuImageLink"
                        PictureFileServer_iPad = ",''"
                    End If
                End If

            End If
		
            If ProductID.Value = 0 Or Request.QueryString("SaveAs") = "yes" Then
                ExtraSQL(0) = "InsertDate,UpdateDate,ProductPictureServer,ProductPictureClient,ProductEnableDateTime,ProductExpireDateTime,ProductName1"
                If ShowWeekly.Visible = True Then
                    ExtraSQL(0) += ",ProductEnableDayString"
                End If
                ExtraSQL(1) = TimeNow + "," + TimeNow
                If Trim(PictureFileServer) <> "" Then
                    ExtraSQL(1) += ",'" + PictureFileServer.Replace("'", "''") + "'"
                Else
                    ExtraSQL(1) += ",NULL"
                End If
                If Trim(PictureFileClient) <> "" Then
                    ExtraSQL(1) += ",'" + PictureFileClient.Replace("'", "''") + "'"
                Else
                    ExtraSQL(1) += ",NULL"
                End If
                ExtraSQL(1) += "," + ActivateDateTime
                ExtraSQL(1) += "," + ExpireDateTime
                If Request.Form("ProductNameExtra") = "" Then
                    ExtraSQL(1) += ",''"
                Else
                    ExtraSQL(1) += ",'" + Replace(Request.Form("ProductNameExtra"), "'", "''") + "'"
                End If
                If ShowWeekly.Visible = True Then
                    ExtraSQL(1) += ",'" + WeeklyValue + "'"
                End If
            Else
                ExtraSQL(0) = "UpdateDate=" + TimeNow
                ExtraSQL(0) += ",ProductEnableDateTime=" + ActivateDateTime
                ExtraSQL(0) += ",ProductExpireDateTime=" + ExpireDateTime
			
                If Trim(PictureFileServer) <> "" Then
                    ExtraSQL(0) += ",ProductPictureServer='" + PictureFileServer.Replace("'", "''") + "'"
                End If
                If Trim(PictureFileClient) <> "" Then
                    ExtraSQL(0) += ",ProductPictureClient='" + PictureFileClient.Replace("'", "''") + "'"
                End If
			
                If RemoveImage.Visible = True Then
                    If RemoveImage.Checked = True Then
                        ExtraSQL(0) += ",ProductPictureServer=NULL"
                        ExtraSQL(0) += ",ProductPictureClient=NULL"
                    End If
                End If
			
                If Request.Form("ProductNameExtra") <> "" Then
                    ExtraSQL(0) += ",ProductName1='" + Request.Form("ProductNameExtra").Replace("'", "''") + "'"
                Else
                    ExtraSQL(0) += ",ProductName1=''"
                End If
			
                If ShowWeekly.Visible = True Then
                    ExtraSQL(0) += ",ProductEnableDayString='" + WeeklyValue + "'"
                End If
            End If
		
            Application.Lock()
            Result = getInfo.AddUpdateCategory(Request, ExtraSQL, "Products", "ProductID", objCnn)
            Dim UpdateProductID As Integer = ProductID.Value
            If ProductID.Value = 0 Or Request.QueryString("SaveAs") = "yes" Then
                UpdateProductID = getInfo.GetInsertID("Products", "ProductID", 3, Request.QueryString("ProductLevelID"), objCnn)
            End If
		
            objDB.sqlExecute("UPDATE ProductShopOverwrite SET ProductName='" + Replace(Request.Form("ProductName"), "'", "''") + "',ProductBarCode='" + Replace(Request.Form("ProductBarCode"), "'", "''") + "',ProductName1='" + Replace(Request.Form("ProductNameExtra"), "'", "''") + "' WHERE ProductID=" + UpdateProductID.ToString, objCnn)
		
            If ShowBuffet.Visible = True Then
                strSQL = "delete from ProductBuffetSetting where ProductBuffetID=" + UpdateProductID.ToString
                objDB.sqlExecute(strSQL, objCnn)
                If Radio110.Checked = True Then
                    Dim productTime As Integer
                    If IsNumeric(ProductBuffetTime.Text) Then
                        productTime = CInt(ProductBuffetTime.Text)
                    Else
                        productTime = 0
                    End If
                    strSQL = "insert into ProductBuffetSetting (ProductBuffetID,ExtentTimeEvery,ExtentTimeRoundUp,ExtentProductID,ProductBuffetTime) " & _
                            "Values (" + UpdateProductID.ToString + "," + ExtentTimeEvery.Text + "," + Request.Form("ExtentTimeRoundUp").ToString + "," & _
                            ExtentProductID.ToString & ", " & productTime & ")"
                    objDB.sqlExecute(strSQL, objCnn)
                End If
            End If
		
            If mPOS = True Then
		
                Dim Exist As Boolean = getProp.CheckTableExist("menuitem", objCnn)
                If Exist = True Then
				
                    Dim Activate As Integer = 1
                    If Radio1111.Checked = True Then
                        Activate = 0
                    End If
                    If Radio6.Checked = True Then
                        Activate = 0
                    End If
                    If IsCommentVal.Value = 0 Then
                        objDB.sqlExecute("delete from menuitem where ProductID=" + UpdateProductID.ToString, objCnn)
                        objDB.sqlExecute("insert into menuitem (MenuItemID,ProductID,MenuDeptID,MenuGroupID,ProductLevelID,MenuName_0,MenuName_1,MenuName_2,MenuDesc_0,MenuDesc_1,MenuLongDesc_0,MenuLongDesc_1,MenuShortName_0,MenuShortName_1,MenuItemOrdering,UpdateDate,Activate" + ImageLinkCol + ") values (" + UpdateProductID.ToString + "," + UpdateProductID.ToString + "," + Request.Form("ProductDeptID").ToString + "," + Request.Form("ProductGroupID").ToString + "," + Request.QueryString("ProductlevelID").ToString + ",'" + Replace(ProductName.Text, "'", "''") + "','" + Replace(ProductNameExtra.Text, "'", "''") + "','" + Replace(ProductPocketName.Text, "'", "''") + "','" + Replace(ProductShortDesp.Text, "'", "''") + "','" + Replace(ProductShortDesp.Text, "'", "''") + "','" + Replace(ProductDesp.Text, "'", "''") + "','" + Replace(ProductDesp.Text, "'", "''") + "','" + Replace(MenuShortName.Text, "'", "''") + "','" + Replace(MenuShortName.Text, "'", "''") + "'," + Request.Form("ProductOrdering").ToString + "," + TimeNow + "," + Activate.ToString + PictureFileServer_iPad + ")", objCnn)
					
                    Else
                        objDB.sqlExecute("delete from menucomment where MenuCommentID=" + UpdateProductID.ToString, objCnn)
                        objDB.sqlExecute("insert into menucomment (MenuCommentID,ProductLevelID,MenuCommentName_0,MenuCommentName_1,MenuCommentOrdering,UpdateDate) values (" + UpdateProductID.ToString + "," + Request.QueryString("ProductlevelID").ToString + ",'" + Replace(ProductName.Text, "'", "''") + "','" + Replace(ProductName.Text, "'", "''") + "'," + Request.Form("ProductOrdering").ToString + "," + TimeNow + ")", objCnn)
                    End If
                End If
            End If
		
            objDB.sqlExecute("delete from SaleModeProduct where ProductID=" + UpdateProductID.ToString, objCnn)
            If Radio27.Checked = True Then
                objDB.sqlExecute("insert into SaleModeProduct (ProductID,SaleModeID) values (" + UpdateProductID.ToString + ",2)", objCnn)
            End If
            If Radio29.Checked = True Then
                objDB.sqlExecute("insert into SaleModeProduct (ProductID,SaleModeID) values (" + UpdateProductID.ToString + ",3)", objCnn)
            End If
            If Radio31.Checked = True Then
                objDB.sqlExecute("insert into SaleModeProduct (ProductID,SaleModeID) values (" + UpdateProductID.ToString + ",4)", objCnn)
            End If
            If Len(Trim(Request.Form("PrinterID"))) = 0 Then
                objDB.sqlExecute("update Products set PrinterID='-1' where ProductID=" + UpdateProductID.ToString, objCnn)
            End If
            Result = "Success"
            If Result = "Success" Then
                If ModifyPackageDetail = True Then
                    getInfo.UpdatePackageDetail(ProductCode_Old.Value, Trim(ProductCode.Text), Request.Form("ProductLevelID"), objCnn)
                End If
                If ModifyPackageHistory = True Then
                    getInfo.UpdatePackageHistory(ProductCode_Old.Value, Trim(ProductCode.Text), Request.Form("ProductLevelID"), objCnn)
                End If
                If (ProductID.Value = 0 Or Request.QueryString("SaveAs") = "yes") And showPromo.Visible = True Then
                    'getPromo.PromoProduct(Request.Form("SelPromo"),objCnn)
                End If


                If Trim(ProductMainPrice.Text) <> "" Then
                    getInfo.UpdateProductPrice(UpdateProductID, 1, ProductMainPrice.Text, PrepaidPrice.Text, objCnn)
                Else
                    getInfo.DelProductPrice(UpdateProductID, 1, 1, objCnn)
                End If
			
                If SM2.Visible = True Then
                    If Trim(ProductPriceSM2.Text) <> "" Then
                        getInfo.UpdateProductPrice(UpdateProductID, 2, ProductPriceSM2.Text, "", objCnn)
                    Else
                        getInfo.DelProductPrice(UpdateProductID, 2, 1, objCnn)
                    End If
                End If
			
                If SM3.Visible = True Then
                    If Trim(ProductPriceSM3.Text) <> "" Then
                        getInfo.UpdateProductPrice(UpdateProductID, 3, ProductPriceSM3.Text, "", objCnn)
                    Else
                        getInfo.DelProductPrice(UpdateProductID, 3, 1, objCnn)
                    End If
                End If
			
                If SM4.Visible = True Then
                    If Trim(ProductPriceSM4.Text) <> "" Then
                        getInfo.UpdateProductPrice(UpdateProductID, 4, ProductPriceSM4.Text, "", objCnn)
                    Else
                        getInfo.DelProductPrice(UpdateProductID, 4, 1, objCnn)
                    End If
                End If
			
                If SM5.Visible = True Then
                    If Trim(ProductPriceSM5.Text) <> "" Then
                        getInfo.UpdateProductPrice(UpdateProductID, 5, ProductPriceSM5.Text, "", objCnn)
                    Else
                        getInfo.DelProductPrice(UpdateProductID, 5, 1, objCnn)
                    End If
                End If
				
                If ShowMultiplePrice.Visible = True Then
                    getInfo.MultiProductPrice(UpdateProductID, ProductPrice2.Text, ProductPrice3.Text, ProductPrice4.Text, ProductPrice5.Text, objCnn)
                End If
                getInfo.UpdateStaffDuration(UpdateProductID, Staff1DurationTime.Text, Staff2DurationTime.Text, Staff3DurationTime.Text, objCnn)

                Response.Redirect("product_category.aspx?" + Request.QueryString.ToString)
            Else
                errorMsg.InnerHtml = Result
            End If
            Application.UnLock()
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
