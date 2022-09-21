<%@ Page Language="C#" AutoEventWireup="true" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>record finding and recommendation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="bootstrap/css/bootstrap-min.css" />
    <link rel="icon" href="images/logoOFAG.png">
    <script src="bootstrap/js/jquery.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        function savefinding() {
            var form = new FormData();
            form.append("finding", document.getElementById("finding").value);
            form.append("findingType", document.getElementById("findingType").value);
            form.append("actValue", document.getElementById("actValue").value);
            form.append("extValue", document.getElementById("extValue").value);
            form.append("source", $("#source").val()+","+$("#sourcetxt").val());
            form.append("pref", document.getElementById("pref").value);
            form.append("audresp", document.getElementById("audresp").value);
            form.append("respdate", document.getElementById("respdate").value);
            form.append("respfname", document.getElementById("respfname").value);
            form.append("resplname", document.getElementById("resplname").value);

            if (document.getElementById("finding").value != "") {
                var http = new XMLHttpRequest();
                http.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        var response = this.responseText;

                        if (response.indexOf("SUCCESS") != -1) {

                            location.reload();
                        }
                        else {

                        }
                    }
                };
                http.open("POST", "savefinding.aspx", true);
                http.send(form);
            }
            else {
                alert("Write Finding Description");
            }
        }
        function editfinding(findingId) {
            var form = new FormData();
           
            form.append("finding", document.getElementById("edfinding" + findingId).value);
            form.append("findingType", document.getElementById("edfindingType" + findingId).value);
            form.append("actValue", document.getElementById("edactValue" + findingId).value);
            form.append("extValue", document.getElementById("edextValue" + findingId).value);
            form.append("source", $("#edsource" + findingId).val() + "," + $("#edsourcetxt" + findingId).val());
            form.append("pref", $("#edpref" + findingId).val());
            form.append("audresp", $("#edaudresp" + findingId).val());
            form.append("respdate", $("#edrespdate" + findingId).val());
            form.append("findingId", findingId);
            form.append("respfname", document.getElementById("respfname" + findingId).value);
            form.append("resplname", document.getElementById("resplname"+findingId).value);

            if (document.getElementById("edfinding"+findingId).value != "") {
                var http = new XMLHttpRequest();
                http.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        var response = this.responseText;
                        
                        if (response.indexOf("SUCCESS") != -1) {

                            location.reload();
                        }
                        else {

                        }
                    }
                };
                http.open("POST", "editfinding.aspx", true);
                http.send(form);
            }
            else {
                alert("Write Finding Description");
            }

        }
        function openrecommendation(findingId) {
            $("#recomcontent" + findingId).html("");
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    $("#recomcontent" + findingId).html(this.responseText);
                    $('#recomcontent'+findingId).slideToggle();
                }
            };
            http.open("GET", "recordrecommendation.aspx?findingId=" + findingId, true);
            http.send();
        }

        function saverecommendation(findingId) {
            var form = new FormData();
            form.append("recom", document.getElementById("recom" + findingId).value);
            form.append("potSaving", document.getElementById("potSaving" + findingId).value);
            form.append("status", document.getElementById("recomStatus" + findingId).value);
            form.append("ext", document.getElementById("ext" + findingId).value);
            form.append("findingId", findingId);
            if (document.getElementById("recom" + findingId).value != "") {
                var http = new XMLHttpRequest();
                http.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {

                        var response = this.responseText;

                        if (response.indexOf("SUCCESS") != -1) {

                            openrecommendation(findingId);
                        }
                        else {

                        }
                       
                    }
                };
                http.open("POST", "saveRecommendation.aspx", true);
                http.send(form);
            }
            else {
                alert("Empty recommendation");
            }
        }
        function editrecommendation(recomId, findingId) {
            var form = new FormData();
            form.append("recom", document.getElementById("edrecom" + recomId).value);
            form.append("potSaving", document.getElementById("edpotSaving" + recomId).value);
            form.append("status", document.getElementById("edrecomStatus" + recomId).value);
            form.append("recomId", recomId);
            form.append("ext", document.getElementById("ext"+recomId).value);
            if (document.getElementById("edrecom"+recomId).value != "") {
                var http = new XMLHttpRequest();
                http.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {

                        var response = this.responseText;
                       

                        if (response.indexOf("SUCCESS") != -1) {

                            openrecommendation(findingId);
                        }
                        else {

                        }

                    }
                };
                http.open("POST", "editrecommendation.aspx", true);
                http.send(form);
            }
            else {
                alert("Empty recommendation");
            }
        }
        function showallrecom() {
            $('body').addClass("disable-scroll");
           
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    $("#recomcontent").html(this.responseText);
                    $('#recomcontentparent').slideDown();
                }
            };
            http.open("GET", "openallAuditrecommendation.aspx", true);
            http.send();
        }
        function editrecommendation2(recomId) {
            var form = new FormData();
            form.append("recom", document.getElementById("edrecom1" + recomId).value);
            form.append("potSaving", document.getElementById("edpotSaving1" + recomId).value);
            form.append("status", document.getElementById("edrecomStatus1" + recomId).value);
            form.append("recomId", recomId);
            if (document.getElementById("edrecom1" + recomId).value != "") {
                var http = new XMLHttpRequest();
                http.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {

                        var response = this.responseText;

                        if (response.indexOf("SUCCESS") != -1) {

                            showallrecom();
                        }
                        else {

                        }

                    }
                };
                http.open("POST", "editrecommendation.aspx", true);
                http.send(form);
            }
            else {
                alert("Empty recommendation");
            }
        }
        function saveremark() {
            $('#rmrkmsg').html("");
            
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    var response = this.responseText;

                    if (response.indexOf("SUCCESS") != -1) {

                        $('#rmrkmsg').html("successfully saved");
                    }
                    else {

                    }
                }
            };
            http.open("GET", "saveremark.aspx?remark=" + document.getElementById("remark").value, true);
            http.send();
        }
        function saveauditeeopinion() {
            $('#opnmsg').html("");
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    var response = this.responseText;

                    if (response.indexOf("SUCCESS") != -1) {

                        $('#opnmsg').html("successfully saved");
                    }
                    else {

                    }
                }
            };
            http.open("GET", "saveauditeeopinion.aspx?opinion=" + document.getElementById("opinion").value, true);
            http.send();
        }
        function deletefinding(findingId) {
            if (confirm("are you sure to delete this finding?")) {
                var http = new XMLHttpRequest();
                http.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        location.reload();
                    }
                };
                http.open("GET", "deletefinding.aspx?findingId=" + findingId, true);
                http.send();
            }
        }

        function deleterecom(recomId, findingId) {
            if (confirm("are you sure to delete this Recommendation?")) {
                var http = new XMLHttpRequest();
                http.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        openrecommendation(findingId);
                    }
                };
                http.open("GET", "deleterecommendation.aspx?recomId=" + recomId, true);
                http.send();
            }
        }
        function recomstatuschanged() {
            var status = document.getElementById("recomStatus").value;
            if (status == "1" || status == "3") {
                $("#extentrow").slideUp(0);
            }
            if (status == "2") {
                $("#extentrow").slideDown(0);
            }
        }
        function editrecomstatuschanged(recomId) {
            var status = document.getElementById("edrecomStatus"+recomId).value;
            if (status == "1" || status == "3") {
                $("#extrecom"+recomId).slideUp(0);
            }
            if (status == "2") {
                $("#extrecom"+recomId).slideDown(0);
            }
        }
    </script>
    <style>
        .affix
        {
            top: 0;
            width: 100%;
        }
        .affix + .container-fluid
        {
            padding-top: 20px;
        }
        
        .sideb:hover
        {
            color: Black !important;
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
    <div class="" style="height: 70px;">
        <img src="images/logoimg.png" style="height: 70px;" class="btn-block img-responsive" />
    </div>
      <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../am/auditor_recordfindingsAndRecommendations.aspx"><img src="images/et.png" width="20" height="10"/>አማርኛ</a></div>
    <div class="row">
      <div class="col-sm-2 panel panel-default" style="background-color:#c2c9cb; height:1000px;border-right:1px solid black;padding-right:0px;">
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
    <div class="col-sm-10" style="padding-left:0px; height:1000px;overflow:auto;" id="mainpan">
         <!--  *******TOP Nagigation bar-->
            <div class="">
                <div class="navbar navbar-inverse" data-offset-top="70" style="background-color: #c2c9cb;
                    z-index: 100; border-radius: 0px; border-width: 0px; height: 40px;padding-bottom:2px !important;">
                    <div class="navbar-header">
                        <a href="auditor_home.aspx" class="navbar-brand" style="color: black"><b>Home</b></a>
                    </div>
                    <div class="navbar-header">
                        <a href="auditor_auditees.aspx" class="navbar-brand" style="color: black"><b>Auditees</b></a>
                    </div>
                    <div class="navbar-header">
                        <a href="auditor_aboutOfag.aspx" class="navbar-brand" style="color: black"><b>About OFAG</b></a>
                    </div>
                    <div class="navbar-header">
                        <p class="navbar-brand">
                            Logged as <%Response.Write(name);%> &nbsp <% Response.Write(last);%> <i>[<%Response.Write(role); %>]</i></p>
                    </div>
                    <div class="navbar-header">
                        <p class="navbar-brand">
                            |</p>
                    </div>
                    <div class="navbar-header" align="right">
                        <a href="logout.aspx" class="navbar-brand" style="color: black"><b>Logout</b></a>
                    </div>
                </div>
                 <ul class="nav nav-pills btn-sm">
                 <li> <a href="auditor_recordnewAudit.aspx" class="btn btn-link btn-sm">
                <span class="glyphicon glyphicon-backward"></span>Back</a></li>
            <li style=""><a href="audiorAudits.aspx"  class="btn btn-link btn-sm"><b>Audits</b></a></li>
            <li style=""><a href="report.aspx" class="btn btn-link btn-sm"><b >Report</b></a></li>
            <li style=""><a href="auditor_accountsetting.aspx"  class="btn btn-link btn-sm"><b>Account setting</b></a></b></li>
            </ul>
            </div>
            <div class="row">
                <div class="col-sm-12" style="padding-left:20px;">
                    <table class="table table-condensed table-responsive table-bordered table-striped" style="border: 2px solid #c2c9cb; background-color:white; padding: 5px;">
                        <tr style="background-color:#c2c9cb">
                            <th colspan="4" style="color: black">
                                <h4><b><span class="glyphicon glyphicon-record"></span>Record new finding</b></h4>
                            </th>
                        </tr>
                        <tr>
                            <td colspan="2" rowspan="2">
                                <textarea class="form-control" id="finding" placeholder="Write Finding Decsription here..."
                                    rows="5" style="border: 1px solid #c2c9cb"></textarea>
                            </td> <th style="width:20%">
                                Finding type
                            </th>
                             <td>
                                <select class="form-control" id="findingType" style="border: 1px solid #c2c9cb">
                                    <%try
                                      {
                                          con.Open();
                                          SqlDataReader findingtypereader = new SqlCommand("select * from findingType_Table", con).ExecuteReader();
                                          while (findingtypereader.Read())
                                          { 
                                    %>
                                    <option value="<%Response.Write(findingtypereader["typeId"]);%>">
                                        <%Response.Write(findingtypereader["findingType"]);%></option>
                                    <%
             }
             con.Close();
         }
                                      catch (Exception ex)
                                      {

                                      }
                                    %>
                                </select>
                            </td>
                        </tr>
                         <tr>
                        <th>
                                Actual financial value<br>
                                of finding(ETB.)
                            </th>
                            <td>
                                <input type="number" id="actValue" class="form-control" placeholder="10000000.00"
                                    style="border: 1px solid #c2c9cb">
                            </td>
                        </tr>
                        <tr>
                         <th>Working paper reference</th>
                        <td>
                        <input  type="text" class="form-control" id="pref" style="border: 1px solid #c2c9cb" placeholder="paper work reference no for the finding">
                        </td>
                           
                        
                       
                            <th style="width:100px;">
                                Extrapolated financial value<br>
                                of finding(ETB.)
                            </th>
                            <td>
                                <input type="number" id="extValue" class="form-control" placeholder="10000000.00"
                                    style="border: 1px solid #c2c9cb">
                            </td>
                        </tr>
                       
                        <tr>
                            <th rowspan="3">
                                Source of the finding/methodology
                            </th>
                            <td rowspan="3">
                            <p>To select two or more items press on <kbd>ctrl</kbd> from the keyboard and click on items</p>
                                <select id="source" class="form-control" multiple="multiple" style="border: 1px solid #c2c9cb">
                                    <option>Through interview</option>
                                    <option>Substantive testing</option>
                                    <option>Analytical review</option>
                                    <option>Observation</option>
                                    <option>System testing</option>
                                    <option>Document review</option>
                                </select>
                                <br>
                                <p style="">Add new source of finding / methodology here. Use comma (,) to separate more than one source of findings</p>
                                <input type="text" id="sourcetxt" class="form-control" placeholder="new source of finding/methodology" style="border: 1px solid #c2c9cb">
                            </td>
                        
                        <th>Auditee response to the finding</th>
                        <td><textarea id="audresp" placeholder="write auditee response here..." class="form-control" rows="4" style="border: 1px solid #c2c9cb;"></textarea></td>
                        </tr>
                        <tr><th>Response by</th><td><input type="text" id="respfname" style="border: 1px solid #c2c9cb" class="form-control" placeholder="first name">&nbsp<input type="text" id="resplname" style="border: 1px solid #c2c9cb;" class="form-control" placeholder="last name"></td></tr>
                        <tr><th>Auditee response date to the finding (E.C)</th>
                        <td><input type="date" class="form-control" id="respdate"></td>
                        </tr>
                        <tr>
                            <th colspan="4">
                                <button class="btn btn-primary" onclick="savefinding()">
                                    Save finding</button>
                            </th>
                        </tr>
                    </table>
                </div>
                <div class="col-sm-12" style="border-left: 1px solid #c2c9cb">
                    <table class="table table-condensed table-responsive table-bordered table-striped">
                        <tr style="background-color:#c2c9cb">
                            <th colspan="5" style="color: black"><h4><b>
                                <span class="glyphicon glyphicon-saved"></span>Saved findings</b></h4>
                            </th>
                        </tr>
                        <%try
                          {
                              con.Open();
                              int res = (int)new SqlCommand("select count(*) from finding_Table where auditId=" + int.Parse(Request.Cookies["auditId"].Value), con).ExecuteScalar();
                              con.Close();
                              if (res > 0)
                              { 
                        %>
                        <tr>
                            <th style="color:black">
                                <%Response.Write(res);%>
                            </th><th></th>
                            <th>
                                Findings
                            </th>
                            <th>
                                Actual financial<br>
                                value
                            </th>
                            <th>
                                Extrapolated financial<br>
                                value
                            </th>
                        </tr>
                        <%
            }
            con.Open();
            SqlDataReader findingReader = new SqlCommand("select * from finding_Table where auditId=" + int.Parse(Request.Cookies["auditId"].Value) + " order by findingId desc", con).ExecuteReader();
            while (findingReader.Read())
            { 
                        %>
                        <tr>
                            <td style="width:7px;">
                                <button class="btn btn-link" title="Edit" onclick="$('#hidfinding<%Response.Write(findingReader["findingId"]);%>').slideToggle();">
                                    <span class="glyphicon glyphicon-edit"></span>
                                </button></td>
                                <td style="width:7px;">
                                 <button class="btn btn-link" title="Delete" onclick="deletefinding('<%Response.Write(findingReader["findingId"]);%>')">
                                    <span class="glyphicon glyphicon-trash" style="color:red"></span>
                                </button>
                            </td>
                            <td>
                                <%Response.Write(findingReader["findingName"]);%>
                            </td>
                            <td>
                                <%Response.Write(findingReader["actualValue"]);%>ETB
                            </td>
                            <td>
                                <%Response.Write(findingReader["extraValue"]);%>ETB
                            </td>
                        </tr>
                        <tr style="display: none;background-color:white"id="hidfinding<%Response.Write(findingReader["findingId"]);%>">
                            <td colspan="5">
                                <center>
                                    <table class="table table-responsive table-condensed table-bordered table-striped" style="width: 90%; border: 2px solid #c2c9cb">
                                        <tr>
                                            <td colspan="2" rowspan="2">
                                                <textarea class="form-control" id="edfinding<%Response.Write(findingReader["findingId"]);%>"
                                                    placeholder="Write Finding Decsription here..." rows="5" style="border: 1px solid #c2c9cb"><%Response.Write(findingReader["findingName"]);%></textarea>
                                            </td>
                                        
                                            <th style="width:30%">
                                                Finding type
                                            </th>
                                            <td>
                                                <select class="form-control" id="edfindingType<%Response.Write(findingReader["findingId"]);%>"
                                                    style="border: 1px solid #c2c9cb">
                                                    <%try
                                                      {
                                                          con2.Open();
                                                          SqlDataReader findingtypereader = new SqlCommand("select * from findingType_Table", con2).ExecuteReader();
                                                          while (findingtypereader.Read())
                                                          {
                                                              if (findingtypereader["typeId"].ToString() == findingReader["findingType"].ToString())
                                                              {
                                                    %>
                                                    <option selected="selected" value="<%Response.Write(findingtypereader["typeId"]);%>">
                                                        <%Response.Write(findingtypereader["findingType"]);%></option>
                                                    <%
                 }
                 else
                 {
                                                    %>
                                                    <option value="<%Response.Write(findingtypereader["typeId"]);%>">
                                                        <%Response.Write(findingtypereader["findingType"]);%></option>
                                                    <%
                 }
             }
             con2.Close();
                 }
                                                      catch (Exception ex)
                                                      {

                                                      }
                                                    %>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>
                                                Actual financial value<br>
                                                of finding(ETB.)
                                            </th>
                                            <td>
                                                <input type="number" id="edactValue<%Response.Write(findingReader["findingId"]);%>"
                                                    class="form-control" placeholder="10000000.00" style="border: 1px solid #c2c9cb"
                                                    value="<%Response.Write(findingReader["actualValue"]);%>">ETB.
                                            </td>
                                        </tr>
                                        <tr>
                                         <th>Paper work reference</th>
                                         <td>
                                        <input  type="text" class="form-control" id="edpref<%Response.Write(findingReader["findingId"]);%>" style="border: 1px solid #c2c9cb" value="<%Response.Write(findingReader["pRef"]);%>">
                                          </td>
                                            <th>
                                                Extrapolated financial value<br>
                                                of finding(ETB.)
                                            </th>
                                            <td>
                                                <input type="number" id="edextValue<%Response.Write(findingReader["findingId"]);%>"
                                                    class="form-control" placeholder="10000000.00" style="border: 1px solid #c2c9cb"
                                                    value="<%Response.Write(findingReader["extraValue"]);%>">ETB.
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <th rowspan="3">
                                                Source of the finding/methodology
                                            </th>
                                            <td rowspan="3"><p><%Response.Write(findingReader["source"]);%></p>
                                                <select id="edsource<%Response.Write(findingReader["findingId"]);%>" class="form-control"
                                                    multiple="multiple" style="border: 1px solid #c2c9cb">
                                                    <option>Through interview</option>
                                                    <option>Substantive testing</option>
                                                    <option>Analytical review</option>
                                                    <option>Observation</option>
                                                    <option>System testing</option>
                                                    <option>Document review</option>
                                                </select>
                                                <br>
                                                <p style="">Add new source of finding / methodology here. Use comma (,) to separate more than one source of findings</p>
                                                 <input type="text" id="edsourcetxt<%Response.Write(findingReader["findingId"]);%>" class="form-control" placeholder="new source of finding/methodology" style="border: 1px solid #c2c9cb">
                          
                                            </td>
                                       
                        <th>Auditee response to the finding</th>
                        <td><textarea id="edaudresp<%Response.Write(findingReader["findingId"]);%>" class="form-control" rows="4" style="border: 1px solid #c2c9cb"><%Response.Write(findingReader["auditeeResp"]);%></textarea></td>
                        </tr>
                            <tr><th>Response by</th><td><input type="text" id="respfname<%Response.Write(findingReader["findingId"]);%>" style="border: 1px solid #c2c9cb" class="form-control" placeholder="first name"  value="<%Response.Write(findingReader["respfname"]);%>">&nbsp<input type="text" id="resplname<%Response.Write(findingReader["findingId"]);%>" style="border: 1px solid #552222;" class="form-control" placeholder="last name" value="<%Response.Write(findingReader["resplname"]);%>"></td></tr>
              
                        <tr><th>Auditee response date to the finding (E.C.)</th>
                        <td><input type="date" class="form-control" id="edrespdate<%Response.Write(findingReader["findingId"]);%>" value="<%Response.Write(findingReader["respDate"]);%>"></td>
                        </tr>
                              <tr>
                                 <th>
                                                <button class="btn btn-primary btn-block" style="color:white" onclick="editfinding(<%Response.Write(findingReader["findingId"]);%>)">
                                                    Save changes</button>
                                            </th>
                                           
                                            <td></td><td></td><th>
                                                <button class="btn btn-primary btn-block" style="color:white" onclick="$('#hidfinding<%Response.Write(findingReader["findingId"]);%>').slideToggle();">
                                                    Cancel</button>
                                            </th>
                                        </tr>
                                    </table>
                                </center>
                            </td>
                        </tr>
                        <%
            }
            con.Close();
        }
                          catch (Exception ex)
                          {

                          }
                        %>
                    </table>
                </div>
            </div>

            <div class="row">
            <div class="col-sm-12">
              <table class="table table-condensed table-responsive table-bordered table-striped">
                <tr style="background-color:#c2c9cb">
                    <th colspan="2" style="color: black"><h4><b>
                        <span class="glyphicon glyphicon-record"></span>Record recommendation for each finding</b></h4>
                    </th>
                </tr>
                </table>
                </div>
               
                </div>
               
                <div class="row" style="">
                <div class="col-sm-12">
                <table class="table table-condenced table-hover table-bordered table-striped">
                <tr><td colspan="3"><span class="glyphicon glyphicon-arrow-down"></span> <b>Click on <u>Add recommendation</u> to record recommendation</b></td></tr>
                <%
                    try
                    {
                        con.Open();
                        SqlDataReader findingreader = new SqlCommand("select findingName, findingId from finding_Table where auditId=" + int.Parse(Request.Cookies["auditId"].Value) + " order by findingId asc", con).ExecuteReader();
                        int findingcounter = 1;
                        while (findingreader.Read()) {   
                           
                        %>
                        <tr><td><button class="btn btn-link" onclick="openrecommendation(<%Response.Write(findingreader["findingId"]);%>)"><span class="glyphicon glyphicon-record"></span>Add Recommendation</button></td><td><i style="color:green">Finding <%Response.Write(findingcounter);%></i></td><td><p><%Response.Write(findingreader["findingName"]);%></p></td></tr>
                         <tr><td colspan="3">
                          <div class="panel-panel-primary" id="recomcontent<%Response.Write(findingreader["findingId"]);%>" style="display:none;background-color:white">
                          </div>
                          </td></tr>
                        <%
                            
                            findingcounter++;
                            }
                        con.Close();
                    }
                    catch (Exception ex) {
                        Response.Write(ex.Message);
                    }    
                 %>
            </table>
           
            </div>
            
            </div>
            <% string remark = "";
               string auditeeopinion = "";
               try
               {
                   con.Open();
                   SqlDataReader remarkreader = new SqlCommand("select auditeeopinion,remark from audit_Table where auditId=" + int.Parse(Request.Cookies["auditId"].Value), con).ExecuteReader();
                   while (remarkreader.Read()) {
                       remark = remarkreader["remark"].ToString();
                       auditeeopinion = remarkreader["auditeeopinion"].ToString();
                   }
                   con.Close();
               }
               catch (Exception ex) { 
               
               } %>
           

             <table class="table table-responsive table-condensed table-hover table-bordered table-striped" border="1">
            <tr style="background-color:#c2c9cb;color:black"><th><h4><b>Auditee opinion</b></h4></th></tr>
            <tr><td><textarea class="form-control" id="opinion" placeholder="Write Auditee opnion here..." rows="4" style="border:1px solid #c2c9cb"><%Response.Write(auditeeopinion);%></textarea></td></tr>
            <tr><td><button class="btn btn-primary" style="color:white" onclick="saveauditeeopinion()">Save auditee opinion</button><i style="color:blue" id="opnmsg"></i></td></tr>
            </table>
            
             <table class="table table-responsive table-condensed table-hover table-bordered table-striped" border="1">
            <tr style="background-color:#c2c9cb;color:black"><th><h4><b>Auditor remark</b></h4></th></tr>
            <tr><td><textarea class="form-control" id="remark" placeholder="Write Auditor remark here..." rows="4" style="border:1px solid #c2c9cb"><%Response.Write(remark);%></textarea></td></tr>
            <tr><td><button class="btn btn-primary" style="color:white" onclick="saveremark()">Save remark</button><i style="color:blue" id="rmrkmsg"></i></td></tr>
            </table>

        <table class="table table-responsive table-condensed table-hover table-bordered table-striped">
     
     <tr><td colspan="2"> <a class="btn btn-link" style="color:white;background-color:#3479c6" href="auditor_recordActionPlan.aspx">Click here to record action plan</a></td><td></td></tr>
     </table>
        </div>
    </div>
    <!-- show all recom panel-->
    <div class="panel panel-default"style="position:fixed;top:10px;left:40%;width:700px;height:550px;display:none;z-index:100;border:2px solid #002345;text-align:right;background-color:#aa9999" id="recomcontentparent">
          <table class="table" style="height:6%;">
          <tr><td style="background-color:#aa9999"></td><td style="height:100%;width:20px;background-color:red"><button class="btn btn-link" style="color:white;width:30px;height:100%;display:inline;padding:0px" onclick="$('#recomcontentparent').slideUp(); $('body').removeClass('disable-scroll');"><b>X</b></button>
          </td></tr></table>
          <div class="panel-body" id="recomcontent" style="height:89%;overflow:auto;text-align:justify;background-color:white">
            
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
