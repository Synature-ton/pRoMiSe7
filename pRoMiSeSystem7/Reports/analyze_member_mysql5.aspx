<%@ Page Language="VB" validateRequest=false ContentType="text/html" debug="True" %>
<%@ Register tagPrefix="Web" Namespace="WebChart" Assembly="WebChart" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Import Namespace="System.Drawing" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="MySQL5DBClass.POSControl" %>
<%@Import Namespace="MySQL5DBClass.GlobalFunctions" %>
<%@Import Namespace="System.Globalization" %>
<%@Import Namespace="ReportModule" %>
<%@Import Namespace="ReportModuleMySQL5" %>
<%@ IMPORT namespace="System.Web.Mail" %>
<%@ Register tagprefix="synature" Tagname="date" Src="../UserControls/Date.ascx" %>
<%@Import Namespace="pRoMiSeCRMMySQL5.pRoMiSeCRM" %>

<html>
<head>
<title>Member's Report</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>
<body>
<ASP:Label id="updateMessage" CssClass="headerText" runat="server" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="White">
<tr bgcolor="eeeeee">
	<td height="35" nowrap background="../images/headerstub.jpg">&nbsp; &nbsp;</td>
	<td colspan="2" background="../images/headerbg2000.jpg">
		<div class="noprint"><b class="headerText"><div class="headerText" align="left" id="SectionText" runat="server" /></b></div>
	</td>
	<td width="1" nowrap rowspan="99" bgcolor="003366"><img src="../images/clear.gif" height="1" width="1"></td>
</tr>
<tr bgcolor="666666">
	<td width="3%" height="1"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	<td width="94%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="252"></p></td>
	<td width="3%"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1" border="0" hspace="2"></p></td>
	
</tr>
<tr><td colspan="3" class="smalltext" align="right"><span id="DBText" class="smalltext" runat="server" /></td></tr>
<tr>
<td>&nbsp;</td>
<td>
<form id="mainForm" runat="server">
<input type="hidden" name="SubmitFormSearch" value="yes">
<input type="hidden" id="SelMonth" value="" runat="server" />
<input type="hidden" id="SelYear" value="" runat="server" />

<input type="hidden" id="SelMonth1" value="" runat="server" />
<input type="hidden" id="SelYear1" value="" runat="server" />

<input type="hidden" id="SelMonth2" value="" runat="server" />
<input type="hidden" id="SelYear2" value="" runat="server" />

<input type="hidden" id="SelMonth11" value="" runat="server" />
<input type="hidden" id="SelYear11" value="" runat="server" />

<input type="hidden" id="SelMonth12" value="" runat="server" />
<input type="hidden" id="SelYear12" value="" runat="server" />

<input type="hidden" id="MemberIDList" value="" runat="server" />
<input type="hidden" id="MemberRecord" value="" runat="server" />
<input type="hidden" id="MemberMobileRecord" value="" runat="server" />
<input type="hidden" id="MemberMobileIDList" value="" runat="server" />
<input type="hidden" id="MemberIDListSale" value="" runat="server" />

<input type="hidden" id="SelMonth0" value="" runat="server" />
<input type="hidden" id="SelYear0" value="" runat="server" />

<input type="hidden" id="DocDailyDay" value="" runat="server" />
<input type="hidden" id="DocDailyMonth" value="" runat="server" />
<input type="hidden" id="DocDailyYear" value="" runat="server" />

<input type="hidden" id="DocDay" value="" runat="server" />
<input type="hidden" id="DocMonth" value="" runat="server" />
<input type="hidden" id="DocYear" value="" runat="server" />
<input type="hidden" id="DocToDay" value="" runat="server" />
<input type="hidden" id="DocToMonth" value="" runat="server" />
<input type="hidden" id="DocToYear" value="" runat="server" />

<input type="hidden" id="SelMonth9" value="" runat="server" />
<input type="hidden" id="SelYear9" value="" runat="server" />

<input type="hidden" id="DocDailyDay9" value="" runat="server" />
<input type="hidden" id="DocDailyMonth9" value="" runat="server" />
<input type="hidden" id="DocDailyYear9" value="" runat="server" />

<input type="hidden" id="DocDay9" value="" runat="server" />
<input type="hidden" id="DocMonth9" value="" runat="server" />
<input type="hidden" id="DocYear9" value="" runat="server" />
<input type="hidden" id="DocToDay9" value="" runat="server" />
<input type="hidden" id="DocToMonth9" value="" runat="server" />
<input type="hidden" id="DocToYear9" value="" runat="server" />

<input type="hidden" id="SendDateDay" value="" runat="server" />
<input type="hidden" id="SendDateMonth" value="" runat="server" />
<input type="hidden" id="SendDateYear" value="" runat="server" />

<input type="hidden" id="EmailFromVal" value="" runat="server" />
<input type="hidden" id="EmailSubjectVal" value="" runat="server" />
<input type="hidden" id="EmailCCVal" value="" runat="server" />
<input type="hidden" id="EmailMessageVal" value="" runat="server" />
<input type="hidden" id="MemberEmailList" value="" runat="server" />

<input type="hidden" id="Dynamic1List" value="" runat="server" />
<input type="hidden" id="Dynamic2List" value="" runat="server" />
<input type="hidden" id="Dynamic3List" value="" runat="server" />
<input type="hidden" id="Dynamic4List" value="" runat="server" />
<input type="hidden" id="Dynamic5List" value="" runat="server" />
<input type="hidden" id="Dynamic6List" value="" runat="server" />
<div class="noprint">
<table border="0" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
	<tr>
		<td class="text">[<asp:LinkButton ID="SearchCriteria" OnClick="DoSwitch1" Enabled="false" runat="server"></asp:LinkButton>]</td>
		<td class="text">[<asp:LinkButton ID="SearchResult" OnClick="DoSwitch2" runat="server"></asp:LinkButton>]</td>
		<td class="text">[<asp:LinkButton ID="BestSeller" OnClick="DoSwitch3" runat="server"></asp:LinkButton>]</td>
		<td class="text">[<asp:LinkButton ID="SaleReport" OnClick="DoSwitch4" runat="server"></asp:LinkButton>]</td>
		<span id="ShowSMS" visible="false" runat="server"><td class="text">[<asp:LinkButton ID="SMSForm" OnClick="DoSwitch8" runat="server"></asp:LinkButton>]</td></span>
		<span id="ShowEmail" visible="true" runat="server"><td class="text">[<asp:LinkButton ID="EmailForm" OnClick="DoSwitch5" runat="server"></asp:LinkButton>]</td></span>
		<span id="ShowLabel" visible="false" runat="server"><td>[<asp:LinkButton ID="LabelLink" OnClick="DoSwitch6" runat="server"></asp:LinkButton>]</td></span>
		<span id="ShowOptions" visible="true" runat="server"><td class="text">[<asp:LinkButton ID="Options" OnClick="DoSwitch7" runat="server"></asp:LinkButton>]</td></span>
	</tr>
</table>
<table border="0" cellpadding="4" cellspacing="0">
	<tr><td height="10"></td></tr>
	<tr>
		<td><asp:Button ID="ExportExcelAll" OnClick="ExportToExcelAll" Height="20" Font-Size="8" Width="140" Text="Export Member Data" runat="server"></asp:Button></td>
		<td><asp:Button ID="ExportUserDefine" OnClick="ExportMemberUDD" Height="20" Font-Size="8" Width="140" Text="Export User Define Data" runat="server"></asp:Button></td>
	</tr>
</table>
</div>
<div id="Section1" runat="server">
<table border="1" cellpadding="4" cellspacing="0" width="100%" style="border-collapse:collapse;">
<tr><td>
<table cellpadding="0" cellspacing="3">
<tr>
	<td rowspan="2"><span id="GroupSearchText" class="text" runat="server"></span><br><asp:Listbox ID="GroupList"  Height="110" Width="200" SelectionMode="Multiple" runat="server"></asp:Listbox></td>
	<td valign="top">
		<table>
			<tr>
				<td><span id="CodeSearchText" class="text" runat="server"></span><br><asp:textbox ID="MemberCode" Font-Size="10" Height="22" Width="130" runat="server" /></td>
			</tr>
			<tr>
				<td><span id="TelSearchText" class="text" runat="server"></span><br><asp:textbox ID="MemberTelephone" Font-Size="10" Height="22" Width="130" runat="server" /></td>
			</tr>
			
			
		</table>
	</td>
	<td valign="top">
		<table>
			<tr>
				<td><span id="FirstNameSearchText" class="text" runat="server"></span><br><asp:textbox ID="MemberFirstName" Font-Size="10" Height="22" Width="130" runat="server" /></td>
			</tr>
			
			<tr>
				<td><span id="MobileSearchText" class="text" runat="server"></span><br><asp:textbox ID="MemberMobile" Font-Size="10" Height="22" Width="130" runat="server" /></td>
			</tr>
			
		</table>
	</td>
	<td valign="top">
		<table>
			<tr>
				<td><span id="LastNameSearchText" class="text" runat="server"></span><br><asp:textbox ID="MemberLastName" Font-Size="10" Height="22" Width="130" runat="server" /></td>
			</tr>
			<tr>
				<td><span id="GenderSearchText" class="text" runat="server"></span><br><asp:radiobuttonlist ID="GenderList" RepeatDirection="Horizontal" CssClass="text" Visible="true"  runat="server">
				<asp:listitem></asp:listitem>
				<asp:listitem></asp:listitem>
				<asp:listitem></asp:listitem>
				</asp:radiobuttonlist></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
   <td colspan="3" valign="top"><table><tr><td><span id="SearchText1" class="text" runat="server" /> <input type="text" id="ExpireRange" size="3" runat="server" /><asp:RangeValidator ID="ExpireRangeValidate" ControlToValidate="ExpireRange" MinimumValue="1" MaximumValue="900000" Type="Integer" CssClass="errorText" ErrorMessage="Must be integer number" Display="Dynamic" runat="server"></asp:RangeValidator> <span id="DayText" class="text" runat="server" /></td><td><asp:CheckBox ID="OnlyNotExpire" CssClass="text" runat="server"></asp:CheckBox></td></tr></table>
</tr>
</table>
</td></tr>

<tr>
	<td>
	<table width="100%"><tr><td width="66%">
	<table border="0">
	<tr>
		<td><asp:RadioButton ID="Radio1" GroupName="AgeCriteria" runat="server"></asp:RadioButton></td>
		<td><span id="FromAgeText" class="text" runat="server"></span></td>
		<td><table><tr><td><input type="text" id="txtFromAge" size="3" runat="server" /><asp:RangeValidator ID="FromAgeVal" ControlToValidate="txtFromAge" MinimumValue="1" MaximumValue="150" Type="Integer" CssClass="errorText" ErrorMessage="Must be numberic number between 1 to 150" Display="Dynamic" runat="server"></asp:RangeValidator></td>
		<td><span id="ToAgeText" class="text" runat="server"></span></td>
		<td><input type="text" id="txtToAge" size="3" runat="server" /><asp:RangeValidator ID="ToAgeVal" ControlToValidate="txtToAge" MinimumValue="1" MaximumValue="150" Type="Integer" CssClass="errorText" ErrorMessage="Must be numberic number between 1 to 150" Display="Dynamic" runat="server"></asp:RangeValidator></td></tr></table>
	</tr>
	<tr>
		<td><asp:RadioButton ID="Radio2" GroupName="AgeCriteria" runat="server"></asp:RadioButton></td>
		<td><span id="BirthDayText" class="text" runat="server"></span></td>
		<td><table><tr><td><synature:date id="MonthYearDate" runat="server" /></td></tr></table></td>
	</tr>
	<tr>
		<td><asp:RadioButton ID="Radio3" GroupName="AgeCriteria" runat="server"></asp:RadioButton></td>
		<td><span id="BirthDayPeriodText" class="text" runat="server"></span></td>
		<td><table><tr><td><synature:date id="MonthYearDate1" runat="server" /></td><td><span id="ToPeriodText" class="text" runat="server"></span></td><td><synature:date id="MonthYearDate2" runat="server" /></td></tr></table></td>
	</tr>
	<tr>
		<td><asp:RadioButton ID="Radio4" GroupName="AgeCriteria" runat="server"></asp:RadioButton></td>
		<td><span id="NAText" class="text" runat="server"></span></td>
		<td>&nbsp;</td>
	</tr>
	</table>
	</td>
	<td width="33%" valign="top">
	<table>
		<tr><td><span id="CityText" class="text" runat="server"></span></td><td><asp:textbox ID="MemberCity" Font-Size="10" Height="22" Width="200" runat="server" /></td></tr>
		<tr><td valign="top"><span id="ProvinceText" class="text" runat="server"></span></td><td><asp:ListBox ID="Province" Rows="5" Width="200" SelectionMode="Multiple" runat="server"></asp:ListBox></td></tr>
	</table>
	</td>
	</tr></table></td>
</tr>

<div id="ShowProductCriteria" visible="false" runat="server">
<tr>
	<td><table>
		<tr>
			<td><asp:CheckBox ID="ProductCriteria" CssClass="text" runat="server"></asp:CheckBox></td>
			<td><span id="ProductCriteriaText" class="text" runat="server"></span></td>
			<td>
				<table>
					<tr>
						<td><synature:date id="MonthYearDate11" runat="server" /></td>
						<td><span id="ToProductCriteriaText" class="text" runat="server"></span></td>
						<td><synature:date id="MonthYearDate12" runat="server" /></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2"></td>
			<td><table>
				<tr>
					<td><asp:DropDownList ID="ShopInfo1" CssClass="text" Width="200" AutoPostBack="true" OnSelectedIndexChanged="SelGroup1" runat="server"></asp:DropDownList></td>
					<td><asp:DropDownList ID="GroupInfo1" CssClass="text" Width="200" AutoPostBack="true" OnSelectedIndexChanged="SelDept1" runat="server"></asp:DropDownList></td>
					<td><asp:DropDownList ID="DeptInfo1" Width="200" CssClass="text" runat="server"></asp:DropDownList></td>
				</tr>
				</table>
			</td>
		</table>
	</td>
</tr>
</div>

<div id="DynamicCriteria" visible="false" runat="server">
	<tr>
		<td>
		<table width="100%">
			<tr>
				<td width="33%" class="text"><span id="DynamicText1" class="text" runat="server"></span><br><asp:ListBox ID="Dynamic1" Rows="5" Width="200" SelectionMode="Multiple" runat="server"></asp:ListBox></td>
				<td width="33%" class="text"><span id="DynamicText2" class="text" runat="server"></span><br><asp:ListBox ID="Dynamic2" Rows="5" Width="200" SelectionMode="Multiple" runat="server"></asp:ListBox></td>
				<td width="33%" class="text"><span id="DynamicText3" class="text" runat="server"></span><br><asp:ListBox ID="Dynamic3" Rows="5" Width="200" SelectionMode="Multiple" runat="server"></asp:ListBox></td>
			</tr>
			<tr>
				<td width="33%" class="text"><span id="DynamicText4" class="text" runat="server"></span><br><asp:ListBox ID="Dynamic4" Rows="5" SelectionMode="Multiple" runat="server"></asp:ListBox></td>
				<td width="33%" class="text"><span id="DynamicText5" class="text" runat="server"></span><br><asp:ListBox ID="Dynamic5" Rows="5" SelectionMode="Multiple" runat="server"></asp:ListBox></td>
				<td width="33%" class="text"><span id="DynamicText6" class="text" runat="server"></span><br><asp:ListBox ID="Dynamic6" Rows="5" SelectionMode="Multiple" runat="server"></asp:ListBox></td>
			</tr>
		</table>
		</td>
	</tr>
</div>
<div id="DynamicNumeric" visible="false" runat="server">
	<tr>
		<td>
		<table>

			<tr id="DisplayN1" visible="false" runat="server">
				<td class="text"><span id="DynamicNumericText1" class="text" runat="server"></span></td>
				<td><asp:DropDownList ID="DynamicNumeric1" CssClass="text" Width="80" runat="server" /></td>
				<td><asp:TextBox ID="StartNumericText1" Width="80" runat="server" /></td>
				<td class="text">and</td>
				<td><asp:TextBox ID="EndNumericText1" Width="80" runat="server" /></td>
			</tr>

			<tr id="DisplayN2" visible="false" runat="server">
				<td class="text"><span id="DynamicNumericText2" class="text" runat="server"></span></td>
				<td><asp:DropDownList ID="DynamicNumeric2" CssClass="text" Width="80" runat="server" /></td>
				<td><asp:TextBox ID="StartNumericText2" Width="80" runat="server" /></td>
				<td class="text">and</td>
				<td><asp:TextBox ID="EndNumericText2" Width="80" runat="server" /></td>
			</tr>

			<tr id="DisplayN3" visible="false" runat="server">
				<td class="text"><span id="DynamicNumericText3" class="text" runat="server"></span></td>
				<td><asp:DropDownList ID="DynamicNumeric3" CssClass="text" Width="80" runat="server" /></td>
				<td><asp:TextBox ID="StartNumericText3" Width="80" runat="server" /></td>
				<td class="text">and</td>
				<td><asp:TextBox ID="EndNumericText3" Width="80" runat="server" /></td>
			</tr>

			<tr id="DisplayN4" visible="false" runat="server">
				<td class="text"><span id="DynamicNumericText4" class="text" runat="server"></span></td>
				<td><asp:DropDownList ID="DynamicNumeric4" CssClass="text" Width="80" runat="server" /></td>
				<td><asp:TextBox ID="StartNumericText4" Width="80" runat="server" /></td>
				<td class="text">and</td>
				<td><asp:TextBox ID="EndNumericText4" Width="80" runat="server" /></td>
			</tr>

		</table>
		</td>
	</tr>
</div>
<div id="DynamicDate" visible="false" runat="server">
	<tr>
		<td>
		<table>
		<tr id="ShowDate1" runat="server">
			<td class="text"><span id="DynamicDateText1" class="text" runat="server"></span></td>
			<td><asp:DropDownList ID="DynamicDate1" CssClass="text" Width="80" runat="server" /></td>
			<td><asp:TextBox ID="StartDayText1" MaxLength="2" Width="30" runat="server" /> / <asp:TextBox ID="StartMonthText1" MaxLength="2" Width="30" runat="server" /> / <asp:TextBox ID="StartYearText1" MaxLength="4" Width="50" runat="server" /></td>
			<td class="text">and</td>
			<td><asp:TextBox ID="EndDayText1" MaxLength="2" Width="30" runat="server" /> / <asp:TextBox ID="EndMonthText1" MaxLength="2" Width="30" runat="server" /> / <asp:TextBox ID="EndYearText1" MaxLength="4" Width="50" runat="server" /></td>
			<td class="text">(dd/mm/yyyy)</td>
		</tr>
		<tr id="ShowDate2" runat="server">
			<td class="text"><span id="DynamicDateText2" class="text" runat="server"></span></td>
			<td><asp:DropDownList ID="DynamicDate2" CssClass="text" Width="80" runat="server" /></td>
			<td><asp:TextBox ID="StartDayText2" Width="30" MaxLength="2" runat="server" /> / <asp:TextBox ID="StartMonthText2" MaxLength="2" Width="30" runat="server" /> / <asp:TextBox ID="StartYearText2" MaxLength="4" Width="50" runat="server" /></td>
			<td class="text">and</td>
			<td><asp:TextBox ID="EndDayText2" MaxLength="2" Width="30" runat="server" /> / <asp:TextBox ID="EndMonthText2" MaxLength="2" Width="30" runat="server" /> / <asp:TextBox ID="EndYearText2" MaxLength="4" Width="50" runat="server" /></td>
			<td class="text">(dd/mm/yyyy)</td>
		</tr>
		<tr id="ShowDate3" runat="server">
			<td class="text"><span id="DynamicDateText3" class="text" runat="server"></span></td>
			<td><asp:DropDownList ID="DynamicDate3" CssClass="text" Width="80" runat="server" /></td>
			<td><asp:TextBox ID="StartDayText3" MaxLength="2" Width="30" runat="server" /> / <asp:TextBox ID="StartMonthText3" MaxLength="2" Width="30" runat="server" /> / <asp:TextBox ID="StartYearText3" MaxLength="4" Width="50" runat="server" /></td>
			<td class="text">and</td>
			<td><asp:TextBox ID="EndDayText3" MaxLength="2" Width="30" runat="server" /> / <asp:TextBox ID="EndMonthText3" MaxLength="2" Width="30" runat="server" /> / <asp:TextBox ID="EndYearText3" MaxLength="4" Width="50" runat="server" /></td>
			<td class="text">(dd/mm/yyyy)</td>
		</tr>
		<tr id="ShowDate4" runat="server">
			<td class="text"><span id="DynamicDateText4" class="text" runat="server"></span></td>
			<td><asp:DropDownList ID="DynamicDate4" CssClass="text" Width="80" runat="server" /></td>
			<td><asp:TextBox ID="StartDayText4" Width="30" MaxLength="2" runat="server" /> / <asp:TextBox ID="StartMonthText4" MaxLength="2" Width="30" runat="server" /> / <asp:TextBox ID="StartYearText4" MaxLength="4" Width="50" runat="server" /></td>
			<td class="text">and</td>
			<td><asp:TextBox ID="EndDayText4" MaxLength="2" Width="30" runat="server" /> / <asp:TextBox ID="EndMonthText4" MaxLength="2" Width="30" runat="server" /> / <asp:TextBox ID="EndYearText4" MaxLength="4" Width="50" runat="server" /></td>
			<td class="text">(dd/mm/yyyy)</td>
		</tr>
		</table>
		</td>
	</tr>
</div>

<tr>
	<td class="text">Display Options:
		<table width="100%">
			<tr>
				<td><asp:CheckBoxList ID="DisplayList" RepeatLayout="Table" RepeatDirection="Horizontal" RepeatColumns="5" Width="100%" CssClass="text" runat="server"></asp:CheckBoxList></td>
			</tr>
		</table>
	</td>
</tr>

<tr><td><asp:button ID="SubmitForm" Font-Size="12" Height="30" Width="120" OnClick="DoSearch" runat="server" /></td></tr>
</table>
</div>

<div id="section2" visible="false" runat="server">
	
<div class="noprint">
<table width="100%">
<tr>
	<td align="left"><div id="totalRecord" class="text" runat="server"></div></td>
	<td align="right"><a href="javascript: window.print()">Print Report</a>&nbsp;&nbsp;<asp:Button ID="ExportExcel" OnClick="ExportToExcel" Height="20" Font-Size="8" Width="120" Text="Export to Excel" runat="server"></asp:Button></td>
</tr>
</table>
</div>
<table width="100%">
<tr>
	<td><asp:DataGrid ID="Results" AutoGenerateColumns="false" CellPadding="3" CssClass="text" HeaderStyle-BackColor="#507093" HeaderStyle-CssClass="smallTdHeader" HeaderStyle-HorizontalAlign="center" AllowPaging="true" OnPageIndexChanged="ChangeGridPage" Width="100%" OnItemDataBound="MemberResults_ItemDataBound" runat="server">
		<columns>
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="#"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="Code"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="Name"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="Address"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" ItemStyle-CssClass="smallText" DataField="Gender"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" ItemStyle-CssClass="smallText" DataField="Group"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="Birthday"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="Age"></asp:BoundColumn>  
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="Tel"></asp:BoundColumn>
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" ItemStyle-CssClass="smallText" DataField="RegExpire"></asp:BoundColumn>
		</columns>
	</asp:DataGrid></td>
