<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>record audit</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<link rel="icon" href="images/logoOFAG.png">
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
    function saveauditInfo() {
    
        var form = new FormData();
        form.append("refno", document.getElementById("audrefno").value);
        form.append("auditee", document.getElementById("selauditee").value);
        form.append("audittype", document.getElementById("selaudittype").value);
        form.append("year", document.getElementById("selyear").value);
        form.append("startdate", document.getElementById("startdate").value);
        form.append("enddate", document.getElementById("enddate").value);
        form.append("audittitle", document.getElementById("audittitle").value);
       // form.append("risk", document.getElementById("risk").value);
        if (document.getElementById("audittitle").value.match(/^[0-9]+$/) != null) {
            $("#auditmsg").html("<b style='color:red'>Error in saving. Check input values</b>");
        }
        else {
            if (document.getElementById("audittitle").value != "" && document.getElementById("audrefno").value != "") {
                var http = new XMLHttpRequest();
                http.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        var response = this.responseText;
                        
                        if (response.indexOf("SUCCESS") != -1) {
                            location.reload();
                        }
                        else {

                        }
                    }
                };
                http.open("POST", "saveauditinfo.aspx", true);
                http.send(form);
            }
            else {
                alert("All fields are Required");
            }
        }
    }
    function editauditInfo() {

        var form = new FormData();
        form.append("refno", document.getElementById("audrefno").value);
        form.append("auditee", document.getElementById("selauditee").value);
        form.append("audittype", document.getElementById("selaudittype").value);
        form.append("year", document.getElementById("selyear").value);
        form.append("startdate", document.getElementById("startdate").value);
        form.append("enddate", document.getElementById("enddate").value);
        form.append("audittitle", document.getElementById("audittitle").value);
       
        if (document.getElementById("audittitle").value.match(/^[0-9]+$/) != null) {
            $("#auditmsg").html("<b style='color:red'>Error in saving. Check input values</b>");
        }
        else {
            if (document.getElementById("audittitle").value != "" && document.getElementById("audrefno").value != "") {
                var http = new XMLHttpRequest();
                http.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        var response = this.responseText;
                    
                        if (response.indexOf("SUCCESS") != -1) {

                            location.reload();
                        }
                        else {

                        }
                    }
                };
                http.open("POST", "saveauditinfo.aspx", true);
                http.send(form);
            }
            else {
                alert("All fields are Required");
            }
        }
    }
    function saveauditor() {
        var form = new FormData();
        form.append("fname", document.getElementById("audfname").value);
        form.append("lname", document.getElementById("audlname").value);
        form.append("rank", document.getElementById("audrank").value);
        form.append("dir", document.getElementById("auddir").value);


        if (document.getElementById("audlname").value.match(/^[0-9]+$/) != null || document.getElementById("audlname").value.match(/^[0-9]+$/) != null) {
            $("#auditormsg").html("<b style='color:red'>Error in saving. Check input values</b>");
        }
        else {
            if (document.getElementById("audfname").value != "" && document.getElementById("audlname").value != "") {
                var http = new XMLHttpRequest();
                http.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        var response = this.responseText;

                        if (response.indexOf("SUCCESS") != -1) {

                            location.reload();
                        }
                        else {
                            $("#auditormsg").html("<b style='color:red'>You should fill audit information first</b>");
                        }

                    }
                };
                http.open("POST", "saveauditor.aspx", true);
                http.send(form);
            }
            else {
                alert("All fields are required");
            }
        }

    }
    function editauditorinfo(idno) {
        var form = new FormData();
        form.append("fname", document.getElementById("edaudfname" + idno).value);
        form.append("lname", document.getElementById("edaudlname" + idno).value);
        form.append("rank", document.getElementById("edaudrank" + idno).value);
        form.append("dir", document.getElementById("edauddir" + idno).value);
        form.append("idno", idno);

        if (document.getElementById("edaudfname" + idno).value.match(/^[0-9]+$/) != null || document.getElementById("edaudlname" + idno).value.match(/^[0-9]+$/) != null) {
            $("#editauditormsg" + idno).html("<b style='color:red'>Error in saving. Check input values</b>");
        }
        else {
            if (document.getElementById("edaudfname" + idno).value != "" && document.getElementById("edaudlname" + idno).value != "") {
                var http = new XMLHttpRequest();
                http.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        var response = this.responseText;

                        if (response.indexOf("SUCCESS") != -1) {

                            location.reload();
                        }
                        else {

                            $("#editauditormsg" + idno).html("<b style='color:red'>Changes are not saved. try agian</b>");
                        }

                    }
                };
                http.open("POST", "editauditorinfo.aspx", true);
                http.send(form);
            }
            else {
                $("#editauditormsg" + idno).html("<b style='color:red'>Changes are not saved. try agian</b>");
            }
        }
    }
    function savereviewer() {
        var form = new FormData();
        form.append("fname", document.getElementById("revfname").value);
        form.append("lname", document.getElementById("revlname").value);
        form.append("rank", document.getElementById("revrank").value);
        form.append("date", document.getElementById("revdate").value);
        if (document.getElementById("revfname").value.match(/^[0-9]+$/) != null || document.getElementById("revlname").value.match(/^[0-9]+$/) != null) {
            $("#revmsg").html("<b style='color:red'> Error in saving. Check input values</b>");
        }
        else {
            if (document.getElementById("revfname").value != "" && document.getElementById("revlname").value != "") {
                var http = new XMLHttpRequest();
                http.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        var response = this.responseText;

                        if (response.indexOf("SUCCESS") != -1) {

                            location.reload();
                        }
                        else {
                            $("#revmsg").html("<b style='color:red'>You should fill audit information first</b>");

                        }

                    }
                };
                http.open("POST", "savereviewer.aspx", true);
                http.send(form);
            }
            else {
                alert("All fields are required");
            }
        }
    }
    function editreviewerinfo(revId) {
        var form = new FormData();
        form.append("fname", document.getElementById("edrevfname" + revId).value);
        form.append("lname", document.getElementById("edrevlname" + revId).value);
        form.append("rank", document.getElementById("edrevrank" + revId).value);
        form.append("date", document.getElementById("edrevdate" + revId).value);
        form.append("revId", revId);
        if (document.getElementById("edrevfname" + revId).value.match(/^[0-9]+$/) != null || document.getElementById("edrevlname" + revId).value.match(/^[0-9]+$/) != null) {
            $("#revmsg" + revId).html("<b style='color:red'> Error in saving. Check input values</b>");
        }
        else {
            if (document.getElementById("edrevdate" + revId).value != "" && document.getElementById("edrevfname" + revId).value != "" && document.getElementById("edrevlname" + revId).value != "") {
                var http = new XMLHttpRequest();
                http.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        var response = this.responseText;

                        if (response.indexOf("SUCCESS") != -1) {

                            location.reload();
                        }
                        else {

                        }

                    }
                };
                http.open("POST", "editreviewerinfo.aspx", true);
                http.send(form);
            }
            else {
                alert("All fields are required");
            }
        }
    }
    function deletereviewer(revId) {
        if (confirm("Are you sure?")) {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    var response = this.responseText;

                    if (response.indexOf("SUCCESS") != -1) {

                        location.reload();
                    }
                    else {

                    }
                }
            };
            http.open("GET", "deletereviewer.aspx?revId=" + revId, true);
            http.send();
        }
    }
    function deleteauditor(audId) {
        if (confirm("Are you sure?")) {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    var response = this.responseText;

                    if (response.indexOf("SUCCESS") != -1) {

                        location.reload();
                    }
                    else {

                    }
                }
            };
            http.open("GET", "deleteauditor.aspx?audId=" + audId, true);
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
   int auditId = 0;
   try
   {
       auditId = int.Parse(Request.Cookies["auditId"].Value);
   }
   catch (Exception ex) {    
   }
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
       <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../am/auditor_recordnewAudit.aspx"><img src="images/et.png" width="20" height="10"/>አማርኛ</a></div>
   <div class="row">
   <div class="col-sm-2 panel panel-default" style="background-color:#c2c9cb; height:1000px;border-right:1px solid black;padding-right:0px;">
        <div class="navbar navbar-default">
           <ul class="nav sidebar-nav btn-primary ">
            <li style="border-bottom: 2px solid #ffffff"><a href="audiorAudits.aspx" style="background-color:#c2c9cb;"><b style="color:black;">Audits</b></a></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="report.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">Report</b></a></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="auditor_actionplanfiles.aspx" style="background-color:#c2c9cb ;"><b  style="color:black;">Uploaded action plan files</b></a></b></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="auditor_actiontakenfiles.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">Uploaded action taken files</b></a></b></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="auditor_accountsetting.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">Account setting</b></a></b></li>
            </ul>
        </div>
        </div>
    <div class="col-sm-10" style="padding-left:0px;height:1000px;overflow:auto;">
    <!--  *******TOP Nagigation bar-->
    <div class="" style="padding:0px;">
     <div class="navbar navbar-inverse"  data-offset-top="70" style="background-color:#c2c9cb;z-index:100; border-radius:0px; border-width:0px;height:40px;">
     <div class="navbar-header">
    <a href="auditor_home.aspx" class="navbar-brand" style="color:black"><b>Home</b></a>
     </div>
     <div class="navbar-header">
    <a href="auditor_auditees.aspx" class="navbar-brand" style="color:black"><b>Auditees</b></a>
     </div>
     <div class="navbar-header">
    <a href="auditor_aboutOfag.aspx" class="navbar-brand" style="color:black"><b>About OFAG</b></a>
     </div>
     <div class="navbar-header">
     <p class="navbar-brand">Logged as <%Response.Write(name);%> &nbsp  <%Response.Write(last); %>  <i>[<%Response.Write(role); %>]</i></p>
     </div>
     <div class="navbar-header">
     <p class="navbar-brand">|</p>
     </div>
     <div class="navbar-header" align="right">
    <a href="logout.aspx" class="navbar-brand" style="color:black"><b>Logout</b></a>
     </div>
    
    </div>
    <ul class="nav nav-pills btn-sm" style="padding:10px;">
            <%if (Request["back"] != "" && Request["back"] != null) { 
              %>
              <li style=""><a href="Auditor_showAudit.aspx?auditId=<%Response.Write(Request.Cookies["auditId"].Value);%>"  class="btn btn-link btn-sm"><b><span class="glyphicon glyphicon-backward"></span>Back</b></a></li>
              <%
              }%>
            <li style=""><a href="audiorAudits.aspx"  class="btn btn-link btn-sm"><b>Audits</b></a></li>
            <li style=""><a href="report.aspx" class="btn btn-link btn-sm"><b >Report</b></a></li>
            <li style=""><a href="auditor_accountsetting.aspx"  class="btn btn-link btn-sm"><b>Account setting</b></a></b></li>
            </ul>
    </div>
    <!--************************************************-->
    <div>
    
    <div id="auditeditting" style="display:none;padding-left:10px;padding-right:20px;">
    <table class="table table-responive table-condensed table-bordered table-hover table-striped" style="border:1px solid #c2c9cb;">
     <tr style="background-color:#c2c9cb;"><td colspan="6"><h4 style="color:black"><b>Audit Information</b></h4></td></tr>
 
       <%
           string refno = "";
           string auditname = "";
           string orgId = "";
           string orgname = "";
           string year = "";
           string startdate = "";
           string enddate = "";
           string auditype = "";
           string risk = "";
           
           try
           {
               if (Request.Cookies["auditId"].Value != "")
               {
                   con.Open();
                   SqlDataReader auditreader = new SqlCommand("select * from audit_Table where auditId=" + int.Parse(Request.Cookies["auditId"].Value), con).ExecuteReader();
                   while (auditreader.Read())
                   {
                       refno = auditreader["refNo"].ToString();
                       auditname = auditreader["auditName"].ToString();
                       orgId = auditreader["orgId"].ToString();
                       year = auditreader["year"].ToString();
                       startdate = auditreader["startdate"].ToString();
                       enddate = auditreader["enddate"].ToString();
                       auditype = auditreader["auditType"].ToString();
                       string auditee = "";
                      
                       con2.Open();
                       SqlDataReader auditeereader = new SqlCommand("select orgName from org_Table where orgId=" + (int)auditreader["orgId"], con2).ExecuteReader();
                       while (auditeereader.Read())
                       {
                           auditee = auditeereader["orgName"].ToString();
                           orgname = auditee;
                       }
                       con2.Close();
                %>
               <tr><th style="width:15%">Reference number</th><td><%Response.Write(auditreader["refNo"]);%></td></tr>
               <tr><th>Audit title</th><td><%Response.Write(auditreader["auditName"]);%></td></tr>
               <tr><th>Auditee</th><td><%Response.Write(auditee);%></td></tr>
              
               <tr><th>Audit type</th><td><%Response.Write(auditreader["auditType"]);%></td></tr>
               <tr><th>Audit year</th><td><%Response.Write(auditreader["year"]);%></td></tr>
               <tr><th>Audit period</th><td><%Response.Write(auditreader["startdate"] + "<b>----</b>" + auditreader["enddate"]);%></td></tr>
               <%
                   }
                   con.Close();
               }
           }
           catch (Exception ex) { 
             
           }  
        %>
        <tr><td colspan="6"><button class="btn btn-primary" onclick="$('#auditsaving').slideToggle();$('#auditeditting').slideToggle();"><span class="glyphicon glyphicon-edit"></span>Edit</button></td></tr>
        </table>
    </div>
    <div id="auditsaving" style="padding-left:10px;padding-right:20px;">
    <table class="table table-responsive table-bordered table-striped" style="border-bottom:1px dotted #c2c9cb;">
    <tr style="background-color:#c2c9cb;color:black"><td colspan="4"><h4><b>Audit information</b></h4></td></tr>
    <tr>
    <th style="width:100px">Reference number</th>
    <td><input type="text" class="form-control" id="audrefno" placeholder="Reference number" style="border:1px solid #c2c9cb" value="<%Response.Write(refno);%>"></td>
     <th>Audit title</th>
    <td><input type="text" class="form-control" id="audittitle" placeholder="Audit  Title" style="border:1px solid #c2c9cb" value="<%Response.Write(auditname);%>">
    </td>
    </tr><tr>
    <th>Auditee</th>
    <td>
     <select class="form-control" id="selauditee" style="border:1px solid #c2c9cb">
     <option value="<%Response.Write(orgId);%>"><%Response.Write(orgname);%></option>
      <%try
        {
            con.Open();
            SqlDataReader auditeeReader = new SqlCommand("select * from org_Table", con).ExecuteReader();
            while (auditeeReader.Read()) { 
            %>
              <option value="<%Response.Write(auditeeReader["orgId"]);%>"><%Response.Write(auditeeReader["orgName"]);%></option>
             <%
            }
            con.Close();   
        }
        catch (Exception ex) {
            con.Close();
        }
          
        %>
     </select>
    </td>
     <th>Audit type</th>
    <td>
     <select class="form-control" id="selaudittype" style="border:1px solid #c2c9cb">
     <option><%Response.Write(auditype);%></option>
      <%try
        {
            con.Open();
            SqlDataReader audittypeReader = new SqlCommand("select * from auditType_Table", con).ExecuteReader();
            while (audittypeReader.Read())
            { 
            %>
              <option><%Response.Write(audittypeReader["auditType"]);%></option>
             <%
            }
            con.Close();   
        }
        catch (Exception ex) {
            con.Close();
        }
          
        %>
     </select>
    </td>
    <tr>
    <th>Audit year</th>
    <td>
      <select class="form-control" id="selyear" style="border:1px solid #c2c9cb">
      <option><%Response.Write(year);%></option>
      <%try
        {
            int today = int.Parse(DateTime.Now.ToString("yyyy"));
            
            while (today>=1950)
            { 
            %>
              <option><%Response.Write(today);%></option>
             <%
                today--;
            }
            con.Close();   
        }
        catch (Exception ex) {
            con.Close();
        }
          
        %>
     </select>
    </td>
     <th rowspan="2">Audit period</th>
    <td>
    <table class="table table-condensed table-bordered table-striped">
    <tr><th>Start date</th>
    <td>
    <input type="date" class="form-control" id="startdate" style="width:200px;border:1px solid #c2c9cb" value="<%Response.Write(startdate);%>">
    </td></tr><tr>
    <th >End date</th><td>
    <input type="date" class="form-control" id="enddate" style="width:200px;border:1px solid #c2c9cb" value="<%Response.Write(enddate);%>">
    </td>
    </tr>
   
    </table></td>
    </tr>
    
    <tr><td colspan="7" id="audmsg">
    <%if (Request.Cookies["auditId"].Value != "")
      {%>
        <button class="btn btn-primary"  onclick="editauditInfo()">Save changes</button> <button class="btn btn-primary"  onclick="$('#auditsaving').slideToggle();$('#auditeditting').slideToggle();">Cancel</button></td></tr>
    <%}
      else
      { %>
    <button class="btn btn-primary" onclick="saveauditInfo()">Save</button><%} %><span id="auditmsg"></span></td></tr>
    </table>
    </div>
    <%
       
          %>
          <script type="text/javascript">
           
              var auditId = "";
              var cokkies = document.cookie;
             
              var arraycookies = cokkies.split("; ");
              for (var i = 0; i < arraycookies.length; i++) {
                  var cok = arraycookies[i].split("=");
                  if (cok[0] == "auditId") {
                      auditId = cok[1];
                           
                  }
              }
              if (auditId != "") {
                  $("#auditsaving").slideUp();
                  $("#auditeditting").slideDown();
              }
                 
          </script>
 <!--***************************Auditor info---->
 <div style="padding-left:10px;padding-right:20px;">
    <table class="table table-responsive table-bordered table-condensed table-striped" style="border-bottom:1px solid #552222">
    <tr style="background-color:#c2c9cb"><th colspan="5"><h4><b style="color:black">Auditors</b></h4></th></tr>
    <tr><th colspan="5"><ul class="nav nav-pills"><li><a class="btn btn-link" onclick="$('#hidrow1').slideToggle();"><b><span class="glyphicon glyphicon-plus"></span>Add auditor</b></a></li></ul></th></tr>
    <tr style="display:none" id="hidrow1"><td colspan="5"><table class="table table-responsive" border="1">
    <tr><th>First name</th><th>Last name</th><th>Rank</th><th>Directorate</th></tr>
    <tr><th><input type="text" class="form-control" id="audfname"></th><th><input type="text" class="form-control" id="audlname"></th><th>
    <select class="form-control" id="audrank">
    <option>Auditor</option>
    <option>Senior Auditor</option>
    <option>Audit Manager</option>
    <option>Audit Director</option>
    <option>Deputy Auditor General</option>
    <option>Auditor General</option>
    </select>
    </th>
    <th><select class="form-control" id="auddir">
      <% 
          try
          {
              con.Open();
              SqlDataReader dirreader = new SqlCommand("select * from directorate_Table", con).ExecuteReader();
              while (dirreader.Read()) { 
              %>
              <option><%Response.Write(dirreader["directorate"]);%></option>
              <%
              }
              con.Close();
          }
          catch (Exception ex) {
              con.Close();
          }
          %>
    </select></th>
    </tr>
          <%if (auditId != 0)
            {%>
        <tr><td colspan="4"><button class="btn btn-primary" onclick="saveauditor()">Save</button><span id="auditormsg"></span></td></tr>
         <%} %>
    </table>
    </td></tr>
    <% try
       {
           con.Open();
           SqlDataReader revreader = new SqlCommand("select * from auditor_Table where auditId=" +auditId, con).ExecuteReader();
           while (revreader.Read()) { 
             %>
             <tr><th style="width:7px;"><button class="btn btn-link" title="Delete" style="color:Red;"onclick="deleteauditor(<%Response.Write(revreader["idno"]);%>)"><span class="glyphicon glyphicon-minus-sign"></span></button></th><th style="width:7px"><button title="Edit" class="btn btn-link" onclick="$('#hidrow1<%Response.Write(revreader["idno"]);%>').slideToggle();"><span class="glyphicon glyphicon-edit"></span></button></th><th><%Response.Write(revreader["fname"] + " " + revreader["lname"]);%></th><th><%Response.Write(revreader["rank"]);%></th><th><%Response.Write(revreader["directorate"]);%></th></tr>
             <tr style="background-color:#c2c9cb;display:none" id="hidrow1<%Response.Write(revreader["idno"]);%>"><td colspan="5">
             <center>
             <table class="table table-bordered table-condensed table-striped" style="width:50%" border="1">
             <tr><td><input type="text" class="form-control" id="edaudfname<%Response.Write(revreader["idno"]);%>" value="<%Response.Write(revreader["fname"]);%>"></td></tr>
              <tr><td><input type="text" class="form-control" id="edaudlname<%Response.Write(revreader["idno"]);%>" value="<%Response.Write(revreader["lname"]);%>"></td></tr>
               <tr><td>
               <select class="form-control" id="edaudrank<%Response.Write(revreader["idno"]);%>">
                 <option><%Response.Write(revreader["rank"]);%>
                 <option>Auditor</option>
                 <option>Senior Auditor</option>
                 <option>Audit Manager</option>
                 <option>Audit Director</option>
                 <option>Deputy Auditor General</option>
                 <option>Auditor General</option>
               </select>
               </td></tr>
             <tr><th><select class="form-control" id="edauddir<%Response.Write(revreader["idno"]);%>">
             <option><%Response.Write(revreader["directorate"]);%></option>
                <% 
             
                 con2.Open();
              SqlDataReader dirreader = new SqlCommand("select * from directorate_Table", con2).ExecuteReader();
              while (dirreader.Read()) { 
              %>
              <option><%Response.Write(dirreader["directorate"]);%></option>
              <%
              }
              con2.Close();
                 %>
             </select></th></tr>   
             <tr><td><button class="btn btn-primary" onclick="editauditorinfo(<%Response.Write(revreader["idno"]);%>)"><b>Save changes</b></button><span id="editauditormsg<%Response.Write(revreader["idno"]);%>"></span></td></tr>
             </table>
             </center>
             </td></tr>
             <%
           }
           con.Close();
       }
       catch (Exception ex) {
           con.Close();
           con2.Close();
           Response.Write(ex.StackTrace);
       }
      %>
       </table>
       </div>
   <!-- Reviewr-->
   <div style="padding-left:10px;padding-right:20px;">
   <table class="table table-responsive table-bordered table-condensed table-striped" style="border-bottom:1px dotted #552222">
    <tr style="background-color:#c2c9cb"><th colspan="5"><h4><b style="color:black">Reviewers</b></h4></th></tr>
    <tr><th colspan="5"><ul class="nav nav-pills"><li><a class="btn btn-link" onclick="$('#hidrow').slideToggle();"><b><span class="glyphicon glyphicon-plus"></span>Add reviewer</b></a></li></ul></th></tr>
    <tr style="display:none" id="hidrow"><td colspan="5"><table class="table table-responsive" border="1">
    <tr><th>First name</th><th>Last name</th><th>Rank</th><th>Date</th></tr>
    <tr><th><input type="text" class="form-control" id="revfname"></th><th><input type="text" class="form-control" id="revlname"></th><th>
    <select class="form-control" id="revrank">
    <option>Auditor</option>
    <option>Senior Auditor</option>
    <option>Audit Manager</option>
    <option>Audit Director</option>
    <option>Deputy Auditor General</option>
    <option>Auditor General</option>
    </select>
    </th>
    <th><input type="date" class="form-control" id="revdate"></th>
    </tr>
         <%if (auditId != 0)
         {%>
        <tr><td colspan="4"><button class="btn btn-primary" onclick="savereviewer()">Save</button><span id="revmsg"></span></td></tr>
       <%} %>
    </table>
    </td></tr>
    <% try
       {
           con.Open();
           SqlDataReader revreader = new SqlCommand("select * from reviewer_Table where auditId=" + auditId, con).ExecuteReader();
           while (revreader.Read()) { 
             %>
             <tr><th style="width:7px;"><button class="btn btn-link" title="Delete" style="color:Red;"onclick="deletereviewer(<%Response.Write(revreader["revId"]);%>)"><span class="glyphicon glyphicon-minus-sign"></span></button></th><th style="width:7px"><button class="btn btn-link" title="Edit" onclick="$('#hidrow<%Response.Write(revreader["revId"]);%>').slideToggle();"><span class="glyphicon glyphicon-edit"></span></button></th><th><%Response.Write(revreader["fname"] + " " + revreader["lname"]);%></th><th><%Response.Write(revreader["rank"]);%></th><th><%Response.Write(revreader["date"]);%></th></tr>
             <tr style="background-color:#c2c9cb;display:none" id="hidrow<%Response.Write(revreader["revId"]);%>"><td colspan="5">
             <center>
             <table class="table table-responsive table-hover table-bordered table-condensed table-striped" style="width:50%" border="1">
             <tr><td><input type="text" class="form-control" id="edrevfname<%Response.Write(revreader["revId"]);%>" value="<%Response.Write(revreader["fname"]);%>"></td></tr>
              <tr><td><input type="text" class="form-control" id="edrevlname<%Response.Write(revreader["revId"]);%>" value="<%Response.Write(revreader["lname"]);%>"></td></tr>
               <tr><td>
               <select class="form-control" id="edrevrank<%Response.Write(revreader["revId"]);%>">
                 <option><%Response.Write(revreader["rank"]);%>
                 <option>Auditor</option>
                 <option>Senior Auditor</option>
                 <option>Audit Manager</option>
                 <option>Audit Director</option>
                 <option>Deputy Auditor General</option>
                 <option>Auditor General</option>
               </select>
               </td></tr>
             <tr><td><input type="date" class="form-control" id="edrevdate<%Response.Write(revreader["revId"]);%>" value="<%Response.Write(revreader["date"]);%>"></td></tr>   
             <tr><td><button class="btn btn-primary" onclick="editreviewerinfo(<%Response.Write(revreader["revId"]);%>)"><b>Save changes</b></button><span id="revmsg<%Response.Write(revreader["revId"]);%>"></span></td></tr>
             </table>
             </center>
             </td></tr>
             <%
           }
           con.Close();
       }
       catch (Exception ex) { 
       
       }
      %>
       </table>
       <hr>
   &nbsp; <%if (Request.Cookies["auditId"].Value != "")
            {%>
              <table class="table table-responsive table-condensed table-hover table-bordered table-striped">
     <tr><td colspan="3"><p style="font-family:Times New Roman;font-size:larger"></p></td></tr>
     <tr><td colspan="2"><a href="auditor_recordfindingsAndRecommendations.aspx" class="btn btn-link" style="background-color:#3479c6;color:white">Record findings and recommendations</a></td><td></td></tr>
     </table>
            <%} %>
            </div>
    </div>
        
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
