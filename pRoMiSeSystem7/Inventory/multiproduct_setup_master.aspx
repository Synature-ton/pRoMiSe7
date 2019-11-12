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
	If User.Identity.IsAuthenticated  AND Session("Inv_Product_Category") Then
			
		'Try
			objCnn = getCnn.EstablishConnection()
			Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)
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
			textTable = getPageText.GetText(7,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			Text_SectionParam.InnerHtml = "Manage Product Parameters"
			
			Dim ProductLevelIDList,ProductGroupIDList,ProductDeptIDList,ProductIDList As String
			
			ProductLevelIDList = Request.QueryString("ProductLevelID").ToString
			ProductGroupIDList = Request.QueryString("ProductGroupID").ToString
			ProductDeptIDList = Request.QueryString("ProductDeptID").ToString
			If Request.QueryString("ProductID") IsNot Nothing Then
				ProductIDList = Request.QueryString("ProductID").ToString
			Else
				ProductIDList = ""
			End If
            Dim dtProductPriceData As DataTable
            Dim dtProductData As DataTable
            Dim dtProductDeptData As DataTable
            Dim PIDList As String
            Dim i, j, k, colSpan As Integer

            dtProductDeptData = New DataTable
            dtProductData = New DataTable
            dtProductPriceData = New DataTable
            PIDList = ""
            Dim Result As String = getInfo.MultiProductData(dtProductData, dtProductDeptData, dtProductPriceData, PIDList, ProductLevelIDList, ProductGroupIDList, ProductDeptIDList, ProductIDList, objCnn)
				
			Dim HeaderString As StringBuilder = New StringBuilder

			TableHeaderText.InnerHtml = ""
			
			Dim PrinterIDValue,Checked,ParamName,ValText As String
            Dim PrintType, VATType, SCValue, saleModeValue, Activate As Integer
            Dim outputString As StringBuilder = New StringBuilder
			Dim foundRows() As DataRow
			Dim foundRows2() As DataRow
			Dim expression As String
			Dim bColor As String
			Dim tdColor As String
			Dim CompareString As String
			Dim PrinterString As String = ""
			Dim AllPrinters As DataTable
            Dim strTemp, strSaleMode, ChkPrinterID As String
			Dim ProductPriceString As String
            Dim LineFeed As String
            
			AllPrinters = GetConfig.GetPrinters(-1,objCnn)
			
            Dim dtSMData As DataTable
            dtSMData = objDB.List("select * from SaleMode where Deleted=0 order by SaleModeID", objCnn)
						
			Dim PriceRegion As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramtypeID = 2 AND PropertyID =14 AND KeyID = 1", objCnn)
			Dim PriceRegFeature As Boolean = False
			If PriceRegion.Rows.Count > 0 Then
				If PriceRegion.Rows(0)("PropertyValue") = 1 OR PriceRegion.Rows(0)("PropertyValue") = 2 Then
					PriceRegFeature = True
				End If
			End If
			Dim showPrice As Boolean = True
			If PriceRegFeature = True Then
				showPrice = False
			End If

            colSpan = 9 + dtSMData.Rows.Count
            For i = 0 To dtProductDeptData.Rows.Count - 1
				
                outputString = outputString.Append("<tr>")
                outputString = outputString.Append("<td colspan=""" & colSpan & """ align=""center"" class=""text"">" & dtProductDeptData.Rows(i)("ProductDeptName") & " " + "Department" + "</td>")
                outputString = outputString.Append("</tr>")
				
                outputString = outputString.Append("<tr>")
                outputString = outputString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "" + "</td>")
                outputString = outputString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Product Code" + "</td>")
                outputString = outputString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Product Name" + "</td>")
                If showPrice = True Then
                    outputString = outputString.Append("<td align=""center"" class=""smallTdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + "Price" + "</td>")
                End If
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
				
                expression = "ProductDeptID=" & dtProductDeptData.Rows(i)("ProductDeptID").ToString
                foundRows = dtProductData.Select(expression)
					
                For j = 0 To foundRows.GetUpperBound(0)
                    If j Mod 2 = 0 Then
                        bColor = "white"
                    Else
                        bColor = GlobalParam.RowBGColor
                    End If
					
                    ChkPrinterID = foundRows(j)("PrinterID").ToString
                    PrinterIDValue = foundRows(j)("PrinterID").ToString
                    PrintType = foundRows(j)("PrintGroup").ToString
                    VATType = foundRows(j)("VATType").ToString
                    SCValue = foundRows(j)("HasServiceCharge").ToString
                    Activate = foundRows(j)("ProductActivate").ToString
						
                    expression = "ProductID=" + foundRows(j)("ProductID").ToString
                    foundRows2 = dtProductPriceData.Select(expression)
					
                    ParamName = "ProductID" + ":" + foundRows(j)("ProductID").ToString
					
                    If foundRows2.GetUpperBound(0) >= 0 Then
                        ProductPriceString = CDbl(foundRows2(0)("ProductPrice")).ToString("##0.00")
                        ParamName += ":" + foundRows2(0)("ProductPriceID").ToString
                    Else
                        ProductPriceString = "0"
                        ParamName += ":0"
                    End If
	
                    outputString = outputString.Append("<tr bgColor=""" + bColor + """>")
                    outputString = outputString.Append("<td align=""center"" class=""smalltext"">" + (j + 1).ToString + "</td>")
					
                    outputString = outputString.Append("<td align=""center"" class=""smalltext"">" + foundRows(j)("ProductCode").ToString + "</td>")
                    outputString = outputString.Append("<td align=""left"" class=""smalltext"">" + foundRows(j)("ProductName").ToString + "</td>")
					
                    tdColor = ""
                    If showPrice = True Then
                        outputString = outputString.Append("<td align=""center""" + tdColor + "><input type=""input"" style=""width:70px;text-align:right;"" name=""PP:" + ParamName + """ value=""" + ProductPriceString + """></td>")
                    End If
					
                    PrinterString = ""
                    PrinterIDValue = "," + PrinterIDValue + ","

                    ParamName = "ProductID" + ":" + foundRows(j)("ProductID").ToString
                    tdColor = ""
	
                    outputString = outputString.Append("<td align=""left"" class=""smalltext""" + tdColor + ">")
                    For k = 0 To AllPrinters.Rows.Count - 1
                        If AllPrinters.Rows(k)("PrinterID") >= 0 Then
                            CompareString = "," + AllPrinters.Rows(k)("PrinterID").ToString + ","
                            If PrinterIDValue.IndexOf(CompareString) <> -1 Then
                                Checked = "Checked"
                            Else
                                Checked = ""
                            End If
                            LineFeed = ""
                            If k > 0 Then
                                LineFeed = "<BR>"
                            End If
                            outputString = outputString.Append(LineFeed + "<input type=""checkbox"" name=""RT:" + ParamName + """ value=""" + AllPrinters.Rows(k)("PrinterID").ToString + """" + Checked + ">" + AllPrinters.Rows(k)("PrinterName"))
                        End If
                    Next
                    outputString = outputString.Append("</td>")
						
                    If PrintType = 0 Then
                        ValText = textTable.Rows(73)("TextParamValue")
                    ElseIf PrintType = 1 Then
                        ValText = textTable.Rows(72)("TextParamValue")
                    End If
                    tdColor = ""
                    If PrintType = 0 Then
                        Checked = "Checked"
                    Else
                        Checked = ""
                    End If
                    outputString = outputString.Append("<td align=""left"" class=""smalltext""" + tdColor + "><input type=""radio"" name=""PT:" + ParamName + """ value=""0""" + Checked + ">" + textTable.Rows(73)("TextParamValue"))
					
                    If PrintType = 1 Then
                        Checked = "Checked"
                    Else
                        Checked = ""
                    End If
                    outputString = outputString.Append("<br><input type=""radio"" name=""PT:" + ParamName + """ value=""1""" + Checked + ">" + textTable.Rows(72)("TextParamValue") + "</td>")
				
                    If VATType = 0 Then
                        ValText = "No"
                    ElseIf VATType = 1 Then
                        ValText = "Include"
                    Else
                        ValText = "Exclude"
                    End If
                    tdColor = ""
                    If VATType = 0 Then
                        Checked = "Checked"
                    Else
                        Checked = ""
                    End If
                    outputString = outputString.Append("<td align=""left"" class=""smalltext""" + tdColor + "><input type=""radio"" name=""VT:" + ParamName + """ value=""0""" + Checked + ">No")
                    If VATType = 1 Then
                        Checked = "Checked"
                    Else
                        Checked = ""
                    End If
                    outputString = outputString.Append("<br><input type=""radio"" name=""VT:" + ParamName + """ value=""1""" + Checked + ">Incl")
                    If VATType = 2 Then
                        Checked = "Checked"
                    Else
                        Checked = ""
                    End If
                    outputString = outputString.Append("<br><input type=""radio"" name=""VT:" + ParamName + """ value=""2""" + Checked + ">Excl</td>")
						
                    If SCValue = 1 Then
                        Checked = "checked"
                        ValText = "Y"
                    Else
                        Checked = " "
                        ValText = "N"
                    End If
                    outputString = outputString.Append("<td align=""center""" + tdColor + "><input type=""checkbox"" name=""SC:" + ParamName + """ value=""1""" + Checked + "></td>")

                    'Sale Mode
                    For k = 0 To dtSMData.Rows.Count - 1
                        strSaleMode = "SaleMode" & dtSMData.Rows(k)("SaleModeID")
                        If dtProductData.Columns.Contains(strSaleMode) = True Then
                            saleModeValue = foundRows(j)(strSaleMode).ToString
                        Else
                            saleModeValue = 0
                        End If
                        If saleModeValue = 1 Then
                            Checked = "checked"
                            ValText = "Y"
                        Else
                            Checked = " "
                            ValText = "N"
                        End If
                        ParamName = "ProductID" + ":" + foundRows(j)("ProductID").ToString

                        strTemp = "<td align=""center""" + tdColor + "><input type=""checkbox"" name=""" & strSaleMode & ":" & ParamName & """ value=""1""" & Checked & "></td>"
                        outputString = outputString.Append(strTemp)
                    Next k
                    
                    If Activate = 1 Then
                        Checked = "checked"
                        ValText = "Y"
                    Else
                        Checked = " "
                        ValText = "N"
                    End If
                    ParamName = "ProductID" + ":" + foundRows(j)("ProductID").ToString
                    outputString = outputString.Append("<td align=""center""" + tdColor + "><input type=""checkbox"" name=""AV:" + ParamName + """ value=""1""" + Checked + "></td>")

                    outputString = outputString.Append("</tr>")
                Next
                outputString = outputString.Append("<tr>")
                outputString = outputString.Append("<td colspan=""13"" height=""20"" align=""left"" class=""smalltext"">" + "&nbsp;" + "</td>")
                outputString = outputString.Append("</tr>")
            Next
						
			HiddenForm.InnerHtml = "<input type=""hidden"" name=""PIDList"" value=""" + PIDList + """><input type=""hidden"" name=""MasterShop"" value=""" + ProductLevelIDList + """>"
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
	getInfo.MultiProductDataUpdate(Request, objCnn)
	Dim ProductID As String = ""
	If Request.QueryString("ProductID") IsNot Nothing Then
		ProductID = Request.QueryString("ProductID").ToString
	End If
	Response.Redirect("multiproduct_setup_master.aspx?Update=done&ProductGroupID=" + Request.QueryString("ProductGroupID").ToString + "&ProductDeptID=" + Request.QueryString("ProductDeptID").ToString + "&ProductID=" + ProductID + "&ProductLevelID=" + Request.QueryString("ProductLevelID").ToString)
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
