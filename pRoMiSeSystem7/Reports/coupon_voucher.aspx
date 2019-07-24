<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="POSTypeClass" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Voucher/Coupon Reports</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:#FFF">
<div id="showPage" visible="true" runat="server">

<table width="100%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
<td align="right"><div class="noprint"><div class="text"><a href="javascript: window.print()">Print</a> | <a href="javascript: window.close()">Close</a></div></div></td>
</tr>
</table>

<div id="ResultSearchText" runat="server"></div>
<div align="center"><br>
<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
	
	<div id="ResultText" runat="server"></div>
</table></div>

</div>
<div id="errorMsg" runat="server" />

<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getInfo As New CCategory()
Dim getReport As New GenReports()
Dim DateTimeUtil As New MyDateTime()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim FormatDocNumber As New FormatText()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture

    Sub Page_Load()
        'If User.Identity.IsAuthenticated  AND Session("Report_Voucher") Then
		
        'Try	
		
        objCnn = getCnn.EstablishConnection()
        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
        Dim displayTable As New DataTable()
		
        Dim i As Integer
        Dim DateCheck As Boolean
		
        Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)

        Dim strBuild As StringBuilder
        Dim counter, MaxNum As Integer
        Dim ShowSaleDate As String = ""
        Dim bgColor As String = "e9e9e9"
        Dim TypeHeader, TypeString, CouponNumber, TotalPayment As String
        Dim grandTotal As Double = 0
		
        Dim PayTypeID As String = 0
        If IsNumeric(Request.QueryString("PayTypeID")) Then
            PayTypeID = Request.QueryString("PayTypeID")
        End If
		
        'Application.Lock()
        Dim dtTable As DataTable
        If PayTypeID = 0 Then
            Response.Redirect("report_voucher.aspx?ShopID=" + Request.QueryString("ShopID").ToString + "&StartDate=" + Request.QueryString("StartDate") + "&EndDate=" + Request.QueryString("EndDate") + "&FromSale=1")
            dtTable = getReport.CouponVoucher(Session("LangID"), Request.QueryString("ViewOption"), Request.QueryString("StartDate"), Request.QueryString("EndDate"), _
                                           Request.QueryString("ShopID"), objCnn)
			
        Else
            dtTable = PayTypeDetail(PayTypeID, Session("LangID"), Request.QueryString("ViewOption"), Request.QueryString("StartDate"), Request.QueryString("EndDate"), _
                                    Request.QueryString("ShopID"), Request.QueryString("SaleModeID"), objCnn)
        End If
		 
        'Application.UnLock()
        Dim DummyTypeID As Integer = -1

        Dim AdditionalHeaderText, HText, RText As String
        Dim ReceiptHeaderData As DataTable
        ReceiptHeaderData = getInfo.GetDocType(1, 0, 8, Session("LangID"), objCnn)

        strBuild = New StringBuilder
        If ReceiptHeaderData.Rows.Count > 0 Then
            If Not IsDBNull(ReceiptHeaderData.Rows(0)("DocumentTypeHeader")) Then
                AdditionalHeaderText = ReceiptHeaderData.Rows(0)("DocumentTypeHeader")
            End If
        End If

        For i = 0 To dtTable.Rows.Count - 1
			
            If dtTable.Rows(i)("VTypeID") <> DummyTypeID Then
                If dtTable.Rows(i)("VTypeID") = 4 Then
                    TypeHeader = "Coupons"
                    TypeString = "Coupon #"
                ElseIf dtTable.Rows(i)("VTypeID") = 5 Then
                    TypeHeader = "Vouchers"
                    TypeString = "Voucher #"
                Else
                    If PayTypeID = 0 Then
                        TypeHeader = "Cash Coupon"
                        TypeString = "Cash Coupon #"
                    Else
                        Dim PayData As DataTable = getProp.PayTypeData(0, PayTypeID, Session("LangID"), objCnn)
                        If PayData.Rows.Count > 0 Then
                            TypeHeader = PayData.Rows(0)("PayType")
                            TypeString = "Remark"
                        Else
                            TypeHeader = "Cash Coupon"
                            TypeString = "Cash Coupon #"
                        End If
                    End If
                End If
				
                strBuild.Append("<tr><td colspan=""5"" align=""center"" class=""tdHeader"" bgColor=""" + GlobalParam.AdminBGColor + """>" + TypeHeader + "</td></tr>")
                strBuild.Append("<tr><td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>Date</td>" + "<td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>Shop Name</td>" + "<td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>Receipt #</td>" + "<td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>" + TypeString + "</td><td class=""tdHeader"" align=""center"" bgColor=""" + GlobalParam.AdminBGColor + """>Amount</td></tr>")
            End If
            HText = ""
            If PropertyInfo.Rows(0)("FrontSystemType") = 1 Then
                If Not IsDBNull(dtTable.Rows(i)("DocumentTypeHeader")) Then
                    HText = dtTable.Rows(i)("DocumentTypeHeader")
                End If
            Else
                HText = AdditionalHeaderText
            End If
            If IsDBNull(dtTable.Rows(i)("ReceiptID")) Or IsDBNull(dtTable.Rows(i)("ReceiptMonth")) Or IsDBNull(dtTable.Rows(i)("ReceiptYear")) Then
                RText = "-"
            Else
                RText = FormatDocNumber.GetReceiptHeader(HText, dtTable.Rows(i)("ReceiptYear"), dtTable.Rows(i)("ReceiptMonth"), dtTable.Rows(i)("ReceiptID"))
            End If
            ShowSaleDate = DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly", Session("LangID"), objCnn)
            'ShowSaleDate = DateTimeUtil.FormatDateTime(dtTable.Rows(i)("SaleDate"), "DateOnly")
			
            If dtTable.Rows(i)("VTypeID") = 4 Then
                MaxNum = dtTable.Rows(i)("VoucherID") + 1000000
                CouponNumber = dtTable.Rows(i)("VoucherHeader") + "/" + Right(MaxNum.ToString, 6)
                If Not IsDBNull(dtTable.Rows(i)("CouponDiscount")) Then
                    TotalPayment = CDbl(dtTable.Rows(i)("CouponDiscount")).ToString(FormatObject.CurrencyFormat, ci)
                    grandTotal += dtTable.Rows(i)("CouponDiscount")
                End If
            ElseIf dtTable.Rows(i)("VTypeID") = 5 Then
                MaxNum = dtTable.Rows(i)("VoucherID") + 1000000
                CouponNumber = dtTable.Rows(i)("VoucherHeader") + "/" + Right(MaxNum.ToString, 6)
                If Not IsDBNull(dtTable.Rows(i)("VoucherDiscount")) Then
                    TotalPayment = CDbl(dtTable.Rows(i)("UsedAmount")).ToString(FormatObject.CurrencyFormat, ci)
                    grandTotal += dtTable.Rows(i)("UsedAmount")
                End If
            Else
				
                'If Not IsDBNull(dtTable.Rows(i)("GroupName")) Then
                'CouponNumber = dtTable.Rows(i)("GroupName")
                'Else
                'CouponNumber = dtTable.Rows(i)("PayType")
                'End If
				
                If Not IsDBNull(dtTable.Rows(i)("PayType")) Then
                    CouponNumber = dtTable.Rows(i)("PayType")
                Else
                    CouponNumber = ""
                End If
				
                Select Case dtTable.Rows(i)("IsFromEDC")
                    Case POSType.EDCType_RBSC_Coca, POSType.EDCType_BuzzeBee_Payment, POSType.EDCType_ValueDesignCashCard, POSType.EDCType_ValueDesignPoint
                        If Not IsDBNull(dtTable.Rows(i)("CreditCardNo")) Then
                            If Trim(dtTable.Rows(i)("CreditCardNo")) <> "" Then
                                CouponNumber  &= " (" & dtTable.Rows(i)("CreditCardNo") & ") "
                            End If
                        End If
                        
                    Case Else
                        If Not IsDBNull(dtTable.Rows(i)("CashCouponNumber")) Then
                            If Trim(dtTable.Rows(i)("CashCouponNumber")) <> "" Then
                                CouponNumber += " (" + dtTable.Rows(i)("CashCouponNumber") + ")"
                            End If
                        End If
                End Select
				
                If Not IsDBNull(dtTable.Rows(i)("TotalPayment")) Then
                    TotalPayment = CDbl(dtTable.Rows(i)("TotalPayment")).ToString(FormatObject.CurrencyFormat, ci)
                    grandTotal += dtTable.Rows(i)("TotalPayment")
                End If
            End If
            If (Not IsDBNull(dtTable.Rows(i)("CashCouponNumber")) And dtTable.Rows(i)("VTypeID") <> 4 And dtTable.Rows(i)("VTypeID") <> 5) Or dtTable.Rows(i)("VTypeID") = 4 Or dtTable.Rows(i)("VTypeID") = 5 Then
                strBuild.Append("<tr>")
                strBuild.Append("<td align=""left"" class=""text"">" & ShowSaleDate & "</td>")
                strBuild.Append("<td align=""left"" class=""text"">" & dtTable.Rows(i)("ProductLevelName") & "</td>")
                If RText <> "-" Then
                    strBuild.Append("<td align=""left"" class=""text""><a href=""JavaScript: newWindow = window.open( '../Reports/BillDetails.aspx?ComputerID=" + dtTable.Rows(i)("ComputerID").ToString + "&ShopID=" + dtTable.Rows(i)("ShopID").ToString + "&TransactionID=" + dtTable.Rows(i)("TransactionID").ToString + "', '', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & RText & "</a></td>")
                Else
                    strBuild.Append("<td align=""left"" class=""text"">" & RText & "</td>")
                End If
                strBuild.Append("<td align=""left"" class=""text"">" & CouponNumber & "</td>")
                strBuild.Append("<td align=""right"" class=""text"">" & TotalPayment & "</td>")
				
                strBuild.Append("</tr>")
                counter = counter + 1
            End If
            DummyTypeID = dtTable.Rows(i)("VTypeID")

        Next
        If grandTotal <> 0 Then
            strBuild.Append("<tr><td align=""right"" class=""text"" colspan=""4"">Total</td>")
            strBuild.Append("<td align=""right"" class=""text"">" & CDbl(grandTotal).ToString(FormatObject.CurrencyFormat, ci) & "</td></tr>")
        End If
        If dtTable.Rows.Count = 0 Then
            strBuild = New StringBuilder
            strBuild.Append("<tr><td class=""boldText"" colspan=""4"">No Data Found</td></tr>")
        End If
        ResultText.InnerHtml = strBuild.ToString
					
        'Catch ex As Exception
        'errorMsg.InnerHtml = ex.Message
        'End Try
	  
        '	Else
        '		showPage.Visible = False
        '		errorMsg.InnerHtml = "Access Denied"
        '	End If
    End Sub

    Public Function PayTypeDetail(ByVal PayTypeID As Integer, ByVal LangID As Integer, ByVal ViewOption As Integer, ByVal StartDate As String, ByVal EndDate As String, _
    ByVal ShopID As String, filterSaleModeID As String, ByVal objCnn As MySqlConnection) As DataTable

        Dim sqlStatement As String
        Dim AdditionalQuery As String = ""
        Dim bolIsOtherReceipt As Boolean
        Dim dtPayType As DataTable
        Dim getProp As New CPreferences

        Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
       

        If ShopID <> "0" Then
            AdditionalQuery += " AND a.ShopID IN (" & ShopID & ")"
        End If

        If StartDate <> "" And EndDate <> "" Then
            AdditionalQuery += " AND (a.SaleDate >= " + StartDate + " AND a.SaleDate < " + EndDate + ")"
        Else
            AdditionalQuery += " AND 0=1"
        End If
        If filterSaleModeID <> "" Then
            AdditionalQuery &= " AND a.SaleMode IN (" & filterSaleModeID & ") "
        End If

        Dim ReportType As Integer = 0

        Dim Chk As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramTypeID=2 AND PropertyID=16 AND KeyID=1", objCnn)
        If Chk.Rows.Count > 0 Then
            ReportType = Chk.Rows(0)("PropertyValue")
        End If

        sqlStatement = "Select IsOtherReceipt From PayType Where TypeID = " & PayTypeID
        dtPayType = objDB.List(sqlStatement, objCnn)
        If dtPayType.Rows.Count = 0 Then
            bolIsOtherReceipt = False
        ElseIf dtPayType.Rows(0)("IsOtherReceipt") = 1 Then
            bolIsOtherReceipt = True
        Else
            bolIsOtherReceipt = False
        End If

        If bolIsOtherReceipt = False Then
            If ReportType = 0 Then 'combine credit card
                sqlStatement = "select 0 AS VTypeID,a.ShopID,pl.ProductLevelName,a.TransactionID,a.ComputerID,a.SaleDate,a.ReceiptID,a.ReceiptMonth,a.ReceiptYear, " & _
                               "c.Amount AS TotalPayment,c.PaidByName AS CashCouponNumber,c.PayTypeID,f.PayType,f.PayTypeCode, e.DocumentTypeHeader,pt.PayType As GroupName, " & _
                               "c.IsFromEDC, c.CreditCardNo " & _
                               "from OrderTransaction a inner join PayDetail c ON a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID " & _
                               " left outer join DocumentType e ON a.CloseComputerID=e.ComputerID AND e.LangID=1 AND e.DocumentTypeID=8 AND e.ShopID=0 " & _
                               " LEFT OUTER JOIN PayType f ON c.PayTypeID=f.TypeID left outer join PayType pt ON c.SmartcardType=pt.TypeID " & _
                               " left outer join ProductLevel pl ON a.ShopID=pl.ProductLevelID WHERE a.TransactionStatusID=2 AND a.ReceiptID>0 AND " & _
                               " c.PayTypeID=" + PayTypeID.ToString + AdditionalQuery & _
                               " order by a.ShopID, pl.ProductLevelCode,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"
            Else
                'separate credit card
                sqlStatement = "select * from (select 0 AS VTypeID,a.ShopID,pl.ProductLevelName,a.TransactionID,a.ComputerID,a.SaleDate,a.ReceiptID,a.ReceiptMonth, " & _
                               " a.ReceiptYear,c.Amount AS TotalPayment,c.PaidByName AS CashCouponNumber,IF(c.SmartcardType>0,pt.TypeID,f.TypeID) As PayTypeID, " & _
                               " IF(SmartcardType>0,pt.PayType,f.PayType) As PayType,IF(SmartcardType>0,pt.PayTypecode,f.PayTypeCode) As PayTypeCode, e.DocumentTypeHeader, " & _
                               " pt.PayType As GroupName, c.IsFromEDC, c.CreditCardNo " & _
                               "from OrderTransaction a inner join PayDetail c ON a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID " & _
                               " left outer join DocumentType e ON a.CloseComputerID=e.ComputerID AND e.LangID=1 AND e.DocumentTypeID=8 AND e.ShopID=0 " & _
                               " LEFT OUTER JOIN PayType f ON c.PayTypeID=f.TypeID left outer join PayType pt ON c.SmartcardType=pt.TypeID " & _
                               " left outer join ProductLevel pl ON a.ShopID=pl.ProductLevelID " & _
                               "WHERE a.TransactionStatusID=2 AND a.ReceiptID>0 " & AdditionalQuery & ") aa where aa.PayTypeID=" & PayTypeID.ToString & _
                               " order by ShopID,ReceiptYear,ReceiptMonth,ReceiptID"
            End If
            'errorMsg.InnerHtml = sqlStatement
        Else
            'Stock Only Payment
            If ReportType = 0 Then 'combine credit card
                sqlStatement = "select 0 AS VTypeID,a.ShopID,pl.ProductLevelName,a.TransactionID,a.ComputerID,a.SaleDate,a.ReceiptID,a.ReceiptMonth,a.ReceiptYear, " & _
                            "c.Amount AS TotalPayment,c.PaidByName AS CashCouponNumber,c.PayTypeID,f.PayType,f.PayTypeCode, e.DocumentTypeHeader,pt.PayType As GroupName, " & _
                            " c.IsFromEDC, c.CreditCardNo " & _
                            "from OrderTransaction a inner join PayDetail c ON a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID " & _
                            " left outer join DocumentType e ON e.ComputerID=0 AND a.ShopID = e.ShopID AND e.LangID=1 AND e.DocumentTypeID=a.DocType " & _
                            " LEFT OUTER JOIN PayType f ON c.PayTypeID=f.TypeID left outer join PayType pt ON c.SmartcardType=pt.TypeID " & _
                            " left outer join ProductLevel pl ON a.ShopID=pl.ProductLevelID " & _
                            "WHERE a.TransactionStatusID=11 AND a.ReceiptID>0 AND c.PayTypeID=" & PayTypeID.ToString & AdditionalQuery & _
                            " order by a.ShopID, pl.ProductLevelCode,a.ReceiptYear,a.ReceiptMonth,a.ReceiptID"
            Else 'separate credit card
                sqlStatement = "select * from (select 0 AS VTypeID,a.ShopID,pl.ProductLevelName,a.TransactionID,a.ComputerID,a.SaleDate,a.ReceiptID,a.ReceiptMonth,a.ReceiptYear, " & _
                                "  c.Amount AS TotalPayment,c.PaidByName AS CashCouponNumber,IF(c.SmartcardType>0,pt.TypeID,f.TypeID) As PayTypeID," & _
                                " IF(SmartcardType>0,pt.PayType,f.PayType) As PayType,IF(SmartcardType>0,pt.PayTypecode,f.PayTypeCode) As PayTypeCode, " & _
                                " e.DocumentTypeHeader,pt.PayType As GroupName, c.IsFromEDC, c.CreditCardNo " & _
                                " from OrderTransaction a inner join PayDetail c ON a.TransactionID=c.TransactionID AND a.ComputerID=c.ComputerID " & _
                                "  left outer join DocumentType e ON e.ComputerID = 0 AND e.LangID=1 AND e.DocumentTypeID=a.DocType AND e.ShopID=a.ShopID " & _
                                "  LEFT OUTER JOIN PayType f ON c.PayTypeID=f.TypeID left outer join PayType pt ON c.SmartcardType=pt.TypeID " & _
                                "  left outer join ProductLevel pl ON a.ShopID=pl.ProductLevelID " & _
                                " WHERE a.TransactionStatusID=11 AND a.ReceiptID>0 " & AdditionalQuery & ") aa where aa.PayTypeID=" & PayTypeID.ToString & _
                                " order by ShopID,ReceiptYear,ReceiptMonth,ReceiptID"
            End If
        End If

        Dim GetData As DataTable = objDB.List(sqlStatement, objCnn)

        Return GetData

    End Function

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
