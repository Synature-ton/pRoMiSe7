<%@ page language="VB" autoeventwireup="false" inherits="Reports_ProductNotActive, App_Web_productnotactive.aspx.dfa151d5" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
        <tr bgcolor="eeeeee">
            <td height="35" nowrap background="../images/headerstub.jpg">
                &nbsp; &nbsp;
            </td>
            <td colspan="2" background="../images/headerbg2000.jpg">
                <b class="headerText">
                    <div class="headerText" align="left" id="Text_SectionParam" runat="server">
                        <asp:Label ID="lblnewsManager" runat="server" Text="Product Not Active"></asp:Label></div>
                </b>
            </td>
            <td width="1" nowrap rowspan="99" bgcolor="003366">
                <img src="../images/clear.gif" height="1" width="1">
            </td>
        </tr>
        <tr bgcolor="666666">
            <td width="3%" height="1">
                <p style="line-height: 1px;">
                    <img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p>
            </td>
            <td width="94%">
                <p style="line-height: 1px;">
                    <img src="../images/clear.gif" height="1" width="1" border="0" hspace="252"></p>
            </td>
            <td width="3%">
                <p style="line-height: 1px;">
                    <img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p>
            </td>
        </tr>
        <tr>
            <td height="10" colspan="3">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td style="height: 16px">
                &nbsp;
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
               
                <table style="width: 100%;">
                    <tr>
                        <td style="width: 15%;" valign="top">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <asp:DropDownList ID="ddlProductLevel" runat="server" Width="170px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:DropDownList ID="ddlProductGroupID" runat="server" Width="170px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <br />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td align="right" style="width: 10%;">
                                                <asp:RadioButton ID="RdBtnMonth" runat="server" Checked="true" GroupName="Group1"
                                                    Text="Month : " TextAlign="Left" />
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlMonth" runat="server">
                                                </asp:DropDownList>
                                                <asp:DropDownList ID="ddlYearByMonth" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RadioButton ID="RdBtnBetween" runat="server" GroupName="Group1" Text="Between : "
                                                    TextAlign="Left" />
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlStartMonthByBetween" runat="server">
                                                </asp:DropDownList>
                                                <asp:DropDownList ID="ddlStartYearByBetween" runat="server">
                                                </asp:DropDownList>
                                                <asp:Label ID="Label1" runat="server" Text="To"></asp:Label>
                                                <asp:DropDownList ID="ddlEndMonthByBetween" runat="server">
                                                </asp:DropDownList>
                                                <asp:DropDownList ID="ddlEndYearByBetween" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RadioButton ID="RdBtnYear" runat="server" GroupName="Group1" Text="Year :  "
                                                    TextAlign="Left" />
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="DDlYear" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="middle" height="35">
                                                &nbsp;<asp:Button ID="BtnShowData" runat="server" Text="Show Report" />
                                            </td>
                                            <td valign="middle">
                                                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                                    <ProgressTemplate>
                                                        <asp:Image ID="Image1" runat="server" Height="30px" ImageUrl="~/Images/loading3.gif"
                                                            Width="30px" />
                                                        &nbsp; Loading...
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="RdBtnMonth" EventName="CheckedChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="RdBtnYear" EventName="CheckedChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
               
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
            
            <asp:GridView ID="gvProductNotActive" runat="server" 
                AutoGenerateColumns="False" BackColor="White" BorderColor="#3366CC" 
                BorderStyle="None" BorderWidth="1px" CellPadding="4" CssClass="smalltext" 
                Width="100%">
                <RowStyle BackColor="White" ForeColor="#003399" />
                <Columns>
                    <asp:BoundField DataField="ProductCode" HeaderStyle-HorizontalAlign="Left" 
                        HeaderText="ProductCode">
                        <HeaderStyle ForeColor="White" Width="15%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ProductName" HeaderStyle-HorizontalAlign="Left" 
                        HeaderText="ProductName">
                        <HeaderStyle ForeColor="White" Width="85%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Bit" HeaderText="Bit" Visible="False" />
                </Columns>
                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
            </asp:GridView>
            <asp:Label ID="LblError" runat="server"></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
    </td>
    <td style="height: 16px">
        &nbsp;
    </td>
    </tr>
    <tr>
        <td colspan="3" height="30">
            &nbsp;
        </td>
    </tr>
    <tr>
        <td height="1" colspan="3" bgcolor="999999">
            <p style="line-height: 1px;">
                <img src="../images/clear.gif" height="1" width="1"></p>
        </td>
    </tr>
    <tr>
        <td height="50" colspan="3" background="../images/footerbg2000.gif">
            &nbsp;
        </td>
    </tr>
    <tr>
        <td height="1" colspan="3" bgcolor="999999">
            <p style="line-height: 1px;">
                <img src="../images/clear.gif" height="1" width="1"></p>
        </td>
    </tr>
    </table>
    </form>
</body>
</html>
