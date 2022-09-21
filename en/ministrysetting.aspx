<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
  <script type="text/javascript">
     
  </script>
</head>
<body>
<%
     if (Request.Cookies["user"].Value == null || Request.Cookies["user"].Value == "")
     {
         Response.Redirect("login.aspx");
    } 
     
     
      %>
<% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
 %>
  <h4><span class="glyphicon glyphicon-plus"></span>Add new federal ministry</h4>
 <center> <span id="minmsg"></span><table class="table" style="width:70%">
 <tr><td colspan="2"><input type="text" class="form-control" id="fedministry" placeholder="Name of the ministry"></td></tr>
 <tr><td style="width:50%"></td><td><button class="btn btn-primary btn-block" onclick="saveministry()">Add</button></td></tr>
  </table>
  </center>
  <hr style="border:2px solid #777777">
    <h4><span class="glyphicon glyphicon-folder-close"></span>Registered federal ministries</h4>
    <table class="table">
    <%  try
        {
            con.Open();
            SqlDataReader minReader = new SqlCommand("select * from ministry_Table order by minId desc", con).ExecuteReader();
            while (minReader.Read()) { 
            %>
            <tr><td style="width:5%"><button class="btn btn-link" style="color:Orange" onclick="$('#vismin<%Response.Write(minReader["minId"]);%>').slideToggle();$('#hidmin<%Response.Write(minReader["minId"]);%>').slideToggle();"><span class="glyphicon glyphicon-pencil"></span></button></td><td style="width:5%"><button class="btn btn-link" style="color:red" onclick="deleteministry(<%Response.Write(minReader["minId"]);%>)"><span class="glyphicon glyphicon-trash"></span></button></td><td><span id="vismin<%Response.Write(minReader["minId"]);%>"><%Response.Write(minReader["minName"]);%></span><span id="hidmin<%Response.Write(minReader["minId"]);%>" style="display:none"><input type="text" class="form-control" id="minvalue<%Response.Write(minReader["minId"]);%>" value="<%Response.Write(minReader["minName"]);%>" /><button class="btn btn-link" onclick="savechangesministry(<%Response.Write(minReader["minId"]);%>)">save changes</button></span><span id="minmsg<%Response.Write(minReader["minId"]);%>"></span></td></tr>
            <%
            }
            con.Close();
        }
        catch (Exception ex) {
            con.Close();
        }
        
         %>
     </table>
</body>
</html>
