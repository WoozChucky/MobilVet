using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MobilVet.Backend;

public partial class Account_Activate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] != null)
            Response.Redirect("~/Account/Manage");

        WebsiteUser Op = (WebsiteUser)Session["User"];

        if (Op.Level == 2)
            Response.Redirect("~/Veterinary/");
        else if (Op.Level == 3)
            Response.Redirect("~/Admin/");

        if(Request.QueryString["Email"] != null)
        {
            Email.Text = Request.QueryString["Email"].ToString();
        }
    }

    protected void Activate(object sender, EventArgs e)
    {
        if (Account.Activate(Email.Text, Code.Text, FailureText))
        {
            FailureText.Text = "Conta activada com sucesso, irá ser reencaminhado para a página de login dentro de momentos.";
            ErrorMessage.Visible = true;
            Response.AddHeader("REFRESH", "5;URL=Login");
        }
        else
        {
            FailureText.Text = "Código de activação ou email errado(s).";
            ErrorMessage.Visible = true;
        }
    }
}