</tr>
</table>
</div>

<div id="section3" visible="false" runat="server">
	<table width="100%">
		<tr><td align="center"><div id="FavoriteHeader" class="boldText" runat="server" /></td></tr>
	</table>
<div class="noprint">
<table>
<tr>
	<td valign="top">
		<table>

			<tr>
				<td><asp:DropDownList ID="ShopInfo" CssClass="text" Width="200" AutoPostBack="true" OnSelectedIndexChanged="SelGroup" runat="server"></asp:DropDownList></td>
			</tr>
			<tr>
				<td><asp:DropDownList ID="GroupInfo" CssClass="text" Width="200" AutoPostBack="true" OnSelectedIndexChanged="SelDept" runat="server"></asp:DropDownList></td>
			</tr>
			<tr>
				<td><asp:DropDownList ID="DeptInfo" Width="200" CssClass="text" runat="server"></asp:DropDownList></td>
			</tr>
			<tr>
				<td><asp:dropdownlist ID="GroupByParam" Width="200" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist></td>
			</tr>
		</table></td>
	<td>
	<table>
		<tr>
		<td><asp:radiobutton ID="Radio_3" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="DailyDate" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="Radio_1" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="MonthYearDate0" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="Radio_2" GroupName="Group1" runat="server" /></td>
		<td><synature:date id="CurrentDate" runat="server" /></td>
		<td class="text"><div id="DocumentToDateParam" class="text" runat="server"></div></td>
		<td><synature:date id="ToDate" runat="server" /></td>
	</tr>
	<tr><td>&nbsp;</td>
		<td colspan="4" class="text"><asp:button ID="SubmitFavorite" Font-Size="8" Height="20" Width="110" OnClick="DoSearchFavorite" runat="server" />&nbsp;<asp:CheckBox ID="DisplayGraph" CssClass="text" Checked="false" runat="server" />&nbsp;&nbsp;Display <asp:TextBox ID="NumDisplay" CssClass="text" Width="30" Text="10" runat="server"></asp:TextBox> record(s)</td>
	</tr>
	</table>
	</td>
</tr>
</table>
</div>
<div id="showFavoriteResults" runat="server">
<table id="" width="100%">
<tr><td colspan="2"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td></tr>
<tr><td align="left">
<div id="ResultSearchText" class="boldText" runat="server"></div></td>
<td align="right">
<div id="PercentBaseText" class="text" runat="server"></div></td></tr>
<tr>
	<td colspan="2"><asp:DataGrid ID="FavoriteResults" AutoGenerateColumns="false" CellPadding="3" CssClass="text" HeaderStyle-BackColor="#507093" HeaderStyle-CssClass="tdHeader" HeaderStyle-HorizontalAlign="center" AllowPaging="false" OnItemDataBound="FavoriteResults_ItemDataBound" Width="100%" runat="server">
		<columns>
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" DataField="#"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" DataField="Product Code"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" DataField="Product Name"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="Qty"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="Amount"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="%"></asp:BoundColumn>
		</columns>
	</asp:DataGrid></td>
</tr>
</table>

<asp:Panel ID="showGraph" Visible="false" runat="server">
<br>
<Web:ChartControl id="ChartControl1" ChartPadding=40 runat="Server" />
</asp:Panel>
</div>
</div>

<SCRIPT language="JavaScript">
			function CheckAll(checked) {
				len = document.forms[0].ShopList.length;
				var i=0;
				for( i=0; i<len; i++) {
					document.forms[0].ShopList.options[i].selected=checked;
				}
			}
</script>

<div id="Section4" visible="false" runat="server">
<div class="noprint">
<table border="0">
<tr>
	<td valign="top">
		<table>
        	<tr><td class="text"><a href="javascript:CheckAll(true)">Select&nbsp;All</a> - <a href="javascript:CheckAll(false)">Clear&nbsp;All</a></td></tr>
			<tr>
				<td><asp:ListBox ID="ShopList" SelectionMode="Multiple" Height="120" runat="server"></asp:ListBox></td>
			</tr>
		</table></td>
	<td>
	<table border="0">
		<tr>
		<td><asp:radiobutton ID="Radio_13" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="DailyDate9" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="Radio_11" GroupName="Group1" runat="server" /></td>
		<td colspan="3"><synature:date id="MonthYearDate9" runat="server" /></td>
		</tr>
		<tr>
		<td><asp:radiobutton ID="Radio_12" GroupName="Group1" runat="server" /></td>
		<td width="10%"><synature:date id="CurrentDate9" runat="server" /></td>
		<td class="text" align="center"><span id="DocumentToDateParam9" class="text" runat="server"></span></td>
		<td align="left"><synature:date id="ToDate9" runat="server" /></td>
	</tr>
	<tr><td>&nbsp;</td>
		<td colspan="3" class="text"><asp:button ID="SubmitSale" Font-Size="8" Height="20" Width="110" OnClick="DoSearchSale" runat="server" /></td>
	</tr>
	<tr><td><asp:CheckBox ID="FilterSale" CssClass="text" Checked="false" runat="server" /></td>
		<td colspan="3" class="text">Show members who purchased <asp:DropDownList ID="FilterSaleCriteria" CssClass="text" Width="80" runat="server" /> <asp:TextBox ID="StartAmount" CssClass="text" Width="80" Text="" runat="server"></asp:TextBox> and <asp:TextBox ID="EndAmount" CssClass="text" Width="80" Text="" runat="server"></asp:TextBox> with top <asp:TextBox ID="TopMemberSale" CssClass="text" Width="50" Text="" runat="server"></asp:TextBox> members</td>
	</tr>
	</table>
	</td>
</tr>
</table>
</div>
<div id="showSaleResults" runat="server">
<table id="" width="100%">
<tr><td colspan="2"><div class="noprint"><a href="javascript: window.print()">Print Report</a></div></td></tr>
<tr><td align="left">
<div id="SaleResultText" class="boldText" runat="server"></div></td>
<td align="right"><asp:button ID="ApplyToSearchResult" Font-Size="8" Height="20" Width="150" OnClick="DoApplySearchResult" runat="server" /><span id="ApplyDone" class="boldText" visible="false" runat="server"> Apply Done!</span></td></tr>
<tr>
	<td colspan="2"><asp:DataGrid ID="SaleResults" AutoGenerateColumns="false" CellPadding="3" CssClass="text" HeaderStyle-BackColor="#507093" HeaderStyle-CssClass="tdHeader" HeaderStyle-HorizontalAlign="center" OnItemDataBound="SaleResults_ItemDataBound" AllowPaging="true" OnPageIndexChanged="ChangeGridSalePage" Width="100%" runat="server">
		<columns>
			<asp:BoundColumn ItemStyle-HorizontalAlign="center" DataField="#"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" DataField="Member Code"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="left" DataField="Member Name"></asp:BoundColumn> 
			<asp:BoundColumn ItemStyle-HorizontalAlign="right" DataField="Purchase Amount"></asp:BoundColumn> 

		</columns>
	</asp:DataGrid></td>
</tr>
</table>

</div>
</div>

<div id="Section8" visible="false" runat="server">
<br>
<table>
<tr><td>
<table border="0">
	<tr>
		<td class="text">Mobile Phones</td>
		<td></td>
		<td class="text"><span class="text" id="SMSMembers" runat="server"></span></td>
	</tr>
	<tr id="ValidateEventName" visible="false" runat="Server">
		<td colspan="2"></td>
		<td class="errorText">Event Name cannot be blank</td>
	</tr>
	<tr>
		<td class="requireText">Event Name</td>
		<td></td>
		<td class="text"><asp:TextBox ID="EventName" Width="200" runat="server"></asp:TextBox></td>
	</tr>
	<tr>
		<td class="text">Event Type</td>
		<td></td>
		<td class="text"><asp:DropDownList ID="EventType" Width="200" CssClass="text" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
		</asp:DropDownList></td>
	</tr>
	<tr>
		<td class="text">Send Date</td>
		<td><asp:radiobutton ID="RadioSendDate1" GroupName="SendDateGroup" Checked="true" runat="server" /></td>
		<td class="text">Immediately</td>
	</tr>
	<tr id="ValidateScheduleDate" visible="false" runat="server">
		<td colspan="2"></td>
		<td class="errorText">Invalid date format</td>
	</tr>
	<tr id="ValidateScheduleDateDiff" visible="false" runat="server">
		<td colspan="2"></td>
		<td class="errorText">Schedule date must greater than today</td>
	</tr>
	<tr>
		<td></td>
		<td><asp:radiobutton ID="RadioSendDate2" GroupName="SendDateGroup" Checked="false" runat="server" /></td>
		<td><synature:date id="SendScheduleDate" runat="server" /></td>
	</tr>
	<tr id="ValidateScheduleDateValue" visible="false" runat="server">
		<td colspan="2"></td>
		<td class="errorText">Input box must be numeric number that >=0 </td>
	</tr>
	<tr>
		<td></td>
		<td><asp:radiobutton ID="RadioSendDate3" GroupName="SendDateGroup" Checked="false" runat="server" /></td>
		<td><asp:dropdownlist ID="BeforeAfter" Width="80" runat="server">
							<asp:listitem></asp:listitem>
							<asp:listitem></asp:listitem>
						</asp:dropdownlist> <asp:TextBox ID="ScheduleDateValue" Width="50" Text="0" runat="server"></asp:TextBox> <asp:dropdownlist ID="DateColumn" runat="server"></asp:dropdownlist></td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td><asp:button ID="SubmitSMS" Font-Size="12" Height="30" Width="200" Text="Export SMS Data" OnClick="DoExportSMS" runat="server" /></td>
	</tr>

</table>
</td>
<td></td>
		<td valign="top">
			<table><tr>
			<td class="text">Please select parameters<br><asp:Listbox ID="ColListSMS"  Height="100" Width="150" SelectionMode="Multiple" runat="server"></asp:Listbox></td>
	
			<td><asp:button ID="SubmitMoveRightSMS" Font-Size="8" Height="20" Width="50" Text=" >> " OnClick="MoveRightSMS" runat="server" /><br><br><asp:button ID="SubmitMoveLeftSMS" Font-Size="8" Height="20" Width="50" Text=" << " OnClick="MoveLeftSMS" runat="server" /></td>
	
			<td class="text">Selected parameters<br><asp:Listbox ID="SelColListSMS"  Height="100" Width="150" SelectionMode="Multiple" runat="server"></asp:Listbox></td>
			</tr>
			<tr>
				<td colspan="2" class="text">Attach Coupon Data:<br><asp:DropDownList ID="CouponType" Width="200" CssClass="text" runat="server"></asp:DropDownList></td>
				<td class="text">Start Coupon #: <span class="smalltext">(Blank for Reuse)</span><br><asp:TextBox ID="StartNumberCoupon" Width="100" Text="" runat="server"></asp:TextBox></td>
			</tr>
			<tr>
				<td colspan="3"><span id="CouponError" class="errorText" runat="server"></span></td>
			</tr>
			</table>
		</td>
</tr>
</table>
</div>

<div id="Section5" visible="false" runat="server">
<div id="ShowEmailForm" visible="false" runat="server">
<table border="0" width="100%">
	<tr><td colspan="2" height="10"></td></tr>
	<tr><td></td><td class="boldText">Sending Email Form</td></tr>
	<tr><td colspan="2" height="10"></td></tr>
	<tr>
		<td class="text" width="5%">To:</td>
		<td class="text"><span id="ToEmailText" class="text" runat="server"></span></td>
	</tr>
	<tr>
		<td class="text">From:</td>
		<td class="text"><asp:TextBox ID="EmailFrom" Width="200" runat="server"></asp:TextBox><span id="EmailInvalid" class="errorText" visible="false" runat="server">*Invalid email address.</span></td>
	</tr>
	<tr>
		<td class="text">Subject:</td>
		<td class="text"><asp:TextBox ID="EmailSubject" Width="200" runat="server"></asp:TextBox><span id="SubjectInvalid" class="errorText" visible="false" runat="server">*Subject cannot be blank.</span></td>
	</tr>
	<tr>
		<td class="text">CC:</td>
		<td class="text"><asp:TextBox ID="EmailCC" Width="200" runat="server"></asp:TextBox></td>
	</tr>
	<tr>
		<td class="text" valign="top">Message:</td>
		<td class="text"><FCKeditorV2:FCKeditor id="FCKeditor1" height="300" width="90%" runat="server" value=''></FCKeditorV2:FCKeditor></td>
	</tr>
	<tr>
		<td></td>
		<td><asp:button ID="SubmitEmail" Font-Size="8" Height="20" Width="110" Text="Send Email" OnClick="DoSendEmail" runat="server" /></td>
	</tr>
</table>
</div>
<div id="ConfirmationEmail" visible="false" runat="server">
<table width="100%">
	<tr><td height="10"></td></tr>
	<tr><td class="boldText">Confirmation Sending Email</td></tr>
	<tr><td height="10"></td></tr>
</table>
<table border="1" cellpadding="4" cellspacing="0" width="100%" style="border-collapse:collapse;">
	<tr>
		<td class="text" width="5%">To:</td>
		<td class="text"><span id="CToEmailText" class="text" runat="server"></span></td>
	</tr>
	<tr>
		<td class="text">From:</td>
		<td class="text"><span id="CFromEmailText" class="text" runat="server"></span></td>
	</tr>
	<tr>
		<td class="text">Subject:</td>
		<td class="text"><span id="CSubjectEmailText" class="text" runat="server"></span></td>
	</tr>
	<tr>
		<td class="text">CC:</td>
		<td class="text"><span id="CCCEmailText" class="text" runat="server"></span></td>
	</tr>
	<tr>
		<td class="text" valign="top">Message:</td>
		<td class="text"><% = Request.Form("FCKeditor1") %></td>
	</tr>
	<tr>
		<td></td>
		<td><asp:button ID="CSubmitEmail" Font-Size="8" Height="20" Width="110" Text="Send Email" OnClick="DoCSendEmail" runat="server" /> <asp:button ID="CancelSubmitEmail" Font-Size="8" Height="20" Width="110" Text="Cancel" OnClick="DoCancelSendEmail" runat="server" /></td>
	</tr>
</table>
</div>
<div id="FinalSendEmail" visible="false" runat="server">
<table width="100%">
	<tr><td height="10" colspan="2"></td></tr>
	<tr><td class="boldText"><span id="SendEmailMsg" class="boldText" runat="server"></span></td><td align="right"><asp:button ID="FinishSubmitEmail" Font-Size="8" Height="20" Width="150" Text="Back to Sending Email Form" OnClick="FinishSendEmail" runat="server" /></td></tr>
	<tr><td height="10" colspan="2"></td></tr>
	<tr><td colspan="2"><span id="EmailListSent" class="text" runat="server"></span></td></tr>
</table>
</div>
</div>

<div id="Section6" visible="false" runat="server">

</div>

<div id="Section7" visible="false" runat="server">
<table>
	<tr>
		<td height="20">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldText">Select dynamic columns to be critiria on search page:</td>
	</tr>
	<tr>
		<td height="10">&nbsp;</td>
	</tr>
	<tr>
		<td class="smallText">
		(Only 6 option columns will be displayed at "Search Criteria")
		
		<table><tr>
		<td class="text">Please select option columns<br><asp:Listbox ID="ColList"  Height="100" Width="200" SelectionMode="Multiple" runat="server"></asp:Listbox></td>

		<td><asp:button ID="SubmitMoveRight" Font-Size="8" Height="20" Width="50" Text=" >> " OnClick="MoveRight" runat="server" /><br><br><asp:button ID="SubmitMoveLeft" Font-Size="8" Height="20" Width="50" Text=" << " OnClick="MoveLeft" runat="server" /></td>

		<td class="text">Selected option columns<br><asp:Listbox ID="SelColList"  Height="100" Width="200" SelectionMode="Multiple" runat="server"></asp:Listbox></td>
		</tr>
		
		</table></td>
	</tr>
	
	<tr>
		<td class="smalltext">(Only 3 numeric columns will be displayed at "Search Criteria")
		<table><tr>
		<td class="text">Please select numeric columns<br><asp:Listbox ID="ColNumericList"  Height="100" Width="200" SelectionMode="Multiple" runat="server"></asp:Listbox></td>

		<td><asp:button ID="SubmitMoveRightNumeric" Font-Size="8" Height="20" Width="50" Text=" >> " OnClick="MoveRightNumeric" runat="server" /><br><br><asp:button ID="SubmitMoveLeftNumeric" Font-Size="8" Height="20" Width="50" Text=" << " OnClick="MoveLeftNumeric" runat="server" /></td>

		<td class="text">Selected numeric columns<br><asp:Listbox ID="SelNumericColList"  Height="100" Width="200" SelectionMode="Multiple" runat="server"></asp:Listbox></td>
		</tr>
		</table></td>
	</tr>
	
	<tr>
		<td class="smalltext">(Only 3 date columns will be displayed at "Search Criteria")
		<table><tr>
		<td class="text">Please select date columns<br><asp:Listbox ID="ColDateList"  Height="100" Width="200" SelectionMode="Multiple" runat="server"></asp:Listbox></td>

		<td><asp:button ID="SubmitMoveRightDate" Font-Size="8" Height="20" Width="50" Text=" >> " OnClick="MoveRightDate" runat="server" /><br><br><asp:button ID="SubmitMoveLeftDate" Font-Size="8" Height="20" Width="50" Text=" << " OnClick="MoveLeftDate" runat="server" /></td>

		<td class="text">Selected date columns<br><asp:Listbox ID="SelDateColList"  Height="100" Width="200" SelectionMode="Multiple" runat="server"></asp:Listbox></td>
		</tr>

		</table></td>
	</tr>
</table>
</div>

<div id="testMsg" runat="server"></div>

<div id="errorMsg" style="color:red;" runat="server" />
</td>
<td>&nbsp;</td>
</tr>
</form>
<tr><td colspan="3" height="30">&nbsp;</td></tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
<tr>
	<td height="50" colspan="3" background="../images/footerbg2000.gif">&nbsp;</td>
</tr>
<tr><td height="1" colspan="3" bgcolor="999999"><p style="line-height:1px;"><img src="../images/clear.gif" height="1" width="1"></p></td></tr>
</table>
<script language="VB" runat="server">
Dim objCnn As New MySqlConnection()
Dim getCnn As New CDBUtil()
Dim Util As New UtilityFunction()
Dim FormatObject As New FormatClass()
Dim getData As New CMembers()
Dim getPageText As New DefaultText()
Dim objDB As New CDBUtil()
Dim getProp As New CPreferences()
Dim DateTimeUtil As New MyDateTime()
Dim getInfo As New CCategory()
Dim getReport As New stReports()
Dim PromiseCRM As New CRMModule()
Dim gstrSortOrder As String
Dim RecordPerPage As Integer = 50


