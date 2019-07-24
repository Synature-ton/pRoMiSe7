<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSTypeClass" %>
<%@Import Namespace="pRoMiSeProgramProperty" %>

<html>
<head>
<title>Manage Products</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText"><div class="headerText" align="left" id="HeaderText" runat="server" /></b>
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
<span id="showHeader" runat="server">
<table cellpadding="2" cellspacing="2">
<tr>
<td><div id="LinkText" class="text" runat="server"></div></td>
<span id="showKeywordSearch" runat="server">
<form id="mainForm" runat="server">
	<td class="text">Keyword(s): <asp:textbox ID="Keyword" Width="150" Height="20" runat="server" />&nbsp;<asp:button ID="SubmitForm" Text=" Search " Font-Size="8" Height="20" Width="70" OnClick="DoSearch" runat="server" /></td></form>
<script language="JavaScript">
	document.forms[0].Keyword.focus()
	document.forms[0].SubmitForm.focus()	
</script>
</span>
</tr>
</table>
</span>

<table width="100%" border="0">

<tr><div id="FormAction" runat="server"></div>
	<td align="left"><div id="SelectionText" class="text" runat="server"></div></td>
</tr><tr>
	<td align="right"><table><tr><td><div id="TabletImage" visible="false" runat="server"></div></td><td><div id="MasterData" visible="false" runat="server"></div></td><td><div id="SetUpParam" visible="false" runat="server"></div></td><td><div id="SetUpPrice" visible="false" runat="server"></div></td><td><div id="list_component" visible=false runat="server"></div></td><td><div id="showAddText" visible=true runat="server"></div></td></tr></table></td>
</tr></form>
<tr>
<td colspan="2">

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTDCode" align="center" class="tdHeader" runat="server"><div id="CodeText" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="ParentText" runat="server"></div></td>
		<td id="headerTDName" align="center" class="tdHeader" runat="server"><div id="NameText" runat="server"></div></td>
		<td id="headerTD11" align="center" class="tdHeader" runat="server"><div id="TypeText" runat="server"></div></td>
        <td id="headerTD14" align="center" class="tdHeader" runat="server"><div id="PriceText" runat="server"></div></td>
        <td id="headerTD15" align="center" class="tdHeader" runat="server"><div id="PrinterText" runat="server"></div></td>
        <td id="headerTD16" align="center" class="tdHeader" runat="server"><div id="PrintTypeText" runat="server"></div></td>
        <td id="headerTD17" align="center" class="tdHeader" runat="server"><div id="VATText" runat="server"></div></td>
        <td id="headerTD13" align="center" class="tdHeader" runat="server"><div id="SetupText" runat="server"></div></td>
		<td id="headerTDPromotion" align="center" class="tdHeader" runat="server"><div id="PromoText" runat="server"></div></td>
        <td id="headerTD12" align="center" class="tdHeader" runat="server"><div id="CommentText" runat="server"></div></td>
		<td id="headerTDSetComponent" align="center" class="tdHeader" runat="server"><div id="SetIngText" runat="server"></div></td>
		<td id="headerTDSetPrice" align="center" class="tdHeader" runat="server"><div id="SetPriceText" runat="server"></div></td>
		<td id="headerTDNotOrderTogether" align="center" class="tdHeader" runat="server"><div id="SetNotOrderTogether" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="ViewText" runat="server"></div></td>
        <td id="headerTD18" align="center" class="tdHeader" runat="server"><div id="SetShopText" runat="server"></div></td>
		<td id="headerTDSaveAs" align="center" class="tdHeader" runat="server"><div id="Default_SaveAsText" runat="server"></div></td>
		<td id="headerTDEdit" align="center" class="tdHeader" runat="server"><div id="Default_EditText" runat="server"></div></td>
		<td id="headerTDDelete" align="center" class="tdHeader" runat="server"><div id="Default_DelText" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>

</table>
</td></tr></table>


<div id="errorMsg" runat="server" />
</td>
<td>&nbsp;</td>
</tr>

<tr><td colspan="3" height="30">&nbsp;</td></tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
<tr>
	<td height="50" colspan="3" background="../images/footerbg2000.gif">&nbsp;</td>
</tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
</table>
<script language="VB" runat="server">
    Dim objCnn As New MySqlConnection()
    Dim getCnn As New CDBUtil()
    Dim Util As New UtilityFunction()
    Dim FormatObject As New FormatClass()
    Dim getInfo As New CCategory()
    Dim getPageText As New DefaultText()
    Dim getProp As New CPreferences()
    Dim DateTimeUtil As New MyDateTime()
    Dim objDB As New CDBUtil()
    Dim bolFromProductComponent As Boolean

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Inv_Product_Category") Then
            
            headerTDCode.BgColor = GlobalParam.AdminBGColor
            headerTDName.BgColor = GlobalParam.AdminBGColor
            headerTDEdit.BgColor = GlobalParam.AdminBGColor
            headerTDDelete.BgColor = GlobalParam.AdminBGColor
            headerTD5.BgColor = GlobalParam.AdminBGColor
            headerTD6.BgColor = GlobalParam.AdminBGColor
            headerTDSetPrice.BgColor = GlobalParam.AdminBGColor
            headerTDSetComponent.BgColor = GlobalParam.AdminBGColor
            headerTDSaveAs.BgColor = GlobalParam.AdminBGColor
            headerTDPromotion.BgColor = GlobalParam.AdminBGColor
            headerTD11.BgColor = GlobalParam.AdminBGColor
            headerTD12.BgColor = GlobalParam.AdminBGColor
            headerTD13.BgColor = GlobalParam.AdminBGColor
            headerTD14.BgColor = GlobalParam.AdminBGColor
            headerTD15.BgColor = GlobalParam.AdminBGColor
            headerTD16.BgColor = GlobalParam.AdminBGColor
            headerTD17.BgColor = GlobalParam.AdminBGColor
            headerTD18.BgColor = GlobalParam.AdminBGColor
            headerTDNotOrderTogether.BgColor = GlobalParam.AdminBGColor
		
            Dim KeywordString As String = ""
            If Trim(Request.QueryString("Keyword")) <> "" And Not Page.IsPostBack Then
                Keyword.Text = Trim(Request.QueryString("Keyword"))
                KeywordString = "&Keyword=" + Keyword.Text
                'If NOT Session("ProductSearchKeyword") is Nothing Then
                'Keyword.Text = Session("ProductSearchKeyword")
            End If
		
            Try
                objCnn = getCnn.EstablishConnection()
			
                Dim FormatData As DataTable = Util.FormatParam(FormatObject, Session("LangID"), objCnn)
                Dim ci As New CultureInfo(FormatObject.CultureString)
			
                headerTD13.Visible = False
                SetUpPrice.Visible = False
                SetUpParam.Visible = False
                TabletImage.Visible = False
                MasterData.Visible = False
                headerTD14.Visible = False
                headerTD18.Visible = False
                headerTDNotOrderTogether.Visible = False
                
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
			
                If PropertyInfo.Rows(0)("MultiBranch") = 1 Then
                    headerTD13.Visible = True
                End If
			
                Dim CheckShopLink As Boolean = getProp.CheckTableExist("ProductLevelLinkProductGroup", objCnn)
			
                If CheckShopLink = True Then
                    Dim ChkFeature As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramTypeID=2 AND PropertyID=13 AND KeyID=1", objCnn)
			
                    If ChkFeature.Rows.Count > 0 Then
                        If ChkFeature.Rows(0)("PropertyValue") = 1 Then
                            headerTD18.Visible = True
                        End If
                    End If
                End If
			
                If PropertyInfo.Rows(0)("HeadOrBranch") = 1 Then
                    headerTDEdit.Visible = False
                    headerTDDelete.Visible = False
                    showAddText.Visible = False
                    headerTDSetPrice.Visible = False
                    headerTDSetComponent.Visible = False
                    headerTDSaveAs.Visible = False
                    headerTDPromotion.Visible = False
                    headerTD13.Visible = False
                    headerTD18.Visible = False
                    headerTDNotOrderTogether.Visible = False
                End If
			
                headerTD12.Visible = False
			
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(7, Session("LangID"), objCnn)
                Dim strNotOrderTogetherText As String
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
                HeaderText.InnerHtml = textTable.Rows(11)("TextParamValue")
                Default_EditText.InnerHtml = defaultTextTable.Rows(0)("TextParamValue")
                Default_DelText.InnerHtml = defaultTextTable.Rows(1)("TextParamValue")
                Default_SaveAsText.InnerHtml = defaultTextTable.Rows(13)("TextParamValue")
                PromoText.InnerHtml = "Promotion"
                TypeText.InnerHtml = "Group Type"
                CommentText.InnerHtml = "Set Comment"
                SetupText.InnerHtml = "Set Up"
                PriceText.InnerHtml = "Price"
                PrinterText.InnerHtml = "Printer"
                PrintTypeText.InnerHtml = "Print Type"
                VATText.InnerHtml = "VAT Type"
                SetShopText.InnerHtml = "Set Shop"
                
                Dim ChkProductComment As DataTable = getProp.PropertyValue(1, 52, 1, objCnn)
			
                If ChkProductComment.Rows.Count > 0 Then
                    If ChkProductComment.Rows(0)("PropertyValue") <> 0 Then
                        headerTD12.Visible = True
                    End If
                End If
                
                bolFromProductComponent = False
                If Request.QueryString("From") IsNot Nothing Then
                    Select Case Request.QueryString("From")
                        Case "component", "setproduct_notordertogether.aspx"
                            bolFromProductComponent = True
                    End Select
                End If
                        
                Dim LinkString As String = ""
                Dim outputString As String = ""
                Dim PageSection As Integer = 1
                Dim i As Integer
                Dim FormSelected As String
                Dim ShowTableContent As Boolean = True
			
                Dim IDValue As Integer = -1
                If IsNumeric(Request.Form("ProductLevelID")) Then
                    IDValue = Request.Form("ProductLevelID")
                ElseIf IsNumeric(Session("ProductLevelID")) And Request.QueryString("From") IsNot Nothing Then
                    If bolFromProductComponent = True Then
                        If Request.QueryString("ProductLevelID") <> Session("ProductLevelID") Then
                            IDValue = Request.QueryString("ProductLevelID")
                        Else
                            IDValue = Session("ProductLevelID")
                        End If
                    End If
                ElseIf IsNumeric(Request.QueryString("ProductLevelID")) Then
                    IDValue = Request.QueryString("ProductLevelID")
                End If
			
                Dim GroupIDValue As Integer = -1
                If IsNumeric(Request.Form("ProductGroupID")) Then
                    GroupIDValue = Request.Form("ProductGroupID")
                ElseIf IsNumeric(Session("ProductGroupID")) And Request.QueryString("From") IsNot Nothing Then
                    If bolFromProductComponent = True Then
                        Select Case Request.QueryString("From")
                            Case "component"
                                If Request.QueryString("ProductLevelID") = Session("ProductLevelID") Then
                                    GroupIDValue = Session("ProductGroupID")
                                End If

                            Case "setproduct_notordertogether.aspx"
                                If IsNumeric(Request.QueryString("ProductGroupID")) Then
                                    GroupIDValue = Request.QueryString("ProductGroupID")
                                End If
                        End Select
                    End If
                ElseIf IsNumeric(Request.QueryString("ProductGroupID")) Then
                    GroupIDValue = Request.QueryString("ProductGroupID")
                End If
			
                Dim DeptIDValue As Integer = -1
                If IsNumeric(Request.Form("ProductDeptID")) Then
                    DeptIDValue = Request.Form("ProductDeptID")
                ElseIf IsNumeric(Session("ProductDeptID")) And Request.QueryString("From") IsNot Nothing Then
                    If bolFromProductComponent = True Then
                        Select Case Request.QueryString("From")
                            Case "component"
                                If Request.QueryString("ProductLevelID") = Session("ProductLevelID") Then
                                    DeptIDValue = Session("ProductDeptID")
                                End If

                            Case "setproduct_notordertogether.aspx"
                                If IsNumeric(Request.QueryString("ProductDeptID")) Then
                                    DeptIDValue = Request.QueryString("ProductDeptID")
                                End If
                        End Select
                    End If
                ElseIf IsNumeric(Request.QueryString("ProductDeptID")) Then
                    DeptIDValue = Request.QueryString("ProductDeptID")
                End If

                If bolFromProductComponent = True Then
                    Session("ProductLevelID") = IDValue
                    Session("ProductGroupID") = GroupIDValue
                    Session("ProductDeptID") = DeptIDValue
                End If
			    
                Dim CheckTable As Boolean = getProp.CheckTableExist("menuitem", objCnn)
                Dim ChkmPOS As DataTable = getProp.PropertyValue(2, 10, IDValue, objCnn)
                Dim mPOS As Boolean = False
                If ChkmPOS.Rows.Count > 0 And CheckTable = True And bolFromProductComponent = False Then
                    If ChkmPOS.Rows(0)("PropertyValue") = 1 Then
                        mPOS = True
                    End If
                End If
			
                If Not Request.QueryString("EditID") And IsNumeric(Request.QueryString("EditID")) Then
                    If Request.QueryString("EditID") = 1 Then
                        LinkString = "[" + textTable.Rows(12)("TextParamValue") + "]&nbsp;&nbsp;[<a href=""Product_category.aspx?EditID=2" + "&ProductLevelID=" + IDValue.ToString + """>" + textTable.Rows(13)("TextParamValue") + "</a>]&nbsp;&nbsp;[<a href=""Product_category.aspx?EditID=3&ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + GroupIDValue.ToString + """>" + textTable.Rows(39)("TextParamValue") + "</a>]"
                    ElseIf Request.QueryString("EditID") = 2 Then
                        LinkString = "[<a href=""Product_category.aspx?EditID=1" + "&ProductLevelID=" + IDValue.ToString + """>" + textTable.Rows(12)("TextParamValue") + "</a>]&nbsp;&nbsp;[" + textTable.Rows(13)("TextParamValue") + "]&nbsp;&nbsp;[<a href=""Product_category.aspx?EditID=3&ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + GroupIDValue.ToString + """>" + textTable.Rows(39)("TextParamValue") + "</a>]"
                        PageSection = 2
                    Else
                        LinkString = "[<a href=""Product_category.aspx?EditID=1" + "&ProductLevelID=" + IDValue.ToString + """>" + textTable.Rows(12)("TextParamValue") + "</a>]&nbsp;&nbsp;[<a href=""Product_category.aspx?EditID=2" + "&ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + GroupIDValue.ToString + """>" + textTable.Rows(13)("TextParamValue") + "</a>]&nbsp;&nbsp;[" + textTable.Rows(39)("TextParamValue") + "]"
                        PageSection = 3
                    End If
                Else
                    LinkString = "[" + textTable.Rows(12)("TextParamValue") + "]&nbsp;&nbsp;[<a href=""Product_category.aspx?EditID=2" + "&ProductLevelID=" + IDValue.ToString + """>" + textTable.Rows(13)("TextParamValue") + "</a>]&nbsp;&nbsp;[<a href=""Product_category.aspx?EditID=3&ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + GroupIDValue.ToString + """>" + textTable.Rows(39)("TextParamValue") + "</a>]"
                End If
                LinkText.InnerHtml = LinkString
			
                If bolFromProductComponent = True Then
                    LinkText.InnerHtml = ""
                End If
                                               
                Dim PriceRegion As DataTable = objDB.List("select * from ProgramPropertyValue where ProgramtypeID = 2 AND PropertyID =14 AND KeyID = 1", objCnn)
                Dim PriceRegFeature As Boolean = False
                If PriceRegion.Rows.Count > 0 Then
                    If PriceRegion.Rows(0)("PropertyValue") = 1 Or PriceRegion.Rows(0)("PropertyValue") = 2 Then
                        PriceRegFeature = True
                    End If
                End If
						
                Dim NewStringName As String
                Dim bColor As String
                Dim j As Integer
			
                If PageSection = 1 Then
                    headerTD5.Visible = False
                    headerTD6.Visible = False
                    headerTDSetPrice.Visible = False
                    headerTDSetComponent.Visible = False
                    headerTDSaveAs.Visible = False
                    headerTDPromotion.Visible = False
                    headerTD12.Visible = False
                    headerTD14.Visible = False
                    headerTD15.Visible = False
                    headerTD16.Visible = False
                    headerTD17.Visible = False
                    headerTDNotOrderTogether.Visible = False
                    TabletImage.Visible = False
				
                    CodeText.InnerHtml = textTable.Rows(14)("TextParamValue")
                    NameText.InnerHtml = textTable.Rows(15)("TextParamValue")
                    ParentText.InnerHtml = textTable.Rows(16)("TextParamValue")
				
				
                    Dim selectionTable As New DataTable()
				
                    selectionTable = getInfo.GetProductLevel(-888, objCnn)
                    'If selectionTable.Rows.Count > 1 Then
                    'selectionTable = getInfo.GetProductLevel(0,objCnn)
                    'End If
				
                    Dim displayTable As New DataTable()
				
                    If selectionTable.Rows.Count = 0 Then
                        ShowTableContent = False
                        showAddText.Visible = False
                        SelectionText.InnerHtml = textTable.Rows(19)("TextParamValue")
                    Else
                        Dim selIndex As Integer = 0
                        If selectionTable.Rows.Count > 1 Then
                            displayTable = getInfo.GetProductGroup(IDValue, 0, objCnn)
						
                            Dim SelectString As String = textTable.Rows(26)("TextParamValue")
                            If IDValue = -1 Then
                                FormSelected = "selected"
                            Else
                                FormSelected = ""
                            End If
                            outputString = "<select name=""ProductLevelID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" & textTable.Rows(18)("TextParamValue")
                            'If IDValue = 0 Then
                            'FormSelected = "selected"
                            'Else
                            'FormSelected = ""
                            'End If
                            'outputString += "<option value=""0""" + FormSelected + ">" & SelectString
                            For i = 0 To selectionTable.Rows.Count - 1
                                If IDValue = selectionTable.Rows(i)("ProductLevelID") Then
                                    FormSelected = "selected"
                                    selIndex = i
                                Else
                                    FormSelected = ""
                                End If
                                outputString += "<option value=""" & selectionTable.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & selectionTable.Rows(i)("ProductLevelName")
                            Next
                            SelectionText.InnerHtml = outputString
                        Else
                            selIndex = 0
                            IDValue = selectionTable.Rows(0)("ProductLevelID")
                            displayTable = getInfo.GetProductGroup(IDValue, 0, objCnn)
                            headerTD5.Visible = False
                        End If
                        'Hide Add New ProductGroup Link For Branch Shop
                        If (PropertyInfo.Rows(0)("HeadOrBranch") = 0 And selectionTable.Rows(selIndex)("MasterShopLink") <> 0) Then
                            showAddText.Visible = False
                        End If
					
                        outputString = ""
                        Dim ShowGroupRow As Boolean = True
                        For i = 0 To displayTable.Rows.Count - 1
                            ShowGroupRow = True
                            If PropertyInfo.Rows(0)("SystemTypeID") = 2 And displayTable.Rows(i)("IsComment") > 0 Then
                                'ShowGroupRow = False
                            End If
                            If i Mod 2 = 0 Then
                                bColor = "white"
                            Else
                                bColor = GlobalParam.RowBGColor
                            End If
                            outputString += "<tr bgColor=""" + bColor + """>"
                            If ShowGroupRow = True Then
                                If displayTable.Rows(i)("ProductGroupActivate") = 1 Or displayTable.Rows(i)("ProductGroupActivate") = True Then
                                    outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("ProductGroupCode") & "</td>"
                                Else
                                    outputString += "<td align=""left"" class=""disabledText"">" & displayTable.Rows(i)("ProductGroupCode") & "</td>"
                                End If
						
                                If headerTD5.Visible = True Then
                                    outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("ProductLevelName") & "</td>"
                                End If
						
                                If displayTable.Rows(i)("ProductGroupActivate") = 1 Or displayTable.Rows(i)("ProductGroupActivate") = True Then
                                    outputString += "<td align=""left"" class=""text""><a href=""product_category.aspx?EditID=2&ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + displayTable.Rows(i)("ProductGroupID").ToString + """>" & displayTable.Rows(i)("ProductGroupName") & "</a></td>"
                                Else
                                    outputString += "<td align=""left"" class=""disabledText""><a href=""product_category.aspx?EditID=2&ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + displayTable.Rows(i)("ProductGroupID").ToString + """>" & displayTable.Rows(i)("ProductGroupName") & "</a></td>"
                                End If
						
                                If displayTable.Rows(i)("IsComment") = 1 Then
                                    outputString += "<td align=""left"" class=""text"">" & "Product Comments" & "</td>"
                                ElseIf displayTable.Rows(i)("IsComment") = 2 Then
                                    outputString += "<td align=""left"" class=""text"">" & "Transaction Comments" & "</td>"
                                Else
                                    outputString += "<td align=""left"" class=""text"">" & "-" & "</td>"
                                End If
						
                                If headerTD13.Visible = True Then
                                    outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'multibranch_setup_productgroup.aspx?ProductGroupID=" + displayTable.Rows(i)("ProductGroupID").ToString + "&ProductLevelID=" + IDValue.ToString + "', '', 'width=800,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Multi Branch" + "</a></td>"
                                End If
						
                                If headerTDPromotion.Visible = True Then
                                    outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( '../Promotions/promotion_setup_products.aspx?ProductDeptID=0&ProductID=0&ProductGroupID=" + displayTable.Rows(i)("ProductGroupID").ToString + "&ProductLevelID=" + IDValue.ToString + "', '', 'width=1000,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Promotion" + "</a></td>"
                                End If
                                If headerTD18.Visible = True Then
                                    outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'manage_access_shop.aspx?TypeID=0&ParamID=" + displayTable.Rows(i)("ProductGroupID").ToString + "&ProductLevelID=" + IDValue.ToString + "', '', 'width=1000,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Set Shop" + "</a></td>"
                                End If
                                If headerTDEdit.Visible = True Then
                                    If (displayTable.Rows(i)("ProductGroupTakeAway") = 0 Or displayTable.Rows(i)("ProductGroupTakeAway") = False) And displayTable.Rows(i)("IsComment") = 0 Then
                                        outputString += "<td align=""center"" class=""text""><a href=""Product_category_edit.aspx?ProductGroupID=" & displayTable.Rows(i)("ProductGroupID") & "&ProductLevelID=" & IDValue.ToString & """>" & defaultTextTable.Rows(0)("TextParamValue") & "</a></td>"
                                    Else
                                        outputString += "<td align=""center"" class=""text"">" + "-" & "</td>"
                                    End If
                                End If
                                NewStringName = Replace(displayTable.Rows(i)("ProductGroupName"), """", "\""")
                                NewStringName = Replace(NewStringName, "'", "\'")
                                If headerTDDelete.Visible = True Then
                                    If (displayTable.Rows(i)("ProductGroupTakeAway") = 0 Or displayTable.Rows(i)("ProductGroupTakeAway") = False) And displayTable.Rows(i)("IsComment") = 0 Then
                                        outputString += "<td align=""center"" class=""text""><a href=""inv_category_action.aspx?action=delete_category&action_to=productgroup&DelID=" & displayTable.Rows(i)("ProductGroupID") & "&ProductLevelID=" & IDValue.ToString & """ onClick=""javascript: return confirm('" & textTable.Rows(3)("TextParamValue") & " " & NewStringName & " " & textTable.Rows(4)("TextParamValue") & "')"">" & defaultTextTable.Rows(1)("TextParamValue") & "</a></td>"
                                    Else
                                        outputString += "<td align=""center"" class=""text"">" + "-" & "</td>"
                                    End If
                                End If
		
                                outputString += "</tr>"
                            End If
                        Next
                        ResultText.InnerHtml = outputString
					
                        showAddText.InnerHtml = "<a href=""Product_category_edit.aspx?EditID=" + PageSection.ToString + "&ProductLevelID=" + IDValue.ToString + """>" + textTable.Rows(17)("TextParamValue") + "</a>"
					
                        FormAction.InnerHtml = "<form action=""Product_category.aspx"" method=""post"">"
                    End If
                ElseIf PageSection = 2 Then
				
                    headerTD5.Visible = False
                    headerTD6.Visible = False
                    headerTDSetPrice.Visible = False
                    headerTDSetComponent.Visible = False
                    headerTDSaveAs.Visible = False
                    headerTD11.Visible = False
                    headerTD12.Visible = False
                    headerTD14.Visible = False
                    headerTD15.Visible = False
                    headerTD16.Visible = False
                    headerTD17.Visible = False
                    headerTD18.Visible = False
                    headerTDNotOrderTogether.Visible = False
				
                    CodeText.InnerHtml = textTable.Rows(27)("TextParamValue")
                    NameText.InnerHtml = textTable.Rows(28)("TextParamValue")
                    ParentText.InnerHtml = textTable.Rows(29)("TextParamValue")
				
                    If PropertyInfo.Rows(0)("MultiBranch") = 1 Then
                        SetUpPrice.Visible = True
                        SetUpParam.Visible = True
                    End If
				
                    If PriceRegFeature = True Then
                        SetUpPrice.Visible = False
                    End If
                    SetUpPrice.InnerHtml = "<a href=""JavaScript: newWindow = window.open( 'price_setup_products.aspx?ProductGroupID=" & GroupIDValue.ToString & "&ProductLevelID=" & IDValue.ToString & "&ProductDeptID=" & DeptIDValue.ToString + "', '', 'width=900,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Price for Branches" + "</a> | "
                    SetUpParam.InnerHtml = "" '"<a href=""JavaScript: newWindow = window.open( 'multibranch_setup_products.aspx?ProductGroupID=" & GroupIDValue.ToString & "&ProductLevelID=" & IDValue.ToString & "&ProductDeptID=" & DeptIDValue.ToString + "', '', 'width=900,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Parameters for Branches" + "</a>"
				
                    MasterData.Visible = True
                    MasterData.InnerHtml = "<a href=""JavaScript: newWindow = window.open( 'multiproduct_setup_master.aspx?ProductGroupID=" & GroupIDValue.ToString & "&ProductLevelID=" & IDValue.ToString & "&ProductDeptID=" & DeptIDValue.ToString + "', '', 'width=1200,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Set Up Product Data" + "</a> | "
				
                    If Request.QueryString("From") <> "" Then
                        SetUpPrice.Visible = False
                        SetUpParam.Visible = False
                        list_component.Visible = False
                        TabletImage.Visible = False
                        MasterData.Visible = False
                    Else
                        MasterData.Visible = True
                    End If
				
                    Dim levelTable As New DataTable()
                    levelTable = getInfo.GetProductLevel(-888, objCnn)
				
                    Dim groupTable As New DataTable()
                    groupTable = getInfo.GetProductGroup(0, 0, objCnn)
				
                    Dim ProductLevelString As String = ""
                    Dim ProductGroupString As String = ""
				
                    If IDValue = 0 Then IDValue = -1
				
                    If groupTable.Rows.Count = 0 Then
                        ShowTableContent = False
                        showAddText.Visible = False
                        SelectionText.InnerHtml = textTable.Rows(32)("TextParamValue")
                    Else
                        Dim selIndex As Integer = 0
                        If levelTable.Rows.Count > 1 Then
                            For i = 0 To levelTable.Rows.Count - 1
                                If IDValue = levelTable.Rows(i)("ProductLevelID") Then
                                    FormSelected = "selected"
                                    selIndex = i
                                Else
                                    FormSelected = ""
                                End If
                                ProductLevelString += "<option value=""" & levelTable.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & levelTable.Rows(i)("ProductLevelName")
                            Next
                            ProductLevelString = "<select name=""ProductLevelID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" + textTable.Rows(18)("TextParamValue") + ProductLevelString + "</select>"
                        Else
                            IDValue = levelTable.Rows(0)("ProductLevelID")
                            headerTD5.Visible = False
                            selIndex = 0
                        End If
                        'Hide Add New ProductDept Link For Branch Shop
                        If (PropertyInfo.Rows(0)("HeadOrBranch") = 0 And levelTable.Rows(selIndex)("MasterShopLink") <> 0) Then
                            showAddText.Visible = False
                        End If
                        Dim CheckGroupIDValue As Boolean = False
                        For i = 0 To groupTable.Rows.Count - 1
                            If IDValue = groupTable.Rows(i)("ProductLevelID") Then
                                If GroupIDValue = groupTable.Rows(i)("ProductGroupID") Then
                                    FormSelected = "selected"
                                    CheckGroupIDValue = True
                                Else
                                    FormSelected = ""
                                End If
                                ProductGroupString += "<option value=""" & groupTable.Rows(i)("ProductGroupID") & """ " & FormSelected & ">" & groupTable.Rows(i)("ProductGroupName")
                            End If
                        Next
                        If CheckGroupIDValue = False Then GroupIDValue = -1
										
                        ProductGroupString = "<select name=""ProductGroupID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" + textTable.Rows(31)("TextParamValue") + ProductGroupString + "</select>"
					
                        If Trim(ProductLevelString) <> "" Then
                            SelectionText.InnerHtml = ProductLevelString + "&nbsp;&nbsp;" + ProductGroupString
                        Else
                            SelectionText.InnerHtml = ProductGroupString
                        End If
				
                        FormAction.InnerHtml = "<form action=""Product_category.aspx?EditID=" + PageSection.ToString + "&ProductLevelID=" + IDValue.ToString + """ method=""post"">"
					
                        showAddText.InnerHtml = "<a href=""Product_category_edit1.aspx?EditID=" + PageSection.ToString + "&ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + GroupIDValue.ToString + """>" + textTable.Rows(30)("TextParamValue") + "</a>"
					
                        If mPOS = True Then
                            TabletImage.InnerHtml = "<a href=""JavaScript: newWindow = window.open( 'tablet_image_setup.aspx?ProductGroupID=" & GroupIDValue.ToString & "&ProductLevelID=" & IDValue.ToString & "&ProductDeptID=" & DeptIDValue.ToString + "', '', 'width=900,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Tablet Images" + "</a> | "
                            TabletImage.Visible = True
                        End If
					
                        Dim displayTable As New DataTable()
                        displayTable = getInfo.GetProductDept(GroupIDValue, 0, objCnn)
					
                        outputString = ""
                        For i = 0 To displayTable.Rows.Count - 1
                            If i Mod 2 = 0 Then
                                bColor = "white"
                            Else
                                bColor = GlobalParam.RowBGColor
                            End If
                            outputString += "<tr bgColor=""" + bColor + """>"
                            If displayTable.Rows(i)("ProductDeptActivate") = 1 Or displayTable.Rows(i)("ProductDeptActivate") = True Then
                                outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("ProductDeptCode") & "</td>"
                            Else
                                outputString += "<td align=""left"" class=""disabledText"">" & displayTable.Rows(i)("ProductDeptCode") & "</td>"
                            End If
						
                            If headerTD5.Visible = True Then
                                outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("ProductLevelName") & " > " & displayTable.Rows(i)("ProductGroupName") & "</td>"
                            End If
						
                            outputString += "<td align=""left"" class=""text""><a href=""product_category.aspx?EditID=3&ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + GroupIDValue.ToString + "&ProductDeptID=" + displayTable.Rows(i)("ProductDeptID").ToString + """>" & displayTable.Rows(i)("ProductDeptName") & "</a></td>"
                            If headerTD13.Visible = True Then
                                outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'multibranch_setup_productdept.aspx?ProductGroupID=" + displayTable.Rows(i)("ProductGroupID").ToString + "&ProductDeptID=" + displayTable.Rows(i)("ProductDeptID").ToString + "&ProductLevelID=" + IDValue.ToString + "', '', 'width=800,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Multi Branch" + "</a></td>"
                            End If
						
                            If headerTDPromotion.Visible = True Then
                                outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( '../Promotions/promotion_setup_products.aspx?ProductGroupID=0&ProductID=0&ProductDeptID=" + displayTable.Rows(i)("ProductDeptID").ToString + "&ProductLevelID=" + IDValue.ToString + "', '', 'width=1000,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Promotion" + "</a></td>"
                            End If
						
                            If headerTDEdit.Visible = True Then
                                If displayTable.Rows(i)("ProductDeptTakeAway") = 0 Or displayTable.Rows(i)("ProductDeptTakeAway") = False Then
                                    outputString += "<td align=""center"" class=""text""><a href=""Product_category_edit1.aspx?ProductGroupID=" & displayTable.Rows(i)("ProductGroupID") & "&ProductLevelID=" & IDValue.ToString & "&ProductDeptID=" & displayTable.Rows(i)("ProductDeptID") & "&EditID=2" & """>" & defaultTextTable.Rows(0)("TextParamValue") & "</a></td>"
                                Else
                                    outputString += "<td align=""center"" class=""text"">" + defaultTextTable.Rows(0)("TextParamValue") & "</td>"
                                End If
                            End If
						
                            NewStringName = Replace(displayTable.Rows(i)("ProductDeptName"), """", "")
                            NewStringName = Replace(NewStringName, "'", "\'")
                            If headerTDDelete.Visible = True Then
                                If displayTable.Rows(i)("ProductDeptTakeAway") = 0 Or displayTable.Rows(i)("ProductDeptTakeAway") = False Then
                                    outputString += "<td align=""center"" class=""text""><a href=""inv_category_action.aspx?action=delete_category&action_to=productdept&EditID=2&DelID=" & displayTable.Rows(i)("ProductDeptID") & "&ProductLevelID=" & IDValue.ToString & "&ProductGroupID=" & GroupIDValue.ToString & """ onClick=""javascript: return confirm('" & textTable.Rows(3)("TextParamValue") & " " & NewStringName & " " & textTable.Rows(4)("TextParamValue") & "')"">" & defaultTextTable.Rows(1)("TextParamValue") & "</a></td>"
                                Else
                                    outputString += "<td align=""center"" class=""text"">" + defaultTextTable.Rows(1)("TextParamValue") & "</td>"
                                End If
                            End If
		
                            outputString += "</tr>"
                        Next
                        ResultText.InnerHtml = outputString
                    End If
                Else
                    ' -----------------Product Info-------------------------			
                    Dim ExtraQueryString As String = ""
                    If Request.QueryString("From") <> "" Then
                        If bolFromProductComponent = True Then
                            showHeader.Visible = True
                        Else
                            showHeader.Visible = False
                        End If
                        showAddText.Visible = False
                        headerTDEdit.Visible = False
                        headerTD6.Visible = False
                        headerTDSetPrice.Visible = False
                        headerTDSetComponent.Visible = False
                        headerTDSaveAs.Visible = False
                        headerTD12.Visible = False
                        '  ExtraQueryString = "&" + Request.QueryString.ToString
                       
                        'Not Include Keyword in Querystring
                        Dim strSplit() As String
                        strSplit = Split(Request.QueryString.ToString, "&")
                        ExtraQueryString = ""
                        For i = 0 To strSplit.Length - 1
                            If InStr(UCase(strSplit(i)), "KEYWORD") <> 1 And InStr(UCase(strSplit(i)), "EDITID") <> 1 Then
                                ExtraQueryString &= "&" & strSplit(i)
                            End If
                        Next i
                        
                        Default_DelText.InnerHtml = defaultTextTable.Rows(9)("TextParamValue")
                    End If
                    headerTD5.Visible = False
                    headerTD11.Visible = False
                    headerTD14.Visible = True
                    headerTD15.Visible = True
                    headerTD16.Visible = True
                    headerTD17.Visible = True
                    headerTD18.Visible = False
                    
                    'Check For Product Not Order Together
                    Dim bolHasNotOrderTogether As Boolean
                    If PropertyInfo.Rows(0)("HeadOrBranch") = 1 Then
                        bolHasNotOrderTogether = False
                    ElseIf pRoMiSeProgramProperty.ProgramPropertyFunction.GetProgramPropertyValueInDB(objDB, objCnn, POSAdditionalProgramVariable.PROGRAMTYPE_FRONT, _
                                1, POSAdditionalProgramVariable.PROPERTY_CHECKORDERPRODUCTTOGETHERFEATURE, 0) = 1 Then
                        If POSDBSQLFront.POSUtilSQL.IsTableExist(objDB, objCnn, "ProductNotOrderTogether") = True Then
                            bolHasNotOrderTogether = True
                        Else
                            bolHasNotOrderTogether = False
                        End If
                    Else
                        bolHasNotOrderTogether = False
                    End If
                    headerTDNotOrderTogether.Visible = bolHasNotOrderTogether
                    
                    If bolFromProductComponent = True Then
                        headerTDPromotion.Visible = False
                        headerTD13.Visible = False
                        headerTD15.Visible = False
                        headerTD16.Visible = False
                        headerTDNotOrderTogether.Visible = False
                    End If
				
                    CodeText.InnerHtml = textTable.Rows(40)("TextParamValue")
                    NameText.InnerHtml = textTable.Rows(41)("TextParamValue")
                    ParentText.InnerHtml = textTable.Rows(42)("TextParamValue")
                    ViewText.InnerHtml = defaultTextTable.Rows(5)("TextParamValue")
                    SetPriceText.InnerHtml = textTable.Rows(56)("TextParamValue")
                    SetIngText.InnerHtml = textTable.Rows(57)("TextParamValue")
                    If textTable.Rows.Count >= 97 Then
                        strNotOrderTogetherText = textTable.Rows(96)("TextParamValue")
                    Else
                        strNotOrderTogetherText = "Product Not Order Together"
                    End If
                    SetNotOrderTogether.InnerHtml = strNotOrderTogetherText
                    
                    Dim levelTable As New DataTable()
                    
                    If bolFromProductComponent = True And IDValue > 0 Then
                        levelTable = getInfo.GetProductLevel(IDValue, objCnn)
                    Else
                        levelTable = getInfo.GetProductLevel(-888, objCnn)
                    End If
                    
                    If levelTable.Rows.Count = 1 Then
                        IDValue = levelTable.Rows(0)("ProductLevelID")
                    End If
				
                    Dim groupTable As New DataTable()
                    groupTable = getInfo.GetProductGroup(IDValue, 0, objCnn)
				
                    Dim deptTable As New DataTable()
                    deptTable = getInfo.GetProductDept(0, 0, objCnn)
				
                    If IDValue = 0 Then IDValue = -1
                    If GroupIDValue = 0 Then GroupIDValue = -1
                    If DeptIDValue = 0 Then DeptIDValue = -1
				
                    list_component.Visible = True
                    list_component.InnerHtml = "<a href=""JavaScript: newWindow = window.open( 'product_details.aspx?EditID=3&ProductGroupID=" & GroupIDValue.ToString & "&ProductLevelID=" & IDValue.ToString & "&ProductDeptID=" & DeptIDValue.ToString + "', '', 'width=900,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "List Component" + "</a> | " '"<a href=""list_product_component.aspx?ProductDeptID=" + DeptIDValue.ToString + "&ProductLevelID=" & IDValue.ToString + "&ProductGroupID=" & GroupIDValue.ToString + """>List Component</a>&nbsp;&nbsp;"
				
                    If PropertyInfo.Rows(0)("MultiBranch") = 1 Then
                        SetUpPrice.Visible = True
                        SetUpParam.Visible = True
					
                    End If
                    SetUpPrice.InnerHtml = "<a href=""JavaScript: newWindow = window.open( 'price_setup_products.aspx?ProductGroupID=" & GroupIDValue.ToString & "&ProductLevelID=" & IDValue.ToString & "&ProductDeptID=" & DeptIDValue.ToString + "', '', 'width=900,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Price for Branches" + "</a> | "
                    SetUpParam.InnerHtml = "<a href=""JavaScript: newWindow = window.open( 'multibranch_setup_products.aspx?ProductGroupID=" & GroupIDValue.ToString & "&ProductLevelID=" & IDValue.ToString & "&ProductDeptID=" & DeptIDValue.ToString + "', '', 'width=900,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Parameters for Branches" + "</a> | "
                    If Request.QueryString("From") <> "" Then
                        SetUpPrice.Visible = False
                        SetUpParam.Visible = False
                        list_component.Visible = False
                        MasterData.Visible = False
                        TabletImage.Visible = False
                    Else
                        MasterData.Visible = True
                    End If
				
                    If PriceRegFeature = True Then
                        SetUpPrice.Visible = False
                        headerTDSetPrice.Visible = False
                    End If
				
                    MasterData.InnerHtml = "<a href=""JavaScript: newWindow = window.open( 'multiproduct_setup_master.aspx?ProductGroupID=" & GroupIDValue.ToString & "&ProductLevelID=" & IDValue.ToString & "&ProductDeptID=" & DeptIDValue.ToString + "', '', 'width=1200,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Set Up Product Data" + "</a> | "
				
                    If PropertyInfo.Rows(0)("HeadOrBranch") = 1 Then
                        SetUpPrice.Visible = False
                        SetUpParam.Visible = False
                        MasterData.Visible = False
                    End If
				
                    Dim ProductLevelString As String = ""
                    Dim ProductGroupString As String = ""
                    Dim ProductDeptString As String = ""
				
                    If deptTable.Rows.Count = 0 Then
                        ShowTableContent = False
                        showAddText.Visible = False
                        SelectionText.InnerHtml = textTable.Rows(45)("TextParamValue")
                    Else
                        Dim selIndex As Integer = 0
                        If levelTable.Rows.Count > 1 Then
                            For i = 0 To levelTable.Rows.Count - 1
                                If IDValue = levelTable.Rows(i)("ProductLevelID") Then
                                    FormSelected = "selected"
                                    selIndex = i
                                Else
                                    FormSelected = ""
                                End If
                                ProductLevelString += "<option value=""" & levelTable.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & levelTable.Rows(i)("ProductLevelName")
                            Next
                            ProductLevelString = "<select name=""ProductLevelID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" + textTable.Rows(18)("TextParamValue") + ProductLevelString + "</select>"
                        Else
                            IDValue = levelTable.Rows(0)("ProductLevelID")
                            headerTD5.Visible = False
                            selIndex = 0
                        End If
                        'Hide Add New Product Link For Branch Shop
                        If (PropertyInfo.Rows(0)("HeadOrBranch") = 0 And levelTable.Rows(selIndex)("MasterShopLink") <> 0) Then
                            showAddText.Visible = False
                        End If
				
                        Dim CheckGroupIDValue As Boolean = False
                        For i = 0 To groupTable.Rows.Count - 1
                            If GroupIDValue = groupTable.Rows(i)("ProductGroupID") Then
                                FormSelected = "selected"
                                CheckGroupIDValue = True
                            Else
                                FormSelected = ""
                            End If
                            ProductGroupString += "<option value=""" & groupTable.Rows(i)("ProductGroupID") & """ " & FormSelected & ">" & groupTable.Rows(i)("ProductGroupName")
                        Next
                        If CheckGroupIDValue = False Then GroupIDValue = -1
					
                        Dim CheckDeptIDValue As Boolean = False
                        For i = 0 To deptTable.Rows.Count - 1
                            If GroupIDValue = deptTable.Rows(i)("ProductGroupID") Then
                                If DeptIDValue = deptTable.Rows(i)("ProductDeptID") Then
                                    FormSelected = "selected"
                                    CheckDeptIDValue = True
                                Else
                                    FormSelected = ""
                                End If
                                ProductDeptString += "<option value=""" & deptTable.Rows(i)("ProductDeptID") & """ " & FormSelected & ">" & deptTable.Rows(i)("ProductDeptName")
                            End If
                        Next
                        If CheckDeptIDValue = False Then DeptIDValue = -1
					
					
                        ProductGroupString = "<select name=""ProductGroupID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" + textTable.Rows(31)("TextParamValue") + ProductGroupString + "</select>"
					
                        ProductDeptString = "<select name=""ProductDeptID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" + textTable.Rows(43)("TextParamValue") + ProductDeptString + "</select>"
					
                        If Trim(ProductLevelString) <> "" And showHeader.Visible = True Then
                            SelectionText.InnerHtml = ProductLevelString + "&nbsp;&nbsp;" + ProductGroupString + "&nbsp;&nbsp;" + ProductDeptString
                        Else
                            SelectionText.InnerHtml = ProductGroupString + "&nbsp;&nbsp;" + ProductDeptString
                        End If
				
                        FormAction.InnerHtml = "<form action=""Product_category.aspx?EditID=" + PageSection.ToString + ExtraQueryString + """ method=""post"">"
					
                        showAddText.InnerHtml = "<a href=""Product_category_edit2.aspx?EditID=" + PageSection.ToString + "&ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + GroupIDValue.ToString + "&ProductDeptID=" + DeptIDValue.ToString + """>" + textTable.Rows(44)("TextParamValue") + "</a>"
					
                        If mPOS = True Then
                            TabletImage.InnerHtml = "<a href=""JavaScript: newWindow = window.open( 'tablet_image_setup.aspx?ProductGroupID=" & GroupIDValue.ToString & "&ProductLevelID=" & IDValue.ToString & "&ProductDeptID=" & DeptIDValue.ToString + "', '', 'width=900,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Tablet Images" + "</a> | "
                            TabletImage.Visible = True
                        End If
					
                        Dim displayTable As New DataTable()
                        displayTable = getInfo.ListOrSearchProductInfo(DeptIDValue, 0, Keyword.Text, IDValue, objCnn)
					
                        outputString = ""
                        Dim SpaText As String
                        Dim IsTakeAway As Boolean = False
                        Dim PrinterString As String
                        Dim Printers As DataTable
                        For i = 0 To displayTable.Rows.Count - 1
                            IDValue = displayTable.Rows(i)("ProductLevelID")
						
                            If displayTable.Rows(i)("ProductCode").IndexOf("TW:") <> -1 Then
                                IsTakeAway = True
                                showAddText.Visible = False
                            Else
                                IsTakeAway = False
                            End If
                            If i Mod 2 = 0 Then
                                bColor = "white"
                            Else
                                bColor = GlobalParam.RowBGColor
                            End If
                            outputString += "<tr bgColor=""" + bColor + """>"
                            If displayTable.Rows(i)("ProductActivate") = 1 Or displayTable.Rows(i)("ProductActivate") = True Then
                                outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("ProductCode") & "</td>"
                            Else
                                outputString += "<td align=""left"" class=""disabledText"">" & displayTable.Rows(i)("ProductCode") & "</td>"
                            End If
						
                            If headerTD5.Visible = True Then
                                outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'multibranch_setup_products.aspx?ProductGroupID=" + displayTable.Rows(i)("ProductGroupID").ToString + "&ProductDeptID=" + displayTable.Rows(i)("ProductDeptID").ToString + "&ProductID=" + displayTable.Rows(i)("ProductID").ToString + "&ProductLevelID=" + IDValue.ToString + "', '', 'width=1000,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Multi Branch" + "</a></td>"
                            End If
						
                            If displayTable.Rows(i)("ProductSet") = 3 Then
                                SpaText = "<br>" + "<a href=""JavaScript: newWindow = window.open( 'product_staff.aspx?LinkID=" + displayTable.Rows(i)("ProductID").ToString + "&TypeID=1&EditID=1', '', 'width=640,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + textTable.Rows(77)("TextParamValue") + "</a>" + " | " + "<a href=""JavaScript: newWindow = window.open( 'product_room.aspx?LinkID=" + displayTable.Rows(i)("ProductID").ToString + "&ProductLevelID=" + IDValue.ToString + "&TypeID=1&EditID=1', '', 'width=640,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + textTable.Rows(78)("TextParamValue") + "</a>"
                            Else
                                SpaText = ""
                            End If
						
                            If displayTable.Rows(i)("ProductActivate") = 1 Or displayTable.Rows(i)("ProductActivate") = True Then
                                outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("ProductName") & SpaText & "</td>"
                            Else
                                outputString += "<td align=""left"" class=""disabledText"">" & displayTable.Rows(i)("ProductName") & SpaText & "</td>"
                            End If
						
						
                            If headerTD14.Visible = True Then
                                If PriceRegFeature = True Then
                                    outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'pricegroup_setting.aspx?ProductGroupID=" + displayTable.Rows(i)("ProductGroupID").ToString + "&ProductDeptID=" + displayTable.Rows(i)("ProductDeptID").ToString + "&ProductID=" + displayTable.Rows(i)("ProductID").ToString + "&ProductLevelID=" + IDValue.ToString + "', '', 'width=1100,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Check Price" + "</a></td>"
                                Else
                                    If Not IsDBNull(displayTable.Rows(i)("ProductPrice")) Then
                                        outputString += "<td align=""right"" class=""text"">" & CDbl(displayTable.Rows(i)("ProductPrice")).ToString(FormatObject.CurrencyFormat, ci) & "</td>"
                                    Else
                                        outputString += "<td align=""right"" class=""text"">" & "-" & "</td>"
                                    End If
                                End If
                            End If
						
                            If headerTD15.Visible = True Then
                                PrinterString = ""
                                If Not IsDBNull(displayTable.Rows(i)("PrinterID")) Then
                                    If Trim(displayTable.Rows(i)("PrinterID")) <> "" Then
                                        Printers = objDB.List("select * from Printers where PrinterID IN (" + displayTable.Rows(i)("PrinterID") + ")", objCnn)
                                        For j = 0 To Printers.Rows.Count - 1
                                            PrinterString += Printers.Rows(j)("PrinterName")
                                        Next
                                        outputString += "<td align=""left"" class=""text"">" & PrinterString & "</td>"
                                    Else
                                        outputString += "<td align=""left"" class=""text"">" & "-" & "</td>"
                                    End If
                                Else
                                    outputString += "<td align=""left"" class=""text"">" & "-" & "</td>"
                                End If
                            End If
						
                            If headerTD16.Visible = True Then
                                If Not IsDBNull(displayTable.Rows(i)("PrintGroup")) Then
                                    If displayTable.Rows(i)("PrintGroup") = 0 Then
                                        outputString += "<td align=""center"" class=""text"">" & "Separate" & "</td>"
                                    Else
                                        outputString += "<td align=""center"" class=""text"">" & "Combine" & "</td>"
                                    End If
                                Else
                                    outputString += "<td align=""center"" class=""text"">" & "-" & "</td>"
                                End If
                            End If
						
                            If headerTD17.Visible = True Then
                                If Not IsDBNull(displayTable.Rows(i)("VATType")) Then
                                    If displayTable.Rows(i)("VATType") = 0 Then
                                        outputString += "<td align=""center"" class=""text"">" & "N" & "</td>"
                                    ElseIf displayTable.Rows(i)("VATType") = 1 Then
                                        outputString += "<td align=""center"" class=""text"">" & "I" & "</td>"
                                    Else
                                        outputString += "<td align=""center"" class=""text"">" & "E" & "</td>"
                                    End If
                                Else
                                    outputString += "<td align=""center"" class=""text"">" & "-" & "</td>"
                                End If
                            End If
						
                            If headerTD13.Visible = True Then
                                outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'multibranch_setup_products.aspx?ProductGroupID=" + displayTable.Rows(i)("ProductGroupID").ToString + "&ProductDeptID=" + displayTable.Rows(i)("ProductDeptID").ToString + "&ProductID=" + displayTable.Rows(i)("ProductID").ToString + "&ProductLevelID=" + IDValue.ToString + "', '', 'width=1100,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Multi Branch" + "</a></td>"
                            End If
						
                            If headerTDPromotion.Visible = True Then
                                If displayTable.Rows(i)("ProductSet") <> 14 And displayTable.Rows(i)("ProductSet") <> 15 And displayTable.Rows(i)("ProductSet") <> 16 Then
                                    outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( '../Promotions/promotion_setup_products.aspx?ProductGroupID=0&ProductDeptID=0&ProductID=" + displayTable.Rows(i)("ProductID").ToString + "&ProductLevelID=" + IDValue.ToString + "', '', 'width=1000,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Promotion" + "</a></td>"
                                Else
                                    outputString += "<td align=""left"" class=""disabledText"">" & "-" & "</td>"
                                End If
                            End If
						
                            If headerTD12.Visible = True Then
                                Select Case displayTable.Rows(i)("ProductSet")
                                    Case 14, 15, 16
                                        outputString += "<td align=""left"" class=""disabledText"">" & "-" & "</td>"
                                    Case Else
                                        outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'product_comment_setup.aspx?ProductGroupID=0&ProductDeptID=0&ProductID=" + displayTable.Rows(i)("ProductID").ToString + "&ProductLevelID=" + IDValue.ToString + "', '', 'width=1000,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "Set Comment" + "</a></td>"
                                End Select
                            End If
						
                            If headerTDSetComponent.Visible = True Then
                                If displayTable.Rows(i)("ProductSet") <> 16 Then
                                    outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'pcomponent_group.aspx?ProductID=" + displayTable.Rows(i)("ProductID").ToString + "&ProductGroupID=" + displayTable.Rows(i)("ProductGroupID").ToString + "&ProductLevelID=" + IDValue.ToString + "&ProductDeptID=" + displayTable.Rows(i)("ProductDeptID").ToString + "', '', 'width=900,height=750,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + textTable.Rows(57)("TextParamValue") + "</a></td>"
                                Else
                                    outputString += "<td align=""left"" class=""disabledText"">" & "-" & "</td>"
                                End If
                            End If
						
						
                            '--------- Set Price ---------
                            If headerTDSetPrice.Visible = True Then
                                If displayTable.Rows(i)("ProductSet") = 0 Or displayTable.Rows(i)("ProductSet") = 3 Or displayTable.Rows(i)("ProductSet") = 19 Or displayTable.Rows(i)("ProductSet") = 1 Or displayTable.Rows(i)("ProductSet") = 4 Or displayTable.Rows(i)("ProductSet") = 6 Or displayTable.Rows(i)("ProductSet") = 7 Then
                                    outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'product_price.aspx?ProductID=" + displayTable.Rows(i)("ProductID").ToString + "&ProductGroupID=" & displayTable.Rows(i)("ProductGroupID").ToString & "&ProductLevelID=" & IDValue.ToString & "&ProductDeptID=" & displayTable.Rows(i)("ProductDeptID").ToString + "', '', 'width=1000,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + textTable.Rows(56)("TextParamValue") + "</a></td>"

                                    ' Else If displayTable.Rows(i)("ProductSet") = 1 Or displayTable.Rows(i)("ProductSet") = 4 Or displayTable.Rows(i)("ProductSet") = 6 Or displayTable.Rows(i)("ProductSet") = 7 Then
                                    'outputString +=  "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'productset_price.aspx?ProductID=" + displayTable.Rows(i)("ProductID").ToString + "&ProductGroupID=" & displayTable.Rows(i)("ProductGroupID").ToString & "&ProductLevelID=" & IDValue.ToString & "&ProductDeptID=" & displayTable.Rows(i)("ProductDeptID").ToString + "', '', 'width=800,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + textTable.Rows(56)("TextParamValue") + "</a></td>"

                                ElseIf displayTable.Rows(i)("ProductSet") <> 14 And displayTable.Rows(i)("ProductSet") <> 15 And displayTable.Rows(i)("ProductSet") <> 16 Then
                                    outputString += "<td align=""left"" class=""disabledText"">" & "-" & "</td>"
                                Else
                                    outputString += "<td align=""center"" class=""disabledText"">" + "-" + "</td>"
                                End If
                            End If
                            '-------- Product Not Order Together ----------
                            If headerTDNotOrderTogether.Visible = True Then
                                Select Case displayTable.Rows(i)("ProductSet")
                                    Case POSType.PRODUCTTYPE_COMMENT, POSType.PRODUCTTYPE_COMMENTWITHPRICE
                                        outputString += "<td align=""left"" class=""disabledText"">" & "-" & "</td>"
  
                                    Case Else
                                        outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open(" & _
                                                "'setproduct_notordertogether.aspx?ProductID=" & displayTable.Rows(i)("ProductID").ToString & _
                                                "&ProductGroupID=" + displayTable.Rows(i)("ProductGroupID").ToString & _
                                                "&ProductLevelID=" + IDValue.ToString + "&ProductDeptID=" + displayTable.Rows(i)("ProductDeptID").ToString & _
                                                "', '', 'width=900,height=750,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & _
                                                strNotOrderTogetherText & "</a></td>"
                                End Select
                            End If
						
                            '-------- Details --------
                            If headerTD6.Visible = True Then
                                If displayTable.Rows(i)("ProductSet") <> 16 And displayTable.Rows(i)("ProductSet") <> 19 Then
                                    outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'product_details.aspx?EditID=3&ProductID=" + displayTable.Rows(i)("ProductID").ToString + "&ProductGroupID=" & displayTable.Rows(i)("ProductGroupID").ToString & "&ProductLevelID=" & IDValue.ToString & "&ProductDeptID=" & displayTable.Rows(i)("ProductDeptID").ToString + "', '', 'width=850,height=570,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + defaultTextTable.Rows(5)("TextParamValue") + "</a></td>"
                                Else
                                    outputString += "<td align=""left"" class=""disabledText"">" & "-" & "</td>"
                                End If
                            End If
						
                            '------- Save As--------
                            If headerTDSaveAs.Visible = True Then
                                If (displayTable.Rows(i)("ProductSet") = 0 Or displayTable.Rows(i)("ProductSet") = 3) And displayTable.Rows(i)("TakeAway") <= 1 And IsTakeAway = False Then
                                    outputString += "<td align=""center"" class=""text""><a href=""Product_category_edit2.aspx?ProductGroupID=" & displayTable.Rows(i)("ProductGroupID") & "&ProductLevelID=" & IDValue.ToString & "&ProductDeptID=" & displayTable.Rows(i)("ProductDeptID") & "&EditID=3&ProductID=" & displayTable.Rows(i)("ProductID") & "&SaveAs=yes" & KeywordString & """>" & defaultTextTable.Rows(13)("TextParamValue") & "</a></td>"
                                ElseIf displayTable.Rows(i)("ProductSet") <> 14 And displayTable.Rows(i)("ProductSet") <> 15 And displayTable.Rows(i)("ProductSet") <> 16 Then
                                    outputString += "<td align=""left"" class=""disabledText"">" & "-" & "</td>"
                                Else
                                    outputString += "<td align=""center"" class=""disabledText"">" + "-" + "</td>"
                                End If
                            End If
						
                            If headerTDEdit.Visible = True Then
                                If displayTable.Rows(i)("TakeAway") <= 1 And IsTakeAway = False Then
                                    outputString += "<td align=""center"" class=""text""><a href=""Product_category_edit2.aspx?ProductGroupID=" & displayTable.Rows(i)("ProductGroupID") & "&ProductLevelID=" & IDValue.ToString & "&ProductDeptID=" & displayTable.Rows(i)("ProductDeptID") & "&EditID=3&ProductID=" & displayTable.Rows(i)("ProductID") & KeywordString & """>" & defaultTextTable.Rows(0)("TextParamValue") & "</a></td>"
                                Else
                                    outputString += "<td align=""center"" class=""text"">" + defaultTextTable.Rows(0)("TextParamValue") & "</td>"
                                End If
                            End If
                            
                            If bolFromProductComponent = True Then
                                Dim GoBackUrl As String = "productset_component.aspx"
                                If Request.QueryString("From") <> "component" Then
                                    GoBackUrl = Request.QueryString("From")
                                End If
                                
                                If displayTable.Rows(i)("ProductSet") = 0 Or displayTable.Rows(i)("ProductSet") = 1 Or displayTable.Rows(i)("ProductSet") = 3 Then
                                    outputString += "<td align=""center"" class=""text""><a href="""" onclick=""opener.location.href='" + GoBackUrl + "?MaterialID=" + displayTable.Rows(i)("ProductID").ToString + "&" + Request.QueryString.ToString + "'; window.close(); return false;"">" & defaultTextTable.Rows(9)("TextParamValue") & "</a></td>"
                                ElseIf displayTable.Rows(i)("ProductSet") = 6 And Request.QueryString("ProductSet") = 7 Then
                                    outputString += "<td align=""center"" class=""text""><a href="""" onclick=""opener.location.href='" + GoBackUrl + "?MaterialID=" + displayTable.Rows(i)("ProductID").ToString + "&" + Request.QueryString.ToString + "'; window.close(); return false;"">" & defaultTextTable.Rows(9)("TextParamValue") & "</a></td>"
                                ElseIf Request.QueryString("ProductSet") = 2 Then
                                    outputString += "<td align=""center"" class=""text""><a href="""" onclick=""opener.location.href='" + GoBackUrl + "?MaterialID=" + displayTable.Rows(i)("ProductID").ToString + "&" + Request.QueryString.ToString + "'; window.close(); return false;"">" & defaultTextTable.Rows(9)("TextParamValue") & "</a></td>"
                                ElseIf (Request.QueryString("From") <> "component") And displayTable.Rows(i)("ProductSet") = 7 Then
                                    outputString += "<td align=""center"" class=""text""><a href="""" onclick=""opener.location.href='" + GoBackUrl + "?MaterialID=" + displayTable.Rows(i)("ProductID").ToString + "&" + Request.QueryString.ToString + "'; window.close(); return false;"">" & defaultTextTable.Rows(9)("TextParamValue") & "</a></td>"
                                Else
                                    outputString += "<td align=""center"" class=""disabledText"">" + defaultTextTable.Rows(9)("TextParamValue") + "</td>"
                                End If
                            Else
                                If showHeader.Visible = True Then
                                    NewStringName = Replace(displayTable.Rows(i)("ProductName"), """", "")
                                    NewStringName = Replace(NewStringName, "\", "\\")
                                    NewStringName = Replace(NewStringName, "'", "\'")
							
                                    If headerTDDelete.Visible = True Then
                                        If displayTable.Rows(i)("TakeAway") <= 1 And IsTakeAway = False Then
                                            outputString += "<td align=""center"" class=""text""><a href=""del_product.aspx?action=delete_product&EditID=3&ProductID=" & displayTable.Rows(i)("ProductID") & "&ProductLevelID=" & IDValue.ToString & "&ProductGroupID=" & GroupIDValue.ToString & "&ProductDeptID=" & DeptIDValue.ToString & KeywordString & """>" & defaultTextTable.Rows(1)("TextParamValue") & "</a></td>"
                                        Else
                                            outputString += "<td align=""center"" class=""text"">" + defaultTextTable.Rows(1)("TextParamValue") & "</td>"
                                        End If
                                    End If
                                Else
                                    Dim GoBackUrl As String = "productset_component.aspx"
                                    If Request.QueryString("From") <> "component" Then
                                        GoBackUrl = Request.QueryString("From")
                                    End If
							
                                    If displayTable.Rows(i)("ProductSet") = 0 Or displayTable.Rows(i)("ProductSet") = 1 Or displayTable.Rows(i)("ProductSet") = 3 Then
                                        outputString += "<td align=""center"" class=""text""><a href="""" onclick=""opener.location.href='" + GoBackUrl + "?MaterialID=" + displayTable.Rows(i)("ProductID").ToString + "&" + Request.QueryString.ToString + "'; window.close(); return false;"">" & defaultTextTable.Rows(9)("TextParamValue") & "</a></td>"
                                    ElseIf displayTable.Rows(i)("ProductSet") = 6 And Request.QueryString("ProductSet") = 7 Then
                                        outputString += "<td align=""center"" class=""text""><a href="""" onclick=""opener.location.href='" + GoBackUrl + "?MaterialID=" + displayTable.Rows(i)("ProductID").ToString + "&" + Request.QueryString.ToString + "'; window.close(); return false;"">" & defaultTextTable.Rows(9)("TextParamValue") & "</a></td>"
                                    ElseIf Request.QueryString("ProductSet") = 2 Then
                                        outputString += "<td align=""center"" class=""text""><a href="""" onclick=""opener.location.href='" + GoBackUrl + "?MaterialID=" + displayTable.Rows(i)("ProductID").ToString + "&" + Request.QueryString.ToString + "'; window.close(); return false;"">" & defaultTextTable.Rows(9)("TextParamValue") & "</a></td>"
                                    Else
                                        outputString += "<td align=""center"" class=""disabledText"">" + defaultTextTable.Rows(9)("TextParamValue") + "</td>"
                                    End If
                                End If
                            End If
                            outputString += "</tr>"
                        Next
                        ResultText.InnerHtml = outputString
					
                        'errorMsg.InnerHtml = IDValue.ToString + ":" + GroupIDValue.ToString + ":" + DeptIDValue.ToString
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
        Dim strURL As String
        Session("ProductSearchKeyword") = Keyword.Text
                
        strURL = "product_category.aspx?EditID=3&Keyword=" & Keyword.Text & "&ProductLevelID=" & Request.QueryString("ProductLevelID")
        If bolFromProductComponent = True Then
            If Request.QueryString("From") IsNot Nothing Then
                strURL &= "&From=" & Request.QueryString("From")
            End If
            If Request.QueryString("ProductGroupID") IsNot Nothing Then
                strURL &= "&ProductGroupID=" & Request.QueryString("ProductGroupID")
            End If
            If Request.QueryString("ProductDeptID") IsNot Nothing Then
                strURL &= "&ProductDeptID=" & Request.QueryString("ProductDeptID")
            End If
            If Request.QueryString("ProductID") IsNot Nothing Then
                strURL &= "&ProductID=" & Request.QueryString("ProductID")
            End If
            If Request.QueryString("PGroupID") IsNot Nothing Then
                strURL &= "&PGroupID=" & Request.QueryString("PGroupID")
            End If
            If Request.QueryString("PComponentID") IsNot Nothing Then
                strURL &= "&PComponentID=" & Request.QueryString("PComponentID")
            End If
            If Request.QueryString("MaterialAmount") IsNot Nothing Then
                strURL &= "&MaterialAmount=" & Request.QueryString("MaterialAmount")
            End If
        End If
        Response.Redirect(strURL)

    End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
