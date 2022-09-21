<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
<center><table class="table table-responsive table-condensed table-hover table-bordered table-striped" style="border-left:100px solid #dddddd;border-right:100px solid #dddddd;padding-left:20px;padding-right:20px;">
    <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   SqlConnection con2 = new SqlConnection(@conString);
   string fname = Request["reguser"];

               try
               {
                   con.Open();
                   SqlDataReader userReader = new SqlCommand("select * from user_Table where fname like N'%"+fname+"%' order by idno desc", con).ExecuteReader();
                   while (userReader.Read()) { 
                     %>
                         <tr><th style="width:150px;"><%Response.Write(userReader["fname"]);%></th><th style="width:150px"><%Response.Write(userReader["lname"]);%></th><td><%Response.Write(userReader["role"]);%></td><td style="width:30px"><button class="btn btn-link" onclick="$('#hidrow<%Response.Write(userReader["idno"]);%>').slideToggle();"><span class="glyphicon glyphicon-pencil"></span>አድስ</button></td><td id="disbut<%Response.Write(userReader["idno"]);%>" style="width:30px;">
                         <%if (userReader["status"].ToString() == "active")
                           {%>
                         <button style="color:red" class="btn btn-link" onclick="disableuser(<%Response.Write(userReader["idno"]);%>,'deactive')"><span class="glyphicon glyphicon-off"></span>አሰናክል</button>
                         <%}
                           else
                           { %>
                          <button style="color:#23ff23" class="btn btn-link" onclick="disableuser(<%Response.Write(userReader["idno"]);%>,'active')"><span class="glyphicon glyphicon-check"></span>አንቃ</button>
                         <%} %>
                         </td></tr>
                         <tr style="display:none;" id="hidrow<%Response.Write(userReader["idno"]);%>">
                         <td colspan="5"><center>
                         <table class="table table-bordered table-condensed table-striped" border="1" style="width:80%;background-color:#eeeeee">
                          <tr><td><input type="text" class="form-control" id="newfname<%Response.Write(userReader["idno"]);%>" value="<%Response.Write(userReader["fname"]);%>"></td><tr>
                          <tr><td><input type="text" class="form-control" id="newlname<%Response.Write(userReader["idno"]);%>" value="<%Response.Write(userReader["lname"]);%>"></td><tr>
                          <tr><td>
                                        <select id="newrole<%Response.Write(userReader["idno"]);%>" style="border:0.5px solid #888888" class="form-control">
                                        <option><%Response.Write(userReader["role"]);%></option>
                                        <option>System Administrator</option>
                                        <option>Auditor General</option>
                                        <option>Special Assistant to Auditor General</option>
                                       <option>Deputy Auditor General</option>
                                       <option>PAC Member</option>
                                         <option>Audit Director</option>
                                      <option>Data Encoder</option>
                                        </select>
                          </td></tr>
                          <tr><td>መለያ ስም: <%Response.Write(userReader["username"]);%></td></tr>
                          <tr><td><input type="password" class="form-control" placeholder="የይለፍ ቃል" id="newpass<%Response.Write(userReader["idno"]);%>" value="<%Response.Write(userReader["fname"]);%>"></td><tr>
                          <tr><td><input type="password" class="form-control" placeholder="የይለፍ ቃል ያረጋግጡ" id="newcpass<%Response.Write(userReader["idno"]);%>" value="<%Response.Write(userReader["fname"]);%>"></td><tr>
                          <tr><td><button class="btn btn-primary" onclick="savechangesofuser(<%Response.Write(userReader["idno"]);%>)">ለውጦችን መዝግብ</button><span id="errormsg<%Response.Write(userReader["idno"]);%>"></span></td></tr>
                         </table></center>
                         </td>
                         </tr>
                     <%
                   }
                   con.Close(); 
               }
               catch (Exception ex) {
                   con.Close();
               }
                         try
                         {
                             con.Open();
                             SqlDataReader userReader = new SqlCommand("select org_Table.orgName,org_Table.orgId,auditeeuser_Table.pass,auditeeuser_Table.status,auditeeuser_Table.uname from org_Table INNER JOIN auditeeuser_Table ON org_Table.orgId=auditeeuser_Table.orgId where orgName like N'%" + fname + "%' order by orgName asc", con).ExecuteReader();
                
                             
                             while (userReader.Read()) { 
                          %>
                         <tr><th style="width:150px;" colspan="2"><%Response.Write(userReader["orgName"]);%></th><td>Auditee</td><td style="width:30px"><button class="btn btn-link" onclick="$('#hidrowaud<%Response.Write(userReader["orgId"]);%>').slideToggle();"><span class="glyphicon glyphicon-pencil"></span>edit</button></td><td id="disbutaud<%Response.Write(userReader["orgId"]);%>" style="width:30px;">
                         <%if (userReader["status"].ToString() == "active")
                           {%>
                         <button style="color:red" class="btn btn-link" onclick="disableauduser(<%Response.Write(userReader["orgId"]);%>,'deactive')"><span class="glyphicon glyphicon-off"></span>Disable</button>
                         <%}
                           else
                           { %>
                          <button style="color:#23ff23" class="btn btn-link" onclick="disableauduser(<%Response.Write(userReader["orgId"]);%>,'active')"><span class="glyphicon glyphicon-check"></span>Enable</button>
                         <%} %>
                          </td></tr>
                         <tr style="display:none;" id="hidrowaud<%Response.Write(userReader["orgId"]);%>">
                         <td colspan="5"><center>
                         <table class="table table-bordered table-condensed table-striped" border="1" style="width:80%;background-color:#eeeeee">
                          <tr><td>
      <select class="form-control" id="selauditee<%Response.Write(userReader["orgId"]);%>" style="border:1px solid black">
      <option value="<%Response.Write(userReader["orgId"]);%>"><%Response.Write(userReader["orgName"]);%></option>
    
      <%try
        {
            con2.Open();
            SqlDataReader auditeeReader = new SqlCommand("select * from org_Table", con2).ExecuteReader();
            while (auditeeReader.Read()) { 
            %>
              <option value="<%Response.Write(auditeeReader["orgId"]);%>"><%Response.Write(auditeeReader["orgName"]);%></option>
             <%
            }
            con2.Close();   
        }
        catch (Exception ex) {
            con2.Close();
        }
          
        %>
     </select></td></tr>
                          
                          <tr><td>መለያ ስም: <%Response.Write(userReader["uname"]);%></td></tr>
                          <tr><td><input type="password" class="form-control" placeholder="የይለፍ ቃል" id="newaudpass<%Response.Write(userReader["orgId"]);%>" value="<%Response.Write(userReader["pass"]);%>"></td><tr>
                          <tr><td><input type="password" class="form-control" placeholder="የይለፍ ቃል ያረጋግጡ" id="newaudcpass<%Response.Write(userReader["orgId"]);%>" value="<%Response.Write(userReader["pass"]);%>"></td><tr>
                          <tr><td><button class="btn btn-primary" onclick="savechangesofauditeeuser(<%Response.Write(userReader["orgId"]);%>,'<%Response.Write(userReader["uname"]);%>')">save changes</button><span id="errormsgaud<%Response.Write(userReader["orgId"]);%>"></span></td></tr>
                         </table></center>
                         </td>
                         </tr>
                     <%
                             }
                             con.Close();
                         }
                         catch (Exception ex) {
                             con.Close();
                             Response.Write(ex.Message);
                         }
               
            %>
                  </table></center>
</body>
</html>

  
