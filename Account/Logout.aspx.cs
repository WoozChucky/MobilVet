using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MobilVet.Backend;

public partial class Account_Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["User"] == null)
        {
            Response.Redirect("~/Account/Login");
        }
        WebsiteUser Op = (WebsiteUser)Session["User"]; 
        InfoLabel.Text = "Logout efectuado com exito. Até à proxima " + Op.Username;
        Session.Abandon();
        Session.Clear();
        Response.AddHeader("REFRESH", "5;URL=Login");
    }
}