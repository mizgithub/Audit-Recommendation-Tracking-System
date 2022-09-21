<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>auditees</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<link rel="icon" href="images/logoOFAG.png">
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
    var flag = 1;
    function toggleorg(minId) {
            $('#hidden' + minId).slideToggle(0);
         
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
<body style="color:black !important">
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
       <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../am/Ag_auditees.aspx"><img src="images/et.png" width="20" height="10"/>አማርኛ</a></div>
   <div class="row">
    <div class="col-sm-2" style="overflow:auto;padding-right:0px;">
 <div class="panel panel-default" style="background-color:#c2c9cb; height:1000px;border-right:1px solid black">
        <div class="navbar navbar-default">
            <ul class="nav sidebar-nav btn-primary ">
            <li style="border-bottom: 2px solid #ffffff;border-color:#ffffff"><a href="Ag_audits.aspx" style="background-color:#c2c9cb;"><b style="color:black;">Audits</b></a></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="Ag_report.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">Report</b></a></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="Ag_actionplanfile.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">Uploaded action plan files</b></a></b></li> 
            <li style="border-bottom: 2px solid #ffffff"><a href="Ag_actiontakenfile.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">Uploaded action taken files</b></a></b></li> 
            <li style="border-bottom: 2px solid #ffffff"><a href="Ag_accountsetting.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">Account setting</b></a></b></li> 
            </ul>
        </div>
        </div>
    </div>
    <div class="col-sm-10" style="padding-left:0px;">
    <!--  *******TOP Nagigation bar-->
    <div class="">
     <div class="navbar navbar-inverse"  data-offset-top="70" style="background-color:#c2c9cb;z-index:100; border-radius:0px; border-width:0px;height:40px;">
     <div class="navbar-header">
    <a href="Ag_home.aspx" class="navbar-brand" style="color:black"><b>Home</b></a>
     </div>
     <div class="navbar-header">
    <a href="Ag_auditees.aspx" class="navbar-brand" style="color:black"><b>Auditees</b></a>
     </div>
     <div class="navbar-header">
    <a href="Ag_aboutOfag.aspx" class="navbar-brand" style="color:black"><b>About OFAG</b></a>
     </div>
     <div class="navbar-header">
     <p class="navbar-brand">logged as <%Response.Write(name);%>&nbsp<%Response.Write(last); %>  <i>[<%Response.Write(role); %>]</i></p>
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
    <table class="table table-bordered table-condensed table-hover table-responsive table-striped">
       <%con.Open();

         SqlDataReader minreader = new SqlCommand("select * from ministry_Table order by minName asc", con).ExecuteReader();
         int mincounter = 1;
         while (minreader.Read()) { 
           %>
           <tr><td style="width:7px;"><button class="btn btn-link" id="but<%Response.Write(minreader["minId"]);%>" onclick="toggleorg('<%Response.Write(minreader["minId"]);%>')"><span class="glyphicon glyphicon-menu-down"></span></button></td><td><%Response.Write(mincounter+++". "+minreader["minName"]);%></td></tr>
           <tr style="display:none;" id="hidden<%Response.Write(minreader["minId"]);%>"><td colspan="2">
            <center><table class="table table-bordered table-condensed table-hover table-responsive table-striped" style="width:90%">
             <%
               con2.Open();
               SqlDataReader orgreader = new SqlCommand("select * from org_Table where minId=" + (int)minreader["minId"] + " order by orgName asc", con2).ExecuteReader();
               int orgcounter = 1;
               while (orgreader.Read()) { 
                %>
                <tr><td><%Response.Write(orgcounter+++". "+orgreader["orgName"]);%></td></tr>
                <%
               }
               con2.Close(); 
             %>
            </table></center>
           </td></tr>
           <%
         }
         con.Close();
            %>
      </table>
  
        
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
