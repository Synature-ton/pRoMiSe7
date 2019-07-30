﻿<%@ page language="C#" autoeventwireup="true" inherits="Inventory_WeeklyStock, App_Web_weeklystock_new.aspx.9758fd70" enableEventValidation="false" %>

<%@ Register Src="../UserControl/Footer.ascx" TagName="Footer" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Stock Count Weekly</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../css/Default.css" type="text/css" rel="stylesheet" />
    <link href="../App_Themes/Classic/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
    <link href="../scripts/selectmenu/selectmenu.css" rel="stylesheet" />
    <link href="../css/icon.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body
        {
            min-width: 1024px;
        }
        .noTitleStuff .ui-dialog-titlebar
        {
            display: none;
        }
        .dialogWithDropShadow
         {
             -webkit-box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.5);  
             -moz-box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.5); 
         }
    </style>
    <link href="../scripts/jquery.jqGrid-3.8/css/ui.jqgrid.css" rel="stylesheet" />

    <script type="text/javascript" src="../scripts/jquery-1.4.2.min.js"></script>

    <script type="text/javascript" src="../scripts/jquery-ui-1.8.4.custom.min.js"></script>

    <script type="text/javascript" src="../scripts/jquery.jqGrid-3.8/grid.locale-en.js"></script>
    <script type="text/javascript" src="../scripts/jquery.jqGrid-3.8/jquery.jqGrid.min.js"></script>

    <script type="text/javascript" src="../scripts/selectmenu/jquery.ui.selectmenu.js"></script>

    <script type="text/javascript" src="../scripts/regexNonNumeric.js"></script>

    <script type="text/javascript" src="../scripts/invJqueryPlugins.js"></script>

    <script type="text/javascript" src="../scripts/stockcount-util.js"></script>
    <script type="text/javascript">
        //<![CDATA[
        $(function() {
            $(window).bind('resize', function() {
                $("#theGrid").setGridWidth($("#grid-content").width());
            }).trigger('resize');
        });
        var isDiffAmount = false;
        var materialId = 0;
        var unitSmallAmount = 0;
        var unitLargeId = 0;
        var documentId = 0;
        var crCount = false;
        var allowCount = 0;

        //        window.onbeforeunload = function() {
        //            if (crCount)
        //                return '<%=lbl_3_20.Text %>';
        //        }

        function displayMaterial() {
            ajaxWorking();
            $("#btnDisplayMaterial").attr('disabled', true).addClass('ui-state-disabled');
            $('#<%=ddlInv.ClientID %>').attr('disabled', true).addClass('ui-state-disabled');
            $("#theGrid").jqGrid('setGridParam', {
                url: 'DataXML/WeeklyStockDataXML.aspx?action=load&StaffID=' + require_var.staffId + '&langId=' + require_var.langId + '&invId=' + $('#<%=ddlInv.ClientID %> :selected').val() + '&allowCount=' + allowCount
            }).trigger('reloadGrid');
            $("#theGrid").jqGrid().setCaption('<%=lbl_4_8.Text %>');
        }

        function countStockHistory(historyData) {
            $('#<%=ddlInv.ClientID %>').val($('#<%=ddlInvHistory.ClientID %> :selected').val());
            //console.log($('#<%=ddlInv.ClientID %> :selected').val());

            $("#theGrid").jqGrid().setGridParam({
                url: 'DataXML/WeeklyStockDataXML.aspx?action=historyDetail&StaffID=' + require_var.staffId + '&langId=' + require_var.langId + '&invId=' + $('#<%=ddlInv.ClientID %> :selected').val() + '&documentDate=' + historyData.stock_date_hide + '&documentId=' + historyData.documentId + '&documentStatus=' + historyData.documentStatus
            });
            $("#theGrid").jqGrid().trigger('reloadGrid');
            $("#theGrid").jqGrid().setCaption('<%=lbl_4_9.Text %> ' + historyData.countdate);
        }

        function saveCountStock() {
            ajaxWorking();
            $.ajax({
                url: 'DataXML/WeeklyStockDataXML.aspx?action=save&StaffID=' + require_var.staffId + '&langId=' + require_var.langId,
                dataType: 'json',
                data: "invId=" + $('#<%=ddlInv.ClientID %> :selected').val() +
                        "&remark=" + $("#txtRemark").val() + '&documentId=' + documentId,
                type: 'POST',
                cache: false,
                complete: function(xhr, status) {
                    var res = eval('(' + xhr.responseText + ')');
                    if (res.sess_timeout && res.sess_timeout == 1) {
                        window.location = "../Login.aspx";
                    } else {
                        if (res.save == '1') {
                            $("#alert_msg").text('<%=lbl_3_13.Text %>');
                            alertDialog();
                        }
                        else if (res.save == '0') {
                        $("#alert_msg").text('<%=lbl_3_14.Text %>');
                        alertDialog();
                        }

                        $("#theGrid").jqGrid().trigger('reloadGrid');

                        var ctrl = new Array();
                        ctrl.push("#btnApprove");
                        enableControl(ctrl);

                        getCountDate();
                    }
                }, error: function(xhr, status) {
                    alert(xhr.responsetext);
                }
            });
        }

        function approveStock() {
            $("#dialog_approvedocument").dialog({
                title: '<div style="float: left; font-size: 14px;"><div class="icon-vendors" style="float: left; width: 32px; height: 32px; margin-right: 4px;"></div><div style="float: left;"><div style="height: 4px; margin-top: 4px;"></div><div style="margin: 2px;">ยืนยันการอนุมัติเอกสารนับสต๊อก</div></div></div>',
                dialogClass: 'dialogWithDropShadow',
                width: 350,
                //height: 180,
                modal: true,
                resizable: false,
                buttons: {
                    '<%=lbl_2_11.Text %>': function () {
                        $("#dialog_approvedocument").dialog('close');
                    },
                    '<%=lbl_2_10.Text %>': function () {
                        ajaxWorking();
                        checkPermission(
                            19, //approve
                            $("#txtUserName").val(),
                            $("#txtPassword").val(),
                            function (data) {
                                var json = eval('(' + data.d + ')');
                                if (json.Status) {
                                    $("#dialog_approvedocument").dialog('close');
                                    // approve ajax
                                    ajaxWorking();
                                    // check not count row
                                    if (chkNotCount($("#theGrid"))) {
                                        $.ajax({
                                            url: 'DataXML/WeeklyStockDataXML.aspx?action=approve&StaffID=' + require_var.staffId + '&LangID=' + require_var.langId,
                                            dataType: 'json',
                                            data: "invId=" + $('#<%=ddlInv.ClientID %> :selected').val() + "&remark=" + $("#txtRemark").val() + "&documentId=" + documentId,
                                            type: 'POST',
                                            cache: false,
                                            success: function(data) {
                                                if (data.sess_timeout && data.sess_timeout == 1)
                                                    window.location = "../Login.aspx";

                                                if (data.approve == '1') {

                                                    $("#alert_msg").text('<%=lbl_3_15.Text %>');
                                                    alertDialog(function() {
                                                        window.location = "WeeklyStock_New.aspx?StaffID=" + require_var.staffId + '&StaffRoleID=' + require_var.staffRole +
                                                        '&LangID=' + require_var.langId;
                                                    });

                                                } else if (data.approve == '99') {
                                                    $("#alert_msg").text('<%=lbl_3_16.Text %>');
                                                    alertDialog();
                                                } else if (data.approve == '-1') {
                                                    $("#alert_msg").text('<%=lbl_3_31.Text %>');
                                                    alertDialog();
                                                } else if (data.isEndday == false) {
                                                    $("#alert_msg").text('<%=lbl_3_25.Text %>');
                                                    alertDialog();
                                                } else {
                                                    $("#alert_msg").text('<%=lbl_3_17.Text %>');
                                                    alertDialog();
                                                }
                                            }
                                        });
                                    } else {
                                        $("#alert_msg").html('<%=lbl_3_28.Text %>');
                                        alertDialog();
                                    }
                                }else{
                                    $("#alert_msg").text(json.ResultText);
                                    alertDialog();
                                }
                            },
                            function(xhr, status){
                                $("#alert_msg").text(xhr.responseText);
                                alertDialog();
                            }
                         );
                    }
                }, // button
                open: function () {
                    $('.ui-dialog-buttonpane').
                    find('button:contains("<%=lbl_2_10.Text %>")').button({
                        icons: {
                            primary: 'icon-btn-ok'
                        }
                    });

                    $('.ui-dialog-buttonpane').
                    find('button:contains("<%=lbl_2_11.Text %>")').button({
                        icons: {
                            primary: 'icon-btn-cancel'
                        }
                    });
                }
            });
        }

        function getCountDate() {
            //alert('getCountDate');
            $.ajax({
                url: 'DataXML/WeeklyStockDataXML.aspx?action=getCountDate&StaffID=' + require_var.staffId + '&langId=' + require_var.langId,
                dataType: 'json',
                data: ({ invId: $('#ddlInv :selected').val() }),
                type: 'POST',
                cache: false,
                success: function(data) {
                    if (data.sess_timeout && data.sess_timeout == 1)
                        window.location = "../Login.aspx";

                    //alert(data.countDate);
                    $('#txtLastCountDate').val(data.countDate);
                }
            });

        }

        function scrollToRow(targetGrid, id) {
            //alert(id);
            var rowHeight = 18; //getGridRowHeight(targetGrid) || 23; // Default height
            var index = jQuery(targetGrid).getInd(id);
            jQuery(targetGrid).closest(".ui-jqgrid-bdiv").scrollTop(rowHeight * index);
        }

        function disableControl(control) {
            for (var i = 0; i <= control.length - 1; i++) {
                $(control[i]).attr('disabled', true).addClass('ui-state-disabled');
            }
        }

        function enableControl(control) {
            for (var i = 0; i <= control.length - 1; i++) {
                $(control[i]).attr('disabled', false).removeClass('ui-state-disabled');
            }
        }

        function clearTextBox(control) {
            for (var i = 0; i <= control.length - 1; i++) {
                $(control[i]).val('');
            }
        }

        function cancelStockCount() {
            $("#dialog_approvedocument").dialog({
                title: '<div style="float: left; font-size: 14px;"><div class="icon-vendors" style="float: left; width: 32px; height: 32px; margin-right: 4px;"></div><div style="float: left;"><div style="height: 4px; margin-top: 4px;"></div><div style="margin: 2px;">ยืนยันการยกเลิกเอกสารนับสต๊อก</div></div></div>',
                dialogClass: 'dialogWithDropShadow',
                width: 350,
                //height: 180,
                modal: true,
                resizable: false,
                buttons: {
                    '<%=lbl_2_11.Text %>': function () {
                        $("#dialog_approvedocument").dialog('close');
                    },
                    '<%=lbl_2_10.Text %>': function () {
                        ajaxWorking();
                        checkPermission(
                            20, //cancel
                            $("#txtUserName").val(),
                            $("#txtPassword").val(),
                            function (data) {
                                var json = eval('(' + data.d + ')');
                                if (json.Status) {
                                    $("#dialog_approvedocument").dialog('close');
                                    // cancel ajax
                                    $.ajax({
                                        url: 'DataXML/WeeklyStockDataXML.aspx?action=cancelDocument&StaffID=' + require_var.staffId + '&LangID=' + require_var.langId + '&invId=' + $('#<%=ddlInv.ClientID %> :selected').val() + '&documentId=' + documentId,
                                        type: 'GET',
                                        dataType: 'json',
                                        cache: false,
                                        success: function(data) {
                                            if (data.sess_timeout && data.sess_timeout == 1)
                                                window.location = "../Login.aspx";

                                            $("#dialog_alert_icon").removeClass('ui-icon-alert').addClass('ui-icon-check');
                                            $("#alert_msg").html('<%=lbl_3_19.Text %>');
                                            alertDialog(function() {
                                                window.location = "WeeklyStock_New.aspx?StaffID=" + require_var.staffId + '&LangID=' + require_var.langId + '&StaffRoleID=' + require_var.staffRole;
                                            });
                    
                                        }, error: function(x, s) {
                                            $("#alert_msg").text(x.responseText);
                                            alertDialog();
                                        }
                                    });

                                }else{
                                    $("#alert_msg").text(json.ResultText);
                                    alertDialog();
                                }
                            },
                            function(xhr, status){
                                $("#alert_msg").text(xhr.responseText);
                                alertDialog();
                            }
                         );
                    }
                }, // button
                open: function () {
                    $('.ui-dialog-buttonpane').
                    find('button:contains("<%=lbl_2_10.Text %>")').button({
                        icons: {
                            primary: 'icon-btn-ok'
                        }
                    });

                    $('.ui-dialog-buttonpane').
                    find('button:contains("<%=lbl_2_11.Text %>")').button({
                        icons: {
                            primary: 'icon-btn-cancel'
                        }
                    });
                }
            });
        }
        //]]>
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:Literal ID="Require_Var" runat="server"></asp:Literal>
    <input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="" />
    <asp:HiddenField ID="DocumentID" runat="server" Value="0" />
    <asp:Button ID="BtnExportExcel1" runat="server" OnClick="ExportStockExcel_Click"
        Visible="false" />
    <div id="loading" style="display: none; overflow: hidden;">
        <div style="margin-left: 8px;" class="ui-widget">
            <img src="../Images/loadingSmall.gif" alt="" style="margin-right:2px;" /><asp:Label ID="lbl_3_1" runat="server" Text="รอสักครู่..." Style="font-size: 14px;
                color: #333; font-family: Segoe UI, Tahoma, Arial;"></asp:Label>
        </div>
    </div>
    <div style="display: none;" id="notfoundDataDialog" title="<%=lbl_3_2.Text %>">
        <div style="margin: 4px;">
            <span id="saveStatusText" style="color: #333; font-size: 1.2em; font-weight: bold;">
                <asp:Label ID="lbl_3_12" runat="server" Text="ไม่พบข้อมูลวัตถุดิบ กรุณาตรวจสอบการตั้งค่านับสต๊อก"></asp:Label></span>
        </div>
        <div style="margin: 4px; text-align: right;">
            <button type="button" id="btnCloseNotFoundDialog" onclick="javascript:$('#notfoundDataDialog').dialog('close');"
                style="width: 70px;">
                <asp:Label ID="lbl_2_1" runat="server" Text="ปิด"></asp:Label></button>
        </div>
    </div>
    <div>
        <div class="ui-widget ui-widget-header" style="height: 30px; padding: 4px 10px;">
            <div style="float: left; font-size: 14px;">
                <div class="icon-weekly-stock" style="float: left; width: 32px; height: 32px; margin-right: 4px;">
                </div>
                <div style="float: left;">
                    <div style="margin: 2px 0 0 2px;">
                        <asp:Label ID="lbl_1_1" runat="server" Text="นับสต๊อกรายสัปดาห์"></asp:Label></div>
                    <div style="height: 4px; font-size: 11px; font-weight: lighter;">
                        <asp:Label ID="lbl_1_2" runat="server" Text="นับสต๊อกเมื่อสิ้นสุดในแต่ละสัปดาห์ เพื่อปรับจำนวนสต๊อกให้ถูกต้อง"></asp:Label></div>
                </div>
            </div>
            <div style="float: right;">
                <div style="float: left;">
                    <button id="btnSaveForm" type="button" style="margin-right: 2px;" class="btn">
                        <asp:Label ID="lbl_2_2" Text="บันทึกสต๊อก" runat="server" class="btn"></asp:Label></button>
                    <button id="btnApprove" type="button" style="margin-right: 2px;" class="btn">
                        <asp:Label ID="lbl_2_3" Text="อนุมัติการนับสต๊อก" runat="server" class="btn"></asp:Label></button>
                    <span style="border-right: #ccc 1px solid; height: 12px; padding: 4px 0;">&nbsp;</span>
                      <button id="btnPrintHistory" type="button" style="margin-right: 2px;" class="btn">
                        <asp:Label ID="lbl_2_16" Text="พิมพ์ประวัติ" runat="server" class="btn"></asp:Label></button>
                    <button id="btnPrintForm" type="button" style="margin-right: 2px;" class="btn">
                        <asp:Label ID="lbl_2_4" Text="พิมพ์ฟอร์ม" runat="server" class="btn"></asp:Label></button>
                    <button id="btnExportExcel" type="button" style="margin-right: 2px;" class="btn">
                        <asp:Label ID="lbl_2_5" runat="server" Text="Export Excel"></asp:Label></button>
                    <button id="btnReport" type="button" style="margin-right: 2px; display: none;" class="btn">
                        <asp:Label ID="lblBtnReport" runat="server" Text="รายงานสรุป"></asp:Label></button>
                    <span style="border-right: #ccc 1px solid; height: 12px; padding: 4px 0;">&nbsp;</span>
                    <button id="btnCancelCountStock" type="button" style="margin-right: 2px;" class="btn">
                        <asp:Label ID="lbl_2_14" runat="server"></asp:Label></span></button>
                </div>
                <div style="float: left; display: none;">
                    <select id="slReport" name="slReport">
                        <option value="0">
                            <%=lbl_3_22.Text %></option>
                        <option value="1">
                            <%=lbl_3_23.Text %></option>
                        <option value="2">
                            <%=lbl_3_24.Text %></option>
                    </select>
                </div>
            </div>

            <script type="text/javascript">
                $("select#slReport").selectmenu({ style: 'dropdown' }).change(function() {

                    var inv = $('#<%=ddlInv.ClientID %> :selected').val();
                    var url = 'StockCountDiffReport.aspx?inv=' + inv + '&StockCountType=weekly';
                    if ($(this + ":selected").val() != "0") {
                        if ($(this + ":selected").val() == "1") {
                            window.open(url, 'stockCountDiffReport', 'width=1000, height=600,location=0,status=0,scrollbars=0 ');
                            $(this).val("0");
                        }
                        else if ($(this + ":selected").val() == "2") {
                            //alert($(this + ":selected").val());
                            url = 'StockCountEachMaterialReport.aspx?inv=' + inv + '&StockCountType=weekly';
                            window.open(url, 'stockCountEachMaterialReport', 'width=900, height=600,location=0,status=0,scrollbars=0 ');
                            $(this).val("0");
                        }
                    }
                });

                $("#btnCancelCountStock").button({
                    icons: {
                        primary: ' icon-action-cancel'
                    }
                }).click(function() {
                $("#confirmCancelDocumentDialog").dialog({
                dialogClass: 'dialogWithDropShadow noTitleStuff ',
                        title: '<%=lbl_3_7.Text %>',
                        width: 380,
                        height: 80,
                        modal: true
                        /*resizable: false */
                    });
                }).attr('disabled', true).addClass('ui-state-disabled');
                
                // additional print history count
                // add 7/5/14
                $("#btnPrintHistory").button({
                    icons: {
                        primary: 'icon-action-print'
                    }
                }).click(function() {
                    printHistory = window.open('Report/crstockcounthistory.aspx?docId=' +
                    documentId + '&invName=' + $('#<%=ddlInv.ClientID %> :selected').text() +
                    '&stockType=2&invId=' + $('#<%=ddlInv.ClientID %> :selected').val() +
                    '&langId=' + require_var.langId +
                    '&crForm=1', '', 'location=1,status=1,scrollbars=1');
                }).attr('disabled', true).addClass('ui-state-disabled');

                $("#btnPrintForm").button({
                    icons: {
                        primary: ' icon-action-print'
                    }
                }).click(function() {
                    print_weekly = window.open('Report/crreportstockcountmonthly.aspx?invName=' +
                    $('#<%=ddlInv.ClientID %> :selected').text() +
                    '&stockCountName=<%=lbl_1_1.Text %>' + '&stockCountType=weeklystockmaterial' +
                    '&stockdate=' + $('#<%=txtLastCountDate.ClientID %>').val() +
                    '&shopId=' + $('#<%=ddlInv.ClientID %> :selected').val() + '&langId=' + require_var.langId, '', 'location=1,status=1,scrollbars=1');
                });

                $("#btnSaveForm").button({
                    icons: {
                        primary: ' icon-action-save'
                    }
                }).click(function() {
                    //alert(selectedRowID);
                    //$("#theGrid").jqGrid('saveCell', selectedRowID, 5);
                    saveCountStock();
                }).attr('disabled', true).addClass('ui-state-disabled');

                $('#btnExportExcel').button({
                    icons: {
                        primary: 'icon-export-xls'
                    }
                }).click(function() {
                    document.getElementById('form1').__EVENTTARGET.value = 'BtnExportExcel1';
                    document.getElementById('form1').submit();
                });

                $("#btnReport").button({
                    icons: {
                        primary: ' icon-action-report'
                    }
                });
            </script>

        </div>
        <div style="margin: 8px 4px">
            <div class="ui-widget-content">
                <table class="paramlist admintable" cellspacing="1" width="100%">
                    <tbody>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lbl_1_3" runat="server" Text="คลัง"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlInv" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lbl_1_4" runat="server" Text="วันที่นับสต๊อกล่าสุด"></asp:Label>
                            </td>
                            <td style="white-space: nowrap;">
                                <asp:TextBox ID="txtLastCountDate" Enabled="false" ReadOnly="true" runat="server"></asp:TextBox>
                                <button id="btnDisplayMaterial" type="button" style="margin-right: 2px; width: 110px;"
                                    class="btn">
                                    <asp:Label ID="lbl_2_7" Text="แสดงข้อมูล" runat="server" class="btn"></asp:Label></button>
                                <button id="btnAutocount" type="button" style="display:none;">
                                    <asp:Label ID="lbl_2_15" Text="นับอัตโนมัติ" runat="server"></asp:Label>
                                </button>
                            </td>
                            <td class="paramlist_key">
                            </td>
                            <td>
                                <button id="btnCountStockHistory" type="button" style="margin-right: 2px; width: 110px;"
                                    class="btn">
                                    <asp:Label ID="lbl_2_6" Text="ประวัติบันทึก" runat="server" class="btn"></asp:Label></button>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lbl_1_5" runat="server" Text="รหัสวัตถุดิบ" class="font-bold"></asp:Label>
                            </td>
                            <td>
                                <input type="text" id="txtMatCode" style="width: 100px;" class="text-box text-box-font-bold ui-state-disabled" />

                                <script type="text/javascript">
                                    $("#txtMatCode").autocomplete({
                                        delay: 1,
                                        source: function(request, response) {
                                            $.ajax({
                                                url: 'DataXML/MaterialListDataXML.aspx?action=smat&invId=' + $('#<%=ddlInv.ClientID %> :selected').val() +
                                                 '&matCode=' + $("#txtMatCode").val() + '&configCountTable=weeklystockmaterial' +
                                                 '&staffId=' + require_var.staffId +
                                                 '&staffRole=' + require_var.staffRole +
                                                 '&langId=' + require_var.langId,
                                                dataType: 'json',
                                                cache: false,
                                                global: false,
                                                complete: function(xhr, status) {
                                                    try {
                                                        var data = eval('(' + xhr.responseText + ')');
                                                        //alert(xhr.responseText);
                                                        response($.map(data.matList, function(item) {
                                                            return {
                                                                label: item.materialCode + ' ( ' + item.materialName + ' ) ',
                                                                value: item.materialCode
                                                            }
                                                        }));
                                                    } catch (e) {
                                                        alert(xhr.responseText);
                                                    }
                                                }
                                            });
                                        },
                                        minLength: 0,
                                        open: function() {
                                            $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
                                        },
                                        close: function() {
                                            $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
                                        }
                                    });
                                </script>

                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lbl_1_6" runat="server" Text="ชื่อวัตถุดิบ" class="font-bold"></asp:Label>
                            </td>
                            <td>
                                <input type="text" id="txtMatName" style="width: 240px;" readonly="readonly" class="text-box text-box-font-bold ui-state-disabled" />
                            </td>
                            <td class="paramlist_key" rowspan="2" valign="top">
                                <asp:Label ID="lbl_1_7" runat="server" Text="หมายเหตุ" class="font-bold"></asp:Label>
                            </td>
                            <td rowspan="2" valign="top">
                                <textarea id="txtRemark" cols="20" style="height: 50px;"></textarea>
                            </td>
                            <td rowspan="2" valign="middle">
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lbl_1_8" runat="server" Text="จำนวนคงเหลือ" class="font-bold"></asp:Label>
                            </td>
                            <td>
                                <input type="text" id="txtMatRemainAmount" style="width: 100px; text-align: right;"
                                    class="text-box text-box-font-bold ui-state-disabled" readonly="readonly" />
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lbl_1_9" runat="server" Text="จำนวนนับ" class="font-bold"></asp:Label>
                            </td>
                            <td>
                                <input type="text" id="txtCountAmount" style="width: 100px; text-align: right;" class="txt-numeric text-box text-box-font-bold ui-state-disabled" />
                                <input type="text" id="txtCountUnitName" style="width: 100px;" readonly="readonly"
                                    class="text-box text-box-font-bold ui-state-disabled" />
                                <button id="btnCountMat" type="button">
                                    <span>...</span></button>
                                <img src="../Images/loadingSmall.gif" id="count_progress" alt="" style="display:none;"/>
                                    <br />
                                <span id="validate_amount" style="border-top:none;"></span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div  style="margin:0 auto; text-align:center;"><asp:Label ID="lblMonthCount" runat="server"></asp:Label></div>
            <div style="margin: 4px 0;" id="grid-content">
                <table id="theGrid" class="scroll">
                </table>
                <div id="pager" class="scroll">
                </div>

                <script type="text/javascript">
                    $("#theGrid").jqGrid({
                        jsonReader: {
                            repeatitems: false,
                            root: "rows",
                            page: "page",
                            total: "total",
                            records: "records",
                            cell: "",
                            id: "0"
                        },
                        url: 'noData.json',
                        colNames: ["<%=lbl_4_1.Text %>", "<%=lbl_4_2.Text %>", "<%=lbl_4_3.Text %>", "summary", "unitSmallAmount", "<%=lbl_4_4.Text %>", "<%=lbl_4_5.Text %>", "<%=lbl_4_6.Text %>", "diff", "<%=lbl_4_7.Text %>", "ต้นทุนต่อหน่วย", "รวมต้นทุน", "materialID", "unitLargeId", "unitid", "isSave", "documentId"],
                        colModel: [{ "name": "id", "index": "id", "jsonmap": "id", "width": 2, "align": "center", "sortable": false },
                            { "name": "mcode", "index": "mcode", "jsonmap": "mcode", "width": 20 },
                            { "name": "mname", "index": "mname", "jsonmap": "mname", "width": 30 },
                            { "name": "summary", "index": "summary", "jsonmap": "summary", "hidden": true },
                            { "name": "unitSmallAmount", "index": "unitSmallAmount", "jsonmap": "unitSmallAmount", "hidden": true },
                            { "name": "mcountremain", "index": "mcountremain", "jsonmap": "mcountremain", "width": 8, "align": "right", "hidden": false },
                            { "name": "mcountamount", "index": "mcountamount", "jsonmap": "mcountamount", "width": 8, "align": "right", "editable": true, "editrules": { "number": true} },
                            { "name": "mdiffdisplay", "index": "mdiffdisplay", "jsonmap": "mdiffdisplay", "width": 8, "align": "right", "hidden": false },
                            { "name": "mdiff", "index": "mdiff", "jsonmap": "mdiff", "width": 8, "align": "right", "hidden": true },
                            { "name": "munit", "index": "munit", "jsonmap": "munit", "width": 10, "align": "center" },
                            { "name": "mcostperunit", "index": "mcostperunit", "jsonmap": "mcountperunit", "width": 8, "align": "right", "hidden": true },
                            { "name": "mtotalcost", "index": "mtotalcost", "jsonmap": "mtotalcost", "width": 8, "align": "right", "hidden": true },
                            { "name": "mid", "index": "mid", "jsonmap": "mid", "hidden": true },
                            { "name": "munitlargeid", "index": "munitlargeid", "jsonmap": "munitlargeid", "hidden": true },
                            { "name": "countunitid", "index": "countunitid", "jsonmap": "countunitid", "hidden": true },
                            { "name": "documentStatus", "index": "documentStatus", "jsonmap": "documentStatus", "hidden": true },
                            { "name": "documentId", "index": "documentId", "jsonmap": "documentId", "hidden": true}],
                        datatype: 'json',
                        pager: '#pager',
                        loadui: 'disable',
                        autowidth: true,
                        height: 400,
                        rowNum: -1,
                        scrollrows: true,
                        //rowList: [10, 20, 50, 100],
                        pgtext: null,
                        pgbuttons: false,
                        viewrecords: true,
                        onSelectRow: function(id) {
                            var dataSl = $(this).jqGrid('getRowData', id);
                            $("#txtMatCode").val(dataSl.mcode);
                            $("#txtMatName").val(dataSl.mname);
                            $("#txtMatRemainAmount").val(dataSl.summary);
//                            if (dataSl.mcountamount == "")
//                                $("#txtCountAmount").val(dataSl.summary).select();
//                            else
                                $("#txtCountAmount").val(dataSl.mcountamount).select();
                            $("#txtCountUnitName").val(dataSl.munit);
                            materialId = dataSl.mid;
                            unitSmallAmount = dataSl.unitSmallAmount;
                            unitLargeId = dataSl.munitlargeid;
                            documentId = dataSl.documentId;

                            //alert(dataSl.unitSmallAmount);
                        },
                        caption: '<%=lbl_4_8.Text %>',
                        gridComplete: function() {

                            chkCountDiffInJqGrid($("#theGrid"));

                            var ids = $("#theGrid").jqGrid('getDataIDs');
                            if (ids.length > 0) {
                                $("#theGrid").jqGrid('setSelection', ids[0]);

                                //alert($("#theGrid").jqGrid('getRowData', ids[0]).documentStatus);
                                require_var.docStatus = $("#theGrid").jqGrid('getRowData', ids[0]).documentStatus;

                                if ($("#theGrid").jqGrid('getRowData', ids[0]).documentStatus == 1) {
                                    var control = new Array();
                                    control.push("#txtMatCode", "#txtMatName", "#txtMatRemainAmount", "#txtCountAmount",
                                "#txtCountUnitName", "#btnCountMat", "#btnSaveForm", "#btnApprove", "#btnCancelCountStock", "#btnCancelCountStock");
                                    enableControl(control);
                                    $("#btnPrintHistory").attr('disabled', true).addClass('ui-state-disabled');
                                } else if ($("#theGrid").jqGrid('getRowData', ids[0]).documentStatus == 2 || $("#theGrid").jqGrid('getRowData', ids[0]).documentStatus == 99) {
                                    var control = new Array();
                                    control.push("#txtMatCode", "#txtMatName", "#txtMatRemainAmount", "#txtCountAmount",
                                "#txtCountUnitName", "#btnCountMat", "#btnApprove", "#btnSaveForm", "#btnCancelCountStock", "#btnAutoTransferStock");
                                    disableControl(control);
                                    $("#btnPrintHistory").attr('disabled', false).removeClass('ui-state-disabled');
                                } else {
                                    var control = new Array();
                                    control.push("#txtMatCode", "#txtMatName", "#txtMatRemainAmount", "#txtCountAmount",
                                "#txtCountUnitName", "#btnCountMat", "#btnApprove", "#btnSaveForm", "#btnCancelCountStock", "#btnAutoTransferStock");
                                    disableControl(control);
                                }
                            }
                        }, loadComplete: function(data) {
                            $('#<%=DocumentID.ClientID%>').val("0");
                            if(data != null && data != undefined){
                                $('#<%=DocumentID.ClientID%>').val(data.documentId);
                            }
                            require_var.docStatus = data.documentStatus;
                            if (data.documentStatus == 1) {
                                documentId = data.documentId;
                                var control = new Array();
                                control.push("#txtMatCode", "#txtMatName", "#txtMatRemainAmount", "#txtCountAmount",
                                    "#txtCountUnitName", "#btnCountMat", "#btnSaveForm", "#btnApprove", "#btnCancelCountStock", "#btnCancelCountStock");
                                enableControl(control);
                            } else if (data.documentStatus == 2 || data.documentStatus == 99) {
                                documentId = data.documentId;
                                var control = new Array();
                                control.push("#txtMatCode", "#txtMatName", "#txtMatRemainAmount", "#txtCountAmount",
                                    "#txtCountUnitName", "#btnCountMat", "#btnApprove", "#btnSaveForm", "#btnCancelCountStock", "#btnAutoTransferStock");
                                disableControl(control);
                            } else {
                                var control = new Array();
                                control.push("#txtMatCode", "#txtMatName", "#txtMatRemainAmount", "#txtCountAmount",
                                    "#txtCountUnitName", "#btnCountMat", "#btnApprove", "#btnSaveForm", "#btnCancelCountStock", "#btnAutoTransferStock");
                                disableControl(control);
                            }
                            if (data.sess_timeout && data.sess_timeout == 1) {
                                crCount = false;
                                window.location = "../Login.aspx";
                            }

                            //alert(data.remark);
                            $("#txtRemark").val(data.remark);
                            $('#<%=ddlInv.ClientID %>').attr('disabled', false).removeClass('ui-state-disabled');

                            if(data.weeklyCount == 0){
                                $("#alert_msg").text('ไม่สามารถนับสต๊อกได้ วันนี้ไม่ใช่วันนับสต๊อกรายสัปดาห์');
                                alertDialog();
                            }

                            if (data.monthlyCount == 1) {
                                $("#alert_msg").text('<%=lbl_3_27.Text %>');
                                alertDialog();
                            }
                            //                            if (data.haveDailyDoc == true) {
                            //                                if (confirm('มีการนับสต๊อกรายวันค้างอยู่ คุณต้องการนับสต๊อกรายสัปดาห์หรือไม่?')) {
                            //                                    allowCount = 1;
                            //                                    displayMaterial();
                            //                                }
                            //                            }
                            if (data.approve == 99 || data.approve == 1) {
                                if (data.approve == 99) {
                                    $("#alert_msg").text('<%=lbl_3_18.Text %>');
                                    alertDialog();
                                }
                                else if (data.approve == 1) {
                                    $("#alert_msg").text('<%=lbl_3_17.Text %>');
                                    alertDialog();
                                }
                                var control = new Array();
                                control.push("#txtMatCode", "#txtMatName", "#txtMatRemainAmount", "#txtCountAmount",
                                "#txtCountUnitName", "#btnCountMat", "#btnApprove", "#btnSaveForm", "#btnCancelCountStock", "#btnAutoTransferStock");
                                disableControl(control);
                            } else if (data.approve == "-1") {
                                $("#alert_msg").text('<%=lbl_3_21.Text %>');
                                alertDialog();
                                var control = new Array();
                                control.push("#txtMatCode", "#txtMatName", "#txtMatRemainAmount", "#txtCountAmount",
                                "#txtCountUnitName", "#btnCountMat", "#btnApprove", "#btnSaveForm", "#btnCancelCountStock", "#btnAutoTransferStock");
                                disableControl(control);
                            } else if (data.endday == false) {
                                $("#alert_msg").text('<%=lbl_3_26.Text %>');
                                alertDialog();
                            }
                            else {
                                var ids = $("#theGrid").jqGrid('getDataIDs');
                                if (ids.length == 0) {
                                    if (data.found == false) {
                                        $("#alert_msg").text('<%=lbl_3_12.Text %>');
                                        alertDialog();
                                    }
                                    //clear 
                                    $("#txtMatCode").val('');
                                    $("#txtMatName").val('');
                                    $("#txtMatRemainAmount").val('');
                                    $("#txtCountAmount").val('');
                                    $("#txtCountUnitName").val('');
                                }
                            }

                            $("#btnDisplayMaterial").attr('disabled', false).removeClass('ui-state-disabled');

                            notAllowCount();
                        }
                    }).jqGrid('navGrid', '#pager',
                            {
                                edit: false,
                                add: false,
                                del: false,
                                refresh: false,
                                search: false
                            }).navButtonAdd('#pager', {
                                caption: "Refresh",
                                title: '<%=lbl_3_33.Text %>',
                                buttonicon: "ui-icon-refresh",
                                onClickButton: function () {
                                    refreshSettingStockCount(documentId, $('#ddlInv :selected').val(),
                                    function (result) {
                                        if (result.Status == 1) {
                                            displayMaterial();
                                            //alert(result.Msg);
                                        } else {
                                            alert(result.Msg);
                                        }

                                    }, function (xhr, status) {
                                        alert(xhr.responseText);
                                    });
                                },
                                position: "last"
                            });
                </script>

                <div style="text-align: center">
                    <uc1:Footer ID="Footer1" runat="server" />
                </div>
            </div>

            <script type="text/javascript">
                //-- init button
                $("#btnCountMat").button({
                    icons: {
                        primary: ''
                    }
                }).click(function() {
                    // do add material to grid
                    $("#unitDetail").stockCountUnit({
                        materialId: materialId,
                        materialAmount: $("#txtCountAmount").val(),
                        unitSmallAmount: unitSmallAmount,
                        materialRemainAmount: $("#txtMatRemainAmount").val(),
                        materialCode: $("#txtMatCode").val(),
                        materialName: $("#txtMatName").val(),
                        materialUnitName: $("#txtCountUnitName").val()
                    });
                });

                $("#btnAutoTransferStock").button({
                    icons: {
                        primary: 'icon-btn-autotransfer'
                    }
                }).click(function() {
                $("#cfAutoTransferDialog").dialog({
                dialogClass: 'dialogWithDropShadow noTitleStuff ',
                        width: 380,
                        height: 110,
                        modal: true
                        /*resizable: false */
                    });
                }); //.attr('disabled', true).addClass('ui-state-disabled');
                $("#btnDisplayMaterial").button({
                    icons: {
                        primary: ' icon-action-table-display'
                    }
                }).click(function() {
                    displayMaterial();
                });

                $("#btnAutocount").button({
                    icons: {
                        primary: ' icon-action-table-display'
                    }
                }).click(function () {
                    $("#auto_count_dialog").dialog({
                        dialogClass: 'dialogWithDropShadow noTitleStuff ',
                        width: 380,
                        height: 110,
                        modal: true
                        /*resizable: false */
                    });
                });

                $("#btnCountStockHistory").button({
                    icons: {
                        primary: 'icon-action-history'
                    }
                }).click(function() {
                $("#history_dialog").dialog({
                dialogClass: 'dialogWithDropShadow ',
                        width: 'auto',
                        modal: false,
                        resizable: false
                    });
                    $("#historyTable").jqGrid('setGridParam',
                    { url: 'DataXML/WeeklyStockDataXML.aspx?action=history&StaffID=' + require_var.staffId + '&langId=' + require_var.langId + '&invId=' + $('#<%=ddlInvHistory.ClientID %> :selected').val() + '&dateFrom=' + $('#<%=ddlDateFrom.ClientID %> :selected').val() + '&monthFrom=' + $('#<%=ddlMonthFrom.ClientID %> :selected').val() + '&yearFrom=' + $('#<%=ddlYearFrom.ClientID %> :selected').val() + '&dateTo=' + $('#<%=ddlDateTo.ClientID %> :selected').val() + '&monthTo=' + $('#<%=ddlMonthTo.ClientID %> :selected').val() + '&yearTo=' + $('#<%=ddlYearTo.ClientID %> :selected').val() }).trigger('reloadGrid');
                });


                $('#<%=ddlInv.ClientID %>').change(function() {

                    $('#<%=ddlInvHistory.ClientID %>').val($('#<%=ddlInv.ClientID %> :selected').val());

                    $("#txtMatCode").val('');
                    $("#txtMatName").val('');
                    $("#txtMatRemainAmount").val('');
                    $("#txtCountAmount").val('');
                    $("#txtCountUnitName").val('');

                    getCountDate();

                    $("#theGrid").jqGrid('clearGridData');

                    notAllowCount();
                }).val(require_var.dbShopId);

                $("#txtMatCode").keyup(function(e) {
                    if (e.keyCode == 13) {
                        //if ($(this).val() != "") {
                        //do search material
                        findMaterial();
                        //
                        //}
                    }
                }).click(function() {
                    $(this).select();
                });

                $("#txtCountAmount").keyup(function(e) {
                    $("#validate_amount").html('').removeClass('ui-state-error');
                    if (e.keyCode == 13) {
                        if ($(this).val() != "" && !isNaN(parseFloat($(this).val()))) {
                            setMatCountToGrid();
                            crCount = true;
                        } else {
        //                            $("#alert_msg").html('<%=lbl_3_8.Text %>');
                        //                            alertDialog($("#txtCountAmount"));
                            $("#validate_amount").html('<%=lbl_3_8.Text %>').addClass('ui-state-error');
                        }
                    }
                }).click(function() {
                    $(this).select();
                });

                function findMaterial() {
                    //                    $("#theGrid").jqGrid('setGridParam',
                    //                    { url: 'DataXML/MonthlyStockDataXML.aspx?action=load&StaffID=' + require_var.staffId + '&langId=' + require_var.langId + '&invId=' + $('#<%=ddlInv.ClientID %> :selected').val() + '&cMonth=' + $('#ddlCountStockMonth :selected').val() + '&cYear=' + $('#ddlCountStockYear :selected').val() + '&matCode=' + $("#txtMatCode").val(),
                    //                        page: 1
                    //                    }).trigger('reloadGrid');

                    var theGrid = $("#theGrid");

                    for (var i = 1; i <= theGrid.jqGrid('getGridParam', 'records'); i++) {
                        if ($("#txtMatCode").val() == theGrid.jqGrid('getRowData', i).mcode) {
                            theGrid.jqGrid('setSelection', i);
                            //scrollToRow(theGrid, i);
                            break;
                        }
                    }
                    /*$.ajax({
                    url: 'DataXML/MonthlyStockDataXML.aspx?action=load&invId=' + $('#<%=ddlInv.ClientID %> :selected').val() + '&cMonth=' + $('#ddlCountStockMonth :selected').val() + '&cYear=' + $('#ddlCountStockYear :selected').val() + '&matCode=' + $("#txtMatCode").val(),
                    dataType: 'json',
                    cache: false,
                    success: function (result) {
                    if (result) {
                    if (result.found == 1) {
                    $("#txtMatCode").val(result.materialCode);
                    $("#txtMatName").val(result.materialName);
                    $("#txtMatRemainAmount").val(result.summary);
                    $("#txtCountAmount").val(result.summary).focus().select();
                    $("#txtCountUnitName").val(result.countUnitName);
                    //alert(result.materialId);
                    unitSmallAmount = result.unitSmallAmount;
                    materialId = result.materialId;
                    unitLargeId = result.countUnit;
                    } else {
                    $("#txtMatCode").val('');
                    $("#txtMatName").val('');
                    $("#txtMatRemainAmount").val('');
                    $("#txtCountAmount").val('');
                    $("#txtCountUnitName").val('');
                    materialId = 0;
                    unitLargeId = 0;
                    }
                    }
                    },
                    error: function (xhr, status) {
                    $("#debug").html(xhr.responseText);
                    }
                    });
                    */
                }

                function setMatCountToGrid() {
                    var countAmount = $("#txtCountAmount").val();
                    var remainAmount = $("#txtMatRemainAmount").val();
                    var grid = $("#theGrid");
                    var ids = grid.jqGrid('getDataIDs');
                    var selRow = parseInt(grid.jqGrid('getGridParam', 'selrow'));

                    if ($("#txtCountAmount").val() != "" && $("#txtMatRemainAmount").val() != "") {
                        if (parseFloat($("#txtCountAmount").val()) >= 0) {
                            // enable count progress
                            //$("#count_progress").css('display', '');
                            
                            $("#validate_amount").html('').removeClass('ui-state-error');
                            $.ajax({
                                url: 'DataXML/DailyStockDataXML.aspx?action=updateStockCount&StaffID=' + require_var.staffId + '&langId=' + require_var.langId + '&invId=' + $('#<%=ddlInv.ClientID %> :selected').val() + '&documentId=' + grid.jqGrid('getRowData', selRow).documentId + '&materialId=' + grid.jqGrid('getRowData', selRow).mid + '&countAmount=' + countAmount + '&summaryAmount=' + remainAmount + '&unitLargeId=' + grid.jqGrid('getRowData', selRow).munitlargeid,
                                global: false,
                                dataType: 'json',
                                cache: false,
                                complete: function(xhr, status) {
                                    // hide count progress
                                    //$("#count_progress").css('display', 'none');
                                    try {
                                        var data = eval('(' + xhr.responseText + ')');
                                        grid.jqGrid('setRowData', selRow, {
                                            mcountamount: data.countAmount,
                                            mdiffdisplay: data.diffAmount,
                                            mdiff: data.diffAmount
                                        });
                                        grid.jqGrid('setCell', selRow, 6, '', { 'background': '#FFFFFF', 'color': '#000000' });

                                        if (selRow < ids[ids.length - 1]) {
                                            grid.jqGrid('setSelection', selRow + 1);
                                            var dataSl = grid.jqGrid('getRowData', selRow + 1)
                                            $("#txtMatCode").val(dataSl.mcode);
                                            $("#txtMatName").val(dataSl.mname);
                                            $("#txtMatRemainAmount").val(dataSl.summary);
                                            if (dataSl.mcountamount != "")
                                                $("#txtCountAmount").val(dataSl.mcountamount).select();
//                                            else
//                                                $("#txtCountAmount").val(dataSl.summary).select();
                                            $("#txtCountUnitName").val(dataSl.munit);
                                            materialId = dataSl.mid;
                                            unitSmallAmount = dataSl.unitSmallAmount;
                                            unitLargeId = dataSl.munitlargeid;
                                        }
                                    } catch (e) {
                                        // hide count progress
                                        $("#count_progress").css('display', 'none');
                                        alert(xhr.responseText);
                                    }
                                }
                            });
                        } else {
//                            $("#alert_msg").html('<%=lbl_3_30.Text %>');
                        //                            alertDialog($("#txtCountAmount"));

                            $("#validate_amount").html('<%=lbl_3_30.Text %>').addClass('ui-state-error');
                        }
                    }
                }
                
            </script>

            <div id="history_dialog" style="display: none; overflow: hidden;" title='<%=lbl_3_5.Text %>'>
                <div class="ui-widget-content">
                    <table class="paramlist admintable" cellspacing="1" width="100%">
                        <tbody>
                            <tr>
                                <td class="paramlist_key fix-width">
                                    <%=lbl_1_3.Text %>
                                </td>
                                <td colspan="3">
                                    <asp:DropDownList ID="ddlInvHistory" runat="server" Width="200">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="paramlist_key fix-width">
                                    <asp:Label ID="lbl_1_10" runat="server" Text="จากวันที่"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlDateFrom" runat="server">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlMonthFrom" runat="server">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlYearFrom" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td class="paramlist_key fix-width">
                                    <asp:Label ID="lbl_1_11" runat="server" Text="ถึงวันที่"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlDateTo" runat="server">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlMonthTo" runat="server">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlYearTo" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <button id="btnDisplayHistory" type="button">
                                        <%=lbl_2_6.Text %></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div style="padding: 4px;">
                    <table id="historyTable">
                    </table>
                    <div id="historyPage">
                    </div>

                    <script type="text/javascript">
                        $('#<%=ddlInvHistory.ClientID %>').val(require_var.dbShopId);
                        $("#historyTable").jqGrid({
                            url: 'DataXML/WeeklyStockDataXML.aspx?action=history&StaffID=' + require_var.staffId + '&langId=' + require_var.langId + '&invId=' + $('#<%=ddlInvHistory.ClientID %> :selected').val() + '&dateFrom=' + $('#<%=ddlDateFrom.ClientID %> :selected').val() + '&monthFrom=' + $('#<%=ddlMonthFrom.ClientID %> :selected').val() + '&yearFrom=' + $('#<%=ddlYearFrom.ClientID %> :selected').val() + '&dateTo=' + $('#<%=ddlDateTo.ClientID %> :selected').val() + '&monthTo=' + $('#<%=ddlMonthTo.ClientID %> :selected').val() + '&yearTo=' + $('#<%=ddlYearTo.ClientID %> :selected').val(),
                            jsonReader: {
                                repeatitems: false,
                                root: 'rows',
                                page: 'page',
                                total: 'total',
                                records: 'records',
                                cell: '',
                                id: '0'
                            },
                            datatype: 'json',
                            colNames: ['<%=lbl_4_1.Text %>', '<%=lbl_4_9.Text %>', '<%=lbl_4_13.Text %>', '<%=lbl_4_10.Text %>', '<%=lbl_4_12.Text %>', '<%=lbl_4_11.Text %>', 'documentId', 'inv', 'documentStatus', 'stock_date_hide', 'remark'],
                            colModel: [{ name: 'id', index: 'id', width: 20, align: 'center' },
                            { name: 'countdate', index: 'countdate', jsonmap: 'countdate', width: 120, editable: false },
                            { name: 'updatedate', index: 'updatedate', jsonmap: 'updateDate', width: 180, editable: false },
                            { name: 'staffname', index: 'staffname', jsonmap: 'staffname', width: 200, editable: false },
                            { name: 'approveStaffName',  jsonmap: 'approveStaffName', width: 200, editable: false },
                            { name: 'status', index: 'status', jsonmap: 'status', width: 100, align: 'center' },
                            { name: 'documentId', index: 'documentId', jsonmap: 'documentId', hidden: true },
                            { name: 'inv', index: 'inv', jsonmap: 'inv', hidden: true },
                            { name: 'documentStatus', index: 'documentStatus', jsonmap: 'documentStatus', hidden: true },
                            { name: 'stock_date_hide', index: 'stock_date_hide', jsonmap: 'stock_date_hide', hidden: true },
                            { name: 'remark', index: 'remark', jsonmap: 'remark', hidden: true }
                            ],
                            pager: '#historyPage',
                            width: 710,
                            height: 300,
                            loadui: 'disable',
                            rowNum: -1,
                            viewrecords: true,
                            pgbuttons: false,
                            pgtext: null,
                            ondblClickRow: function(rowid, iRow, iCol, e) {
                                var historyData = $(this).jqGrid('getRowData', rowid);
                                countStockHistory(historyData);
                                $("#history_dialog").dialog('close');
                            }, caption: '<%=lbl_3_5.Text %>',
                            gridComplete: function() {
                                var ids = $(this).jqGrid('getDataIDs');
                                //alert(ids.length);
                                if (ids.length > 0) {
                                    for (var i = 0; i < ids.length; i++) {
                                        var status = $(this).jqGrid('getRowData', ids[i]).documentStatus;
                                        //alert(status);
                                        switch (status) {
                                            case '1':
                                                $(this).jqGrid('setRowData', ids[i], { status: '<%=lbl_3_9.Text %>' });
                                                break;
                                            case '2':
                                                $(this).jqGrid('setRowData', ids[i], { status: '<%=lbl_3_10.Text %>' });
                                                break;
                                            case '99':
                                                $(this).jqGrid('setRowData', ids[i], { status: '<%=lbl_3_11.Text %>' });
                                                break;
                                        }
                                    }
                                }
                            }
                        });
                        $("#historyTable").jqGrid('navGrid', '#historyPager', { edit: false, add: false, del: false });
                    </script>

                </div>
                <div style="text-align: right; padding-right: 2px;">
                    <button id="btnOkHistory" type="button" style="display: none;">
                        <asp:Label ID="lbl_2_8" runat="server" Text="OK"></asp:Label></button>
                    <button id="btnCancelHistory" type="button" style="display: none;">
                        <asp:Label ID="lbl_2_9" runat="server" Text="Cancel"></asp:Label></button>
                </div>
            </div>

            <script type="text/javascript">
                // button option
                $("#btnDisplayHistory").button({
                    icons: {
                        primary: 'icon-action-history'
                    }
                }).click(function() {
                    $("#historyTable").jqGrid('setGridParam',
                { url: 'DataXML/WeeklyStockDataXML.aspx?action=history&StaffID=' + require_var.staffId + '&langId=' + require_var.langId + '&invId=' + $('#<%=ddlInvHistory.ClientID %> :selected').val() + '&dateFrom=' + $('#<%=ddlDateFrom.ClientID %> :selected').val() + '&monthFrom=' + $('#<%=ddlMonthFrom.ClientID %> :selected').val() + '&yearFrom=' + $('#<%=ddlYearFrom.ClientID %> :selected').val() + '&dateTo=' + $('#<%=ddlDateTo.ClientID %> :selected').val() + '&monthTo=' + $('#<%=ddlMonthTo.ClientID %> :selected').val() + '&yearTo=' + $('#<%=ddlYearTo.ClientID %> :selected').val() }).trigger('reloadGrid');
                });
                // button remark dialog
                $("#btnOkRemark").button({
                    icons: {
                        primary: 'icon-btn-ok'
                    }
                }).click(function() {
                    approveStock();
                    $("#remarkDialog").dialog('close');
                });
                $("#btnCancelRemark").button({
                    icons: {
                        primary: 'icon-btn-cancel'
                    }
                }).click(function() {
                    $("#remarkDialog").dialog('close');
                });

                $("#btnOkHistory").button({
                    icons: {
                        primary: 'icon-btn-ok'
                    }
                }).click(function() {
                    $("#history_dialog").dialog('close');
                });
                $("#btnCancelHistory").button({
                    icons: {
                        primary: 'icon-btn-cancel'
                    }
                }).click(function() {
                    $("#history_dialog").dialog('close');
                });
            </script>

        </div>
    </div>
    <div id="unitDetail" style="display: none;">
    </div>
    <div id="customDialog" style="display: none; height: 70px;">
    </div>
    <div style="display: none;" id="saveSuccess" title="">
        <div style="margin: 4px;">
            <span id="saveSuccessText" style="font-size: 1.2em; font-weight: bold;"></span>
        </div>
        <div style="margin: 4px; text-align: right;">
            <button type="button" id="btnCloseSaveDialog" onclick="javascript:$('#saveSuccess').dialog('close');"
                style="width: 70px;">
                <%=lbl_2_1.Text %></button>
        </div>
    </div>

    <script type="text/javascript">
        $("#btnCloseSaveDialog").button({
            icons: { primary: 'icon-btn-cancel' }
        });
        $("#btnCloseNotFoundDialog").button({
            icons: {
                primary: 'icon-btn-cancel'
            }
        });
    </script>

    <div style="display: none; overflow: hidden;" id="cfApproveDialog">
        <p>
            <span style="font-size: 1.2em; font-weight: bold;">
                <asp:Label ID="lbl_3_3" runat="server" Text="คุณต้องการอนุมัติการนับสต๊อกรายสัปดาห์ ใช่หรือไม่ ?"></asp:Label>
            </span>
        </p>
        <p style="border-top:#ccc 1px solid; text-align:right; padding-top:4px;">
                <button id="btnOkCfApprove" type="button">
                    <asp:Label ID="lbl_2_10" runat="server" Text="ตกลง"></asp:Label></button>
                <button id="btnCancelCfApprove" type="button">
                    <asp:Label ID="lbl_2_11" runat="server" Text="ยกเลิก"></asp:Label></button>
        </p>
    </div>
    <div style="display: none; overflow: hidden;" id="confirmCancelDocumentDialog">
        <p>
            <span style="font-size: 1.2em; font-weight: bold;">
                <asp:Label ID="lbl_3_4" runat="server" Text="คุณต้องการยกเลิกเอกสาร ใช่หรือไม่ ?"></asp:Label>
            </span>
        </p>
        <p style="border-top:#ccc 1px solid; text-align:right; padding-top:4px;">
                <button id="btnOkConfirmCancelDocumentDialog" type="button">
                    <asp:Label ID="lbl_2_12" runat="server" Text="ตกลง"></asp:Label></button>
                <button id="btnCancelConfirmCancelDocumentDialog" type="button">
                    <asp:Label ID="lbl_2_13" runat="server" Text="ยกเลิก"></asp:Label></button>
        </p>
    </div>
    <div style="display:none; width:auto; overflow:hidden;" id="dialog_alert">
        <p>
            <span id="dialog_alert_icon" class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>
            <span id="alert_msg" style="font-size:1.1em;"></span>
        </p>
    </div>
    <!-- autoCount dialog -->
    <div style="display:none; width:auto; overflow:hidden;" id="auto_count_dialog">
        <p>
            <span id="auto_count_dialog_icon" class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>
            <span id="auto_count_msg" style="font-size:1.1em;"><%=lbl_3_32.Text %></span>
        </p>
        <p style="border-top:#ccc 1px solid; padding-top: 4px; text-align:right;">
            <button type="button" id="btn_ok_auto_count"><%=lbl_2_12.Text %></button>
            <button type="button" id="btn_cancel_auto_count"><%=lbl_2_13.Text %></button>
        </p>
    </div>
        
        <div id="dialog_approvedocument" style="display: none; overflow: hidden; font-family: Segoe UI, Tahoma, Arial;">
            <table class="paramlist admintable" cellspacing="1" width="100%">
                <tr>
                    <td></td>
                    <td>
                        <input type="text" placeholder="รหัสพนักงาน" class="textbox" id="txtUserName" style="font-size: 16px; height: 30px; width: 100%;">
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="password" placeholder="รหัสผ่าน" class="textbox" id="txtPassword" style="font-size: 16px; height: 30px; width: 100%;">
                        <asp:HiddenField ID="hfd_action_button" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    <script type="text/javascript">
        $("#btn_ok_auto_count").button({
            icons: {
                primary: 'icon-btn-ok'
            }
        }).click(function () {
            $("#auto_count_dialog").dialog('close');

            ajaxWorking();
            $("#btnDisplayMaterial").attr('disabled', true).addClass('ui-state-disabled');
            $('#<%=ddlInv.ClientID %>').attr('disabled', true).addClass('ui-state-disabled');
                    $("#theGrid").jqGrid('setGridParam', {
                        url: 'DataXML/WeeklyStockDataXML.aspx?action=load&StaffID=' + require_var.staffId + '&langId=' + require_var.langId + '&invId=' + $('#<%=ddlInv.ClientID %> :selected').val() + '&allowCount=' + allowCount + '&autoCount=1'
                    }).trigger('reloadGrid');
        });

        $("#btn_cancel_auto_count").button({
            icons: {
                primary: 'icon-btn-cancel'
            }
        }).click(function () {
            $("#auto_count_dialog").dialog('close');
        });

        $("#btnCancelCfApprove").button({
            icons: {
                primary: 'icon-btn-cancel'
            }
        }).click(function() {
            $("#cfApproveDialog").dialog('close');
        });

        $("#btnApprove").button({
            icons: {
                primary: ' icon-action-approve'
            }
        }).click(function() {
            $("#cfApproveDialog").dialog({
            title: '<%=lbl_3_6.Text %>',
            dialogClass: 'dialogWithDropShadow noTitleStuff ',
                width: 380,
                height: 80,
                modal: true
                /*resizable: false */
            });
        }).attr('disabled', true).addClass('ui-state-disabled');

        $("#btnOkCfApprove").button({
            icons: {
                primary: 'icon-btn-ok'
            }
        }).click(function() {
            $("#cfApproveDialog").dialog('close');
            //--Approve func
            if (isDiffAmount) {
                if ($("#txtRemark").val() == "") {
                    $("#customDialog").customDialog({
                        title: 'จำนวนสต๊อกขาด-เกิน',
                        height: 80,
                        modal: true,
                        showButton: false,
                        mesg: "มีการนับสต๊อกขาด-เกิน กรุณาระบุหมายเหตุ",
                        click: function() {
                            $("#txtRemark").select();
                        }
                    });
                } else {
                    approveStock();
                }
            }
            else {
                approveStock();
            }
        });

        $("#btnOkConfirmCancelDocumentDialog").button({
            icons: {
                primary: 'icon-btn-ok'
            }
        }).click(function() {
            $("#confirmCancelDocumentDialog").dialog('close');
            // use stock count usercontrol
            cancelStockCount();
        });

        $("#btnCancelConfirmCancelDocumentDialog").button({
            icons: {
                primary: 'icon-btn-cancel'
            }
        }).click(function() {
            $("#confirmCancelDocumentDialog").dialog('close');
        });
        
        function alertDialog(callBack) {
            $("#dialog_alert_icon").removeClass('ui-icon-check').addClass('ui-icon-alert');
            $("#dialog_alert").dialog({
                dialogClass: 'dialogWithDropShadow noTitleStuff ',
                modal: true,
                width: 'inherit',
                height: 90,
                buttons: {
                    '<%=lbl_2_1.Text %>': function() {
                        $(this).dialog("close");
                        if(callBack != undefined)
                            callBack();
                    }
                }
            });
        }
    </script>

    <!-- for alert -->
    <asp:Label ID="lbl_3_2" runat="server" Text="ไม่พบข้อมูล" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_5" runat="server" Text="ประวัตินับสต๊อกรายสัปดาห์" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_6" runat="server" Text="อนุมัติการนับสต๊อกรายสัปดาห์" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_7" runat="server" Text="ยกเลิกนับสต๊อกรายสัปดาห์" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_8" runat="server" Text="กรุณาใส่จำนวน" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_9" runat="server" Text="กำลังแก้ไข" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_10" runat="server" Text="อนุมัติ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_11" runat="server" Text="ยกเลิก" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_13" runat="server" Text="บันทึกข้อมูลเรียบร้อย" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_14" runat="server" Text="บันทึกข้อมูลล้มเหลว" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_15" runat="server" Text="อนุมัติเรียบร้อย" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_16" runat="server" Text="อนุมัติล้มเหลว" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_17" runat="server" Text="การนับสต๊อกรายเดือนของคลังนี้ได้รับการอนุมัติแล้ว"
        Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_18" runat="server" Text="คุณต้องทำการยกยอดของเดือนที่แล้วก่อน จึงจะสามารถทำการนับสต๊อกของเดือนนี้ได้ เพื่อความถูกต้องของข้อมูล."
        Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_19" runat="server" Text="ยกเลิกเรียบร้อย" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_20" runat="server" Text="คำเตือน ! กรุณาบันทึกข้อมูล" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_21" runat="server" Text="วันนี้เป็นวันนับสต๊อกรายสัปดาห์" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_22" runat="server" Text="รายงาน" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_23" runat="server" Text="นับสต๊อกขาด-เกิน" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_24" runat="server" Text="นับสต๊อกแต่ละตัว" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_25" runat="server" Text="ต้องทำการปิดสิ้นวันก่อนจึงจะทำการอนุมัติการนับสต๊อกได้"
        Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_26" runat="server" Text="ต้องทำการปิดสิ้นวันก่อนจึงจะสามารถนับสต๊อกได้"
        Style="display: none;"></asp:Label>
        <asp:Label ID="lbl_3_27" runat="server" Text="วันนี้เป็นวันนับสต๊อกรายเดือน คุณไม่จำเป็นต้องนับสต๊อกรายสัปดาห์ เพื่อความถูกต้องให้ทำการนับสต๊อกรายเดือนแทน" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_28" runat="server" Text="มีวัตถุดิบที่ยังไม่ได้ทำการนับ คุณต้องใส่จำนวนนับให้ครบทุกตัวก่อน ระบบจึงจะยอมให้อนุมัติ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_29" runat="server" Text="คำเตือน" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_30" runat="server" Text="ใส่จำนวนไม่ถูกต้อง" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_31" runat="server" Text="ไม่สามารถอนุมัติเอกสารนี้ได้ เนื่องจากมีการสร้างเอกสารนับสต๊อกใหม่กว่าเอกสารนี้" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_3_32" runat="server" Text="นับสต๊อกอัตโนมัติเป็นการนับเท่ากับจำนวนคงเหลือจากระบบ คุณแน่ใจหรือไม่" Style="display:none;"></asp:Label>
    <asp:Label ID="lbl_3_33" runat="server" Text="กด refresh เมื่อมีการเปลี่ยนแปลงการตั้งค่านับสต๊อก" Style="display:none;"></asp:Label>
    <asp:Label ID="lbl_4_1" runat="server" Text="#" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_2" runat="server" Text="รหัสวัตถุดิบ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_3" runat="server" Text="ชื่อวัตถุดิบ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_4" runat="server" Text="คงเหลือ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_5" runat="server" Text="นับ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_6" runat="server" Text="ผลต่าง" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_7" runat="server" Text="หน่วย" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_8" runat="server" Text="รายการวัตถุดิบ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_9" runat="server" Text="วันที่นับสต๊อก" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_10" runat="server" Text="พนักงานนับสต๊อก" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_11" runat="server" Text="สถานะ" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_12" runat="server" Text="พนักงานอนุมัติสต๊อก" Style="display: none;"></asp:Label>
    <asp:Label ID="lbl_4_13" runat="server" Text="วันที่อนุมัติ" Style="display: none;"></asp:Label>
    </form>
</body>
</html>
