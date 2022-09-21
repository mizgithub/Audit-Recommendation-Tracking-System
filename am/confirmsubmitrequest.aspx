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
      string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   int auditId=int.Parse(Request.Cookies["auditId"].Value);
   try
   {
       ///con.Open();
      // int res=(int)new SqlCommand("update submitRequest_Table set status='approved' where auditId="+int.Parse(Request["auditId"]),con).ExecuteNonQuery();
     //  con.Close();
      // if (res != 0)
      // {
        con.Open();
        new SqlCommand("update audit_Table set status='submitted' where auditId=" + auditId, con).ExecuteNonQuery();
        con.Close();
         //  Response.Write("SUC");
      // }
     //  else {
         //  Response.Write("UNSUC");
      // }
        Response.Write("SUC");
       
   }
   catch (Exception ex) {
       con.Close();
       Response.Write("<b style='color:red;'>Error occure during Audit Submission. Try it again.</b>");
   }
 
 %>
</body>
</html>
