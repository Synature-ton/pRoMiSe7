<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Promotion_Price_Edit.aspx.vb"
    Inherits="POSPromotionSettings.Promotion_Price_Edit" %>

<html>
<head id="Head1" runat="server">
    <title>Promotion Setting</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />

    <script language="JavaScript" src="../StyleSheet/webscript.js"></script>

    <style type="text/css">
        .auto-style1 {
            height: 1px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <table bgcolor="White" cellpadding="0" cellspacing="0">
        <tr style="background-color: #EEEEEE">
            <td height="35" style="background-image: url('../images/headerstub.jpg')">
                &nbsp; &nbsp;
            </td>
            <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                <div>
                    <asp:Label ID="lh" runat="server" Text="Promotion Setting" CssClass="headerText"></asp:Label></div>
            </td>
            <td rowspan="99" style="background-color: #003366; width: 1px;">
                <img src="../images/clear.gif" height="1px" width="1px">
            </td>
        </tr>
        <tr style="background-color: #666666">
            <td width="3%" class="auto-style1">
            </td>
            <td width="94%" class="auto-style1">
            </td>
            <td width="3%" class="auto-style1">
            </td>
        </tr>
        <tr>
            <td height="10" colspan="3">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <table style="width: 100%;">
                    <tr class="text">
                        <td width="200px" align="right">
                            <asp:Label ID="lb0" runat="server" Text="Promotion" class="redText"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPromoName" runat="server" Width="400px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                ValidationGroup="p" ControlToValidate="txtPromoName"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                  <tr class="text">
                        <td width="200px" align="right">
                            <asp:Label ID="lblPromotionCode" runat="server" Text="Promo Code"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPromotionCode" runat="server" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="lb1" runat="server" Text="From Date" class="redText"></asp:Label>
                        </td>
                        <td>
                            <div id="date_startdate" runat="server" style="float: left;">
                            </div>
                            <span id="validate_startdate" runat="server" class="redText"></span>
                        </td>
                    </tr>
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="lb2" runat="server" Text="To Date"></asp:Label>
                        </td>
                        <td>
                            <div id="date_enddate" runat="server" style="float: left;">
                            </div>
                        </td>
                    </tr>
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="lb3" runat="server" Text="Start Time"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlHourFromTime" runat="server">
                                <asp:ListItem Value="">--HH--</asp:ListItem>
                                <asp:ListItem Value="0">00</asp:ListItem>
                                <asp:ListItem Value="1">01</asp:ListItem>
                                <asp:ListItem Value="2">02</asp:ListItem>
                                <asp:ListItem Value="3">03</asp:ListItem>
                                <asp:ListItem Value="4">04</asp:ListItem>
                                <asp:ListItem Value="5">05</asp:ListItem>
                                <asp:ListItem Value="6">06</asp:ListItem>
                                <asp:ListItem Value="7">07</asp:ListItem>
                                <asp:ListItem Value="8">08</asp:ListItem>
                                <asp:ListItem Value="9">09</asp:ListItem>
                                <asp:ListItem Value="10">10</asp:ListItem>
                                <asp:ListItem Value="11">11</asp:ListItem>
                                <asp:ListItem Value="12">12</asp:ListItem>
                                <asp:ListItem Value="13">13</asp:ListItem>
                                <asp:ListItem Value="14">14</asp:ListItem>
                                <asp:ListItem Value="15">15</asp:ListItem>
                                <asp:ListItem Value="16">16</asp:ListItem>
                                <asp:ListItem Value="17">17</asp:ListItem>
                                <asp:ListItem Value="18">18</asp:ListItem>
                                <asp:ListItem Value="19">19</asp:ListItem>
                                <asp:ListItem Value="20">20</asp:ListItem>
                                <asp:ListItem Value="21">21</asp:ListItem>
                                <asp:ListItem Value="22">22</asp:ListItem>
                                <asp:ListItem Value="23">23</asp:ListItem>
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlMinuteFromTime" runat="server">
                                <asp:ListItem Value="">--mm--</asp:ListItem>
                                <asp:ListItem Value="0">:00</asp:ListItem>
                                <asp:ListItem Value="5">:05</asp:ListItem>
                                <asp:ListItem Value="10">:10</asp:ListItem>
                                <asp:ListItem Value="15">:15</asp:ListItem>
                                <asp:ListItem Value="20">:20</asp:ListItem>
                                <asp:ListItem Value="25">:25</asp:ListItem>
                                <asp:ListItem Value="30">:30</asp:ListItem>
                                <asp:ListItem Value="35">:35</asp:ListItem>
                                <asp:ListItem Value="40">:40</asp:ListItem>
                                <asp:ListItem Value="45">:45</asp:ListItem>
                                <asp:ListItem Value="50">:50</asp:ListItem>
                                <asp:ListItem Value="55">:55</asp:ListItem>
                            </asp:DropDownList>
                            <span id="validFormTime" runat="server" class="redText"></span>
                        </td>
                    </tr>
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="lb4" runat="server" Text="End Time"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlHourToTime" runat="server">
                                <asp:ListItem Value="">--HH--</asp:ListItem>
                                <asp:ListItem Value="0">00</asp:ListItem>
                                <asp:ListItem Value="1">01</asp:ListItem>
                                <asp:ListItem Value="2">02</asp:ListItem>
                                <asp:ListItem Value="3">03</asp:ListItem>
                                <asp:ListItem Value="4">04</asp:ListItem>
                                <asp:ListItem Value="5">05</asp:ListItem>
                                <asp:ListItem Value="6">06</asp:ListItem>
                                <asp:ListItem Value="7">07</asp:ListItem>
                                <asp:ListItem Value="8">08</asp:ListItem>
                                <asp:ListItem Value="9">09</asp:ListItem>
                                <asp:ListItem Value="10">10</asp:ListItem>
                                <asp:ListItem Value="11">11</asp:ListItem>
                                <asp:ListItem Value="12">12</asp:ListItem>
                                <asp:ListItem Value="13">13</asp:ListItem>
                                <asp:ListItem Value="14">14</asp:ListItem>
                                <asp:ListItem Value="15">15</asp:ListItem>
                                <asp:ListItem Value="16">16</asp:ListItem>
                                <asp:ListItem Value="17">17</asp:ListItem>
                                <asp:ListItem Value="18">18</asp:ListItem>
                                <asp:ListItem Value="19">19</asp:ListItem>
                                <asp:ListItem Value="20">20</asp:ListItem>
                                <asp:ListItem Value="21">21</asp:ListItem>
                                <asp:ListItem Value="22">22</asp:ListItem>
                                <asp:ListItem Value="23">23</asp:ListItem>
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlMinuteToTime" runat="server">
                                <asp:ListItem Value="">--mm--</asp:ListItem>
                                <asp:ListItem Value="0">:00</asp:ListItem>
                                <asp:ListItem Value="5">:05</asp:ListItem>
                                <asp:ListItem Value="10">:10</asp:ListItem>
                                <asp:ListItem Value="15">:15</asp:ListItem>
                                <asp:ListItem Value="20">:20</asp:ListItem>
                                <asp:ListItem Value="25">:25</asp:ListItem>
                                <asp:ListItem Value="30">:30</asp:ListItem>
                                <asp:ListItem Value="35">:35</asp:ListItem>
                                <asp:ListItem Value="40">:40</asp:ListItem>
                                <asp:ListItem Value="45">:45</asp:ListItem>
                                <asp:ListItem Value="50">:50</asp:ListItem>
                                <asp:ListItem Value="55">:55</asp:ListItem>
                            </asp:DropDownList>
                            <span id="validToTime" runat="server" class="redText"></span>
                        </td>
                    </tr>
                    <tr class="text">
                        <td align="right" valign="top">
                            <asp:Label ID="lb5" runat="server" Text="Conditions around the time."></asp:Label>
                        </td>
                        <td>
                            <div style="border: solid 1px rgb(236, 233,216);">
                                <asp:RadioButton ID="WeeklyOption" runat="server" Text="Week" GroupName="ConditionTime" />
                                <div style="border-bottom: solid 1px rgb(236, 233,216);">
                                    <asp:CheckBoxList ID="ckWeekly" runat="server" RepeatDirection="Horizontal" CssClass="text">
                                        <asp:ListItem Value="1">Sunday</asp:ListItem>
                                        <asp:ListItem Value="2">Monday</asp:ListItem>
                                        <asp:ListItem Value="3">Tuesday</asp:ListItem>
                                        <asp:ListItem Value="4">Wednesday</asp:ListItem>
                                        <asp:ListItem Value="5">Thursday</asp:ListItem>
                                        <asp:ListItem Value="6">Friday</asp:ListItem>
                                        <asp:ListItem Value="7">Saturday</asp:ListItem>
                                    </asp:CheckBoxList>
                                </div>
                                <asp:RadioButton ID="MonthOption" runat="server" Text="Month" GroupName="ConditionTime" />
                                <div style="border-bottom: solid 1px rgb(236, 233,216);">
                                    <asp:CheckBoxList ID="ckMonthly" runat="server" RepeatColumns="10" RepeatDirection="Horizontal"
                                        CssClass="text">
                                        <asp:ListItem Value="1">1</asp:ListItem>
                                        <asp:ListItem Value="2">2</asp:ListItem>
                                        <asp:ListItem Value="3">3</asp:ListItem>
                                        <asp:ListItem Value="4">4</asp:ListItem>
                                        <asp:ListItem Value="5">5</asp:ListItem>
                                        <asp:ListItem Value="6">6</asp:ListItem>
                                        <asp:ListItem Value="7">7</asp:ListItem>
                                        <asp:ListItem Value="8">8</asp:ListItem>
                                        <asp:ListItem Value="9">9</asp:ListItem>
                                        <asp:ListItem Value="10">10</asp:ListItem>
                                        <asp:ListItem Value="11">11</asp:ListItem>
                                        <asp:ListItem Value="12">12</asp:ListItem>
                                        <asp:ListItem Value="13">13</asp:ListItem>
                                        <asp:ListItem Value="14">14</asp:ListItem>
                                        <asp:ListItem Value="15">15</asp:ListItem>
                                        <asp:ListItem Value="16">16</asp:ListItem>
                                        <asp:ListItem Value="17">17</asp:ListItem>
                                        <asp:ListItem Value="18">18</asp:ListItem>
                                        <asp:ListItem Value="19">19</asp:ListItem>
                                        <asp:ListItem Value="20">20</asp:ListItem>
                                        <asp:ListItem Value="21">21</asp:ListItem>
                                        <asp:ListItem Value="22">22</asp:ListItem>
                                        <asp:ListItem Value="23">23</asp:ListItem>
                                        <asp:ListItem Value="24">24</asp:ListItem>
                                        <asp:ListItem Value="25">25</asp:ListItem>
                                        <asp:ListItem Value="26">26</asp:ListItem>
                                        <asp:ListItem Value="27">27</asp:ListItem>
                                        <asp:ListItem Value="28">28</asp:ListItem>
                                        <asp:ListItem Value="29">29</asp:ListItem>
                                        <asp:ListItem Value="30">30</asp:ListItem>
                                        <asp:ListItem Value="31">31</asp:ListItem>
                                    </asp:CheckBoxList>
                                </div>
                                <asp:RadioButton ID="NoneOption" runat="server" Text="Do not specify time." GroupName="ConditionTime" />
                            </div>
                        </td>
                    </tr>
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="lb6" runat="server" Text="Used with other promotions."></asp:Label>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="RdoAllowOtherPromo" runat="server" RepeatDirection="Horizontal"
                                CssClass="text">
                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                <asp:ListItem Value="0">No</asp:ListItem>
                                <asp:ListItem Value="2" Selected="True">Yes (one item one promotion)</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="lb7" runat="server" Text="Allow Multiple Voucher"></asp:Label>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="RdoAllowOtherPromoSameLV" runat="server" RepeatDirection="Horizontal"
                                CssClass="text">
                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                <asp:ListItem Value="0">No</asp:ListItem>
                                <asp:ListItem Selected="True" Value="2">Yes (one item one promotion)</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="lb8" runat="server" Text="Enable"></asp:Label>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="RdoActivated" runat="server" RepeatDirection="Horizontal"
                                CssClass="text">
                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                <asp:ListItem Value="0" Selected="True">No.</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="LbNoPrintReceiptCopy" runat="server" Text="PrintReceiptCopy"></asp:Label>
                        </td>
                        <td>
                            &nbsp;<asp:TextBox ID="txtPrintReceiptCopy" runat="server" Width="50px">0</asp:TextBox></td>
                    </tr>
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="LbPrintSignatureInReceipt" runat="server" Text="PrintSignatureInReceipt"></asp:Label>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="RdoPrintSignatureInReceipt" runat="server" 
                                RepeatDirection="Horizontal">
                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                <asp:ListItem Value="0">No</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>                    
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="lblExemptVAT" runat="server" Text="Is SCD Discount (Exempt VAT)"></asp:Label>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="rdoExemptVAT" runat="server" 
                                RepeatDirection="Horizontal">
                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                <asp:ListItem Value="0">No</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr id="rManualSelectPromotion" class="text" runat="server" >
                        <td align="right">
                            <asp:Label ID="lblManualSelectPromotion" runat="server" Text="Is Manaul Select Promotion"></asp:Label>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="rdoManualSelectPromotion" runat="server" 
                                RepeatDirection="Horizontal">
                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                <asp:ListItem Value="0">No</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="lb9" runat="server" Text="Promotion Type"></asp:Label>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="RdoAmountType" runat="server" RepeatDirection="Horizontal"
                                CssClass="text">
                                <asp:ListItem Value="0" Selected="True">Normal</asp:ListItem>
                                <asp:ListItem Value="3">Level</asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:HiddenField ID="promoAmountType" runat="server" />
                        </td>
                    </tr>
                      <tr class="text">
                        <td align="right">
                            <asp:Label ID="lblPromoDescription" runat="server" Text="Description"></asp:Label>
                        </td>
                        <td>
                            &nbsp;<asp:TextBox ID="txtPromoDescription" runat="server" Height="99px" TextMode="MultiLine" Width="600px" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="text">
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Button ID="btSavePromo" runat="server" Text="Next" ValidationGroup="p" />
                            <asp:Button ID="btEditPromo" runat="server" Text="Next" Visible="False" ValidationGroup="p" />
                            <asp:Button ID="btCancel" runat="server" Text="Cancel" Height="26px" />
                        </td>
                    </tr>
                    <tr class="text">
                        <td>
                            &nbsp;
                        </td>
                        <td>
                           <span id="ErrorText" runat="server"></span>
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" height="30">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #999999; height: 1px;">
            </td>
        </tr>
        <tr>
            <td height="50" colspan="3" style="background-image: url('../images/footerbg2000.gif')">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #999999; height: 1px;">
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
