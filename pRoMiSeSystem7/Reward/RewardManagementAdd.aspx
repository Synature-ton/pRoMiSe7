<%@ page language="C#" masterpagefile="~/MasterPage/MasterPage.master" autoeventwireup="true" inherits="RewardManagementAdd, App_Web_rewardmanagementadd.aspx.b7f13d75" title="Untitled Page" enableEventValidation="false" %>

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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="Label1" runat="server" Text="Add For Reward"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <div style="text-align: center;width:100%">
        <fieldset class="fieldset" style="width: 100%">
            <legend class="legend"><%--<span style="text-align: center">กำหนด การให้แต้มสะสม</span><br />--%>
                <span>Set Promotion For Reward</span> </legend>
            <table id="tbHead" width="100%">
                <thead>
                    <tr>
                        <th width="15%">
                        </th>
                        <th width="25%">
                        </th>
                        <th width="25%">
                        </th>
                        <th width="35%" style="text-align: right; padding-right: 20px;">
                            <a href="javaScript:location.replace('RewardManagement.aspx');"><span style="color: Blue;
                                font-size: 16px; font-family: Tahoma;">
                                <asp:Label ID="lbBack" runat="server" Text=""></asp:Label></span></a>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="Td1">
                            <div>
                                <span class="star_label">*</span><span class="th_label"><asp:Label ID="Label2" runat="server" Text=""></asp:Label></span></div>
                        </td>
                        <td class="Td2" colspan="2">
                            <input name="ckRdoPromo" value="Y" type="radio" onclick="ShowTypeProduct();" 
                                checked />
                            <span class="th_label" style="color: #00008B"><asp:Label ID="Label3" runat="server" Text=""></asp:Label></span>
                            <input name="ckRdoPromo" value="N" type="radio" onclick="ShowTypeCoupon();" disabled
                                style="display: none;" />
                            <%--<span class="th_label" style="color: #00008B">สำหรับ จำนวนชิ้น</span>--%>
                        </td>
                        <td class="Td4">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="background-color: ButtonFace;">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <table id="tProduct" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th width="25%">
                                        </th>
                                        <th width="25%">
                                        </th>
                                        <th width="25%">
                                        </th>
                                        <th width="25%">
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                  
                                    <tr>
                                        <td style="padding-left: 25px;" colspan="4">
                                            <div id="ddClass" style="float: left; padding-top: 10px;">
                                                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                    <ContentTemplate>
                                                        <asp:DropDownList ID="ddlProductLevel" runat="server" AutoPostBack="True" ToolTip="Shop"
                                                            OnSelectedIndexChanged="ddlProductLevel_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                            <div id="ddGroup" style="float: left; padding-left: 10px; padding-top: 10px;">
                                                <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                                    <ContentTemplate>
                                                        <asp:DropDownList ID="ddlProGroup" runat="server" AutoPostBack="True" ToolTip="Product Group"
                                                            OnSelectedIndexChanged="ddlProGroup_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                            <div id="ddDept" style="float: left; padding-left: 10px; padding-top: 10px;">
                                                <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                                    <ContentTemplate>
                                                        <asp:DropDownList ID="ddlProDept" runat="server" AutoPostBack="True" ToolTip="Product Dept"
                                                            OnSelectedIndexChanged="ddlProDept_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                            <div style="float: left; padding-left: 10px; padding-top: 10px;">
                                                <asp:UpdateProgress runat="server" ID="PageUpdateProgress" AssociatedUpdatePanelID="UpdatePanel5">
                                                    <ProgressTemplate>
                                                        <img alt="" src="../images/wait.gif" /><br />
                                                        Please wait....
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                                <asp:UpdateProgress runat="server" ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel6">
                                                    <ProgressTemplate>
                                                        <img alt="" src="../images/wait.gif" /><br />
                                                        Please wait....
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                                <asp:UpdateProgress runat="server" ID="UpdateProgress2" AssociatedUpdatePanelID="UpdatePanel7">
                                                    <ProgressTemplate>
                                                        <img alt="" src="../images/wait.gif" /><br />
                                                        Please wait....
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
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
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="background-color: ButtonFace;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td id="tdGvproduct" colspan="4" style="padding-left: 5px;">
                                            <div style="text-align: center; font-size: 25px; color: Blue; font-family: BrowalliaUPC;
                                                font-weight: bold">
                                                <asp:Label ID="lbHeader" runat="server" Text=""></asp:Label>
                                            </div>
                                             <div id="tdBNT" style="text-align:right;margin-right:20px">
                                           
                                            <asp:UpdatePanel ID="update2" runat="server">
                                            <ContentTemplate>
                                            
                                                <asp:Button ID="bntOk" runat="server" Text="" OnClick="bntOk_Click" />
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
                                                            BorderStyle="Solid" BorderWidth="1px" CellPadding="3" OnRowDataBound="GvProduct_RowDataBound"
                                                            EmptyDataText="" EmptyDataRowStyle-ForeColor="Red" AutoGenerateColumns="False"
                                                            Width="100%">
                                                            <RowStyle ForeColor="#000066" Font-Names="BrowalliaUPC" Font-Size="18px" />
                                                            <EmptyDataRowStyle ForeColor="Red" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="#" HeaderStyle-Width="70px" HeaderStyle-CssClass="tdHeader"   >
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="ckID" runat="server" Text="Add"></asp:CheckBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="ProductID" HeaderText="" HeaderStyle-Width="60px" HeaderStyle-CssClass="tdHeader"  ItemStyle-CssClass="itemText"
                                                                    ItemStyle-HorizontalAlign="center">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="ProductCode" HeaderText="" ItemStyle-HorizontalAlign="center" HeaderStyle-CssClass="tdHeader"  ItemStyle-CssClass="itemText" >
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="ProductGroupName" HeaderText="" HeaderStyle-CssClass="tdHeader"  ItemStyle-CssClass="itemText" />
                                                                <asp:BoundField DataField="ProductDeptName" HeaderText="" HeaderStyle-CssClass="tdHeader"  ItemStyle-CssClass="itemText" />
                                                                <asp:BoundField DataField="ProductName" HeaderText="" HeaderStyle-CssClass="tdHeader"  ItemStyle-CssClass="itemText" />
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
                                                                                Product Group
                                                                            </th>
                                                                            <th scope="col" class="tdHeader" >
                                                                                Product Dept
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
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="Td1" colspan="4" style="text-align: center; font-size: 25px; color: Blue;
                            font-family: BrowalliaUPC; font-weight: bold">
                        </td>
                    </tr>
                </tbody>
            </table>
        </fieldset>
    </div>

    <script type="text/javascript">
      
        
        ShowTypeHiden();

        function ShowTypeHiden() {
            document.getElementById('tdGvproduct').style.display = 'none';
            document.getElementById('tdBNT').style.display = 'none';
        }
        function ShowTypeshow() {
            document.getElementById('tdGvproduct').style.display = '';
            document.getElementById('tdBNT').style.display = '';
        }
        
        function ShowTypeProduct() {
            document.getElementById('tProduct').style.display = '';
        }

        function ShowTypeCoupon() {
            document.getElementById('tProduct').style.display = 'none';
        }
        
        <%=script %>
        <%=scriptRadio %>
        <%=scpRadio %>
    </script>

</asp:Content>
