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

    <%
            try
            {
                string extdisablingrecomids = "";
              
               
                con.Open();
                SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where recomId=" + int.Parse(Request["recomId"]) + " order by recomId desc", con).ExecuteReader();
                while (recomreader.Read())
                {
                    
                    if (recomreader["status"].ToString() == "1" || recomreader["status"].ToString() == "3") {
                        extdisablingrecomids += recomreader["recomId"] + ",";
                    }
                    if ((int)recomreader["status"] == 1)
                    {
        %>
       
        <%
                }
                else if ((int)recomreader["status"] == 2)
                {
        %>
       
        <%
                }
                else
                {
        %>
       
        <%
                }
        %>
        <tr style="display:none;background-color:#eeeeee" id="hidrecom<%Response.Write(recomreader["recomId"]);%>">
            <td colspan="5">
                <center>
                    <table class="table table-responsive table-condenced table-hover" style="width: 90%;">
                        
                     
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
                         <td><textarea class="form-control" id="ext<%Response.Write(recomreader["recomId"]);%>" style="border:1px solid #552222" placeholder="Write extent of status of recommendation here.."><%Response.Write(recomreader["statusExtent"]);%></textarea>
                         <input type="hidden" id="potsav<%Response.Write(recomreader["recomId"]);%>" value="<%Response.Write(recomreader["potSaving"]);%>">
                         </td></tr>

                       
                       
                    </table>
                </center>
            </td>
        </tr>
        <%
            }
            con.Close();
            %>
            <input type="hidden" value="<%Response.Write(extdisablingrecomids);%>" id="extdisrecom">
            <%
        }
        catch (Exception ex)
        {
            Response.Write(ex.StackTrace);
        }
        %>
        
    </table>
    <script>
        var extdisrecom = document.getElementById("extdisrecom").value;
        var recomidarray = new Array();
        recomidarray = extdisrecom.split(",");
        for (var i = 0; i < recomidarray.length - 1; i++) {
            $("#extrecom" + recomidarray[i]).slideUp(0);
        }
    </script>
</body>
</html>
