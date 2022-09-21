<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>show audit</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<link rel="icon" href="images/logoOFAG.png">
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">

    function editrecomstatuschanged(recomId) {
        var status = document.getElementById("edrecomStatus" + recomId).value;
        if (status == "1" || status == "3") {
            $("#extrecom" + recomId).slideUp(0);
        }
        if (status == "2") {
            $("#extrecom" + recomId).slideDown(0);
        }
    }
    function showdetailfidingrecom(auditId) {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status) {
                $("#detailfindingrecom").html(this.responseText);
            }
        };
        http.open("GET", "showdetailfindingrecommendation.aspx?auditId=" + auditId, true);
        http.send();
    }
    function changestatusofrecommendation(recomId, auditId) {
       
        if (confirm("you are about to change the status of recommendation and Potential saving from the recommendation.\nPress OK to continue")) {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status) {
                    showdetailfidingrecom(auditId);
                }
            };
            http.open("GET", "changestatusofrecommendation.aspx?recomId="+recomId+"&status="+document.getElementById("status"+recomId).value+"&potsav="+document.getElementById("pots"+recomId).value+"&ext="+document.getElementById("ext"+recomId).value, true);
            http.send();
        }
    }
    function editaudit(auditId) {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                window.open("auditor_recordnewAudit.aspx?back=1", "_self");
            }
        };
        http.open("GET", "setcokkieforAudit.aspx?auditId=" + auditId, true);
        http.send();
    }

    function openstatusofrecom(recomId) {
        document.getElementById("openedrecom").value = recomId;
        $('#recomstatuswind').slideDown(0);
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {

                $("#recomstatus").html(this.responseText);
            }
        };
        http.open("GET", "openstatusofrecommendation.aspx?recomId=" + recomId, true);
        http.send();
    }
    function changestatufofrecom(auditId) {
        var recomId = document.getElementById("openedrecom").value;
        var form = new FormData();
        form.append("status", document.getElementById("edrecomStatus"+recomId).value);
        form.append("ext", document.getElementById("ext" + recomId).value);
        form.append("potsav", document.getElementById("potsav" + recomId).value);
        form.append("recomId", recomId);
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {

                showdetailfidingrecom(auditId);
            }
        };
        http.open("POST", "changestatusofrecommendation.aspx", true);
        http.send(form);
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
<body onload="showdetailfidingrecom(<%Response.Write(Request["auditId"]);%>)" style="color:Black !important">
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
    %>
    <%
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
       <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../en/Auditor_showAudit.aspx?auditId=<%Response.Write(Request["auditId"]);%>"><img src="images/eng.png" width="20" height="10"/>English</a></div>
   <div class="row">
    <div class="col-sm-2" style="padding-right:0px;background-color:">
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
      <table class="table table-responsive table-condensed">
      <tr style="color:black"><th colspan="2" style="font-size:16px;">የኦዲቱ አጠቃላይ መረጃ</th></tr>
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
                  <tr><th style="width:10%">የኦዲቱ ርዕስ</th><td><%Response.Write(auditreader["auditName"]);%></td></tr>
                  <tr><th>ተገምጋሚ ድርጅት</th><td><%Response.Write(orgname);%></td></tr>
                  <tr><th>የኦዲት አይነት</th><td><%Response.Write(auditreader["auditType"]);%></td></tr>
                  <tr><th>የኦዲት ዓ/ም</th><td><%Response.Write(auditreader["year"]);%></td></tr>
                  <tr><th>የኦዲት ጊዜ</th><td><%Response.Write("<u>"+auditreader["startdate"]+"</u>---<u>"+auditreader["enddate"]+"</u>");%></td></tr>    
                  <tr><th>የክትትል ኦዲት ቀን</th><td><%Response.Write(auditreader["followupdate"]);%></td></tr>
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
                           <tr><th>ኦዲተር</th><td><%Response.Write(auditorreader["fname"] + " " + auditorreader["lname"] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>Rank: <U>" + auditorreader["rank"] + "</u> </i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>Directorate <u>" + auditorreader["directorate"] + "</u></i>");%></td></tr>
                           <%
                          }
                          con.Close();
                          con.Open();
                          %>
                           <tr><th>የኦዲቱ ገምጋሚ</th><td>
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
            <tr><th>የተገምጋሚ ድርጅት አስተያየት</th><td><%Response.Write(opinion);%></td></tr>
           <tr><th>የኦዲተሩ አስተያየት</th><td><%Response.Write(remark);%></td></tr>
           <tr><td colspan="2"><hr></td></tr>
           <%try {
                 con.Open();
                 SqlDataReader nextstepreader = new SqlCommand("select * from auditorNextStep_Table where auditId=" +auditId, con).ExecuteReader();
                 while (nextstepreader.Read()) { 
                    %>
                    <tr><th>የኦዲተሩ ቀጣይ እርም</th><td><%Response.Write(nextstepreader["nextstep"]);%></td></tr>
                    <tr><th>ቀጣዩን እርምጃ እንዲጀምር የተመረጠ ኦዲተር</th><td><%Response.Write(nextstepreader["audfname"]+" "+nextstepreader["audlname"]);%></td></tr> 
                    <tr><th>ኦዲተሩ የወሰደው እርምጃ</th><td><%Response.Write(nextstepreader["actiontaken"]);%></td></tr>
                    <%
                 }
                 con.Close(); 
             }
             catch(Exception ex){
                 con.Close();
             } %>
      </table>
        <table class="table table-condensed table-responsive">
        <tr style="color:black"><th colspan="5" style="font-size:16px;">ግኝቶች እና የማሻሻያ ሃሳቦች</th></tr>
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
              <tr style="background-color:white;color:black"><th colspan="5">ግኝቶች</th></tr>
              <tr><th>አጠቃላይ የግኝቶች ቁጥር</th><th>የግኝቶች ጠቅላላ የፋይናንስ እሴት</th><th>የግኝቶች ግምታዊ የፋይናንስ እሴት</th><th></th><th></th></tr>
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
                <tr style="background-color"><th colspan="5">ማሻሻያ ሃሳቦች</th></tr>
              <tr><th>አጠቃላይ የማሻሻያ ሃሳቦች ብዛት</th><th>አጠቃላይ የማሻሻያ ሃሳቦች ግምታዊ የፋይናንስ እሴት</th><th style="">ጠቅላላ ሙሉ በሙሉ የተተገበሩ ማሻሻያ ሃሳቦች ብዛት</th><th style="background-color:">ጠቅላላ በከፊል የተተገበሩ ማሻሻያ ሃሳቦች ብዛት</th><th style="background-color">ጠቅላላ ያልተተገበሩ ማሻሻያ ሃሳቦች ብዛት</th></tr>
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
         <input type="hidden" id="openedrecom">
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
