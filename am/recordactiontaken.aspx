<%@ Page Language="C#" AutoEventWireup="true"%>

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
      
     
    %>

    <button class="btn btn-link" onclick="$('#actiontakenform<%Response.Write(Request["planId"]);%>').slideToggle();"><h4>
        <span class="glyphicon glyphicon-plus"></span>የተወሰዱ እርምጃዎችን አክል</h4></button>
    <table class="table table-responsive table-condensed table-hover table-bordered table-striped" style="border: 2px solid #c2c9cb;display:none" id="actiontakenform<%Response.Write(Request["planId"]);%>">
        <tr>
            <td colspan="2">
                <textarea class="form-control" id="actiontaken<%Response.Write(Request["planId"]);%>" placeholder="የተወሰደ እርምጃ..." rows="4" style="border:1px solid #c2c9cb"></textarea>
            </td>
        </tr>
         <tr>
         <th>የተመለሰ የፋይናንስ እሴት (ETB.)</th>
            <td>
               <input type="number" class="form-control" id="recvalue<%Response.Write(Request["planId"]);%>">
            </td>
        </tr>
        <tr>
        <th>እርምጃ የተወሰደበት ቀን</th>
        <td><input type="date" id="actiontdate<%Response.Write(Request["planId"]);%>" class="form-control"></td>
        </tr>
        <tr>
            <td colspan="2">
                <button class="btn btn-primary" onclick="saveactiontaken(<%Response.Write(Request["planId"]);%>)">
                    <b>መዝግብ</b></button>
            </td>
        </tr>
    </table>
    <table class="table table-responsive table-condensed table-hover table-bordered table-striped">
        <tr style="background-color:#c2c9cb; color: black">
            <th colspan="4">
                <span class="glyphicon glyphicon-saved"></span><b>የተመዘገቡ የተወሰዱ እርምጃዎች</b>
            </th>
        </tr>
        <tr><th>ተ.ቁ</th><th>የተወሰደ እርምጃ</th><th>የተመለሰ የፋይናንስ እሴት (ETB.)</th><th>እርምጃ የተወሰደበት ቀን</th></tr>
        <%try
          {
              con.Open();
              SqlDataReader actiontakenreader = new SqlCommand("select * from actiontaken_Table where actionplanId=" + int.Parse(Request["planId"]) + " order by actiontakenId asc", con).ExecuteReader();
              int rowcounter = 0;
             
              while (actiontakenreader.Read()) {
                  double recvalue = 0.0;
                  if (actiontakenreader["recoveredvalue"].ToString() != "" && actiontakenreader["recoveredvalue"].ToString() != "0")
                  {
                      recvalue = double.Parse(actiontakenreader["recoveredvalue"].ToString());
                  }
                %>
                <tr>
                <th style="width:5%"><%Response.Write(++rowcounter);%></th>
                <td style="width:61%"><%Response.Write(actiontakenreader["actiontaken"]);%></td>
                <td style="width:17%"><%Response.Write(recvalue);%></td>
                <td style="width:17%"><%Response.Write(actiontakenreader["actiondate"]);%></td>
                </tr>
               
                <%
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
