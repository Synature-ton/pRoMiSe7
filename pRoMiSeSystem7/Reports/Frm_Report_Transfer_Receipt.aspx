<%@ page language="VB" autoeventwireup="false" inherits="Reports_Frm_Report_Transfer_Receipt, App_Web_frm_report_transfer_receipt.aspx.dfa151d5" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<html>
<head runat="server">
    <title>รายงานรับและโอนสินค้า</title>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/StyleSheet.css" rel="stylesheet" type="text/css" />
    <%-- <meta http-equiv="Page-Enter" content="blendTrans(Duration=1)" />
    <meta http-equiv="Page-Exit" content="blendTrans(Duration=1)" />--%>

    <script src="../StyleSheet/GridRowSelection.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" 
        AsyncPostBackTimeout="60000" EnableScriptGlobalization="True" 
        EnableScriptLocalization="True">
    </asp:ScriptManager>
    <div>
        <table border="0" cellpadding="0" cellspacing="0" width="98%" bgcolor="White">
            <tr bgcolor="eeeeee">
                <td height="35" nowrap background="../images/headerstub.jpg">
                    &nbsp; &nbsp;
                </td>
                <td colspan="2" background="../images/headerbg2000.jpg">
                    <b class="headerText">
                        <asp:Label ID="lblHeader" runat="server" Text="รายงานรับและโอนสินค้า"></asp:Label>
                    </b>
                </td>
                <td width="1" nowrap rowspan="99" bgcolor="003366">
                    <img src="../images/clear.gif" height="1" width="1">
                </td>
            </tr>
            <tr bgcolor="666666">
                <td width="3%" height="1">
                    <p style="line-height: 1px;">
                        <img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p>
                </td>
                <td width="94%">
                    <p style="line-height: 1px;">
                        <img src="../images/clear.gif" height="1" width="1" border="0" hspace="252"></p>
                </td>
                <td width="3%">
                    <p style="line-height: 1px;">
                        <img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p>
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
                    <div>
                        <table style="width: 800px; height: 100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td valign="top" align="left" width="40%">
                                    <asp:Panel ID="PanelProductLevel" runat="server" Width="100%" BorderColor="Silver">
                                        <asp:UpdatePanel ID="UpdatePanelProductlevel" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <table style="width: 100%; height: 100%" class="text">
                                                    <tr>
                                                        <td valign="top" align="left" width="120">
                                                            <asp:Label ID="lblstatus" runat="server" Text="สถานะ"></asp:Label>
                                                        </td>
                                                        <td valign="top" align="left">
                                                            <asp:DropDownList ID="DdlStatus" runat="server" AutoPostBack="True" Width="200px">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" align="left" width="120">
                                                            <asp:Label ID="lbllocation" runat="server" Text="เลือกคลัง   :"></asp:Label>
                                                        </td>
                                                        <td valign="top" align="left">
                                                            <asp:DropDownList ID="DDlProLevel" runat="server" Width="200px" AutoPostBack="True">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" align="left">
                                                            <asp:Label ID="LblToProLevel" runat="server" Text="ไปยังคลัง  :"></asp:Label>
                                                        </td>
                                                        <td valign="top" align="left">
                                                            <asp:DropDownList ID="DDlToProLevel" runat="server" Width="200px">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" align="left">
                                                            <asp:Label ID="lblReports" runat="server" Text="รายงาน  :"></asp:Label>
                                                        </td>
                                                        <td valign="top" align="left">
                                                            <asp:DropDownList ID="DdlSelectReport" runat="server" Width="200px" AutoPostBack="True">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" valign="top">
                                                            <asp:Label ID="LblSelectReportType" runat="server" Text="รูปแบบรายงาน  :"></asp:Label>
                                                        </td>
                                                        <td align="left" valign="top">
                                                            <asp:DropDownList ID="DdlReportType" runat="server" AutoPostBack="True" Width="200px">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="DDlProLevel" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="DdlSelectReport" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="DdlReportType" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </asp:Panel>
                                </td>
                                <td valign="top" align="left" class="text">
                                    <asp:Panel ID="PnlProduct" runat="server" Height="100%" Width="100%" BorderColor="Silver">
                                        <asp:UpdatePanel ID="UpdatePanelProduct" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <table style="width: 100%; height: 100%" class="text">
                                                    <tr>
                                                        <td valign="top" align="left" width="120">
                                                            <asp:Label ID="lblGroupMeterial" runat="server" Text="กลุ่มสินค้า  :"></asp:Label>
                                                        </td>
                                                        <td valign="top" align="left">
                                                            <asp:DropDownList ID="DDlGrpMaterial" runat="server" Width="200px" AutoPostBack="True"
                                                                OnSelectedIndexChanged="DDlGrpMaterial_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                            &nbsp; &nbsp;
                                                            <asp:Button ID="BtnShowSum" runat="server" Text="แสดงข้อมูลแบบสรุป" Width="120px"
                                                                OnClick="BtnShowSum_Click" />
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" align="left">
                                                            <asp:Label ID="lblDeptMaterial" runat="server" Text="หมวดสินค้า  :"></asp:Label>
                                                        </td>
                                                        <td valign="top" align="left">
                                                            <asp:DropDownList ID="DDLDeptMaterial" runat="server" Width="200px" OnSelectedIndexChanged="DDLDeptMaterial_SelectedIndexChanged"
                                                                AutoPostBack="True">
                                                            </asp:DropDownList>
                                                            &nbsp; &nbsp;
                                                            <asp:Button ID="BtnShowData" runat="server" Text="แสดงข้อมูลทั้งหมด" Width="120px"
                                                                OnClick="BtnShowData_Click" />
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" align="left">
                                                            <asp:Label ID="lblMaterials" runat="server" Text="สินค้า  :"></asp:Label>
                                                        </td>
                                                        <td valign="top" align="left">
                                                            <asp:DropDownList ID="DDlMaterial" runat="server" Width="200px">
                                                            </asp:DropDownList>
                                                            &nbsp; &nbsp;
                                                            <asp:Button ID="BtnReport" runat="server" Text="ตัวอย่างก่อนพิมพ์" Width="120px"
                                                                Enabled="False" OnClick="BtnReport_Click" /><br />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="DDlGrpMaterial" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="DDlDeptMaterial" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="DDlMaterial" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="DdlSelectReport" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1" valign="top" align="left">
                                    <asp:Panel ID="PanelDate" runat="server" Height="100%" Width="100%" BorderColor="Silver">
                                        <asp:UpdatePanel ID="UpdatePanelDate" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <table style="width: 100%; height: 100%" class="text">
                                                    <tr>
                                                        <td valign="top" align="left" width="120">
                                                            <asp:Label ID="lblStartDate" runat="server" Text="ตั้งแต่วันที่  :" />
                                                        </td>
                                                        <td valign="top" align="left">
                                                            <asp:TextBox ID="TxtStartDate" runat="server" BackColor="PapayaWhip" BorderColor="White"
                                                                Width="150px"></asp:TextBox>
                                                            <asp:ImageButton ID="ImgBtnStart" ImageUrl="~/Images/Calendar_scheduleHS.png" runat="server"
                                                                Width="16px" Height="16px" />
                                                            <cc1:CalendarExtender ID="CalendarStart" runat="server" PopupButtonID="ImgBtnStart"
                                                                TargetControlID="TxtStartDate" CssClass="MyCalendar" Format="dd/MM/yyyy" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" align="left">
                                                            <asp:Label ID="lblEndDate" runat="server" Text="จนถึงวันที่  :" />
                                                        </td>
                                                        <td valign="top" align="left">
                                                            <asp:TextBox ID="TxtEndDate" runat="server" BackColor="PapayaWhip" BorderColor="White"
                                                                Width="150px" />
                                                            <asp:ImageButton ID="ImgBtnEnd" ImageUrl="~/Images/Calendar_scheduleHS.png" runat="server"
                                                                Width="16px" Height="16px" />
                                                            <cc1:CalendarExtender ID="CalendarEnd" runat="server" PopupButtonID="ImgBtnEnd" TargetControlID="TxtEndDate"
                                                                CssClass="MyCalendar" Format="dd/MM/yyyy" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ImgBtnStart" EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="ImgBtnEnd" EventName="Click" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        &nbsp;
                                    </asp:Panel>
                                </td>
                                <td colspan="2" valign="top" align="left">
                                    <table style="width: 100%;" class="text">
                                        <tr>
                                            <td align="left">
                                                <asp:UpdatePanel ID="UpdateVendorGr" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <table style="height: 100%; width: 100%" class="text">
                                                            <tr>
                                                                <td valign="top" align="left" width="120">
                                                                    <asp:Label ID="lblVendorGroup1" runat="server" Text="กลุ่มผู้จัดจำหน่าย   :"></asp:Label>
                                                                </td>
                                                                <td valign="top" align="left">
                                                                    <asp:DropDownList ID="DDlVendorGroup" OnSelectedIndexChanged="DDlVendorGroup_SelectedIndexChanged"
                                                                        runat="server" Width="200px" AutoPostBack="true">
                                                                    </asp:DropDownList>
                                                                    &nbsp; &nbsp;
                                                                    <asp:Button ID="BtnShowVendor" runat="server" Text="ค้นหาผู้จัดจำหน่าย" Width="120px" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td valign="top" align="left">
                                                                    <asp:Label ID="lblVendor1" runat="server" Text="ชื่อผู้จัดจำหน่าย  :"></asp:Label>
                                                                </td>
                                                                <td valign="top" align="left">
                                                                    <asp:DropDownList ID="DdlVendor" runat="server" Width="200px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="DDlVendorGroup" EventName="SelectedIndexChanged" />
                                                        <asp:AsyncPostBackTrigger ControlID="DdlVendor" EventName="SelectedIndexChanged" />
                                                        <asp:AsyncPostBackTrigger ControlID="BtnSelectVendor" EventName="Click" />
                                                        <asp:AsyncPostBackTrigger ControlID="DdlSelectReport" EventName="SelectedIndexChanged" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 40px" align="center">
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                        <ProgressTemplate>
                                            &nbsp;&nbsp;
                                            <img src="../Images/loading3.gif" width="25" height="25" />&nbsp;
                                            <asp:Label ID="lblLoading1" runat="server" Text="กรุณารอสักครู่..."></asp:Label>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 100%" valign="top">
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="PanelHide" runat="server">
                        </asp:Panel>
                        <asp:Panel ID="Panel1" runat="server">
                        </asp:Panel>
                    </div>
                    <asp:Label ID="LblSession" runat="server" Visible="False" CssClass="lbl">
                    </asp:Label><asp:Label ID="LblId" runat="server" Text="-1" Visible="False"></asp:Label>
                    <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="Panel1"
                        PopupControlID="PnlSelectVendor" BackgroundCssClass="modalBackground" DropShadow="true"
                        CancelControlID="BtnCancelVendor" PopupDragHandleControlID="Pnl2">
                    </cc1:ModalPopupExtender>
                    <asp:Panel ID="PnlSelectVendor" runat="server" CssClass="modalPopup5" style="display:none;">
                        <asp:Panel ID="Pnl2" runat="server" Style="cursor: move; background-color: #E0ECFF;
                            border: solid 1px Gray; color: Black">
                            <p>
                                &nbsp;</p>
                        </asp:Panel>
                        <table style="width: 100%; background-color:#F7F7F7;" class="text">
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="UPdateSelectSearch" runat="server">
                                        <ContentTemplate>
                                            <p>
                                                <asp:Label ID="lblSearchType" runat="server" Text="เลือกรูปแบบการค้นหา"></asp:Label>
                                                <br />
                                                <asp:RadioButtonList ID="RdoSelect" runat="server" TextAlign="Right">
                                                    <asp:ListItem Selected="True" Value="0">รหัสผุ้จัดจำหน่าย</asp:ListItem>
                                                    <asp:ListItem Value="1">ชื่อผุ้จัดจำหน่าย</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </p>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                                <td valign="top">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td valign="top" width="30%">
                                                <asp:Label ID="LblSelectVendorGroup" runat="server" Width="120px" Text="กลุ่มผู้จัดจำหน่าย"></asp:Label>
                                            </td>
                                            <td valign="top" width="30%">
                                                <asp:DropDownList ID="DdlvendorGroup1" runat="server" Width="155px">
                                                </asp:DropDownList>
                                            </td>
                                            <td valign="top">
                                                &nbsp;
                                                <asp:Button ID="BtnSearch" runat="server" Text="ค้นหา" Width="150px" />
                                            </td>
                                        </tr>
                                        <tr valign="top">
                                            <td valign="top">
                                                <asp:Label ID="LblSelectVendor" runat="server" Text="ชื่อผู้จัดจำหน่าย"></asp:Label>
                                            </td>
                                            <td valign="top">
                                                <asp:TextBox ID="TxtSearch" runat="server" Width="150px"></asp:TextBox>
                                            </td>
                                            <td valign="top" align="left">
                                                &nbsp;
                                                <asp:Button ID="BtnCancelVendor" runat="server" Text="ยกเลิก" Width="150px" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="UpdateSearchBy" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <table style="width: 100%">
                                                <tr>
                                                    <td valign="top" align="left">
                                                        <asp:DropDownList ID="DdlSearchBy" runat="server" Width="200px">
                                                            <asp:ListItem Value="0">ค้นหาคำเฉพาะที่ขึ้นต้นคำ</asp:ListItem>
                                                            <asp:ListItem Value="1">ค้นหาคำเฉพาะที่ลงท้ายคำ</asp:ListItem>
                                                            <asp:ListItem Value="2">ค้นหาคำ ทั้งประโยค</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top">
                                                        <asp:DropDownList ID="DdlOrderBy" runat="server" Width="200px">
                                                            <asp:ListItem Value="0">เรียงตามกลุ่มผู้จัดจำหน่าย</asp:ListItem>
                                                            <asp:ListItem Value="1">เรียงตามชื่อผู้จัดจำหน่าย</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="DdlOrderBy" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="DdlSearchBy" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                    <asp:UpdateProgress ID="UpdateProgressVendor" runat="server" DisplayAfter="100">
                                        <ProgressTemplate>
                                            &nbsp;<img src="../Images/loading3.gif" style="width: 32px; height: 32px" />
                                            <asp:Label ID="lblLoading2" runat="server" Text="Loading ..."></asp:Label>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                                <td valign="top">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td valign="top" width="30%">
                                                <asp:Label ID="LblVendorGroupSelect" runat="server" Text="รหัสผู้จัดจำหน่ายทีเลือก"></asp:Label>
                                            </td>
                                            <td valign="top" width="30%">
                                                <asp:TextBox ID="TxtVendorId" runat="server" BackColor="#FFE0C0" Width="150px"></asp:TextBox>
                                                <asp:Label ID="Label6" runat="server" Visible="True"></asp:Label>&nbsp;
                                            </td>
                                            <td align="left" valign="top">
                                                <asp:Button ID="BtnSelectVendor" runat="server" Text="เลือกผู้จัดจำหน่าย" Width="150px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <asp:Label ID="LblVendorSelect" runat="server" Text="ชื่อผู้จัดจำหน่ายทีเลือก"></asp:Label>
                                            </td>
                                            <td valign="top" colspan="2">
                                                <asp:TextBox ID="TxtVendorName" runat="server" BackColor="#FFE0C0" Width="300px"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 200px;" valign="top">
                                    <asp:UpdatePanel ID="UpdatePanelSelectVendor" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="GrviewVendor" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                CellPadding="4" ForeColor="#333333" Width="100%" EmptyDataText="--ไม่พบข้อมูลผู้จัดจำหน่าย--">
                                                <Columns>
                                                    <asp:BoundField DataField="VendorID" HeaderText="VendorID" ReadOnly="True" Visible="False" />
                                                    <asp:BoundField DataField="VendorCode" HeaderText="รหัสกลุ่มผู้จัดจำหน่าย" ReadOnly="True" />
                                                    <asp:BoundField DataField="VendorName" HeaderText="ชื่อผู้จัดจำหน่าย" ReadOnly="True" />
                                                    <asp:BoundField DataField="VendorGroupID" HeaderText="VendorGroupID" ReadOnly="True"
                                                        Visible="False" />
                                                    <asp:BoundField DataField="VendorGroupName" HeaderText="กลุ่มผู้จัดจำหน่าย" ReadOnly="True" />
                                                </Columns>
                                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                <RowStyle BackColor="#F7F6F3" CssClass="smalltext" ForeColor="#333333" />
                                                <EditRowStyle BackColor="#999999" />
                                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                <HeaderStyle BackColor="#5D7B9D" CssClass="smallTdHeader" Font-Bold="True" ForeColor="White" />
                                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                            </asp:GridView>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="BtnSearch" EventName="Click"></asp:AsyncPostBackTrigger>
                                            <asp:AsyncPostBackTrigger ControlID="GrviewVendor" EventName="RowDataBound"></asp:AsyncPostBackTrigger>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                    <asp:Label ID="LblReport" runat="server" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <br />
                    <asp:UpdatePanel ID="UpdateGr" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="GrView" runat="server" Width="100%"
                                AllowPaging="True" PageSize="100" EmptyDataText="-- ไม่พบข้อมูล --"
                                CssClass="smalltext" BackColor="White" BorderColor="#3366CC" 
                                BorderStyle="None" BorderWidth="1px" CellPadding="4">
                                <RowStyle Wrap="False" BackColor="White" CssClass="smalltext"/>
                                <EmptyDataRowStyle BorderStyle="None" HorizontalAlign="Center" ForeColor="#003399" />
                                <FooterStyle BackColor="#F1EDED" ForeColor="#003399" />
                                <PagerStyle BackColor="#F1EDED" ForeColor="#003399" HorizontalAlign="Left" />
                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" BackColor="#507093" CssClass="tdHeader" />
                                <PagerSettings FirstPageText="First" LastPageText="Last" NextPageText="Next" Mode="Numeric" Position="TopAndBottom" Visible="True" />
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GrView" EventName="PageIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="BtnShowData" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="BtnShowSum" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <asp:Label ID="LblSelectReport" runat="server" Visible="False" CssClass="lbl"></asp:Label>
                    <asp:Label ID="LblGroupID" runat="server" Visible="False">-1</asp:Label><br />
                    <div>
                        <asp:Label ID="LblSelectBtnShowAllORShowSum" runat="server" Visible="False"></asp:Label>&nbsp;
                        <asp:Label ID="LBlSelectHeader" runat="server" Visible="False"></asp:Label>&nbsp;
                    </div>
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
                <td height="1" colspan="3" bgcolor="999999">
                    <p style="line-height: 1px;">
                        <img src="../images/clear.gif" height="1" width="1"></p>
                </td>
            </tr>
            <tr>
                <td height="50" colspan="3" background="../images/footerbg2000.gif">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td height="1" colspan="3" bgcolor="999999">
                    <p style="line-height: 1px;">
                        <img src="../images/clear.gif" height="1" width="1"></p>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
