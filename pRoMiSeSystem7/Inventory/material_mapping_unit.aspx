<%@ Page Language="VB" ContentType="text/html" EnableViewState="true" debug="True" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<%@Import Namespace="POSMySQL.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<html>
<head>
<title>Administration</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form id="mainForm" runat="server">
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
<input type="hidden" id="UnitSmallID" runat="server">
<input type="hidden" id="MaterialID" runat="server">
<table id="myTable" border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%">
	<tr>
		<td id="headerTD1" align="center" class="tdHeader" runat="server"><div id="Text1" runat="server"></div></td>
		<td id="headerTD2" align="center" class="tdHeader" runat="server"><div id="Text2" runat="server"></div></td>
		<td></td>
		<td id="headerTD3" align="center" class="tdHeader" runat="server"><div id="Text3" runat="server"></div></td>
		<td id="headerTD4" align="center" class="tdHeader" runat="server"><div id="Text4" runat="server"></div></td>
		<td></td>
		<td id="headerTD5" align="center" class="tdHeader" runat="server"><div id="Text5" runat="server"></div></td>
		<td id="headerTD6" align="center" class="tdHeader" runat="server"><div id="Text6" runat="server"></div></td>
		<td></td>
		<td id="headerTD7" align="center" class="tdHeader" runat="server"><div id="Text7" runat="server"></div></td>
		<td id="headerTD8" align="center" class="tdHeader" runat="server"><div id="Text8" runat="server"></div></td>
		<td></td>
		<td id="headerTD9" align="center" class="tdHeader" runat="server"><div id="Text9" runat="server"></div></td>
		<td id="headerTD10" align="center" class="tdHeader" runat="server"><div id="Text10" runat="server"></div></td>
		<td></td>
		<td id="headerTD12" align="center" class="tdHeader" runat="server"><div id="Text12" runat="server"></div></td>
		<td id="headerTD13" align="center" class="tdHeader" runat="server"><div id="Text13" runat="server"></div></td>
		<td></td>
		<td id="headerTD14" align="center" class="tdHeader" runat="server"><div id="Text14" runat="server"></div></td>
		<td id="headerTD15" align="center" class="tdHeader" runat="server"><div id="Text15" runat="server"></div></td>
		<td></td>
		<td id="headerTD11" align="center" class="tdHeader" runat="server"><div id="Text11" runat="server"></div></td>
	</tr>
	<div id="ResultText" runat="server"></div>

