<%@ page language="C#" autoeventwireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body style="color:black !important">
<%
    Response.Cache.SetCacheability(HttpCacheability.NoCache);
    Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
    Response.Cache.SetNoStore();
    if (Request.Cookies["user"].Value == null || Request.Cookies["user"].Value == "")
    {
        Response.Redirect("logout.aspx");
    }
    
     
     
      %>
<table class="table table-condensed table-responsive table-bordered table-striped" style="font-family:Times New Roman;color:black;font-size:15px;  border:2px solid black;">
<tr style="color:black"><th colspan="10" style="font-size:16px;">የኦዲቱ ግኝት እና የማሻሻያ ሃሳብ ዝርዝር</th></tr>
    <% string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
   SqlConnection con2 = new SqlConnection(@conString);
   SqlConnection con3 = new SqlConnection(@conString);
   SqlConnection con4 = new SqlConnection(@conString);
   int auditId = 0;
  
   try
   {
       auditId = int.Parse(Request["auditId"]);
   }
   catch (Exception ex) { 
   }
  
   try
   {
       con.Open();
       SqlDataReader findingreader = new SqlCommand("select * from finding_Table where auditId=" + auditId, con).ExecuteReader();
       int findingcounter = 1;
       while (findingreader.Read()) {
           double totrecvalue = 0;
           con3.Open();
           SqlDataReader recomidreader = new SqlCommand("select recomId from recommendation_Table where findingId=" + (int)findingreader["findingId"], con3).ExecuteReader();
           while (recomidreader.Read()) {
               con4.Open();
               SqlDataReader recvaluereader = new SqlCommand("select recoveredvalue from actiontaken_Table where actionplanId=" +(int)recomidreader["recomId"], con4).ExecuteReader();
               while (recvaluereader.Read())
               {
                   if (recvaluereader["recoveredvalue"].ToString() != "" && recvaluereader["recoveredvalue"].ToString() != "0")
                   {
                       totrecvalue += double.Parse(recvaluereader["recoveredvalue"].ToString());
                   }
               }
               con4.Close();
           }
           con3.Close();
           
           con3.Open();
           string findingtype = "";
           SqlDataReader ftypereader = new SqlCommand("select findingType from findingType_Table where typeId=" + (int)findingreader["findingType"], con3).ExecuteReader();
           while (ftypereader.Read()) {
               findingtype = ftypereader["findingType"].ToString();
           }
           con3.Close();
        %>
        <tr style="background-color:white; border-top:3px solid gray;">
        <th style="width:7%"><b style="font-size:18px">ግኝት <%Response.Write(findingcounter++);%></b></th>
        <td>
        <%string findingname="";
          if (findingreader["findingName"].ToString().Length > 50)
          {
              findingname = findingreader["findingName"].ToString().Substring(0, 50);
          }
          else
          {
              findingname = findingreader["findingName"].ToString();
          }
          %>
          <span id="visf<%Response.Write(findingreader["findingId"]);%>">
           <%Response.Write(findingname);%>
           <p style="color:blue" onclick="$('#visf<%Response.Write(findingreader["findingId"]);%>').slideUp();$('#hidf<%Response.Write(findingreader["findingId"]);%>').slideDown();">...ተጨማሪ አሳይ</p>
          </span>
          <span id="hidf<%Response.Write(findingreader["findingId"]);%>" style="display:none">
           <%Response.Write(findingreader["findingName"]);%>
           <p style="color:blue" onclick="$('#visf<%Response.Write(findingreader["findingId"]);%>').slideDown();$('#hidf<%Response.Write(findingreader["findingId"]);%>').slideUp();">ያነሰ አሳይ</p>
          </span>

      
        </td>
       <td><b style="">የግኝት አይነት:</b><br><%Response.Write(findingtype);%></td><td><%Response.Write("<b>የወረቀት ማጣቀሻ:</b> <br>"+findingreader["pRef"]);%></td><td><%Response.Write("<b>የግኝቱ ምንጭ:</b><br>" + findingreader["source"]+"");%></td>
        <td><b>የተገምጋሚ ድርጅት ምላሽ</b><br></i>
        <%
         string resp="";
           if (findingreader["auditeeResp"].ToString().Length > 50)
           {
                resp = findingreader["auditeeResp"].ToString().Substring(0, 50);
                         }
           else {
               resp = findingreader["auditeeResp"].ToString();
           }
                 %>
                 <span id="visspan<%Response.Write(findingreader["findingId"]);%>">
                 <%Response.Write(resp);%>
                 <p style="color:Blue;"onclick="$('#visspan<%Response.Write(findingreader["findingId"]);%>').slideUp();$('#hidspan<%Response.Write(findingreader["findingId"]);%>').slideDown();">...ተጨማሪ አሳይ</p>
                 </span>
                 <span id="hidspan<%Response.Write(findingreader["findingId"]);%>" style="display:none">
                 <%  Response.Write(findingreader["auditeeResp"] + " <i style='color:blue'>date:" + findingreader["respDate"] + "<br>Response by: " + findingreader["respfname"] + " " + findingreader["resplname"]);
                      %>
                      <p style="color:Blue;"onclick="$('#visspan<%Response.Write(findingreader["findingId"]);%>').slideDown();$('#hidspan<%Response.Write(findingreader["findingId"]);%>').slideUp();">ያነሰ አሳይ</p>
            
                 </span>    
                 </td>    
      <td><b>ትክክለኛዉ የፋይናንስ እሴት (ETB.)</b><br><%Response.Write(double.Parse(findingreader["actualValue"].ToString()).ToString("#,0.00"));%></td><td><b>ግምታዊ የፋይናንስ እሴት( ETB.)</b><br><%Response.Write(double.Parse(findingreader["extraValue"].ToString()).ToString("#,0.00"));%></td><td><b>የተመለሰው የፋይናንስ እሴት (ETB.)</b><br><%Response.Write(totrecvalue.ToString("#,0.00"));%></td><td><b>ያልተመለሰው የፋይናንስ እሴት (ETB.)</b><br><%Response.Write((double.Parse(findingreader["actualValue"].ToString())-totrecvalue).ToString("#,0.00"));%></td></tr>
         <tr><td colspan="10"><center><table class="table table-responsive table-condensed table-bordered table-striped" style="width:98%;">
        <tr style="color:black;font-size:18px;"><th colspan="9">ማሻሻያ ሃሳብ</th></tr>
        <%
           con2.Open();
           SqlDataReader recomreader = new SqlCommand("select * from recommendation_Table where findingId=" + (int)findingreader["findingId"], con2).ExecuteReader();
           int recomcounter = 1;
           while (recomreader.Read()) {
               int recomId=(int)recomreader["recomId"];
               %>
               <tr>
               <%
               if (recomreader["status"].ToString() == "1")
               {
            %>
            <th style="border-top:"><b style="font-size:18px">ማሻሻያ ሃሳብ<%Response.Write(recomcounter++);%></b></th><td style="border-top:"><%Response.Write(recomreader["recomName"]);%></td><td style="border-top:">የማሻሻያ ሃሳቡ ግምታዊ የፋይናንስ እሴት<br><%Response.Write(double.Parse(recomreader["potSaving"].ToString()).ToString("#,0.00"));%></td>
            <td style="border-top:;width:200px;"><u><b>አሁን ያለበት ሁኔታ</b></u><br>
               አልተተገበረም
            </td>
            <%
               }
               else if (recomreader["status"].ToString() == "2")
               { 
                   %>
            <th style="border-top:2"><b style="font-size:18px">ማሻሻያ ሃሳብ <%Response.Write(recomcounter++);%></b></th><td style="border-top:"><%Response.Write(recomreader["recomName"]);%></td><td style="border-top:">የማሻሻያ ሃሳቡ ግምታዊ የፋይናንስ እሴት<br><%Response.Write(recomreader["potSaving"]);%></td>
            <td style="width:200px;border-top:;"><u><b>አሁን ያለበት ሁኔታ </b></u><br>
            በከፊል ተተግብሯል
            </td>
            <%
               }
               else { 
               
             %>
           <th style="border-top:"><b style="font-size:18px">ማሻሻያ ሃሳብ <%Response.Write(recomcounter++);%></b></th><td style="border-top:"><%Response.Write(recomreader["recomName"]);%></td><td style="border-top:">የማሻሻያ ሃሳቡ ግምታዊ የፋይናንስ እሴት<br><%Response.Write(recomreader["potSaving"]);%></td>
            <td style="border-top:;width:200px;"><u><b>አሁን ያለበት ሁኔታ </b></u><br>
            ሙሉ በሙሉ ተተግብሯል
            </td>
            <%
               }
            %>
             <td style="width:200px;border-right:;">
            <b>የሁኔታው መጠን </b><br>
            <%Response.Write(recomreader["statusExtent"]);%>
            </td>
            </tr>
            <tr><td></td><td></td><td></td><td colspan="2"><button class="btn btn-primary" onclick="openstatusofrecom(<%Response.Write(recomreader["recomId"]);%>)">የማሻሻያ ሃሳብ ሁኔታ ለመቀየር እዚህ ጠቅ ያድርጉ</button></td></tr>
            <tr style="background-color:white"><td colspan="5"><center><table class="table table-condensed table-responsive table-bordered table-striped" border="1" style="width:100%">
            <tr style="background-color:;color:black;font-size:18px;border-top:;border-bottom:;"><th colspan="2">የትግበራ ዕቅድ</th></tr>
            <%
               con3.Open();
               SqlDataReader actionplanreader = new SqlCommand("select * from actionPlan_Table where recomId=" + (int)recomreader["recomId"], con3).ExecuteReader();
               while (actionplanreader.Read()) {
                   if (recomreader["status"].ToString() != "3" && actionplanreader["actiondate"].ToString().CompareTo(DateTime.Now.ToString("yyyy-MM-dd")) <= 0)
                   {
                %>
                <tr><td><%Response.Write(actionplanreader["actionplan"]);%></td><td style="width:200px;background-color:">ቀነ-ገደብ:<br><b style="color:blue"><%Response.Write(actionplanreader["actiondate"]);%></b><span style="color:red">ቀነ-ገደቡ አልፏል</span></td></tr>
              
                <%
                   }
                   else { 
                    %>
                <tr><td><%Response.Write(actionplanreader["actionplan"]);%></td><td style="width:200px;background-color:">ቀነ-ገደብ:<br><b style="color:blue"><%Response.Write(actionplanreader["actiondate"]);%></b></td></tr>
                    <%
                   }
                   %>
                   <tr><td colspan="2">
                  <center><table class="table table-responsive table-condensed table-hover table-striped table-bordered" style="width:90%">
                  <tr><th>ተ.ቁ.</th><th>የተወሰደ እርምጃ</th><th>የተመለሰ የፋይናንስ እሴት(ETB.)</th><th>እርምጃ የተወሰደበት ቀን</th></tr>
                  
                   <%
                   con4.Open();
                   int actiontakencounter = 0;
                   SqlDataReader actiontakenreader = new SqlCommand("select * from actiontaken_Table where actionplanId=" + (int)actionplanreader["recomId"], con4).ExecuteReader();
                   while (actiontakenreader.Read()) { 
                      %>
                      <tr><th style="width:15%;"><%Response.Write(++actiontakencounter);%>.</th><td style="width:55%"><%Response.Write(actiontakenreader["actiontaken"]);%></td><td style="width:15%"><%Response.Write(actiontakenreader["recoveredvalue"]);%></td><td style="width:15%"><%Response.Write(actiontakenreader["actiondate"]);%></td></tr>
                      <%           
                   }
                   if (actiontakencounter == 0) {
                       Response.Write("<tr><th colspan='4'>ምንም እርምጃ አልተወሰደም</th></tr>");
                   }
                   con4.Close();
                   %>
                   </table></center></td></tr>
                   <%
               }
               con3.Close();
                 %>
            </table></center></td></tr>
            <%
              
           }
           con2.Close();
         %>
         </table></center></td></tr>
         <%  
       }
         %>
      </td></tr>
         <%  
       con.Close();
   }
   catch (Exception ex) {
       Response.Write(ex.Message);
   }
 %>
 </table>

 <!--****************pop up window***************-->
    <div class="panel"style="position:fixed;top:200px;left:400px;width:600px;height:250px;display:none;z-index:10;border:1px solid #c2c9cb" id="recomstatuswind">
          <div class="panel-footer" style="height:20%;">
          <p style="color:black">የማሻሻያ ሃሳብ ሁኔታን ይለውጡ</p>
          </div>
          <div class="panel-body" id="recomstatus" style="height:60%">
            
          </div>
          <div class="panel-footer" style=";height:20%;text-align:right;">
          <button class="btn-primary" onclick="changestatufofrecom(<%Response.Write(Request["auditId"]);%>)" style="width:100px">ቀጥል</button>
          <button class="btn-primary" style="color:white;width:100px" onclick="$('#recomstatuswind').slideUp();">አቋርጥ</button>
          </div>
         </div>

</body>
</html>
