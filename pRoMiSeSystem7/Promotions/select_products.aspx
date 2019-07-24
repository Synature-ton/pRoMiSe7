<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="RewardModule.RewardPoint" %>
<html>
<head>
<title>Manage Products</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body style="background-color:white">

<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<div id="FormParam" runat="server"></div>
<input type="hidden" id="TypeID" runat="server" />
<input type="hidden" id="LinkID" runat="server" />
<table cellpadding="2" cellspacing="2" width="100%">
<tr>
<td><div id="LinkText" class="text" runat="server"></div></td>
<td align="right"><div class="headerText" align="right" id="HeaderText" runat="server" /></td>
</tr>
<tr><td colspan="2"><hr size="0"></td></tr>
</table>
<SCRIPT language="JavaScript">
		function CheckAll(checked) {
			len = document.forms[0].selList.length;
			var i=0;
			for( i=0; i<len; i++) {
				document.forms[0].selList[i].checked=checked;
			}
		}
</script>
<table width="90%">
<tr>
	<td align="left"><div id="SelectionText" class="text" runat="server"></div></td>
	<td align="right"><div id="showAddText" visible=true runat="server"></div></td>
</tr>
<span id="MessageText" class="boldText" runat="server"></span>
<tr id="ShowCheckAll" runat="server">
	<td class="text" colspan="2"><a href="javascript:CheckAll(true)">Select&nbsp;All</a> - <a href="javascript:CheckAll(false)">Clear&nbsp;All</a></td>
</tr>
<tr><td colspan="2">
<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTD3" align="center" class="tdHeader" runat="server" width="30"><div id="Default_SelectText" runat="server"></div></td>
		<td id="headerTD1" align="center" class="tdHeader" runat="server" width="200"><div id="CodeText" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="NameText" runat="server"></div></td>
	</tr>
	
	<div id="ResultText" runat="server"></div>

</table>
</td></tr>
<tr id="showUpdate" visible="false" runat="server">

	<td colspan="2"><input type="submit" name="submitForm" value=" update "></td>
</tr>
</table>
</form>

<div id="errorMsg" runat="server" />