</table><br>
<asp:button ID="SubmitForm" Font-Size="10" Height="30" Width="150" OnClick="DoAddUpdate" runat="server" />
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
</table></form>
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
        If User.Identity.IsAuthenticated And Session("Inv_Material_Category") Then
	  
            If IsNumeric(Request.QueryString("MaterialID")) Then
	
                Try
                    SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
                    objCnn = getCnn.EstablishConnection()
		
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
		
                    Text1.InnerHtml = "Default"
                    Text2.InnerHtml = "PO"
                    Text3.InnerHtml = "Default"
                    Text4.InnerHtml = "Stock Count"
                    Text5.InnerHtml = "Default"
                    Text6.InnerHtml = "Receive"
                    Text7.InnerHtml = "Default"
                    Text8.InnerHtml = "Transfer"
                    Text9.InnerHtml = "Default"
                    Text10.InnerHtml = "Request"
                    Text12.InnerHtml = "Default"
                    Text13.InnerHtml = "Adjust"
                    Text14.InnerHtml = "Default"
                    Text15.InnerHtml = "PreFinish"
                    Text11.InnerHtml = "Unit Name"
		
                    SubmitForm.Text = "Submit Changes"
		
                    Dim textTable As New DataTable()
                    textTable = getPageText.GetText(8, Session("LangID"), objCnn)
		
                    Dim textTable1 As New DataTable()
                    textTable1 = getPageText.GetText(7, Session("LangID"), objCnn)
		
                    Dim MaterialData As DataTable = getInfo.GetMaterialInfo(0, Request.QueryString("MaterialID"), objCnn)
		
                    If MaterialData.Rows.Count > 0 Then
			
                        HeaderText.InnerHtml = "Set Inventory Unit for Material " + MaterialData.Rows(0)("MaterialName")
			
                        Dim dtMaterialUnit, dtUnitInfo As DataTable
                        dtUnitInfo = New DataTable
                        dtMaterialUnit = getInfo.GetMaterialAllInvenUnitAndUnitInfo(objCnn, 1, Request.QueryString("MaterialID"), dtUnitInfo)

                        Dim selDocType As Integer
                        Dim outputString As StringBuilder
                        Dim Checked As String = ""
                        Dim DChecked As String = ""
                        Dim i As Integer
                        If dtUnitInfo.Rows.Count = 0 Then
                            UnitSmallID.Value = 0
                        Else
                            UnitSmallID.Value = dtUnitInfo.Rows(0)("UnitSmallID")
                        End If
                        MaterialID.Value = Request.QueryString("MaterialID")
                        outputString = New StringBuilder
                        For i = 0 To dtUnitInfo.Rows.Count - 1
                            'PO Document
                            selDocType = 1
                            SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit, dtUnitInfo, i, selDocType, Checked, DChecked)
                            outputString.Append("<tr>")
                            outputString.Append("<td class=""text"" align=""center""><input type=""Radio"" value=""" + dtUnitInfo.Rows(i)("UnitLargeID").ToString + """ name=""UnitDefault_1""" + DChecked + "></td>")
                            outputString.Append("<td class=""text"" align=""center""><input type=""checkbox"" value=""1"" name=""UnitLargeID_1_" + dtUnitInfo.Rows(i)("UnitLargeID").ToString + """" + Checked + "></td>")
                            outputString.Append("<td></td>")
				
                            'Stock Count document
                            selDocType = 7
                            SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit, dtUnitInfo, i, selDocType, Checked, DChecked)
                            outputString.Append("<td class=""text"" align=""center""><input type=""Radio"" value=""" + dtUnitInfo.Rows(i)("UnitLargeID").ToString + """ name=""UnitDefault_7""" + DChecked + "></td>")
                            outputString.Append("<td class=""text"" align=""center""><input type=""checkbox"" value=""1"" name=""UnitLargeID_7_" + dtUnitInfo.Rows(i)("UnitLargeID").ToString + """" + Checked + "></td>")
                            outputString.Append("<td></td>")

                            'DRO Document
                            selDocType = 39
                            SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit, dtUnitInfo, i, selDocType, Checked, DChecked)
                            outputString.Append("<td class=""text"" align=""center""><input type=""Radio"" value=""" + dtUnitInfo.Rows(i)("UnitLargeID").ToString + """ name=""UnitDefault_39""" + DChecked + "></td>")
                            outputString.Append("<td class=""text"" align=""center""><input type=""checkbox"" value=""1"" name=""UnitLargeID_39_" + dtUnitInfo.Rows(i)("UnitLargeID").ToString + """" + Checked + "></td>")
                            outputString.Append("<td></td>")
				
                            'Transfer Document
                            selDocType = 3
                            SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit, dtUnitInfo, i, selDocType, Checked, DChecked)
                            outputString.Append("<td class=""text"" align=""center""><input type=""Radio"" value=""" + dtUnitInfo.Rows(i)("UnitLargeID").ToString + """ name=""UnitDefault_3""" + DChecked + "></td>")
                            outputString.Append("<td class=""text"" align=""center""><input type=""checkbox"" value=""1"" name=""UnitLargeID_3_" + dtUnitInfo.Rows(i)("UnitLargeID").ToString + """" + Checked + "></td>")
                            outputString.Append("<td></td>")
				
                            'Request Document
                            selDocType = 17
                            SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit, dtUnitInfo, i, selDocType, Checked, DChecked)
                            outputString.Append("<td class=""text"" align=""center""><input type=""Radio"" value=""" + dtUnitInfo.Rows(i)("UnitLargeID").ToString + """ name=""UnitDefault_17""" + DChecked + "></td>")
                            outputString.Append("<td class=""text"" align=""center""><input type=""checkbox"" value=""1"" name=""UnitLargeID_17_" + dtUnitInfo.Rows(i)("UnitLargeID").ToString + """" + Checked + "></td>")
                            outputString.Append("<td></td>")
				
                            'Adjust Document
                            selDocType = 0
                            SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit, dtUnitInfo, i, selDocType, Checked, DChecked)
                            outputString.Append("<td class=""text"" align=""center""><input type=""Radio"" value=""" + dtUnitInfo.Rows(i)("UnitLargeID").ToString + """ name=""UnitDefault_0""" + DChecked + "></td>")
                            outputString.Append("<td class=""text"" align=""center""><input type=""checkbox"" value=""1"" name=""UnitLargeID_0_" + dtUnitInfo.Rows(i)("UnitLargeID").ToString + """" + Checked + "></td>")
                            outputString.Append("<td></td>")
				
                            'Prefinish Document
                            selDocType = 26
                            SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit, dtUnitInfo, i, selDocType, Checked, DChecked)
                            outputString.Append("<td class=""text"" align=""center""><input type=""Radio"" value=""" + dtUnitInfo.Rows(i)("UnitLargeID").ToString + """ name=""UnitDefault_26""" + DChecked + "></td>")
                            outputString.Append("<td class=""text"" align=""center""><input type=""checkbox"" value=""1"" name=""UnitLargeID_26_" + dtUnitInfo.Rows(i)("UnitLargeID").ToString + """" + Checked + "></td>")
				
                            If IsDBNull(dtUnitInfo.Rows(i)("UnitLargeName")) Then
                                dtUnitInfo.Rows(i)("UnitLargeName") = ""
                            End If
                            outputString.Append("<td></td>")
                            outputString.Append("<td class=""text"">" & dtUnitInfo.Rows(i)("UnitLargeName") & "</td>")
                            outputString.Append("</tr>")
                        Next
                        ResultText.InnerHtml = outputString.ToString
                    Else
                        updateMessage.Text = "Invalid Data"
                    End If
                Catch ex As Exception
                    errorMsg.InnerHtml = ex.Message
                    SubmitForm.Visible = False
                End Try
            Else
                updateMessage.Text = "Invalid Parameters"
            End If
        Else
            updateMessage.Text = "Access Denied"
        End If
    End Sub

    Private Sub SetCheckAndDefaultUnitForMaterialInvenUnit(dtMaterialUnit As DataTable, dtUnitInfo As DataTable, unitIndex As Integer, selDocType As Integer, _
    ByRef strChecked As String, ByRef strDefaultChecked As String)
        Dim rResult() As DataRow
        strChecked = ""
        strDefaultChecked = ""
        If dtUnitInfo.Rows.Count > unitIndex Then
            rResult = dtMaterialUnit.Select("SelectUnitLargeID = " & dtUnitInfo.Rows(unitIndex)("UnitLargeID") & " AND DocumentTypeID = " & selDocType)
            If rResult.Length > 0 Then
                strChecked = " checked"
                If rResult(0)("IsDefault") = 1 Then
                    strDefaultChecked = " checked"
                End If
            End If
        End If
    End Sub
    
Sub DoAddUpdate(Source As Object, E As EventArgs)
	getInfo.MaterialDocUnit_Update(1, Request, objCnn)
	Response.Redirect("material_mapping_unit.aspx?" + Request.QueryString.ToString)
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub
</script>

</body>
</html>