<%@ Page Language="VB" ContentType="text/html" debug="True"%>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySql.GlobalFunctions" %>
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Product Set</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">
<form id="mainForm" runat="server">
<ASP:Label id="updateMessage" CssClass="text" runat="server" />

<table cellpadding="2" cellspacing="2" width="90%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
<td align="right"><table cellpadding="0" cellspacing="0"><tr id="showsubmit" visible="false" runat="server"><td><synature:date id="PMonthYearDate" runat="server" /></td><td><input type="submit" value="Submit"></td></tr></table></td>
</tr>
<tr><td height="5" colspan="2"></td></tr>
<tr><td><div id="CostText" class="text" runat="server"></div></td>
<td align="right"><div class="text" id="GoBackText" runat="server"></div></td></tr>
<tr><td height="5" colspan="2"></td></tr>
</table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="90%">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="OrderText" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="CodeText" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="NameText" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="AmountText" runat="server"></div></td>
        <td id="headerTD10" align="center" class="tdHeader" runat="server"><div id="AddPriceText" runat="server"></div></td>
        <td id="headerTD11" align="center" class="tdHeader" runat="server"><div id="AddAmountText" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="UnitText" runat="server"></div></td>
		<td id="headerTD8" align="center" class="tdHeader" runat="server"><div id="CostPerUnitText" runat="server"></div></td>

		<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="ActionText" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>
	
	<div id="showAddMaterial" runat="server">
	
	<input type="hidden" id="ProductID" runat="server">
	<input type="hidden" id="MaterialID" runat="server">
	<input type="hidden" id="PComponentOrdering" runat="server">
	<input type="hidden" id="UnitSmallID" runat="server">
	<input type="hidden" id="PComponentID" runat="server">
	<tr id="AddDataText" runat="server">
		<td><table cellpadding="0" cellspacing="0"><tr><td><div id="counterText" class="text" runat="server"></div></td><td width="5" ></td>
                <td><asp:textbox ID="txtOrdering"  Width="40"  style="text-align: center" runat="server" /><div id="ValidateOrdering" class="errorText" runat="server"></div></td></tr></table></td>
		<td><table cellpadding="0" cellspacing="0"><div id="ValidateCode" runat="server"></div><tr><td><asp:textbox ID="MaterialCode" Width="100" runat="server" /></td><td width="5"></td><td><div id="selectMaterialText" class="text" runat="server"></div></td></tr></table></td>
		<td><div id="MaterialNameText" class="text" runat="server"></div></td>
		<td align="center"><div id="ValidateAmount" class="errorText" runat="server"></div><asp:textbox ID="MaterialAmount" Width="50" runat="server" /></td>
  
        <td id="Flex1" align="center" runat="server"><asp:Checkbox ID="FlexibleProductIncludePrice" Checked="false" runat="server" /></td>
        <td id="Flex2" align="center" runat="server"><div id="ValidateFlex" class="errorText" runat="server"></div><asp:textbox ID="txtFlexibleProductPrice" Width="100" runat="server" /></td>

		<td id="Cost1" align="center" runat="server"><div id="UnitNameText" class="text" runat="server"></div></td>
		<td id="Cost2" runat="server"></td>

		<td align="center"><table cellpadding="0" cellspacing="0"><tr><td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="45" OnClick="DoAddUpdate" runat="server" /></td><td width="5"></td><td><div id="CancelUpdate" runat="server"></div></td></tr></table></td>
	</tr>
	
	</div>
</table>
</form>
<div id="errorMsg" runat="server" />

