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
       color :black !important;
      
       }
      
     
   </style>
</head>
<body style="color:black !important">
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
  string grpby = Request["grpby"];
  string filterby = Request["filterby"];
  string detail = Request["detail"];

  int numofcolumns = 0;
  int rowno = 0;
  string setminname = "All Directorate";
  string setorgname = "All Organization in the Directorate";
  string setaudittype = Request["selauditType"];
  string setyear = "All year";
  string setgrp = grpby;
  if (grpby == "0") {
      setgrp = "None";
   }
  if (grpby == "finding") {
      setgrp = "finding type";
  }
  if (setaudittype == "0") {
      setaudittype = "All audit types";
  }
  string setfilter = "Finding and recommendation";
  if (filterby == "finding") {
      setfilter = "Findings";
  }
  if (filterby == "recomm") {
      setfilter = "Recommendations";
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
<tr><td>Show:</td><td><%Response.Write(setfilter);%></td><td>Group by:</td><td><%Response.Write(setgrp);%></td></tr>
</table>

<ul class="nav nav-tabs" style="border-bottom:1px solid #dddddd"><li><a class="btn btn-link btn-sm"style="cursor:pointer;background-color:#c2c9cb;color:black;border-radius:0px;" onclick="$('#hidmenu').slideToggle();" ><span class="glyphicon glyphicon-share"></span>Export</a>
<ul class="dropdown-menu"style="display:none;border:1px solid #cc5555" id="hidmenu">
<li><a style="cursor:pointer;" onclick="exporttoexcel();$('#hidmenu').slideUp();"><span class="glyphicon glyphicon-th"></span> To Excel</a></li>
<li><a style="cursor:pointer;" onclick="enterListreportTitle();$('#hidmenu').slideUp();"><span class="glyphicon glyphicon-book"></span> To Pdf</a></li>
</ul>
</li><li><a style="cursor:pointer;" onclick="showsetting()">Summary format</a></li><li><a style="cursor:pointer;font-weight:bolder;background-color:#ddeeee;width:100%" onclick="showsettingListFormat()">List format</a></li>
</ul>

<br>
<div  id="tableid">
 <%

   %>
  <center> <table class="" border="1" style="border:1px solid #c2c9cb;font-size:12px;background-color:white;width:100%;" id="tbl">
 
   <%
   string sql = "select * from audit_Table where status='submitted'";
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
   
       //*********** Group by Auditee*****
   
   if(grpby=="auditee"){

       int colspan = int.Parse(Request["colspan"]) + 1;
      
       //***** GROUP BY MINISTRY******
      
       // ************group by Organization**************
       int flag = 0;
           string sql2=sql.Replace("*","orgId");
           sql2+=" group by orgId";
           con.Open();
          
           SqlDataReader auditreader = new SqlCommand(sql2, con).ExecuteReader(); 
           int rowcounter = 1;
           while (auditreader.Read())
           {

               int totnumoffinding = 0;
               int totnumofrecom = 0;
               int totnumfullrecom = 0;
               int totnumpartrecom = 0;
               int totnumnotrecom = 0;
               double totnetactval = 0;
               double totrecovered = 0;
               double totactualvalue = 0;
               string totfid = "";
               double totextravalue = 0;
               double totsaving = 0;
               string minname = "";
               con2.Open();
               // reading ministries
               SqlDataReader minnamereader = new SqlCommand("select orgName from org_Table where orgId=" + (int)auditreader["orgId"], con2).ExecuteReader();
               while (minnamereader.Read()) {
                   minname = minnamereader["orgName"].ToString();
               }
               con2.Close();
                  %>
               
                 
               <%
          if (flag == 0)
           {
               flag = 1;
           }
           else
           {
        %>

         <tr style="border:0px solid white"><th colspan="<%Response.Write(colspan);%>">&nbsp;</th></tr>
          <tr style="border:0px solid white"><th colspan="<%Response.Write(colspan);%>">&nbsp;</th></tr>
           <tr style="border:0px solid white"><th colspan="<%Response.Write(colspan);%>" style="border-width:0px;">&nbsp;</th></tr>
           <%} %>
       
         <tr style="background-color:#c2c9cb;color:black;font-size:16px;border-top:2px solid #c2c9cb;text-align:center"><th colspan="<%Response.Write(colspan);%>" align="center">Audit detail of <%Response.Write(minname);%></th></tr>
       
          <tr><th id="">Audit year</th>
        <%
       
       //******************************************
       if(Request["c1"]=="t"){
          
       %><th>No. of findings</th><%                                                                          
       }
       if(Request["c2"]=="t"){
        
       %><th>Actual financial value of findings (ETB.)</th><%                                                                          
       }
       if(Request["c3"]=="t"){
          
       %><th>Extrapolated financial value of findings (ETB.) </th><%                                                                          
       }
       if(Request["c4"]=="t"){
        
       %><th >No. of recomm</th><%                                                                          
       }
       if(Request["c5"]=="t"){
         
       %><th>Potential saving from recomm (ETB.)</th><%                                                                          
       }
       if(Request["c6"]=="t"){
          
       %><th>No. of fully implemented recomm.</th><%                                                                          
       }
       if(Request["c7"]=="t"){
          
       %><th>No. of partially implemented recomm.</th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
          
       %><th>No. of not implemented recomm.</th><%                                                                          
       }
      if(Request["c9"]=="t"){
          
       %><th>Recovered financial value (ETB.)</th><%                                                                          
       }
        if(Request["c10"]=="t"){
          
       %><th>Unrecovered financial value (ETB.)</th><%                                                                          
       }
       %></tr><%
              con2.Open();
               string sql3=sql+" and orgId="+auditreader["orgId"]+" order by year desc";
               // reading audits for each Organization
               SqlDataReader auditreader2 = new SqlCommand(sql3, con2).ExecuteReader();
               while (auditreader2.Read()) {
                   int numoffinding = 0;
                   int numofrecom = 0;
                   int numfullrecom = 0;
                   int numpartrecom = 0;
                   int numnotrecom = 0;
                   double netactval = 0;
                   double recovered = 0;
                   double actualvalue = 0;
                   double extravalue = 0;
                   string fid = "";
                   double saving = 0;
                   con3.Open();
                   SqlDataReader findingreader = new SqlCommand("select * from finding_Table where auditId=" + (int)auditreader2["auditId"], con3).ExecuteReader();
                   while (findingreader.Read()) {
                       try
                       {
                           numoffinding++;
                           totnumoffinding++;
                           actualvalue += double.Parse(findingreader["actualValue"].ToString());
                           extravalue += double.Parse(findingreader["extraValue"].ToString());
                           fid += findingreader["findingId"] + ";";
                           totfid += findingreader["findingId"] + ";";
                           netactval += double.Parse(findingreader["netactValue"].ToString());
                           totnetactval += double.Parse(findingreader["netactValue"].ToString());
                           totactualvalue += double.Parse(findingreader["actualValue"].ToString());
                           totextravalue += double.Parse(findingreader["extraValue"].ToString());
                       }
                       catch (Exception ex)
                       {

                       }
                   }
                  con3.Close();

                  con3.Open();
                  SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where auditId=" + (int)auditreader2["auditId"], con3).ExecuteReader();
                  while (recomreader.Read()) {
                      numofrecom++;
                      totnumofrecom++;
                      if (recomreader["status"].ToString() == "1")
                      {
                          numnotrecom++;
                          totnumnotrecom++;
                      }
                      else if (recomreader["status"].ToString() == "2")
                      {
                          numpartrecom++;
                          totnumpartrecom++;
                      }
                      else
                      {
                          numfullrecom++;
                          totnumfullrecom++;
                      }
                      saving += double.Parse(recomreader["potSaving"].ToString());
                      totsaving += double.Parse(recomreader["potSaving"].ToString());
                  }
                  con3.Close();
                  con3.Open();

                  SqlDataReader recvaluereader = new SqlCommand("select recoveredvalue from actiontaken_Table where auditId=" + auditreader2["auditId"], con3).ExecuteReader();
                  while (recvaluereader.Read())
                  {
                      if (recvaluereader["recoveredvalue"].ToString() != "" && recvaluereader["recoveredvalue"].ToString() != "0")
                      {
                          recovered += double.Parse(recvaluereader["recoveredvalue"].ToString());
                          totrecovered += double.Parse(recvaluereader["recoveredvalue"].ToString());
                      }
                  }
                  con3.Close();
                     %>
          <tr><th><%Response.Write(auditreader2["year"]);%></th>
        <%
              
       //******************************************
       if(Request["c1"]=="t"){
          
       %><th><a href="#" onclick="openfinding('<%Response.Write(fid);%>')"><%Response.Write(numoffinding);%></a></th><%                                                                          
       }
       if(Request["c2"]=="t"){
          
       %><th><%Response.Write(actualvalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c3"]=="t"){
        
       %><th><%Response.Write(extravalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c4"]=="t"){
         
       %><th><%Response.Write(numofrecom);%></th><%                                                                          
       }
       if(Request["c5"]=="t"){
          
       %><th><%Response.Write(saving.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c6"]=="t"){
         
       %><th><%Response.Write(numfullrecom);%></th><%                                                                          
       }
       if(Request["c7"]=="t"){
          
       %><th><%Response.Write(numpartrecom);%></th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
         
       %><th><%Response.Write(numnotrecom);%></th><%                                                                          
       }
      if(Request["c9"]=="t"){
          
       %><th><%Response.Write(recovered.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c10"]=="t"){
          
       %><th><%Response.Write((actualvalue-recovered).ToString("#,0.00"));%></th><%                                                                          
       }
       %></tr><%
               rowcounter++;
               
                   
               }
               con2.Close();
               %>
        <tr style="background-color:#ddeeee;font-size:larger"><th>Total</th>
        <%
              
       //******************************************
       if(Request["c1"]=="t"){
          
       %><th><a href="#" onclick="openfinding('<%Response.Write(totfid);%>')"><%Response.Write(totnumoffinding);%></a></th><%                                                                          
       }
       if(Request["c2"]=="t"){
          
       %><th><%Response.Write(totactualvalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c3"]=="t"){
        
       %><th><%Response.Write(totextravalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c4"]=="t"){
         
       %><th><%Response.Write(totnumofrecom);%></th><%                                                                          
       }
       if(Request["c5"]=="t"){
          
       %><th><%Response.Write(totsaving.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c6"]=="t"){
         
       %><th><%Response.Write(totnumfullrecom);%></th><%                                                                          
       }
       if(Request["c7"]=="t"){
          
       %><th><%Response.Write(totnumpartrecom);%></th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
         
       %><th><%Response.Write(totnumnotrecom);%></th><%                                                                          
       }
      if(Request["c9"]=="t"){
          
       %><th><%Response.Write(totrecovered.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c10"]=="t"){
          
       %><th><%Response.Write((totactualvalue-totrecovered).ToString("#,0.00"));%></th><%                                                                          
       }
       %></tr><%
           }
           rowno = rowcounter;
       
           con.Close();
   }
   
   
   
   
   else if (grpby == "finding")
   {
        int colspan = int.Parse(Request["colspan"]) + 2;
       numofcolumns = 4;
       int flag = 0;
       con.Open();
      
    
       SqlDataReader findingtypereader = new SqlCommand("select * from findingType_Table", con).ExecuteReader();
       int rowcounter = 1;
       while (findingtypereader.Read())
       {
           int totnumoffinding = 0;
           int totnumofrecom = 0;
           int totnumfullrecom = 0;
           int totnumpartrecom = 0;
           int totnumnotrecom = 0;
           double totnetactval = 0;
           string totfid = "";
           double totrecovered = 0;
           double totactualvalue = 0;
           double totextravalue = 0;
           double totsaving = 0;
           
           int res = 0;
           con2.Open();
           SqlDataReader audcounter = new SqlCommand(sql, con2).ExecuteReader();
           while (audcounter.Read()) {
               con3.Open();
               res += (int)new SqlCommand("select count(*) from finding_Table where auditId=" + (int)audcounter["auditId"] + " and findingType=" + (int)findingtypereader["typeId"], con3).ExecuteScalar();
               con3.Close();
           }
           
           con2.Close();
           if (res != 0)
           {
            if (flag == 0)
           {
               flag = 1;
           }
           else
           {
        %>

         <tr style="border:0px solid white"><th colspan="<%Response.Write(colspan);%>">&nbsp;</th></tr>
          <tr style="border:0px solid white"><th colspan="<%Response.Write(colspan);%>">&nbsp;</th></tr>
           <tr style="border:0px solid white"><th colspan="<%Response.Write(colspan);%>" style="border-width:0px;">&nbsp;</th></tr>
           <%} %>
       
         <tr style="background-color:#c2c9cb;color:black;font-size:16px;border-top:2px solid #c2c9cb;text-align:center"><th colspan="<%Response.Write(colspan);%>" align="center"><%Response.Write(findingtypereader["findingType"]);%></th></tr>
         <tr><th>Auditee</th><th>Audit year</th>
         
       <%
           //******************************************
           if(Request["c1"]=="t"){
          
       %><th>No. of findings</th><%                                                                          
       }
       if(Request["c2"]=="t"){
        
       %><th>Actual financial value of findings (ETB.)</th><%                                                                          
       }
       if(Request["c3"]=="t"){
          
       %><th>Extrapolated financial value of findings (ETB.) </th><%                                                                          
       }
       if(Request["c4"]=="t"){
        
       %><th >No. of recomm.</th><%                                                                          
       }
       if(Request["c5"]=="t"){
         
       %><th>Potential saving from recomm (ETB.)</th><%                                                                          
       }
       if(Request["c6"]=="t"){
          
       %><th>No. of fully implemented recomm.</th><%                                                                          
       }
       if(Request["c7"]=="t"){
          
       %><th>No. of partially implemented recomm.</th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
          
       %><th>No. of not implemented recomm.</th><%                                                                          
       }
      if(Request["c9"]=="t"){
          
       %><th>Recovered financial value (ETB.)</th><%                                                                          
       }
        if(Request["c10"]=="t"){
          
       %><th>Unrecovered financial value (ETB.)</th><%                                                                          
       }
       %></tr><%
           }
           con2.Open();
           SqlDataReader auditreader = new SqlCommand(sql, con2).ExecuteReader();
           while (auditreader.Read())
           {
               string minname = "";
               con4.Open();
               // reading ministries
               SqlDataReader minnamereader = new SqlCommand("select orgName from org_Table where orgId=" + (int)auditreader["orgId"], con4).ExecuteReader();
               while (minnamereader.Read())
               {
                   minname = minnamereader["orgName"].ToString();
               }
               con4.Close();
               int numoffinding = 0;
               int numofrecom = 0;
               int numfullrecom = 0;
               int numpartrecom = 0;
               int numnotrecom = 0;
               double netactval = 0;
               double recovered = 0;
               double actualvalue = 0;
               double extravalue = 0;
               string fid = "";
               double saving = 0;
               con3.Open();
               SqlDataReader findingreader = new SqlCommand("select * from finding_Table where auditId=" + (int)auditreader["auditId"] + " and findingType=" + (int)findingtypereader["typeId"], con3).ExecuteReader();
               while (findingreader.Read())
               {
                   numoffinding++;
                   totnumoffinding++;
                   actualvalue += double.Parse(findingreader["actualValue"].ToString());
                   extravalue += double.Parse(findingreader["extraValue"].ToString());
                   fid += findingreader["findingId"] + ";";
                   totfid += findingreader["findingId"] + ";";
                   netactval += double.Parse(findingreader["netactValue"].ToString());
                   totnetactval += double.Parse(findingreader["netactValue"].ToString());
                   totactualvalue += double.Parse(findingreader["actualValue"].ToString());
                   totextravalue += double.Parse(findingreader["extraValue"].ToString());

                   con4.Open();
                   SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where auditId=" + (int)auditreader["auditId"] + " and findingId=" + (int)findingreader["findingId"], con4).ExecuteReader();
                   while (recomreader.Read())
                   {
                       numofrecom++;
                       totnumofrecom++;
                       if (recomreader["status"].ToString() == "1")
                       {
                           numnotrecom++;
                           totnumnotrecom++;
                       }
                       else if (recomreader["status"].ToString() == "2")
                       {
                           numpartrecom++;
                           totnumpartrecom++;
                       }
                       else
                       {
                           numfullrecom++;
                           totnumfullrecom++;
                       }
                       saving += double.Parse(recomreader["potSaving"].ToString());
                       totsaving += double.Parse(recomreader["potSaving"].ToString());
                       con5.Open();
                       SqlDataReader recvaluereader = new SqlCommand("select recoveredvalue from actiontaken_Table where actionplanId=" + (int)recomreader["recomId"], con5).ExecuteReader();
                       while (recvaluereader.Read())
                       {
                           if (recvaluereader["recoveredvalue"].ToString() != "" && recvaluereader["recoveredvalue"].ToString() != "0")
                           {
                               recovered += double.Parse(recvaluereader["recoveredvalue"].ToString());
                               totrecovered += double.Parse(recvaluereader["recoveredvalue"].ToString());
                           }
                       }
                       con5.Close();
                   }
                   con4.Close();
               }
               con3.Close();
               
               
               if (numoffinding > 0)
           { 
              %>
          <tr><th><%Response.Write(minname);%></th><th><%Response.Write(auditreader["year"]);%></th>
        <%
              
       //******************************************
       if(Request["c1"]=="t"){
          
       %><th><a href="#" onclick="openfinding('<%Response.Write(fid);%>')"><%Response.Write(numoffinding);%></a></th><%                                                                          
       }
       if(Request["c2"]=="t"){
          
       %><th><%Response.Write(actualvalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c3"]=="t"){
        
       %><th><%Response.Write(extravalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c4"]=="t"){
         
       %><th><%Response.Write(numofrecom);%></th><%                                                                          
       }
       if(Request["c5"]=="t"){
          
       %><th><%Response.Write(saving.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c6"]=="t"){
         
       %><th><%Response.Write(numfullrecom);%></th><%                                                                          
       }
       if(Request["c7"]=="t"){
          
       %><th><%Response.Write(numpartrecom);%></th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
         
       %><th><%Response.Write(numnotrecom);%></th><%                                                                          
       }
      if(Request["c9"]=="t"){
          
       %><th><%Response.Write(recovered.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c10"]=="t"){
          
       %><th><%Response.Write((actualvalue-recovered).ToString("#,0.00"));%></th><%                                                                          
       }
       %></tr><%
                 rowcounter++;
           }
               
           }
           con2.Close();

           
           rowno = rowcounter;
           if (res != 0)
           {
             %>
        <tr style="background-color:#ddeeee;font-size:larger"><th>Total</th><th></th>
        <%
              
       //******************************************
       if(Request["c1"]=="t"){
          
       %><th><a href="#" onclick="openfinding('<%Response.Write(totfid);%>')"><%Response.Write(totnumoffinding);%></a></th><%                                                                          
       }
       if(Request["c2"]=="t"){
          
       %><th><%Response.Write(totactualvalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c3"]=="t"){
        
       %><th><%Response.Write(totextravalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c4"]=="t"){
         
       %><th><%Response.Write(totnumofrecom);%></th><%                                                                          
       }
       if(Request["c5"]=="t"){
          
       %><th><%Response.Write(totsaving.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c6"]=="t"){
         
       %><th><%Response.Write(totnumfullrecom);%></th><%                                                                          
       }
       if(Request["c7"]=="t"){
          
       %><th><%Response.Write(totnumpartrecom);%></th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
         
       %><th><%Response.Write(totnumnotrecom);%></th><%                                                                          
       }
      if(Request["c9"]=="t"){
          
       %><th><%Response.Write(totrecovered.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c10"]=="t"){
          
       %><th><%Response.Write((totactualvalue-totrecovered).ToString("#,0.00"));%></th><%                                                                          
       }
       %></tr><%
           }
          
       }
       
       con.Close();

   }
   //***** group by year****************************
   else{
       int colspan = int.Parse(Request["colspan"]) + 1;
       int flag = 0;
   string sql2=sql.Replace("*","DISTINCT year");
           sql2+=" order by year desc";
           con.Open();
           
           SqlDataReader auditreader = new SqlCommand(sql2, con).ExecuteReader();
           int rowcounter=1;
           while (auditreader.Read())
           {
               int totnumoffinding = 0;
               int totnumofrecom = 0;
               int totnumfullrecom = 0;
               int totnumpartrecom = 0;
               int totnumnotrecom = 0;
               double totnetactval = 0;
               double totrecovered = 0;
               string totfid = "";
               double totactualvalue = 0;
               double totextravalue = 0;
               double totsaving = 0;
             
        numofcolumns = 10;
        if (flag == 0)
           {
               flag = 1;
           }
           else
           {
        %>

         <tr style="border:0px solid white"><th colspan="<%Response.Write(colspan);%>">&nbsp;</th></tr>
          <tr style="border:0px solid white"><th colspan="<%Response.Write(colspan);%>">&nbsp;</th></tr>
           <tr style="border:0px solid white"><th colspan="<%Response.Write(colspan);%>" style="border-width:0px;">&nbsp;</th></tr>
           <%} %>
       
         <tr style="background-color:#c2c9cb;color:black;font-size:16px;border-top:2px solid #c2c9cb;text-align:center"><th colspan="<%Response.Write(colspan);%>" align="center">Audit detail of audit year <%Response.Write(auditreader["year"]);%></th></tr>
         <tr><th>Auditee</th>
         <%
              //******************************************
       if(Request["c1"]=="t"){
          
       %><th>No. of findings</th><%                                                                          
       }
       if(Request["c2"]=="t"){
        
       %><th>Actual financial value of findings (ETB.)</th><%                                                                          
       }
       if(Request["c3"]=="t"){
          
       %><th>Extrapolated financial value of findings (ETB.) </th><%                                                                          
       }
       if(Request["c4"]=="t"){
        
       %><th >No. of recomm.</th><%                                                                          
       }
       if(Request["c5"]=="t"){
         
       %><th>Potential saving from recomm (ETB.)</th><%                                                                          
       }
       if(Request["c6"]=="t"){
          
       %><th>No. of fully implemented recomm.</th><%                                                                          
       }
       if(Request["c7"]=="t"){
          
       %><th>No. of partially implemented recomm.</th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
          
       %><th>No. of not implemented recomm.</th><%                                                                          
       }
      if(Request["c9"]=="t"){
          
       %><th>Recovered financial value(ETB.)</th><%                                                                          
       }
       if(Request["c10"]=="t"){
          
       %><th>Unrecovered financial value (ETB.)</th><%                                                                          
       }
       %></tr><%
     
               con2.Open();
               string sql3=sql+" and year="+auditreader["year"];
               // reading audits for each ministries
               SqlDataReader auditreader2 = new SqlCommand(sql3, con2).ExecuteReader();
               while (auditreader2.Read()) {
                   int numoffinding = 0;
                   int numofrecom = 0;
                   int numfullrecom = 0;
                   int numpartrecom = 0;
                   int numnotrecom = 0;
                   double netactval = 0;
                   double recovered = 0;
                   double actualvalue = 0;
                   string fid = "";
                   double extravalue = 0;
                   double saving = 0;
                   string minname = "";
                  
                   con4.Open();
                   // reading ministries
                   SqlDataReader minnamereader = new SqlCommand("select orgName from org_Table where orgId=" + (int)auditreader2["orgId"], con4).ExecuteReader();
                   while (minnamereader.Read())
                   {
                       minname = minnamereader["orgName"].ToString();
                   }
                   con4.Close();
                   con3.Open();
                   SqlDataReader findingreader = new SqlCommand("select * from finding_Table where auditId=" + (int)auditreader2["auditId"], con3).ExecuteReader();
                   while (findingreader.Read()) {
                       try
                       {
                           numoffinding++;
                           totnumoffinding++;
                           actualvalue += double.Parse(findingreader["actualValue"].ToString());
                           extravalue += double.Parse(findingreader["extraValue"].ToString());
                           totfid += findingreader["findingId"] + ";";
                           fid += findingreader["findingId"] + ";";
                           netactval += double.Parse(findingreader["netactValue"].ToString());
                           totnetactval += double.Parse(findingreader["netactValue"].ToString());
                           totactualvalue += double.Parse(findingreader["actualValue"].ToString());
                           totextravalue += double.Parse(findingreader["extraValue"].ToString());
                       }
                       catch (Exception ex)
                       {

                       }
                   }
                  con3.Close();

                  con3.Open();
                  SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where auditId=" + (int)auditreader2["auditId"], con3).ExecuteReader();
                  while (recomreader.Read()) {
                      numofrecom++;
                      totnumofrecom++;
                      if (recomreader["status"].ToString() == "1")
                      {
                          numnotrecom++;
                          totnumnotrecom++;
                      }
                      else if (recomreader["status"].ToString() == "2")
                      {
                          numpartrecom++;
                          totnumpartrecom++;
                      }
                      else
                      {
                          numfullrecom++;
                          totnumfullrecom++;
                      }
                      saving += double.Parse(recomreader["potSaving"].ToString());
                      totsaving += double.Parse(recomreader["potSaving"].ToString());
                  }
                  con3.Close();
                  con3.Open();

                  SqlDataReader recvaluereader = new SqlCommand("select recoveredvalue from actiontaken_Table where auditId=" + auditreader2["auditId"], con3).ExecuteReader();
                  while (recvaluereader.Read())
                  {
                      if (recvaluereader["recoveredvalue"].ToString() != "" && recvaluereader["recoveredvalue"].ToString() != "0")
                      {
                          recovered += double.Parse(recvaluereader["recoveredvalue"].ToString());
                          totrecovered += double.Parse(recvaluereader["recoveredvalue"].ToString());
                      }
                  }
                  con3.Close();
                      %>
          <tr><th><%Response.Write(minname);%></th>
        <%
              
       //******************************************
       if(Request["c1"]=="t"){
          
       %><th><a href="#" onclick="openfinding('<%Response.Write(fid);%>')"><%Response.Write(numoffinding);%></a></th><%                                                                          
       }
       if(Request["c2"]=="t"){
          
       %><th><%Response.Write(actualvalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c3"]=="t"){
        
       %><th><%Response.Write(extravalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c4"]=="t"){
         
       %><th><%Response.Write(numofrecom);%></th><%                                                                          
       }
       if(Request["c5"]=="t"){
          
       %><th><%Response.Write(saving.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c6"]=="t"){
         
       %><th><%Response.Write(numfullrecom);%></th><%                                                                          
       }
       if(Request["c7"]=="t"){
          
       %><th><%Response.Write(numpartrecom);%></th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
         
       %><th><%Response.Write(numnotrecom);%></th><%                                                                          
       }
      if(Request["c9"]=="t"){
          
       %><th><%Response.Write(recovered.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c9"]=="t"){
          
       %><th><%Response.Write((actualvalue-recovered).ToString("#,0.00"));%></th><%                                                                          
       }
       %></tr><%
                   
               }
               con2.Close();
              
               rowcounter++;
                   %>
        <tr style="background-color:#ddeeee;font-size:larger"><th>Total</th>
        <%
              
       //******************************************
       if(Request["c1"]=="t"){
          
       %><th><a href="#" onclick="openfinding('<%Response.Write(totfid);%>')"><%Response.Write(totnumoffinding);%></a></th><%                                                                          
       }
       if(Request["c2"]=="t"){
          
       %><th><%Response.Write(totactualvalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c3"]=="t"){
        
       %><th><%Response.Write(totextravalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c4"]=="t"){
         
       %><th><%Response.Write(totnumofrecom);%></th><%                                                                          
       }
       if(Request["c5"]=="t"){
          
       %><th><%Response.Write(totsaving.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c6"]=="t"){
         
       %><th><%Response.Write(totnumfullrecom);%></th><%                                                                          
       }
       if(Request["c7"]=="t"){
          
       %><th><%Response.Write(totnumpartrecom);%></th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
         
       %><th><%Response.Write(totnumnotrecom);%></th><%                                                                          
       }
      if(Request["c9"]=="t"){
          
       %><th><%Response.Write(totrecovered.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c10"]=="t"){
          
       %><th><%Response.Write((totactualvalue-totrecovered).ToString("#,0.00"));%></th><%                                                                          
       }
       %></tr><%
           }
       rowno = rowcounter;
            
           con.Close();
   }

   }
   catch(Exception ex){
   
   }
 %>
 </table></center>
 </div>
 <input type="hidden" id="hiddencolumn" value="<%Response.Write(numofcolumns);%>">
  <input type="hidden" id="hiddenrow" value="<%Response.Write(rowno-1);%>">

 <!--**********************-Detail********************-->

</body>
</html>
