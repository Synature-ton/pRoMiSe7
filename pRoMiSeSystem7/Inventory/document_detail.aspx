<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Document Detail</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">

<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<form id="mainForm" runat="server">
<input type="hidden" id="MaterialID" runat="server">
<input type="hidden" id="SelMaterialID" runat="server">
<div class="noprint">
<span id="DBText" class="smalltext" runat="server" />
<table cellpadding="2" cellspacing="2" width="100%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
<td align="right"><div class="text" id="GoBackText" runat="server"></div></td>
</tr>

</table>
</div>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td width="50%">
			<table>
				<tr>
					<td class="text" align="right">Status:</td>
					<td class="text"><span id="StatusText" class="text" runat="server"></span></td>
				</tr>
				<tr>
					<td class="text" align="right">Document Type:</td>
					<td class="text"><span id="DocTypeText" class="text" runat="server"></span></td>
				</tr>
				<tr>
					<td class="text" align="right">Document Number:</td>
					<td class="text"><span id="DocNoText" class="text" runat="server"></span></td>
				</tr>
				<tr>
					<td class="text" align="right">Document Ref:</td>
					<td class="text"><span id="DocRefText" class="text" runat="server"></span></td>
				</tr>
				<tr>
					<td class="text" align="right">Document Date:</td>
					<td class="text"><span id="DocDateText" class="text" runat="server"></span></td>
				</tr>
				<tr id="FromInv" visible="false" runat="server">
					<td class="text" align="right">From Inventory:</td>
					<td class="text"><span id="FromInventoryText" class="text" runat="server"></span></td>
				</tr>
				<tr>
					<td class="text" align="right">Inventory:</td>
					<td class="text"><span id="InventoryText" class="text" runat="server"></span></td>
				</tr>
				<tr id="ToInv" visible="false" runat="server">
					<td class="text" align="right">To Inventory:</td>
					<td class="text"><span id="ToInventoryText" class="text" runat="server"></span></td>
				</tr>
				<tr>
					<td class="text" align="right">Remark:</td>
					<td class="text"><span id="RemarkText" class="text" runat="server"></span></td>
				</tr>
			</table>
		</td>
		<td width="50%">
			<table>
				<tr>
					<td class="text" align="right">Vendor Code:</td>
					<td class="text"><span id="VendorCodeText" class="text" runat="server"></span></td>
				</tr>
				<tr>
					<td class="text" align="right">Vendor Name:</td>
					<td class="text"><span id="VendorNameText" class="text" runat="server"></span></td>
				</tr>
				<tr>
					<td class="text" align="right" valign="top">Vendor Address:</td>
					<td class="text"><span id="VendorAddressText" class="text" runat="server"></span></td>
				</tr>
				<tr>
					<td class="text" align="right">Tel/Fax:</td>
					<td class="text"><span id="VendorTelFaxText" class="text" runat="server"></span></td>
				</tr>
				<tr>
					<td class="text" align="right">Term Of Payment:</td>
					<td class="text"><span id="TermOfPaymentText" class="text" runat="server"></span></td>
				</tr>
				<tr>
					<td class="text" align="right">Due Date:</td>
					<td class="text"><span id="DueDateText" class="text" runat="server"></span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="Text6" runat="server"></div></td>
		<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="Text7" runat="server"></div></td>
		<td id="headerTD8" align="center" class="tdHeader" runat="server"><div id="Text8" runat="server"></div></td>
		<td id="headerTD9" align="center" class="tdHeader" runat="server"><div id="Text9" runat="server"></div></td>
        <span id="showStd" visible="false" runat="server">
        <td id="headerTD10" align="center" class="tdHeader" runat="server"><div id="Text10" runat="server"></div></td>
		<td id="headerTD11" align="center" class="tdHeader" runat="server"><div id="Text11" runat="server"></div></td>
        </span>
	</tr>
	
	
	<div id="ResultText" runat="server"></div>
	
</table></form>

<div id="errorMsg" runat="server" />

