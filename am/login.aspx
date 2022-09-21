<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
    
    window.onunload = function () { null };
    function preventback() {
        window.history.forward(); 
       
    }
    function loging(args) {
        if (args.keyCode == 13) {
            authenticateLogin();
        }

    }
    function authenticateLogin() {
        $("#loginicon").html("<center>Plesae Wait...<img src='images/facebook.gif' height='5%' width='5%'></center>");
        var form = new FormData(document.getElementById("loginform"));
        var http = new XMLHttpRequest();

        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                var response = this.responseText;
                if (response.indexOf("OFAG1") != -1) {
                    window.open("admin_home.aspx", "_self");
                }
                else if (response.indexOf("OFAG2") != -1) {
                    window.open("Ag_home.aspx", "_self");
                }
                else if (response.indexOf("OFAG3") != -1) {
                    window.open("pac_home.aspx", "_self");
                }
                else if (response.indexOf("OFAG4") != -1) {
                    window.open("auditor_home.aspx", "_self")
                }
                else if (response.indexOf("UNSUC1") != -1) {
                    $("#loginicon").html("<center><h5 style='color:red'>Your account is Not active.</h5></center>");
                }
                else if (response.indexOf("UNSUC2") != -1) {
                    $("#loginicon").html("<center><h5 style='color:red'>Wrong username and or password.</h5></center>");
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
<body onload="preventback()">
    <div class="" style="height:70px;">
   
     <img src="images/logoimg.png" style="height:70px;" class="btn-block img-responsive"/>
    
     </div>
    <div style="background-color:InfoBackground">&nbsp;</div>
   <hr style="border:6px solid #00c69f">
   <div class="panel panel-default" style="height:450px;">
   <div class="row">
     <div class="col-sm-4">
     </div>
     <div class="col-sm-4">
    <div class="panel panel-default">
     <div class="panel-heading" >
        <h3 align="center">Please Login</h3>
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
        <center><b><p id="errormsg" style="color:Red;"></p></b></center>
        <button  type="button" class="btn btn-primary btn-block" onclick="authenticateLogin()" >Login</button>
     </div>
     <div class="panel-footer">
     
     <p>If you forgot your username and/or password Contact System Administrator</p>

     </div>
   </div>
     </div>
   </div>
   </div>
   <div class="panel-footer" style="background-color:#009fc6;">
   <img src="images/logoOFAG.png" class="" style="width:2%;height:2%;">
   <b style="font-family:Times New Roman;color:white;">Powered by Office of The Federal Auditor General 
   <i> &nbsp;&nbsp;&nbsp;&nbsp;Contact: TEL:9890545454 &nbsp;&nbsp;&nbsp;&nbsp; EMAIL:something@something.Com &nbsp;&nbsp;&nbsp;&nbsp; PO.BOX.:</i></b>
   </div>
</body>
</html>