Sub Page_Load()
	If User.Identity.IsAuthenticated AND Session("Analyze_Member") Then
				
		Dim SystemPath As String = Replace(Request.ServerVariables("PATH_INFO"),"Reports/Analyze_Member.aspx","")
		SystemPath += "FCKeditor/"
		FCKeditor1.BasePath = SystemPath
		
		Dim QueryStringList As String
		Dim InvC As CultureInfo = CultureInfo.InvariantCulture
		SearchCriteria.Text = "Search Criteria"
		SearchResult.Text = "Search Result"
		BestSeller.Text = "Favorite Products"
		SaleReport.Text = "Member Sale Report"
		SMSForm.Text = "Send SMS"
		EmailForm.Text = "Send Email"
		LabelLink.Text = "Printing Label"
		Options.Text = "Options"
		ApplyToSearchResult.Text = "Apply to Search Result"
		errorMsg.InnerHtml = ""
		CouponError.InnerHtml = ""
		
		
		Try
			objCnn = getCnn.EstablishConnection()
			Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)	
			
			If PropertyInfo.Rows(0)("ImportDataToCopyTable") = 0 Then
				'ShopList.SelectionMode = "Single"
			End If
			
			If PropertyInfo.Rows(0)("SMSFeature") = 1 Then
				ShowSMS.Visible = True
			End If
			If PropertyInfo.Rows(0)("SystemEditionID") = 1 Then
				ShowOptions.Visible = False
				ShowEmail.Visible = False
				ShowSMS.Visible = False
			End If
			
			Dim GetReportLog As DataTable = getReport.ReportLog(objCnn)
			If GetReportLog.Rows.Count > 0 Then
				DBText.InnerHtml = "Report Database: " + Format(GetReportLog.Rows(0)("LogDateTime"), "dd MMMM yyyy HH:mm:ss") + "&nbsp;&nbsp;"
			Else
				DBText.InnerHtml = "Report Database&nbsp;&nbsp;"
			End If
				
			Dim textTable As New DataTable()
			textTable = getPageText.GetText(11,Session("LangID"),objCnn)
			
			Dim defaultTextTable As New DataTable()
			defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
			
			SectionText.InnerHtml = "Member Data Analysis"
			
			Dim i As Integer
			
			CodeSearchText.InnerHtml = textTable.Rows(19)("TextParamValue")
			FirstNameSearchText.InnerHtml = defaultTextTable.Rows(16)("TextParamValue")
			LastNameSearchText.InnerHtml = defaultTextTable.Rows(17)("TextParamValue")
			GroupSearchText.InnerHtml = textTable.Rows(18)("TextParamValue")
			TelSearchText.InnerHtml = defaultTextTable.Rows(23)("TextParamValue")
			MobileSearchText.InnerHtml = defaultTextTable.Rows(27)("TextParamValue")
			GenderSearchText.InnerHtml = defaultTextTable.Rows(28)("TextParamValue")
			SubmitForm.Text = defaultTextTable.Rows(92)("TextParamValue")
			
			FromAgeText.InnerHtml =  textTable.Rows(47)("TextParamValue")
			ToAgeText.InnerHtml =  defaultTextTable.Rows(91)("TextParamValue")
			BirthDayText.InnerHtml =  defaultTextTable.Rows(31)("TextParamValue")
			BirthDayPeriodText.InnerHtml =  defaultTextTable.Rows(104)("TextParamValue")
			ToPeriodText.InnerHtml =  defaultTextTable.Rows(91)("TextParamValue")
			NAText.InnerHtml =  defaultTextTable.Rows(103)("TextParamValue")
			DocumentToDateParam9.InnerHtml =  defaultTextTable.Rows(91)("TextParamValue")
			ProvinceText.InnerHtml = defaultTextTable.Rows(21)("TextParamValue")
			CityText.InnerHtml = defaultTextTable.Rows(20)("TextParamValue")
			SearchText1.InnerHtml = textTable.Rows(48)("TextParamValue")
			DayText.InnerHtml = defaultTextTable.Rows(106)("TextParamValue")
			OnlyNotExpire.Text = textTable.Rows(49)("TextParamValue")
			
			ProductCriteriaText.InnerHtml = "From"
			ToProductCriteriaText.InnerHtml = "To"
			
			MonthYearDate.YearType = GlobalParam.YearType
			MonthYearDate.FormName = "MonthYearDate"
			MonthYearDate.StartYear = GlobalParam.StartYear
			MonthYearDate.EndYear = GlobalParam.EndYear
			MonthYearDate.LangID = Session("LangID")
			MonthYearDate.ShowDay = False
			
			MonthYearDate1.YearType = GlobalParam.YearType
			MonthYearDate1.FormName = "MonthYearDate1"
			MonthYearDate1.StartYear = 100
			MonthYearDate1.EndYear = 0
			MonthYearDate1.LangID = Session("LangID")
			MonthYearDate1.ShowDay = False
			
			MonthYearDate2.YearType = GlobalParam.YearType
			MonthYearDate2.FormName = "MonthYearDate2"
			MonthYearDate2.StartYear = 100
			MonthYearDate2.EndYear = 0
			MonthYearDate2.LangID = Session("LangID")
			MonthYearDate2.ShowDay = False
			
			MonthYearDate11.YearType = GlobalParam.YearType
			MonthYearDate11.FormName = "MonthYearDate11"
			MonthYearDate11.StartYear = 1
			MonthYearDate11.EndYear = 0
			MonthYearDate11.LangID = Session("LangID")
			MonthYearDate11.ShowDay = False
			
			MonthYearDate12.YearType = GlobalParam.YearType
			MonthYearDate12.FormName = "MonthYearDate12"
			MonthYearDate12.StartYear = 1
			MonthYearDate12.EndYear = 0
			MonthYearDate12.LangID = Session("LangID")
			MonthYearDate12.ShowDay = False
			
			If Page.IsPostBack Then
				If IsNumeric(Request.Form("SelMonth")) Then
					MonthYearDate.SelectedMonth = Request.Form("SelMonth")
				End If
				If IsNumeric(Request.Form("SelYear")) Then
					MonthYearDate.SelectedYear = Request.Form("SelYear")
				End If
				If IsNumeric(Request.Form("SelMonth1")) Then
					MonthYearDate1.SelectedMonth = Request.Form("SelMonth1")
				End If
				If IsNumeric(Request.Form("SelYear1")) Then
					MonthYearDate1.SelectedYear = Request.Form("SelYear1")
				End If
				If IsNumeric(Request.Form("SelMonth2")) Then
					MonthYearDate2.SelectedMonth = Request.Form("SelMonth2")
				End If
				If IsNumeric(Request.Form("SelYear2")) Then
					MonthYearDate2.SelectedYear = Request.Form("SelYear2")
				End If
				
				If IsNumeric(Request.Form("SelMonth11")) Then
					MonthYearDate11.SelectedMonth = Request.Form("SelMonth11")
				End If
				If IsNumeric(Request.Form("SelYear11")) Then
					MonthYearDate11.SelectedYear = Request.Form("SelYear11")
				End If
				If IsNumeric(Request.Form("SelMonth12")) Then
					MonthYearDate12.SelectedMonth = Request.Form("SelMonth12")
				End If
				If IsNumeric(Request.Form("SelYear12")) Then
					MonthYearDate12.SelectedYear = Request.Form("SelYear12")
				End If

			End If
			
			'-------- Section 3 Parameters---------
			GroupByParam.Items(0).Text = "Top Product Sale By Price"
			GroupByParam.Items(0).Value = "1"
			GroupByParam.Items(1).Text = "Top Product Sale By Amount"
			GroupByParam.Items(1).Value = "2"
			GroupByParam.Items(2).Text = "Lowest Product Sale By Price"
			GroupByParam.Items(2).Value = "3"
			GroupByParam.Items(3).Text = "Lowest Product Sale By Amount"
			GroupByParam.Items(3).Value = "4"
			
			DisplayGraph.Text = "Display Graph"
			
			DocumentToDateParam.InnerHtml = defaultTextTable.Rows(91)("TextParamValue")
			
			DailyDate.YearType = GlobalParam.YearType
			DailyDate.FormName = "DocDaily"
			DailyDate.StartYear = GlobalParam.StartYear
			DailyDate.EndYear = GlobalParam.EndYear
		DailyDate.LangID = Session("LangID")
		DailyDate.Lang_Data = LangDefault
		DailyDate.Culture = CultureString
		
		CurrentDate.YearType = GlobalParam.YearType
			CurrentDate.FormName = "Doc"
			CurrentDate.StartYear = GlobalParam.StartYear
			CurrentDate.EndYear = GlobalParam.EndYear
		CurrentDate.LangID = Session("LangID")
		CurrentDate.Lang_Data = LangDefault
		CurrentDate.Culture = CultureString
		
		ToDate.YearType = GlobalParam.YearType
			ToDate.FormName = "DocTo"
			ToDate.StartYear = GlobalParam.StartYear
			ToDate.EndYear = GlobalParam.EndYear
			ToDate.LangID = Session("LangID")
			
			MonthYearDate0.YearType = GlobalParam.YearType
			MonthYearDate0.FormName = "MonthYearDate0"
			MonthYearDate0.StartYear = GlobalParam.StartYear
			MonthYearDate0.EndYear = GlobalParam.EndYear
			MonthYearDate0.LangID = Session("LangID")
			MonthYearDate0.ShowDay = False
			MonthYearDate0.SelectedMonth = Month(Now())
			MonthYearDate0.SelectedYear =  DateTime.Now.ToString("yyyy", InvC) 
			
			DailyDate9.YearType = GlobalParam.YearType
			DailyDate9.FormName = "DocDaily9"
			DailyDate9.StartYear = GlobalParam.StartYear
			DailyDate9.EndYear = GlobalParam.EndYear
			DailyDate9.LangID = Session("LangID")
			
			CurrentDate9.YearType = GlobalParam.YearType
			CurrentDate9.FormName = "Doc9"
			CurrentDate9.StartYear = GlobalParam.StartYear
			CurrentDate9.EndYear = GlobalParam.EndYear
			CurrentDate9.LangID = Session("LangID")
			
			ToDate9.YearType = GlobalParam.YearType
			ToDate9.FormName = "DocTo9"
			ToDate9.StartYear = GlobalParam.StartYear
			ToDate9.EndYear = GlobalParam.EndYear
			ToDate9.LangID = Session("LangID")
			
			MonthYearDate9.YearType = GlobalParam.YearType
			MonthYearDate9.FormName = "MonthYearDate9"
			MonthYearDate9.StartYear = GlobalParam.StartYear
			MonthYearDate9.EndYear = GlobalParam.EndYear
			MonthYearDate9.LangID = Session("LangID")
			MonthYearDate9.ShowDay = False
			MonthYearDate9.SelectedMonth = Month(Now())
			MonthYearDate9.SelectedYear =  DateTime.Now.ToString("yyyy", InvC) 
			
			SubmitFavorite.Text = "Submit Query"
			SubmitSale.Text = "Submit Query"
			
			If Page.IsPostBack Then
				If IsNumeric(Request.Form("MonthYearDate0_Month")) Then
					MonthYearDate0.SelectedMonth = Request.Form("MonthYearDate0_Month")
				ElseIf IsNumeric(Request.Form("SelMonth0")) Then
					MonthYearDate0.SelectedMonth = Request.Form("SelMonth0")
				End If
				If IsNumeric(Request.Form("MonthYearDate0_Year")) Then
					MonthYearDate0.SelectedYear = Request.Form("MonthYearDate0_Year")
				ElseIf IsNumeric(Request.Form("SelYear0")) Then
					MonthYearDate0.SelectedYear = Request.Form("SelYear0")
				End If
				
				If IsNumeric(Request.Form("DocDaily_Day")) Then
					DailyDate.SelectedDay = Request.Form("DocDaily_Day")
				ElseIf IsNumeric(Request.Form("DocDailyDay")) Then
					DailyDate.SelectedDay = Request.Form("DocDailyDay")
				End If
				If IsNumeric(Request.Form("DocDaily_Month")) Then
					DailyDate.SelectedMonth = Request.Form("DocDaily_Month")
				ElseIf IsNumeric(Request.Form("DocDailyMonth")) Then
					DailyDate.SelectedMonth = Request.Form("DocDailyMonth")
				End If
				If IsNumeric(Request.Form("DocDaily_Year")) Then
					DailyDate.SelectedYear = Request.Form("DocDaily_Year")
				ElseIf IsNumeric(Request.Form("DocDailyYear")) Then
					DailyDate.SelectedYear = Request.Form("DocDailyYear")
				End If
				
				If IsNumeric(Request.Form("Doc_Day")) Then
					CurrentDate.SelectedDay = Request.Form("Doc_Day")
				ElseIf IsNumeric(Request.Form("DocDay")) Then
					CurrentDate.SelectedDay = Request.Form("DocDay")
				End If
				If IsNumeric(Request.Form("Doc_Month")) Then
					CurrentDate.SelectedMonth = Request.Form("Doc_Month")
				ElseIf IsNumeric(Request.Form("DocMonth")) Then
					CurrentDate.SelectedMonth = Request.Form("DocMonth")
				End If
				If IsNumeric(Request.Form("Doc_Year")) Then
					CurrentDate.SelectedYear = Request.Form("Doc_Year")
				ElseIf IsNumeric(Request.Form("DocYear")) Then
					CurrentDate.SelectedYear = Request.Form("DocYear")
				End If
				
				If IsNumeric(Request.Form("DocTo_Day")) Then
					ToDate.SelectedDay = Request.Form("DocTo_Day")
				ElseIf IsNumeric(Request.Form("DocToDay")) Then
					ToDate.SelectedDay = Request.Form("DocToDay")
				End If
				If IsNumeric(Request.Form("DocTo_Month")) Then
					ToDate.SelectedMonth = Request.Form("DocTo_Month")
				ElseIf IsNumeric(Request.Form("DocToMonth")) Then
					ToDate.SelectedMonth = Request.Form("DocToMonth")
				End If
				If IsNumeric(Request.Form("DocTo_Year")) Then
					ToDate.SelectedYear = Request.Form("DocTo_Year")
				ElseIf IsNumeric(Request.Form("DocToYear")) Then
					ToDate.SelectedYear = Request.Form("DocToYear")
				End If
				
				
				If IsNumeric(Request.Form("MonthYearDate9_Month")) Then
					MonthYearDate9.SelectedMonth = Request.Form("MonthYearDate9_Month")
				ElseIf IsNumeric(Request.Form("SelMonth9")) Then
					MonthYearDate9.SelectedMonth = Request.Form("SelMonth9")
				End If
				If IsNumeric(Request.Form("MonthYearDate9_Year")) Then
					MonthYearDate9.SelectedYear = Request.Form("MonthYearDate9_Year")
				ElseIf IsNumeric(Request.Form("SelYear9")) Then
					MonthYearDate9.SelectedYear = Request.Form("SelYear9")
				End If
				
				If IsNumeric(Request.Form("DocDaily9_Day")) Then
					DailyDate9.SelectedDay = Request.Form("DocDaily9_Day")
				ElseIf IsNumeric(Request.Form("DocDailyDay9")) Then
					DailyDate9.SelectedDay = Request.Form("DocDailyDay9")
				End If
				If IsNumeric(Request.Form("DocDaily9_Month")) Then
					DailyDate9.SelectedMonth = Request.Form("DocDaily9_Month")
				ElseIf IsNumeric(Request.Form("DocDailyMonth9")) Then
					DailyDate9.SelectedMonth = Request.Form("DocDailyMonth9")
				End If
				If IsNumeric(Request.Form("DocDaily9_Year")) Then
					DailyDate9.SelectedYear = Request.Form("DocDaily9_Year")
				ElseIf IsNumeric(Request.Form("DocDailyYear9")) Then
					DailyDate9.SelectedYear = Request.Form("DocDailyYear9")
				End If
				
				If IsNumeric(Request.Form("Doc9_Day")) Then
					CurrentDate9.SelectedDay = Request.Form("Doc9_Day")
				ElseIf IsNumeric(Request.Form("DocDay9")) Then
					CurrentDate9.SelectedDay = Request.Form("DocDay9")
				End If
				If IsNumeric(Request.Form("Doc9_Month")) Then
					CurrentDate9.SelectedMonth = Request.Form("Doc9_Month")
				ElseIf IsNumeric(Request.Form("DocMonth9")) Then
					CurrentDate9.SelectedMonth = Request.Form("DocMonth9")
				End If
				If IsNumeric(Request.Form("Doc9_Year")) Then
					CurrentDate9.SelectedYear = Request.Form("Doc9_Year")
				ElseIf IsNumeric(Request.Form("DocYear9")) Then
					CurrentDate9.SelectedYear = Request.Form("DocYear9")
				End If
				
				If IsNumeric(Request.Form("DocTo9_Day")) Then
					ToDate9.SelectedDay = Request.Form("DocTo9_Day")
				ElseIf IsNumeric(Request.Form("DocToDay9")) Then
					ToDate9.SelectedDay = Request.Form("DocToDay9")
				End If
				If IsNumeric(Request.Form("DocTo9_Month")) Then
					ToDate9.SelectedMonth = Request.Form("DocTo9_Month")
				ElseIf IsNumeric(Request.Form("DocToMonth9")) Then
					ToDate9.SelectedMonth = Request.Form("DocToMonth9")
				End If
				If IsNumeric(Request.Form("DocTo9_Year")) Then
					ToDate9.SelectedYear = Request.Form("DocTo9_Year")
				ElseIf IsNumeric(Request.Form("DocToYear9")) Then
					ToDate9.SelectedYear = Request.Form("DocToYear9")
				End If
				
				If IsNumeric(Request.Form("SendDate_Day")) Then
					SendScheduleDate.SelectedDay = Request.Form("SendDate_Day")
				ElseIf IsNumeric(Request.Form("SendDateDay")) Then
					SendScheduleDate.SelectedDay = Request.Form("SendDateDay")
				End If
				If IsNumeric(Request.Form("SendDate_Month")) Then
					SendScheduleDate.SelectedMonth = Request.Form("SendDate_Month")
				ElseIf IsNumeric(Request.Form("SendDateMonth")) Then
					SendScheduleDate.SelectedMonth = Request.Form("SendDateMonth")
				End If
				If IsNumeric(Request.Form("SendDate_Year")) Then
					SendScheduleDate.SelectedYear = Request.Form("SendDate_Year")
				ElseIf IsNumeric(Request.Form("SendDateYear")) Then
					SendScheduleDate.SelectedYear = Request.Form("SendDateYear")
				End If
			End If
			'-------- End Section 3 -------------
			
			'----------- Section 8 -------------
			BeforeAfter.Items(0).Text = "Before"
			BeforeAfter.Items(0).Value = "-1"
			BeforeAfter.Items(1).Text = "After"
			BeforeAfter.Items(1).Value = "1"
			
			EventType.Items(0).Text = "General"
			EventType.Items(0).Value = "General"
			EventType.Items(1).Text = "Promotion"
			EventType.Items(1).Value = "Promotion"
			EventType.Items(2).Text = "Reminder"
			EventType.Items(2).Value = "Reminder"
			EventType.Items(3).Text = "News & Events"
			EventType.Items(3).Value = "News & Events"
			EventType.Items(4).Text = "Greeting"
			EventType.Items(4).Value = "Greeting"
			EventType.Items(5).Text = "Birthday"
			EventType.Items(5).Value = "Birthday"
			EventType.Items(6).Text = "New Year"
			EventType.Items(6).Value = "New Year"
			EventType.Items(7).Text = "Customer Care"
			EventType.Items(7).Value = "Customer Care"
			
			SendScheduleDate.YearType = GlobalParam.YearType
			SendScheduleDate.FormName = "SendDate"
			SendScheduleDate.StartYear = -1
			SendScheduleDate.EndYear = 2
			SendScheduleDate.LangID = Session("LangID")
			
			'----------- End Section 8 ---------
			
			If Not Page.IsPostBack Then
				If PropertyInfo.Rows.Count > 0 Then
					If Not IsDBNull(PropertyInfo.Rows(0)("WebmasterEmail")) Then
						EmailFrom.Text = PropertyInfo.Rows(0)("WebmasterEmail")
					Else
						EmailFrom.Text = ""
					End If
				End If
				Radio4.Checked = True
				Radio_11.Checked = True
				Radio_1.Checked = True
				
				GenderList.Items(0).Text = defaultTextTable.Rows(29)("TextParamValue")
				GenderList.Items(0).Value = "1"
				GenderList.Items(1).Text = defaultTextTable.Rows(30)("TextParamValue")
				GenderList.Items(1).Value = "2"
				GenderList.Items(2).Text = "N/A"
				GenderList.Items(2).Value = "0"
				
				GenderList.Items(2).Selected = True
				
				UDDDataBound(0,objCnn)
				UDDDataBoundSMS(objCnn)
				CheckDynamicCol(Session("StaffID"),objCnn)
			
				Dim GroupTable As New DataTable()
				GroupTable = getData.GetMemberInfo(4,-1,-1,-1,"MemberGroupID",objCnn)
				Dim outputString,FormSelected As String
				
				Dim SelectString As String = textTable.Rows(11)("TextParamValue")
				
				Dim myDataTable As DataTable = new DataTable("ParentTable")
	
				Dim myDataColumn As DataColumn 
				Dim myDataRow As DataRow
	
				myDataColumn = New DataColumn()
				myDataColumn.DataType = System.Type.GetType("System.Int32")
				myDataColumn.ColumnName = "MemberGroupID"
				myDataColumn.ReadOnly = True
				myDataColumn.Unique = True
				myDataTable.Columns.Add(myDataColumn)
				
				myDataColumn = New DataColumn()
				myDataColumn.DataType = System.Type.GetType("System.String")
				myDataColumn.ColumnName = "MemberGroupName"
				myDataTable.Columns.Add(myDataColumn)
	
				myDataRow = myDataTable.NewRow()
				myDataRow("MemberGroupID") = 0
				myDataRow("MemberGroupName") = SelectString
				myDataTable.Rows.Add(myDataRow)
				
				myDataRow = myDataTable.NewRow()
				myDataRow("MemberGroupID") = -1
				myDataRow("MemberGroupName") = textTable.Rows(12)("TextParamValue")
				myDataTable.Rows.Add(myDataRow)
				   
				For i = 0 to GroupTable.Rows.Count - 1
				   myDataRow = myDataTable.NewRow()
				   myDataRow("MemberGroupID") = GroupTable.Rows(i)("MemberGroupID")
				   myDataRow("MemberGroupName") = GroupTable.Rows(i)("MemberGroupName")
				   myDataTable.Rows.Add(myDataRow)
				Next i
				
				GroupList.DataSource = myDataTable
				GroupList.DataValueField = "MemberGroupID"
				GroupList.DataTextField = "MemberGroupName"
				GroupList.DataBind()
				
				Dim provinceTable As DataTable = new DataTable("ParentTable")
	
				Dim myDataColumn1 As DataColumn 
	
				myDataColumn1 = New DataColumn()
				myDataColumn1.DataType = System.Type.GetType("System.Int32")
				myDataColumn1.ColumnName = "ProvinceID"
				myDataColumn1.ReadOnly = True
				myDataColumn1.Unique = True
				provinceTable.Columns.Add(myDataColumn1)
				
				myDataColumn1 = New DataColumn()
				myDataColumn1.DataType = System.Type.GetType("System.String")
				myDataColumn1.ColumnName = "ProvinceName"
				provinceTable.Columns.Add(myDataColumn1)
	
				myDataRow = provinceTable.NewRow()
				myDataRow("ProvinceID") = 0
				myDataRow("ProvinceName") = defaultTextTable.Rows(102)("TextParamValue")
				provinceTable.Rows.Add(myDataRow)
				
				Dim provinceData As DataTable = objDB.List("select ProvinceID,ProvinceName from provinces where LangID=" + Session("LangID").ToString + " order by ProvinceName", objCnn)
				
				For i = 0 to provinceData.Rows.Count - 1
				   myDataRow = provinceTable.NewRow()
				   myDataRow("ProvinceID") = provinceData.Rows(i)("ProvinceID")
				   myDataRow("ProvinceName") = provinceData.Rows(i)("ProvinceName")
				   provinceTable.Rows.Add(myDataRow)
				Next i
				Province.DataSource = provinceTable
				Province.DataValueField = "ProvinceID"
				Province.DataTextField = "ProvinceName"
				Province.DataBind()
				Province.Items(0).Selected = True
				
				Dim displayTable As DataTable = new DataTable("ParentTable")
	
				Dim myDataColumn2 As DataColumn 
	
				myDataColumn2 = New DataColumn()
				myDataColumn2.DataType = System.Type.GetType("System.Int32")
				myDataColumn2.ColumnName = "ID"
				myDataColumn2.ReadOnly = True
				myDataColumn2.Unique = True
				displayTable.Columns.Add(myDataColumn2)
				
				myDataColumn2 = New DataColumn()
				myDataColumn2.DataType = System.Type.GetType("System.String")
				myDataColumn2.ColumnName = "Name"
				displayTable.Columns.Add(myDataColumn2)
				
				myDataRow = displayTable.NewRow()
				myDataRow("ID") = 1
				myDataRow("Name") = textTable.Rows(19)("TextParamValue")
				displayTable.Rows.Add(myDataRow)
				
				myDataRow = displayTable.NewRow()
				myDataRow("ID") = 2
				myDataRow("Name") = textTable.Rows(17)("TextParamValue") + "/" + defaultTextTable.Rows(25)("TextParamValue")
				displayTable.Rows.Add(myDataRow)
				
				myDataRow = displayTable.NewRow()
				myDataRow("ID") = 3
				myDataRow("Name") = defaultTextTable.Rows(47)("TextParamValue")
				displayTable.Rows.Add(myDataRow)
				
				myDataRow = displayTable.NewRow()
				myDataRow("ID") = 4
				myDataRow("Name") = defaultTextTable.Rows(28)("TextParamValue")
				displayTable.Rows.Add(myDataRow)
				
				myDataRow = displayTable.NewRow()
				myDataRow("ID") = 5
				myDataRow("Name") = textTable.Rows(18)("TextParamValue")
				displayTable.Rows.Add(myDataRow)
				
				myDataRow = displayTable.NewRow()
				myDataRow("ID") = 6
				myDataRow("Name") = defaultTextTable.Rows(31)("TextParamValue")
				displayTable.Rows.Add(myDataRow)
				
				myDataRow = displayTable.NewRow()
				myDataRow("ID") = 7
				myDataRow("Name") = defaultTextTable.Rows(105)("TextParamValue")
				displayTable.Rows.Add(myDataRow)
				
				myDataRow = displayTable.NewRow()
				myDataRow("ID") = 8
				myDataRow("Name") = defaultTextTable.Rows(23)("TextParamValue") + "/<br>" + defaultTextTable.Rows(27)("TextParamValue")
				displayTable.Rows.Add(myDataRow)
				
				myDataRow = displayTable.NewRow()
				myDataRow("ID") = 9
				myDataRow("Name") = "Register Date/<br>Expire Date"
				displayTable.Rows.Add(myDataRow)
				
				DisplayList.DataSource = displayTable
				DisplayList.DataValueField = "ID"
				DisplayList.DataTextField = "Name"
				DisplayList.DataBind()
				
				For i = 0 To DisplayList.Items.Count - 1
					If i <> 2 AND i <> 4 Then
						DisplayList.Items(i).Selected = True
					Else
						DisplayList.Items(i).Selected = False
					End If
				Next
				
				
				
				'-------- Section 3 Default Data ----------
				Dim ShopData As DataTable = getInfo.GetAllShopData(objCnn)'getInfo.GetProductLevelAccess(-999,Session("StaffRole"),objCnn)
				ShopInfo.DataSource = ShopData
				ShopInfo.DataValueField = "ProductLevelID"
				ShopInfo.DataTextField = "ProductLevelName"
				ShopInfo.DataBind()
				
				ShowGroup()
				
				Dim ShopData1 As DataTable = getInfo.GetProductLevel(-999,objCnn)
				ShopInfo1.DataSource = ShopData1
				ShopInfo1.DataValueField = "ProductLevelID"
				ShopInfo1.DataTextField = "ProductLevelName"
				ShopInfo1.DataBind()
				
				ShowGroup1()

				'-------- End Section 3 -------------
				
				'----------- Section 4 -------------
				ShopList.DataSource = ShopData
				ShopList.DataValueField = "ProductLevelID"
				ShopList.DataTextField = "ProductLevelName"
				ShopList.DataBind()
				If ShopData.Rows.Count > 0 Then
					ShopList.Items(0).Selected = True
				End If
				'----------- End Section 4 -----------
				
				Dim DateColData As DataTable = new DataTable("ParentTable")
				Dim myDataColumn3 As DataColumn 
				Dim myDataRow1 As DataRow
	
				myDataColumn3 = New DataColumn()
				myDataColumn3.DataType = System.Type.GetType("System.Int32")
				myDataColumn3.ColumnName = "UDDID"
				myDataColumn3.ReadOnly = True
				myDataColumn3.Unique = True
				DateColData.Columns.Add(myDataColumn3)
				
				myDataColumn3 = New DataColumn()
				myDataColumn3.DataType = System.Type.GetType("System.String")
				myDataColumn3.ColumnName = "ColumnName"
				DateColData.Columns.Add(myDataColumn3)
	
				myDataRow1 = DateColData.NewRow()
				myDataRow1("UDDID") = -100
				myDataRow1("ColumnName") = "Date of Birth"
				DateColData.Rows.Add(myDataRow1)
				
				myDataRow1 = DateColData.NewRow()
				myDataRow1("UDDID") = -99
				myDataRow1("ColumnName") = "Expire Date"
				DateColData.Rows.Add(myDataRow1)
				
				Dim DateData As DataTable = PromiseCRM.UDDForDynamicAll(1, objCnn)
				Dim ii As Integer
				For ii = 0 to DateData.Rows.Count - 1
				   myDataRow1 = DateColData.NewRow()
				   myDataRow1("UDDID") = DateData.Rows(ii)("UDDID")
				   myDataRow1("ColumnName") = DateData.Rows(ii)("UDDName")
				   DateColData.Rows.Add(myDataRow1)
				Next ii
				DateColumn.DataSource = DateColData
				DateColumn.DataValueField = "UDDID"
				DateColumn.DataTextField = "ColumnName"
				DateColumn.DataBind()
				
				
				Dim dsSet As New DataSet
				Dim rNew As DataRow
				Dim dtCoupon As New DataTable
				Dim dtCriteria As New DataTable
			
				dtCoupon.Columns.Add("CouponTypeID", System.Type.GetType("System.Int32"))
				dtCoupon.Columns.Add("CouponTypeName", System.Type.GetType("System.String"))
	
				rNew = dtCoupon.NewRow
				rNew("CouponTypeID") = 0
				rNew("CouponTypeName") = "--- Select Coupon Type ---"
				dtCoupon.Rows.Add(rNew)
				
				Dim CouponData As DataTable = PromiseCRM.GetCouponInfo(-1,objCnn)
				
				For i = 0 To CouponData.Rows.Count - 1
					rNew = dtCoupon.NewRow
					rNew("CouponTypeID") = CouponData.Rows(i)("VoucherTypeID")
					If CouponData.Rows(i)("ReuseCoupon") = 0 Then
						rNew("CouponTypeName") = CouponData.Rows(i)("VoucherTypeName")
					Else
						rNew("CouponTypeName") = CouponData.Rows(i)("VoucherTypeName") + " (Reuse)"
					End If
					dtCoupon.Rows.Add(rNew)
				Next
				CouponType.DataSource = dtCoupon
				CouponType.DataValueField = "CouponTypeID"
				CouponType.DataTextField = "CouponTypeName"
				CouponType.DataBind()
				
				dtCriteria.Columns.Add("CriteriaID", System.Type.GetType("System.String"))
				dtCriteria.Columns.Add("CriterialName", System.Type.GetType("System.String"))
	
				rNew = dtCriteria.NewRow
				rNew("CriteriaID") = "="
				rNew("CriterialName") = "="
				dtCriteria.Rows.Add(rNew)
				
				rNew = dtCriteria.NewRow
				rNew("CriteriaID") = ">"
				rNew("CriterialName") = ">"
				dtCriteria.Rows.Add(rNew)
				
				rNew = dtCriteria.NewRow
				rNew("CriteriaID") = ">="
				rNew("CriterialName") = ">="
				dtCriteria.Rows.Add(rNew)
				
				rNew = dtCriteria.NewRow
				rNew("CriteriaID") = "<"
				rNew("CriterialName") = "<"
				dtCriteria.Rows.Add(rNew)
				
				rNew = dtCriteria.NewRow
				rNew("CriteriaID") = "<="
				rNew("CriterialName") = "<="
				dtCriteria.Rows.Add(rNew)
				
				rNew = dtCriteria.NewRow
				rNew("CriteriaID") = "between"
				rNew("CriterialName") = "between"
				dtCriteria.Rows.Add(rNew)
				
				DynamicNumeric1.DataSource = dtCriteria
				DynamicNumeric1.DataValueField = "CriteriaID"
				DynamicNumeric1.DataTextField = "CriterialName"
				DynamicNumeric1.DataBind()
				
				DynamicNumeric2.DataSource = dtCriteria
				DynamicNumeric2.DataValueField = "CriteriaID"
				DynamicNumeric2.DataTextField = "CriterialName"
				DynamicNumeric2.DataBind()
				
				DynamicNumeric3.DataSource = dtCriteria
				DynamicNumeric3.DataValueField = "CriteriaID"
				DynamicNumeric3.DataTextField = "CriterialName"
				DynamicNumeric3.DataBind()
				
				DynamicNumeric4.DataSource = dtCriteria
				DynamicNumeric4.DataValueField = "CriteriaID"
				DynamicNumeric4.DataTextField = "CriterialName"
				DynamicNumeric4.DataBind()
				
				DynamicDate1.DataSource = dtCriteria
				DynamicDate1.DataValueField = "CriteriaID"
				DynamicDate1.DataTextField = "CriterialName"
				DynamicDate1.DataBind()
				
				DynamicDate2.DataSource = dtCriteria
				DynamicDate2.DataValueField = "CriteriaID"
				DynamicDate2.DataTextField = "CriterialName"
				DynamicDate2.DataBind()
				
				DynamicDate3.DataSource = dtCriteria
				DynamicDate3.DataValueField = "CriteriaID"
				DynamicDate3.DataTextField = "CriterialName"
				DynamicDate3.DataBind()
				
				DynamicDate4.DataSource = dtCriteria
				DynamicDate4.DataValueField = "CriteriaID"
				DynamicDate4.DataTextField = "CriterialName"
				DynamicDate4.DataBind()
				
				FilterSaleCriteria.DataSource = dtCriteria
				FilterSaleCriteria.DataValueField = "CriteriaID"
				FilterSaleCriteria.DataTextField = "CriterialName"
				FilterSaleCriteria.DataBind()

			End If
			
			
			If PropertyInfo.Rows(0)("SystemEditionID") = 1 Then
				DynamicCriteria.Visible = False
				DynamicNumeric.Visible = False
				DynamicDate.Visible = False
			End If

		Catch ex As Exception
			errorMsg.InnerHtml = ""'ex.Message
			SubmitSale.Enabled = False
			SubmitFavorite.Enabled = False
		End Try
	Else
		updateMessage.Text = "Access Denied"
	End If
