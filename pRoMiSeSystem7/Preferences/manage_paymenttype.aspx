<%@ page language="C#" autoeventwireup="true" inherits="Preferences_manage_paymenttype, App_Web_manage_paymenttype.aspx.475a53d1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        a.del {
            color: #0B55C4;
        }

            a.del:hover {
                color: #BAC40B;
                cursor: pointer;
            }

        table.fixed {
            table-layout: fixed;
        }

            table.fixed td {
                overflow: hidden;
            }

                table.fixed td.lbProduct {
                    width: 50px;
                }

                table.fixed td.ddlProduct {
                    width: 200px;
                }

                table.fixed td.lbDate {
                    width: 40px;
                }

                table.fixed td.ddlDate {
                    width: 120px;
                }

        table.report {
            border: solid;
            border-width: 1px;
            border-collapse: collapse;
        }

            table.report th {
                padding: 5px;
                border: solid 1px #000;
            font-size:11px;
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
                border: solid 1px #000;
            font-size:11px;
            }

                table.report tbody td.sum {
                    padding: 4px;
                    background: #ebebeb;
                    border-top-width: 2px;
                    border: solid 1px #000;
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
        function AddWasteType() {
            document.getElementById("dialogadd").style.visibility = (document.getElementById("dialogadd").style.visibility == "visible") ? "hidden" : "visible";
        }
        function PrintDivContent(divId) {
            var printContent = document.getElementById(divId);
            var WinPrint = window.open('', '', 'left=0,top=0,toolbar=0,sta­tus=0');
            WinPrint.document.write(printHTML.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
        }
        function DeleteConfirm(id) {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value_delete";
            if (confirm("You want to delete data?")) {
                confirm_value.value = "Yes";
                window.location = id;
            }
            else
                confirm_value.value = "No";
            document.forms[0].appendChild(confirm_value);
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
                        <span class="headerText"> Manage Pay Type Setting</span>
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

                        <div>
                            <a href="edit_paymenttype.aspx?action=add"> + Add Payment Type</a>&nbsp;&nbsp;&nbsp;
                            <span id="spCancanConfig" runat="server"><a href="cancan_configsetting.aspx"> Cancan Config</a></span>
                            <br />
                            <br />
                            <span id="resultHTML" runat="server"></span>
                        </div>                        
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
    </form>
</body>
</html>
