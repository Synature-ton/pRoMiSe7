<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<html>
<head>
<title>Select Promotion</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body<% = GlobalParam.BodyProp %>>
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText">Select Promotion to Front System</b>
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
<ASP:Label id="updateMessage" CssClass="text" runat="server" />
<div id="showContent" visible="true" runat="server">
<form runat="server">

<table id="myTable" border="0" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td valign="top">
			<table>
				<tr>
					<td colspan="3" class="text">Please Select Promotion</td>
				</tr>
				<span id="MemberError" class="errorText" runat="server"></span>
				<tr id="memberold" visible="false" runat="server">
					<td><asp:RadioButton ID="Type_0" GroupName="PromoType" CssClass="text" Text="Member" runat="server" /></td>
					<td><asp:DropDownList ID="MemberGroup" Width="170" OnSelectedIndexChanged="SelMemberGroup" AutoPostBack="true" runat="server" /></td>
					<td><asp:DropDownList ID="MemberData" Width="170" OnSelectedIndexChanged="SelMember" AutoPostBack="true" runat="server" /></td>
				</tr>
                <tr>
					<td><asp:RadioButton ID="Type_1" GroupName="PromoType" CssClass="text" Text="Member" runat="server" /></td>
					<td><asp:TextBox ID="MemberCode" Width="170" runat="server" /></td>
                    <td class="text">Please input member code</td>
				</tr>
				<span id="StaffError" class="errorText" runat="server"></span>
				<tr>
					<td><asp:RadioButton ID="Type_2" GroupName="PromoType" CssClass="text" Text="Staff" runat="server" /></td>
					<td><asp:DropDownList ID="StaffGroup" Width="170" OnSelectedIndexChanged="SelStaffGroup" AutoPostBack="true" runat="server" /></td>
					<td><asp:DropDownList ID="StaffData" Width="170" OnSelectedIndexChanged="SelStaff" AutoPostBack="true" runat="server" /></td>
				</tr>
				<span id="CouponError" class="errorText" runat="server"></span>
				<tr>
					<td><asp:RadioButton ID="Type_3" GroupName="PromoType" CssClass="text" Text="Coupon" runat="server" /></td>
					<td><asp:DropDownList ID="CouponGroup" Width="170" OnSelectedIndexChanged="SelCouponGroup" AutoPostBack="true" runat="server" /></td>
					<td></td>
				</tr>
                <span id="VoucherError" class="errorText" runat="server"></span>
				<tr>
					<td><asp:RadioButton ID="Type_5" GroupName="PromoType" CssClass="text" Text="Voucher" runat="server" /></td>
					<td><asp:DropDownList ID="VoucherGroup" Width="170" OnSelectedIndexChanged="SelVoucherGroup" AutoPostBack="true" runat="server" /></td>
					<td></td>
				</tr>
				<span id="DiscountError" class="errorText" runat="server"></span>
				<tr>
					<td><asp:RadioButton ID="Type_4" GroupName="PromoType" CssClass="text" Text="Discount" runat="server" /></td>
					<td><asp:TextBox ID="Discount" Width="95" runat="server" /> <asp:dropdownlist ID="PercentUnit" OnSelectedIndexChanged="SelDiscount" AutoPostBack="true" Width="70" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
					<td></td>
				</tr>
                <tr id="showSaleMode" visible="false" runat="server">
                	<td class="text" align="right">Sale Mode:</td>
                    <td colspan="2"><span id="SaleModeText" runat="server"></span></td>
                </tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2"><asp:Button ID="SubmitMove" CommandName="SubmitMove" Text=" Add " OnCommand="Select_Promotion" runat="server" /></td>
				</tr>
			</table>
		</td>
		<td>&nbsp;&nbsp;</td>
		<td valign="top">
			<table>
				<tr>
					<td class="text" valign="top" colspan="2">Selected Promotion(s)</td>
				</tr>
				<tr id="selectError" runat="server">
					<td class="errorText" valign="top" colspan="2">Please select at least one item</td>
				</tr>
				<tr>
					<td><asp:ListBox ID="DiscountButtonList" Height="300" Width="430" CssClass="text" runat="server" /></td>
					<td valign="top"><asp:Button ID="MoveUp" CommandName="MoveUp" Width="50" Text="Up" OnCommand="Move_Up" runat="server" /><br><br><asp:Button ID="MoveDown" CommandName="MoveDown" Text="Down" Width="50" OnCommand="Move_Down" runat="server" /><br><br><asp:TextBox ID="Ordering" Width="50" runat="server"/><br><br><asp:Button ID="MoveItem" CommandName="Move" Text="Move" Width="50" OnCommand="Move_Item" runat="server" /></td>
				</tr>
				<tr>
					<td colspan="2"><asp:Button ID="DelItem" CommandName="DelItem" Text=" Delete " OnCommand="Del_Item" runat="server" /></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</form>
