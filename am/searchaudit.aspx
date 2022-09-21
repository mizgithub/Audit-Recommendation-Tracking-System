<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>

<table class="table table-responsive table-condensed table-hover table-bordered table-striped">
<tr><th colspan="5" style="background-color:#c2c9cb;color:black"><h4>የፍለጋ ዉጤት</h4></th></tr>
    <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
    SqlConnection con2 = new SqlConnection(@conString);

   
   string year = Request["year"];
   int orgId = 0;
   string auditType = Request["audittype"];
   try
   {
       orgId = int.Parse(Request["auditee"]);
     
   }
   catch (Exception ex) { 
   }
   
   try
   {
       string sql = "select * from audit_Table where status='submitted'";
       if (year != "0") {
        sql+=" and year='"+year+"'";  
       }
       if (auditType != "0") {
           sql += " and auditType='" + auditType + "'";
       }
       if (orgId != 0) {
           sql += " and orgId=" + orgId;
       }
       
       con.Open();
       string sqlcounter = sql.Replace("*", "count(*)");
           int res = (int)new SqlCommand(sqlcounter, con).ExecuteScalar();
           con.Close();
           if (res > 0) { 
           %>
           <tr><td colspan="5" style="font-weight:bold">ለመክፈት የኦዲቱ ርዕስ ላይ ጠቅ ያድርጉ</td></tr>
           <tr><td></td><td style="font-size:small">የኦዲት ርዕስ</td><td style="font-size:small">ተገምጋሚ ድርጅት</td><td style="font-size:small">የኦዲት አይነት</td><td style="font-size:small">የኦዲት ዓ/ም</td></tr>
           <%
           }
       sql += " order by year desc";
       con.Open();
       int auditcounter = 0;
       SqlDataReader auditreader = new SqlCommand(sql, con).ExecuteReader();
       while (auditreader.Read()) {
           string orgname = ""; 
           con2.Open();
           SqlDataReader auditeereader = new SqlCommand("select orgName from org_Table where orgId=" +auditreader["orgId"], con2).ExecuteReader();
           while (auditeereader.Read()) {
               orgname = auditeereader["orgName"].ToString();
           }
           con2.Close();
       %>
       <tr style="color:#6666dd;font-size:larger;cursor:pointer" onclick="opensearchedaudit(<%Response.Write(auditreader["auditId"]);%>)" class="btn-link"><td style="width:10px"><%Response.Write(++auditcounter);%></td><td><%Response.Write(auditreader["auditName"]);%></td><td><%Response.Write(orgname);%></td><td><%Response.Write(auditreader["auditType"]);%></td><td><%Response.Write(auditreader["year"]);%></td></tr>
       <%
       }
       con.Close();
       Response.Write("");
   }
   catch (Exception ex) {
       con.Close();
       Response.Write(ex.Message);
   }
 %>
 </table>
</body>
</html>
