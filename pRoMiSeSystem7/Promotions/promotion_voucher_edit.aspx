<%@ Page Language="VB" ContentType="text/html" EnableViewState="false" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.ComponentModel" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSBackOfficeReport" %>
<%@Import Namespace="POSDBFront" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<%@ Register tagprefix="synature" Tagname="time" Src="../UserControls/Time.ascx" %>
<html>
<head>
<title>Promotions</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body<% = GlobalParam.BodyProp %>>
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

<form runat="server">
<script type="text/javascript">
function showTextBox() {
   if ( document.forms[0].ReuseCoupon[2].checked == true ) {
      document.getElementById("tbox").style.display = "block";
   } else {
      document.getElementById("tbox").style.display = "none";
   }
}

function showRequireReferenceNo() {
    if (document.forms[0].ReuseCoupon[2].checked == true) {
        document.getElementById("tbox").style.display = "block";
    } else {
        document.getElementById("tbox").style.display = "none";
    }
}

</script>
<input type="hidden" id="VoucherTypeID" runat="server" />
<input type="hidden" id="SelDiscount" runat="server" />
<input type="hidden" id="OldVoucherHeader" runat="server" />
<table cellpadding="3" cellspacing="3" border="0">
<div id="validateName" runat="server" />
<tr>
	<td><div class="requireText" id="NameParam" runat="server"></div></td>
	<td><asp:textbox ID="VoucherTypeName" MaxLength="100" Width="200" runat="server" /></td>
</tr>
<div id="validateHeader" runat="server" />
<tr>
	<td><div class="requireText" id="HeaderParam" runat="server"></div></td>
	<td><asp:textbox ID="VoucherHeader" MaxLength="10" Width="70" runat="server" /></td>
</tr>
<div id="validateStart" runat="server" />
<tr id="showStartNumber" runat="server">
	<td><div class="requireText" id="StartParam" runat="server"></div></td>
	<td><asp:textbox ID="StartNumber" MaxLength="10" Width="70" runat="server" /></td>
</tr>
<div id="validateAmount" runat="server" />
<tr id="showAmount" runat="server">
	<td><div class="requireText" id="AmountParam" runat="server"></div></td>
	<td><asp:textbox ID="VoucherAmount" MaxLength="10" Width="70" runat="server" /></td>
</tr>

<div id="validateExpireDate" runat="server" />
<tr>
	<td><div class="text" id="ExpireDateParam" runat="server"></div></td>
	<td><synature:date id="ExpireDate" runat="server" /></td>
</tr>

<tr id="ReuseCoupon" visible="false" runat="server">
	<td><div class="text" id="ReuseText" runat="server"></div></td>
	<td class="text"><input type="radio" id="Radio1" name="ReuseCoupon" onClick="showTextBox();" value="1" runat="server" />
        <span id="YesText2" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio2" onClick="showTextBox();" name="ReuseCoupon" value="0" runat="server" />
        <span id="NoText2" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Radio3" name="ReuseCoupon" value="2" onClick="showTextBox();" runat="server" />
        <span id="InReceipt" runat="server"></span><input type="radio" id="optAutoCoupon" name="ReuseCoupon" value="3" onClick="showTextBox();" runat="server" />
        <span id="AutoCoupon" runat="server"></span></td>
</tr>

<tr id="tbox" style="overflow:hidden;">
	<td class="text">Valid</td>
	<td class="text"><asp:TextBox ID="ValidDayAfterCreate" CssClass="text" Width="50" runat="server"></asp:TextBox> days after create</td>
</tr>

<tr id="VoucherType" visible="false" runat="server">
	<td><div class="text" id="VoucherTypeText" runat="server"></div></td>
	<td class="text"><input type="radio" id="VTypeEnable" name="SoldVoucher" value="1" runat="server" /><span id="SoldVoucherText" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="VTypeDisable" name="SoldVoucher" value="0" runat="server" /><span id="GiftVoucherText" runat="server"></span></td>
</tr>
    
