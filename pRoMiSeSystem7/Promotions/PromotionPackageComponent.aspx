<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PromotionPackageComponent.aspx.vb" Inherits="POSPromotionSettings.PromotionPackageComponent" %>

<!DOCTYPE html>

<<html>
<head id="Head1" runat="server">
    <title>Promotion Set Setting - Voucher/ Coupon List</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />

    <script language="JavaScript" src="../StyleSheet/webscript.js"></script>

    <style type="text/css">
        .auto-style1 {
            height: 1px;
        }
    </style>

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
                    <asp:Label ID="lblHeader" runat="server" Text="Promotion Set - Voucner/ Coupon Setting" CssClass="headerText"></asp:Label>
                </div>
            </td>
            <td rowspan="98" style="background-color: #003366; width: 1px;">
                <img src="../images/clear.gif" height="1px" width="1px">
            </td>
        </tr>
        <tr style="background-color: #666666">
            <td width="3%" class="auto-style1">
            </td>
            <td width="94%" class="auto-style1">
            </td>
            <td width="3%" class="auto-style1">
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
            <td style=" text-align:left;">
                <asp:LinkButton ID="lnkBackToPromotionPackageEdit" runat="server" >Back</asp:LinkButton>
            </td>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <table style="width: 75%;" class="blue">
                    <thead>
                        <tr>
                            <th style="width: 5%;">
                                <asp:Label ID="lblComponentNo" runat="server" Text=""></asp:Label>
                            </th>
                            <th style="width: 50%;">
                                <asp:Label ID="lblVoucherName" runat="server" Text="Voucher/ Coupon Name"></asp:Label>
                            </th>
                            <th style="width: 20%;">
                                <asp:Label ID="lblNoOfVoucher" runat="server" Text="Qty."></asp:Label>
                            </th>
                            <th style="width: 5%;">
                                <asp:Label ID="lblEditComponent" runat="server" Text="Edit"></asp:Label>
                            </th>
                            <th style="width: 5%;">
                                <asp:Label ID="lblDeleteComponent" runat="server" Text="Delete"></asp:Label>
                            </th>
                        </tr>
                    </thead>
                    <asp:Label ID="lblComponent1" runat="server"></asp:Label>

                    <tr id="trEdit" runat="server">
                        <td>
                        </td>
                        <td>
                            <asp:DropDownList ID="cboVoucherType" runat="server" ></asp:DropDownList>
                        </td>
                        <td style=" text-align:center;">
                            <asp:TextBox ID="txtNoOfVoucher" runat="server" Style="width: 50px; text-align: center; " class="txt-numeric" MaxLength="3">0</asp:TextBox>
                            &nbsp;&nbsp;<asp:Label ID="lblNoVoucherValidate" runat="server" CssClass="redText"></asp:Label>
                        </td>
                        <td colspan="2" style=" text-align:center;">
                            <asp:Button ID="cmdUpdateComponent" runat="server" Text="Save" Width="100px" />
                            <asp:HiddenField ID="hdfEditVoucherTypeID" runat="server" />
                        </td>
                    </tr>
                    <asp:Label ID="lblComponent2" runat="server"></asp:Label>
                </table>
            </td>
        </tr>
        <tr class="text">
            <td>
                &nbsp;
            </td>
            <td>
            <span id="ErrorText" runat="server"></span>
            </td>
        </tr>
        <tr>
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
