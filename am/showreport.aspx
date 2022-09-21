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
<body style="color:Black !important">
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
  if (grpby == "0") {
      setgrp = "ምንም";
   }
  if (grpby == "finding") {
      setgrp = "በ ግኝት አይነት";
  }
  if (grpby == "auditee") { 
      setgrp="በ ተገምጋሚ ድርጅት";
  }
  if (grpby == "year") {
      setgrp = "በ ኦዲት አመት";
  }
  if (setaudittype == "0") {
      setaudittype = "ሁለንም የኦዲት አይነት";
  }
  string setfilter = "ግኝት እና ማሻሻያ ሃሳብ";
  if (filterby == "finding") {
      setfilter = "ግኝት";
  }
  if (filterby == "recomm") {
      setfilter = "ማሻሻያ ሃሳብ";
  }

  if (yeartype == "on")
  {
      setyear = Request["onyear"];
      if (setyear == "0") {
          setyear = "ሁሉንም አመት";
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
<tr  align="center" style=""><th colspan="4"><h4 style="display:inline"><u>ቅንብር</u></h4></th></tr>
<tr><td>ዳይሬክቶሬት:</td><td><%Response.Write(setminname);%></td><td>ተገምጋሚ ድርጅት:</td><td><%Response.Write(setorgname);%></td></tr>
<tr><td>የኦዲት አይነት:</td><td><%Response.Write(setaudittype);%></td><td>የኦዲት ዓ/ም:</td><td><%Response.Write(setyear);%></td></tr>
<tr><td>ዝርዝር እይታ:</td><td><%Response.Write(setfilter);%></td><td>ምድብ:</td><td><%Response.Write(setgrp);%></td></tr>
</table>
<ul class="nav nav-tabs" style="border-bottom:1px solid #c2c9cb"><li><a class="btn btn-link btn-sm"style="cursor:pointer;background-color:#c2c9cb;color:black;border-radius:0px;" onclick="$('#hidmenu').slideToggle();" ><span class="glyphicon glyphicon-share"></span>አዉጣ</a>
<ul class="dropdown-menu"style="display:none;border:1px solid #c2c9cb" id="hidmenu">
<li><a style="cursor:pointer;" onclick="exporttoexcel();$('#hidmenu').slideUp();"><span class="glyphicon glyphicon-th"></span> ወደ Excel</a></li>
<li><a style="cursor:pointer;" onclick="enterTitle();$('#hidmenu').slideUp();"><span class="glyphicon glyphicon-book"></span> አትም</a></li>
</ul>
</li><li><a style="cursor:pointer;font-weight:bolder;background-color:#ddeeee" onclick="showsetting()">ማጠቃለያ ፎርማት</a></li><li><a style="cursor:pointer;width:100%" onclick="showsettingListFormat()">ዝርዝር ፎርማት</a></li>
</ul><br>
<table class="table table-hover"><tr style="background-color:#c2c9cb;color:black;font-size:16px;text-align:center"><th>ማጠቃለያ ሪፖርት</th>
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

       
       //*********** Group by Auditee*****
   
   if(grpby=="auditee"){
      numofcolumns=1;
       %>
          <tr><th id="h1">ተገምጋሚ ድርጅት</th>
        <%
       
       //******************************************
       if(Request["c1"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የግኝት ብዛት</th><%                                                                          
       }
       if(Request["c2"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የግኝቶች ትክክለኛ የፋይናንስ እሴት (ETB.)</th><%                                                                          
       }
       if(Request["c3"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ግምታዊ የተደረጉ የግኝቶች ዋጋ (ETB.) </th><%                                                                          
       }
       if(Request["c4"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የማሻሻያ ሃሳብ ብዛት</th><%                                                                          
       }
       if(Request["c5"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የማሻሻያ ሃሳብ ግምታዊ ዋጋ (ETB.)</th><%                                                                          
       }
       if(Request["c6"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ሙሉ በሙሉ ተግባራዊ የሆኑ ማሻሻያ ሃሳቦች ብዛት</th><%                                                                          
       }
       if(Request["c7"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">በከፊል ተግባራዊ የሆኑ ማሻሻያ ሃሳቦች ብዛት</th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ያልተተገበሩ ማሻሻያ ሃሳቦች ብዛት</th><%                                                                          
       }
      if(Request["c9"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የተመለሰ የፋይናንስ እሴት(ETB.)</th><%                                                                          
       }
       if(Request["c10"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ያልተመለሰ የፋይናንስ እሴት (ETB.)</th><%                                                                          
       }
       %></tr><%
      
     
           string sql2=sql.Replace("*","orgId");
           sql2+=" group by orgId";
           con.Open();
           int totnumoffinding = 0;
           int totnumofrecom = 0;
           int totnumfullrecom = 0;
           int totnumpartrecom = 0;
           int totnumnotrecom = 0;
           
           string totfid = "";
           double totrecovered = 0;
           double totnetactval = 0;
           double totactualvalue = 0;
           double totextravalue = 0;
           double totsaving = 0;
           SqlDataReader auditreader = new SqlCommand(sql2, con).ExecuteReader(); 
           int rowcounter = 1;
           while (auditreader.Read())
           {
               int numoffinding = 0;
               int numofrecom = 0;
               int numfullrecom = 0;
               int numpartrecom = 0;
               int numnotrecom = 0;
               double recovered = 0;
               double netactval = 0;
               double actualvalue = 0;
               double extravalue = 0;
               double saving = 0;
               string minname = "";
               string fid = "";
               con2.Open();
               // reading ministries
               SqlDataReader minnamereader = new SqlCommand("select orgName from org_Table where orgId=" + (int)auditreader["orgId"], con2).ExecuteReader();
               while (minnamereader.Read()) {
                   minname = minnamereader["orgName"].ToString();
               }
               con2.Close();
               con2.Open();
               string sql3=sql+" and orgId="+auditreader["orgId"];
               // reading audits for each Organization
               SqlDataReader auditreader2 = new SqlCommand(sql3, con2).ExecuteReader();
               while (auditreader2.Read()) {
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
                   fid += "0";
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
                
                  SqlDataReader recvaluereader = new SqlCommand("select recoveredvalue from actiontaken_Table where auditId=" +auditreader2["auditId"], con3).ExecuteReader();
                  while (recvaluereader.Read())
                   {
                      if (recvaluereader["recoveredvalue"].ToString() != "" && recvaluereader["recoveredvalue"].ToString() != "0")
                       {
                              recovered += double.Parse(recvaluereader["recoveredvalue"].ToString());
                              totrecovered += double.Parse(recvaluereader["recoveredvalue"].ToString());
                        }
                      }
                      con3.Close();
                 
               }
               con2.Close();
               numofcolumns = 1;
        %>
          <tr><th id="hd1<%Response.Write(rowcounter);%>"><%Response.Write(minname);%></th>
        <%
              
       //******************************************
       if(Request["c1"]=="t"){
           numofcolumns++;
       %><th><a href="#" onclick="openfinding('<%Response.Write(fid);%>')"><p id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(numoffinding);%></p></a></th><%                                                                          
       }
       if(Request["c2"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(actualvalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c3"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(extravalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c4"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(numofrecom);%></th><%                                                                          
       }
       if(Request["c5"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(saving.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c6"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(numfullrecom);%></th><%                                                                          
       }
       if(Request["c7"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(numpartrecom);%></th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(numnotrecom);%></th><%                                                                          
       }
      if(Request["c9"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(recovered.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c10"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write((actualvalue-recovered).ToString("#,0.00"));%></th><%                                                                          
       }
       %></tr><%
             
               rowcounter++;
           }
           rowno = rowcounter;
           totfid += "0";
           // **************TOTAL********************
                numofcolumns = 1;
        %>
          <tr style="background-color:#ddeeee;font-size:larger"><th>ድምር</th>
        <%
              
       //******************************************
       if(Request["c1"]=="t"){
           numofcolumns++;
       %><th><a href="#" onclick="openfinding('<%Response.Write(totfid);%>')"><%Response.Write(totnumoffinding);%></a></th><%                                                                          
       }
       if(Request["c2"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totactualvalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c3"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totextravalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c4"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumofrecom);%></th><%                                                                          
       }
       if(Request["c5"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totsaving.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c6"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumfullrecom);%></th><%                                                                          
       }
       if(Request["c7"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumpartrecom);%></th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumnotrecom);%></th><%                                                                          
       }
      if(Request["c9"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totrecovered.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c10"]=="t"){
           numofcolumns++;
       %><th><%Response.Write((totactualvalue-totrecovered).ToString("#,0.00"));%></th><%                                                                          
       }
       %></tr><%
           con.Close();
       
       
   }
   else if (grpby == "finding")
   {
    numofcolumns=1;
       %>
          <tr><th id="h1">የግኝት አይነት</th>
        <%
       
       //******************************************
       if(Request["c1"]=="t"){
           numofcolumns++;
           
       %> <th id="h<%Response.Write(numofcolumns);%>">የግኝት ብዛት</th><%                                                                          
       }
       if(Request["c2"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የማሻሻያ ሃሳብ ግምታዊ ዋጋ (ETB.)</th><%                                                                          
       }
       if(Request["c3"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ግምታዊ የተደረጉ የግኝቶች ዋጋ (ETB.) </th><%                                                                          
       }
       if(Request["c4"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የማሻሻያ ሃሳብ ብዛት</th><%                                                                          
       }
       if(Request["c5"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የማሻሻያ ሃሳብ ግምታዊ ዋጋ (ETB.)</th><%                                                                          
       }
       if(Request["c6"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ሙሉ በሙሉ ተግባራዊ የሆኑ ማሻሻያ ሃሳቦች ብዛት</th><%                                                                          
       }
       if(Request["c7"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">በከፊል ተግባራዊ የሆኑ ማሻሻያ ሃሳቦች ብዛት</th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ያልተተገበሩ ማሻሻያ ሃሳቦች ብዛት</th><%                                                                          
       }
      if(Request["c9"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የተመለሰ የፋይናንስ እሴት (ETB.)</th><%                                                                          
       }
       if(Request["c10"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ያልተመለሰ የፋይናንስ እሴት (ETB.)</th><%                                                                          
       }
       %></tr><%
      
       int totnumoffinding = 0;
       int totnumofrecom = 0;
       int totnumfullrecom = 0;
       int totnumpartrecom = 0;
       int totnumnotrecom = 0;
       double totnetactval = 0;
       string totfid = "";
       double totactualvalue = 0;
       double totrecovered = 0;
       double totextravalue = 0;
       double totsaving = 0;
       con.Open();
       SqlDataReader findingtypereader = new SqlCommand("select * from findingType_Table", con).ExecuteReader();
       int rowcounter = 1;
       while (findingtypereader.Read())
       {
           int numoffinding = 0;
           int numofrecom = 0;
           int numfullrecom = 0;
           int numpartrecom = 0;
           int numnotrecom = 0;
           double netactval = 0;
           string fid = "";
           double actualvalue = 0;
           double recovered = 0;
           double extravalue = 0;
           double saving = 0;
           con2.Open();
           SqlDataReader auditreader = new SqlCommand(sql, con2).ExecuteReader();
           while (auditreader.Read())
           {
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
              
           }
           con2.Close();
           fid += "0";
           if (numoffinding > 0)
           { 
             numofcolumns = 1;
        %>
          <tr><th id="hd1<%Response.Write(rowcounter);%>"><%Response.Write(findingtypereader["findingType"]);%></th>
        <%
              
       //******************************************
       if(Request["c1"]=="t"){
           numofcolumns++;
       %><th><a href="#" onclick="openfinding('<%Response.Write(fid);%>')"><span id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(numoffinding);%></span></a></th><%                                                                          
       }
       if(Request["c2"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(actualvalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c3"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(extravalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c4"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(numofrecom);%></th><%                                                                          
       }
       if(Request["c5"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(saving.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c6"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(numfullrecom);%></th><%                                                                          
       }
       if(Request["c7"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(numpartrecom);%></th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(numnotrecom);%></th><%                                                                          
       }
      if(Request["c9"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(recovered.ToString("#,0.00"));%></th><%                                                                          
       }
      if(Request["c10"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write((actualvalue-recovered).ToString("#,0.00"));%></th><%                                                                          
       }
       %></tr><%
             
                 rowcounter++;
           }
           rowno = rowcounter;
          
       }
         // **************TOTAL********************
                numofcolumns = 1;
                totfid += "0";
        %>
          <tr style="background-color:#ddeeee;font-size:larger"><th>ድምር</th>
        <%
              
       //******************************************
       if(Request["c1"]=="t"){
           numofcolumns++;
       %><th><a href="#" onclick="openfinding('<%Response.Write(totfid);%>')"><%Response.Write(totnumoffinding);%></a></th><%                                                                          
       }
       if(Request["c2"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totactualvalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c3"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totextravalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c4"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumofrecom);%></th><%                                                                          
       }
       if(Request["c5"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totsaving.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c6"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumfullrecom);%></th><%                                                                          
       }
       if(Request["c7"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumpartrecom);%></th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumnotrecom);%></th><%                                                                          
       }
      if(Request["c9"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totrecovered.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c10"]=="t"){
           numofcolumns++;
       %><th><%Response.Write((totactualvalue-totrecovered).ToString("#,0.00"));%></th><%                                                                          
       }
       %></tr><%
       con.Close();

   }
   //***** group by year****************************
   else if (grpby == "year") {
             numofcolumns=1;
       %>
          <tr><th id="h1">የኦዲት ዓ/ም</th>
        <%
       
       //******************************************
       if(Request["c1"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የግኝት ብዛት</th><%                                                                          
       }
       if(Request["c2"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የግኝቶች ትክክለኛ የፋይናንስ እሴት (ETB.)</th><%                                                                          
       }
       if(Request["c3"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ግምታዊ የተደረጉ የግኝቶች ዋጋ (ETB.) </th><%                                                                          
       }
       if(Request["c4"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የማሻሻያ ሃሳብ ብዛት</th><%                                                                          
       }
       if(Request["c5"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የማሻሻያ ሃሳብ ግምታዊ ዋጋ (ETB.)</th><%                                                                          
       }
       if(Request["c6"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ሙሉ በሙሉ ተግባራዊ የሆኑ ማሻሻያ ሃሳቦች ብዛት</th><%                                                                          
       }
       if(Request["c7"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">በከፊል ተግባራዊ የሆኑ ማሻሻያ ሃሳቦች ብዛት</th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ያልተተገበሩ ማሻሻያ ሃሳቦች ብዛት</th><%                                                                          
       }
      if(Request["c9"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የተመለሰ የፋይናንስ እሴት (ETB.)</th><%                                                                          
       }
        if(Request["c10"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ያልተመለሰ የፋይናንስ እሴት (ETB.)</th><%                                                                          
       }
       %></tr><%
    string sql2=sql.Replace("*","year");
           sql2+=" group by year";
           con.Open();
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
           SqlDataReader auditreader = new SqlCommand(sql2, con).ExecuteReader();
           int rowcounter=1;
           while (auditreader.Read())
           {
               int numoffinding = 0;
               int numofrecom = 0;
               int numfullrecom = 0;
               int numpartrecom = 0;
               int numnotrecom = 0;
               double netactval = 0;
               string fid = "";
               double actualvalue = 0;
               double recovered = 0;
               double extravalue = 0;
               double saving = 0;
               string minname = "";
               
               con2.Open();
               string sql3=sql+" and year="+auditreader["year"];
               // reading audits for each ministries
               SqlDataReader auditreader2 = new SqlCommand(sql3, con2).ExecuteReader();
               while (auditreader2.Read()) {
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
                           totfid += findingreader["findingId"] +";";
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
               }
               con2.Close();
              
             numofcolumns = 1;
             fid += "0";
        %>
          <tr><th id="hd1<%Response.Write(rowcounter);%>"><%Response.Write(auditreader["year"]);%></th>
        <%
              
       //******************************************
       if(Request["c1"]=="t"){
           numofcolumns++;
       %><th ><a href="#" onclick="openfinding('<%Response.Write(fid);%>')"><span id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(numoffinding);%></span></a></th><%                                                                          
       }
       if(Request["c2"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(actualvalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c3"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(extravalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c4"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(numofrecom);%></th><%                                                                          
       }
       if(Request["c5"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(saving.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c6"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(numfullrecom);%></th><%                                                                          
       }
       if(Request["c7"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(numpartrecom);%></th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(numnotrecom);%></th><%                                                                          
       }
      if(Request["c9"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write(recovered.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c10"]=="t"){
           numofcolumns++;
       %><th id="hd<%Response.Write(numofcolumns+""+rowcounter);%>"><%Response.Write((actualvalue-recovered).ToString("#,0.00"));%></th><%                                                                          
       }
       %></tr><%
             
               rowcounter++;
           }
       rowno = rowcounter;
                 numofcolumns = 1;
                 totfid += "0";
        %>
          <tr style="background-color:#ddeeee;font-size:larger"><th>ድምር</th>
        <%
              
       //******************************************
       if(Request["c1"]=="t"){
           numofcolumns++;
       %><th><a href="#" onclick="openfinding('<%Response.Write(totfid);%>')"><%Response.Write(totnumoffinding);%></a></th><%                                                                          
       }
       if(Request["c2"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totactualvalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c3"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totextravalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c4"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumofrecom);%></th><%                                                                          
       }
       if(Request["c5"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totsaving.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c6"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumfullrecom);%></th><%                                                                          
       }
       if(Request["c7"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumpartrecom);%></th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumnotrecom);%></th><%                                                                          
       }
      if(Request["c9"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totrecovered.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c10"]=="t"){
           numofcolumns++;
       %><th><%Response.Write((totactualvalue-totrecovered).ToString("#,0.00"));%></th><%                                                                          
       }
       %></tr><%
           con.Close();
   }
   else
   {
       numofcolumns=2;
       %>
          <tr><th id="h1">የኦዲት ዓ/ም</th><th id="h2">ተገምጋሚ ድርጅት</th>
        <%
       
       //******************************************
       if(Request["c1"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የግኝት ብዛት</th><%                                                                          
       }
       if(Request["c2"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የግኝቶች ትክክለኛ የፋይናንስ እሴት(ETB.)</th><%                                                                          
       }
       if(Request["c3"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ግምታዊ የተደረጉ የግኝቶች ዋጋ(ETB.) </th><%                                                                          
       }
       if(Request["c4"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የማሻሻያ ሃሳብ ብዛት</th><%                                                                          
       }
       if(Request["c5"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የማሻሻያ ሃሳብ ግምታዊ ዋጋ (ETB.)</th><%                                                                          
       }
       if(Request["c6"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ሙሉ በሙሉ ተግባራዊ የሆኑ ማሻሻያ ሃሳቦች ብዛት</th><%                                                                          
       }
       if(Request["c7"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">በከፊል ተግባራዊ የሆኑ ማሻሻያ ሃሳቦች ብዛት</th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ያልተተገበሩ ማሻሻያ ሃሳቦች ብዛት</th><%                                                                          
       }
      if(Request["c9"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">የተመለሰ የፋይናንስ እሴት(ETB.)</th><%                                                                          
       }
       if(Request["c10"]=="t"){
           numofcolumns++;
       %><th id="h<%Response.Write(numofcolumns);%>">ያልተመለሰ የፋይናንስ እሴት (ETB.)</th><%                                                                          
       }
       %></tr><%
       
       string  sql2= sql+" order by year desc";
       con.Open();
       int totnumoffinding = 0;
       int totnumofrecom = 0;
       int totnumfullrecom = 0;
       int totnumpartrecom = 0;
       int totnumnotrecom = 0;
       double totnetactval = 0;
       double totrecovered = 0;
       double totactualvalue = 0;
       double totextravalue = 0;
       string totfid = "";
       double totsaving = 0;
       SqlDataReader auditreader = new SqlCommand(sql2, con).ExecuteReader();
       while (auditreader.Read())
       {
            int numoffinding = 0;
               int numofrecom = 0;
               int numfullrecom = 0;
               int numpartrecom = 0;
               int numnotrecom = 0;
               double netactval = 0;
               double recovered=0;
               double actualvalue = 0;
               double extravalue = 0;
               string fid = "";
               double saving = 0;
               string orgname = "";
           con3.Open();
           SqlDataReader findingreader = new SqlCommand("select * from finding_Table where auditId=" + (int)auditreader["auditId"], con3).ExecuteReader();
           while (findingreader.Read())
           {
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
           SqlDataReader orgnamereader = new SqlCommand("select orgName from org_Table where orgId=" + (int)auditreader["orgId"], con3).ExecuteReader();
           while (orgnamereader.Read())
           {
               orgname = orgnamereader["orgName"].ToString();
           }
           con3.Close();
           con3.Open();
           SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where auditId=" + (int)auditreader["auditId"], con3).ExecuteReader();
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
           }
           con3.Close();
           con3.Open();

           SqlDataReader recvaluereader = new SqlCommand("select recoveredvalue from actiontaken_Table where auditId=" + auditreader["auditId"], con3).ExecuteReader();
           while (recvaluereader.Read())
           {
               if (recvaluereader["recoveredvalue"].ToString() != "" && recvaluereader["recoveredvalue"].ToString() != "0")
               {
                   recovered += double.Parse(recvaluereader["recoveredvalue"].ToString());
                   totrecovered += double.Parse(recvaluereader["recoveredvalue"].ToString());
               }
           }
           con3.Close();
         numofcolumns = 2;
         fid += "0";
        %>
          <tr><th><%Response.Write(auditreader["year"]);%></th>
          <th ><%Response.Write(orgname);%></th>
        <%
              
       //******************************************
       if(Request["c1"]=="t"){
           numofcolumns++;
       %><th><a href="#" onclick="openfinding('<%Response.Write(fid);%>')"><%Response.Write(numoffinding);%></a></th><%                                                                          
       }
       if(Request["c2"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(actualvalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c3"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(extravalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c4"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(numofrecom);%></th><%                                                                          
       }
       if(Request["c5"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(saving.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c6"]=="t"){
           numofcolumns++;
       %><th ><%Response.Write(numfullrecom);%></th><%                                                                          
       }
       if(Request["c7"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(numpartrecom);%></th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(numnotrecom);%></th><%                                                                          
       }
      if(Request["c9"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(recovered.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c10"]=="t"){
           numofcolumns++;
       %><th><%Response.Write((actualvalue-recovered).ToString("#,0.00"));%></th><%                                                                          
       }
       %></tr><%
                 
       }
                 numofcolumns = 2;
                 totfid += "0";
        %>
          <tr style="background-color:#ddeeee;font-size:larger"><th>ድምር</th><th>All</th>
        <%
              
       //******************************************
       if(Request["c1"]=="t"){
           numofcolumns++;
       %><th><a href="#" onclick="openfinding('<%Response.Write(totfid);%>')"><%Response.Write(totnumoffinding);%></a></th><%                                                                          
       }
       if(Request["c2"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totactualvalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c3"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totextravalue.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c4"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumofrecom);%></th><%                                                                          
       }
       if(Request["c5"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totsaving.ToString("#,0.00"));%></th><%                                                                          
       }
       if(Request["c6"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumfullrecom);%></th><%                                                                          
       }
       if(Request["c7"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumpartrecom);%></th><%                                                                          
       }
       
       if(Request["c8"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totnumnotrecom);%></th><%                                                                          
       }
      if(Request["c9"]=="t"){
           numofcolumns++;
       %><th><%Response.Write(totrecovered.ToString("#,0.00"));%></th><%                                                                          
       }
        if(Request["c10"]=="t"){
           numofcolumns++;
       %><th><%Response.Write((totactualvalue-totrecovered).ToString("#,0.00"));%></th><%                                                                          
       }
       %></tr><%
       con.Close();
   }
   }
   catch(Exception ex){
   
   }
 %>
 </table>
 <%if (grpby != "0") { 
   %><table class="table"><tr><td style="text-align:right"><button class="btn btn-primary" style="text-align:left" onclick="$('#chartdiv').slideToggle();$('#chartContainer').slideToggle();"><span class="glyphicon glyphicon-signal"></span>ገበታ አሳይ</button></td></tr></table>
    <%
   }%>
 </div>
 <input type="hidden" id="hiddencolumn" value="<%Response.Write(numofcolumns);%>">
  <input type="hidden" id="hiddenrow" value="<%Response.Write(rowno-1);%>">

 <!--**********************-Detail********************-->
 <%if (detail == "detail")
   {
       try
       {
       %>
      
    <hr>
   <table class="table table-responsive table-condensed table-bordered table-striped" border="1" style="border:1px solid #c2c9cb;color:black !important">
   <tr style="background-color:#c2c9cb;color:black"><th>ዝርዝር ግኝት እና የማሻሻያ ሃሳብ</th></tr>
   </table>
    <table class="table table-responsive table-condensed table-bordered table-striped" border="1" style="border:2px solid #c2c9cb; color:black !important">
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
                      
                      con3.Open();
       SqlDataReader findingreader = new SqlCommand("select * from finding_Table where auditId=" + (int)auditreader2["auditId"], con3).ExecuteReader();
     
       while (findingreader.Read()) {
           con4.Open();
           string findingtype = "";
           SqlDataReader ftypereader = new SqlCommand("select findingType from findingType_Table where typeId=" + (int)findingreader["findingType"], con4).ExecuteReader();
           while (ftypereader.Read()) {
               findingtype = ftypereader["findingType"].ToString();
           }
           con4.Close();
           if (filterby == "both" || filterby == "finding")
           {
        %>
        <tr style="background-color:white; border-left:2px soild #c2c9cb;border-top:3px solid #c2c9cb"><th style="width:10%"><b style="font-size:18px">ግኝት <%Response.Write(findingcounter++);%></b><br><i style="font-size:12px;color:black"><br>ተገምጋሚ ድርጅት:<br><u><%Response.Write(minname);%></u></i></th><td style="font-family:Times New Roman;text-align:justify"><%Response.Write(findingreader["findingName"]);%><br><i style="font-size:13px;"><b style="color:#33aa33">(የግኝት አይነት: <%Response.Write(findingtype);%>)</b><br><button class="btn btn-link" onclick="showinaudit(<%Response.Write(findingreader["auditId"]);%>)"><span class="glyphicon glyphicon-share"></span>በኦዲት አሳይ</button></i></td><td>ትክክለኛ የፋይናንስ እሴት<br><b><%Response.Write(Double.Parse(findingreader["actualValue"].ToString()).ToString("#,0.00"));%> ETB.</b></td><td>ግምታዊ የፋይናንስ እሴት<br><b><%Response.Write(Double.Parse(findingreader["extraValue"].ToString()).ToString("#,0.00"));%> ETB.</b></td></tr>
       
        
        <%
           }

           if (filterby == "recomm" || filterby == "both")
           { 
             %>
              <tr><td colspan="5"><center><table class="table table-responsive table-condensed table-bordered table-striped" border="1" style="width:98%;border:2px solid #c2c9cb">
             <tr style="color:#000000;border-top:"><th colspan="5"><b style="font-size:18px">ማሻሻያ ሃሳብ</b></th></tr>
               <%
           
               con4.Open();
               SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where findingId=" + (int)findingreader["findingId"], con4).ExecuteReader();
              
               while (recomreader.Read())
               {
                   int recomId = (int)recomreader["recomId"];
                   if (recomreader["status"].ToString() == "1")
                   {
              
            %>
            <tr><th style="border-top:2px "><b style="font-size:18px">ማሻሻያ ሃሳብ<%Response.Write(recomcounter++);%></b><br><i style="font-size:12px;color:black"><br>ተገምጋሚ ድርጅት:<br><u><%Response.Write(minname);%></u></i></th><td style="width:50%;color:black"><%Response.Write(recomreader["recomName"]);%><i><br><button class="btn btn-link" onclick="showinaudit(<%Response.Write(recomreader["auditId"]);%>)"><span class="glyphicon glyphicon-share"></span>በኦዲት አሳይ</button></i></td><td style="border-top:">ግምታዊ የፋይናንስ እሴት<br><%Response.Write(Double.Parse(recomreader["potSaving"].ToString()).ToString("#,0.00"));%></td>
            <td style="width:100px;background-color:"><u><b>አሁን ያለበት ሁኔታ</b></u><br>
             ያልተተገበረ
            
            </td>
            <%
                   }
                   else if (recomreader["status"].ToString() == "2")
                   { 
                   %>
            <tr><th ><b style="font-size:18px">ማሻሻያ ሃሳብ<%Response.Write(recomcounter++);%></b><br><i style="font-size:12px;color:black"><br>ተገምጋሚ ድርጅት:<br><u><%Response.Write(minname);%></u></i></th><td style="width:60%;"><%Response.Write(recomreader["recomName"]);%><i><br><button class="btn btn-link" onclick="showinaudit(<%Response.Write(findingreader["auditId"]);%>)"><span class="glyphicon glyphicon-share"></span>በኦዲት አሳይ</button></i></td><td style="border-top:;">ግምታዊ የፋይናንስ እሴት<br><%Response.Write(Double.Parse(recomreader["potSaving"].ToString()).ToString("#,0.00"));%></td>
            <td style="width:100px;border-top:;background-color:"><u><b>Current status</b></u><br>
            በከፊል የተተገበረ
            </td>
            <%
                   }
                   else
                   { 
               
             %>
            <tr><th><b style="font-size:18px">ማሻሻያ ሃሳብ<%Response.Write(recomcounter++);%></b><br><i style="font-size:12px;color:black"><br>ተገምጋሚ ድርጅት:<br><u><%Response.Write(minname);%></u></i></th><td style="width:60%;"><%Response.Write(recomreader["recomName"]);%><i><br><button class="btn btn-link" onclick="showinaudit(<%Response.Write(findingreader["auditId"]);%>)"><span class="glyphicon glyphicon-share"></span>በኦዲት አሳይ</button></i></td><td style="border-top:;">ግምታዊ የፋይናንስ እሴት<br><%Response.Write(Double.Parse(recomreader["potSaving"].ToString()).ToString("#,0.00"));%></td>
            <td style="border-top:;width:100px;background-color:"><u><b>አሁን ያለበት ሁኔታ</b></u><br>
              ሙሉ በሙሉ የተተገበረ
            </td>
            <%
                   }
            %>
            <td>የሁኔታው መጠን<br><%Response.Write(recomreader["statusExtent"]);%></td></tr>
            <tr style="background-color:"><td colspan="5"><center><table class="table table-condensed table-responsive table-bordered table-striped" border="1" style="width:98%;">
            <tr style="color:#000000;border-top:;border-bottom:"><th colspan="2">የድርጊት መርሃ ግብር</th></tr>
            <%
                   con5.Open();
                   SqlDataReader actionplanreader = new SqlCommand("select * from actionPlan_Table where recomId=" + (int)recomreader["recomId"], con5).ExecuteReader();
                   while (actionplanreader.Read())
                   {
                       if (recomreader["status"].ToString() != "3" && actionplanreader["actiondate"].ToString().CompareTo(DateTime.Now.ToString("yyyy-MM-dd")) <= 0)
                       {
                %>
                <tr><td><%Response.Write(actionplanreader["actionplan"]);%></td><td style="width:100px;background-color:#">ቀነ—ገደብ:<br><b style="color:blue"><%Response.Write(actionplanreader["actiondate"]);%></b></td></tr>
                <tr style="background-color:"><td style="color:blue !important;" colspan="2">ቀነ ገደቡ አምልጦታል</td></tr>
                <%
                       }
                       else
                       { 
                    %>
                <tr><td><%Response.Write(actionplanreader["actionplan"]);%></td><td style="width:100px;background-color:">ቀነ-ገደብ:<br><b style="color:blue"><%Response.Write(actionplanreader["actiondate"]);%></b></td></tr>
                <%
                       }
                   }
                   con5.Close();
                 %>
            </table></center></td></tr>
            <%
               }

               con4.Close();
         %>
         </table></center></td></tr>
         <%
           }  
       }
       con3.Close();
                       
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
  <%if (grpby != "0")
   {%>
   <div class="panel panel-primary" style="position:fixed;top:5px;left:50px;right:50px;padding:2px;border-width:1px;color:black !important" id="chartdiv" onmouseup="mouseUp(event)" onmousedown="mouseDown(event)">
   <div class="btn-group">
   <button class="btn btn-link" onclick="$('#chartdiv').slideToggle();$('#chartContainer').slideToggle();"><b style="color:red">ዝጋ</b></button>
   <span >&nbsp;</span>
   <button class="btn btn-link" onclick="drawgraph('bar')">Bar chart</button>
   <button class="btn btn-link" onclick="drawgraph('column')">Column chart</button>
   <button class="btn btn-link" onclick="drawgraph('line')">Line chart</button>
   <button class="btn btn-link" onclick="drawgraph('area')">Area chart</button>
   <button class="btn btn-link" onclick="drawgraph('pie')">Pie chart</button>
   <button class="btn btn-link" onclick="drawgraph('doughnut')">Doughnut chart</button>
   <button class="btn btn-link" onclick="drawgraph('scatter')">Scatter chart</button>
   <button class="btn btn-link" onclick="drawgraph('spline')">Spline chart</button>
    <button class="btn btn-link" onclick="drawgraph('splineArea')">Spline area chart</button>
   
   </div>
   <div style="background-color:#c2c9cb;height:1px;padding:0px;"></div>
   <table style="background-color:white;width:100%;font-size:12px;font-family:Times New Roman;border-bottom:1px solid #c2c9cb">
<tr  align="center" style=""><th colspan="4"><u><b>ቅንብር</b></u></th></tr>
<tr><td>ዳይሬክቶሬት:</td><td><%Response.Write(setminname);%></td><td>ተገምጋሚ ድርጅት:</td><td><%Response.Write(setorgname);%></td></tr>
<tr><td>የኦዲት አይነት:</td><td><%Response.Write(setaudittype);%></td><td>የኦዲት ዓ/ም:</td><td><%Response.Write(setyear);%></td></tr>
<tr><td>ምድብ በ</td><td><%Response.Write(setgrp);%></td></tr>
</table>

       <div style="background-color:#459fc6;height:1px;padding:0px;"></div>
  <div id="chartContainer" style="width:100%;height:400px;background-color:white;font-size:11px !important;">
 
 </div>
 </div>
 <%} %>

</body>
</html>