<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getInfo As New CCategory()
Dim getPageText As New DefaultText()
Dim objDB As New CDBUtil()
Dim DateTimeUtil As New MyDateTime()
Dim CostInfo As New CostClass()
		
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Inv_Product_Category") Then
	  
            If Not Request.QueryString("ProductID") And IsNumeric(Request.QueryString("ProductID")) Then
	  	
                'If Request.QueryString("a")	= "yes" Then
                'ShowAddMaterial.Visible = False
                'End If
                ProductID.Value = Request.QueryString("ProductID")
                Dim PGroupID As Integer = 0
                If IsNumeric(Request.QueryString("PGroupID")) Then
                    PGroupID = Request.QueryString("PGroupID")
                End If
		
                headerTD1.BgColor = GlobalParam.AdminBGColor
                headerTD2.BgColor = GlobalParam.AdminBGColor
                headerTD3.BgColor = GlobalParam.AdminBGColor
                headerTD4.BgColor = GlobalParam.AdminBGColor
                headerTD5.BgColor = GlobalParam.AdminBGColor
                headerTD10.BgColor = GlobalParam.AdminBGColor
                headerTD11.BgColor = GlobalParam.AdminBGColor

                headerTD7.BgColor = GlobalParam.AdminBGColor
                headerTD8.BgColor = GlobalParam.AdminBGColor
		
                Session("Material_Cost") = False
                If Session("Material_Cost") = False Then
                    headerTD5.Visible = False
                    headerTD8.Visible = False
                    Cost1.Visible = False
                    Cost2.Visible = False
                End If
		
                PMonthYearDate.YearType = GlobalParam.YearType
                PMonthYearDate.FormName = "PMonthYearDate"
                PMonthYearDate.StartYear = 1
                PMonthYearDate.EndYear = 2
                PMonthYearDate.LangID = Session("LangID")
                PMonthYearDate.ShowDay = False
		
                If IsNumeric(Request.Form("PMonthYearDate_Month")) Then
                    Session("PMonthYearDate_Month") = Request.Form("PMonthYearDate_Month")
                ElseIf IsNumeric(Request.QueryString("PMonthYearDate_Month")) Then
                    Session("PMonthYearDate_Month") = Request.QueryString("PMonthYearDate_Month")
                ElseIf Trim(Session("PMonthYearDate_Month")) = "" Then
                    Session("PMonthYearDate_Month") = DateTime.Now.Month
                End If
                If Page.IsPostBack And Request.Form("PMonthYearDate_Month") = "" Then Session("PMonthYearDate_Month") = 0
                PMonthYearDate.SelectedMonth = Session("PMonthYearDate_Month")
		
                If IsNumeric(Request.Form("PMonthYearDate_Year")) Then
                    Session("PMonthYearDate_Year") = Request.Form("PMonthYearDate_Year")
                ElseIf IsNumeric(Request.QueryString("PMonthYearDate_Year")) Then
                    Session("PMonthYearDate_Year") = Request.QueryString("PMonthYearDate_Year")
                ElseIf Trim(Session("PMonthYearDate_Year")) = "" Then
                    Session("PMonthYearDate_Year") = DateTime.Now.Year
                End If
                If Page.IsPostBack And Request.Form("PMonthYearDate_Year") = "" Then Session("PMonthYearDate_Year") = 0
                PMonthYearDate.SelectedYear = Session("PMonthYearDate_Year")
			
                'Try
                objCnn = getCnn.EstablishConnection()

                Dim strTemp As String
                Dim dtTable As New DataTable()
                dtTable = getInfo.GetProductInfo(0, Request.QueryString("ProductID"), objCnn)
			
                If dtTable.Rows.Count <> 0 Then
			
                    Dim textTable As New DataTable()
                    textTable = getPageText.GetText(8, Session("LangID"), objCnn)
				
                    Dim dtSMData, dtComponentTable, dtUnComponentTable As DataTable
                    dtSMData = POSDBSQLFront.POSUtilSQL.ListAllSaleMode(getCnn, objCnn)
                    dtComponentTable = getInfo.GetProductSetInfo(Request.QueryString("ProductID"), PGroupID, "0", 0, Session("PMonthYearDate_Month"), Session("PMonthYearDate_Year"), _
                                                            Request.QueryString("ProductLevelID"), objCnn)
                    dtUnComponentTable = getInfo.GetProductSetInfo1(Request.QueryString("ProductID"), PGroupID, "0", 0, objCnn)
				
                    Dim defaultTextTable As New DataTable()
                    defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
                    Dim bolCanAddPrice As Boolean
				
                    If dtTable.Rows(0)("ProductSet") = 7 Then
                        GoBackText.InnerHtml = "<a href=""pcomponent_group.aspx?ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + """>" + textTable.Rows(57)("TextParamValue") + "</a>"
                        bolCanAddPrice = True
                    Else
                        GoBackText.InnerHtml = ""
                        bolCanAddPrice = False
                    End If
				
                    headerTD10.Visible = bolCanAddPrice
                    headerTD11.Visible = bolCanAddPrice
                    Flex1.Visible = bolCanAddPrice
                    Flex2.Visible = bolCanAddPrice
                    txtOrdering.Visible = bolCanAddPrice
                    
                    HeaderText.InnerHtml = textTable.Rows(37)("TextParamValue") + " " + dtTable.Rows(0)("ProductName")
                    OrderText.InnerHtml = textTable.Rows(1)("TextParamValue")
                    CodeText.InnerHtml = textTable.Rows(35)("TextParamValue")
                    NameText.InnerHtml = textTable.Rows(36)("TextParamValue")
                    AmountText.InnerHtml = textTable.Rows(4)("TextParamValue")
                    UnitText.InnerHtml = defaultTextTable.Rows(10)("TextParamValue") + "/" + textTable.Rows(5)("TextParamValue")

                    ActionText.InnerHtml = textTable.Rows(7)("TextParamValue")
                    CostPerUnitText.InnerHtml = textTable.Rows(18)("TextParamValue") + " (" + defaultTextTable.Rows(10)("TextParamValue") + ")"
                    
                    If textTable.Rows.Count > 65 Then
                        strTemp = textTable.Rows(65)("TextParamValue")
                    Else
                        strTemp = "Add Price"
                    End If
                    AddPriceText.InnerHtml = strTemp
                    If textTable.Rows.Count > 66 Then
                        strTemp = textTable.Rows(66)("TextParamValue")
                    Else
                        strTemp = "Add Amount"
                    End If
                    AddAmountText.InnerHtml = strTemp
				
                    Dim costValue As Decimal = 0
				
                    Dim i, counter, j As Integer
                    Dim strBuild As StringBuilder
				
                    Dim UnitIDValue As Integer = 0
                    Dim SelectedText As String
                    Dim SelectedMaterialID As String = 0
                    Dim selectOrdering As Integer = 0
                    Dim SelectedMaterialAmount As String
                    Dim FlexIncPrice As Boolean
                    Dim FlexProductPrice As Double
                    Dim componentList As String = ""
                    counter = 1
                    Dim subCostValue As Double
                    Dim costTable As DataTable

                    strBuild = New StringBuilder
                    For i = 0 To componentTable.Rows.Count - 1
                        If Not IsDBNull(componentTable.Rows(i)("ProductID")) Then
                            If Not Request.QueryString("a") Is Nothing Then
                                If Request.QueryString("a") = "yes" And Request.QueryString("PComponentID") = componentTable.Rows(i)("PComponentID") Then
                                    SelectedText = "disabledText"
                                    SelectedMaterialID = componentTable.Rows(i)("ProductID")
                                    selectOrdering = componentTable.Rows(i)("Ordering")
                                    SelectedMaterialAmount = Format(componentTable.Rows(i)("ProductAmount"), "##,##0")
                                    If componentTable.Rows(i)("FlexibleProductIncludePrice") = 0 Then
                                        FlexIncPrice = False
                                    Else
                                        FlexIncPrice = True
                                    End If
                                    FlexProductPrice = componentTable.Rows(i)("FlexibleProductPrice")
                                Else
                                    SelectedText = "text"
                                End If
                            Else
                                SelectedText = "text"
                            End If
                            'costTable = getInfo.ProductUnitCost(Request.QueryString("ProductLevelID"),componentTable.Rows(i)("ProductID"), Session("PMonthYearDate_Month"),Session("PMonthYearDate_Year"),objCnn)
					
                            If txtOrdering.Visible = True Then
                                strBuild.Append("<tr><td align=""center"" class=""" + SelectedText + """>" & componentTable.Rows(i)("Ordering") & "</td>")
                                counter = componentTable.Rows(i)("Ordering")
                            Else
                                strBuild.Append("<tr><td align=""center"" class=""" + SelectedText + """>" & counter.ToString & "</td>")
                            End If
                            strBuild.Append("<td align=""left"" class=""" + SelectedText + """>" & componentTable.Rows(i)("ProductCode") & "</td>")
                            strBuild.Append("<td align=""left"" class=""" + SelectedText + """>" & componentTable.Rows(i)("ProductName") & "</td>")
                            strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & Format(componentTable.Rows(i)("ProductAmount"), "##,##0") & "</td>")
                            If bolCanAddPrice = True Then
                                If componentTable.Rows(i)("FlexibleProductIncludePrice") = 0 Then
                                    strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & "&nbsp;" & "</td>")
                                    strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & "&nbsp;" & "</td>")
                                Else
                                    strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & componentTable.Rows(i)("FlexibleProductIncludePrice") & "</td>")
                                    strTemp = "&nbsp;<a href=""JavaScript: newWindow = window.open( 'productcomponent_multishop.aspx?ProductLevelID=" & Request.QueryString("ProductLevelID").ToString & _
                                            "&PGroupID=" + Request.QueryString("PGroupID").ToString + "&ProductID=" + Request.QueryString("ProductID").ToString & _
                                            "&SubProductID=" + componentTable.Rows(i)("ProductID").ToString & "&SaleMode=" & componentTable.Rows(i)("SaleMode") & _
                                            "', '', 'width=550,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & _
                                            "Multi Price" & "</a>"
                                    
                                    strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(componentTable.Rows(i)("FlexibleProductPrice"), "##,##0.00") & _
                                                  strTemp & "</td>")
                                End If
						
                            End If
                            subCostValue = 0
                            If Session("Material_Cost") = True Then
                                For j = 0 To costTable.Rows.Count - 1
                                    If Not IsDBNull(costTable.Rows(j)("TotalPrice")) And Not IsDBNull(costTable.Rows(j)("TotalAmount")) Then
                                        If costTable.Rows(j)("TotalAmount") > 0 Then
                                            subCostValue += (costTable.Rows(j)("MaterialAmount") * costTable.Rows(j)("TotalPrice")) / costTable.Rows(j)("TotalAmount")
                                        End If
                                    End If
                                Next
						
                                If subCostValue > 0 Then
                                    strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(subCostValue, "##,##0.0000") & "</td>")
                                Else
                                    strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & "N/A" & "</td>")
                                End If
                            End If
					
                            If Session("Material_Cost") = True Then
                                If subCostValue > 0 Then
                                    strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(subCostValue * componentTable.Rows(i)("ProductAmount"), "##,##0.00") & "</td>")
                                    costValue += subCostValue * componentTable.Rows(i)("ProductAmount")
							
                                Else
                                    strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & "N/A" & "</td>")
                                End If
                            End If
					
                            If SelectedText = "text" Then
                                strTemp = "<a href=""productset_component.aspx?EditID=3&a=yes&ProductGroupID=" + Request.QueryString("ProductGroupID") & _
                                            "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") & _
                                            "&ProductID=" + Request.QueryString("ProductID") + "&PComponentID=" + componentTable.Rows(i)("PComponentID").ToString & _
                                            "&PGroupID=" + PGroupID.ToString & "&SaleMode=" & componentTable.Rows(i)("SaleMode") & """>"
                                strBuild.Append("<td align=""center"" class=""text"">" & strTemp & "Edit</a>")
                                
                                strTemp = "<a href=""inv_category_action.aspx?action=delete_component&EditID=3&GoBackURL=productset_component.aspx" & _
                                         "&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") & _
                                         "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") & _
                                         "&PComponentID=" + componentTable.Rows(i)("PComponentID").ToString + "&PGroupID=" + PGroupID.ToString & _
                                         "&SaleMode=" & componentTable.Rows(i)("SaleMode") & """" & _
                                         "onClick=""javascript: return confirm('" & textTable.Rows(13)("TextParamValue") & " " & _
                                            Replace(componentTable.Rows(i)("ProductName"), "'", "\'") & " " & textTable.Rows(15)("TextParamValue") & "')"">"
                                strBuild.Append("&nbsp;&nbsp;" & strTemp & "Del</a></td>")
                            Else
                                strBuild.Append("<td align=""center"" class=""" + SelectedText + """>Updating</td>")
                            End If
                            strBuild.Append("</tr>")
                            counter += 1
                            componentList += "," + componentTable.Rows(i)("PComponentID").ToString
                        End If
                    Next
                    componentList += ","
				
                    Dim compareString As String
                    For i = 0 To unComponentTable.Rows.Count - 1
                        compareString = "," + unComponentTable.Rows(i)("PComponentID").ToString + ","
                        If componentList.IndexOf(compareString) = -1 Then
                            If Request.QueryString("a") = "yes" And Request.QueryString("PComponentID") = unComponentTable.Rows(i)("PComponentID") Then
                                SelectedText = "disabledText"
                                SelectedMaterialID = unComponentTable.Rows(i)("ProductID")
                                SelectedMaterialAmount = Format(unComponentTable.Rows(i)("ProductAmount"), "##,##0")
                            Else
                                SelectedText = "text"
                            End If
                            If txtOrdering.Visible = True Then
                                strBuild.Append("<tr><td align=""center"" class=""" + SelectedText + """>" & unComponentTable.Rows(i)("Ordering") & "</td>")
                                counter = unComponentTable.Rows(i)("Ordering")
                            Else
                                strBuild.Append("<tr><td align=""center"" class=""" + SelectedText + """>" & counter.ToString & "</td>")
                            End If
                            strBuild.Append("<td align=""left"" class=""" + SelectedText + """>" & unComponentTable.Rows(i)("ProductCode") & "EEEE</td>")
                            strBuild.Append("<td align=""left"" class=""" + SelectedText + """>" & unComponentTable.Rows(i)("ProductName") & "</td>")
                            strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & Format(unComponentTable.Rows(i)("ProductAmount"), "##,##0") & "</td>")
                            If bolCanAddPrice = True Then
                                If unComponentTable.Rows(i)("FlexibleProductIncludePrice") = 0 Then
                                    strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & "&nbsp;" & "</td>")
                                    strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & "&nbsp;" & "</td>")
                                Else
                                    strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & unComponentTable.Rows(i)("FlexibleProductIncludePrice") & "</td>")
                                    strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(unComponentTable.Rows(i)("FlexibleProductPrice"), "##,##0.00") & "</td>")
                                End If
							
                            End If
                            If Session("Material_Cost") = True Then
                                strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & "N/A" & "</td>")
                                strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & "N/A" & "</td>")
                            End If
						
                            If SelectedText = "text" Then
                                strTemp = "<a href=""productset_component.aspx?EditID=3&a=yes&ProductGroupID=" + Request.QueryString("ProductGroupID") & _
                                        "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") & _
                                        "&ProductID=" + Request.QueryString("ProductID") + "&PComponentID=" + unComponentTable.Rows(i)("PComponentID").ToString & _
                                        "&PGroupID=" + PGroupID.ToString & "&SaleMode=" & unComponentTable.Rows(i)("SaleMode") & """>"
                                strBuild.Append("<td align=""center"" class=""text"">" & strTemp & "Edit</a>")
                                
                                strTemp = "<a href=""inv_category_action.aspx?action=delete_component&EditID=3&GoBackURL=productset_component.aspx" & _
                                        "&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") & _
                                        "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") & _
                                        "&PComponentID=" + unComponentTable.Rows(i)("PComponentID").ToString + "&PGroupID=" + PGroupID.ToString & _
                                        "&SaleMode=" & unComponentTable.Rows(i)("SaleMode") & """" & _
                                        "onClick=""javascript: return confirm('" & textTable.Rows(13)("TextParamValue") & " " & _
                                        Replace(unComponentTable.Rows(i)("ProductName"), "'", "\'") & " " & textTable.Rows(15)("TextParamValue") & "')"">"
                                
                                strBuild.Append("&nbsp;&nbsp;" & strTemp & "Del</a></td>")
                            Else
                                strBuild.Append("<td align=""center"" class=""" + SelectedText + """>Updating</td>")
                            End If
                            strBuild.Append("</tr>")
                            counter = counter + 1
                        End If
                    Next
				
                    Dim CostTextValue As String = "0"
                    If costValue > 0 Then
                        CostTextValue = Format(costValue, "##,##0.00")
                    End If
                    If Session("Material_Cost") = True Then
                        'CostText.InnerHtml = textTable.Rows(16)("TextParamValue") + " " + dtTable.Rows(0)("ProductName") + " " + textTable.Rows(17)("TextParamValue") + " " + costTextValue + " " + defaultTextTable.Rows(10)("TextParamValue")
                    End If
				
                    Dim AttachEditText As String
                    If Request.QueryString("a") <> "yes" Then
                        If bolCanAddPrice = False Then
                            counterText.InnerHtml = counter.ToString
                        Else
                            counterText.InnerHtml = ""
                            
                            If Not Page.IsPostBack Then
                                txtOrdering.Text = counter.ToString()
                            End If
                        End If
                        SubmitForm.Text = "Add"
                        AttachEditText = "&b=null"
                        PComponentID.Value = "0"
                    Else
                        SubmitForm.Text = "Update"
                        counterText.InnerHtml = "<a href=""productset_component.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" & _
                                        Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" & _
                                        Request.QueryString("ProductID") + "&PGroupID=" + PGroupID.ToString + """>Cancel</a>"
                        AttachEditText = "&a=yes"
                        If Request.QueryString("PComponentID") IsNot Nothing Then
                            PComponentID.Value = Request.QueryString("PComponentID")
                        End If
                    End If
				
                    If Not Page.IsPostBack Then
                        If Not Request.QueryString("MaterialID") And IsNumeric(Request.QueryString("MaterialID")) And Not Page.IsPostBack Then
                            SelectedMaterialID = Request.QueryString("MaterialID")
                        End If
                    End If
				
                    If IsNumeric(SelectedMaterialID) And SelectedMaterialID > 0 And Not Page.IsPostBack Then
					
                        Dim materialData As DataTable
                        materialData = getInfo.GetProductInfo(0, SelectedMaterialID, objCnn)
					
                        If materialData.Rows.Count > 0 Then
					
                            MaterialCode.Text = materialData.Rows(0)("ProductCode")
                            MaterialNameText.InnerHtml = materialData.Rows(0)("ProductName")
                            MaterialID.Value = materialData.Rows(0)("ProductID")
						
                            If dtTable.Rows(0)("ProductSet") = 6 Then
                                MaterialAmount.Text = "1"
                                MaterialAmount.Enabled = False
                            Else
                                If Request.QueryString("a") = "yes" Then
                                    MaterialAmount.Text = SelectedMaterialAmount
                                    If Flex1.Visible = True Then
                                        FlexibleProductIncludePrice.Checked = FlexIncPrice
                                        txtFlexibleProductPrice.Text = Format(FlexProductPrice, "##0.00")
                                    End If
                                End If
                                If Request.QueryString("MaterialAmount") <> Nothing Then
                                    MaterialAmount.Text = Request.QueryString("MaterialAmount")
                                End If
                                MaterialAmount.Enabled = True
                                
                                'For Add New Use Counter
                                If PComponentID.Value = "0" Then
                                    txtOrdering.Text = counter
                                Else
                                    txtOrdering.Text = selectOrdering
                                End If
                            End If

                        End If
                    End If
				
                    ResultText.InnerHtml = strBuild.ToString
				
                    selectMaterialText.InnerHtml = "<a href=""JavaScript: newWindow = window.open( 'product_category.aspx?EditID=3&From=component" & _
                                "&ProductGroupID=" & Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") & _
                                "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") & _
                                "&PGroupID=" + PGroupID.ToString + "&ProductSet=" + dtTable.Rows(0)("ProductSet").ToString & _
                                "&MaterialAmount=' + document.forms[0].MaterialAmount.value + '&PComponentID=' + document.forms[0].PComponentID.value + '" + AttachEditText & _
                                "', '', 'width=600,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & _
                                defaultTextTable.Rows(9)("TextParamValue") + "</a>"
				
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

    Sub DoAddUpdate(Source As Object, E As EventArgs)
        Dim strTemp As String
        Dim FoundError As Boolean = False
        Dim PGroupID As Integer = 0
        Dim ordering As Integer
        If IsNumeric(Request.QueryString("PGroupID")) Then
            PGroupID = Request.QueryString("PGroupID")
        End If
        Dim textTable As New DataTable()
        textTable = getPageText.GetText(8, Session("LangID"), objCnn)

        Dim materialByCode As DataTable
        materialByCode = getInfo.GetProductInfo(0, 0, MaterialCode.Text, Request.QueryString("ProductLevelID"), objCnn)

        If materialByCode.Rows.Count = 0 Then
            ValidateCode.InnerHtml = "<tr><td colspan=""3"" class=""errorText"">" & textTable.Rows(9)("TextParamValue") & "</td></tr>"
            FoundError = True
        Else
            Dim chkComponent As New DataTable()
            chkComponent = getInfo.GetProductInfo1(0, MaterialCode.Text, ProductID.Value, Request.QueryString("ProductLevelID"), PGroupID, objCnn)
            If chkComponent.Rows.Count > 0 Then
                If (PComponentID.Value = "0" Or (PComponentID.Value <> "0" And PComponentID.Value <> chkComponent.Rows(0)("PComponentID"))) Then
                    ValidateCode.InnerHtml = "<tr><td colspan=""3"" class=""errorText"">" & textTable.Rows(38)("TextParamValue") & "</td></tr>"
                    FoundError = True
                    MaterialNameText.InnerHtml = chkComponent.Rows(0)("ProductName")
                    MaterialID.Value = chkComponent.Rows(0)("ProductID")
				
                Else
                    SetValue(materialByCode)
                End If
            Else
                SetValue(materialByCode)
            End If
        End If
	
        If IsNumeric(MaterialAmount.Text) Then
            ValidateAmount.InnerHtml = ""
        Else
            ValidateAmount.InnerHtml = textTable.Rows(10)("TextParamValue") + "<br>"
            FoundError = True
        End If
        
        'Error Numeric Text
        If textTable.Rows.Count > 67 Then
            strTemp = textTable.Rows(67)("TextParamValue")
        Else
            strTemp = "Must be numeric"
        End If
        ValidateOrdering.InnerHtml = ""
        If txtOrdering.Visible = True Then
            If Not IsNumeric(txtOrdering.Text) Then
                ValidateOrdering.InnerHtml = strTemp & "<br>"
                FoundError = True
            End If
        End If
        
        If Flex1.Visible = True Then
            ValidateFlex.InnerHtml = ""
            If FlexibleProductIncludePrice.Checked = True Then
                If Not IsNumeric(txtFlexibleProductPrice.Text) Then
                    ValidateFlex.InnerHtml = strTemp & "<br>"
                    FoundError = True
                End If
            End If
        End If
        If FoundError = False Then
            Dim Result As String
            Dim myArray() As String
            myArray = PComponentID.Value.Split(":"c)
            Dim FlexInc As Boolean = False
            Dim FlexPrice As Double = 0
            If Flex1.Visible = True Then
                FlexInc = FlexibleProductIncludePrice.Checked
                If FlexInc = True Then
                    FlexPrice = txtFlexibleProductPrice.Text
                End If
            End If
            If txtOrdering.Visible = False Then
                ordering = -1         'Use MaxOrderID
            Else
                ordering = CInt(txtOrdering.Text)
            End If
            
            Application.Lock()
            If PComponentID.Value = "0" Then
                Result = getInfo.AUDComponent("Add", "0", ProductID.Value, MaterialID.Value, MaterialAmount.Text, 0, 0, PGroupID, 1, FlexInc, FlexPrice, ordering, 0, objCnn)
            ElseIf myArray.Length >= 4 Then
                Result = getInfo.AUDComponent("Update", PComponentID.Value, ProductID.Value, MaterialID.Value, MaterialAmount.Text, 0, 0, PGroupID, 1, FlexInc, _
                                             FlexPrice, ordering, 0, objCnn)
            End If
            getInfo.UpdateProductDate(ProductID.Value, objCnn)
            Application.UnLock()
            If Result = "Success" Then
                Response.Redirect("productset_component.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&PGroupID=" + PGroupID.ToString)
            Else
                errorMsg.InnerHtml = Result
            End If

        End If
	
    End Sub

    Sub SetValue(materialByCode As DataTable)
        ValidateCode.InnerHtml = ""
        MaterialCode.Text = materialByCode.Rows(0)("ProductCode")
        MaterialNameText.InnerHtml = materialByCode.Rows(0)("ProductName")
        MaterialID.Value = materialByCode.Rows(0)("ProductID")
    End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
