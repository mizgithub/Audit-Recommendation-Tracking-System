<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ARTS Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<link rel="icon" href="images/logoOFAG.png">
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
    function initializing() {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                if (this.responseText == "0") {
                    creatingadmin();
                }
                else {
                   
                }
            }

        };
        http.open("GET", "initializing.aspx", true);
        http.send();
    }
    function creatingadmin(){
        $("#initcontainer").slideDown();
        
        $("#intmsg").html("<center>Please Wait...<img src='images/facebook.gif' height='5%' width='5%'></center>");
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $("#intmsg").html(this.responseText);
            }
        };
        http.open("GET","creatingadmin.aspx",true);
        http.send();  
        
    }
    function loging(args) {
        if (args.keyCode == 13) {
            authenticateLogin();
        }

    }
    function authenticateLogin() {
        
        $("#errormsg").html("");
        $("#loginicon").html("<center>Please Wait...<img src='images/facebook.gif' height='5%' width='5%'></center>");
        var form = new FormData(document.getElementById("loginform"));
        var http = new XMLHttpRequest();

        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                var response = this.responseText;
                if (response.indexOf("Your") != -1) {
                    $("#exp").html(response);
                }
                else {
                    if (response.indexOf("OFAG1") != -1) {
                        window.open("am/admin_home.aspx", "_self");
                    }
                    else if (response.indexOf("OFAG2") != -1) {
                        window.open("am/Ag_home.aspx", "_self");
                    }
                    else if (response.indexOf("OFAG3") != -1) {
                        window.open("am/pac_home.aspx", "_self");
                    }
                    else if (response.indexOf("OFAG4") != -1) {
                        window.open("am/auditor_home.aspx", "_self");
                    }
                    else if (response.indexOf("OFAG5") != -1) {
                        window.open("am/auditeehome.aspx", "_self");
                    }
                    else if (response.indexOf("UNSUC1") != -1) {
                        $("#errormsg").html("<center><h5 style='color:red;'>Your account is Not active.</h5></center>");
                        $("#loginicon").html("");
                    }
                    else if (response.indexOf("UNSUC2") != -1) {
                        $("#errormsg").html("<center><h5 style='color:red'>Wrong username and or password.</h5></center>");
                        $("#loginicon").html("");
                    }
                }

            }
        };
        http.open("POST", "authenticateLogin.aspx", true);
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
<body onload="initializing()" style="background-color:white;">
    <div class="" style="height:70px;">
   
     <img src="images/logoimg.png" style="height:70px;" class="btn-block img-responsive"/>
    
     </div>
    <div style="background-color:white">&nbsp;</div>
   <div class="panel panel-default" style="">

   <div class="row" style="padding-right:20px;padding-left:100px;background-color:white;">
     <div class="col-sm-4"></div>
     <div class="col-sm-4">
    <div class="panel panel-primary" style="height:440px;">
     <div class="panel-heading" style="background-color:#049dc6;">
        <h3 align="center">Please login</h3>
        <center><span id="loginicon"></span></center>
        <div class="page-header"></div>
     </div>
     <div class="panel-body">
       <form id="loginform">
       <div class="form-group">
       <div class="input-group"><span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
          <input type="text"  name="username" class="form-control" id="username" placeholder="Enter username"/></div><br>
          <div class="input-group">
         <span class="input-group-addon"> <i class="glyphicon glyphicon-lock"></i></span>
          <input type="password" name="password" class="form-control" id="password" placeholder="Enter password" onkeypress="loging(event);" /></div> 
       </div>
      
      
       </form>
        <center><b><div id="errormsg" style="color:Red;"></div></b></center>
        <button  type="button" class="btn btn-primary btn-block" onclick="authenticateLogin()" >Login</button>
     </div>
     <div class="panel-footer">
     
     <p>If you forgot your username and/or password Contact System Administrator</p>

     </div>
   </div>
     </div>
   </div>
   </div>
      <div class="panel panel-success"style="position:fixed;top:30%;left:30%;width:500px;height:250px;display:none;z-index:100;border:thick solid #002345" id="initcontainer">
        <div class="panel-footer" style="background-color:#009fc6;height:20%;border:1px solid #232323">
          <p style="color:white"><span class="glyphicon glyphicon-user"></span>Creating default System administrator</p>
          </div>
          <div class="panel-body" id="intmsg" style="height:60%">
            
          </div>
          <div class="panel-footer" style="background-color:#c2c9cb ;height:20%;text-align:right;border:1px solid #232323">
          
          <button class="btn-danger" style="color:white;width:100px" onclick="$('#initcontainer').slideUp();">Close</button>
          </div>
         </div>
        <center>
   <h4 style="color:red" id="exp"></h4></center>
</body>
</html>
