﻿<%@ page language="C#" autoeventwireup="true" inherits="Inventory_UploadStockFile, App_Web_uploadstockfile.aspx.9758fd70" enableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Upload Stock File</title>
    <link rel="SHORTCUT ICON" href="~/Images/icon/houses.ico" />
    <link href="../css/General.css" rel="stylesheet" type="text/css" />
     <style type="text/css">
          thead, th
          {
              height:30px;
          }
          .item td
          {
              padding:4px !important;
              font-size:1.2em;
          }
          .number
          {
              text-align:right;
          }
         .lage-text
         {
             font-size:2em;
             font-weight:bold;
         }
          .file-upload
          {
              font-size:1.2em;
          }
          .large-button
          {
              font-size:1.2em;
              height:30px;
          }
          #wrapper
          {
              height:450px;
              overflow:auto;
          }
         .auto-style1 {
             width: 538px;
         }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <table class="paramlist admintable" cellspacing="1" style="width:100%;">
        <tr>
            <td class="paramlist_key" style="text-align:right;">
                <h3>Select File</h3>
            </td>
            <td class="auto-style1">
                <asp:FileUpload ID="FileUpload1" runat="server" class="file-upload"/>
                <asp:Button ID="BtnUpload" runat="server"
                    Text="OK" Width="70" onclick="Button1_Click"/>
                <br />
                <asp:Label ID="Uploaded" runat="server" style="font-size:1.2em;" Visible="false" Text="Uploaded file name: "></asp:Label>
                <asp:Label ID="FileName" runat="server" style="font-weight:bold;font-size:1.2em;"></asp:Label>
            </td>
            <td align="right">
                <asp:Button ID="ButtonConfirm" runat="server" Text="Save And Close" 
                    class="large-button" Enabled="false" onclick="ButtonConfirm_Click" />    
            </td>
        </tr>
     </table>
    </div>
    <div>
        <table class="adminlist" cellpadding="1" style="width:100%;">
            <thead>
            <tr>
                <th style="width:5%;">
                    #
                </th>
                <th style="width:30%;">
                   Product Bar Code
                </th>
                <th style="width:45%;">
                   Product Name
                </th>
                <th style="width:10%;">
                    Balance
                </th>
                <th style="width:10%;">
                    File
                </th>
            </tr>
            </thead>
        </table>
    </div>
    <div id="wrapper">
        <table class="adminlist" cellspacing="1" style="width: 100%;">
            <tbody class="item">
                <asp:Literal ID="Literal1" runat="server"></asp:Literal>
            </tbody>
        </table>
    </div>
    <div>
         <table class="adminlist" cellspacing="1" style="width: 100%;">
            <thead>
            <tr>
                <th style="width:5%;">
                   
                </th>
                <th style="width:30%;">
                  
                </th>
                <th style="width:45%; text-align:right">
                  <asp:Label ID="Summary" runat="server" Text="Summary"></asp:Label>
                </th>
                <th style="width:10%; text-align:right">
                   <asp:Label ID="TotalAmount" runat="server"></asp:Label>
                </th>
                <th style="width:10%; text-align:right; padding-right:22px;">
                   <asp:Label ID="TotalFileAmount" runat="server"></asp:Label>
                </th>
            </tr>
            </thead>
        </table>
    </div>
    <div>
        <asp:Label ID="LabelResult" runat="server" Text="" style="font-size:2em; font-weight:bold; margin-left:10px; color:red;"></asp:Label>
    </div>
    </form>
</body>
</html>
