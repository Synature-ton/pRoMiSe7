<%@ page language="C#" autoeventwireup="true" masterpagefile="~/MasterPage/MasterPage.master" inherits="Inventory_compare_document_detail, App_Web_compare_document_detail.aspx.9758fd70" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheet/StyleSheet.css" rel="stylesheet" type="text/css" />
     <script language="javascript" src="../StyleSheet/DateDropdownJScript.js" type="text/javascript"></script>
     <style type="text/css">
        .altrowstyle
        {
            background-color: #C8D3DC;
        }
         .HeaderStyle
        {
            text-align: left;
        }
        .TextLeft
        {
            text-align: left;
            padding-left: 5px;
        }
        .TextRight
        {
            text-align: right;
            padding-right: 5px;
        }
        .txt_label
        {
            text-align: right;
            font-family: Tahoma;
            font-size: 12px;
            font-weight: bold;
            padding-right: 5px;
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
         .style1
         {
             text-align: right;
             font-family: Tahoma;
             font-size: 12px;
             font-weight: bold;
             padding-right: 5px;
         }
         .style2
         {
             text-align: left;
             padding-left: 5px;
         }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="Label1" runat="server" Text="Report Compare Transfer Document"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <div id="Body" style="width: 100%">
        <div style="float: left; width: 100%;">
            <table id="filter" style="width: 100%">
                <tbody>
                    <tr>
                        <th width="20%">
                        </th>
                        <th width="80%">
                        </th>
                    </tr>
                    <tr>
                        <td class="txt_label">
                            <asp:Label ID="lbHead1" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="text">
                             <div style="float: left;">
                                <asp:Label ID="lbDetail1" runat="server" Text=""></asp:Label>
                            </div>
                        </td>
                    </tr>
                     <tr>
                        <td class="txt_label">
                            <asp:Label ID="lbHead2" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="text">
                            <div style="float: left;">
                                <asp:Label ID="lbDetail2" runat="server" Text=""></asp:Label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="txt_label">
                            <asp:Label ID="lbHead3" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="text" >
                            <div style="float: left;">
                                <asp:Label ID="lbDetail3" runat="server" Text=""></asp:Label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="txt_label">
                            <asp:Label ID="lbHead4" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="text" >
                            <div style="float: left;">
                                <asp:Label ID="lbDetail4" runat="server" Text=""></asp:Label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="background-color: ButtonFace;">
                        </td>
                    </tr>
                </tbody>
            </table>
          
        </div>
        <div style="float: left; width: 100%">
            <table class="text" id="" style="width: 100%">
                <tbody>
                    <tr>
                        <td>
                            <div><asp:LinkButton ID="expotExcel" runat="server" onclick="expotExcel_Click" >Export to Excel</asp:LinkButton></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:UpdatePanel ID="updateGrid" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lbTable" runat="server" Text=""></asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
     <script type="text/javascript">
         
     </script>
</asp:Content>
