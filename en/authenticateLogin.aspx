<%@ page language="C#" autoeventwireup="true"  %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head2" runat="server">
    <title></title>
</head>
<body>

    <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   string username = Request["username"];
   string password = Request["password"];
   string role="";
   string status="";
   try
   {
       con.Open();
       SqlDataReader userreader = new SqlCommand("select * from user_Table where password='" + password + "' and username='" + username + "'", con).ExecuteReader();
       while (userreader.Read()) {
           role = userreader["role"].ToString();
           status = userreader["status"].ToString();
       }
       con.Close();
       if (status != "")
       {
           if (status != "deactive")
           {
                Response.Cookies["user"].Value = username;
               if (role == "Auditor General")
               {
                   Response.Write("OFAG2");
               }
               else if(role=="Admin"){
                   Response.Write("OFAG1");
               }
               else if (role == "Auditor") {
                   Response.Write("OFAG4");
               }
               else if (role == "PAC")
               {
                   Response.Write("OFAG3");
               }
               else { 
                   
               }
           }
           else
           {
               Response.Write("UNSUC1");
           }
       }
       else {
           Response.Write("UNSUC2");
       }
   }
   catch (Exception ex) {
       con.Close();
   }
 %>
</body>
</html>
