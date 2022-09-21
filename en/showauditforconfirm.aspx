<%@ Page Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
<script type="text/javascript">
    function showdetailfidingrecom() {
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (this.readyState == 4 && this.status) {
                $("#detailfindingrecom").html(this.responseText);
            }
        };
        http.open("GET", "Ag_showdetailfindingrecommendation.aspx", true);
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
<body onload="showdetailfidingrecom()" style="color:black !important">

 <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   SqlConnection con2 = new SqlConnection(@conString);
   %>
    
    <!--************************************************-->
      <table class="table table-responsive table-condensed" style="background-color:#eeddbb">
      <tr style="background-color:#009fc6;color:white"><th colspan="2">Audit information</th></tr>
      <%
          try
          {
              con.Open();
              SqlDataReader auditreader = new SqlCommand("select * from audit_Table where auditId=" + int.Parse(Request["auditId"]), con).ExecuteReader();
              while (auditreader.Read()) {
                  string orgname = "";
                  con2.Open();
                  SqlDataReader orgreader = new SqlCommand("select orgName from org_Table where orgId=" + (int)auditreader["orgId"], con2).ExecuteReader();
                  while (orgreader.Read()) {
                      orgname = orgreader["orgName"].ToString();
                  }
                  con2.Close();
                  %>
                  <tr><th style="width:10%">Audit title</th><td><%Response.Write(auditreader["auditName"]);%></td></tr>
                  <tr><th>Auditee</th><td><%Response.Write(orgname);%></td></tr>
                  <tr><th>Audit Type</th><td><%Response.Write(auditreader["auditType"]);%></td></tr>
                  <tr><th>Audit year</th><td><%Response.Write(auditreader["year"]);%></td></tr>
                  <tr><th>Audit Period</th><td><%Response.Write("<u>"+auditreader["startdate"]+"</u>---<u>"+auditreader["enddate"]+"</u>");%></td></tr>    
                  <tr><td colspan="2"><hr></td></tr>
                  <%
              }
              con.Close();
          }
          catch (Exception ex) {
              Response.Write(ex.Message);
          }
                      try
                      {
                       con.Open();
                          SqlDataReader auditorreader = new SqlCommand("select * from auditor_Table where auditId=" + int.Parse(Request["auditId"]), con).ExecuteReader();
                          while (auditorreader.Read()) { 
                           %>
                           <tr><th>Auditor</th><td><%Response.Write(auditorreader["fname"] + " " + auditorreader["lname"] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>Rank: <U>" + auditorreader["rank"] + "</u> </i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>Directorate <u>" + auditorreader["directorate"] + "</u></i>");%></td></tr>
                           <%
                          }
                          con.Close();
                          con.Open();
                          %>
                           <tr><th>Reviewd by</th><td>
                          <%
                          SqlDataReader revreader = new SqlCommand("select * from reviewer_Table where auditId=" + int.Parse(Request["auditId"]), con).ExecuteReader();
                          int revcounter = 1;
                          while (revreader.Read()) {
                              Response.Write(revcounter+++". "+revreader["fname"] + " " + revreader["lname"] + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>Rank: " + revreader["rank"] + "</i>&nbsp;&nbsp;&nbsp;<i>date:" + revreader["date"] + "<br>");
                          }
                          con.Close();
                          %>
                          </td></tr>
                          <%
                      }
                      catch (Exception ex) {
                          Response.Write(ex.Message);
                      }
           %>
           
      </table>
        <table class="table table-condensed table-responsive" style="background-color:#eeddbb">
        <tr style="background-color:#009fc6;color:white"><th colspan="5">Findings and recommendations</th></tr>
        <%try
          {
              con.Open();
              int nooffinding = 0;
              Double sumofactualvalue = 0.00;
              Double sumofextravalue = 0.00;
              SqlDataReader findingreader1 = new SqlCommand("select * from finding_Table where auditId=" + int.Parse(Request["auditId"]), con).ExecuteReader();
              while (findingreader1.Read()) {
                  nooffinding++;
                  sumofactualvalue += Double.Parse(findingreader1["actualValue"].ToString());
                  sumofextravalue += Double.Parse(findingreader1["extraValue"].ToString());
              }
               
              con.Close();
              %>
              <tr style="background-color:#abcdef"><th colspan="5">Findings</th></tr>
              <tr><th>Total number of findings</th><th>Total Actual financial value of findings</th><th>Total Extrapolated financial value of findings</th><th></th><th></th></tr>
              <tr><td><%Response.Write(nooffinding);%></td><td><%Response.Write(sumofactualvalue);%> <b>ETB.</b></td><td><%Response.Write(sumofextravalue);%> <b>ETB.</b></td><td></td><td></td></tr>
               <%
              con.Open();
              int numofrecom = 0;
              Double saving = 0.00;
              int numfully = 0;
              int numpartly = 0;
              int numnot = 0;
              SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where auditId="+int.Parse(Request["auditId"]),con).ExecuteReader();
              while (recomreader.Read()) {
                  numofrecom++;
                  saving += Double.Parse(recomreader["potSaving"].ToString());
                  if (recomreader["status"].ToString() == "1") {
                      numnot++;
                  }
                  else if (recomreader["status"].ToString() == "2")
                  {
                      numpartly++;
                  }
                  else {
                      numfully++;
                  }
              }
              con.Close();
               %>
                <tr style="background-color:#abcdef"><th colspan="5">Recommendations</th></tr>
              <tr><th>Total number of recommendations</th><th>Total Potential saving from the recommendations</th><th style="background-color:#aaffaa">Total Fully implemented recommendations</th><th style="background-color:#ffffaa">Total partially implemented recommendations</th><th style="background-color:#ffaaaa">Total not implemented recommendations</th></tr>
              <tr><td><%Response.Write(numofrecom);%></td><td><%Response.Write(saving);%> <b>ETB.</b></td><td style="background-color:#aaffaa"><%Response.Write(numfully);%></td><td style="background-color:#ffffaa"><%Response.Write(numpartly);%></td><td style="background-color:#ffaaaa"><%Response.Write(numnot);%></td></tr>
               <%
              
          }
          catch (Exception ex) {
              Response.Write(ex.Message);
          }
            
             %>
        </table>
         <div id="detailfindingrecom" style="background-color:#eeddbb">
         <table class="table table-condensed table-responsive table-bordered table-striped" style="font-family:Times New Roman;color:black;font-size:15px;">
<tr style="background-color:#009fc6;color:white"><th colspan="4">Detail of findings and recommendations</th></tr>
    <% 
   SqlConnection con3 = new SqlConnection(@conString);
   try
   {
       con.Open();
       SqlDataReader findingreader = new SqlCommand("select * from finding_Table where auditId=" + int.Parse(Request["auditId"]), con).ExecuteReader();
       int findingcounter = 1;
       while (findingreader.Read()) {
           con3.Open();
           string findingtype = "";
           SqlDataReader ftypereader = new SqlCommand("select findingType from findingType_Table where typeId=" + (int)findingreader["findingType"], con3).ExecuteReader();
           while (ftypereader.Read()) {
               findingtype = ftypereader["findingType"].ToString();
           }
           con3.Close();
        %>
        <tr style="background-color:white"><th style="width:10%">Finding <%Response.Write(findingcounter++);%><br><i style="font-size:13px;">Finding type:<br><b style="color:#6666dd"><%Response.Write(findingtype);%></b></i></th><td><%Response.Write(findingreader["findingName"]);%></td><td>Actual financial value<br><b><%Response.Write(findingreader["actualValue"]);%> ETB.</b></td><td>Extrapolated financial value<br><b><%Response.Write(findingreader["extraValue"]);%> ETB.</b></td></tr>
        <tr><td colspan="4"><center><table class="table table-responsive table-condensed table-bordered table-striped" style="width:98%;">
        <tr style="background-color:#abcdef;color:#5566dd;border-top:2px solid #886666"><th colspan="4">Recommendations</th></tr>
        <%
           con2.Open();
           SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where findingId=" + (int)findingreader["findingId"], con2).ExecuteReader();
           int recomcounter = 1;
           while (recomreader.Read()) {
               int recomId=(int)recomreader["recomId"];
               if (recomreader["status"].ToString() == "1")
               {
            %>
            <tr><th style="border-top:2px solid #552222;"><i style="color:Blue;font-size:11px">Recomm.</i><%Response.Write(recomcounter++);%></th><td style="border-top:2px solid #552222"><%Response.Write(recomreader["recomName"]);%></td><td style="border-top:2px solid #552222">Potential saving<br><%Response.Write(recomreader["potSaving"]);%></td>
            <td style="border-top:2px solid #552222;width:200px;background-color:#ff2323"><u><b>Current status</b></u><br>
               NOT Implemented
            </td></tr>
            <%
               }
               else if (recomreader["status"].ToString() == "2")
               { 
                   %>
            <tr><th style="border-top:2px solid #552222"><i style="color:Blue;font-size:11px">Recomm.</i><%Response.Write(recomcounter++);%></th><td style="border-top:2px solid #552222"><%Response.Write(recomreader["recomName"]);%></td><td style="border-top:2px solid #552222">Potential saving<br><%Response.Write(recomreader["potSaving"]);%></td>
            <td style="width:200px;border-top:2px solid #552222;background-color:#ffff23"><u><b>Current status</b></u><br>
             Partially Implemented
            </td></tr>
            <%
               }
               else { 
               
             %>
            <tr><th style="border-top:2px solid #552222"><i style="color:Blue;font-size:11px">Recomm.</i><%Response.Write(recomcounter++);%></th><td style="border-top:2px solid #552222"><%Response.Write(recomreader["recomName"]);%></td><td style="border-top:2px solid #552222">Potential saving<br><%Response.Write(recomreader["potSaving"]);%></td>
            <td style="border-top:2px solid #552222;width:200px;background-color:#23ff23"><u><b>Current status</b></u><br>
            Fully Implemented
            </td></tr>
            <%
               }
            %>
            <tr style="background-color:#eeddbb"><td colspan="4"><center><table class="table table-condensed table-responsive table-bordered table-striped" border="1" style="width:98%">
            <tr style="background-color:#bcdeef;color:#009fc6;border-top:2px solid #886666;border-bottom:2px solid #886666;"><th colspan="2">Action plan</th></tr>
            <%
               con3.Open();
               SqlDataReader actionplanreader = new SqlCommand("select * from actionPlan_Table where recomId=" + (int)recomreader["recomId"], con3).ExecuteReader();
               while (actionplanreader.Read()) {
                   if (recomreader["status"].ToString() != "3" && actionplanreader["actiondate"].ToString().CompareTo(DateTime.Now.ToString("yyyy-MM-dd")) <= 0)
                   {
                %>
                <tr><td><%Response.Write(actionplanreader["actionplan"]);%></td><td style="width:200px;background-color:#ff5151">Action plan date:<br><b style="color:blue"><%Response.Write(actionplanreader["actiondate"]);%></b></td></tr>
                <tr><td style="color:blue" colspan="2">Missed the deadline</td></tr>
                <%
                   }
                   else { 
                    %>
                <tr><td><%Response.Write(actionplanreader["actionplan"]);%></td><td style="width:200px;background-color:#23ff23"">Action plan date:<br><b style="color:blue"><%Response.Write(actionplanreader["actiondate"]);%></b></td></tr>
                <%
                   }
               }
               con3.Close();
                 %>
            </table></center></td></tr>
            <%
               
           }
           con2.Close();
         %>
         </table></center></td></tr>
         <%  
       }
       con.Close();
   }
   catch (Exception ex) { 
   
   }
 %>
 </table>
         </div>
</body>
</html>
