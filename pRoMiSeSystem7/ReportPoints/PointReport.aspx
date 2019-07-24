<%@ page language="C#" autoeventwireup="true" inherits="ReportPoints_PointReport, App_Web_pointreport.aspx.21ba1aa2" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Summary Point(s) Report</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        label.lastUpdate::selection {
            background-color: transparent;
        }

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

            table.report tbody tr:nth-child(even) {
                background-color: #fff;
            }

            table.report tbody tr:nth-child(odd) {
                background-color: #eff3fb;
            }

            table.report tbody tr:nth-child(even):hover td {
                background-color: #FFFFDD;
            }

            table.report tbody tr:nth-child(odd):hover td {
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

        function pointNull() {
            var check = document.getElementById("<%= cbPoint_PointNull.ClientID %>");
            if (check.checked) {
                document.getElementById("<%= cbPoint_PointRange.ClientID %>").disabled = true;
                document.getElementById("<%= cbPoint_PointZero.ClientID %>").disabled = true;
                document.getElementById("<%= tbPointFrom.ClientID %>").disabled = true;
                document.getElementById("<%= tbPointTo.ClientID %>").disabled = true;
            }
            else {
                document.getElementById("<%= cbPoint_PointRange.ClientID %>").disabled = false;
                document.getElementById("<%= cbPoint_PointZero.ClientID %>").disabled = false;
                document.getElementById("<%= cbPoint_PointZero.ClientID %>").checked = true;
                document.getElementById("<%= tbPointFrom.ClientID %>").disabled = false;
                document.getElementById("<%= tbPointTo.ClientID %>").disabled = false;
            }
        }

        function NumberCheck(evt, exp) {
            if (exp == 1)
                if (evt.charCode == 46)
                    return true;
            if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                alert("Allow Only Numbers");
                return false;
            }
        }
        function LinkBtnMouseOut(element) {
            if (element.disabled) {
                element.style.color = "black";
            }
            else {
                element.style.color = "#0B55C4";
            }
            element.style.textDecoration = 'none';
            element.style.cursor = 'default';
        }
        function LinkBtnMouseOver(element) {
            if (element.disabled) {
                element.style.color = "black";
            }
            else {
                element.style.color = "#BAC40B";
            }
            element.style.textDecoration = 'underline';
            if (element.disabled) {
                element.style.cursor = 'pointer';
            }
            else {
                element.style.cursor = 'auto';
            }
        }

        $(function () {
            $(document).ready(function () {

            });
            $("[id$=imgHelp_PointRange]").tooltip({
                track: true,
                open: function (event, ui) {
                    ui.tooltip.css("max-width", "500px");
                    ui.tooltip.css("font-size", "1em");
                },
                content: $("[id$=alt_langid]").attr("Value") == "2" ? '<b>คำแนะนำ</b><br>ถ้าต้องการดูสมาชิกที่อยู่ในช่วงคะแนนที่กำหนด ให้เลือกตัวเลือกนี้' : '<b>Advice</b><br>If want to view member who have point(s) in range, please select this choice.'
            });
            $("[id$=imgHelp_PointZero]").tooltip({
                track: true,
                open: function (event, ui) {
                    ui.tooltip.css("max-width", "500px");
                    ui.tooltip.css("font-size", "1em");
                },
                content: $("[id$=alt_langid]").attr("Value") == "2" ? '<b>คำแนะนำ</b><br>ถ้าต้องการดูสมาชิกที่มีคะแนนเท่ากับ 0 ด้วย ให้เลือกตัวเลือกนี้' : '<b>Advice</b><br>If want to view member who have zero point, please select this choice.'
            });
            $("[id$=imgHelp_PointNull]").tooltip({
                track: true,
                open: function (event, ui) {
                    ui.tooltip.css("max-width", "500px");
                    ui.tooltip.css("font-size", "1em");
                },
                content: $("[id$=alt_langid]").attr("Value") == "2" ? '<b>คำแนะนำ</b><br>ถ้าต้องการที่จะดูสมาชิกที่ไม่มีคะแนนเลย ให้เลือกที่ตัวเลือกนี้ (ถ้าเลือกตัวเลือกนี้ ตัวเลือกให้แสดงผลสมาชิกที่มีแต้มสะสมเท่ากับ 0 และ การแสดงผลแต้มสะสมระหว่างช่วงคะแนนจะถูกปิด)' : '<b>Advice</b><br>If want to view member who not have point only, please select this choice. (If select this choice, display member who have zero point choice and display point range is disabled)'
            });
            $("#btnPrint").click(function () {
                var isDisabled = $('#btnPrint').is('[disabled=disabled]');
                if (!isDisabled) {
                    var contents = $("#printResultHTML").html();
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

                        <asp:Label ID="lbErrorMessage" ForeColor="#ff9900" runat="server"></asp:Label>
                        <asp:HiddenField ID="alt_langid" runat="server" />
                        <table style="vertical-align: top;">
                            <tr>
                                <td style="vertical-align: top; padding-right: 5px;">
                                    <table style="vertical-align: top;">
                                        <tr>
                                            <td>
                                                <label id="lbHeader_MemberGroup" runat="server"></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:DropDownList ID="ddlMemberGroup" runat="server" Width="200"></asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label id="lbHeader_MemberCode" runat="server"></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="tbMemberCode" runat="server" Width="200"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="vertical-align: top; border-left: 2px #bebebe solid; padding-left: 10px;">
                                    <table style="vertical-align: top;">
                                        <tr>
                                            <td>
                                                <asp:RadioButton ID="rbData_AmountRow" runat="server" GroupName="AmountData" />
                                                &nbsp;
                                            <asp:TextBox ID="tbAmountRow" runat="server" onkeypress="return NumberCheck(event,0)"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:RadioButton ID="rbData_ShowAll" runat="server" GroupName="AmountData" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="cbPoint_PointRange" runat="server" />
                                                &nbsp;
                                            <asp:TextBox ID="tbPointFrom" runat="server" onkeypress="return NumberCheck(event,1)"></asp:TextBox>
                                                &nbsp;<label id="lbHeader_To" runat="server"></label>&nbsp;
                                            <asp:TextBox ID="tbPointTo" runat="server" onkeypress="return NumberCheck(event,1)"></asp:TextBox>
                                                &nbsp;<img id="imgHelp_PointRange" src="../images/help.jpg" title="" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="cbPoint_PointZero" runat="server" />
                                                &nbsp;<img id="imgHelp_PointZero" src="../images/help.jpg" title="" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="cbPoint_PointNull" runat="server" onclick="pointNull();" />
                                                &nbsp;<img id="imgHelp_PointNull" src="../images/help.jpg" title="" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnGenerateReport" runat="server" Width="100" Height="25" OnClick="btnGenerateReport_Click" />
                                                &nbsp;
                                                <asp:LinkButton ID="btnExportExcel" runat="server" Text="Export to excel" Enabled="false" OnClick="btnExportExcel_Click"></asp:LinkButton>
                                                &nbsp;|&nbsp;
                                                <asp:HyperLink ID="btnPrint" runat="server" Enabled="false" Text="Print"></asp:HyperLink>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <hr />
                        <table style="width: 100%;">
                            <tr>
                                <td style="text-align: left;">
                                    <asp:Label ID="lbCountRow" runat="server" Style="font-size: 1.2em;" Font-Bold="true" Height="25px"></asp:Label>
                                </td>
                                <td style="text-align: right;">
                                    <asp:Label ID="lbReportCreated" runat="server" Style="font-size: 1em;" Font-Bold="true" Height="25px"></asp:Label>
                                </td>
                            </tr>
                        </table>

                        <span id="detailHTML" runat="server"></span>
                        <br />
                        <span id="resultHTML" runat="server"></span>
                        <br />
                        <span id="pagingHTML" runat="server"></span>
                        <br />
                        <center>
                        <table id="tbl_goToPage" runat="server" style="width:auto; display:none;">
                            <tr>
                                <td><label id="lbHeader_goToPage" runat="server" visible="false"></label>
                                    <asp:TextBox ID="tbGoToPage" runat="server" Width="100" Enabled="false" Visible="false"></asp:TextBox>
                                    <asp:Button ID="btnGoToPage" runat="server" Enabled="false" Visible="false" OnClick="btnGoToPage_Click"/>
                                    <asp:RangeValidator ID="vldPageRange" runat="server" Type="Integer" MinimumValue="0" MaximumValue="1" ControlToValidate="tbGoToPage" ErrorMessage="Page Out Of Range." Display="Dynamic"></asp:RangeValidator>
                                </td>
                            </tr>
                        </table>
                        </center>
                        <span id="printResultHTML" runat="server" style="display:none;"></span>







                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3" height="30">&nbsp;
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
