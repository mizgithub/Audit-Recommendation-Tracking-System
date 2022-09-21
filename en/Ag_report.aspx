<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="bootstrap/css/bootstrap-min.css"/>
<link rel="icon" href="images/logoOFAG.png">
<script src="bootstrap/js/jquery.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="tabletoexeljquery/jquery.table2excel.js"></script>
<script src="canvasjs/canvasjs.min.js"></script>
<script type="text/javascript">
   var charttype="";
   var pdftype=0;
   function openfinding(fid){
     var http=new XMLHttpRequest();
     http.onreadystatechange=function(){
       if(this.readyState==4 && this.status==200){
          
          $("#fcont").html(this.responseText);
           $("#findingcontainer").slideDown();
       }
     };
     http.open("GET","getfindings.aspx?fid="+fid,true);
     http.send();
   }
   function showactionplan(){
    var form = new FormData();
        form.append("selmin", document.getElementById("selmin").value);
        form.append("selorg", document.getElementById("selorg").value);
        form.append("selaudittype",document.getElementById("selaudittype").value);
        var yeartype = "";
        if (document.getElementById("on").checked) {
            yeartype = document.getElementById("on").value;
        }
        else {
            yeartype = document.getElementById("range").value;
        }
        form.append("yeartype", yeartype);
        form.append("onyear",document.getElementById("onyear").value);
        form.append("fyear",document.getElementById("fyear").value);
        form.append("tyear",document.getElementById("tyear").value);
        form.append("grpby", document.getElementById("grpby").value);
        
         var detail = "";
        if (document.getElementById("detail").checked) {
            detail = "detail";
        }
        form.append("detail",detail);
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    $("#content").html(this.responseText);
                   
                   $('#chartdiv').slideUp(0);$('#chartContainer').slideUp(0);
                   

                }
            };
            http.open("POST", "showdeadlinemissedactionplan.aspx", true);
            http.send(form);
        
   }
   function showrecommendation(status){
     var form = new FormData();
        form.append("selmin", document.getElementById("selmin").value);
        form.append("selorg", document.getElementById("selorg").value);
        form.append("selaudittype",document.getElementById("selaudittype").value);
        var yeartype = "";
        if (document.getElementById("on").checked) {
            yeartype = document.getElementById("on").value;
        }
        else {
            yeartype = document.getElementById("range").value;
        }
        form.append("yeartype", yeartype);
        form.append("onyear",document.getElementById("onyear").value);
        form.append("fyear",document.getElementById("fyear").value);
        form.append("tyear",document.getElementById("tyear").value);
        form.append("grpby", document.getElementById("grpby").value);
      
         var detail = "";
        if (document.getElementById("detail").checked) {
            detail = "detail";
        }
        form.append("detail",detail);
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    $("#content").html(this.responseText);
                   
                   $('#chartdiv').slideUp(0);$('#chartContainer').slideUp(0);
                   

                }
            };
            http.open("POST", "notimplementedrecom.aspx?status="+status, true);
            http.send(form);
        
   }
   function showsettingListFormat(){
    var form = new FormData();
        form.append("selmin", document.getElementById("selmin").value);
        form.append("selorg", document.getElementById("selorg").value);
        form.append("selaudittype",document.getElementById("selaudittype").value);
        var yeartype = "";
        if (document.getElementById("on").checked) {
            yeartype = document.getElementById("on").value;
        }
        else {
            yeartype = document.getElementById("range").value;
        }
        form.append("yeartype", yeartype);
        form.append("onyear",document.getElementById("onyear").value);
        form.append("fyear",document.getElementById("fyear").value);
        form.append("tyear",document.getElementById("tyear").value);
        form.append("grpby", document.getElementById("grpby").value);
     
        var fliterby = "";
        if (document.getElementById("recomm").checked && document.getElementById("finding").checked) {
            fliterby = "both";
        }
        else if (document.getElementById("recomm").checked) {
            fliterby = "recomm";
        }
        else if (document.getElementById("finding").checked) {
            fliterby = "finding";
        }
        else {
        
        }
        var detail = "";
        if (document.getElementById("detail").checked) {
            detail = "detail";
        }
       var c1="f",c2="f",c3="f",c4="f",c5="f",c6="f",c7="f",c8="f",c9="f",c10="f";
       var column=1;
          
        if (document.getElementById("Checkbox1").checked) {
            c1="t";
            column++;
        }
        if (document.getElementById("Checkbox2").checked) {
            c2="t";
            column++;
        }
        if (document.getElementById("Checkbox3").checked) {
            c3="t";
            column++;
        }
        if (document.getElementById("Checkbox4").checked) {
            c4="t";
            column++;
        }
        if (document.getElementById("Checkbox5").checked) {
            c5="t";
            column++;
        }
        if (document.getElementById("Checkbox6").checked) {
            c6="t";
            column++;
        }
        if (document.getElementById("Checkbox7").checked) {
            c7="t";
            column++;
        }
        if (document.getElementById("Checkbox8").checked) {
            c8="t";
        }
        if (document.getElementById("Checkbox9").checked) {
            c9="t";
            column++;
        }
        if (document.getElementById("Checkbox10").checked) {
            c10="t";
            column++;
        }

        form.append("filterby", fliterby);
        form.append("detail", detail);
        form.append("c1",c1);
        form.append("c2",c2);
        form.append("c3",c3);
        form.append("c4",c4);
        form.append("c5",c5);
        form.append("c6",c6);
        form.append("c7",c7);
        form.append("c8",c8);
        form.append("c9",c9);
        form.append("c10",c10);
        form.append("colspan",column);
        
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    $("#content").html(this.responseText);
                   
                   $('#chartdiv').slideUp(0);$('#chartContainer').slideUp(0);
                   

                }
            };
            http.open("POST", "showreportListFormat.aspx", true);
            http.send(form);
        

   }
    function showsetting() {
        var form = new FormData();
        form.append("selmin", document.getElementById("selmin").value);
        form.append("selorg", document.getElementById("selorg").value);
        form.append("selaudittype",document.getElementById("selaudittype").value);
        var yeartype = "";
        if (document.getElementById("on").checked) {
            yeartype = document.getElementById("on").value;
        }
        else {
            yeartype = document.getElementById("range").value;
        }
        form.append("yeartype", yeartype);
        form.append("onyear",document.getElementById("onyear").value);
        form.append("fyear",document.getElementById("fyear").value);
        form.append("tyear",document.getElementById("tyear").value);
        form.append("grpby", document.getElementById("grpby").value);
       
        var fliterby = "";
        if (document.getElementById("recomm").checked && document.getElementById("finding").checked) {
            fliterby = "both";
        }
        else if (document.getElementById("recomm").checked) {
            fliterby = "recomm";
        }
        else if (document.getElementById("finding").checked) {
            fliterby = "finding";
        }
        else {
           
        }
        var detail = "";
        if (document.getElementById("detail").checked) {
            detail = "detail";
        }
        var c1="f",c2="f",c3="f",c4="f",c5="f",c6="f",c7="f",c8="f",c9="f",c10="f";
          
        if (document.getElementById("Checkbox1").checked) {
            c1="t";
        }
        if (document.getElementById("Checkbox2").checked) {
            c2="t";
        }
        if (document.getElementById("Checkbox3").checked) {
            c3="t";
        }
        if (document.getElementById("Checkbox4").checked) {
            c4="t";
        }
        if (document.getElementById("Checkbox5").checked) {
            c5="t";
        }
        if (document.getElementById("Checkbox6").checked) {
            c6="t";
        }
        if (document.getElementById("Checkbox7").checked) {
            c7="t";
        }
        if (document.getElementById("Checkbox8").checked) {
            c8="t";
        }
        if (document.getElementById("Checkbox9").checked) {
            c9="t";
        }
        if (document.getElementById("Checkbox10").checked) {
            c10="t";
        }

        form.append("filterby", fliterby);
        form.append("detail", detail);
        form.append("c1",c1);
        form.append("c2",c2);
        form.append("c3",c3);
        form.append("c4",c4);
        form.append("c5",c5);
        form.append("c6",c6);
        form.append("c7",c7);
        form.append("c8",c8);
        form.append("c9",c9);
        form.append("c10",c10);
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    $("#content").html(this.responseText);
                     drawgraph("bar");
                   $('#chartdiv').slideUp(0);$('#chartContainer').slideUp(0);
                   

                }
            };
            http.open("POST", "showreport.aspx", true);
            http.send(form);
        

    }
    function displayorg() {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                $("#disporg").html(this.responseText);
            }
        };
        http.open("GET", "displayorganizations.aspx?minId=" + document.getElementById("selmin").value, true);
        http.send();
    }
    function showinaudit(auditId){
       window.open("Ag_showAudit.aspx?auditId="+auditId);
    }
    
    function exporttoexcel(e) {
        $("#tbl").table2excel({

            // exclude CSS class

            exclude: ".noExl",

            name: "Worksheet Name",

            filename: "exportedfile" //do not include extension

        });

    }
   function drawgraph(type) {

        var column = document.getElementById("hiddencolumn").value;
        var row = document.getElementById("hiddenrow").value;
        var data = new Array();

        for (var i = 0; i < row; i++) {
            var arr = new Array();
            var i2=i+1;
            if(type==0){
               type=charttype;
               }
               else{
                 charttype=type;
               }
              
                if(row>1){
                arr["showInLegend"]="true";
                arr["legendText"]=document.getElementById("hd1"+i2).innerHTML;
              
                }
            arr["type"] = type;
            
            var dataPoints = new Array();
            var temp=0;
            for (var j = 0; j <column-1; j++) {//number of columns and with thier column name and value
                var arr2 = new Array();
                 
                 var j2=j+2;
                 
               // alert(document.getElementById("h"+j2+i2).innerHTML+" "+document.getElementById("h"+j2).innerHTML);
               
                arr2["label"] = document.getElementById("h" + j2).innerHTML;
                arr2["y"] =parseFloat(document.getElementById("hd"+j2+i2).innerHTML.replace(/,/g,""));
                dataPoints[temp] = arr2;
                temp++;
                
            }
            arr["dataPoints"] = dataPoints;

            data[i] = arr;
        }
        
        var chart = new CanvasJS.Chart("chartContainer", {
            animationEnabled: true, 
         theme:"theme2",
        title: { text: '' }, 
        axisX:{
           interval: 1,
           labelFontSize:10,
          
         
         },
        exportEnabled: true,
       
          data
        });
        chart.render();

         
    }
 function enterTitle(){
 $("#pdftcontainer").slideDown(0);
 }  

 function enterListreportTitle(){
 pdftype=1;
  $("#pdftcontainer").slideDown(0);
 }
 function entertitlerecomreport(){
  pdftype=2;
  $("#pdftcontainer").slideDown(0);
 }
 function entertitlemissedactionplan(){
  pdftype=3;
  $("#pdftcontainer").slideDown(0);
 }
 function printpdfactionplanprovided(){
  $("#pdftcontainer").slideDown(0);
 }
