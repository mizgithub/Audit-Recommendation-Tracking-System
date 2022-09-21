<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<%
     if (Request.Cookies["user"].Value == null || Request.Cookies["user"].Value == "")
     {
         Response.Redirect("../login.aspx");
    }
     Response.Cache.SetCacheability(HttpCacheability.NoCache);
     Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
     Response.Cache.SetNoStore();
     
      %>
   <div class="row">
    <div class="col-sm-4" style="border-width:0px;border-radius:0px;border-right:1px solid #777777;height:600px;">
    <div class="panel -panel-default">
    <table class="table">
    <tr><td><button class="btn btn-link" onclick="openministrysetting()"><span class="glyphicon glyphicon-cog"></span>Federal Ministry Setting</button></td></tr>
    <tr><td><button class="btn btn-link" onclick="openfederalorgsetting()"><span class="glyphicon glyphicon-cog"></span>Federal Organization Setting</button></td></tr>
    </table>
    </div>
    </div>
    <div class="col-sm-8">
    <div id="audteeemptycont">
    <h4>Click on one of the settinh buttons on the Left</h4>
    </div>
    </div>
   </div>
   <%Response.Write("");%>
</body>
</html>
