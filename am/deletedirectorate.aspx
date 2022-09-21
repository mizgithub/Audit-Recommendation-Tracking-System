<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
<%
     if (Request.Cookies["user"].Value == null || Request.Cookies["user"].Value == "")
     {
         Response.Redirect("login.aspx");
    } 
     
     
      %>
    <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   
   try
   {
       con.Open();
       new SqlCommand("delete from directorate_Table where dirId=" + int.Parse(Request["dirId"]), con).ExecuteNonQuery();
       con.Close();
       con.Open();
       new SqlCommand("delete from ministry_Table where minId=" + int.Parse(Request["dirId"]), con).ExecuteNonQuery();
       con.Close();
   }
   catch (Exception ex) {
       con.Close();
   }
 %>
</body>
</html>
