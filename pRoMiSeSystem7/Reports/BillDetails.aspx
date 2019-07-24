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
<html>
<head>
<title>Bill Details</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">
<form id="mainForm" runat="server">
<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<div class="noprint">
<table cellpadding="2" cellspacing="2" width="90%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
<td align="right"><div class="text"><a href="javascript: window.print()"><asp:Label ID="PrintText" Text="Print" runat="server" /></a> | <a href="javascript: window.close()"><asp:Label ID="CloseText" Text="Close Windows" runat="server" /></a></div></td>
</tr>
<tr><td height="5" colspan="2"></td></tr>
<tr><td><div id="CostText" class="text" runat="server"></div></td>
<td align="right"><div class="text" id="GoBackText" runat="server"></div></td></tr>
<tr><td height="5" colspan="2"></td></tr>
</table>
</div>
<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="90%">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="Text6" runat="server"></div></td>	
		<td id="headerTD9" align="center" class="tdHeader" runat="server"><div id="Text9" runat="server"></div></td>
		<td id="headerTD10" align="center" class="tdHeader" runat="server"><div id="Text10" runat="server"></div></td>
        <td id="headerTD11" align="center" class="tdHeader" runat="server"><div id="Text11" runat="server"></div></td>
        <td id="headerTD12" align="center" class="tdHeader" runat="server"><div id="Text12" runat="server"></div></td>
        <td id="headerTD13" align="center" class="tdHeader" runat="server"><div id="Text13" runat="server"></div></td>
	</tr>
	<div id="ResultText" runat="server"></div>
	
<p>&nbsp;</p>
</form>


<div id="errorMsg" runat="server" />

<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim Fm As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim FormatDocNumber As New FormatText()
Dim DateTimeUtil As New MyDateTime()
Dim getInfo As New CCategory()
Dim objDB As New CDBUtil()
Dim getReport As New GenReports()
Dim Reports As New ReportV6()
Dim getProp As New CPreferences()
Dim PageID As Integer = 6
		
    Sub Page_Load()
        If User.Identity.IsAuthenticated And IsNumeric(Request.QueryString("ComputerID")) And IsNumeric(Request.QueryString("TransactionID")) Then
            objCnn = getCnn.EstablishConnection()
		
            Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
            Dim LangData2 As DataTable = getProp.GetLangData(PageID, 2, -1, Request)
            Dim LangText As String = "lang" + Session("LangID").ToString
            Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
            Dim ci As New CultureInfo(FormatObject.CultureString)
            PrintText.Text = LangDefault.Rows(20)(LangText)
            CloseText.Text = LangDefault.Rows(21)(LangText)
				
            headerTD1.BgColor = GlobalParam.AdminBGColor
            headerTD2.BgColor = GlobalParam.AdminBGColor
            headerTD3.BgColor = GlobalParam.AdminBGColor
            headerTD4.BgColor = GlobalParam.AdminBGColor
            headerTD5.BgColor = GlobalParam.AdminBGColor
            headerTD6.BgColor = GlobalParam.AdminBGColor
            headerTD9.BgColor = GlobalParam.AdminBGColor
            headerTD10.BgColor = GlobalParam.AdminBGColor
            headerTD11.BgColor = GlobalParam.AdminBGColor
            headerTD12.BgColor = GlobalParam.AdminBGColor
            headerTD13.BgColor = GlobalParam.AdminBGColor
		
            If GlobalParam.ShowSubmitOrderDetail = False Then
                headerTD11.Visible = False
                headerTD12.Visible = False
                headerTD13.Visible = False
            End If
			
            'Try		
            Dim AdditionalHeaderText As String = ""

            Text1.InnerHtml = ""
            Text2.InnerHtml = LangData2.Rows(33)(LangText)
            Text3.InnerHtml = LangData2.Rows(34)(LangText)
            Text4.InnerHtml = LangData2.Rows(36)(LangText)
            Text5.InnerHtml = LangData2.Rows(37)(LangText)
            Text6.InnerHtml = LangData2.Rows(38)(LangText)
            Text9.InnerHtml = ""
            Text10.InnerHtml = LangData2.Rows(127)(LangText)
            Text11.InnerHtml = "Terminal"
            Text12.InnerHtml = "Order Staff"
            Text13.InnerHtml = "Order Time"

			
            If Not Page.IsPostBack Then

                Dim ShopProp As DataTable = getInfo.GetProductLevel(Request.QueryString("ShopID"), objCnn)
                If ShopProp.Rows(0)("DisplayOrderBookRecord") = 1 Then
                    'headerTD8.Visible = True
                End If
				
                Dim outputString As String = ""
				
                Dim TotalSale As Double = 0
                Dim bgColor As String = "e9e9e9"
                Dim TotalCreditMoney As Double = 0
                Dim TotalPay As Double = 0
                Dim outString As String = ""
			
                Dim LangPath As String = Util.GetLangPath(Request.PhysicalApplicationPath)
                Dim GraphData As New DataSet()
                Dim StartDate As String = ""
                Dim EndDate As String = ""
                Dim OrderBy As String = ""
				
                ResultText.InnerHtml = Reports.BillDetailReport(outputString, GlobalParam.GrayBGColor, GlobalParam.AdminBGColor, GlobalParam.ShowSubmitOrderDetail, _
                                      Session("LangID"), StartDate, EndDate, Request.QueryString("ShopID"), _
                                      Request.QueryString("TransactionID"), Request.QueryString("ComputerID"), LangPath, LangDefault, LangData2, OrderBy, _
                                      Session("StaffRole"), objCnn)
				
                'ResultText.InnerHtml = BillDetailReport(outputString,GlobalParam.GrayBGColor,GlobalParam.AdminBGColor,Session("LangID"),"{ d '2013-09-26' }","{ d '2013-09-27' }",Request.QueryString("ShopID"), 0, 0, LangPath, LangDefault, LangData2,OrderBy, Session("StaffRole"), objCnn)

				
            End If

            'Catch ex As Exception
            'errorMsg.InnerHtml = ex.Message
            'End Try

        Else
            updateMessage.Text = "Access Denied"
        End If
    End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
