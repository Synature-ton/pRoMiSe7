<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<html>
<head>
<title>Product Component</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">
<form id="mainForm" runat="server">
<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<input type="hidden" id="PGroupID" runat="server" />
<table cellpadding="2" cellspacing="2" width="100%">
<tr>
<td align="left"><div class="headerText" align="left" id="Text_SectionParam" runat="server" /></td>
</tr>
<tr><td><hr size="0"></td></tr>
</table>
<table width="<% = GlobalParam.AdminTableWidth %>">
<tr id="xxx" visible="false" runat="server">
<td width="50%"><a href="../Promotions/promotion_price_edit.aspx"><div id="Text_AddParam" runat="server"></div></a></td>
<td width="50%" align="right"><div id="GoBackText" runat="server"></div></td>
</tr></table>

<table> 
	<div id="ValidateError" runat="Server"></div>
	<tr>
    	<td class="text">Group No:</td>
        <td class="text"><asp:textbox ID="SetGroupNo" CssClass="text" Width="50" runat="server" /></td>
        <td class="text">Group Name:</td>
        <td class="text"><asp:textbox ID="SetGroupName" CssClass="text" Width="200" MaxLength="50" runat="server" /></td>
        <td class="text">No of Products in Group</td>
        <td class="text"><asp:textbox ID="RequireAddAmountForProduct" CssClass="text" Width="50" runat="server" /></td>
        <td class="text"><asp:button ID="SubmitForm" OnClick="DoAddUpdate" runat="server" />&nbsp;<asp:button ID="CancelButton" Text=" Cancel " OnClick="DoCancel" Visible="false" runat="server" /></td>
    </tr>
</table>

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="<% = GlobalParam.AdminTableWidth %>">
	<tr>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="NameParam" runat="server"></div></td>
        <td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="GroupNameParam" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="StartDateParam" runat="server"></div></td>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="EndDateParam" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="AddComponentText" runat="server"></div></td>
		<td id="headerTD3" visible="true" align="center" class="tdHeader" runat="server"><div id="Default_EditText" runat="server"></div></td>
		<td id="headerTD4" visible="false" align="center" class="tdHeader" runat="server"><div id="Default_DelText" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>

</table>
</form>


<div id="errorMsg" class="errorText" runat="server" />

