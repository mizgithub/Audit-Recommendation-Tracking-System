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
         Response.Redirect("login.aspx");
    } 
     
     
      %>
    <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   string finding = Request["finding"];
   string source = Request["source"];
   string pref = Request["pref"];
   string audresp = Request["audresp"];
   string respdate = Request["respdate"];
   string respfname = Request["respfname"];
   string resplname = Request["resplname"];
   int findingType = 0;
   double actValue = 0;
   double extValue = 0;
   try
   {
       findingType = int.Parse(Request["findingType"]);
       actValue = double.Parse(Request["actValue"]);
       extValue = double.Parse(Request["extValue"]);
   }
   catch (Exception) { 
   
   }

   string newvalue = "Finding:" + finding + "<br>" + "Actual Financial Value:<b>" + actValue + "ETB.</b><br>Extrapolated financial value:<b>" + extValue + "ETB.</b><br>";
   try
   {
       con.Open();
       SqlDataReader typereader = new SqlCommand("select findingType from findingType_Table where typeId=" + findingType,con).ExecuteReader();
       while (typereader.Read()) {
           newvalue += "findignType: " + typereader["findingType"];
       }
       con.Close();
       con.Open();
       SqlDataReader userreader = new SqlCommand("select fname,lname from user_Table where username='" + Request.Cookies["user"].Value + "'", con).ExecuteReader();
       string userfname = "";
       string userlname = "";
       while (userreader.Read())
       {
           userfname = userreader["fname"].ToString();
           userlname=userreader["lname"].ToString();
       }
       con.Close();
      
       con.Open();
       int findingId = (int)new SqlCommand("insert into finding_Table OUTPUT INSERTED.findingId values(" + int.Parse(Request.Cookies["auditId"].Value) + ",N'" + finding + "'," + findingType + "," + actValue + "," + extValue + ",N'" + source + "',N'"+pref+"',N'"+audresp+"','"+respdate+"',"+actValue+",N'"+respfname+"',N'"+resplname+"')", con).ExecuteScalar();
        con.Close();
        con.Open();
        new SqlCommand("insert into activitylog_Table values('Finding inserted',N'"+userfname+"',N'"+userlname+"',N'"+newvalue + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "')", con).ExecuteNonQuery();
        con.Close();
       Response.Write("SUCCESS");
   }
   catch (Exception ex) {
       con.Close();
   }
 %>
</body>
</html>
