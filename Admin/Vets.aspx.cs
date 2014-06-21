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

public partial class Admin_Vets : System.Web.UI.Page
{

    protected String SuccessMessage
    {
        get;
        set;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
            Response.Redirect("~/Account/Login?ReturnUrl=Admin/Vets");

        WebsiteUser Op = (WebsiteUser)Session["User"];

        if (Op.Level != 3)
            Response.Redirect("~/Default");

        if (!IsPostBack)
            successMessage.Visible = false;
    }
    protected void ClientsSQLDataSource_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        SuccessMessage = "Veterinário actualizado com sucesso.";
        successMessage.Visible = true;
    }

    protected void CreateVet_Click(object sender, EventArgs e)
    {
        if(Account.ValidEmail(EmailTextBox.Text))
        {
            ErrorMessage.Text = "Email já existe!";
            return;
        }

        if (Account.RegisterVeterinary(UserName.Text, Convert.ToUInt32(Idade.Text), Morada.Text, Especialidade.Text, EmailTextBox.Text, Convert.ToDouble(Contacto.Text), Password.Text))
            ErrorMessage.Text = "Veterinário registado com sucesso.";
        else
            ErrorMessage.Text = "Ocorreu um erro ao registar o veterinario.";
    }
}