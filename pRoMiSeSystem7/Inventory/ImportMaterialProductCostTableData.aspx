<%@ page language="VB" autoeventwireup="false" inherits="ImportMaterialProductCostTableData, App_Web_importmaterialproductcosttabledata.aspx.9758fd70" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Import Stock Count Materials.</title>
    <link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">   
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="selMaterialCostGroupID" runat="server">
        <table bgcolor="White" cellpadding="0" cellspacing="0">
            <tr style="background-color: #EEEEEE">
                <td height="35" style="background-image: url('../images/headerstub.jpg')">&nbsp; &nbsp;
                </td>
                <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                    <div>
                        <asp:Label ID="lblHeader" runat="server" Text="Import Material Cost File." CssClass="headerText"></asp:Label>
                    </div>
                </td>
                <td rowspan="99" style="background-color: #003366; width: 1px;">
                    <img src="../images/clear.gif" height="1px" width="1px">
                </td>
            </tr>
            <tr style="background-color: #666666">
                <td width="3%" height="1"></td>
                <td width="94%"></td>
                <td width="3%"></td>
            </tr>
            <tr>
                <td height="10" colspan="3">&nbsp;
                </td>
            </tr>
           <tr>
                <td>
                </td>
                <td>
                    <span id="MessageText" class="boldText" runat="server"></span>
                    <table style="width: 100%;">  
                       <tr>
                         <td class="paramlist_key">
                            <asp:Label ID="lblPath" runat="server">Path File</asp:Label>
                         </td>
                         <td width="375px">
                            <asp:FileUpload ID="FileUpload1" runat="server" />
                         </td>
                         <td>
                            <asp:Button ID="cmdUploadFile" runat="server" Text="Upload File" Width="120px" Height="30px" />
                            &nbsp;<asp:Button ID="cmdImportfile" runat="server" Text="Import File" Width="120px" Height="30px" />                                                       
                            &nbsp;<asp:Button ID="cmdBack" runat="server" Text="<< Back" Width="120px" Height="30px" />                            
                         </td>                               
                       </tr>
                       <tr>
                         <td></td>
                         <td></td>
                         <td>
                            <asp:CheckBox ID="chkDisplayOnlyCanNotImport" runat="server" AutoPostBack="true"  text="Display only error record"/>
                         </td>
                        </tr>                    
                    </table>

                    <div id="responseText" runat="server" style="padding: 1px; margin-top: 5px;"></div>
                    <div style="text-align: center; padding: 10px; margin-bottom: 15px;">
                        <asp:Label ID="msgResponse" runat="server" Style="font-size: 20px; font-weight: bold;
                                color: Red; font-family: Tahoma;"></asp:Label>
                    </div>
                    <div id="ErrorMessage" runat="server" class="redText"></div> 
                </td>
                <td>&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3" height="30">&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3" style="background-color: #999999; height: 1px;"></td>
            </tr>
            <tr>
                <td height="50" colspan="3" style="background-image: url('../images/footerbg2000.gif')">&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3" style="background-color: #999999; height: 1px;"></td>
            </tr>
        </table>
    </form>
</body>
</html>
