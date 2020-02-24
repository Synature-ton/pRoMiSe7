<%@ Page Language="VB" ContentType="text/html" EnableViewState="False" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="System.Globalization" %>

<html>
<head>
<title>MultiBranch Setup By Products</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">
<form id="mainForm" runat="server">
<ASP:Label id="updateMessage" CssClass="text" runat="server" />

<span id="HiddenForm" runat="server"></span>
<b class="headerText"><div class="headerText" align="left" id="Text_SectionParam" runat="server" /></b>
<br>
<div id="ShowContent" runat="server">
<table>
	<tr>
		<td><asp:button ID="SubmitForm" OnClick="DoAddUpdate" Text=" Submit Changes " runat="server" />&nbsp;&nbsp;<span id="UpdateMsg" class="boldText" runat="server"></span></td>
	</tr>
</table>
<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
	<span id="TableHeaderText" runat="server"></span>
	<div id="ResultText" runat="server"></div>

</table>
<table>
	<tr>
		<td><asp:button ID="SubmitForm1" OnClick="DoAddUpdate" Text=" Submit Changes " runat="server" /></td>
	</tr>
</table>
</div>
<div id="errorMsg" runat="server" />
<div id="errorMsg2" runat="server" />
</form>
<script language="VB" runat="server">
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getData As New CPromotions()
Dim getPageText As New DefaultText()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
Dim getConfig As New POSConfiguration()
Dim DateTimeUtil As New MyDateTime()
Dim getInfo As New CCategory()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Inv_Product_Category") Then
			
            'Try
            objCnn = getCnn.EstablishConnection()
            Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
            If PropertyInfo.Rows(0)("HeadOrBranch") = 1 Then
                ShowContent.Visible = False
            Else
                ShowContent.Visible = True
            End If
			
            SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
            SubmitForm1.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm1).ToString
			
            If Request.QueryString("Update") = "done" Then
                UpdateMsg.InnerHtml = "Data have been updated " + Now.ToString
            End If
			
            Dim textTable As New DataTable()
            textTable = getPageText.GetText(7, Session("LangID"), objCnn)
			
            Dim defaultTextTable As New DataTable()
            defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
            Text_SectionParam.InnerHtml = "Manage Price for Multi Branch of Product Component"
			
            Dim ProductShopData As DataTable
            Dim ShopData As DataTable
            Dim ShopIDList As String
            Dim Result As String = getInfo.PriceComponentByBranch(ShopData, ProductShopData, ShopIDList, Request.QueryString("ProductLevelID"), _
                                             Request.QueryString("PGroupID"), Request.QueryString("ProductID"), Request.QueryString("SubProductID"), objCnn)
            
            Dim i, j As Integer

        	
            Dim HeaderString As StringBuilder = New StringBuilder

            TableHeaderText.InnerHtml = ""
			
            Dim PriceParamName, PriceString As String
            Dim outputString As StringBuilder = New StringBuilder
            Dim foundRows() As DataRow
            Dim expression As String
            Dim bColor As String
            Dim tdColor As String
            Dim strTemp As String
            Dim PrinterString As String = ""
       	
            Dim forSaleModeID As Integer
            Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
            Dim ci As New CultureInfo(FormatObject.CultureString)
            Dim ci_us As New CultureInfo("en-US")
            Dim dtSMData As DataTable
           
            If Not (Request.QueryString("SaleMode") Is Nothing) Then
                forSaleModeID = CInt(Request.QueryString("SaleMode"))
                dtSMData = POSDBSQLFront.POSUtilSQL.GetSaleModeData(objDB, objCnn, forSaleModeID)
            Else
                forSaleModeID = 0
                dtSMData = POSDBSQLFront.POSUtilSQL.ListAllSaleMode(objDB, objCnn)
            End If
            
            outputString = outputString.Append("<tr>")
            outputString = outputString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "" + "</td>")
            outputString = outputString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Shop Name" + "</td>")
            For j = 0 To dtSMData.Rows.Count - 1
                outputString = outputString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + dtSMData.Rows(j)("SaleModeName") + "</td>")
            Next j
            outputString = outputString.Append("</tr>")
		
            For i = 0 To ShopData.Rows.Count - 1
                If i Mod 2 = 0 Then
                    bColor = "white"
                Else
                    bColor = GlobalParam.RowBGColor
                End If
				
                outputString = outputString.Append("<tr bgColor=""" + bColor + """>")
                outputString = outputString.Append("<td align=""center"" class=""smalltext"">" + (i + 1).ToString + "</td>")
                outputString = outputString.Append("<td align=""left"" class=""smalltext"" style=""width:200px;"">" + ShopData.Rows(i)("ProductLevelName") + "</td>")
				
                For j = 0 To dtSMData.Rows.Count - 1
                    expression = "ProductLevelID=" + ShopData.Rows(i)("ProductLevelID").ToString + " AND SaleMode=" & dtSMData.Rows(j)("SaleModeID").ToString
                    foundRows = ProductShopData.Select(expression)
                    PriceParamName = "Price:" + ShopData.Rows(i)("ProductLevelID").ToString + ":" + Request.QueryString("PGroupID").ToString + ":" & _
                                       Request.QueryString("ProductID").ToString + ":" + Request.QueryString("SubProductID").ToString + ":" & _
                                       dtSMData.Rows(j)("SaleModeID").ToString
                    If foundRows.GetUpperBound(0) >= 0 Then
                        PriceString = Replace(CDbl(foundRows(0)("FlexibleProductPrice")).ToString(FormatObject.CurrencyFormat, ci_us), ",", "")
                    Else
                        PriceString = ""
                    End If
                    strTemp = "<td align=""right""><input type=""text"" class=""smalltext"" style=""width:70px;text-align:right;" & _
                                    tdColor + """ name=""" & PriceParamName & """ value=""" + PriceString + """></td>"
                    outputString = outputString.Append(strTemp)
                Next
				
                outputString = outputString.Append("</tr>")
				
            Next
	
            HiddenForm.InnerHtml = "<input type=""hidden"" name=""ShopIDList"" value=""" + ShopIDList + """>"
            ResultText.InnerHtml = outputString.ToString
            'errorMsg.InnerHtml = TestString
            'Catch ex As Exception
            'errorMsg.InnerHtml = ex.Message
            'End Try
        Else
            updateMessage.Text = "Access Denied"
        End If
    End Sub

    Sub DoAddUpdate(Source As Object, E As EventArgs)
        Dim forSaleModeID As Integer
        Dim strTemp As String
        If Not (Request.QueryString("SaleMode") Is Nothing) Then
            forSaleModeID = CInt(Request.QueryString("SaleMode"))
        Else
            forSaleModeID = 0
        End If
        getInfo.PriceComponentByBranchUpdate(Request, forSaleModeID, objCnn)
        Dim ProductID As String = ""
        If Request.QueryString("ProductID") IsNot Nothing Then
            ProductID = Request.QueryString("ProductID").ToString
        End If
        strTemp = "productcomponent_multishop.aspx?Update=done&PGroupID=" + Request.QueryString("PGroupID").ToString & _
                       "&SubProductID=" + Request.QueryString("SubProductID").ToString + "&ProductID=" + ProductID & _
                       "&ProductLevelID=" + Request.QueryString("ProductLevelID").ToString & "&SaleMode=" & forSaleModeID
        Response.Redirect(strTemp)
    End Sub
	
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
