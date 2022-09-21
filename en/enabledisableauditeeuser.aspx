<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
<%
   
     
      %>
    <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   int idno = int.Parse(Request["idno"]);
   string status = Request["status"];
   try
   {
       con.Open();
       new SqlCommand("update auditeeuser_Table set status='"+status+"' where orgId="+idno, con).ExecuteNonQuery();
       con.Close();
   }
   catch (Exception ex) {
       con.Close();
   }
 %>
</body>
</html>
