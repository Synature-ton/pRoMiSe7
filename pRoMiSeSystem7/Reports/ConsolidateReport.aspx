<%@ page language="C#" autoeventwireup="true" inherits="Reports_ConsolidateReport, App_Web_consolidatereport.aspx.dfa151d5" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        label.lastUpdate::selection{
            background-color:transparent;
        }
        /*a.print {
            color: #0B55C4;
            color: #000000;
            
        }*/
        /*a.printCSS:enabled{
            color: #0B55C4;
        }
        a.printCSS:enabled:hover {
                color: #BAC40B;
                cursor: pointer;
            }
        a.printCSS:disabled{
            color: #000000;
        }
            a.printCSS:disabled:hover{
                color: #BAC40B;
                cursor: crosshair;
            }
        .printHover {
            cursor: pointer;
        }*/
            
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

        div.ui-tooltip {
            width: 600px;
        }
    </style>
    <link href="../javascript/JQueryUI/1.11.4/jquery-ui.css" rel="Stylesheet" type="text/css" />
    <script src="../javascript/JQuery/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="../javascript/JQueryUI/1.11.4/jquery-ui.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function LinkBtnMouseOut(element)
        {
            if (document.getElementById("alt_isHaveData").value == "0") {
                element.style.color = "black";
            }
            else {
                element.style.color = "#0B55C4";
            }
            element.style.textDecoration = 'none';
            element.style.cursor = 'default';
        }
        function LinkBtnMouseOver(element)
        {
            element.style.color = "#BAC40B";
            element.style.textDecoration = 'underline';
            if (document.getElementById("alt_isHaveData").value == "1") {
                element.style.cursor = 'pointer';
            }
            else {
                element.style.cursor = 'auto';
            }
        }
        function AddWasteType() {
            document.getElementById("dialogadd").style.visibility = (document.getElementById("dialogadd").style.visibility == "visible") ? "hidden" : "visible";
        }
        function PrintDivContent(divId) {
            var printContent = document.getElementById(divId);
            var WinPrint = window.open('', '', 'left=0,top=0,toolbar=0,sta­tus=0');
            WinPrint.document.write(printContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
        }
        function DeleteConfirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value_delete";
            if (confirm("You want to delete data?"))
                confirm_value.value = "Yes";
            else
                confirm_value.value = "No";
            document.forms[0].appendChild(confirm_value);
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
            $(document).tooltip({
                track: true,
                open: function (event, ui) {
                    ui.tooltip.css("max-width", "500px");
                    ui.tooltip.css("font-size", "1em");
                },
                content: '<h3>Keyboard interaction</h3><p>While the datepicker is open, the following key commands are available:</p><ul><li><code>PAGE UP</code>: Move to the previous month.</li><li><code>PAGE DOWN</code>: Move to the next month.</li><li><code>CTRL</code> + <code>HOME</code>: Open the datepicker if closed.</li><li><code>CTRL</code>/<code>COMMAND</code> + <code>HOME</code>: Move to the current month.</li><li><code>CTRL</code>/<code>COMMAND</code> + <code>LEFT</code>: Move to the previous day.</li><li><code>CTRL</code>/<code>COMMAND</code> + <code>RIGHT</code>: Move to the next day.</li><li><code>CTRL</code>/<code>COMMAND</code> + <code>UP</code>: Move to the previous week.</li><li><code>CTRL</code>/<code>COMMAND</code> + <code>DOWN</code>: Move the next week.</li><li><code>CTRL</code>/<code>COMMAND</code> + <code>END</code>: Close the datepicker and erase the date.</li><li><code>ENTER</code>: Select the focused date.</li><li><code>ESCAPE</code>: Close the datepicker without selection.</li></ul>'
            });
            $("[id$=tbStartDate]").datepicker({
                dateFormat: "dd MM yy",
                yearRange: "c-80:c+40",
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
                yearRange: "c-80:c+40",
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
            $("#btnPrint").click(function () {
                var isDisabled = $('#btnPrint').is('[disabled=disabled]');
                if (!isDisabled) {
                    var contents = $("#resultHTML").html();
                    var frame1 = $('<iframe />');
                    frame1[0].name = "frame1";
                    frame1.css({ "position": "absolute", "top": "-1000000px" });
                    $("body").append(frame1);
                    var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
                    frameDoc.document.open();
                    //Create a new HTML document.
                    frameDoc.document.write('<html><head>');
                    frameDoc.document.write('</head><body>');
                    //Append the external CSS file.
                    frameDoc.document.write('<style type="text/css">');
                    frameDoc.document.write('table.fixed { table-layout:fixed; }table.fixed td { overflow: hidden; }table.report {width:100%;border-collapse: collapse;}');
                    frameDoc.document.write('table.report th {padding:10px;border: solid 1px #000;}table.report thead th {background: #507093;color: #fff;}');
                    frameDoc.document.write('table.report tbody th {background: #507093;color: #fff;}');
                    frameDoc.document.write('table.report tbody td {padding:4px;background: #fff;}');
                    frameDoc.document.write('table.report tbody td.sum {padding:4px;background: #ebebeb;border-top-width:2px;}');
                    frameDoc.document.write('table.report .pagination {display: table;padding: 0;margin: 0 auto;}');
                    frameDoc.document.write('</style>');
                    //Append the DIV contents.
                    frameDoc.document.write(contents);
                    frameDoc.document.write('</body></html>');
                    frameDoc.document.close();
                    setTimeout(function () {
                        window.frames["frame1"].focus();
                        window.frames["frame1"].print();
                        frame1.remove();
                    }, 500);
                }
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table bgcolor="White" cellpadding="0" cellspacing="0">
                <tr style="background-color: #EEEEEE">
                    <td height="35" style="background-image: url('../images/headerstub.jpg')">&nbsp;&nbsp;</td>
                    <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                        <span class="headerText" id="headerHTML" runat="server"></span>
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
                        <asp:Label ID="lbErrorMessage" runat="server" ForeColor="#ff9900"></asp:Label>
                        <table style="vertical-align: top;">
                            <tr>
                                <td style="vertical-align: top; padding-right: 5px;">
                                    <table style="vertical-align: top;">
                                        <tr>
                                            <td>
                                                <label id="lbHeader_ReportType" runat="server"></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:DropDownList ID="ddlReportType" runat="server" Width="200"></asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label id="lbHeader_ProductLevel" runat="server"></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:DropDownList ID="ddlProductLevel" runat="server" Width="200"></asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="vertical-align: top; border-left: 2px #bebebe solid; padding-left: 10px;">
                                    <table style="vertical-align: top;">
                                        <tr>
                                            <td>
                                                <label id="lbHeader_StartDate" runat="server"></label>
                                            </td>
                                            <td style="padding-left: 10px;">
                                                <label id="lbHeader_EndDate" runat="server"></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="vertical-align: middle;">
                                                <asp:TextBox ID="tbStartDate" runat="server" ReadOnly="true" Width="133"></asp:TextBox>
                                                <asp:HiddenField ID="alt_StartDate" runat="server" Value="" />
                                            </td>
                                            <td style="padding-left: 10px; vertical-align: middle;">
                                                <asp:TextBox ID="tbEndDate" runat="server" ReadOnly="true" Width="133"></asp:TextBox>
                                                <asp:HiddenField ID="alt_EndDate" runat="server" Value="" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="text-align: left;">
                                                <asp:Button ID="btnGenerateReport" runat="server" Height="25" Width="140" OnClick="btnGenerateReport_Click" />
                                                &nbsp;
                                                <asp:LinkButton ID="btnExportExcel" runat="server" Enabled="false" Text="Export to excel" OnClick="btnExportExcel_Click"></asp:LinkButton>
                                                &nbsp;|&nbsp;
                                                <asp:HyperLink ID="btnPrint" runat="server"  Enabled="false" Text="Print" onmouseout="LinkBtnMouseOut(this)" onmouseover="LinkBtnMouseOver(this)"></asp:HyperLink>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="alt_isHaveData" runat="server" Value="0" />
                        <span id="resultHTML" runat="server"></span>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3" height="30">&nbsp;
                        <table style="width: 100%;">
                            <tr>
                                <td style="text-align: right;">
                                    <label id="lbLastUpdate" runat="server" class="lastUpdate" style="text-align: right; font-size: 0.8em; color: #b9b9b9;">Last Update : 2016/01/12 GMT+7</label>
                                </td>
                            </tr>
                        </table>
                    </td>
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
    </form>
</body>
</html>
