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
         Response.Redirect("login.aspx");
    } 
     
     
      %>
 <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
  %>
  <h4><span class="glyphicon glyphicon-plus"></span>Add new finding type</h4>
 <center><span id="findtymsg"></span><table class="table" style="width:70%">
 <tr><td colspan="2"><input type="text" class="form-control" id="findingtype" placeholder="Name of Finding Type"></td></tr>
 <tr><td style="width:50%"></td><td><button class="btn btn-primary btn-block" onclick="savefindingtype()">Add</button></td></tr>
  </table>
  </center>
  <hr style="border:2px solid #777777">
    <h4><span class="glyphicon glyphicon-folder-close"></span>Saved finding types</h4>
    <table class="table">
    <%
        try
        {
            con.Open();
            SqlDataReader findingtypeReader = new SqlCommand("select * from findingType_Table order by typeId desc", con).ExecuteReader();
            while (findingtypeReader.Read())
            { 
                %>
               <tr><td style="width:5%"><button class="btn btn-link" style="color:Orange" onclick="$('#vis<%Response.Write(findingtypeReader["typeId"]);%>').slideToggle();$('#hid<%Response.Write(findingtypeReader["typeId"]);%>').slideToggle();" title="Edit"><span class="glyphicon glyphicon-pencil"></span></button></td><td style="width:5%"><button class="btn btn-link" style="color:red" onclick="deletefindingtype(<%Response.Write(findingtypeReader["typeId"]);%>)" title="Delete"><span class="glyphicon glyphicon-trash"></span></button></td><td><span id="vis<%Response.Write(findingtypeReader["typeId"]);%>"><%Response.Write(findingtypeReader["findingType"]);%></span><span id="hid<%Response.Write(findingtypeReader["typeId"]);%>" style="display:none"><input type="text" id="findingTypevalue<%Response.Write(findingtypeReader["typeId"]);%>" value="<%Response.Write(findingtypeReader["findingType"]);%>" class="form-control"><button class="btn btn-link" onclick="savechangesoffindingtype(<%Response.Write(findingtypeReader["typeId"]);%>)">save changes</button></span><span id="findtymsg<%Response.Write(findingtypeReader["typeId"]);%>"></span></td></tr>
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
