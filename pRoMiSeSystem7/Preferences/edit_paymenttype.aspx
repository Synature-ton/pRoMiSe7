<%@ page language="C#" autoeventwireup="true" inherits="Preferences_edit_paymenttype, App_Web_edit_paymenttype.aspx.475a53d1" %>

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


        function CheckFixPayAmount() {
            var rbIsFixPaymentElement = document.getElementById("<%= rb_IsFixPayment.ClientID %>");
            var rbIsFixPaymentChoice = rbIsFixPaymentElement.getElementsByTagName("input");
            var tbDefaultPayAmount = document.getElementById("<%= tb_DefaultPayAmount.ClientID %>");
            var rbValue = 0;
            var tbValue = tbDefaultPayAmount.value;
            for (var j = 0; j < rbIsFixPaymentChoice.length; j++) {
                if (rbIsFixPaymentChoice[j].checked) {
                    rbValue = rbIsFixPaymentChoice[j].value;
                    break;
                }
            }
            var isChecked = (rbValue == 1 && parseInt(tbValue) > 0) ? true : false;
            return isChecked;
        }

        function CheckStockOnly() {
            var rbElement = document.getElementById("<%= rb_IsStockOnly.ClientID %>");
        var rbChoice = rbElement.getElementsByTagName("input");
        var isChecked = 0;
        for (var i = 0; i < rbChoice.length; i++) {
            if (rbChoice[i].checked) {
                isChecked = rbChoice[i].value;
                break;
            }
        }
        return isChecked;
    }

    function CheckColumnExist() {
        var val = document.getElementById("<%= valueCheckColumn.ClientID %>").value;
        var arr = new Array();
        arr = val.split(',');
        return arr;
    }

    function Detect() {
        var valPayAmount = CheckFixPayAmount();
        var valStockOnly = CheckStockOnly();
        var valColumn = CheckColumnExist();
        if (valStockOnly == 1) {
            document.getElementById("tr_IsPrintReceipt").style.display = "";
            document.getElementById("tr_OtherReceiptPrinter").style.display = "";
            document.getElementById("tr_ExcludeVatServiceCharge").style.display = "";
            document.getElementById("tr_EDCType").style.display = "none";
            document.getElementById("tr_QRPaymentCode").style.display = "none";
            document.getElementById("tr_QRPaymentInquiryFeature").style.display = "none";
            document.getElementById("tr_ConvertTo").style.display = "none";
            document.getElementById("tr_DisplayInReceipt").style.display = "none";
            document.getElementById("tr_GroupSamePayType").style.display = "none";
            document.getElementById("tr_DefaultCcType").style.display = "none";
            document.getElementById("tr_DefaultBankName").style.display = "none";
            document.getElementById("<%= tb_Perc.ClientID %>").disabled = true;
            for (var dis1 = 0; dis1 < document.getElementById("<%= rb_Drawer.ClientID %>").getElementsByTagName("input").length; dis1++)
                document.getElementById("<%= rb_Drawer.ClientID %>").getElementsByTagName("input")[dis1].disabled = false;
            document.getElementById("<%= rb_IsRequire.ClientID %>").getElementsByTagName("input")[0].checked = true;
            for (var dis1 = 0; dis1 < document.getElementById("<%= rb_IsRequire.ClientID %>").getElementsByTagName("input").length; dis1++)
                document.getElementById("<%= rb_IsRequire.ClientID %>").getElementsByTagName("input")[dis1].disabled = true;
            if (valPayAmount) {
                document.getElementById("tr_AdjustExcessPrice").style.display = "";
                document.getElementById("tr_ExcessPrice").style.display = "";
                document.getElementById("tr_AdjustmentToPayType").style.display = "none";
            }
            else {
                document.getElementById("tr_AdjustExcessPrice").style.display = "none";
                document.getElementById("tr_ExcessPrice").style.display = "none";
                document.getElementById("tr_AdjustmentToPayType").style.display = "none";
            }
        }
        else {
            document.getElementById("tr_IsPrintReceipt").style.display = "none";
            document.getElementById("tr_OtherReceiptPrinter").style.display = "none";
            document.getElementById("tr_ExcludeVatServiceCharge").style.display = "none";
            document.getElementById("tr_ConvertTo").style.display = "";
            document.getElementById("tr_EDCType").style.display = "";
            var ddlEDC = document.getElementById("<%=ddl_EDCType.ClientID%>");
            var SelVal = ddlEDC.options[ddlEDC.selectedIndex].value;
            if (SelVal == 20) {
                document.getElementById("tr_QRPaymentCode").style.display = "";
                document.getElementById("tr_QRPaymentInquiryFeature").style.display = "";                
            }
            else {
                document.getElementById("tr_QRPaymentCode").style.display = "none";
                document.getElementById("tr_QRPaymentInquiryFeature").style.display = "none";
            }
            document.getElementById("tr_DisplayInReceipt").style.display = "";
            document.getElementById("tr_GroupSamePayType").style.display = "";

            var ddl = document.getElementById("<%=ddl_ConvertTo.ClientID%>");
            var SelVal = ddl.options[ddl.selectedIndex].value;
            if (SelVal == 2) {
                document.getElementById("tr_DefaultCcType").style.display = "";
                document.getElementById("tr_DefaultBankName").style.display = "";
            }
            else {
                document.getElementById("tr_DefaultCcType").style.display = "none";
                document.getElementById("tr_DefaultBankName").style.display = "none";
            }
            document.getElementById("<%= tb_Perc.ClientID %>").disabled = false;
            for (var dis1 = 0; dis1 < document.getElementById("<%= rb_Drawer.ClientID %>").getElementsByTagName("input").length; dis1++)
                document.getElementById("<%= rb_Drawer.ClientID %>").getElementsByTagName("input")[dis1].disabled = false;
            for (var dis1 = 0; dis1 < document.getElementById("<%= rb_IsRequire.ClientID %>").getElementsByTagName("input").length; dis1++)
                document.getElementById("<%= rb_IsRequire.ClientID %>").getElementsByTagName("input")[dis1].disabled = false;
            if (valPayAmount) {
                document.getElementById("tr_AdjustExcessPrice").style.display = "none";
                document.getElementById("tr_ExcessPrice").style.display = "none";
                document.getElementById("tr_AdjustmentToPayType").style.display = "";
            }
            else {
                document.getElementById("tr_AdjustExcessPrice").style.display = "none";
                document.getElementById("tr_ExcessPrice").style.display = "none";
                document.getElementById("tr_AdjustmentToPayType").style.display = "none";
            }
        }

        if (valColumn[0] == 0) {
            for (var dis1 = 0; dis1 < document.getElementById("<%= rb_IsStockOnly.ClientID %>").getElementsByTagName("input").length; dis1++)
                document.getElementById("<%= rb_IsStockOnly.ClientID %>").getElementsByTagName("input")[dis1].disabled = true;
        }

        if (valColumn[1] == 0)
            document.getElementById("tr_OtherReceiptPrinter").style.display = "none";

        if (valColumn[2] == 0)
            document.getElementById("tr_ExcludeVatServiceCharge").style.display = "none";

        if (valColumn[3] == 0)
            document.getElementById("tr_printsignature").style.display = "none";

        if (valColumn[4] == 0)
            document.getElementById("tr_receiptcopy").style.display = "none";

        if (valColumn[5] == 0)
            document.getElementById("tr_maximumpayamount").style.display = "none";

        if (valColumn[6] == 0)
            document.getElementById("tr_minimumpayamount").style.display = "none";

        if (valColumn[7] == 0) {
            document.getElementById("tr_AdjustmentToPayType").style.display = "none";
            document.getElementById("tr_AdjustExcessPrice").style.display = "none";
        }

        if (valColumn[8] == 0)
            document.getElementById("tr_ExcessPrice").style.display = "none";

        if (valColumn[9] == 0)
            document.getElementById("tr_rounding").style.display = "none";

        if (valColumn[10] == 0)
            document.getElementById("tr_DefaultCcType").style.display = "none";

        if (valColumn[11] == 0)
            document.getElementById("tr_DefaultBankName").style.display = "none";
    }

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
            document.getElementById("btna").disabled = true;
            _input.style.borderColor = "#F44336";
        }
        else {
            document.getElementById("btna").disabled = false;
            _input.style.borderColor = "";
        }
    }

    function setLocationHref() {
        // set the location path as local page name.
        window.location.href = 'manage_paymenttype.aspx';
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
                        <span class="headerText">Add/Edit Pay Type Setting</span>
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
                        <asp:HiddenField ID="valueCheckColumn" runat="server" />
                        <asp:HiddenField ID="valueDisColumn" runat="server" />
                        <asp:HiddenField ID="valueBlank" runat="server" />
                        <input type="hidden" id="validate_checker_value" runat="server" />
                        <a href="manage_paymenttype.aspx" runat="server">Back to manage payment type</a>
                        <br />
                        <br />
                        <table>
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td style="vertical-align: top;">
                                                <table>
                                                    <tr id="tr_name" runat="server">
                                                        <td style="text-align: right; width: 160px;">
                                                            <asp:Label ID="lb_header01" runat="server" Text="Pay Type Name : "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="tb_PayTypeName" runat="server" Text="" onblur="onLeave(this)" TabIndex="1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr_group" runat="server">
                                                        <td style="text-align: right;">
                                                            <asp:Label ID="lb_header03" runat="server" Text="Pay Type Group : "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddl_PayTypeGroup" runat="server" TabIndex="3"></asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr_vat" runat="server">
                                                        <td style="text-align: right;">
                                                            <asp:Label ID="lb_header10" runat="server" Text="Is VAT : "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="rb_IsVat" runat="server" RepeatDirection="Horizontal" TabIndex="5">
                                                                <asp:ListItem Text="Yes" Selected="True" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr_require" runat="server">
                                                        <td style="text-align: right;">
                                                            <asp:Label ID="lb_header12" runat="server" Text="Is Require : "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="rb_IsRequire" runat="server" RepeatDirection="Horizontal" TabIndex="7">
                                                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="No" Selected="True" Value="0"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr_printsignature" runat="server">
                                                        <td style="text-align: right;">
                                                            <asp:Label ID="lb_header05" runat="server" Text="Print Signature In Receipt : "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="rb_PrintSignature" runat="server" RepeatDirection="Horizontal" TabIndex="9">
                                                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="No" Selected="True" Value="0"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr_drawer" runat="server">
                                                        <td style="text-align: right;">
                                                            <asp:Label ID="lb_header07" runat="server" Text="Open Cash Drawer : "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="rb_Drawer" runat="server" RepeatDirection="Horizontal" TabIndex="11">
                                                                <asp:ListItem Text="Yes" Selected="True" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr id="trCashChange" runat="server">
                                                        <td style="text-align: right;">
                                                            <asp:Label ID="lb_header30" runat="server" Text="Display Cash Change : "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="rb_CashChange" runat="server" RepeatDirection="Horizontal" TabIndex="13">
                                                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="No" Value="0" Selected="True"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="vertical-align: top;">
                                                <table>
                                                    <tr id="tr_code" runat="server">
                                                        <td style="text-align: right; width: 180px;">
                                                            <asp:Label ID="lb_header02" runat="server" Text="Pay Type Code : "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="tb_PayTypeCode" runat="server" onblur="onLeave(this)" TabIndex="2"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr_ordering" runat="server">
                                                        <td style="text-align: right;">
                                                            <asp:Label ID="lb_header04" runat="server" Text="Pay Type Ordering : "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="tb_PayTypeOrdering" runat="server" onkeypress="return NumberCheck(event,0)" onblur="onLeave(this)" TabIndex="4"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr_receiptcopy" runat="server">
                                                        <td style="text-align: right;">
                                                            <asp:Label ID="lb_header06" runat="server" Text="No. Receipt Copy : "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="tb_ReceiptCopy" runat="server" Text="0" TabIndex="6" onkeypress="return NumberCheck(event,0)" onkeyup="javascript:this.value=Comma(this.value);" onblur="onLeave(this)"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr_discountpercent" runat="server">
                                                        <td style="text-align: right;">
                                                            <asp:Label ID="lb_header08" runat="server" Text="Percent Discount : "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="tb_Perc" runat="server" Text="0" TabIndex="8" onkeypress="return NumberCheck(event,1)" onkeyup="javascript:this.value=Comma(this.value);" onblur="onLeave(this)"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr_rounding" runat="server">
                                                        <td style="text-align: right;">
                                                            <asp:Label ID="lb_header09" runat="server" Text="Use Price Before Rounding : "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="rb_Rounding" runat="server" RepeatDirection="Horizontal" TabIndex="10">
                                                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="No" Selected="True" Value="0"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr_includeday" runat="server">
                                                        <td style="text-align: right;">
                                                            <asp:Label ID="lb_header11" runat="server" Text="Include In End Day Report : "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="rb_IncludeEndDay" runat="server" RepeatDirection="Horizontal" TabIndex="12">
                                                                <asp:ListItem Text="Yes" Selected="True" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr_RequireAuthorize" runat="server">
                                                        <td style="text-align: right;">
                                                            <asp:Label ID="lblRequireAuthorize" runat="server" Text="Require Authorize : "></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:RadioButtonList ID="rb_RequireAuthorize" runat="server" RepeatDirection="Horizontal" TabIndex="12">
                                                                <asp:ListItem Text="Yes" Selected="True" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%">
                                        <tr>
                                            <td style="text-align: right;"></td>
                                            <td></td>
                                            <td style="text-align: right;"></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right;"></td>
                                            <td></td>

                                        </tr>
                                        <tr>
                                        </tr>
                                        <tr>
                                        </tr>
                                        <tr>
                                        </tr>
                                        <tr>
                                        </tr>
                                    </table>


                                </td>
                            </tr>
                            <tr>
                                <td>

                                    <fieldset>
                                        <legend>Pay Type Display At Front</legend>

                                        <table>
                                            <tr>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header13" runat="server" Text="Display Name : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="tb_DisplayName" runat="server" onblur="onLeave(this)" TabIndex="14"></asp:TextBox>
                                                </td>
                                            </tr>

                                        </table>
                                    </fieldset>

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <fieldset>
                                        <legend>Pay Amount</legend>

                                        <table>
                                            <tr id="tr_minimumpayamount" runat="server">
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header15" runat="server" Text="Minimum Pay Amount : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="tb_MinimumPayAmount" runat="server" Text="0.00" TabIndex="15" onkeypress="return NumberCheck(event,1)" onkeyup="javascript:this.value=Comma(this.value);" onblur="onLeave(this)"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="tr_maximumpayamount" runat="server">
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header16" runat="server" Text="Maximum Pay Amount : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="tb_MaximumPayAmount" runat="server" Text="0.00" TabIndex="16" onkeypress="return NumberCheck(event,1)" onkeyup="javascript:this.value=Comma(this.value);" onblur="onLeave(this)"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header17" runat="server" Text="Default Pay Amount : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="tb_DefaultPayAmount" runat="server" Text="0.00" TabIndex="17" onchange="javascript: Detect();" onkeypress="return NumberCheck(event,1)" onkeyup="javascript:this.value=Comma(this.value);" onblur="onLeave(this)"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header18" runat="server" Text="Is Fix Payment : "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:RadioButtonList ID="rb_IsFixPayment" runat="server" TabIndex="18" RepeatDirection="Horizontal" onclick="Detect();">
                                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="No" Selected="True" Value="0"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>
                                        </table>

                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <fieldset id="fs_StockOnly" runat="server">
                                        <legend>Sale/Non Sale (Stock Only)</legend>

                                        <table id="tb_StockOnly" runat="server">
                                            <tr>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header19" runat="server" Text="Is Stock Only : "></asp:Label></td>
                                                <td>
                                                    <asp:RadioButtonList ID="rb_IsStockOnly" runat="server" TabIndex="19" RepeatDirection="Horizontal" onclick="Detect();">
                                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="No" Selected="True" Value="0"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>

                                            <tr id="tr_IsPrintReceipt" runat="server">
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header20" runat="server" Text="Is Print Receipt : "></asp:Label></td>
                                                <td>
                                                    <asp:RadioButtonList ID="rb_IsPrintReceipt" runat="server" RepeatDirection="Horizontal" TabIndex="20">
                                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="No" Selected="True" Value="0"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>
                                            <tr id="tr_OtherReceiptPrinter" runat="server" style="display: none;">
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header21" runat="server" Text="Other Receipt Printer : "></asp:Label></td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_OtherReceiptPrinter" runat="server" TabIndex="21"></asp:DropDownList></td>
                                            </tr>
                                            <tr id="tr_ExcludeVatServiceCharge" runat="server" style="display: none;">
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header22" runat="server" Text="Exclude VAT/Service Charge : "></asp:Label></td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_ExcludeVatServiceCharge" runat="server" TabIndex="22"></asp:DropDownList></td>
                                            </tr>
                                            <tr id="tr_EDCType" runat="server" style="display: none;">
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblEDCType" runat="server" Text="EDC Type : "></asp:Label></td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_EDCType" runat="server" onchange="Detect()" TabIndex="23"></asp:DropDownList></td>
                                            </tr>
                                            <tr id="tr_QRPaymentCode" runat="server" style="display: none;">
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblQRPaymentCode" runat="server" Text="QR Payment Code : "></asp:Label></td>
                                                <td>
                                                    <asp:TextBox ID="txtQRPaymentCode" runat="server" Text="" TabIndex="24" onchange="javascript: Detect();" onblur="onLeave(this)"></asp:TextBox>
                                                    </td>
                                            </tr>
                                            <tr id="tr_QRPaymentInquiryFeature" runat="server" style="display: none;">
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblQRPaymentInquiry" runat="server" Text="QR Payment Work Flow : "></asp:Label></td>
                                                <td>
                                                    <asp:RadioButtonList ID="optQRPaymentInquiry" runat="server" RepeatDirection="Horizontal" TabIndex="20">
                                                        <asp:ListItem Text="Credit Card Via EDC" Selected="True"  Value="0"></asp:ListItem>
                                                        <asp:ListItem Text="Generate QR and use inquiry feature" Value="1"></asp:ListItem>
                                                    </asp:RadioButtonList>    
                                                </td>
                                            </tr>
                                            <tr id="tr_ConvertTo" runat="server" style="display: none;">
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header23" runat="server" Text="Convert To : "></asp:Label></td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_ConvertTo" runat="server" onchange="Detect()" TabIndex="25"></asp:DropDownList></td>
                                            </tr>
                                            <tr id="tr_DisplayInReceipt" runat="server" style="display: none;">
                                                <td style="text-align: right; vertical-align: top;">
                                                    <asp:Label ID="lb_header14" runat="server" Text="Display In Receipt : "></asp:Label>
                                                </td>
                                                <td style="vertical-align: top;">
                                                    <asp:RadioButtonList ID="rb_DisplayInReceipt" runat="server" RepeatDirection="Vertical" TabIndex="24">
                                                        <asp:ListItem Text="Display own Name" Selected="True" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Display Converted Name" Value="0"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>
                                            <tr id="tr_GroupSamePayType" runat="server" style="display: none;">
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header24" runat="server" Text="Group Same Pay Type : "></asp:Label></td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_GroupSamePaytype" runat="server" TabIndex="26"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr id="tr_DefaultCcType" runat="server" style="display: none;">
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header25" runat="server" Text="Default CC Type : "></asp:Label></td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_DefaultCcType" runat="server" TabIndex="27"></asp:DropDownList></td>
                                            </tr>
                                            <tr id="tr_DefaultBankName" runat="server" style="display: none;">
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header26" runat="server" Text="Default Bank Name : "></asp:Label></td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_DefaultBankName" runat="server" TabIndex="28"></asp:DropDownList></td>
                                            </tr>

                                            <tr id="tr_AdjustmentToPayType" runat="server" style="display: none;">
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header27" runat="server" Text="Adjustment To Pay Type : "></asp:Label></td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_AdjustmentToPayType" runat="server" TabIndex="29"></asp:DropDownList></td>
                                            </tr>
                                            <tr id="tr_AdjustExcessPrice" runat="server" style="display: none;">
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header28" runat="server" Text="Adjest Excess Price To Pay Type : "></asp:Label></td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_AdjustExcessPrice" runat="server" TabIndex="30"></asp:DropDownList></td>
                                            </tr>
                                            <tr id="tr_ExcessPrice" runat="server" style="display: none;">
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lb_header29" runat="server" Text="Excess Price To Cash In Product : "></asp:Label></td>
                                                <td>
                                                    <asp:DropDownList ID="ddl_ExcessPrice" runat="server" TabIndex="31"></asp:DropDownList></td>
                                            </tr>
                                        </table>

                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <center>
                                        <button type="button" id="btna" runat="server" style="width:200px;" onserverclick="btnAddUpdate_Click"></button>
                                </center>
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