function printpdf() {
var mywindow=window.open('','PRINT');
mywindow.document.write("<html><head></head><body>");
mywindow.document.write("<h4>"+$("#pdftitle").val()+"</h4>");
mywindow.document.write(document.getElementById("content").innerHTML);
mywindow.document.write("</body></html>");
mywindow.document.close();
mywindow.focus();
mywindow.print();
mywindow.close();
}
function showactionplanprovided(){
 var form = new FormData();
        form.append("selmin", document.getElementById("selmin").value);
        form.append("selorg", document.getElementById("selorg").value);
        form.append("selaudittype",document.getElementById("selaudittype").value);
        var yeartype = "";
        if (document.getElementById("on").checked) {
            yeartype = document.getElementById("on").value;
        }
        else {
            yeartype = document.getElementById("range").value;
        }
        form.append("yeartype", yeartype);
        form.append("onyear",document.getElementById("onyear").value);
        form.append("fyear",document.getElementById("fyear").value);
        form.append("tyear",document.getElementById("tyear").value);

       
       
            var http = new XMLHttpRequest();
            http.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    $("#content").html(this.responseText);
                     drawgraph("bar");
                   $('#chartdiv').slideUp(0);$('#chartContainer').slideUp(0);
                   

                }
            };
            http.open("POST", "showactionplanprovided.aspx", true);
            http.send(form);
        

}

