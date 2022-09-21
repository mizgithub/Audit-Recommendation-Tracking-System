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
   int planId = int.Parse(Request["planId"]);
   int auditId = int.Parse(Request.Cookies["auditId"].Value);
   double recvalue = 0.0;
   try
   {
       recvalue = double.Parse(Request["recvalue"]);
   }
   catch (Exception ex) { 
   
   }
   try
   {
       con.Open();
       new SqlCommand("insert into actiontaken_Table values(" + planId + ",N'" + actiontaken + "','" + actiondate + "'," + auditId + ","+recvalue+")", con).ExecuteNonQuery();
       con.Close();
       int userId = 0;
       string user = "";
       try
       {
           userId = int.Parse(Request.Cookies["user"].Value);
       }
       catch (Exception ex)
       {
           user = Request.Cookies["user"].Value;

       }


       if (userId == 0)
       {
           con.Open();
           string fname = "";
           string lname = "";
           SqlDataReader namereader = new SqlCommand("select fname,lname from user_Table where username='" + user + "'", con).ExecuteReader();
           while (namereader.Read())
           {
               fname = namereader["fname"] + "";
               lname = namereader["lname"] + "";
           }
           con.Close();
           con.Open();
           new SqlCommand("insert into activitylog_Table values('Action taken inserted',N'" + fname + "',N'" + lname + "',N'" + actiontaken+ "<br>date:" + actiondate + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "')", con).ExecuteNonQuery();
           con.Close();
       }
       else
       {
           con.Open();
           string fname = "";
           string lname = "";
           SqlDataReader namereader = new SqlCommand("select orgName from org_Table where orgId=" + userId, con).ExecuteReader();
           while (namereader.Read())
           {
               fname = namereader["orgName"] + "";
               lname = "";
           }
           con.Close();
           con.Open();
           new SqlCommand("insert into activitylog_Table values('Action taken inserted',N'" + fname + "',N'" + lname + "',N'" + actiontaken + "<br>date:" + actiondate + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "')", con).ExecuteNonQuery();
           con.Close();
       }
       Response.Write("SUCCESS");
   }
       
   catch (Exception ex) {
       Response.Write(ex.Message);
       con.Close();
   }
 %>
</body>
</html>