End Sub

Sub DoSearch(Source As Object, E As EventArgs)
	
	Dim i As Integer
	For i = 0 To DisplayList.Items.Count - 1
		Results.Columns(i+1).Visible = DisplayList.Items(i).Selected
	Next

	SelMonth.Value = Request.Form("MonthYearDate_Month")
	SelYear.Value = Request.Form("MonthYearDate_Year")
	SelMonth1.Value = Request.Form("MonthYearDate1_Month")
	SelYear1.Value = Request.Form("MonthYearDate1_Year")
	SelMonth2.Value = Request.Form("MonthYearDate2_Month")
	SelYear2.Value = Request.Form("MonthYearDate2_Year")
	
	SelMonth11.Value = Request.Form("MonthYearDate11_Month")
	SelYear11.Value = Request.Form("MonthYearDate11_Year")
	SelMonth12.Value = Request.Form("MonthYearDate12_Month")
	SelYear12.Value = Request.Form("MonthYearDate12_Year")

	SearchCriteria.Enabled = True
	SearchResult.Enabled = False
	BestSeller.Enabled = True
	SaleReport.Enabled = True
	EmailForm.Enabled = True
	LabelLink.Enabled = True
	
	Section1.Visible = False
	Section2.Visible = True
	
	Dim AgeSel As Integer = 0
	Dim FromMonth,FromYear,ToMonth,ToYear,DummyYear1,DummyYear2 As Integer
	
	
	If Radio1.Checked = True Then
		AgeSel = 1
	ElseIf Radio2.Checked = True Then
		AgeSel = 2
	ElseIf Radio3.Checked = True Then
		AgeSel = 3
	End If
	
	Dim outData As DataTable
	GenResult(outData,GroupList,Trim(MemberCode.Text),Trim(MemberFirstName.Text),Trim(MemberLastName.Text),Trim(MemberTelephone.Text),Trim(MemberMobile.Text),GenderList.SelectedItem.Value, AgeSel, txtFromAge.Value, txtToAge.Value, SelMonth.Value, SelYear.Value, SelMonth1.Value, SelYear1.Value, SelMonth2.Value, SelYear2.Value, objCnn)
	
End Sub

Public Function GenResult(ByRef outData As DataTable,ByVal MemberGroup As Object, ByVal MemberCode As String, ByVal MemberFirstName As String, ByVal MemberLastName As String, ByVal MemberTelephone As String, ByVal MemberMobile As String, ByVal GenderValue As Integer, ByVal AgeSel As Integer, ByVal FromAgeValue As String, ByVal ToAgeValue As String, ByVal SelMonth As String, ByVal SelYear As String, ByVal SelMonth1 As String, ByVal SelYear1 As String, ByVal SelMonth2 As String, ByVal SelYear2 As String, ByVal objCnn As MySqlConnection) As String
	Dim MIDList As String
	
	Dim DynamicString(5) AS String
	Dim DynamicNumericString(3) As String
	Dim DynamicDateString(3) As String
	Dim j As Integer
	Dim ListString As String
	
	Dim propData As DataTable = getProp.PropertyInfo(1,objCnn)	
	
	ListString = ""
	For j = 0 to Dynamic1.Items.Count - 1
		If Dynamic1.Items(j).Selected = True
			ListString += "," + Dynamic1.Items(j).Value
		End If
	Next
	If ListString <> ",0" AND ListString <> "" Then
		DynamicString(0) = "-1" + ListString
		Dynamic1List.Value = ListString + ","
	Else
		DynamicString(0) = ""
	End If
	
	ListString = ""
	For j = 0 to Dynamic2.Items.Count - 1
		If Dynamic2.Items(j).Selected = True
			ListString += "," + Dynamic2.Items(j).Value
		End If
	Next
	If ListString <> ",0" AND ListString <> "" Then
		DynamicString(1) = "-1" + ListString
		Dynamic2List.Value = ListString + ","
	Else
		DynamicString(1) = ""
	End If
	
	ListString = ""
	For j = 0 to Dynamic3.Items.Count - 1
		If Dynamic3.Items(j).Selected = True
			ListString += "," + Dynamic3.Items(j).Value
		End If
	Next
	If ListString <> ",0" AND ListString <> "" Then
		DynamicString(2) = "-1" + ListString
		Dynamic3List.Value = ListString + ","
	Else
		DynamicString(2) = ""
	End If
	
	ListString = ""
	For j = 0 to Dynamic4.Items.Count - 1
		If Dynamic4.Items(j).Selected = True
			ListString += "," + Dynamic4.Items(j).Value
		End If
	Next
	If ListString <> ",0" AND ListString <> "" Then
		DynamicString(3) = "-1" + ListString
		Dynamic4List.Value = ListString + ","
	Else
		DynamicString(3) = ""
	End If
	
	ListString = ""
	For j = 0 to Dynamic5.Items.Count - 1
		If Dynamic5.Items(j).Selected = True
			ListString += "," + Dynamic5.Items(j).Value
		End If
	Next
	If ListString <> ",0" AND ListString <> "" Then
		DynamicString(4) = "-1" + ListString
		Dynamic5List.Value = ListString + ","
	Else
		DynamicString(4) = ""
	End If
	
	ListString = ""
	For j = 0 to Dynamic6.Items.Count - 1
		If Dynamic6.Items(j).Selected = True
			ListString += "," + Dynamic6.Items(j).Value
		End If
	Next
	If ListString <> ",0" AND ListString <> "" Then
		DynamicString(5) = "-1" + ListString
		Dynamic6List.Value = ListString + ","
	Else
		DynamicString(5) = ""
	End If
	
	Try 
	
	If DynamicNumeric1.SelectedItem.Value = "between" Then
		If IsNumeric(StartNumericText1.Text) AND IsNumeric(EndNumericText1.Text) Then
			DynamicNumericString(0) = " between " + StartNumericText1.Text + " and " + EndNumericText1.Text
		End If
	Else
		If IsNumeric(StartNumericText1.Text) Then
			DynamicNumericString(0) = DynamicNumeric1.SelectedItem.Value + StartNumericText1.Text
		End If
	End If
	
	If DynamicNumeric2.SelectedItem.Value = "between" Then
		If IsNumeric(StartNumericText2.Text) AND IsNumeric(EndNumericText2.Text) Then
			DynamicNumericString(1) = " between " + StartNumericText2.Text + " and " + EndNumericText2.Text
		End If
	Else
		If IsNumeric(StartNumericText2.Text) Then
			DynamicNumericString(1) = DynamicNumeric2.SelectedItem.Value + StartNumericText2.Text
		End If
	End If
	
	If DynamicNumeric3.SelectedItem.Value = "between" Then
		If IsNumeric(StartNumericText3.Text) AND IsNumeric(EndNumericText3.Text) Then
			DynamicNumericString(2) = " between " + StartNumericText3.Text + " and " + EndNumericText3.Text
		End If
	Else
		If IsNumeric(StartNumericText3.Text) Then
			DynamicNumericString(2) = DynamicNumeric3.SelectedItem.Value + StartNumericText3.Text
		End If
	End If
	
	If DynamicNumeric4.SelectedItem.Value = "between" Then
		If IsNumeric(StartNumericText4.Text) AND IsNumeric(EndNumericText4.Text) Then
			DynamicNumericString(3) = " between " + StartNumericText4.Text + " and " + EndNumericText4.Text
		End If
	Else
		If IsNumeric(StartNumericText4.Text) Then
			DynamicNumericString(3) = DynamicNumeric4.SelectedItem.Value + StartNumericText4.Text
		End If
	End If
	
	Dim StartDateText As String
	Dim EndDateText As String
	Dim StartYear,EndYear As Integer
	If DynamicDate1.SelectedItem.Value = "between" Then
		If IsNumeric(StartDayText1.Text) AND IsNumeric(StartMonthText1.Text) AND IsNumeric(StartYearText1.Text) AND IsNumeric(EndDayText1.Text) AND IsNumeric(EndMonthText1.Text) AND IsNumeric(EndYearText1.Text) Then
			If propData.Rows(0)("YearSetting") = 1 Then
				StartYear = CInt(StartYearText1.Text) - 543
				EndYear = CInt(EndYearText1.Text) - 543
			Else
				StartYear = StartYearText1.Text
				EndYear = EndYearText1.Text
			End If
			Try
				Dim StartDate As New Date(StartYear,StartMonthText1.Text,StartDayText1.Text)
				Dim EndDate As New Date(EndYear,EndMonthText1.Text,EndDayText1.Text)
				StartDateText = DateTimeUtil.FormatDate(Day(StartDate),Month(StartDate),StartYear)
				EndDateText = DateTimeUtil.FormatDate(Day(EndDate),Month(EndDate),EndYear)
				DynamicDateString(0) = " between " + StartDateText + " and " + EndDateText
			Catch ex As Exception
				DynamicDateString(0) = ""
			End Try
		End If
	Else
		If IsNumeric(StartDayText1.Text) AND IsNumeric(StartMonthText1.Text) AND IsNumeric(StartYearText1.Text) Then
			If propData.Rows(0)("YearSetting") = 1 Then
				StartYear = CInt(StartYearText1.Text) - 543
			Else
				StartYear = StartYearText1.Text
			End If
			Try
				Dim StartDate As New Date(StartYear,StartMonthText1.Text,StartDayText1.Text)
				StartDateText = DateTimeUtil.FormatDate(Day(StartDate),Month(StartDate),StartYear)
				DynamicDateString(0) = DynamicDate1.SelectedItem.Value + StartDateText
			Catch ex As Exception
				DynamicDateString(0) = ""
			End Try
		End If
	End If
	
	If DynamicDate2.SelectedItem.Value = "between" Then
		If IsNumeric(StartDayText2.Text) AND IsNumeric(StartMonthText2.Text) AND IsNumeric(StartYearText2.Text) AND IsNumeric(EndDayText2.Text) AND IsNumeric(EndMonthText2.Text) AND IsNumeric(EndYearText2.Text) Then
			If propData.Rows(0)("YearSetting") = 1 Then
				StartYear = CInt(StartYearText2.Text) - 543
				EndYear = CInt(EndYearText2.Text) - 543
			Else
				StartYear = StartYearText2.Text
				EndYear = EndYearText2.Text
			End If
			Try
				Dim StartDate As New Date(StartYear,StartMonthText2.Text,StartDayText2.Text)
				Dim EndDate As New Date(EndYear,EndMonthText2.Text,EndDayText2.Text)
				StartDateText = DateTimeUtil.FormatDate(Day(StartDate),Month(StartDate),StartYear)
				EndDateText = DateTimeUtil.FormatDate(Day(EndDate),Month(EndDate),EndYear)
				DynamicDateString(1) = " between " + StartDateText + " and " + EndDateText
			Catch ex As Exception
				DynamicDateString(1) = ""
			End Try
		End If
	Else
		If IsNumeric(StartDayText2.Text) AND IsNumeric(StartMonthText2.Text) AND IsNumeric(StartYearText2.Text) Then
			If propData.Rows(0)("YearSetting") = 1 Then
				StartYear = CInt(StartYearText2.Text) - 543
			Else
				StartYear = StartYearText2.Text
			End If
			Try
				Dim StartDate As New Date(StartYear,StartMonthText2.Text,StartDayText2.Text)
				StartDateText = DateTimeUtil.FormatDate(Day(StartDate),Month(StartDate),StartYear)
				DynamicDateString(1) = DynamicDate2.SelectedItem.Value + StartDateText
			Catch ex As Exception
				DynamicDateString(1) = ""
			End Try
		End If
	End If
	
	If DynamicDate3.SelectedItem.Value = "between" Then
		If IsNumeric(StartDayText3.Text) AND IsNumeric(StartMonthText3.Text) AND IsNumeric(StartYearText3.Text) AND IsNumeric(EndDayText3.Text) AND IsNumeric(EndMonthText3.Text) AND IsNumeric(EndYearText3.Text) Then
			If propData.Rows(0)("YearSetting") = 1 Then
				StartYear = CInt(StartYearText3.Text) - 543
				EndYear = CInt(EndYearText3.Text) - 543
			Else
				StartYear = StartYearText3.Text
				EndYear = EndYearText3.Text
			End If
			Try
				Dim StartDate As New Date(StartYear,StartMonthText3.Text,StartDayText3.Text)
				Dim EndDate As New Date(EndYear,EndMonthText3.Text,EndDayText3.Text)
				StartDateText = DateTimeUtil.FormatDate(Day(StartDate),Month(StartDate),StartYear)
				EndDateText = DateTimeUtil.FormatDate(Day(EndDate),Month(EndDate),EndYear)
				DynamicDateString(2) = " between " + StartDateText + " and " + EndDateText
			Catch ex As Exception
				DynamicDateString(2) = ""
			End Try
		End If
	Else
		If IsNumeric(StartDayText3.Text) AND IsNumeric(StartMonthText3.Text) AND IsNumeric(StartYearText3.Text) Then
			If propData.Rows(0)("YearSetting") = 1 Then
				StartYear = CInt(StartYearText3.Text) - 543
			Else
				StartYear = StartYearText3.Text
			End If
			Try
				Dim StartDate As New Date(StartYear,StartMonthText3.Text,StartDayText3.Text)
				StartDateText = DateTimeUtil.FormatDate(Day(StartDate),Month(StartDate),StartYear)
				DynamicDateString(2) = DynamicDate3.SelectedItem.Value + StartDateText
			Catch ex As Exception
				DynamicDateString(2) = ""
			End Try
		End If
	End If
	
	If DynamicDate4.SelectedItem.Value = "between" Then
		If IsNumeric(StartDayText4.Text) AND IsNumeric(StartMonthText4.Text) AND IsNumeric(StartYearText4.Text) AND IsNumeric(EndDayText4.Text) AND IsNumeric(EndMonthText4.Text) AND IsNumeric(EndYearText4.Text) Then
			If propData.Rows(0)("YearSetting") = 1 Then
				StartYear = CInt(StartYearText4.Text) - 543
				EndYear = CInt(EndYearText4.Text) - 543
			Else
				StartYear = StartYearText4.Text
				EndYear = EndYearText4.Text
			End If
			Try
				Dim StartDate As New Date(StartYear,StartMonthText4.Text,StartDayText4.Text)
				Dim EndDate As New Date(EndYear,EndMonthText4.Text,EndDayText4.Text)
				StartDateText = DateTimeUtil.FormatDate(Day(StartDate),Month(StartDate),StartYear)
				EndDateText = DateTimeUtil.FormatDate(Day(EndDate),Month(EndDate),EndYear)
				DynamicDateString(3) = " between " + StartDateText + " and " + EndDateText
			Catch ex As Exception
				DynamicDateString(3) = ""
			End Try
		End If
	Else
		If IsNumeric(StartDayText4.Text) AND IsNumeric(StartMonthText4.Text) AND IsNumeric(StartYearText4.Text) Then
			If propData.Rows(0)("YearSetting") = 1 Then
				StartYear = CInt(StartYearText4.Text) - 543
			Else
				StartYear = StartYearText4.Text
			End If
			Try
				Dim StartDate As New Date(StartYear,StartMonthText4.Text,StartDayText4.Text)
				StartDateText = DateTimeUtil.FormatDate(Day(StartDate),Month(StartDate),StartYear)
				DynamicDateString(3) = DynamicDate4.SelectedItem.Value + StartDateText
			Catch ex As Exception
				DynamicDateString(3) = ""
			End Try
		End If
	End If
	
	Catch ex As Exception

		End Try
	
	Dim ExpireRangeValue As Integer = 0
	If IsNumeric(ExpireRange.Value) Then
		ExpireRangeValue = ExpireRange.Value
	Else
		ExpireRangeValue = 0
	End If
	Dim TestTime As String
	TestTime += DateTimeUtil.CurrentDateTime + "<br>"
	Dim dtTable As New DataTable()
	dtTable = PromiseCRM.SearchMember(MIDList,MemberGroup,MemberCode,MemberFirstName,MemberLastName,MemberTelephone,MemberMobile, GenderValue, "", AgeSel, FromAgeValue, ToAgeValue, SelMonth, SelYear, SelMonth1, SelYear1, SelMonth2, SelYear2, DynamicString, DynamicNumericString, DynamicDateString, Session("StaffID"), Province, MemberCity.Text, ExpireRangeValue, OnlyNotExpire.Checked, Session("LangID"), objCnn)
	TestTime += DateTimeUtil.CurrentDateTime

	outData = dtTable	

	MemberIDList.Value = MIDList
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(11,Session("LangID"),objCnn)
	
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
		
	SetSearchResult(dtTable, objCnn)