<script language="VB" runat="server">
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getInfo As New CCategory()
Dim getPageText As New DefaultText()
Dim DateTimeUtil As New MyDateTime()
Dim objDB As New CDBUtil()

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Inv_Product_Category") Then
		
            'Dim InvC As CultureInfo = CultureInfo.InvariantCulture
            'Dim BeforeToday As Date
            'BeforeToday = DateAdd(DateInterval.Day, -1, Now())
            'Dim BeforeTodayString As String = DateTimeUtil.FormatDate(Day(BeforeToday), Month(BeforeToday), BeforeToday.ToString("yyyy", InvC))
            'errorMsg.InnerHtml = BeforeTodayString
		
            headerTD1.BgColor = GlobalParam.AdminBGColor
            headerTD2.BgColor = GlobalParam.AdminBGColor
            headerTD3.BgColor = GlobalParam.AdminBGColor
            headerTD4.BgColor = GlobalParam.AdminBGColor
            headerTD5.BgColor = GlobalParam.AdminBGColor
            headerTD6.BgColor = GlobalParam.AdminBGColor
            headerTD7.BgColor = GlobalParam.AdminBGColor
			
            Try
                objCnn = getCnn.EstablishConnection()
			
                Dim dtTable As New DataTable()
                dtTable = getInfo.GetProductInfo(0, Request.QueryString("ProductID"), objCnn)
			
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(8, Session("LangID"), objCnn)
			
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
                'GoBackText.InnerHtml = "<a href=""product_category.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") +  "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + """>" + textTable.Rows(12)("TextParamValue") + "</a>"
                'GoBackText.InnerHtml = "<a href=""product_category.aspx?" + Request.QueryString.ToString  + """>" + textTable.Rows(12)("TextParamValue") + "</a>"
                GoBackText.InnerHtml = "<a href=""javascript: window.close()"">Close Window</a>"
                Text_AddParam.InnerHtml = "<a href=""pcomponent_group.aspx?EditID=3&AddComp=yes&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + """ onclick=""javascript: return confirm('" + textTable.Rows(56)("TextParamValue") + "')"">" + textTable.Rows(55)("TextParamValue") + "</a>"
                Text_AddParam.Visible = False

                If Not Page.IsPostBack And Request.QueryString("action") = "delete" And IsNumeric(Request.QueryString("ProductID")) And IsNumeric(Request.QueryString("PGroupID")) Then
                    'Delete PComponentGroup and ProductComponent In All SaleMode
                    Dim ResultDelComp As String = getInfo.DelComponentGroup(Request.QueryString("ProductID"), Request.QueryString("PGroupID"), 0, objCnn)
                    If ResultDelComp = "Success" Then
                        getInfo.UpdateProductDate(Request.QueryString("ProductID"), objCnn)
                        Response.Redirect("pcomponent_group.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") & _
                                       "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") & _
                                       "&ProductID=" + Request.QueryString("ProductID"))
                    Else
                        errorMsg.InnerHtml = ResultDelComp
                    End If
                End If
                CancelButton.Visible = False
                SubmitForm.Text = " Add "
                If Not Page.IsPostBack Then
                    PGroupID.Value = 0
                    If IsNumeric(Request.QueryString("PGroupID")) And Request.QueryString("action") = "edit" Then
                        PGroupID.Value = Request.QueryString("PGroupID")
                        Dim getP As DataTable = getInfo.GetComponentGroup(Request.QueryString("ProductID"), Request.QueryString("PGroupID"), objCnn)
                        If getP.Rows.Count > 0 Then
                            SetGroupNo.Text = getP.Rows(0)("SetGroupNo")
                            RequireAddAmountForProduct.Text = getP.Rows(0)("RequireAddAmountForProduct")
                            If Not IsDBNull(getP.Rows(0)("SetGroupName")) Then
                                SetGroupName.Text = getP.Rows(0)("SetGroupName")
                            Else
                                SetGroupName.Text = ""
                            End If
                            SubmitForm.Text = " Update "
                            CancelButton.Visible = True
                        End If
                    End If
                End If
			
                GroupNameParam.InnerHtml = "Group Name"
                NameParam.InnerHtml = "Group No"
                StartDateParam.InnerHtml = "# of Products" 'textTable.Rows(50)("TextParamValue")
                EndDateParam.InnerHtml = textTable.Rows(51)("TextParamValue")
                AddComponentText.InnerHtml = textTable.Rows(53)("TextParamValue")
                Default_EditText.InnerHtml = defaultTextTable.Rows(0)("TextParamValue")
                Default_DelText.InnerHtml = defaultTextTable.Rows(1)("TextParamValue")
			
                headerTD1.Visible = False
			
                Dim i, counter As Integer
                Dim outputString As String = ""
                Dim StartDateString, EndDateString As String

                If dtTable.Rows.Count > 0 Then
				
                    Text_SectionParam.InnerHtml = textTable.Rows(0)("TextParamValue") + dtTable.Rows(0)("ProductName")
                    Dim PGroupData As New DataTable()
                    PGroupData = getInfo.GetComponentGroup(dtTable.Rows(0)("ProductID"), 0, objCnn)
				
                    If PGroupData.Rows.Count = 0 Then
                        Dim StringResult As String = getInfo.AddFirstComponentGroup(dtTable.Rows(0)("ProductID"), objCnn)
                        PGroupData = getInfo.GetComponentGroup(dtTable.Rows(0)("ProductID"), 0, objCnn)
                    End If
				
                    For i = 0 To PGroupData.Rows.Count - 1
                        counter = i + 1
                        outputString += "<tr><td class=""text"" align=""center"">" & PGroupData.Rows(i)("SetGroupNo").ToString & "</td>"
                        If Not IsDBNull(PGroupData.Rows(i)("SetGroupName")) Then
                            outputString += "<td class=""text"" align=""left"">" & PGroupData.Rows(i)("SetGroupName").ToString & "</td>"
                        Else
                            outputString += "<td class=""text"" align=""left"">" & "" & "</td>"
                        End If
                        If Not IsDBNull(PGroupData.Rows(i)("StartDate")) Then
                            StartDateString = DateTimeUtil.FormatDateTime(PGroupData.Rows(i)("StartDate"), "DateOnly")
                            StartDateString += " " + "<a href=""pcomponent_date.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&PGroupID=" + PGroupData.Rows(i)("PGroupID").ToString + """>" + textTable.Rows(58)("TextParamValue") + "</a>"
                        Else
                            StartDateString = "-"
                        End If
                        If Not IsDBNull(PGroupData.Rows(i)("EndDate")) Then
                            EndDateString = DateTimeUtil.FormatDateTime(PGroupData.Rows(i)("EndDate"), "DateOnly")
                        Else
                            getCnn.sqlExecute("UPDATE PComponentGroup SET EndDate=NULL WHERE PGroupID=" + PGroupData.Rows(i)("PGroupID").ToString, objCnn)
                            EndDateString = textTable.Rows(49)("TextParamValue")
                        End If
                        outputString += "<td align=""center"" class=""text"">" + PGroupData.Rows(i)("RequireAddAmountForProduct").ToString + "</td>"
                        'outputString += "<td align=""center"" class=""text"">" + EndDateString + "</td>"
                        If dtTable.Rows(0)("ProductSet") = 0 Or dtTable.Rows(0)("ProductSet") = 3 Or dtTable.Rows(0)("ProductSet") = 9 Or dtTable.Rows(0)("ProductSet") = 10 Or dtTable.Rows(0)("ProductSet") = 11 Or dtTable.Rows(0)("ProductSet") = 12 Or dtTable.Rows(0)("ProductSet") = 14 Or dtTable.Rows(0)("ProductSet") = 15 Or dtTable.Rows(0)("ProductSet") = 5 Then
                            outputString += "<td align=""center"" class=""text""><a href=""product_component.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&PGroupID=" + PGroupData.Rows(i)("PGroupID").ToString + """>" + textTable.Rows(53)("TextParamValue") + "</a>"
                            Dim MonthString, YearString As String
                            If IsNumeric(Request.QueryString("SelMonth")) Then
                                MonthString = Request.QueryString("SelMonth").ToString
                            Else
                                MonthString = DateTime.Now.Month.ToString
                            End If
                            If IsNumeric(Request.QueryString("SelYear")) Then
                                YearString = Request.QueryString("SelYear").ToString
                            Else
                                YearString = DateTime.Now.Year.ToString
                            End If
                            Response.Redirect("product_component.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&PGroupID=" + PGroupData.Rows(i)("PGroupID").ToString + "&PMonthYearDate_Month=" + MonthString + "&PMonthYearDate_Year=" + YearString)
                        ElseIf dtTable.Rows(0)("ProductSet") = 19 Then
                            Response.Redirect("productupsize_component.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&PGroupID=" + PGroupData.Rows(i)("PGroupID").ToString)
                        ElseIf dtTable.Rows(0)("ProductSet") <> 7 Then
                            outputString += "<td align=""center"" class=""text""><a href=""productset_component.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&PGroupID=" + PGroupData.Rows(i)("PGroupID").ToString + """>" + textTable.Rows(53)("TextParamValue") + "</a>"
                            Response.Redirect("productset_component.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&PGroupID=" + PGroupData.Rows(i)("PGroupID").ToString)
                        Else
                            'ProductSet 7 ---> SetGroupNo = - 1 is Material/ >= 0 is Product
                            If PGroupData.Rows(i)("SetGroupNo") = -1 Then
                                Dim MonthString, YearString As String
                                If IsNumeric(Request.QueryString("SelMonth")) Then
                                    MonthString = Request.QueryString("SelMonth").ToString
                                Else
                                    MonthString = DateTime.Now.Month.ToString
                                End If
                                If IsNumeric(Request.QueryString("SelYear")) Then
                                    YearString = Request.QueryString("SelYear").ToString
                                Else
                                    YearString = DateTime.Now.Year.ToString
                                End If
                                outputString += "<td align=""center"" class=""text""><a href=""product_component.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&PGroupID=" + PGroupData.Rows(i)("PGroupID").ToString + "&PMonthYearDate_Month=" + MonthString + "&PMonthYearDate_Year=" + YearString + """>" + textTable.Rows(53)("TextParamValue") + "</a>"
                            Else
                                outputString += "<td align=""center"" class=""text""><a href=""productset_component.aspx?EditID=3&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") + "&PGroupID=" + PGroupData.Rows(i)("PGroupID").ToString + """>" + textTable.Rows(53)("TextParamValue") + "</a>"
                            End If
                        End If
					
					
                        outputString += "<td align=""center"" class=""text""><a href=""pcomponent_group.aspx?action=edit&ProductGroupID=" + Request.QueryString("ProductGroupID").ToString + "&ProductLevelID=" + Request.QueryString("ProductLevelID").ToString + "&ProductDeptID=" + Request.QueryString("ProductDeptID").ToString + "&ProductID=" + Request.QueryString("ProductID").ToString + "&PGroupID=" + PGroupData.Rows(i)("PGroupID").ToString + """>" & defaultTextTable.Rows(0)("TextParamValue") & "</a></td>"
                        If PGroupData.Rows.Count >= 1 Then
                            headerTD4.Visible = True
                            outputString += "<td align=""center"" class=""text""><a href=""pcomponent_group.aspx?action=delete&PGroupID=" & PGroupData.Rows(i)("PGroupID").ToString & "&ProductGroupID=" + Request.QueryString("ProductGroupID") + "&ProductLevelID=" + Request.QueryString("ProductLevelID") + "&ProductDeptID=" + Request.QueryString("ProductDeptID") + "&ProductID=" + Request.QueryString("ProductID") & _
                                    """ onClick=""javascript: return confirm('" & defaultTextTable.Rows(14)("TextParamValue") & " " & " Group No " & " " & PGroupData.Rows(i)("SetGroupNo") & _
                                    " " & defaultTextTable.Rows(15)("TextParamValue") & "')"">" & defaultTextTable.Rows(1)("TextParamValue") & "</a></td>"
                        End If
	
                        outputString += "</tr>"
                    Next
                    ResultText.InnerHtml = outputString
                Else
                    updateMessage.Text = "No Data"
                End If
            Catch ex As Exception
                errorMsg.InnerHtml = ex.ToString
            End Try
        Else
            updateMessage.Text = "Access Denied"
        End If
    End Sub

    Sub DoAddUpdate(Source As Object, E As EventArgs)
        Dim FoundError As Boolean = False

        ValidateError.InnerHtml = ""
        If Not IsNumeric(SetGroupNo.Text) Then
            ValidateError.InnerHtml = "<tr><td></td><td class=""errorText"" colspan=""4"">" & "Group No must be integer number" & "</td></tr>"
            FoundError = True
        ElseIf CInt(SetGroupNo.Text) < -1 Then
            ValidateError.InnerHtml = "<tr><td></td><td class=""errorText"" colspan=""4"">" & "Invalid Group No. Value must be >= -1" & "</td></tr>"
            FoundError = True
        ElseIf Not IsNumeric(RequireAddAmountForProduct.Text) Then
            ValidateError.InnerHtml = "<tr><td></td><td class=""errorText"" colspan=""4"">" & "No of Products in Group must be integer number" & "</td></tr>"
            FoundError = True
        ElseIf PGroupID.Value = 0 Then
            Dim ChkGroupNo As DataTable = objDB.List("select * from PComponentGroup WHERE ProductID=" + Request.QueryString("ProductID").ToString & _
                                                " AND SetGroupNo=" + SetGroupNo.Text, objCnn)
            If ChkGroupNo.Rows.Count > 0 Then
                ValidateError.InnerHtml = "<tr><td></td><td class=""errorText"" colspan=""4"">" & "Group No you have entered already exists." & "</td></tr>"
                FoundError = True
            End If
        End If
        If FoundError = False Then
            getInfo.AddComponentGroup(PGroupID.Value, Request.QueryString("ProductID"), 1, SetGroupNo.Text, SetGroupName.Text, _
                                   RequireAddAmountForProduct.Text, objCnn)
            getInfo.UpdateProductDate(Request.QueryString("ProductID"), objCnn)
            Response.Redirect("pcomponent_group.aspx?ProductGroupID=" + Request.QueryString("ProductGroupID").ToString & _
                              "&ProductLevelID=" + Request.QueryString("ProductLevelID").ToString + "&ProductDeptID=" + Request.QueryString("ProductDeptID").ToString & _
                              "&ProductID=" + Request.QueryString("ProductID").ToString)
        End If
	
    End Sub

Sub DoCancel(Source As Object, E As EventArgs)
	Response.Redirect("pcomponent_group.aspx?ProductGroupID=" + Request.QueryString("ProductGroupID").ToString + "&ProductLevelID=" + Request.QueryString("ProductLevelID").ToString +  "&ProductDeptID=" + Request.QueryString("ProductDeptID").ToString + "&ProductID=" + Request.QueryString("ProductID").ToString )
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
