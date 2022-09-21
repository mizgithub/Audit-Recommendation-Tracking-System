<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>show audit</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="images/logoOFAG.png">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
    function showdetailfidingrecom(auditId) {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status) {
                $("#detailfindingrecom").html(this.responseText);
            }
        };
        http.open("GET", "Ag_showdetailfindingrecommendation.aspx?auditId="+auditId, true);
        http.send();
    }
    function makebakup() {
        $("#backupmsg").html("<p>Enter disk name to save the backup file<br> (Valid disk names are D:,F:,G:,H:  ... )." +
           "<input type='text' class='form-control' style='border:1px solid #00ff56' id='diskname'>");
        $("#buckupcontainer").slideDown();
    }
    function takebuckup() {
        var diskname = document.getElementById("diskname").value;

        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {

                $("#backupmsg").html(this.responseText);
            }
        };
        http.open("GET", "makebackup.aspx?diskname=" + diskname, true);
        http.send();
    }
        
</script>
<style>
    .affix
    {
        top:0;
        width:100%;
        }
       .affix + .container-fluid
       {
           padding-top:20px;
           }
           
         .sideb:hover
         {
             color:Black !important;
             }
</style>
</head>
<body onload="showdetailfidingrecom(<%Response.Write(Request["auditId"]);%>)" style="color:black !important">
<%
    Response.Cache.SetCacheability(HttpCacheability.NoCache);
    Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
    Response.Cache.SetNoStore();
    if (Request.Cookies["user"].Value == null || Request.Cookies["user"].Value == "" || Session["sessionID"] == null)
    {
        Response.Redirect("logout.aspx");
    }
    
      %>
 <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   SqlConnection con2 = new SqlConnection(@conString);
   int auditId = 0;
   try
   {
       auditId = int.Parse(Request["auditId"]);
   }
   catch (Exception ex) { 
   }
   String role = "", name = "", last = "";
   try
   {
       con.Open();

       SqlDataReader reader = new SqlCommand("select fname,lname,role from user_Table where username='" + Request.Cookies["user"].Value + "'", con).ExecuteReader();
       while (reader.Read())
       {
           role = reader["role"].ToString();
           name = reader["fname"].ToString();
           last = reader["lname"].ToString();
       }
       con.Close();

   }
   catch (Exception e)
   {
       Response.Write(e.Message);
   }
   %>
    <div class="" style="height:70px;">
   
     <img src="images/logoimg.png" style="height:70px;" class="btn-block img-responsive"/>
    
     </div>
     <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../am/admin_showaudits.aspx?auditId=<%Response.Write(Request["auditId"]); %>"><img src="images/et.png" width="20" height="10"/>አማርኛ</a></div>
   <div class="row">
    <div class="col-sm-2" style="overflow:auto;padding-right:0px;">
    <div class="panel panel-default" style="background-color:#c2c9cb; height:1200px;border-right:1px solid black">
        <div class="navbar navbar-default">
            <ul class="nav sidebar-nav btn-primary ">
            <li style="border-bottom: 2px solid #ffffff;"><a href="admin_audits.aspx" style="background-color:#c2c9cb;"><b style="color:black;">Audits</b></a></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="admin_setting.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">Setting</b></a></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="adminreport.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">Report</a></b></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="adminactionplanfile.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">Uploaded action plan files</a></b></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="adminactiontakenfile.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">Uploaded action taken files</a></b></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="admin_accountsetting.aspx" style="background-color:#c2c9cb;"><b style="color:black;">Account setting</b></a></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="admin_activitylog.aspx" style="background-color:#c2c9cb;"><b style="color:black;">Activity log</b></a></li>
            <li style="border-bottom: 2px solid #ffffff;border-color:#ffffff"><a href="admin_userManagement.aspx" style="background-color:#c2c9cb;"><b style="color:black;">User management</b></a></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="#" style="background-color:#c2c9cb;" onclick="makebakup()"><b style="color:black;">Take backup</b></a></li>
            </ul>
        </div>
        </div>
    </div>
    <div class="col-sm-10" style="padding-left:0px;height:1200px;overflow:auto;">
    <!--  *******TOP Nagigation bar-->
    <div class="">
     <div class="navbar navbar-inverse"  data-offset-top="70" style="background-color:#c2c9cb;z-index:100; border-radius:0px; border-width:0px;height:40px;">
     <div class="navbar-header">
    <a href="admin_home.aspx" class="navbar-brand" style="color:black"><b>Home</b></a>
     </div>
     <div class="navbar-header">
    <a href="admin_auditees.aspx" class="navbar-brand" style="color:black"><b>Auditees</b></a>
     </div>
     <div class="navbar-header">
    <a href="admin_aboutOfag.aspx" class="navbar-brand" style="color:black"><b>About OFAG</b></a>
     </div>
     <div class="navbar-header">
     <p class="navbar-brand">Logged as <%Response.Write(name);%>&nbsp<%Response.Write(last); %> <i>[<%Response.Write(role); %>]</i></p>
     </div>
     <div class="navbar-header">
     <p class="navbar-brand">|</p>
     </div>
     <div class="navbar-header" align="right">
    <a href="logout.aspx" class="navbar-brand" style="color:black"><b>Logout</b></a>
     </div>
    
    </div>
    </div>
    <!--************************************************-->
      <table class="table table-responsive table-condensed">
      <tr style="color:black"><th colspan="2" style="font-size:16px;">Audit information</th></tr>
      <%string remark = "";
        string opinion = "";
          try
          {
              con.Open();
              SqlDataReader auditreader = new SqlCommand("select * from audit_Table where auditId=" +auditId, con).ExecuteReader();
              while (auditreader.Read()) {
                  remark = auditreader["remark"].ToString();
                  opinion = auditreader["auditeeopinion"].ToString();
                  string orgname = "";
                  con2.Open();
                  SqlDataReader orgreader = new SqlCommand("select orgName from org_Table where orgId=" + (int)auditreader["orgId"], con2).ExecuteReader();
                  while (orgreader.Read()) {
                      orgname = orgreader["orgName"].ToString();
                  }
                  con2.Close();
                  %>
                  <tr><th style="width:10%">Audit title</th><td><%Response.Write(auditreader["auditName"]);%></td></tr>
                  <tr><th>Auditee</th><td><%Response.Write(orgname);%></td></tr>
                  <tr><th>Audit type</th><td><%Response.Write(auditreader["auditType"]);%></td></tr>
                  
                  <tr><th>Audit year</th><td><%Response.Write(auditreader["year"]);%></td></tr>
                  <tr><th>Audit period</th><td><%Response.Write("<u>"+auditreader["startdate"]+"</u>---<u>"+auditreader["enddate"]+"</u>");%></td></tr>    
                  <tr><th>Followup date</th><td><%Response.Write(auditreader["followupdate"]);%></td></tr>
                  <tr><td colspan="2"><hr></td></tr>
                  <%
              }
              con.Close();
          }
          catch (Exception ex) {
              Response.Write(ex.Message);
          }
                      try
                      {
                       con.Open();
                          SqlDataReader auditorreader = new SqlCommand("select * from auditor_Table where auditId=" + auditId, con).ExecuteReader();
                          while (auditorreader.Read()) { 
                           %>
                           <tr><th>Auditor</th><td><%Response.Write(auditorreader["fname"] + " " + auditorreader["lname"] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>Rank: <U>" + auditorreader["rank"] + "</u> </i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>Directorate <u>" + auditorreader["directorate"] + "</u></i>");%></td></tr>
                           <%
                          }
                          con.Close();
                          con.Open();
                          %>
                           <tr><th>Reviewd by</th><td>
                          <%
                          SqlDataReader revreader = new SqlCommand("select * from reviewer_Table where auditId=" + auditId, con).ExecuteReader();
                          int revcounter = 1;
                          while (revreader.Read()) {
                              Response.Write(revcounter+++". "+revreader["fname"] + " " + revreader["lname"] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>Rank: " + revreader["rank"] + "</i>&nbsp;&nbsp;&nbsp;<i>date:" + revreader["date"] + "<br>");
                          }
                          con.Close();
                          %>
                          </td></tr>
                          <%
                      }
                      catch (Exception ex) {
                          con.Close();
                          Response.Write(ex.Message);
                      }
           %>
            <tr><th>Auditee opinion</th><td><%Response.Write(opinion);%></td></tr>
           <tr><th>Auditor Remark</th><td><%Response.Write(remark);%></td></tr>
           <tr><td colspan="2"><hr></td></tr>
           <%try {
                 con.Open();
                 SqlDataReader nextstepreader = new SqlCommand("select * from auditorNextStep_Table where auditId=" +auditId, con).ExecuteReader();
                 while (nextstepreader.Read()) { 
                    %>
                    <tr><th>Auditor next step</th><td><%Response.Write(nextstepreader["nextstep"]);%></td></tr>
                    <tr><th>Auditor asigned to initiate next step</th><td><%Response.Write(nextstepreader["audfname"]+" "+nextstepreader["audlname"]);%></td></tr> 
                    <tr><th>Action taken by auditor</th><td><%Response.Write(nextstepreader["actiontaken"]);%></td></tr>
                    <%
                 }
                 con.Close(); 
             }
             catch(Exception ex){
                 con.Close();
             } %>
      </table>
        <table class="table table-condensed table-responsive">
        <tr style="color:black"><th colspan="5" style="font-size:16px;">Findings and recommendations</th></tr>
        <%try
          {
              con.Open();
              int nooffinding = 0;
              Double sumofactualvalue = 0.00;
              Double sumofextravalue = 0.00;
              SqlDataReader findingreader1 = new SqlCommand("select * from finding_Table where auditId=" + auditId, con).ExecuteReader();
              while (findingreader1.Read()) {
                  nooffinding++;
                  sumofactualvalue += Double.Parse(findingreader1["actualValue"].ToString());
                  sumofextravalue += Double.Parse(findingreader1["extraValue"].ToString());
              }
               
              con.Close();
              %>
              <tr ><th colspan="5">Findings</th></tr>
              <tr><th>Total number of findings</th><th>Total Actual financial value of findings</th><th>Total Extrapolated financial value of findings</th><th></th><th></th></tr>
              <tr><td><%Response.Write(nooffinding);%></td><td><%Response.Write(sumofactualvalue);%> <b>ETB.</b></td><td><%Response.Write(sumofextravalue);%> <b>ETB.</b></td><td></td><td></td></tr>
               <%
              con.Open();
              int numofrecom = 0;
              Double saving = 0.00;
              int numfully = 0;
              int numpartly = 0;
              int numnot = 0;
              SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where auditId="+auditId,con).ExecuteReader();
              while (recomreader.Read()) {
                  numofrecom++;
                  saving += Double.Parse(recomreader["potSaving"].ToString());
                  if (recomreader["status"].ToString() == "1") {
                      numnot++;
                  }
                  else if (recomreader["status"].ToString() == "2")
                  {
                      numpartly++;
                  }
                  else {
                      numfully++;
                  }
              }
              con.Close();
               %>
                <tr style="background-color"><th colspan="5">Recommendations</th></tr>
              <tr><th>Total number of recommendations</th><th>Total Potential saving from the recommendations</th><th style="">Total Fully implemented recommendations</th><th style="background-color:">Total partially implemented recommendations</th><th style="background-color">Total not implemented recommendations</th></tr>
              <tr><td><%Response.Write(numofrecom);%></td><td><%Response.Write(saving);%> <b>ETB.</b></td><td style=""><%Response.Write(numfully);%></td><td style="background-color:"><%Response.Write(numpartly);%></td><td style="background-color"><%Response.Write(numnot);%></td></tr>
               <%
              
          }
          catch (Exception ex) {
              Response.Write(ex.Message);
          }
            
             %>
        </table>
         <div id="detailfindingrecom">

         </div>
      
         </div>
         </div>
        <div class="panel panel-success"style="position:fixed;top:300px;left:10px;width:500px;height:250px;display:none;z-index:10;border:1px solid #02c9cb" id="buckupcontainer">
          <div class="panel-footer" style="background-color:#c2c9cb;height:20%;border:1px solid #c2c9cb">
          <p style="color:black"><span class="glyphicon glyphicon-floppy-disk"></span>Backup Message</p>
          </div>
          <div class="panel-body" id="backupmsg" style="height:60%">
            
          </div>
          <div class="panel-footer" style="background-color:#c2c9cb;height:20%;text-align:right;border:1px solid #c2c9cb">
          <button class="btn-primary" onclick='takebuckup()' style="width:100px">Ok</button>
          <button class="btn-primary" style="color:white;width:100px" onclick="$('#buckupcontainer').slideUp();">Close</button>
          </div>
         </div>
  <div class="panel-footer" style="background-color:#428bca;">
   <center>
   <img src="images/logoOFAG.png" class="" style="width:2%;height:2%;">
   <b style="font-family:Times New Roman;color:white;">
  Office of the Federal Auditor General,
Africa Avenue, Flamingo Area, 
Addis Ababa, P.O.Box: 457
ofagit@ethionet.et
+251 115 575701
+251 115574468
www.ofag.gov.et<br>
© 2017 Office of the Federal Auditor General | All Rights Reserved!
</b></center>
   </div>
</body>
</html>
