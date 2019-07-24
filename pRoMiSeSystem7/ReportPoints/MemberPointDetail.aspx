<%@ page language="C#" autoeventwireup="true" inherits="ReportPoints_MemberPointDetail, App_Web_memberpointdetail.aspx.21ba1aa2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Member Point Detail</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/admin2.css" rel="stylesheet" type="text/css" />
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

                table.report tbody td.sum {
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

</head>
<body>
    <form id="form1" runat="server">

        <div>
            <table bgcolor="White" cellpadding="0" cellspacing="0">
                <tr style="background-color: #EEEEEE">
                    <td height="35" style="background-image: url('../images/headerstub.jpg')">&nbsp; &nbsp;
                    </td>
                    <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')"></td>
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

                        <asp:Label ID="lbErrorMessage" runat="server" ForeColor="#ff9900"></asp:Label>

                        <fieldset style="margin: 20px auto; margin-bottom: 0px; padding: 0px; padding-top: 10px; padding-bottom: 10px;">
                            <center>
                            <span class="headerText" id="headerT" runat="server"></span>
                            <br />
                        <table style="width:600px; flex-align:center;">
                            <tr>
                                <td style="text-align:right; width:45%;">
                                    <asp:Label ID="lbheader00" runat="server" Text=""></asp:Label>&nbsp;:&nbsp;&nbsp;
                                </td>
                                <td style="width:55%;">
                                    <asp:Label ID="lbdata00" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:right; width:45%;">
                                    <asp:Label ID="lbheader01" runat="server" Text=""></asp:Label>&nbsp;:&nbsp;&nbsp;
                                </td>
                                <td style="width:55%;">
                                    <asp:Label ID="lbdata01" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:right; width:45%;">
                                    <asp:Label ID="lbheader02" runat="server" Text=""></asp:Label>&nbsp;:&nbsp;&nbsp;
                                </td>
                                <td style="width:55%;">
                                    <asp:Label ID="lbdata02" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                            </center>
                        </fieldset>
                        <br />
                        <span id="resultHTML" runat="server"></span>


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
