<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<html>
<head>
<title>Manage User Action</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<div id="Message" class="headerText" runat="server"></div>
<div id="errorMsg" class="headerText" runat="server"></div>
<script language="VB" runat="server">

Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim userInfo As New CCategory()
Dim DateTimeUtil As New MyDateTime()
Dim objDB As New CDBUtil()
Dim InvC As CultureInfo = CultureInfo.InvariantCulture
Dim PriceBeginDate As String = "{ d '2000-01-01' }"
Dim PriceEndDate As String = "{ d '9999-01-01' }"

    Sub Page_Load()
        If User.Identity.IsAuthenticated And (Session("Inv_Product_Category") Or Session("Inv_Material_Category") Or Session("Purchase_Order") Or Session("Receive_Order")) Then
            Dim ReturnPage As String
            Dim strTemp As String
            
            Select Case Request.QueryString("action")

                Case "delete_category"
                    Dim TableName, TableKey As String
                    Select Case Request.QueryString("action_to")
                        Case "productlevel"
                            TableName = "ProductLevel"
                            TableKey = "ProductLevelID"
                            ReturnPage = "inv_category.aspx"
                        Case "productgroup"
                            TableName = "ProductGroup"
                            TableKey = "ProductGroupID"
                            ReturnPage = "product_category.aspx"
                        Case "productdept"
                            TableName = "ProductDept"
                            TableKey = "ProductDeptID"
                            ReturnPage = "product_category.aspx"
                        Case "product"
                            TableName = "Products"
                            TableKey = "ProductID"
                            ReturnPage = "product_category.aspx"
                        Case "materiallevel"
                            TableName = "MaterialLevel"
                            TableKey = "MaterialLevelID"
                            ReturnPage = "mat_category.aspx"
                        Case "materialgroup"
                            TableName = "MaterialGroup"
                            TableKey = "MaterialGroupID"
                            ReturnPage = "material_category.aspx"
                        Case "materialdept"
                            TableName = "MaterialDept"
                            TableKey = "MaterialDeptID"
                            ReturnPage = "material_category.aspx"
                        Case "material"
                            TableName = "Materials"
                            TableKey = "MaterialID"
                            ReturnPage = "material_category.aspx"
                        Case "vendor_group"
                            TableName = "VendorGroup"
                            TableKey = "VendorGroupID"
                            ReturnPage = "manage_vendor.aspx"
                        Case "vendor"
                            TableName = "Vendors"
                            TableKey = "VendorID"
                            ReturnPage = "manage_vendor.aspx"
                        Case "document_temp"
                            If Request.QueryString("DocumentID") = 0 Then
                                TableName = "DocDetailTemp"
                            Else
                                TableName = "DocDetail"
                            End If
                            TableKey = "DocDetailID"
                            ReturnPage = "document_control.aspx"
                        Case "document_temp1"
                            TableName = "DocDetailTemp"
                            TableKey = "DocDetailID"
                            ReturnPage = "receive_document.aspx"
                        Case "document_transfer"
                            If Request.QueryString("DocumentID") = 0 Then
                                TableName = "DocDetailTemp"
                            Else
                                TableName = "DocDetail"
                            End If
                            TableKey = "DocDetailID"
                            ReturnPage = "withdraw_document.aspx"
                        Case "document_modify"
                            If Request.QueryString("DocumentID") = 0 Then
                                TableName = "DocDetailTemp"
                            Else
                                TableName = "DocDetail"
                            End If
                            TableKey = "DocDetailID"
                            ReturnPage = "addedit_document.aspx"
                        Case "document_editRO"
                            If Request.QueryString("DocumentID") = 0 Then
                                TableName = "DocDetailTemp"
                            Else
                                TableName = "DocDetail"
                            End If
                            TableKey = "DocDetailID"
                            ReturnPage = "editreceive_document.aspx"
                    End Select
                    If IsNumeric(Request.QueryString("DelID")) Then
                        Try
                            objCnn = getCnn.EstablishConnection()
                            Dim ResultString As String = ""
                            If TableKey = "DocDetailID" Then
                                ResultString = userInfo.DelDocument(Request.QueryString("DelID"), TableName, TableKey, 1, objCnn)
                            Else
                                ResultString = userInfo.DelCategory(Request.QueryString("DelID"), TableName, TableKey, objCnn)
                            End If
                        Catch objError As Exception
                            'display error details
                            Message.InnerHtml = "<b>* Error while accessing database</b>.<br />" _
                                & objError.Message & "<br />" & objError.Source
                            Exit Sub  ' and stop execution
	
                        End Try
                    End If
                    Response.Redirect(ReturnPage + "?" + Request.QueryString.ToString)
                Case "delete_component"
                    If Request.QueryString("PComponentID") IsNot Nothing Then
                        Try
                            objCnn = getCnn.EstablishConnection()
                            Dim ResultString As String = ""
                            ResultString = userInfo.AUDComponent("Delete", Request.QueryString("PComponentID"), 0, 0, 0, 0, True, 0, 1, False, 0, 0, objCnn)
                            userInfo.UpdateProductDate(Request.QueryString("ProductID"), objCnn)
                        Catch objError As Exception
                            'display error details
                            Message.InnerHtml = "<b>* Error while accessing database</b>.<br />" _
                                & objError.Message & "<br />" & objError.Source
                            Exit Sub  ' and stop execution
	
                        End Try
                    End If
                    Dim GoBackURL As String = "product_component.aspx"
                    If Trim(Request.QueryString("GoBackURL")) <> "" Then
                        GoBackURL = Trim(Request.QueryString("GoBackURL"))
                    End If
                    strTemp = GoBackURL & "?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") & _
                                    "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") & _
                                    "&ProductID=" + Request.QueryString("ProductID") + "&PGroupID=" & Request.QueryString("PGroupID")
                    If Not ( Request.QueryString("SaleMode") Is Nothing)  Then
                        strTemp &= "&SaleMode=" & Request.QueryString("SaleMode")
                    End If
                    Response.Redirect(strTemp)
               
                Case "delete_notordertogether"
                    If Request.QueryString("NotTogetherProductID") IsNot Nothing Then
                        Try
                            objCnn = getCnn.EstablishConnection()
                            Dim ResultString As String = ""
                            ResultString = userInfo.DeleteProductNotOrderTogether(Request.QueryString("ProductID"), Request.QueryString("NotTogetherProductID"), objCnn)
                            userInfo.UpdateProductDate(Request.QueryString("ProductID"), objCnn)
                        Catch objError As Exception
                            'display error details
                            Message.InnerHtml = "<b>* Error while accessing database</b>.<br />" _
                                & objError.Message & "<br />" & objError.Source
                            Exit Sub  ' and stop execution
	
                        End Try
                    End If
                    Dim GoBackURL As String = "setproduct_notordertogether.aspx"
                    If Trim(Request.QueryString("GoBackURL")) <> "" Then GoBackURL = Trim(Request.QueryString("GoBackURL"))
                    Response.Redirect(GoBackURL + "?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") & _
                                     "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") & _
                                      "&PGroupID=" + Request.QueryString("PGroupID"))
                Case "delete_upsize"
                    If IsNumeric(Request.QueryString("ProductID")) Then
                        Try
                            objCnn = getCnn.EstablishConnection()
                            Dim ResultString As String = ""
                            ResultString = getCnn.sqlExecute("delete from ProductUpSizeDetail where UpSizeProductCode='" + Request.QueryString("ProductCode") + "' AND ChangeFromProductCode='" + Request.QueryString("ChangeFromProductCode") + "'", objCnn)
                            userInfo.UpdateProductDate(Request.QueryString("ProductID"), objCnn)
                        Catch objError As Exception
                            'display error details
                            Message.InnerHtml = "<b>* Error while accessing database</b>.<br />" _
                                & objError.Message & "<br />" & objError.Source
                            Exit Sub  ' and stop execution
	
                        End Try
                    End If
                    Dim GoBackURL As String = "productupsize_component.aspx"
                    If Trim(Request.QueryString("GoBackURL")) <> "" Then GoBackURL = Trim(Request.QueryString("GoBackURL"))
                    Response.Redirect(GoBackURL + "?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID"))
             
                Case "delete_price"
                    If IsNumeric(Request.QueryString("ProductPriceID")) Then
                        Try
                            objCnn = getCnn.EstablishConnection()
                            Dim ResultString As String = ""
                            ResultString = userInfo.DeleteProductPrice(Request.QueryString("ProductPriceID"), Request.QueryString("ProductID"), objCnn)
                            userInfo.UpdateProductDate(Request.QueryString("ProductID"), objCnn)
                        Catch objError As Exception
                            'display error details
                            Message.InnerHtml = "<b>* Error while accessing database</b>.<br />" _
                                & objError.Message & "<br />" & objError.Source
                            Exit Sub  ' and stop execution
	
                        End Try
                    End If
                    Dim GoBackURL As String = "product_price.aspx"
                    If Trim(Request.QueryString("GoBackURL")) <> "" Then GoBackURL = Trim(Request.QueryString("GoBackURL"))
                    Response.Redirect(GoBackURL + "?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID"))
		
                Case "delete_price_salemode"
                    If IsNumeric(Request.QueryString("ProductID")) And Trim(Request.QueryString("FromDateString")) <> "" And Trim(Request.QueryString("ToDateString")) <> "" Then
                        Try
                            objCnn = getCnn.EstablishConnection()
                            Dim ResultString As String = ""
                            ResultString = userInfo.DeleteProductPrice(Request.QueryString("ProductPriceID"), Request.QueryString("ProductID"), Request.QueryString("FromDateString"), Request.QueryString("ToDateString"), objCnn)
                            userInfo.UpdateProductDate(Request.QueryString("ProductID"), objCnn)
                        Catch objError As Exception
                            'display error details
                            Message.InnerHtml = "<b>* Error while accessing database</b>.<br />" _
                                & objError.Message & "<br />" & objError.Source
                            Exit Sub  ' and stop execution
	
                        End Try
				
                    End If
                    Dim GoBackURL As String = "product_price.aspx"
                    If Trim(Request.QueryString("GoBackURL")) <> "" Then GoBackURL = Trim(Request.QueryString("GoBackURL"))
                    Response.Redirect(GoBackURL + "?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID"))
				
                Case "set_defaultprice"
                    If IsNumeric(Request.QueryString("ProductPriceID")) Then
                        Try
                            objCnn = getCnn.EstablishConnection()
                            Dim ResultString As String = ""
                            ResultString = userInfo.PriceAction("SetDefault", Request.QueryString("ProductID"), Request.QueryString("ProductPriceID"), objCnn)
                            userInfo.UpdateProductDate(Request.QueryString("ProductID"), objCnn)
                        Catch objError As Exception
                            'display error details
                            Message.InnerHtml = "<b>* Error while accessing database</b>.<br />" _
                                & objError.Message & "<br />" & objError.Source
                            Exit Sub  ' and stop execution
	
                        End Try
                    End If
                    Dim GoBackURL As String = "product_price.aspx"
                    If Trim(Request.QueryString("GoBackURL")) <> "" Then GoBackURL = Trim(Request.QueryString("GoBackURL"))
                    Response.Redirect(GoBackURL + "?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID"))
             
                Case "delete_material_component"
                    If IsNumeric(Request.QueryString("SelMaterialID")) And IsNumeric(Request.QueryString("MaterialID")) Then
                        Try
                            objCnn = getCnn.EstablishConnection()
                            userInfo.DelSelMaterial(Request.QueryString("MaterialID"), Request.QueryString("SelMaterialID"), objCnn)
                        Catch objError As Exception
                            'display error details
                            Message.InnerHtml = "<b>* Error while accessing database</b>.<br />" _
                                & objError.Message & "<br />" & objError.Source
                            Exit Sub  ' and stop execution
	
                        End Try
                    End If
                    Dim GoBackURL As String = "material_component.aspx"
                    If Trim(Request.QueryString("GoBackURL")) <> "" Then GoBackURL = Trim(Request.QueryString("GoBackURL"))
                    Response.Redirect(GoBackURL + "?MaterialID=" + Request.QueryString("MaterialID") + "&MaterialGroupID=" + Request.QueryString("MaterialGroupID") + "&MaterialDeptID=" + Request.QueryString("MaterialDeptID"))
            End Select
		
        Else
            Message.InnerHtml = "You are not permit to access this page"
        End If
    End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
