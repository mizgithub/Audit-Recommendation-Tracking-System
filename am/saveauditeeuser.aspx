<%@ Page Language="C#" AutoEventWireup="true"  %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Security.Cryptography"%>
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
   int selauditee = 0;
   try
   {
       selauditee = int.Parse(Request["selauditee"]);
   }
   catch (Exception ex) { 
   
   }
   string role = "Auditee";
   string uname = Request["uname"];
   string pass = Request["pass"];
   StringBuilder hashpass = new StringBuilder();
   
   try
   {
       MD5CryptoServiceProvider md5provider = new MD5CryptoServiceProvider();
       byte[] bytes = md5provider.ComputeHash(new UTF8Encoding().GetBytes(pass));

       for (int i = 0; i < bytes.Length; i++)
       {
           hashpass.Append(bytes[i].ToString("x2"));
       }
   }
   catch (Exception ex) { 
       
   }
   
   try
   {
        con.Open();
        int res = (int)new SqlCommand("select count(*) from auditeeuser_Table where orgId=" + selauditee+" or uname='"+uname+"'", con).ExecuteScalar();
        con.Close();
        if (res == 0)
        {
            con.Open();
            new SqlCommand("insert into auditeeuser_Table values(" + selauditee + ",'" + uname + "',N'" + hashpass + "','active','" + DateTime.Now.ToString("yyyy/MM/dd") + "')", con).ExecuteNonQuery();
            con.Close();
            Response.Write("<b style='color:blue'>User Successfully Registered+hash:"+hashpass+"</b>");
        }
        else
        {
            Response.Write("THETRICKBECAUSEOFASPX");
        }
          
       
   }
   catch (Exception ex) {
       con.Close();
   }
 %>
</body>
</html>
