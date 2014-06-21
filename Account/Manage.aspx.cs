using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using System.Security.Cryptography;
using System.Threading.Tasks;
using System.Data;
using System.Net.Mail;
using System.Net;
using System.Text.RegularExpressions;
using MobilVet.Backend;
using Website;
using Microsoft.Owin.Security;

public partial class Account_Manage : System.Web.UI.Page
{
    protected String SuccessMessage
    {
        get;
        set;
    }
    protected void Page_Load()
    {
        if (Session["User"] == null)
            Response.Redirect("~/Account/Login?ReturnUrl=Account/Manage");

        WebsiteUser Op = (WebsiteUser)Session["User"];

        if (Op.Level == 2)
            Response.Redirect("~/Veterinary/");
        else if (Op.Level == 3)
            Response.Redirect("~/Admin/");

        ClientSelectDataSource.SelectParameters["IDCLIENTE"].DefaultValue = Convert.ToString(Op.ClientID);

    }

    protected void Change_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Account/EditAccount");
    }

    protected void Password_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Account/Password");
    }

    protected void NewAnimal(object sender, EventArgs e)
    {
        Response.Redirect("~/Animal/NewAnimal");
    }

    protected void AnimalListing(object sender, EventArgs e)
    {
        Response.Redirect("~/Animal/");
    }

    protected void Delete_Click(object sender, EventArgs e)
    {
        String confirmValue = Request.Form["confirm_value"];
        if(confirmValue == "Sim")
        {
            WebsiteUser Op = (WebsiteUser)Session["User"];
            Account.Deactivate(Op.Email);
            Session.Abandon();
            Session.Clear();
            SuccessMessage = "Conta eliminada com sucesso. Vai ser redirecionado dentro de 5 segundos.";
            successMessage.Visible = true;
            Response.AddHeader("REFRESH", "5;URL=Login");
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Account/Consults");
    }
}