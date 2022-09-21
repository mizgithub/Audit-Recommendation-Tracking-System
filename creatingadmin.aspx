<%@ Page Language="C#" AutoEventWireup="true"  %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Security.Cryptography"%>
<%string conString = WebConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
   SqlConnection con = new SqlConnection(@conString);
    try
    {
        string fname = "systemadmin";
        string lname="systemadmin";
        string username = "admin";
        string password = "admin0000";
        string role = "Admin";
        StringBuilder hashpass = new StringBuilder();
        try
        {
            MD5CryptoServiceProvider md5provider = new MD5CryptoServiceProvider();
            byte[] bytes = md5provider.ComputeHash(new UTF8Encoding().GetBytes(password));

            for (int i = 0; i < bytes.Length; i++)
            {
                hashpass.Append(bytes[i].ToString("x2"));
            }
        }
        catch (Exception ex)
        {

        }
        con.Open();
        new SqlCommand("insert into user_Table values('" + username + "','" + hashpass + "','" + role + "','" + fname + "','" + lname + "','active','" + DateTime.Now.ToString("yyyy-MM-dd") + "')", con).ExecuteNonQuery();
        con.Close();
        Response.Write("<b style='font-size:12px;font-family:TimesNewRoman;color:blue'>Default Administrator created successfully With<br>username=" + username + "  and <br>password=" + password + "<br>:<i style='color:red'>It is recommended that After you loged in, create another administrator and disable the Default administrator account</i><br>You can get it in users list with <br>first name="+fname+" and<br> last name="+lname+"<br><u style='color:white'>Remember USERNAME and  PASSWORD <br>YOU CAN NOT GET THIS MESSAGE AGAIN.</u></b>");
    }
    catch (Exception ex) {
        Response.Write("<b style='color:red;fonr-size:14px;font-family:TimesNewRoman;'>Error during creating default system administartor<br><b style='color:blue'>Possible causes<br>.Database May not be exits<br>.connection string is not correct</b></b>");
    }
 %>

