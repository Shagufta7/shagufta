using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Calendar;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.SessionState;
using BeforeCellRenderEventArgs = DayPilot.Web.Ui.Events.Navigator.BeforeCellRenderEventArgs;
using CommandEventArgs = DayPilot.Web.Ui.Events.CommandEventArgs;

public partial class StartPage : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["daypilot"].ConnectionString);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }

    protected void Login_Click(object sender, EventArgs e)
    {
        conn.Open();
        Session["Username"] = txtusername.Text;
        Session["Password"] = password.Text;
        
        string Username = txtusername.Text;
        string Password = password.Text;

        SqlCommand cmd = new SqlCommand("SP_Login", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "SP_Login";
        cmd.Parameters.AddWithValue("@Username", Username);
        cmd.Parameters.AddWithValue("@Password", Password);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        SqlDataReader dr = cmd.ExecuteReader();
        DataSet ds = new DataSet();
        if (dr.Read())
        {
            string Username1 = dr["Username"].ToString();
            string Password1 = dr["Passport"].ToString();
            string UserRolls1 = dr["UserRolls"].ToString();

            if (Username == Username1 && Password == Password1  && UserRolls1 == "Public")
            {
                Response.Redirect("Default.aspx");
                return;
            }
            else if (Username == Username1 && Password == Password1 && UserRolls1 == "Doctor")
            {
                Response.Redirect("Doctor.aspx");
                return;
            }
            else if (Username == Username1 && Password == Password1 && UserRolls1 == "Admin")
            {
                Response.Redirect("Manager.aspx");
                return;
            }
        }

        }
    }