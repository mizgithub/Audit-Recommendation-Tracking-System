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
 <select class="form-control" id="selorg">
<option value="0">ሁሉንም ተገምጋሚ ድርጅቶች</option>
    <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   int minId = int.Parse(Request["minId"]);
   try
   {
       string sql = "select * from org_Table";
       if (minId != 0) {
           sql += " where minId=" + minId;
       }
       con.Open();
               SqlDataReader orgreader = new SqlCommand(sql, con).ExecuteReader();
               while (orgreader.Read())
               { 
               %>
               <option value="<%Response.Write(orgreader["orgId"]);%>"><%Response.Write(orgreader["orgName"]);%></option>
                <%
               }
               con.Close();
   }
   catch (Exception ex) {
       con.Close();
   }
 %>
 </select>
</body>
</html>
