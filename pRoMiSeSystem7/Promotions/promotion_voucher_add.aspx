<%@ Page Language="VB" ContentType="text/html" EnableViewState="false" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.ComponentModel" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>

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
<input type="hidden" id="VoucherTypeID" runat="server" />
<input type="hidden" id="SelDiscount" runat="server" />

<table cellpadding="3" cellspacing="3">
<tr>
	<td colspan="2"><div id="sectionHeader" class="boldText" runat="server"></div></td>
</tr>

<div id="validateStart" runat="server" />
<tr>
	<td><div class="requireText" id="StartParam" runat="server"></div></td>
	<td><asp:textbox ID="StartNumber" MaxLength="10" Width="70" runat="server" /> </td>
</tr>
<div id="validateAmount" runat="server" />
<tr>
	<td><div class="requireText" id="AmountParam" runat="server"></div></td>
	<td><asp:textbox ID="VoucherAmount" MaxLength="10" Width="70" runat="server" /> <span id="Unit"  class="requireText" runat="server"></span></td>
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
<div id="Msg" runat="server" />
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
Dim objDB As New CDBUtil()
Sub Page_Load()
	If User.Identity.IsAuthenticated AND IsNumeric(Request.QueryString("VoucherTypeID")) AND ( (Session("Promotion_Coupon") AND Request.QueryString("type") = 4) OR (Session("Promotion_Voucher") AND Request.QueryString("type") = 5) ) Then
	
		Dim permissionItemList As String = ""
		SelDiscount.Value = Request.QueryString("type")
		VoucherTypeID.Value = Request.QueryString("VoucherTypeID")
		
		SubmitForm.Attributes.Item("onclick") = "this.disabled=true; document.forms[0].CancelButton.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
		
		Try
			objCnn = getCnn.EstablishConnection()
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(12,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			validateAmount.InnerHtml = ""	
			validateStart.InnerHtml = ""
			Unit.InnerHtml = textTable.Rows(48)("TextParamValue")
			CancelButton.Text = defaultTextTable.Rows(2)("TextParamValue")
			StartParam.InnerHtml = "Starting Number"
			If Not Page.IsPostBack Then
				Dim MaxVID As DataTable
                MaxVID = getCnn.List("SELECT MAX(EndNo) As MaxID FROM VoucherRange WHERE VoucherTypeID=" + VoucherTypeID.Value.ToString, objCnn)
				Dim MaxVoucherID As Integer = 1
                If IsNumeric(MaxVID.Rows(0)("MaxID")) Then
					MaxVoucherID = MaxVID.Rows(0)("MaxID") + 1
                End If
				StartNumber.Text = MaxVoucherID.ToString
			End If
				
		Dim PromotionType As String = "Voucher"
		Dim CouponType As Integer
		Dim TextType As String
		If Request.QueryString("type") = 4 Then
			PromotionType = "Coupon"
			TextType = textTable.Rows(46)("TextParamValue")
			CouponType = 4
			Text_SectionParam.InnerHtml = textTable.Rows(26)("TextParamValue")

		Else
			PromotionType = "Voucher"
			TextType = textTable.Rows(47)("TextParamValue")
			CouponType = 5
			Text_SectionParam.InnerHtml = textTable.Rows(27)("TextParamValue")

		End If
			
		AmountParam.InnerHtml = TextType
		
		Dim dtTable As DataTable
		dtTable = getData.GetCVPromo(-1,VoucherTypeID.Value,"",objCnn)
		If dtTable.Rows.Count > 0 Then
			sectionHeader.InnerHtml = TextType + " (" + dtTable.Rows(0)("VoucherTypeName") + ")"
		Else
			sectionHeader.InnerHtml = TextType
		End If 
		
		SubmitForm.Text = textTable.Rows(50)("TextParamValue")

		
			
		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	Else
		errorMsg.InnerHtml = "Access Denied or Invalid Parameters"
	End If
End Sub

Sub DoAddUpdate(Source As Object, E As EventArgs)

	Dim FoundError AS Boolean = False
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(12,Session("LangID"),objCnn)
	
	If NOT IsNumeric(VoucherAmount.Text) Then
		validateAmount.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(42)("TextParamValue") & "</td></tr>"
		FoundError = True
	Else If VoucherAmount.Text <= 0 Then
		validateAmount.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(42)("TextParamValue") & "</td></tr>"
		FoundError = True
	End If
	
	If NOT IsNumeric(StartNumber.Text) Then
		validateStart.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(42)("TextParamValue") & "</td></tr>"
		FoundError = True
	Else If StartNumber.Text <= 0 Then
		validateStart.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(42)("TextParamValue") & "</td></tr>"
		FoundError = True
	End If

	
	If FoundError = False Then
		Dim Result As String

		Dim GenAmount As Integer = 0
		If IsNumeric(VoucherAmount.Text) Then
			GenAmount = VoucherAmount.Text
		End If
		Dim StartNum As Integer = 0
		If IsNumeric(StartNumber.Text) Then
			StartNum = StartNumber.Text
		End If
		
		Application.Lock()
		Result = getData.AddMoreCV(VoucherTypeID.Value,StartNum, GenAmount, objCnn)
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


Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
