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
   
  
   string pass = Request["pass"];
   int orgId = int.Parse(Request["orgId"]);
   string uname = Request["uname"];

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
            new SqlCommand("update auditeeuser_Table set orgId="+orgId+",pass=N'" + hashpass + "' where uname=N'"+uname+"'", con).ExecuteNonQuery();
            con.Close();
            Response.Write(orgId + " " + pass);
            
   }
   catch (Exception ex) {
       con.Close();
       Response.Write(ex.Message+" "+orgId+" "+pass);
   }
 %>
</body>
</html>
