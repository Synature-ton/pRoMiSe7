<%@ page language="VB" autoeventwireup="false" inherits="DocumentSetting_DocumentTemplateSetting, App_Web_documenttemplatesetting.aspx.cd59623" maintainscrollpositiononpostback="true" theme="Classic" enableEventValidation="false" %>

<%@ Register TagPrefix="uc1" TagName="MenuBar" Src="~/UserControl/Menu.ascx" %>
<%@ Register Src="../UserControl/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Document Template Setting.</title>
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
        window.addEvent('domready', function () { new Accordion($$('.panel h3.jpane-toggler'), $$('.panel div.jpane-slider'), { onActive: function (toggler, i) { toggler.addClass('jpane-toggler-down'); toggler.removeClass('jpane-toggler'); }, onBackground: function (toggler, i) { toggler.addClass('jpane-toggler'); toggler.removeClass('jpane-toggler-down'); }, duration: 10, opacity: false, alwaysHide: true }); });

        jQuery(document).ready(function($) {
            $("button, input:submit, a", "#toolbar-button").button({ icons: { primary: 'icon-action-new' }, text: true })
                  .next().button({ icons: { primary: 'icon-action-new'} });
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




        });


    </script>

</head>
<body>
    

 <form id="form1" runat="server">
     <div id="xHeader" runat="server">
        <div id="header-box">
            <uc1:MenuBar ID="menu" runat="server" />
        </div>
    </div>
    <div id="xButton" runat="server">
        <div id="toolbar-button" >
            <div class="icon-mod-preparedoc" style="float: left; width: 32px; height: 32px; margin-right: 4px;">
            </div>
            <div class="toolbar-title">
                <asp:Label ID="lblHeader" runat="server" CssClass="texttitle">Document Template Setting</asp:Label>
            </div>
            <button id="cmdNewTemplateType" type="button" runat="server">New Template Type</button>
        </div>
    </div>
    
    <div id="content">
        <div id="responseText" runat="server" style="padding: 1px; margin-top: 5px;">
            <table style="width: 100%;">
                <tr>
                    <td style="width: 5%;"></td>
                    <td style="width: 80%;">
                        <table class="blue" cellspacing="1">
                            <thead>
                                <tr>
                                    <th nowrap="nowrap" style="width: 2%; height: 25px;"></th>
                                    <th nowrap="nowrap" style="width: 40%;"><asp:Label ID="lblDocumentType" runat="server" Text="Document Type"></asp:Label></th>
                                    <th nowrap="nowrap"><asp:Label ID="lblMaxCode" runat="server" Text="Max Lenght for Code"></asp:Label></th>
                                    <th nowrap="nowrap" style="width: 10%;"><asp:Label ID="lblEdit" runat="server" Text="Edit"></asp:Label></th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Label ID="trDetail" runat="server"></asp:Label>
                            </tbody>
                        </table>                    
                    </td>
                    <td></td>
                </tr>     
                </table>
        <div style="text-align: center; padding: 10px; margin-bottom: 15px;">
            <asp:Label ID="msgResponse" runat="server" Style="font-size: 20px; font-weight: bold;
                color: Red; font-family: Tahoma;"></asp:Label>
        </div>
    </div>
    <div id="footer-box">
        <uc2:Footer ID="Footer1" runat="server" />
    </div>

    </form>
</body>
</html>
