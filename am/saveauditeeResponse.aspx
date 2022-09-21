<%@ Page Language="C#" AutoEventWireup="true" %>
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
   string issueddate = Request["issueddate"];
   string resp = Request["resp"];
   string respdate = Request["respdate"];
   try
   {
       con.Open();
       int res = (int)new SqlCommand("select count(*) from auditeeResponse_Table where auditId=" + int.Parse(Request.Cookies["auditId"].Value), con).ExecuteScalar();
       con.Close();
       if (res == 0)
       {
           con.Open();
           new SqlCommand("insert into auditeeResponse_Table values(" + int.Parse(Request.Cookies["auditId"].Value) + ",N'" + resp + "','" + respdate + "','" + issueddate + "')", con).ExecuteNonQuery();
           con.Close();
       }
       else {
           con.Open();
           new SqlCommand("update auditeeResponse_Table set  issueddate='" + issueddate + "',response=N'" + resp + "',respdate='" + respdate + "' where auditId=" + int.Parse(Request.Cookies["auditId"].Value), con).ExecuteNonQuery();
           con.Close(); 
       }
       Response.Write("SUCCESS");
   }
   catch (Exception ex) {
       con.Close();
   }
 %>
</body>
</html>
