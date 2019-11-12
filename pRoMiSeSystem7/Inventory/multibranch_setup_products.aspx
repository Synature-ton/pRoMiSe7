<%@ Page Language="VB" ContentType="text/html" EnableViewState="False" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
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
			
            Text_SectionParam.InnerHtml = "Manage Product Parameters By Shops"
			
            Dim ProductLevelIDList, ProductGroupIDList, ProductDeptIDList, ProductIDList As String
			
            ProductLevelIDList = Request.QueryString("ProductLevelID").ToString
            ProductGroupIDList = Request.QueryString("ProductGroupID").ToString
            ProductDeptIDList = Request.QueryString("ProductDeptID").ToString
            If Request.QueryString("ProductID") IsNot Nothing Then
                ProductIDList = Request.QueryString("ProductID").ToString
            Else
                ProductIDList = ""
            End If
			
            Dim dtProductData As DataTable
            Dim dtProductShopData As DataTable
            Dim dtShopData As DataTable
            Dim ShopIDList As String
            Dim PIDList As String
            Dim strTemp, strSaleMode As String
            Dim i, j, k As Integer
           
            dtShopData = New DataTable
            dtProductShopData = New DataTable
            dtProductData = New DataTable
            Dim Result As String = getInfo.ProductByBranch(dtShopData, dtProductData, dtProductShopData, ShopIDList, PIDList, ProductLevelIDList, _
                                                        ProductGroupIDList, ProductDeptIDList, ProductIDList, objCnn)		
 	
            Dim HeaderString As StringBuilder = New StringBuilder

            TableHeaderText.InnerHtml = ""
			
            Dim PrinterIDValue, Checked, ParamName, ValText As String
            Dim PrintType, VATType, SCValue, colSpan As Integer
            Dim productSaleModeValue, shopSaleModeValue, Activate As Integer
            Dim outputString As StringBuilder = New StringBuilder
            Dim rResult() As DataRow
            Dim expression As String
            Dim bColor As String
            Dim tdColor As String
            Dim CompareString As String
            Dim PrinterString As String = ""
            Dim AllPrinters As DataTable
            Dim ChkPrinterID As String
            AllPrinters = getConfig.GetPrinters(-1, objCnn)
            Dim dtSMData As DataTable = objDB.List("select * from SaleMode where Deleted=0 order by SaleModeID", objCnn)
			
            colSpan = 7 + dtSMData.Rows.Count
            For i = 0 To dtProductData.Rows.Count - 1
                outputString = outputString.Append("<tr>")
                outputString = outputString.Append("<td colspan=""" & colSpan & """ align=""center"" class=""text"">" & dtProductData.Rows(i)("ProductName") & "</td>")
                outputString = outputString.Append("</tr>")
				
                outputString = outputString.Append("<tr>")
                outputString = outputString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "" + "</td>")
                outputString = outputString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Shop Name" + "</td>")
                outputString = outputString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Printer(s)" + "</td>")
                outputString = outputString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Print Type" + "</td>")
                outputString = outputString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "VAT Type" + "</td>")
                outputString = outputString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Service Charge" + "</td>")
                For j = 0 To dtSMData.Rows.Count - 1
                    strTemp = "<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" & dtSMData.Rows(j)("SaleModeName") & "</td>"
                    outputString = outputString.Append(strTemp)
                Next
				
                outputString = outputString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Activate" + "</td>")
                outputString = outputString.Append("</tr>")
			
                For j = 0 To dtShopData.Rows.Count - 1
                    If j Mod 2 = 0 Then
                        bColor = "white"
                    Else
                        bColor = GlobalParam.RowBGColor
                    End If
                    expression = "ProductLevelID=" & dtShopData.Rows(j)("ProductLevelID").ToString & " AND ProductID=" & dtProductData.Rows(i)("ProductID").ToString
                    rResult = dtProductShopData.Select(expression)
                    If rResult.GetUpperBound(0) >= 0 Then
                        ChkPrinterID = rResult(0)("PrinterID").ToString
                        PrinterIDValue = rResult(0)("PrinterID").ToString
                        PrintType = rResult(0)("PrintGroup").ToString
                        VATType = rResult(0)("VATType").ToString
                        SCValue = rResult(0)("HasServiceCharge").ToString
                        Activate = rResult(0)("ProductActivate").ToString
                    Else
                        ChkPrinterID = dtProductData.Rows(i)("PrinterID").ToString
                        PrinterIDValue = dtProductData.Rows(i)("PrinterID").ToString
                        PrintType = dtProductData.Rows(i)("PrintGroup").ToString
                        VATType = dtProductData.Rows(i)("VATType").ToString
                        SCValue = dtProductData.Rows(i)("HasServiceCharge").ToString
                        Activate = dtProductData.Rows(i)("ProductActivate").ToString
                    End If
					
                    ParamName = dtShopData.Rows(j)("ProductLevelID").ToString + ":" & dtProductData.Rows(i)("ProductID").ToString
					
                    outputString = outputString.Append("<tr bgColor=""" + bColor + """>")
                    outputString = outputString.Append("<td align=""center"" class=""smalltext"">" + (j + 1).ToString + "</td>")
                    outputString = outputString.Append("<td align=""left"" class=""smalltext"">" & dtShopData.Rows(j)("ProductLevelName") & "</td>")
					
                    PrinterString = ""
                    PrinterIDValue = "," + PrinterIDValue + ","
                    If ProductLevelIDList = dtShopData.Rows(j)("ProductlevelID").ToString Then
                        For k = 0 To AllPrinters.Rows.Count - 1
                            If AllPrinters.Rows(k)("PrinterID") >= 0 Then
                                CompareString = "," + AllPrinters.Rows(k)("PrinterID").ToString + ","
                                If PrinterIDValue.IndexOf(CompareString) <> -1 Then
                                    If PrinterString = "" Then
                                        PrinterString += AllPrinters.Rows(k)("PrinterName")
                                    Else
                                        PrinterString += "," + AllPrinters.Rows(k)("PrinterName")
                                    End If
                                End If
                            End If
                        Next
                        outputString = outputString.Append("<td align=""center"" class=""smalltext"">" + PrinterString + "</td>")
                    Else
                        If dtProductData.Rows(i)("PrinterID").ToString <> ChkPrinterID Then
                            tdColor = " bgColor=""#ff9797"""
                        Else
                            tdColor = ""
                        End If
                        outputString = outputString.Append("<td align=""center"" class=""smalltext""" + tdColor + ">")
                        For k = 0 To AllPrinters.Rows.Count - 1
                            If AllPrinters.Rows(k)("PrinterID") >= 0 Then
                                CompareString = "," + AllPrinters.Rows(k)("PrinterID").ToString + ","
                                If PrinterIDValue.IndexOf(CompareString) <> -1 Then
                                    Checked = "Checked"
                                Else
                                    Checked = ""
                                End If
                                outputString = outputString.Append("<input type=""checkbox"" name=""RT:" + ParamName + """ value=""" + AllPrinters.Rows(k)("PrinterID").ToString + """" + Checked + ">" + AllPrinters.Rows(k)("PrinterName"))
                            End If
                        Next
                        'outputString = outputString.Append(":" + ProductData.Rows(i)("PrinterID").ToString + ":" + ChkPrinterID)
                        outputString = outputString.Append("</td>")
                    End If
					
                    If PrintType = 0 Then
                        ValText = textTable.Rows(73)("TextParamValue")
                    ElseIf PrintType = 1 Then
                        ValText = textTable.Rows(72)("TextParamValue")
                    End If
                    If ProductLevelIDList = dtShopData.Rows(j)("ProductlevelID").ToString Then
                        outputString = outputString.Append("<td align=""center"" class=""smalltext"">" + ValText + "</td>")
                    Else
                        If dtProductData.Rows(i)("PrintGroup").ToString <> PrintType Then
                            tdColor = " bgColor=""#ff9797"""
                        Else
                            tdColor = ""
                        End If
                        If PrintType = 0 Then
                            Checked = "Checked"
                        Else
                            Checked = ""
                        End If
                        outputString = outputString.Append("<td align=""center"" class=""smalltext""" + tdColor + "><input type=""radio"" name=""PT:" + ParamName + """ value=""0""" + Checked + ">" + textTable.Rows(73)("TextParamValue"))
                        If PrintType = 1 Then
                            Checked = "Checked"
                        Else
                            Checked = ""
                        End If
                        outputString = outputString.Append("<input type=""radio"" name=""PT:" + ParamName + """ value=""1""" + Checked + ">" + textTable.Rows(72)("TextParamValue") + "</td>")
                    End If
					
                    If VATType = 0 Then
                        ValText = "No"
                    ElseIf VATType = 1 Then
                        ValText = "Include"
                    Else
                        ValText = "Exclude"
                    End If
                    If ProductLevelIDList = dtShopData.Rows(j)("ProductlevelID").ToString Then
                        outputString = outputString.Append("<td align=""center"" class=""smalltext"">" + ValText + "</td>")
                    Else
                        If dtProductData.Rows(i)("VATType").ToString <> VATType Then
                            tdColor = " bgColor=""#ff9797"""
                        Else
                            tdColor = ""
                        End If
                        If VATType = 0 Then
                            Checked = "Checked"
                        Else
                            Checked = ""
                        End If
                        outputString = outputString.Append("<td align=""center"" class=""smalltext""" + tdColor + "><input type=""radio"" name=""VT:" + ParamName + """ value=""0""" + Checked + ">No")
                        If VATType = 1 Then
                            Checked = "Checked"
                        Else
                            Checked = ""
                        End If
                        outputString = outputString.Append("<input type=""radio"" name=""VT:" + ParamName + """ value=""1""" + Checked + ">Incl")
                        If VATType = 2 Then
                            Checked = "Checked"
                        Else
                            Checked = ""
                        End If
                        outputString = outputString.Append("<input type=""radio"" name=""VT:" + ParamName + """ value=""2""" + Checked + ">Excl</td>")
                    End If
					
                    If SCValue = 1 Then
                        Checked = "checked"
                        ValText = "Y"
                    Else
                        Checked = " "
                        ValText = "N"
                    End If
					
                    If ProductLevelIDList = dtShopData.Rows(j)("ProductlevelID").ToString Then
                        outputString = outputString.Append("<td align=""center"" class=""smalltext"">" + ValText + "</td>")
                    Else
                        If dtProductData.Rows(i)("HasServiceCharge").ToString <> SCValue.ToString Then
                            tdColor = " bgColor=""#ff9797"""
                        Else
                            tdColor = ""
                        End If
                        outputString = outputString.Append("<td align=""center""" + tdColor + "><input type=""checkbox"" name=""SC:" + ParamName + """ value=""1""" + Checked + "></td>")
                    End If
                                        
                    'Sale Mode
                    For k = 0 To dtSMData.Rows.Count - 1
                        strSaleMode = "SaleMode" & dtSMData.Rows(k)("SaleModeID")
                        If rResult.Length > 0 Then
                            'From Over Write
                            If dtProductShopData.Columns.Contains(strSaleMode) = True Then
                                shopSaleModeValue = rResult(0)(strSaleMode)
                            Else
                                shopSaleModeValue = 0
                            End If
                        Else
                            'From ProductData
                            If dtProductData.Columns.Contains(strSaleMode) = True Then
                                shopSaleModeValue = dtProductData.Rows(i)(strSaleMode)
                            Else
                                shopSaleModeValue = 0
                            End If
                        End If
                        If shopSaleModeValue = 1 Then
                            Checked = "checked"
                            ValText = "Y"
                        Else
                            Checked = " "
                            ValText = "N"
                        End If
                        ParamName = dtShopData.Rows(j)("ProductLevelID").ToString + ":" & dtProductData.Rows(i)("ProductID").ToString
                        If ProductLevelIDList = dtShopData.Rows(j)("ProductlevelID").ToString Then
                            outputString = outputString.Append("<td align=""center"" class=""smalltext"">" & ValText & "</td>")
                        Else
                            If dtProductData.Columns.Contains(strSaleMode) = True Then
                                productSaleModeValue = dtProductData.Rows(i)(strSaleMode)
                            Else
                                productSaleModeValue = 0
                            End If
                            If productSaleModeValue <> shopSaleModeValue Then
                                tdColor = " bgColor=""#ff9797"""
                            Else
                                tdColor = ""
                            End If
                            strTemp = "<td align=""center""" + tdColor + "><input type=""checkbox"" name=""" & strSaleMode & ":" & ParamName & """ value=""1""" + Checked + "></td>"
                            outputString = outputString.Append(strTemp)
                        End If
                    Next k
                    
                    If Activate = 1 Then
                        Checked = "checked"
                        ValText = "Y"
                    Else
                        Checked = " "
                        ValText = "N"
                    End If
                    ParamName = dtShopData.Rows(j)("ProductLevelID").ToString + ":" & dtProductData.Rows(i)("ProductID").ToString
                    If ProductLevelIDList = dtShopData.Rows(j)("ProductlevelID").ToString Then
                        outputString = outputString.Append("<td align=""center"" class=""smalltext"">" + ValText + "</td>")
                    Else
                        If dtProductData.Rows(i)("ProductActivate").ToString <> Activate.ToString Then
                            tdColor = " bgColor=""#ff9797"""
                        Else
                            tdColor = ""
                        End If
                        strTemp = "<td align=""center""" + tdColor + "><input type=""checkbox"" name=""AV:" + ParamName + """ value=""1""" + Checked + "></td>"
                        outputString = outputString.Append(strTemp)
                    End If
					
                    outputString = outputString.Append("</tr>")
					
                Next
                outputString = outputString.Append("<tr>")
                outputString = outputString.Append("<td colspan=""11"" height=""20"" align=""left"" class=""smalltext"">" + "&nbsp;" + "</td>")
                outputString = outputString.Append("</tr>")
            Next
			
            HiddenForm.InnerHtml = "<input type=""hidden"" name=""ShopIDList"" value=""" + ShopIDList + """><input type=""hidden"" name=""PIDList"" value=""" + PIDList + """><input type=""hidden"" name=""MasterShop"" value=""" + ProductLevelIDList + """>"
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
        getInfo.ProductByBranchUpdate(Request, objCnn)
        Dim ProductID As String = ""
        If Request.QueryString("ProductID") IsNot Nothing Then
            ProductID = Request.QueryString("ProductID").ToString
        End If
        Response.Redirect("multibranch_setup_products.aspx?Update=done&ProductGroupID=" + Request.QueryString("ProductGroupID").ToString + "&ProductDeptID=" + Request.QueryString("ProductDeptID").ToString + "&ProductID=" + ProductID + "&ProductLevelID=" + Request.QueryString("ProductLevelID").ToString)
    End Sub
	
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
