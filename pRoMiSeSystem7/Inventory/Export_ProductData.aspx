<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="System.IO" %>

<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Export Product Data</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<form id="mainForm" runat="server">
<input type="hidden" id="ProductLevelID" runat="server">
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
<SCRIPT language="JavaScript">
			function CheckAll(checked) {
				len = document.forms[0].DestinationShop.length;
				var i=0;
				for( i=0; i<len; i++) {
					document.forms[0].DestinationShop.options[i].selected=checked;
				}
			}
	</script>
<table>
<tr><td>
<table>
	<tr>
		<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
		<td class="text"><span id="ShowAllText" class="text" runat="server"></span></td>
	</tr>
	<tr>
		<td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
		<td class="text"><span id="KeywordText" class="text" runat="server"></span></td>
		<td><asp:textbox ID="Keywords" CssClass="text" Font-Size="10" Height="22" Width="150" runat="server" /></td>
	</tr>
	<tr>
		<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
		<td class="text"><span id="ProductCodeText" class="text" runat="server"></span></td>
		<td><asp:textbox ID="ProductCodeKey" CssClass="text" Font-Size="10" Height="22" Width="150" runat="server" /></td>
	</tr>
    <tr>
		<td></td>
		<td class="text"><asp:CheckBox ID="chkNotIncludeComment" runat="server" CssClass="text" Text="Not Include Comment"/></td>
		<td></td>
	</tr>

	<tr>
		<td></td>
		<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="80" OnClick="DoSearch" runat="server" />&nbsp;<asp:Button ID="ExportExcel" OnClick="ExportToExcel" Height="20" Font-Size="8" Width="120" Text="Export to Excel" runat="server"></asp:Button></td>	
		
		<td><asp:DropDownList ID="OrderByParam" CssClass="text" SelectionMode="Single" runat="server">
				<asp:listitem></asp:listitem>
				<asp:listitem></asp:listitem>
			</asp:DropDownList>
		</td>
	</tr>
</table>
</td>
<td><span id="showShopList" visible="false" runat="server">
<table>
	<tr>
				<td class="text"><a href="javascript:CheckAll(true)">Select&nbsp;All</a> - <a href="javascript:CheckAll(false)">Clear&nbsp;All</a></td>
			</tr>
			<tr>
				<td><asp:listbox ID="DestinationShop" CssClass="smalltext" Height="100" Width="250" SelectionMode="Multiple" runat="server" /></td>
			</tr>
</table></span></td></tr></table>

<br>
<div id="ShowResults" visible="false" runat="server">
	<asp:DataGrid ID="Results" AutoGenerateColumns="false" CellPadding="3" CssClass="text" HeaderStyle-BackColor="#507093" HeaderStyle-CssClass="smallTdHeader" HeaderStyle-HorizontalAlign="center" AllowPaging="true" OnPageIndexChanged="ChangeGridPage" Width="100%" OnItemDataBound="Results_ItemDataBound" runat="server">
		<columns>
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="No"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="Status"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="Shop"></asp:BoundColumn>   
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="GCode"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="Gname"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="DCode"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="Dname"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="PCode"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="Pname"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="Price"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="Type"></asp:BoundColumn>  
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="Disc"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="VAT"></asp:BoundColumn>
		</columns>
	</asp:DataGrid>


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
Dim RecordPerPage As Integer = 100
		
Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Export_Product") Then
		
		
		Try
			objCnn = getCnn.EstablishConnection()
			
			SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
			
			headerText.InnerHtml = "Export Product Data"
			KeywordText.InnerHtml = "Keywords"
			ShowAllText.InnerHtml = "All Products"
			ProductCodeText.InnerHtml = "Product Codes That Start With"
			SubmitForm.Text = " Submit "
			
			OrderByParam.Items(0).Text = "Order By Product Code"
			OrderByParam.Items(0).Value = "pl.ProductLevelID,pg.ProductGroupName,pd.ProductDeptName,p.ProductCode"
			OrderByParam.Items(1).Text = "Order By Product Name"
			OrderByParam.Items(1).Value = "pl.ProductLevelID,pg.ProductGroupName,pd.ProductDeptName,p.ProductName"

				
			If Not Page.IsPostBack Then
				Radio_1.Checked = True
				Dim DShopData As DataTable = getInfo.GetProductLevel(-9,objCnn)
				DestinationShop.DataSource = DShopData
				DestinationShop.DataValueField = "ProductLevelID"
				DestinationShop.DataTextField = "ProductLevelName"
				DestinationShop.DataBind()
				If DShopData.Rows.Count > 1 Then
					ShowShopList.Visible = True
					ProductLevelID.Value = 0
				Else
					ShowShopList.Visible = False
					If DShopData.Rows.Count = 1 Then
						ProductLevelID.Value = DShopData.Rows(0)("ProductLevelID")
					Else
						ProductLevelID.Value = -1
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

