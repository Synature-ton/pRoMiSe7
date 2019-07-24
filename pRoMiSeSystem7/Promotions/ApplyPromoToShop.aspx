<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ApplyPromoToShop.aspx.vb"
    Inherits="POSPromotionSettings.ApplyPromoToShop" %>

<html>
<head id="Head1" runat="server">
    <title>Promotion Setting</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />

    <script language="JavaScript" src="../StyleSheet/webscript.js"></script>

    <script>
        function OnChangeCheckBox1(selectedOption) {
            var objCheckListBox = document.getElementById('<%= ChkShopList.ClientID %>');
            var chkBoxCount = objCheckListBox.getElementsByTagName("input");
            if (selectedOption == 1) {

                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = true;
                }

            }
            else if (selectedOption == 2) {
                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = false;
                }

            }
        }
        function OnChangeCheckBox2(selectedOption) {
            var objCheckListBox = document.getElementById('<%= ChkSelectShop.ClientID %>');
            var chkBoxCount = objCheckListBox.getElementsByTagName("input");
            if (selectedOption == 1) {

                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = true;
                }

            }
            else if (selectedOption == 2) {
                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = false;
                }

            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <table bgcolor="White" cellpadding="0" cellspacing="0">
        <tr style="background-color: #EEEEEE">
            <td height="35" style="background-image: url('../images/headerstub.jpg')">
                &nbsp; &nbsp;
            </td>
            <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                <div>
                    <asp:Label ID="lh" runat="server" Text="Apply promotion to branch" CssClass="headerText"></asp:Label></div>
            </td>
            <td rowspan="99" style="background-color: #003366; width: 1px;">
                <img src="../images/clear.gif" height="1px" width="1px">
            </td>
        </tr>
        <tr style="background-color: #666666">
            <td width="3%" height="1">
            </td>
            <td width="94%">
            </td>
            <td width="3%">
            </td>
        </tr>
        <tr>
            <td height="10" colspan="3">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <table style="width: 550px;">
                    <tr><td><asp:Label ID="lbPromoName" runat="server" CssClass="headerText"></asp:Label></td></tr>
                    <tr>
                        <td>
                            <fieldset>
                                <legend>Select Branch</legend>
                                <table>
                                    <tr>
                                        <td>
                                            <a href="javascript:OnChangeCheckBox1(1)">Select&nbsp;All</a> - <a href="javascript:OnChangeCheckBox1(2)">
                                                Clear&nbsp;All</a>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <a href="javascript:OnChangeCheckBox2(1)">Select&nbsp;All</a> - <a href="javascript:OnChangeCheckBox2(2)">
                                                Clear&nbsp;All</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Pl2" runat="server" Height="250px" ScrollBars="Auto" Width="450px"
                                                Style="border: solid 1px rgb(236, 233,216);">
                                                <asp:CheckBoxList ID="ChkShopList" runat="server">
                                                </asp:CheckBoxList>
                                            </asp:Panel>
                                        </td>
                                        <td align="center">
                                            <input type="button" id="btnAddShop" runat="server" value=">>" style="width: 55px;" />
                                            <input type="button" id="btnRemoveShop" runat="server" value="<<" style="width: 55px;" />
                                        </td>
                                        <td>
                                            <asp:Panel ID="Panel1" runat="server" Height="250px" ScrollBars="Auto" Width="450px"
                                                Style="border: solid 1px rgb(236, 233,216);">
                                                <asp:CheckBoxList ID="ChkSelectShop" runat="server">
                                                </asp:CheckBoxList>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
                <table style="width: 550px;">
                    <tr>
                        <td align="right">
                            <input type="button" id="btnBackToEditPromo" value="Back" runat="server" />
                            <input type="button" id="btnBackToHomePage" runat="server" value="Next" />
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" height="30">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #999999; height: 1px;">
            </td>
        </tr>
        <tr>
            <td height="50" colspan="3" style="background-image: url('../images/footerbg2000.gif')">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #999999; height: 1px;">
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
