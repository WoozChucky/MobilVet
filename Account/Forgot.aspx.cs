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

public partial class Account_Forgot : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] != null)
            Response.Redirect("~/Account/Manage");
    }

    protected void Forgot(object sender, EventArgs e)
    {
        String SaltKey = Account.Email2Hash(Email.Text);
        String EncryptedPassword = Account.Email2EncryptedPassword(Email.Text);

        if(SaltKey == null || EncryptedPassword == null)
        {
            FailureText.Text = "Email inválido.";
            return;
        }

        String PlainPassword = SEM.Decrypt(EncryptedPassword, SaltKey);

        if(Mailer.SendMail(Mailer.ForgotPassword(Email.Text ,PlainPassword)))
        {
            FailureText.Text = "Email enviado com sucesso para " + Email.Text;
        }
    }
}