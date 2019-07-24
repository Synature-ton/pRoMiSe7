<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Promotion_link_level.aspx.vb"
    Inherits="POSPromotionSettings.Promotion_link_level" %>

<html>
<head id="Head1" runat="server">
    <title>Promotion Setting</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />

    <script language="JavaScript" src="../StyleSheet/webscript.js"></script>

    <script>
        //สำหรับการเลือกข้อมูลพนักงาน
        function OnChangeCheckBox1(selectedOption) {
            var objCheckListBox = document.getElementById('<%= ChkPromoStaff.ClientID %>');
            var chkBoxCount = objCheckListBox.getElementsByTagName("input");
            if (selectedOption == 1) {

                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = true;
                    Disable('btnNextMember', false);
                }

            }
            else if (selectedOption == 2) {
                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = false;
                    Disable('btnNextMember', true);
                }

            }
        }
        //ตรวจสอบมีการเลือก กลุ่มพนักงานไว้หรือไม่
        //กรณีถ้ามีการเลือกไว้ให้สามารถกดปุ่มถัดไปได้
        //กรณีที่ไม่มีการเลือกจะไม่สามารถกดปุ่มถัดไปได้
        function CheckSeleStaffForDisableButton() {
            var objCheckListBox = document.getElementById('<%= ChkPromoStaff.ClientID %>');
            var chkBoxCount = objCheckListBox.getElementsByTagName("input");
            var chkLoop = 0;
            for (var i = 0; i < chkBoxCount.length; i++) {
                if (chkBoxCount[i].checked == true) { chkLoop = 1; break; }
            }
            if (chkLoop == 1) {
                Disable('btnNextMember', false);
            } else {
                Disable('btnNextMember', true);

            }

        }
        //สำหรับการเลือกข้อมูลคูปอง
        function OnChangeCheckBox2(selectedOption) {
            var objCheckListBox = document.getElementById('<%= ChkPromoCoupon.ClientID %>');
            var chkBoxCount = objCheckListBox.getElementsByTagName("input");
            if (selectedOption == 1) {

                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = true;
                    Disable('btnNextMember', false);
                }

            }
            else if (selectedOption == 2) {
                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = false;
                    Disable('btnNextMember', true);
                }

            }
        }
        //ตรวจสอบมีการเลือก กลุ่มคูปองไว้หรือไม่
        //กรณีถ้ามีการเลือกไว้ให้สามารถกดปุ่มถัดไปได้
        //กรณีที่ไม่มีการเลือกจะไม่สามารถกดปุ่มถัดไปได้
        function CheckSeleCouponForDisableButton() {
            var objCheckListBox = document.getElementById('<%= ChkPromoCoupon.ClientID %>');
            var chkBoxCount = objCheckListBox.getElementsByTagName("input");
            var chkLoop = 0;
            for (var i = 0; i < chkBoxCount.length; i++) {
                if (chkBoxCount[i].checked == true) { chkLoop = 1; break; }
            }
            if (chkLoop == 1) {
                Disable('btnNextMember', false);
            } else {
                Disable('btnNextMember', true);

            }

        }
        //สำหรับการเลือกข้อมูลบัตรกำนัล
        function OnChangeCheckBox3(selectedOption) {
            var objCheckListBox = document.getElementById('<%= ChkVoucher.ClientID %>');
            var chkBoxCount = objCheckListBox.getElementsByTagName("input");
            if (selectedOption == 1) {

                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = true;
                    Disable('btnNextMember', false);
                }

            }
            else if (selectedOption == 2) {
                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = false;
                    Disable('btnNextMember', true);
                }

            }
        }
        //ตรวจสอบมีการเลือก กลุ่มบัตรกำนัลไว้หรือไม่
        //กรณีถ้ามีการเลือกไว้ให้สามารถกดปุ่มถัดไปได้
        //กรณีที่ไม่มีการเลือกจะไม่สามารถกดปุ่มถัดไปได้
        function CheckSeleVoucherForDisableButton() {
            var objCheckListBox = document.getElementById('<%= ChkVoucher.ClientID %>');
            var chkBoxCount = objCheckListBox.getElementsByTagName("input");
            var chkLoop = 0;
            for (var i = 0; i < chkBoxCount.length; i++) {
                if (chkBoxCount[i].checked == true) { chkLoop = 1; break; }
            }
            if (chkLoop == 1) {
                Disable('btnNextMember', false);
            } else {
                Disable('btnNextMember', true);

            }

        }
        //สำหรับการเลือกข้อมูลสมาชิก
        function OnChangeCheckBox4(selectedOption) {
            var objCheckListBox = document.getElementById('<%= ChkMemberGroup.ClientID %>');
            var chkBoxCount = objCheckListBox.getElementsByTagName("input");
            if (selectedOption == 1) {

                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = true;
                    Disable('btnNextMember', false);
                }

            }
            else if (selectedOption == 2) {
                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = false;
                    Disable('btnNextMember', true);
                }

            }
        }
        //ตรวจสอบมีการเลือก กลุ่มสมาชิกไว้หรือไม่
        //กรณีถ้ามีการเลือกไว้ให้สามารถกดปุ่มถัดไปได้
        //กรณีที่ไม่มีการเลือกจะไม่สามารถกดปุ่มถัดไปได้
        function CheckSeleMemberForDisableButton() {
            var objCheckListBox = document.getElementById('<%= ChkMemberGroup.ClientID %>');
            var chkBoxCount = objCheckListBox.getElementsByTagName("input");
            var chkLoop = 0;
            for (var i = 0; i < chkBoxCount.length; i++) {
                if (chkBoxCount[i].checked == true) { chkLoop = 1; break; }
            }
            if (chkLoop == 1) {
                Disable('btnNextMember', false);
            } else {
                Disable('btnNextMember', true);

            }

        }

        // สำหรับกดปุ่มถัดไป ในกรณีเป็นส่วนลดประเภท พนักงาน,คูปอง,บัตรกำนัล,สมาชิก
        // เพราะกรณีนี้จะต้องไปกลุ่มข้อมูล พนักงาน,คูปอง,บัตรกำนัล,สมาชิก ก่อนไปกำหนดส่วนให้กับระบบ
        function NextConditionDiscount() {
            //Section Discount Price 
            //Row data
            HidedRows('Section_MemberGroup');
            HidedRows('Section_PromotionType');
            HidedRows('Section_StaffGroup');
            HidedRows('Section_Coupon');
            HidedRows('Section_Voucher');
            ShowRows('Section_ConditionDiscount');

            //button
            HidedRows('btnNextPromoType');
            ShowRows('btnBackMemberToPromoType');
            HidedRows('btnNextMember');
            ShowRows('btnSavePromo');
            var objRdoList = document.getElementById('<%= RdoPromoType.ClientID %>');
            var rdoListCount = objRdoList.getElementsByTagName("input");
            for (var i = 0; i < rdoListCount.length; i++) {
                if (rdoListCount[i].checked == true) {
                    var rodChk = rdoListCount[i].value;
                    if (rodChk == '5') {
                        Disable('<%= RdoPieceAmount.ClientID %>', true);
                        Disable('<%= RdoBathAmount.ClientID %>', false);
                        document.getElementById('<%= RdoBathAmount.ClientID %>').checked = true;
                    } else {
                        Disable('<%= RdoPieceAmount.ClientID %>', false);
                        Disable('<%= RdoBathAmount.ClientID %>', false);
                        //document.getElementById('<%= RdoPieceAmount.ClientID %>').checked = true;
                    }
                }


            }

        }
        // สำหรับปิด/ซ้อน ส่วนเงื่อนไขของโปรโมชั่น
        function NextPromoType() {
            var objRdoList = document.getElementById('<%= RdoPromoType.ClientID %>');
            var rdoListCount = objRdoList.getElementsByTagName("input");
            for (var i = 0; i < rdoListCount.length; i++) {
                if (rdoListCount[i].checked == true) {
                    HidedRows('btnBackToEditPromo');
                    var rdoChk = rdoListCount[i].value;
                    //alert(rdoChk);
                    switch (rdoChk) {
                        case '1':
                            // Section Member
                            //Row data
                            ShowRows('Section_MemberGroup');
                            HidedRows('Section_PromotionType');
                            HidedRows('Section_StaffGroup');
                            HidedRows('Section_Coupon');
                            HidedRows('Section_Voucher');

                            //button
                            HidedRows('btnNextPromoType');
                            ShowRows('btnBackMemberToPromoType');
                            ShowRows('btnNextMember');
                            HidedRows('btnSavePromo');

                            //ตรวจสอบมีการเลือก กลุ่มสมาชิกไว้หรือไม่
                            //กรณีถ้ามีการเลือกไว้ให้สามารถกดปุ่มถัดไปได้
                            //กรณีที่ไม่มีการเลือกจะไม่สามารถกดปุ่มถัดไปได้
                            var objCheckListBox = document.getElementById('<%= ChkMemberGroup.ClientID %>');
                            var chkBoxCount = objCheckListBox.getElementsByTagName("input");
                            var chkLoop;
                            for (var j = 0; j < chkBoxCount.length; j++) {
                                if (chkBoxCount[j].checked == true) { chkLoop = 1; break; }
                            }
                            if (chkLoop == 1) {
                                Disable('btnNextMember', false);
                            } else {
                                Disable('btnNextMember', true);

                            }

                            break;
                        case '2':
                            //Section Discount Price 
                            //Row data
                            HidedRows('Section_MemberGroup');
                            HidedRows('Section_PromotionType');
                            HidedRows('Section_StaffGroup');
                            HidedRows('Section_Coupon');
                            HidedRows('Section_Voucher');
                            ShowRows('Section_ConditionDiscount');

                            //button
                            HidedRows('btnNextPromoType');
                            ShowRows('btnBackMemberToPromoType');
                            ShowRows('btnSavePromo');
                            NextConditionDiscount();
                            break;
                        case '3':
                            // Section Staff
                            //Row data
                            HidedRows('Section_MemberGroup');
                            HidedRows('Section_PromotionType');
                            ShowRows('Section_StaffGroup');
                            HidedRows('Section_Coupon');
                            HidedRows('Section_Voucher');
                            HidedRows('Section_ConditionDiscount');

                            //button
                            HidedRows('btnNextPromoType');
                            ShowRows('btnBackMemberToPromoType');
                            ShowRows('btnNextMember');
                            HidedRows('btnSavePromo');
                            //กรณีถ้ามีการเลือกไว้ให้สามารถกดปุ่มถัดไปได้
                            //กรณีที่ไม่มีการเลือกจะไม่สามารถกดปุ่มถัดไปได้
                            var objCheckListBox = document.getElementById('<%= ChkPromoStaff.ClientID %>');
                            var chkBoxCount = objCheckListBox.getElementsByTagName("input");
                            var chkLoop;
                            for (var j = 0; j < chkBoxCount.length; j++) {
                                if (chkBoxCount[j].checked == true) { chkLoop = 1; break; }
                            }
                            if (chkLoop == 1) {
                                Disable('btnNextMember', false);
                            } else {
                                Disable('btnNextMember', true);

                            }

                            break;
                        case '4':
                            // Section Coupon
                            //Row data
                            HidedRows('Section_MemberGroup');
                            HidedRows('Section_PromotionType');
                            HidedRows('Section_StaffGroup');
                            ShowRows('Section_Coupon');
                            HidedRows('Section_Voucher');
                            HidedRows('Section_ConditionDiscount');

                            //button
                            HidedRows('btnNextPromoType');
                            ShowRows('btnBackMemberToPromoType');
                            ShowRows('btnNextMember');
                            HidedRows('btnSavePromo');
                            //กรณีถ้ามีการเลือกไว้ให้สามารถกดปุ่มถัดไปได้
                            //กรณีที่ไม่มีการเลือกจะไม่สามารถกดปุ่มถัดไปได้
                            var objCheckListBox = document.getElementById('<%= ChkPromoCoupon.ClientID %>');
                            var chkBoxCount = objCheckListBox.getElementsByTagName("input");
                            var chkLoop;
                            for (var j = 0; j < chkBoxCount.length; j++) {
                                if (chkBoxCount[j].checked == true) { chkLoop = 1; break; }
                            }
                            if (chkLoop == 1) {
                                Disable('btnNextMember', false);
                            } else {
                                Disable('btnNextMember', true);

                            }

                            break;
                        case '5':
                            //Row data
                            HidedRows('Section_MemberGroup');
                            HidedRows('Section_PromotionType');
                            HidedRows('Section_StaffGroup');
                            HidedRows('Section_Coupon');
                            ShowRows('Section_Voucher');
                            HidedRows('Section_ConditionDiscount');

                            //button
                            HidedRows('btnNextPromoType');
                            ShowRows('btnBackMemberToPromoType');
                            ShowRows('btnNextMember');
                            //กรณีถ้ามีการเลือกไว้ให้สามารถกดปุ่มถัดไปได้
                            //กรณีที่ไม่มีการเลือกจะไม่สามารถกดปุ่มถัดไปได้

                            var objCheckListBox = document.getElementById('<%= ChkVoucher.ClientID %>');
                            var chkBoxCount = objCheckListBox.getElementsByTagName("input");
                            var chkLoop;
                            for (var j = 0; j < chkBoxCount.length; j++) {
                                if (chkBoxCount[j].checked == true) { chkLoop = 1; break; }
                            }
                            if (chkLoop == 1) {
                                Disable('btnNextMember', false);
                            } else {
                                Disable('btnNextMember', true);

                            }

                            break;
                    }
                }
            }
        }
        //สำหรับกลับพาเนลหลักของการเลือกเงื่อนไขของโปรโมชั่น
        function BackToSection(id) {
            ShowRows('btnBackToEditPromo');
            switch (id) {
                case '1':
                    //Row data
                    HidedRows('Section_MemberGroup');
                    ShowRows('Section_PromotionType');
                    HidedRows('Section_StaffGroup');
                    HidedRows('Section_Coupon');
                    HidedRows('Section_Voucher');
                    HidedRows('Section_ConditionDiscount');
                    //button
                    ShowRows('btnNextPromoType');
                    HidedRows('btnBackMemberToPromoType');
                    HidedRows('btnNextMember');
                    HidedRows('btnSavePromo');
                    break;
                default:
                    alert('');
            }
        }
        // สำหรับซ่อนพาเนลของเงื่อนไขโปรโมชั่น
        function HidedRows(id) {
            if (document.getElementById) {
                document.getElementById(id).style.display = 'none';
            }
        }
        // สำหรับเปิดแสดงพาเนลของเงื่อนไขโปรโมชั่น
        function ShowRows(id) {
            if (document.getElementById) {
                document.getElementById(id).style.display = '';
            }
        }
        // สำหรับปิดการใช้งาน Control
        function Disable(id, boolean) {
            if (document.getElementById) {
                document.getElementById(id).disabled = boolean;
            }
        }
    </script>

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
            <td width="3%" height="1">
            </td>
            <td width="94%">
            </td>
            <td width="3%">
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
                <table style="width: 600px;">
                    <tr>
                        <td align="right">
                            <asp:HyperLink ID="lbBackToHomePage" runat="server" NavigateUrl="~/Promotions/promotion_setup.aspx">Home Page</asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:Label ID="lbPromoName" runat="server" CssClass="headerText"></asp:Label></td>
                    </tr>
                    <tr id="Section_PromotionType">
                        <td>
                            <fieldset>
                                <legend><asp:Label ID="lf1" runat="server" Text="Select promotion type."></asp:Label></legend>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="PlPromoType" runat="server" Height="150px" ScrollBars="Auto" Width="550px">
                                                <asp:RadioButtonList ID="RdoPromoType" runat="server">
                                                </asp:RadioButtonList>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr id="Section_StaffGroup" style="display: none;">
                        <td>
                            <fieldset>
                                <legend>Select staff group</legend>
                                <table>
                                    <tr>
                                        <td>
                                            <a href="javascript:OnChangeCheckBox1(1)">Select&nbsp;All</a> - <a href="javascript:OnChangeCheckBox1(2)">
                                                Clear&nbsp;All</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Pl1" runat="server" Height="150px" ScrollBars="Auto" Width="550px"
                                                Style="border: solid 1px rgb(236, 233,216);">
                                                <asp:CheckBoxList ID="ChkPromoStaff" runat="server" onClick="CheckSeleStaffForDisableButton();">
                                                </asp:CheckBoxList>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr id="Section_Coupon" style="display: none;">
                        <td>
                            <fieldset>
                                <legend>Select Coupon</legend>
                                <table>
                                    <tr>
                                        <td>
                                            <a href="javascript:OnChangeCheckBox2(1)">Select&nbsp;All</a> - <a href="javascript:OnChangeCheckBox2(2)">
                                                Clear&nbsp;All</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Pl2" runat="server" Height="150px" ScrollBars="Auto" Width="550px"
                                                Style="border: solid 1px rgb(236, 233,216);">
                                                <asp:CheckBoxList ID="ChkPromoCoupon" runat="server" onClick="CheckSeleCouponForDisableButton();">
                                                </asp:CheckBoxList>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr id="Section_Voucher" style="display: none;">
                        <td>
                            <fieldset>
                                <legend>Select Voucher</legend>
                                <table>
                                    <tr>
                                        <td>
                                            <a href="javascript:OnChangeCheckBox3(1)">Select&nbsp;All</a> - <a href="javascript:OnChangeCheckBox3(2)">
                                                Clear&nbsp;All</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Pl3" runat="server" Height="150px" ScrollBars="Auto" Width="550px"
                                                Style="border: solid 1px rgb(236, 233,216);">
                                                <asp:CheckBoxList ID="ChkVoucher" runat="server" onClick="CheckSeleVoucherForDisableButton();">
                                                </asp:CheckBoxList>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr id="Section_MemberGroup" style="display: none;">
                        <td>
                            <fieldset>
                                <legend>Select Member Group</legend>
                                <table>
                                    <tr>
                                        <td>
                                            <a href="javascript:OnChangeCheckBox4(1)">Select&nbsp;All</a> - <a href="javascript:OnChangeCheckBox4(2)">
                                                Clear&nbsp;All</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Pl4" runat="server" Height="150px" ScrollBars="Auto" Width="550px"
                                                Style="border: solid 1px rgb(236, 233,216);">
                                                <asp:CheckBoxList ID="ChkMemberGroup" runat="server" onClick="CheckSeleMemberForDisableButton();">
                                                </asp:CheckBoxList>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr id="Section_ConditionDiscount" style="display: none;">
                        <td>
                            <fieldset>
                                <legend><asp:Label ID="lf2" runat="server" Text="Select Discount"></asp:Label></legend>
                                <table style="width: 600px;">
                                    <tr>
                                        <td>
                                            <fieldset>
                                                <legend><asp:Label ID="lf3" runat="server" Text="Promotion base on"></asp:Label></legend>
                                                <table style="width: 550px;">
                                                    <tr>
                                                        <td>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 100px;">
                                                                        <asp:RadioButton ID="RdoPieceAmount" runat="server" GroupName="dd" Text="Piece" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 100px;">
                                                                        <asp:RadioButton ID="RdoBathAmount" runat="server" GroupName="dd" Text="price" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <fieldset>
                                                <legend><asp:Label ID="lf4" runat="server"
                                                    Text="Amount specified above for the product."></asp:Label></legend>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:RadioButton ID="RdoProductSame" runat="server" Text="Product same" GroupName="dp" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:RadioButton ID="RdoProductdifferent" runat="server" Text="Product different"
                                                                Checked="true" GroupName="dp" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <fieldset>
                                                <legend>
                                                    <asp:Label ID="Lb5" runat="server" Text="Set condition total price."></asp:Label></legend>
                                                <table>
                                                    <tr>
                                                        <td align="left">
                                                            <asp:Label ID="Lb7" runat="server" Text="Total price product is over."></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="TxtOverPrice" runat="server" Width="70px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Label ID="Lb6" runat="server" Text="Sorting price."></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="DDlDiscountMinpriceToMax" runat="server">
                                                                <asp:ListItem Value="1">The Highest price first.</asp:ListItem>
                                                                <asp:ListItem Value="0">The lowest first prices.</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table style="width: 600px;">
                                <tr>
                                    <td>
                                        <input type="button" id="btnBackToEditPromo" value="Back" runat="server" />
                                        <input type="button" id="btnNextPromoType" onclick="NextPromoType();" value="Next" />
                                        <input type="button" id="btnBackMemberToPromoType" onclick="BackToSection('1');"
                                            value="Back" style="display: none;" />
                                        <input type="button" id="btnNextMember" onclick="NextConditionDiscount();" value="Next"
                                            style="display: none;" />
                                        <input type="button" id="btnSavePromo" runat="server" value="Next" style="display: none;" />
                                    </td>
                                    <td align="right">
                                        <input type="button" id="btnCancel" value="Home Page" runat="server" visible="false" />
                                    </td>
                                </tr>
                            </table>
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
