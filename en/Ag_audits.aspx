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
       
                window.open("Ag_showAudit.aspx?auditId="+auditId, "_self");
       
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
       <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../am/Ag_audits.aspx"><img src="images/et.png" width="20" height="10"/>አማርኛ</a></div>
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
    <div class="col-sm-10" style="padding-left:0px;height:1000px">
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
    <div class="panel-heading" style="background-color:#c2c9cb;height:50px;"><h5 style="color:black;font-size:larger"><b>Search Audit</b></h5></div>
     <table class="table table-responsive"> 
     <tr><th>Select auditee</th><th>Select audit Type</th><th>Select audit Year</th><th>&nbsp;</th></tr> 
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
