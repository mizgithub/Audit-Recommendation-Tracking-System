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
       color:black; 
      
       }
     
     
   </style>
</head>
<body style="background-color:#eeddbb !important;color:black !important">
<div class="panel panel-danger" style="padding:10px;">
<%
string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
    SqlConnection con = new SqlConnection(@conString);
    SqlConnection con2 = new SqlConnection(@conString);
    SqlConnection con3 = new SqlConnection(@conString);
    SqlConnection con4 = new SqlConnection(@conString);
    SqlConnection con5 = new SqlConnection(@conString);

  string minId = Request["selmin"];
  string orgId = Request["selorg"];
  string audittype = Request["selaudittype"];
  string yeartype = Request["yeartype"];
  string onyear = Request["onyear"];
  string fyear = Request["fyear"];
  string tyear = Request["tyear"];
 
 
 
  
  int numofcolumns = 0;
  int rowno = 0;
  string setminname = "All Directorate";
  string setorgname = "All Organization in the Directorate";
  string setaudittype = Request["selauditType"];
  string setyear = "All year";
 
  if (setaudittype == "0") {
      setaudittype = "All audit types";
  }

  if (yeartype == "on")
  {
      setyear = Request["onyear"];
      if (setyear == "0") {
          setyear = "All years";
      }
  }
  else {
      setyear = Request["fyear"] + "----" + Request["tyear"];
  }
  
  try
  {
      con.Open();
      SqlDataReader setminreader = new SqlCommand("select minName from ministry_Table where minId=" + int.Parse(minId), con).ExecuteReader();
      while (setminreader.Read()) {
          setminname = setminreader["minName"].ToString();
      }
      con.Close();
      con.Open();
      SqlDataReader setorgreader = new SqlCommand("select orgName from org_Table where orgId=" + int.Parse(orgId), con).ExecuteReader();
      while (setorgreader.Read())
      {
          setorgname = setorgreader["orgName"].ToString();
      }
      con.Close();
      
  }
  catch (Exception ex) {
      con.Close();
  }
     
      %>
<div class="panel panel-danger" style="padding:10px;font-size:smaller;font-family:Times New Roman">
<table style="background-color:white;width:100%">
<tr  align="center" style=""><th colspan="4"><h4 style="display:inline"><u>Your Setting</u></h4></th></tr>
<tr><td>Directorate:</td><td><%Response.Write(setminname);%></td><td>Organization:</td><td><%Response.Write(setorgname);%></td></tr>
<tr><td>Audit type:</td><td><%Response.Write(setaudittype);%></td><td>Audit Year:</td><td><%Response.Write(setyear);%></td></tr>
</table>
<ul class="nav nav-tabs" style="border-bottom:1px solid #dddddd">
<li><a class="btn btn-link btn-sm"style="cursor:pointer;background-color:#c2c9cb;color:black;border-radius:0px;" onclick="printpdfactionplanprovided()" ><span class="glyphicon glyphicon-share"></span>Export to PDF</a></li>
</ul>
<br>
<table class="table">
<tr><th style="background-color:#c2c9cb;color:black">Detail of action plan and action taken provided</th></tr>
</table>
<br>
<table class="table table-responsive table-condensed table-hover table-striped table-bordered" border="1">
<% string sql = "select * from audit_Table where status='submitted'";
   try
   {

   if (yeartype == "on" && onyear != "0") {
       sql += " and year='" + onyear + "'";
   }
   if (yeartype == "range" && fyear != "0" && tyear != "0") {
       sql += " and year>='" + fyear + "' and year<='" + tyear + "'";
   }
   if (minId != "0") {
       sql += " and minId=" + int.Parse(minId);
   }
   if (orgId != "0") {
       sql += "and orgId=" + int.Parse(orgId);
   }
   if (audittype != "0") {
       sql += " and auditType='" + audittype + "'";
   }
   
      con.Open();
      int recomcounter = 1;
      SqlDataReader auditidreader = new SqlCommand(sql, con).ExecuteReader();
      while(auditidreader.Read()){
          string auditee="";
        con2.Open();
          SqlDataReader auditeereader=new SqlCommand("select orgName from org_Table where orgId="+(int)auditidreader["orgId"],con2).ExecuteReader();
            while(auditeereader.Read()){
               auditee=auditeereader["orgName"].ToString();
            }
          con2.Close();
          con2.Open();
          
          SqlDataReader recomreader = new SqlCommand("select * from actionPlan_Table where auditId=" + (int)auditidreader["auditId"], con2).ExecuteReader();
           while(recomreader.Read()){
            %>
            <tr style="border-top:2px solid #c3c9cb;"><th style="background-color:#c2c9cb;color:black;"><%Response.Write(recomcounter++);%></th><td style="width:27%">Auditee<br><%Response.Write(auditee);%></td><td>Action plan<br><%Response.Write(recomreader["actionplan"]);%></td></tr>
            <tr><td colspan="3">
            <table class="table table-responsive table-condensed table-hover table-striped table-bordered">
            <% 
               con3.Open();
               int actiontakencounter = 0;
               SqlDataReader actiontakenreader = new SqlCommand("select * from actiontaken_Table where actionplanId=" + (int)recomreader["recomId"] + " order by actiontakenId", con3).ExecuteReader();
               while (actiontakenreader.Read()) { 
               %>
               <tr><td style="width:10%">Action taken <%Response.Write(++actiontakencounter);%></td><td style="width:50%">Action Taken<br><%Response.Write(actiontakenreader["actiontaken"]);%></td><td>Recovered financial value(ETB.): <%Response.Write(actiontakenreader["recoveredvalue"]); %></td><td style="width:10%">Date:<%Response.Write(actiontakenreader["actiondate"]);%></td></tr>
               <%
               }   
               con3.Close();
               if (actiontakencounter == 0) { 
               %>
               <tr><th colspan="3" style="font-size:16px;">No action taken provided</th></tr>
               <%
               }
               %>
               </table></td></tr>
               <%
           }
          con2.Close();    
      }
      con.Close();
  }
  catch (Exception ex) { 
  
  }
    
  %>
  </table>
</body>
</html>
