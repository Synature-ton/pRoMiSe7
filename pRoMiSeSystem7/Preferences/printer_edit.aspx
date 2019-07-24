<%@ Page Language="VB" ContentType="text/html" EnableViewState="true" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="POSBackOfficeReport" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>

<html>
<head>
<title>Manage Category</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form id="mainForm" runat="server">
<input type="hidden" id="PrinterID" runat="server" />
<input type="hidden" id="ZoneID" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText"><ASP:Label id="updateMessage" CssClass="headerText" runat="server" /></b>
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
<div id="validateName" runat="server" />

<tr>
	<td><div class="requireText" id="PrinterNameParam" runat="server"></div></td>
	<td><asp:textbox ID="PrinterName" Width="300" runat="server" /></td>
</tr>
<tr>
	<td class="text">Printer Device Name</td>
	<td><asp:textbox ID="PrinterDeviceName" Width="300" runat="server" /></td>
</tr>
<tr id="prop" visible="false" runat="server">
	<td class="text">Printer Property</td>
	<td><asp:textbox ID="PrinterDeviceNameFor98" Width="300" runat="server" /></td>
</tr>

<span id="PrinterProp" runat="server" />

<tr id="DisplayPrinterTypeID" runat="server">
	<td class="text">Printer Type</td>
	<td><asp:DropDownList ID="PrinterTypeID" CssClass="text" runat="server"></asp:DropDownList></td>
</tr>
<div id="ShowIsOPOSPrinter" visible="false" runat="server">
<tr>
	<td class="text">OPOS</td>
	<td class="text"><input type="radio" id="Radio1" name="IsOPOSPrinter" value="1" runat="server" />YES&nbsp;&nbsp;<input type="radio" id="Radio2" name="IsOPOSPrinter" value="0" runat="server" />NO</td>
</tr>
</div>
<tr>
	<td colspan="2" height="5"></td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td><asp:button ID="SubmitForm" OnClick="DoAddUpdate" runat="server" />&nbsp;<asp:button ID="CancelButton" OnClick="DoCancel" runat="server" /></td>
