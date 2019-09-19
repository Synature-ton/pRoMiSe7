<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PromotionPackage_Edit.aspx.vb" Inherits="POSPromotionSettings.PromotionPackage_Edit" %>

<!DOCTYPE html>

<<html>
<head id="Head1" runat="server">
    <title>Member Promotion Set Setting</title>
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
                    <asp:Label ID="lblHeader" runat="server" Text="Promotion Setting" CssClass="headerText"></asp:Label>
                </div>
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
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Label ID="lblUpdateDate" runat="server" Text="" ></asp:Label>
                        </td>
                    </tr>
                    <tr class="text">
                        <td width="200px" align="right">
                            <asp:Label ID="lblPromotionPackageName" runat="server" Text="Promotion" class="redText"></asp:Label>&nbsp;
                        </td>
                        <td>
                            <asp:TextBox ID="txtPromoPackageName" runat="server" Width="400px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                ValidationGroup="p" ControlToValidate="txtPromoPackageName"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="lblPromoDescription" runat="server" Text="Description"></asp:Label>&nbsp;
                        </td>
                        <td>
                            <asp:TextBox ID="txtPromoDescription" runat="server" Height="60px" TextMode="MultiLine" Width="550px" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="lblFromDate" runat="server" Text="From Date" ></asp:Label>&nbsp;
                        </td>
                        <td>
                            <div id="date_startdate" runat="server" style="float: left;"></div>
                        </td>
                    </tr>
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="lblToDate" runat="server" Text="To Date"></asp:Label>&nbsp;
                        </td>
                        <td>
                            <div id="date_enddate" runat="server" style="float: left;"></div>
                        </td>
                    </tr>

                     <tr class="text">
                        <td align="right">
                            <asp:Label ID="lblPromotionPackageType" runat="server" Text="ประเภท"></asp:Label>&nbsp;
                        </td>
                        <td>
                           <asp:DropDownList ID="cboPromotionPackageType" runat="server" Width="220px" Height="25px" AutoPostBack="true"></asp:DropDownList>
                        </td>                         
                    </tr>                    
                     <tr id="trBirthDaySetting" class="text" runat="server" >
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:RadioButton ID="optIsInBirthDayMonth" runat="server" GroupName="BirthDayGroup" Text="Use Within Month" ></asp:RadioButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:RadioButton ID="optBetweenBirthDay" runat="server"  GroupName="BirthDayGroup" Text="Use Between Date" ></asp:RadioButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td><asp:Label ID="lblDayBeforeBirthDay" runat="server" Text="ก่อนวันเกิด"></asp:Label></td>
                                                <td><asp:TextBox ID="txtDayBeforeBirthDay" runat="server" Width="40px"></asp:TextBox></td>
                                                <td><asp:Label ID="lblDay1" runat="server" Text="day"></asp:Label>
                                                    <asp:Label ID="lblBirthDay1Validate" runat="server"  CssClass="redText" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><asp:Label ID="lblDayAfterBirthDay" runat="server" Text="หลังจากวันเกิด"></asp:Label></td>
                                                <td><asp:TextBox ID="txtDayAfterBirthDay" runat="server" Width="40px"></asp:TextBox></td>
                                                <td><asp:Label ID="lblDay2" runat="server" Text="day"></asp:Label>
                                                    <asp:Label ID="lblBirthDay2Validate" runat="server" CssClass="redText" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                        </table>                                       
                                    </td>
                                </tr>                               
                            </table>
                        </td>
                    </tr>
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="lblMemberGroup" runat="server" Text="Member Group"></asp:Label>&nbsp;
                        </td>
                        <td>                           
                            <div style="width : 350px; height:175px; border: solid 1px rgb(236, 233,216); overflow:auto; ">
                                <asp:CheckBoxList ID="chkLstMemberGroup" runat="server" CssClass="text"></asp:CheckBoxList>                                
                            </div>
                        </td>
                    </tr>
                    <tr class="text">
                        <td align="right">
                            <asp:Label ID="lblComponent" runat="server" Text="Component"></asp:Label>&nbsp;
                        </td>
                        <td>
                            <div id="dvPromoPackageComponent" runat="server" style="border: solid 1px rgb(236, 233,216);">
                                <table style="width: 50%;">
                                    <tr><td>
                                        <asp:LinkButton ID="lnkAddUpdatePackageComponent" runat="server" Text="Add/ Update Voucher/ Coupon List"></asp:LinkButton>
                                    </td></tr>
                                    <tr><td>
                                        <table class="blue"  style="width: 100%;">
                                            <thead>
                                                <tr>
                                                    <th style="width: 5%;">
                                                        <asp:Label ID="lblComponentNo" runat="server" Text=""></asp:Label>
                                                    </th>
                                                    <th style="width: 50%;">
                                                        <asp:Label ID="lblVoucherName" runat="server" Text="Voucher/ Coupon Name"></asp:Label>
                                                    </th>
                                                    <th style="width: 20%;">
                                                        <asp:Label ID="lblNoOfVoucher" runat="server" Text="Qty."></asp:Label>
                                                    </th>
                                                </tr>
                                            </thead>
                                            <asp:Label ID="OutputPromoPackageComponent" runat="server"></asp:Label>
                                        </table>
                                    </td></tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr class="text">
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    
                    <tr class="text">
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Button ID="cmdSavePromotion" runat="server" Text="Save" ValidationGroup="p" Width="100px" />
                             &nbsp; &nbsp; &nbsp; &nbsp;
                            <asp:Button ID="cmdCancel" runat="server" Text="Cancel" Width="100px" />
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
