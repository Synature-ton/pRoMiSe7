<%@ page language="VB" autoeventwireup="false" inherits="Frm_StockCard, App_Web_frm_stockcard.aspx.dfa151d5" enableeventvalidation="false" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report StockCard</title>
    <link href="../StyleSheet/StyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="true"
        EnableScriptLocalization="true" AsyncPostBackTimeout="50000" >
    </asp:ScriptManager>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<b class="headerText"><div class="headerText" align="left" id="Text_SectionParam" runat="server" />
        <asp:Label ID="LbTitle" runat="server" Text="รายงานทะเบียนวัตถุดิบ"></asp:Label> </b></td>
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
<td> <div>
        <table>
            <tr style="height: 25%; width: 100%">
                <td style="width: 25%">
                    &nbsp;
                    <asp:DropDownList ID="DdlproductLevel" runat="server">
                    </asp:DropDownList>
                </td>
                <td style="width: 15%">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:RadioButton ID="RdoMonth" runat="server" AutoPostBack="True" Text="เลือกช่วงเดือน"
                                Checked="True" />
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="RdoMonth" EventName="CheckedChanged" />
                            <asp:AsyncPostBackTrigger ControlID="RdoBetweenDate" EventName="CheckedChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
                <td style="width: 15%">
                    <asp:DropDownList ID="DdlMonth" runat="server">
                    </asp:DropDownList>
                </td>
                <td style="width: 15%">
                    <asp:DropDownList ID="DdlYear" runat="server">
                    </asp:DropDownList>
                </td>
                <td style="width: 5%">
                </td>
                <td>
                    <asp:Button ID="BtnSubmit" runat="server" Text="Generate Report" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:RadioButton ID="RdoBetweenDate" runat="server" AutoPostBack="True" Text="เลือกระหว่างวันที่" />
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="RdoBetweenDate" EventName="CheckedChanged" />
                            <asp:AsyncPostBackTrigger ControlID="RdoMonth" EventName="CheckedChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
                <td>
                    <asp:UpdatePanel ID="UdPnlStartDate" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:TextBox ID="TxtStartDate" runat="server" BackColor="PapayaWhip" BorderColor="White"
                                Width="130px"></asp:TextBox>
                            <asp:ImageButton ID="BtnStartDate" runat="server" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                Height="7%" />
                            <cc1:CalendarExtender ID="StartDateExtend" runat="server" PopupButtonID="BtnStartDate"
                                TargetControlID="TxtStartDate" CssClass="MyCalendar" Format="dd / MM / yyyy">
                            </cc1:CalendarExtender>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="BtnStartDate" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
                <td>
                    <asp:UpdatePanel ID="UdPnlEndDate" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:TextBox ID="TxtEndDate" runat="server" BackColor="PapayaWhip" BorderColor="White"
                                Width="130px"></asp:TextBox>
                            <asp:ImageButton ID="BtnEndDate" runat="server" Height="7%" ImageUrl="~/Images/Calendar_scheduleHS.png" />
                            <cc1:CalendarExtender ID="EndDateExtend" runat="server" PopupButtonID="BtnEndDate"
                                TargetControlID="TxtEndDate" CssClass="MyCalendar" Format="dd / MM / yyyy">
                            </cc1:CalendarExtender>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="BtnEndDate" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="100">
                        <ProgressTemplate>
                            &nbsp;<img src="../Images/loading3.gif" />กรุณารอสักครู่ ...
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                
                  <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" HorizontalAlign="Center"
                            EmptyDataText="NO DATA" PageSize="50">
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" CssClass="smalltext" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="smallTdHeader"  />
                            <EditRowStyle BackColor="#999999" />
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        </asp:GridView>
             
                      
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="BtnSubmit" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div></td>
<td>&nbsp;</td>
</tr>

<tr><td colspan="3" height="30">&nbsp;</td></tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
<tr>
	<td height="50" colspan="3" background="../images/footerbg2000.gif">&nbsp;</td>
</tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
</table>
    
    </form>
</body>
</html>
