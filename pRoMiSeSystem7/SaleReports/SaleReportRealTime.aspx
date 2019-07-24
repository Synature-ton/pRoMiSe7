<%@ page language="VB" autoeventwireup="false" inherits="SaleReports_SaleReportRealTime, App_Web_salereportrealtime.aspx.1ae37aa7" theme="default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head1" runat="server">
    <title>Sale Report RealTime.</title>
    <style type="text/css">
        body
        {
            margin: 0 auto;
            padding: 5px;
            font-family: Verdana, Tahoma, Arial, sans-serif,;
            font-size: 12px;
        }
        .headReport
        {
            font-size: 16px;
            text-align: center;
            font-weight: bold;
        }
        .left
        {
            width: 70%;
            float: left;
            text-align: left;
        }
        .right
        {
            width: 30%;
            float: right;
            text-align: right;
        }
    </style>

    <script src="../Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-ui-1.8.4.custom.min.js" type="text/javascript"></script>

    <script src="../Scripts/JSReports.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <div style="margin: 0 auto; padding: 5px;">
        <div class="headReport">
            Sale Report RealTime
        </div>
        <div class="left">
           
        </div>
        <div class="right">
            <span>Date :
                <asp:Label ID="lbDateTime" runat="server"></asp:Label></span>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <div style="margin: 0 auto; padding: 5px;">
        <div id="SaleReportRealTime">
        </div>
    </div>
    </form>
</body>
</html>
