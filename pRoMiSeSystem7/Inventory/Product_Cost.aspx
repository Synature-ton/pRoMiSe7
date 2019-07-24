<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSDBFront" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Set Product Cost</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">  
</head>
<body>

<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<form id="mainForm" runat="server">
<input type="hidden" id="ProductID" runat="server">
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">

<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><b class="headerText"><div class="headerText" align="left" id="HeaderText" runat="server"></div></b></div>
	</td>
	<td width="1" nowrap rowspan="99" bgcolor="003366"><img src="../images/clear.gif" height="1" width="1"></td>
</tr>
<tr bgcolor="666666">
	<td width="3%" height="1"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	<td width="94%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="252"></p></td>
	<td width="3%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	
</tr>
<tr><td height="10" colspan="3">&nbsp;</td></tr>

<tr>
<td>&nbsp;</td>
<td>

<table>
	<tr>
		<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
		<td class="text"><span id="ShowAllText" class="text" runat="server"></span></td>
		<td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
		<td class="text"><span id="KeywordText" class="text" runat="server"></span></td>
		<td><asp:textbox ID="Keywords" CssClass="text" Font-Size="10" Height="22" Width="150" runat="server" /></td>
		<td><asp:DropDownList ID="ProductCostGroupID" CssClass="text" Visible="true" AutoPostBack="false" runat="server" /></td>
		<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="80" OnClick="DoSearch" runat="server" /></td>
		<td><asp:DropDownList ID="OrderByParam" CssClass="text" SelectionMode="Single" runat="server">
				<asp:listitem></asp:listitem>
				<asp:listitem></asp:listitem>
			</asp:DropDownList>
		</td>
		<td><asp:Button ID="ExportExcel" OnClick="ExportToExcel" Height="20" Font-Size="8" Width="120" Text="Export to Excel" runat="server"></asp:Button></td>     
	</tr>
    <tr id="showtext" runat="server">
		<td colspan="10" class="boldText">Please add product cost group data before adding cost table</td>
	</tr>
</table>

<br>
<div id="ShowResults" visible="false" runat="server">

<table  border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;width:100%" >
	<tr>
		<td colspan="5" align="right"><asp:Label ID="lblUpdateProductCostGroup" runat="server" text="Update Cost for"></asp:Label>
                <asp:DropDownList ID="ProductCostGroupIDUpdate" CssClass="text" Visible="true" AutoPostBack="false" runat="server" />
                &nbsp;<asp:button ID="cmdImportProductCost" Font-Size="8" Height="20" Width="120" OnClick="ImportProductCost" runat="server" />
                &nbsp;<asp:button ID="SubmitChange1" Font-Size="8" Height="20" Width="120" OnClick="DoChange" runat="server" /></td>
	</tr>
    <tr>
        <td colspan="5" class="text">
            <asp:DropDownList ID="cboProductLevel" CssClass="text" AutoPostBack="true" Visible="true" runat="server" OnSelectedIndexChanged="SelProductGroupData"  />
            <asp:DropDownList ID="cboProductGroup" CssClass="text" AutoPostBack="true" Visible="true" runat="server" OnSelectedIndexChanged="SelProductDeptData"  />
            <asp:DropDownList ID="cboProductDept" CssClass="text"  AutoPostBack="true" Visible="true" runat="server" OnSelectedIndexChanged="SelProductCostData"   />
        </td>
    </tr>
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTDProductCode" align="center" class="tdHeader" runat="server"><div id="txtProductCode" runat="server"></div></td>
		<td id="headerTDProductName" align="center" class="tdHeader" runat="server"><div id="txtProductName" runat="server"></div></td>
		<td id="headerTDProductCost" align="center" class="tdHeader" runat="server"><div id="txtProductCost" runat="server"></div></td>
		<td id="headerTDProductUnit" align="center" class="tdHeader" runat="server"><div id="txtProductUnit" runat="server"></div></td>
		<td id="headerTDSetProductCost" align="center" class="tdHeader" runat="server"><div id="txtSetProductCost" runat="server"></div></td>
		<td id="headerTDSetProductUnit" align="center" class="tdHeader" runat="server"><div id="txtSetProductUnit" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>
	<tr>
		<td colspan="5" align="right"><asp:button ID="SubmitChange2" Font-Size="8" Height="20" Width="120" OnClick="DoChange" runat="server" /></td>
	</tr>
