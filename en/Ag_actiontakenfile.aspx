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
<script language="javascript">
    function searchfile() {
        window.open("Ag_actiontakenfile.aspx?selauditee=" + document.getElementById("selauditee").value + "&selyear=" + document.getElementById("selyear").value + "&selaudittype=" + document.getElementById("selaudittype").value, "_self");
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
     <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../am/auditor_home.aspx"><img src="images/et.png" width="20" height="10"/>አማርኛ</a></div>
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
    <div class="col-sm-10" style="padding-left:0px;height:1000px;overflow:auto;">
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
     <p class="navbar-brand">logged as <%Response.Write(name);%>&nbsp<%Response.Write(last); %> <i>[<%Response.Write(role); %>]</i></p>
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
         
        
         <table class="table-table table-responsive table-condensed table-hover table-striped table-bordered">
         <tr><td>Select auditee</td><td>Select audit type</td><td colspan="2">Select audit year</td></tr>
         <tr>
         <td>
     <select class="form-control" id="selauditee" name="selauditee" style="border:1px solid black">
     <option value="0">All</option>
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
     <select class="form-control" id="selaudittype" name="selaudittype" style="border:1px solid black">
     <option value="0">All</option>
      <%try
        {
            con.Open();
            SqlDataReader audittypeReader = new SqlCommand("select * from auditType_Table", con).ExecuteReader();
            while (audittypeReader.Read())
            { 
            %>
              <option value="<%Response.Write(audittypeReader["typeId"]);%>"><%Response.Write(audittypeReader["auditType"]);%></option>
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
      <select class="form-control" id="selyear" name="selyear" style="border:1px solid black">
      <option value="0">All</option>
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
    <td><button class="btn btn-primary"  onclick="searchfile()"><span class="glyphicon glyphicon-search"></span>Search action taken file</button></td>
         </tr>
         </table>
         <table class="table table-bordered table-condensed table-responsive table-striped">
        <tr><th colspan="5" style="background-color:#c2c9cb">Result</th></tr>
        <tr><th colspan="5">Click on the hyper link to download the file</th></tr>
         <tr><td>File</td><td>Auditee</td><td>Audit type</td><td>Audit year</td><td>File uploaded date</td></tr>
     
         <%
            
             string sql = "select TOP 10 * from actionplanfile_Table where ftype=2";
             if (Request["selauditee"] != null && Request["selauditee"] != "" && Request["selauditee"] != "0")
             {
                 sql += " and orgId=" + int.Parse(Request["selauditee"]);
                 sql.Replace("TOP 10", "");
             }
             if (Request["selyear"] != null && Request["selyear"] != "" && Request["selyear"] != "0")
             {
                 sql += " and year='" + Request["selyear"]+"'";
                 sql.Replace("TOP 10", "");
             }
             if (Request["selaudittype"] != null && Request["selaudittype"] != "" && Request["selaudittype"] != "0")
             {
                 sql += " and auditType=" + int.Parse(Request["selaudittype"]);
                 sql.Replace("TOP 10", "");
             }
             sql += " order by fId desc";
             
             con.Open();
           SqlDataReader reader2 = new SqlCommand(sql, con).ExecuteReader();
             while (reader2.Read()) {
                 con2.Open();
                 string orgname = "";
                 string audtype = "";
                 SqlDataReader orgreader=new SqlCommand("select orgName from org_Table where orgId="+(int)reader2["orgId"],con2).ExecuteReader();
                   while(orgreader.Read()){
                        orgname=orgreader["orgName"].ToString();
                   }
                 con2.Close();
                 con2.Open();
                 SqlDataReader audtypereader = new SqlCommand("select auditType from auditType_Table where typeId=" + (int)reader2["auditType"], con2).ExecuteReader();
                 while (audtypereader.Read()) {
                     audtype = audtypereader["auditType"].ToString();
                 }
                 con2.Close();
                 %>
                 <tr><td><a href="../Files/<%Response.Write(reader2["filename"]);%>" class="btn btn-link"><span class="glyphicon glyphicon-download"></span><%Response.Write(reader2["filename"]);%></a></td><td><%Response.Write(orgname);%></td><td><%Response.Write(audtype);%></td><td><%Response.Write(reader2["year"]);%></td><td><%Response.Write(reader2["date"]);%></td></tr>
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
