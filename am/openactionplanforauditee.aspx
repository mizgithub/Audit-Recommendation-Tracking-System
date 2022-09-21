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
           Response.Write("ምንም ኦዲት አልተገኘም");
       }
       else {
           Response.Write("የተወሰደውን እርምጃ ለመመዝገብ «እርምጃዎችን አክል» የሚለውን ጠቅ ያድርጉ <br><b>ማሳሰቢያ</b>: አንዴ እሴት ካስገቡ በኋላ እርትቱን ማስተካከል አይችሉም, ስለዚህ እባክዎ ትክክለኛውን መረጃ እንዳስገቡ እርግጠኛ ይሁኑ");
           Response.Cookies["auditId"].Value = auditId+"";
       }
                       con.Open();
                        SqlDataReader actionplanreader = new SqlCommand("select * from actionPlan_Table where auditId=" +auditId, con).ExecuteReader();
                        int plancounter = 1;
                        while (actionplanreader.Read())
                        {   
                           
                        %>
                         <tr><td><button class="btn btn-link" onclick="$('#recomcontent<%Response.Write(actionplanreader["recomId"]);%>').slideToggle();openactiontaken(<%Response.Write(actionplanreader["recomId"]);%>)"><span class="glyphicon glyphicon-record"></span>እርምጃዎችን አክል</button></td><td style=""><i style="color:green">የድርጊት ዕቅድ <%Response.Write(plancounter);%></i></td><td><p><%Response.Write(actionplanreader["actionplan"]);%></p></td></tr>
                         <tr><td colspan="3"><div class="col-sm-12 panel-panel-primary" id="recomcontent<%Response.Write(actionplanreader["recomId"]);%>" style="display:none;background-color:white">
                          </div>
                          </td></tr>
                        <%
                            
                          plancounter++;
                            }
                        con.Close();
   }
   catch (Exception ex) { 
     Response.Write(ex.Message);
   }
  %>
  </table>
</body>
</html>
