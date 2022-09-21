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
         Response.Redirect("../login.aspx");
    } 
     
     
      %>
    <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   string actiontaken = Request["actiontaken"];
   string actiondate=Request["actiondate"];
   int actiontakenId = int.Parse(Request["actiontakenId"]);
   
   try
   {
       con.Open();
       new SqlCommand("update actiontaken_Table set actiontaken=N'" + actiontaken + "',actiondate='" + actiondate + "' where actiontakenId=" +actiontakenId, con).ExecuteNonQuery();
       con.Close();
       Response.Write("SUCCESS");
   }
   catch (Exception ex) {
       Response.Write(ex.Message);
       con.Close();
   }
 %>
</body>
</html>
