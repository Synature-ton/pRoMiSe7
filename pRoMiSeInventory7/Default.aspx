﻿<%@ page language="VB" autoeventwireup="false" inherits="_Default, App_Web_default.aspx.cdcab7d2" theme="Classic" enableEventValidation="false" %>

 <%@ Register TagPrefix="uc1" TagName="MenuBar" Src="~/UserControl/Menu.ascx" %>
<%@ Register Src="UserControl/Footer.ascx" TagName="Footer" TagPrefix="uc2" %> 
<html>
<head runat="server">
    <title>pRoMiSe Inventory</title>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="css/General.css" rel="stylesheet" type="text/css" />
    <link href="css/modal.css" rel="stylesheet" type="text/css" />
    <link href="css/page.css" rel="stylesheet" type="text/css" />
    <link href="css/rounded.css" rel="stylesheet" type="text/css" />
    <link href="css/menu.css" rel="stylesheet" type="text/css" />
    <link href="css/icon.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="Scripts/modal.js" type="text/javascript"></script>
    <script src="Scripts/menu.js" type="text/javascript"></script>
    <script src="Scripts/index.js" type="text/javascript"></script>
    <script type="text/javascript">
        window.addEvent('domready', function () { new Accordion($$('.panel h3.jpane-toggler'), $$('.panel div.jpane-slider'), { onActive: function (toggler, i) { toggler.addClass('jpane-toggler-down'); toggler.removeClass('jpane-toggler'); }, onBackground: function (toggler, i) { toggler.addClass('jpane-toggler'); toggler.removeClass('jpane-toggler-down'); }, duration: 100, opacity: false, alwaysHide: true }); });
        jQuery(document).ready(function ($) {
            $("#dialog").dialog({
                height: 120,
                width: 300,
                draggable: false,
                position: ['right', 'bottom'],
                autoOpen: false,
                show: {
                    effect: 'slide',
                    direction: 'up',
                    duration: 300
                }
            });

        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="header-box">
        <uc1:menubar id="menu" runat="server" />
    </div>
    <div id="content-box">
        <table class="adminform">
            <tbody>
                <tr>
                    <td width="50%" valign="top">
                        <div id="cpanel" runat="server">
                        </div>
                    </td>
                    <td width="50%" valign="top">
                        <div style="display: none">
                            <asp:Label ID="lblDocumentNumber" runat="server" Text="Document Number"></asp:Label>
                            <asp:Label ID="lblDocumentDate" runat="server" Text="Date"></asp:Label>
                            <asp:Label ID="lblDocumentNumberOtherInv" runat="server" Text="Document Number"></asp:Label>
                            <asp:Label ID="lblFromInventory" runat="server" Text="Form Inventory"></asp:Label>
                            <asp:Label ID="lblDocumentDateOtherInv" runat="server" Text="Date"></asp:Label>
                            <asp:Label ID="lblNewRODocument" runat="server" Text="New RO Document"></asp:Label>
                            <asp:Label ID="lblClick" runat="server" Text="Click"></asp:Label>
                            <asp:Label ID="lblRemark" runat="server" Text="Remark"></asp:Label>
                            <asp:Label ID="lblInventory" runat="server" Text="Inventory"></asp:Label>
                            <asp:Label ID="lblToInventory" runat="server" Text="To Inventory"></asp:Label>
                            <asp:Label ID="lblVendor" runat="server" Text="Vendor"></asp:Label>
                            <asp:Label ID="lblApproveDate" runat="server" Text="ApproveDate"></asp:Label>
                            <asp:Label ID="lblInvoiceRef" runat="server" Text="InvoiceRef"></asp:Label>
                            <asp:Label ID="lblLinkForDetail" runat="server" Text="Detail"></asp:Label>
                        </div>
                        <div id="content-pane" class="pane-sliders">
                            <div class="panel" style="padding: 2px;" id="pnlAlertDocumentBatch"  runat="server"  >
                                <div>
                                    <b>
                                        <asp:Label ID="lblAlertDocumentBatch" runat="server" Text="Document Batch not approve."></asp:Label>
                                    </b>
                                </div>
                                <div id="dvNotApproveBatch" runat="server">
                                </div>
                            </div>
                            <div class="panel" style="padding: 2px; ">
                                <div>
                                    <b>
                                        <asp:Label ID="lb1" runat="server" Text="Document not approve."></asp:Label>
                                    </b>
                                </div>
                                <div id="NotApprove" runat="server">
                                </div>
                            </div>
                             <div class="panel" style="padding: 2px; ">
                                <div>
                                    <b>
                                        <asp:Label ID="lb3" runat="server" Text="PO Not Refered Document"></asp:Label>
                                    </b>
                                </div>
                                <div>
                                    <div id="PODocument" runat="server">
                                    </div>
                                </div>
                            </div>
                            <div class="panel" style="padding: 2px; ">
                                <div>
                                    <b>
                                        <asp:Label ID="lb2" runat="server" Text="Document form other branch."></asp:Label>
                                    </b>
                                </div>
                                <div>
                                    <div id="OtherBranch" runat="server">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div id="footer-box">
        <uc2:footer id="Footer1" runat="server" />
    </div>
    <div id="dialog" title="New Message!" style="display: none;">
        Hi, How are you?</div>
    </form>
</body>
</html>