</tr>
</table>
</form>

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
Dim getInfo As New POSConfiguration()
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getPageText As New DefaultText()
Dim getProp As New CPreferences()
Dim objDB As New CDBUtil()
    Dim bolUpdatePrinterByZone As Boolean

    Sub Page_Load()
        If User.Identity.IsAuthenticated And Session("Manage_Printer") Then
	
            ZoneID.Value = -1
            'Try
            objCnn = getCnn.EstablishConnection()
            SubmitForm.Attributes.Item("onclick") = "this.disabled=true; " & GetPostBackEventReference(SubmitForm).ToString
            Dim textTable As New DataTable()
            textTable = getPageText.GetText(9, Session("LangID"), objCnn)
		
            Dim defaultTextTable As New DataTable()
            defaultTextTable = getPageText.GetDefaultText(Session("LangID"), objCnn)
            'Additional Language (Use Language in xml)
            Dim dtManageTableLang As DataTable = getProp.GetLangData(1000, 2, -1, Request)
            Dim LangText As String = "lang" + Session("LangID").ToString
			
            PrinterNameParam.InnerHtml = textTable.Rows(41)("TextParamValue")

            SubmitForm.Text = textTable.Rows(12)("TextParamValue")
		
            Dim ChkPrinterType As Boolean = getProp.TableColCheck("Printers", "PrinterTypeID", objCnn)
            Dim PrinterType As DataTable
            If ChkPrinterType = True Then
                PrinterType = getInfo.PrinterTypeInfo(0, objCnn)
                PrinterTypeID.DataSource = PrinterType
                PrinterTypeID.DataValueField = "PrinterTypeID"
                PrinterTypeID.DataTextField = "Description"
                PrinterTypeID.DataBind()
                ShowIsOPOSPrinter.Visible = True
            Else
                ShowIsOPOSPrinter.Visible = False
            End If
		
            'IsOPOS Printer --> InVisiable
            ShowIsOPOSPrinter.Visible = False
		
            Dim PropData As DataTable = objDB.List("select * from propertytextdesp where propertytypeid=101 order by PropertyPosition", objCnn)
            Dim PropList As String
            Dim i As Integer
            Dim PrinterParam() As String
		
            ReDim PrinterParam(-1)
            bolUpdatePrinterByZone = False
            If Not Request.QueryString("PrinterID") And IsNumeric(Request.QueryString("PrinterID")) Then
			
                PrinterID.Value = Request.QueryString("PrinterID")
			    
                If Not Request.QueryString("ZoneID") And IsNumeric(Request.QueryString("ZoneID")) Then
                    ZoneID.Value = Request.QueryString("ZoneID")
                    bolUpdatePrinterByZone = True
                End If
                
                If Not Page.IsPostBack Then
                    CancelButton.Text = defaultTextTable.Rows(2)("TextParamValue")
                                        
                    If ZoneID.Value > 0 Then
                        updateMessage.Text = BackOfficeReport.GetLanguageText(dtManageTableLang, 3, LangText, "Update Printer For Zone : ") & _
                                                getProp.GetTableZoneName(ZoneID.Value, objCnn)
                    Else
                        updateMessage.Text = textTable.Rows(42)("TextParamValue")
                    End If
                    
                    SubmitForm.Text = textTable.Rows(42)("TextParamValue")
					
                    Dim dtPrinterInfo As DataTable
                    If bolUpdatePrinterByZone = True Then
                        dtPrinterInfo = getInfo.GetPrinterByTableZone(ZoneID.Value, PrinterID.Value, objCnn)
                    Else
                        dtPrinterInfo = getInfo.GetPrinters(PrinterID.Value, objCnn)
                    End If
                    
                    PropList = ""
                    For i = 0 To dtPrinterInfo.Rows.Count - 1
                        'Update PrinterDevice/ Property From PrinterByTableZone
                        If bolUpdatePrinterByZone = True Then
                            If Not IsDBNull(dtPrinterInfo.Rows(i)("ZonePrinterDeviceName")) Then
                                dtPrinterInfo.Rows(i)("PrinterDeviceName") = dtPrinterInfo.Rows(i)("ZonePrinterDeviceName")
                            End If
                            If Not IsDBNull(dtPrinterInfo.Rows(i)("ZonePrinterProperty")) Then
                                dtPrinterInfo.Rows(i)("PrinterDeviceNameFor98") = dtPrinterInfo.Rows(i)("ZonePrinterProperty")
                            End If
                            If Not IsDBNull(dtPrinterInfo.Rows(i)("ZoneOPOSPrinter")) Then
                                dtPrinterInfo.Rows(i)("IsOPOSPrinter") = dtPrinterInfo.Rows(i)("ZoneOPOSPrinter")
                            End If
                        End If

                        If IsDBNull(dtPrinterInfo.Rows(i)("PrinterName")) Then
                            PrinterName.Text = ""
                        Else
                            PrinterName.Text = dtPrinterInfo.Rows(i)("PrinterName")
                        End If
                        If bolUpdatePrinterByZone = True Then
                            PrinterName.Enabled = False
                        End If
                        
                        If IsDBNull(dtPrinterInfo.Rows(i)("PrinterDeviceName")) Then
                            PrinterDeviceName.Text = ""
                        Else
                            PrinterDeviceName.Text = dtPrinterInfo.Rows(i)("PrinterDeviceName")
                        End If
                        If IsDBNull(dtPrinterInfo.Rows(i)("PrinterDeviceNameFor98")) Then
                            PropList = ""
                            PrinterDeviceNameFor98.Text = ""
                        Else
                            PrinterDeviceNameFor98.Text = dtPrinterInfo.Rows(i)("PrinterDeviceNameFor98")
                            PropList = dtPrinterInfo.Rows(i)("PrinterDeviceNameFor98")
                        End If
                        If ChkPrinterType = True Then
                            If dtPrinterInfo.Rows(i)("IsOPOSPrinter") = True Or dtPrinterInfo.Rows(i)("IsOPOSPrinter") = 1 Then
                                Radio1.Checked = True
                            Else
                                Radio2.Checked = True
                            End If
                            Dim j As Integer
                            For j = 0 To PrinterTypeID.Items.Count - 1
                                If PrinterTypeID.Items(j).Value = dtPrinterInfo.Rows(i)("PrinterTypeID") Then
                                    PrinterTypeID.Items(j).Selected = True
                                End If
                            Next
                            If bolUpdatePrinterByZone = True Then
                                DisplayPrinterTypeID.Visible=False 
                            Else
                                DisplayPrinterTypeID.Visible = True
                            End If
                            
                            
                        End If
                    Next
                    PrinterParam = PropList.Split(","c)
                End If
            Else
                CancelButton.Text = defaultTextTable.Rows(2)("TextParamValue")
                updateMessage.Text = textTable.Rows(40)("TextParamValue")
                SubmitForm.Text = textTable.Rows(40)("TextParamValue")
			
                PrinterID.Value = -1
                If Not Page.IsPostBack Then
                    Radio2.Checked = True
                End If

            End If
		
            Dim PropVal As String
            Dim PropString As String = ""
            For i = 0 To PropData.Rows.Count - 1
                PropVal = ""
                If Not Request.Form("Prop_" & i.ToString) Is Nothing Then
                    PropVal = Request.Form("Prop_" & i.ToString)
                ElseIf PrinterID.Value <> -1 Then
                    If (PrinterParam.Length - 1) >= i Then
                        PropVal = PrinterParam(i)
                    End If
                End If
                PropString += "<tr>"
                PropString += "<td class=""text"">" + PropData.Rows(i)("PropertyName") + "</td><td><input type=""text"" name=""Prop_" + i.ToString + """ value=""" + PropVal + """>" + "</td>"
                PropString += "</tr>"
            Next
		
            PrinterProp.InnerHtml = PropString
	
            'Catch ex As Exception
            'errorMsg.InnerHtml = ex.Message
            'End Try
        Else
            updateMessage.Text = "Access Denied"
        End If
    End Sub

    Sub DoAddUpdate(Source As Object, E As EventArgs)
        Dim FoundError As Boolean = False
        Dim textTable As New DataTable()
        textTable = getPageText.GetText(9, Session("LangID"), objCnn)
        validateName.InnerHtml = ""
        If Len(Trim(PrinterName.Text)) = 0 Then
            validateName.InnerHtml = "<tr><td></td><td class=""errorText"">*" & textTable.Rows(43)("TextParamValue") & "</td></tr>"
            FoundError = True
        End If
        If FoundError = False Then
            Dim Result As String
            Dim ExtraSQL(1) As String

            ExtraSQL(0) = ""
            ExtraSQL(1) = ""
		
            Application.Lock()
            Dim strPrinterProperty As String
            Dim dtProertyData As DataTable = objDB.List("select * from propertytextdesp where propertytypeid=101 order by PropertyPosition", objCnn)
            Dim i As Integer
            strPrinterProperty = ""
            For i = 0 To dtProertyData.Rows.Count - 1
                If Not Request.Form("Prop_" & i.ToString) Is Nothing Then
                    If i = 0 Then
                        strPrinterProperty &= Replace(Request.Form("Prop_" & i.ToString), ",", "")
                    Else
                        strPrinterProperty &= "," & Replace(Request.Form("Prop_" & i.ToString), ",", "")
                    End If
                Else
                    If i = 0 Then
                        strPrinterProperty &= ""
                    Else
                        strPrinterProperty &= ","
                    End If
                End If
            Next i
                        
            'Add/ Update Printer By TableZone
            If bolUpdatePrinterByZone = True Then
                Dim isOPOS As Integer
                If Radio1.Checked = True Then
                    isOPOS = 1
                Else
                    isOPOS = 0
                End If
                Result = getInfo.AddUpdatePrinterByTableZone(ZoneID.Value, PrinterID.Value, Replace(PrinterName.Text, "'", "''"), _
                                 Replace(PrinterDeviceName.Text, "'", "''"), isOPOS, Replace(strPrinterProperty, "'", "''"), objCnn)
            Else
                'Add/ Update Printer In Printers
                Result = getCnn.AddUpdatePrinter(Request, ExtraSQL, "Printers", "PrinterID", objCnn)
                Dim UpdateID As Integer = PrinterID.Value
                If PrinterID.Value = -1 Then
                    Dim getMax As DataTable = objDB.List("select MAX(printerid) As MaxID from printers", objCnn)
                    If IsNumeric(getMax.Rows(0)("MaxID")) Then
                        UpdateID = getMax.Rows(0)("MaxID")
                    End If
                End If
           
                If dtProertyData.Rows.Count > 0 Then
                    objDB.sqlExecute("update printers set PrinterDeviceNameFor98='" + Replace(strPrinterProperty, "'", "''") + "' where PrinterID=" + UpdateID.ToString, objCnn)
                End If
            End If
            Application.UnLock()
            If Result = "Success" Then
                If bolUpdatePrinterByZone = False Then
                    Response.Redirect("Printers.aspx")
                Else
                    Response.Redirect("PrinterByTableZone.aspx?ZoneID=" & ZoneID.Value)
                End If
            Else
                errorMsg.InnerHtml = Result
            End If

        End If
    End Sub

    Sub DoCancel(Source As Object, E As EventArgs)
        If bolUpdatePrinterByZone = False Then
            Response.Redirect("Printers.aspx")
        Else
            Response.Redirect("PrinterByTableZone.aspx?ZoneID=" & ZoneID.Value)
        End If
    End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
