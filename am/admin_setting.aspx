<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>setting</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="images/logoOFAG.png">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
    function openauditeesetting() {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $("#emptycont").html(this.responseText);
            }
        };
        http.open("GET", "auditeesetting.aspx", true);
        http.send();

    }
    function openministrysetting() {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $("#audteeemptycont").html(this.responseText);
            }
        };
        http.open("GET", "ministrysetting.aspx", true);
        http.send();
    }
    function openfederalorgsetting() {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $("#emptycont").html(this.responseText);
            }
        };
        http.open("GET", "federalorgsetting.aspx", true);
        http.send();
    }


    function openaudittypesetting() {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $("#emptycont").html(this.responseText);
            }
        };
        http.open("GET", "audittypesetting.aspx", true);
        http.send();
    }
    function openfindingtypesetting() {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $("#emptycont").html(this.responseText);
            }
        };
        http.open("GET", "findingtypesetting.aspx", true);
        http.send();
    }
    function openauditdirectoratesetting() {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $("#emptycont").html(this.responseText);
            }
        };
        http.open("GET", "auditordirectoratesetting.aspx", true);
        http.send();
    }

    function saveministry() {
        var minName = document.getElementById("fedministry").value;
        if (minName.match(/^[0-9]+$/) != null) {
            $("#minmsg").html("<b style='color:red'> Error in saving. check input values</b>");
        } else {
        if (minName != null && minName != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openministrysetting();
                }
            };
            http.open("GET", "saveministry.aspx?fedministry=" + minName, true);
            http.send();
        }
        else {
            $("#minmsg").html("<b style='color:red'> Error in saving. check input values</b>");
        }
        }
    }
    function deleteministry(minId) {
         if(confirm("Are you sure?")){
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openministrysetting();
                }
            };
            http.open("GET", "deleteministry.aspx?minId=" + minId, true);
            http.send();
         }
    }
    function savechangesministry(minId) {
        var minName = document.getElementById("minvalue" + minId).value;
        if (minName.match(/^[0-9]+$/) != null) {
            $("#minmsg" + minId).html("<b style='color:red'> Error in saving. check input values</b>");
        } else {
        if (minName != null && minName != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openministrysetting();
                }
            };
            http.open("GET", "savechangesofministry.aspx?minId=" + minId + "&minName=" + minName, true);
            http.send();
        }
        else {
            $("#minmsg" + minId).html("<b style='color:red'> Error in saving. check input values</b>");
        }
        }
    }

    function savefederalorg() {
        var fedorg = document.getElementById("fedorg").value;
        if (fedorg.match(/^[0-9]+$/) != null) {
            $("#orgmsg").html("<b style='color:red'> Error in saving. check input values</b>");
        } else {
            var fedministry = document.getElementById("fedministry").value;
            if (fedorg != "" && fedorg != null && fedministry != "" && fedministry != null) {
                var http = new XMLHttpRequest();
                http.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        openfederalorgsetting();
                    }
                };
                http.open("GET", "savefederalorg.aspx?fedministry=" + fedministry + "&fedorg=" + fedorg, true);
                http.send();
            }
            else {
                $("#orgmsg").html("<b style='color:red'> Error in saving. check input values</b>");
             }
        }
    }
    function deleteorg(orgId) {
        if (confirm("Are you sure?")) {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openfederalorgsetting();
                }
            };
            http.open("GET", "deleteorg.aspx?orgId=" + orgId, true);
            http.send();
        }

    }
    function savechangesoforg(orgId) {
        var orgName = document.getElementById("orgvalue" + orgId).value;
        if (orgName.match(/^[0-9]+$/) != null) {
            $("#orgmsg" + orgId).html("<b style='color:red'> Error in saving. check input values</b>");
        } else {
        if (orgName != null && orgName != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openfederalorgsetting();
                }
            };
            http.open("GET", "savechangesoforg.aspx?orgId=" + orgId + "&orgName=" + orgName, true);
            http.send();
        }
        else {
            $("#orgmsg" + orgId).html("<b style='color:red'> Error in saving. check input values</b>");
        }
        }
    }
    function saveaudittype() {
        var audittype = document.getElementById("audittype").value;
        if (audittype.match(/^[0-9]+$/) != null) {
            $("#audtymsg").html("<b style='color:red'> Error in saving. check input values</b>");
        } else {
        if (audittype != null && audittype != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openaudittypesetting();
                }
            };
            http.open("GET", "saveaudittype.aspx?audittype=" + audittype, true);
            http.send();
        }
        else {
            $("#audtymsg").html("<b style='color:red'> Error in saving. check input values</b>");
        }
        }
    }
    function deleteaudittype(typeId) {
        if (confirm("Are you sure?")) {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openaudittypesetting();
                }
            };
            http.open("GET", "deleteaudittype.aspx?typeId=" + typeId, true);
            http.send();
        }
    }
    function savechangesofaudittype(typeId) {
        var auditType = document.getElementById("audittypevalue" + typeId).value;
       if (auditType.match(/^[0-9]+$/) != null) {
            $("#audtymsg"+typeId).html("<b style='color:red'> Error in saving. check input values</b>");
        } else {
        if (auditType != null && auditType != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openaudittypesetting();
                }
            };
            http.open("GET", "savechangesofaudittype.aspx?typeId=" + typeId + "&auditType=" + auditType, true);
            http.send();
        }
        else {
            $("#audtymsg" + typeId).html("<b style='color:red'> Erro in saving. check input values</b>");
        }
        }
    }
    function savedirectorate() {
        var dir = document.getElementById("dir").value;
        if (dir.match(/^[0-9]+$/) != null) {
            $("#dirmsg").html("<b style='color:red'> Error in saving. check input values</b>");
        } else {
        if (dir != null && dir != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openauditdirectoratesetting();
                }
            };
            http.open("GET", "savedirectorate.aspx?dir=" + dir, true);
            http.send();
        }
        else {
            $("#dirmsg").html("<b style='color:red'> Error in saving. check input values</b>");
        }
        }
        
    }
    function deletedirectorate(dirId) {
        if (confirm("Are you sure?")) {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openauditdirectoratesetting();
                }
            };
            http.open("GET", "deletedirectorate.aspx?dirId=" + dirId, true);
            http.send();
        }
    }
    function savechangesofdirectorate(dirId) {
        var dir = document.getElementById("dirvalue" + dirId).value;
        if (dir.match(/^[0-9]+$/) != null) {
            $("#dirmsg" + dirId).html("<b style='color:red'> Error in saving. check input values</b>");
        } else {
        if (dir != null && dir != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openauditdirectoratesetting();
                }
            };
            http.open("GET", "savechangesofdirectorate.aspx?dirId=" + dirId + "&dir=" + dir, true);
            http.send();
        }
        else {
            $("#dirmsg" + dirId).html("<b style='color:red'> Error in saving. check input values</b>");
        }
        }
    }
    function savefindingtype() {
        var findingtype = document.getElementById("findingtype").value;
        if (findingtype.match(/^[0-9]+$/) != null) {
            $("#findtymsg").html("<b style='color:red'> Error in saving. check input values</b>");
        } else {
        if (findingtype != null && findingtype != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openfindingtypesetting();
                }
            };
            http.open("GET", "savefindingtype.aspx?findingtype=" + findingtype, true);
            http.send();
        }
        else {
            $("#findtymsg").html("<b style='color:red'> Error in saving. check input values</b>");
        }
        }
    }
    function deletefindingtype(typeId) {
        if (confirm("Are you sure?")) {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openfindingtypesetting();
                }
            };
            http.open("GET", "deletefindingtype.aspx?typeId=" + typeId, true);
            http.send();
        }
    }
    function savechangesoffindingtype(typeId) {
        var findingType = document.getElementById("findingTypevalue" + typeId).value;
        if (findingType.match(/^[0-9]+$/) != null) {
            $("#findtymsg" + typeId).html("<b style='color:red'> Error in saving. check input values</b>");
        } else {
        if (findingType != null && findingType != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openfindingtypesetting();
                }
            };
            http.open("GET", "savechangesoffindingtype.aspx?typeId=" + typeId + "&findingType=" + findingType, true);
            http.send();
        }
        else {
            $("#findtymsg" + typeId).html("<b style='color:red'> Error in saving. check input values</b>");
        }
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
       
       SqlDataReader reader = new SqlCommand("select fname,lname,role from user_Table where username='"+Request.Cookies["user"].Value+"'",con).ExecuteReader();
       while(reader.Read()){
           role = reader["role"].ToString();
           name=reader["fname"].ToString();
           last=reader["lname"].ToString();
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
       <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../en/admin_setting.aspx"><img src="images/eng.png" width="20" height="10"/>English</a></div>
   <div class="row">
    <div class="col-sm-2" style="overflow:auto;padding-right:0px;">
    <div class="panel panel-default" style="background-color:#c2c9cb; height:1000px;border-right:1px solid black">
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
    <!--************************************************-->
    <div class="row">
    <div class="col-sm-3">
    <div class="panel panel-default" style="height:900px;border-width:0px;border-right:1px solid #777777;border-radius:0px;">
    <table class="table table-responsive">
    <tr><td><button class="btn btn-link" onclick="openauditdirectoratesetting()"><span class="glyphicon glyphicon-cog"></span> ኦዲት ዳይሬክቶሬት ማስተካከያ</button></td></tr>
    <tr><td><button class="btn btn-link" onclick="openfederalorgsetting()"><span class="glyphicon glyphicon-cog"></span> የተገምጋሚ ድርጅት ማስተካከያ</button></td></tr>
    <tr><td><button class="btn btn-link" onclick="openaudittypesetting()"><span class="glyphicon glyphicon-cog"></span> የኦዲት አይነት ማስተካከያ</button></td></tr>
    <tr><td><button class="btn btn-link" onclick="openfindingtypesetting()"><span class="glyphicon glyphicon-cog"></span> የግኝት አይነት ማስተካከያ</button></td></tr>
  
    </table>
    </div>
    </div>
    <div class="col-sm-9">
    <div id="emptycont">
   
    <h3>ከአንዱ የማስተካከያ ቁልፎች በአንዱ ላይ ጠቅ ያድርጉ</h3>
  
    </div>
    </div>
    </div>
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
