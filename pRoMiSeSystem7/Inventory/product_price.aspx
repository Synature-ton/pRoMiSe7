<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSTypeClass" %>
<%@Import Namespace="pRoMiSeUtil.pRoMiSeUtil" %>
<%@Import Namespace="pRoMiSeLanguage" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>

<html>
<head>
<title>Manage User Roles</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">

<ASP:Label id="updateMessage" CssClass="text" runat="server" />

<table cellpadding="2" cellspacing="2" width="100%">
<tr>
<td align="left" colspan="2"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
</tr>
<tr><td height="5" colspan="2"></td></tr>
<tr><td><div id="CostText" class="text" runat="server"></div></td>
<td align="right"><div class="text" id="GoBackText" runat="server"></div></td></tr>
<tr><td height="5" colspan="2"></td></tr>
</table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="OrderText" runat="server"></div></td>
        <td id="headerTD8" align="center" class="tdHeader" runat="server"><div id="FromDateText" runat="server"></div></td>
        <td id="headerTD9" align="center" class="tdHeader" runat="server"><div id="ToDateText" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="SetPriceText" runat="server"></div></td>
		<td id="tdPriceSM" align="center" class="tdHeader" runat="server"><div id="PriceText" runat="server"></div></td>
        <td id="tdPriceSM2" align="center" class="tdHeader" runat="server"><div id="PriceTextSM2" runat="server"></div></td>
        <td id="tdPriceSM3" align="center" class="tdHeader" runat="server"><div id="PriceTextSM3" runat="server"></div></td>
        <td id="tdPriceSM4" align="center" class="tdHeader" runat="server"><div id="PriceTextSM4" runat="server"></div></td>
        <td id="tdPriceSM5" align="center" class="tdHeader" runat="server"><div id="PriceTextSM5" runat="server"></div></td>
        <td id="tdPriceSM6" align="center" class="tdHeader" runat="server"><div id="PriceTextSM6" runat="server"></div></td>
        <td id="tdPriceSM7" align="center" class="tdHeader" runat="server"><div id="PriceTextSM7" runat="server"></div></td>
        <td id="tdPriceSM8" align="center" class="tdHeader" runat="server"><div id="PriceTextSM8" runat="server"></div></td>
        <td id="tdPriceSM9" align="center" class="tdHeader" runat="server"><div id="PriceTextSM9" runat="server"></div></td>
        <td id="tdPriceSM10" align="center" class="tdHeader" runat="server"><div id="PriceTextSM10" runat="server"></div></td>
        <td id="tdPriceSM11" align="center" class="tdHeader" runat="server"><div id="PriceTextSM11" runat="server"></div></td>
        <td id="tdPriceSM12" align="center" class="tdHeader" runat="server"><div id="PriceTextSM12" runat="server"></div></td>
        <td id="tdPriceSM13" align="center" class="tdHeader" runat="server"><div id="PriceTextSM13" runat="server"></div></td>
        <td id="tdPriceSM14" align="center" class="tdHeader" runat="server"><div id="PriceTextSM14" runat="server"></div></td>
        <td id="tdPriceSM15" align="center" class="tdHeader" runat="server"><div id="PriceTextSM15" runat="server"></div></td>
        <td id="tdPriceSM16" align="center" class="tdHeader" runat="server"><div id="PriceTextSM16" runat="server"></div></td>
        <td id="tdPriceSM17" align="center" class="tdHeader" runat="server"><div id="PriceTextSM17" runat="server"></div></td>
        <td id="tdPriceSM18" align="center" class="tdHeader" runat="server"><div id="PriceTextSM18" runat="server"></div></td>
        <td id="tdPriceSM19" align="center" class="tdHeader" runat="server"><div id="PriceTextSM19" runat="server"></div></td>
        <td id="tdPriceSM20" align="center" class="tdHeader" runat="server"><div id="PriceTextSM20" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="RemarkText" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="DefaultText" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="SetDefaultText" runat="server"></div></td>
		<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="ActionText" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>
	
	<div id="showAddMessage" runat="server">
	<form id="mainForm" runat="server">
	<input type="hidden" id="ProductID" runat="server">
	<input type="hidden" id="ProductPriceID" runat="server">
    <input type="hidden" id="PriceFromDate" runat="server">
    <input type="hidden" id="PriceToDate" runat="server">
	<tr id="AddDataText" runat="server">
		<td align="center"><div id="counterText" class="text" runat="server"></div></td>
        <td align="center"><div id="ValidateFromDate" class="errorText" runat="server"></div><synature:date id="FromDate" runat="server" /></td>
        <td></td>
		<td><table cellpadding="0" cellspacing="0"><tr><td class="text"><asp:textbox ID="Percentage" Visible="false" Width="30" runat="server" /></td><td width="5"></td><td><div id="selectPercentText" class="text" visible="false" runat="server"></div></td></tr></table></td>
		<td align="right"><div id="ValidateAmount" class="errorText" runat="server"></div><asp:textbox ID="ProductPrice" Width="100" runat="server" /></td>
        <td id="tdSM2" visible="false" runat="server" align="right"><div id="ValidateAmountSM2" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM2" Width="100" runat="server" /></td>
        <td id="tdSM3" visible="false" runat="server" align="right"><div id="ValidateAmountSM3" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM3" Width="100" runat="server" /></td>
        <td id="tdSM4" visible="false" runat="server" align="right"><div id="ValidateAmountSM4" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM4" Width="100" runat="server" /></td>
        <td id="tdSM5" visible="false" runat="server" align="right"><div id="ValidateAmountSM5" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM5" Width="100" runat="server" /></td>
        <td id="tdSM6" visible="false" runat="server" align="right"><div id="ValidateAmountSM6" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM6" Width="100" runat="server" /></td>
        <td id="tdSM7" visible="false" runat="server" align="right"><div id="ValidateAmountSM7" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM7" Width="100" runat="server" /></td>
        <td id="tdSM8" visible="false" runat="server" align="right"><div id="ValidateAmountSM8" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM8" Width="100" runat="server" /></td>
        <td id="tdSM9" visible="false" runat="server" align="right"><div id="ValidateAmountSM9" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM9" Width="100" runat="server" /></td>
        <td id="tdSM10" visible="false" runat="server" align="right"><div id="ValidateAmountSM10" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM10" Width="100" runat="server" /></td>
        <td id="tdSM11" visible="false" runat="server" align="right"><div id="ValidateAmountSM11" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM11" Width="100" runat="server" /></td>
        <td id="tdSM12" visible="false" runat="server" align="right"><div id="ValidateAmountSM12" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM12" Width="100" runat="server" /></td>
        <td id="tdSM13" visible="false" runat="server" align="right"><div id="ValidateAmountSM13" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM13" Width="100" runat="server" /></td>
        <td id="tdSM14" visible="false" runat="server" align="right"><div id="ValidateAmountSM14" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM14" Width="100" runat="server" /></td>
        <td id="tdSM15" visible="false" runat="server" align="right"><div id="ValidateAmountSM15" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM15" Width="100" runat="server" /></td>
        <td id="tdSM16" visible="false" runat="server" align="right"><div id="ValidateAmountSM16" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM16" Width="100" runat="server" /></td>
        <td id="tdSM17" visible="false" runat="server" align="right"><div id="ValidateAmountSM17" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM17" Width="100" runat="server" /></td>
        <td id="tdSM18" visible="false" runat="server" align="right"><div id="ValidateAmountSM18" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM18" Width="100" runat="server" /></td>
        <td id="tdSM19" visible="false" runat="server" align="right"><div id="ValidateAmountSM19" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM19" Width="100" runat="server" /></td>
        <td id="tdSM20" visible="false" runat="server" align="right"><div id="ValidateAmountSM20" class="errorText" runat="server"></div><asp:textbox ID="ProductPriceSM20" Width="100" runat="server" /></td>
		<td align="left"><asp:textbox ID="PriceRemark" Width="150" MaxLength="100" runat="server" /></td>
		<td id="show1" visible="false" runat="server"></td>
		<td align="center" id="show2" visible="false" runat="server"><asp:checkbox ID="MainPriceValue" runat="server" /></td>
		<td align="center"><table cellpadding="0" cellspacing="0"><tr><td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="45" OnClick="DoAddUpdate" runat="server" /></td><td width="5"></td><td><div id="CancelUpdate" runat="server"></div></td></tr></table></td>
	</tr>
	</form>
	</div>
