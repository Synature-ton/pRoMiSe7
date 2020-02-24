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
<title>Product Recipe Setting</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body style="background-color:white">

<ASP:Label id="updateMessage" CssClass="text" runat="server" />

<table cellpadding="2" cellspacing="2" width="100%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td><span id="showCostCriteria" visible="false" runat="server">
<td align="right"><table cellpadding="0" cellspacing="0"><tr><td><synature:date id="PMonthYearDate" runat="server" /></td><td><input type="submit" value="Submit"></td></tr></table></td></span>
<td align="right"><td align="right"><div class="text" id="GoBackText" runat="server"></div></td></td>
</tr>
<tr><td height="5" colspan="2"></td></tr>
<tr id="showMsg" visible="false" runat="server"><td colspan="2"><span id="periodText" class="text" runat="server"></span></td></tr>
<tr id="showCost" visible="false" runat="server"><td><div id="CostText" class="text" runat="server"></div></td>
<td align="right"></td></tr>
<tr><td height="5" colspan="2"></td></tr>
<span id="showGroupSel" visible="false" runat="server">
	<tr><td colspan="2" align="right"><span id="GroupSelection" runat="server"></span></td></tr>
</span>

</table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	
	
	<div id="ResultText" runat="server"></div>
	
</table>

<div id="errorMsg2" runat="server" />

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
Dim CostInfo As New CostClass
		
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Inv_Product_Category") Then
	  
            If Not Request.QueryString("ProductID") And IsNumeric(Request.QueryString("ProductID")) Then
	  	
                'If Request.QueryString("a")	= "yes" Then
                'ShowAddMaterial.Visible = False
                'End If
                'ProductID.Value = Request.QueryString("ProductID")
			
		
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
                'If Not Page.IsPostBack Then Session("PMonthYearDate_Month") = DateTime.Now.Month
                PMonthYearDate.SelectedMonth = Session("PMonthYearDate_Month")
		
                If IsNumeric(Request.Form("PMonthYearDate_Year")) Then
                    Session("PMonthYearDate_Year") = Request.Form("PMonthYearDate_Year")
                ElseIf IsNumeric(Request.QueryString("PMonthYearDate_Year")) Then
                    Session("PMonthYearDate_Year") = Request.QueryString("PMonthYearDate_Year")
                ElseIf Trim(Session("PMonthYearDate_Year")) = "" Then
                    Session("PMonthYearDate_Year") = DateTime.Now.Year
                End If
                'If Not Page.IsPostBack Then Session("PMonthYearDate_Year") = DateTime.Now.Year
                PMonthYearDate.SelectedYear = Session("PMonthYearDate_Year")
			
                'Try
                objCnn = getCnn.EstablishConnection()

                Dim dtTable As New DataTable()
                dtTable = getInfo.GetProductInfo(0, Request.QueryString("ProductID"), objCnn)
    			
                Dim strTemp As String
                Dim StartDateString, EndDateString As String
                Dim PGroupID As Integer = 0
                Dim SetGroupNo As Integer
                If IsNumeric(Request.QueryString("PGroupID")) Then
                    PGroupID = Request.QueryString("PGroupID")
                End If
			
                Dim componentGroup As New DataTable()
                componentGroup = getInfo.GetComponentGroup(Request.QueryString("ProductID"), PGroupID, objCnn)
                Dim costValue As Double = 0
                Dim j As Integer
				
                If dtTable.Rows.Count <> 0 And componentGroup.Rows.Count <> 0 Then
                    SetGroupNo = componentGroup.Rows(0)("SetGroupNo")
                    Dim textTable As New DataTable()
                    textTable = getPageText.GetText(8, Session("LangID"), objCnn)
				
                    Dim defaultTextTable As New DataTable()
                    defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)

                    If dtTable.Rows(0)("ProductSet") = 7 Then
                        GoBackText.InnerHtml = "<a href=""pcomponent_group.aspx?ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + """>" + textTable.Rows(57)("TextParamValue") + "</a>"
                    Else
                        GoBackText.InnerHtml = "<a href=""javascript: window.close()"">Close Window</a>"
                    End If
				
                    strTemp = textTable.Rows(0)("TextParamValue") & " " & dtTable.Rows(0)("ProductName")
                    HeaderText.InnerHtml = strTemp 
                    Dim ComponentLevel As Integer = dtTable.Rows(0)("ComponentLevel")
			
				
                    Dim i, counter As Integer
                    Dim strBuild As StringBuilder
				
                    Dim UnitIDValue As Integer = 0
                    Dim SelectedText As String
                    Dim SelectedMaterialID As String = 0
                    Dim SelectedMaterialAmount As String
                    Dim SelectedShowOnOrder As Boolean
                    Dim Result As String
                    Dim FoundError As Boolean
                    Dim materialByCode As DataTable
                    Dim componentTable As New DataTable()
                    Dim MaterialIDDB, UnitSmallIDDB As Integer
                    Dim dtSMData As DataTable
                    Dim ErrorMsg(-1) As String
                    Dim ErrorMsgQty(-1) As String
                    Dim chkComponent As DataTable
				
                    strBuild = New StringBuilder
                    dtSMData = POSDBSQLFront.POSUtilSQL.ListAllSaleMode(objDB, objCnn)
                    ReDim ErrorMsg(dtSMData.Rows.Count)
                    ReDim ErrorMsgQty(dtSMData.Rows.Count)

                    For j = 0 To dtSMData.Rows.Count - 1
                        ErrorMsgQty(j) = ""
                        ErrorMsg(j) = ""
                    Next
				
                    For j = 0 To dtSMData.Rows.Count - 1
                        If Not Request.Form("SubmitSaleMode_" & dtSMData.Rows(j)("SaleModeID")) Is Nothing Then
                            FoundError = False
                            ErrorMsg(j) = ""
                            ErrorMsgQty(j) = ""
                            If Not IsNumeric(Request.Form("MaterialAmount_" & dtSMData.Rows(j)("SaleModeID"))) Then
                                FoundError = True
                                ErrorMsgQty(j) = "<tr><td align=""right"" class=""ErrorText"" width=""100%"">Must be numeric</td></tr>"
                            End If

                            materialByCode = getInfo.GetMaterialInfoByCode(0, Request.Form("MaterialCode_" & dtSMData.Rows(j)("SaleModeID")), objCnn)
	
                            If materialByCode.Rows.Count = 0 Or Trim(Request.Form("MaterialCode_" & dtSMData.Rows(j)("SaleModeID"))) = "" Then
                                FoundError = True
                                ErrorMsg(j) = "<tr><td colspan=""3"" class=""ErrorText"">No data found</td></tr>"
                            Else
                                MaterialIDDB = materialByCode.Rows(0)("MaterialID")
                                UnitSmallIDDB = materialByCode.Rows(0)("UnitSmallID")
                                chkComponent = objDB.List("select * from productcomponent where SaleMode=" + dtSMData.Rows(j)("SaleModeID").ToString + " AND MaterialID=" + materialByCode.Rows(0)("MaterialID").ToString + " AND PGroupID=" + Request.QueryString("PGroupID").ToString, objCnn)
                                If chkComponent.Rows.Count > 0 And Request.Form("PComponentID") = "0" Then
                                    FoundError = True
                                    ErrorMsg(j) = "<tr><td colspan=""3"" class=""ErrorText"">Duplicate data</td></tr>"
                                End If
                            End If
						
                            Dim CopyAllSaleMode As Integer = 0
                            If Not Request.Form("CopyAll") Is Nothing Then
                                If Request.Form("CopyAll") = 1 Then
                                    CopyAllSaleMode = 1
                                End If
                            End If
						
                            If FoundError = False Then
							
                                If Request.Form("PComponentID") = "0" Then
                                    Result = getInfo.AUDComponent("Add", "", Request.QueryString("ProductID"), MaterialIDDB, _
                                                    Request.Form("MaterialAmount_" & dtSMData.Rows(j)("SaleModeID")), UnitSmallIDDB, _
                                                    Request.Form("ShowOnSearch_" & dtSMData.Rows(j)("SaleModeID")), Request.QueryString("PGroupID"), _
                                                    dtSMData.Rows(j)("SaleModeID"), False, 0, CopyAllSaleMode, objCnn)
                                Else
                                    Result = getInfo.AUDComponent("Update", Request.Form("PComponentID"), Request.QueryString("ProductID"), MaterialIDDB, _
                                                    Request.Form("MaterialAmount_" & dtSMData.Rows(j)("SaleModeID")), UnitSmallIDDB, _
                                                    Request.Form("ShowOnSearch_" & dtSMData.Rows(j)("SaleModeID")), Request.QueryString("PGroupID"), _
                                                    dtSMData.Rows(j)("SaleModeID"), False, 0, CopyAllSaleMode, objCnn)
                                End If
                                getInfo.UpdateProductDate(Request.QueryString("ProductID"), objCnn)
                                Response.Redirect("product_component.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&PGroupID=" + Request.QueryString("PGroupID").ToString)
                            End If
                        End If
                    Next

                    If Not IsDBNull(componentGroup.Rows(0)("StartDate")) Then
                        StartDateString = DateTimeUtil.FormatDateTime(componentGroup.Rows(0)("StartDate"), "DateOnly")
                    Else
                        StartDateString = "-"
                    End If
                    If Not IsDBNull(componentGroup.Rows(0)("EndDate")) Then
                        EndDateString = DateTimeUtil.FormatDateTime(componentGroup.Rows(0)("EndDate"), "DateOnly")
                    Else
                        EndDateString = textTable.Rows(49)("TextParamValue")
                    End If
                    showMsg.Visible = True
                    Dim SelectMaterial As String
                    Dim AttachEditText As String
                    Dim materialData As DataTable
                    Dim unitData As DataTable
                    Dim MaterialCodeVal, MaterialAmountVal, ShowOnOrderVal, PComponentIDVal, MaterialNameVal, MaterialIDVal, UnitNameVal, UnitSmallIDVal As String
                    Dim SubmitText, CancelText As String
                    Dim Editing As Boolean
                    'periodText.InnerHtml = textTable.Rows(47)("TextParamValue") + " " + StartDateString + " " + textTable.Rows(48)("TextParamValue") + " " + EndDateString					
									
                    For j = 0 To dtSMData.Rows.Count - 1
					
                        SelectedMaterialID = 0
                        If Not Page.IsPostBack Then
                            If Not Request.QueryString("MaterialID") And IsNumeric(Request.QueryString("MaterialID")) And Not Page.IsPostBack Then
                                If dtSMData.Rows(j)("SaleModeID") = Request.QueryString("SaleMode") Then
                                    SelectedMaterialID = Request.QueryString("MaterialID")
                                End If
                            End If
						
                            If Not Request.Form("MaterialID_" & dtSMData.Rows(j)("SaleModeID")) Is Nothing Then
                                If IsNumeric(Request.Form("MaterialID_" & dtSMData.Rows(j)("SaleModeID"))) Then
                                    SelectedMaterialID = Request.Form("MaterialID_" & dtSMData.Rows(j)("SaleModeID"))
                                End If
                            End If
                        End If
				
				
                        MaterialCodeVal = ""
                        MaterialNameVal = ""
                        MaterialIDVal = ""
                        MaterialAmountVal = ""
                        ShowOnOrderVal = ""
                        If IsNumeric(SelectedMaterialID) And SelectedMaterialID > 0 And Not Page.IsPostBack Then
						
                            materialData = getInfo.GetMaterialInfo(0, SelectedMaterialID, objCnn)
						
                            If materialData.Rows.Count > 0 Then
						
                                MaterialCodeVal = materialData.Rows(0)("MaterialCode")
                                MaterialNameVal = materialData.Rows(0)("MaterialName")
                                MaterialIDVal = materialData.Rows(0)("MaterialID")
                                If Request.QueryString("a") = "yes" Then
                                    MaterialAmountVal = SelectedMaterialAmount
                                    ShowOnOrderVal = SelectedShowOnOrder
                                End If
                                If Request.QueryString("MaterialAmount") <> Nothing Then
                                    MaterialAmountVal = Format(Request.QueryString("MaterialAmount"), "####0.0000")
                                End If
                                If Request.QueryString("ShowOnOrder") <> Nothing Then
                                    ShowOnOrderVal = Request.QueryString("ShowOnOrder")
                                End If
							
                                unitData = getInfo.GetUnitInfo(2, materialData.Rows(0)("UnitSmallID"), objCnn)
                                If unitData.Rows.Count > 0 Then
                                    UnitNameVal = unitData.Rows(0)("UnitSmallName")
                                    UnitSmallIDVal = unitData.Rows(0)("UnitSmallID")
                                End If
                            End If
                        End If
					
                        If Not Request.Form("MaterialCode_" & dtSMData.Rows(j)("SaleModeID")) Is Nothing Then
                            MaterialCodeVal = Request.Form("MaterialCode_" & dtSMData.Rows(j)("SaleModeID"))
                        End If
					
                        If Request.QueryString("a") <> "yes" Then
                            AttachEditText = "&b=null"
                            PComponentIDVal = "0"
                        Else

                            AttachEditText = "&a=yes" + "&SaleMode=" + Request.QueryString("SaleMode").ToString + "&MaterialAmount=" + Request.QueryString("MaterialAmount").ToString + "&MaterialCode=" + Request.QueryString("MaterialCode") + "&MaterialName=" + Request.QueryString("MaterialName") + "&UnitName=" + Request.QueryString("UnitSmallName") + "&PComponentID=" + Request.QueryString("PComponentID")
                            If Request.QueryString("PComponentID") IsNot Nothing Then PComponentIDVal = Request.QueryString("PComponentID")
                        End If
					
                        SelectMaterial = "<a href=""JavaScript: newWindow = window.open( 'material_category.aspx?EditID=3&From=component&SaleMode=" & _
                                            dtSMData.Rows(j)("SaleModeID").ToString & "&ProductGroupID=" + Request.QueryString("ProductGroupID") & _
                                            "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") & _
                                            "&ProductID=" + Request.QueryString("ProductID") + "&PGroupID=" + Request.QueryString("PGroupID") & _
                                            "&MaterialAmount_" & dtSMData.Rows(j)("SaleModeID").ToString & "=" & MaterialAmountVal & _
                                            "&ShowOnOrder_" & dtSMData.Rows(j)("SaleModeID").ToString & "=" & ShowOnOrderVal & _
                                            "&PComponentID_" & dtSMData.Rows(j)("SaleModeID").ToString & "=" & PComponentIDVal & AttachEditText & _
                                            "', '', 'width=600,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & _
                                            defaultTextTable.Rows(9)("TextParamValue") + "</a>"
					
                        strBuild.Append("<tr><td colspan=""7"" align=""left"" class=""boldtext"" bgColor=""" & GlobalParam.GrayBGColor & """>" & dtSMData.Rows(j)("SaleModeName") & "</td></tr>")
					
                        strBuild.Append("<tr>")
                        strBuild.Append("<td align=""center"" class=""tdHeader"" bgColor=""" & GlobalParam.AdminBGColor & """>" & "#" & "</td>")
                        If ComponentLevel = 1 Then
                            strBuild.Append("<td align=""center"" class=""tdHeader"" bgColor=""" & GlobalParam.AdminBGColor & """>" & "Material Code" & "</td>")
                            strBuild.Append("<td align=""center"" class=""tdHeader"" bgColor=""" & GlobalParam.AdminBGColor & """>" & "Material Name" & "</td>")
                        Else
                            strBuild.Append("<td align=""center"" class=""tdHeader"" bgColor=""" & GlobalParam.AdminBGColor & """>" & "Product Code" & "</td>")
                            strBuild.Append("<td align=""center"" class=""tdHeader"" bgColor=""" & GlobalParam.AdminBGColor & """>" & "Product Name" & "</td>")
                        End If
                        strBuild.Append("<td align=""center"" class=""tdHeader"" bgColor=""" & GlobalParam.AdminBGColor & """>" & "Amount" & "</td>")
                        strBuild.Append("<td align=""center"" class=""tdHeader"" bgColor=""" & GlobalParam.AdminBGColor & """>" & "Unit" & "</td>")
                        strBuild.Append("<td align=""center"" class=""tdHeader"" bgColor=""" & GlobalParam.AdminBGColor & """>" & "Copy All" & "</td>")
                        strBuild.Append("<td align=""center"" class=""tdHeader"" bgColor=""" & GlobalParam.AdminBGColor & """>" & "Action" & "</td>")
                        strBuild.Append("</tr>")
					
                        strBuild.Append("<form action=""product_component.aspx?ProductGroupID=" + Request.QueryString("ProductGroupID").ToString + "&ProductLevelID=" + Request.QueryString("ProductLevelID").ToString + "&ProductDeptID=" + Request.QueryString("ProductDeptID").ToString + "&ProductID=" + Request.QueryString("ProductID").ToString + "&PGroupID=" + Request.QueryString("PGroupID").ToString & AttachEditText & """ method=""post"">")
                        strBuild.Append("<input type=""hidden"" name=""MaterialID_" & dtSMData.Rows(j)("SaleModeID").ToString & """ value=""" & MaterialIDVal & """>")
                        strBuild.Append("<input type=""hidden"" name=""SaleMode" & """ value=""" & dtSMData.Rows(j)("SaleModeID").ToString & """>")
                        strBuild.Append("<input type=""hidden"" name=""PComponentID" & """ value=""" & PComponentIDVal & """>")
                        strBuild.Append("<input type=""hidden"" name=""UnitSmallID_" & dtSMData.Rows(j)("SaleModeID").ToString & """ value=""" & UnitSmallIDVal & """>")
					
                        Editing = False
                        SubmitText = "Add"
                        CancelText = ""
                        If Not Request.QueryString("a") Is Nothing Then
                            If Request.QueryString("a") = "yes" And Request.QueryString("SaleMode") = dtSMData.Rows(j)("SaleModeID") Then
                                MaterialAmountVal = Request.QueryString("MaterialAmount")
                                MaterialCodeVal = Request.QueryString("MaterialCode")
                                MaterialNameVal = Request.QueryString("MaterialName")
                                UnitNameVal = Request.QueryString("UnitName")
                                Editing = True
                                strBuild.Append("<input type=""hidden"" name=""MaterialCode_" & dtSMData.Rows(j)("SaleModeID").ToString & """ value=""" & MaterialCodeVal & """>")
                                SubmitText = "Update"
                                CancelText = "<td>&nbsp;</td><td><a href=""product_component.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&PGroupID=" + PGroupID.ToString + """>Cancel</a></td>"
							
                            End If
                        End If
					
                        If Not Request.Form("MaterialAmount_" & dtSMData.Rows(j)("SaleModeID").ToString) Is Nothing Then
                            MaterialAmountVal = Request.Form("MaterialAmount_" & dtSMData.Rows(j)("SaleModeID").ToString)
                        End If
						
                        strBuild.Append("<tr>")
                        strBuild.Append("<td align=""center"" class=""text"">" & "-" & "</td>")
                        If Editing = True Then
                            strBuild.Append("<td align=""left"" class=""text"">" & MaterialCodeVal & "</td>")
                        Else
                            strBuild.Append("<td><table cellpadding=""0"" cellspacing=""0"">" & ErrorMsg(j) & "<tr><td>" & _
                                         "<input type=""text"" style=""width:120px"" name=""MaterialCode_" & dtSMData.Rows(j)("SaleModeID").ToString & _
                                         """ value=""" & MaterialCodeVal & """></td><td width=""5""></td><td>" & SelectMaterial & "</td></tr></table></td>")
                        End If
                        strBuild.Append("<td align=""left"" class=""text"">" & MaterialNameVal & "</td>")
                        strBuild.Append("<td><table cellpadding=""0"" cellspacing=""0"" width=""100%"">" & ErrorMsgQty(j) & "<tr><td align=""right"" class=""text"" width=""100%"">" & _
                                        "<input type=""text"" style=""width:120px;"" name=""MaterialAmount_" & dtSMData.Rows(j)("SaleModeID").ToString & _
                                        """ value=""" & MaterialAmountVal & """></td></tr></table></td>")
                        strBuild.Append("<td align=""left"" class=""text"">" & UnitNameVal & "</td>")
					
                        'strBuild.append "<td align=""center""><input type=""checkbox"" name=""ShowOnSearch_""" & getSaleMode.Rows(j)("SaleModeID").ToString & "></td>"
                        If Editing = False Then
                            strBuild.Append("<td align=""center"" class=""text""><input type=""checkbox"" name=""CopyAll"" value=""1""></td>")
                        Else
                            strBuild.Append("<td align=""center"" class=""text""></td>")
                        End If
                        strBuild.Append("<td align=""center""><table cellpadding=""0"" cellspacing=""0""><tr><td>" & "<input type=""submit"" name=""SubmitSaleMode_" & dtSMData.Rows(j)("SaleModeID").ToString & """ value=""" & SubmitText & """>" & "</td>" & CancelText & "</tr></table></td>")
                        strBuild.Append("</tr></form>")
                        counter = 1
					
                        If (dtTable.Rows(0)("ProductSet") = 7) And (SetGroupNo = -1) Then
                            componentTable = getInfo.ProductComponentForAutoMaterialInFlexibleProduct(dtSMData.Rows(j)("SaleModeID"), Request.QueryString("ProductLevelID"), Request.QueryString("ProductID"), PGroupID, objCnn)
                        Else
                            componentTable = getInfo.ProductComponent(dtSMData.Rows(j)("SaleModeID"), Request.QueryString("ProductLevelID"), Request.QueryString("ProductID"), Session("PMonthYearDate_Month"), Session("PMonthYearDate_Year"), objCnn)
                        End If
					
                        If componentTable.Rows.Count = 0 And dtSMData.Rows(j)("SaleModeID") <> 1 Then
                            strBuild.Append("<tr><td colspan=""7"" align=""center"" class=""" + "boldText" + """>" & "SAME AS DINE IN" & "</td>")
                        Else
                            For i = 0 To componentTable.Rows.Count - 1
                                If Not IsDBNull(componentTable.Rows(i)("PComponentID")) Then
                                    SelectedText = "text"
                                    If Not Request.QueryString("a") Is Nothing Then
                                        If Request.QueryString("a") = "yes" And Request.QueryString("PComponentID") = componentTable.Rows(i)("PComponentID") Then
                                            SelectedText = "disabledText"
                                        End If
                                    End If
                                    strBuild.Append("<tr><td align=""center"" class=""" + SelectedText + """>" & counter.ToString & "</td>")
                                    strBuild.Append("<td align=""left"" class=""" + SelectedText + """>" & componentTable.Rows(i)("MaterialCode") & "</td>")
                                    strBuild.Append("<td align=""left"" class=""" + SelectedText + """>" & componentTable.Rows(i)("MaterialName") & "</td>")
                                    strBuild.Append("<td align=""right"" class=""" + SelectedText + """>" & Format(componentTable.Rows(i)("MaterialAmount"), "##,##0.0000") & "</td>")
                                    strBuild.Append("<td align=""left"" class=""" + SelectedText + """>" & componentTable.Rows(i)("UnitSmallName") & "</td>")
                                    strBuild.Append("<td align=""left"" class=""text"">" & "&nbsp;" & "</td>")

                                    'If componentTable.Rows(i)("ShowOnOrder") = True Or componentTable.Rows(i)("ShowOnOrder") = 1 Then
                                    'strBuild.append "<td align=""center"" class=""" + SelectedText + """>" + "<img src=""../images/checkbl.gif"" border=""0""></td>"
                                    'Else
                                    'strBuild.append "<td align=""center"" class=""" + SelectedText + """>" + "<img src=""../images/crossbl.gif"" border=""0""></td>"
                                    'End If
                                    If SelectedText = "text" Then
                                        strBuild.Append("<td align=""center"" class=""text""><a href=""product_component.aspx?EditID=3&a=yes&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&PComponentID=" + componentTable.Rows(i)("PComponentID") + "&PGroupID=" + PGroupID.ToString + "&SaleMode=" + componentTable.Rows(i)("SaleMode").ToString + "&MaterialAmount=" + componentTable.Rows(i)("MaterialAmount").ToString + "&MaterialCode=" + componentTable.Rows(i)("MaterialCode") + "&MaterialName=" + componentTable.Rows(i)("MaterialName") + "&UnitName=" + componentTable.Rows(i)("UnitSmallName") + """>Edit</a>")

                                        strBuild.Append("&nbsp;&nbsp;<a href=""inv_category_action.aspx?action=delete_component&EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&PComponentID=" + componentTable.Rows(i)("PComponentID") + "&PGroupID=" + PGroupID.ToString + """" + "onClick=""javascript: return confirm('" & textTable.Rows(13)("TextParamValue") & " " & Replace(componentTable.Rows(i)("MaterialName"), "'", "\'") & " " & textTable.Rows(15)("TextParamValue") & "')"">" + "Del</a></td>")
                                    Else
                                        strBuild.Append("<td align=""center"" class=""" + SelectedText + """>Updating</td>")
                                    End If
                                    strBuild.Append("</tr>")
                                    counter = counter + 1
                                End If
                            Next
                        End If
                    Next
			
                    ResultText.InnerHtml = strBuild.ToString
				
                    Dim costTextValue As String = "0"
                    If costValue > 0 Then
                        costTextValue = Format(costValue, "##,##0.0000")
                    End If
                    If Session("Material_Cost") = True Then
                        CostText.InnerHtml = textTable.Rows(16)("TextParamValue") + " " + dtTable.Rows(0)("ProductName") + " " + textTable.Rows(17)("TextParamValue") + " " + costTextValue + " " + defaultTextTable.Rows(10)("TextParamValue")
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

Sub Page_UnLoad()
	objCnn.Close()
End Sub
</script>

</body>
</html>