</table>

</div>
</td>
<td>&nbsp;</td>
</tr>
</form>
<tr><td colspan="3" height="30">&nbsp;</td></tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
<tr>
	<td height="50" colspan="3" background="../images/footerbg2000.gif">&nbsp;</td>
</tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
</table>

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
Dim getReport As New GenReports()
Dim objDB As New CDBUtil()
Dim CostInfo As New CostClass()
		
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("SetProductCost") Then
		
            headerTD1.BgColor = GlobalParam.AdminBGColor
            headerTDProductCode.BgColor = GlobalParam.AdminBGColor
            headerTDProductName.BgColor = GlobalParam.AdminBGColor
            headerTDProductUnit.BgColor = GlobalParam.AdminBGColor
            headerTDProductCost.BgColor = GlobalParam.AdminBGColor
            headerTDSetProductCost.BgColor = GlobalParam.AdminBGColor
            headerTDSetProductUnit.BgColor = GlobalParam.AdminBGColor
		
            headerTDProductUnit.Visible = False
            headerTDSetProductUnit.Visible = False
		
            Try
                objCnn = getCnn.EstablishConnection()
			
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
                SubmitChange1.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitChange1).ToString
                SubmitChange2.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitChange2).ToString
			
                HeaderText.InnerHtml = "Set Product Cost Data"
                KeywordText.InnerHtml = "Keywords"
                ShowAllText.InnerHtml = "Display All"
                SubmitForm.Text = " Submit "
                SubmitChange1.Text = " Submit Changes "
                SubmitChange2.Text = " Submit Changes "
                cmdImportProductCost.Text = "Import Data"
			
                OrderByParam.Items(0).Text = "Order By Product Code"
                OrderByParam.Items(0).Value = "a.ProductCode"
                OrderByParam.Items(1).Text = "Order By Product Name"
                OrderByParam.Items(1).Value = "a.ProductName"
			
                txtProductCode.InnerHtml = "Product Code"
                txtProductName.InnerHtml = "Product Name"
                txtProductCost.InnerHtml = "Product Cost"
                txtSetProductCost.InnerHtml = "Set Product Cost"
                txtProductUnit.InnerHtml = "Unit"
                txtSetProductUnit.InnerHtml = "Unit"
				
                Dim dtCostGroup As DataTable
                
                If POSDBSQLFront.POSUtilSQL.IsTableExist(objDB, objCnn, "ProductCostGroup") = False Then
                    ProductCostGroupID.Visible = False
                    lblUpdateProductCostGroup.Visible = False
                    ProductCostGroupIDUpdate.Visible = False
                    dtCostGroup = New DataTable
                Else
                    ProductCostGroupID.Visible = True
                    lblUpdateProductCostGroup.Visible = True
                    ProductCostGroupIDUpdate.Visible = True
                    dtCostGroup = CostInfo.ProductCostGroup(0, objCnn)
                    If dtCostGroup.Rows.Count = 0 Then
                        SubmitForm.Enabled = False
                        ExportExcel.Enabled = False
                        showtext.Visible = True
                    Else
                        showtext.Visible = False
                    End If
                End If
                
                If Not Page.IsPostBack Then
                    Radio_1.Checked = True
                    
                    If ProductCostGroupID.Visible = True Then
                        ProductCostGroupID.DataSource = dtCostGroup
                        ProductCostGroupID.DataValueField = "ProductCostGroupID"
                        ProductCostGroupID.DataTextField = "DateRangeString"
                        ProductCostGroupID.DataBind()
				
                        ProductCostGroupIDUpdate.DataSource = dtCostGroup
                        ProductCostGroupIDUpdate.DataValueField = "ProductCostGroupID"
                        ProductCostGroupIDUpdate.DataTextField = "DateRangeString"
                        ProductCostGroupIDUpdate.DataBind()
                        
                        ShowProductLevelData()
                        ShowProductGroupData()
                        ShowProductDeptData()
                        
                        'Go To Select Product Cost Group
                        If Not IsDBNull(Request("ProductCostGroupID")) Then
                            Dim i, costGroupID As Integer
                            Dim bolFound As Boolean
                            costGroupID = Request("ProductCostGroupID")
                            If costGroupID > 0 Then
                                bolFound = False
                                For i = 0 To ProductCostGroupID.Items.Count - 1
                                    If ProductCostGroupID.Items(i).Value = costGroupID Then
                                        ProductCostGroupID.SelectedIndex = i
                                        bolFound = True
                                        Exit For
                                    End If
                                Next i
                                If bolFound = True Then
                                    SearchResult(objCnn)
                                End If
                            End If
                        End If
                    End If
                    
                End If

            Catch ex As Exception
                errorMsg.InnerHtml = ex.Message
            End Try

        Else
            updateMessage.Text = "Access Denied"
        End If
    End Sub

    Sub DoChange(Source As Object, E As EventArgs)
        If ProductCostGroupID.Visible = False Then
            CostInfo.UpdateProductCost(Request, objCnn)
        Else
            CostInfo.UpdateUpdateProductCostByProductCostGroup(Request, objCnn)
        End If
        SearchResult(objCnn)
    End Sub

    Sub DoSearch(Source As Object, E As EventArgs)
        SearchResult(objCnn)
    End Sub

    Public Function SearchResult(ByVal objCnn As MySqlConnection) As String
        Dim i, j As Integer
        Dim TextClass As String = "smallText"
        Dim bgColor As String = "#eeeeee"
        ShowResults.Visible = True
	
        Dim ProductCostValue, ProductCostDisplay As String
	
        Dim KeywordString As String
        If Radio_1.Checked = True Then
            KeywordString = ""
        Else
            KeywordString = Keywords.Text
        End If
        Dim dtTable As DataTable
        Dim selCostGroupID, selShopID, selGroupID, selDeptID As Integer
        
        selShopID = cboProductLevel.SelectedItem.Value
        selGroupID = cboProductGroup.SelectedItem.Value
        selDeptID = cboProductDept.SelectedItem.Value
        
        If ProductCostGroupID.Visible = True Then
            selCostGroupID = ProductCostGroupID.SelectedItem.Value
            dtTable = CostInfo.SetProductCostByProductCostGroup(selCostGroupID, selShopID, selGroupID, selDeptID, 0, KeywordString, OrderByParam.SelectedItem.Value, objCnn)
        Else
            dtTable = CostInfo.SetProductCost(selGroupID, selDeptID, 0, KeywordString, OrderByParam.SelectedItem.Value, objCnn)
        End If

        Dim DummyProductCode As String = ""
        Dim outputString As StringBuilder = New StringBuilder
        For i = 0 To dtTable.Rows.Count - 1
            If DummyProductCode <> dtTable.Rows(i)("ProductCode") Then
                If bgColor = "#eeeeee" Then
                    bgColor = "white"
                Else
                    bgColor = "#eeeeee"
                End If
                outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")
	
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & (i + 1).ToString & ")</td>")
	
                If Not IsDBNull(dtTable.Rows(i)("ProductCode")) Then
                    outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("ProductCode") & "</td>")
                Else
                    outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
                End If
			
                If Not IsDBNull(dtTable.Rows(i)("ProductName")) Then
                    outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("ProductName") & "</td>")
                Else
                    outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
                End If
			
                If Not IsDBNull(dtTable.Rows(i)("ProductCost")) Then
                    ProductCostValue = Format(dtTable.Rows(i)("ProductCost"), "##,##0.0000")
                    ProductCostDisplay = Format(dtTable.Rows(i)("ProductCost"), "##,##0.0000")
                Else
                    ProductCostValue = ""
                    ProductCostDisplay = "-"
                End If
                outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & ProductCostDisplay & "</td>")
                If ProductCostGroupIDUpdate.Visible = False Then
                    'Old Version : ProductCode
                    outputString = outputString.Append("<td><input type=""text"" name=""ProductCode^" + dtTable.Rows(i)("ProductCode").ToString + """ value=""" + ProductCostValue + """ style=""font-size:10px;line-height:12px;text-align:right;width:100px""></td>")
                Else
                    'New Version : ProductID
                    outputString = outputString.Append("<td><input type=""text"" name=""ProductID:" + dtTable.Rows(i)("ProductID").ToString + """ value=""" + ProductCostValue + """ style=""font-size:10px;line-height:12px;text-align:right;width:100px""></td>")
                End If
                outputString = outputString.Append("</tr>")
                DummyProductCode = dtTable.Rows(i)("ProductCode")
            End If
        Next
        ResultText.InnerHtml = outputString.ToString
    End Function

    Sub ExportToExcel(Source As Object, E As EventArgs)
        Dim KeywordString As String
        If Radio_1.Checked = True Then
            KeywordString = ""
        Else
            KeywordString = Keywords.Text
        End If
        Dim dtTable As DataTable
        If ProductCostGroupID.Visible = True Then
            Dim selShopID, selCostGroupID As Integer
            selCostGroupID = ProductCostGroupID.SelectedItem.Value
            selShopID = cboProductLevel.SelectedItem.Value
            dtTable = CostInfo.SetProductCostByProductCostGroup(selCostGroupID, selShopID, 0, 0, 0, KeywordString, OrderByParam.SelectedItem.Value, objCnn)
        Else
            dtTable = CostInfo.SetProductCost(0, 0, 0, KeywordString, OrderByParam.SelectedItem.Value, objCnn)
        End If
        Dim i As Integer
        Dim filename As String = "ProductData.csv"
	
        Response.Clear()
        Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader("Content-Disposition", "attachment; filename=""" & filename & """")
        Response.Charset = "windows-874"
        Response.ContentEncoding = System.Text.Encoding.GetEncoding(874)
        Response.Flush()
        Response.Write("ProductCode,ProductName,ProductCost" + Chr(13) & Chr(10))
	
        For i = 0 To dtTable.Rows.Count - 1
            Response.Write("""" + Replace(dtTable.Rows(i)("ProductCode"), """", """""") + """,""" + Replace(dtTable.Rows(i)("ProductName"), """", """""") + """")

            If Not IsDBNull(dtTable.Rows(i)("ProductCost")) Then
                Response.Write(",""" + dtTable.Rows(i)("ProductCost").ToString + """")
            Else
                Response.Write(",""-""")
            End If
            Response.Write(Chr(13) & Chr(10))
        Next
        Response.End()
    End Sub
	  
    Sub ShowProductLevelData()
        Dim i As Integer
        Dim dtShop As DataTable = New DataTable("ShopData")
        Dim rNew As DataRow
        Dim dtData As DataTable
        
        dtShop.Columns.Add("ProductLevelName", GetType(String))
        dtShop.Columns.Add("ProductLevelID", GetType(Integer))
        
        dtData = getInfo.GetProductLevel(-999, objCnn)
        For i = 0 To dtData.Rows.Count - 1
            rNew = dtShop.NewRow()
            rNew("ProductLevelName") = dtData.Rows(i)("ProductLevelCode") & " : " & dtData.Rows(i)("ProductLevelName")
            rNew("ProductLevelID") = dtData.Rows(i)("ProductLevelID")
            dtShop.Rows.Add(rNew)
        Next i
	
        cboProductLevel.DataSource = dtShop
        cboProductLevel.DataValueField = "ProductLevelID"
        cboProductLevel.DataTextField = "ProductLevelName"
        cboProductLevel.DataBind()
        If dtShop.Rows.Count > 0 Then
            cboProductLevel.SelectedIndex = 0
        End If
    End Sub
        
    Sub SelProductGroupData(sender As Object, e As System.EventArgs)
        ShowProductGroupData()
        SearchResult(objCnn)
    End Sub
    
    Sub ShowProductGroupData()
        Dim i, selShopID As Integer
        Dim dtProductGroup As DataTable = New DataTable("ProductGroupData")
        Dim rNew As DataRow
        Dim dtData As DataTable
        
        dtProductGroup.Columns.Add("ProductGroupName", GetType(String))
        dtProductGroup.Columns.Add("ProductGroupID", GetType(Integer))
        
        selShopID = cboProductLevel.SelectedItem.Value
        dtData = CostInfo.ListProductGroup(objCnn, selShopID)
        
        rNew = dtProductGroup.NewRow()
        rNew("ProductGroupName") = "---- All ----"
        rNew("ProductGroupID") = 0
        dtProductGroup.Rows.Add(rNew)
        
        For i = 0 To dtData.Rows.Count - 1
            rNew = dtProductGroup.NewRow()
            rNew("ProductGroupName") = dtData.Rows(i)("ProductGroupCode") & " : " & dtData.Rows(i)("ProductGroupName")
            rNew("ProductGroupID") = dtData.Rows(i)("ProductGroupID")
            dtProductGroup.Rows.Add(rNew)
        Next i
	
        cboProductGroup.DataSource = dtProductGroup
        cboProductGroup.DataValueField = "ProductGroupID"
        cboProductGroup.DataTextField = "ProductGroupName"
        cboProductGroup.DataBind()
        
        cboProductGroup.SelectedIndex = 0
    End Sub
    
    Sub SelProductDeptData(sender As Object, e As System.EventArgs)
        ShowProductDeptData()
        SearchResult(objCnn)
    End Sub
	
    Sub ShowProductDeptData()
        Dim i As Integer
        Dim selShopID, selGroupID As Integer
        Dim dtProductDept As DataTable = New DataTable("ProductDeptData")
        Dim rNew As DataRow
        Dim dtData As DataTable
        
        selShopID = cboProductLevel.SelectedItem.Value
        If cboProductGroup.Items.Count = 0 Then
            selGroupID = 0
        Else
            selGroupID = cboProductGroup.SelectedItem.Value
        End If
        
        dtProductDept.Columns.Add("ProductDeptName", GetType(String))
        dtProductDept.Columns.Add("ProductDeptID", GetType(Integer))
        dtData = CostInfo.ListProductDept(objCnn, selShopID, selGroupID)
        
        rNew = dtProductDept.NewRow()
        rNew("ProductDeptName") = "---- All ----"
        rNew("ProductDeptID") = 0
        dtProductDept.Rows.Add(rNew)
        
        For i = 0 To dtData.Rows.Count - 1
            rNew = dtProductDept.NewRow()
            rNew("ProductDeptName") = dtData.Rows(i)("ProductDeptCode") & " : " & dtData.Rows(i)("ProductDeptName")
            rNew("ProductDeptID") = dtData.Rows(i)("ProductDeptID")
            dtProductDept.Rows.Add(rNew)
        Next i
	
        cboProductDept.DataSource = dtProductDept
        cboProductDept.DataValueField = "ProductDeptID"
        cboProductDept.DataTextField = "ProductDeptName"
        cboProductDept.DataBind()
                       
        cboProductDept.SelectedIndex = 0
    End Sub
          
    Sub SelProductCostData(sender As Object, e As System.EventArgs)
        SearchResult(objCnn)
    End Sub
        
    Sub ImportProductCost(ByVal Source As Object, ByVal E As EventArgs)
        Response.Redirect("ImportMaterialProductCostTableData.aspx?ImportType=1&CostGroupID=" & ProductCostGroupIDUpdate.SelectedValue)
    End Sub

    Sub Page_UnLoad()
        objCnn.Close()
    End Sub

</script>
</body>
</html>