</script>
<style type="text/css">
    select
    {
        border:1px solid black !important;
        }
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
<body style="color:Black !important">
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
   %>
     <div class="" style="height:70px;">
   
     <img src="images/logoimg.png" style="height:70px;" class="btn-block img-responsive"/>
    
     </div>
       <div style="background-color:white;text-align:right;padding-right:20px;"><a href="../am/Ag_report.aspx"><img src="images/et.png" width="20" height="10"/>አማርኛ</a></div>
       <div style="background-color:white;text-align:left;"><a class="btn btn-link" style="background-color:#c2c9cb;color:black"onclick="$('#panelcontainer').slideToggle();" title="Hide/show panel"><span class="glyphicon glyphicon-menu-down"></span></a>&nbsp;<a href="Ag_home.aspx" class="btn btn-link" style="color:black;background-color:#c2c9cb" title="home"><span class="glyphicon glyphicon-home"></span></a></div>
   <div class="row">
    <div class="col-sm-3" style="overflow:auto;padding-right:0px;" id="panelcontainer">
   <div class="panel panel-default" style="background-color:white; height:900px;">
         <table class="table table-condensed table-responsive table-bordered table-striped" border="1" style="border:2px solid #c2c9cb;width:75%">
        
        <tr style="background-color:#c2c9cb;color:black"><th colspan="2">Adjust report setting</th></tr>
        <tr style="border:3px solid white"><th rowspan="2" style="width:20%">Auditee</th><td>
         <select class="form-control" id="selmin" onchange="displayorg()">
         <option value="0">All directorate</option>
         <%try
           {
               con.Open();
               SqlDataReader minreader = new SqlCommand("select * from ministry_Table", con).ExecuteReader();
               while (minreader.Read()) { 
               %>
               <option value="<%Response.Write(minreader["minId"]);%>"><%Response.Write(minreader["minName"]);%></option>
                <%
               }
               con.Close();
           }
           catch (Exception ex) { 
           
           }%>
         </select>
        </td></tr>
        <tr style="border:3px solid white"><td id="disporg">
        <select class="form-control" id="selorg">
        <option value="0">All organizations</option>
       
            <%try
           {
               con.Open();
               SqlDataReader orgreader = new SqlCommand("select * from org_Table", con).ExecuteReader();
               while (orgreader.Read())
               { 
               %>
               <option value="<%Response.Write(orgreader["orgId"]);%>"><%Response.Write(orgreader["orgName"]);%></option>
                <%
               }
               con.Close();
           }
           catch (Exception ex) { 
           
           }%>
        </select>
        </td></tr>
        <tr style="border:3px solid white"><th>Audit type</th><td>
        <select class="form-control" id="selaudittype">
        <option value="0">All audit types</option>
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
        </td></tr>
        <tr style="border:3px solid white"><th rowspan="2">Audit year</th>
        <td><input type="radio" name="yeartype" id="on" style="width:20px;height:20px;" checked="checked" onclick="$('#onselection').slideDown(0);$('#rangeselection').slideUp(0);" value="on">On&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" style="width:20px;height:20px;" name="yeartype" id="range" onclick="$('#onselection').slideUp(0);$('#rangeselection').slideDown(0);" value="range">Range</td>
        </tr>
        <tr style="border:3px solid white">
        <td>
        <span id="onselection">
        <select class="form-control" id="onyear">
        <option value="0">All years</option>
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
        </span>
        <span id="rangeselection" style="display:none">
         <b>From</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b style="padding:30%">To</b><br>
          <select class="form-control" id="fyear" style="width:45%;display:inline">
       
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
       
         <select class="form-control" id="tyear" style="width:45%;display:inline;">
       
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
        </span>
        </td>
        </tr>
     
        <tr style="border:3px solid white"><th>Group by</th>
        <td>
        <select class="form-control" id="grpby">
        <option value="0">None</option>
        <option value="finding">Finding type</option>
        <option value="auditee">Auditee</option>
        <option value="year">Audit year</option>
        </select>
        </td>
        </tr>
        <tr style="border:3px solid white"><th><input type="checkbox" id="finding" style="width:20px;height:20px" checked="checked">Finding</th><th><input type="checkbox" id="recomm" style="width:20px;height:20px" checked="checked">Recommendation</th></tr>
        <tr><td colspan="2">Check Fields to appear in the report</td></tr>
        <tr style="border:1px solid white;font-size:10px"><th colspan="2"><input type="checkbox" id="Checkbox1" style="width:20px;height:20px" checked="checked">Number of findings</th></tr>
        <tr style="border:1px solid white;font-size:10px"><th colspan="2"><input type="checkbox" id="Checkbox2" style="width:20px;height:20px" checked="checked">Actual financial value of findings</th></tr>
        <tr style="border:1px solid white;font-size:10px"><th colspan="2"><input type="checkbox" id="Checkbox3" style="width:20px;height:20px" checked="checked">Extrapolated Financial value of findings</th></tr>
        <tr style="border:1px solid white;font-size:10px"><th colspan="2"><input type="checkbox" id="Checkbox4" style="width:20px;height:20px" checked="checked">Number of recommendations</th></tr>
        <tr style="border:1px solid white;font-size:10px"><th colspan="2"><input type="checkbox" id="Checkbox5" style="width:20px;height:20px" checked="checked">Potential saving from recommendations</th></tr>
        <tr style="border:1px solid white;font-size:10px"><th colspan="2"><input type="checkbox" id="Checkbox6" style="width:20px;height:20px" checked="checked">Number of fully implemented recommendations</th></tr>
        <tr style="border:1px solid white;font-size:10px"><th colspan="2"><input type="checkbox" id="Checkbox7" style="width:20px;height:20px" checked="checked">Number of partialy implemented recommendations</th></tr>
        <tr style="border:1px solid white;font-size:10px"><th colspan="2"><input type="checkbox" id="Checkbox8" style="width:20px;height:20px" checked="checked">Number of not implemented recommendations</th></tr>
        <tr style="border:1px solid white;font-size:10px"><th colspan="2"><input type="checkbox" id="Checkbox9" style="width:20px;height:20px" checked="checked">Recovered financial value</th></tr>
        <tr style="border:1px solid white;font-size:10px"><th colspan="2"><input type="checkbox" id="Checkbox10" style="width:20px;height:20px" checked="checked">Unrecovered financial value</th></tr>
        <tr style="border:3px solid white"><th colspan="2"><input type="checkbox" id="detail" style="width:20px;height:20px"> Show detail</th></tr>
         
        <tr style="border:1px solid black;font-size:10px"><td colspan="2" align="right"><button class="btn btn-link btn-block nav-tabs" style="background-color:#c2c9cb;color:black;text-align:left" onclick="showsetting()"><span class="glyphicon glyphicon-book"></span> Show</button></td></tr>
        <tr><th colspan="2">Pre-defined reports</th></tr>
        <tr style="border:1px solid black;font-size:10px !important"><td colspan="2"><button class="btn btn-link btn-block" onclick="showactionplanprovided()" style="background-color:#c2c9cb;color:black;text-align:left"><span class="glyphicon glyphicon-book"></span>Action plan and action taken provided</button></td></tr>
        <tr style="border:1px solid black;font-size:10px"><td colspan="2"><button class="btn btn-link btn-block" onclick="showactionplan()" style="background-color:#c2c9cb;color:black;text-align:left"><span class="glyphicon glyphicon-book"></span>Action plans which miss action plan date</button></td></tr>
        <tr style="border:1px solid black;font-size:10px"><td colspan="2"><button class="btn btn-link btn-block" onclick="showrecommendation(1)" style="background-color:#c2c9cb;color:black;text-align:left"><span class="glyphicon glyphicon-book"></span>Not implemented recommendations</button></td></tr>
        <tr style="border:1px solid black;font-size:10px"><td colspan="2"><button class="btn btn-link btn-block" onclick="showrecommendation(2)" style="background-color:#c2c9cb;color:black;text-align:left"><span class="glyphicon glyphicon-book"></span>Partially implemented recommendations</button></td></tr>
        <tr style="border:1px solid black;font-size:10px"><td colspan="2"><button class="btn btn-link btn-block" onclick="showrecommendation(3)" style="background-color:#c2c9cb;color:black;text-align:left"><span class="glyphicon glyphicon-book"></span>Fully implemented recommendations</button></td></tr>
       </table>
        </div>
    </div>
   
    <div class="" style="padding-left:0px;height:900px;overflow:auto;border-left:1px solid black;color:Black !important" id="content">
  
  
      
   </div>
        

