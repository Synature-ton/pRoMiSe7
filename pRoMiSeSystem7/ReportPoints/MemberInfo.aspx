<%@ page language="C#" autoeventwireup="true" inherits="ReportPoints_MemberInfo, App_Web_memberinfo.aspx.21ba1aa2" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Member Info</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <script src="../StyleSheet/DateDropdownJScript.js"></script>
    <style type="text/css">
        label.lastUpdate::selection {
            background-color: transparent;
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
            width: 100%;
            border-collapse: collapse;
        }

            table.report th {
                border: solid 1px #999;
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
                background: #fff;
            }

                table.report tbody td.sumdept {
                    background: #ebebeb;
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
    <link href="../javascript/JQueryUI/1.11.4/jquery-ui.css" rel="Stylesheet" type="text/css" />
    <script src="../javascript/JQuery/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="../javascript/JQueryUI/1.11.4/jquery-ui.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function SelectView(view) {
            if (view == "point") {
                document.getElementById("result1HTML").style.display = "";
                document.getElementById("result2HTML").style.display = "none";
            }
            else if (view == "redeem") {
                document.getElementById("result1HTML").style.display = "none";
                document.getElementById("result2HTML").style.display = "";
            }
        }

        $(function () {
            $(document).ready(function () {
                //Code to set the datepicker's date again after post back 
                if (!($("[id$=alt_StartDate]").attr("Value") == undefined)) {
                    if ($("[id$=alt_StartDate]").attr("Value").length > 0) {
                        $("[id$=tbStartDate]").datepicker("setDate", new Date($("[id$=alt_StartDate]").attr("Value")));
                    }
                }
                if (!($("[id$=alt_EndDate]").attr("Value") == undefined)) {
                    if ($("[id$=alt_EndDate]").attr("Value").length > 0) {
                        $("[id$=tbEndDate]").datepicker("setDate", new Date($("[id$=alt_EndDate]").attr("Value")));
                    }
                }
            });
            $("[id$=imgHelp_Date]").tooltip({
                track: true,
                open: function (event, ui) {
                    ui.tooltip.css("max-width", "500px");
                    ui.tooltip.css("font-size", "1em");
                },
                content: '<h3>Keyboard interaction</h3><p>While the datepicker is open, the following key commands are available:</p><ul><li><code>PAGE UP</code>: Move to the previous month.</li><li><code>PAGE DOWN</code>: Move to the next month.</li><li><code>CTRL</code> + <code>HOME</code>: Open the datepicker if closed.</li><li><code>CTRL</code>/<code>COMMAND</code> + <code>HOME</code>: Move to the current month.</li><li><code>CTRL</code>/<code>COMMAND</code> + <code>LEFT</code>: Move to the previous day.</li><li><code>CTRL</code>/<code>COMMAND</code> + <code>RIGHT</code>: Move to the next day.</li><li><code>CTRL</code>/<code>COMMAND</code> + <code>UP</code>: Move to the previous week.</li><li><code>CTRL</code>/<code>COMMAND</code> + <code>DOWN</code>: Move the next week.</li><li><code>CTRL</code>/<code>COMMAND</code> + <code>END</code>: Close the datepicker and erase the date.</li><li><code>ENTER</code>: Select the focused date.</li><li><code>ESCAPE</code>: Close the datepicker without selection.</li></ul>'
            });
            $("[id$=tbStartDate]").datepicker({
                dateFormat: "dd MM yy",
                yearRange: "c-20:c+0",
                inline: true,
                showAnim: 'fadeIn',
                changeMonth: true,
                changeYear: true,
                showOn: 'button',
                buttonImageOnly: true,
                buttonImage: '../images/Calendar_scheduleHS.png',
                altField: '[id$=alt_StartDate]',
                altFormat: 'yy-mm-dd'
            });
            $("[id$=tbEndDate]").datepicker({
                dateFormat: "dd MM yy",
                yearRange: "c-20:c+0",
                inline: true,
                showAnim: 'fadeIn',
                changeMonth: true,
                changeYear: true,
                showOn: 'button',
                buttonImageOnly: true,
                buttonImage: '../images/Calendar_scheduleHS.png',
                altField: '[id$=alt_EndDate]',
                altFormat: 'yy-mm-dd'
            });
        });

    </script>
</head>
<body>

    <form id="form1" runat="server">
        <div>
            <table bgcolor="White" cellpadding="0" cellspacing="0">
                <tr style="background-color: #EEEEEE">
                    <td height="35" style="background-image: url('../images/headerstub.jpg')">&nbsp; &nbsp;
                    </td>
                    <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                        <span class="headerText"></span>
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
                    <td height="10" colspan="3">&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;
                    </td>
                    <td>

                        <asp:Label ID="lbMessageError" runat="server"></asp:Label>
                        <asp:Label ID="lbMessageErrorHistory" runat="server"></asp:Label>

                        <br />



                        <fieldset style="margin: 20px auto; margin-bottom: 0px; padding: 0px; padding-bottom: 20px;">
                            <center>
                    <table style="width:600px; flex-align:center;">
                        <tr style="text-align:center;">
                            <th colspan="4">&nbsp;<br /><asp:Label ID="lbHeader" runat="server" Font-Size="Large" Text="Label"></asp:Label><br />&nbsp;</th>
                        </tr>
                        <tr style="vertical-align:top;">
                            <td style="text-align:right; width:25%;"><asp:Label ID="lbMemberInfoHead0" runat="server" Text=""></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                            <td style="width:25%;"><asp:Label ID="lbMemberInfoData0" runat="server" Text=""></asp:Label></td>
                            <td style="text-align:right; width:20%;"><asp:Label ID="lbMemberInfoHead1" runat="server" Text=""></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                            <td style="width:30%;"><asp:Label ID="lbMemberInfoData1" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr style="vertical-align:top;">
                            <td style="text-align:right"><asp:Label ID="lbMemberInfoHead2" runat="server" Text=""></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                            <td><asp:Label ID="lbMemberInfoData2" runat="server" Text=""></asp:Label></td>
                            <td style="text-align:right"><asp:Label ID="lbMemberInfoHead3" runat="server" Text=""></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                            <td><asp:Label ID="lbMemberInfoData3" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr style="vertical-align:top;">
                            <td style="text-align:right"><asp:Label ID="lbMemberInfoHead4" runat="server" Text=""></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                            <td><asp:Label ID="lbMemberInfoData4" runat="server" Text=""></asp:Label></td>
                            <td style="text-align:right"><asp:Label ID="lbMemberInfoHead5" runat="server" Text=""></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                            <td><asp:Label ID="lbMemberInfoData5" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr style="vertical-align:top;">
                            <td style="text-align:right"><asp:Label ID="lbMemberInfoHead6" runat="server" Text=""></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                            <td><asp:Label ID="lbMemberInfoData6" runat="server" Text=""></asp:Label></td>
                            <td style="text-align:right"><asp:Label ID="lbMemberInfoHead7" runat="server" Text=""></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                            <td><asp:Label ID="lbMemberInfoData7" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr style="vertical-align:top;">
                            <td style="text-align:right"><asp:Label ID="lbMemberInfoHead8" runat="server" Text=""></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                            <td><asp:Label ID="lbMemberInfoData8" runat="server" Text=""></asp:Label></td>
                            <td style="text-align:right"><asp:Label ID="lbMemberInfoHead9" runat="server" Text=""></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                            <td><asp:Label ID="lbMemberInfoData9" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr style="vertical-align:top;">
                            <td style="text-align:right"><asp:Label ID="lbMemberInfoHead10" runat="server" Text=""></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                            <td colspan="3"><asp:Label ID="lbMemberInfoData10" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr style="vertical-align:top;">
                            <td style="text-align:right"><asp:Label ID="lbMemberInfoHead11" runat="server" Text=""></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                            <td><asp:Label ID="lbMemberInfoData11" runat="server" Text=""></asp:Label></td>
                            <td style="text-align:right"><asp:Label ID="lbMemberInfoHead12" runat="server" Text=""></asp:Label>&nbsp;&nbsp;:&nbsp;</td>
                            <td><asp:Label ID="lbMemberInfoData12" runat="server" Text=""></asp:Label></td>
                        </tr>

                    </table>
                            </center>
                        </fieldset>

                        <center>
                    <table style="width:600px;">
                        <tr style="vertical-align:top;">
                            <td style="text-align:right; width:20%;">
                                <asp:Label ID="lbSearchHead0" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td style="width:80%;">
                                <asp:TextBox ID="tbStartDate" runat="server" ReadOnly="true" Width="133"></asp:TextBox>
                                <label id="lbHeader_EndDate" runat="server"></label>
                                <asp:TextBox ID="tbEndDate" runat="server" ReadOnly="true" Width="133"></asp:TextBox>
                                &nbsp;<img id="imgHelp_Date" runat="server" src="../images/help.jpg" title="" />
                                <asp:HiddenField ID="alt_StartDate" runat="server" Value="" />
                                <asp:HiddenField ID="alt_EndDate" runat="server" Value="" />
                                <asp:Button ID="btnSearch0" runat="server" Text="Button" OnClick="btnSearch0_Click"></asp:Button>
                            </td>
                        </tr>
                        <tr style="vertical-align:top;">
                            <td style="text-align:right; width:20%;">
                                <asp:Label ID="lbSearchHead2" runat="server" Text="Label"></asp:Label>
                            </td>
                            <td style="width:80%;">
                                <asp:Label ID="lbPointAtdate" runat="server" Text="0.00"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    </center>

                        <span id="result1HTML" runat="server"></span>

                    </td>
                    <td>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="3" height="30">
                        <table style="width: 100%;">
                            <tr>
                                <td style="text-align: right;">
                                    <label id="lbLastUpdate" runat="server" style="text-align: right; font-size: 0.8em; color: #b9b9b9;" class="lastUpdate">Last Update : </label>
                                    <%--<asp:Label id="lbLastUpdate" runat="server" CssClass="lastUpdate" ForeColor="#b9b9b9" Text=""></asp:Label>--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="background-color: #999999; height: 1px;"></td>
                </tr>
                <tr>
                    <td height="50" colspan="3" style="background-image: url('../images/footerbg2000.gif')">&nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="background-color: #999999; height: 1px;"></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
