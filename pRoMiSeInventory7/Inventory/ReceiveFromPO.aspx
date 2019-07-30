﻿<%@ page language="VB" autoeventwireup="false" inherits="Inventory_ReceiveFromPO, App_Web_receivefrompo.aspx.9758fd70" maintainscrollpositiononpostback="true" theme="Classic" enableEventValidation="false" %>

<%@ Register TagPrefix="uc1" TagName="MenuBar" Src="~/UserControl/Menu.ascx" %>
<%@ Register Src="../UserControl/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<html>
<head runat="server">
    <title>Receive Purchase Document.</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
    <link href="../css/modal.css" rel="stylesheet" type="text/css" />
    <link href="../css/page.css" rel="stylesheet" type="text/css" />
    <link href="../css/rounded.css" rel="stylesheet" type="text/css" />
    <link href="../css/menu.css" rel="stylesheet" type="text/css" />
    <link href="../css/icon.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/jquery.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

    <script src="../Scripts/modal.js" type="text/javascript"></script>

    <script src="../Scripts/menu.js" type="text/javascript"></script>

    <script src="../Scripts/index.js" type="text/javascript"></script>

    <script type="text/javascript">

        window.addEvent('domready', function() { new Accordion($$('.panel h3.jpane-toggler'), $$('.panel div.jpane-slider'), { onActive: function(toggler, i) { toggler.addClass('jpane-toggler-down'); toggler.removeClass('jpane-toggler'); }, onBackground: function(toggler, i) { toggler.addClass('jpane-toggler'); toggler.removeClass('jpane-toggler-down'); }, duration: 10, opacity: false, alwaysHide: true }); });

        jQuery(document).ready(function ($) {
            $('#txtAmount').select();
            $("button, input:submit, a", "#toolbar-button").button({ icons: { primary: 'icon-action-new' }, text: true })
                  .next().button({ icons: { primary: 'icon-action-search'} })
                  .next().button({ icons: { primary: 'icon-action-save'} })
                  .next().button({ icons: { primary: 'icon-action-copy'} })
                  .next().button({ icons: { primary: 'icon-action-approve'} })
                  .next().button({ icons: { primary: 'icon-action-cancel'} })
                  .next().button({ icons: { primary: 'icon-action-print-preview'} })
                  .next().button({ icons: { primary: 'icon-action-print' }
                  });

            $("button, input:submit, a", "#dvEditMultipleDocDetail").button({ icons: { primary: 'icon-action-new' }, text: true });

            $(function () {
                $(".txt-numeric").keypress(function(evt) {
                    /*if ($(this).val() != "") {
                    this.value = this.value.replace(/[^0-9+,.]/g, "");
                    }*/
                    var charCode = (evt.which) ? evt.which : event.keyCode;
                    //alert(charCode);
                    if (charCode > 47 && charCode < 58 || charCode == 46)
                        return true;
                    else
                        return false;
                });
            });

            var authoizeWindows;
            authoizeWindows = $("#hdfAuthoizeWindows").val();

            $("#btnAppove").live('click', function () {
                if (authoizeWindows == 1) {
                    $("#txtUserName").val('');
                    $("#txtPassword").val('');
                    $("#hfd_action_button").val('');
                    $("#hfd_action_button").val(2);
                    $("#dialog_approvedocument").dialog("open");
                    $("#dialog_approvedocument").dialog({
                        title: '<div style="float: left; font-size: 14px;"><div class="icon-vendors" style="float: left; width: 32px; height: 32px; margin-right: 4px;"></div><div style="float: left;"><div style="height: 4px; margin-top: 4px;"></div><div style="margin: 2px;">ยืนยันการอนุมัติเอกสารรับจากสั่งซื้อ</div></div></div>',
                        width: 350,
                        height: 180,
                        modal: true,
                        resizable: false
                    });
                }
                
            });
            $("#btnCancelDocment").live('click', function () {
                if (authoizeWindows == 1) {
                    $("#txtUserName").val('');
                    $("#txtPassword").val('');
                    $("#hfd_action_button").val('');
                    $("#hfd_action_button").val(99);
                    $("#dialog_approvedocument").dialog("open");
                    $("#dialog_approvedocument").dialog({
                        title: '<div style="float: left; font-size: 14px;"><div class="icon-vendors" style="float: left; width: 32px; height: 32px; margin-right: 4px;"></div><div style="float: left;"><div style="height: 4px; margin-top: 4px;"></div><div style="margin: 2px;">ยืนยันการยกเลิกเอกสารรับจากสั่งซื้อ</div></div></div>',
                        width: 350,
                        height: 180,
                        modal: true,
                        resizable: false
                    });
                }
                
            });

            $.extend({
                getUrlVars: function () {
                    var vars = [], hash;
                    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                    for (var i = 0; i < hashes.length; i++) {
                        hash = hashes[i].split('=');
                        vars.push(hash[0]);
                        vars[hash[0]] = hash[1];
                    }
                    return vars;
                },
                getUrlVar: function (name) {
                    return $.getUrlVars()[name];
                }
            });
            $("#txtUserName").keyup(function (e) {
                if (e.keyCode == 13) { $("#txtPassword").select(); }

            });
            $("#txtPassword").keyup(function (e) {
                if (e.keyCode == 13) {
                    $("#confirm_ok").focus();
                }
            });

            $("#confirm_ok").button({
                icons: {
                    primary: 'icon-btn-ok'
                }
            }).live('click', function () {
                var LangID = $.getUrlVars()['LangID'];
                var StaffID = $.getUrlVars()['StaffID'];
                var StaffRoleID = $.getUrlVars()['StaffRoleID'];
                var DocumentShopID = $.getUrlVars()['DocumentShopID'];
                var DocumentID = $.getUrlVars()['DocumentID'];
                var InvenID = $.getUrlVars()['InvenID'];
                var DocumentTypeID = 2;
                var doc_day = 1;
                var doc_month = 1;
                var doc_year = 2000;
                var doc_note = $("#txtNote").val();
                var doc_invoice = $("#txtInvoice").val();
                var doc_hour = 0;
                var doc_minute = 0;
                var param_invoice = ",'doc_day':" + doc_day + ",'doc_month':" + doc_month + ",'doc_year':" + doc_year + ",'doc_hour':" + doc_hour + ",'doc_minute':" + doc_minute + ",'doc_note':'" + doc_note + "','doc_invoice':'" + doc_invoice + "'";
                var param = "{'txtUser':'" + $("#txtUserName").val() + "','txtPass':'" + $("#txtPassword").val() + "','StaffID':" + StaffID + ",'InvenID':" + InvenID + ",'LangID':" + LangID + ",'DocumentID':" + DocumentID + ",'DocumentShopID':" + DocumentShopID + param_invoice + "}";
                //alert(param);
                var action = '';
                if ($("#hfd_action_button").val() == 2) {
                    action = "ApproveROFromPODocumentByStaff";
                } else if ($("#hfd_action_button").val() == 99) {
                    action = "CancelDocumentByStaff";
                }
                $.ajax({
                    type: "POST",
                    url: "DataXML/ServiceInventory.asmx/" + action,
                    data: param,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        //console.log(msg.d);
                        var data = eval("(" + msg.d + ")");
                        if (data.Status == true) {
                            $("#dialog_approvedocument").dialog('close');
                            alert(data.ResultText);
                            window.location.reload();
                        } else {
                            //$("#dialog_approvedocument").dialog('close');
                            alert(data.ResultText);
                            $("#txtUserName").select();
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log(XMLHttpRequest);

                    }
                });
            });
            $("#confirm_cancel").button({
                icons: {
                    primary: 'icon-btn-cancel'
                }
            }).click(function () {
                $("#dialog_approvedocument").dialog('close');
            });

            $('#txtAmount').click(function () {
                $(this).select();
            });
            if ($("#txtAmount").val() >= 0) { $("#btnSaveMaterial").attr("disabled", ""); } else { $("#btnSaveMaterial").attr("disabled", "disabled"); };
            $("#txtAmount").keyup(function (e) {

                if ($("#txtAmount").val() >= 0) { $("#btnSaveMaterial").attr("disabled", ""); } else { $("#btnSaveMaterial").attr("disabled", "disabled"); };

            });
            $("#txtAmount").keyup(function(e) {
                if (e.keyCode == 13) {
                    $("#ddlUnit").focus();
                }
            });
            $('#txtPricePerUnit').click(function() {
                $(this).select();
            });
            $("#txtPricePerUnit").keyup(function(e) {
                if (e.keyCode == 13) {
                    $("#txtDiscount").focus();
                }
            });
            $("#ddlUnit").keyup(function(e) {
                if (e.keyCode == 13) {
                    $("#txtPricePerUnit").select();
                }
            });
            $('#txtDiscount').click(function() {
                $(this).select();
            });
            $("#txtDiscount").keyup(function(e) {
                if (e.keyCode == 13) {
                    $("#ddlDiscount").focus();
                }
            });
            $("#ddlDiscount").keyup(function(e) {
                if (e.keyCode == 13) {
                    $("#ddlVAT").focus();
                }
            });
            $("#ddlVAT").keyup(function(e) {
                if (e.keyCode == 13) {
                    $("#btnSaveMaterial").focus();
                }
            });
            $('.chks_11').live('change', function() {
                $('.chks_12').attr('checked', $(this).is(':checked') ? 'checked' : '');
            });
            $('.chks_12').live('change', function() {
                $('.chks_12').length == $('.chks_12:checked').length ? $('.chks_11').attr('checked', 'checked').next() : $('.chks_11').attr('checked', '').next();

            });

        });

       
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="header-box">
        <uc1:MenuBar ID="menu" runat="server" />
    </div>
    <div id="toolbar-button">
    <div class="icon-receipt-document" style="float: left; width: 32px; height: 32px;
            margin-right: 4px;">
        </div>
        <div class="toolbar-title">
            <asp:Label ID="lt" runat="server" CssClass="texttitle">Receive From Purchase Document</asp:Label></div>
        <button id="btnCreateDocument" type="button" runat="server">
            Create Document
        </button>
        <button id="btnSeachDocument" type="button" runat="server">
            Search Document
        </button>
        <button id="btnSave" type="button" runat="server" validationgroup="v">
            Save Document
        </button>
        <button id="btnTemplate" type="button" style="display: none;" runat="server">
            Template
        </button>
        <button id="btnAppove" type="button" runat="server">
            Approve Document
        </button>
        <button id="btnCancelDocment" type="button" runat="server">
            Cancel Document
        </button>
        <button id="btnPreview" type="button" style="display: none;" runat="server">
            Preview
        </button>
        <button id="btnPrint" type="button" runat="server">
            Print Document
        </button>
        <asp:HiddenField ID="hdfDocumentID" runat="server" />
        <asp:HiddenField ID="hdfDocumentShopID" runat="server" />
        <asp:HiddenField ID="hdfIndexList" runat="server" />
        <asp:HiddenField ID="hdfAuthoizeWindows" runat="server" />
    </div>
    <div id="content">
        <div id="content-pane" class="pane-sliders">
            <div class="panel">
                <h3 id="detail-page" class="title jpane-toggler">
                    <asp:Label ID="lbDocumentName" runat="server"></asp:Label>
                    <asp:Label ID="lb1" runat="server"></asp:Label>
                    <asp:Label ID="lbDocumentStatus" runat="server"></asp:Label>
                    <asp:Label ID="lb2" runat="server"></asp:Label>
                    <asp:Label ID="lbDocumentNumber" runat="server"></asp:Label>
                    <asp:Label ID="lb11" runat="server"  Visible="false"></asp:Label>
                    <asp:Label ID="lbDocumentRef" runat="server" Visible="false"></asp:Label>
                </h3>
                <div class="jpane-slider">
                    <table class="paramlist admintable" cellspacing="1" width="100%">
                        <tr>
                            <td class="paramlist_key" width="40%">
                                <asp:Label ID="lb3" runat="server">Inventory</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlInv" runat="server" Width="220px">
                                </asp:DropDownList>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb7" runat="server" Text="Label">VendorGroup</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlVendorGroup" runat="server" AutoPostBack="True" Width="250px" Enabled="false">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                    ControlToValidate="ddlVendorGroup" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lb4" runat="server" Height="23px">Date</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="RdoDocs_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDocs_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDocs_DdlYear" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb8" runat="server">Vendor</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlVendor" runat="server" Width="250px" Enabled="false">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                    ControlToValidate="ddlVendor" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lb5" runat="server">Invoice Ref.</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtInvoice" runat="server" Width="220px" ReadOnly="true">
                                
                                </asp:TextBox> <asp:Button ID="btnFinishDocument" runat="server" Text="Close" />
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lb6" runat="server">Note</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtNote" runat="server" Rows="2" TextMode="MultiLine" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div id="responseText" runat="server" style="padding: 1px; margin-top: 5px;">
          <div id="dvEditMultipleDocDetail" class="toolbar-title">
            <button id="cmdEditMultipleDocDetail" type="button" runat="server">
                Edit Multiple Material 
            </button> 
          </div>
          <table class="adminlist" cellspacing="1">
                <thead>
                    <tr>
                        <th nowrap="nowrap" style="width: 2%; height: 25px;">
                            #
                        </th>
                        <th style="width: 2%;">
                            <div id="chk" runat="server">
                            </div>
                        </th>
                        <th nowrap="nowrap" style="width: 15%;">
                            <asp:Label ID="lh1" runat="server" Text="Code"></asp:Label>
                        </th>
                        <th nowrap="nowrap">
                            <asp:Label ID="lh2" runat="server" Text="Item"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 5%;" id="thPOOriginalAmount" runat="server" >
                            <asp:Label ID="lblPOOriginalAmount" runat="server" Text="PO Amount"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 5%;" id="thPOAmount" runat="server">
                            <asp:Label ID="lblPOAmount" runat="server" Text="PO Amount"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 5%;">
                            <asp:Label ID="lblAmount" runat="server" Text="Amount"></asp:Label>
                        </th>
                         <th nowrap="nowrap" style="width: 5%;">
                            <asp:Label ID="lh5" runat="server" Text="Unit"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 5%;">
                            <asp:Label ID="lh4" runat="server" Text="Price/Unit"></asp:Label>
                        </th>
                       
                        <th nowrap="nowrap" style="width: 10%;">
                            <asp:Label ID="lh6" runat="server" Text="Discount"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 5%;">
                            <asp:Label ID="lh7" runat="server" Text="VAT"></asp:Label>
                       </th>
                       <th nowrap="nowrap" style="width: 10%;" id="thPOTotalPrice" runat="server" >
                            <asp:Label ID="lblPOTotalPrice" runat="server" Text="Total PO"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 10%;">
                            <asp:Label ID="lh8" runat="server" Text="Total"></asp:Label>
                        </th>
                        <th nowrap="nowrap" style="width: 5%;">
                            x
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Label ID="tr1" runat="server"></asp:Label>
                    <tr class="row0" id="trEdit" runat="server">
                        <td colspan="2">
                            <button id="btnDelete" type="button" runat="server" style="width: 100%;">
                                Delete
                            </button>
                            <button id="btnCancelMaterial" type="button" runat="server" style="width: 100%;">
                                cancel</button>
                        </td>
                        <td>
                            <div style="float: left; width: 75%;">
                                <asp:TextBox ID="txtCode" runat="server" Style="width: 100%;" AutoPostBack="True"
                                    OnTextChanged="txtCode_TextChanged"></asp:TextBox>
                            </div>
                            <div id="bts" runat="server" style="float: left; width: 20%;">
                            </div>
                        </td>
                        <td>
                            <asp:Label ID="lbMaterialName" runat="server"></asp:Label>
                        </td>
                        <td align="center" id="tdPOOriginalAmount" runat="server" >
                            <asp:Label ID="lblOriginalPOAmount" runat="server"></asp:Label>
                        </td>
                        <td align="center" id="tdPOAmount" runat="server">
                            <asp:Label ID="lbPOAmount" runat="server"></asp:Label>
                            <asp:HiddenField ID="hdfComparePOAmount" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtAmount" runat="server" Style="width: 50px;" class="txt-numeric">0</asp:TextBox>
                        </td>
                         <td>
                            <asp:DropDownList ID="ddlUnit" runat="server" AutoPostBack="true">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPricePerUnit" runat="server" Style="width: 70px;" class="txt-numeric">0.00</asp:TextBox>
                        </td>                       
                        <td>
                            <div style="float: left; width: 45%;">
                                <asp:TextBox ID="txtDiscount" runat="server" Style="width: 100%;" class="txt-numeric">0</asp:TextBox>
                            </div>
                            <div style="float: left; width: 50%;">
                                <asp:DropDownList ID="ddlDiscount" runat="server" >
                                    <asp:ListItem Value="2">%</asp:ListItem>
                                    <asp:ListItem Value="1">Baht</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlVAT" runat="server">
                                <asp:ListItem Value="2">Include</asp:ListItem>
                                <asp:ListItem Value="1">Exclude</asp:ListItem>
                                <asp:ListItem Value="0">No VAT</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td style="text-align: right" id="tdTotalPO" runat="server" >
                            <asp:Label ID="lblTotalPO" runat="server"></asp:Label>
                        </td>
                        <td style="text-align: right">
                            <asp:Label ID="lbTotal" runat="server"></asp:Label>
                        </td>
                        <td>
                            <div style="float: left; width: 100%;">
                                <button id="btnSaveMaterial" type="button" runat="server" style="width: 100%;" disabled="disabled">
                                    Save</button>
                            </div>
                            <asp:HiddenField ID="hdfMaterialID" runat="server" />
                            <asp:HiddenField ID="hdfMaterialUnitID" runat="server" />
                            <asp:HiddenField ID="hdfDocDetailID" runat="server" />
                        </td>
                    </tr>
                    <asp:Label ID="tr2" runat="server"></asp:Label>
                    <tr class="row0" style="text-align: right">
                        <td colspan="9" id="tdDocumentSubTotal" runat="server" >
                            <asp:Label ID="lf1" runat="server" Text="SubTotal"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbSubTotal" runat="server"></asp:Label>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr class="row0" style="text-align: right">
                        <td colspan="9" id="tdDocumentDiscount" runat="server" >
                            <asp:Label ID="lf2" runat="server" Text="Discount"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbDiscount" runat="server"></asp:Label>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr class="row0" style="text-align: right">
                        <td colspan="9" id="tdDocumentNetPrice" runat="server" > 
                            <asp:Label ID="lf3" runat="server" Text="NetPrice"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbNetPrice" runat="server"></asp:Label>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr class="row0" style="text-align: right">
                        <td colspan="9" id="tdDocumentTotalVAT" runat="server" >
                            <asp:Label ID="lf4" runat="server" Text="TotalVAT"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbTotalVAT" runat="server"></asp:Label>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr class="row0" style="text-align: right">
                        <td colspan="9" id="tdDocumentGrandTotal" runat="server" >
                            <asp:Label ID="lf5" runat="server" Text="GrandTotal"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbGrandTotal" runat="server"></asp:Label>
                        </td>
                        <td>
                        </td>
                    </tr>
                </tbody>
                <asp:Label ID="ft" runat="server"></asp:Label>
            </table>
        </div>
        <div style="text-align: center;">
            <h1>
                <asp:Label ID="msgResponse" runat="server"></asp:Label></h1>
        </div>
        <div id="dialog_approvedocument" style="display: none; overflow: hidden; font-family: Segoe UI, Tahoma, Arial;">
            <table class="paramlist admintable" cellspacing="1" width="100%">
                <tr>
                    <td>
                    </td>
                    <td>
                        <input type="text" placeholder="รหัสพนักงาน" class="textbox" id="txtUserName" style="font-size: 16;
                            height: 30px; width: 100%;">
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <input type="password" placeholder="รหัสผ่าน" class="textbox" id="txtPassword" style="font-size: 16;
                            height: 30px; width: 100%;">
                        <asp:HiddenField ID="hfd_action_button" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="right">
                        <button type="button" id="confirm_cancel" style="width: 90px; height: 35px;">
                            ยกเลิก</button>&nbsp;
                        <button type="button" id="confirm_ok" style="width: 90px; height: 35px;">
                                ตกลง</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="footer-box">
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
