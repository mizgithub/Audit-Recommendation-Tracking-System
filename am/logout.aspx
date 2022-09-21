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
       Response.Cookies["user"].Value = null;
      
       Response.AddHeader("Cache-Control", "no-cache, no-store, max-age=0, must-revalidate");
       Response.AddHeader("Pragma", "no-cache");
     //  Response.ClearHeaders("0");
       Response.Cache.SetCacheability(HttpCacheability.NoCache);
       Response.Redirect("../login.aspx");    
      
    %>
</body>
</html>
