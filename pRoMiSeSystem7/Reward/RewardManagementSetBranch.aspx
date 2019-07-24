<%@ page language="C#" masterpagefile="~/MasterPage/MasterPage.master" autoeventwireup="true" inherits="RewardManagementSetBranch, App_Web_rewardmanagementsetbranch.aspx.b7f13d75" title="Untitled Page" enableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" type="text/css" href="../StyleSheet/admin.css" />
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/StyleSheet.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .altrowstyle
        {
            background-color: #C8D3DC;
        }
        .Td1
        {
            text-align: right;
        }
        .Td2
        {
            text-align: left;
        }
        .Td3
        {
            text-align: right;
        }
        .Td4
        {
            width: 300px;
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
        .container
        {
            /* So the overflow scrolls */
            overflow: auto;
            position: relative; /* Style */
            border: 0px solid black;
        }
        .style1
        {
            height: 14px;
        }
        .txtNote
        {
            height: 70px;
            width: 280px;
            margin-left: 5px;
        }
        #bntBack
        {
            width: 85px;
        }
        #bntAddshop
        {
            width: 120px;
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
    <asp:Label ID="Label1" runat="server" Text="Branch For Reward"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <div style="text-align: center;width:100%">
        <fieldset class="fieldset" style="width: 95%">
            <legend class="legend"><%--<span style="text-align: center">กำหนดร้านสาขา การให้แต้มสะสม</span><br />--%>
                <span>Reward For Branch</span> </legend>
            <table id="tbHead" width="100%">
                <tbody>
                    <tr>
                        <td colspan="4">
                            <table id="tProduct" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th width="20%">
                                        </th>
                                        <th width="25%">
                                        <%--<%=ss %>--%>
                                        </th>
                                        <th width="25%">
                                        </th>
                                        <th width="30%">
                                            <div style="text-align: right; padding-right: 20px;">
                                                <a href="javaScript:location.replace('RewardManagement.aspx');"><span style="color: Blue;
                                                    font-size: 16px; font-family: Tahoma;">
                                                    <asp:Label ID="lbBack" runat="server" Text=""></asp:Label></span></a>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td colspan="4">
                                            <table id="ShopShow" width="100%">
                                                <thead>
                                                    <tr>
                                                         <th width="5%">
                                                        </th>
                                                        <th width="25%">
                                                        </th>
                                                        <th width="60%">
                                                        </th>
                                                        <th width="20%">
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                        <td colspan="2" class="style1" style="text-align: center; font-size: 25px; color: Blue;
                                                            font-family: BrowalliaUPC; font-weight: bold">
                                                            <asp:Label ID="lbHeader" runat="server" Text=""></asp:Label>
                                                        </td>
                                                        <td>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3">
                                                         <div id="tdBntAddshop" style="text-align:right;margin-right:20px">
                                                         
                                                           
                                                            <asp:UpdatePanel ID="updatepanel9" runat="server">
                                                            <ContentTemplate>
                                                            <input id="bntAddshop" type="button" value="Add Shop" onclick="showPageAdd();" />
                                                            <asp:Button ID="bntDeleteShop" runat="server" Text="Delete" OnClick="bntDeleteShop_Click"
                                                                Width="150px" style="margin-left:20px"/>
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
                                                            <div id="branchShow" class="container" style="width: 100%; height: 400px;">
                                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:GridView ID="GvBranch" runat="server" BackColor="White" BorderColor="#6666FF"
                                                                            BorderStyle="Solid" BorderWidth="1px" CellPadding="3" OnRowDataBound="GvProductleve_RowDataBound"
                                                                            EmptyDataText="" EmptyDataRowStyle-ForeColor="Red" AutoGenerateColumns="False"
                                                                            Width="100%" PageSize="20">
                                                                            <RowStyle ForeColor="#000066" Font-Names="BrowalliaUPC" Font-Size="18px" />
                                                                            <EmptyDataRowStyle ForeColor="Red" />
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="#" HeaderStyle-Width="70px">
                                                                                    <ItemTemplate>
                                                                                        <asp:CheckBox ID="ckID" runat="server" Text="delete"></asp:CheckBox>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField DataField="ProductLevelID" HeaderText="ID" ItemStyle-HorizontalAlign="center" HeaderStyle-CssClass="tdHeader"  ItemStyle-CssClass="itemText"
                                                                                    HeaderStyle-Width="30px">
                                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="ProductLevelCode" HeaderText="" ItemStyle-HorizontalAlign="center" HeaderStyle-CssClass="tdHeader"  ItemStyle-CssClass="itemText"
                                                                                    HeaderStyle-Width="100px">
                                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="ProductLevelName" HeaderText="" HeaderStyle-CssClass="tdHeader"  ItemStyle-CssClass="itemText" ItemStyle-HorizontalAlign="left">
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:BoundField>
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
                                                                                                ID
                                                                                            </th>
                                                                                            <th scope="col" class="tdHeader" >
                                                                                                Shop Code
                                                                                            </th>
                                                                                            <th scope="col" class="tdHeader" >
                                                                                                Shop Name
                                                                                            </th>
                                                                                        </tr>
                                                                                        <tr style="color: rgb(0, 0, 102); font-family: BrowalliaUPC; font-size: 18px;" onmouseout="this.style.backgroundColor=currentcolor"
                                                                                            onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#CCCCCC'">
                                                                                            <td colspan="4" align="center">
                                                                                                <span style="text-align: center; font-size: 18px; color: red; font-family: BrowalliaUPC;
                                                                                                    font-weight: bold">No data.</span>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </EmptyDataTemplate>
                                                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                            <HeaderStyle BackColor="#507093" Font-Bold="True" ForeColor="White" Font-Names="BrowalliaUPC"
                                                                                Font-Size="18px" />
                                                                            <AlternatingRowStyle CssClass="altrowstyle" />
                                                                        </asp:GridView>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </div>
                                                        </td>
                                                        <td >
                                                           
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <table id="PageAddBranch" width="100%" style="display: ;">
                                <thead>
                                    <tr>
                                          <th width="5%">
                                                        </th>
                                                        <th width="25%">
                                                        </th>
                                                        <th width="60%">
                                                        </th>
                                                        <th width="20%">
                                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                   
                                    <tr>
                                        <td>
                                        </td>
                                        <td colspan="2" class="style1" style="text-align: center; font-size: 25px; color: Blue;
                                            font-family: BrowalliaUPC; font-weight: bold">
                                            <asp:Label ID="lbHeader2" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td id="tdGvproduct" colspan="3" style="padding-left: 5px;">
                                            <div id="tdBNT" style="text-align: right; margin-right: 20px">
                                                <asp:Button ID="bntOk" runat="server" Text="Add Shop" OnClick="bntOk_Click" />
                                                <input id="bntBack" type="button" style="margin-left: 10px" value="Back" onclick="UnshowPageAdd();" />
                                            </div>
                                            <div>
                                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                    <ContentTemplate>
                                                        <asp:LinkButton ID="LinkBranchSelect" runat="server" OnClick="LinkBranchSelect_Click">Select - All</asp:LinkButton>
                                                        &nbsp; &nbsp;
                                                        <asp:LinkButton ID="LinkBranchClear" runat="server" OnClick="LinkBranchClear_Click">Clear - All</asp:LinkButton>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                            <div class="container" style="width: 100%; height: 400px;">
                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>
                                                        <asp:GridView ID="GvProductleve" runat="server" BackColor="White" BorderColor="#6666FF"
                                                            BorderStyle="Solid" BorderWidth="1px" CellPadding="3" OnRowDataBound="GvProductleve_RowDataBound"
                                                            EmptyDataText="" EmptyDataRowStyle-ForeColor="Red" AutoGenerateColumns="False"
                                                            Width="100%">
                                                            <RowStyle ForeColor="#000066" Font-Names="BrowalliaUPC" Font-Size="18px" />
                                                            <EmptyDataRowStyle ForeColor="Red" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="#" HeaderStyle-Width="70px">
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="ckID" runat="server" Text="Add"></asp:CheckBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="ProductLevelID" HeaderText="ID" ItemStyle-HorizontalAlign="center"
                                                                    HeaderStyle-Width="30px">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="ProductLevelCode" HeaderText="" HeaderStyle-CssClass="tdHeader"  ItemStyle-CssClass="itemText" ItemStyle-HorizontalAlign="center"
                                                                    HeaderStyle-Width="100px">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="ProductLevelName" HeaderText="" HeaderStyle-CssClass="tdHeader"  ItemStyle-CssClass="itemText" ItemStyle-HorizontalAlign="left">
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:BoundField>
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
                                                                                ID
                                                                            </th>
                                                                            <th scope="col" class="tdHeader" >
                                                                                Shop Code
                                                                            </th>
                                                                            <th scope="col" class="tdHeader" >
                                                                                Shop Name
                                                                            </th>
                                                                        </tr>
                                                                        <tr style="color: rgb(0, 0, 102); font-family: BrowalliaUPC; font-size: 18px;" onmouseout="this.style.backgroundColor=currentcolor"
                                                                            onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#CCCCCC'">
                                                                            <td colspan="4" align="center">
                                                                                <span style="text-align: center; font-size: 18px; color: red; font-family: BrowalliaUPC;
                                                                                    font-weight: bold">No data.</span>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </EmptyDataTemplate>
                                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                            <HeaderStyle BackColor="#507093" Font-Bold="True" ForeColor="White" Font-Names="BrowalliaUPC"
                                                                Font-Size="18px" />
                                                            <AlternatingRowStyle CssClass="altrowstyle" />
                                                        </asp:GridView>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                        </td>
                                        <td >
                                            
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </fieldset>
    </div>

    <script type="text/javascript">
        <%=script %>
        <%=scriptRadio %>
        
        function showPageAdd()
        {
           document.getElementById('PageAddBranch').style.display = '';
           document.getElementById('ShopShow').style.display = 'none';
        
        }
        
        
        function UnshowPageAdd()
        {
           document.getElementById('PageAddBranch').style.display = 'none';
           document.getElementById('ShopShow').style.display = '';
        
        }
    </script>

</asp:Content>
