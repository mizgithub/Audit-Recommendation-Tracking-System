<%@ Page Language="C#" AutoEventWireup="true" %>
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
   int auditId=int.Parse(Request.Cookies["auditId"].Value);
  string user = Request.Cookies["user"].Value;
   try
   {
       con.Open();
       int res=(int)new SqlCommand("insert into submitRequest_Table values("+auditId+",'"+user+"','"+DateTime.Now.ToString("yyyy-MM-dd")+"','pending')",con).ExecuteNonQuery();
       con.Close();
       if (res != 0)
       {
           Response.Write("<b style='color:blue'>Your request has been sent successfully.<br></b>");
       }
       else {
           Response.Write("<b style='color:red'>You already sent a request.<br></b>");
       }
   }
   catch (Exception ex) {
       con.Close();
       Response.Write("<b style='color:red'>You already sent a request.<br></b>");
   }
 %>
</body>
</html>