<tr id="trRequireReference" visible="false" runat="server">
	<td><div class="text" id="dvReferenceNo" runat="server"></div></td>
	<td class="text">
        <div style="border: solid 1px rgb(236, 233,216);">
        <table id="tbRequireReference" runat="server" >
            <tr id="trRequireReferenceNo" runat="server" >
                <td><asp:RadioButton ID="optRequireReferenceNo" GroupName="RequireReferenceGroup" text="No" runat="server" /></td>
            </tr> 
            <tr id="trRequireReferenceYes" runat="server" >
                <td><asp:RadioButton ID="optRequireReferenceYes" text="Yes" GroupName="RequireReferenceGroup" runat="server" />
                    &nbsp;&nbsp;<asp:TextBox ID="txtRequireReferenceDigit" CssClass="text" Width="35" runat="server" MaxLength="2"></asp:TextBox>
                    &nbsp;<asp:Label ID="lblRequireReferenceDigitError" class="requireText" text="" runat="server"></asp:Label>
                    &nbsp;<asp:Label ID="lblRequireReferenceDigit" text="digit(s)" runat="server"></asp:Label>                    
                </td>
            </tr> 
            <tr id="trRequireReferenceBuzzeBee" runat="server" >
                <td><asp:RadioButton ID="optRequireReferenceBuzzeBee" text="Yes : BuzzeBee" GroupName="RequireReferenceGroup" runat="server" /></td>
            </tr> 
            <tr id="trRequireReferencePTTBlueCard" runat="server" >
                <td><asp:RadioButton ID="optRequireReferencePTTBlueCard" text="Yes : PTT BlueCard" GroupName="RequireReferenceGroup" runat="server" />
                    &nbsp;&nbsp;<asp:TextBox ID="txtReqiureReferencePTTBlueCardDigit" CssClass="text" Width="35" runat="server" MaxLength="2"></asp:TextBox>
                    &nbsp;<asp:Label ID="lblRequireReferenceDigitPTTBlueCardError" class="requireText" text="" runat="server"></asp:Label>
                    &nbsp;<asp:Label ID="lblReqiureReferencePTTBlueCardDigit" text="digit(s)" runat="server"></asp:Label>                    
                </td>
            </tr> 
            <tr id="trRequireReferencePTTWallet" runat="server" >
                <td><asp:RadioButton ID="optRequireReferencePTTWallet" text="Yes : PTT Wallet" GroupName="RequireReferenceGroup" runat="server" /></td>
            </tr> 
        </table>
        </div> 
    </td> 
</tr>

<tr id="Authorize" visible="false" runat="server">
	<td><div class="text" id="AuthorizeText" runat="server"></div></td>
	<td class="text"><input type="radio" id="RequireAuthorizeYES" name="RequireAuthorize" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="RequireAuthorizeNO" name="RequireAuthorize" value="0" runat="server" />NO</td>
</tr>

<tr id="trRequireMember" visible="false" runat="server">
	<td><div class="text" id="dvRequireMember" runat="server"></div></td>
	<td class="text"><input type="radio" id="optRequireMemberYes" name="RequireMember" value="1" runat="server" />YES&nbsp;&nbsp;
                     <input type="radio" id="optRequireMemberNo" name="RequireMember" value="0" runat="server" />NO</td>
</tr>

<tr id="ActivateSection" visible="true" runat="server">
	<td><div class="text" id="ActivateText" runat="server"></div></td>
	<td class="text"><input type="radio" id="Enable" name="Activated" value="1" runat="server" /><span id="YesText" runat="server"></span>&nbsp;&nbsp;<input type="radio" id="Disable" name="Activated" value="0" runat="server" /><span id="NoText" runat="server"></span></td>
</tr>

<div id="validateItem" runat="server" />
<div id="htmlResult" runat="server" />
<tr>
	<td colspan="2" height="5"></td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td><asp:button ID="SubmitForm" OnClick="DoAddUpdate" runat="server" />&nbsp;<asp:button ID="CancelButton" OnClick="DoCancel" runat="server" /></td>
</tr>

</table>
</form>
<script language="javascript">
	showTextBox()
