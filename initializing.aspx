<%@ Page Language="C#" AutoEventWireup="true"  %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
    try
    {
        Response.Cookies["user"].Value = "";
        Response.Cookies["auditId"].Value = "";
        con.Open();
        int res =(int) new SqlCommand("select count (*) from user_Table where role='System Administrator'", con).ExecuteScalar();
        con.Close();
        Response.Write(res);
    }
    catch (Exception ex) {
        Response.Write("UnSUC");
    }
 %>