</div>
         </div>
          <div class="panel panel-success"style="position:fixed;top:300px;left:10px;width:500px;height:200px;display:none;z-index:10;border:thick solid #c2c9cb" id="pdftcontainer">
          <div class="panel-footer" style="background-color:#c2c9cb;height:20%;border:1px solid #c2c9cb">
          <p style="color:black"><span class="glyphicon glyphicon-floppy-disk"></span>Export report to pdf</p>
          </div>
          <div class="panel-body" id="" style="height:60%">
             <b>Give Title for the pdf</b>
            <input type="text" class="form-control" id="pdftitle" style="border:1px solid #993333">
          </div>
          <div class="panel-footer" style="background-color:#c2c9cb;height:20%;text-align:right;border:1px solid #c2c9cb">
          <div class="btn-group btn-block"><button class="bnt btn-primary" style="width:100px" onclick="printpdf()">OK</button>
          <button class="bnt btn-primary" style="color:white;width:100px" onclick="$('#pdftcontainer').slideUp(0);document.getElementById('pdftitle').value=''">Cancel</button>
          </div></div>
         </div>

          <div class="panel"style="position:fixed;top:20%;left:30%;width:70%;height:60%;display:none;z-index:10;border:1px solid #c2c9cb" id="findingcontainer">
          <ul class="nav nab-tabs" align="right"><li><a href="#" onclick="$('#findingcontainer').slideUp();">X</a></li></ul>
          <div class="panel-body" id="fcont" style="height:90%;overflow:auto">
           
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
