<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>activity log</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="refresh" content="600"><!--10 minuts-->
    <link rel="icon" href="images/logoOFAG.png">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
    function showallhistory() {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $("#contianer").html(this.responseText);
            }
        };
        http.open("GET", "showallhistory.aspx?fyear=" + document.getElementById("fyear").value + "&tyear=" + document.getElementById("tyear").value, true);
        http.send();
    }
    function makebakup() {
        $("#backupmsg").html("<p>Enter Disk Name to save the backup file<br> (Valid disk names are D:,F:,G:,H:  ... )." +
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
    function printtable() {
        var mywindow = window.open('', 'PRINT');
        mywindow.document.write("<html><head></head><body>");
        mywindow.document.write("<h4>Activity Log</h4><hr>");
        mywindow.document.write(document.getElementById("contianer").innerHTML);
        mywindow.document.write("</body></html>");
        mywindow.document.close();
        mywindow.focus();
        mywindow.print();
        mywindow.close();

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
<body onload="showallhistory()" style="color:black !important">
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
       
       SqlDataReader reader = new SqlCommand("select fname,lname,role from user_Table where username='"+Request.Cookies["user"].Value+"'",con).ExecuteReader();
       while(reader.Read()){
           role = reader["role"].ToString();
           name=reader["fname"].ToString();
           last = reader["lname"].ToString();
       }
       con.Close();
       
   }
   catch(Exception e){
       Response.Write(e.Message);
   }
   %>
    <div class="" style="height:70px;">
   
     <img src="images/logoimg.png" style="height:70px;" class="btn-block img-responsive"/>
    
     </div>
      <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../am/admin_activitylog.aspx"><img src="images/et.png" width="20" height="10"/>አማርኛ</a></div>
   <div class="row">
    <div class="col-sm-2" style="overflow:auto;padding-right:0px;">
    <div class="panel panel-default" style="background-color:#c2c9cb; height:900px;border-right:1px solid black">
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
    <div class="col-sm-10" style="padding-left:0px;height:900px;overflow:auto;">
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
     <p class="navbar-brand">Logged as  <%Response.Write(name);%>&nbsp<%Response.Write(last); %> <i>[<%Response.Write(role); %>]</i></p>
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
    
       <div>
          <table class="table" style="border:0px solid white;width:100%">
          <tr><th>From</th><th>To</th><th></th><th></th></tr>
        <tr><td><input type="date" class="form-control" id="fyear" style="width:200px;display:inline"></td>

        <td><input type="date" class="form-control" id="tyear" style="width:200px;display:inline;"></td>
      
         <td><a class="btn btn-primary" href="#" onclick="showallhistory()"><span class="glyphicon glyphicon-search"></span>Show</a></td>
          <td><a class="btn btn-primary" href="#" onclick="printtable()"><span class="glyphicon glyphicon-print"></span>Print</a></td>
         </tr></table>
       </div>
       <div class="panel panel-default" style="border-left:1px solid #67c69f" id="contianer">
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
