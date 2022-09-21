<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<script runat="server">

 protected void Page_Load(object sender, EventArgs e)
    {
        string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(@conString);
       
      try
        {
            con.Open();
            
            SqlDataReader myCommand = new SqlCommand("select auditType,typeId from auditType_Table", con).ExecuteReader();
            while (myCommand.Read())
            {
                selaudittype.Items.Add(new ListItem(myCommand["auditType"].ToString(), myCommand["typeId"].ToString()));
                selaudittype2.Items.Add(new ListItem(myCommand["auditType"].ToString(), myCommand["typeId"].ToString()));
            }
            con.Close();
            
            List<int> yearlist=new List<int>();
           int today = int.Parse(DateTime.Now.ToString("yyyy"));
            
            while (today>=1950)
            {
                yearlist.Add(today);
              
                today--;
            }
           
         foreach(int year in yearlist){
            selyear.Items.Add(year+"");
            selyear2.Items.Add(year + "");
             
         }
            
         
        }
        catch (Exception ex) {
            con.Close();
        }
         
        
    }
 protected void uploadfile(object sender, EventArgs e)
 {
    
     string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
     SqlConnection con = new SqlConnection(@conString);
     int orgId=0;
     try{
         orgId=int.Parse(Request.Cookies["user"].Value);
     }
     catch(Exception ex){
     
     }
     if ((FileUploadControl.PostedFile != null) && (FileUploadControl.PostedFile.ContentLength > 0))
     
     {
         try
         {
             string filename = System.IO.Path.GetFileName(FileUploadControl.PostedFile.FileName);
             filename.Replace(" ", "_");
             con.Open();
             int reader = (int)new SqlCommand("select count(*) from actionplanfile_Table where filename like '%" + filename + "%'", con).ExecuteScalar();
             con.Close();
             filename = reader + 1 + filename;
             string location = Server.MapPath("../Files") + "\\" + filename;
             FileUploadControl.PostedFile.SaveAs(location);
             con.Open();
             new SqlCommand("insert into actionplanfile_Table values(" + orgId + ",'" + selyear.Value + "'," + selaudittype.Value + ",N'" + filename + "','"+DateTime.Now.ToString("yyyy-MM-dd")+"',1)", con).ExecuteNonQuery();
             con.Close();
             msg.Text = "File uploaded successfully.";
         }
         catch (Exception ex)
         {
             msg.Text = "<span style='color:red'>File not uploaded. Trye again</span>";

             //StatusLabel.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
         }
     }
     else {
         msg.Text = "<span style='color:red'>File not selected</span>";
     }
     //*************************************
     selyear.Items.Clear();
     selaudittype.Items.Clear();
     selyear2.Items.Clear();
     selaudittype2.Items.Clear();
     Object ser=new Object();
     EventArgs ev=new EventArgs();
     Page_Load( ser,  ev);
 }
 protected void uploadfile2(object sender, EventArgs e)
 {

     string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
     SqlConnection con = new SqlConnection(@conString);
     int orgId = 0;
     try
     {
         orgId = int.Parse(Request.Cookies["user"].Value);
     }
     catch (Exception ex)
     {

     }
     if ((FileUploadControl2.PostedFile != null) && (FileUploadControl2.PostedFile.ContentLength > 0))
     {
         try
         {
             string filename = System.IO.Path.GetFileName(FileUploadControl2.PostedFile.FileName);
             filename.Replace(" ", "_");
             con.Open();
             int reader = (int)new SqlCommand("select count(*) from actionplanfile_Table where filename like '%" + filename + "%'", con).ExecuteScalar();
             con.Close();
             filename = reader + 1 + filename;
             string location = Server.MapPath("../Files") + "\\" + filename;
             FileUploadControl2.PostedFile.SaveAs(location);
             con.Open();
             new SqlCommand("insert into actionplanfile_Table values(" + orgId + ",'" + selyear2.Value + "'," + selaudittype2.Value + ",N'" + filename + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "',2)", con).ExecuteNonQuery();
             con.Close();
             msg.Text = "File uploaded successfully.";
         }
         catch (Exception ex)
         {
             msg2.Text = "<span style='color:red'>File not uploaded. Try agian</span>";

             //StatusLabel.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
         }
     }
     else
     {
         msg2.Text = "<span style='color:red'>File not selected</span>";
     }
     //*************************************
     selyear.Items.Clear();
     selaudittype.Items.Clear();
     selyear2.Items.Clear();
     selaudittype2.Items.Clear();
     Object ser = new Object();
     EventArgs ev = new EventArgs();
     Page_Load(ser, ev);
 }
 </script>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="images/logoOFAG.png">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
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
<script type="text/javascript">
    function showrecommendations() {
        var year = document.getElementById("ryear").value;
        var audittype = document.getElementById("raudittype").value;

        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                var resp = this.responseText;
               
                $("#hidrecom").html(resp);
            }
        };
        http.open("GET", "openrecommendationforauditee.aspx?year=" + year + "&audittype=" + audittype, true);
        http.send();
    }
    function openactionplan(recomId) {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $("#actioncontent" + recomId).html(this.responseText);
            }
        };
        http.open("GET", "openActionplan.aspx?recomId=" + recomId, true);
        http.send();
    }
    function saveActionPlan(recomId) {
        $("#actionplansavedmsg" + recomId).html("");
        var form = new FormData();
        form.append("action", document.getElementById("action" + recomId).value);
        form.append("recomId", recomId);
        form.append("actiondate", document.getElementById("actiondate" + recomId).value);
        if (document.getElementById("action" + recomId).value != "" && document.getElementById("actiondate" + recomId).value != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    $("#actionplansavedmsg" + recomId).html("successfully saved");
                    openactionplan(recomId);

                }
            };
            http.open("POST", "saveactionplan.aspx", true);
            http.send(form);
        }
        else {
            alert("All fields are required");
        }
    }
    function showactionplan() {
        var year = document.getElementById("rtyear").value;
        var audittype = document.getElementById("rtaudittype").value;

        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                var resp = this.responseText;

                $("#hidplan").html(resp);
            }
        };
        http.open("GET", "openactionplanforauditee.aspx?year=" + year + "&audittype=" + audittype, true);
        http.send();
    }
    function openactiontaken(planId) {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $("#recomcontent" + planId).html(this.responseText);
            }
        };
        http.open("GET", "recordactiontaken.aspx?planId=" + planId, true);
        http.send();
    }
    function saveactiontaken(planId) {
        var form = new FormData();
        form.append("actiontaken", document.getElementById("actiontaken" + planId).value);
        form.append("actiondate", document.getElementById("actiontdate" + planId).value);
        form.append("recvalue", document.getElementById("recvalue" + planId).value);
        form.append("planId", planId);
        if (document.getElementById("actiontaken" + planId).value != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {

                    var response = this.responseText;
                   
                    if (response.indexOf("SUCCESS") != -1) {

                        openactiontaken(planId);
                    }
                    else {

                    }

                }
            };
            http.open("POST", "saveactiontaken.aspx", true);
            http.send(form);
        }
        else {
            alert("Empty field");
        }
    }
    function savechangesactiontaken(actiontakenId, planId) {

        var form = new FormData();
        form.append("actiontaken", document.getElementById("edactiontaken" + actiontakenId).value);
        form.append("actiondate", document.getElementById("edactiontdate" + actiontakenId).value);

        form.append("actiontakenId", actiontakenId);
        if (document.getElementById("edactiontaken" + actiontakenId).value != "") {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {

                    var response = this.responseText;

                    if (response.indexOf("SUCCESS") != -1) {

                        openactiontaken(planId);
                    }
                    else {

                    }

                }
            };
            http.open("POST", "savechangesactiontaken.aspx", true);
            http.send(form);
        }
        else {
            alert("Empty field");
        }
    }
    function deleteactiontaken(actiontakenId, planId) {
        if (confirm("Are you sure to delete?")) {
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    openactiontaken(planId);
                }
            };
            http.open("GET", "deleteactiontaken.aspx?actiontakenId=" + actiontakenId, true);
            http.send();
        }
    }
