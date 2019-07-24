<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="promotion_Level_Edit.aspx.vb"
    Inherits="POSPromotionSettings.promotion_Level_Edit" %>

<html>
<head id="Head1" runat="server">
    <title>Promotion Setting</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />

    <script language="JavaScript" src="../StyleSheet/webscript.js"></script>

    <script>
        // สำหรับซ่อนพาเนลของเงื่อนไขโปรโมชั่น
        function HidedRows(id) {
            if (document.getElementById) {
                document.getElementById(id).style.display = 'none';
            }
        }
        // สำหรับเปิดแสดงพาเนลของเงื่อนไขโปรโมชั่น
        function ShowRows(id) {
            if (document.getElementById) {
                document.getElementById(id).style.display = '';
            }
        }
        // สำหรับปิดการใช้งาน Control
        function Disable(id, boolean) {
            if (document.getElementById) {
                document.getElementById(id).disabled = boolean;
            }
        }
        //สำหรับกรณี เลือกเงื่อนไขส่วนลดเป็นแบบ ให้ฟรี / แลกซื้อสินค้า
        //ให้เปิด Panel กำหนดค่าส่วนลดต่างๆ ได้
        function CheckEnableConditionPromotion(id) {
            if (id == 'RdoFree') {
                ShowRows('PlDiscount');
            } else {
                HidedRows('PlDiscount');
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
                    <asp:Label ID="lh" runat="server" Text="Promotion Setting" CssClass="headerText"></asp:Label></div>
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
                <table style="width: 650px;">
                    <tr>
                        <td>
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lf1" runat="server" Text="Promotion Level"></asp:Label></legend>
                                <table>
                                    <tr>
                                        <td>
                                            <table cellspacing="0" style="width: 100%;">
                                                <tr>
                                                    <td align="left">
                                                        <asp:Label ID="lbPromoLevelName" runat="server" Text="Promotion Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPromoLevelName" runat="server" Width="350px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:Label ID="lblPromoLevelCode" runat="server" Text="Promo Code"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPromoLevelCode" runat="server" Width="350px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:Label ID="LbPromoAmount" runat="server" Text="Amount"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="LbPromoStartAmount" runat="server" Text=" >"></asp:Label>
                                                        <asp:TextBox ID="txtStartAmount" runat="server" Width="100px"></asp:TextBox>
                                                        &nbsp;
                                                        <asp:Label ID="LbPromoEndAmount" runat="server" Text="<="></asp:Label>
                                                        &nbsp;
                                                        <asp:TextBox ID="txtEndAmount" runat="server" Width="100px"></asp:TextBox>&nbsp;
                                                        <asp:Label ID="LbAmountText" runat="server" Text="Piece"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:Label ID="LbUseOnly" runat="server" Text="Promotion Use Only"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:RadioButtonList ID="RdoUseOnly" runat="server" RepeatDirection="Horizontal">
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lf2" runat="server" Text="Select Discount"></asp:Label></legend>
                                <table style="width: 600px;">
                                    <tr style="display:none;">
                                        <td>
                                            <table >
                                                <tr>
                                                    <td>
                                                        <asp:RadioButton ID="RdoPercentDiscount" runat="server" GroupName="d" Text="Discount"
                                                           onClick="CheckEnableConditionPromotion('RdoPercentDiscount')" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPercentDiscount" runat="server" Style="width: 50px;"></asp:TextBox>
                                                        <asp:Label ID="LbPercentDiscount" runat="server" Text="Percent"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr style="display:none;">
                                        <td>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:RadioButton ID="RdoDiscountAmount" runat="server" GroupName="d" Text="Discount"
                                                            onClick="CheckEnableConditionPromotion('RdoDiscountAmount')" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDiscountAmount" runat="server" Style="width: 50px;"></asp:TextBox>
                                                        <asp:Label ID="LbDiscountAmount" runat="server" Text="Bath"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr style="display:none;">
                                        <td>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:RadioButton ID="RdoFree" runat="server" GroupName="d" onClick="CheckEnableConditionPromotion('RdoFree')" Checked="true" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="LbRdoFree" runat="server" Text=" Free / Purchase"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <div id="PlDiscount" runat="server">
                                                            <table style="width: 550px;">
                                                                <tr>
                                                                    <td><fieldset style="border:solid 0 fff;">
                                                                        <legend>
                                                                                <asp:RadioButton ID="RdoOtherDiscount" runat="server" GroupName="ddd"
                                                                                    Text="Discount is other" /></legend>
                                                                       </fieldset>
                                                                        <fieldset>
                                                                            <legend>
                                                                                <asp:RadioButton ID="RdoForDiscountBathOrPercent" runat="server" GroupName="ddd"
                                                                                    Text="Discount" /></legend>
                                                                            <table>
                                                                                <tr>
                                                                                    <td style="width: 70px;">
                                                                                        <asp:Label ID="LbForDiscount" runat="server" Text="For discount"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 150px;">
                                                                                        <asp:TextBox ID="txtForDiscountBathOrPercent" runat="server" Style="width: 50px;"></asp:TextBox>
                                                                                        <asp:DropDownList ID="DdlForDiscountBathOrPercent" runat="server">
                                                                                            <asp:ListItem Value="1">%</asp:ListItem>
                                                                                            <asp:ListItem Value="2">Bath</asp:ListItem>
                                                                                            <asp:ListItem Value="3">One Price</asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="LbDiscountFor" runat="server" Text="A piece"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtDiscountForBonusProduct" runat="server" Style="width: 50px;"></asp:TextBox>&nbsp;<asp:Label ID="LbPieceText_P" runat="server" Text="Piece"></asp:Label></td>
                                                                                </tr>
                                                                            </table>
                                                                        </fieldset>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <fieldset>
                                                                            <legend>
                                                                                <asp:RadioButton ID="RdoFreeOfCharge" runat="server" GroupName="ddd" Text="Free" /></legend>
                                                                            <table>
                                                                                <tr>
                                                                                    <td style="width: 70px;">
                                                                                        <asp:Label ID="LbFree" runat="server" Text="For redeem purchase"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 70px;">
                                                                                        <asp:TextBox ID="txtFreeOrPurchase" runat="server" Style="width: 50px;"></asp:TextBox>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="LbFree_P" runat="server" Text="Piece"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </fieldset>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <fieldset>
                                                <legend>
                                                    <asp:RadioButton ID="RdoNoDiscount" runat="server" Text="Discount coupon on the next bill"
                                                        GroupName="ddd"/></legend>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="LbCoupon" runat="server" Text="Select Coupon"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="DdlCoupon" runat="server">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td><span id="SetHeaderFooterCouponNextReceipt" runat="server"></span></td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <fieldset>
                                                <legend><asp:Label ID="lf4" runat="server"
                                                    Text="Amount specified above for the product."></asp:Label></legend>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:RadioButton ID="RdoProductSame" runat="server" Text="Product same" GroupName="dp" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:RadioButton ID="RdoProductdifferent" runat="server" Text="Product different"
                                                                GroupName="dp" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:Button ID="BtnSavePromo" runat="server" Text="Save" Height="25px" />
                            <asp:Button ID="BtnUpdatePromo" runat="server" Text="Save" Height="25px" />
                            <asp:Button ID="BtnCancelPromo" runat="server" Text="Cancel" Height="25px" />
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
