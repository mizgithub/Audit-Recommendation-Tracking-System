﻿<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Security.Cryptography"%>
<% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   string oldpassword = Request["oldpassword"];
   string newpassword = Request["newpassword"];
   int user = 0;
   try
   {
       user = int.Parse(Request.Cookies["user"].Value);
   }
   catch (Exception ex) { 
   }
   StringBuilder hashpassold = new StringBuilder();
   StringBuilder hashpassnew = new StringBuilder();

   try
   {
       MD5CryptoServiceProvider md5provider = new MD5CryptoServiceProvider();
       byte[] bytes = md5provider.ComputeHash(new UTF8Encoding().GetBytes(oldpassword));

       for (int i = 0; i < bytes.Length; i++)
       {
           hashpassold.Append(bytes[i].ToString("x2"));
       }

       bytes = md5provider.ComputeHash(new UTF8Encoding().GetBytes(newpassword));
       for (int i = 0; i < bytes.Length; i++)
       {
           hashpassnew.Append(bytes[i].ToString("x2"));
       }
   }
   catch (Exception ex)
   {

   }
   try
   {
       con.Open();
       int res = (int)new SqlCommand("update auditeeuser_Table set pass='" + hashpassnew + "' where pass='"+hashpassold+"' and orgId='" + user + "'", con).ExecuteNonQuery();
       con.Close();
       if (res != 0)
       {
           Response.Write("<b style='color:blue'>Password changed successfully</b>");
       }
       else {
           Response.Write("<b style='color:red'>Password NOT changed</b>");
       }
   }
   catch (Exception ex) {
       con.Close();
   }
 %>

