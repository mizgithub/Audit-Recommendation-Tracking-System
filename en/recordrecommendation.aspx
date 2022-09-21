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

    <button class="btn btn-link" style="color:#666699" onclick="$('#recomform<%Response.Write(Request["findingId"]);%>').slideToggle();"><h4>
        <span class="glyphicon glyphicon-plus"></span>Add new recommendation</h4></button>
    <table class="table table-responsive table-condensed table-hover table-bordered table-striped" style="border: 2px solid #c2c9cb;display:none" id="recomform<%Response.Write(Request["findingId"]);%>">
        <tr>
            <td colspan="2">
                <textarea class="form-control" id="recom<%Response.Write(Request["findingId"]);%>" placeholder="Write recommendation description here..." rows="4" style="border:1px solid #c2c9cb"></textarea>
            </td>
        </tr>
        <tr>
            <th>
                Potential savings from the recommendation
            </th>
            <td>
                <input type="number" class="form-control" id="potSaving<%Response.Write(Request["findingId"]);%>" placeholder="999000000000.00" style="border:1px solid #c2c9cb">ETB.
            </td>
        </tr>
        <tr>
            <th>
                Current status of recommendation
            </th>
            <td>
                <select class="form-control" id="recomStatus<%Response.Write(Request["findingId"]);%>" style="border:1px solid #c2c9cb" onchange="recomstatuschanged()">
                    <option value="1">Not implemented</option>
                    <option value="2">Partially implemented</option>
                    <option value="3">Fully implemented</option>
                </select>
            </td>
        </tr>
        <tr id="extentrow" style="display:none"><th>Extent of status of recommendation</th>
        <td><textarea class="form-control" id="ext<%Response.Write(Request["findingId"]);%>" style="border:1px solid #c2c9cb" placeholder="Write extent of status of recommendation here.."></textarea></td></tr>
        <tr>
            <td colspan="2">
                <button class="btn btn-primary" onclick="saverecommendation(<%Response.Write(Request["findingId"]);%>)">
                    <b>Save recommendation</b></button>
            </td>
        </tr>
    </table>
    <table class="table table-responsive table-condensed table-hover table-bordered table-striped">
        <tr style="background-color: #c2c9cb; color: black">
            <th colspan="6">
                <span class="glyphicon glyphicon-saved"></span><b>Saved recommendations</b>
            </th>
           
        </tr>
        <%
            string extdisablingrecomids = "";
            try
            {
                
                con.Open();
                int res = (int)new SqlCommand("select count(*) from recommendation_Table where findingId=" + int.Parse(Request["findingId"]), con).ExecuteScalar();
                if (res > 0) {
                   
                 %>
                  <tr><th><%Response.Write(res);%></th><th></th><th>Recommendation</th><th>Potential Saving from the recommendation</th><th>Status</th><th>Extent of status</th></tr>
                 <%
                }
                con.Close();
                con.Open();
                string status = "";
                SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where findingId=" + int.Parse(Request["findingId"]) + " order by recomId desc", con).ExecuteReader();
                while (recomreader.Read())
                {

                    if (recomreader["status"].ToString() == "1")
                    {
                        extdisablingrecomids += recomreader["recomId"] + ",";
                        status = "Not implemented";
                       
                    }
                    else if (recomreader["status"].ToString() == "3")
                    {
                        status = "Fully implemented";
                        extdisablingrecomids += recomreader["recomId"] + ",";
                    }
                    else {
                        status = "Partially implemented";
                    }
                   
        %>
        <tr>
            <td style="border-bottom: 1px solid #c2c9cb">
                <button class="btn btn-link" title="Edit" onclick="$('#hidrecom<%Response.Write(recomreader["recomId"]);%>').slideToggle();">
                    <span class="glyphicon glyphicon-edit"></span></button>
            </td>
             <td style="width:7px; border-bottom: 1px solid #c2c9cb">
                <button class="btn btn-link" title="Delete" onclick="deleterecom(<%Response.Write(recomreader["recomId"]);%>,<%Response.Write(Request["findingId"]);%>)">
                    <span class="glyphicon glyphicon-trash"></span></button>
            </td>
            <td style="border-bottom: 1px solid #c2c9cb">
                <%Response.Write(recomreader["recomName"]);%>
            </td>
            <td style="border-bottom: 1px solid #c2c9cb">
                <%Response.Write(recomreader["potSaving"]);%>
            </td>
            <td style="border-bottom: 1px solid #c2c9cb;">
                <%Response.Write(status);%>
            </td>
             <td style="border-bottom: 1px solid #c2c9cb;">
                <%Response.Write(recomreader["statusExtent"]);%>
            </td>
        </tr>
        <tr style="display:none;background-color:white" id="hidrecom<%Response.Write(recomreader["recomId"]);%>">
            <td colspan="6">
                <center>
                    <table class="table table-responsive table-condenced table-hover" style="width: 90%; border:2px solid #c2c9cb">
                        <tr>
                            <td colspan="2">
                                <textarea class="form-control" id="edrecom<%Response.Write(recomreader["recomId"]);%>" placeholder="Write recommendation description here..." rows="4" style="border:1px solid #c2c9cb"><%Response.Write(recomreader["recomName"]);%></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                Potential savings from the recommendation (ETB.)
                            </th>
                            <td>
                                <input type="number" class="form-control" id="edpotSaving<%Response.Write(recomreader["recomId"]);%>" style="border:1px solid #c2c9cb" placeholder="999000000000.00" value="<%Response.Write(recomreader["potSaving"]);%>">
                            </td>
                        </tr>
                        <tr>
                            <th>
                                Current status of recommendation
                            </th>
                            <td> 
                                <select class="form-control" id="edrecomStatus<%Response.Write(recomreader["recomId"]);%>" style="border:1px solid #552222" onchange="editrecomstatuschanged(<%Response.Write(recomreader["recomId"]);%>)" on>
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

                        <tr id="extrecom<%Response.Write(recomreader["recomId"]);%>"><th>Extent of status of recommendation</th>
                         <td><textarea class="form-control" id="ext<%Response.Write(recomreader["recomId"]);%>" style="border:1px solid #c2c9cb" placeholder="Write extent of status of recommendation here.."><%Response.Write(recomreader["statusExtent"]);%></textarea></td></tr>
                       
                        <tr>
                            <td>
                                <button class="btn btn-primary btn-block" onclick="editrecommendation(<%Response.Write(recomreader["recomId"]);%>,<%Response.Write(Request["findingId"]);%>)">
                                    <b>Save changes</b></button>
                            </td>
                            <td> <button class="btn btn-primary btn-block" onclick="$('#hidrecom<%Response.Write(recomreader["recomId"]);%>').slideToggle();">
                                    <b>Cancel</b></button></td>
                        </tr>
                    </table>
                </center>
            </td>
        </tr>
        <%
            }
            %>
            <input type="hidden" value="<%Response.Write(extdisablingrecomids);%>" id="extdisrecom">
             <script type="text/javascript">
                 var extdisrecom = document.getElementById("extdisrecom").value;

                 var recomidarray = new Array();

                 if (extdisrecom != "") {
                     recomidarray = extdisrecom.split(",");
                     for (var i = 0; i < recomidarray.length - 1; i++) {

                         $("#extrecom" + recomidarray[i]).slideUp(0);
                     }
                 }
       
    </script>
            <%
            con.Close();
            %>
          
           
            <%
        }
        catch (Exception ex)
        {
            Response.Write(ex.StackTrace);
        }
        %>
        
    </table>
    
   
</body>
</html>
