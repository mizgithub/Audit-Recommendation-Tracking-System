<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>audits</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<link rel="icon" href="images/logoOFAG.png">
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
    function openAudit(auditId) {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                window.open("auditor_recordnewAudit.aspx", "_self");
            }
        };
        http.open("GET", "setcokkieforAudit.aspx?auditId=" + auditId, true);
        http.send();

    }
    function searchaudit() {
       
        var form = new FormData();
      
        form.append("auditee", document.getElementById("selauditee").value);
        form.append("audittype", document.getElementById("selaudittype").value);
        form.append("year", document.getElementById("selyear").value);
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
              
                $("#auditsearchres").html(this.responseText);
            }
        };
        http.open("POST", "searchaudit.aspx", true);
        http.send(form);
    }
    function opensearchedaudit(auditId) {
     
                window.open("Auditor_showAudit.aspx?auditId="+auditId, "_self");
         
       
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
<body>
<%   Response.Cache.SetCacheability(HttpCacheability.NoCache);
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
   Response.Cookies["auditId"].Value = "";
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
      <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../am/audiorAudits.aspx"><img src="images/et.png" width="20" height="10"/>አማርኛ</a></div>
   <div class="row">
    <div class="col-sm-2" style="overflow:auto;padding-right:0px;">
   <div class="panel panel-default" style="background-color:#c2c9cb; height:1000px;border-right:1px solid black">
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
    </div>
    <div class="col-sm-10" style="padding-left:0px;height:1000px">
    <!--  *******TOP Nagigation bar-->
    <div class="">
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
     <p class="navbar-brand">Logged as <%Response.Write(name);%> &nbsp<%Response.Write(last); %> <i>[<%Response.Write(role); %>]</i></p>
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
     <div class="row">
     <div class="col-sm-3">
     <a href="#" class="btn btn-link" onclick="openAudit('')" style="c"><div class="thumbnail rectangle" style="font-size:50px;padding:5px;"><b>
     <span class="glyphicon glyphicon-record"></span>
     <h5><b>Record new audit</b></h5>
     </div></a>
     </div>
     <div class="panel col-sm-9" style="height:200px;border-left:1px solid #c2c9cb;padding-right:20px;">
     <table style="border-bottom:1px solid #c2c9cb" class="table table-striped">
     <tr><th style="background-color:#c2c9cb;height:40px;color:black" valign="center"><span class="glyphicon glyphicon-floppy-disk"></span> Saved audits</th></tr>
     </table>
     <div class="panel-body" style="overflow:auto;height:75%">
     <table class="table table-responsive table-condensed table-hover table-bordered table-striped" style="overflow:auto">
     <%
         try
         {
             con.Open();
             SqlDataReader auditreader = new SqlCommand("select  * from audit_Table where status='saved' and recorderId='"+Request.Cookies["user"].Value+"'",con).ExecuteReader();
             while (auditreader.Read()) {
                 string auditee = "";
                 con2.Open();
                 SqlDataReader auditeereader = new SqlCommand("select orgName from org_Table where orgId=" + (int)auditreader["orgId"], con2).ExecuteReader();
                 while (auditeereader.Read()) {
                     auditee = auditeereader["orgName"].ToString();
                 }
                 con2.Close();
             %>
             <tr><td style="width:20px;"><button class="btn btn-link" onclick="openAudit(<%Response.Write(auditreader["auditId"]);%>)"><span class="glyphicon glyphicon-folder-close"></span>Open</button></td><td style="width:200px;"><%Response.Write(auditreader["auditName"]);%></td><td><%Response.Write(auditee);%></td></tr>
             <%
             }
             con.Close();
         }
         catch (Exception ex) { 
         
         }    
      %>
      </table>
      </div>
     </div>
     </div>
    <table class="table" style="background-color:#c2c9cb;color:black;height:40px;"><tr><th><b>Search audit</b></th></tr></table>
     <table class="table table-responsive table-hover table-condensed table-striped table-bordered"> 
     <tr><th>Select auditee</th><th>Select audit type</th><th>Select audit year</th><th>&nbsp;</th></tr> 
     <tr>
     <td>
     <select class="form-control" id="selauditee">
     <option value="0">All auditees</option>
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
     <td>
      <select class="form-control" id="selaudittype">
      <option value="0">All audit types</option>
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

      <td>
      <select class="form-control" id="selyear">
      <option value="0">ALL year</option>
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
     <td>
     <button class="btn btn-primary" onclick="searchaudit()"><span class="glyphicon glyphicon-search"></span> Search</button>
     </td>
     </tr>
     </table>
     <hr style="border:1px dotted #c2c9cb">
    <div style="height:700px;overflow:auto;" id="auditsearchres">
     
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
