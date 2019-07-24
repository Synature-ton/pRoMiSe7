<%@ page language="C#" autoeventwireup="true" inherits="Reports_SaleByPeriod, App_Web_salebyperiod.aspx.dfa151d5" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />--%>
    <style type="text/css">
        body
        {
            margin: 0;
            padding: 0;
            background:#C8D3DC;
            font-family:Arial, Sans-Serif, Tahoma;
            font-size:12px;
        }
        #header
        {
            background: url(../images/headerbg2000.jpg) top left;
            height: 30px;
            padding: 14px 0 0 8px;
        }
        #opt
        {
            margin: 0;
            padding: 4px 8px 4px 16px;
            background: white;
        }
        #content
        {
            margin: 0;
            padding: 4px 8px 4px 20px;
            background: white;
        }
        #footer
        {
        }
        .blue
        {
            border:#666 1px solid;
            border-right:none;
            border-bottom:none;
            width:70% !important;
        }
        .blue th
        {
            padding:4px;
            background:#507095;
            color:#ffffff;
            border-right:#666 1px solid;
            border-bottom:#666 1px solid;
        }
        td
        {
            padding: 2px;
            border-right:#666 1px solid;
            border-bottom:#666 1px solid;
        }
        .blue tfoot
        {
           background:#f0f0f0;
        }
        .headerText
        {
            font-size:1.1em;
            font-weight:bold;
        }
    </style>

    <script src="../js/jquery-1.4.2.min.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="header" class="no-print">
        <span class="headerText">Sale Report By Period</span>
    </div>
    <div id="opt" class="no-print">
        <div style="float: left; width: 30%; padding:0 0 0 20px;">
            <div style="margin-bottom: 10px;">
                <label for="ddlShop" style="font-weight: bold;">
                </label>
                <asp:DropDownList ID="ddlShop" runat="server">
                </asp:DropDownList>
            </div>
        </div>
        <div style="float: left;">
            <label for="rdoDate">
            </label>
            <asp:RadioButton ID="rdoDate" runat="server" GroupName="date" Checked="true" Width="20" />
            <asp:DropDownList ID="ddlDay" runat="server">
            </asp:DropDownList>
            <asp:DropDownList ID="ddlMonth" runat="server">
            </asp:DropDownList>
            <asp:DropDownList ID="ddlYear" runat="server">
            </asp:DropDownList>
            <br />
            <label for="rdoMonth">
            </label>
            <asp:RadioButton ID="rdoMonth" runat="server" GroupName="date" Width="20" />
            <asp:DropDownList ID="ddl_m_month" runat="server">
            </asp:DropDownList>
            <asp:DropDownList ID="ddl_m_year" runat="server">
            </asp:DropDownList>
            <br />
            <label for="rdoYear">
            </label>
            <asp:RadioButton ID="rdoYear" runat="server" GroupName="date" Width="20" />
            <asp:DropDownList ID="ddl_y_year" runat="server">
            </asp:DropDownList>
            <br />
            <label for="rdoDateFrame">
            </label>
            <asp:RadioButton ID="rdoDateFrame" runat="server" GroupName="date" Width="20" />
            <asp:DropDownList ID="ddlDayFrom" runat="server">
            </asp:DropDownList>
            <asp:DropDownList ID="ddlMonthFrom" runat="server">
            </asp:DropDownList>
            <asp:DropDownList ID="ddlYearFrom" runat="server">
            </asp:DropDownList>
            ถึง
            <asp:DropDownList ID="ddlDayTo" runat="server">
            </asp:DropDownList>
            <asp:DropDownList ID="ddlMonthTo" runat="server">
            </asp:DropDownList>
            <asp:DropDownList ID="ddlYearTo" runat="server">
            </asp:DropDownList>
            <div style="padding: 4px 0 0 20px;">
                <asp:Button ID="btnDis" runat="server" Text="แสดงรายงาน" OnClick="BtnCreateReport_Click" />
            </div>
        </div>
        <div style="clear: both; height: 1px;">
            &nbsp;</div>

        <script type="text/javascript">
            $("#ddlDay").click(function() {
                $("#rdoDate").attr('checked', true);
            });
            $("#ddlMonth").click(function() {
                $("#rdoDate").attr('checked', true);
            });
            $("#ddlYear").click(function() {
                $("#rdoDate").attr('checked', true);
            });

            $("#ddl_m_month").click(function() {
                $("#rdoMonth").attr('checked', true);
            });
            $("#ddl_m_year").click(function() {
                $("#rdoMonth").attr('checked', true);
            });

            $("#ddl_y_year").click(function() {
                $("#rdoYear").attr('checked', true);
            });

            $("#ddlDateFrom").click(function() {
                $("#rdoDateFrame").attr('checked', true);
            });
            $("#ddlMonthFrom").click(function() {
                $("#rdoDateFrame").attr('checked', true);
            });
            $("#ddlYearFrom").click(function() {
                $("#rdoDateFrame").attr('checked', true);
            });

            $("#ddlDateTo").click(function() {
                $("#rdoDateFrame").attr('checked', true);
            });
            $("#ddlMonthTo").click(function() {
                $("#rdoDateFrame").attr('checked', true);
            });
            $("#ddlYearTo").click(function() {
                $("#rdoDateFrame").attr('checked', true);
            });
        </script>

    </div>
    <div id="content">
       <asp:Literal ID="litReportDesc" runat="server"></asp:Literal>
        <div id="tbCont" runat="server">
        </div>
    </div>
    <div id="footer" class="no-print">
        <img src="../images/footerbg2000.gif" />
    </div>
    </form>
</body>
</html>
