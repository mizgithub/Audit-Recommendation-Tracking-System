<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>about OFAG</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="images/logoOFAG.png">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
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
     if (Request.Cookies["user"].Value == null || Request.Cookies["user"].Value == "" ||Session["sessionID"] == null)
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
      <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../en/admin_aboutOfag.aspx"><img src="images/eng.png" width="20" height="10"/>English</a></div>
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
    <div class="col-sm-10" style="padding-left:0px;height:1200px;overflow:auto;">
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
     <p class="navbar-brand">Logged as <%Response.Write(name); %>&nbsp<%Response.Write(last); %> <i>[<%Response.Write(role); %>]</i></p>
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
      <div class="panel panel-default" style="padding:10px;overflow:auto;">
        <div style="float:left; width:50%">
       <h1>The Office Of The Federal Auditor General</h1><HR>
       <p style="font-size:medium">We exist to deliver reliable and objective information through our audit reports to support the House of Peoples' Representatives in carrying out its responsibilities, to strengthen the performance and accountability of the Federal Government for the benefit of the Ethiopian people. By providing reliable and objective information through enhancing the audit profession, our vision is to strengthen the performance, transparency, democratization process, accountability as well as the good governance of the Federal Government for the benefit of the Ethiopian people.</p>
         <hr></div>
         <div style="width:50%;float:right">
         <img src="images/ofagmainoffice.jpg" style="width:80%;height:80%">
         </div>
         <hr>
         <H3>VISSION</h3>
         <P>

         To become one of model SAI’s in Africa by 2017.</P><hr>
         <H3>MISSION</h3>
         <HR>
         <P>Provide quality, wide coverage and timely audit service by maintaining professional independence, teamwork, and integrity to assist in ensuring good governance and enhance government performance capabilities.</P>
        <hr>
         <H3>CORE VALUES</h3>
         <P>
         <UL>
         
             <LI>Team Work</LI>
             <LI>Accountability</LI>
              <LI>Reliability</LI>
              <LI>Integrity</LI>
             <LI>Commitment</LI>


         </UL>
         </P>
         <hr>
         <H3>OUR MANDATES</H3>
         <P>PROCLAMATION NO. 982/2016 A PROCLAMATION TO RE-ESTABLSIH THE OFFICE OF THE FEDERAL AUDITOR GENERAL.

WHEREAS, strengthening the audit system in the country plays an important role in providing reliable data useful for the effective management and administration of the national economy...</P>
         <HR>
         <H3>CONSTITUTIONAL PROVISION</h1>
         <P>
         The Auditor General
         <OL>
         Article 101


  <LI>  The Auditor General shall, upon recommendation of the Prime Minister, be appointed by the House of Peoples’ Representatives.</LI> 
  <LI>   The Auditor General shall audit and inspect the accounts of ministries and other agencies of the Federal Government to ensure that expenditures are properly made for activities carried out during the fiscal year and in accordance with the approved allocations, and submit his reports thereon to the House of Peoples’ Representatives.</LI>
    <LI> The Auditor General shall draw up and submit for approval to the House of Peoples’ Representatives his office’s annual budget.</LI>
    <LI> The details of functions of the Auditor General shall be determined by law.</LI>


         </OL>
         </P>
         <a href="http://www.ofag.gov.et">OFAG official website</a>
                 </div>
                 <br>
             
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
