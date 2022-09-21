<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
<%   Response.Cache.SetCacheability(HttpCacheability.NoCache);
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
  <h4><span class="glyphicon glyphicon-plus"></span>Add new audit directorate</h4>
 <center> <span id="dirmsg"></span><table class="table" style="width:70%">
 <tr><td colspan="2"><input type="text" class="form-control" id="dir" placeholder="Name of audit directorate"></td></tr>
 <tr><td style="width:50%"></td><td><button class="btn btn-primary btn-block" onclick="savedirectorate()">Add</button></td></tr>
  </table>
  </center>
  <hr style="border:2px solid #777777">
    <h4><span class="glyphicon glyphicon-folder-close"></span>Saved audit directorates</h4>
    <table class="table">
    <%
        try
        {
            con.Open();
            SqlDataReader dirReader = new SqlCommand("select * from directorate_Table order by dirId desc", con).ExecuteReader();
            while (dirReader.Read()) { 
              %>
                <tr><td style="width:5%"><button class="btn btn-link" style="color:Orange" onclick="$('#vis<%Response.Write(dirReader["dirId"]);%>').slideToggle();$('#hid<%Response.Write(dirReader["dirId"]);%>').slideToggle();" title="Edit"><span class="glyphicon glyphicon-pencil"></span></button></td><td style="width:5%"><button class="btn btn-link" style="color:red" onclick="deletedirectorate(<%Response.Write(dirReader["dirId"]);%>)" title="Delete"><span class="glyphicon glyphicon-trash"></span></button></td><td><span id="vis<%Response.Write(dirReader["dirId"]);%>"><%Response.Write(dirReader["directorate"]);%></span><span id="hid<%Response.Write(dirReader["dirId"]);%>" style="display:none"><input type="text" class="form-control" id="dirvalue<%Response.Write(dirReader["dirId"]);%>" value="<%Response.Write(dirReader["directorate"]);%>"><button class="btn btn-link" onclick="savechangesofdirectorate(<%Response.Write(dirReader["dirId"]);%>)">save changes</button></span><span id="dirmsg<%Response.Write(dirReader["dirId"]);%>"></span></td></tr>
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
