<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   //Mentioned Connection string make sure that user id and password sufficient previlages
  

   //Enter destination directory where backup file stored
   string disk = Request["diskname"].Replace(":", "");
   string destdir = disk+":ARTSbackup\\backupdb" + DateTime.Now.ToString("ddMMyyyy_HHmmss");

   //Check that directory already there otherwise create 
  
   try
   {
       //Open connection
       if (!System.IO.Directory.Exists(destdir))
       {

           System.IO.Directory.CreateDirectory(destdir);

       }

      string filename = destdir + "\\ARTSnew.Bak";
      con.Open();
       //query to take backup database
      new SqlCommand("backup database ARTSnew to disk='" +filename+"'", con).ExecuteNonQuery();
      
       //Close connection
      con.Close();
       Response.Write("<p style='color:blue'>Database backup finished successfully<br>File saved in:<br>"+filename+"</b>");
   }
   catch (Exception ex)
   {
       Response.Write("<p style='color:red'>Error During backup!<br>Check Disk name you entered.</p>"+disk);
   }
 %>
</body>
</html>