End Function

Sub ChangeGridPage(objSender As Object, objArgs As DataGridPageChangedEventArgs)
	Dim AgeSel As Integer = 0
	If Radio1.Checked = True Then
		AgeSel = 1
	ElseIf Radio2.Checked = True Then
		AgeSel = 2
	ElseIf Radio3.Checked = True Then
		AgeSel = 3
	End If
   'runs when one of the pager controls is clicked

   'update the current page number from the parameter values
   Results.CurrentPageIndex = objArgs.NewPageIndex

   'recreate the data set and bind it to the DataGrid control
   Dim outData As DataTable
   GenResult(outData,GroupList,Trim(MemberCode.Text),Trim(MemberFirstName.Text),Trim(MemberLastName.Text),Trim(MemberTelephone.Text),Trim(MemberMobile.Text), GenderList.SelectedItem.Value, AgeSel, txtFromAge.Value, txtToAge.Value, SelMonth.Value, SelYear.Value, SelMonth1.Value, SelYear1.Value, SelMonth2.Value, SelYear2.Value, objCnn)
	
End Sub
		
Sub ExportToExcel(Source As Object, E As EventArgs)
	Dim outData As DataTable
	Dim AgeSel As Integer = 0
	If Radio1.Checked = True Then
		AgeSel = 1
	ElseIf Radio2.Checked = True Then
		AgeSel = 2
	ElseIf Radio3.Checked = True Then
		AgeSel = 3
	End If
	Dim TestTime As String

	TestTime += DateTimeUtil.CurrentDateTime
	Dim dtReader As MySqlDataReader = getData.MemberResult(Session("LangID"),MemberIDList.Value,objCnn)
	TestTime += "<br>" + DateTimeUtil.CurrentDateTime

	Dim filename As String = "MemberData.csv"
	Dim ResultText As String = ""
	
	ResultText = "MemberCode,MemberName,MemberGender,MemberAddress1,MemberCity,Province,ZipCode,MemberTelephone,MemberMobile,MemberEmail,MemberBirthDate,RegisterDate,ExpirationDate,MemberFax,AdditionalInfo,NationalID,IssueDate,NationalIDExpDate,MemberBlood,Activated" + chr(13) & chr(10)
	Dim i As Integer = 0
	
	Response.Clear()
    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader("Content-Disposition", "attachment; filename=""" & filename & """")
	Response.Charset = "windows-874"
	Response.ContentEncoding = System.Text.Encoding.GetEncoding(874)
    Response.Flush()
	Response.Write("MemberCode,MemberName,MemberGender,MemberAddress1,MemberCity,Province,ZipCode,MemberTelephone,MemberMobile,MemberEmail,MemberBirthDate,RegisterDate,ExpirationDate,MemberFax,AdditionalInfo,NationalID,IssueDate,NationalIDExpDate,MemberBlood,Activated" + chr(13) & chr(10))
	While dtReader.Read()
		Response.Write("""" + Replace(dtReader.GetValue(0),"""","""""") + """,""" + Replace(dtReader.GetValue(1),"""","""""") + " " + Replace(dtReader.GetValue(2),"""","""""") + """,""" + Replace(dtReader.GetValue(3),"""","""""") + """")
		If Not IsDBNull(dtReader.GetValue(4)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(4),"""","""""") + """")
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(5)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(5),"""",""""""))
			If Not IsDBNull(dtReader.GetValue(6)) Then 
				Response.Write(" " + Replace(dtReader.GetValue(6),"""","""""") + """")
			Else
				Response.Write("""") 
			End If
		Else
			Response.Write(",""") 
			If Not IsDBNull(dtReader.GetValue(6)) Then 
				Response.Write(Replace(dtReader.GetValue(6),"""","""""") + """")
			Else
				Response.Write("""") 
			End If
		End If
		
		If Not IsDBNull(dtReader.GetValue(7)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(7),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(8)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(8),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(9)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(9),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(10)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(10),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(11)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(11),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(12)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(12),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(13)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(13),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(14)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(14),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(15)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(15),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(16)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(16),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(17)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(17),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(18)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(18),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(19)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(19),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(20)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(20),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(21)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(21),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		Response.Write(chr(13) & chr(10))
	
	End While
	dtReader.Close()
	Response.End()
	
	TestTime += "<br>" + DateTimeUtil.CurrentDateTime
	'errorMsg.InnerHtml = TestTime + "<br>" 

End Sub

Sub ExportToExcelAll(Source As Object, E As EventArgs)
	Dim outData As DataTable
	Dim TestTime As String

	TestTime += DateTimeUtil.CurrentDateTime
	Dim dtReader As MySqlDataReader = getData.MemberResult(Session("LangID"),"-99",objCnn)
	TestTime += "<br>" + DateTimeUtil.CurrentDateTime

	Dim filename As String = "AllMemberData.csv"
	Dim ResultText As String = ""
	
	ResultText = "MemberID,MemberCode,MemberName,MemberGender,MemberAddress1,MemberCity,Province,ZipCode,MemberTelephone,MemberMobile,MemberEmail,MemberBirthDate,RegisterDate,ExpirationDate,MemberFax,AdditionalInfo,NationalID,IssueDate,NationalIDExpDate,MemberBlood,Activated" + chr(13) & chr(10)
	Dim i As Integer = 0
	
	Response.Clear()
    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader("Content-Disposition", "attachment; filename=""" & filename & """")
	Response.Charset = "windows-874"
	Response.ContentEncoding = System.Text.Encoding.GetEncoding(874)
    Response.Flush()
	Response.Write("MemberID,MemberCode,MemberName,MemberGender,MemberAddress1,MemberCity,Province,ZipCode,MemberTelephone,MemberMobile,MemberEmail,MemberBirthDate,RegisterDate,ExpirationDate,MemberFax,AdditionalInfo,NationalID,IssueDate,NationalIDExpDate,MemberBlood,Activated" + chr(13) & chr(10))
	While dtReader.Read()
		Response.Write("""" + Replace(dtReader.GetValue(22),"""","""""") + """,""" + Replace(dtReader.GetValue(0),"""","""""") + """,""" + Replace(dtReader.GetValue(1),"""","""""") + " " + Replace(dtReader.GetValue(2),"""","""""") + """,""" + Replace(dtReader.GetValue(3),"""","""""") + """")
		If Not IsDBNull(dtReader.GetValue(4)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(4),"""","""""") + """")
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(5)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(5),"""",""""""))
			If Not IsDBNull(dtReader.GetValue(6)) Then 
				Response.Write(" " + Replace(dtReader.GetValue(6),"""","""""") + """")
			Else
				Response.Write("""") 
			End If
		Else
			Response.Write(",""") 
			If Not IsDBNull(dtReader.GetValue(6)) Then 
				Response.Write(Replace(dtReader.GetValue(6),"""","""""") + """")
			Else
				Response.Write("""") 
			End If
		End If
		
		If Not IsDBNull(dtReader.GetValue(7)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(7),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(8)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(8),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(9)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(9),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(10)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(10),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(11)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(11),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(12)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(12),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(13)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(13),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(14)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(14),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(15)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(15),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(16)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(16),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(17)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(17),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(18)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(18),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(19)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(19),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(20)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(20),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(21)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(21),"""","""""") + """") 
		Else
			Response.Write(",""""") 
		End If
		Response.Write(chr(13) & chr(10))
	
	End While
	dtReader.Close()
	Response.End()

End Sub
		
Sub ExportMemberUDD(Source As Object, E As EventArgs)
	Dim outData As DataTable
	Dim TestTime As String

	TestTime += DateTimeUtil.CurrentDateTime
	Dim dtReader As MySqlDataReader = getData.MemberUDDResult("-99",objCnn)
	TestTime += "<br>" + DateTimeUtil.CurrentDateTime

	Dim filename As String = "MemberUserDefineData.csv"
	Dim ResultText As String = ""

	Dim i As Integer = 0
	
	Response.Clear()
    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader("Content-Disposition", "attachment; filename=""" & filename & """")
	Response.Charset = "windows-874"
	Response.ContentEncoding = System.Text.Encoding.GetEncoding(874)
    Response.Flush()
	Response.Write("MemberID,MemberCode,ColumnID,ColumnType,ColumnName,ColumnValue" + chr(13) & chr(10))
	While dtReader.Read()
		Response.Write("""" + Replace(dtReader.GetValue(0),"""","""""") + """")
		If Not IsDBNull(dtReader.GetValue(1)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(1),"""","""""") + """")
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(2)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(2),"""","""""") + """")
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(4)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(4),"""","""""") + """")
		Else
			Response.Write(",""""") 
		End If
		If Not IsDBNull(dtReader.GetValue(5)) Then 
			Response.Write(",""" + Replace(dtReader.GetValue(5),"""","""""") + """")
		Else
			Response.Write(",""""") 
		End If
		If dtReader.GetValue(3) = 1 Or dtReader.GetValue(3) = 6 Then
			Response.Write(",""" + Replace(dtReader.GetValue(8),"""","""""") + """")
		ElseIf dtReader.GetValue(3) = 2 Then
			Response.Write(",""" + Replace(dtReader.GetValue(9),"""","""""") + """")
		ElseIf dtReader.GetValue(3) = 3 Then
			Response.Write(",""" + Replace(dtReader.GetValue(7),"""","""""") + """")
		ElseIf dtReader.GetValue(3) = 4 Then
			Response.Write(",""" + Replace(dtReader.GetValue(7),"""","""""") + """")
		ElseIf dtReader.GetValue(3) = 5 Then
			Response.Write(",""" + Replace(dtReader.GetValue(10),"""","""""") + """")
		Else
			Response.Write(",""""")
		End If
		Response.Write(chr(13) & chr(10))
	
	End While
	dtReader.Close()
	Response.End()

End Sub

Sub DoSearchSale(Source As Object, E As EventArgs)
	ApplyDone.Visible = False
	showSaleResults.Visible = True
	SelMonth9.Value = Request.Form("MonthYearDate9_Month")
	SelYear9.Value = Request.Form("MonthYearDate9_Year")
	
	DocDailyDay9.Value = Request.Form("DocDaily9_Day")
	DocDailyMonth9.Value = Request.Form("DocDaily9_Month")
	DocDailyYear9.Value = Request.Form("DocDaily9_Year")
	
	DocDay9.Value = Request.Form("Doc9_Day")
	DocMonth9.Value = Request.Form("Doc9_Month")
	DocYear9.Value = Request.Form("Doc9_Year")
	DocToDay9.Value = Request.Form("DocTo9_Day")
	DocToMonth9.Value = Request.Form("DocTo9_Month")
	DocToYear9.Value = Request.Form("DocTo9_Year")
	Dim FoundError As Boolean
	FoundError = False
	Session("ReportResult") = ""
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(12,Session("LangID"),objCnn)
			
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	Dim DailyDateValue As String = ""
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
	Dim outputString As String = ""
	Dim grandTotal As Double = 0
	Dim GraphData As New DataSet()
	Dim ReportDate As String
			
	If Radio_11.Checked = True Then
		If IsNumeric(Request.Form("MonthYearDate9_Month")) AND IsNumeric(Request.Form("MonthYearDate9_Year")) Then
			If Request.Form("MonthYearDate9_Month") = 12 Then
				StartMonthValue = Request.Form("MonthYearDate9_Month")
				EndMonthValue = 1
				StartYearValue = Request.Form("MonthYearDate9_Year")
				EndYearValue = Request.Form("MonthYearDate9_Year") + 1
			Else
				StartMonthValue = Request.Form("MonthYearDate9_Month")
				EndMonthValue = Request.Form("MonthYearDate9_Month") + 1
				StartYearValue = Request.Form("MonthYearDate9_Year")
				EndYearValue = Request.Form("MonthYearDate9_Year")
			End If
			StartDate = DateTimeUtil.FormatDate(1,StartMonthValue,StartYearValue)
			EndDate = DateTimeUtil.FormatDate(1,EndMonthValue,EndYearValue)
			Dim SDate As New Date(StartYearValue,StartMonthValue,1)
			ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy",Session("LangID"),objCnn)
		Else
			SaleResultText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
			FoundError = True
		End If
	ElseIf Radio_12.Checked = True Then
		If IsNumeric(Request.Form("Doc9_Day")) AND IsNumeric(Request.Form("Doc9_Month")) AND IsNumeric(Request.Form("Doc9_Year")) AND IsNumeric(Request.Form("DocTo9_Year")) AND IsNumeric(Request.Form("DocTo9_Month")) AND IsNumeric(Request.Form("DocTo9_Day")) Then
			StartDate = DateTimeUtil.FormatDate(Request.Form("Doc9_Day"),Request.Form("Doc9_Month"),Request.Form("Doc9_Year"))
			Dim CheckDate As New DateTime(Request.Form("DocTo9_Year"), Request.Form("DocTo9_Month"), Request.Form("DocTo9_Day"), 0, 0, 0)
			CheckDate = DateAdd("d",1,CheckDate)
			EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
			
			If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
				SaleResultText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
				FoundError = True
				DateFromValue = ""
				DateToValue = ""
				DailyDateValue = ""
			Else
				SaleResultText.InnerHtml = ""
				Dim SDate1 As New Date(Request.Form("Doc9_Year"), Request.Form("Doc9_Month"), Request.Form("Doc9_Day"))
				Dim EDate1 As New Date(Request.Form("DocTo9_Year"), Request.Form("DocTo9_Month"), Request.Form("DocTo9_Day"))
				ReportDate = DateTimeUtil.FormatDateTime(SDate1, "DateOnly",Session("LangID"),objCnn) + " - " + DateTimeUtil.FormatDateTime(EDate1, "DateOnly",Session("LangID"),objCnn)
			End If
		Else
			SaleResultText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
			FoundError = True
			DateFromValue = ""
			DateToValue = ""
			DailyDateValue = ""
		End If
	Else If Radio_13.Checked = True Then
		If IsNumeric(Request.Form("DocDaily9_Day")) AND IsNumeric(Request.Form("DocDaily9_Month")) AND IsNumeric(Request.Form("DocDaily9_Year")) Then
			StartDate = DateTimeUtil.FormatDate(Request.Form("DocDaily9_Day"),Request.Form("DocDaily9_Month"),Request.Form("DocDaily9_Year"))
			Dim CheckDate As New DateTime(Request.Form("DocDaily9_Year"), Request.Form("DocDaily9_Month"), Request.Form("DocDaily9_Day"), 0, 0, 0)
			CheckDate = DateAdd("d",1,CheckDate)
			EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
	
			If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
				SaleResultText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
				FoundError = True
				DateFromValue = ""
				DateToValue = ""
				DailyDateValue = ""
			Else
				SaleResultText.InnerHtml = ""
				Dim SDate2 As New Date(Request.Form("DocDaily9_Year"), Request.Form("DocDaily9_Month"), Request.Form("DocDaily9_Day"))
				ReportDate = DateTimeUtil.FormatDateTime(SDate2, "DateOnly",Session("LangID"),objCnn)
			End If
		Else
			SaleResultText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
			FoundError = True
			DateFromValue = ""
			DateToValue = ""
			DailyDateValue = ""
		End If
	Else
		DateFromValue = ""
		DateToValue = ""
		DailyDateValue = ""
	End If	
	If FoundError = False Then
		showSaleResults.Visible = True
		GenSaleResult(objCnn)
	Else
		showSaleResults.Visible = False
	End If
End Sub

Public Function GenSaleResult(ByVal objCnn As MySqlConnection) As String
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
	Dim outputString As String = ""
	Dim grandTotal As Double = 0
	Dim ReportDate As String
	
	If Radio_11.Checked = True Then
		If Request.Form("MonthYearDate9_Month") = 12 Then
			StartMonthValue =SelMonth9.Value
			EndMonthValue = 1
			StartYearValue = SelYear9.Value
			EndYearValue = SelYear9.Value + 1
		Else
			StartMonthValue = SelMonth9.Value
			EndMonthValue = SelMonth9.Value + 1
			StartYearValue = SelYear9.Value
			EndYearValue = SelYear9.Value
		End If
		StartDate = DateTimeUtil.FormatDate(1,StartMonthValue,StartYearValue)
		EndDate = DateTimeUtil.FormatDate(1,EndMonthValue,EndYearValue)
		Dim SDate As New Date(StartYearValue,StartMonthValue,1)
		ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy",Session("LangID"),objCnn)
	ElseIf Radio_12.Checked = True Then
		
		StartDate = DateTimeUtil.FormatDate(DocDay9.Value,DocMonth9.Value,DocYear9.Value)
		Dim CheckDate As New DateTime(DocToYear9.Value, DocToMonth9.Value, DocToDay9.Value, 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
		
		If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then

		Else
			SaleResultText.InnerHtml = ""
			Dim SDate1 As New Date(DocYear9.Value, DocMonth9.Value, DocDay9.Value)
			Dim EDate1 As New Date(DocToYear9.Value, DocToMonth9.Value, DocToDay9.Value)
			ReportDate = DateTimeUtil.FormatDateTime(SDate1, "DateOnly",Session("LangID"),objCnn) + " - " + DateTimeUtil.FormatDateTime(EDate1, "DateOnly",Session("LangID"),objCnn)
		End If
	Else If Radio_13.Checked = True Then
		StartDate = DateTimeUtil.FormatDate(DocDailyDay9.Value,DocDailyMonth9.Value,DocDailyYear9.Value)
		Dim CheckDate As New DateTime(DocDailyYear9.Value, DocDailyMonth9.Value, DocDailyDay9.Value, 0, 0, 0)
		CheckDate = DateAdd("d",1,CheckDate)
		EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))

		If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then

		Else
			SaleResultText.InnerHtml = ""
			Dim SDate2 As New Date(DocDailyYear9.Value, DocDailyMonth9.Value, DocDailyDay9.Value)
			ReportDate = DateTimeUtil.FormatDateTime(SDate2, "DateOnly",Session("LangID"),objCnn)
		End If

	End If
	
	Dim ViewOption As Integer
	If Radio_11.Checked = True Then
		ViewOption = 1
	ElseIf Radio_12.Checked = True Then
		ViewOption = 2
	Else
		ViewOption = 0 
	End If
	Application.Lock()
	Dim i As Integer
	Dim ShopString As String
	For i = 0 to ShopList.Items.Count - 1
		If ShopList.Items(i).Selected = True
			ShopString += "," + ShopList.Items(i).Value
		End If
	Next
	ShopString = "0" + ShopString
	Dim dtTable As DataTable = getData.MemberSaleReports(ViewOption, StartDate, EndDate, ShopString, MemberIDList.Value, objCnn)
	SaleResultText.InnerHtml = "Member Sale Report (" + ReportDate + ")"
	Application.UnLock()
	
	Dim AttachString As String = "&StartDate=" + Server.UrlEncode(Replace(StartDate,"'","\'")) + "&EndDate=" + Server.UrlEncode(Replace(EndDate,"'","\'")) + "&ShopList=" + Server.UrlEncode(ShopString) + "&ReportDate=" + ReportDate
		Dim MCounter,MCode,MFullName,MAmount As String
		MCode = "Member Code"
		MFullName = "Member Name"
		MAmount = "Purchase Amount"
		
		PercentBaseText.InnerHtml = "% (based on " +  Format(grandTotal, "##,##0.00") + ")"
		Dim myDataTable As DataTable = new DataTable("MemberFavoriteDataTable")
		Dim myDataColumn As DataColumn 
		Dim myDataRow As DataRow

		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "#"
		myDataColumn.ReadOnly = True
		myDataColumn.Unique = False
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = MCode
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = MFullName
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = MAmount
		myDataTable.Columns.Add(myDataColumn)
		
		Dim TotalProductDiscount As Double = 0
        Dim TotalSale As Double
		Dim TotalDisplay As Integer = dtTable.Rows.Count - 1
		If FilterSale.Checked = True Then
			If IsNumeric(TopMemberSale.Text) Then
				If TopMemberSale.Text > 0 Then
					TotalDisplay = CInt(TopMemberSale.Text) - 1
				End If
			End If
		End If
		Dim StartAmountVal As Double = 0
		Dim EndAmountVal As Double = 0
		If IsNumeric(StartAmount.Text) Then
			If StartAmount.Text > 0 Then
				StartAmountVal = StartAmount.Text
			End If
		End If
		If IsNumeric(EndAmount.Text) Then
			If EndAmount.Text > 0 Then
				EndAmountVal = EndAmount.Text
			End If
		End If
		Dim DisplayRecord As Boolean
		Dim MemberSaleIDList As String = "0"
		For i = 0 To dtTable.Rows.Count - 1

			TotalSale = dtTable.Rows(i)("TotalSale")
			
			DisplayRecord = False
			If FilterSale.Checked = False Then
				DisplayRecord = True
			Else
				If StartAmountVal = 0 AND EndAmountVal = 0 Then
					DisplayRecord = True
				Else
					Select FilterSaleCriteria.SelectedItem.Value
						Case "="
							If TotalSale = StartAmountVal Then
								DisplayRecord = True
							End If
						Case ">"
							If TotalSale > StartAmountVal Then
								DisplayRecord = True
							End If
						Case ">="
							If TotalSale >= StartAmountVal Then
								DisplayRecord = True
							End If
						Case "<"
							If TotalSale < StartAmountVal Then
								DisplayRecord = True
							End If
						Case "<="
							If TotalSale <= StartAmountVal Then
								DisplayRecord = True
							End If
						Case "between"
							If TotalSale >= StartAmountVal AND TotalSale <= EndAmountVal Then
								DisplayRecord = True
							End If
					End Select
				End If
				
				
			End If
			If DisplayRecord = True Then
                
				
				myDataRow = myDataTable.NewRow()
				myDataRow("#") = (i+1).ToString
               
				If Not IsDBNull(dtTable.Rows(i)("MemberCode")) Then
					myDataRow(MCode) = dtTable.Rows(i)("MemberCode")
				Else
					myDataRow(MCode) = "-"
				End If
				If Not IsDBNull(dtTable.Rows(i)("MemberFullName")) Then
					myDataRow(MFullName) = "<a href=""JavaScript: newWindow = window.open( '../members/member_stat.aspx?MemberID=" + dtTable.Rows(i)("MemberID").ToString + "', '', 'width=950,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & dtTable.Rows(i)("MemberFullName") & "</a>"
				Else
					myDataRow(MFullName) = "-"
				End If
	
				myDataRow(MAmount) = "<a href=""JavaScript: newWindow = window.open( 'member_purchase_stat.aspx?MemberID=" + dtTable.Rows(i)("MemberID").ToString + AttachString + "', '', 'width=800,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & Format(TotalSale, "##,##0.00") & "</a>"

				myDataTable.Rows.Add(myDataRow)
				MemberSaleIDList += "," + dtTable.Rows(i)("MemberID").ToString
				End If
				If FilterSale.Checked = True AND i >= TotalDisplay Then
					Exit For
				End If

            Next
			MemberIDListSale.Value = MemberSaleIDList
			SaleResults.PageSize = RecordPerPage
			SaleResults.PagerStyle.Mode = PagerMode.NumericPages
			SaleResults.DataSource = myDataTable
			SaleResults.DataBind()

End Function

Sub ChangeGridSalePage(objSender As Object, objArgs As DataGridPageChangedEventArgs)
	SaleResults.CurrentPageIndex = objArgs.NewPageIndex
	
	GenSaleResult(objCnn)
End Sub

Sub DoApplySearchResult(Source As Object, E As EventArgs)
	MemberIDList.Value = MemberIDListSale.Value
	Dim dtTable As DataTable
	dtTable = PromiseCRM.SearchMemberFromID(MemberIDListSale.Value,Session("LangID"),objCnn)
	SetSearchResult(dtTable,objCnn)		
	ApplyDone.Visible = True
End Sub

Public Function SetSearchResult(ByVal dtTable As DataTable, ByVal objCnn As MySqlConnection) As String
	If dtTable.Rows.Count > 0 Then
		If dtTable.Rows.Count > 1 Then
			totalRecord.InnerHtml = Format(dtTable.Rows.Count, "##,##0") + " records found"
			FavoriteHeader.InnerHtml = "Favorite Products Analysis for " + Format(dtTable.Rows.Count, "##,##0") + " Members"
			
		Else
			totalRecord.InnerHtml = Format(dtTable.Rows.Count, "##,##0") + " record found"
			FavoriteHeader.InnerHtml = "Favorite Products Analysis for " + Format(dtTable.Rows.Count, "##,##0") + " Member"
			
		End If
	Else
		FavoriteHeader.InnerHtml = "No Member Data"
		totalRecord.InnerHtml = "No data found"
	End If

	Dim MEmailList As String = ""
	Dim MobileList As String = ""
	Dim ValidEmail As Integer = 0
	Dim MobileCount As Integer = 0
	Dim myDataTable As DataTable
	myDataTable = PromiseCRM.GenMemberData(MEmailList,ValidEmail,MobileList,MobileCount,dtTable,objCnn)
	If Trim(MEmailList) = "," Or Trim(MEmailList) = "" Then
		MEmailList = ""
	Else
		MEmailList = Right(MEmailList, Len(MEmailList) - 1)
	End If
	MemberEmailList.Value = MEmailList
	
	If Trim(MobileList) = "," Or Trim(MobileList) = "" Then
		MobileList = ""
	Else
		MobileList = Right(MobileList, Len(MobileList) - 1)
	End If
	MemberMobileIDList.Value = MobileList
	
	If ValidEmail > 1 Then
		ToEmailText.InnerHtml = "Sending email to " + Format(ValidEmail, "##,##0") + " members"
		CToEmailText.InnerHtml = "Sending email to " + Format(ValidEmail, "##,##0") + " members"
	ElseIf ValidEmail = 0 Then
		ToEmailText.InnerHtml = "No valid emails"
		CToEmailText.InnerHtml = "No valid emails"
	Else
		ToEmailText.InnerHtml = "Sending email to " + Format(ValidEmail, "##,##0") + " member"
		CToEmailText.InnerHtml = "Sending email to " + Format(ValidEmail, "##,##0") + " member"
	End If

	If MobileCount > 1 Then
		SMSMembers.InnerHtml = Format(MobileCount, "##,##0") + " members"
	ElseIf MobileCount = 0 Then
		SMSMembers.InnerHtml = "No valid mobile phones"
	Else
		SMSMembers.InnerHtml = Format(MobileCount, "##,##0") + " member"
	End If
	MemberRecord.Value = ValidEmail
	MemberMobileRecord.Value = MobileCount
	Results.PageSize = RecordPerPage
	Results.PagerStyle.Mode = PagerMode.NumericPages
	Results.DataSource = myDataTable
	Results.DataBind()
End Function
		
Sub DoSearchFavorite(Source As Object, E As EventArgs)
	
	SelMonth0.Value = Request.Form("MonthYearDate0_Month")
	SelYear0.Value = Request.Form("MonthYearDate0_Year")
	
	DocDailyDay.Value = Request.Form("DocDaily_Day")
	DocDailyMonth.Value = Request.Form("DocDaily_Month")
	DocDailyYear.Value = Request.Form("DocDaily_Year")
	
	DocDay.Value = Request.Form("Doc_Day")
	DocMonth.Value = Request.Form("Doc_Month")
	DocYear.Value = Request.Form("Doc_Year")
	DocToDay.Value = Request.Form("DocTo_Day")
	DocToMonth.Value = Request.Form("DocTo_Month")
	DocToYear.Value = Request.Form("DocTo_Year")
	Dim FoundError As Boolean
	FoundError = False
	Session("ReportResult") = ""
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(12,Session("LangID"),objCnn)
			
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	Dim DateFromValue As String = ""
	Dim DateToValue As String = ""
	Dim DailyDateValue As String = ""
	Dim InvC As CultureInfo = CultureInfo.InvariantCulture
	
	Dim StartDate,EndDate As String
	Dim StartMonthValue,StartYearValue,EndMonthValue,EndYearValue As Integer
	Dim outputString As String = ""
	Dim grandTotal As Double = 0
	Dim GraphData As New DataSet()
	Dim ReportDate As String
			
	If Radio_1.Checked = True Then
		If IsNumeric(Request.Form("MonthYearDate0_Month")) AND IsNumeric(Request.Form("MonthYearDate0_Year")) Then
			If Request.Form("MonthYearDate0_Month") = 12 Then
				StartMonthValue = Request.Form("MonthYearDate0_Month")
				EndMonthValue = 1
				StartYearValue = Request.Form("MonthYearDate0_Year")
				EndYearValue = Request.Form("MonthYearDate0_Year") + 1
			Else
				StartMonthValue = Request.Form("MonthYearDate0_Month")
				EndMonthValue = Request.Form("MonthYearDate0_Month") + 1
				StartYearValue = Request.Form("MonthYearDate0_Year")
				EndYearValue = Request.Form("MonthYearDate0_Year")
			End If
			StartDate = DateTimeUtil.FormatDate(1,StartMonthValue,StartYearValue)
			EndDate = DateTimeUtil.FormatDate(1,EndMonthValue,EndYearValue)
			Dim SDate As New Date(StartYearValue,StartMonthValue,1)
			ReportDate = DateTimeUtil.FormatDateTime(SDate, "MMMM yyyy",Session("LangID"),objCnn)
		Else
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
			FoundError = True
		End If
	ElseIf Radio_2.Checked = True Then
		If IsNumeric(Request.Form("Doc_Month")) AND IsNumeric(Request.Form("Doc_Day")) AND IsNumeric(Request.Form("Doc_Year")) AND IsNumeric(Request.Form("DocTo_Year")) AND IsNumeric(Request.Form("DocTo_Month")) AND IsNumeric(Request.Form("DocTo_Day")) Then
			StartDate = DateTimeUtil.FormatDate(Request.Form("Doc_Day"),Request.Form("Doc_Month"),Request.Form("Doc_Year"))
			Dim CheckDate As New DateTime(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"), 0, 0, 0)
			CheckDate = DateAdd("d",1,CheckDate)
			EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
			
			If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
				ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
				FoundError = True
				DateFromValue = ""
				DateToValue = ""
				DailyDateValue = ""
			Else
				ResultSearchText.InnerHtml = ""
				Dim SDate1 As New Date(Request.Form("Doc_Year"), Request.Form("Doc_Month"), Request.Form("Doc_Day"))
				Dim EDate1 As New Date(Request.Form("DocTo_Year"), Request.Form("DocTo_Month"), Request.Form("DocTo_Day"))
				ReportDate = Format(SDate1, "d MMMM yyyy") + " - " + Format(EDate1, "d MMMM yyyy")
			End If
		Else
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
			FoundError = True
			DateFromValue = ""
			DateToValue = ""
			DailyDateValue = ""
		End If
	Else If Radio_3.Checked = True Then
		If IsNumeric(Request.Form("DocDaily_Day")) AND IsNumeric(Request.Form("DocDaily_Month")) AND IsNumeric(Request.Form("DocDaily_Year")) Then
			StartDate = DateTimeUtil.FormatDate(Request.Form("DocDaily_Day"),Request.Form("DocDaily_Month"),Request.Form("DocDaily_Year"))
			Dim CheckDate As New DateTime(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"), 0, 0, 0)
			CheckDate = DateAdd("d",1,CheckDate)
			EndDate = DateTimeUtil.FormatDate(Day(CheckDate),Month(CheckDate),CheckDate.ToString("yyyy", InvC))
	
			If Trim(StartDate) = "InvalidDate" Or Trim(EndDate) = "InvalidDate" Then
				ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
				FoundError = True
				DateFromValue = ""
				DateToValue = ""
				DailyDateValue = ""
			Else
				Dim SDate2 As New Date(Request.Form("DocDaily_Year"), Request.Form("DocDaily_Month"), Request.Form("DocDaily_Day"))
				ReportDate = DateTimeUtil.FormatDateTime(SDate2, "DateOnly",Session("LangID"),objCnn)
				ResultSearchText.InnerHtml = ""
			End If
		Else
			ResultSearchText.InnerHtml = "<table><tr><td class=""requireText"">" + LangDefault.Rows(19)(LangText) + "</td></tr></table>"
			FoundError = True
			DateFromValue = ""
			DateToValue = ""
			DailyDateValue = ""
		End If
	Else
		DateFromValue = ""
		DateToValue = ""
		DailyDateValue = ""
	End If
	
	If Not IsNumeric(NumDisplay.Text) Then
		FoundError = True
	End If	
	If FoundError = False Then

		Dim dtTable As New DataTable()
		
		showFavoriteResults.Visible = True
		
		Dim ViewOption As Integer
		If Radio_1.Checked = True Then
			ViewOption = 1
		ElseIf Radio_2.Checked = True Then
			ViewOption = 2
		Else
			ViewOption = 0 
		End If
		Dim grandTotalQty AS Double = 0
		Application.Lock()

		getReport.TopSaleReports(dtTable,grandTotalQty,grandTotal,GraphData,GroupByParam.SelectedItem.Value, StartDate, EndDate,"","", ShopInfo.SelectedItem.Value,GroupInfo.SelectedItem.Value,DeptInfo.SelectedItem.Value,NumDisplay.Text, DisplayGraph.Checked, Session("LangID"), MemberIDList.Value,1, objCnn)
		
		Application.UnLock()

		Dim TextClass As String = "text"
		Dim i,totalDisplay As Integer
		If NumDisplay.Text > 0 AND NumDisplay.Text <= dtTable.Rows.Count Then
			totalDisplay = NumDisPlay.Text
		Else
			totalDisplay = dtTable.Rows.Count
		End If
		
		Dim gData As New DataSet()
		Dim table As DataTable = gData.Tables.Add("Data")
        table.Columns.Add("Description")
        table.Columns.Add("Value1", GetType(Double))
		Dim subTotal As Double = 0
		
		Dim MFCounter,MFProductCode,MFProductName,MFQty,MFAmount,MFPercent As String
		MFProductCode = "Product Code"
		MFProductName = "Product Name"
		MFQty = "Qty"
		MFAmount = "Amount"
		MFPercent =  "%"
		
		PercentBaseText.InnerHtml = "% (based on " +  Format(grandTotal, "##,##0.00") + ")"
		Dim myDataTable As DataTable = new DataTable("MemberFavoriteDataTable")
		Dim myDataColumn As DataColumn 
		Dim myDataRow As DataRow

		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = "#"
		myDataColumn.ReadOnly = True
		myDataColumn.Unique = False
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = MFProductCode
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = MFProductName
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = MFQty
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = MFAmount
		myDataTable.Columns.Add(myDataColumn)
		
		myDataColumn = New DataColumn()
		myDataColumn.DataType = System.Type.GetType("System.String")
		myDataColumn.ColumnName = MFPercent
		myDataTable.Columns.Add(myDataColumn)
		
		Dim subTotalQty As Double = 0
		For i = 0 to totalDisplay - 1 
			myDataRow = myDataTable.NewRow()
			myDataRow("#") = (i+1).ToString
			If Not IsDBNull(dtTable.Rows(i)("ProductCode")) Then
				myDataRow(MFProductCode) = dtTable.Rows(i)("ProductCode")
			Else
				myDataRow(MFProductCode) = "-"
			End If
			If Not IsDBNull(dtTable.Rows(i)("ProductName")) Then
				myDataRow(MFProductName) = dtTable.Rows(i)("ProductName")
			Else
				myDataRow(MFProductName) = "-"
			End If
			If Not IsDBNull(dtTable.Rows(i)("TotalQty")) Then
				myDataRow(MFQty) = Format(dtTable.Rows(i)("TotalQty"), "##,##0.00")
				subTotalQty += dtTable.Rows(i)("TotalQty")
			Else
				myDataRow(MFQty) = "-"
			End If
			If Not IsDBNull(dtTable.Rows(i)("TotalSale")) Then
				myDataRow(MFAmount) = Format(dtTable.Rows(i)("TotalSale"), "##,##0.00")
				myDataRow(MFPercent) = Format((dtTable.Rows(i)("TotalSale"))*100/grandTotal, "##,##0.00") + "%"
				subTotal += dtTable.Rows(i)("TotalSale")
				
				Dim row As DataRow = table.NewRow()
				row("Description") = dtTable.Rows(i)("ProductName")
				row("Value1") = Format((dtTable.Rows(i)("TotalSale"))*100/grandTotal, "##,##0.00")
				table.Rows.Add(row)

			Else
				myDataRow(MFAmount) = "-"
				myDataRow(MFPercent) = "-"
			End If

			myDataTable.Rows.Add(myDataRow)
			
			
		Next
		myDataRow = myDataTable.NewRow()
		myDataRow("#") = ""
		myDataRow(MFProductCode) = ""
		myDataRow(MFProductName) = "Sub Total"
		myDataRow(MFQty) = Format(subTotalQty, "##,##0.00")
		myDataRow(MFAmount) = Format(subTotal, "##,##0.00")
		myDataRow(MFPercent) = Format(subTotal*100/grandTotal, "##,##0.00") + "%"
		myDataTable.Rows.Add(myDataRow)
		If subTotal <> grandTotal Then
			Dim row As DataRow = table.NewRow()
			row("Description") = "Others"
			row("Value1") = Format((grandTotal-subTotal)*100/grandTotal, "##,##0.00")
			table.Rows.Add(row)
			myDataRow = myDataTable.NewRow()
			myDataRow("#") = ""
			myDataRow(MFProductCode) = ""
			myDataRow(MFProductName) = "Others"
			myDataRow(MFQty) = Format(grandTotalQty-subTotalQty, "##,##0.00")
			myDataRow(MFAmount) = Format(grandTotal-subTotal, "##,##0.00")
			myDataRow(MFPercent) = Format((grandTotal-subTotal)*100/grandTotal, "##,##0.00") + "%"
			myDataTable.Rows.Add(myDataRow)
			
			myDataRow = myDataTable.NewRow()
			myDataRow("#") = ""
			myDataRow(MFProductCode) = ""
			myDataRow(MFProductName) = "Grand Total"
			myDataRow(MFQty) = Format(grandTotalQty, "##,##0.00")
			myDataRow(MFAmount) = Format(grandTotal, "##,##0.00")
			myDataRow(MFPercent) = Format((grandTotal)*100/grandTotal, "##,##0.00") + "%"
			myDataTable.Rows.Add(myDataRow)

		End If
		
		FavoriteResults.DataSource = myDataTable
		FavoriteResults.DataBind()
	
		Dim ShopGroupDept As String = ShopInfo.SelectedItem.Text
		If GroupInfo.SelectedItem.Value > 0 Then
			ShopGroupDept += ":" + GroupInfo.SelectedItem.Text
		End If
		If DeptInfo.SelectedItem.Value > 0 Then
			ShopGroupDept += ":" + DeptInfo.SelectedItem.Text
		End If
		ResultSearchText.InnerHtml = "Top Product Sale Report of " + ShopGroupDept + " (" + ReportDate + ")"
		If DisplayGraph.Checked = True Then

				showGraph.Visible = True
				Dim view As DataView = gData.Tables(0).DefaultView
            
				Dim chart As New PieChart()
				chart.Explosion = 3
				chart.Fill.Color = Color.FromArgb(80, Color.SpringGreen)
            	chart.Line.Color = Color.SteelBlue
            	chart.Line.Width = 1
				chart.ShowLegend = True
				chart.DataLabels.Visible = True
				chart.DataSource = view
				chart.DataXValueField = "Description"
				chart.DataYValueField = "Value1"
				chart.DataBind()
				ChartControl1.Charts.Add(chart)
				ConfigureColors("Top Product Sale Report of " + ShopGroupDept + " (" + ReportDate + ")")
        
        		ChartControl1.RedrawChart()
		Else
			showGraph.Visible = False
		End If
	Else
		showFavoriteResults.Visible = False
	End If
End Sub

Sub DoSwitch1(Source As Object, E As EventArgs)
	Dim i As Integer
	SearchCriteria.Enabled = False
	SearchResult.Enabled = True
	BestSeller.Enabled = True
	SaleReport.Enabled = True
	EmailForm.Enabled = True
	LabelLink.Enabled = True
	Options.Enabled = True
	SMSForm.Enabled = True
	Section8.Visible = False
	Section1.Visible = True
	Section2.Visible = False
	Section3.Visible = False
	Section4.Visible = False
	Section5.Visible = False
	Section6.Visible = False
	Section7.Visible = False
	
	CheckDynamicCol(Session("StaffID"),objCnn)
	
End Sub
Sub DoSwitch2(Source As Object, E As EventArgs)
	SearchCriteria.Enabled = True
	SearchResult.Enabled = False
	BestSeller.Enabled = True
	SaleReport.Enabled = True
	EmailForm.Enabled = True
	LabelLink.Enabled = True
	Options.Enabled = True
	SMSForm.Enabled = True
	Section8.Visible = False
	Section1.Visible = False
	Section2.Visible = True
	Section3.Visible = False
	Section4.Visible = False
	Section5.Visible = False
	Section6.Visible = False
	Section7.Visible = False
End Sub
Sub DoSwitch3(Source As Object, E As EventArgs)
	SearchCriteria.Enabled = True
	SearchResult.Enabled = True
	BestSeller.Enabled = False
	SaleReport.Enabled = True
	EmailForm.Enabled = True
	LabelLink.Enabled = True
	Options.Enabled = True
	SMSForm.Enabled = True
	Section8.Visible = False
	Section1.Visible = False
	Section2.Visible = False
	Section3.Visible = True
	Section4.Visible = False
	Section5.Visible = False
	Section6.Visible = False
	Section7.Visible = False
	showFavoriteResults.Visible = False
	
End Sub
Sub DoSwitch4(Source As Object, E As EventArgs)
	SearchCriteria.Enabled = True
	SearchResult.Enabled = True
	BestSeller.Enabled = True
	SaleReport.Enabled = False
	EmailForm.Enabled = True
	LabelLink.Enabled = True
	Options.Enabled = True
	SMSForm.Enabled = True
	Section8.Visible = False
	Section1.Visible = False
	Section2.Visible = False
	Section3.Visible = False
	Section4.Visible = True
	Section5.Visible = False
	Section6.Visible = False
	Section7.Visible = False
	showSaleResults.Visible = False
End Sub
Sub DoSwitch5(Source As Object, E As EventArgs)
	SearchCriteria.Enabled = True
	SearchResult.Enabled = True
	BestSeller.Enabled = True
	SaleReport.Enabled = True
	EmailForm.Enabled = False
	LabelLink.Enabled = True
	Options.Enabled = True
	SMSForm.Enabled = True
	Section8.Visible = False
	Section1.Visible = False
	Section2.Visible = False
	Section3.Visible = False
	Section4.Visible = False
	Section5.Visible = True
	Section6.Visible = False
	Section7.Visible = False
	Dim totalM As Integer
	SubmitEmail.Enabled = False
	If IsNumeric(MemberRecord.Value) Then
		totalM = CInt(MemberRecord.Value) 
		If totalM > 0 Then
			SubmitEmail.Enabled = True
		End If
	End If
	EmailInvalid.Visible = False
	SubjectInvalid.Visible = False
	ShowEmailForm.Visible = True
	ConfirmationEmail.Visible = False
	FinalSendEmail.Visible = False
End Sub
Sub DoSwitch6(Source As Object, E As EventArgs)
	SearchCriteria.Enabled = True
	SearchResult.Enabled = True
	BestSeller.Enabled = True
	SaleReport.Enabled = True
	EmailForm.Enabled = True
	LabelLink.Enabled = False
	Options.Enabled = True
	SMSForm.Enabled = True
	Section8.Visible = False
	Section1.Visible = False
	Section2.Visible = False
	Section3.Visible = False
	Section4.Visible = False
	Section5.Visible = False
	Section6.Visible = True
	Section7.Visible = False
End Sub
Sub DoSwitch7(Source As Object, E As EventArgs)
	SearchCriteria.Enabled = True
	SearchResult.Enabled = True
	BestSeller.Enabled = True
	SaleReport.Enabled = True
	EmailForm.Enabled = True
	LabelLink.Enabled = True
	Options.Enabled = False
	SMSForm.Enabled = True
	Section8.Visible = False
	Section1.Visible = False
	Section2.Visible = False
	Section3.Visible = False
	Section4.Visible = False
	Section5.Visible = False
	Section6.Visible = False
	Section7.Visible = True

End Sub
Sub DoSwitch8(Source As Object, E As EventArgs)
	SearchCriteria.Enabled = True
	SearchResult.Enabled = True
	BestSeller.Enabled = True
	SaleReport.Enabled = True
	EmailForm.Enabled = True
	LabelLink.Enabled = True
	Options.Enabled = True
	SMSForm.Enabled = False
	Section1.Visible = False
	Section2.Visible = False
	Section3.Visible = False
	Section4.Visible = False
	Section5.Visible = False
	Section6.Visible = False
	Section7.Visible = False
	Section8.Visible = True
	Dim totalM As Integer
	SubmitSMS.Enabled = False
	If IsNumeric(MemberMobileRecord.Value) Then
		totalM = CInt(MemberMobileRecord.Value) 
		If totalM > 0 Then
			SubmitSMS.Enabled = True
		End If
	End If

End Sub

Sub SelGroup(sender As Object, e As System.EventArgs)
	ShowGroup()
End Sub

Sub ShowGroup()
	showGraph.Visible = False
	Dim i As Integer
	Dim gpTable As New DataTable()
	gpTable = getInfo.GetProductGroupCode(ShopInfo.SelectedItem.Value,0,objCnn)
			
	Dim groupTable As DataTable = New DataTable("GroupData")
	groupTable.Columns.Add("ProductGroupName")
	groupTable.Columns.Add("ProductGroupID", GetType(String))
	Dim myrow As DataRow = groupTable.NewRow()
	myrow("ProductGroupName") = "-- Display All Groups --"
	myrow("ProductGroupID") = "0"
	groupTable.Rows.Add(myrow)
	If ShopInfo.SelectedItem.Value >= 0 Then
		For i = 0 To gpTable.Rows.Count - 1
			myrow = groupTable.NewRow()
			myrow("ProductGroupName") = gpTable.Rows(i)("ProductGroupName")
			myrow("ProductGroupID") = gpTable.Rows(i)("ProductGroupCode")
			groupTable.Rows.Add(myrow)
		Next
	End If
	GroupInfo.DataSource = groupTable
	GroupInfo.DataValueField = "ProductGroupID"
	GroupInfo.DataTextField = "ProductGroupName"
	GroupInfo.DataBind()
	
	Dim deptTable As DataTable = New DataTable("DeptData")
	deptTable.Columns.Add("ProductDeptName")
	deptTable.Columns.Add("ProductDeptID", GetType(String))
	Dim deptRow As DataRow = deptTable.NewRow()
	deptRow("ProductDeptName") = "-- Display All Dept --"
	deptRow("ProductDeptID") = "0"
	deptTable.Rows.Add(deptRow)
	DeptInfo.DataSource = deptTable
	DeptInfo.DataValueField = "ProductDeptID"
	DeptInfo.DataTextField = "ProductDeptName"
	DeptInfo.DataBind()
	DeptInfo.Enabled = False
End Sub

Sub SelDept(sender As Object, e As System.EventArgs)
	ShowDept()
End Sub

Sub ShowDept()
	showGraph.Visible = False
	Dim i As Integer
	Dim deptTable As DataTable = New DataTable("DeptData")
	deptTable.Columns.Add("ProductDeptName")
	deptTable.Columns.Add("ProductDeptID", GetType(String))
	Dim deptRow As DataRow = deptTable.NewRow()
	If GroupInfo.SelectedItem.Value = "" Then
		DeptInfo.Enabled = False
		
		deptRow("ProductDeptName") = "-- Display All Dept --"
		deptRow("ProductDeptID") = "0"
		deptTable.Rows.Add(deptRow)
		DeptInfo.Enabled = False
	Else
		DeptInfo.Enabled = True
		Dim dpTable As New DataTable()
		dpTable = getInfo.GetProductDeptCode(ShopInfo.SelectedItem.Value,GroupInfo.SelectedItem.Value,0,objCnn)
		deptRow("ProductDeptName") = "-- Display All Dept --"
		deptRow("ProductDeptID") = "0"
		deptTable.Rows.Add(deptRow)
		For i = 0 To dpTable.Rows.Count - 1
			deptRow = deptTable.NewRow()
			deptRow("ProductDeptName") = dpTable.Rows(i)("ProductDeptName")
			deptRow("ProductDeptID") = dpTable.Rows(i)("ProductDeptCode")
			deptTable.Rows.Add(deptRow)
		Next
		DeptInfo.DataSource = deptTable
		DeptInfo.DataValueField = "ProductDeptID"
		DeptInfo.DataTextField = "ProductDeptName"
		DeptInfo.DataBind()
	End If
End Sub

Sub SelGroup1(sender As Object, e As System.EventArgs)
	ShowGroup1()
End Sub

Sub ShowGroup1()
	Dim i As Integer
	Dim gpTable As New DataTable()
	gpTable = getInfo.GetProductGroup(ShopInfo1.SelectedItem.Value,0,objCnn)
			
	Dim groupTable As DataTable = New DataTable("GroupData")
	groupTable.Columns.Add("ProductGroupName")
	groupTable.Columns.Add("ProductGroupID", GetType(Integer))
	Dim myrow As DataRow = groupTable.NewRow()
	myrow("ProductGroupName") = "-- Display All Groups --"
	myrow("ProductGroupID") = "0"
	groupTable.Rows.Add(myrow)
	For i = 0 To gpTable.Rows.Count - 1
		myrow = groupTable.NewRow()
		myrow("ProductGroupName") = gpTable.Rows(i)("ProductGroupName")
		myrow("ProductGroupID") = gpTable.Rows(i)("ProductGroupID")
		groupTable.Rows.Add(myrow)
	Next
	GroupInfo1.DataSource = groupTable
	GroupInfo1.DataValueField = "ProductGroupID"
	GroupInfo1.DataTextField = "ProductGroupName"
	GroupInfo1.DataBind()
	
	Dim deptTable As DataTable = New DataTable("DeptData")
	deptTable.Columns.Add("ProductDeptName")
	deptTable.Columns.Add("ProductDeptID", GetType(Integer))
	Dim deptRow As DataRow = deptTable.NewRow()
	deptRow("ProductDeptName") = "-- Display All Dept --"
	deptRow("ProductDeptID") = "0"
	deptTable.Rows.Add(deptRow)
	DeptInfo1.DataSource = deptTable
	DeptInfo1.DataValueField = "ProductDeptID"
	DeptInfo1.DataTextField = "ProductDeptName"
	DeptInfo1.DataBind()
	DeptInfo1.Enabled = False
End Sub

Sub SelDept1(sender As Object, e As System.EventArgs)
	ShowDept1()
End Sub

Sub ShowDept1()
	Dim i As Integer
	Dim deptTable As DataTable = New DataTable("DeptData")
	deptTable.Columns.Add("ProductDeptName")
	deptTable.Columns.Add("ProductDeptID", GetType(Integer))
	Dim deptRow As DataRow = deptTable.NewRow()
	If GroupInfo1.SelectedItem.Value = 0 Then
		DeptInfo1.Enabled = False
		
		deptRow("ProductDeptName") = "-- Display All Dept --"
		deptRow("ProductDeptID") = "0"
		deptTable.Rows.Add(deptRow)
		DeptInfo1.Enabled = False
	Else
		DeptInfo1.Enabled = True
		Dim dpTable As New DataTable()
		dpTable = getInfo.GetProductDept(GroupInfo1.SelectedItem.Value,0,objCnn)
		deptRow("ProductDeptName") = "-- Display All Dept --"
		deptRow("ProductDeptID") = "0"
		deptTable.Rows.Add(deptRow)
		For i = 0 To dpTable.Rows.Count - 1
			deptRow = deptTable.NewRow()
			deptRow("ProductDeptName") = dpTable.Rows(i)("ProductDeptName")
			deptRow("ProductDeptID") = dpTable.Rows(i)("ProductDeptID")
			deptTable.Rows.Add(deptRow)
		Next
		DeptInfo1.DataSource = deptTable
		DeptInfo1.DataValueField = "ProductDeptID"
		DeptInfo1.DataTextField = "ProductDeptName"
		DeptInfo1.DataBind()
	End If
End Sub

 Sub ConfigureColors(TitleName)
        	'ChartControl1.Background.Color = Color.FromArgb(75, Color.SteelBlue)
			Dim ChartWidth As Integer = 700
			Dim ChartHeight As Integer = 550
			
			
            ChartControl1.Background.Type = InteriorType.LinearGradient
            ChartControl1.Background.ForeColor = Color.SteelBlue
            ChartControl1.Background.EndPoint = new Point(ChartWidth, ChartHeight) 
            ChartControl1.Legend.Position = LegendPosition.Bottom
           ' 'ChartControl1.Legend.Width = 40
			ChartControl1.Width = Unit.Parse(ChartWidth.ToString + "px")
			ChartControl1.Height = Unit.Parse(ChartHeight.ToString + "px")
 
            ChartControl1.YAxisFont.ForeColor = Color.SteelBlue
            ChartControl1.XAxisFont.ForeColor = Color.SteelBlue
            
            ChartControl1.ChartTitle.Text = TitleName
            ChartControl1.ChartTitle.ForeColor = Color.White
      
            ChartControl1.Border.Color = Color.SteelBlue
            'ChartControl1.BorderStyle = BorderStyle.Ridge
    End Sub

Private Sub FavoriteResults_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) 
	If e.Item.ItemType = ListItemType.Header Then
		e.Item.Cells(0).Text = "#"
		e.Item.Cells(1).Text = "Product Code"
		e.Item.Cells(2).Text = "Product Name"
		e.Item.Cells(3).Text = "Qty"
		e.Item.Cells(4).Text = "Amount"
		e.Item.Cells(5).Text = "%"
	End If
End Sub

Private Sub SaleResults_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) 
	If e.Item.ItemType = ListItemType.Header Then
		e.Item.Cells(0).Text = "#"
		e.Item.Cells(1).Text = "Member Code"
		e.Item.Cells(2).Text = "Member Name"
		e.Item.Cells(3).Text = "Purchase Amount"
	End If
End Sub

Private Sub MemberResults_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) 
	Dim textTable As New DataTable()
	textTable = getPageText.GetText(11,Session("LangID"),objCnn)
	
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	
	If e.Item.ItemType = ListItemType.Header Then
		e.Item.Cells(0).Text = "#"
		e.Item.Cells(1).Text = textTable.Rows(19)("TextParamValue")
		e.Item.Cells(2).Text = textTable.Rows(17)("TextParamValue") + "/" + defaultTextTable.Rows(25)("TextParamValue")
		e.Item.Cells(3).Text = defaultTextTable.Rows(47)("TextParamValue")
		e.Item.Cells(4).Text = defaultTextTable.Rows(28)("TextParamValue")
		e.Item.Cells(5).Text = textTable.Rows(18)("TextParamValue")
		e.Item.Cells(6).Text = defaultTextTable.Rows(31)("TextParamValue")
		e.Item.Cells(7).Text = defaultTextTable.Rows(105)("TextParamValue")
		e.Item.Cells(8).Text = defaultTextTable.Rows(23)("TextParamValue") + "/<br>" + defaultTextTable.Rows(27)("TextParamValue")
		e.Item.Cells(9).Text = "Register Date/<br>Expire Date"
	End If
End Sub
Sub DoSendEmail(Source As Object, E As EventArgs)
	SubjectInvalid.Visible = False
	EmailInvalid.Visible = False
	Dim FoundError As Boolean = False
	If Trim(Request.Form("EmailSubject")) = "" Then 
		SubjectInvalid.Visible = True
		FoundError = True
	End If
	Dim strPattern As String = "^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$"
	If System.Text.RegularExpressions.Regex.IsMatch(Request.Form("EmailFrom"), strPattern) = False Then
		EmailInvalid.Visible = True
		FoundError = True
	End If
	If FoundError = True Then
		ShowEmailForm.Visible = True
		ConfirmationEmail.Visible = False
		FinalSendEmail.Visible = False
	Else
		ShowEmailForm.Visible = False
		ConfirmationEmail.Visible = True
		FinalSendEmail.Visible = False
		CFromEmailText.InnerHtml = Request.Form("EmailFrom")
		CSubjectEmailText.InnerHtml = Request.Form("EmailSubject")
		CCCEmailText.InnerHtml = Request.Form("EmailCC")
		EmailFromVal.Value = Request.Form("EmailFrom")
		EmailSubjectVal.Value = Request.Form("EmailSubject")
		EmailCCVal.Value = Request.Form("EmailCC")
		EmailMessageVal.Value = Request.Form("FCKeditor1")
	End If
End Sub

Sub DoCSendEmail(Source As Object, E As EventArgs)
	Dim PropertyInfo As DataTable = getProp.PropertyInfo(1,objCnn)	
	Dim memberData As DataTable = objDB.List("SELECT MemberID,MemberEmail AS EmailAddress FROM Members WHERE Deleted=0 AND MemberID IN (" + MemberIDList.Value + ")", objCnn)
	Dim EmailList As String = SendEmail(memberData,EmailFromVal.Value,EmailSubjectVal.Value,EmailCCVal.Value,EmailMessageVal.Value,PropertyInfo.Rows(0)("SMTPServer"),objCnn)
	
	ShowEmailForm.Visible = False
	ConfirmationEmail.Visible = False
	FinalSendEmail.Visible = True
	Dim i As Integer
	Dim EmailSent As String = "<ol type=""1"">"
	Dim OutputList() As String
	OutputList = EmailList.Split(","c)
	If OutputList.Length > 1 Then
		If OutputList(0) <> "Error" Then
			SendEmailMsg.InnerHtml = OutputList(0)
			For i = 1 To OutputList.Length - 1
				EmailSent += "<li type=""1"">" + OutputList(i) + "</li>"
			Next
			EmailSent += "</ol>"
			EmailListSent.InnerHtml = EmailSent
		Else
			SendEmailMsg.InnerHtml = OutputList(1)
			EmailListSent.InnerHtml = ""
			FinishSubmitEmail.Enabled = False
		End If
	Else
		SendEmailMsg.InnerHtml = "No Return Data"
		EmailListSent.InnerHtml = ""
		FinishSubmitEmail.Enabled = False
	End If
End Sub

Sub DoCancelSendEmail(Source As Object, E As EventArgs)
	ShowEmailForm.Visible = True
	ConfirmationEmail.Visible = False
	FinalSendEmail.Visible = False
End Sub

Sub FinishSendEmail(Source As Object, E As EventArgs)
	ShowEmailForm.Visible = True
	ConfirmationEmail.Visible = False
	FinalSendEmail.Visible = False
	EmailSubject.Text = ""
	EmailCC.Text = ""
	FCKeditor1.Value = ""
End Sub

Public Function SendEmail(ByVal dtTable As DataTable, ByVal EmailFrom As String, ByVal EmailSubject As String, ByVal EmailCC As String, ByVal EmailMessage As String, ByVal SMTPServer As String, ByVal objCnn As MySqlConnection) As String
Try 
	Dim mailMessage As System.Web.Mail.MailMessage = New System.Web.Mail.MailMessage 

	Dim strPattern As String = "^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$"
	If System.Text.RegularExpressions.Regex.IsMatch(EmailFrom, strPattern) = False Then
		Return "Error,Invalid from email address"
	End If
	If Trim(EmailSubject) = "" Then 
		Return "Error,Subject of email is blank"
	End If

	Dim i As Integer
	Dim EmailList As String = ""
	For i = 0 To dtTable.Rows.Count - 1
	  If Not IsDBNull(dtTable.Rows(i)("EmailAddress")) Then
		If System.Text.RegularExpressions.Regex.IsMatch(Trim(dtTable.Rows(i)("EmailAddress")), strPattern) = True Then
			mailMessage.From = EmailFrom
			mailMessage.To = Trim(dtTable.Rows(i)("EmailAddress"))
			mailMessage.Subject = EmailSubject
			mailMessage.BodyFormat = System.Web.Mail.MailFormat.Html
			mailMessage.Cc = ""
			mailMessage.Body = EmailMessage
			System.Web.Mail.SmtpMail.SmtpServer = SMTPServer
			System.Web.Mail.SmtpMail.Send(mailMessage) 
			
			EmailList += "," + Trim(dtTable.Rows(i)("EmailAddress"))
		End If
	  End If
	Next
	If Trim(EmailCC) <> "" Then
		mailMessage.From = EmailFrom
		mailMessage.To = EmailCC
		mailMessage.Subject = EmailSubject
		mailMessage.BodyFormat = System.Web.Mail.MailFormat.Html
		mailMessage.Cc = ""
		mailMessage.Body = EmailMessage
		
		System.Web.Mail.SmtpMail.SmtpServer = SMTPServer
		System.Web.Mail.SmtpMail.Send(mailMessage) 
	End If

	Return "Message has been sent to the following recipients:" + EmailList
	
	Catch exp as Exception 
		Return "Error,There was and error Sending the mail: " & exp.Message 
	End Try 

End Function 

Sub MoveRight(Source As Object, E As EventArgs)
	Dim i As Integer
	Dim ListString As String
	For i = 0 to ColList.Items.Count - 1
		If ColList.Items(i).Selected = True
			PromiseCRM.AddUDDForDynamic(Session("StaffID"),1,ColList.Items(i).Value,objCnn)
		End If
	Next
	UDDDataBound(1,objCnn)
End Sub

Sub MoveLeft(Source As Object, E As EventArgs)
	Dim i As Integer
	Dim ListString As String
	For i = 0 to SelColList.Items.Count - 1
		If SelColList.Items(i).Selected = True
			PromiseCRM.DelUDDForDynamic(Session("StaffID"),1,SelColList.Items(i).Value,objCnn)
		End If
	Next
	UDDDataBound(1,objCnn)
End Sub

Sub MoveRightNumeric(Source As Object, E As EventArgs)
	Dim i As Integer
	Dim ListString As String
	For i = 0 to ColNumericList.Items.Count - 1
		If ColNumericList.Items(i).Selected = True
			PromiseCRM.AddUDDForDynamic(Session("StaffID"),2,ColNumericList.Items(i).Value,objCnn)
		End If
	Next
	UDDDataBound(2,objCnn)
End Sub

Sub MoveLeftNumeric(Source As Object, E As EventArgs)
	Dim i As Integer
	Dim ListString As String
	For i = 0 to SelNumericColList.Items.Count - 1
		If SelNumericColList.Items(i).Selected = True
			PromiseCRM.DelUDDForDynamic(Session("StaffID"),2,SelNumericColList.Items(i).Value,objCnn)
		End If
	Next
	UDDDataBound(2,objCnn)
End Sub

Sub MoveRightDate(Source As Object, E As EventArgs)
	Dim i As Integer
	Dim ListString As String
	For i = 0 to ColDateList.Items.Count - 1
		If ColDateList.Items(i).Selected = True
			PromiseCRM.AddUDDForDynamic(Session("StaffID"),3,ColDateList.Items(i).Value,objCnn)
		End If
	Next
	UDDDataBound(3,objCnn)
End Sub

Sub MoveLeftDate(Source As Object, E As EventArgs)
	Dim i As Integer
	Dim ListString As String
	For i = 0 to SelDateColList.Items.Count - 1
		If SelDateColList.Items(i).Selected = True
			PromiseCRM.DelUDDForDynamic(Session("StaffID"),3,SelDateColList.Items(i).Value,objCnn)
		End If
	Next
	UDDDataBound(3,objCnn)
End Sub

Public Function UDDDataBound(ByVal DataType As Integer, ByVal objCnn As MySqlConnection) As Boolean
	Dim DynamicUDD As New DataTable()
	Dim SelDynamicUDD As New DataTable()
	
	If DataType = 1 Or DataType = 0 Then
		DynamicUDD = PromiseCRM.UDDForDynamic(Session("StaffID"),1,objCnn)
		ColList.DataSource = DynamicUDD
		ColList.DataValueField = "UDDID"
		ColList.DataTextField = "UDDName"
		ColList.DataBind()
		
		
		SelDynamicUDD = PromiseCRM.SelUDDForDynamic(Session("StaffID"),1,objCnn)
		SelColList.DataSource = SelDynamicUDD
		SelColList.DataValueField = "UDDID"
		SelColList.DataTextField = "UDDName"
		SelColList.DataBind()
	End If
	
	If DataType = 2 Or DataType = 0 Then
		DynamicUDD = PromiseCRM.UDDForDynamic(Session("StaffID"),2,objCnn)
		ColNumericList.DataSource = DynamicUDD
		ColNumericList.DataValueField = "UDDID"
		ColNumericList.DataTextField = "UDDName"
		ColNumericList.DataBind()
	
		SelDynamicUDD = PromiseCRM.SelUDDForDynamic(Session("StaffID"),2,objCnn)
		SelNumericColList.DataSource = SelDynamicUDD
		SelNumericColList.DataValueField = "UDDID"
		SelNumericColList.DataTextField = "UDDName"
		SelNumericColList.DataBind()
	End If
	
	If DataType = 3 Or DataType = 0 Then
		DynamicUDD = PromiseCRM.UDDForDynamic(Session("StaffID"),3,objCnn)
		ColDateList.DataSource = DynamicUDD
		ColDateList.DataValueField = "UDDID"
		ColDateList.DataTextField = "UDDName"
		ColDateList.DataBind()
	
		SelDynamicUDD = PromiseCRM.SelUDDForDynamic(Session("StaffID"),3,objCnn)
		SelDateColList.DataSource = SelDynamicUDD
		SelDateColList.DataValueField = "UDDID"
		SelDateColList.DataTextField = "UDDName"
		SelDateColList.DataBind()
	End If
End Function

Public Function CheckDynamicCol(ByVal StaffID As Integer, ByVal objCnn As MySqlConnection) As DataTable
	Dim getDynamic As DataTable = PromiseCRM.SelUDDForDynamic(StaffID,1,objCnn)
	Dim defaultTextTable As New DataTable()
	defaultTextTable = getPageText.GetDefaultText(Session("LangID"),objCnn)
	Dim UDDOption1,UDDOption2,UDDOption3,UDDOption4,UDDOption5,UDDOption6 As DataTable
	Dim totalCol As Integer
	Dim i As Integer
	If getDynamic.Rows.Count = 0 Then
		DynamicCriteria.Visible = False
	Else
		DynamicCriteria.Visible = True
		
		Select Case getDynamic.Rows.Count
			Case 1
				DynamicText1.InnerHtml = getDynamic.Rows(0)("UDDName")
				DynamicText2.InnerHtml = ""
				DynamicText3.InnerHtml = ""
				DynamicText4.InnerHtml = ""
				DynamicText5.InnerHtml = ""
				DynamicText6.InnerHtml = ""
				Dynamic1.Visible = True
				Dynamic2.Visible = False
				Dynamic3.Visible = False
				Dynamic4.Visible = False
				Dynamic5.Visible = False
				Dynamic6.Visible = False
				
			Case 2
				DynamicText1.InnerHtml = getDynamic.Rows(0)("UDDName")
				DynamicText2.InnerHtml = getDynamic.Rows(1)("UDDName")
				DynamicText3.InnerHtml = ""
				DynamicText4.InnerHtml = ""
				DynamicText5.InnerHtml = ""
				DynamicText6.InnerHtml = ""
				Dynamic1.Visible = True
				Dynamic2.Visible = True
				Dynamic3.Visible = False
				Dynamic4.Visible = False
				Dynamic5.Visible = False
				Dynamic6.Visible = False

			Case 3
				DynamicText1.InnerHtml = getDynamic.Rows(0)("UDDName")
				DynamicText2.InnerHtml = getDynamic.Rows(1)("UDDName")
				DynamicText3.InnerHtml = getDynamic.Rows(2)("UDDName")
				DynamicText4.InnerHtml = ""
				DynamicText5.InnerHtml = ""
				DynamicText6.InnerHtml = ""
				Dynamic1.Visible = True
				Dynamic2.Visible = True
				Dynamic3.Visible = True
				Dynamic4.Visible = False
				Dynamic5.Visible = False
				Dynamic6.Visible = False

			Case 4
				DynamicText1.InnerHtml = getDynamic.Rows(0)("UDDName")
				DynamicText2.InnerHtml = getDynamic.Rows(1)("UDDName")
				DynamicText3.InnerHtml = getDynamic.Rows(2)("UDDName")
				DynamicText4.InnerHtml = getDynamic.Rows(3)("UDDName")
				DynamicText5.InnerHtml = ""
				DynamicText6.InnerHtml = ""
				Dynamic1.Visible = True
				Dynamic2.Visible = True
				Dynamic3.Visible = True
				Dynamic4.Visible = True
				Dynamic5.Visible = False
				Dynamic6.Visible = False

			Case 5
				DynamicText1.InnerHtml = getDynamic.Rows(0)("UDDName")
				DynamicText2.InnerHtml = getDynamic.Rows(1)("UDDName")
				DynamicText3.InnerHtml = getDynamic.Rows(2)("UDDName")
				DynamicText4.InnerHtml = getDynamic.Rows(3)("UDDName")
				DynamicText5.InnerHtml = getDynamic.Rows(4)("UDDName")
				DynamicText6.InnerHtml = ""
				Dynamic1.Visible = True
				Dynamic2.Visible = True
				Dynamic3.Visible = True
				Dynamic4.Visible = True
				Dynamic5.Visible = True
				Dynamic6.Visible = False

			Case 6
				DynamicText1.InnerHtml = getDynamic.Rows(0)("UDDName")
				DynamicText2.InnerHtml = getDynamic.Rows(1)("UDDName")
				DynamicText3.InnerHtml = getDynamic.Rows(2)("UDDName")
				DynamicText4.InnerHtml = getDynamic.Rows(3)("UDDName")
				DynamicText5.InnerHtml = getDynamic.Rows(4)("UDDName")
				DynamicText6.InnerHtml = getDynamic.Rows(5)("UDDName")
				Dynamic1.Visible = True
				Dynamic2.Visible = True
				Dynamic3.Visible = True
				Dynamic4.Visible = True
				Dynamic5.Visible = True
				Dynamic6.Visible = True

		End Select
		
			Dim compareString,SelectedList As String
			If getDynamic.Rows.Count >= 1 Then
				UDDOption1 = getData.UDDOption(getDynamic.Rows(0)("UDDID"),objCnn)
				Dim Option1Value As DataTable = New DataTable("OptionData")
				Option1Value.Columns.Add("OptionName")
				Option1Value.Columns.Add("OptionID", GetType(Integer))
				Dim myrow As DataRow = Option1Value.NewRow()
				myrow("OptionName") = defaultTextTable.Rows(102)("TextParamValue")
				myrow("OptionID") = 0
				Option1Value.Rows.Add(myrow)
				For i = 0 To UDDOption1.Rows.Count - 1
					myrow = Option1Value.NewRow()
					myrow("OptionName") = UDDOption1.Rows(i)("OptionName")
					myrow("OptionID") = UDDOption1.Rows(i)("OptionID")
					Option1Value.Rows.Add(myrow)
				Next
				Dynamic1.DataSource = Option1Value
				Dynamic1.DataValueField = "OptionID"
				Dynamic1.DataTextField = "OptionName"
				Dynamic1.DataBind()
				If Not Page.IsPostBack Then
					Dynamic1.Items(0).Selected = True
				Else
					SelectedList = Dynamic1List.Value
					For i = 0 to Dynamic1.Items.Count - 1
						compareString = "," & CStr(Dynamic1.Items(i).Value) & ","
                        If SelectedList.IndexOf(compareString) <> -1 Then
                            Dynamic1.Items(i).Selected = True
                        End If
					Next
				End If
			End If
			If getDynamic.Rows.Count >= 2 Then
				UDDOption2 = getData.UDDOption(getDynamic.Rows(1)("UDDID"),objCnn)
				Dim Option2Value As DataTable = New DataTable("OptionData")
				Option2Value.Columns.Add("OptionName")
				Option2Value.Columns.Add("OptionID", GetType(Integer))
				Dim myrow As DataRow = Option2Value.NewRow()
				myrow("OptionName") = defaultTextTable.Rows(102)("TextParamValue")
				myrow("OptionID") = 0
				Option2Value.Rows.Add(myrow)
				For i = 0 To UDDOption2.Rows.Count - 1
					myrow = Option2Value.NewRow()
					myrow("OptionName") = UDDOption2.Rows(i)("OptionName")
					myrow("OptionID") = UDDOption2.Rows(i)("OptionID")
					Option2Value.Rows.Add(myrow)
				Next

				Dynamic2.DataSource = Option2Value
				Dynamic2.DataValueField = "OptionID"
				Dynamic2.DataTextField = "OptionName"
				Dynamic2.DataBind()
				If Not Page.IsPostBack Then
					Dynamic2.Items(0).Selected = True
				Else
					SelectedList = Dynamic2List.Value
					For i = 0 to Dynamic2.Items.Count - 1
						compareString = "," & CStr(Dynamic2.Items(i).Value) & ","
                        If SelectedList.IndexOf(compareString) <> -1 Then
                            Dynamic2.Items(i).Selected = True
                        End If
					Next
				End If
			End If

			If getDynamic.Rows.Count >= 3 Then
				UDDOption3 = getData.UDDOption(getDynamic.Rows(2)("UDDID"),objCnn)
				Dim Option3Value As DataTable = New DataTable("OptionData")
				Option3Value.Columns.Add("OptionName")
				Option3Value.Columns.Add("OptionID", GetType(Integer))
				Dim myrow As DataRow = Option3Value.NewRow()
				myrow("OptionName") = defaultTextTable.Rows(102)("TextParamValue")
				myrow("OptionID") = 0
				Option3Value.Rows.Add(myrow)
				For i = 0 To UDDOption3.Rows.Count - 1
					myrow = Option3Value.NewRow()
					myrow("OptionName") = UDDOption3.Rows(i)("OptionName")
					myrow("OptionID") = UDDOption3.Rows(i)("OptionID")
					Option3Value.Rows.Add(myrow)
				Next
				Dynamic3.DataSource = Option3Value
				Dynamic3.DataValueField = "OptionID"
				Dynamic3.DataTextField = "OptionName"
				Dynamic3.DataBind()
				If Not Page.IsPostBack Then
					Dynamic3.Items(0).Selected = True
				Else
					SelectedList = Dynamic3List.Value
					For i = 0 to Dynamic3.Items.Count - 1
						compareString = "," & CStr(Dynamic3.Items(i).Value) & ","
                        If SelectedList.IndexOf(compareString) <> -1 Then
                            Dynamic3.Items(i).Selected = True
                        End If
					Next
				End If
			End If

			If getDynamic.Rows.Count >= 4 Then
				UDDOption4 = getData.UDDOption(getDynamic.Rows(3)("UDDID"),objCnn)
				Dim Option4Value As DataTable = New DataTable("OptionData")
				Option4Value.Columns.Add("OptionName")
				Option4Value.Columns.Add("OptionID", GetType(Integer))
				Dim myrow As DataRow = Option4Value.NewRow()
				myrow("OptionName") = defaultTextTable.Rows(102)("TextParamValue")
				myrow("OptionID") = 0
				Option4Value.Rows.Add(myrow)
				For i = 0 To UDDOption4.Rows.Count - 1
					myrow = Option4Value.NewRow()
					myrow("OptionName") = UDDOption4.Rows(i)("OptionName")
					myrow("OptionID") = UDDOption4.Rows(i)("OptionID")
					Option4Value.Rows.Add(myrow)
				Next
				Dynamic4.DataSource = Option4Value
				Dynamic4.DataValueField = "OptionID"
				Dynamic4.DataTextField = "OptionName"
				Dynamic4.DataBind()
				If Not Page.IsPostBack Then
					Dynamic4.Items(0).Selected = True
				Else
					SelectedList = Dynamic4List.Value
					For i = 0 to Dynamic4.Items.Count - 1
						compareString = "," & CStr(Dynamic4.Items(i).Value) & ","
                        If SelectedList.IndexOf(compareString) <> -1 Then
                            Dynamic4.Items(i).Selected = True
                        End If
					Next
				End If
			End If

			If getDynamic.Rows.Count >= 5 Then
				UDDOption5 = getData.UDDOption(getDynamic.Rows(4)("UDDID"),objCnn)
				Dim Option5Value As DataTable = New DataTable("OptionData")
				Option5Value.Columns.Add("OptionName")
				Option5Value.Columns.Add("OptionID", GetType(Integer))
				Dim myrow As DataRow = Option5Value.NewRow()
				myrow("OptionName") = defaultTextTable.Rows(102)("TextParamValue")
				myrow("OptionID") = 0
				Option5Value.Rows.Add(myrow)
				For i = 0 To UDDOption5.Rows.Count - 1
					myrow = Option5Value.NewRow()
					myrow("OptionName") = UDDOption5.Rows(i)("OptionName")
					myrow("OptionID") = UDDOption5.Rows(i)("OptionID")
					Option5Value.Rows.Add(myrow)
				Next
				Dynamic5.DataSource = Option5Value
				Dynamic5.DataValueField = "OptionID"
				Dynamic5.DataTextField = "OptionName"
				Dynamic5.DataBind()
				If Not Page.IsPostBack Then
					Dynamic5.Items(0).Selected = True
				Else
					SelectedList = Dynamic5List.Value
					For i = 0 to Dynamic5.Items.Count - 1
						compareString = "," & CStr(Dynamic5.Items(i).Value) & ","
                        If SelectedList.IndexOf(compareString) <> -1 Then
                            Dynamic5.Items(i).Selected = True
                        End If
					Next
				End If
			End If

			If getDynamic.Rows.Count >= 6 Then
				UDDOption6 = getData.UDDOption(getDynamic.Rows(5)("UDDID"),objCnn)
				Dim Option6Value As DataTable = New DataTable("OptionData")
				Option6Value.Columns.Add("OptionName")
				Option6Value.Columns.Add("OptionID", GetType(Integer))
				Dim myrow As DataRow = Option6Value.NewRow()
				myrow("OptionName") = defaultTextTable.Rows(102)("TextParamValue")
				myrow("OptionID") = 0
				Option6Value.Rows.Add(myrow)
				For i = 0 To UDDOption6.Rows.Count - 1
					myrow = Option6Value.NewRow()
					myrow("OptionName") = UDDOption6.Rows(i)("OptionName")
					myrow("OptionID") = UDDOption6.Rows(i)("OptionID")
					Option6Value.Rows.Add(myrow)
				Next
				Dynamic6.DataSource = Option6Value
				Dynamic6.DataValueField = "OptionID"
				Dynamic6.DataTextField = "OptionName"
				Dynamic6.DataBind()
				If Not Page.IsPostBack Then
					Dynamic6.Items(0).Selected = True
				Else
					SelectedList = Dynamic6List.Value
					For i = 0 to Dynamic6.Items.Count - 1
						compareString = "," & CStr(Dynamic6.Items(i).Value) & ","
                        If SelectedList.IndexOf(compareString) <> -1 Then
                            Dynamic6.Items(i).Selected = True
                        End If
					Next
				End If
			End If


	End If
	
	getDynamic = PromiseCRM.SelUDDForDynamic(StaffID,2,objCnn)
	If getDynamic.Rows.Count = 0 Then
		DynamicNumeric.Visible = False
	Else
		DynamicNumeric.Visible = True
		Select Case getDynamic.Rows.Count
			Case 1
				DynamicNumericText1.InnerHtml = getDynamic.Rows(0)("UDDName")
				DisplayN1.Visible = True
				DisplayN2.Visible = False
				DisplayN3.Visible = False
				DisplayN4.Visible = False
			Case 2
				DynamicNumericText1.InnerHtml = getDynamic.Rows(0)("UDDName")
				DynamicNumericText2.InnerHtml = getDynamic.Rows(1)("UDDName")
				DisplayN1.Visible = True
				DisplayN2.Visible = True
				DisplayN3.Visible = False
				DisplayN4.Visible = False
			Case 3
				DynamicNumericText1.InnerHtml = getDynamic.Rows(0)("UDDName")
				DynamicNumericText2.InnerHtml = getDynamic.Rows(1)("UDDName")
				DynamicNumericText3.InnerHtml = getDynamic.Rows(2)("UDDName")
				DisplayN1.Visible = True
				DisplayN2.Visible = True
				DisplayN3.Visible = True
				DisplayN4.Visible = False
			Case 4
				DynamicNumericText1.InnerHtml = getDynamic.Rows(0)("UDDName")
				DynamicNumericText2.InnerHtml = getDynamic.Rows(1)("UDDName")
				DynamicNumericText3.InnerHtml = getDynamic.Rows(2)("UDDName")
				DynamicNumericText4.InnerHtml = getDynamic.Rows(3)("UDDName")
				DisplayN1.Visible = True
				DisplayN2.Visible = True
				DisplayN3.Visible = True
				DisplayN4.Visible = True
		End Select
	End If
	
	getDynamic = PromiseCRM.SelUDDForDynamic(StaffID,3,objCnn)
	If getDynamic.Rows.Count = 0 Then
		DynamicDate.Visible = False
	Else
		DynamicDate.Visible = True
		Select Case getDynamic.Rows.Count
			Case 1
				DynamicDateText1.InnerHtml = getDynamic.Rows(0)("UDDName")
				ShowDate1.Visible = True
				ShowDate2.Visible = False
				ShowDate3.Visible = False
				ShowDate4.Visible = False
			Case 2
				DynamicDateText1.InnerHtml = getDynamic.Rows(0)("UDDName")
				DynamicDateText2.InnerHtml = getDynamic.Rows(1)("UDDName")
				ShowDate1.Visible = True
				ShowDate2.Visible = True
				ShowDate3.Visible = False
				ShowDate4.Visible = False
			Case 3
				DynamicDateText1.InnerHtml = getDynamic.Rows(0)("UDDName")
				DynamicDateText2.InnerHtml = getDynamic.Rows(1)("UDDName")
				DynamicDateText3.InnerHtml = getDynamic.Rows(2)("UDDName")
				ShowDate1.Visible = True
				ShowDate2.Visible = True
				ShowDate3.Visible = True
				ShowDate4.Visible = False
			Case 4
				DynamicDateText1.InnerHtml = getDynamic.Rows(0)("UDDName")
				DynamicDateText2.InnerHtml = getDynamic.Rows(1)("UDDName")
				DynamicDateText3.InnerHtml = getDynamic.Rows(2)("UDDName")
				DynamicDateText4.InnerHtml = getDynamic.Rows(3)("UDDName")
				ShowDate1.Visible = True
				ShowDate2.Visible = True
				ShowDate3.Visible = True
				ShowDate4.Visible = True
		End Select
	End If
End Function

Sub MoveRightSMS(Source As Object, E As EventArgs)
	Dim i As Integer
	Dim ListString,ListString1 As String
	Dim RemoveItem() As Integer
	Dim counter As Integer = 0
	For i = 0 to ColListSMS.Items.Count - 1
		If ColListSMS.Items(i).Selected = True
			SelColListSMS.Items.Add(New ListItem(ColListSMS.Items(i).Text, ColListSMS.Items(i).Value))
			Redim Preserve RemoveItem(counter)
			RemoveItem(counter) = i
			counter += 1
		End If
	Next
	Dim IndexDel As Integer
	If counter > 0 Then
		For i = 0 to RemoveItem.Length - 1
			IndexDel = RemoveItem(i) - i
			ColListSMS.Items.RemoveAt(IndexDel)
		Next
	End If

End Sub

Sub MoveLeftSMS(Source As Object, E As EventArgs)
	Dim i As Integer
	Dim ListString As String
	Dim RemoveItem() As Integer
	Dim counter As Integer = 0
	For i = 0 to SelColListSMS.Items.Count - 1
		If SelColListSMS.Items(i).Selected = True
			ColListSMS.Items.Add(New ListItem(SelColListSMS.Items(i).Text, SelColListSMS.Items(i).Value))
			Redim Preserve RemoveItem(counter)
			RemoveItem(counter) = i
			counter += 1
		End If
	Next
	Dim IndexDel As Integer
	If counter > 0 Then
		For i = 0 to RemoveItem.Length - 1
			IndexDel = RemoveItem(i) - i
			SelColListSMS.Items.RemoveAt(IndexDel)
		Next
	End If
End Sub

Public Function UDDDataBoundSMS(ByVal objCnn As MySqlConnection) As Boolean
	Dim dtTable As DataTable = new DataTable("ParentTable")
	Dim myDataColumn3 As DataColumn 
	Dim myDataRow1 As DataRow

	myDataColumn3 = New DataColumn()
	myDataColumn3.DataType = System.Type.GetType("System.Int32")
	myDataColumn3.ColumnName = "UDDID"
	myDataColumn3.ReadOnly = True
	myDataColumn3.Unique = True
	dtTable.Columns.Add(myDataColumn3)
	
	myDataColumn3 = New DataColumn()
	myDataColumn3.DataType = System.Type.GetType("System.String")
	myDataColumn3.ColumnName = "ColumnName"
	dtTable.Columns.Add(myDataColumn3)

	myDataRow1 = dtTable.NewRow()
	myDataRow1("UDDID") = -100
	myDataRow1("ColumnName") = "First Name"
	dtTable.Rows.Add(myDataRow1)
	
	myDataRow1 = dtTable.NewRow()
	myDataRow1("UDDID") = -99
	myDataRow1("ColumnName") = "Last Name"
	dtTable.Rows.Add(myDataRow1)
	
	myDataRow1 = dtTable.NewRow()
	myDataRow1("UDDID") = -98
	myDataRow1("ColumnName") = "Birthday"
	dtTable.Rows.Add(myDataRow1)
	
	myDataRow1 = dtTable.NewRow()
	myDataRow1("UDDID") = -97
	myDataRow1("ColumnName") = "Expiration"
	dtTable.Rows.Add(myDataRow1)
	
	myDataRow1 = dtTable.NewRow()
	myDataRow1("UDDID") = -96
	myDataRow1("ColumnName") = "Note"
	dtTable.Rows.Add(myDataRow1)
	
	Dim DynamicUDD As DataTable = PromiseCRM.UDDForDynamicAll(0, objCnn)
	Dim ii As Integer
	For ii = 0 to DynamicUDD.Rows.Count - 1
	   myDataRow1 = dtTable.NewRow()
	   myDataRow1("UDDID") = DynamicUDD.Rows(ii)("UDDID")
	   myDataRow1("ColumnName") = DynamicUDD.Rows(ii)("UDDName")
	   dtTable.Rows.Add(myDataRow1)
	Next ii

	ColListSMS.DataSource = dtTable
	ColListSMS.DataValueField = "UDDID"
	ColListSMS.DataTextField = "ColumnName"
	ColListSMS.DataBind()
	
End Function

Sub DoExportSMS(Source As Object, E As EventArgs)

	Dim dsSet As DataSet
	Dim xmlResult,fileName As String
	
	Dim FoundError AS Boolean = False
	
	ValidateEventName.Visible = False
	ValidateScheduleDate.Visible = False
	ValidateScheduleDateValue.Visible = False
	ValidateScheduleDateDiff.Visible = False
	CouponError.InnerHtml = ""
	
	If Len(Trim(EventName.Text)) = 0 Then
		ValidateEventName.Visible = True
		FoundError = True
	End If
	
	Dim ScheduleDateCheck As String
	
	
	ScheduleDateCheck = DateTimeUtil.FormatDate(Request.Form("SendDate_Day"),Request.Form("SendDate_Month"),Request.Form("SendDate_Year"))
	
	If RadioSendDate2.Checked = True Then
		If Trim(ScheduleDateCheck) = "InvalidDate" Or Trim(ScheduleDateCheck) = "" Then
			ValidateScheduleDate.Visible = True
			FoundError = True
		Else
			Dim DateCheck As new Date(Request.Form("SendDate_Year"),Request.Form("SendDate_Month"),Request.Form("SendDate_Day"))
			Dim DateDiffCheck As Integer = DateDiff("d",Now,DateCheck)
			If DateDiffCheck < 0 Then
				ValidateScheduleDateDiff.Visible = True
				FoundError = True
			End If
		End If
	End If
	
	If RadioSendDate3.Checked = True Then
		If Not IsNumeric(ScheduleDateValue.Text) Then
			ValidateScheduleDateValue.Visible = True
			FoundError = True
		Else
			If ScheduleDateValue.Text < 0 Then
				ValidateScheduleDateValue.Visible = True
				FoundError = True
			End If
		End If
	End If
	
	
	Dim StartNumberCouponValue As Integer
	Dim i,j As Integer
	Dim CouponLink As String
	Dim CouponList() As String
	Dim ExitLoop As Boolean = False
	Dim ChkS As String = "LoopData:" + CouponType.SelectedItem.Value
	Dim CouponReuse As Integer = -1
	Dim CouponRange As DataTable
	Dim CouponData As DataTable
	If CouponType.SelectedItem.Value > 0 Then
		CouponData = PromiseCRM.GetCouponInfo(CouponType.SelectedItem.Value,objCnn)
		If CouponData.Rows.Count > 0 Then
			CouponReuse = CouponData.Rows(0)("ReuseCoupon")
			Dim CouponHeader As String = CouponData.Rows(0)("VoucherHeader")
			Dim maxNum As Integer
			If CouponData.Rows(0)("ReuseCoupon") = 0 Then
				
				Try
					StartNumberCouponValue = CInt(StartNumberCoupon.Text)
				Catch ex As Exception
					FoundError = True
					CouponError.InnerHtml = "Please input start coupon # and coupon # must be integer"
				End Try

				If CouponError.InnerHtml = "" Then
				
					ChkS += "Inloop<br>"
					CouponLink = "<a href=""JavaScript: newWindow = window.open( '../Promotions/promotion_voucher.aspx?type=" + CouponData.Rows(0)("TypeID").ToString + "', '', 'width=950,height=700,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1' ); newWindow.focus()"">" & "Click Here" & "</a>"
			
					Dim UsedCouponIDList As String = PromiseCRM.GetUsedCoupon(CouponType.SelectedItem.Value,objCnn)
					UsedCouponIDList = "," + UsedCouponIDList + ","
					CouponRange = PromiseCRM.GetCouponRange(CouponType.SelectedItem.Value,objCnn)
					Dim CouponCount As Integer = 0

					Dim StartCoupon As Integer
					If CouponRange.Rows.Count > 0 Then
						For i = 0 To CouponRange.Rows.Count - 1
							If StartNumberCouponValue >= CouponRange.Rows(i)("StartNo") Then
								StartCoupon = StartNumberCouponValue
							Else
								StartCoupon = CouponRange.Rows(i)("StartNo")
							End If
							For j = StartCoupon To CouponRange.Rows(i)("EndNo")
								If UsedCouponIDList.IndexOf("," + j.ToString + ",") = -1 Then
									maxNum = j + 1000000
									Redim Preserve CouponList(CouponCount)
									CouponList(CouponCount) = CouponHeader + "/" + Right(maxNum.ToString, 6)
									CouponCount += 1
									If CouponCount = CInt(MemberMobileRecord.Value) Then
										ExitLoop = True
										Exit For
									End If
								End If
							Next
							If ExitLoop = True Then Exit For
						Next
						If ExitLoop = False Then
							FoundError = True
							CouponError.InnerHtml = "Not enough coupons. Please " + CouponLink + " to add more coupons"
						End IF
					Else
						FoundError = True
						CouponError.InnerHtml = "No coupons. Please " + CouponLink + " to add coupons"
					End If
				End If
			Else
				CouponRange = PromiseCRM.GetCouponRange(CouponType.SelectedItem.Value,objCnn)
				If CouponRange.Rows.Count > 0 Then
					Redim Preserve CouponList(0)
					maxNum = CouponRange.Rows(0)("StartNo") + 1000000
					CouponList(0) = CouponHeader + "/" + Right(maxNum.ToString, 6)
				Else
					FoundError = True
					CouponError.InnerHtml = "No coupons. Please " + CouponLink + " to add coupons"
				End If
			End If
		Else
			FoundError = True
			CouponError.InnerHtml = "No data found"
		End If
	End If	
	If FoundError = False Then
	
		fileName = "SMSData_" + Trim(Replace(EventName.Text," ","")) + "-" + DateTime.Now.ToString("yyyy-MM-dd") + ".xml"
		
		dsSet = PromiseCRM.SMSXMLData(EventName.Text,EventType,RadioSendDate1,RadioSendDate2,RadioSendDate3,DateColumn,Request.Form("SendDate_Year"),Request.Form("SendDate_Month"),Request.Form("SendDate_Day"),BeforeAfter,ScheduleDateValue.Text,SelColListSMS,CouponType,CouponReuse,CouponList,MemberMobileIDList.Value,objCnn)

		xmlResult = dsSet.GetXml()
		Response.Clear()
		Response.ContentType = "application/xml"
		Response.AddHeader("Content-Disposition", "attachment; filename=""" & filename & """")
		Response.Charset = "windows-874"
		Response.ContentEncoding = System.Text.Encoding.GetEncoding(874)
		Response.Flush()
		Response.Write("<?xml version=""1.0"" encoding=""windows-874""?>" & chr(13) & chr(10) & xmlResult)
		Response.End()
	End If
End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
