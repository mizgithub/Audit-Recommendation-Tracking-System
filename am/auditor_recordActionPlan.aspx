<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>record action plan</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<script src="bootstrap/js/jquery.min.js"></script>
<link rel="icon" href="images/logoOFAG.png">
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
    function openactionplan(recomId) {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $("#actioncontent"+recomId).html(this.responseText);
            }
        };
        http.open("GET", "auditoropenactionplan.aspx?recomId=" + recomId, true);
        http.send();
    }
    function saveauditeeresponse() {
        $("#auditeerespmsg").html("");
        var form = new FormData();
        form.append("issueddate", document.getElementById("issueddate").value);
        form.append("resp", document.getElementById("resp").value);
        form.append("respdate", document.getElementById("respdate").value);
        if (document.getElementById("resp").value != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    var response = this.responseText;

                    if (response.indexOf("SUCCESS") != -1) {

                        $("#auditeerespmsg").html("Successfully saved");
                    }
                    else {

                    }

                }
            };
            http.open("POST", "saveauditeeResponse.aspx", true);
            http.send(form);
        }
        else {
            alert("Empty auditee response");
        }
    }
    function saveActionPlan(recomId) {
        $("#actionplansavedmsg" + recomId).html("");
        var form = new FormData();
        form.append("action",document.getElementById("action"+recomId).value);
        form.append("recomId",recomId);
        form.append("actiondate",document.getElementById("actiondate"+recomId).value);
        if (document.getElementById("action"+recomId).value != "" && document.getElementById("actiondate"+recomId).value != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    $("#actionplansavedmsg" + recomId).html("successfully saved");
                    location.reload();
                }
            };
            http.open("POST", "saveactionplan.aspx",true);
            http.send(form);
        }
        else {
            alert("All fields are required");
        }
    }
    function showallactionplan() {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $('body').addClass("disable-scroll");
                $("#actioncontent").html(this.responseText);
                $('#actioncontentparent').slideDown();
            }
        };
        http.open("GET", "showallactionplan.aspx", true);
        http.send();
    }
    function savefollowupdate() {
        $("#follmsg").html("");
        var form = new FormData();
        form.append("date", document.getElementById("folldate").value);
        form.append("nextstep", document.getElementById("nextstep").value);
        form.append("fname", document.getElementById("audfname").value);
        form.append("lname", document.getElementById("audlname").value);
        form.append("action", document.getElementById("act").value);
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $("#follmsg").html("<b style='color:blue'>Successfully saved</b>");
            }
        };
        http.open("POST", "savefollowupdate.aspx", true);
        http.send(form);
    }
    function submittheaudit() {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                var response = this.responseText;
                if (response.indexOf("SUC") != -1) {
                    window.open("audiorAudits.aspx", "_self");
                }
                else {
                    $("#submitmsg").html(this.responseText);
                }

            }
        };
        http.open("GET", "confirmsubmitrequest.aspx", true);
        http.send();
    }
    function openactiontaken(planId) {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $("#recomcontent" + planId).html(this.responseText);
            }
        };
        http.open("GET", "auditorecordactiontaken.aspx?planId=" + planId, true);
        http.send();
    }
    function saveactiontaken(planId) {
        var form = new FormData();
        form.append("actiontaken", document.getElementById("actiontaken"+planId).value);
        form.append("actiondate", document.getElementById("actiontdate" + planId).value);
        form.append("recvalue", document.getElementById("recvalue" + planId).value);
        form.append("planId", planId);
        if (document.getElementById("actiontaken" + planId).value != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {

                    var response = this.responseText;

                    if (response.indexOf("SUCCESS") != -1) {

                        openactiontaken(planId);
                    }
                    else {

                    }

                }
            };
            http.open("POST", "saveactiontaken.aspx", true);
            http.send(form);
        }
        else {
            alert("Empty field");
        }
    }
    function savechangesactiontaken(actiontakenId, planId) {
       
        var form = new FormData();
        form.append("actiontaken", document.getElementById("edactiontaken" + actiontakenId).value);
        form.append("actiondate", document.getElementById("edactiontdate" + actiontakenId).value);
        form.append("recvalue", document.getElementById("edrecvalue" + actiontakenId).value);
        form.append("actiontakenId",actiontakenId);
        if (document.getElementById("edactiontaken" + actiontakenId).value != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {

                    var response = this.responseText;

                    if (response.indexOf("SUCCESS") != -1) {

                        openactiontaken(planId);
                    }
                    else {

                    }

                }
            };
            http.open("POST", "savechangesactiontaken.aspx", true);
            http.send(form);
        }
        else {
            alert("Empty field");
        }
    }
    function deleteactiontaken(actiontakenId, planId) {
        if (confirm("Are you sure to delete?")) {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openactiontaken(planId);
                }
            };
            http.open("GET", "deleteactiontaken.aspx?actiontakenId=" + actiontakenId, true);
            http.send();
        }
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
                 body.disable-scroll {
    overflow: hidden;
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
      <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../en/auditor_recordActionPlan.aspx"><img src="images/eng.png" width="20" height="10"/>English</a></div>
   <div class="row">
 
 <div class="col-sm-2 panel panel-default" style="background-color:#c2c9cb; height:1000px;border-right:1px solid black;padding-right:0px;">
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
     <ul class="nav nav-pills btn-sm">
                 <li> <a href="auditor_recordfindingsAndRecommendations.aspx" class="btn btn-link btn-sm">
                <span class="glyphicon glyphicon-backward"></span>ወደ ኋላ መልስ</a></li>
             <li style=""><a href="audiorAudits.aspx"  class="btn btn-link btn-sm"><b>ኦዲት</b></a></li>
            <li style=""><a href="report.aspx" class="btn btn-link btn-sm"><b >ሪፖርት</b></a></li>
            <li style=""><a href="auditor_actionplanfiles.aspx" class="btn btn-link btn-sm"><b>የትግበራ ዕቅድ</b></a></li>
            <li style=""><a href="auditor_actiontakenfiles.aspx" class="btn btn-link btn-sm"><b>በትግበራ ዕቅዱ የተወሰደ እርምጃ</b></a></li>
            <li style=""><a href="auditor_accountsetting.aspx"  class="btn btn-link btn-sm"><b>መለያ መቸት</b></a></b></li>
             </ul>
    </div>
     <table class="table table-responsive table-condensed table-bordered table-striped">
     <tr style="background-color:#c2c9cb;color:black"><th><h4><b>የተገምጋሚ ድርጅቱ የትግበራ ዕቅድ</b></h4></th></tr>
     </table>
     <div class="row">
     <div class="col-sm-12" style="padding-left:20px;">
      <table class="table table-responsive table-hover table-bordered table-striped">
      <tr><th colspan="3"><span class="glyphicon glyphicon-arrow-down"></span>የማሻሻያ ሃሳብ የትግበራ እቅድ ለመመዝገብ <u>የትግበራ ዕቅድ መዝግብ </u> ን ጠቅ ያድርጉ</th></tr>
      <%
          try
          {
              con.Open();
              SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where auditId=" + int.Parse(Request.Cookies["auditId"].Value), con).ExecuteReader();
               int recomcounter=1;
              while (recomreader.Read()) {
                   
                   %>
              <tr><td style="width:100px"><button class="btn btn-link" onclick="$('#actioncontent<%Response.Write(recomreader["recomId"]);%>').slideToggle();openactionplan(<%Response.Write(recomreader["recomId"]);%>)"><span class="glyphicon glyphicon-record"></span>የትግበራ ዕቅድ መዝግብ</button></td><th style="width:7px;"><i style="color:black">ማሻሻያ ሃሳብ <%Response.Write(recomcounter);%></i></th><th><%Response.Write(recomreader["recomName"]);%></th></tr>
              <tr><td colspan="3">
               <div class="col-sm-12" id="actioncontent<%Response.Write(recomreader["recomId"]);%>" style="display:none;background-color:white">
               </div>
              </td></tr>
              <%
                  
                  recomcounter++;
              }
              con.Close();
          }
          catch (Exception ex) { 
          
          }  
        %>
      </table>
     <table class="table table-responsive table-condensed table-bordered table-striped">
     <tr style="background-color:#c2c9cb;color:black"><th><h4><b>ተገምጋሚ ድርጅቱ በትግበራ ዕቅዱ ላይ የወሰደዉ እርምጃ</b></h4></th></tr>
     </table>
     <table class="table table-responsive table-hover table-bordered table-striped">
      <tr><th colspan="3"><span class="glyphicon glyphicon-arrow-down"></span>የተወሰዱ እርምጃዎችን ለመመዝገብ <U>የተወሰዱ እርምጃዎችን ጨምር</U> ን ጠቅ አድርግ</th></tr>
       <%
                    try
                    {
                        con.Open();
                        SqlDataReader actionplanreader = new SqlCommand("select * from actionPlan_Table where auditId=" + int.Parse(Request.Cookies["auditId"].Value), con).ExecuteReader();
                        int plancounter = 1;
                        while (actionplanreader.Read())
                        {   
                           
                        %>
                         <tr><td><button class="btn btn-link" onclick="$('#recomcontent<%Response.Write(actionplanreader["recomId"]);%>').slideToggle();openactiontaken(<%Response.Write(actionplanreader["recomId"]);%>)"><span class="glyphicon glyphicon-record"></span>የተወሰዱ እርምጃዎችን ጨምር</button></td><td style=""><i style="color:green">Action plan <%Response.Write(plancounter);%></i></td><td><p><%Response.Write(actionplanreader["actionplan"]);%></p></td></tr>
                         <tr><td colspan="3"><div class="col-sm-12 panel-panel-primary" id="recomcontent<%Response.Write(actionplanreader["recomId"]);%>" style="display:none;background-color:white">
                          </div>
                          </td></tr>
                        <%
                            
                          plancounter++;
                            }
                        con.Close();
                    }
                    catch (Exception ex) { 
                    
                    }    
                 %>
      </table>
     </div>
    
     </div>
     <%
         string followupdate = "";
         string nextstep = "", fname = "", lname = "", action = "";
         try
         {
             con.Open();
             SqlDataReader folldatereader = new SqlCommand("select followupdate from audit_Table where auditId=" + int.Parse(Request.Cookies["auditId"].Value), con).ExecuteReader();
             while (folldatereader.Read()) {
                 followupdate = folldatereader["followupdate"].ToString();
             }
             con.Close();
             con.Open();
             SqlDataReader nextstepreader = new SqlCommand("select * from auditorNextStep_Table where auditId=" + int.Parse(Request.Cookies["auditId"].Value), con).ExecuteReader();
             while (nextstepreader.Read()) {
                 nextstep = nextstepreader["nextstep"].ToString();
                 fname = nextstepreader["audfname"].ToString();
                 lname = nextstepreader["audlname"].ToString();
                 action = nextstepreader["actiontaken"].ToString();
             }
             con.Close();
         }
         catch (Exception ex) { 
         }
       %>
     <table class="table table-responsive table-condensed table-hover table-bordered table-striped" style="border:1px solid #552222">
     <tr style="background-color:#c2c9cb;color:black"><th colspan="3"><h4><b>የክትትል ኦዲት አጠቃላይ መረጃ</b></h4></th></tr>
     <tr><td style="width:150px">የክትትል ቀን</td><td><input type="date" id="folldate" class="form-control" value="<%Response.Write(followupdate);%>" style="border:1px solid #c2c9cb"><br></td><td></td></tr>
     <tr><td>የኦዲተሩ ቀጣይ ሂደት</td><td><textarea class="form-control" rows="4" id="nextstep" style="border:1px solid #c2c9cb" placeholder="የኦዲተሩ ቀጣይ ሂደት...."><%Response.Write(nextstep);%></textarea></td></tr>
     <tr><td>ቀጣዩን ሂደት ለመጀመር የተመረጠ ኦዲተር </td><td><input type="text" class="form-control" id="audfname" style="width:200px;border:1px solid #c2c9cb" placeholder="ስም" value="<%Response.Write(fname);%>">&nbsp;&nbsp;&nbsp;<input type="text" class="form-control" id="audlname" style="width:200px;border:1px solid #888899" placeholder="የአባት ስም" value="<%Response.Write(lname);%>"></td></tr>
     <tr><td>ኦዲተሩ የወሰደው እርምጃ</td><td><textarea class="form-control" rows="4" id="act" style="border:1px solid #c2c9cb" placeholder="ኦዲተሩ የወሰደው እርምጃ...."><%Response.Write(action);%></textarea></td></tr>
     <tr><td><button class="btn btn-primary btn-block" onclick="savefollowupdate()">መዝግብ</button></td><td id="follmsg"></td></tr>
     </table>
     
     <br>
     <table class="table table-responsive table-condensed table-hover table-bordered table-striped">
     <tr style="background-color:#c2c9cb;color:black"><th colspan="3"><h4><b>ኦዲት አስረክብ</b></h4></th></r>
     <tr><td colspan="3"><p style="font-family:Times New Roman;font-size:larger">
     <br> 
     <br><b>ማስታዎሻ᎓- ኦዲቱን አንዴ ካስረከቡ በኋላ ማደስ አይችሉም</b></p>
     <br><div id="submitmsg">
     </div>
     </td></tr>
     <tr><td colspan="3"><button class="btn btn-primary" style="width:300px;" onclick="submittheaudit()">ለማስረከብ እዚህ ጠቅ አድርግ</button></td></tr>
     </table>
     
     </div>
   </div>
    <div class="panel panel-default"style="position:fixed;top:10px;left:40%;width:700px;height:550px;display:none;z-index:100;border:2px solid #002345;text-align:right;background-color:#aa9999" id="actioncontentparent">
          <table class="table" style="height:6%;">
          <tr><td style="background-color:#aa9999"></td><td style="height:100%;width:20px;background-color:red"><button class="btn btn-link" style="color:white;width:30px;height:100%;display:inline;padding:0px" onclick="$('#actioncontentparent').slideUp(); $('body').removeClass('disable-scroll');"><b>X</b></button>
          </td></tr></table>
          <div class="panel-body" id="actioncontent" style="height:89%;overflow:auto;text-align:justify;background-color:white">
            
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