Sub DoSearch(Source As Object, E As EventArgs)
	Results.CurrentPageIndex = 0
	SearchResult(objCnn)
End Sub

    Public Function SearchResult(ByVal objCnn As MySqlConnection) As String
        Dim outputString As String = ""
        Dim i, j, ULID As Integer
        Dim TextClass As String = "smallText"
        Dim bgColor As String = "#eeeeee"
        ShowResults.Visible = True
	
        Dim strNotIncludeProductType As String
	
        Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
	
        Dim KeywordString, SelectedString As String
        Dim StartWithString As String
        If Radio_1.Checked = True Then
            KeywordString = ""
            StartWithString = ""
        ElseIf Radio_2.Checked = True Then
            KeywordString = Keywords.Text
            StartWithString = ""
        Else
            KeywordString = ""
            StartWithString = ProductCodeKey.Text
        End If
	
        Dim ShopIDList As String = "0"
        If ProductLevelID.Value = 0 And DestinationShop.Items.Count > 0 Then
            For i = 0 To DestinationShop.Items.Count - 1
                If DestinationShop.Items(i).Selected = True Then
                    ShopIDList += "," + DestinationShop.Items(i).Value.ToString
                End If
            Next
        End If
        
        If chkNotIncludeComment.Checked = True Then
            strNotIncludeProductType = "14,15,16"
        Else
            strNotIncludeProductType = ""
        End If
                
        Dim dtTable As DataTable = getInfo.ExportProductData(ShopIDList, 0, 0, 0, KeywordString, StartWithString, OrderByParam.SelectedItem.Value, strNotIncludeProductType, objCnn)

        Dim StatusImage As String
	
	
        Dim displayTable As DataTable = New DataTable("Data")
        Dim rNew As DataRow
	
        displayTable.Columns.Add("No", GetType(Integer))
        displayTable.Columns.Add("Status", System.Type.GetType("System.String"))
        displayTable.Columns.Add("Shop", System.Type.GetType("System.String"))
        displayTable.Columns.Add("GCode", System.Type.GetType("System.String"))
        displayTable.Columns.Add("GName", System.Type.GetType("System.String"))
        displayTable.Columns.Add("DCode", System.Type.GetType("System.String"))
        displayTable.Columns.Add("DName", System.Type.GetType("System.String"))
        displayTable.Columns.Add("PCode", System.Type.GetType("System.String"))
        displayTable.Columns.Add("PName", System.Type.GetType("System.String"))
        displayTable.Columns.Add("Price", System.Type.GetType("System.String"))
        displayTable.Columns.Add("Type", System.Type.GetType("System.String"))
        displayTable.Columns.Add("Disc", System.Type.GetType("System.String"))
        displayTable.Columns.Add("VAT", System.Type.GetType("System.String"))
	
        For i = 0 To dtTable.Rows.Count - 1
            rNew = displayTable.NewRow
            rNew("No") = i + 1
            If bgColor = "#eeeeee" Then
                bgColor = "white"
            Else
                bgColor = "#eeeeee"
            End If
		
		
            If dtTable.Rows(i)("ProductActivate") = True Or dtTable.Rows(i)("ProductActivate") = 1 Then
                StatusImage = "../images/checkbl.gif"
            Else
                StatusImage = "../images/crossbl.gif"
            End If
            rNew("Status") = "<img src=""" + StatusImage + """ border=""0"">"

            rNew("Shop") = dtTable.Rows(i)("ProductLevelName")
            rNew("GCode") = dtTable.Rows(i)("ProductGroupCode")
            rNew("GName") = dtTable.Rows(i)("ProductGroupName")
            rNew("DCode") = dtTable.Rows(i)("ProductDeptCode")
            rNew("DName") = dtTable.Rows(i)("ProductDeptName")
            rNew("PCode") = dtTable.Rows(i)("ProductCode")
            rNew("PName") = dtTable.Rows(i)("ProductName")
		
            If Not IsDBNull(dtTable.Rows(i)("ProductPrice")) Then
                rNew("Price") = CDbl(dtTable.Rows(i)("ProductPrice")).ToString(FormatObject.CurrencyFormat, ci)
            Else
                rNew("Price") = "-"
            End If
		
            If Not IsDBNull(dtTable.Rows(i)("Description")) Then
                rNew("Type") = dtTable.Rows(i)("Description")
            Else
                rNew("Type") = "-"
            End If
		
            If dtTable.Rows(i)("DiscountAllow") = True Or dtTable.Rows(i)("DiscountAllow") = 1 Then
                rNew("Disc") = "Y"
            Else
                rNew("Disc") = "N"
            End If
		
		
            If dtTable.Rows(i)("VATType") = 2 Then
                rNew("VAT") = "E"
            ElseIf dtTable.Rows(i)("VATType") = 1 Then
                rNew("VAT") = "V"
            Else
                rNew("VAT") = "N"
            End If
		
            displayTable.Rows.Add(rNew)

        Next
	
        Results.PageSize = RecordPerPage
        Results.PagerStyle.Mode = PagerMode.NumericPages
        Results.DataSource = displayTable
        Results.DataBind()
	
	
    End Function

    Sub ExportToExcel(Source As Object, E As EventArgs)
        Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
        Dim ci As New CultureInfo(FormatObject.CultureString)
        Dim KeywordString, StartWithString As String
        Dim strNotIncludeProductType As String
        
        If Radio_1.Checked = True Then
            KeywordString = ""
            StartWithString = ""
        ElseIf Radio_2.Checked = True Then
            KeywordString = Keywords.Text
            StartWithString = ""
        Else
            KeywordString = ""
            StartWithString = ProductCodeKey.Text
        End If
        Dim ShopIDList As String = "0"
        Dim i As Integer
        If ProductLevelID.Value = 0 And DestinationShop.Items.Count > 0 Then
            For i = 0 To DestinationShop.Items.Count - 1
                If DestinationShop.Items(i).Selected = True Then
                    ShopIDList += "," + DestinationShop.Items(i).Value.ToString
                End If
            Next
        End If
        If chkNotIncludeComment.Checked = True Then
            strNotIncludeProductType = "14,15,16"
        Else
            strNotIncludeProductType = ""
        End If
        Dim dtTable As DataTable = getInfo.ExportProductData(ShopIDList, 0, 0, 0, KeywordString, StartWithString, OrderByParam.SelectedItem.Value, strNotIncludeProductType, objCnn)

        Dim filename As String = "ProductData.csv"
	
        Response.Clear()
        Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader("Content-Disposition", "attachment; filename=""" & filename & """")
        Response.Charset = "windows-874"
        Response.ContentEncoding = System.Text.Encoding.GetEncoding(874)
        Response.Flush()
        Response.Write("ShopName,ProductGroupCode,ProductGroupName,ProductDeptCode,ProductDeptName,ProductCode,ProductName,ProductPrice,ProductType,VAT,Discount Allow,Activation,Insert Date,Last Update,ShopID,ProductGroupID,ProductDeptID,ProductID" + Chr(13) & Chr(10))
	
        For i = 0 To dtTable.Rows.Count - 1
            Response.Write("""" + Replace(dtTable.Rows(i)("ProductLevelName"), """", """""") + """,""" + Replace(dtTable.Rows(i)("ProductGroupCode"), """", """""") + """,""" + Replace(dtTable.Rows(i)("ProductGroupName"), """", """""") + """,""" + Replace(dtTable.Rows(i)("ProductDeptCode"), """", """""") + """,""" + Replace(dtTable.Rows(i)("ProductDeptName"), """", """""") + """,""" + Replace(dtTable.Rows(i)("ProductCode"), """", """""") + """,""" + Replace(dtTable.Rows(i)("ProductName"), """", """""") + """")
		
            'If Not IsDBNull(dtTable.Rows(i)("ProductCost")) Then
            'Response.Write(",""" + dtTable.Rows(i)("ProductCost").ToString + """")
            'Else
            'Response.Write(",""""")
            'End If
		
            If Not IsDBNull(dtTable.Rows(i)("ProductPrice")) Then
                Response.Write(",""" + dtTable.Rows(i)("ProductPrice").ToString + """")
            Else
                Response.Write(",""""")
            End If
		
            Response.Write(",""" + Replace(dtTable.Rows(i)("Description"), """", """""") + """")
		
            If dtTable.Rows(i)("VATType") = 2 Then
                Response.Write(",""E""")
            ElseIf dtTable.Rows(i)("VATType") = 1 Then
                Response.Write(",""V""")
            Else
                Response.Write(",""N""")
            End If
		
            Response.Write(",""" + dtTable.Rows(i)("DiscountAllow").ToString + """")
		
            Response.Write(",""" + dtTable.Rows(i)("ProductActivate").ToString + """")
		
            Response.Write(",""" + dtTable.Rows(i)("InsertDate") + """")
            Response.Write(",""" + dtTable.Rows(i)("UpdateDate") + """")
		
            Response.Write(",""" + dtTable.Rows(i)("ProductLevelID").ToString + """")
            Response.Write(",""" + dtTable.Rows(i)("ProductGroupID").ToString + """")
            Response.Write(",""" + dtTable.Rows(i)("ProductDeptID").ToString + """")
            Response.Write(",""" + dtTable.Rows(i)("ProductID").ToString + """")
		
            Response.Write(Chr(13) & Chr(10))
        Next
        Response.End()
    End Sub

Private Sub Results_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) 
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(11,Session("LangID"),objCnn)
	
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	If e.Item.ItemType = ListItemType.Header Then
		e.Item.Cells(0).Text = "#"
		e.Item.Cells(1).Text = ""
		e.Item.Cells(2).Text = "Shop"
		e.Item.Cells(3).Text = "Group Code"
		e.Item.Cells(4).Text = "Group Name"
		e.Item.Cells(5).Text = "Dept Code"
		e.Item.Cells(6).Text = "Dept Name"
		e.Item.Cells(7).Text = "Product Code"
		e.Item.Cells(8).Text = "Product Name"
		e.Item.Cells(9).Text = "Price"
		e.Item.Cells(10).Text = "Type"
		e.Item.Cells(11).Text = "Disc"
		e.Item.Cells(12).Text = "VAT"
	End If
End Sub

Sub ChangeGridPage(objSender As Object, objArgs As DataGridPageChangedEventArgs)


   'update the current page number from the parameter values
   Results.CurrentPageIndex = objArgs.NewPageIndex

   SearchResult(objCnn)
	
End Sub


Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
