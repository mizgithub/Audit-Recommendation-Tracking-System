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

    <button class="btn btn-link" style="color:#666699" onclick="$('#actiontakenform<%Response.Write(Request["planId"]);%>').slideToggle();"><h4>
        <span class="glyphicon glyphicon-plus"></span>የተወሰደ እርምጃ ጨምር</h4></button>
    <table class="table table-responsive table-condensed table-hover table-bordered table-striped" style="border: 2px solid #009fc6;display:none" id="actiontakenform<%Response.Write(Request["planId"]);%>">
        <tr>
            <td colspan="2">
                <textarea class="form-control" id="actiontaken<%Response.Write(Request["planId"]);%>" placeholder="የተወሰደ እርምጃ እዚህ ጻፍ..." rows="4" style="border:1px solid #552222"></textarea>
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
        <tr style="background-color: #c2c9cb; color: black">
            <th colspan="4">
                <span class="glyphicon glyphicon-saved"></span><b>የተመዘገቡ የተገምጋሚ ድርጅት በትግበራ ዕቅዱ ላይ የወሰዳቸው እርምጃዎች</b>
            </th>
        </tr>
        <%try
          {
              con.Open();
              SqlDataReader actiontakenreader = new SqlCommand("select * from actiontaken_Table where actionplanId=" + int.Parse(Request["planId"]) + " order by actiontakenId desc", con).ExecuteReader();
              while (actiontakenreader.Read()) { 
                %>
                <tr>
                <td style="width:7px"><button class="btn btn-link" title="አድስ" onclick="$('#editactiontaken<%Response.Write(actiontakenreader["actiontakenId"]);%>').slideToggle();"><span class="glyphicon glyphicon-edit"></span></button></td>
                <td style="width:7px"><button class="btn btn-link" title="አጥፋ" style="color:red" onclick="deleteactiontaken(<%Response.Write(actiontakenreader["actiontakenId"]);%>,<%Response.Write(actiontakenreader["actionplanId"]);%>)"><span class="glyphicon glyphicon-trash"></span></button></td>
                <td><%Response.Write(actiontakenreader["actiontaken"]);%></td>
                <td><%Response.Write(actiontakenreader["actiondate"]);%></td>
                </tr>
                <tr id="editactiontaken<%Response.Write(actiontakenreader["actiontakenId"]);%>" style="display:none">
                   <td colspan="4">
                   <table class="table table-condensed table-responsive table-striped table-bordered">
                   <tr>
                   <th style="width:30px;">የተወሰደ እርምጃ</th><td><textarea class="form-control" id="edactiontaken<%Response.Write(actiontakenreader["actiontakenId"]);%>" placeholder="የተወሰደ እርምጃ እዚህ ጻፍ...."><%Response.Write(actiontakenreader["actiontaken"]);%></textarea></td>
                   </tr>
                    <tr>
                    <th>የተመለሰ የፋይናንስ እሴት (ETB.)</th>
                   <td>
                  <input type="number" class="form-control" id="edrecvalue<%Response.Write(actiontakenreader["actiontakenId"]);%>" value="<%Response.Write(actiontakenreader["recoveredvalue"]);%>">
                  </td>
                  </tr>
                   <tr>
                   <th style="width:30px;">እርምጃ የተወሰደበት ቀን</th><td><input type="date" id="edactiontdate<%Response.Write(actiontakenreader["actiontakenId"]);%>" value="<%Response.Write(actiontakenreader["actiondate"]);%>"></td>
                   </tr>
                   <tr><td><button class="btn btn-primary" onclick="savechangesactiontaken(<%Response.Write(actiontakenreader["actiontakenId"]);%>,<%Response.Write(actiontakenreader["actionplanId"]);%>)">ለውጦችን መዝግብ</button></td>
                   <td><button class="btn btn-primary" onclick="$('#editactiontaken<%Response.Write(actiontakenreader["actiontakenId"]);%>').slideUp();">አቋርጥ</button></td></tr>
                   </table>
                   </td>                
                </tr>
                <%
              }
              con.Close();
          }
          catch (Exception ex) { 
          
          }
            
          %>
      
</body>
</html>
