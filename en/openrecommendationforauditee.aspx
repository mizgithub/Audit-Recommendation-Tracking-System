<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
<table class="table table-responsive table-condenced table-hover table-striped table-bordered">
   <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   string year = Request["year"];
   string audittype = Request["audittype"];
   int orgId = 0;
 
   try
   {
       orgId = int.Parse(Request.Cookies["user"].Value);
   }
   catch (Exception ex) { 
      
   }
  
   try
   {
       con.Open();
       SqlDataReader auditreader = new SqlCommand("select auditId from audit_Table where year='" + year + "' and audittype='" + audittype + "' and orgId=" + orgId + " and status='submitted'", con).ExecuteReader();
       int auditId = 0;
       while (auditreader.Read()) {
           auditId = (int)auditreader["auditId"];
       }
       con.Close();
       if (auditId == 0)
       {
           Response.Write("No audit found");
       }
       else {
           Response.Write("<h5>Click on <u>add action plan</u> button to recomrd action plan</h5><br><b>Note:</b>You can not edit the value once you record it, so please make sure that you entered the corect value");
           Response.Cookies["auditId"].Value = auditId+"";
       }
       con.Open();
       SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where auditId=" + auditId, con).ExecuteReader();
        int recomcounter=1;
              while (recomreader.Read()) { 
                   %>
              <tr><td style="width:100px"><button class="btn btn-link" onclick="$('#actioncontent<%Response.Write(recomreader["recomId"]);%>').slideToggle();openactionplan(<%Response.Write(recomreader["recomId"]);%>)"><span class="glyphicon glyphicon-record"></span>Add action plan</button></td><th style="width:7px;"><i style="color:green">Recomm. <%Response.Write(recomcounter);%></i></th><th><%Response.Write(recomreader["recomName"]);%></th></tr>
              <tr><td colspan="3">
               <div class="col-sm-12" id="actioncontent<%Response.Write(recomreader["recomId"]);%>" style="display:none;background-color:white">
               </div>
              </td></tr>
              <%     
             recomcounter++;
              }
              con.Close();
       con.Close();
   }
   catch (Exception ex) { 
     Response.Write(ex.Message);
   }
  %>
  </table>
</body>
</html>
