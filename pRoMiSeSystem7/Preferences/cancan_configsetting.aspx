<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="cancan_configsetting.aspx.vb" Inherits="POSBackOfficeSetting.Cancan_configsetting" %>

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
        <input type="hidden" id="validate_checker_value" runat="server" />
        <div>
            <table bgcolor="White" cellpadding="0" cellspacing="0">
                <tr style="background-color: #EEEEEE">
                    <td height="35" style="background-image: url('../images/headerstub.jpg')">&nbsp;&nbsp;</td>
                    <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                        <span class="headerText">Cancan Config Setting</span>
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
                    <td height="20" >&nbsp;</td>
                    <td><a id="A1" href="manage_paymenttype.aspx" runat="server">Back to manage Payment</a></td>
                    <td></td>
                </tr>
                <tr><td height ="20" colspan="3" ></td></tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <table>
                            <tr>
                                <td style="vertical-align: top;">
                                    <table>
                                      <tr id="tr_name" runat="server">
                                         <td style="text-align: right; width: 100px;">
                                            <asp:Label ID="lblPaymentURL" runat="server" Text="Payment URL :"></asp:Label>
                                         </td>
                                         <td>
                                            <asp:TextBox ID="txtPaymentURL" runat="server" Text="" onblur="onLeave(this)" TabIndex="1" Width="400px"></asp:TextBox>
                                         </td>
                                      </tr>
                                      <tr id="tr_group" runat="server">
                                          <td style="text-align: right;">
                                            <asp:Label ID="lblAPIKey" runat="server" Text="API Key :"></asp:Label>
                                          </td>  
                                          <td>
                                            <asp:TextBox ID="txtAPIKey" runat="server" Text="" onblur="onLeave(this)" TabIndex="2" Width="400px"></asp:TextBox>
                                          </td>
                                          <td style="vertical-align: top;">
                                            <asp:Button ID="cmdUpdateConfig" runat="server" Text="Update" Width="80px" />
                                          </td>
                                       </tr>
                                       <tr id="tr_vat" runat="server">
                                          <td style="text-align: right;">
                                              &nbsp;</td>
                                          <td>
                                              &nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                               
                            </tr>
                            <tr>
                                <td colspan="2">
                                <span id="spPaymentConfig" runat="server" ></span>
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
