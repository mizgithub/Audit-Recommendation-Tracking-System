<%@ Page Language="C#" AutoEventWireup="true"  %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>

  <table class="table table-condensed table-responsive">
  <tr style="background-color:#009fc6;color:white"><th colspan="3">All Action plans</th></tr>
  <tr><td colspan="3">
    <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
     SqlConnection con = new SqlConnection(@conString);
     SqlConnection con2 = new SqlConnection(@conString);
     try
     {

         con.Open();
         SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where auditId=" + int.Parse(Request.Cookies["auditId"].Value), con).ExecuteReader();
         int recomcounter = 1;
         while (recomreader.Read())
         {
             %>
             <table class="table table-condensed table-responsive" style="border:2px solid #aaaaaa;">
             <tr><td colspan="3" style="width:30px;"><b style="color:#009fc6"><u>Recommendation <%Response.Write(recomcounter);%></u></b></td></tr>
             <tr><td colspan="3" style="background-color:#eeeeff"><%Response.Write(recomreader["recomName"]);%></td></tr>
             <%
                                                                                                con2.Open();
                                                                                                SqlDataReader actionplanreader = new SqlCommand("select * from actionPlan_Table where recomId=" + (int)recomreader["recomId"], con2).ExecuteReader();
                                                                                                while (actionplanreader.Read())
                                                                                                {
                                                                                                    if (recomreader["status"].ToString() != "3" && actionplanreader["actiondate"].ToString().CompareTo(DateTime.Now.ToString("yyyy-MM-dd"))<=0)
                                                                                                    {
                    %>
                     <tr style="background-color:#ff6666"><td><i style="color:blue">Action plan</i></td><td><%Response.Write(actionplanreader["actionplan"]);%><br><i style="color:blue">Deadline missed</i></td><td><i style="color:blue">Action date</i>: <%Response.Write(actionplanreader["actiondate"]);%></td></tr>
                    <%
                                                                                                    }
                                                                                                    else {
                     %>
                     <tr style="background-color:#66ff66"><td><i style="color:blue">Action plan</i></td><td><%Response.Write(actionplanreader["actionplan"]);%></td><td><i style="color:blue">Action date</i>: <%Response.Write(actionplanreader["actiondate"]);%></td></tr>
                    <%
                                                                                                    }
                                                                                                }
                                                                                                con2.Close();
                                                                                                recomcounter++;
                                                                                                %>
                                                                                                </table>
                                                                                                
                                                                                                <%
                                                                                                }
                                                                   
         con.Close();

     }
     catch (Exception ex)
     {
         con.Close();
     }
 %>
 </td></tr>
 </table>
</body>
</html>
