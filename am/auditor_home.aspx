<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<link rel="icon" href="images/logoOFAG.png">
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
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
<body style="color:Black !important;">
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
   String role = "", name = "",last="";
   try
   {
       con.Open();

       SqlDataReader reader = new SqlCommand("select fname,lname,role from user_Table where username='" + Request.Cookies["user"].Value + "'", con).ExecuteReader();
       while (reader.Read())
       {
           role = reader["role"].ToString();
           name = reader["fname"].ToString();
           last=reader["lname"].ToString();
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
     <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../en/auditor_home.aspx"><img src="images/eng.png" width="20" height="10"/>English</a></div>
   <div class="row">
    <div class="col-sm-2" style="overflow:auto;padding-right:0px;">
<div class="panel panel-default" style="background-color:#c2c9cb; height:1000px;border-right:1px solid black">
        <div class="navbar navbar-default">
           <ul class="nav sidebar-nav btn-primary ">
            <li style="border-bottom: 2px solid #ffffff"><a href="audiorAudits.aspx" style="background-color:#c2c9cb;"><b style="color:black;">ኦዲት</b></a></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="report.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">ሪፖርት</b></a></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="auditor_actionplanfiles.aspx" style="background-color:#c2c9cb ;"><b  style="color:black;">የትግበራ ዕቅድ</b></a></b></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="auditor_actiontakenfiles.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">በትግበራ ዕቅዱ የተወሰደ እርምጃ</b></a></b></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="auditor_accountsetting.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">የመለያ መቸት</b></a></b></li>
            </ul>
        </div>
        </div>
    </div>
    <div class="col-sm-10" style="padding-left:0px;height:1000px;overflow:auto;">
    <!--  *******TOP Nagigation bar-->
    <div class="">
     <div class="navbar navbar-inverse"  data-offset-top="70" style="background-color:#c2c9cb;z-index:100; border-radius:0px; border-width:0px;height:40px;">
     <div class="navbar-header">
    <a href="auditor_home.aspx" class="navbar-brand" style="color:black"><b>ዋና ገጽ</b></a>
     </div>
     <div class="navbar-header">
    <a href="auditor_auditees.aspx" class="navbar-brand" style="color:black"><b>ተገምጋሚ ድርጅቶች</b></a>
     </div>
     <div class="navbar-header">
    <a href="auditor_aboutOfag.aspx" class="navbar-brand" style="color:black"><b>ስለ OFAG</b></a>
     </div>
     <div class="navbar-header">
     <p class="navbar-brand">Logged as <%Response.Write(name);%> &nbsp<%Response.Write(last); %> <i>[<%Response.Write(role); %>]</i></p>
     </div>
     <div class="navbar-header">
     <p class="navbar-brand">|</p>
     </div>
     <div class="navbar-header" align="right">
    <a href="logout.aspx" class="navbar-brand" style="color:black"><b>ውጣ</b></a>
     </div>
    
    </div>
    </div>
    <!--************************************************-->
  <center> <h4 style="color:black;font-weight:bold"> <b>Features in ARTS (Audit Recommendation Tracking System)</b></h4></center>
     <div style="padding:0px;padding-right:50px;height:900px;overflow:auto;padding-left:50px;border-top:2px solid #cccccc;border-bottom:2px solid #cccccc;font-size:16px;font-family:@BatangChe;">
   <div class="col-sm-12" style="">
     <div class="panel-body" style="padding-top:0px;background-color:white;">
    
     <h4 style="color:black;font-weight:bold;">Introduction</h4>
     <p style="font-family:Times New Roman;font-size:18px;text-align:justify">Audit Recommendation Tracking System (ARTS) is essential for a Supreme Audit Institution (SAI) to monitor the implementation and resolution of audit recommendations and also it is used to automate the processing, reporting and utilization of audit recommendations for their respective auditee’s. 
The system allows secure data entry, editing and storage of all details associated with all findings and recommendations processed. In addition, the system has a flexible search facility and flexible reporting environment that can be tailored for use by both ‘novice’ and ‘expert’ users.
</p>
    <p>ARTS have several subsystems. These tasks include:</p>
    <ul>
	<li>System administrator subsystem</li>
	<li>Data encoder subsystem</li>
    <li>Audit director subsystem</li>
    <li>Special assistance to auditor general subsystem</li>
    <li>Deputy auditor general</li>
    <li>Auditor General subsystem</li>
    <li>PAC subsystem</li>
    <li>Auditee subsystem</li>
</ul>
<hr style="background-color:white;height:4px;">
<h4 style="color:black">System administrator subsystem</h4>
<p>These tasks include:</p>
     <ul>
     <li>Setting Management 
     <ul>
     <li>Auditee Setting can be used for adding Auditee at Ministry Level and the Federal Organization Level in the selected ministry.</li>
     <li>Audit Type Setting can be used to add audit type and will be used to add new audit type whenever needed.</li>
     <li>Finding Type Setting used to add Finding types and can be used to add new audit finding types whenever needed.</li>
     <li>Audit Directorate Setting used to Add and modify audit directorate.</li>
     </ul>
     </li>
     <li>Account Setting 
     <ul>
     <li>Used to change logged-in user’s password. </li>
     </ul>
     </li>
     <li>Activity Logs
     <ul>
  <li>Displays range of days to generate report on audit trials.</li>
  <li>Used to display who entered what and when.</li>
  <li>Displays audit trial report using tabular and on screen report.</li>
     </ul>
     </li>
     <li>
     Generating Report
     <ul>
<li>Generate report based on auditee directorate for specific organization or for all organizations.</li>
<li> Generate report based on audit type.</li>
<li>Generate report based on a single year or range of years.</li>
<li>Generate report based on risk level.</li>
<li>Generate report that can be grouped by finding type, auditee and audit year.</li>
<li>Generate report of finding only, recommendation only or both.</li>
<li>Select fields to appear in the report you want to generate.</li>
<li>A graphical report can also be generated.</li>
<li>Report can be exported to Excel or to PDF.</li>
<li>Predefined reports can also be generated.</li>
<li>Detail of any report can be shown.</li>
</ul>
     </li>
     <li>
Action plan files
<ul>
<li>Used to access action plan files uploaded by auditee.
</li></ul>
</li>
<li>
Action taken files
<ul>
<li>Used to access action taken files uploaded by auditee.
</li></ul>
</li>
     <li>Auditee Page 
     <ul><li>Used to display all general information about Ministries and organizations to be audited by OFAG are presented</li></ul>
     </li>
     <li>About OFAG 
     <ul><li>Used to display all general information about the Office of the Federal Auditor General (OFAG) project and its goals.</li></ul>
     </li>
     <li>Exit System 
     <ul><li>When you are finished working, remember to logout and then close the web browser.</li></ul>
     </li></ul>
     
     <ul>
      <li>User Management
     <ul>
     <li>User account creation, modification
     <ul>
     <li>User account role can be created for Auditor, Administrator, PAC and Auditor General.</li>
     <li>A Unique User account is generated by the system and can be modified if needed.</li>
     </ul>
     </li>
     </ul>
     </li>
     <li>Take Backup
     <ul><li>Used to take a backup of the whole database to a secured location.</li></ul>
     </li>
 
     </ul>
     <hr style="background-color:white;height:4px;">
     <h4 style="color:black">Data encoder subsystem</h4>
     <p>Data encoder subsystem is one of the subsystems that include tasks performed by auditor/record officer. These tasks include:  </p>
   <ul><li>Audit Details
   <ul>
<li>Record New Audits</li>
<li> Open and Finish Saved Audits</li>
<li>Search Audits</li>
<li> View Audit Details</li>
</ul></li>
<li>Record Basic Audit Information</li>
<li> Record:
<ul>
<li>Audit Prepared by</li>
<li> Audit Reviewed by</li>
</ul>
</li>
<li>Record Audit Finding Details</li>
<li>Record Audit Recommendations</li>
<li>Record Action Plan</li>
<li> Record Follow-up Information</li>
<li>
Action plan files
<ul>
<li>Used to access action plan files uploaded by auditee.
</li></ul>
</li>
<li>
Action taken files
<ul>
<li>Used to access action taken files uploaded by auditee.
</li></ul>
</li>
 <li>Account Setting
<ul>
	<li>Used to change logged-in user’s password. </li>
</ul>
</li>
<li>
     Generating Report
     <ul>
<li>Generate report based on auditee directorate for specific organization or for all organizations.</li>
<li> Generate report based on audit type.</li>
<li>Generate report based on a single year or range of years.</li>
<li>Generate report based on risk level.</li>
<li>Generate report that can be grouped by finding type, auditee and audit year.</li>
<li>Generate report of finding only, recommendation only or both.</li>
<li>Select fields to appear in the report you want to generate.</li>
<li>A graphical report can also be generated.</li>
<li>Report can be exported to Excel or to PDF.</li>
<li>Predefined reports can also be generated.</li>
<li>Detail of any report can be shown.</li>
</ul>
     </li>
<li>Auditee Page 
<ul><li>Used to display all general information about Ministries and organizations to be audited by OFAG are presented. </li></ul>
</li>
<li>About OFAG 
<ul><li>Used to display all general information about the Office of the Federal Auditor General (OFAG) project and its goals.</li></ul>
</li>
<li>Exit System 
<ul><li>When you are finished working, remember to logout and then close the web browser.</li></ul>
</li>
 </ul>
 <hr style="background-color:white;height:4px;">
 <h4 style="color:black">Auditor General Subsystem / Deputy auditor general /Special assistant to auditor general subsystem /PAC members subsystem /  Audit director subsystem</h4>
 <p>These tasks include</p>
  <ul>
  <li>Audit Details
	<ul><li>Search Audits</li>
   <li>View Audit Details</li>
</ul>
</li>
<li>
Action plan files
<ul>
<li>Used to access action plan files uploaded by auditee.
</li></ul>
</li>
<li>
Action taken files
<ul>
<li>Used to access action taken files uploaded by auditee.
</li></ul>
</li>
<li>
     Generating Report
     <ul>
<li>Generate report based on auditee directorate for specific organization or for all organizations.</li>
<li> Generate report based on audit type.</li>
<li>Generate report based on a single year or range of years.</li>
<li>Generate report based on risk level.</li>
<li>Generate report that can be grouped by finding type, auditee and audit year.</li>
<li>Generate report of finding only, recommendation only or both.</li>
<li>Select fields to appear in the report you want to generate.</li>
<li>A graphical report can also be generated.</li>
<li>Report can be exported to Excel or to PDF.</li>
<li>Predefined reports can also be generated.</li>
<li>Detail of any report can be shown.</li>
</ul>
     </li>
<li>Account Setting 
<ul><li>Used to change logged-in user’s password.</li></ul>
</li>
<li>Auditee Page 
<ul><li>Used to display all general information about Ministries and organizations to be audited by OFAG are presented.</li></ul>
</li>
<li>About OFAG 
<ul><li>Used to display all general information about the Office of the Federal Auditor General (OFAG) project and its goals.</li></ul>
</li>
<li>Exit System 
<ul><li>When you are finished working, remember to logout and then close the web browser.</li></ul>
</li>
</ul>
<h4 style="color:black">Auditee subsystem</h4>
<ul>
<li>
Action plan
<ul>
<li>
Auditee can access the system to provide/record action plan, they are be able to attach the official scanned and signed action plan into the system.
</li>
</ul>
</li>
<li>
Action taken
<ul>
<li>
Auditee can access the system to provide/record action taken, they are be able to attach the official scanned and signed action taken into the system.
</li>
</ul>
</li>
<li>
Account setting
<ul>
<li>
Used to change logged-in user's password.
</li>
</ul>
</li>
<li>
About OFAG
<ul>
<li>
Used to display all general information about the Office of the Federal Auditor General (OFAG) project and its goals.
</li>
</ul>
</li>
<li>
Exit System
<ul>
<li>
When you are finished working, remember to logout and then close the web browser.
</li>
</ul>
</li>
</ul>
<p></p>
<hr style="background-color:white;height:4px;">
<div class="panel panel-default" style="background-color:#eeeeff">
<a href="../ARTS%20-%20Users%20Operations%20Manual.pdf" class="btn btn-link"><span class="glyphicon glyphicon-download"></span>Download full user-operational manual documentation</a>
 </div>

   </div>
     </div>
     </div>
    </div>
  
        
         </div>
         </div>
  <div class="panel-footer" style="background-color:#049dc6;">
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
