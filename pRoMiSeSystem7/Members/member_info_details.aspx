<%@ Page Language="VB" ContentType="text/html" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="POSBackOfficeReport" %>
<%@Import Namespace="POSTypeClass" %>
<%@Import Namespace="POSDBFront" %>

<%@ Register tagprefix="synature" Tagname="MemberMenu" Src="../UserControls/MemberMenu.ascx" %>

<html>
<head>
<title>Members</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body<% = GlobalParam.BodyProp %>>

<script language="VB" runat="server">

Dim userInfo As New CMembers()
Dim objCnn As New MySqlConnection()
    Dim getCnn As New CDBUtil()
    Dim Fm As New UtilityFunction()
    Dim FormatObject As New POSMySQL.POSControl.FormatClass
Dim getPageText As New DefaultText()
Dim DateTimeUtil As New MyDateTime()
Dim getUDD As New CPreferences()
Dim objDB As New CDBUtil()
    Dim PageID As Integer = 111
    Dim getProp As New CPreferences()
    
    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Member_Info") And IsNumeric(Request.QueryString("MemberID")) Then
	
            Try
                objCnn = getCnn.EstablishConnection()
		
                Dim textTable As New DataTable()
                textTable = getPageText.GetText(11, Session("LangID"), objCnn)
		
                Fm.FormatParam(FormatObject, Session("LangID"), objCnn)
                
                Dim LangData2 As DataTable = getProp.GetLangData(PageID, 1, -1, Request)
                Dim LangText As String = "lang" + Session("LangID").ToString
                
                Dim defaultTextTable As New DataTable()
                defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
                Dim PropertyInfo As DataTable = getUDD.PropertyInfo(1, objCnn)
                Dim getInfo As DataTable

                getInfo = userInfo.GetMemberInfo(1, -1, Request.QueryString("MemberID"), -1, "CodeOrder", objCnn)
		
                headerTD0.BgColor = GlobalParam.AdminBGColor
                headerTD1.BgColor = GlobalParam.AdminBGColor
                headerTD2.BgColor = GlobalParam.AdminBGColor
                headerTD3.BgColor = GlobalParam.AdminBGColor
                headerTD4.BgColor = GlobalParam.AdminBGColor
                headerTD5.BgColor = GlobalParam.AdminBGColor
                headerTD6.BgColor = GlobalParam.AdminBGColor
                headerTD7.BgColor = GlobalParam.AdminBGColor
                headerTD8.BgColor = GlobalParam.AdminBGColor
                headerTD9.BgColor = GlobalParam.AdminBGColor
                headerTD10.BgColor = GlobalParam.AdminBGColor
                headerTD11.BgColor = GlobalParam.AdminBGColor
                headerTD12.BgColor = GlobalParam.AdminBGColor
                headerTD13.BgColor = GlobalParam.AdminBGColor
                headerTD14.BgColor = GlobalParam.AdminBGColor
                headerTD15.BgColor = GlobalParam.AdminBGColor
                headerTD16.BgColor = GlobalParam.AdminBGColor
                headerTD17.BgColor = GlobalParam.AdminBGColor
                tdChangeMemberCode.BgColor = GlobalParam.AdminBGColor
                tdMemberPoint.BgColor = GlobalParam.AdminBGColor
                
		
                CodeText.InnerHtml = textTable.Rows(19)("TextParamValue")
                RoleText.InnerHtml = textTable.Rows(18)("TextParamValue")
                NameText.InnerHtml = defaultTextTable.Rows(46)("TextParamValue")
                AddressText.InnerHtml = defaultTextTable.Rows(47)("TextParamValue")
                EmailText.InnerHtml = defaultTextTable.Rows(25)("TextParamValue")
                ProvinceText.InnerHtml = defaultTextTable.Rows(21)("TextParamValue")
                ZipText.InnerHtml = defaultTextTable.Rows(22)("TextParamValue")
                TelephoneText.InnerHtml = defaultTextTable.Rows(23)("TextParamValue")
                MobileText.InnerHtml = defaultTextTable.Rows(27)("TextParamValue")
                FaxText.InnerHtml = defaultTextTable.Rows(24)("TextParamValue")
                BirthDayText.InnerHtml = defaultTextTable.Rows(31)("TextParamValue")
                AdditionalText.InnerHtml = defaultTextTable.Rows(26)("TextParamValue")
                IDNumberText.InnerHtml = defaultTextTable.Rows(32)("TextParamValue")
                IDIssueText.InnerHtml = defaultTextTable.Rows(33)("TextParamValue")
                IDExpText.InnerHtml = defaultTextTable.Rows(34)("TextParamValue")
                BloodGroupText.InnerHtml = defaultTextTable.Rows(35)("TextParamValue")
                LastUpdateText.InnerHtml = defaultTextTable.Rows(48)("TextParamValue")
                SectionText.InnerHtml = textTable.Rows(29)("TextParamValue")
                MemberExpireText.InnerHtml = textTable.Rows(36)("TextParamValue")
		
                spMemberPoint.InnerHtml = POSBackOfficeReport.BackOfficeReport.GetLanguageText(LangData2, 1, LangText, "Total Point")
                spChangeMemberCode.InnerHtml = POSBackOfficeReport.BackOfficeReport.GetLanguageText(LangData2, 2, LangText, "Change Member Code History")
		        
                trMemberPoint.Visible = False
                trChangeMemberCode.Visible = False
                                
                If getInfo.Rows.Count > 0 Then
                    If IsDBNull(getInfo.Rows(0)("MemberCode")) Then
                        getInfo.Rows(0)("MemberCode") = ""
                    End If
                    CodeValue.InnerHtml = getInfo.Rows(0)("MemberCode")
			
                    If Not IsDBNull(getInfo.Rows(0)("MemberFirstName")) Then NameValue.InnerHtml = getInfo.Rows(0)("MemberFirstName")
			
                    If Not IsDBNull(getInfo.Rows(0)("MemberLastName")) Then
                        NameValue.InnerHtml += " " + getInfo.Rows(0)("MemberLastName")
                    End If
			
                    If Not IsDBNull(getInfo.Rows(0)("MemberAddress1")) Then
                        AddressValue.InnerHtml = getInfo.Rows(0)("MemberAddress1") + "<br>"
                    End If
			
                    If Not IsDBNull(getInfo.Rows(0)("MemberAddress2")) Then
                        If Trim(getInfo.Rows(0)("MemberAddress2")) <> "" Then
                            AddressValue.InnerHtml += getInfo.Rows(0)("MemberAddress2") + " "
                        End If
                    End If
                    If Not IsDBNull(getInfo.Rows(0)("MemberCity")) Then
                        AddressValue.InnerHtml += getInfo.Rows(0)("MemberCity")
                    End If
			
                    If Not IsDBNull(getInfo.Rows(0)("MemberZipCode")) Then ZipValue.InnerHtml = getInfo.Rows(0)("MemberZipCode")
                    If Not IsDBNull(getInfo.Rows(0)("MemberTelephone")) Then TelephoneValue.InnerHtml = getInfo.Rows(0)("MemberTelephone")
                    If Not IsDBNull(getInfo.Rows(0)("MemberMobile")) Then MobileValue.InnerHtml = getInfo.Rows(0)("MemberMobile")
                    If Not IsDBNull(getInfo.Rows(0)("MemberEmail")) Then EmailValue.InnerHtml = getInfo.Rows(0)("MemberEmail")
                    If Not IsDBNull(getInfo.Rows(0)("MemberIDNumber")) Then IDNumberValue.InnerHtml = getInfo.Rows(0)("MemberIDNumber")
                    If Not IsDBNull(getInfo.Rows(0)("MemberMobile")) Then MobileValue.InnerHtml = getInfo.Rows(0)("MemberMobile")
                    If Not IsDBNull(getInfo.Rows(0)("MemberFax")) Then FaxValue.InnerHtml = getInfo.Rows(0)("MemberFax")
                    If Not IsDBNull(getInfo.Rows(0)("MemberBlood")) Then BloodGroupValue.InnerHtml = getInfo.Rows(0)("MemberBlood")
                    If Not IsDBNull(getInfo.Rows(0)("MemberBirthDay")) Then
                        Dim MemberAge As Integer = 0
                        MemberAge = Year(Now()) - Year(getInfo.Rows(0)("MemberBirthDay"))
                        BirthDayValue.InnerHtml = DateTimeUtil.FormatDateTime(getInfo.Rows(0)("MemberBirthDay"), "DateOnly") + " (" + MemberAge.ToString + ")"
                    End If
                    If Not IsDBNull(getInfo.Rows(0)("UpdateDate")) Then LastUpdateValue.InnerHtml = DateTimeUtil.FormatDateTime(getInfo.Rows(0)("UpdateDate"), "DateAndTime")
                    If Not IsDBNull(getInfo.Rows(0)("MemberIDIssueDate")) Then IDIssueValue.InnerHtml = DateTimeUtil.FormatDateTime(getInfo.Rows(0)("MemberIDIssueDate"), "DateOnly")
                    If Not IsDBNull(getInfo.Rows(0)("MemberIDExpiration")) Then IDExpValue.InnerHtml = DateTimeUtil.FormatDateTime(getInfo.Rows(0)("MemberIDExpiration"), "DateOnly")
                    If Not IsDBNull(getInfo.Rows(0)("MemberAdditional")) Then AdditionalValue.InnerHtml = getInfo.Rows(0)("MemberAdditional")
                    If Not IsDBNull(getInfo.Rows(0)("MemberExpiration")) Then MemberExpireValue.InnerHtml = DateTimeUtil.FormatDateTime(getInfo.Rows(0)("MemberExpiration"), "DateOnly")
			
                    If Not IsDBNull(getInfo.Rows(0)("MemberPictureFileServer")) Then
                        If Trim(getInfo.Rows(0)("MemberPictureFileServer")) <> "" Then
                            myImage.Src = "../images/Members/" + getInfo.Rows(0)("MemberPictureFileServer")
                        Else
                            myImage.Src = "../images/no_photo.jpg"
                        End If
                    Else
                        myImage.Src = "../images/no_photo.jpg"
                    End If
			
                    If Not IsDBNull(getInfo.Rows(0)("MemberGroupID")) Then
                        RoleValue.InnerHtml = getInfo.Rows(0)("MemberGroupName")
                    End If
			
                    If Not IsDBNull(getInfo.Rows(0)("MemberProvince")) Then
                        If IsNumeric(getInfo.Rows(0)("MemberProvince")) Then
                            Dim MemberProvinceN As DataTable
                            MemberProvinceN = getPageText.GetProvinceName(getInfo.Rows(0)("MemberProvince"), Session("LangID"), objCnn)
					
                            If MemberProvinceN.Rows.Count <> 0 Then
                                ProvinceValue.InnerHtml = MemberProvinceN.Rows(0)("ProvinceName")
                            End If
                        End If
                    End If
			
                    Dim ExtraInfoText As String = ""
                    Dim ExtraValue As String = ""
			
                    Dim UDDGroup As DataTable = getUDD.GetUDDGInfo1(1, 0, 1, objCnn)
                    Dim ExtraData As DataTable
                    Dim i, j As Integer
                    Dim DummyUDDID As Integer
                    Dim NextUDDID As Integer
			
                    If UDDGroup.Rows.Count > 0 Then
                        ShowExtraInfo.Visible = True
                        For j = 0 To UDDGroup.Rows.Count - 1
                            ExtraData = getUDD.UDDValueGroup(UDDGroup.Rows(j)("UDDGID"), getInfo.Rows(0)("MemberID"), 1, 0, 0, objCnn)
                            ExtraInfoText += "<tr><td colspan=""2"" class=""boldText"">" + UDDGroup.Rows(j)("UDDGName") + "</td></tr>"
                            DummyUDDID = 0
                            NextUDDID = 0
                            For i = 0 To ExtraData.Rows.Count - 1
                                If ExtraData.Rows(i)("UDDPropID") = 1 Or ExtraData.Rows(i)("UDDPropID") = 3 Then
                                    Select Case ExtraData.Rows(i)("UDDTypeID")
                                        Case 1
                                            If Not IsDBNull(ExtraData.Rows(i)("UDVText")) Then
                                                ExtraValue = ExtraData.Rows(i)("UDVText")
                                            Else
                                                ExtraValue = ""
                                            End If
                                        Case 2
                                            ExtraValue = Format(ExtraData.Rows(i)("UDVValue"), "##,##0.00")
                                        Case 3
                                            If Not IsDBNull(ExtraData.Rows(i)("OptionName")) Then
                                                If DummyUDDID = ExtraData.Rows(i)("UDDID") Then
                                                    ExtraValue += "," + ExtraData.Rows(i)("OptionName")
                                                Else
                                                    ExtraValue = ExtraData.Rows(i)("OptionName")
                                                End If
                                            End If
                                        Case 4
                                            If Not IsDBNull(ExtraData.Rows(i)("OptionName")) Then
                                                ExtraValue = ExtraData.Rows(i)("OptionName")
                                            End If
                                        Case 5
                                            If Not IsDBNull(ExtraData.Rows(i)("UDVDate")) Then
                                                ExtraValue = DateTimeUtil.FormatDateTime(ExtraData.Rows(i)("UDVDate"), "DateOnly")
                                            Else
                                                ExtraValue = ""
                                            End If
                                        Case 6
                                            If Not IsDBNull(ExtraData.Rows(i)("UDVText")) Then
                                                ExtraValue = "<a href=""JavaScript: newWindow = window.open( '../images/members/" + Replace(ExtraData.Rows(i)("UDVText"), "\", "/") + "', '', 'width=600,height=550,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" + "View Image" + "</a>"
                                            Else
                                                ExtraValue = ""
                                            End If
                                    End Select
                                    'TestMsg += "<br>DummyID=" + DummyUDDID.ToString + "::UUID" + ExtraData.Rows(i)("UDDID").ToString + "==" + ExtraValue
                                    If i = ExtraData.Rows.Count - 1 Then
                                        ExtraInfoText += "<tr>"
                                        ExtraInfoText += "<td class=""tdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + ExtraData.Rows(i)("UDDName") + "</td>"
                                        ExtraInfoText += "<td class=""text"">" + ExtraValue + "</td>"
                                        ExtraInfoText += "</tr>"
                                    Else
                                        NextUDDID = i + 1
                                        If ExtraData.Rows(i)("UDDID") <> ExtraData.Rows(NextUDDID)("UDDID") Then
                                            ExtraInfoText += "<tr>"
                                            ExtraInfoText += "<td class=""tdHeader"" bgcolor=""" + GlobalParam.AdminBGColor + """>" + ExtraData.Rows(i)("UDDName") + "</td>"
                                            ExtraInfoText += "<td class=""text"">" + ExtraValue + "</td>"
                                            ExtraInfoText += "</tr>"
                                        End If
                                    End If
                                    'TestMsg += " :: " + ExtraData.Rows(i)("UDDID").ToString + ":" + ExtraData.Rows(NextUDDID)("UDDID").ToString + " :: " + NextUDDID.ToString + ":" + ExtraData.Rows.Count.ToString
						
                                    DummyUDDID = ExtraData.Rows(i)("UDDID")
                                End If
                            Next
                        Next
                        ExtraInfo.InnerHtml = ExtraInfoText
                        'Msg.InnerHtml = TestMsg
                    Else
                        ShowExtraInfo.Visible = False
                    End If
			
                    Dim strTemp As String
                    Dim bolHead, bolShowProperty As Boolean
                    Dim dtResult As DataTable
                    
                    dtResult = POSDBSQLFront.POSUtilSQL.GetMainProperty(objDB, objCnn)
                    If dtResult.Rows.Count = 0 Then
                        bolHead = False
                    ElseIf dtResult.Rows(0)("HeadOrBranch") = 0 Then
                        bolHead = True
                    Else
                        bolHead = False
                    End If

                    '**************************************************************
                    'Display MemberPoint
                    If bolHead = False Then
                        bolShowProperty = False
                    Else
                        bolShowProperty = POSBackOfficeReport.ReportShareSQL.SystemHasRewardPointSetting(objDB, objCnn)                       
                    End If
                    If bolShowProperty = True Then
                        trMemberPoint.Visible = True
                        dtResult = POSBackOfficeReport.ReportShareSQL.GetMemberRewardPointSummary(objDB, objCnn, getInfo.Rows(0)("MemberID"))
                        If dtResult.Rows.Count = 0 Then
                            spMemberPointVaue.InnerHtml = "-"
                        Else
                            strTemp = "../ReportPoints/MemberInfo.aspx?KeyID=" & getInfo.Rows(0)("MemberID") & "&DisDate=0"
                            
                            strTemp = Format(dtResult.Rows(0)("TotalPoint"), FormatObject.CurrencyFormat)
                            strTemp = "<a class=""smallText"" href=""JavaScript: newWindow = window.open( '../ReportPoints/MemberInfo.aspx?KeyID=" & getInfo.Rows(0)("MemberID") & "&DisDate=0'," & _
                                        "'', 'width=750,height=600,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & _
                                        strTemp & "</a>"
                            spMemberPointVaue.InnerHtml = strTemp 
                        End If
                    End If
                                   
                    '**************************************************************
                    'Old Member Code
                    If bolHead = False Then
                        bolShowProperty = False
                    Else
                        dtResult = POSDBSQLFront.POSUtilSQL.GetMemberFrontFeature(objDB, objCnn)
                        If dtResult.Rows.Count = 0 Then
                            bolShowProperty = False
                        ElseIf dtResult.Rows(0)("ReNewMember") = 1 Then
                            bolShowProperty = True
                        Else
                            bolShowProperty = False
                        End If
                    End If
                    If bolShowProperty = True Then
                        Dim noChange As Integer
                        trChangeMemberCode.Visible = True
                        dtResult = POSBackOfficeReport.ReportShareSQL.ListHistoryOfChangeMemberCode(objDB, objCnn, getInfo.Rows(0)("MemberID"))
                        strTemp = ""
                        noChange = 0
                        For i = 0 To dtResult.Rows.Count - 1
                            If dtResult.Rows(i)("ChangeFromMemberCode") <> getInfo.Rows(0)("MemberCode") Then
                                If noChange > 0 Then
                                    strTemp &= "-->"
                                End If
                                strTemp &= dtResult.Rows(i)("ChangeFromMemberCode")
                                noChange += 1
                            End If
                        Next i
                        spChangeMemberCodeDetail.InnerHtml = strTemp
                    End If
                    
                End If

                    If Request.QueryString("Logout") = "yes" Then
                        MMenu.Logout = 1
                    Else
                        MMenu.Logout = 0
                    End If
                    MMenu.MemberPage = 1
		
            Catch ex As Exception
                errorMsg.InnerHtml = ex.Message
            End Try
		
        Else
            errorMsg.InnerHtml = "Access Denied"
        End If
    End Sub

</script>
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText"><div class="headerText" align="left" id="SectionText" runat="server" /></b>
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

<synature:MemberMenu id="MMenu" runat="server" />

<table width="100%" border="1" cellspacing="0" cellpadding="5" style="border-collapse:collapse;">
  <tr> 
    <td width="16%" id="headerTD13" class="tdHeader" runat="server"><span id="CodeText" runat="server"></span></td>
    <td><span id="CodeValue" class="text" runat="server"></span></td>
	<td id="headerTD15" class="tdHeader" runat="server"><span id="LastUpdateText" runat="server"></span></td>
    <td><span id="LastUpdateValue" class="text" runat="server"></span></td>
    <td width="10%" align="center" rowspan="5"><img id="myImage" width="120" height="155" runat="server"></td>
  </tr>
  <tr> 
    <td id="headerTD0" class="tdHeader" runat="server"><span id="NameText" runat="server"></span></td>
    <td><span id="NameValue" class="text" runat="server"></span></td>
	<td id="headerTD14" class="tdHeader" runat="server"><span id="RoleText" runat="server"></span></td>
    <td><span id="RoleValue" class="text" runat="server"></span></td>
	
  </tr>
  <tr> 
    <td height="59" id="headerTD1" class="tdHeader" runat="server"><span id="AddressText" runat="server"></span></td>
    <td colspan="3"><span id="AddressValue" class="text" runat="server"></span></td>
  </tr>
  <tr> 
    <td id="headerTD2" class="tdHeader" runat="server"><span id="ProvinceText" runat="server"></span></td>
    <td width="27%"><span id="ProvinceValue" class="text" runat="server"></span></td>
    <td width="13%" id="headerTD3" class="tdHeader" runat="server"><span id="ZipText" runat="server"></span></td>
    <td width="22%"><span id="ZipValue" class="text" runat="server"></span></td>
  </tr>
  <tr> 
    <td id="headerTD4" class="tdHeader" runat="server"><span id="TelephoneText" runat="server"></span></td>
    <td><span id="TelephoneValue" class="text" runat="server"></span></td>
    <td id="headerTD5" class="tdHeader" runat="server"><span id="MobileText" runat="server"></span></td>
    <td><span id="MobileValue" class="text" runat="server"></span></td>
  </tr>
  <tr> 
    <td id="headerTD16" class="tdHeader" runat="server"><span id="FaxText" runat="server"></span></td>
	<td><span id="FaxValue" class="text" runat="server"></span></td>
	<td id="headerTD7" class="tdHeader" runat="server"><span id="BirthDayText" runat="server"></span></td>
    <td><span id="BirthDayValue" class="text" runat="server"></span></td>
    <td><span id="LastUpdated" class="text" runat="server"></span></td>
    
  </tr>
  <tr> 
    <td id="headerTD6" class="tdHeader" runat="server"><span id="EmailText" runat="server"></span></td>
    <td><span id="EmailValue" class="text" runat="server"></span></td>
    <td id="headerTD17" class="tdHeader" runat="server"><span id="MemberExpireText" runat="server"></span></td>
    <td colspan="2"><span id="MemberExpireValue" class="text" runat="server"></span></td>
  </tr>

  <tr> 
    <td id="headerTD8" class="tdHeader" runat="server"><span id="IDNumberText" runat="server"></span></td>
    <td><span id="IDNumberValue" class="text" runat="server"></span></td>
    <td id="headerTD9" class="tdHeader" runat="server"><span id="IDIssueText" runat="server"></span></td>
    <td colspan="2"><span id="IDIssueValue" class="text" runat="server"></span></td>
  </tr>
  <tr> 
    <td id="headerTD10" class="tdHeader" runat="server"><span id="IDExpText" runat="server"></span></td>
    <td><span id="IDExpValue" class="text" runat="server"></span></td>
    <td id="headerTD11" class="tdHeader" runat="server"><span id="BloodGroupText" runat="server"></span></td>
    <td colspan="2"><span id="BloodGroupValue" class="text" runat="server"></span></td>
  </tr>
  
    <tr id="trMemberPoint" runat="server" > 
    <td id="tdMemberPoint" class="tdHeader" runat="server"><span id="spMemberPoint" runat="server"></span></td>
    <td id="tdMemberPointValue" runat="server"><span id="spMemberPointVaue" class="text" runat="server"></span></td>
    <td class="tdHeader" runat="server"></td>
    <td colspan="2"></td>
  </tr>
  <tr id="trChangeMemberCode" runat="server" > 
    <td id="tdChangeMemberCode" class="tdHeader" runat="server"><span id="spChangeMemberCode" runat="server"></span></td>
    <td id="tdChangeMemberCodeDetail" runat="server" colspan="4"><span id="spChangeMemberCodeDetail" class="text" runat="server"></span></td>
  </tr>
  <tr> 
    <td id="headerTD12" class="tdHeader" runat="server"><span id="AdditionalText" runat="server"></span></td>
    <td colspan="4"><span id="AdditionalValue" class="text" runat="server"></span></td>
  </tr>

</table>
<br>&nbsp;
<div id="ShowExtraInfo" runat="server">
<table width="100%" border="1" cellspacing="0" cellpadding="5" style="border-collapse:collapse;">
<span id="ExtraInfo" runat="server"></span>
</table>
</div>
<div id="Msg" runat="server"></div><p>&nbsp;</p>
<div id="errorMsg" style="color:red;" runat="server" />
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
</body>
</html>