<script language="VB" runat="server">
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim objDB As New CDBUtil()
Dim getInfo As New CCategory()
Dim getPageText As New DefaultText()
Dim getMember As New CMembers()
Dim getPromo As New CPromotions()
Dim getRole As New CStaffRole()
Dim userInfo As New CStaffs()
Dim getData As New CPreferences()
Dim getReward As New ManageReward()
Dim DateTimeUtil As New MyDateTime()
Sub Page_Load()
	If User.Identity.IsAuthenticated Then
		
		headerTD1.BgColor = GlobalParam.AdminBGColor
		headerTD2.BgColor = GlobalParam.AdminBGColor
		headerTD3.BgColor = GlobalParam.AdminBGColor
		
		'Try
			objCnn = getCnn.EstablishConnection()	
			
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(7,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			ShowCheckAll.Visible = False
			Default_SelectText.InnerHtml = defaultTextTable.Rows(9)("TextParamValue")

			MessageText.InnerHtml = ""
			
			
			Dim ExtraURL As String = "&TypeID=" + Request.QueryString("TypeID") + "&LinkID=" + Request.QueryString("LinkID")
			
			If IsNumeric(Request.QueryString("TypeID")) Then
				TypeID.Value = Request.QueryString("TypeID")
			End If
			If IsNumeric(Request.QueryString("LinkID")) Then
				LinkID.Value = Request.QueryString("LinkID")
			End If
			
			If TypeID.Value = 6 Then
				Response.Redirect("../Commission/config_products.aspx?TypeID=" + TypeID.Value.ToString + "&LinkID=" + LinkID.Value.ToString + "&EditID=" + Request.QueryString("EditID").ToString)
			End If
			
			Dim AdditionalHeaderText As String = ""
			Dim ConfigType As New DataTable()
			If TypeID.Value = 1 Then
				ConfigType = getMember.GetMemberInfo(99,LinkID.Value,-1,-1,"",objCnn)
				If ConfigType.Rows.Count > 0 Then
					AdditionalHeaderText = ConfigType.Rows(0)("MemberGroupName")
				End If
			Else If TypeID.Value = 2 or TypeID.Value = 6 Then
				ConfigType = getPromo.GetPromotionInfo(LinkID.Value,-1,"",objCnn)
				If ConfigType.Rows.Count > 0 Then
					AdditionalHeaderText = ConfigType.Rows(0)("PromotionPriceName")
				End If
			Else If TypeID.Value = 3 Then
				ConfigType = getRole.GetRoleInfo(99,LinkID.Value,-1,-1,"",objCnn)
				If ConfigType.Rows.Count > 0 Then
					AdditionalHeaderText = ConfigType.Rows(0)("StaffRoleName")
				End If
			Else If TypeID.Value = 4 Or TypeID.Value = 5 Then
				ConfigType = getPromo.GetCVPromo(-1,LinkID.Value,"",objCnn)
				If ConfigType.Rows.Count > 0 Then
					AdditionalHeaderText = ConfigType.Rows(0)("VoucherTypeName")
				End If
			Else If TypeID.Value = 7 Then
				ConfigType = getPromo.GetCommissionInfo(LinkID.Value, -1,2, "", objCnn)
				If ConfigType.Rows.Count > 0 Then
					AdditionalHeaderText = ConfigType.Rows(0)("CommissionName")
				End If	
			Else If TypeID.Value = 10 Then
				ConfigType = getReward.GetRewardInfo(LinkID.Value,-1,"", objCnn)
				If ConfigType.Rows.Count > 0 Then
					AdditionalHeaderText = ConfigType.Rows(0)("RewardName")
				End If	
			Else If TypeID.Value = 99 Then
				ConfigType = userInfo.GetStaffInfo(LinkID.Value, objCnn)
				If ConfigType.Rows.Count > 0 Then
					AdditionalHeaderText = ConfigType.Rows(0)("StaffFirstName") + " " + ConfigType.Rows(0)("StaffLastName")
				End If	
			Else If TypeID.Value = 999 Then
				ConfigType = getData.TableInfo(2,0,0,LinkID.Value,objCnn)
				If ConfigType.Rows.Count > 0 Then
					AdditionalHeaderText = ConfigType.Rows(0)("TableName")
				End If	
			End If
			
			HeaderText.InnerHtml = textTable.Rows(64)("TextParamValue") + " " + AdditionalHeaderText
			
			
			Dim LinkString As String = ""
			Dim outputString As String = ""
			Dim selList As String = ""
			Dim PageSection As Integer = 1
			Dim i As integer
			Dim FormSelected As String
			Dim ShowTableContent As Boolean = True
			
			Dim IDValue As Integer = -1
			If IsNumeric(Request.Form("ProductLevelID")) Then
				IDValue = Request.Form("ProductLevelID")
			Else If IsNumeric(Request.QueryString("ProductLevelID"))
				IDValue = Request.QueryString("ProductLevelID")
			End If
			
			Dim GroupIDValue As Integer = -1
			If IsNumeric(Request.Form("ProductGroupID")) Then
				GroupIDValue = Request.Form("ProductGroupID")
			Else If IsNumeric(Request.QueryString("ProductGroupID"))
				GroupIDValue = Request.QueryString("ProductGroupID")
			End If
			
			Dim DeptIDValue As Integer = -1
			If IsNumeric(Request.Form("ProductDeptID")) Then
				DeptIDValue = Request.Form("ProductDeptID")
			Else If IsNumeric(Request.QueryString("ProductDeptID"))
				DeptIDValue = Request.QueryString("ProductDeptID")
			End If
			
			If NOT Request.QueryString("EditID") AND IsNumeric(Request.QueryString("EditID")) Then
				If Request.QueryString("EditID") = 1 Then
					LinkString = "[" +  textTable.Rows(12)("TextParamValue") + "]&nbsp;&nbsp;[<a href=""select_products.aspx?EditID=2" + "&ProductLevelID=" + IDValue.ToString + ExtraURL + """>" +  textTable.Rows(13)("TextParamValue") + "</a>]&nbsp;&nbsp;[<a href=""select_products.aspx?EditID=3&ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + GroupIDValue.ToString + ExtraURL + """>"  +  textTable.Rows(39)("TextParamValue") + "</a>]"
				Else If Request.QueryString("EditID") = 2 Then
					LinkString = "[<a href=""select_products.aspx?EditID=1" + "&ProductLevelID=" + IDValue.ToString + ExtraURL + """>" +  textTable.Rows(12)("TextParamValue") + "</a>]&nbsp;&nbsp;[" +  textTable.Rows(13)("TextParamValue") + "]&nbsp;&nbsp;[<a href=""select_products.aspx?EditID=3&ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + GroupIDValue.ToString + ExtraURL + """>"  +  textTable.Rows(39)("TextParamValue") + "</a>]"
					PageSection = 2
				Else
					LinkString = "[<a href=""select_products.aspx?EditID=1" + "&ProductLevelID=" + IDValue.ToString + ExtraURL + """>" +  textTable.Rows(12)("TextParamValue") + "</a>]&nbsp;&nbsp;[<a href=""select_products.aspx?EditID=2" + "&ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + GroupIDValue.ToString + ExtraURL + """>" +  textTable.Rows(13)("TextParamValue") + "</a>]&nbsp;&nbsp;["  +  textTable.Rows(39)("TextParamValue") + "]"
					PageSection = 3
				End If
			Else
				LinkString = "[" +  textTable.Rows(12)("TextParamValue") + "]&nbsp;&nbsp;[<a href=""select_products.aspx?EditID=2" + "&ProductLevelID=" + IDValue.ToString + ExtraURL + """>" + textTable.Rows(13)("TextParamValue")  + "</a>]&nbsp;&nbsp;[<a href=""select_products.aspx?EditID=3&ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + GroupIDValue.ToString + ExtraURL + """>"  +  textTable.Rows(39)("TextParamValue") + "</a>]"
			End If
			LinkText.InnerHtml = LinkString
			
			
			If Not Page.IsPostBack AND Not Request.Form("SubmitForm") is Nothing Then
				Dim Result As String
				If IsNumeric(TypeID.Value) AND IsNumeric(LinkID.Value) AND IsNumeric(Request.QueryString("EditID")) AND IsNumeric(IDValue) Then
					Dim SelID As Integer
					If PageSection = 1 Then
						SelID = IDValue
					Else If PageSection = 2 Then
						SelID = GroupIDValue
					Else If PageSection = 3 Then
						SelID = DeptIDValue
					End If

					If TypeID.Value = 6 Or TypeID.Value = 7 Or TypeID.Value = 99 Or TypeID.Value = 999 Or TypeID.Value = 10 Or TypeID.Value = 2 Then
						Result = getInfo.AddUpdateSelectedProduct(SelID,TypeID.Value,LinkID.Value,Request.QueryString("EditID"),Request.Form("selList"),objCnn)
					Else
						Result = getInfo.AddUpdatePromoProduct(SelID,TypeID.Value,LinkID.Value,Request.QueryString("EditID"),Request.Form("selList"),objCnn)
					End If
					
					If Result = "Success" Then
						MessageText.InnerHtml = "<tr><td colspan=""2"" class=""boldText"">Data have been updated</td></tr>"
					Else
						MessageText.InnerHtml = "<tr><td colspan=""2"" class=""boldText"">" + Result + "</td></tr>"
					End If
				Else
					MessageText.InnerHtml =  "<tr><td colspan=""2"" class""errorText"">Invalid Param</td></tr>"
				End If
			'Else
				'MessageText.InnerHtml = "<tr><td colspan=""2"" class=""boldText"">Not update</td></tr>"
			End If
			
			Dim dtTable As New DataTable()
			Dim selDataList,Checked,compareString As String
			
			If PageSection = 1 Then
				
				CodeText.InnerHtml = textTable.Rows(14)("TextParamValue")
				NameText.InnerHtml = textTable.Rows(15)("TextParamValue")
				
				Dim ProductLevelType As Integer
				
				Dim selectionTable As New DataTable()
				
				selectionTable = getInfo.GetProductLevel(-88,objCnn)
				
				Dim displayTable As New DataTable()
				
				If  selectionTable.Rows.Count = 0 Then
					ShowTableContent = False
					ShowAddText.Visible = False
					SelectionText.InnerHtml = textTable.Rows(19)("TextParamValue")
				Else 
					If selectionTable.Rows.Count > 1 Then
						displayTable = getInfo.GetProductGroup(IDValue,0,objCnn)
						dtTable = getInfo.GetPromoProduct(IDValue,TypeID.Value,LinkID.Value,1,objCnn)
						selDataList = ""
						For i = 0 to dtTable.Rows.Count - 1
							selDataList += "," + dtTable.Rows(i)("ProductGroupID").ToString
						Next
						selDataList += ","
						
						Dim SelectString As String = textTable.Rows(26)("TextParamValue")
						If IDValue = -1 Then
							FormSelected = "selected"
						Else
							FormSelected = ""
						End If
						outputString = "<select name=""ProductLevelID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" & textTable.Rows(18)("TextParamValue")

						For i = 0 to selectionTable.Rows.Count - 1
							If IDValue = selectionTable.Rows(i)("ProductLevelID") Then
								FormSelected = "selected"
							Else
								FormSelected = ""
							End If
							outputString += "<option value=""" & selectionTable.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & selectionTable.Rows(i)("ProductLevelName")
						Next
						SelectionText.InnerHtml = outputString
					Else
						IDValue = selectionTable.Rows(0)("ProductLevelID")
						displayTable = getInfo.GetProductGroup(IDValue,0,objCnn)
						dtTable = getInfo.GetPromoProduct(IDValue,TypeID.Value,LinkID.Value,1,objCnn)
						selDataList = ""
						For i = 0 to dtTable.Rows.Count - 1
							selDataList += "," + dtTable.Rows(i)("ProductGroupID").ToString
						Next
						selDataList += ","
					End If
					
					outputString = ""

					
					For i = 0 to displayTable.Rows.Count - 1
						compareString = "," & CStr(displayTable.Rows(i)("ProductGroupID")) & ","
						Checked = ""
						If selDataList.IndexOf(compareString) <> -1 Then
							Checked = "checked"
						End If
						outputString += "<tr><td align=""center"" class=""text"" width=""30""><input type=""checkbox"" name=""selList"" value=""" & displayTable.Rows(i)("ProductGroupID").ToString & """" + Checked + "></td>"
		
						outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("ProductGroupCode") & "</td>"
						
						
						outputString += "<td align=""left"" class=""text""><a href=""select_products.aspx?EditID=2&ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + displayTable.Rows(i)("ProductGroupID").ToString + ExtraURL + """>" & displayTable.Rows(i)("ProductGroupName") & "</a></td>"
		
						outputString += "</tr>"
					Next
					ResultText.InnerHtml = outputString
					If displayTable.Rows.Count > 0 Then
						'SubmitForm.Enabled = True
						ShowCheckAll.Visible = True
						showUpdate.Visible = True
					End If

					'FormAction.InnerHtml = "<form action=""select_products.aspx"" method=""post"">"
				End If
			Else If PageSection = 2 Then
				
				
				CodeText.InnerHtml = textTable.Rows(27)("TextParamValue")
				NameText.InnerHtml = textTable.Rows(28)("TextParamValue")
				
				Dim levelTable As New DataTable()
				levelTable = getInfo.GetProductLevel(-88,objCnn)
				
				Dim groupTable As New DataTable()
				groupTable = getInfo.GetProductGroup(0,0,objCnn)
				
				Dim ProductLevelString As String = ""
				Dim ProductGroupString As String = ""
				
				If IDValue = 0 Then IDValue = -1
				
				If  groupTable.Rows.Count = 0 Then
					ShowTableContent = False
					ShowAddText.Visible = False
					SelectionText.InnerHtml = textTable.Rows(32)("TextParamValue")
				Else
					
					If levelTable.Rows.Count > 1 Then
						For i = 0 to levelTable.Rows.Count - 1
							If IDValue = levelTable.Rows(i)("ProductLevelID") Then
								FormSelected = "selected"
							Else
								FormSelected = ""
							End If
							ProductLevelString += "<option value=""" & levelTable.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & levelTable.Rows(i)("ProductLevelName")
						Next
						ProductLevelString = "<select name=""ProductLevelID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" + textTable.Rows(18)("TextParamValue") + ProductLevelString + "</select>"
					Else
						IDValue = levelTable.Rows(0)("ProductLevelID")
					End If
					
					Dim CheckGroupIDValue As Boolean = False
					For i = 0 to groupTable.Rows.Count - 1
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
				
					'FormAction.InnerHtml = "<form action=""select_products.aspx?EditID=" + PageSection.ToString + """ method=""post"">"
					
					Dim displayTable As New DataTable()
					displayTable = getInfo.GetProductDept(GroupIDValue,0,objCnn)
					dtTable = getInfo.GetPromoProduct(GroupIDValue,TypeID.Value,LinkID.Value,2,objCnn)
					selDataList = ""
					For i = 0 to dtTable.Rows.Count - 1
						selDataList += "," + dtTable.Rows(i)("ProductDeptID").ToString
					Next
					selDataList += ","
					
					outputString = ""
					For i = 0 to displayTable.Rows.Count - 1
						compareString = "," & CStr(displayTable.Rows(i)("ProductDeptID")) & ","
						Checked = ""
						If selDataList.IndexOf(compareString) <> -1 Then
							Checked = "checked"
						End If
						outputString += "<tr><td align=""center"" class=""text"" width=""30""><input type=""checkbox"" name=""selList"" value=""" & displayTable.Rows(i)("ProductDeptID").ToString & """" + Checked + "></td>"
						outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("ProductDeptCode") & "</td>"
						
						
						outputString += "<td align=""left"" class=""text""><a href=""select_products.aspx?EditID=3&ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + GroupIDValue.ToString + "&ProductDeptID=" + displayTable.Rows(i)("ProductDeptID").ToString + ExtraURL + """>" & displayTable.Rows(i)("ProductDeptName") & "</a></td>"
		
						outputString += "</tr>"
					Next
					ResultText.InnerHtml = outputString
					If displayTable.Rows.Count > 0 Then
						'SubmitForm.Enabled = True
						ShowCheckAll.Visible = True
						showUpdate.Visible = True
					End If
				End If
			Else
			
				' -----------------Product Info-------------------------
				
				CodeText.InnerHtml = textTable.Rows(40)("TextParamValue")
				NameText.InnerHtml = textTable.Rows(41)("TextParamValue")
				
				
				Dim levelTable As New DataTable()
				levelTable = getInfo.GetProductLevel(-88,objCnn)
				
				If levelTable.Rows.Count = 1 Then
					IDValue = levelTable.Rows(0)("ProductLevelID")
				End If
				
				Dim groupTable As New DataTable()
				groupTable = getInfo.GetProductGroup(IDValue,0,objCnn)
				
				Dim deptTable As New DataTable()
				deptTable = getInfo.GetProductDept(0,0,objCnn)
				
				If IDValue = 0 Then IDValue = -1
				If GroupIDValue = 0 Then GroupIDValue = -1
				If DeptIDValue = 0 Then DeptIDValue = -1
				
				Dim ProductLevelString As String = ""
				Dim ProductGroupString As String = ""
				Dim ProductDeptString As String = ""
				
				If  deptTable.Rows.Count = 0 Then
					ShowTableContent = False
					ShowAddText.Visible = False
					SelectionText.InnerHtml = textTable.Rows(45)("TextParamValue")
				Else
					
					If levelTable.Rows.Count > 1 Then
						For i = 0 to levelTable.Rows.Count - 1
							If IDValue = levelTable.Rows(i)("ProductLevelID") Then
								FormSelected = "selected"
							Else
								FormSelected = ""
							End If
							ProductLevelString += "<option value=""" & levelTable.Rows(i)("ProductLevelID") & """ " & FormSelected & ">" & levelTable.Rows(i)("ProductLevelName")
						Next
						ProductLevelString = "<select name=""ProductLevelID"" onchange=""submit()""><option value=""-1""" + FormSelected + ">" + textTable.Rows(18)("TextParamValue") + ProductLevelString + "</select>"
					Else
						IDValue = levelTable.Rows(0)("ProductLevelID")
					End If
					
					Dim CheckGroupIDValue As Boolean = False
					For i = 0 to groupTable.Rows.Count - 1
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
					For i = 0 to deptTable.Rows.Count - 1
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
					
					If Trim(ProductLevelString) <> "" Then
						SelectionText.InnerHtml = ProductLevelString + "&nbsp;&nbsp;" + ProductGroupString + "&nbsp;&nbsp;" +  ProductDeptString
					Else
						SelectionText.InnerHtml = ProductGroupString + "&nbsp;&nbsp;" + ProductDeptString
					End If
				
					'FormAction.InnerHtml = "<form action=""select_products.aspx?EditID=" + PageSection.ToString + """ method=""post"">"
					
					Dim displayTable As New DataTable()
					displayTable = getInfo.GetProductInfo(DeptIDValue,-99,objCnn)
					dtTable = getInfo.GetPromoProduct(DeptIDValue,TypeID.Value,LinkID.Value,3,objCnn)
					selDataList = ""
					For i = 0 to dtTable.Rows.Count - 1
						selDataList += "," + dtTable.Rows(i)("ProductID").ToString
					Next
					selDataList += ","
					
					outputString = ""
					For i = 0 to displayTable.Rows.Count - 1
						compareString = "," & CStr(displayTable.Rows(i)("ProductID")) & ","
						Checked = ""
						If selDataList.IndexOf(compareString) <> -1 Then
							Checked = "checked"
						End If
						outputString += "<tr><td align=""center"" class=""text"" width=""30""><input type=""checkbox"" name=""selList"" value=""" & displayTable.Rows(i)("ProductID").ToString & """" + Checked + "></td>"
						outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("ProductCode") & "</td>"
						
						
						outputString += "<td align=""left"" class=""text"">" & displayTable.Rows(i)("ProductName") & "</td>"
		
						outputString += "</tr>"
					Next
					ResultText.InnerHtml = outputString
					If displayTable.Rows.Count > 0 Then
						'SubmitForm.Enabled = True
						ShowCheckAll.Visible = True
						showUpdate.Visible = True
					End If
					'errorMsg.InnerHtml = IDValue.ToString + ":" + GroupIDValue.ToString + ":" + DeptIDValue.ToString
				End If
			End If
			FormParam.InnerHtml = "<form action=""select_products.aspx?ProductLevelID=" + IDValue.ToString + "&ProductGroupID=" + GroupIDValue.ToString  + "&ProductDeptID=" + DeptIDValue.ToString + "&EditID=" + Request.QueryString("EditID").ToString + ExtraURL + """ method=""post"">"
			'errorMsg.InnerHtml = selDataList
		'Catch ex As Exception
			'errorMsg.InnerHtml = ex.Message
		'End Try
	Else
		updateMessage.Text = "Access Denied"
	End If
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>