<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSDBFront" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="CostingClass.pRoMiSeCosting" %>
<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Set Material Cost</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<form id="mainForm" runat="server">
<input type="hidden" id="MaterialID" runat="server">
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
		<td><asp:DropDownList ID="MaterialCostGroupID" CssClass="text" Visible="true" AutoPostBack="false" runat="server" /></td>
		<td><asp:button ID="SubmitForm" Font-Size="8" Height="20" Width="80" OnClick="DoSearch" runat="server" /></td>
		<td><asp:DropDownList ID="OrderByParam" CssClass="text" SelectionMode="Single" runat="server">
				<asp:listitem></asp:listitem>
				<asp:listitem></asp:listitem>
			</asp:DropDownList>
		</td>
		<td><asp:Button ID="ExportExcel" OnClick="ExportToExcel" Height="20" Font-Size="8" Width="120" Text="Export to Excel" runat="server"></asp:Button></td>
	</tr>
	<tr id="showtext" runat="server">
		<td colspan="10" class="boldText">Please add material cost group data before adding cost table</td>
	</tr>
</table>

<br>
<div id="ShowResults" visible="false" runat="server">

<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
	<tr>
		<td colspan="7" align="right" class="text">Update Cost for <asp:DropDownList ID="MaterialCostGroupIDUpdate" CssClass="text" Visible="true" AutoPostBack="false" runat="server" />
                &nbsp;<asp:button ID="cmdImportMaterialCost" Font-Size="8" Height="20" Width="120" OnClick="ImportMaterialCost" runat="server" />
                &nbsp;<asp:button ID="SubmitChange1" Font-Size="8" Height="20" Width="120" OnClick="DoChange" runat="server" /></td>
	</tr>
    <tr>
        <td colspan="7" class="text">
            <asp:DropDownList ID="cboMaterialGroup" CssClass="text" AutoPostBack="true" Visible="true" runat="server" OnSelectedIndexChanged="SelMaterialDeptData"  />
            <asp:DropDownList ID="cboMatrialDept" CssClass="text" Visible="true" AutoPostBack="true" runat="server" OnSelectedIndexChanged="SelMaterialCostData"   />
        </td>
    </tr>
	<tr>       
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="Text6" runat="server"></div></td>
		<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="Text7" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="Text5" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>
	<tr>
		<td colspan="7" align="right"><asp:button ID="SubmitChange2" Font-Size="8" Height="20" Width="120" OnClick="DoChange" runat="server" /></td>
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
Dim CostInfo As New CostClass()
Dim objDB As New CDBUtil()
		
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Set_Material_Cost") Then
		
            headerTD1.BgColor = GlobalParam.AdminBGColor
            headerTD2.BgColor = GlobalParam.AdminBGColor
            headerTD3.BgColor = GlobalParam.AdminBGColor
            headerTD4.BgColor = GlobalParam.AdminBGColor
            headerTD5.BgColor = GlobalParam.AdminBGColor
            headerTD6.BgColor = GlobalParam.AdminBGColor
            headerTD7.BgColor = GlobalParam.AdminBGColor
		
            Try
                objCnn = getCnn.EstablishConnection()
			
                SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
                SubmitChange1.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitChange1).ToString
                SubmitChange2.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitChange2).ToString
			
                HeaderText.InnerHtml = "Set Material Cost Data"
                KeywordText.InnerHtml = "Keywords"
                ShowAllText.InnerHtml = "Display All"
                SubmitForm.Text = " Submit "
                SubmitChange1.Text = " Submit Changes "
                SubmitChange2.Text = " Submit Changes "
                cmdImportMaterialCost.Text = "Import Data"
                
                OrderByParam.Items(0).Text = "Order By Material Code"
                OrderByParam.Items(0).Value = "a.MaterialCode"
                OrderByParam.Items(1).Text = "Order By Material Name"
                OrderByParam.Items(1).Value = "a.MaterialName"
			
                Text2.InnerHtml = "Material Code"
                Text3.InnerHtml = "Material Name"
                Text6.InnerHtml = "Material Cost"
                Text4.InnerHtml = "Set Material Cost"
                Text5.InnerHtml = "Unit"
                Text7.InnerHtml = "Unit"
                showtext.Visible = False
                If Not Page.IsPostBack Then
                    Radio_1.Checked = True
                End If
			                
                Dim getData As DataTable = CostInfo.MaterialCostGroup(0, objCnn)
                If getData.Rows.Count = 0 Then
                    SubmitForm.Enabled = False
                    ExportExcel.Enabled = False
                    showtext.Visible = True
                End If
			
			
                If Not Page.IsPostBack Then
                    MaterialCostGroupID.DataSource = getData
                    MaterialCostGroupID.DataValueField = "MaterialCostGroupID"
                    MaterialCostGroupID.DataTextField = "DateRangeString"
                    MaterialCostGroupID.DataBind()
				
                    MaterialCostGroupIDUpdate.DataSource = getData
                    MaterialCostGroupIDUpdate.DataValueField = "MaterialCostGroupID"
                    MaterialCostGroupIDUpdate.DataTextField = "DateRangeString"
                    MaterialCostGroupIDUpdate.DataBind()
                    
                    ShowMaterialGroupData()
                    ShowMaterialDeptData()
                    
                    'Go To Select Material Cost Group
                    If Not IsDBNull(Request("MaterialCostGroupID")) Then
                        Dim i, costGroupID As Integer
                        Dim bolFound As Boolean
                        costGroupID = Request("MaterialCostGroupID")
                        If costGroupID > 0 Then
                            bolFound = False
                            For i = 0 To MaterialCostGroupID.Items.Count - 1
                                If MaterialCostGroupID.Items(i).Value = costGroupID Then
                                    MaterialCostGroupID.SelectedIndex = i
                                    bolFound = True
                                    Exit For
                                End If
                            Next i
                            If bolFound = True Then
                                SearchMaterialCostTable()
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
        CostInfo.UpdateMaterialCost(Request, objCnn)
	
        Dim getData As DataTable = CostInfo.MaterialCostGroup(0, objCnn)
        MaterialCostGroupID.DataSource = getData
        MaterialCostGroupID.DataValueField = "MaterialCostGroupID"
        MaterialCostGroupID.DataTextField = "DateRangeString"
        MaterialCostGroupID.DataBind()
        Dim i As Integer
        For i = 0 To getData.Rows.Count - 1
            If getData.Rows(i)("MaterialCostGroupID") = MaterialCostGroupIDUpdate.SelectedItem.Value Then
                MaterialCostGroupID.Items(i).Selected = True
            End If
        Next
        SearchResult(objCnn)
    End Sub

    Sub DoSearch(Source As Object, E As EventArgs)
        SearchMaterialCostTable()
    End Sub

    Sub SearchMaterialCostTable()
        Dim getData As DataTable = CostInfo.MaterialCostGroup(0, objCnn)
        MaterialCostGroupIDUpdate.DataSource = getData
        MaterialCostGroupIDUpdate.DataValueField = "MaterialCostGroupID"
        MaterialCostGroupIDUpdate.DataTextField = "DateRangeString"
        MaterialCostGroupIDUpdate.DataBind()

        Dim i As Integer
        For i = 0 To getData.Rows.Count - 1
            If getData.Rows(i)("MaterialCostGroupID") = MaterialCostGroupID.SelectedItem.Value Then
                MaterialCostGroupIDUpdate.Items(i).Selected = True
            End If
        Next
        SearchResult(objCnn)
    End Sub
    
    Public Function SearchResult(ByVal objCnn As MySqlConnection) As String
        Dim outputString As StringBuilder = New StringBuilder
        Dim i, j, ULID As Integer
        Dim TextClass As String = "smallText"
        Dim bgColor As String = "#eeeeee"
        
        ShowResults.Visible = True
	
        Dim MaterialCostValue, UnitSelText, MaterialCostDisplay As String
        Dim unitTable As DataTable
        Dim selGroupID, selDeptID As Integer
        Dim KeywordString, SelectedString As String

        If Radio_1.Checked = True Then
            KeywordString = ""
        Else
            KeywordString = Keywords.Text
        End If
        selGroupID = cboMaterialGroup.SelectedItem.Value
        selDeptID = cboMatrialDept.SelectedItem.Value
        Dim dtTable As DataTable = CostInfo.SetMaterialCost(MaterialCostGroupID.SelectedItem.Value, selGroupID, selDeptID, 0, KeywordString, OrderByParam.SelectedItem.Value, objCnn)
	
        For i = 0 To dtTable.Rows.Count - 1
            If bgColor = "#eeeeee" Then
                bgColor = "white"
            Else
                bgColor = "#eeeeee"
            End If
            outputString = outputString.Append("<tr bgColor=""" + bgColor + """>")

            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & (i + 1).ToString & ")</td>")

            If Not IsDBNull(dtTable.Rows(i)("MaterialCode")) Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("MaterialCode") & "</td>")
            Else
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
            End If
		
            If Not IsDBNull(dtTable.Rows(i)("MaterialName")) Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("MaterialName") & "</td>")
            Else
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
            End If
		
            If Not IsDBNull(dtTable.Rows(i)("MaterialPrice")) Then
                MaterialCostValue = Format(dtTable.Rows(i)("MaterialPrice"), "####0.####")
                MaterialCostDisplay = Format(dtTable.Rows(i)("MaterialPrice"), "##,##0.####")
            Else
                MaterialCostValue = ""
                MaterialCostDisplay = "-"
            End If
		
            outputString = outputString.Append("<td align=""right"" class=""" + TextClass + """>" & MaterialCostDisplay & "</td>")
		
            If Not IsDBNull(dtTable.Rows(i)("UnitLargeName")) Then
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & dtTable.Rows(i)("UnitLargeName") & "</td>")
            Else
                outputString = outputString.Append("<td align=""left"" class=""" + TextClass + """>" & "-" & "</td>")
            End If
		
            If Not IsDBNull(dtTable.Rows(i)("SelectUnitLargeID")) Then
                ULID = dtTable.Rows(i)("SelectUnitLargeID")
            Else
                ULID = 0
            End If
		
            outputString = outputString.Append("<td><input type=""text"" name=""MaterialID:" + dtTable.Rows(i)("MaterialID").ToString + """ value=""" + MaterialCostValue + """ style=""font-size:10px;line-height:12px;text-align:right;width:100px""></td>")
		
            unitTable = getInfo.GetUnitInfo(2, dtTable.Rows(i)("UnitSmallID"), "", objCnn)
            UnitSelText = "<select name=""MaterialUnit:" + dtTable.Rows(i)("MaterialID").ToString + """ style=""font-size:10px;line-height:12px;width:120px"">"
            For j = 0 To unitTable.Rows.Count - 1
                If ULID = unitTable.Rows(j)("UnitLargeID") Then
                    SelectedString = "selected"
                Else
                    SelectedString = ""
                End If
                UnitSelText += "<option value=""" + unitTable.Rows(j)("UnitLargeID").ToString + """ " + SelectedString + ">" + unitTable.Rows(j)("UnitLargeName")
            Next
            UnitSelText += "</select>"
            outputString = outputString.Append("<td>" + UnitSelText + "</td>")
		
            outputString = outputString.Append("</tr>")

        Next
        ResultText.InnerHtml = outputString.ToString
    End Function

    Sub ExportToExcel(Source As Object, E As EventArgs)
        Dim KeywordString As String
        Dim selGroupID, selDeptID As Integer
        If Radio_1.Checked = True Then
            KeywordString = ""
        Else
            KeywordString = Keywords.Text
        End If
        
        selGroupID = cboMaterialGroup.SelectedItem.Value
        selDeptID = cboMatrialDept.SelectedItem.Value
        
        Dim dtTable As DataTable = CostInfo.SetMaterialCost(MaterialCostGroupID.SelectedItem.Value, selGroupID, selDeptID, 0, KeywordString, OrderByParam.SelectedItem.Value, objCnn)
        Dim i As Integer
        Dim filename As String = "MaterialData.csv"
	
        Response.Clear()
        Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader("Content-Disposition", "attachment; filename=""" & filename & """")
        Response.Charset = "windows-874"
        Response.ContentEncoding = System.Text.Encoding.GetEncoding(874)
        Response.Flush()
        Response.Write("MaterailGroupCode,MaterialGroupName,MaterialDeptCode,MaterialDeptName,MaterialCode,MaterialName,TaxType,MaterialCost,MaterailUnit" + Chr(13) & Chr(10))
	
        For i = 0 To dtTable.Rows.Count - 1
            Response.Write("""" + Replace(dtTable.Rows(i)("MaterialGroupCode"), """", """""") + """,""" + Replace(dtTable.Rows(i)("MaterialGroupName"), """", """""") + """,""" + Replace(dtTable.Rows(i)("MaterialDeptCode"), """", """""") + """,""" + Replace(dtTable.Rows(i)("MaterialDeptName"), """", """""") + """,""" + Replace(dtTable.Rows(i)("MaterialCode"), """", """""") + """,""" + Replace(dtTable.Rows(i)("MaterialName"), """", """""") + """")
            If dtTable.Rows(i)("MaterialTaxType") = 2 Then
                Response.Write(",""V""")
            ElseIf dtTable.Rows(i)("MaterialTaxType") = 1 Then
                Response.Write(",""E""")
            Else
                Response.Write(",""N""")
            End If
            If Not IsDBNull(dtTable.Rows(i)("MaterialPrice")) Then
                Response.Write(",""" + dtTable.Rows(i)("MaterialPrice").ToString + """")
            Else
                Response.Write(",""-""")
            End If
            If Not IsDBNull(dtTable.Rows(i)("UnitLargeName")) Then
                Response.Write(",""" + dtTable.Rows(i)("UnitLargeName") + """")
            Else
                Response.Write(",""-""")
            End If
            Response.Write(Chr(13) & Chr(10))
        Next
        Response.End()
    End Sub
	
    Sub ShowMaterialGroupData()
        Dim i As Integer
        Dim dtMaterialGroup As DataTable = New DataTable("MaterialGroupData")
        Dim rNew As DataRow
        Dim dtData As DataTable
        
        dtMaterialGroup.Columns.Add("MaterialGroupName", GetType(String))
        dtMaterialGroup.Columns.Add("MaterialGroupID", GetType(Integer))
        dtData = CostInfo.ListMaterialGroup(objCnn)
        
        rNew = dtMaterialGroup.NewRow()
        rNew("MaterialGroupName") = "---- All ----"
        rNew("MaterialGroupID") = 0
        dtMaterialGroup.Rows.Add(rNew)
        
        For i = 0 To dtData.Rows.Count - 1
            rNew = dtMaterialGroup.NewRow()
            rNew("MaterialGroupName") = dtData.Rows(i)("MaterialGroupCode") & " : " & dtData.Rows(i)("MaterialGroupName")
            rNew("MaterialGroupID") = dtData.Rows(i)("MaterialGroupID")
            dtMaterialGroup.Rows.Add(rNew)
        Next i
	
        cboMaterialGroup.DataSource = dtMaterialGroup
        cboMaterialGroup.DataValueField = "MaterialGroupID"
        cboMaterialGroup.DataTextField = "MaterialGroupName"
        cboMaterialGroup.DataBind()
        
        cboMaterialGroup.SelectedIndex = 0
    End Sub
    
    Sub SelMaterialDeptData(sender As Object, e As System.EventArgs)
        ShowMaterialDeptData()
        SearchResult(objCnn)
    End Sub
	
    Sub ShowMaterialDeptData()
        Dim i As Integer
        Dim selGroupID As Integer
        Dim dtMaterialDept As DataTable = New DataTable("MaterialDeptData")
        Dim rNew As DataRow
        Dim dtData As DataTable
        
        If cboMaterialGroup.Items.Count = 0 Then
            selGroupID = 0
        Else
            selGroupID = cboMaterialGroup.SelectedItem.Value
        End If
        
        dtMaterialDept.Columns.Add("MaterialDeptName", GetType(String))
        dtMaterialDept.Columns.Add("MaterialDeptID", GetType(Integer))
        dtData = CostInfo.ListMaterialDept(objCnn, selGroupID)
        
        rNew = dtMaterialDept.NewRow()
        rNew("MaterialDeptName") = "---- All ----"
        rNew("MaterialDeptID") = 0
        dtMaterialDept.Rows.Add(rNew)
        
        For i = 0 To dtData.Rows.Count - 1
            rNew = dtMaterialDept.NewRow()
            rNew("MaterialDeptName") = dtData.Rows(i)("MaterialDeptCode") & " : " & dtData.Rows(i)("MaterialDeptName")
            rNew("MaterialDeptID") = dtData.Rows(i)("MaterialDeptID")
            dtMaterialDept.Rows.Add(rNew)
        Next i
	
        cboMatrialDept.DataSource = dtMaterialDept
        cboMatrialDept.DataValueField = "MaterialDeptID"
        cboMatrialDept.DataTextField = "MaterialDeptName"
        cboMatrialDept.DataBind()
                       
        cboMatrialDept.SelectedIndex = 0
    End Sub
          
    Sub SelMaterialCostData(sender As Object, e As System.EventArgs)
        SearchResult(objCnn)
    End Sub
    
    Sub ImportMaterialCost(ByVal Source As Object, ByVal E As EventArgs)
        Response.Redirect("ImportMaterialProductCostTableData.aspx?ImportType=0&CostGroupID=" & MaterialCostGroupIDUpdate.SelectedValue)
    End Sub

    
    
    Sub Page_UnLoad()
        objCnn.Close()
    End Sub
</script>

</body>
</html>
