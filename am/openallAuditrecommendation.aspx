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
      
    %>
    <table class="table table-responsive table-condensed table-hover table-bordered table striped" style="background-color:white">
        <tr style="background-color: #559999; color: white">
            <th colspan="4">
                <span class="glyphicon glyphicon-saved"></span><b>Saved recommendations</b>
            </th>
           
        </tr>
        <%
            try
            {
                con.Open();
                int res = (int)new SqlCommand("select count(*) from recommendation_Table where auditId=" + int.Parse(Request.Cookies["auditId"].Value), con).ExecuteScalar();
                if (res > 0) { 
                 %>
                  <tr><th><%Response.Write(res);%></th><th>Recommendation</th><th>Potential Saving from the recommendation</th><th>Status</th></tr>
                 <%
                }
                con.Close();
                con.Open();
                SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where auditId=" + int.Parse(Request.Cookies["auditId"].Value) + " order by recomId desc", con).ExecuteReader();
                while (recomreader.Read())
                {
                    if ((int)recomreader["status"] == 1)
                    {
        %>
        <tr style="background-color: #ffcccc;">
            <td style="width: 10px; border-bottom: 1px solid #552222">
                <button class="btn btn-link" onclick="$('#hidrecom1<%Response.Write(recomreader["recomId"]);%>').slideToggle();">
                    <span class="glyphicon glyphicon-edit"></span>edit</button>
            </td>
            <td style="border-bottom: 1px solid #552222">
                <%Response.Write(recomreader["recomName"]);%>
            </td>
            <td style="border-bottom: 1px solid #552222">
                <%Response.Write(recomreader["potSaving"]);%>
            </td>
            <td style="border-bottom: 1px solid #552222">
                <%Response.Write("Not implemented");%>
            </td>
        </tr>
        <%
                }
                else if ((int)recomreader["status"] == 2)
                {
        %>
        <tr style="background-color: #ffffcc;">
            <td style="border-bottom: 1px solid #552222">
                <button class="btn btn-link" onclick="$('#hidrecom1<%Response.Write(recomreader["recomId"]);%>').slideToggle();">
                    <span class="glyphicon glyphicon-edit"></span>edit</button>
            </td>
            <td style="border-bottom: 1px solid #552222">
                <%Response.Write(recomreader["recomName"]);%>
            </td>
            <td style="border-bottom: 1px solid #552222">
                <%Response.Write(recomreader["potSaving"]);%>
            </td>
            <td style="border-bottom: 1px solid #552222">
                <%Response.Write("Partially implemented");%>
            </td>
        </tr>
        <%
                }
                else
                {
        %>
        <tr style="background-color: #ccffcc;">
            <td style="border-bottom: 1px solid #552222">
                <button class="btn btn-link" onclick="$('#hidrecom1<%Response.Write(recomreader["recomId"]);%>').slideToggle();">
                    <span class="glyphicon glyphicon-edit"></span>edit</button>
            </td>
            <td style="border-bottom: 1px solid #552222">
                <%Response.Write(recomreader["recomName"]);%>
            </td>
            <td style="border-bottom: 1px solid #552222">
                <%Response.Write(recomreader["potSaving"]);%>
            </td>
            <td style="border-bottom: 1px solid #552222">
                <%Response.Write("Full implemented");%>
            </td>
        </tr>
        <%
                }
        %>
        <tr style="display:none;background-color:#eeeeee" id="hidrecom1<%Response.Write(recomreader["recomId"]);%>">
            <td colspan="4">
                <center>
                    <table class="table table-responsive table-condenced table-hover" style="width: 90%; border:2px solid #552222">
                        <tr>
                            <td colspan="2">
                                <textarea class="form-control" id="edrecom1<%Response.Write(recomreader["recomId"]);%>" placeholder="Write recommendation description here..." rows="4" style="border:1px solid #552222"><%Response.Write(recomreader["recomName"]);%></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                Potential savings from the recommendation
                            </th>
                            <td>
                                <input type="number" class="form-control" id="edpotSaving1<%Response.Write(recomreader["recomId"]);%>" style="border:1px solid #552222" placeholder="999000000000.00" value="<%Response.Write(recomreader["potSaving"]);%>">ETB.
                            </td>
                        </tr>
                        <tr>
                            <th>
                                Current status of recommendation
                            </th>
                            <td> 
                                <select class="form-control" id="edrecomStatus1<%Response.Write(recomreader["recomId"]);%>" style="border:1px solid #552222">
                                    <%if((int)recomreader["status"]==1){%>
                                    <option value="1" selected="selected">Not implemented</option>
                                    <option value="2">Partially implemented</option>
                                    <option value="3">Fully implemented</option>
                                    <%}else if((int)recomreader["status"]==2){ %>
                                    <option value="1">Not implemented</option>
                                    <option value="2" selected="selected">Partially implemented</option>
                                    <option value="3">Fully implemented</option>
                                    <%}else{ %>
                                    <option value="1">Not implemented</option>
                                    <option value="2">Partially implemented</option>
                                    <option value="3"  selected="selected">Fully implemented</option>
                                    <%} %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <button class=" btn-primary btn-block" style=" color: white" onclick="editrecommendation2(<%Response.Write(recomreader["recomId"]);%>)">
                                    <b>Save changes</b></button>
                            </td>
                            <td> <button class=" btn-danger btn-block" style="color: white" onclick="$('#hidrecom1<%Response.Write(recomreader["recomId"]);%>').slideToggle();">
                                    <b>Cancel</b></button></td>
                        </tr>
                    </table>
                </center>
            </td>
        </tr>
        <%
            }
            con.Close();
        }
        catch (Exception ex)
        {
            Response.Write(ex.StackTrace);
        }
        %>
    </table>
</body>
</html>
