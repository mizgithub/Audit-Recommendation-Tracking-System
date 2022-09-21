<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
<%
     if (Request.Cookies["user"].Value == null || Request.Cookies["user"].Value == "")
     {
         Response.Redirect("../login.aspx");
    } 
     
     
      %>
<% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   SqlConnection con2 = new SqlConnection(@conString);
 %>
  <h4><span class="glyphicon glyphicon-plus"></span>Add new federal organization</h4>
 <center> <span id="orgmsg"></span><table class="table" style="width:70%">
 <tr><td colspan="2"><input type="text" class="form-control" id="fedorg" placeholder="name of organization"></td></tr>
  <tr><td colspan="2">
   <p>Select Audit direcorate to which the federal organization belongs</p>
   <select id="fedministry" class="form-control">
   <%
       try
       {
           con.Open();
           SqlDataReader minReader = new SqlCommand("select * from ministry_Table", con).ExecuteReader();
           while (minReader.Read()) { 
            %>
            <option value="<%Response.Write(minReader["minId"]);%>"><%Response.Write(minReader["minName"]);%></option>
             <%
           }
           con.Close();
       }
       catch (Exception ex) {
           con.Close();
       }
    %>
   </select>
  </td></tr>
 <tr><td style="width:50%"></td><td><button class="btn btn-primary btn-block" onclick="savefederalorg()">Add</button></td></tr>
  </table>
  </center>
  <hr style="border:2px solid #777777">
    <h4><span class="glyphicon glyphicon-folder-close"></span>Registered federal organizations</h4>
    <table class="table">
    <%try
      {
          con.Open();
          SqlDataReader orgReader = new SqlCommand("select * from org_Table order by minId desc", con).ExecuteReader();
          while (orgReader.Read()) {
              string minName = "";
              con2.Open();
              SqlDataReader minReader = new SqlCommand("select minName from ministry_Table where minId=" + (int)orgReader["minId"], con2).ExecuteReader();
              while (minReader.Read()) {
                  minName = minReader["minName"].ToString();
              }
              con2.Close();
             %>
            <tr><td style="width:5%"><button class="btn btn-link" style="color:Orange" onclick="$('#vis<%Response.Write(orgReader["orgId"]);%>').slideToggle();$('#hid<%Response.Write(orgReader["orgId"]);%>').slideToggle();" title="Edit"><span class="glyphicon glyphicon-pencil"></span></button></td><td style="width:5%"><button class="btn btn-link" style="color:red" title="Delete" onclick="deleteorg(<%Response.Write(orgReader["orgId"]);%>)"><span class="glyphicon glyphicon-trash"></span></button></td><td><span id="vis<%Response.Write(orgReader["orgId"]);%>"><%Response.Write(orgReader["orgName"]);%></span><span id="hid<%Response.Write(orgReader["orgId"]);%>" style="display:none"><input type="text" id="orgvalue<%Response.Write(orgReader["orgId"]);%>" value="<%Response.Write(orgReader["orgName"]);%>" class="form-control"><button class="btn btn-link" onclick="savechangesoforg(<%Response.Write(orgReader["orgId"]);%>)">save changes</button></span><span id="orgmsg<%Response.Write(orgReader["orgId"]);%>"></span></td><td><%Response.Write(minName);%></td></tr>
             <%
          }
          con.Close();
      }
      catch (Exception ex) {
          con.Close();
          con2.Close();
      }
         %>
       </table>
</body>
</html>