</script>
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
Dim getData As New CPromotions()
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim getPageText As New DefaultText()
Dim DateTimeUtil As New MyDateTime()
Dim objDB As New CDBUtil()
Dim Util As New UtilityFunction()
Dim getProp As New CPreferences()

    Sub Page_Load()
        If User.Identity.IsAuthenticated And ((Session("Promotion_Coupon") And Request.QueryString("type") = 4) Or (Session("Promotion_Voucher") And Request.QueryString("type") = 5)) Then
            SubmitForm.Attributes.Item("onclick") = "this.disabled=true; document.forms[0].CancelButton.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
            Dim permissionItemList As String = ""
            SelDiscount.Value = Request.QueryString("type")
            Try
                objCnn = getCnn.EstablishConnection()
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(12, Session("LangID"), objCnn)
			
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
                Dim CultureString As String = Util.GetCultureByLangID(Session("LangID"), objCnn)
                Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
                Dim dtLangData As DataTable = getProp.GetLangData(110, 2, -1, Request)
                Dim strLangText As String
                
                validateName.InnerHtml = ""
                validateExpireDate.InnerHtml = ""
                validateHeader.InnerHtml = ""
                validateAmount.InnerHtml = ""
			
                YesText.InnerHtml = defaultTextTable.Rows(3)("TextParamValue")
                NoText.InnerHtml = defaultTextTable.Rows(4)("TextParamValue")
                YesText2.InnerHtml = textTable.Rows(60)("TextParamValue") 'defaultTextTable.Rows(3)("TextParamValue")
			
			
                VoucherTypeText.InnerHtml = textTable.Rows(37)("TextParamValue")
                SoldVoucherText.InnerHtml = textTable.Rows(39)("TextParamValue")
                GiftVoucherText.InnerHtml = textTable.Rows(40)("TextParamValue")
                ReuseText.InnerHtml = "Voucher Property" 'textTable.Rows(60)("TextParamValue")
			
                StartParam.InnerHtml = "Starting Number"
                AmountParam.InnerHtml = textTable.Rows(34)("TextParamValue")
		
                CancelButton.Text = defaultTextTable.Rows(2)("TextParamValue")
                ExpireDateParam.InnerHtml = textTable.Rows(38)("TextParamValue")

                NameParam.InnerHtml = textTable.Rows(2)("TextParamValue")

                ActivateText.InnerHtml = textTable.Rows(18)("TextParamValue")
			
                ExpireDate.LangID = Session("LangID")
                ExpireDate.FormName = "ExpireDate"
                ExpireDate.StartYear = GlobalParam.StartYear
                ExpireDate.EndYear = GlobalParam.EndYear
                ExpireDate.LangID = Session("LangID")
                ExpireDate.Lang_Data = LangDefault
                ExpireDate.Culture = CultureString
			
                strLangText = "Lang" & Session("LangID")
                
                'Set Language
                AuthorizeText.InnerHtml = POSBackOfficeReport.BackOfficeReport.GetLanguageText(dtLangData, 1, strLangText, "Require Authorization?")
                dvRequireMember.InnerHtml = POSBackOfficeReport.BackOfficeReport.GetLanguageText(dtLangData, 2, strLangText, "For Member Only?")
                dvReferenceNo.InnerHtml = POSBackOfficeReport.BackOfficeReport.GetLanguageText(dtLangData, 3, strLangText, "Require Reference Number.")
		
                optRequireReferenceNo.Text = POSBackOfficeReport.BackOfficeReport.GetLanguageText(dtLangData, 4, strLangText, "No")
                optRequireReferenceYes.Text = POSBackOfficeReport.BackOfficeReport.GetLanguageText(dtLangData, 5, strLangText, "Yes")
                optRequireReferenceBuzzeBee.Text = POSBackOfficeReport.BackOfficeReport.GetLanguageText(dtLangData, 6, strLangText, "Yes : BuzzeBee")
                optRequireReferencePTTBlueCard.Text = POSBackOfficeReport.BackOfficeReport.GetLanguageText(dtLangData, 7, strLangText, "Yes : PTT BlueCard")
                optRequireReferencePTTWallet.Text = POSBackOfficeReport.BackOfficeReport.GetLanguageText(dtLangData, 8, strLangText, "Yes : PTT Wallet")
                    
                lblRequireReferenceDigit.Text = POSBackOfficeReport.BackOfficeReport.GetLanguageText(dtLangData, 9, strLangText, "digit(s) (between 4-30)")
                lblReqiureReferencePTTBlueCardDigit.Text = POSBackOfficeReport.BackOfficeReport.GetLanguageText(dtLangData, 9, strLangText, "digit(s) (between 4-30)")
                    
                SetVisibleControl()
                                
                Dim PromotionType As String = "Voucher"
                Dim CouponType As Integer
                If Request.QueryString("type") = 4 Then
                    PromotionType = "Coupon"
                    CouponType = 4
                    HeaderParam.InnerHtml = textTable.Rows(32)("TextParamValue")
                    Text_SectionParam.InnerHtml = textTable.Rows(26)("TextParamValue")
                    VoucherType.Visible = False
                    ReuseCoupon.Visible = True
                    NoText2.InnerHtml = "Coupon Range" 'defaultTextTable.Rows(4)("TextParamValue")
                    InReceipt.InnerHtml = "Redeem Coupon/Coupon In Receipt"
                    AutoCoupon.InnerHtml = "Auto Coupon(price discount)"
                Else
                    PromotionType = "Voucher"
                    CouponType = 5
                    HeaderParam.InnerHtml = textTable.Rows(33)("TextParamValue")
                    Text_SectionParam.InnerHtml = textTable.Rows(27)("TextParamValue")
                    VoucherType.Visible = True
                    ReuseCoupon.Visible = True
                    NoText2.InnerHtml = "Voucher Range" 'defaultTextTable.Rows(4)("TextParamValue")
                    InReceipt.InnerHtml = "Redeem Voucher/Voucher In Receipt"
                    AutoCoupon.InnerHtml = ""
                    optAutoCoupon.Visible = False
                End If
			
                If Not Request.QueryString("VoucherTypeID") And IsNumeric(Request.QueryString("VoucherTypeID")) Then
			
                    VoucherTypeID.Value = Request.QueryString("VoucherTypeID")
                    showAmount.Visible = False
                    showStartNumber.Visible = False
			
                    Radio1.Disabled = True
                    Radio2.Disabled = True
                    Radio3.Disabled = True
                    optAutoCoupon.Disabled = True
			
                    If Not Page.IsPostBack Then
                        Dim dtTable As DataTable
                        dtTable = getData.GetCVPromo(SelDiscount.Value, VoucherTypeID.Value, "", objCnn)
                        If dtTable.Rows.Count > 0 Then
				
                            If Not IsDBNull(dtTable.Rows(0)("VoucherTypeName")) Then
                                VoucherTypeName.Text = dtTable.Rows(0)("VoucherTypeName")
                            End If
					
                            If Not IsDBNull(dtTable.Rows(0)("VoucherHeader")) Then
                                VoucherHeader.Text = dtTable.Rows(0)("VoucherHeader")
                                OldVoucherHeader.Value = dtTable.Rows(0)("VoucherHeader")
                            End If
					
					
                            If IsDate(dtTable.Rows(0)("ExpireDate")) Then
                                ExpireDate.SelectedDay = dtTable.Rows(0)("ExpireDate").Day
                                ExpireDate.SelectedMonth = dtTable.Rows(0)("ExpireDate").Month
                                ExpireDate.SelectedYear = dtTable.Rows(0)("ExpireDate").Year
                            End If
					
                            If Not IsDBNull(dtTable.Rows(0)("SoldVoucher")) Then
                                If dtTable.Rows(0)("SoldVoucher") = True Or dtTable.Rows(0)("SoldVoucher") = 1 Then
                                    VTypeEnable.Checked = True
                                Else
                                    VTypeDisable.Checked = True
                                End If
                            Else
                                VTypeDisable.Checked = True
                            End If
					
                            If Not IsDBNull(dtTable.Rows(0)("Activated")) Then
                                If dtTable.Rows(0)("Activated") = True Or dtTable.Rows(0)("Activated") = 1 Then
                                    Enable.Checked = True
                                Else
                                    Disable.Checked = True
                                End If
                            Else
                                Disable.Checked = True
                            End If
					
                            Select Case dtTable.Rows(0)("ReuseCoupon")
                                Case 1      'Reuse
                                    Radio1.Checked = True
                                Case 2  'Redeem Coupon
                                    Radio3.Checked = True
                                Case 3      'Auto Coupon
                                    optAutoCoupon.Checked = True
                                Case Else
                                    Radio2.Checked = True
                            End Select
					
                            If dtTable.Rows(0)("ValidDayAfterCreate") >= 0 Then
                                ValidDayAfterCreate.Text = dtTable.Rows(0)("ValidDayAfterCreate").ToString
                            Else
                                ValidDayAfterCreate.Text = ""
                            End If
					
                            If dtTable.Rows(0)("RequireAuthorize") = 0 Then
                                RequireAuthorizeNO.Checked = True
                            Else
                                RequireAuthorizeYES.Checked = True
                            End If
                            If dtTable.Rows(0)("IsRequireMember") = 0 Then
                                optRequireMemberNo.Checked = True
                            Else
                                optRequireMemberYes.Checked = True
                            End If
					
                            lblRequireReferenceDigitError.Text = ""
                            lblRequireReferenceDigitError.Visible = False
                            lblRequireReferenceDigitPTTBlueCardError.Text = ""
                            lblRequireReferenceDigitPTTBlueCardError.Visible = False
                            txtRequireReferenceDigit.Text = ""
                            txtReqiureReferencePTTBlueCardDigit.Text = ""
                            Select Case dtTable.Rows(0)("RequireReferenceNo")
                                Case 0
                                    optRequireReferenceNo.Checked = True
                                    
                                Case 90
                                    optRequireReferenceBuzzeBee.Checked = True
                                    
                                Case 1 To 50
                                    optRequireReferenceYes.Checked = True
                                    If dtTable.Rows(0)("RequireReferenceNo") > 3 And dtTable.Rows(0)("RequireReferenceNo") < 30 Then
                                        txtRequireReferenceDigit.Text = dtTable.Rows(0)("RequireReferenceNo")
                                    End If
                                    
                                Case -98 To -1            'Get ReferenceNo From PTT BlueCard
                                    optRequireReferencePTTBlueCard.Checked = True
                                    If dtTable.Rows(0)("RequireReferenceNo") > -30 And dtTable.Rows(0)("RequireReferenceNo") < -3 Then
                                        txtReqiureReferencePTTBlueCardDigit.Text = Math.Abs(dtTable.Rows(0)("RequireReferenceNo"))
                                    End If
                                Case -99
                                    optRequireReferencePTTWallet.Checked = True
                                    
                                Case Else
                                    optRequireReferenceNo.Checked = True
                            End Select
                        End If
                    End If
                    If SelDiscount.Value = 4 Then
                        SubmitForm.Text = textTable.Rows(53)("TextParamValue")
                    Else
                        SubmitForm.Text = textTable.Rows(54)("TextParamValue")
                    End If
			
                Else
                    Radio1.Disabled = False
                    Radio2.Disabled = False
                    Radio3.Disabled = False
                    optAutoCoupon.Disabled = False
                    If Not Page.IsPostBack Then
                        Disable.Checked = True
                        VTypeDisable.Checked = True
                        Radio2.Checked = True
                        RequireAuthorizeNO.Checked = True
                        optRequireMemberNo.Checked = True
                        optRequireReferenceNo.Checked = True
                        ValidDayAfterCreate.Text = ""
                        StartNumber.Text = 1
                    End If
                    If SelDiscount.Value = 4 Then
                        SubmitForm.Text = textTable.Rows(51)("TextParamValue")
                    Else
                        SubmitForm.Text = textTable.Rows(52)("TextParamValue")
                    End If
                    VoucherTypeID.Value = 0
                End If
		
		
        If IsNumeric(Request.Form("ExpireDate_Day")) Then
            ExpireDate.SelectedDay = Request.Form("ExpireDate_Day")
        End If
        If IsNumeric(Request.Form("ExpireDate_Month")) Then
            ExpireDate.SelectedMonth = Request.Form("ExpireDate_Month")
        End If
        If IsNumeric(Request.Form("ExpireDate_Year")) Then
            ExpireDate.SelectedYear = Request.Form("ExpireDate_Year")
        End If
		
			
            Catch ex As Exception
            errorMsg.InnerHtml = ex.Message
        End Try
        Else
            errorMsg.InnerHtml = "Access Denied"
        End If
    End Sub

    Sub DoAddUpdate(Source As Object, E As EventArgs)
        Dim strSQL As String
        Dim FoundError As Boolean = False
        Dim textTable As New DataTable()
        textTable = getPageText.GetText(12, Session("LangID"), objCnn)
        Dim defaultTextTable As New DataTable()
        defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
	
        Dim Discount_Value As Integer = 0
        Dim Amount_Value As Integer = 0
	
        If Len(Trim(VoucherTypeName.Text)) = 0 Then
            validateName.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(23)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
	
        If Len(Trim(VoucherHeader.Text)) = 0 Then
            validateHeader.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(41)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
	
        If showAmount.Visible = True Then
            If Not IsNumeric(VoucherAmount.Text) Then
                validateAmount.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(42)("TextParamValue") & "</td></tr>"
                FoundError = True
            ElseIf VoucherAmount.Text <= 0 Then
                validateAmount.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(42)("TextParamValue") & "</td></tr>"
                FoundError = True
            End If
        End If
        If showStartNumber.Visible = True Then
            If Not IsNumeric(StartNumber.Text) Then
                validateStart.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(42)("TextParamValue") & "</td></tr>"
                FoundError = True
            ElseIf StartNumber.Text <= 0 Then
                validateStart.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(42)("TextParamValue") & "</td></tr>"
                FoundError = True
            End If
        End If
	
        Dim ChkCode As DataTable
        ChkCode = getData.GetCVPromo(SelDiscount.Value, -1, Trim(VoucherHeader.Text), objCnn)
	
        If Len(Trim(VoucherHeader.Text)) = 0 Then
            validateHeader.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(41)("TextParamValue") & "</td></tr>"
            FoundError = True
        ElseIf ChkCode.Rows.Count > 0 And (VoucherTypeID.Value = 0 Or (VoucherTypeID.Value <> 0 And String.Compare(UCase(OldVoucherHeader.Value), UCase(VoucherHeader.Text)) <> 0)) Then
            validateHeader.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(44)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
		
        Dim Expiration As String
	
        Expiration = DateTimeUtil.FormatDate(Request.Form("ExpireDate_Day"), Request.Form("ExpireDate_Month"), Request.Form("ExpireDate_Year"))
        If Trim(Expiration) = "InvalidDate" Then
            validateExpireDate.InnerHtml = "<tr><td></td><td class=""errorText"">" & defaultTextTable.Rows(45)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        'Validate Reference Digit
        Dim refLen As Integer
       If optRequireReferenceYes.Checked = True Then
            If IsNumeric(txtRequireReferenceDigit.Text) Then
                refLen = CInt(txtRequireReferenceDigit.Text)
                If Not (refLen > 3 And refLen <= 30) Then
                    lblRequireReferenceDigitError.Text = "!!Invalid Value"
                    FoundError = True
                End If
            End If
        ElseIf optRequireReferencePTTBlueCard.Checked = True Then
            If IsNumeric(txtReqiureReferencePTTBlueCardDigit.Text) Then
                refLen = CInt(txtReqiureReferencePTTBlueCardDigit.Text)
                If Not (refLen > 3 And refLen <= 30) Then
                    lblRequireReferenceDigitPTTBlueCardError.Text = "!!Invalid Value"
                    FoundError = True
                End If
            End If
        End If
        
        If FoundError = False Then
            Dim Result, TimeNow As String
            TimeNow = DateTimeUtil.CurrentDateTime
		
            Dim GenAmount As Integer = 0
            If IsNumeric(VoucherAmount.Text) Then
                GenAmount = VoucherAmount.Text
            End If
            Dim StartNum As Integer = 0
            If IsNumeric(StartNumber.Text) Then
                StartNum = StartNumber.Text
            End If
            If Trim(Expiration) = "" Then Expiration = "NULL"
		
            Application.Lock()
            Result = getData.AddUpdateCVPromo_New(0, VoucherTypeID.Value, VoucherTypeName.Text, VoucherHeader.Text, Request.Form("SoldVoucher"), Expiration, Session("StaffID"), Session("StaffID"), TimeNow, TimeNow, Request.Form("Activated"), 0, StartNum, GenAmount, Request.Form("ReuseCoupon"), SelDiscount.Value, objCnn)
		
            Dim UpdateID As Integer = VoucherTypeID.Value
            If UpdateID = 0 Then
                Dim getID As DataTable = objDB.List("SELECT MAX(VoucherTypeID) As MaxID FROM VoucherDetail", objCnn)
                UpdateID = getID.Rows(0)("MaxID")
            End If
            Dim getP As DataTable = objDB.List("select * from VoucherDetail where VoucherTypeID=" + UpdateID.ToString, objCnn)
            Dim ReUseCouponVal As Integer = getP.Rows(0)("ReuseCoupon")
            If ReUseCouponVal = 2 Then
			
                If IsNumeric(ValidDayAfterCreate.Text) Then
                    If CInt(ValidDayAfterCreate.Text) >= 0 Then
                        objDB.List("UPDATE VoucherDetail SET ValidDayAfterCreate=" + ValidDayAfterCreate.Text + " WHERE VoucherTypeID=" + UpdateID.ToString, objCnn)
                    Else
                        objDB.List("UPDATE VoucherDetail SET ValidDayAfterCreate=-1 WHERE VoucherTypeID=" + UpdateID.ToString, objCnn)
                    End If
                Else
                    objDB.List("UPDATE VoucherDetail SET ValidDayAfterCreate=-1 WHERE VoucherTypeID=" + UpdateID.ToString, objCnn)
                End If
            End If
            
            Dim updateRequireRefNo As Integer
            If optRequireReferenceNo.Checked = True Then
                updateRequireRefNo = 0

            ElseIf optRequireReferenceYes.Checked = True Then
                If IsNumeric(txtRequireReferenceDigit.Text) Then
                    updateRequireRefNo = CInt(txtRequireReferenceDigit.Text)
                    If Not (updateRequireRefNo > 3 And updateRequireRefNo <= 30) Then
                        updateRequireRefNo = 1
                    End If
                Else
                    updateRequireRefNo = 1
                End If
                
            ElseIf optRequireReferenceBuzzeBee.Checked = True Then
                updateRequireRefNo = 90
    
            ElseIf optRequireReferencePTTBlueCard.Checked = True Then
                If IsNumeric(txtReqiureReferencePTTBlueCardDigit.Text) Then
                    updateRequireRefNo = CInt(txtReqiureReferencePTTBlueCardDigit.Text)
                    If Not (updateRequireRefNo > 3 And updateRequireRefNo <= 30) Then
                        updateRequireRefNo = -1
                    Else
                        updateRequireRefNo = updateRequireRefNo * -1
                    End If
                Else
                    updateRequireRefNo = -1
                End If
                
            ElseIf optRequireReferencePTTWallet.Checked = True Then
                updateRequireRefNo = -99
            End If
                       
            'Update Require Authorize/ Member
            strSQL = "Update VoucherDetail SET RequireReferenceNo = " & updateRequireRefNo & ", RequireAuthorize = " & Request.Form("RequireAuthorize").ToString & _
                     ", IsRequireMember = " & Request.Form("RequireMember").ToString & " " & _
                     " WHERE VoucherTypeID=" + UpdateID.ToString
            objDB.List(strSQL, objCnn)
        
            Application.UnLock()
		
            If Result = "Success" Then
                Response.Redirect("promotion_voucher.aspx?type=" + SelDiscount.Value)
            Else
                errorMsg.InnerHtml = Result
            End If
        End If
    End Sub

    Sub DoCancel(Source As Object, E As EventArgs)
        Response.Redirect("promotion_voucher.aspx?type=" + Request.Form("SelDiscount").ToString)
    End Sub
    
    Private Sub SetVisibleControl()
        trRequireReference.Visible = True
        Authorize.Visible = True
        trRequireMember.Visible = True

        trRequireReferenceBuzzeBee.Visible = False
        trRequireReferencePTTBlueCard.Visible = False
        trRequireReferencePTTWallet.Visible = False
        
        Dim dtResult As DataTable
        Dim strSQL As String
        Dim i As Integer
        strSQL = "Select * From LinkOtherSystemFeature Where IsAvailable = 1 "
        Try
            dtResult = objDB.List(strSQL, objCnn)
        Catch ex As Exception
            dtResult = New DataTable
        End Try

        For i = 0 To dtResult.Rows.Count - 1
            Select Case dtResult.Rows(i)("SystemTypeID")
                Case 1          'BuzzeBee
                    trRequireReferenceBuzzeBee.Visible = True
            End Select
        Next i
        
        'For PTT Feautre (Property 119)
        strSQL = "Select * From ProgramPropertyValue Where ProgramTypeID = 1 AND PropertyID = 119 AND PropertyValue =1 "
        dtResult = objDB.List(strSQL, objCnn)
        If dtResult.Rows.Count > 0 Then
            trRequireReferencePTTBlueCard.Visible = True
            trRequireReferencePTTWallet.Visible = True
        End If
       
    End Sub
    
    

    Sub Page_UnLoad()
        objCnn.Close()
    End Sub

</script>
</body>
</html>
