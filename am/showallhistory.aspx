<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
<script type="text/javascript">
   
</script>
<style>
    .affix
    {
        top:0;
        width:100%;
        }
       .affix + .container-fluid
       {
           padding-top:20px;
           }
           
         .sideb:hover
         {
             color:Black !important;
             }
</style>
</head>
<body>
<%
     if (Request.Cookies["user"].Value == null || Request.Cookies["user"].Value == "")
     {
         Response.Redirect("login.aspx");
    } 
     
     
      %>



<table class="table table-responsive table-condensed table-bordered table-striped table-hover" id="htab" border="1">
<tr><td>ተጠቃሚ</td><td>ቀን</td><td>እንቅስቃሴ</td></tr>
 <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   SqlConnection con2 = new SqlConnection(@conString);
   try
   {
       con.Open();
      
       string sql = "select TOP 20 * from activitylog_Table order by activityId desc";
       if (Request["fyear"] != "" || Request["fyear"]!="") { 
       sql="select * from activitylog_Table where lastupdate>='"+Request["fyear"]+"' and lastupdate<='"+Request["tyear"]+"' order by activityId desc";
       }
        SqlDataReader ahistreader = new SqlCommand(sql, con).ExecuteReader();
       while (ahistreader.Read()) { 
       %>
       <tr><td style="width:15%"><%Response.Write(ahistreader["userfname"]+" "+ahistreader["userlname"]);%></td><td style="width:15%"><%Response.Write(ahistreader["lastupdate"]);%></td><td style="width:70%"><u><%Response.Write(ahistreader["activityType"]);%></u><br><%Response.Write(ahistreader["value"]);%></td></tr>
       <%
       }
       con.Close();
   }
   catch (Exception ex) {
       con.Close();
   }
   %>
   </table>


</body>
</html>