</script>
</head>
<body>
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
   int orgId = 0;
   try
   {
       orgId = int.Parse(Request.Cookies["user"].Value);
   }
   catch (Exception ex) { 
   }
   String role = "", name = "",last="";
   try
   {
       con.Open();

       SqlDataReader reader = new SqlCommand("select orgName from org_Table where orgId=" + orgId, con).ExecuteReader();
       while (reader.Read())
       {
          
           name = reader["orgName"].ToString();
          
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
       <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../am/auditeehome.aspx"><img src="images/et.png" width="20" height="10"/>አማርኛ</a></div>
   <div class="row">
    <div class="col-sm-2" style="overflow:auto;padding-right:0px;">
  <div class="panel panel-default" style="background-color:#c2c9cb; height:1000px;border-right:1px solid black">
        <div class="navbar navbar-default">
            <ul class="nav sidebar-nav btn-primary ">
                       <li style="border-bottom: 2px solid #ffffff;"><a href="auditeeaccountsetting.aspx" style="background-color:#c2c9cb;"><b  style="color:black;">Account setting</b></a></b></li>
            
            </ul>
        </div>
        </div>
    </div>
    <div class="col-sm-10" style="padding-left:0px;height:1000px;overflow:auto">
    <!--  *******TOP Nagigation bar-->
    <div class="">
     <div class="navbar navbar-inverse"  data-offset-top="70" style="background-color:#c2c9cb;z-index:100; border-radius:0px; border-width:0px;height:40px;">
     <div class="navbar-header">
    <a href="auditeehome.aspx" class="navbar-brand" style="color:black"><b>Home</b></a>
     </div>
     
     <div class="navbar-header">
    <a href="auditeeaboutofag.aspx" class="navbar-brand" style="color:black"><b>About OFAG</b></a>
     </div>
     <div class="navbar-header">
     <p class="navbar-brand">logged as <%Response.Write(name);%>&nbsp <i>[<%Response.Write("Auditee"); %>]</i></p>
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
    <ul class="nav nav-tabs">
    <li ><a href="#" onclick="$('#plan').slideDown(0);$('#taken').slideUp(0);$('#uppltkn').slideDown(0);$('#rplan').slideUp(0);$('#rtplan').slideUp(0);" >Upload action plan</a></li>
    <li ><a href="#" onclick="$('#plan').slideUp(0);$('#taken').slideDown(0);$('#uppltkn').slideDown(0);$('#rplan').slideUp(0);$('#rtplan').slideUp(0);" >Upload action taken</a></li>
    <li ><a href="#" onclick="$('#plan').slideUp(0);$('#taken').slideUp(0);$('#uppltkn').slideUp(0);$('#rplan').slideDown(0);$('#rtplan').slideUp(0);" >Record action plan</a></li>
    <li ><a href="#" onclick="$('#plan').slideUp(0);$('#taken').slideUp(0);$('#uppltkn').slideUp(0);$('#rplan').slideUp(0);$('#rtplan').slideDown(0);" >Record action taken</a></li>
    </ul>
    <form runat="server" method="post" enctype="multipart/form-data">
    <asp:Label ID="lab" runat="server"></asp:Label>
       <table class="table table-responsive table-condensed table-hover table-bordered table-striped" id="plan">
       <tr><th colspan="2"  style="background-color:#c2c9cb">Upload action plan</th></tr>
       <tr><th>Select audit year (E.c.)</th>
       <td>
      <select class="form-control" id="selyear" style="border:1px solid black" runat="server">
      
     </select>
    </td>
       </tr>
       <tr><th>Select audit type</th>
       <td>
     <select class="form-control" id="selaudittype" style="border:1px solid black" runat="server">
   
      
     </select>
    </td>
       </tr>
       <tr><th>choose action plan file</th>
       <td><input type="file" id="FileUploadControl" runat="server" class="btn btn-info"/>
       </td>
       </tr>
       <tr><td><asp:Label ID="msg" style="color:blue" runat="server"></asp:Label></td><td><asp:Button runat="server" Text="Upload action plan" OnClick="uploadfile" class="btn btn-primary"/></td></tr>
       </table>

       <!--action taken-->
        <table class="table table-responsive table-condensed table-hover table-bordered table-striped" id="taken" style="display:none">
       <tr><th colspan="2" style="background-color:#c2c9cb">Upload action taken</th></tr>
       <tr><th>Select audit year (E.c.)</th>
       <td>
      <select class="form-control" id="selyear2" style="border:1px solid black" runat="server">
      
     </select>
    </td>
       </tr>
       <tr><th>Select audit type</th>
       <td>
     <select class="form-control" id="selaudittype2" style="border:1px solid black" runat="server">
   
      
     </select>
    </td>
       </tr>
       <tr><th>Choose action taken file</th>
       <td><input type="file" id="FileUploadControl2" runat="server" class="btn btn-info"/>
       </td>
       </tr>
       <tr><td><asp:Label ID="msg2" style="color:blue" runat="server"></asp:Label></td><td><asp:Button ID="Button1" runat="server" Text="Upload action taken" OnClick="uploadfile2" class="btn btn-primary"/></td></tr>
       </table>
    </form>
    <div class="row" id="uppltkn">
    <div class="col-sm-6" style="padding-right:0px;">
    <table class="table table-condensed table-bordered table-hover table-responsive">
    <tr><td colspan="2" style="background-color:#c2c9cb;color:black">Uploaded Action plan files (Click on the hyper link to download)</td></tr>
    <%try
      {
          con.Open();
          SqlDataReader reader2 = new SqlCommand("select * from actionplanfile_Table where orgId=" + orgId+" and ftype=1 order by fId desc", con).ExecuteReader();
          while (reader2.Read())
          {
         %>
         <tr><td><a href="../Files/<%Response.Write(reader2["filename"]);%>" target="_blank"><%Response.Write(reader2["filename"]);%></a></td><td>On: <%Response.Write(reader2["date"]);%></td></tr>
         <%}
          con.Close();
      }
      catch (Exception ex) {
          con.Close();
      }
           %>
    </table>
    </div>
     <div class="col-sm-6" style="padding-left:0px;">
    <table class="table table-condensed table-bordered table-hover table-responsive">
    <tr><td colspan="2" style="background-color:#c2c9cb;color:black">Uploaded Action taken files (Click on the hyper link to download)</td></tr>
    <%try
      {
          con.Open();
          SqlDataReader reader2 = new SqlCommand("select * from actionplanfile_Table where orgId=" + orgId+" and ftype=2 order by fId desc", con).ExecuteReader();
          while (reader2.Read())
          {
         %>
         <tr><td><a href="../Files/<%Response.Write(reader2["filename"]);%>" target="_blank"><%Response.Write(reader2["filename"]);%></a></td><td>On: <%Response.Write(reader2["date"]);%></td></tr>
         <%}
          con.Close();
      }
      catch (Exception ex) {
          con.Close();
      }
           %>
    </table>
    </div>
    </div>

    <div class="row" id="rplan" style="padding-left:20px;display:none">
    
    <table class="table table-responsive table-condensed table-hover table-striped table-bordered">
    <tr><th colspan="3" style="background-color:#c2c9cb">Search the audit to record action plan</th></tr>
    <tr><th>Select audit year</th><th>Select audit type</th><th></th></tr>
    <tr><td>
     <select class="form-control" id="ryear" style="width:45%;display:inline">
       
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
     <select class="form-control" id="raudittype">
       
           <%try
           {
               con.Open();
               SqlDataReader audittypereader = new SqlCommand("select * from auditType_Table", con).ExecuteReader();
               while (audittypereader.Read())
               { 
               %>
               <option><%Response.Write(audittypereader["auditType"]);%></option>
              <%
               }
               con.Close();
           }
           catch (Exception ex) { 
           
           }%>
        </select>
    
    </td>
    <td>
    <button class="btn btn-primary" onclick="showrecommendations()"><span class="glyphicon glyphicon-search"></span> Search</button>
    </td>
    </tr>
    </table>
    <div id="hidrecom">
    
    </div>
    </div>
     <div class="row" id="rtplan" style="padding-left:20px;display:none">
   
    <table class="table table-responsive table-condensed table-hover table-striped table-bordered">
     <tr><th colspan="3" style="background-color:#c2c9cb">Search the audit to record action taken</th></tr>
    <tr><th>Select audit year</th><th>Select audit type</th><th></th></tr>
    <tr><td>
     <select class="form-control" id="rtyear" style="width:45%;display:inline">
       
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
     <select class="form-control" id="rtaudittype">
       
           <%try
           {
               con.Open();
               SqlDataReader audittypereader = new SqlCommand("select * from auditType_Table", con).ExecuteReader();
               while (audittypereader.Read())
               { 
               %>
               <option><%Response.Write(audittypereader["auditType"]);%></option>
              <%
               }
               con.Close();
           }
           catch (Exception ex) { 
           
           }%>
        </select>
    
    </td>
    <td>
    <button class="btn btn-primary" onclick="showactionplan()"><span class="glyphicon glyphicon-search"></span> Search</button>
    </td>
    </tr>
    </table>
    <div id="hidplan">
    
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
