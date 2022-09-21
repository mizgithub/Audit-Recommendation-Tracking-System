<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>audits</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="images/logoOFAG.png">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
   
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
       
                window.open("admin_showaudits.aspx?auditId="+auditId, "_self");
    }
    function openaudit(auditId) {
       
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("selaudit").value = auditId;
                $("#childcontainer").html(this.responseText);
                $("#perentcontainer").slideDown(0);
                $("body").addClass("disable-scroll");
            }
        };
        http.open("GET", "showauditforconfirm.aspx?auditId=" + auditId, true);
        http.send();
    }
    function confirmsubmiting(auditId) {
        if (confirm("Are you sure? this action will not be undo")) {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    var response = this.responseText;

                    if (response.indexOf("SUC") != -1) {

                        location.reload();
                    }
                    else {
                        
                    }
                    
                }
            };
            http.open("GET", "confirmsubmitrequest.aspx?auditId=" + auditId, true);
            http.send();
        }
    }
    function makebakup() {
        $("#backupmsg").html("<p>የመጠባበቂያ ፋይልን ለማስቀመጥ የዲስክ ስም ያስገቡ<br> (ትክክለኛ ዲስክ ስሞች D:,F:,G:,H:  ... )." +
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
    try
    {
        if (Request.Cookies["user"].Value == null || Request.Cookies["user"].Value == "" || Session["sessionID"] == null)
        {
            Response.Redirect("logout.aspx");
        }
    }
    catch (Exception ex) {
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
      <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../en/admin_audits.aspx"><img src="images/eng.png" width="20" height="10"/>English</a></div>
   <div class="row">
    <div class="col-sm-2" style="overflow:auto;padding-right:0px;">
   <div class="panel panel-default" style="background-color:#c2c9cb; height:1200px;border-right:1px solid black">
        <div class="navbar navbar-default">
           <ul class="nav sidebar-nav btn-primary ">
            <li style="border-bottom: 2px solid #ffffff;"><a href="admin_audits.aspx" style="background-color:#c2c9cb;"><b style="color:black;">ኦዲቶች</b></a></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="admin_setting.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">ማስተካከያዎች</b></a></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="adminreport.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">ሪፖርት</a></b></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="adminactionplanfile.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">የትግበራ ዕቅዶች</a></b></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="adminactiontakenfile.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">በትግበራ ዕቅዱ የተወሰደ እርምጃ</a></b></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="admin_accountsetting.aspx" style="background-color:#c2c9cb;"><b style="color:black;">የመለያ መቸት</b></a></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="admin_activitylog.aspx" style="background-color:#c2c9cb;"><b style="color:black;">የእንቅስቃሴ ምዝግብ</b></a></li>
            <li style="border-bottom: 2px solid #ffffff;border-color:#ffffff"><a href="admin_userManagement.aspx" style="background-color:#c2c9cb;"><b style="color:black;">የተጠቃሚ አስተዳደር</b></a></li>
            <li style="border-bottom: 2px solid #ffffff"><a href="#" style="background-color:#c2c9cb;" onclick="makebakup()"><b style="color:black;">ምትኬ ይዉሰዱ</b></a></li>
            </ul>
        </div>
        </div>
    </div>
    <div class="col-sm-10" style="padding-left:0px;">
    <!--  *******TOP Nagigation bar-->
    <div class="">
     <div class="navbar navbar-inverse"  data-offset-top="70" style="background-color:#c2c9cb;z-index:100; border-radius:0px; border-width:0px;height:40px;">
   <div class="navbar-header">
    <a href="admin_home.aspx" class="navbar-brand" style="color:black"><b>ዋና ገጽ</b></a>
     </div>
     <div class="navbar-header">
    <a href="admin_auditees.aspx" class="navbar-brand" style="color:black"><b>ተገምጋሚ ድርጅቶች</b></a>
     </div>
     <div class="navbar-header">
    <a href="admin_aboutOfag.aspx" class="navbar-brand" style="color:black"><b>ስለ OFAG</b></a>
     </div>
     <div class="navbar-header">
     <p class="navbar-brand">Logged as <%Response.Write(name);%>&nbsp<%Response.Write(last); %> <i>[<%Response.Write(role); %>]</i></p>
     </div>
     <div class="navbar-header">
     <p class="navbar-brand">|</p>
     </div>
     <div class="navbar-header" align="right">
    <a href="logout.aspx" class="navbar-brand" style="color:black"><b>ውጣ</b></a>
     </div>
    
    </div>
    </div>
    <!--************************Confirmation requests************************-->
   <!--  <table class="table table-bordered"><tr style="background-color:#239fc6;color:white"><th>Audit Confirmation Request</th></tr></table>
     <div class="panel panel-primary" style="height:300px;overflow:auto">
     <table class="table table-responsive table-condensed table-hover table-bordered table-striped">
      <%
       /*  try
          {
              con.Open();
              SqlDataReader reqreader = new SqlCommand("select * from submitRequest_Table where status='pending' order by date desc", con).ExecuteReader();
              int counter = 0;
              while (reqreader.Read()) {
                  con2.Open();
                  SqlDataReader senderreader = new SqlCommand("select fname, lname from user_Table where username='" + reqreader["sender"] + "'", con2).ExecuteReader();
                  string sender = "";
                  while (senderreader.Read()) {
                      sender = senderreader["fname"] + " " + senderreader["lname"];
                  }
                  con2.Close();
               %>
               <tr><td style="width:7%;"><button class="btn btn-link" onclick="openaudit(<%Response.Write(reqreader["auditId"]);%>)"><span class="glyphicon glyphicon-folder-open"></span>Open</button></td><td style="width:7%;"><button class="btn btn-link" onclick="confirmsubmiting(<%Response.Write(reqreader["auditId"]);%>)"><span class="glyphicon glyphicon-check"></span>Confirm</button></td><td>Requested by:<%Response.Write(sender);%></td><td>Requested on:<%Response.Write(reqreader["date"]);%></td></tr>
               <%
                  counter++;
              }
              con.Close();
              if (counter == 0) {
                  Response.Write("No new request");
              }
          }
          catch (Exception ex) { 
          
          }
         */
       %>
       </table>
     </div>-->
    <!--***********************Search audits*************************-->

    <div class="panel-heading" style="background-color:#c2c9cb;height:50px;"><h5 style="color:black;font-size:larger"><b>ኦዲት ፈልግ</b></h5></div>
     <table class="table table-responsive"> 
     <tr><th>ተገምጋሚ ድርጅት ምረጥ</th><th>የኦዲት አይነት ምረጥ</th><th>የኦዲት ዓ/ም ምረጥ</th><th>&nbsp;</th></tr> 
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
     <button class="btn btn-primary" onclick="searchaudit()"><span class="glyphicon glyphicon-search"></span>ፈልግ</button>
     </td>
     </tr>
     </table>
     <hr style="border:1px dotted #c2c9cb">
    <div style="height:700px;overflow:auto;" id="auditsearchres">
     
    </div>
    <div class="panel panel-danger" style="position:fixed;top:40px;right:50px;left:90px;height:500px;display:none;background-color:white;z-index:1000;border-width:thick;padding:5px" id="perentcontainer">
    <div class="" style="height:430px;overflow:auto;padding:5px;" id="childcontainer">
    </div>
    <table class="table table-responsive"><tr style="border-top:1px solid #c2c9cb"><td style="text-align:left;">
    
    <button class="btn btn-link" style="background-color:#00cc00;color:white" onclick="confirmsubmiting(document.getElementById('selaudit').value)"><span class="glyphicon glyphicon-check"></span>Confirm</button></td><td style="text-align:right;">
    <button class="btn btn-link" style="background-color:red;color:white" onclick="$('#perentcontainer').slideUp();$('body').removeClass('disable-scroll');"><span class="glyphicon glyphicon-remove"></span>Close</button>
    </td></tr></table>
    </div>
      <input type="hidden" id="selaudit">
         </div>
         </div>
        <div class="panel panel-success"style="position:fixed;top:300px;left:10px;width:500px;height:250px;display:none;z-index:10;border:1px solid #02c9cb" id="buckupcontainer">
          <div class="panel-footer" style="background-color:#c2c9cb;height:20%;border:1px solid #c2c9cb">
          <p style="color:black"><span class="glyphicon glyphicon-floppy-disk"></span>ምትኬ ዉሰድ </p>
          </div>
          <div class="panel-body" id="backupmsg" style="height:60%">
            
          </div>
          <div class="panel-footer" style="background-color:#c2c9cb;height:20%;text-align:right;border:1px solid #c2c9cb">
          <button class="btn-primary" onclick='takebuckup()' style="width:100px">ቀጥል</button>
          <button class="btn-primary" style="color:white;width:100px" onclick="$('#buckupcontainer').slideUp();">አቋርጥ</button>
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
