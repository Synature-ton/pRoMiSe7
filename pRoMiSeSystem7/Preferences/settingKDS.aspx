<%@ page language="VB" autoeventwireup="false" inherits="Preferences_settingKDS, App_Web_settingkds.aspx.475a53d1" %>

<!DOCTYPE html>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>KDS SaleMode Setting</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

</head>
<body>

<div id="dvAccessDenied" runat="server" />
<div id="showContent" visible="True" runat="server">
<form id="mainForm" runat="server">
<input type="hidden" name="ID" value="1" />
<input type="hidden" id="SelShopID" runat="server" />
<input type="hidden" id="SelProductGroupIDList" runat="server" />
<input type="hidden" id="SelProductDeptIDList" runat="server" />
<input type="hidden" id="SelProductIDList" runat="server" />
<input type="hidden" id="selKDSStep" runat="server" />
<input type="hidden" id="selKDSPerStep" runat="server" />
<input type="hidden" id="selSetKDSBy" runat="server" />

<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
    	<table width="100%"><tr><td align="left" width="70%"><b class="headerText"><asp:Label ID="lblHeader" runat="server" /></b></td><td align="right"></td></tr></table>
	</td>
	<td width="1" nowrap rowspan="99" bgcolor="003366"><img src="../images/clear.gif" height="1" width="1" /></td>
</tr>
 <tr style="background-color: #eeeeee">
    <td width="3%" height="1"></td>
    <td width="94%"></td>
    <td width="3%"></td>
</tr>
<tr><td  colspan="3">&nbsp;</td></tr>

<tr>
    <td>&nbsp;</td>
    <td>
        <table>
            <tr>
                <td><asp:Label ID="lblShopName" runat="server" Text="Select Shop :" ></asp:Label> </td>
                <td><asp:DropDownList ID="cboShopName" runat="server" AutoPostBack="true" ></asp:DropDownList>
                </td>                
            </tr>
            <tr>
                <td><asp:Label ID="lblKDSStep" runat="server" Text="Number of Step :" ></asp:Label> </td>
                <td><asp:DropDownList ID="cboKDSStep" runat="server" Width="40px"></asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblKDSPerStep" runat="server" Text="Number of KDS/ Step :" ></asp:Label>
                    &nbsp;&nbsp;<asp:DropDownList ID="cboKDSIDPerStep" Width="40px" runat="server"></asp:DropDownList>
                </td>
                       
            </tr>
            <tr>
                <td><asp:Label ID="lblSetKDSBy" runat="server" Text="Setting By :" ></asp:Label> </td>
                <td>
                    <asp:RadioButton ID="optSetByProductGroup" GroupName="GroupSetKDSBy" runat="server" Text="Product Group" AutoPostBack="true"  />&nbsp;&nbsp;
                    <asp:RadioButton ID="optSetByProductDept" GroupName="GroupSetKDSBy" runat="server" Text="Product Dept" AutoPostBack="true" />&nbsp;&nbsp;
                    <asp:RadioButton ID="optSetByProduct" GroupName="GroupSetKDSBy" runat="server" Text="Product " AutoPostBack="true" />&nbsp;&nbsp;
                </td>                                
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <table id="tbProductGroup" runat="server" style="height: 144px; float:left; ">
                        <tr>
                            <td><asp:Label ID="lblSelectProductGroup" runat="server" Text="Select Group" CssClass="text" ></asp:Label></td>                            
                        </tr>
                        <tr>
                            <td><asp:Checkbox ID="chkSelAllProductGroup" Text="Sel All Data" AutoPostBack="True"  runat="server" /></td>
                        </tr>
                        <tr>
                            <td><div id="pnlProductGroup" style="border-width:1px;border-style:solid;height:120px;width:280px;overflow:auto" runat="server"  >
                                <asp:CheckBoxList ID="chkbProductGroup" runat="server" Width="250px" AutoPostBack="true" Height="16px" ></asp:CheckBoxList>
                            </div></td>
                        </tr>
                    </table>
                    <table id="tbProductDept" runat="server" style="height: 144px; float:left;">
                        <tr>
                            <td><asp:Label ID="lblSelectProductDept" runat="server" Text="Select Dept" CssClass="text" ></asp:Label></td>
                        </tr>
                        <tr>
                            <td><asp:Checkbox ID="chkSelAllProductDept" Text="Sel All Data" AutoPostBack="True"  runat="server" /></td>
                        </tr>
                        <tr>
                            <td><div id="pnlProductDept" style="border-width:1px;border-style:solid;height:120px;width:280px;overflow:auto" runat="server" >
                                <asp:CheckBoxList ID="chkbProductDept" runat="server" Height="25px" Width="261px" AutoPostBack="true" ></asp:CheckBoxList>
                           </div></td>
                        </tr>
                    </table>
                    <table id="tbProduct" runat="server" style="height: 144px; float:left ">
                        <tr>
                            <td><asp:Label ID="lblSelectProduct" runat="server" Text="Select Product" CssClass="text" ></asp:Label></td>                       
                        </tr>
                        <tr>
                            <td><asp:Checkbox ID="chkSelAllProduct" Text="Sel All Data" AutoPostBack="True"  runat="server" /></td>
                        </tr>
                        <tr>
                           <td><div id="pnlProduct" style="border-width:1px;border-style:solid;height:120px;width:280px;overflow:auto" runat="server"  >
                            <asp:CheckBoxList ID="chkbProduct" runat="server" Height="21px" Width="215px"></asp:CheckBoxList>
                            </div></td>
                        </tr>
                    </table>
                </td>
            </tr>
             <tr>
                <td>&nbsp;</td>
                <td colspan="3"><asp:Button ID="cmdDisplayData" runat="server" Text="Display" width="100px" /></td> 
            </tr>
        </table>
    </td>
</tr>
<tr>
     <td>&nbsp;</td>
     <td align="left"><asp:Button ID="cmdSaveData" runat="server" Text="Save" width="100px" /></td>
</tr> 
<tr>
    <td>&nbsp;</td>
    <td><div id="dvUpdateText" class="boldText" runat="server"></div>
    </td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td><div id="dvDisplaySetting" runat="server"></div>
    </td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td>
        <table width="100%">
            <tr>
                <td align="left" colspan="2"><asp:Button ID="cmdSaveData2" runat="server" Text="Save"  width="100px" /></td>
            </tr>
        </table>
    </td>
</tr>
</table>
</form>
    <div id="dvErrorMsg" class="red" runat="server" />
</div>
</body>
</html>
