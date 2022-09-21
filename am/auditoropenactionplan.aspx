<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>

    <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   string recom = "";
   string actionplan = "";
   string actiondate = "";
   try
   {
       con.Open();
       SqlDataReader recomreader = new SqlCommand("select recomName from recommendation_Table where recomId=" + int.Parse(Request["recomId"]), con).ExecuteReader();
       while (recomreader.Read())
       {
           recom = recomreader["recomName"].ToString();
       }
       con.Close();
       con.Open();
       SqlDataReader actionplanreader = new SqlCommand("select * from actionPlan_Table where recomId=" + int.Parse(Request["recomId"]), con).ExecuteReader();
       while (actionplanreader.Read()) {
           actionplan = actionplanreader["actionplan"].ToString();
           actiondate = actionplanreader["actiondate"].ToString();
       }
       con.Close();
   }
   catch (Exception ex) {
       Response.Write(ex.Message);
   }
    %>
    <p></p>
    <table class="table table-condensed table-responsive table-bordered table-striped" style="border:2px solid #998888">
     
    <tr><th style="width:20%">የትግበራ ዕቅድ</th><td><textarea class="form-control" style="border:1px solid #c2c9cb"rows="3" id="action<%Response.Write(Request["recomId"]);%>" placeholder="የትግበራ ዕቅድ እዚህ ጻፍ..."><%Response.Write(actionplan);%></textarea></td></tr>
    <tr><th>የትግበራ ዕቅድ ቀን</th><td><input type="date" id="actiondate<%Response.Write(Request["recomId"]);%>" class="form-control" style="width:200px;border:1px solid #c2c9cb" value="<%Response.Write(actiondate);%>"></td></tr>
    <tr>
    <%if (actionplan == "" && actiondate == "")
      {%><td colspan="2"><button class="btn btn-primary" style="color:white;width:200px;" onclick="saveActionPlan(<%Response.Write(Request["recomId"]);%>)">ምዝግብ</button> <span style="color:blue" id="actionplansavedmsg<%Response.Write(Request["recomId"]);%>"></span></td>
    <%}
      else { 
      %><td colspan="2"><button class="btn btn-primary" style="color:white;width:200px;" onclick="saveActionPlan(<%Response.Write(Request["recomId"]);%>)">ለውጦችን መዝግብ</button> <span style="color:blue" id="actionplansavedmsg<%Response.Write(Request["recomId"]);%>"></span></td>
    <%
      } %></tr>
    </table>
</body>
</html>

