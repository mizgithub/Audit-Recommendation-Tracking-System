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
       int findingId = int.Parse(Request["findingId"]);
       double actValue = 0;
       double extValue = 0;
       double netactValue = 0;
       double totpotsav = 0;
       try
       {
           findingType = int.Parse(Request["findingType"]);
           actValue = double.Parse(Request["actValue"]);
           extValue = double.Parse(Request["extValue"]);

           con.Open();
           SqlDataReader recomreader = new SqlCommand("select potSaving from recommendation_Table where findingId=" + findingId, con).ExecuteReader();
           while (recomreader.Read())
           {
               totpotsav += double.Parse(recomreader["potSaving"].ToString());
           }
           con.Close();
           netactValue = actValue - totpotsav;
       }
       catch (Exception)
       {

       }
       string newvalue = "Finding:" + finding + "<br>" + "Actual Financial Value:<b>" + actValue + "ETB.</b><br>Extrapolated financial value:<b>" + extValue + "ETB.</b><br>";

       try
       {
           string sql = "";
           if (source != "")
           {

               sql = "update finding_Table set findingName=N'" + finding + "',findingType=" + findingType + ",actualValue=" + actValue + ",extraValue=" + extValue + ",source=N'" + source + "',pRef=N'" + pref + "',auditeeResp=N'" + audresp + "',respDate='" + respdate + "',netactValue=" + netactValue + ",respfname=N'"+respfname+"',resplname=N'"+resplname+"' where findingId=" + findingId;
           }
           else
           {
               sql = "update finding_Table set findingName=N'" + finding + "',findingType=" + findingType + ",actualValue=" + actValue + ",extraValue=" + extValue + ",pRef=N'" + pref + "',auditeeResp=N'" + audresp + "',respDate='" + respdate + "',netactValue=" + netactValue + " where findingId=" + findingId;

           }
           con.Open();
           SqlDataReader typereader = new SqlCommand("select findingType from findingType_Table where typeId=" + findingType, con).ExecuteReader();
           while (typereader.Read())
           {
               newvalue += "findignType: " + typereader["findingType"];
           }
           con.Close();
           con.Open();
           string fname = "";
           string lname = "";
           SqlDataReader userreader = new SqlCommand("select fname,lname from user_Table where username='" + Request.Cookies["user"].Value + "'", con).ExecuteReader();
           while (userreader.Read())
           {
               fname = userreader["fname"].ToString();
               lname = userreader["lname"].ToString();
           }
           con.Close();
           newvalue += "<br> Updated on:" + DateTime.Now.ToString("yyyy-MM-dd");
           con.Open();
           new SqlCommand(sql, con).ExecuteNonQuery();
           con.Close();

           
          

           //saving history
           con.Open();
           new SqlCommand("insert into activitylog_Table values('Finding updated',N'" + fname + "',N'" + lname + "',N'" + newvalue + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "')", con).ExecuteNonQuery();
           con.Close();
           Response.Write("SUCCESS");
       }
       catch (Exception ex)
       {
           con.Close();
       }
    %>
</body>
</html>
