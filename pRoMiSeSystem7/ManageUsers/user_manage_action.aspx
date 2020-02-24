<%@ Page Language="VB" ContentType="text/html" %>
<%@Import Namespace="System.Web.Security" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="MySql.Data.MySqlClient" %>
<%@Import Namespace="POSMySQL.POSControl" %>
<%@Import Namespace="BackOfficeClass.Configuration" %>
<%@Import Namespace="pRoMiSeLanguage" %>
<html>
<head>
<title>Manage User Action</title>
<link href="../StyleSheet/admin.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<div id="Message" class="headerText" runat="server"></div>
<script language="VB" runat="server">

    Dim objCnn As New MySqlConnection()
    Dim getCnn As New CDBUtil()
    Dim Util As New UtilityFunction()
    Dim FormatObject As New FormatClass()
    Dim userInfo As New CStaffs()

    Sub Page_Load()
        If User.Identity.IsAuthenticated Then
            Select Case Request.QueryString("action")
                Case "activate_user"
                    If Session("User_ManageUsers_Activation") Then
                        If IsNumeric(Request.QueryString("StaffID")) And IsNumeric(Request.QueryString("ChangeActivateValue")) Then
                            Dim strSQL, strUpdateDate As String
                            Try
                                objCnn = getCnn.EstablishConnection()
                                strUpdateDate = pRoMiSeUtil.pRoMiSeUtil.FormatDateTimeForMySQL(POSDBSQLFront.POSUtilSQL.GetServerCurrentDateTime(getCnn, objCnn))
                                strSQL = "Update Staffs Set Activated=" + Request.QueryString("ChangeActivateValue") & ", UpdateDate = " & strUpdateDate & _
                                         " Where StaffID=" + Request.QueryString("StaffID")
                                getCnn.sqlExecute(strSQL, objCnn)
                            Catch objError As Exception
                                'display error details
                                Message.InnerHtml = "<b>* Error while accessing database</b>.<br />" _
                                    & objError.Message & "<br />" & objError.Source
                                Exit Sub  ' and stop execution
		
                            End Try
                        End If
                    End If
                    Response.Redirect("user_manage.aspx?" + Request.QueryString.ToString)
                Case "delete_user"
                    If Session("User_ManageUsers_Del") Then
                        If IsNumeric(Request.QueryString("StaffID")) Then
                            Try
                                objCnn = getCnn.EstablishConnection()
                                Dim ResultString As String = ""
                                ResultString = userInfo.DeleteStaffData(Request.QueryString("StaffID"), objCnn)
                            Catch objError As Exception
                                'display error details
                                Message.InnerHtml = "<b>* Error while accessing database</b>.<br />" _
                                    & objError.Message & "<br />" & objError.Source
                                Exit Sub  ' and stop execution
		
                            End Try
                        End If
                    End If
                    Response.Redirect("user_manage.aspx?" + Request.QueryString.ToString)
                Case "activate_smartcard"
                    If Session("Manage_SmartCard") Then
                        If IsNumeric(Request.QueryString("SmartcardID")) And IsNumeric(Request.QueryString("ChangeActivateValue")) And IsNumeric(Request.QueryString("UserType")) Then
                            Try
                                objCnn = getCnn.EstablishConnection()
                                getCnn.sqlExecute("update Smartcard set Activated=" + Request.QueryString("ChangeActivateValue") + " where SmartcardID=" + Request.QueryString("SmartcardID") + " AND UserType=" + Request.QueryString("UserType"), objCnn)
                            Catch objError As Exception
                                'display error details
                                Message.InnerHtml = "<b>* Error while accessing database</b>.<br />" _
                                    & objError.Message & "<br />" & objError.Source
                                Exit Sub  ' and stop execution
		
                            End Try
                        End If
                    End If
                    Response.Redirect("../Preferences/Smartcard.aspx?" + Request.QueryString.ToString)
            End Select
        Else
            Message.InnerHtml = "You are not permit to access this page"
        End If
    End Sub

Sub Page_UnLoad()
	objCnn.Close()
End Sub

</script>
</body>
</html>
