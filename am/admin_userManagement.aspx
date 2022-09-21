<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>users</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<link rel="icon" href="images/logoOFAG.png">
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
    function generateusername() {
 
        var fname = document.getElementById("fname").value;
        var lname = document.getElementById("lname").value;
        if (fname != "" && fname != null && lname != "" && lname != null) {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    var response = this.responseText;
                    var firstindex = response.indexOf("*");
                    var lastIndex = response.lastIndexOf("*");
                  
                    document.getElementById("uname").value = response.substring(firstindex+1, lastIndex);
                }
            };
            http.open("GET", "generateusername.aspx?fname=" + fname + "&lname=" + lname, true);
            http.send();
        }
        else {
            alert("fill First name and Last name of the user");
            if (document.getElementById("fname").value == "") {
                document.getElementById("fname").focus();
            }
            else {
                document.getElementById("lname").focus();
            }
        }
    }
    function saveauditeeuser() {
       
        var form = new FormData();
        form.append("selauditee", document.getElementById("selauditee").value);
        form.append("uname", document.getElementById("auduname").value);
         form.append("pass", document.getElementById("audpass").value);
         if (document.getElementById("audpass").value.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/)) {


             if (document.getElementById("audpass").value != "" && document.getElementById("auduname").value != "") {
                 if (document.getElementById("audpass").value == document.getElementById("audcpass").value) {
                     var http = new XMLHttpRequest();
                     http.onreadystatechange = function () {
                         if (this.readyState == 4 && this.status == 200) {
                             var response = this.responseText;

                             var index = response.indexOf("THETRICKBECAUSEOFASPX");

                             if (index != -1) {
                                 $("#auderrmsg").html("User not registered!!</br>Possible causes:-<br>-Auditee is already registred<br>-Username is used by an other auditee");
                                 document.getElementById("auduname").focus();
                             }
                             else {

                                 location.reload();
                             }
                         }
                     };
                     http.open("POST", "saveauditeeuser.aspx", true);
                     http.send(form);
                 }
                 else {
                     $("#auderrmsg").html("<b style='color:red'>Error in saving. Check input values</b>");
                 }
             }
             else {
                 $("#auderrmsg").html("<b style='color:red'>Error in saving. Check input values</b>");
             }
         }
          else {
              $("#auderrmsg").html("Password should be Minimum of eight characters contain at least one uppercase letter, one lowercase letter and one number:");
         }
        
        
    }
    function saveuser() {
        var form = new FormData();
        form.append("fname", document.getElementById("fname").value);
        form.append("lname", document.getElementById("lname").value);
        form.append("role", document.getElementById("urole").value);
        form.append("uname", document.getElementById("uname").value);
        form.append("pass", document.getElementById("pass").value);
        if (document.getElementById("pass").value.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/)) {
        if (document.getElementById("fname").value.match(/^[0-9]+$/) != null || document.getElementById("lname").value.match(/^[0-9]+$/) != null || document.getElementById("lname").value == "" || document.getElementById("fname").value == "") {
            $("#errormsg").html("<b style='color:red'>Error in saving. Check input values</b>");
        }
        else {
            if (document.getElementById("pass").value != "" && document.getElementById("uname").value != "") {
                if (document.getElementById("pass").value == document.getElementById("cpass").value) {
                    var http = new XMLHttpRequest();
                    http.onreadystatechange = function () {
                        if (this.readyState == 4 && this.status == 200) {
                            var response = this.responseText;
                            var index = response.indexOf("THETRICKBECAUSEOFASPX");

                            if (index != -1) {
                                $("#errormsg").html("User not registered</br>Please check username");
                                document.getElementById("uname").focus();
                            }
                            else {
                               
                                location.reload();
                            }
                        }
                    };
                    http.open("POST", "saveuser.aspx", true);
                    http.send(form);
                }
                else {
                    $("#errormsg").html("<b style='color:red'>Error in saving. Check input values</b>");
                }
            }
            else {
                $("#errormsg").html("<b style='color:red'>Error in saving. Check input values</b>");
            }
        }
        }
          else {
          $("#errormsg").html("Password should be Minimum of eight characters contain at least one uppercase letter, one lowercase letter and one number:");
        }
    }
    function savechangesofauditeeuser(idno,uname) {
        var auditee = document.getElementById("selauditee" + idno).value;


        var newaudpass = document.getElementById("newaudpass" + idno).value;
        var newaudcpass = document.getElementById("newaudcpass" + idno).value;
        alert(auditee + " " + newaudpass);
        var form = new FormData();



        form.append("pass", newaudpass);
        form.append("orgId", auditee);
        form.append("uname", uname);
         if (document.getElementById("newaudpass"+idno).value.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/)) {


        if (newaudpass == newaudcpass) {

            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                   
                    getregistereduser();
                }
            };
            http.open("POST", "savechangesofauditeeuser.aspx", true);
            http.send(form);
        }
        else {
            $("#errormsgaud" + idno).html("<b style='color:red'> Error in saving. check input values</b>");
        }

         }
          else {
           $("#errormsgaud" + idno).html("<b style='color:red'>Password should be Minimum of eight characters contain at least one uppercase letter, one lowercase letter and one number</b>");
         }

    }
    function savechangesofuser(idno) {
        var newfname = document.getElementById("newfname" + idno).value;
        var newlname = document.getElementById("newlname" + idno).value;
        var newrole = document.getElementById("newrole" + idno).value;
        var newpass = document.getElementById("newpass" + idno).value;
        var newcpass = document.getElementById("newcpass" + idno).value;

        var form = new FormData();
        form.append("fname", newfname);
        form.append("lname", newlname);
        form.append("role", newrole);
        form.append("pass", newpass);
        form.append("idno", idno);
        if (document.getElementById("newpass"+idno).value.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/)) {
            if (newfname.match(/^[0-9]+$/) != null || newlname.match(/^[0-9]+$/) != null || newfname == "" || newlname == "") {
                $("#errormsg" + idno).html("<b style='color:red'> Error in saving. check input values</b>");
            }
            else {
                if (newpass == newcpass) {

                    var http = new XMLHttpRequest();
                    http.onreadystatechange = function () {
                        if (this.readyState == 4 && this.status == 200) {
                            getregistereduser();
                        }
                    };
                    http.open("POST", "savechangesofuser.aspx", true);
                    http.send(form);
                }
                else {
                    $("#errormsg" + idno).html("<b style='color:red'> Error in saving. check input values</b>");
                }
            }
        }
        else {
            $("#errormsg" + idno).html("<b style='color:red'>Password should be Minimum of eight characters contain at least one uppercase letter, one lowercase letter and one number</b>");
        }

        }
        function disableauduser(idno, status) {
            if (confirm("Aye you sure?")) {
                if (status == 1) {
                    status = "deactive";
                }
                if (status == 2) {
                    status = "active";
                }
                var http = new XMLHttpRequest();
                http.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        if (status == "active") {
                            var str = "deactive";
                            $("#disbutaud" + idno).html("<button style='color:red' class='btn btn-link' onclick='disableuser(" + idno + ",1)'><span class='glyphicon glyphicon-off'></span>Disable</button>");
                        }
                        else {
                            var str = "active";
                            $("#disbutaud" + idno).html("<button style='color:#23dd23' class='btn btn-link' onclick='disableuser(" + idno + ",2)'><span class='glyphicon glyphicon-check'></span>Enable</button>");

                        }
                    }
                };
                http.open("GET", "enabledisableauditeeuser.aspx?idno=" + idno + "&status=" + status, true);
                http.send();
            }

        }
    function disableuser(idno, status) {
        if (confirm("Aye you sure?")) {
            if (status == 1) {
                status = "deactive";
            }
            if (status == 2) {
                status = "active";
            }
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    if (status == "active") {
                        var str = "deactive";
                        $("#disbut" + idno).html("<button style='color:red' class='btn btn-link' onclick='disableuser(" + idno + ",1)'><span class='glyphicon glyphicon-off'></span>Disable</button>");
                    }
                    else {
                        var str = "active";
                        $("#disbut" + idno).html("<button style='color:#23dd23' class='btn btn-link' onclick='disableuser(" + idno + ",2)'><span class='glyphicon glyphicon-check'></span>Enable</button>");

                    }
                }
            };
            http.open("GET", "enabledisableuser.aspx?idno=" + idno + "&status=" + status, true);
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
    function getregistereduser() {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $("#regusercont").html(this.responseText);
            }
        };
        http.open("GET", "registeredusers.aspx?reguser=" + document.getElementById("reguser").value, true);
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
       <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../en/admin_userManagement.aspx"><img src="images/eng.png" width="20" height="10"/>English</a></div>
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
    <div class="col-sm-10" style="padding-left:0px;height:1200px;overflow:auto">
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
         <ul class="nav nav-tabs">
         <li><a class="" onclick="$('#form').slideToggle();$('#ctraud').slideUp();"><span class="glyphicon glyphicon-plus"></span>የተጠቃሚ መለያ ይፍጠሩ</a></li>
         <li><a class="" onclick="$('#form').slideUp();$('#ctraud').slideToggle();"><span class="glyphicon glyphicon-plus"></span>የተገምጋሚ ድርጅት መለያ ይፍጠሩ</a></li></ul>
          <div class="panel panel-default" id="ctraud" style="display:none;">
          <center> <table class="table table-responsive table-bordered" border="1"><tr><td>
           <table class="table table-responsive table-bordered" style="width:100%;" border="1">
            <tr>
            <th style="width:150px">ተገምጋሚ ድርጅት ምረጥ</th> <td>
     <select class="form-control" id="selauditee" style="border:1px solid black">
    
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
            </tr>
           
            <tr>
            <th>መለያ ስም</th><td><input type="text" class="form-control" id="auduname" style="border:0.5px solid #888888; font-size:larger" placeholder="ልዩ የተጠቃሚ ስም"></td>
            </tr>

            <tr>
            <th>የይለፍ ቃል</th><td><input type="text" class="form-control" id="audpass" style="border:0.5px solid #888888"></td>
            </tr>

             <tr>
            <th>የይለፍ ቃል አረጋግጥ</th><td><input type="text" class="form-control" id="audcpass" style="border:0.5px solid #888888"></td>
            </tr>
            <tr><td colspan="2"><button class="btn btn-primary btn-block" onclick="saveauditeeuser()">መለያ ፍጠር</button></td></tr>
            </table>
            </td><td align="left" valign="center" style="width:50%">
              <h4 style="color:red;"id="auderrmsg"></h4><h4 style="color:#343434;text-align:justify">የተጠቃሚውን አስፈላጊ መረጃ ያስገቡ.<br><b></b><h4></h4>
              </td></tr></table></center>
          </div>
          
          <div class="panel panel-default" id="form" style="display:none;">
          <center> <table class="table table-responsive table-bordered" border="1"><tr><td>
           <table class="table table-responsive table-bordered" style="width:100%;" border="1">
            <tr>
            <th style="width:150px">የመጀመሪያ ስም</th><td><input type="text" class="form-control" id="fname" style="border:0.5px solid #888888"></td>
            </tr>

            <tr>
            <th>የአባት ስም</th><td><input type="text" class="form-control" id="lname" style="border:0.5px solid #888888"></td>
            </tr>
             <tr>
            <th>የተጠቃሚ ሚና</th><td>
            <select id="urole" style="border:0.5px solid #888888" class="form-control">
            <option>System Administrator</option>
            <option>Auditor General</option>
            <option>Special Assistant to Auditor General</option>
            <option>Deputy Auditor General</option>
            <option>PAC Member</option>
            <option>Audit Director</option>
            <option>Data Encoder</option>
            </select>
            </td>
            </tr>
            <tr>
            <th>መለያ ስም</th><td><input type="text" class="form-control" id="uname" style="border:0.5px solid #888888; font-size:larger" placeholder="ልዩ የተጠቃሚ ስም" onfocus="generateusername()"></td>
            </tr>

            <tr>
            <th>የይለፍ ቃል</th><td><input type="text" class="form-control" id="pass" style="border:0.5px solid #888888"></td>
            </tr>

             <tr>
            <th>የይለፍ ቃል ያረጋግጡ</th><td><input type="text" class="form-control" id="cpass" style="border:0.5px solid #888888"></td>
            </tr>
            <tr><td colspan="2"><button class="btn btn-primary btn-block" onclick="saveuser()">መለያ ፍጠር</button></td></tr>
            </table>
            </td><td align="left" valign="center" style="width:50%">
              <h4 style="color:red;"id="errormsg"></h4><h4 style="color:#343434;text-align:justify">የተጠቃሚውን አስፈላጊ መረጃ ያስገቡ.<br><b>ማስታወሻ:</b>ስርዓቱ ልዩ መለያ ስም ያመነጫል, ነገር ግን መለወጥ ከፈለጉ ልዩ መለያ ስም ያስገቡ.<h4></h4>
              </td></tr></table></center>
          </div>
          <hr style="border: 1px solid #888888">

          <table class="table table-responsive table-condensed table-hover table-bordered table-striped">
          <tr><th style="background-color:#c2c9cb;color:black"><h5 style="color:black;"><b>የተመዘገቡ ተጠቃሚዎች</b></h5></th><th style="background-color:#c2c9cb"><input type="text" class="form-control" id="reguser" style="width:200px;" placeholder="search user/first name" onkeyup="getregistereduser()"></th></tr></table>
          <div class="panel panel-primary" id="regusercont">
          </div>
         </div>
         </div>
          <div class="panel panel-success"style="position:fixed;top:300px;left:10px;width:500px;height:250px;display:none;z-index:10;border:1px solid #02c9cb" id="buckupcontainer">
          <div class="panel-footer" style="background-color:#c2c9cb;height:20%;border:1px solid #c2c9cb">
          <p style="color:black"><span class="glyphicon glyphicon-floppy-disk"></span>ምትኬ ዉሰድ</p>
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
