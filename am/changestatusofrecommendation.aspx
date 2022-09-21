<%@ Page Language="C#" AutoEventWireup="true"  %>
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
   string status = Request["status"];
   string ext = Request["ext"];
   double potsaving = 0;
   try
   {
       potsaving = double.Parse(Request["potsav"]);
   }
   catch (Exception ex) { 
   }
   string statusstring = "";
   if (status == "1") {
       statusstring = "Not implemented";
       ext = "0% implemented";
   }
   else if (status == "2")
   {
       statusstring = "Partially implemented";
   }
   else {
       statusstring = "Fully implemented";
       ext = "100% implemented";
   }
   string recomId = Request["recomId"];
   try
   {
       con.Open();
       new SqlCommand("update recommendation_Table set statusExtent=N'"+ext+"',status=" + int.Parse(status) + ",potSaving="+potsaving+" ,lastupdate='"+DateTime.Now.ToString("yyyy-MM-dd")+"' where recomId=" + int.Parse(recomId), con).ExecuteNonQuery();
       con.Close();
       string newvalue = "", oldvalue = "";
       con.Open();
       SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where recomId=" + int.Parse(Request["recomId"]), con).ExecuteReader();
       while (recomreader.Read()) {
         newvalue = "<u>Recommendation</u>:<br>" + recomreader["recomName"] + "<br>Potential saving:"+recomreader["potSaving"]+"<br>Status:" + statusstring + "<br>updated on: " + DateTime.Now.ToString("yyyy-MM-dd");
       }
       con.Close();
       con.Open();
       string fname="";
       string lname = "";
       SqlDataReader userreader = new SqlCommand("select fname,lname from user_Table where username='" + Request.Cookies["user"].Value + "'", con).ExecuteReader();
       while (userreader.Read())
       {
           fname = userreader["fname"].ToString();
           lname = userreader["lname"].ToString();
       }
       con.Close();
       
       con.Open();
       new SqlCommand("insert into activitylog_Table values('Recommendation status updated',N'" + fname + "',N'" + lname + "',N'" + newvalue + "','"+DateTime.Now.ToString("yyyy-MM-dd")+"')", con).ExecuteNonQuery();
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
       Response.Write(ex.StackTrace);
   }
 %>
</body>
</html>
