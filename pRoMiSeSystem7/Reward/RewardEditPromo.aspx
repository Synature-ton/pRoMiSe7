<%@ page language="C#" masterpagefile="~/MasterPage/MasterPage.master" autoeventwireup="true" inherits="RewardEditPromo, App_Web_rewardeditpromo.aspx.b7f13d75" title="Untitled Page" uiculture="th-TH" culture="th-TH" enableEventValidation="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/StyleSheet.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .altrowstyle
        {
            background-color: #C8D3DC;
        }
        .Td1
        {
            width: 250px;
            text-align: right;
        }
        .Td2
        {
            text-align: left;
        }
        .Td3
        {
            width: 200px;
            text-align: right;
        }
        .Td4
        {
            width: 350px;
            text-align: left;
        }
        .fieldset
        {
            border: 1px solid #61B5CF;
            margin: 20px auto;
            margin-bottom: 0px;
            padding: 0px;
            padding-bottom: 20px;
            text-align: left;
        }
        .legend
        {
            font: bold 12px Tahoma,Arial, Helvetica, sans-serif;
            color: #00008B; /* background-color: #FFFFFF;*/
        }
        .th_label
        {
            font-family: Tahoma;
            font-size: 12px;
            font-weight: bold;
            margin-right: 5px;
        }
        .star_label
        {
            color: Red;
        }
        .txtwidth_250
        {
            width: 250px;
            margin-left: 5px;
        }
        .txtwidth_150
        {
            width: 150px;
            margin-left: 5px;
        }
        .style1
        {
            text-align: right;
        }
        .style2
        {
            text-align: left;
        }
        .style3
        {
            width: 150px;
            text-align: right;
        }
        .style4
        {
            width: 400px;
            text-align: left;
        }
        #bntAddProduct
        {
            width: 120px;
        }
        .txtNote
        {
            height: 70px;
            width: 280px;
            margin-left: 5px;
        }
        .container
        {
            /* So the overflow scrolls */
            overflow: auto;
            position: relative; /* Style */
            border: 0px solid black;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="Label1" runat="server" Text="Reward Edit"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <div style="text-align: center; width: 100%">
        <fieldset class="fieldset" style="width: 100%">
            <legend class="legend"><%--<span style="text-align: center">จัดการการให้แต้มสะสม</span><br />--%>
                <span>Reward Edit</span> </legend>
            <table id="tbHead" width="100%">
                <tbody>
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td style="text-align: right; padding-right: 20px;">
                            <a href="javaScript:location.replace('RewardManagement.aspx');"><span style="color: Blue;
                                font-size: 16px; font-family: Tahoma;">
                                <asp:Label ID="lbBack" runat="server" Text=""></asp:Label></span></a>
                        </td>
                    </tr>
                    <tr>
                        <td class="" colspan="4" style="text-align: center; font-size: 25px; color: Blue;
                            font-family: BrowalliaUPC; font-weight: bold;">
                            <asp:Label ID="lbHeader" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="Td1">
                        </td>
                        <td class="Td2">
                        </td>
                        <td class="Td3">
                        </td>
                        <td class="Td4">
                        </td>
                    </tr>
                    <tr>
                        <td class="Td1">
                            <div>
                                <span class="star_label">*</span><span class="th_label"><asp:Label ID="Label2" runat="server" Text=""></asp:Label></span></div>
                        </td>
                        <td class="Td2">
                            <asp:TextBox ID="txtName" runat="server" class="txtwidth_250"></asp:TextBox>
                        </td>
                        <td class="Td3">
                        </td>
                        <td class="Td4">
                        </td>
                    </tr>
                    <tr>
                        <td class="Td1">
                            <div>
                                <span class="star_label">*</span><span class="th_label"><asp:Label ID="Label3" runat="server" Text=""></asp:Label></span></div>
                        </td>
                        <td class="Td2">
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <asp:TextBox ID="TxtStartDate" runat="server" class="txtwidth_150"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBtnStart" ImageUrl="~/Images/Calendar_scheduleHS.png" runat="server"
                                        Width="16px" Height="16px" />
                                    <cc1:CalendarExtender ID="CalendarStart" runat="server" PopupButtonID="ImgBtnStart"
                                        TargetControlID="TxtStartDate" CssClass="MyCalendar" Format="dd/MM/yyyy" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td class="Td3">
                            <div>
                                <span class="star_label">*</span><span class="th_label"><asp:Label ID="Label4" runat="server" Text=""></asp:Label></span></div>
                        </td>
                        <td class="Td4">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:TextBox ID="txtEndDate" runat="server" class="txtwidth_150"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBtnEnd" ImageUrl="~/Images/Calendar_scheduleHS.png" runat="server"
                                        Width="16px" Height="16px" />
                                    <cc1:CalendarExtender ID="CalendarEnd" runat="server" PopupButtonID="ImgBtnEnd" TargetControlID="TxtEndDate"
                                        CssClass="MyCalendar" Format="dd/MM/yyyy" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="Td1">
                            <div>
                                <span class="star_label">*</span><span class="th_label"><asp:Label ID="Label5" runat="server" Text=""></asp:Label></span></div>
                        </td>
                        <td class="Td2" colspan="3">
                            <asp:DropDownList ID="DdlReward" Style="margin-left: 5px;" runat="server" AutoPostBack="false">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="Td1">
                            <div>
                                <span class="star_label">*</span><span class="th_label"><asp:Label ID="Label6" runat="server" Text=""></asp:Label></span></div>
                        </td>
                        <td class="Td2">
                            <asp:TextBox ID="txtPerPrice" class="txtwidth_150" runat="server"></asp:TextBox>
                        </td>
                        <td class="Td3">
                            <div>
                                <span class="star_label">*</span><span class="th_label"><asp:Label ID="Label7" runat="server" Text=""></asp:Label></span></div>
                        </td>
                        <td class="Td4">
                            <asp:TextBox ID="txtPoint" class="txtwidth_150" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Td1">
                            <div>
                                <span class="star_label">*</span><span class="th_label"><asp:Label ID="Label8" runat="server" Text=""></asp:Label></span></div>
                        </td>
                        <td class="Td2">
                            <asp:TextBox ID="txtStartPrice" class="txtwidth_150" runat="server"></asp:TextBox>
                        </td>
                        <td class="Td3">
                            <div>
                                <span class="star_label">*</span><span class="th_label"><asp:Label ID="Label9" runat="server" Text=""></asp:Label></span></div>
                        </td>
                        <td class="Td4">
                            <asp:DropDownList ID="DdlRoundingUp" Style="margin-left: 5px;" runat="server" AutoPostBack="false">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="Td1">
                            <div>
                                <span class="th_label"><asp:Label ID="Label10" runat="server" Text=""></asp:Label></span></div>
                        </td>
                        <td class="" rowspan="3">
                            <asp:TextBox ID="txtNote" CssClass="txtNote" TextMode="MultiLine" runat="server"></asp:TextBox>
                        </td>
                        <td class="Td3">
                        </td>
                        <td class="Td4">
                        </td>
                    </tr>
                    <tr>
                        <td class="Td1">
                        </td>
                        <td class="Td3">
                        </td>
                        <td class="Td4">
                        </td>
                    </tr>
                    <tr>
                        <td class="Td1">
                        </td>
                        <td class="Td3">
                        </td>
                        <td class="Td4">
                        </td>
                    </tr>
                    <tr>
                        <td class="Td1">
                            <div>
                                <span class="star_label">*</span><span class="th_label"><asp:Label ID="Label11" runat="server" Text=""></asp:Label></span></div>
                        </td>
                        <td class="Td2">
                            <input name="ckRdoActive" value="Y" type="radio" checked />
                            <span class="th_label" style="color: #00008B"><asp:Label ID="Label12" runat="server" Text=""></asp:Label></span>
                            <input name="ckRdoActive" value="N" type="radio" />
                            <span class="th_label" style="color: #00008B"><asp:Label ID="Label13" runat="server" Text=""></asp:Label></span>
                        </td>
                        <td class="Td3">
                        </td>
                        <td class="Td4">
                        </td>
                    </tr>
                    <tr>
                        <td class="Td1">
                        </td>
                        <td class="Td2">
                        </td>
                        <td class="Td3">
                        </td>
                        <td class="Td4">
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="Td2" colspan="4">
                            <div style="text-align: center; padding-right: 0px">
                                <asp:Button ID="bntUpdate" runat="server" Text="" OnClick="bntUpdate_Click"
                                    Width="150px" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="background-color: ButtonFace;">
                        </td>
                    </tr>
                    <tr>
                        <td class="Td1">
                        </td>
                        <td class="Td2">
                            &nbsp;
                        </td>
                        <td class="Td3">
                        </td>
                        <td class="Td4">
                        </td>
                    </tr>
                </tbody>
            </table>
            <table id="tProduct" width="100%">
                <thead>
                    <tr>
                        <th width="10%">
                        </th>
                        <th width="70%">
                        </th>
                        <th width="20%">
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="3" style="text-align: center; font-size: 25px; color: Blue; font-family: BrowalliaUPC;
                            font-weight: bold; padding-right: 10px;">
                            <asp:Label ID="lbHeader2" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="text-align: right; padding-right: 10px; padding-top: 20px">
                            <div style="text-align: right; margin-right: 20px">
                                <asp:UpdatePanel ID="update1" runat="server">
                                    <ContentTemplate>
                                        <input id="bntAddProduct" name="bntAddProduct" type="button" value="Add Product"
                                            onclick="javaScript:location.replace('RewardManagementAdd.aspx');" />
                                        <asp:Button ID="bntDeleteProduct" runat="server" Text="Delete" OnClick="bntDeleteProduct_Click"
                                            Width="120px" Style="margin-left: 20px" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div style="text-align: left;">
                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                    <ContentTemplate>
                                        <asp:LinkButton ID="LinkButtonSelectPro" runat="server" OnClick="LinkButtonSelectPro_Click">Select - All</asp:LinkButton>
                                        &nbsp; &nbsp;
                                        <asp:LinkButton ID="LinkButtonClearPro" runat="server" OnClick="LinkButtonClearPro_Click">Clear - All</asp:LinkButton>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div class="container" style="width: 100%; height: 400px;">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="GvProduct" runat="server" BackColor="White" BorderColor="#6666FF"
                                            BorderStyle="Solid" BorderWidth="1px" CellPadding="3" EmptyDataText=""
                                            EmptyDataRowStyle-ForeColor="Red" AutoGenerateColumns="False" Width="100%">
                                            <RowStyle ForeColor="#000066" Font-Names="BrowalliaUPC" Font-Size="18px" />
                                            <EmptyDataRowStyle ForeColor="Red" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="#" HeaderStyle-Width="70px" HeaderStyle-CssClass="tdHeader">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="ckID" runat="server" Text="delete"></asp:CheckBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ProductID" HeaderText="" HeaderStyle-CssClass="tdHeader"
                                                    ItemStyle-CssClass="itemText" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="center">
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ProductCode" HeaderText="" HeaderStyle-CssClass="tdHeader"
                                                    ItemStyle-CssClass="itemText" ItemStyle-HorizontalAlign="center">
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ProductGroupName" HeaderText="" HeaderStyle-CssClass="tdHeader"
                                                    ItemStyle-CssClass="itemText" />
                                                <asp:BoundField DataField="ProductDeptName" HeaderText="" HeaderStyle-CssClass="tdHeader"
                                                    ItemStyle-CssClass="itemText" />
                                                <asp:BoundField DataField="ProductName" HeaderText="" HeaderStyle-CssClass="tdHeader"
                                                    ItemStyle-CssClass="itemText" />
                                            </Columns>
                                            <EmptyDataTemplate>
                                                <div style="float: left; text-align: center; width: 100%;">
                                                    <table cellspacing="0" cellpadding="3" border="1" style="border-collapse: collapse;
                                                        width: 100%;">
                                                        <tr style="color: White; background-color: #507093; font-family: BrowalliaUPC;
                                                            font-size: 18px; font-weight: bold;">
                                                            <th scope="col" class="tdHeader" >
                                                                #
                                                            </th>
                                                            <th scope="col" class="tdHeader" >
                                                                Product Code
                                                            </th>
                                                            <th scope="col" class="tdHeader" >
                                                                Product Dept
                                                            </th>
                                                            <th scope="col" class="tdHeader" >
                                                                Product Group
                                                            </th>
                                                            <th scope="col" class="tdHeader" >
                                                                Product Name
                                                            </th>
                                                        </tr>
                                                        <tr style="color: rgb(0, 0, 102); font-family: BrowalliaUPC; font-size: 18px;" onmouseout="this.style.backgroundColor=currentcolor"
                                                            onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#CCCCCC'">
                                                            <td colspan="5" align="center">
                                                                <span style="text-align: center; font-size: 18px; color: red; font-family: BrowalliaUPC;
                                                                    font-weight: bold">No Data.</span>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </EmptyDataTemplate>
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle BackColor="#507093" Font-Bold="True" ForeColor="White" Font-Names="BrowalliaUPC"
                                                Font-Size="20px" />
                                            <AlternatingRowStyle CssClass="altrowstyle" />
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                </tbody>
            </table>
        </fieldset>
    </div>

    <script type="text/javascript">
    
     function ShowProduct() {
           document.getElementById('tProduct').style.display = ''; 
        }
        
         function ShowCoupon() {
           document.getElementById('tProduct').style.display = 'none'; 
        }
    <%=script %>
    <%=scriptRadio %>
    
 
    
    </script>

</asp:Content>
