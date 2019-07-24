<%@ page title="" language="C#" masterpagefile="~/MasterPage/MasterPage.master" autoeventwireup="true" inherits="Report_Redeem, App_Web_report_redeem.aspx.dfa151d5" enableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
    <asp:Label ID="Label1" runat="server" Text="Report Redeem"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <div id="Body" style="width: 100%">
        <div style="float: left; width: 100%;">
            <table id="filter" style="width: 100%">
                <tbody>
                    <tr>
                        <th width="10%">
                        </th>
                        <th width="20%">
                        </th>
                        <th width="10%">
                        </th>
                        <th width="60%">
                        </th>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align: center; font-size: 25px; color: Blue; font-family: BrowalliaUPC;
                            font-weight: bold">
                           
                        </td>
                    </tr>
                    <tr>
                        <td class="txt_label">
                            <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="TextLeft">
                             <div style="float: left;">
                                <asp:DropDownList ID="DdlMaterial" runat="server">
                                </asp:DropDownList>
                            </div></td>
                        <td class="TextRight">
                            <asp:RadioButton ID="rd1" GroupName="rb" runat="server" />
                        </td>
                        <td>
                           <div style="float: left;">
                                <select id="day1" name="day1">
                                </select>
                                <select id="month1" name="month1">
                                </select>
                                <select id="year1" name="year1">
                                </select>
                                </div>
                        </td>
                    </tr>
                   
                     
                     <tr>
                        <td class="txt_label">
                            <asp:Label ID="Label3" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="TextLeft">
                            <div style="float: left;">
                                <asp:DropDownList ID="DdlProductlevel" runat="server">
                                </asp:DropDownList>
                            </div>
                           
                        </td>
                        <td class="TextRight">
                           <asp:RadioButton ID="rd2" GroupName="rb" runat="server" />
                        </td>
                        <td>
                          <div style="float: left;">
                               
                              <select id="month2" name="month2">
                                </select>
                                <select id="year2" name="year2">
                                </select>
                                </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="txt_label">
                           
                        </td>
                        <td class="TextLeft" >
                           
                        </td>
                        <td class="TextRight">
                            <asp:RadioButton ID="rd3" GroupName="rb" runat="server" />
                        </td>
                        <td>
                         <div style="float: left;">
                                <select id="day3" name="day3">
                                </select>
                                <select id="month3" name="month3">
                                </select>
                                <select id="year3" name="year3">
                                </select>
                                <span class="txt_label" style="padding-left: 10px; padding-right: 10px"><asp:Label ID="Label4" runat="server" Text=""></asp:Label></span>
                                <select id="day4" name="day4">
                                </select>
                                <select id="month4" name="month4">
                                </select>
                                <select id="year4" name="year4">
                                </select>
                            </div>
                        </td>
                    </tr>
                     <tr>
                        <td class="style1">
                            </td>
                        <td class="style2" colspan="2">
                            <div style="float: left; padding-left: 20px">
                                <asp:UpdatePanel ID="updatePanelOK" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="bntOK" runat="server" Text="" OnClick="bntOK_Click" />
                                        
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                               
                            </div>
                            <div style="float: left; padding-left: 20px; ">
                             <asp:UpdateProgress runat="server" ID="PageUpdateProgress" AssociatedUpdatePanelID="updatePanelOK">
                                                    <ProgressTemplate>
                                                        <img alt="" src="../images/wait.gif" /><br />
                                                        Please wait....
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                            </div>
                        </td>
                        <td>
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
                            <div><asp:LinkButton ID="expotExcel" runat="server" onclick="expotExcel_Click">Export to Excel</asp:LinkButton></div>
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
         window.onload = function() {
        
//            populatedropdown('day1', 'month1', 'year1', '2')
//            populatedropdown('', 'month2', 'year2', '2')
//            populatedropdown('day3', 'month3', 'year3', '2')
//            populatedropdown('day4', 'month4', 'year4', '2')
           
            
            <%=scriptSetDate %>
        }
        </script>
</asp:Content>

