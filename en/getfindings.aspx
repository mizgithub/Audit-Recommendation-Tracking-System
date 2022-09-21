<%@ page language="C#" autoeventwireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
   <style type="text/css">
   td
   {
       font-weight:bold !important;
       color:#552222 !important; 
      
       }
      
     
   </style>
</head>
<body>

<table class="table table-responsive table-condensed table-bordered table-striped">
<tr><td>Auditee</td><td>Finding</td><td>Actual financial value (ETB.)</td></tr>
<%
string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
    SqlConnection con = new SqlConnection(@conString);
    SqlConnection con2 = new SqlConnection(@conString);
    SqlConnection con3 = new SqlConnection(@conString);
    SqlConnection con4 = new SqlConnection(@conString);
    SqlConnection con5 = new SqlConnection(@conString);
    try
    {
        string fid = Request["fid"];
        string[] arr = fid.Split(';');
        foreach (string id in arr) {
            con.Open();

            SqlDataReader freader = new SqlCommand("select * from finding_Table where findingId=" + int.Parse(id), con).ExecuteReader();
            while (freader.Read()) {
                int orgId = 0;
                con2.Open();
                SqlDataReader orgreader = new SqlCommand("select orgId from audit_Table where auditId=" + (int)freader["auditId"], con2).ExecuteReader(); ;
                while (orgreader.Read()) { 
                   orgId=(int)orgreader["orgId"];
                }
                con2.Close();
                con2.Open();
                string orgName = "";
                orgreader = new SqlCommand("select orgName from org_Table where orgId=" + orgId, con2).ExecuteReader();
                while (orgreader.Read()) {
                    orgName = orgreader["orgName"].ToString();
                 }
                con2.Close();
             %>
             <tr><td style="width:10%;color:blue !important;"><%Response.Write(orgName);%></td><td style="width:80%"><%Response.Write(freader["findingName"]);%></td><td style="width:10%"><%Response.Write((Double.Parse(freader["actualValue"].ToString())).ToString("#,0.00"));%></td></tr>
             <%
            }
            con.Close();
        }
        
    }
    catch (Exception ex) { 
    }
%>
</table>
</body>
</html>
