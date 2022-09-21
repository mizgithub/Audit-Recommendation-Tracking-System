<%@ page language="C#" autoeventwireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
       if (Request["fedministry"] != "" || Request["fedministry"] != null)
       {
           con.Open();
           new SqlCommand("insert into ministry_Table(minName) values(N'" + Request["fedministry"] + "')", con).ExecuteNonQuery();
           con.Close();
          
       }
   }
   catch (Exception ex) {
       con.Close();
   }
 %>
</body>
</html>