<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getInfo As New CCategory()
Dim getPageText As New DefaultText()
Dim FormatHeader As New FormatText()
Dim DateTimeUtil As New MyDateTime()
Dim objDB As New CDBUtil()
Dim CostInfo As New CostClass()
		
    Sub Page_Load()
        If User.Identity.IsAuthenticated Then
	  
            If Not Request.QueryString("MaterialID") And IsNumeric(Request.QueryString("MaterialID")) Then
	  	
                'Try
		
                objCnn = getCnn.EstablishConnection()
				
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
	
                MaterialID.Value = Request.QueryString("MaterialID")
			
			
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

                GoBackText.InnerHtml = "<a href=""javascript: window.print()"">Print this Page</a> | <a href=""javascript: window.close()"">Close Window</a>"
		
                Text1.InnerHtml = ""
                Text2.InnerHtml = "Material Code"
                Text3.InnerHtml = "Material Name"
                Text4.InnerHtml = "Qty"
                Text5.InnerHtml = "Price/Unit"
                Text6.InnerHtml = "Unit"
                Text7.InnerHtml = "Discount"
                Text8.InnerHtml = "VAT"
                Text9.InnerHtml = "Sub Total"
                Text10.InnerHtml = "Std Cost/Unit"
                Text11.InnerHtml = "Total Cost"
			
                Dim ChkDocType As DataTable = getInfo.GetDocTypeID(Request.QueryString("DocumentID"), Request.QueryString("ShopID"), objCnn)
                Dim VendorData As DataTable
                Dim dtTable As New DataTable()
			
                If ChkDocType.Rows(0)("DocumentTypeID") = 26 Then
                    dtTable = getInfo.DocumentDataPreFinish(VendorData, Request.QueryString("MaterialID"), Request.QueryString("DocumentID"), Request.QueryString("ShopID"), Session("LangID"), objCnn)
                Else
                    dtTable = getInfo.DocumentData(VendorData, Request.QueryString("MaterialID"), Request.QueryString("DocumentID"), Request.QueryString("ShopID"), Session("LangID"), objCnn)
                End If
			
                Dim getDocTypeInfo As DataTable = getInfo.GetDocumentType(ChkDocType.Rows(0)("ProductLevelID"), ChkDocType.Rows(0)("DocumentTypeID"), Session("LangID"), objCnn)
			
                Dim ShowPrice As Boolean = False
			
                If getDocTypeInfo.Rows.Count > 0 Then
                    If getDocTypeInfo.Rows(0)("CalculateStandardProfitLoss") = 1 Then
                        ShowPrice = True
                    End If
                End If
                ShowPrice = True
			
                Dim i As Integer
                Dim outputString As StringBuilder = New StringBuilder
                Dim strCostFormat, strQtyFormat As String
                Dim SelectedText As String = "text"
                Dim DocHeader As String
                Dim TotalCost As Double = 0
                Dim SubTotalCost As Double = 0
                Dim SubTotalCost2 As Double = 0
                Dim TotalVAT As Double = 0
                Dim TotalDiscount As Double = 0
                Dim Discount As Double
                Dim VendorAddress As String = ""
                Dim VendorTelFax As String = ""
                Dim DocInfo As String = ""
                Dim ListMaterialId() As String
                Dim Sel As String = ""
			
                SelMaterialID.Value = Request.QueryString("SelMaterialID")
                ReDim Preserve ListMaterialId(-1)
                If SelMaterialID.Value <> "" Then
                    Sel = SelMaterialID.Value
                    If Sel.IndexOf("_") > 0 Then
                        ListMaterialId = Sel.Split("_")
                    Else
                        ReDim Preserve ListMaterialId(1)
                        ListMaterialId(0) = SelMaterialID.Value
                    End If
                End If
			
                If VendorData.Rows.Count > 0 Then
                    DocHeader = FormatHeader.DocumentNumber(VendorData.Rows(0)("ShopID"), VendorData.Rows(0)("DocumentTypeID"), VendorData.Rows(0)("DocumentID"), Session("LangID"), GlobalParam.YearType, objCnn)
                    If Not IsDBNull(VendorData.Rows(0)("DocIDRefShopID")) And Not IsDBNull(VendorData.Rows(0)("DocumentTypeIDRef")) And Not IsDBNull(VendorData.Rows(0)("DocumentIDRef")) Then
                        DocRefText.InnerHtml = "<a href=""JavaScript: newWindow = window.open( 'document_detail.aspx?MaterialID=0" & "&DocumentID=" & VendorData.Rows(i)("DocumentIDRef").ToString & "&ShopID=" & VendorData.Rows(i)("DocIDRefShopID").ToString + "', '', 'width=800,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + FormatHeader.DocumentNumber(VendorData.Rows(0)("DocIDRefShopID"), VendorData.Rows(0)("DocumentTypeIDRef"), VendorData.Rows(0)("DocumentIDRef"), Session("LangID"), GlobalParam.YearType, objCnn) + "</a>"
                    Else
                        DocRefText.InnerHtml = "-"
                    End If
                    StatusText.InnerHtml = VendorData.Rows(0)("DocumentStatusText") ' + "::" + VendorData.Rows(0)("DocumentTypeID").ToString
                    DocTypeText.InnerHtml = VendorData.Rows(0)("DocumentTypeName")
                    DocNoText.InnerHtml = DocHeader
                    DocDateText.InnerHtml = DateTimeUtil.FormatDateTime(VendorData.Rows(0)("DocumentDate"), "DateOnly")
                    If Not IsDBNull(VendorData.Rows(0)("ToInvName")) Then
                        InventoryText.InnerHtml = VendorData.Rows(0)("ToInvName")
                    Else
                        InventoryText.InnerHtml = "-"
                    End If
                    FromInv.Visible = False
                    Select Case VendorData.Rows(0)("DocumentTypeID")
                        Case 25, 1001, 47
                            If VendorData.Rows(0)("FromInvID") <> 0 Then
                                FromInventoryText.InnerHtml = GetInventoryNameFromInventoryView(objDB, objCnn, VendorData.Rows(0)("FromInvID"))
                                FromInv.Visible = True
                            End If
                    End Select
                    ToInv.Visible = False
                    Select Case VendorData.Rows(0)("DocumentTypeID")
                        Case 3, 1000, 46, 17, 1002
                            If VendorData.Rows(0)("ToInvID") <> 0 Then
                                ToInventoryText.InnerHtml = GetInventoryNameFromInventoryView(objDB, objCnn, VendorData.Rows(0)("ToInvID"))
                                ToInv.Visible = True
                            End If
                    End Select
                    If Not IsDBNull(VendorData.Rows(0)("Remark")) Then
                        If Trim(VendorData.Rows(0)("Remark")) = "" Then
                            RemarkText.InnerHtml = "-"
                        Else
                            RemarkText.InnerHtml = VendorData.Rows(0)("Remark")
                        End If
                    Else
                        RemarkText.InnerHtml = "-"
                    End If
                    If Not IsDBNull(VendorData.Rows(0)("VendorCode")) Then
                        VendorCodeText.InnerHtml = VendorData.Rows(0)("VendorCode")
                    Else
                        VendorCodeText.InnerHtml = ""
                    End If
                    If Not IsDBNull(VendorData.Rows(0)("VendorName")) Then
                        VendorNameText.InnerHtml = VendorData.Rows(0)("VendorName")
                    Else
                        VendorNameText.InnerHtml = ""
                    End If
                    If Not IsDBNull(VendorData.Rows(0)("VendorAddress1")) Then
                        VendorAddress += VendorData.Rows(0)("VendorAddress1")
                    End If
                    If Not IsDBNull(VendorData.Rows(0)("VendorAddress2")) Then
                        VendorAddress += " " + VendorData.Rows(0)("VendorAddress2")
                    End If
                    If Not IsDBNull(VendorData.Rows(0)("VendorCity")) Then
                        If Trim(VendorAddress) <> "" Then
                            VendorAddress += "<br>" + VendorData.Rows(0)("VendorCity")
                        Else
                            VendorAddress += VendorData.Rows(0)("VendorCity")
                        End If
                    End If
                    If Not IsDBNull(VendorData.Rows(0)("ProvinceName")) Then
                        VendorAddress += " " + VendorData.Rows(0)("ProvinceName")
                    End If
                    If Not IsDBNull(VendorData.Rows(0)("VendorZipCode")) Then
                        VendorAddress += " " + VendorData.Rows(0)("VendorZipCode")
                    End If
                    VendorAddressText.InnerHtml = VendorAddress
				
                    If Not IsDBNull(VendorData.Rows(0)("VendorTelephone")) Then
                        VendorTelFax += "Tel:" + VendorData.Rows(0)("VendorTelephone")
                    Else
                        VendorTelFax += "Tel:-"
                    End If
                    If Not IsDBNull(VendorData.Rows(0)("VendorFax")) Then
                        VendorTelFax += "/Fax:" + VendorData.Rows(0)("VendorFax")
                    Else
                        VendorTelFax += "/Fax:-"
                    End If
                    VendorTelFaxText.InnerHtml = VendorTelFax
				
                    If VendorData.Rows(0)("TermOfPayment") = 2 Then
                        TermOfPaymentText.InnerHtml = VendorData.Rows(0)("TermOfPaymentText") + " " + VendorData.Rows(0)("CreditDay").ToString + " day(s)"
                    ElseIf VendorData.Rows(0)("TermOfPayment") > 0 Then
                        TermOfPaymentText.InnerHtml = VendorData.Rows(0)("TermOfPaymentText")
                    Else
                        TermOfPaymentText.InnerHtml = "-"
                    End If
                    If Not IsDBNull(VendorData.Rows(0)("DueDate")) Then
                        DueDateText.InnerHtml += DateTimeUtil.FormatDateTime(VendorData.Rows(0)("DueDate"), "DateOnly")
                    Else
                        DueDateText.InnerHtml += "-"
                    End If
                    DocInfo = "<table>"
                    If Not IsDBNull(VendorData.Rows(0)("InputStaff")) Then
                        DocInfo += "<tr><td class=""smallText"">Created By:</td><td class=""smallText"">" + VendorData.Rows(0)("InputStaff") + "</td><td class=""smallText"">" + DateTimeUtil.FormatDateTime(VendorData.Rows(0)("InsertDate"), "DateAndTime") + "</td></tr>"
                    End If
                    If Not IsDBNull(VendorData.Rows(0)("UpdateStaff")) Then
                        DocInfo += "<tr><td class=""smallText"">Updated By:</td><td class=""smallText"">" + VendorData.Rows(0)("InputStaff") + "</td>"
                    End If
                    If Not IsDBNull(VendorData.Rows(0)("UpdateDate")) Then
                        DocInfo += "<td class=""smallText"">" + DateTimeUtil.FormatDateTime(VendorData.Rows(0)("UpdateDate"), "DateAndTime") + "</td></tr>"
                    Else
                        DocInfo += "<td class=""smallText""></td></tr>"
                    End If
                    If Not IsDBNull(VendorData.Rows(0)("ApproveStaff")) Then
                        DocInfo += "<tr><td class=""smallText"">Approved By:</td><td class=""smallText"" colspan=""2"">" + VendorData.Rows(0)("ApproveStaff") + "</td></tr>"
                    End If
                    If Not IsDBNull(VendorData.Rows(0)("VoidStaff")) Then
                        DocInfo += "<tr><td class=""smallText"">Cancelled By:</td><td class=""smallText"" colspan=""2"">" + VendorData.Rows(0)("VoidStaff") + "</td></tr>"
                    End If
                    DocInfo += "</table>"
                End If
                Dim PricePerUnit As Double = 0
                Dim UnitRatioVal As Double = 0
                showStd.Visible = False
                Dim StdPricePerUnit As Double = 0
                Dim StdSubTotal As Double = 0
                Dim StdGrandTotal As Double = 0
                If dtTable.Rows.Count > 0 Then
                    If dtTable.Rows(0)("DocumentTypeID") = 2 Or dtTable.Rows(0)("DocumentTypeID") = 39 Then
                        showStd.Visible = True
                    End If
				
                    showStd.Visible = True
                    strQtyFormat = "#,##0.00"
                    strCostFormat = "#,##0.0000"
                    
                    For i = 0 To dtTable.Rows.Count - 1
                        If IsDBNull(dtTable.Rows(i)("MaterialID")) Then
                            dtTable.Rows(i)("MaterialID") = 0
                        End If
                        If IsDBNull(dtTable.Rows(i)("ProductDiscount")) Then
                            dtTable.Rows(i)("ProductDiscount") = 0
                        End If
                        If IsDBNull(dtTable.Rows(i)("ProductAmount")) Then
                            dtTable.Rows(i)("ProductAmount") = 0
                        End If
                        If IsDBNull(dtTable.Rows(i)("ProductPricePerUnit")) Then
                            dtTable.Rows(i)("ProductPricePerUnit") = 0
                        End If
                        If IsDBNull(dtTable.Rows(i)("ProductDiscountAmount")) Then
                            dtTable.Rows(i)("ProductDiscountAmount") = 0
                        End If
                        If IsDBNull(dtTable.Rows(i)("TotalPrice")) Then
                            dtTable.Rows(i)("TotalPrice") = 0
                        End If
                        If IsDBNull(dtTable.Rows(i)("TotalAmount")) Then
                            dtTable.Rows(i)("TotalAmount") = 0
                        End If
                        If IsDBNull(dtTable.Rows(i)("UnitSmallAmount")) Then
                            dtTable.Rows(i)("UnitSmallAmount") = 0
                        End If
                        If IsDBNull(dtTable.Rows(i)("ProductTax")) Then
                            dtTable.Rows(i)("ProductTax") = 0
                        End If
                        If IsDBNull(dtTable.Rows(i)("ProductTaxType")) Then
                            dtTable.Rows(i)("ProductTaxType") = 0
                        End If
                        If IsDBNull(dtTable.Rows(i)("ProductNetPrice")) Then
                            dtTable.Rows(i)("ProductNetPrice") = 0
                        End If
                        Discount = 0
                        If showStd.Visible = True Then
                            If dtTable.Rows(i)("ProductDiscount") > 0 Then
                                Discount = ((dtTable.Rows(i)("ProductDiscount") * dtTable.Rows(i)("ProductAmount") * dtTable.Rows(i)("ProductPricePerUnit")) / 100)
                            ElseIf dtTable.Rows(i)("ProductDiscountAmount") > 0 Then
                                Discount = dtTable.Rows(i)("ProductDiscountAmount")
                            End If
                        End If
                        If Request.QueryString("MaterialID") = 0 Then
                            If ListMaterialId.Length > 0 Then
                                For n As Integer = 0 To ListMaterialId.Length - 1
                                    If dtTable.Rows(i)("MaterialID") = ListMaterialId(n) Then
                                        SelectedText = "boldText"
                                        Exit For
                                    Else
                                        SelectedText = "text"
                                    End If
                                Next
                            Else
                                If Sel <> "" Then
                                    If dtTable.Rows(i)("MaterialID") = Sel Then
                                        SelectedText = "boldText"
                                    Else
                                        SelectedText = "text"
                                    End If
                                End If
                            End If
                        Else
                            If dtTable.Rows(i)("MaterialID") = Request.QueryString("MaterialID") Then
                                SelectedText = "boldText"
                            Else
                                SelectedText = "text"
                            End If
                        End If
                        PricePerUnit = 0
                        StdPricePerUnit = 0
                        If dtTable.Rows(i)("ProductAmount") = 0 Then
                            UnitRatioVal = 1
                        Else
                            UnitRatioVal = dtTable.Rows(i)("UnitSmallAmount") / dtTable.Rows(i)("ProductAmount")
                        End If
					
                        If showStd.Visible = False Then
                            'If dtTable.Rows(i)("DocumentTypeID") = 10 Then
                            'If dtTable.Rows(i)("TotalAmountPrevious") <> 0 Then
                            'PricePerUnit = dtTable.Rows(i)("TotalPricePrevious")/dtTable.Rows(i)("TotalAmountPrevious")
                            'End If
                            'Else
                            'If dtTable.Rows(i)("TotalAmount") <> 0 Then
                            'PricePerUnit = dtTable.Rows(i)("TotalPrice")/dtTable.Rows(i)("TotalAmount")
                            'End If
                            'End If
                            PricePerUnit = dtTable.Rows(i)("ProductPricePerUnit") / UnitRatioVal
                        Else
                            PricePerUnit = dtTable.Rows(i)("ProductPricePerUnit") / UnitRatioVal
                            If dtTable.Rows(i)("TotalAmount") <> 0 Then
                                StdPricePerUnit = dtTable.Rows(i)("TotalPrice") / dtTable.Rows(i)("TotalAmount")
                            End If
                        End If
                        outputString = outputString.Append("<tr><td align=""center"" class=""" + SelectedText + """>" & (i + 1).ToString & "</td>")
                        outputString = outputString.Append("<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("MaterialCode") & "</td>")
                        outputString = outputString.Append("<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("MaterialName") & "</td>")
                        outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("ProductAmount"), strQtyFormat) & "</td>")
					
                        If ShowPrice = True Then
                            If (PricePerUnit * UnitRatioVal * 1000) < 1 And PricePerUnit * UnitRatioVal <> 0 Then
                                outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(PricePerUnit * UnitRatioVal, "E4") & "</td>")
                            Else
                                outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(PricePerUnit * UnitRatioVal, strCostFormat) & "</td>")
                            End If
                        Else
                            outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & "-" & "</td>")
                        End If
                        outputString = outputString.Append("<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("UnitName") & "</td>")
                        If ShowPrice = True Then
                            outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(Discount, strCostFormat) & "</td>")
                            outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("ProductTax"), strCostFormat) & "</td>")
                            If showStd.Visible = True Then
                                If dtTable.Rows(i)("ProductTaxType") = 2 Then 'Include
                                    SubTotalCost2 = dtTable.Rows(i)("ProductNetPrice")
                                Else
                                    SubTotalCost2 = dtTable.Rows(i)("ProductNetPrice")
                                End If
                                StdSubTotal = dtTable.Rows(i)("UnitSmallAmount") * StdPricePerUnit
                                outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(SubTotalCost2, strCostFormat) & "</td>")
                                outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(StdPricePerUnit * UnitRatioVal, strCostFormat) & "</td>")
                                outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(StdSubTotal, strCostFormat) & "</td>")
                                StdGrandTotal += StdSubTotal
                                TotalCost += dtTable.Rows(i)("ProductNetPrice") + Discount
                            Else
                                If dtTable.Rows(i)("ProductTaxType") = 2 Then 'Include
                                    SubTotalCost2 = dtTable.Rows(i)("UnitSmallAmount") * PricePerUnit
                                Else
                                    SubTotalCost2 = dtTable.Rows(i)("UnitSmallAmount") * PricePerUnit
                                End If
                                outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(SubTotalCost2, strCostFormat) & "</td>")
                                TotalCost += SubTotalCost2
                            End If
						
                            TotalVAT += dtTable.Rows(i)("ProductTax")

                            TotalDiscount += Discount
                        Else
                            outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & "-" & "</td>")
                            outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & "-" & "</td>")
                            outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & "-" & "</td>")
                        End If
                    Next
                    SelectedText = "text"
                    outputString = outputString.Append("<tr><td colspan=""7"" rowspan=""5"" align=""left"" class=""smalltext"" valign=""bottom"">" + DocInfo + "</td>")
                    outputString = outputString.Append("<td bgColor=""" + GlobalParam.GrayBGColor + """ align=""right"" class=""" + SelectedText + """>" & "Sub Total" & "</td>")
                    If ShowPrice = True Then
                        outputString = outputString.Append("<td bgColor=""" + GlobalParam.GrayBGColor + """ align=""right"" class=""" + SelectedText + """>" & Format(TotalCost, strCostFormat) & "</td>")
                    Else
                        outputString = outputString.Append("<td bgColor=""" + GlobalParam.GrayBGColor + """ align=""right"" class=""" + SelectedText + """>" & "-" & "</td>")
                    End If
                    If showStd.Visible = True Then
                        outputString = outputString.Append("<td bgColor=""" + GlobalParam.GrayBGColor + """ align=""right"" class=""" + SelectedText + """>" & "-" & "</td>")
                        outputString = outputString.Append("<td bgColor=""" + GlobalParam.GrayBGColor + """ align=""right"" class=""" + SelectedText + """>" & Format(StdGrandTotal, strCostFormat) & "</td>")
                    End If
                    outputString = outputString.Append("</tr>")
                    outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """><td align=""right"" class=""text"">Discount</td>")
                    If ShowPrice = True Then
                        outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(TotalDiscount, strCostFormat) & "</td></tr>")
                    Else
                        outputString = outputString.Append("<td bgColor=""" + GlobalParam.GrayBGColor + """ align=""right"" class=""" + SelectedText + """>" & "-" & "</td></tr>")
                    End If
                    outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """><td align=""right"" class=""text"">Total</td>")
                    If ShowPrice = True Then
                        outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(TotalCost - TotalDiscount, strCostFormat) & "</td></tr>")
                    Else
                        outputString = outputString.Append("<td bgColor=""" + GlobalParam.GrayBGColor + """ align=""right"" class=""" + SelectedText + """>" & "-" & "</td></tr>")
                    End If
                    outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """><td align=""right"" class=""text"">VAT</td>")
                    If ShowPrice = True Then
                        outputString = outputString.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(TotalVAT, strCostFormat) & "</td></tr>")
                    Else
                        outputString = outputString.Append("<td bgColor=""" + GlobalParam.GrayBGColor + """ align=""right"" class=""" + SelectedText + """>" & "-" & "</td></tr>")
                    End If
                    outputString = outputString.Append("<tr bgColor=""" + GlobalParam.GrayBGColor + """><td align=""right"" class=""boldText"">Grand Total</td>")
                    If ShowPrice = True Then
                        outputString = outputString.Append("<td align=""right"" class=""boldText"">" & Format(TotalCost - TotalDiscount + TotalVAT, strCostFormat) & "</td></tr>")
                    Else
                        outputString = outputString.Append("<td bgColor=""" + GlobalParam.GrayBGColor + """ align=""right"" class=""" + SelectedText + """>" & "-" & "</td></tr>")
                    End If
				
                    ResultText.InnerHtml = outputString.ToString
                Else
                    updateMessage.Text = "No Data"
                End If
                'Catch ex As Exception
                'errorMsg.InnerHtml = ex.Message
                'End Try
		
			
            Else
                updateMessage.Text = "Invalid Parameters"
            End If
        Else
            updateMessage.Text = "Access Denied"
        End If
    End Sub
 
    Private Function GetInventoryNameFromInventoryView(objDB As CDBUtil, ByVal objCnn As MySqlConnection, invID As Integer) As String
        Dim strSQL As String
        Dim dtResult As DataTable
        strSQL = "Select InventoryName From InventoryView Where InventoryID = " & invID
        dtResult = objDB.List(strSQL, objCnn)
        If dtResult.Rows.Count = 0 Then
            Return ""
        ElseIf IsDBNull(dtResult.Rows(0)("InventoryName")) Then
            Return ""
        Else
            Return dtResult.Rows(0)("InventoryName")
        End If
    End Function

	
Sub Page_UnLoad()
	objCnn.Close()
End Sub
</script>

</body>
</html>