</table>

<div id="errorMsg" runat="server" />

<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getInfo As New CCategory()
Dim getPageText As New DefaultText()
Dim DateTimeUtil As New MyDateTime()
Dim objDB As New CDBUtil()
Dim getProp As New CPreferences()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PriceBeginDate As String = "{ d '2000-01-01' }"
Dim PriceEndDate As String = "{ d '9999-01-01' }"
	
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Inv_Product_Category") Then
	  
            If Not Request.QueryString("ProductID") And IsNumeric(Request.QueryString("ProductID")) Then
	  	
                'If Request.QueryString("a")	= "yes" Then
                'showAddMessage.Visible = False
                'End If
		
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
                ProductID.Value = Request.QueryString("ProductID")
		
                headerTD1.BgColor = GlobalParam.AdminBGColor
                headerTD2.BgColor = GlobalParam.AdminBGColor
                tdPriceSM.BgColor = GlobalParam.AdminBGColor
                headerTD4.BgColor = GlobalParam.AdminBGColor
                headerTD5.BgColor = GlobalParam.AdminBGColor
                headerTD6.BgColor = GlobalParam.AdminBGColor
                headerTD7.BgColor = GlobalParam.AdminBGColor
                headerTD8.BgColor = GlobalParam.AdminBGColor
                headerTD9.BgColor = GlobalParam.AdminBGColor
		
                tdPriceSM2.BgColor = GlobalParam.AdminBGColor
                tdPriceSM3.BgColor = GlobalParam.AdminBGColor
                tdPriceSM4.BgColor = GlobalParam.AdminBGColor
                tdPriceSM5.BgColor = GlobalParam.AdminBGColor
                tdPriceSM6.BgColor = GlobalParam.AdminBGColor
                tdPriceSM7.BgColor = GlobalParam.AdminBGColor
                tdPriceSM8.BgColor = GlobalParam.AdminBGColor
                tdPriceSM9.BgColor = GlobalParam.AdminBGColor
                tdPriceSM10.BgColor = GlobalParam.AdminBGColor
                tdPriceSM11.BgColor = GlobalParam.AdminBGColor
                tdPriceSM12.BgColor = GlobalParam.AdminBGColor
                tdPriceSM13.BgColor = GlobalParam.AdminBGColor
                tdPriceSM14.BgColor = GlobalParam.AdminBGColor
                tdPriceSM15.BgColor = GlobalParam.AdminBGColor
                tdPriceSM16.BgColor = GlobalParam.AdminBGColor
                tdPriceSM17.BgColor = GlobalParam.AdminBGColor
                tdPriceSM18.BgColor = GlobalParam.AdminBGColor
                tdPriceSM19.BgColor = GlobalParam.AdminBGColor
                tdPriceSM20.BgColor = GlobalParam.AdminBGColor

                headerTD5.Visible = False
                headerTD6.Visible = False
			
                'Try
                objCnn = getCnn.EstablishConnection()

                Dim dtTable As New DataTable()
                dtTable = getInfo.GetProductInfo(0, Request.QueryString("ProductID"), objCnn)
			
                If dtTable.Rows.Count <> 0 Then
			
                    Dim textTable As New DataTable()
                    textTable = getPageText.GetText(8, Session("LangID"), objCnn)
				
                    Dim defaultTextTable As New DataTable()
                    defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
				
                    Dim LangDefault As DataTable = getProp.GetLangData(999, 2, -1, Request)
                    Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
                    Dim ci As New CultureInfo(FormatObject.CultureString)
                    Dim ci_us As New CultureInfo("en-US")
				
                    'GoBackText.InnerHtml = "<a href=""product_category.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") +  "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + """>" + textTable.Rows(12)("TextParamValue") + "</a>"
                    GoBackText.InnerHtml = "<a href=""javascript: window.close()"">Close Windows</a>"
				
                    HeaderText.InnerHtml = textTable.Rows(39)("TextParamValue") + dtTable.Rows(0)("ProductName")
                    OrderText.InnerHtml = textTable.Rows(1)("TextParamValue")
                    SetPriceText.InnerHtml = textTable.Rows(19)("TextParamValue")
                    PriceText.InnerHtml = textTable.Rows(20)("TextParamValue") + " (" + defaultTextTable.Rows(10)("TextParamValue") + ")"
                    RemarkText.InnerHtml = textTable.Rows(21)("TextParamValue")
                    DefaultText.InnerHtml = textTable.Rows(22)("TextParamValue")
                    ActionText.InnerHtml = textTable.Rows(7)("TextParamValue")
                    SetDefaultText.InnerHtml = textTable.Rows(23)("TextParamValue")
                    FromDateText.InnerHtml = "From Date"
                    ToDateText.InnerHtml = "To Date"
				
                    FromDate.Visible = True
                    FromDate.YearType = GlobalParam.YearType
                    FromDate.FormName = "FromDate"
                    FromDate.StartYear = GlobalParam.StartYear
                    FromDate.EndYear = GlobalParam.EndYear
                    FromDate.LangID = Session("LangID")
                    FromDate.Lang_Data = LangDefault
                    FromDate.Culture = FormatObject.CultureString
				
                    Dim FromDate_Day, FromDate_Month, FromDate_Year As Integer
				
                    If IsNumeric(Request.Form("FromDate_Day")) Then
                        FromDate_Day = Request.Form("FromDate_Day")
                    ElseIf IsNumeric(Request.QueryString("FromDate_Day")) Then
                        FromDate_Day = Request.QueryString("FromDate_Day")
                    ElseIf Trim(FromDate_Day) = "" Then
                        FromDate_Day = DateTime.Now.Day
                    ElseIf Trim(FromDate_Day) = 0 And Not Page.IsPostBack Then
                        FromDate_Day = DateTime.Now.Day
                    End If
                    If Page.IsPostBack And Request.Form("FromDate_Day") = "" Then FromDate_Day = 0
                    FromDate.SelectedDay = FromDate_Day
				
                    If IsNumeric(Request.Form("FromDate_Month")) Then
                        FromDate_Month = Request.Form("FromDate_Month")
                    ElseIf IsNumeric(Request.QueryString("FromDate_Month")) Then
                        FromDate_Month = Request.QueryString("FromDate_Month")
                    ElseIf Trim(FromDate_Month) = "" Then
                        FromDate_Month = DateTime.Now.Month
                    ElseIf Trim(FromDate_Month) = 0 And Not Page.IsPostBack Then
                        FromDate_Month = DateTime.Now.Month
                    End If
                    If Page.IsPostBack And Request.Form("FromDate_Month") = "" Then FromDate_Month = 0
                    FromDate.SelectedMonth = FromDate_Month
				
                    If IsNumeric(Request.Form("FromDate_Year")) Then
                        FromDate_Year = Request.Form("FromDate_Year")
                    ElseIf IsNumeric(Request.QueryString("FromDate_Year")) Then
                        FromDate_Year = Request.QueryString("FromDate_Year")
                    ElseIf Trim(FromDate_Year) = "" Then
                        FromDate_Year = DateTime.Now.Year
                    ElseIf Trim(FromDate_Year) = 0 And Not Page.IsPostBack Then
                        FromDate_Year = DateTime.Now.Year
                    End If
                    If Page.IsPostBack And Request.Form("FromDate_Year") = "" Then FromDate_Year = 0
                    FromDate.SelectedYear = FromDate_Year
				
				
                    Dim costTable As New DataTable()
                    costTable = getInfo.GetProductCost(Request.QueryString("ProductID"), -1, objCnn)
				
                    Dim costTextValue As String = "0"
                    If costTable.Rows.Count > 0 Then
                        If IsNumeric(costTable.Rows(0)("TotalCost")) Then
                            costTextValue = CDbl(costTable.Rows(0)("TotalCost")).ToString(FormatObject.CurrencyFormat, ci)
                        Else
                            costTextValue = "N/A"
                        End If
                    End If
                    CostText.InnerHtml = textTable.Rows(16)("TextParamValue") + " " + dtTable.Rows(0)("ProductName") + " " + textTable.Rows(17)("TextParamValue") + " " + costTextValue '+ " " + defaultTextTable.Rows(10)("TextParamValue")
				
				
                    Dim i, counter, j, k As Integer
                    Dim strTemp As String
                    Dim dtSMData As DataTable
                    dtSMData = POSDBSQLFront.POSUtilSQL.ListAllSaleMode(objDB, objCnn)
			
                    tdSM2.Visible = False
                    tdSM3.Visible = False
                    tdSM4.Visible = False
                    tdSM5.Visible = False
                    tdSM6.Visible = False
                    tdSM7.Visible = False
                    tdSM8.Visible = False
                    tdSM9.Visible = False
                    tdSM10.Visible = False
                    tdSM11.Visible = False
                    tdSM12.Visible = False
                    tdSM13.Visible = False
                    tdSM14.Visible = False
                    tdSM15.Visible = False
                    tdSM16.Visible = False
                    tdSM17.Visible = False
                    tdSM18.Visible = False
                    tdSM19.Visible = False
                    tdSM20.Visible = False
                    
                    tdPriceSM2.Visible = False
                    tdPriceSM3.Visible = False
                    tdPriceSM4.Visible = False
                    tdPriceSM5.Visible = False
                    tdPriceSM6.Visible = False
                    tdPriceSM7.Visible = False
                    tdPriceSM8.Visible = False
                    tdPriceSM9.Visible = False
                    tdPriceSM10.Visible = False
                    tdPriceSM11.Visible = False
                    tdPriceSM12.Visible = False
                    tdPriceSM13.Visible = False
                    tdPriceSM14.Visible = False
                    tdPriceSM15.Visible = False
                    tdPriceSM16.Visible = False
                    tdPriceSM17.Visible = False
                    tdPriceSM18.Visible = False
                    tdPriceSM19.Visible = False
                    tdPriceSM20.Visible = False

                    For i = 0 To dtSMData.Rows.Count - 1
                        strTemp = textTable.Rows(20)("TextParamValue") & " " & dtSMData.Rows(i)("SaleModeName")
                        Select Case dtSMData.Rows(i)("SaleModeID")
                            Case 2
                                tdSM2.Visible = True
                                tdPriceSM2.Visible = True
                                PriceTextSM2.InnerHtml = strTemp
                            Case 3
                                tdSM3.Visible = True
                                tdPriceSM3.Visible = True
                                PriceTextSM3.InnerHtml = strTemp
                            Case 4
                                tdSM4.Visible = True
                                tdPriceSM4.Visible = True
                                PriceTextSM4.InnerHtml = strTemp
                            Case 5
                                tdSM5.Visible = True
                                tdPriceSM5.Visible = True
                                PriceTextSM5.InnerHtml = strTemp
                            Case 6
                                tdSM6.Visible = True
                                tdPriceSM6.Visible = True
                                PriceTextSM6.InnerHtml = strTemp
                            Case 7
                                tdSM7.Visible = True
                                tdPriceSM7.Visible = True
                                PriceTextSM7.InnerHtml = strTemp
                            Case 8
                                tdSM8.Visible = True
                                tdPriceSM8.Visible = True
                                PriceTextSM8.InnerHtml = strTemp
                            Case 9
                                tdSM9.Visible = True
                                tdPriceSM9.Visible = True
                                PriceTextSM9.InnerHtml = strTemp
                            Case 10
                                tdSM10.Visible = True
                                tdPriceSM10.Visible = True
                                PriceTextSM10.InnerHtml = strTemp
                            Case 11
                                tdSM11.Visible = True
                                tdPriceSM11.Visible = True
                                PriceTextSM11.InnerHtml = strTemp
                            Case 12
                                tdSM12.Visible = True
                                tdPriceSM12.Visible = True
                                PriceTextSM12.InnerHtml = strTemp
                            Case 13
                                tdSM13.Visible = True
                                tdPriceSM13.Visible = True
                                PriceTextSM13.InnerHtml = strTemp
                            Case 14
                                tdSM14.Visible = True
                                tdPriceSM14.Visible = True
                                PriceTextSM14.InnerHtml = strTemp
                            Case 15
                                tdSM15.Visible = True
                                tdPriceSM15.Visible = True
                                PriceTextSM15.InnerHtml = strTemp
                            Case 16
                                tdSM16.Visible = True
                                tdPriceSM16.Visible = True
                                PriceTextSM16.InnerHtml = strTemp
                            Case 17
                                tdSM17.Visible = True
                                tdPriceSM17.Visible = True
                                PriceTextSM17.InnerHtml = strTemp
                            Case 18
                                tdSM18.Visible = True
                                tdPriceSM18.Visible = True
                                PriceTextSM18.InnerHtml = strTemp
                            Case 19
                                tdSM19.Visible = True
                                tdPriceSM19.Visible = True
                                PriceTextSM19.InnerHtml = strTemp
                            Case 20
                                tdSM20.Visible = True
                                tdPriceSM20.Visible = True
                                PriceTextSM20.InnerHtml = strTemp
                            
                        End Select
                    Next i
			
                    Dim dtPriceInfo As DataTable
                    Dim strBuild As StringBuilder
                    Dim strSQL As String
                    Dim UnitIDValue As Integer = 0
                    Dim SelectedText As String
                    Dim rResult() As DataRow
                    Dim SelectedPriceRemark As String
                    Dim PercentPrice As Decimal
                    counter = 1
                    Dim strFromDate, strToDate As String
                    Dim dtDateData As DataTable
                    Dim PriceRemarkString As String

                    strSQL = "Select count(*),FromDate,ToDate,YEAR(ToDate) As YearToDate " & _
                             "From ProductPrice Where ProductID = " & Request.QueryString("ProductID").ToString & _
                             " Group by FromDate,ToDate Order by FromDate"
                    dtDateData = objDB.List(strSQL, objCnn)

                    strBuild = New StringBuilder
                    SelectedText = "text"
                    PriceRemarkString = ""
                    For j = 0 To dtDateData.Rows.Count - 1
                        strBuild.Append("<tr>")
                        strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & counter.ToString & "</td>")
					
                        If Not IsDBNull(dtDateData.Rows(j)("FromDate")) Then
                            strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & CDate(dtDateData.Rows(j)("FromDate")).ToString(FormatObject.DateFormat, ci) & "</td>")
                        Else
                            strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & "-" & "</td>")
                        End If
                        If Not IsDBNull(dtDateData.Rows(j)("ToDate")) Then
                            If dtDateData.Rows(j)("YearToDate") = 9999 Then
                                strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & "-" & "</td>")
                            Else
                                strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & CDate(dtDateData.Rows(j)("ToDate")).ToString(FormatObject.DateFormat, ci) & "</td>")
                            End If
                        Else
                            strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & "-" & "</td>")
                        End If
	 
                        strFromDate = FormatDateForMySQL(dtDateData.Rows(j)("FromDate"))
                        strToDate = FormatDateForMySQL(dtDateData.Rows(j)("ToDate"))
                        dtPriceInfo = GetProductPriceInfo(Request.QueryString("ProductID"), strFromDate, strToDate, objCnn)
         
                        For k = 0 To dtSMData.Rows.Count - 1
                            If dtPriceInfo.Rows.Count = 0 Then
                                ReDim rResult(-1)
                            Else
                                rResult = dtPriceInfo.Select("SaleMode = " & dtSMData.Rows(k)("SaleModeID"))
                            End If
                            If rResult.Length <> 0 Then
                                For i = 0 To rResult.Length - 1
                                    If Request.QueryString("a") = "yes" And Request.QueryString("FromDateString") = strFromDate And Request.QueryString("ToDateString") = strToDate Then
                                        SelectedText = "disabledText"
                                        ProductPriceID.Value = rResult(i)("ProductPriceID").ToString
                                        If Not IsDBNull(rResult(i)("PriceRemark")) Then
                                            SelectedPriceRemark = rResult(i)("PriceRemark")
                                        Else
                                            SelectedPriceRemark = ""
                                        End If
                                        If Not Page.IsPostBack Then
                                            strTemp = Replace(CDbl(rResult(i)("ProductPrice")).ToString(FormatObject.CurrencyFormat, ci_us), ",", "")
                                            Select Case dtSMData.Rows(k)("SaleModeID")
                                                Case 1
                                                    ProductPrice.Text = strTemp
                                                Case 2
                                                    ProductPriceSM2.Text = strTemp
                                                Case 3
                                                    ProductPriceSM3.Text = strTemp
                                                Case 4
                                                    ProductPriceSM4.Text = strTemp
                                                Case 5
                                                    ProductPriceSM5.Text = strTemp
                                                Case 6
                                                    ProductPriceSM6.Text = strTemp
                                                Case 7
                                                    ProductPriceSM7.Text = strTemp
                                                Case 8
                                                    ProductPriceSM8.Text = strTemp
                                                Case 9
                                                    ProductPriceSM9.Text = strTemp
                                                Case 10
                                                    ProductPriceSM10.Text = strTemp
                                                Case 11
                                                    ProductPriceSM11.Text = strTemp
                                                Case 12
                                                    ProductPriceSM12.Text = strTemp
                                                Case 13
                                                    ProductPriceSM13.Text = strTemp
                                                Case 14
                                                    ProductPriceSM14.Text = strTemp
                                                Case 15
                                                    ProductPriceSM15.Text = strTemp
                                                Case 16
                                                    ProductPriceSM16.Text = strTemp
                                                Case 17
                                                    ProductPriceSM17.Text = strTemp
                                                Case 18
                                                    ProductPriceSM18.Text = strTemp
                                                Case 19
                                                    ProductPriceSM19.Text = strTemp
                                                Case 20
                                                    ProductPriceSM20.Text = strTemp                                               
                                            End Select
                                        End If
                                    Else
                                        SelectedText = "text"
                                    End If
								 								
                                    If k = 0 Then
                                        Try
                                            PercentPrice = Math.Round(((rResult(i)("ProductPrice") - costTable.Rows(0)("TotalCost")) / costTable.Rows(0)("TotalCost")) * 100, 2)
                                        Catch ex As Exception
                                            PercentPrice = 0
                                        End Try
                                        strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & (PercentPrice / 100).ToString(FormatObject.PercentFormat, ci) & "</td>")
                                    End If
                                    strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & CDbl(rResult(i)("ProductPrice")).ToString(FormatObject.CurrencyFormat, ci) & "</td>")
								
                                    If Not IsDBNull(dtPriceInfo.Rows(i)("PriceRemark")) Then
                                        PriceRemarkString = dtPriceInfo.Rows(i)("PriceRemark")
                                    End If
                                Next
                            Else
                                strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & "" & "</td>")
                            End If
                        Next k
                        strBuild.Append("<td align=""left"" class=""" + SelectedText + """>" & PriceRemarkString & "</td>")
		
                        If SelectedText = "text" Then
                            strBuild.Append("<td align=""center"" class=""text""><a href=""product_price.aspx?EditID=3&a=yes&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&FromDateString=" & strFromDate & "&ToDateString=" & strToDate & """>Edit</a>")
                            strBuild.Append("&nbsp;&nbsp;<a href=""inv_category_action.aspx?action=delete_price_salemode&EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&FromDateString=" & strFromDate & "&ToDateString=" & strToDate & """" + "onClick=""javascript: return confirm('" & textTable.Rows(25)("TextParamValue") & " " & "this record" & " " & textTable.Rows(15)("TextParamValue") & "')"">" + "Del</a></td>")
                        Else
                            strBuild.Append("<td></td>")
                            'outputString += "<td align=""center"" class=""" + SelectedText + """>Updating</td>"
                        End If
                        strBuild.Append("</tr>")
                        counter = counter + 1
                    Next
				
                    Dim AttachEditText As String
                    If Request.QueryString("a") <> "yes" Then
                        counterText.InnerHtml = counter.ToString
                        SubmitForm.Text = "Add"
                        AttachEditText = "&b=null"
                        ProductPriceID.Value = 0
                    Else
                        SubmitForm.Text = "Update"
                        counterText.InnerHtml = "<a href=""product_price.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + """>Cancel</a>"
                        AttachEditText = "&a=yes"

                    End If
				
                    ResultText.InnerHtml = strBuild.ToString
				
                    Dim SelectedPercentage As Decimal
                    Try
                        If Not Request.QueryString("PercentValue") Is Nothing And Not Page.IsPostBack Then
                            SelectedPercentage = Math.Round((Request.QueryString("PercentValue") / 100) * costTable.Rows(0)("TotalCost"), 2) + costTable.Rows(0)("TotalCost")
                            ProductPrice.Text = Format(SelectedPercentage, "##,##0.00")
                            Percentage.Text = Request.QueryString("PercentValue")
                            PriceRemark.Text = Request.QueryString("PriceRemark")
                            MainPriceValue.Checked = Request.QueryString("MainPriceValue")
                        End If
                    Catch ex As Exception

                    End Try
				
                    selectPercentText.InnerHtml = "<a href=""javascript: window.location='product_price.aspx?EditID=3&From=component&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&PercentValue=' + document.forms[0].Percentage.value + '&ProductPriceID=' + document.forms[0].ProductPriceID.value + '&PriceRemark=' + document.forms[0].PriceRemark.value + '&MainPriceValue=' + document.forms[0].MainPriceValue.checked + '" + AttachEditText + "'"">" + textTable.Rows(19)("TextParamValue") + "</a>"
				
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

    Public Function GetProductPriceInfo(ByVal ProductID As Integer, ByVal FromDate As String, ByVal ToDate As String, ByVal objCnn As MySqlConnection) As DataTable
        Dim sqlStatement As String
        Dim AdditionalQuery As String = ""
        If ProductID > 0 And IsNumeric(ProductID) Then
            AdditionalQuery += " AND ProductID=" + ProductID.ToString
        End If
        If Trim(FromDate) <> "" Then
            AdditionalQuery += " AND FromDate=" + FromDate
        End If
        If Trim(ToDate) <> "" Then
            AdditionalQuery += " AND ToDate=" + ToDate
        End If
        sqlStatement = "SELECT *,YEAR(ToDate) As YearToDate FROM ProductPrice WHERE 0=0 " + AdditionalQuery + " ORDER BY FromDate,ToDate,ProductPrice"
        
        Return objDB.List(sqlStatement, objCnn)
    End Function

    Sub DoAddUpdate(Source As Object, E As EventArgs)
        Dim FoundError As Boolean = False
        Dim vPrice As HtmlGenericControl
        Dim textTable As New DataTable()
        textTable = getPageText.GetText(8, Session("LangID"), objCnn)
	
        ValidateFromDate.InnerHtml = ""
      	
        Dim smID() As Integer
        Dim strPrice, strSMPrice() As String
        Dim dtSMData As DataTable
        Dim i As Integer
    
        dtSMData = POSDBSQLFront.POSUtilSQL.ListAllSaleMode(objDB, objCnn)
        
        ReDim smID(dtSMData.Rows.Count - 1)
        ReDim strSMPrice(dtSMData.Rows.Count - 1)
        
        For i = 0 To dtSMData.Rows.Count - 1
            strPrice = ""
            
            Select Case dtSMData.Rows(i)("SaleModeID")
                Case 1
                    strPrice = ProductPrice.Text
                    vPrice = ValidateAmount
                Case 2
                    strPrice = ProductPriceSM2.Text
                    vPrice = ValidateAmountSM2
                Case 3
                    strPrice = ProductPriceSM3.Text
                    vPrice = ValidateAmountSM3
                Case 4
                    strPrice = ProductPriceSM4.Text
                    vPrice = ValidateAmountSM4
                Case 5
                    strPrice = ProductPriceSM5.Text
                    vPrice = ValidateAmountSM5
                Case 6
                    strPrice = ProductPriceSM6.Text
                    vPrice = ValidateAmountSM6
                Case 7
                    strPrice = ProductPriceSM7.Text
                    vPrice = ValidateAmountSM7
                Case 8
                    strPrice = ProductPriceSM8.Text
                    vPrice = ValidateAmountSM8
                Case 9
                    strPrice = ProductPriceSM9.Text
                    vPrice = ValidateAmountSM9
                Case 10
                    strPrice = ProductPriceSM10.Text
                    vPrice = ValidateAmountSM10
                Case 11
                    strPrice = ProductPriceSM11.Text
                    vPrice = ValidateAmountSM11
                Case 12
                    strPrice = ProductPriceSM12.Text
                    vPrice = ValidateAmountSM12
                Case 13
                    strPrice = ProductPriceSM13.Text
                    vPrice = ValidateAmountSM13
                Case 14
                    strPrice = ProductPriceSM14.Text
                    vPrice = ValidateAmountSM14
                Case 15
                    strPrice = ProductPriceSM15.Text
                    vPrice = ValidateAmountSM15
                Case 16
                    strPrice = ProductPriceSM16.Text
                    vPrice = ValidateAmountSM16
                Case 17
                    strPrice = ProductPriceSM17.Text
                    vPrice = ValidateAmountSM17
                Case 18
                    strPrice = ProductPriceSM18.Text
                    vPrice = ValidateAmountSM18
                Case 19
                    strPrice = ProductPriceSM19.Text
                    vPrice = ValidateAmountSM19
                Case 20
                    strPrice = ProductPriceSM20.Text
                    vPrice = ValidateAmountSM20
                Case Else
                    strPrice = ProductPrice.Text
                    vPrice = ValidateAmount
            End Select
            vPrice.InnerHtml = ""
            If strPrice <> "" Then
                If Not IsNumeric(strPrice) Then
                    vPrice.InnerHtml = textTable.Rows(24)("TextParamValue") + "<br>"
                    FoundError = True
                End If
            End If
            
            smID(i) = dtSMData.Rows(i)("SaleModeID")
            strSMPrice(i) = strPrice
        Next i

        Dim FromDateString As String = DateTimeUtil.FormatDate(Request.Form("FromDate_Day"), Request.Form("FromDate_Month"), Request.Form("FromDate_Year"))
	
        If ProductPriceID.Value = 0 Then
            If Trim(FromDateString) = "InvalidDate" Then
                ValidateFromDate.InnerHtml = "Invalid Date" + "<br>"
                FoundError = True
            Else
                Dim Date1 As New DateTime(Request.Form("FromDate_Year"), Request.Form("FromDate_Month"), Request.Form("FromDate_Day"), 0, 0, 0)
                Dim TodayDate As New DateTime(CInt(Now.ToString("yyyy", InvC)), Month(Now()), Day(Now()), 0, 0, 0)
                Dim TotalDay As Integer = DateDiff("d", TodayDate, Date1)
                Dim ChkPrice As DataTable = objDB.List("select *,DAY(FromDate) As FromDateDay,MONTH(FromDate) As FromDateMonth,YEAR(FromDate) AS FromDateYear from ProductPrice WHERE ProductID=" + ProductID.Value.ToString + " order by FromDate DESC", objCnn)
                If ChkPrice.Rows.Count > 0 Then
                    If TotalDay < 0 Then
                        ValidateFromDate.InnerHtml = "Date must be >= Today" + "<br>"
                        FoundError = True
                    Else
                        Dim Date2 As New DateTime(ChkPrice.Rows(0)("FromDateYear"), ChkPrice.Rows(0)("FromDateMonth"), ChkPrice.Rows(0)("FromDateDay"), 0, 0, 0)
                        Dim CompareDay As Integer = DateDiff("d", Date2, Date1)
                        If CompareDay <= 0 Then
                            ValidateFromDate.InnerHtml = "Date must be > Date From of Previous Date From" + "<br>"
                            FoundError = True
                        End If
                    End If
	
                End If
            End If
        End If
        
        If FoundError = False Then
            Dim Result As String
            Dim ExtraSQL(1) As String
            ExtraSQL(0) = ""
            ExtraSQL(1) = ""
            Dim CheckedValue As Integer
            If MainPriceValue.Checked = True Then
                CheckedValue = 1
            Else
                CheckedValue = 0
            End If
            If ProductPriceID.Value = 0 Then
                ExtraSQL(0) = "MainPrice"
                ExtraSQL(1) = CheckedValue.ToString
            Else
                ExtraSQL(0) = "MainPrice=" + CheckedValue.ToString
            End If
				
            Result = getInfo.AUDUpdatePrice(smID, ProductPriceID.Value, ProductID.Value, strSMPrice, "0", FromDateString, _
                                       Request.QueryString("FromDateString"), Request.QueryString("ToDateString"), PriceRemark.Text, objCnn)
            getInfo.UpdateProductDate(Request.QueryString("ProductID"), objCnn)
            If Result = "Success" Then
                Response.Redirect("product_price.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID"))
            Else
                errorMsg.InnerHtml = Result
            End If

        End If
    End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
