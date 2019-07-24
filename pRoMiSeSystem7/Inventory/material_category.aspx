<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>

<html>
<head>
<title>Manage Material Data</title>
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
<form id="mainForm" runat="server">
<table id="showHeader" cellpadding="2" cellspacing="2" runat="server">
<tr>
<td><div id="LinkText" class="text" runat="server"></div></td>

<td class="text"><span id="KeywordText" runat="server" /> <asp:textbox ID="Keyword" Width="150" Height="20" runat="server" />&nbsp;<asp:button ID="SubmitForm" Text=" Search " Font-Size="8" Height="20" Width="60" OnClick="DoSearch" runat="server" /></td>
</tr></form>
</table>
<script language="JavaScript">
	document.forms[0].Keyword.focus()
	document.forms[0].SubmitForm.focus()	
</script>

<table width="90%">

<tr><div id="FormAction" runat="server"></div>
	<td align="left"><div id="SelectionText" class="text" runat="server"></div></td></form>
	<td align="right"><div id="showAddText" visible=true runat="server"></div></td>
</tr>
<tr>
<td colspan="2">

<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
    	<td id="headerTD0" align="center" class="tdHeader" runat="server"></td>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="CodeText" runat="server"></div></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="ParentText" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="NameText" runat="server"></div></td>
        <td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="LinkProductText" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="InvenUnitText" runat="server"></div></td>
        <td id="headerTD8" align="center" class="tdHeader" runat="server"><div id="MappingMac4Text" runat="server"></div></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Default_EditText" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Default_DelText" runat="server"></div></td>
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
Dim objDB As New CDBUtil()
    Dim bolFromProductComponent As Boolean

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Inv_Material_Category") Then
            headerTD0.BgColor = GlobalParam.AdminBGColor
            headerTD1.BgColor = GlobalParam.AdminBGColor
            headerTD2.BgColor = GlobalParam.AdminBGColor
            headerTD3.BgColor = GlobalParam.AdminBGColor
            headerTD4.BgColor = GlobalParam.AdminBGColor
            headerTD5.BgColor = GlobalParam.AdminBGColor
            headerTD6.BgColor = GlobalParam.AdminBGColor
            headerTD7.BgColor = GlobalParam.AdminBGColor
            headerTD8.BgColor = GlobalParam.AdminBGColor
		
            If Trim(Request.QueryString("Keyword")) <> "" And Not Page.IsPostBack Then
                Keyword.Text = Trim(Request.QueryString("Keyword"))
            End If
					
            Try
                objCnn = getCnn.EstablishConnection()
                Dim PageName As String = System.IO.Path.GetFileName(Request.ServerVariables("SCRIPT_NAME"))
                Dim LangListText As String = ""
                Dim LangListData As DataTable
                Dim LangData As DataTable = getProp.GetLang(LangListText, LangListData, PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"), 2, 1, -1, Request, objCnn)
                Dim LangText As String = "lang" + Session("LangID").ToString
                HeaderText.InnerHtml = LangData.Rows(0)(LangText)
                KeywordText.InnerHtml = LangData.Rows(4)(LangText)
                SubmitForm.Text = LangData.Rows(5)(LangText)
			
                'errorMsg.InnerHtml = LangData.Rows.Count.ToString

                			
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(6, Session("LangID"), objCnn)
			
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
			
                Default_EditText.InnerHtml = defaultTextTable.Rows(0)("TextParamValue")
                Default_DelText.InnerHtml = defaultTextTable.Rows(1)("TextParamValue")
                LinkProductText.InnerHtml = LangData.Rows(16)(LangText)
			
                InvenUnitText.InnerHtml = LangData.Rows(17)(LangText)
                MappingMac4Text.InnerHtml = LangData.Rows(18)(LangText)
                headerTD6.Visible = False
			
                Dim LinkString As String = ""
                Dim outputString As String = ""
                Dim PageSection As Integer = 1
                Dim i As Integer
                Dim FormSelected As String
                Dim ShowTableContent As Boolean = True
			
                Dim IDValue As Integer = -1
                If IsNumeric(Request.Form("MaterialLevelID")) Then
                    IDValue = Request.Form("MaterialLevelID")
                ElseIf IsNumeric(Request.QueryString("MaterialLevelID")) And Request.QueryString("From") Is Nothing Then
                    IDValue = Request.QueryString("MaterialLevelID")
                ElseIf IsNumeric(Session("MaterialLevelID")) And Request.QueryString("From") IsNot Nothing Then
                    If Request.QueryString("From") = "component" Or Request.QueryString("From") = "mcomponent" Then
                        IDValue = Session("MaterialLevelID")
                    End If
                End If
			
                Dim GroupIDValue As Integer = -1
                If IsNumeric(Request.Form("MaterialGroupID")) Then
                    GroupIDValue = Request.Form("MaterialGroupID")
                ElseIf IsNumeric(Request.QueryString("MaterialGroupID")) And Request.QueryString("From") Is Nothing Then
                    GroupIDValue = Request.QueryString("MaterialGroupID")
                ElseIf IsNumeric(Session("MaterialGroupID")) And Request.QueryString("From") IsNot Nothing Then
                    If Request.QueryString("From") = "component" Or Request.QueryString("From") = "mcomponent" Then
                        GroupIDValue = Session("MaterialGroupID")
                    End If
                End If
			
                Dim DeptIDValue As Integer = -1
                If IsNumeric(Request.Form("MaterialDeptID")) Then
                    DeptIDValue = Request.Form("MaterialDeptID")
                ElseIf IsNumeric(Request.QueryString("MaterialDeptID")) And Request.QueryString("From") Is Nothing Then
                    DeptIDValue = Request.QueryString("MaterialDeptID")
                ElseIf IsNumeric(Session("MaterialDeptID")) And Request.QueryString("From") IsNot Nothing Then
                    If Request.QueryString("From") = "component" Or Request.QueryString("From") = "mcomponent" Then
                        DeptIDValue = Session("MaterialDeptID")
                    End If
                End If
			
                If Request.QueryString("From") IsNot Nothing Then
                    If Request.QueryString("From") = "component" Or Request.QueryString("From") = "mcomponent" Then
                        Session("MaterialLevelID") = IDValue
                        Session("MaterialGroupID") = GroupIDValue
                        Session("MaterialDeptID") = DeptIDValue
                    End If
                End If
                
                bolFromProductComponent = False
                If Request.QueryString("From") IsNot Nothing Then
                    If Request.QueryString("From") = "component" Or Request.QueryString("From") = "mcomponent" Then
                        bolFromProductComponent = True
                    End If
                End If
			
                If Not Request.QueryString("EditID") And IsNumeric(Request.QueryString("EditID")) Then
                    If Request.QueryString("EditID") = 1 Then
                        LinkString = "[" + LangData.Rows(1)(LangText) + "]&nbsp;&nbsp;[<a href=""Material_category.aspx?EditID=2" + "&MaterialLevelID=" + IDValue.ToString + """>" + LangData.Rows(2)(LangText) + "</a>]&nbsp;&nbsp;[<a href=""Material_category.aspx?EditID=3&MaterialLevelID=" + IDValue.ToString + "&MaterialGroupID=" + GroupIDValue.ToString + """>" + LangData.Rows(3)(LangText) + "</a>]"
                    ElseIf Request.QueryString("EditID") = 2 Then
                        LinkString = "[<a href=""Material_category.aspx?EditID=1" + "&MaterialLevelID=" + IDValue.ToString + """>" + LangData.Rows(1)(LangText) + "</a>]&nbsp;&nbsp;[" + LangData.Rows(2)(LangText) + "]&nbsp;&nbsp;[<a href=""Material_category.aspx?EditID=3&MaterialLevelID=" + IDValue.ToString + "&MaterialGroupID=" + GroupIDValue.ToString + """>" + LangData.Rows(3)(LangText) + "</a>]"
                        PageSection = 2
                    Else
                        LinkString = "[<a href=""Material_category.aspx?EditID=1" + "&MaterialLevelID=" + IDValue.ToString + """>" + LangData.Rows(1)(LangText) + "</a>]&nbsp;&nbsp;[<a href=""Material_category.aspx?EditID=2" + "&MaterialLevelID=" + IDValue.ToString + "&MaterialGroupID=" + GroupIDValue.ToString + """>" + LangData.Rows(2)(LangText) + "</a>]&nbsp;&nbsp;[" + LangData.Rows(3)(LangText) + "]"
                        PageSection = 3
                    End If
                Else
                    LinkString = "[" + LangData.Rows(1)(LangText) + "]&nbsp;&nbsp;[<a href=""Material_category.aspx?EditID=2" + "&MaterialLevelID=" + IDValue.ToString + """>" + LangData.Rows(2)(LangText) + "</a>]&nbsp;&nbsp;[<a href=""Material_category.aspx?EditID=3&MaterialLevelID=" + IDValue.ToString + "&MaterialGroupID=" + GroupIDValue.ToString + """>" + LangData.Rows(3)(LangText) + "</a>]"
                End If
                LinkText.InnerHtml = LinkString
                
                'Clear LinkText For ProductComponent
                If bolFromProductComponent = True Then
                    LinkText.InnerHtml = ""
                End If
                               
                Dim PropertyInfo As DataTable = getProp.PropertyInfo(1, objCnn)
                If PropertyInfo.Rows(0)("HeadOrBranch") = 1 Then
                    showAddText.Visible = False
                    headerTD3.Visible = False
                    headerTD4.Visible = False
                End If
			
                Dim bColor As String
			
                If PageSection = 1 Then
                    CodeText.InnerHtml = LangData.Rows(6)(LangText)
                    NameText.InnerHtml = LangData.Rows(7)(LangText)
                    ParentText.InnerHtml = textTable.Rows(16)("TextParamValue")
                    headerTD7.Visible = False
                    headerTD8.Visible = False
				
                    Dim selectionTable As New DataTable()
                    selectionTable = getInfo.GetMaterialLevel(0, objCnn)
				
                    Dim displayTable As New DataTable()
				
                    If selectionTable.Rows.Count = 0 Then
                        ShowTableContent = False
                        showAddText.Visible = False
                        SelectionText.InnerHtml = textTable.Rows(19)("TextParamValue")
                    Else
                        If selectionTable.Rows.Count > 1 Then
						
                            displayTable = getInfo.GetMaterialGroup(IDValue, 0, objCnn)
						
                            Dim SelectString As String = "-- Please Select --"
                            If IDValue = -1 Then
                                FormSelected = "selected"
                            Else
                                FormSelected = ""
                            End If
                            outputString = "<select name=""MaterialLevelID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" & textTable.Rows(18)("TextParamValue")
                            If IDValue = 0 Then
                                FormSelected = "selected"
                            Else
                                FormSelected = ""
                            End If
                            outputString += "<option value=""0""" + FormSelected + ">" & SelectString
                            For i = 0 To selectionTable.Rows.Count - 1
                                If IDValue = selectionTable.Rows(i)("MaterialLevelID") Then
                                    FormSelected = "selected"
                                Else
                                    FormSelected = ""
                                End If
                                outputString += "<option value=""" & selectionTable.Rows(i)("MaterialLevelID") & """ " & FormSelected & ">" & selectionTable.Rows(i)("MaterialLevelName")
                            Next
                            SelectionText.InnerHtml = outputString
                        Else
                            IDValue = selectionTable.Rows(0)("MaterialLevelID")
                            displayTable = getInfo.GetMaterialGroup(IDValue, 0, objCnn)
                            headerTD5.Visible = False
                        End If
					
                        outputString = ""
                        For i = 0 To displayTable.Rows.Count - 1
						
                            If i Mod 2 = 0 Then
                                bColor = "white"
                            Else
                                bColor = GlobalParam.RowBGColor
                            End If
						
                            outputString += "<tr bgColor=""" + bColor + """><td align=""center"" class=""text"">" + (i + 1).ToString + "</td><td align=""left"" class=""text"">" & displayTable.Rows(i)("MaterialGroupCode") & "</td>"
						
                            If headerTD5.Visible = True Then
                                outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("MaterialLevelName") & "</td>"
                            End If
						
                            outputString += "<td align=""left"" class=""text""><a href=""material_category.aspx?EditID=2&MaterialLevelID=" + IDValue.ToString + "&MaterialGroupID=" + displayTable.Rows(i)("MaterialGroupID").ToString + """>" & displayTable.Rows(i)("MaterialGroupName") & "</a></td>"
						
                            If headerTD3.Visible = True Then
                                outputString += "<td align=""center"" class=""text""><a href=""Material_category_edit.aspx?MaterialGroupID=" & displayTable.Rows(i)("MaterialGroupID") & "&MaterialLevelID=" & IDValue.ToString & """>" & LangData.Rows(9)(LangText) & "</a></td>"
                            End If
						
                            If headerTD4.Visible = True Then
                                outputString += "<td align=""center"" class=""text""><a href=""inv_category_action.aspx?action=delete_category&action_to=materialgroup&DelID=" & displayTable.Rows(i)("MaterialGroupID") & "&MaterialLevelID=" & IDValue.ToString & """ onClick=""javascript: return confirm('" & textTable.Rows(3)("TextParamValue") & " " & Replace(displayTable.Rows(i)("MaterialGroupName"), "'", "\'") & " " & textTable.Rows(4)("TextParamValue") & "')"">" & LangData.Rows(10)(LangText) & "</a></td>"
                            End If
		
                            outputString += "</tr>"
                        Next
                        ResultText.InnerHtml = outputString
					
                        showAddText.InnerHtml = "<a href=""Material_category_edit.aspx?EditID=" + PageSection.ToString + "&MaterialLevelID=" + IDValue.ToString + """>" + textTable.Rows(17)("TextParamValue") + "</a>"
					
                        FormAction.InnerHtml = "<form action=""Material_category.aspx"" method=""post"">"
                    End If
                ElseIf PageSection = 2 Then
                    CodeText.InnerHtml = LangData.Rows(11)(LangText)
                    NameText.InnerHtml = LangData.Rows(12)(LangText)
                    ParentText.InnerHtml = textTable.Rows(29)("TextParamValue")
                    headerTD7.Visible = False
                    headerTD8.Visible = False
				
                    Dim levelTable As New DataTable()
                    levelTable = getInfo.GetMaterialLevel(0, objCnn)
				
                    Dim groupTable As New DataTable()
                    groupTable = getInfo.GetMaterialGroup(0, 0, objCnn)
				
                    Dim MaterialLevelString As String = ""
                    Dim MaterialGroupString As String = ""
				
                    If IDValue = 0 Then IDValue = -1
				
                    If groupTable.Rows.Count = 0 Then
                        ShowTableContent = False
                        showAddText.Visible = False
                        SelectionText.InnerHtml = textTable.Rows(32)("TextParamValue")
                    Else
					
                        If levelTable.Rows.Count > 1 Then
                            For i = 0 To levelTable.Rows.Count - 1
                                If IDValue = levelTable.Rows(i)("MaterialLevelID") Then
                                    FormSelected = "selected"
                                Else
                                    FormSelected = ""
                                End If
                                MaterialLevelString += "<option value=""" & levelTable.Rows(i)("MaterialLevelID") & """ " & FormSelected & ">" & levelTable.Rows(i)("MaterialLevelName")
                            Next
                            MaterialLevelString = "<select name=""MaterialLevelID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" + textTable.Rows(18)("TextParamValue") + MaterialLevelString + "</select>"
                        Else
                            IDValue = levelTable.Rows(0)("MaterialLevelID")
                            headerTD5.Visible = False
                        End If
					
                        Dim CheckGroupIDValue As Boolean = False
                        For i = 0 To groupTable.Rows.Count - 1
                            If IDValue = groupTable.Rows(i)("MaterialLevelID") Then
                                If GroupIDValue = groupTable.Rows(i)("MaterialGroupID") Then
                                    FormSelected = "selected"
                                    CheckGroupIDValue = True
                                Else
                                    FormSelected = ""
                                End If
                                MaterialGroupString += "<option value=""" & groupTable.Rows(i)("MaterialGroupID") & """ " & FormSelected & ">" & groupTable.Rows(i)("MaterialGroupName")
                            End If
                        Next
                        If CheckGroupIDValue = False Then GroupIDValue = -1
														
                        MaterialGroupString = "<select name=""MaterialGroupID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" + LangData.Rows(20)(LangText) + MaterialGroupString + "</select>"
					
                        If Trim(MaterialLevelString) <> "" Then
                            SelectionText.InnerHtml = MaterialLevelString + "&nbsp;&nbsp;" + MaterialGroupString
                        Else
                            SelectionText.InnerHtml = MaterialGroupString
                        End If
				
                        FormAction.InnerHtml = "<form action=""Material_category.aspx?EditID=" + PageSection.ToString + """ method=""post"">"
					
                        showAddText.InnerHtml = "<a href=""Material_category_edit1.aspx?EditID=" + PageSection.ToString + "&MaterialLevelID=" + IDValue.ToString + "&MaterialGroupID=" + GroupIDValue.ToString + """>" + LangData.Rows(13)(LangText) + "</a>"
					
                        Dim displayTable As New DataTable()
                        displayTable = getInfo.GetMaterialDept(GroupIDValue, 0, objCnn)
					
                        outputString = ""
                        For i = 0 To displayTable.Rows.Count - 1
					        If i Mod 2 = 0 Then
                                bColor = "white"
                            Else
                                bColor = GlobalParam.RowBGColor
                            End If
						
                            outputString += "<tr bgColor=""" + bColor + """><td align=""center"" class=""text"">" + (i + 1).ToString + "</td><td align=""left"" class=""text"">" & displayTable.Rows(i)("MaterialDeptCode") & "</td>"
						
                            If headerTD5.Visible = True Then
                                outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("MaterialLevelName") & " > " & displayTable.Rows(i)("MaterialGroupName") & "</td>"
                            End If
						
                            outputString += "<td align=""left"" class=""text""><a href=""material_category.aspx?EditID=3&MaterialLevelID=" + IDValue.ToString + "&MaterialGroupID=" + GroupIDValue.ToString + "&MaterialDeptID=" + displayTable.Rows(i)("MaterialDeptID").ToString + """>" & displayTable.Rows(i)("MaterialDeptName") & "</a></td>"
						
                            If headerTD3.Visible = True Then
                                outputString += "<td align=""center"" class=""text""><a href=""Material_category_edit1.aspx?MaterialGroupID=" & displayTable.Rows(i)("MaterialGroupID") & "&MaterialLevelID=" & IDValue.ToString & "&MaterialDeptID=" & displayTable.Rows(i)("MaterialDeptID") & "&EditID=2" & """>" & LangData.Rows(9)(LangText) & "</a></td>"
                            End If
						
                            If headerTD4.Visible = True Then
                                outputString += "<td align=""center"" class=""text""><a href=""inv_category_action.aspx?action=delete_category&action_to=materialdept&EditID=2&DelID=" & displayTable.Rows(i)("MaterialDeptID") & "&MaterialLevelID=" & IDValue.ToString & "&MaterialGroupID=" & GroupIDValue.ToString & """ onClick=""javascript: return confirm('" & textTable.Rows(3)("TextParamValue") & " " & Replace(displayTable.Rows(i)("MaterialDeptName"), "'", "\'") & " " & textTable.Rows(4)("TextParamValue") & "')"">" & LangData.Rows(10)(LangText) & "</a></td>"
                            End If
		
                            outputString += "</tr>"
                        Next
                        ResultText.InnerHtml = outputString
                    End If
                Else
			
                    ' -----------------Material Info-------------------------
                    Dim GetProperty As DataTable = getProp.PropertyValue(2, 1, 1, objCnn)
                    Dim UnitInputType As DataTable = getProp.PropertyValue(2, 7, 1, objCnn)
                    If GetProperty.Rows.Count = 1 Then
                        If GetProperty.Rows(0)("PropertyValue") = 1 Then
                            If UnitInputType.Rows.Count = 0 Then
                                headerTD6.Visible = True
                            Else
                                If UnitInputType.Rows(0)("PropertyValue") = 0 Then
                                    headerTD6.Visible = True
                                End If
                            End If
                        End If
                    End If
				
                    GetProperty = getProp.PropertyValue(2, 2, 1, objCnn)
                    If GetProperty.Rows.Count = 1 Then
                        If GetProperty.Rows(0)("PropertyValue") = 1 Then
                            headerTD8.Visible = True
                        End If
                    End If
			
                    Dim ExtraQueryString As String = ""
                    If Request.QueryString("From") <> "" Then
                        If bolFromProductComponent = True Then
                            showHeader.Visible = True
                        Else
                            showHeader.Visible = False
                        End If
                        
                        showAddText.Visible = False
                        headerTD3.Visible = False
                        headerTD6.Visible = False
                        headerTD7.Visible = False
                        headerTD8.Visible = False
                        HeaderText.InnerHtml = LangData.Rows(26)(LangText)
                        Dim arr1() As String
                        Dim coll As NameValueCollection
                        Dim loop1 As Integer
                        ' Load Form variables into NameValueCollection variable.
                        coll = Request.QueryString
                        ' Get names of all forms into a string array.
                        arr1 = coll.AllKeys
                        Dim myArray() As String
                        Dim TestText As String = ""
                        ExtraQueryString = ""
                        For loop1 = 0 To arr1.GetUpperBound(0)
                            TestText += "<br>" + "Name=" + arr1(loop1) + "::Value=" + Request.QueryString(arr1(loop1)).ToString
                            If arr1(loop1).IndexOf("EditID") = -1 Then
                                ExtraQueryString += "&" + arr1(loop1) + "=" + Request.QueryString(arr1(loop1)).ToString
                            End If
                        Next
                        'errorMsg.InnerHtml = TestText + "<p>" + ExtraQueryString
                        'ExtraQueryString = "&" + Request.QueryString.ToString
                        Default_DelText.InnerHtml = defaultTextTable.Rows(9)("TextParamValue")
                    End If
                    CodeText.InnerHtml = LangData.Rows(14)(LangText)
                    NameText.InnerHtml = LangData.Rows(15)(LangText)
                    ParentText.InnerHtml = textTable.Rows(42)("TextParamValue")
				
                    Dim levelTable As New DataTable()
                    levelTable = getInfo.GetMaterialLevel(0, objCnn)
				
                    If levelTable.Rows.Count = 1 Then
                        IDValue = levelTable.Rows(0)("MaterialLevelID")
                    End If
				
                    Dim groupTable As New DataTable()
                    groupTable = getInfo.GetMaterialGroup(IDValue, 0, objCnn)
				
                    Dim deptTable As New DataTable()
                    deptTable = getInfo.GetMaterialDept(0, 0, objCnn)
				
                    If IDValue = 0 Then IDValue = -1
                    If GroupIDValue = 0 Then GroupIDValue = -1
                    If DeptIDValue = 0 Then DeptIDValue = -1
				
                    Dim MaterialLevelString As String = ""
                    Dim MaterialGroupString As String = ""
                    Dim MaterialDeptString As String = ""
				
                    If groupTable.Rows.Count = 0 Then
                        ShowTableContent = False
                        showAddText.Visible = False
                        SelectionText.InnerHtml = textTable.Rows(45)("TextParamValue")
                    Else
					
                        If levelTable.Rows.Count > 1 Then
                            For i = 0 To levelTable.Rows.Count - 1
                                If IDValue = levelTable.Rows(i)("MaterialLevelID") Then
                                    FormSelected = "selected"
                                Else
                                    FormSelected = ""
                                End If
                                MaterialLevelString += "<option value=""" & levelTable.Rows(i)("MaterialLevelID") & """ " & FormSelected & ">" & levelTable.Rows(i)("MaterialLevelName")
                            Next
                            MaterialLevelString = "<select name=""MaterialLevelID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" + textTable.Rows(18)("TextParamValue") + MaterialLevelString + "</select>"
                        Else
                            IDValue = levelTable.Rows(0)("MaterialLevelID")
                            headerTD5.Visible = False
                        End If
					
                        Dim CheckGroupIDValue As Boolean = False
                        For i = 0 To groupTable.Rows.Count - 1
                            If GroupIDValue = groupTable.Rows(i)("MaterialGroupID") Then
                                FormSelected = "selected"
                                CheckGroupIDValue = True
                            Else
                                FormSelected = ""
                            End If
                            MaterialGroupString += "<option value=""" & groupTable.Rows(i)("MaterialGroupID") & """ " & FormSelected & ">" & groupTable.Rows(i)("MaterialGroupName")
                        Next
                        If CheckGroupIDValue = False Then GroupIDValue = -1
					
                        Dim CheckDeptIDValue As Boolean = False
                        For i = 0 To deptTable.Rows.Count - 1
                            If GroupIDValue = deptTable.Rows(i)("MaterialGroupID") Then
                                If DeptIDValue = deptTable.Rows(i)("MaterialDeptID") Then
                                    FormSelected = "selected"
                                    CheckDeptIDValue = True
                                Else
                                    FormSelected = ""
                                End If
                                MaterialDeptString += "<option value=""" & deptTable.Rows(i)("MaterialDeptID") & """ " & FormSelected & ">" & deptTable.Rows(i)("MaterialDeptName")
                            End If
                        Next
                        If CheckDeptIDValue = False Then DeptIDValue = -1
					
                        MaterialGroupString = "<select name=""MaterialGroupID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" + LangData.Rows(20)(LangText) + MaterialGroupString + "</select>"
					
                        MaterialDeptString = "<select name=""MaterialDeptID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" + LangData.Rows(21)(LangText) + MaterialDeptString + "</select>"
					
                        If Trim(MaterialLevelString) <> "" Then
                            SelectionText.InnerHtml = MaterialLevelString + "&nbsp;&nbsp;" + MaterialGroupString + "&nbsp;&nbsp;" + MaterialDeptString
                        Else
                            SelectionText.InnerHtml = MaterialGroupString + "&nbsp;&nbsp;" + MaterialDeptString
                        End If
					
					
                        FormAction.InnerHtml = "<form action=""Material_category.aspx?EditID=" + PageSection.ToString + ExtraQueryString + """ method=""post"">"
					
                        showAddText.InnerHtml = "<a href=""Material_category_edit2.aspx?EditID=" + PageSection.ToString + "&MaterialLevelID=" + IDValue.ToString + "&MaterialGroupID=" + GroupIDValue.ToString + "&MaterialDeptID=" + DeptIDValue.ToString + """>" + LangData.Rows(19)(LangText) + "</a>"
					
                        Dim displayTable As New DataTable()
                        displayTable = getInfo.GetMaterialInfo(DeptIDValue, 0, objCnn)
					
                        outputString = ""
                        Dim ShowComp As Boolean = False
                        Dim getPer As DataTable = objDB.List("select * from StaffPermission where PermissionItemID=121 AND StaffRoleID=" + Session("StaffRole").ToString, objCnn)
                        If getPer.Rows.Count > 0 Then
                            ShowComp = True
                        End If
                        For i = 0 To displayTable.Rows.Count - 1
                            If i Mod 2 = 0 Then
                                bColor = "white"
                            Else
                                bColor = GlobalParam.RowBGColor
                            End If
                            outputString += "<tr bgColor=""" + bColor + """><td align=""center"" class=""text"">" + (i + 1).ToString + "</td><td align=""left"" class=""text"">" & displayTable.Rows(i)("MaterialCode") & "</td>"
						
                            If headerTD5.Visible = True Then
                                outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("MaterialLevelName") & " > " & displayTable.Rows(i)("MaterialGroupName") & " > " & displayTable.Rows(i)("MaterialDeptName") & "</td>"
                            End If
												
                            If displayTable.Rows(i)("MaterialTypeID") = 1 Or showHeader.Visible = False Or showAddText.Visible = False Then
                                outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("MaterialName")
                            Else
                                outputString += "<td align=""left"" class=""text"">" + displayTable.Rows(i)("MaterialName")
                            End If
						
                            If displayTable.Rows(i)("MaterialTypeID") = 1 Or showHeader.Visible = False Or showAddText.Visible = False Then
                                outputString += "</td>"
                            Else
                                If ShowComp = True Then
                                    outputString += "&nbsp;&nbsp;<a href=""JavaScript: newWindow = window.open( 'material_component.aspx?MaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "&MaterialGroupID=" + displayTable.Rows(i)("MaterialGroupID").ToString + "&MaterialLevelID=" + IDValue.ToString + "&MaterialDeptID=" + displayTable.Rows(i)("MaterialDeptID").ToString + "', '', 'width=640,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + LangData.Rows(22)(LangText) + "</a>" + "</td>"
                                Else
                                    outputString += "</td>"
                                End If
                            End If
						
                            If headerTD7.Visible = True Then
                                outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'material_check_recipe.aspx?MaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "&MaterialGroupID=" + displayTable.Rows(i)("MaterialGroupID").ToString + "&MaterialLevelID=" + IDValue.ToString + "&MaterialDeptID=" + displayTable.Rows(i)("MaterialDeptID").ToString + "', '', 'width=1000,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + LangData.Rows(16)(LangText) + "</a></td>"
                            End If
						
                            If headerTD6.Visible = True Then
                                outputString += "<td align=""center"" class=""text"">" + "<a href=""JavaScript: newWindow = window.open( 'material_mapping_unit.aspx?MaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "&MaterialGroupID=" + displayTable.Rows(i)("MaterialGroupID").ToString + "&MaterialLevelID=" + IDValue.ToString + "&MaterialDeptID=" + displayTable.Rows(i)("MaterialDeptID").ToString + "', '', 'width=900,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + LangData.Rows(17)(LangText) + "</a></td>"
                            End If
						
                            If headerTD8.Visible = True Then
                                If displayTable.Rows(i)("MaterialID") = 164 Or displayTable.Rows(i)("MaterialID") = 169 Or displayTable.Rows(i)("MaterialID") = 171 Then
                                    outputString += "<td align=""center"" class=""text"">" + "-" + "</td>"
                                Else
                                    outputString += "<td align=""center"" class=""text"">" + "<a href=""JavaScript: newWindow = window.open( 'material_mapping_mac4.aspx?MaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "&MaterialGroupID=" + displayTable.Rows(i)("MaterialGroupID").ToString + "&MaterialLevelID=" + IDValue.ToString + "&MaterialDeptID=" + displayTable.Rows(i)("MaterialDeptID").ToString + "', '', 'width=600,height=400,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + LangData.Rows(18)(LangText) + "</a></td>"
                                End If
                            End If
						
                            If bolFromProductComponent = True Then
                                Dim GoBackUrl As String = "product_component.aspx"
                                If Request.QueryString("From") <> "component" Then
                                    If Request.QueryString("From") = "mcomponent" Then
                                        GoBackUrl = "material_component.aspx"
                                    Else
                                        GoBackUrl = Request.QueryString("From")
                                    End If
                                End If
                                If Request.QueryString("From") = "mcomponent" Then
                                    If Request.QueryString("MaterialID") = displayTable.Rows(i)("MaterialID") Then
                                        outputString += "<td align=""center"" class=""text"">" & "-" & "</td>"
                                    Else
                                        outputString += "<td align=""center"" class=""text""><a href="""" onclick=""opener.location.href='" + GoBackUrl + "?SelMaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "&" + Request.QueryString.ToString + "'; window.close(); return false;"">" & LangData.Rows(23)(LangText) & "</a></td>"
                                    End If
                                Else
                                    outputString += "<td align=""center"" class=""text""><a href="""" onclick=""opener.location.href='" + GoBackUrl + "?MaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "&" + Request.QueryString.ToString + "'; window.close(); return false;"">" & LangData.Rows(23)(LangText) & "</a></td>"
                                End If
                            Else
                                If showHeader.Visible = True Then
                                    If headerTD3.Visible = True Then
                                        outputString += "<td align=""center"" class=""text""><a href=""Material_category_edit2.aspx?MaterialGroupID=" & displayTable.Rows(i)("MaterialGroupID") & "&MaterialLevelID=" & IDValue.ToString & "&MaterialDeptID=" & displayTable.Rows(i)("MaterialDeptID") & "&EditID=3&MaterialID=" & displayTable.Rows(i)("MaterialID") & """>" & LangData.Rows(9)(LangText) & "</a></td>"
                                    End If
                                    If headerTD4.Visible = True Then
                                        outputString += "<td align=""center"" class=""text""><a href=""material_delete.aspx?EditID=3&MaterialID=" & displayTable.Rows(i)("MaterialID") & "&MaterialLevelID=" & IDValue.ToString & "&MaterialGroupID=" & GroupIDValue.ToString & "&MaterialDeptID=" & DeptIDValue.ToString & """>" & LangData.Rows(10)(LangText) & "</a></td>"
                                    End If
                                Else
                                    Dim GoBackUrl As String = "product_component.aspx"
                                    If Request.QueryString("From") <> "component" Then
                                        If Request.QueryString("From") = "mcomponent" Then
                                            GoBackUrl = "material_component.aspx"
                                        Else
                                            GoBackUrl = Request.QueryString("From")
                                        End If
                                    End If
                                    If Request.QueryString("From") = "mcomponent" Then
                                        If Request.QueryString("MaterialID") = displayTable.Rows(i)("MaterialID") Then
                                            outputString += "<td align=""center"" class=""text"">" & "-" & "</td>"
                                        Else
                                            outputString += "<td align=""center"" class=""text""><a href="""" onclick=""opener.location.href='" + GoBackUrl + "?SelMaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "&" + Request.QueryString.ToString + "'; window.close(); return false;"">" & LangData.Rows(23)(LangText) & "</a></td>"
                                        End If
                                    Else
                                        outputString += "<td align=""center"" class=""text""><a href="""" onclick=""opener.location.href='" + GoBackUrl + "?MaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "&" + Request.QueryString.ToString + "'; window.close(); return false;"">" & LangData.Rows(23)(LangText) & "</a></td>"
                                    End If
                                End If
                            End If
                            outputString += "</tr>"
                        Next
                        ResultText.InnerHtml = outputString
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
	
        Dim GetProperty As DataTable = getProp.PropertyValue(2, 1, 1, objCnn)
        Dim UnitInputType As DataTable = getProp.PropertyValue(2, 7, 1, objCnn)
        If GetProperty.Rows.Count = 1 Then
            If GetProperty.Rows(0)("PropertyValue") = 1 Then
                If UnitInputType.Rows.Count = 0 Then
                    headerTD6.Visible = True
                Else
                    If UnitInputType.Rows(0)("PropertyValue") = 0 Then
                        headerTD6.Visible = True
                    End If
                End If
            End If
        End If
	
        GetProperty = getProp.PropertyValue(2, 2, 1, objCnn)
        If GetProperty.Rows.Count = 1 Then
            If GetProperty.Rows(0)("PropertyValue") = 1 Then
                headerTD8.Visible = True
            End If
        End If
        showAddText.Visible = False
        
        If bolFromProductComponent = True Then
            headerTD7.Visible = False
            headerTD6.Visible = False
        Else
            headerTD7.Visible = True
        End If
        		
        'Dim LangData As DataTable = getProp.GetLangData(2,1,0,Request)
        Dim PageName As String = System.IO.Path.GetFileName(Request.ServerVariables("SCRIPT_NAME"))
        Dim LangListText As String = ""
        Dim LangListData As DataTable
        Dim LangData As DataTable = getProp.GetLang(LangListText, LangListData, PageName & "?ID" & Request.QueryString("ID") & "&Order=" + Request.QueryString("Order") & "&GroupID=" & Request.QueryString("GroupID"), 2, 1, -1, Request, objCnn)
	
        Dim LangText As String = "lang" + Session("LangID").ToString
	
        CodeText.InnerHtml = LangData.Rows(14)(LangText)
        NameText.InnerHtml = LangData.Rows(15)(LangText)
			
        Dim displayTable As New DataTable()
        displayTable = getInfo.SearchMaterial(Trim(Keyword.Text), "MaterialName", objCnn)
	
        'Dim testString As String = getInfo.SearchMaterialTest(Trim(Keyword.Text),"MaterialName",objCnn)
	
        Dim outputString As String = ""
        Dim i As Integer
        Dim bColor As String
        For i = 0 To displayTable.Rows.Count - 1
		
            If i Mod 2 = 0 Then
                bColor = "white"
            Else
                bColor = GlobalParam.RowBGColor
            End If
						
            outputString += "<tr bgColor=""" + bColor + """><td align=""center"" class=""text"">" + (i + 1).ToString + "</td><td align=""left"" class=""text"">" & displayTable.Rows(i)("MaterialCode") & "</td>"
            If headerTD5.Visible = True Then
                outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("MaterialLevelName") & " > " & displayTable.Rows(i)("MaterialGroupName") & " > " & displayTable.Rows(i)("MaterialDeptName") & "</td>"
            End If
            outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("MaterialName") & "</td>"
		
            If headerTD7.Visible = True Then
                outputString += "<td align=""center"" class=""text""><a href=""JavaScript: newWindow = window.open( 'material_check_recipe.aspx?MaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "', '', 'width=1000,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + LangData.Rows(16)(LangText) + "</a></td>"
            End If
		
            If headerTD6.Visible = True Then
                outputString += "<td align=""center"" class=""text"">" + "<a href=""JavaScript: newWindow = window.open( 'material_mapping_unit.aspx?MaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "&MaterialGroupID=" + displayTable.Rows(i)("MaterialGroupID").ToString + "&MaterialLevelID=1&MaterialDeptID=" + displayTable.Rows(i)("MaterialDeptID").ToString + "', '', 'width=900,height=530,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + LangData.Rows(17)(LangText) + "</a></td>"
            End If
		
            If headerTD8.Visible = True Then
                If displayTable.Rows(i)("MaterialID") = 164 Or displayTable.Rows(i)("MaterialID") = 169 Or displayTable.Rows(i)("MaterialID") = 171 Then
                    outputString += "<td align=""center"" class=""text"">" + "-" + "</td>"
                Else
                    outputString += "<td align=""center"" class=""text"">" + "<a href=""JavaScript: newWindow = window.open( 'material_mapping_mac4.aspx?MaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "&MaterialGroupID=" + displayTable.Rows(i)("MaterialGroupID").ToString + "&MaterialLevelID=1&MaterialDeptID=" + displayTable.Rows(i)("MaterialDeptID").ToString + "', '', 'width=600,height=400,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + LangData.Rows(18)(LangText) + "</a></td>"
                End If
            End If

            If bolFromProductComponent = True Then
                Dim GoBackUrl As String
                Select Case Request.QueryString("From")
                    Case "component"
                        GoBackUrl = "product_component.aspx"
                    Case "mcomponent"
                        GoBackUrl = "material_component.aspx"
                    Case Else
                        GoBackUrl = Request.QueryString("From")
                End Select
                If Request.QueryString("From") = "mcomponent" Then
                    outputString += "<td align=""center"" class=""text""><a href="""" onclick=""opener.location.href='" + GoBackUrl + "?SelMaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "&" + Request.QueryString.ToString + "'; window.close(); return false;"">" & LangData.Rows(23)(LangText) & "</a></td>"
                Else
                    outputString += "<td align=""center"" class=""text""><a href="""" onclick=""opener.location.href='" + GoBackUrl + "?MaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "&" + Request.QueryString.ToString + "'; window.close(); return false;"">" & LangData.Rows(23)(LangText) & "</a></td>"
                End If
            Else
                If showHeader.Visible = True Then
                    If headerTD3.Visible = True Then
                        outputString += "<td align=""center"" class=""text""><a href=""Material_category_edit2.aspx?Keyword=" + Trim(Keyword.Text) + "&EditID=3&MaterialID=" & displayTable.Rows(i)("MaterialID") & """>" & LangData.Rows(9)(LangText) & "</a></td>"
                    End If
			
                    If headerTD4.Visible = True Then
                        outputString += "<td align=""center"" class=""text""><a href=""inv_category_action.aspx?action=delete_category&action_to=material&EditID=3&DelID=" & displayTable.Rows(i)("MaterialID") & "&Keyword=" & Trim(Keyword.Text) & """ onClick=""javascript: return confirm('" & LangData.Rows(24)(LangText) & " " & Replace(displayTable.Rows(i)("MaterialName"), "'", "\'") & " " & LangData.Rows(25)(LangText) & "')"">" & LangData.Rows(10)(LangText) & "</a></td>"
                    End If
                Else
                    Dim GoBackUrl As String
                    Select Case Request.QueryString("From")
                        Case "component"
                            GoBackUrl = "product_component.aspx"
                        Case "mcomponent"
                            GoBackUrl = "material_component.aspx"
                        Case Else
                            GoBackUrl = Request.QueryString("From")
                    End Select
                    If Request.QueryString("From") = "mcomponent" Then
                        outputString += "<td align=""center"" class=""text""><a href="""" onclick=""opener.location.href='" + GoBackUrl + "?SelMaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "&" + Request.QueryString.ToString + "'; window.close(); return false;"">" & LangData.Rows(23)(LangText) & "</a></td>"
                    Else
                        outputString += "<td align=""center"" class=""text""><a href="""" onclick=""opener.location.href='" + GoBackUrl + "?MaterialID=" + displayTable.Rows(i)("MaterialID").ToString + "&" + Request.QueryString.ToString + "'; window.close(); return false;"">" & LangData.Rows(23)(LangText) & "</a></td>"
                    End If
                End If
            End If

            outputString += "</tr>"
        Next
        ResultText.InnerHtml = outputString
        'errorMsg.InnerHtml = "OK" + " " + displayTable.Rows.Count.ToString + "<br>" + testString
    End Sub
		
Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
