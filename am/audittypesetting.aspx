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
      %>
 <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
  %>
  <h4><span class="glyphicon glyphicon-plus"></span>አዲስ የኦዲት አይነት</h4>
 <center> <span id="audtymsg"></span><table class="table" style="width:70%">
 <tr><td colspan="2"><input type="text" class="form-control" id="audittype" placeholder="የኦዲት አይነት.."></td></tr>
 <tr><td style="width:50%"></td><td><button class="btn btn-primary btn-block" onclick="saveaudittype()">መዝግብ</button></td></tr>
  </table>
  </center>
  <hr style="border:2px solid #777777">
    <h4><span class="glyphicon glyphicon-folder-close"></span>የተመዘገቡ የኦዲት አይነቶች</h4>
    <table class="table">
    <%
        try
        {
            con.Open();
            SqlDataReader audittypeReader = new SqlCommand("select * from auditType_Table order by typeId desc", con).ExecuteReader();
            while (audittypeReader.Read()) { 
                %>
               <tr><td style="width:5%"><button class="btn btn-link" style="color:Orange" onclick="$('#vis<%Response.Write(audittypeReader["typeId"]);%>').slideToggle();$('#hid<%Response.Write(audittypeReader["typeId"]);%>').slideToggle();" title="አዲስ"><span class="glyphicon glyphicon-pencil"></span></button></td><td style="width:5%"><button class="btn btn-link" style="color:red" onclick="deleteaudittype(<%Response.Write(audittypeReader["typeId"]);%>)" title="አጥፋ"><span class="glyphicon glyphicon-trash"></span></button></td><td><span id="vis<%Response.Write(audittypeReader["typeId"]);%>"><%Response.Write(audittypeReader["auditType"]);%></span><span id="hid<%Response.Write(audittypeReader["typeId"]);%>" style="display:none"><input type="text" id="audittypevalue<%Response.Write(audittypeReader["typeId"]);%>" value="<%Response.Write(audittypeReader["auditType"]);%>" class="form-control"><button class="btn btn-link" onclick="savechangesofaudittype(<%Response.Write(audittypeReader["typeId"]);%>)">save changes</button></span><span id="audtymsg<%Response.Write(audittypeReader["typeId"]);%>"></span></td></tr>
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
