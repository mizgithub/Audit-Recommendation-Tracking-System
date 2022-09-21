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
   string nextstep = Request["nextstep"];
   string fname = Request["fname"];
   string lname = Request["lname"];
   string action = Request["action"];
   try
   {
       con.Open();
       new SqlCommand("update audit_Table set followupdate='"+Request["date"]+"' where auditId=" + int.Parse(Request.Cookies["auditId"].Value), con).ExecuteNonQuery();
       con.Close();
     
       con.Open();
       int res = (int)new SqlCommand("select count(*) from auditorNextStep_Table where auditId=" + int.Parse(Request.Cookies["auditId"].Value), con).ExecuteScalar();
       con.Close();
       if (res == 0)
       {
           con.Open();
           new SqlCommand("insert into auditorNextStep_Table values(" + int.Parse(Request.Cookies["auditId"].Value) + ",N'" + nextstep + "',N'" + fname + "',N'" + lname + "',N'" + action + "')", con).ExecuteNonQuery();
           con.Close();
       }
       else {
           con.Open();
           new SqlCommand("update auditorNextStep_Table set nextstep=N'" + nextstep + "',audfname=N'" + fname + "',audlname=N'" + lname + "',actiontaken=N'" + action + "' where auditId="+int.Parse(Request.Cookies["auditId"].Value), con).ExecuteNonQuery();
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
