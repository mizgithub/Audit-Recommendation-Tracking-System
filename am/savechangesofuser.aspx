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
 <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   string fname = Request["fname"];
   string lname = Request["lname"];
   string role = Request["role"];
   string pass = Request["pass"];
   int idno = int.Parse(Request["idno"]);

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
   catch (Exception ex)
   {

   }
   try
   {
       con.Open();
            new SqlCommand("update user_Table set fname=N'"+fname +"',lname=N'" + lname + "',role=N'" + role + "',password='" + hashpass + "' where idno="+idno, con).ExecuteNonQuery();
            con.Close();
            
   }
   catch (Exception ex) {
       con.Close();
   }
 %>
</body>
</html>
