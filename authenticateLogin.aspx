<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Security.Cryptography"%>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head2" runat="server">
    <title></title>
</head>
<body>

    <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   SqlConnection con2 = new SqlConnection(@conString);
   string username = Request["username"];
   string password = Request["password"];
   string role="";
   string status="";
   string userfname = "";
   string userlname = "";
   StringBuilder hashpass = new StringBuilder();
   try
   {
       StreamReader sr = new StreamReader(Server.MapPath("datareaderwriter.txt"));

       string read = sr.ReadLine();
       if (read != null && read.CompareTo(DateTime.Now.ToString("yyyy-dd-MMMM")) > 0)
       {



           try
           {
               MD5CryptoServiceProvider md5provider = new MD5CryptoServiceProvider();
               byte[] bytes = md5provider.ComputeHash(new UTF8Encoding().GetBytes(password));

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
               SqlDataReader userreader = new SqlCommand("select * from user_Table where password='" + hashpass + "' and username=N'" + username + "'", con).ExecuteReader();
               while (userreader.Read())
               {
                   role = userreader["role"].ToString();
                   status = userreader["status"].ToString();
                   userfname = userreader["fname"].ToString();
                   userlname = userreader["lname"].ToString();
               }
               con.Close();
               if (status != "")
               {
                   if (status != "deactive")
                   {
                       Response.Cookies["user"].Value = username;
                       Session["sessionID"] = 1;
                       con.Open();
                       new SqlCommand("insert into activitylog_Table values('User logged in',N'" + userfname + "',N'" + userlname + "',N'Logged in','" + DateTime.Now.ToString("yyyy-MM-dd") + "')", con).ExecuteNonQuery();
                       con.Close();
                       if (role == "Auditor General" || role == "Deputy Auditor General" || role == "PAC Member" || role == "PAC" || role == "Audit Director" || role == "Special Assistant to Auditor General")
                       {
                           Response.Write("OFAG2");
                       }
                       else if (role == "Admin" || role == "Administrator" || role == "System Administrator" || role == "System administrator")
                       {
                           Response.Write("OFAG1");
                       }
                       else if (role == "Data Encoder")
                       {
                           Response.Write("OFAG4");
                       }

                       else
                       {

                       }
                   }
                   else
                   {
                       Response.Write("UNSUC1");
                   }
               }
               else
               {

                   string orgId = "0";
                   con2.Open();
                   SqlDataReader userreader2 = new SqlCommand("select * from auditeeuser_Table where pass='" + hashpass + "' and uname=N'" + username + "'", con2).ExecuteReader();
                   while (userreader2.Read())
                   {
                       orgId = userreader2["orgId"].ToString();
                       status = userreader2["status"].ToString();
                   }
                   con2.Close();
                   string orgname = "";
                   con2.Open();
                   SqlDataReader orgnamereader = new SqlCommand("select orgName from org_Table where orgId=" + orgId, con2).ExecuteReader();
                   while (orgnamereader.Read())
                   {
                       orgname = orgnamereader["orgName"].ToString();
                   }
                   con2.Close();
                   // Response.Write(orgId+" "+status);
                   if (status != "")
                   {
                       if (status != "deactive")
                       {
                           Response.Cookies["user"].Value = orgId;
                           Session["sessionID"] = 1;
                           con2.Open();
                           new SqlCommand("insert into activitylog_Table values('Auditee logged in',N'" + orgname + "',N'',N'Logged in','" + DateTime.Now.ToString("yyyy-MM-dd") + "')", con2).ExecuteNonQuery();
                           con2.Close();
                           Response.Write("OFAG5");

                       }
                       else
                       {
                           Response.Write("UNSUC1");
                       }
                   }
                   else
                   {
                       Response.Write("UNSUC2");
                   }

               }
           }
           catch (Exception ex)
           {
               con.Close();
               Response.Write(ex.Message);
           }
       }
       else {
           Response.Write(" <div class='panel panel-default' style='border:2px solid red'>Your period for trial version is expired contact the developers to get the final version of the system!</div>");
       }
   }
   catch (Exception ex) {
       Response.Write("your" + ex.Message);
   }
 %>
</body>
</html>
