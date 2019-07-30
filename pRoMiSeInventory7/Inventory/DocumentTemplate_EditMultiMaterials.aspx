<%@ page language="VB" autoeventwireup="false" inherits="Inventory_DocumentTemplate_EditMultiMaterials, App_Web_documenttemplate_editmultimaterials.aspx.9758fd70" enableEventValidation="false" %>

<html>
<head runat="server">
    <title>Search Materials.</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
    <link href="../css/modal.css" rel="stylesheet" type="text/css" />
    <link href="../css/page.css" rel="stylesheet" type="text/css" />
    <link href="../css/rounded.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/jquery.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

    <script src="../Scripts/modal.js" type="text/javascript"></script>
<script language="javascript">
        window.onload = function() {
            window.moveTo(0, 0);
            window.resizeTo(screen.availWidth, screen.availHeight);
        }  
    </script>
    <script type="text/javascript">

        jQuery(document).ready(function($) {
             
            $('.txtMV').click(function() {
                $(this).select();
            });

            $(function() {
                $(".txtMV").keypress(function(evt) {
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
            $.extend({
                getUrlVars: function() {
                    var vars = [], hash;
                    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                    for (var i = 0; i < hashes.length; i++) {
                        hash = hashes[i].split('=');
                        vars.push(hash[0]);
                        vars[hash[0]] = hash[1];
                    }
                    return vars;
                },
                getUrlVar: function(name) {
                    return $.getUrlVars()[name];
                }
            });
            $('.txtMV').keyup(function(e) {
                if (e.keyCode == 13) { 
                    var nxtIdx = $('input:text').index(this) + 1;
                    $(":input:text:eq(" + nxtIdx + ")").focus();
                }
            });
            $('.txtMV').focusout(function (e) {
                var i, strTemp;
                i = $('input:text').index(this);
                    // Compare Recv UpTo (For Compare Form)
                if ($("#hdf_RecvUpTo_" + i).length > 0 && $("#hdf_RecvUpTo_" + i).val() != '') {
                    $("#btnDoload").attr("disabled", "");
                    $("#msgResponse").innerHTML = "";

                    document.getElementById('msgResponse').innerHTML = "";

                    // Check For All Data In array of TextBox is Recev More than RecvUpTo
                    var totalRecord;
                    if ($("#hdfTotalrecord").val() != '') {
                        totalRecord = parseInt($("#hdfTotalrecord").val());
                    }
                    else {
                        totalRecord = 0;
                    }
                    for (var i = 0; i <= totalRecord - 1; i++) {
                        var dclRecv = parseFloat($("#txt_1_" + i).val(), 10);
                        var dclUpTo = parseFloat($("#hdf_RecvUpTo_" + i).val(), 10);

                        if (dclRecv > dclUpTo) {
                            $("#btnDoload").attr("disabled", "disabled");

                            strTemp = '<%=lblMsgRecvUpTo.Text%>';
                            document.getElementById('msgResponse').innerHTML = strTemp;
                            //$("#txt_1_" + i).css({ 'background-color': 'red' });
                            $("#txt_1_" + i).css({ 'color': 'red' });
                        }
                        else {
                            $("#txt_1_" + i).css({ 'color': '' });
                        }
                    }
                }
             });
        });
 
        function AlertForRecvAmountUpTo(amountName) {
            document.getElementById("" + amountName + "").focus();
            strTemp = '<%=lblMsgRecvUpTo.Text%>' + '   ';
            alert(strTemp);
        }

        function ExampleForAlertRecvUpToWhenLostFocus (e) {
            var i, strTemp;
            i = $('input:text').index(this);
            // Compare Recv UpTo (For Compare Form)
            if ($("#hdf_RecvUpTo_" + i).length > 0 && $("#hdf_RecvUpTo_" + i).val() != '') {
                var dclRecv = parseFloat($(this).val(), 10);
                var dclUpTo = parseFloat($("#hdf_RecvUpTo_" + i).val(), 10);
                if (dclRecv > dclUpTo) {
                    $("#btnDoload").attr("disabled", "disabled");

                    $("#txt_1_" + i).css({ 'background-color': 'red' });

                    strTemp = '<%=lblMsgRecvUpTo.Text%>';
                    alert(strTemp);
                    $("#txt_1_" + i).focus();
                    return;
                }
                else {
                    $("#btnDoload").attr("disabled", "");
                    $("#txt_1_" + i).css({ 'background-color': '' });
                    $("#msgResponse").Text = '';
                    
                    // Check For All Data In array of TextBox is Recev More than RecvUpTo
                    var totalRecord;
                    if ($("#hdfTotalrecord").val() != '') {
                        totalRecord = parseInt($("#hdfTotalrecord").val());
                    }
                    else {
                        totalRecord = 0;
                    }
                    for (var i = 0; i <= totalRecord - 1; i++) {
                        var dclRecv = parseFloat($("#txt_1_" + i).val(), 10);
                        var dclUpTo = parseFloat($("#hdf_RecvUpTo_" + i).val(), 10);

                        if (dclRecv > dclUpTo) {
                            $("#btnDoload").attr("disabled", "disabled");
                            break;
                        }
                    }
                }
                }
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="content">
        <div>
            <span id="responseText" runat="server"></span>
        </div>
        <div style="display: none;">
            <asp:Label ID="lblMaterialCode" runat="server">Material Code</asp:Label>
            <asp:Label ID="lblMaterialName" runat="server">Material Name</asp:Label>
            <asp:Label ID="lblAmount" runat="server">Qty.</asp:Label>
            <asp:Label ID="lblPricePerUnit" runat="server">Price/Unit</asp:Label>
            <asp:Label ID="lblDiscount" runat="server">Discount</asp:Label>
            <asp:Label ID="lblDiscountAmount" runat="server">Baht</asp:Label>
            <asp:Label ID="lblDiscountPercent" runat="server">%</asp:Label>
            <asp:Label ID="lblUnitName" runat="server">Unit Name</asp:Label>
            <asp:Label ID="lblVAT" runat="server">VAT</asp:Label>
            <asp:Label ID="lblMaterialSupplier" runat="server">Material Supplier</asp:Label>
            <asp:Label ID="lblStock" runat="server">Stock</asp:Label>
            <asp:Label ID="lblSuccess" runat="server">Succussfuly.</asp:Label>
            <asp:Label ID="lblError" runat="server">Error</asp:Label>
            <asp:Label ID="lblMsgRecvUpTo" runat="server">Error</asp:Label>
        </div>
        <div id="condition" runat="server">
            <table class="paramlist admintable" cellspacing="1" width="100%">
                <tr>
                    <td align="center">
                        <asp:CheckBox ID="chkRemoveZeroAmount" Checked="true" Text="Auto Remove Zero Amount" runat="server" />
                    </td>
                </tr>               
                <tr>
                    <td align="center">                        
                        <button id="btnDoload" type="button" runat="server" style="width: 70px;">
                            OK
                        </button>
                        <button id="btnCancel" type="button" runat="server" style="width: 70px;">
                            Cancel
                        </button>
                         <button id="btnClose" type="button" runat="server" style="width: 70px;" onclick="javascript:window.close();">
                            Close
                        </button>
                        <asp:HiddenField ID="hdfDocumentID" runat="server" />
                        <asp:HiddenField ID="hdfDocumentShopID" runat="server" />
                        <asp:HiddenField ID="hdfTemplateDocumentID" runat="server" />
                        <asp:HiddenField ID="hdfTemplateDocumentShopID" runat="server" />
                        <asp:HiddenField ID="hdfIndexList" runat="server" />
                        <asp:HiddenField ID="hdfTotalrecord" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
        <div style="text-align: center; padding: 10px; margin-bottom: 15px;">
            <asp:Label ID="msgResponse" runat="server" Style="font-size: 16px; font-weight: bold;
                color: Red; font-family: Tahoma;"></asp:Label>
        </div>
    </div>
    </form>
</body>
</html>
