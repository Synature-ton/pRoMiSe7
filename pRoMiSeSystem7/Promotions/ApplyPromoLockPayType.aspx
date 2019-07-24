<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ApplyPromoLockPayType.aspx.vb" Inherits="POSPromotionSettings.ApplyPromoLockPayType" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Promotion Setting</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />

    <script language="JavaScript" src="../StyleSheet/webscript.js"></script>

    <script>
        function OnChangeCheckBox1(selectedOption) {
            var objCheckListBox = document.getElementById('<%= chkPaymentList.ClientID%>');
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
            var objCheckListBox = document.getElementById('<%= chkSelectPayment.ClientID%>');
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
                    <asp:Label ID="lblHeader" runat="server" Text="Apply promotion only for specific payment" CssClass="headerText"></asp:Label></div>
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
                                <legend id="lgHeader" runat="server" >Payment can use only for this promotion</legend>
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
                                                <asp:CheckBoxList ID="chkPaymentList" runat="server">
                                                </asp:CheckBoxList>
                                            </asp:Panel>
                                        </td>
                                        <td align="center">
                                            <input type="button" id="cmdSelectPayment" runat="server" value=">>" style="width: 55px;" />
                                            <input type="button" id="cmdSelectPaymentBack" runat="server" value="<<" style="width: 55px;" />
                                        </td>
                                        <td>
                                            <asp:Panel ID="Panel1" runat="server" Height="250px" ScrollBars="Auto" Width="450px"
                                                Style="border: solid 1px rgb(236, 233,216);">
                                                <asp:CheckBoxList ID="chkSelectPayment" runat="server">
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
                        <td>
                            <asp:Label ID="lblNote" runat="server" CssClass="redText"  Text="Not select any payment = promotion can use all payment."></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <input type="button" id="cmdBackToEditPromo" value="Back" runat="server" />
                            <input type="button" id="cmdBackToHomePage" runat="server" value="Next" />
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
