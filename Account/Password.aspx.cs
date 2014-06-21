using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MobilVet.Backend;

public partial class Account_Password : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
            Response.Redirect("~/Account/Login?ReturnUrl=Account/Password");

        WebsiteUser Op = (WebsiteUser)Session["User"];

        if (Op.Level == 2)
            Response.Redirect("~/Veterinary/");
        else if (Op.Level == 3)
            Response.Redirect("~/Admin/");
        
    }
    protected void ChangePassword(object sender, EventArgs e)
    {
        WebsiteUser Op = (WebsiteUser)Session["User"];

        if (IsValid)
        {
            if (SEM.Encrypt(CurrentPassword.Text, Account.Email2Hash(Op.Email)) == Account.Email2EncryptedPassword(Op.Email))
            {
                if (SEM.Encrypt(CurrentPassword.Text, Account.Email2Hash(Op.Email)) != SEM.Encrypt(NewPassword.Text, Account.Email2Hash(Op.Email)))
                {
                    Op.EncryptedPassword = SEM.Encrypt(NewPassword.Text, Account.Email2Hash(Op.Email));
                    if(Op.SaveChangesToDatabase())
                    {
                        FailureText.Text = "Password alterada com sucesso. Por favor volte a fazer login.";
                        ErrorMessage.Visible = true;
                        Session["User"] = new WebsiteUser(Op.Email, 1);
                        Response.AddHeader("REFRESH", "5;URL=Logout");
                    }
                    else
                    {
                        FailureText.Text = "Erro desconhecido.";
                        ErrorMessage.Visible = true;
                    }
                }
                else
                {
                    FailureText.Text = "Password actual nao pode ser igual à nova.";
                    ErrorMessage.Visible = true;
                }
            }
            else
            {
                FailureText.Text = "Password actual incorrecta.";
                ErrorMessage.Visible = true;
            }
        }
    }
}