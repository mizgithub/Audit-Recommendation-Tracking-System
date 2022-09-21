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
   string recom = Request["recom"];
   int status = int.Parse(Request["status"]);
   int auditId = int.Parse(Request.Cookies["auditId"].Value);
   string extent = Request["ext"];
   int findingId = int.Parse(Request["findingId"]);
   double potSaving=0;
   string statusstring="";
   try
   {
       potSaving = double.Parse(Request["potSaving"]);
   }
   catch (Exception ex)
   {

   }
   if(status==1){
   statusstring="Not implemented";
   }
   else if(status==2){
   statusstring="Partailly implemented";
   }
   else{
       statusstring="Fully implemented";
   }

   string newvalue = "<u>Recommendation</u>:<br>" + recom + "<br>Potential saving: " + Request["potSaving"] + "ETB.<br>Status:" + statusstring;
   
   try
   {
       string userfname = "";
       string userlname = "";
       con.Open();
       SqlDataReader userreader = new SqlCommand("select fname,lname from user_Table where username='" + Request.Cookies["user"].Value + "'", con).ExecuteReader();
       while (userreader.Read()) {
           userfname = userreader["fname"].ToString();
           userlname = userreader["lname"].ToString();
       }
       con.Close();
       con.Open();
       int recomId = (int)new SqlCommand("insert into recommendation_Table OUTPUT INSERTED.recomId values(" + auditId + "," + findingId + ",N'" + recom + "'," + potSaving + "," + status + ",'" + DateTime.Now.ToString("yyyy-MM-dd") + "',N'"+extent+"')", con).ExecuteScalar();
       con.Close();
       
       double actvalue = 0;
       double netactvalue = 0;
       double totpotsavving = 0;


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
       new SqlCommand("insert into activitylog_Table values('Recommendation inserted',N'" + userfname + "',N'" + userlname + "',N'" + newvalue + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "')", con).ExecuteNonQuery();
       con.Close(); 
       Response.Write("SUCCESS");
   }
   catch (Exception ex) {
       Response.Write(ex.Message);
       con.Close();
   }
 %>
</body>
</html>
