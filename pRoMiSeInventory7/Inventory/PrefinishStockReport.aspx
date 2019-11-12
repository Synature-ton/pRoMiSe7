<%@ page language="VB" autoeventwireup="false" inherits="Inventory_PrefinishStockReport, App_Web_prefinishstockreport.aspx.9758fd70" enableEventValidation="false" %>

<!DOCTYPE html>
<%@ Register TagPrefix="uc1" TagName="MenuBar" Src="~/UserControl/Menu.ascx" %>
<html>
<head id="Head1" runat="server">
    <title>Prefinish Stock Report.</title>
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

        jQuery(document).ready(function ($) {
            $("button, input:submit, a", "#xButton").button({ icons: { primary: 'icon-action-search' }, text: true })
                      .next().button({ icons: { primary: 'icon-export-xls' } });
           

        });
        
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="content">
        <div id="content-pane" class="pane-sliders">
            <div class="panel">
                <h3 id="detail-page" class="title jpane-toggler">
                    <asp:Label ID="lblHeader" runat="server" CssClass="texttitle">Prefinish By Material Report</asp:Label></div>
                </h3>
                <div class="jpane-slider">
                    <table class="paramlist admintable" cellspacing="1" width="100%">
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lblInventory" runat="server">คลัง</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="cboInventory" runat="server" Width="220px">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*"
                                    ControlToValidate="cboInventory" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lblStartDate" runat="server" Height="23px">วันที่เริ่มต้น</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="cboStartDate_Day" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="cboStartDate_Month" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="cboStartDate_Year" runat="server">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                    ControlToValidate="cboStartDate_Day" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                    ControlToValidate="cboStartDate_Month" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                                    ControlToValidate="cboStartDate_Year" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                &nbsp;
                                <asp:Label ID="lblMaterialGroup" runat="server">กลุ่มวัตถุดิบ</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="cboMaterialGroup" runat="server" Width="220px" AutoPostBack="true" >
                                </asp:DropDownList>
                            </td>
                            <td class="paramlist_key">
                                <asp:Label ID="lblEndDate" runat="server">ถึงวันที่</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="cboEndDate_Day" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="cboEndDate_Month" runat="server">
                                </asp:DropDownList>
                                <asp:DropDownList ID="cboEndDate_Year" runat="server">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                                    ControlToValidate="cboEndDate_Day" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*"
                                    ControlToValidate="cboEndDate_Month" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*"
                                    ControlToValidate="cboEndDate_Year" Display="Dynamic" InitialValue="-1" SetFocusOnError="True"
                                    ValidationGroup="v">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lblMaterialDept" runat="server">หมวดวัตถุดิบ</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="cboMaterialDept" runat="server" Width="220px">
                                </asp:DropDownList>
                            </td>
                            <td class="paramlist_key">
                                &nbsp;
                            </td>
                            <td>
                                <asp:CheckBox ID="chkDisplayByDate" runat ="server" Text="Display Prefniish Material By Date" />
                            </td>
                        </tr>
                        <tr>
                            <td class="paramlist_key">
                                <asp:Label ID="lblMaterialCode" runat="server">รหัสวัตถุดิบ</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtMaterialCode" runat="server" class="TextBox" Width="210px"></asp:TextBox>
                            </td>
                            <td class="paramlist_key">
                                &nbsp;
                            </td>
                            <td>                                
                                <div id="xButton" runat="server">
                                   <button id="btnSearch" type="button" runat="server" ValidationGroup="v">
                                        Search
                                    </button>
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