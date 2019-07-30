<%@ page language="VB" autoeventwireup="false" inherits="Inventory_Stock, App_Web_ghcomparestock_weeklycount_summary.aspx.9758fd70" maintainscrollpositiononpostback="true" theme="Classic" enableEventValidation="false" %>

<%@ Register TagPrefix="uc1" TagName="MenuBar" Src="~/UserControl/Menu.ascx" %>
<html>
<head runat="server">
    <title>Compare Stock Card and Stock Count.</title>
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

    <script type="text/javascript">

        window.addEvent('domready', function() { new Accordion($$('.panel h3.jpane-toggler'), $$('.panel div.jpane-slider'), { onActive: function(toggler, i) { toggler.addClass('jpane-toggler-down'); toggler.removeClass('jpane-toggler'); }, onBackground: function(toggler, i) { toggler.addClass('jpane-toggler'); toggler.removeClass('jpane-toggler-down'); }, duration: 10, opacity: false, alwaysHide: true }); });

        jQuery(document).ready(function($) {
        $("button, input:submit, a", "#xButton").button({ icons: { primary: 'icon-action-search' }, text: true })
                  .next().button({ icons: { primary: 'icon-export-xls'} });
            $(function() {
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
            $("#txtAmount").keyup(function(e) {
                if (e.keyCode == 13) {
                    $("#ddlUnit").focus();
                }
            });

            $("#ddlUnit").keyup(function(e) {
                if (e.keyCode == 13) {
                    $("#btnSaveMaterial").focus();
                }
            });

            $('#chkSelectAllInventory').live('click', function () {
                $("#chkbInventory INPUT[type='checkbox']").attr('checked', $(this).is(':checked') ? 'checked' : '');
            });

            $("#chkbInventory input").live("click", function () {
                if ($("#chkbInventory input[type='checkbox']:checked").length == $("#chkbInventory input").length) {
                    $('#chkSelectAllInventory').attr('checked', 'checked').next();
                }
                else {
                    $('#chkSelectAllInventory').removeAttr('checked');
                }

            });
            

        });

       
    </script>

    <style type="text/css">
        .auto-style2 {
            height: 28px;
        }
    </style>
    
</head>
<body>
    <form id="form1" runat="server">
    <input type="hidden" id="selInventoryID" runat="server" />
    <div id="content">
        <div style="display: none;">
            <asp:Label ID="lh1" runat="server">Code</asp:Label>
            <asp:Label ID="lh2" runat="server">Item</asp:Label>
            <asp:Label ID="lh3" runat="server">UnitName</asp:Label>
            <asp:Label ID="lblStockCardHeader" runat="server">Stock card</asp:Label>
            <asp:Label ID="lblStockCountHeader" runat="server">Counting</asp:Label>
            <asp:Label ID="lblInStockAmount" runat="server">คงเหลือในระบบ</asp:Label>
            <asp:Label ID="lblCountAmount" runat="server">จำนวนนับจริง</asp:Label>
            <asp:Label ID="lblDiffCountAmount" runat="server">ผลต่าง</asp:Label>
            <asp:Label ID="lblComparePercent" runat="server">% ผลต่างเทียบ sale</asp:Label>
            <asp:Label ID="lblCompareStockAndSalePercent" runat="server">% Diff Stock/ Sale</asp:Label>
            <asp:Label ID="lblCompareWasteAndSalePercent" runat="server">% Diff Waste/ Sale</asp:Label>
            <asp:Label ID="lblStockCountNote" runat="server">หมายเหตุ</asp:Label>
            <asp:Label ID="lblStockCountDate" runat="server">วันที่นับสต๊อก</asp:Label>
        </div>
        <div id="content-pane" class="pane-sliders">
            <div class="panel">
                <h3 id="detail-page" class="title jpane-toggler">
                    CompareStockcard and WeeklyStockcount&nbsp;</h3>
                <div class="jpane-slider" >
                    <table class="paramlist admintable" cellspacing="1" width="100%">
                        <tr>
                            <td class="paramlist_key" style="width: 141px">
                                <asp:Label ID="lblInventoryGroup" runat="server">Inventory Group</asp:Label>
                            </td>
                             <td rowspan="4" valign="top" nowrap="nowrap" width="220px">
                                <asp:Panel ID="pnlInventoryGroup" runat="server" Height="120px" ScrollBars="Auto" BorderColor="#999999"
                                    BorderStyle="Solid" BorderWidth="1px">
                                    <div id="chkInvGroup" runat="server">
                                        <asp:CheckBoxList ID="chkbInventoryGroup" runat="server" AutoPostBack="true" Height="16px" Width="195px">
                                        </asp:CheckBoxList>
                                    </div>
                                </asp:Panel>
                            </td>
                            <td class="paramlist_key" style="width: 80px">
                                <asp:Label ID="lb2" runat="server">Inventory</asp:Label>
                            </td>
                            <td rowspan="4" valign="top" nowrap="nowrap" width="250px">
                                <asp:Panel ID="pnlInventory" runat="server" Height="120px" ScrollBars="Auto" BorderColor="#999999"
                                BorderStyle="Solid" BorderWidth="1px">
                                    &nbsp;<asp:CheckBox ID="chkSelectAllInventory" runat="server" Text="Select All" />
                                   <asp:CheckBoxList ID="chkbInventory" runat="server" Height="16px" Width="220px">
                                    </asp:CheckBoxList>
                                </asp:Panel>
                            </td>
                            <td class="paramlist_key" style="width: 95px">
                                <asp:Label ID="lb7" runat="server" Height="23px">Date</asp:Label>
                            </td>
                            <td nowrap="nowrap">
                                <asp:DropDownList ID="RdoDocs_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDocs_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDocs_DdlYear" runat="server">
                                </asp:DropDownList>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                    ControlToValidate="RdoDocs_DdlDay" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                    ControlToValidate="RdoDocs_DdlMonth" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                                    ControlToValidate="RdoDocs_DdlYear" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                            </td>                            
                        </tr>
                        <tr>
                            <td class="paramlist_key" style="height: 28px; width: 141px;">
                                &nbsp;
                            </td>
                            <td class="paramlist_key" style="height: 28px; width: 80px;">
                                &nbsp;
                            </td>
                            <td class="paramlist_key" style="height: 28px; width: 95px;">
                                <asp:Label ID="lb8" runat="server">To Date</asp:Label>
                            </td>
                            <td class="auto-style2">
                                <asp:DropDownList ID="RdoDues_DdlDay" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDues_DdlMonth" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="RdoDues_DdlYear" runat="server">
                                </asp:DropDownList>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                                    ControlToValidate="RdoDocs_DdlDay" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*"
                                    ControlToValidate="RdoDues_DdlMonth" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*"
                                    ControlToValidate="RdoDues_DdlYear" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key" style="width: 141px">
                                &nbsp;
                            </td>
                            <td class="paramlist_key" style="width: 80px">
                                &nbsp;
                            </td>
                            <td class="paramlist_key" style="width: 95px">
                                &nbsp;
                            </td>
                            <td >
                                <asp:CheckBox ID="chkDisplayShortReport" Checked="false" runat="server" Text="รายงานแบบย่อ" />
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key" style="width: 141px">
                                &nbsp;
                                </td>
                            <td class="paramlist_key" style="width: 80px">
                                &nbsp;
                            </td>
                            <td class="paramlist_key" style="width: 95px">
                                &nbsp;
                            </td>
                            <td>
                                <div id="xButton" runat="server">
                                    <button id="btnSearch" type="button" runat="server" ValidationGroup="v">
                                        Searchh</button>
                                    <button id="btnExportExcel" type="button" runat="server" ValidationGroup="v">
                                        Export to excel
                                    </button>                             
                                </div>
                            </td>
                        </tr>

                    </table>
                </div>
            </div>
        </div>
        <table width="100%">
        <tr><td align="center"><div id="ResultSearchText" class="boldText" runat="server"></div></td></tr>
        <tr><td align="left"><asp:Label ID="lblCreateReportDate" Text="" runat="server" /></td></tr>
        </table>
        <div id="responseText" runat="server" style="padding: 1px; margin-top: 5px;">
        </div>
        <div style="text-align: center;">
            <h1>
                <asp:Label ID="msgResponse" runat="server"></asp:Label></h1>
        </div>
    </div>
    </form>
</body>
</html>
