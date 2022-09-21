<%@ Page Language="C#" AutoEventWireup="true"  %>
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
   string fname = Request["fname"];
   string lname = Request["lname"];
   string dir = Request["dir"];
   string rank = Request["rank"];
   try
   {   
       con.Open();
       new SqlCommand("update auditor_Table set fname=N'" + fname + "', lname=N'" + lname + "',rank=N'" + rank + "',directorate=N'" + dir + "' where idno="+int.Parse(Request["idno"]), con).ExecuteNonQuery();
       con.Close();
       Response.Write("SUCCESS");
   }
   catch (Exception ex) {
       con.Close();
   }
 %>
</body>
</html>