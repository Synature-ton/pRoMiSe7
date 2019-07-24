<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="cancan_paymentconfig.aspx.vb" Inherits="POSBackOfficeSetting.cancan_paymentconfg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        div.adddialog {
            visibility: hidden;
            position: absolute;
            left: 0px;
            top: 0px;
            width: 100%;
            height: 100%;
            text-align: center;
            z-index: 1000;
            background-color: rgba(46, 46, 46, 0.59);
        }

            div.adddialog div {
                width: 300px;
                margin: 100px auto;
                background-color: #fff;
                border: 1px solid #000;
                padding: 15px;
                text-align: center;
            }

        table.fixed {
            table-layout: fixed;
        }

            table.fixed td {
                overflow: hidden;
            }                          

        table.report {
            border: solid;
            border-width: 1px;
            border-collapse: collapse;
        }

            table.report th {
                padding: 10px;
                border: solid 1px #000;
            }

            table.report thead th {
                background: #507093;
                color: #fff;
            }

            table.report tbody th {
                background: #507093;
                color: #fff;
            }

            table.report tbody td {
                padding: 4px;
                background: #fff;
            }

                table.report tbody td.sum {
                    padding: 4px;
                    background: #ebebeb;
                    border-top-width: 2px;
                }

            table.report tbody tr:nth-child(even):hover td, table.report tbody tr:nth-child(odd):hover td {
                background-color: #FFFFDD;
            }

            table.report .pagination {
                display: table;
                padding: 0;
                margin: 0 auto;
            }
        .auto-style1 {
            width: 845px;
        }
    </style>
    <script type="text/javascript">

        function Comma(Num) { //function to add commas to textboxes
            Num += '';
            Num = Num.replace(',', ''); Num = Num.replace(',', ''); Num = Num.replace(',', '');
            Num = Num.replace(',', ''); Num = Num.replace(',', ''); Num = Num.replace(',', '');
            x = Num.split('.');
            x1 = x[0];
            x2 = x.length > 1 ? '.' + x[1] : '';
            var rgx = /(\d+)(\d{3})/;
            while (rgx.test(x1))
                x1 = x1.replace(rgx, '$1' + ',' + '$2');
            return x1 + x2;
        }

        function NumberCheck(evt, exp) {
            if (exp == 1)
                if (evt.charCode == 46)
                    return true;
            if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                alert("Allow Only Numbers");
                return false;
            }
        }

        function onLeave(_input) {
            var check = _input.value;
            if (check.length == 0) {
                _input.focus();
                document.getElementById("cmdSubmit").disabled = true;
                _input.style.borderColor = "#F44336";
            }
            else {
                document.getElementById("cmdSubmit").disabled = false;
                _input.style.borderColor = "";
            }
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table bgcolor="White" cellpadding="0" cellspacing="0">
                <tr style="background-color: #EEEEEE">
                    <td height="35" style="background-image: url('../images/headerstub.jpg')">&nbsp;&nbsp;</td>
                    <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                        <asp:Label ID="lblHeader" runat="server" CssClass="headerText" Text="Cancan Payment Setting For "></asp:Label>
                    </td>
                    <td rowspan="99" style="background-color: #003366; width: 1px;">
                        <img src="../images/clear.gif" height="1px" width="1px">
                    </td>
                </tr>
                <tr style="background-color: #666666">
                    <td width="3%" height="1"></td>
                    <td width="94%"></td>
                    <td width="3%"></td>
                </tr>
                <tr>
                    <td height="10" colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <asp:HiddenField ID="cancanPayTypeID" runat="server" />
                        <input type="hidden" id="validate_checker_value" runat="server" />
                        <a id="A1" href="cancan_configsetting.aspx" runat="server">Back to manage Cancan config</a>
                        <br />
                        <br />
                        <table>
                            <tr>
                                <td style="vertical-align: top;" class="auto-style1">
                                    <table>
                                      <tr id="tr_name" runat="server">
                                         <td style="text-align: right; width: 160px;">
                                            <asp:Label ID="lblPaymentName" runat="server" Text="Pay Type Name : "></asp:Label>
                                         </td>
                                         <td>
                                            &nbsp;&nbsp;<asp:TextBox ID="txtPayTypeName" runat="server" Text="" onblur="onLeave(this)" TabIndex="1" Enabled="False" Width="355px"></asp:TextBox>
                                         </td>
                                      </tr>
                                      <tr id="tr_group" runat="server">
                                          <td style="text-align: right;">
                                            <asp:Label ID="lblPaymentGateway" runat="server" Text="Payment Gateway : "></asp:Label>
                                          </td>  
                                          <td>
                                            &nbsp;&nbsp;<asp:TextBox ID="txtPaymentGateway" runat="server" Text="" onblur="onLeave(this)" TabIndex="2" Width="355px"></asp:TextBox>
                                          </td>
                                       </tr>
                                       <tr id="tr_vat" runat="server">
                                          <td style="text-align: right;">
                                            <asp:Label ID="lblCurrency" runat="server" Text="Currency : "></asp:Label>
                                          </td>
                                          <td>
                                            &nbsp;&nbsp;<asp:TextBox ID="txtCurrency" runat="server" Text="" onblur="onLeave(this)" TabIndex="3" MaxLength="3" Width="96px"></asp:TextBox>
                                          </td>
                                       </tr>
                                       <tr><td>&nbsp;</td></tr>
                                       <tr>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;&nbsp;
                                            <asp:Button ID="cmdSubmit" runat="server" Text="Save" Width="130px" />
                                          </td>
                                       </tr>
                                    </table>
                                </td>                               
                            </tr>
                        </table>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3" height="30">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3" style="background-color: #999999; height: 1px;"></td>
                </tr>
                <tr>
                    <td height="50" colspan="3" style="background-image: url('../images/footerbg2000.gif')">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3" style="background-color: #999999; height: 1px;"></td>
                </tr>
            </table>
        </div>

        <script language="javascript">
            function WebForm_FireDefaultButton(event, target) {
                if (event.keyCode == 13)
                    return false;
                return true;
            }
        </script>

    </form>
</body>
</html>
