<%@ Page Language="C#" AutoEventWireup="true" %>
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
   string refno = Request["refno"];
   string audittitle = Request["audittitle"];
   string year = Request["year"];
  
   string startdate = Request["startdate"];
   string enddate = Request["enddate"];
   int auditee = int.Parse(Request["auditee"]);
   string audittype = Request["audittype"];
   string orgname="";
   try
   {
       int minId=0;
       con.Open();
       SqlDataReader minreader=new SqlCommand("select minId,orgName from org_Table where orgId="+auditee,con).ExecuteReader();
       while(minreader.Read()){
        minId=(int)minreader["minId"];
           orgname=minreader["orgName"].ToString();
       }
       con.Close();
        string newvalue="RefNO:"+refno+"<br>Title:"+audittitle+"<br>Auditee:"+orgname+"<br>AuditType:"+audittype+"<br>Audityear:"+year+"<br>AuitdPeriod:"+startdate+"---"+enddate;
        string userfname = "";
        string userlname = "";      
       con.Open();
             SqlDataReader userreader=new SqlCommand("select fname,lname from user_Table where username='"+Request.Cookies["user"].Value+"'",con).ExecuteReader();
              while(userreader.Read()){
                  userfname = userreader["fname"].ToString();
                  userlname=userreader["lname"].ToString();
              }
           con.Close();
       if (Request.Cookies["auditId"].Value == "")
       {
           con.Open();
           int auditId = (int)new SqlCommand("insert into audit_Table  OUTPUT INSERTED.auditId values(N'" + refno + "'," + minId + "," + auditee + ",N'" + audittitle + "',N'" + audittype + "','" + year + "','" + startdate + "','" + enddate + "','saved','"+Request.Cookies["user"].Value+"','','','')", con).ExecuteScalar();
           con.Close();
           // save history

           con.Open();
           new SqlCommand("insert into activitylog_Table values('Audit information inserted',N'" + userfname + "',N'" + userlname + "',N'" + newvalue + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "')", con).ExecuteNonQuery();
           con.Close(); 
           //***********
           Response.Cookies["auditId"].Value = "" + auditId;
           Response.Write("SUCCESS");
       }
       else {
           string oldvalue = "";
           con.Open();
           SqlDataReader valreader = new SqlCommand("select oldvalue,newvalue from audithistory_Table where auditId=" + int.Parse(Request.Cookies["auditId"].Value), con).ExecuteReader();
           while (valreader.Read()) {
               oldvalue += valreader["oldvalue"] + "<br>" + valreader["newvalue"];
           }
           con.Close();
           con.Open();
           new SqlCommand("update audit_Table set refNo=N'" + refno + "',auditName=N'" + audittitle + "',minId=" + minId + ",orgId=" + auditee + ",auditType=N'" + audittype + "',year='" + year + "',startdate='" + startdate + "',enddate='" + enddate + "' where auditId=" + int.Parse(Request.Cookies["auditId"].Value), con).ExecuteNonQuery();
           con.Close();
           con.Open();
           new SqlCommand("insert into activitylog_Table values('Audit information updated',N'" + userfname + "',N'" + userlname + "',N'" + newvalue + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "')", con).ExecuteNonQuery();
           con.Close(); 
           Response.Write("SUCCESS");
       }
   }
   catch (Exception ex) {
       Response.Write(ex.Message);
       con.Close();
   }
 %>
</body>
</html>