</div>
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
Dim getData As New CPromotions()
Dim getPageText As New DefaultText()
Dim getMember As New CMembers()
Dim getStaff As New CStaffs()
Dim getProp As New CPreferences()
Dim getStaffRole As New CStaffRole()
Dim objDB As New CDBUtil()
Dim DateTimeUtil As New MyDateTime()

Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Select_Promotion") Then
		Try
			objCnn = getCnn.EstablishConnection()
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			selectError.Visible = False
			MemberError.InnerHtml = ""
			StaffError.InnerHtml = ""
			CouponError.InnerHtml = ""
			DiscountError.InnerHtml = ""
			
			Dim Chk As Boolean = getProp.CheckColumnExist("DiscountButton","SaleModeAvailable",objCnn)
			If Chk = True Then
				showSaleMode.Visible = True
			End If
			
			Dim SMData As DataTable = objDB.List("select * from SaleMode where Deleted=0 order by SaleModeID", objCnn)
			
			If SMData.Rows.Count < 2 Then
				showSaleMode.Visible = False
			End If
			
			Dim Checked As String = ""
			Dim SaleModeSel As String
			Dim i,j As Integer
			Dim DataArray() As String
           	If Not Request.Form("SaleModeAvailable") is Nothing Then
				DataArray = Request.Form("SaleModeAvailable").Split(","c)
				For j = 0 To DataArray.Length - 1
					If CInt(DataArray(j)) = 0
						Checked = " checked"
						Exit For
					End If
				Next
			End If
			
			SaleModeSel = "<input name=""SaleModeAvailable"" type=""checkbox"" value=""0""" + Checked + ">ALL"
			For i = 0 To SMData.Rows.Count - 1
				Checked = ""
				If Not Request.Form("SaleModeAvailable") is Nothing Then
				   For j = 0 To DataArray.Length - 1
					  If CInt(DataArray(j)) = SMData.Rows(i)("SaleModeID")
						  Checked = " checked"
						  Exit For
					  End If
				   Next
				End If
				SaleModeSel += "<input name=""SaleModeAvailable"" type=""checkbox"" value=""" + SMData.Rows(i)("SaleModeID").ToString + """" + Checked + ">" + SMData.Rows(i)("SaleModeName")
			Next
			SaleModeText.InnerHtml = SaleModeSel
		
			If Not Page.IsPostBack Then
				Dim GroupTable As New DataTable()
				'GroupTable = getMember.GetMemberInfo(4,-1,-1,-1,"MemberGroupID",objCnn)
				'MemberGroup.DataSource = GroupTable
				'MemberGroup.DataValueField = "MemberGroupID"
				'MemberGroup.DataTextField = "MemberGroupName"
				'MemberGroup.DataBind()
				
				Dim memberTable As New DataTable
				If GroupTable.Rows.Count > 0 Then
					'memberTable = getMember.GetMemberInfo(1,MemberGroup.SelectedItem.Value,-1,-1,"CodeOrder", objCnn)
				Else
					'memberTable = getMember.GetMemberInfo(1,0,-1,-1,"CodeOrder", objCnn)
				End If
				
				'MemberData.DataSource = memberTable
				'MemberData.DataValueField = "MemberCode"
				'MemberData.DataTextField = "MemberCode"
				'MemberData.DataBind()
				
				Dim staffRoleTable As New DataTable()
        		staffRoleTable = getStaffRole.GetAccessStaffRole(Session("StaffRole"),objCnn)
				StaffGroup.DataSource = staffRoleTable
				StaffGroup.DataValueField = "StaffRoleID"
				StaffGroup.DataTextField = "StaffRoleName"
				StaffGroup.DataBind()
			
				Dim dtTable As New DataTable()
        		dtTable = getStaff.GetStaffs(Session("StaffRole"),StaffGroup.SelectedItem.Value,objCnn)
				StaffData.DataSource = dtTable
				StaffData.DataValueField = "StaffCode"
				StaffData.DataTextField = "StaffCode"
				StaffData.DataBind()
				
				Dim couponGroupTable As New DataTable()
				couponGroupTable = getData.GetCVPromoFront(4, objCnn)
				CouponGroup.DataSource = couponGroupTable
				CouponGroup.DataValueField = "VoucherHeader"
				CouponGroup.DataTextField = "VoucherTypeName"
				CouponGroup.DataBind()
				
				Dim voucherGroupTable As New DataTable()
				voucherGroupTable = getData.GetCVPromoFront(5, objCnn)
				VoucherGroup.DataSource = voucherGroupTable
				VoucherGroup.DataValueField = "VoucherHeader"
				VoucherGroup.DataTextField = "VoucherTypeName"
				VoucherGroup.DataBind()
				
				Dim DiscountData As New DataTable()
				DiscountData = getData.DiscountButton(objCnn)
				DiscountButtonList.DataSource = DiscountData
				DiscountButtonList.DataValueField = "ID"
				DiscountButtonList.DataTextField = "DiscountName"
				DiscountButtonList.DataBind()
				
	
				Type_1.Checked = True
			
			End If
			PercentUnit.Items(0).Text = "%"
			PercentUnit.Items(0).Value = "1"
			PercentUnit.Items(1).Text = defaultTextTable.Rows(10)("TextParamValue")
			PercentUnit.Items(1).Value = "2"
		Catch ex As Exception
			errorMsg.InnerHtml = ex.Message
		End Try
	Else
		updateMessage.Text = "Access Denied"
		ShowContent.Visible = False
	End If
End Sub
Sub SelMemberGroup(Source As Object, e As System.EventArgs)
	
	Dim memberTable As New DataTable
	memberTable = getMember.GetMemberInfo(1,MemberGroup.SelectedItem.Value,-1,-1,"CodeOrder", objCnn)
	MemberData.DataSource = memberTable
	MemberData.DataValueField = "MemberCode"
	MemberData.DataTextField = "MemberCode"
	MemberData.DataBind()
	
	Type_1.Checked = True
	Type_2.Checked = False
	Type_3.Checked = False
	Type_4.Checked = False
	Type_5.Checked = False
End Sub

Sub SelStaffGroup(Source As Object, e As System.EventArgs)
	Dim dtTable As New DataTable()
	dtTable = getStaff.GetStaffs(Session("StaffRole"),StaffGroup.SelectedItem.Value,objCnn)
	StaffData.DataSource = dtTable
	StaffData.DataValueField = "StaffCode"
	StaffData.DataTextField = "StaffCode"
	StaffData.DataBind()
	
	Type_1.Checked = False
	Type_2.Checked = True
	Type_3.Checked = False
	Type_4.Checked = False
	Type_5.Checked = False
End Sub
 
    Sub SelCouponGroup(Source As Object, e As System.EventArgs)
        Type_1.Checked = False
        Type_2.Checked = False
        Type_3.Checked = True
        Type_4.Checked = False
        Type_5.Checked = False
    End Sub

    Sub SelVoucherGroup(Source As Object, e As System.EventArgs)
        Type_1.Checked = False
        Type_2.Checked = False
        Type_3.Checked = False
        Type_4.Checked = False
        Type_5.Checked = True
    End Sub

    Sub SelMember(Source As Object, e As System.EventArgs)
        Type_1.Checked = True
        Type_2.Checked = False
        Type_3.Checked = False
        Type_4.Checked = False
        Type_5.Checked = False
    End Sub
    
    Sub SelStaff(Source As Object, e As System.EventArgs)
        Type_1.Checked = False
        Type_2.Checked = True
        Type_3.Checked = False
        Type_4.Checked = False
        Type_5.Checked = False
    End Sub

    Sub SelDiscount(Source As Object, e As System.EventArgs)
        Type_1.Checked = False
        Type_2.Checked = False
        Type_3.Checked = False
        Type_4.Checked = True
        Type_5.Checked = False
    End Sub

    Sub Select_Promotion(Source As Object, e As CommandEventArgs)
        Dim Result As String = ""
        If Type_1.Checked = True Then
            Dim Chk As DataTable = objDB.List("select * from Members where MemberCode='" + Replace(MemberCode.Text, "'", "''") + "' AND Deleted=0 AND Activated=1", objCnn)
            If Chk.Rows.Count > 0 Then
                Try
                    Result = getData.AddDiscountButton(3, Chk.Rows(0)("MemberCode"), Chk.Rows(0)("MemberCode"), objCnn)
                Catch ex As Exception
                    Result = "No value of selected item"
                End Try
                If Result <> "Success" Then
                    MemberError.InnerHtml = "<tr><td></td><td class=""errortext"" colspan=""2"">" + Result + "</td></tr>"
                End If
            Else
                MemberError.InnerHtml = "<tr><td></td><td class=""errortext"" colspan=""2"">" + "Cannot find member code in database" + "</td></tr>"
            End If
        ElseIf Type_2.Checked = True Then
            Try
                Result = getData.AddDiscountButton(4, StaffData.SelectedItem.Value, StaffData.SelectedItem.Text, objCnn)
            Catch ex As Exception
                Result = "No value of selected item"
            End Try
            If Result <> "Success" Then
                StaffError.InnerHtml = "<tr><td></td><td class=""errortext"" colspan=""2"">" + Result + "</td></tr>"
            End If
        ElseIf Type_3.Checked = True Then
            Try
                Result = getData.AddDiscountButton(5, CouponGroup.SelectedItem.Text, CouponGroup.SelectedItem.Value, objCnn)
            Catch ex As Exception
                Result = "No value of selected item"
            End Try
            If Result <> "Success" Then
                CouponError.InnerHtml = "<tr><td></td><td class=""errortext"" colspan=""2"">" + Result + "</td></tr>"
            End If
        ElseIf Type_4.Checked = True Then
            If PercentUnit.SelectedItem.Value = 1 Then '%
                Result = getData.AddDiscountButton(1, Discount.Text, "", objCnn)
            Else
                Result = getData.AddDiscountButton(2, Discount.Text, "", objCnn)
            End If
            If Result <> "Success" Then
                DiscountError.InnerHtml = "<tr><td></td><td class=""errortext"" colspan=""2"">" + Result + "</td></tr>"
            End If
        ElseIf Type_5.Checked = True Then
            Try
                Result = getData.AddDiscountButton(6, VoucherGroup.SelectedItem.Text, VoucherGroup.SelectedItem.Value, objCnn)
            Catch ex As Exception
                Result = "No value of selected item"
            End Try
            If Result <> "Success" Then
                VoucherError.InnerHtml = "<tr><td></td><td class=""errortext"" colspan=""2"">" + Result + "</td></tr>"
            End If
        End If
        If Result = "Success" Then
            If showSaleMode.Visible = True Then
                Dim getButton As DataTable = objDB.List("select MAX(ID) As MaxID from DiscountButton", objCnn)
                Dim UpdateID As String
                If getButton.Rows.Count > 0 Then
                    UpdateID = getButton.Rows(0)("MaxID").ToString
                    Dim DataArray() As String
                    Dim j As Integer
                    Dim AllMode As Boolean = False
                    If Not Request.Form("SaleModeAvailable") Is Nothing Then
                        DataArray = Request.Form("SaleModeAvailable").Split(","c)
                        For j = 0 To DataArray.Length - 1
                            If CInt(DataArray(j)) = 0 Then
                                AllMode = True
                                Exit For
                            End If
                        Next
                        If AllMode = True Then
                            objDB.sqlExecute("UPDATE DiscountButton SET SaleModeAvailable=NULL WHERE ID=" + UpdateID, objCnn)
                        Else
                            objDB.sqlExecute("UPDATE DiscountButton SET SaleModeAvailable='" + Request.Form("SaleModeAvailable").ToString + "' WHERE ID=" + UpdateID, objCnn)
                        End If
                    End If
                End If
            End If
            Dim DiscountData As New DataTable()
            DiscountData = getData.DiscountButton(objCnn)
            DiscountButtonList.DataSource = DiscountData
            DiscountButtonList.DataValueField = "ID"
            DiscountButtonList.DataTextField = "DiscountName"
            DiscountButtonList.DataBind()
        End If
    End Sub

Sub Move_Up(Source As Object, e As CommandEventArgs)
	Try	
		getData.OrderingButton("DiscountButton",DiscountButtonList.SelectedItem.Value,"Up",objCnn)
		Dim SelectItem As Integer = DiscountButtonList.SelectedItem.Value
		Dim DiscountData As New DataTable()
		DiscountData = getData.DiscountButton(objCnn)
		DiscountButtonList.DataSource = DiscountData
		DiscountButtonList.DataValueField = "ID"
		DiscountButtonList.DataTextField = "DiscountName"
		DiscountButtonList.DataBind()
		Dim i As Integer
		For i = 0 To DiscountData.Rows.Count - 1
			If DiscountData.Rows(i)("ID") = SelectItem Then
				DiscountButtonList.Items(i).Selected = True
			End If
		Next
	Catch ex As Exception
		SelectError.Visible = True
	End Try
End Sub

Sub Move_Down(Source As Object, e As CommandEventArgs)
	Try
		getData.OrderingButton("DiscountButton",DiscountButtonList.SelectedItem.Value,"Down",objCnn)
		Dim SelectItem As Integer = DiscountButtonList.SelectedItem.Value
		Dim DiscountData As New DataTable()
		DiscountData = getData.DiscountButton(objCnn)
		DiscountButtonList.DataSource = DiscountData
		DiscountButtonList.DataValueField = "ID"
		DiscountButtonList.DataTextField = "DiscountName"
		DiscountButtonList.DataBind()
		Dim i As Integer
		For i = 0 To DiscountData.Rows.Count - 1
			If DiscountData.Rows(i)("ID") = SelectItem Then
				DiscountButtonList.Items(i).Selected = True
			End If
		Next
	Catch ex As Exception
		SelectError.Visible = True
	End Try
End Sub

Sub Move_Item(Source As Object, e As CommandEventArgs)
	Try
		getData.OrderingButton("DiscountButton",DiscountButtonList.SelectedItem.Value,Trim(Ordering.Text),objCnn)
		Dim SelectItem As Integer = DiscountButtonList.SelectedItem.Value
		Dim DiscountData As New DataTable()
		DiscountData = getData.DiscountButton(objCnn)
		DiscountButtonList.DataSource = DiscountData
		DiscountButtonList.DataValueField = "ID"
		DiscountButtonList.DataTextField = "DiscountName"
		DiscountButtonList.DataBind()
		Dim i As Integer
		For i = 0 To DiscountData.Rows.Count - 1
			If DiscountData.Rows(i)("ID") = SelectItem Then
				DiscountButtonList.Items(i).Selected = True
			End If
		Next
		Ordering.Text = ""
	Catch ex As Exception
		SelectError.Visible = True
	End Try
End Sub

Sub Del_Item(Source As Object, e As CommandEventArgs)
	Try
		getData.DelDiscountButton(DiscountButtonList.SelectedItem.Value,objCnn)
		getData.ReOrderingButton("DiscountButton",objCnn)
		Dim DiscountData As New DataTable()
		DiscountData = getData.DiscountButton(objCnn)
		DiscountButtonList.DataSource = DiscountData
		DiscountButtonList.DataValueField = "ID"
		DiscountButtonList.DataTextField = "DiscountName"
		DiscountButtonList.DataBind()
	Catch ex As Exception
		SelectError.Visible = True
	End Try
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
