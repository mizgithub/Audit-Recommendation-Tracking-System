<%@ Page Language="C#" AutoEventWireup="true"%>
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
   SqlConnection con2 = new SqlConnection(@conString);
   int recomId = int.Parse(Request["recomId"]);
   string newvalue = "Deleted";
   try
   {
       string userfname = "";
       string userlname = "";
       con.Open();
       SqlDataReader userreader = new SqlCommand("select fname,lname from user_Table where username='" + Request.Cookies["user"].Value + "'", con).ExecuteReader();
       while (userreader.Read())
       {
           userfname = userreader["fname"].ToString();
           userlname=userreader["lname"].ToString();
       }
       con.Close();
       
       //deleting recommendation for this audit
      
      
      
           con2.Open();
           SqlDataReader roldreader = new SqlCommand("select newvalue from recomhistory_Table where recomId=" +recomId, con2).ExecuteReader();
           string roldvalue = "";
           while (roldreader.Read())
           {
               roldvalue = roldreader["newvalue"].ToString();
           }
           con2.Close();
           con2.Open();
           new SqlCommand("delete from recommendation_Table where recomId=" + recomId, con2).ExecuteNonQuery();
           con2.Close();
           con.Open();
           new SqlCommand("insert into activitylog_Table values('Recommendation deleted',N'" + userfname + "',N'" + userlname + "',N'" + newvalue + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "')", con).ExecuteNonQuery();
           con.Close(); 
           double actvalue = 0;
           double netactvalue = 0;
           double totpotsavving = 0;
           int findingId = 0;
           con.Open();
           SqlDataReader rreader = new SqlCommand("select findingId from recommendation_Table where recomId=" + int.Parse(Request["recomId"]), con).ExecuteReader();
           while (rreader.Read())
           {
               findingId = (int)rreader["findingId"];
           }
           con.Close();
           con.Open();
           SqlDataReader actreader = new SqlCommand("select actualValue from finding_Table where findingId=" + findingId, con).ExecuteReader();
           while (actreader.Read())
           {
               actvalue = double.Parse(actreader["actualValue"].ToString());
           }
           con.Close();
           con.Open();
           SqlDataReader potsavreader = new SqlCommand("select potSaving from recommendation_Table where findingId=" + findingId, con).ExecuteReader();
           while (potsavreader.Read())
           {
               totpotsavving += double.Parse(potsavreader["potSaving"].ToString());
           }
           con.Close();
           netactvalue = actvalue - totpotsavving;
           con.Open();
           new SqlCommand("update finding_Table set netactValue=" + netactvalue + " where findingId=" + findingId,con).ExecuteNonQuery();
           con.Close();
       
       
   }
   catch (Exception ex) {
       con.Close();
   }
 %>
</body>
</html>
