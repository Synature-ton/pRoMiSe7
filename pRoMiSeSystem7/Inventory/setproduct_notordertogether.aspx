<%@ Page Language="VB" ContentType="text/html" debug="True"%>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySql.GlobalFunctions" %>
<%@Import Namespace="POSTypeClass" %>
<%@Import Namespace="pRoMiSeProgramProperty" %>
<html>
<head>
<title>Set Product Not Order Together</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">
<form id="mainForm" runat="server">
<ASP:Label id="updateMessage" CssClass="text" runat="server" />

<table cellpadding="2" cellspacing="2" width="90%">
<tr>
<td align="left"><div class="headerText" align="left" id="HeaderText" runat="server" /></td>
<td align="right"></td>
</tr>
<tr><td height="5" colspan="2"></td></tr>
<tr><td><div id="CostText" class="text" runat="server"></div></td>
<td align="right"><div class="text" id="GoBackText" runat="server"></div></td></tr>
<tr><td height="5" colspan="2"></td></tr>
</table>

	<input type="hidden" id="ProductID" runat="server">
	<input type="hidden" id="NotTogetherProductID" runat="server">

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="90%">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="OrderText" runat="server"></div></td>
		<td id="headerTDProductCode" align="center" class="tdHeader" runat="server"><div id="dvProductCode" runat="server"></div></td>
		<td id="headerTDProductName" align="center" class="tdHeader" runat="server"><div id="dvProductName" runat="server"></div></td>
		<td id="headerTDActionText" align="center" class="tdHeader" runat="server"><div id="dvActionText" runat="server"></div></td>
	</tr>	
	<div id="ResultText" runat="server"></div>
	
	<tr id="AddDataText" runat="server">
		<td><div id="dvOrderText" class="text" align="center" runat="server"></div></td>
		<td><table cellpadding="0" cellspacing="0"><div id="ValidateCode" runat="server"></div>
              <tr>
                  <td><asp:textbox ID="txtProductCode" Width="100" runat="server" /></td>
                  <td width="5"></td>
                  <td><div id="dvSearchProductLink" class="text" runat="server"></div></td>
              </tr></table>
		</td>
		<td><div id="dvProductNameText" class="text" runat="server"></div></td>
		<td align="center"><table cellpadding="0" cellspacing="0">
                <tr>
                    <td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="45" OnClick="DoAddUpdate" runat="server" /></td>
                    <td width="5"></td>
                    <td><div id="CancelUpdate" runat="server"></div></td>
                </tr></table>
		</td>
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

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Inv_Product_Category") Then
	  
            If Not Request.QueryString("ProductID") And IsNumeric(Request.QueryString("ProductID")) Then
                ProductID.Value = Request.QueryString("ProductID")
                
                headerTD1.BgColor = GlobalParam.AdminBGColor
                headerTDProductCode.BgColor = GlobalParam.AdminBGColor
                headerTDProductName.BgColor = GlobalParam.AdminBGColor
                headerTDActionText.BgColor = GlobalParam.AdminBGColor
	
                'Try
                objCnn = getCnn.EstablishConnection()
                
                Dim bolHasNotOrderTogether As Boolean
                If pRoMiSeProgramProperty.ProgramPropertyFunction.GetProgramPropertyValueInDB(objDB, objCnn, POSAdditionalProgramVariable.PROGRAMTYPE_FRONT, _
                              1, POSAdditionalProgramVariable.PROPERTY_CHECKORDERPRODUCTTOGETHERFEATURE, 0) = 1 Then
                    If POSDBSQLFront.POSUtilSQL.IsTableExist(objDB, objCnn, "ProductNotOrderTogether") = True Then
                        bolHasNotOrderTogether = True
                    Else
                        bolHasNotOrderTogether = False
                    End If
                Else
                    bolHasNotOrderTogether = False
                End If
                
                If bolHasNotOrderTogether = False Then
                    updateMessage.Text = "Access Denied"
                    Exit Sub
                End If
                
                Dim strTemp As String
                Dim dtProductInfo, dtNotOrderTogetherProduct As New DataTable()
                dtProductInfo = getInfo.GetProductInfo(0, Request.QueryString("ProductID"), objCnn)
			
                If dtProductInfo.Rows.Count <> 0 Then
                    dtNotOrderTogetherProduct = getInfo.ListProductNotOrderTogether(objCnn, Request.QueryString("ProductID"))
			
                    Dim textTable As New DataTable()
                    textTable = getPageText.GetText(8, Session("LangID"), objCnn)
								
                    Dim defaultTextTable As New DataTable()
                    defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
                   
                    If textTable.Rows.Count > 70 Then
                        strTemp = textTable.Rows(69)("TextParamValue")
                    Else
                        strTemp = "Set Product Not Order Together for"
                    End If
                    HeaderText.InnerHtml = strTemp & " " & dtProductInfo.Rows(0)("ProductName")
                    OrderText.InnerHtml = textTable.Rows(1)("TextParamValue")
                    dvProductCode.InnerHtml = textTable.Rows(35)("TextParamValue")
                    dvProductName.InnerHtml = textTable.Rows(36)("TextParamValue")
                    dvActionText.InnerHtml = textTable.Rows(7)("TextParamValue")
                    
                    Dim i, j As Integer
                    Dim strBuild As StringBuilder
				
                    Dim SelectedText As String
                    Dim selNotOrderProductID As Integer
                    
                    strBuild = New StringBuilder
                    selNotOrderProductID = 0
                    For i = 0 To dtNotOrderTogetherProduct.Rows.Count - 1
                        If Not Request.QueryString("a") Is Nothing Then
                            If Request.QueryString("a") = "yes" And Request.QueryString("NotTogetherProductID") = dtNotOrderTogetherProduct.Rows(i)("ProductID") Then
                                SelectedText = "disabledText"
                                selNotOrderProductID = dtNotOrderTogetherProduct.Rows(i)("ProductID")
                            Else
                                SelectedText = "text"
                            End If
                        Else
                            SelectedText = "text"
                        End If
                        
                        If IsDBNull(dtNotOrderTogetherProduct.Rows(i)("ProductCode")) Then
                            dtNotOrderTogetherProduct.Rows(i)("ProductCode") = ""
                        End If
                        If IsDBNull(dtNotOrderTogetherProduct.Rows(i)("ProductName")) Then
                            dtNotOrderTogetherProduct.Rows(i)("ProductName") = ""
                        End If
                                               
                        strBuild.Append("<tr><td align=""center"" class=""" + SelectedText + """>" & i + 1 & "." & "</td>")
                        strBuild.Append("<td align=""left"" class=""" + SelectedText + """>" & dtNotOrderTogetherProduct.Rows(i)("ProductCode") & "</td>")
                        strBuild.Append("<td align=""left"" class=""" + SelectedText + """>" & dtNotOrderTogetherProduct.Rows(i)("ProductName") & "</td>")
                         
                        If SelectedText = "text" Then
                            'Edit
                            strTemp = "<td align=""center"" class=""text""><a href=""setproduct_notordertogether.aspx?EditID=3&a=yes&ProductGroupID=" & Request.QueryString("ProductGroupID") & _
                                            "&ProductLevelID=" & Request.QueryString("ProductLevelID") & "&ProductDeptID=" & Request.QueryString("ProductDeptID") & _
                                            "&ProductID=" + Request.QueryString("ProductID") & "&NotTogetherProductID=" & dtNotOrderTogetherProduct.Rows(i)("ProductID").ToString & _
                                            """>Edit</a>"
                            strBuild.Append(strTemp)
                            'Delete
                            If textTable.Rows.Count > 71 Then
                                strTemp = textTable.Rows(70)("TextParamValue")
                            Else
                                strTemp = "Are you sure you want delete"
                            End If
                            strTemp = "&nbsp;&nbsp;<a href=""inv_category_action.aspx?action=delete_notordertogether&EditID=3&GoBackURL=setproduct_notordertogether.aspx&ProductGroupID=" + Request.QueryString("ProductGroupID") & _
                                                "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") & _
                                                "&ProductID=" + Request.QueryString("ProductID") + "&NotTogetherProductID=" + dtNotOrderTogetherProduct.Rows(i)("ProductID").ToString & """" & _
                                                "onClick=""javascript: return confirm('" & strTemp & " " & Replace(dtNotOrderTogetherProduct.Rows(i)("ProductName"), "'", "\'") & " " & _
                                                textTable.Rows(15)("TextParamValue") & "')"">" + "Del</a></td>"
                            strBuild.Append(strTemp)
                        Else
                            strBuild.Append("<td align=""center"" class=""" + SelectedText + """>Updating</td>")
                        End If
                        strBuild.Append("</tr>")
                    Next
                   				
                    Dim AttachEditText As String
                    If Request.QueryString("a") <> "yes" Then
                        dvOrderText.InnerHtml = ""
                        SubmitForm.Text = "Add"
                        AttachEditText = "&b=null"
                    Else
                        SubmitForm.Text = "Update"
                        dvOrderText.InnerHtml = "<a href=""setproduct_notordertogether.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" & _
                                        Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" & _
                                        Request.QueryString("ProductID") & """>Cancel</a>"
                        AttachEditText = "&a=yes"
                       
                    End If
				
                    'From Search Product Link 
                    If (Not Page.IsPostBack) And Not Request.QueryString("MaterialID") And IsNumeric(Request.QueryString("MaterialID")) Then
                        selNotOrderProductID = Request.QueryString("MaterialID")
                    End If
                    				
                    If selNotOrderProductID > 0 And Not Page.IsPostBack Then
                        Dim dtProductData As DataTable
                        dtProductData = getInfo.GetProductInfo(0, selNotOrderProductID, objCnn)
                        If dtProductData.Rows.Count > 0 Then
                            SetProductDetailToTextBox(dtProductData)
                        End If
                    End If
                    ResultText.InnerHtml = strBuild.ToString
			        
                    
                    If selNotOrderProductID > 0 Then
                        strTemp = "&NotTogetherProductID=" & selNotOrderProductID
                    Else
                        strTemp = ""
                    End If
                    dvSearchProductLink.InnerHtml = "<a href=""JavaScript: newWindow = window.open( 'product_category.aspx?EditID=3&From=setproduct_notordertogether.aspx&ProductGroupID=" + Request.QueryString("ProductGroupID") & _
                                        "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") & _
                                        "&ProductID=" + Request.QueryString("ProductID") & strTemp & AttachEditText & _
                                        "', '', 'width=600,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & _
                                        defaultTextTable.Rows(9)("TextParamValue") & "</a>"
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
        Dim strTemp, strResult As String
        Dim bolFoundError As Boolean
        Dim currentNotTogetherProductID As Integer
        Dim textTable As New DataTable()

        textTable = getPageText.GetText(8, Session("LangID"), objCnn)

        Dim dtProductByCode As DataTable
        dtProductByCode = getInfo.GetProductInfo(0, 0, txtProductCode.Text, Request.QueryString("ProductLevelID"), objCnn)

        bolFoundError = False
        If dtProductByCode.Rows.Count = 0 Then
            ValidateCode.InnerHtml = "<tr><td colspan=""3"" class=""errorText"">" & textTable.Rows(9)("TextParamValue") & "</td></tr>"
            bolFoundError = True
        Else
            SetProductDetailToTextBox(dtProductByCode)
        End If
	         
        If IsNumeric(Request.QueryString("NotTogetherProductID")) Then
            currentNotTogetherProductID = Request.QueryString("NotTogetherProductID")
        Else
            currentNotTogetherProductID = 0
        End If
       
        If bolFoundError = False Then
            strResult = ""
            Application.Lock()
            Try
                If ProductID.Value <> NotTogetherProductID.Value Then
                    'Delete Current NotTogetherProductID (For Edit)
                    If currentNotTogetherProductID <> 0 Then
                        getInfo.DeleteProductNotOrderTogether(ProductID.Value, currentNotTogetherProductID, objCnn)
                    End If
                    'Delete ProductID (For Add New)
                    getInfo.DeleteProductNotOrderTogether(ProductID.Value, NotTogetherProductID.Value, objCnn)
                    'Add New NotTogetherProductID
                    getInfo.AddNewProductNotOrderTogether(ProductID.Value, NotTogetherProductID.Value, objCnn)
                
                    getInfo.UpdateProductDate(ProductID.Value, objCnn)
                End If
                
            Catch ex As Exception
                strResult = ex.ToString
            End Try
            
            Application.UnLock()
            If strResult = "" Then
                Response.Redirect("setproduct_notordertogether.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") & _
                            "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") & _
                            "&ProductID=" & Request.QueryString("ProductID"))
            Else
                errorMsg.InnerHtml = strResult
            End If
        End If
	
    End Sub

    Private Sub SetProductDetailToTextBox(dtProductData As DataTable)
        ValidateCode.InnerHtml = ""
        txtProductCode.Text = dtProductData.Rows(0)("ProductCode")
        dvProductNameText.InnerHtml = dtProductData.Rows(0)("ProductName")
        NotTogetherProductID.Value = dtProductData.Rows(0)("ProductID")
    End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
