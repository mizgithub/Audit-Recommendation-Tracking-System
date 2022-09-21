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
    color:black !important;
      
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
    string setminname = "ሁሉንም ዳይሬክቶሬት";
    string setorgname = "በዳያሬክቶሬቱ ዉስጥ ያሉ ሁሉንም ተገምጋሚ ድርጅቶች";
    string setaudittype = Request["selauditType"];
    string setyear = "ሁሉንም አመት";
    string setgrp = grpby;
    if (grpby == "0")
    {
        setgrp = "ምንም";
    }
    if (grpby == "finding")
    {
        setgrp = "በ ግኝት አይነት";
    }
    if (grpby == "auditee")
    {
        setgrp = "በ ተገምጋሚ ድርጅት";
    }
    if (grpby == "year")
    {
        setgrp = "በ ኦዲት አመት";
    }
    if (setaudittype == "0")
    {
        setaudittype = "ሁለንም የኦዲት አይነት";
    }
    string setfilter = "ግኝት እና ማሻሻያ ሃሳብ";
    if (filterby == "finding")
    {
        setfilter = "ግኝት";
    }
    if (filterby == "recomm")
    {
        setfilter = "ማሻሻያ ሃሳብ";
    }

    if (yeartype == "on")
    {
        setyear = Request["onyear"];
        if (setyear == "0")
        {
            setyear = "ሁሉንም አመት";
        }
    }
    else
    {
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
<tr  align="center" style=""><th colspan="4"><h4 style="display:inline"><u>ቅንብር</u></h4></th></tr>
<tr><td>ዳይሬክቶሬት:</td><td><%Response.Write(setminname);%></td><td>ተገምጋሚ ድርጅት:</td><td><%Response.Write(setorgname);%></td></tr>
<tr><td>የኦዲት አይነት:</td><td><%Response.Write(setaudittype);%></td><td>የኦዲት ዓ/ም:</td><td><%Response.Write(setyear);%></td></tr>
</table>
<ul class="nav nav-tabs" style="border-bottom:1px solid #dddddd"><li><a class="btn btn-link btn-sm"style="cursor:pointer;background-color:#c2c9cb;color:black;border-radius:0px;" onclick="$('#hidmenu').slideToggle();" ><span class="glyphicon glyphicon-share"></span>አውጣ</a>
<ul class="dropdown-menu"style="display:none;border:1px solid #c2c9cb" id="hidmenu">
<li><a style="cursor:pointer;" onclick="exporttoexcel();$('#hidmenu').slideUp();"><span class="glyphicon glyphicon-th"></span> ወደ Excel</a></li>
<li><a style="cursor:pointer;" onclick="entertitlerecomreport();$('#hidmenu').slideUp();"><span class="glyphicon glyphicon-book"></span> አትም</a></li>
</ul>
</ul><br>
<table class="table table-hover"><tr style="background-color:#c2c9cb;color:black;font-size:16px;text-align:center">
<th>
<%if (Request["status"] == "1")
  {%>
ያልተተገበሩ ማሻሻያ ሃሳቦች 
<%}
  else if (Request["status"] == "2")
  {
   %>
    በከፊል የተተገበሩ ማሻሻያ ሃሳቦች
   <%
  }
  else { 
   %>
   ሙሉ በሙሉ የተተገበሩ ማሻሻያ ሃሳቦች
   <%
  }
   %>
</th>
</tr></table>
<div  id="tableid">
 <%

   %>
   <table class="" border="1" style="border:1px solid #c2c9cb;font-size:12px;background-color:white;width:100%;" id="tbl">
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
       //*********** not yet implemented recommendations *****

       numofcolumns=2;
       %>
          <tr><th id="h1">ተገምጋሚ ድርጅት</th><th id="h2">የኦዲት ዓ/ም</th>
          <th><%if (Request["status"] == "1")
  {%>
ያልተተገበሩ ማሻሻያ ሃሳቦች ብዛት
<%}
  else if (Request["status"] == "2")
  {
   %>
  በከፊል የተተገበሩ ማሻሻያ ሃሳቦች ብዛት
   <%
  }
  else { 
   %>
  ሙሉ በሙሉ የተተገበሩ ማሻሻያ ሃሳቦች ብዛት
   <%
  }
   %></th></tr>
        <%
     
       
       string  sql2= sql+" order by year desc";
       con.Open();
      
       int totnumnotrecom = 0;
     
       SqlDataReader auditreader = new SqlCommand(sql2, con).ExecuteReader();
       while (auditreader.Read())
       {
            
               int numnotrecom = 0;
             
               string orgname = "";
       
           con3.Open();
           SqlDataReader orgnamereader = new SqlCommand("select orgName from org_Table where orgId=" + (int)auditreader["orgId"], con3).ExecuteReader();
           while (orgnamereader.Read())
           {
               orgname = orgnamereader["orgName"].ToString();
           }
           con3.Close();
           con3.Open();
           SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where auditId=" + (int)auditreader["auditId"]+" and status="+Request["status"], con3).ExecuteReader();
           while (recomreader.Read())
           {
           
              
                   numnotrecom++;
                   totnumnotrecom++;
               
             
           }
           con3.Close();
         numofcolumns = 2;
        %>
          <tr><th><%Response.Write(orgname);%></th><th><%Response.Write(auditreader["year"]);%></th><th><%Response.Write(numnotrecom);%></th></tr>
         
        <%
    
                 
       }
                 numofcolumns = 2;
        %>
          <tr style="background-color:#ddeeee;font-size:larger"><th>Total</th><th></th><th><%Response.Write(totnumnotrecom);%></th></tr>
        <%
    
       con.Close();
   
   }
   catch(Exception ex){
   
   }
 %>
 </table>

 <!--**********************-Detail********************-->
 <%if (detail == "detail")
   {
       try
       {
       %>
      
    <hr>
   <table class="table table-responsive table-condensed table-bordered table-striped" border="1" style="border:1px solid #c2c9cb">
   <tr style="background-color:#c2c9cb;color:black"><th>
<%if (Request["status"] == "1")
  {%>
 ያልተተገበሩ ማሻሻያ ሃሳቦች ዝርዝር
<%}
  else if (Request["status"] == "2")
  {
   %>
 በከፊል የተተገበሩ ማሻሻያ ሃሳቦች ዝርዝር
   <%
  }
  else { 
   %>
   ሙሉ በሙሉ የተተገበሩ ማሻሻያ ሃሳቦች ዝርዝር
   <%
  }
   %>
</th></tr>
   </table>
    <table class="table table-responsive table-condensed table-bordered table-striped" border="1" style="border:2px solid #c2c9cb;">
   <!--*********** Group by Auditee*****-->
   <%
           
            
               //***** GROUP BY MINISTRY******

           string sql2 = sql + " order by year desc";
                   con.Open();
                   int findingcounter = 1;
                   int recomcounter = 1;
                   SqlDataReader auditreader2 = new SqlCommand(sql2, con).ExecuteReader();
                   while (auditreader2.Read())
                   {
                       string minname = "";
                       con2.Open();
                       // reading ministries
                       SqlDataReader minnamereader = new SqlCommand("select orgName from org_Table where orgId=" + (int)auditreader2["orgId"], con2).ExecuteReader();
                       while (minnamereader.Read())
                       {
                           minname = minnamereader["orgName"].ToString();
                       }
                       con2.Close();
               con4.Open();
               SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where auditId=" + (int)auditreader2["auditId"]+" and status='"+Request["status"]+"'", con4).ExecuteReader();
              
               while (recomreader.Read())
               {
                   int recomId = (int)recomreader["recomId"];
                   string extent=recomreader["statusExtent"].ToString();
                  
              
            %>
            <tr><th style="border-top:2px solid #c2c9cb;"><i style="color:black;font-size:11px">የማሻሻያ ሃሳብ</i><%Response.Write(recomcounter++);%><br><i style="font-size:12px;color:black"><br>ተገምጋሚ ድርጅት:<br><u><%Response.Write(minname);%></u></i></th><td style="width:50%;border-top:2px solid #c2c9cb"><%Response.Write(recomreader["recomName"]);%><i><br><button class="btn btn-link" onclick="showinaudit(<%Response.Write(recomreader["auditId"]);%>)"><span class="glyphicon glyphicon-share"></span>በኦዲት አሳይ</button></i></td>
            <td style="border-top:2px solid #c2c9cb;width:100px;"><u><b>አሁን ያለበት ሁኔታ</b></u><br>
             <%if (Request["status"] == "1")
  {%>
 ያልተተገበረ
<%}
  else if (Request["status"] == "2")
  {
   %>
  በከፊል የተተገበረ
   <%
  }
  else { 
   %>
   ሙሉ በሙሉ የተተገበረ
   <%
  }
   %>
            </td>
            <td>የሁኔታው መጠን<br><%Response.Write(extent);%></td></tr>
            <%
               }

               con4.Close();
         %>
       
         <%
           }  
          
                   con.Close();
               
               // ************group by Organization**************
               
       
           }
       catch (Exception ex)
       {
           Response.Write(ex.StackTrace);
       }
   
 %>
   </table>
 <%}
   
    %>
 </div>
  
   
   </div>
</body>
</html>
