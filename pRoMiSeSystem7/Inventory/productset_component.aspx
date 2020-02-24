<%@ Page Language="VB" ContentType="text/html" debug="True"%>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySql.GlobalFunctions" %>
<%@Import Namespace="POSTypeClass" %>
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
       <td id="TDSaleModeCombo" align="left" runat="server" colspan="9">
           <asp:DropDownList ID="cboSaleMode"  runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboSaleMode_SelectedIndexChanged"  ></asp:DropDownList>
       </td>
   </tr>
	<tr id="trHeader" runat="server" >
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
	<input type="hidden" id="ProductSetType" runat="server">
	<input type="hidden" id="CurrentPGroupID" runat="server">
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
    
    Dim bolCanAddCompoenntPrice As Boolean
    Dim textTable As New DataTable()
    Dim defaultTextTable As New DataTable()
		
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Inv_Product_Category") Then
	  
            If Not Request.QueryString("ProductID") And IsNumeric(Request.QueryString("ProductID")) Then
	  	
                'If Request.QueryString("a")	= "yes" Then
                'ShowAddMaterial.Visible = False
                'End If
                ProductID.Value = Request.QueryString("ProductID")
                If IsNumeric(Request.QueryString("PGroupID")) Then
                    CurrentPGroupID.Value = Request.QueryString("PGroupID")
                Else
                    CurrentPGroupID.Value = 0
                End If
                ProductSetType.Value = 0
		
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
                Dim dtTable, dtPCompoentGroup As DataTable
                dtTable = getInfo.GetProductInfo(0, Request.QueryString("ProductID"), objCnn)
			
                If dtTable.Rows.Count <> 0 Then
                    textTable = getPageText.GetText(8, Session("LangID"), objCnn)
			         
                    defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
                   
                    ProductSetType.Value  = dtTable.Rows(0)("ProductSet")
                    If dtTable.Rows(0)("ProductSet") = 7 Then
                        GoBackText.InnerHtml = "<a href=""pcomponent_group.aspx?ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + """>" + textTable.Rows(57)("TextParamValue") + "</a>"
                        bolCanAddCompoenntPrice = True
                    Else
                        GoBackText.InnerHtml = ""
                        bolCanAddCompoenntPrice = False
                    End If
				
                    headerTD10.Visible = bolCanAddCompoenntPrice
                    headerTD11.Visible = bolCanAddCompoenntPrice
                    Flex1.Visible = bolCanAddCompoenntPrice
                    Flex2.Visible = bolCanAddCompoenntPrice
                    txtOrdering.Visible = bolCanAddCompoenntPrice
                    
                    dtPCompoentGroup = getInfo.GetComponentGroup(dtTable.Rows(0)("ProductID"), CurrentPGroupID.Value, objCnn)
                    
                    strTemp = textTable.Rows(37)("TextParamValue") & " " & dtTable.Rows(0)("ProductName")
                    If dtPCompoentGroup.Rows.Count > 0 Then
                        If IsDBNull(dtPCompoentGroup.Rows(0)("SetGroupName")) Then
                            dtPCompoentGroup.Rows(0)("SetGroupName") = ""
                        End If
                        strTemp &= " : " & dtPCompoentGroup.Rows(0)("SetGroupName")
                        If dtPCompoentGroup.Rows(0)("SetGroupNo") > 0 Then
                            If dtPCompoentGroup.Rows(0)("RequireAddAmountForProduct") > 0 Then
                                strTemp &= " (# Of Products = " & dtPCompoentGroup.Rows(0)("RequireAddAmountForProduct") & ") "
                            End If
                        End If
                    End If
                    HeaderText.InnerHtml = strTemp
                    
                    OrderText.InnerHtml = textTable.Rows(1)("TextParamValue")
                    CodeText.InnerHtml = textTable.Rows(35)("TextParamValue")
                    NameText.InnerHtml = textTable.Rows(36)("TextParamValue")
                    AmountText.InnerHtml = "Amount per select" 'textTable.Rows(4)("TextParamValue") 
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
				
                  
                    If Not Page.IsPostBack Then
                        LoadSaleModeIntoCombo()
                        
                        If cboSaleMode.Items.Count > 0 Then
                            DisplayProductComponentBySaleMode(cboSaleMode.SelectedValue)
                        End If
                    End If
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
    
    Private Sub LoadSaleModeIntoCombo()
        Dim dtAllSaleMode As DataTable
        Dim i As Integer
        Dim lstItem As ListItem
        Dim selIndex, selSaleMode As Integer
        selIndex = -1
        
        If Request.QueryString("SaleMode") Is Nothing Then
            selSaleMode = 1
        Else
            If IsNumeric(Request.QueryString("SaleMode")) Then
                selSaleMode = CInt(Request.QueryString("SaleMode"))
            Else
                selSaleMode = 1
            End If
        End If
        
        dtAllSaleMode = POSDBSQLFront.POSUtilSQL.ListAllSaleMode(objDB, objCnn)
        For i = 0 To dtAllSaleMode.Rows.Count - 1
            lstItem = New ListItem
            lstItem.Text = dtAllSaleMode.Rows(i)("SaleModeName")
            lstItem.Value = dtAllSaleMode.Rows(i)("SaleModeID")
            cboSaleMode.Items.Add(lstItem)
            
            If dtAllSaleMode.Rows(i)("SaleModeID") = selSaleMode Then
                selIndex = i
            End If
        Next i

        If dtAllSaleMode.Rows.Count <> 0 Then
            cboSaleMode.SelectedIndex = selIndex
        End If
        
    End Sub
    
    Private Sub DisplayProductComponentBySaleMode(displaySaleMode As Integer)
        Dim costValue As Decimal = 0
        Dim strTemp As String
        Dim i, counter, j As Integer
        Dim strBuild As StringBuilder
		
        Dim bolIsUpdateComponentMode As Boolean
        Dim editSaleModeID As Integer
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

        Dim dtComponent, dtUnComponent As DataTable
        dtComponent = getInfo.GetProductSetInfo(Request.QueryString("ProductID"), CurrentPGroupID.Value, "0", displaySaleMode, Session("PMonthYearDate_Month"), _
                                      Session("PMonthYearDate_Year"), Request.QueryString("ProductLevelID"), objCnn)
        dtUnComponent = getInfo.GetProductSetInfo1(Request.QueryString("ProductID"), CurrentPGroupID.Value, "0", displaySaleMode, objCnn)
			                    
        
        If IsNumeric(Request.QueryString("SaleMode")) Then
            editSaleModeID = Request.QueryString("SaleMode")
        End If
        bolIsUpdateComponentMode = False
        If Not Page.IsPostBack Then
            If Request.QueryString("a") = "yes" Then
                'Check For Same Display SaleMode
                If editSaleModeID = displaySaleMode Then
                    bolIsUpdateComponentMode = True
                End If
            End If
        End If
        
        '  errorMsg.InnerHtml = "PGroupID = " & CurrentPGroupID.Value & ", SaleMode = " & displaySaleMode & " : Component = " & dtComponent.Rows.Count & ", " & _
        '                      " UnComponent = " & dtUnComponent.Rows.Count
        
        'Clear Control
        counterText.InnerHtml = ""
        MaterialCode.Text = ""
        MaterialNameText.InnerHtml = ""
        MaterialID.Value = 0
        MaterialAmount.Text = ""
        FlexibleProductIncludePrice.Checked = False
        txtFlexibleProductPrice.Text = ""

        SelectedMaterialAmount = ""
        strBuild = New StringBuilder
        
        If (dtComponent.Rows.Count = 0) And (displaySaleMode <> POSType.SALEMODE_DINEIN) Then
            trHeader.Visible = True
            AddDataText.Visible = True 
            strBuild.Append("<tr><td colspan=""8""  align=""center"" class=""" + "boldText" + """>" & "SAME AS DINE IN" & "</td></tr>")
        Else
            trHeader.Visible = True
            AddDataText.Visible = True
            For i = 0 To dtComponent.Rows.Count - 1
                If Not IsDBNull(dtComponent.Rows(i)("ProductID")) Then
                    If bolIsUpdateComponentMode = True And Request.QueryString("PComponentID") = dtComponent.Rows(i)("PComponentID") Then
                        SelectedText = "disabledText"
                        SelectedMaterialID = dtComponent.Rows(i)("ProductID")
                        selectOrdering = dtComponent.Rows(i)("Ordering")
                        SelectedMaterialAmount = Format(dtComponent.Rows(i)("ProductAmount"), "##,##0")
                        If dtComponent.Rows(i)("FlexibleProductIncludePrice") = 0 Then
                            FlexIncPrice = False
                        Else
                            FlexIncPrice = True
                        End If
                        FlexProductPrice = dtComponent.Rows(i)("FlexibleProductPrice")
                    Else
                        SelectedText = "text"
                    End If
          
                    'costTable = getInfo.ProductUnitCost(Request.QueryString("ProductLevelID"),componentTable.Rows(i)("ProductID"), Session("PMonthYearDate_Month"),Session("PMonthYearDate_Year"),objCnn)
					
                    If txtOrdering.Visible = True Then
                        strBuild.Append("<tr><td align=""center"" class=""" + SelectedText + """>" & dtComponent.Rows(i)("Ordering") & "</td>")
                        counter = dtComponent.Rows(i)("Ordering")
                    Else
                        strBuild.Append("<tr><td align=""center"" class=""" + SelectedText + """>" & counter.ToString & "</td>")
                    End If
                    strBuild.Append("<td align=""left"" class=""" + SelectedText + """>" & dtComponent.Rows(i)("ProductCode") & "</td>")
                    strBuild.Append("<td align=""left"" class=""" + SelectedText + """>" & dtComponent.Rows(i)("ProductName") & "</td>")
                    strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & Format(dtComponent.Rows(i)("ProductAmount"), "##,##0") & "</td>")
                    If bolCanAddCompoenntPrice = True Then
                        If dtComponent.Rows(i)("FlexibleProductIncludePrice") = 0 Then
                            strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & "&nbsp;" & "</td>")
                            strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & "&nbsp;" & "</td>")
                        Else
                            strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & dtComponent.Rows(i)("FlexibleProductIncludePrice") & "</td>")
                            strTemp = "&nbsp;<a href=""JavaScript: newWindow = window.open( 'productcomponent_multishop.aspx?ProductLevelID=" & Request.QueryString("ProductLevelID").ToString & _
                                    "&PGroupID=" & CurrentPGroupID.Value & "&ProductID=" + Request.QueryString("ProductID").ToString & _
                                    "&SubProductID=" + dtComponent.Rows(i)("ProductID").ToString & "&SaleMode=" & dtComponent.Rows(i)("SaleMode") & _
                                    "', '', 'width=550,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & _
                                    "Multi Price" & "</a>"
                                    
                            strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(dtComponent.Rows(i)("FlexibleProductPrice"), "##,##0.00") & _
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
                            strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(subCostValue * dtComponent.Rows(i)("ProductAmount"), "##,##0.00") & "</td>")
                            costValue += subCostValue * dtComponent.Rows(i)("ProductAmount")
							
                        Else
                            strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & "N/A" & "</td>")
                        End If
                    End If
					
                    If SelectedText = "text" Then
                        strTemp = "<a href=""productset_component.aspx?EditID=3&a=yes&ProductGroupID=" + Request.QueryString("ProductGroupID") & _
                                    "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") & _
                                    "&ProductID=" + Request.QueryString("ProductID") + "&PComponentID=" + dtComponent.Rows(i)("PComponentID").ToString & _
                                    "&PGroupID=" + CurrentPGroupID.Value & "&SaleMode=" & dtComponent.Rows(i)("SaleMode") & """>"
                        strBuild.Append("<td align=""center"" class=""text"">" & strTemp & "Edit</a>")
                                
                        strTemp = "<a href=""inv_category_action.aspx?action=delete_component&EditID=3&GoBackURL=productset_component.aspx" & _
                                 "&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") & _
                                 "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") & _
                                 "&PComponentID=" + dtComponent.Rows(i)("PComponentID").ToString + "&PGroupID=" & CurrentPGroupID.Value & _
                                 "&SaleMode=" & dtComponent.Rows(i)("SaleMode") & """" & _
                                 "onClick=""javascript: return confirm('" & textTable.Rows(13)("TextParamValue") & " " & _
                                    Replace(dtComponent.Rows(i)("ProductName"), "'", "\'") & " " & textTable.Rows(15)("TextParamValue") & "')"">"
                        strBuild.Append("&nbsp;&nbsp;" & strTemp & "Del</a></td>")
                    Else
                        strBuild.Append("<td align=""center"" class=""" + SelectedText + """>Updating</td>")
                    End If
                    strBuild.Append("</tr>")
                    counter += 1
                    componentList += "," + dtComponent.Rows(i)("PComponentID").ToString
                End If
            Next i
            componentList += ","
				
            Dim compareString As String
            For i = 0 To dtUnComponent.Rows.Count - 1
                compareString = "," + dtUnComponent.Rows(i)("PComponentID").ToString + ","
                If componentList.IndexOf(compareString) = -1 Then
                    If Request.QueryString("a") = "yes" And Request.QueryString("PComponentID") = dtUnComponent.Rows(i)("PComponentID") Then
                        SelectedText = "disabledText"
                        SelectedMaterialID = dtUnComponent.Rows(i)("ProductID")
                        SelectedMaterialAmount = Format(dtUnComponent.Rows(i)("ProductAmount"), "##,##0")
                    Else
                        SelectedText = "text"
                    End If
                    If txtOrdering.Visible = True Then
                        strBuild.Append("<tr><td align=""center"" class=""" + SelectedText + """>" & dtUnComponent.Rows(i)("Ordering") & "</td>")
                        counter = dtUnComponent.Rows(i)("Ordering")
                    Else
                        strBuild.Append("<tr><td align=""center"" class=""" + SelectedText + """>" & counter.ToString & "</td>")
                    End If
                    strBuild.Append("<td align=""left"" class=""" + SelectedText + """>" & dtUnComponent.Rows(i)("ProductCode") & "EEEE</td>")
                    strBuild.Append("<td align=""left"" class=""" + SelectedText + """>" & dtUnComponent.Rows(i)("ProductName") & "</td>")
                    strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & Format(dtUnComponent.Rows(i)("ProductAmount"), "##,##0") & "</td>")
                    If bolCanAddCompoenntPrice = True Then
                        If dtUnComponent.Rows(i)("FlexibleProductIncludePrice") = 0 Then
                            strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & "&nbsp;" & "</td>")
                            strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & "&nbsp;" & "</td>")
                        Else
                            strBuild.Append("<td align=""center"" class=""" + SelectedText + """>" & dtUnComponent.Rows(i)("FlexibleProductIncludePrice") & "</td>")
                            strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(dtUnComponent.Rows(i)("FlexibleProductPrice"), "##,##0.00") & "</td>")
                        End If
							
                    End If
                    If Session("Material_Cost") = True Then
                        strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & "N/A" & "</td>")
                        strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & "N/A" & "</td>")
                    End If
						
                    If SelectedText = "text" Then
                        strTemp = "<a href=""productset_component.aspx?EditID=3&a=yes&ProductGroupID=" + Request.QueryString("ProductGroupID") & _
                                "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") & _
                                "&ProductID=" + Request.QueryString("ProductID") + "&PComponentID=" + dtUnComponent.Rows(i)("PComponentID").ToString & _
                                "&PGroupID=" & CurrentPGroupID.Value & "&SaleMode=" & dtUnComponent.Rows(i)("SaleMode") & """>"
                        strBuild.Append("<td align=""center"" class=""text"">" & strTemp & "Edit</a>")
                                
                        strTemp = "<a href=""inv_category_action.aspx?action=delete_component&EditID=3&GoBackURL=productset_component.aspx" & _
                                "&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") & _
                                "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") & _
                                "&PComponentID=" + dtUnComponent.Rows(i)("PComponentID").ToString + "&PGroupID=" & CurrentPGroupID.Value & _
                                "&SaleMode=" & dtUnComponent.Rows(i)("SaleMode") & """" & _
                                "onClick=""javascript: return confirm('" & textTable.Rows(13)("TextParamValue") & " " & _
                                Replace(dtUnComponent.Rows(i)("ProductName"), "'", "\'") & " " & textTable.Rows(15)("TextParamValue") & "')"">"
                                
                        strBuild.Append("&nbsp;&nbsp;" & strTemp & "Del</a></td>")
                    Else
                        strBuild.Append("<td align=""center"" class=""" + SelectedText + """>Updating</td>")
                    End If
                    strBuild.Append("</tr>")
                    counter = counter + 1
                End If
            Next
        End If
				
        Dim CostTextValue As String = "0"
        If costValue > 0 Then
            CostTextValue = Format(costValue, "##,##0.00")
        End If
        If Session("Material_Cost") = True Then
            'CostText.InnerHtml = textTable.Rows(16)("TextParamValue") + " " + dtTable.Rows(0)("ProductName") + " " + textTable.Rows(17)("TextParamValue") + " " + costTextValue + " " + defaultTextTable.Rows(10)("TextParamValue")
        End If
		
        Dim AttachEditText As String

        If bolIsUpdateComponentMode = False Then
            If bolCanAddCompoenntPrice = False Then
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
                            Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") & _
                            "&ProductID=" & Request.QueryString("ProductID") + "&PGroupID=" & CurrentPGroupID.Value & _
                            "&SaleMode=" & Request.QueryString("SaleMode") & """>Cancel</a>"
            AttachEditText = "&a=yes"
            If Request.QueryString("PComponentID") IsNot Nothing Then
                PComponentID.Value = Request.QueryString("PComponentID")
            End If
        End If
        
        ResultText.InnerHtml = strBuild.ToString
        
        selectMaterialText.InnerHtml = "<a href=""JavaScript: newWindow = window.open( 'product_category.aspx?EditID=3&From=component" & _
                    "&ProductGroupID=" & Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") & _
                    "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") & _
                    "&PGroupID=" & CurrentPGroupID.Value & "&ProductSet=" & ProductSetType.Value & "&SaleMode=" & displaySaleMode & _
                    "&MaterialAmount=' + document.forms[0].MaterialAmount.value + '&PComponentID=' + document.forms[0].PComponentID.value + '" + AttachEditText & _
                    "', '', 'width=600,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & _
                    defaultTextTable.Rows(9)("TextParamValue") + "</a>"
       
        'For Add New Use Counter
        If PComponentID.Value = "0" Then
            txtOrdering.Text = counter
        Else
            txtOrdering.Text = selectOrdering
        End If
          
        If Not Request.QueryString("MaterialID") And IsNumeric(Request.QueryString("MaterialID")) And Not Page.IsPostBack Then
            SelectedMaterialID = Request.QueryString("MaterialID")
        End If

        If Not Page.IsPostBack Then
            If SelectedMaterialID > 0 Then
                Dim materialData As DataTable
                materialData = getInfo.GetProductInfo(0, SelectedMaterialID, objCnn)
					
                If materialData.Rows.Count > 0 Then
                    MaterialCode.Text = materialData.Rows(0)("ProductCode")
                    MaterialNameText.InnerHtml = materialData.Rows(0)("ProductName")
                    MaterialID.Value = materialData.Rows(0)("ProductID")
						
                    If ProductSetType.Value = 6 Then
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
                    End If
                End If
            End If
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
            chkComponent = getInfo.GetProductInfo1(0, MaterialCode.Text, ProductID.Value, Request.QueryString("ProductLevelID"), PGroupID, _
                                  cboSaleMode.SelectedValue, objCnn)
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
                Result = getInfo.AUDComponent("Add", "0", ProductID.Value, MaterialID.Value, MaterialAmount.Text, 0, 0, PGroupID, cboSaleMode.SelectedValue, _
                                           FlexInc, FlexPrice, ordering, 0, objCnn)
            ElseIf myArray.Length >= 4 Then
                'Update Data --> PGroupID, MateiralID, SaleMode --> Is In PComponentID Value
                Result = getInfo.AUDComponent("Update", PComponentID.Value, ProductID.Value, MaterialID.Value, MaterialAmount.Text, 0, 0, PGroupID, 1, FlexInc, _
                                             FlexPrice, ordering, 0, objCnn)
            Else
                Result = ""
            End If
            getInfo.UpdateProductDate(ProductID.Value, objCnn)
            Application.UnLock()
            If Result = "Success" Then
                strTemp = "productset_component.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") & _
                            "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") & _
                            "&ProductID=" + Request.QueryString("ProductID") + "&PGroupID=" + PGroupID.ToString & _
                            "&SaleMode=" & cboSaleMode.SelectedValue
                Response.Redirect(strTemp)
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

   
    Protected Sub cboSaleMode_SelectedIndexChanged(sender As Object, e As EventArgs)
        DisplayProductComponentBySaleMode(cboSaleMode.SelectedValue)
    End Sub
</script>
</body>
</html>
