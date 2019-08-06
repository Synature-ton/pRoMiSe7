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
<title>Product Standard Cost</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body style="background-color:white">

<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<form id="mainForm" runat="server">
<input type="hidden" id="MaterialID" runat="server">
<table cellpadding="2" cellspacing="2" width="100%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
<td align="right"><div class="text" id="GoBackText" runat="server"></div></td>
</tr>

</table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTD1" align="center" class="smallTdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="smallTdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD10" align="center" class="smallTdHeader" runat="server"><div id="Text10" runat="server"></div></td>
		<td id="headerTD9" align="center" class="smallTdHeader" runat="server"><div id="Text9" runat="server"></div></td>
		<td id="headerTD3" align="center" class="smallTdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD4" align="center" class="smallTdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="smallTdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD7" align="center" class="smallTdHeader" runat="server"><div id="Text7" runat="server"></div></td>
		<td id="headerTD6" align="center" class="smallTdHeader" runat="server"><div id="Text6" runat="server"></div></td>
		<td id="headerTD8" align="center" class="smallTdHeader" runat="server"><div id="Text8" runat="server"></div></td>
		<td id="headerTD11" align="center" class="smallTdHeader" runat="server"><div id="Text11" runat="server"></div></td>
		<td id="headerTD12" align="center" class="smallTdHeader" runat="server"><div id="Text12" runat="server"></div></td>
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
        If User.Identity.IsAuthenticated And Session("Inv_Product_Category") Then
	  
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
                headerTD12.BgColor = GlobalParam.AdminBGColor
			
                headerTD11.Visible = False
                headerTD12.Visible = False
			
                Dim i As Integer
                Dim outputString As String = ""
                Dim ReportDate As String
                Dim SelectedText As String = "smallText"
                Dim DocHeader As String
                Dim dclTemp As Decimal
                Dim TotalCost As Double = 0
                Dim TotalQty As Double = 0
                Dim StaffString As String
                Dim InvoiceRef As String = ""
			
                Dim UnitInfo As DataTable
                Dim UnitText As String
                Dim UnitRatioVal As Double = 1

                GoBackText.InnerHtml = "<a href=""javascript: window.print()"">Print this Page</a> | <a href=""javascript: window.close()"">Close Window</a>"
			
                Dim CostType As Integer = CostInfo.ChkCostingType(objCnn)
                Dim dtTable As New DataTable()
			
                If CostType = -2 Then
                    Text1.InnerHtml = "Material Code"
                    Text2.InnerHtml = "Material Name"
                    Text10.InnerHtml = "Date Range"
                    Text9.InnerHtml = "Cost"
                    Text3.InnerHtml = "Unit Name"
                    headerTD4.Visible = False
                    headerTD5.Visible = False
                    headerTD6.Visible = False
                    headerTD7.Visible = False
                    headerTD8.Visible = False
				
                    Dim DateTimeString As String = "{ d '" + Request.QueryString("SelYear").ToString + "-" + Request.QueryString("SelMonth").ToString + "-1' }"
				
                    Dim ChkGroup As DataTable = objDB.List("select * from MaterialCostGroup where StartDate <= " + DateTimeString + " AND EndDate > " + DateTimeString + " order by StartDate", objCnn)
				
                    Dim MaterialCostGroup As Integer = 0
                    If ChkGroup.Rows.Count > 0 Then
                        MaterialCostGroup = ChkGroup.Rows(0)("MaterialCostGroupID")
                    End If
                    Dim CostData As DataTable = objDB.List("select * from MaterialCostTable a left outer join UnitLarge b ON a.SelectUnitLargeID=b.UnitLargeID left outer join Materials m ON a.MaterialID=m.MaterialID where a.MaterialID=" + MaterialID.Value.ToString + " AND MaterialCostGroupID=" + MaterialCostGroup.ToString, objCnn)
				
                    If CostData.Rows.Count > 0 Then
                        outputString += "<tr><td align=""left"" class=""" + SelectedText + """>" & CostData.Rows(0)("MaterialCode") & "</td>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & CostData.Rows(0)("MaterialName") & "</td>"
                        Dim DateRange As DataTable = CostInfo.MaterialCostGroup(CostData.Rows(0)("MaterialCostGroupID"), objCnn)
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & DateRange.Rows(0)("DateRangeString") & "</td>"
                        outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(CostData.Rows(0)("MaterialPrice"), "##,##0.0000") & "</td>"
                        outputString += "<td align=""left"" class=""" + SelectedText + """>" & CostData.Rows(0)("UnitLargeName") & "</td>"
                        outputString += "</tr>"
                    End If
                    ResultText.InnerHtml = outputString
                Else

                    Text1.InnerHtml = ""
                    Text2.InnerHtml = "Document No.<br>DocumentName"
                    Text10.InnerHtml = "Inv Ref"
                    Text9.InnerHtml = "Inputed By<br>Approved By"
                    Text3.InnerHtml = "Document Date"
                    Text4.InnerHtml = "Vendor Name"
                    Text5.InnerHtml = "Qty"
                    Text6.InnerHtml = "Qty<br>(Unit Small)"
                    Text7.InnerHtml = "Net Price"
                    Text8.InnerHtml = "Price/Small Unit"
				
                    dtTable = getInfo.MaterialAvgStdCost(Request.QueryString("ProductLevelID"), MaterialID.Value, Request.QueryString("SelMonth"), Request.QueryString("SelYear"), Session("LangID"), objCnn)
				
                    If dtTable.Rows.Count > 0 Then
                        Dim SDate As New Date(Request.QueryString("SelYear"), Request.QueryString("SelMonth"), 1)
                        ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy", Session("LangID"), objCnn)
                        HeaderText.InnerHtml = "Average Standard Cost of " + dtTable.Rows(0)("MaterialName") + " for " + ReportDate
					
                        UnitRatioVal = 1
                        UnitText = dtTable.Rows(0)("UnitSmallName")
                        UnitInfo = getInfo.GetUnitSetting(dtTable.Rows(0)("MaterialID"), dtTable.Rows(0)("UnitSmallID"), objCnn)
                        If UnitInfo.Rows.Count <> 0 Then
                            UnitRatioVal = UnitInfo.Rows(0)("UnitSmallRatio")
                            UnitText = UnitInfo.Rows(0)("UnitLargeName")
                            Text11.InnerHtml = "Qty<br>(" + UnitText + ")"
                            Text12.InnerHtml = "Price/" + UnitText
                        End If
					
                        If UnitRatioVal <> 1 Then
                            headerTD11.Visible = True
                            headerTD12.Visible = True
                        End If
				
                        For i = 0 To dtTable.Rows.Count - 1
                            InvoiceRef = "-"
                            If Not IsDBNull(dtTable.Rows(i)("InvoiceRef")) Then
                                If Trim(dtTable.Rows(i)("InvoiceRef")) <> "" Then
                                    InvoiceRef = dtTable.Rows(i)("InvoiceRef")
                                End If
                            End If
                            StaffString = ""
                            DocHeader = FormatHeader.DocumentNumber(dtTable.Rows(i)("ShopID"), dtTable.Rows(i)("DocumentTypeID"), dtTable.Rows(i)("DocumentID"), Session("LangID"), GlobalParam.YearType, objCnn)
                            outputString += "<tr><td align=""center"" class=""" + SelectedText + """>" & (i + 1).ToString & "</td>"
                            outputString += "<td align=""left"" class=""" + SelectedText + """><a class=""" + SelectedText + """ href=""JavaScript: newWindow = window.open( 'document_detail.aspx?MaterialID=" + Request.QueryString("MaterialID").ToString + "&SelMonth=" & Request.QueryString("SelMonth").ToString & "&SelYear=" & Request.QueryString("SelYear").ToString & "&DocumentID=" & dtTable.Rows(i)("DocumentID").ToString & "&ShopID=" & dtTable.Rows(i)("ShopID").ToString & "&ProductLevelID=" & Request.QueryString("ProductLevelID").ToString + "', '', 'width=800,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & DocHeader & "</a>" + "<br>" + dtTable.Rows(i)("DocumentTypeName") + "</td>"
                            outputString += "<td align=""left"" class=""" + SelectedText + """>" & InvoiceRef & "</td>"
                            If Not IsDBNull(dtTable.Rows(i)("InputStaff")) Then
                                StaffString += dtTable.Rows(i)("InputStaff")
                            Else
                                StaffString += "-"
                            End If
                            If Not IsDBNull(dtTable.Rows(i)("ApproveStaff")) Then
                                StaffString += "<br>" + dtTable.Rows(i)("ApproveStaff")
                            Else
                                StaffString += "<br>-"
                            End If
						
                            outputString += "<td align=""left"" class=""" + SelectedText + """>" & StaffString & "</td>"
                            outputString += "<td align=""left"" class=""" + SelectedText + """>" & DateTimeUtil.FormatDateTime(dtTable.Rows(i)("DocumentDate"), "DateOnly") & "</td>"
                            If Not IsDBNull(dtTable.Rows(i)("VendorName")) Then
                                outputString += "<td align=""left"" class=""" + SelectedText + """>" & dtTable.Rows(i)("VendorName") & "</td>"
                            Else
                                outputString += "<td align=""left"" class=""" + SelectedText + """>" & "-" & "</td>"
                            End If
                            outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("ProductAmount"), "##,##0.00") & " " & dtTable.Rows(i)("UnitName") & "</td>"
                            outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("MovementInStock") * dtTable.Rows(i)("ProductNetPrice"), "##,##0.00") & "</td>"
                            outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("MovementInStock") * dtTable.Rows(i)("UnitSmallAmount"), "##,##0.00") & " " & dtTable.Rows(i)("UnitSmallName") & "</td>"
                            If dtTable.Rows(i)("UnitSmallAmount") > 0 Then
                                If (dtTable.Rows(i)("ProductNetPrice") * 1000) / dtTable.Rows(i)("UnitSmallAmount") < 1 And (dtTable.Rows(i)("ProductNetPrice") * 1000) / dtTable.Rows(i)("UnitSmallAmount") <> 0 Then
                                    outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("ProductNetPrice") / dtTable.Rows(i)("UnitSmallAmount"), "E4") & "</td>"
                                Else
                                    If dtTable.Rows(i)("DocumentTypeID") = 10 Then
                                        Dim SelMonthValue, SelYearValue As Integer
                                        If Request.QueryString("SelMonth") = 1 Then
                                            SelMonthValue = 12
                                            SelYearValue = Request.QueryString("SelYear") - 1
                                        Else
                                            SelMonthValue = Request.QueryString("SelMonth") - 1
                                            SelYearValue = Request.QueryString("SelYear")
                                        End If
                                        outputString += "<td align=""right"" class=""" + SelectedText + """><a href=""JavaScript: newWindow = window.open( 'product_stdcost.aspx?MaterialID=" + Request.QueryString("MaterialID").ToString + "&SelMonth=" & SelMonthValue.ToString & "&SelYear=" & SelYearValue.ToString & "&ProductLevelID=" & Request.QueryString("ProductLevelID").ToString + "', '', 'width=900,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & Format(dtTable.Rows(i)("ProductNetPrice") / dtTable.Rows(i)("UnitSmallAmount"), "##,##0.0000") & "</a></td>"
                                    Else
                                        outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("ProductNetPrice") / dtTable.Rows(i)("UnitSmallAmount"), "##,##0.0000") & "</td>"
                                    End If
                                End If
                            Else
                                outputString += "<td align=""right"" class=""" + SelectedText + """>-</td>"
                            End If
						
                            If headerTD11.Visible = True Then
                                outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dtTable.Rows(i)("MovementInStock") * dtTable.Rows(i)("UnitSmallAmount") / UnitRatioVal, "##,##0.00") & " " & UnitText & "</td>"
                            End If
						
                            If headerTD12.Visible = True Then
                                If dtTable.Rows(i)("UnitSmallAmount") > 0 Then
                                    dclTemp = (dtTable.Rows(i)("ProductNetPrice") * UnitRatioVal) / dtTable.Rows(i)("UnitSmallAmount")
                                    If dclTemp >= 0 And dclTemp < 1 Then
                                        outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dclTemp, "E4") & "</td>"
                                    Else
                                        outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(dclTemp , "##,##0.0000") & "</td>"
                                    End If
                                Else
                                    outputString += "<td align=""right"" class=""" + SelectedText + """>-</td>"
                                End If
                            End If
                            outputString += "</tr>"
                            TotalCost += dtTable.Rows(i)("ProductNetPrice") * dtTable.Rows(i)("MovementInStock")
                            TotalQty += dtTable.Rows(i)("UnitSmallAmount") * dtTable.Rows(i)("MovementInStock")
                        Next
                        outputString += "<tr bgColor=""" + GlobalParam.GrayBGColor + """><td colspan=""7"" align=""right"" class=""text"">Summary</td>"
                        outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(TotalCost, "##,##0.00") & "</td>"
                        outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(TotalQty, "##,##0.00") & " " & dtTable.Rows(0)("UnitSmallName") & "</td>"
					
                        If (TotalCost * 1000) / TotalQty < 1 And (TotalCost * 1000) / TotalQty <> 0 Then
                            outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(TotalCost / TotalQty, "E4") & "</td>"
                        Else
                            outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(TotalCost / TotalQty, "##,##0.0000") & "</td>"
                        End If
                        If headerTD11.Visible = True Then
                            outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format(TotalQty / UnitRatioVal, "##,##0.00") & " " & UnitText & "</td>"
                        End If
                        If headerTD12.Visible = True Then
                            If ((TotalCost * 1000) / TotalQty) * UnitRatioVal < 1 And ((TotalCost * 1000) / TotalQty) * UnitRatioVal <> 0 Then
                                outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format((TotalCost * UnitRatioVal) / TotalQty, "E4") & "</td>"
                            Else
                                outputString += "<td align=""right"" class=""" + SelectedText + """>" & Format((TotalCost * UnitRatioVal) / TotalQty, "##,##0.0000") & "</td>"
                            End If                       
                        End If
                        outputString += "</tr>"
                        ResultText.InnerHtml = outputString
                    Else
                        updateMessage.Text = "No Data"
                    End If
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
