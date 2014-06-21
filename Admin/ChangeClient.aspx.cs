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


public partial class Admin_ChangeClient : System.Web.UI.Page
{

    protected String SuccessMessage
    {
        get;
        set;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["ID"] != null)
        {
            if (!Account.ValidEmail(Account.ID2Email(Convert.ToUInt32(Request.QueryString["ID"].ToString()))))
                Response.Redirect("~Admin/Clients");

            if (Session["User"] == null)
                Response.Redirect("~/Account/Login?ReturnUrl=Admin/Clients");

            WebsiteUser Op = (WebsiteUser)Session["User"];

            if (Op.Level != 3)
                Response.Redirect("~/Default");

            if (!IsPostBack)
            {
                WebsiteUser Client = new WebsiteUser(Account.ID2Email(Convert.ToUInt32(Request.QueryString["ID"].ToString())), 1);

                Nome.Text = Client.Username;
                Contacto.Text = Convert.ToString(Client.Contact);
                Email.Text = Client.Email;
                Morada.Text = Client.Address;
                BI.Text = Convert.ToString(Client.CC);
                Contribuinte.Text = Convert.ToString(Client.FiscalNumber);
            }
        }
        else
            Response.Redirect("~/Admin/Clients");
    }

    protected void SaveData_Click(object sender, EventArgs e)
    {
        WebsiteUser Client = new WebsiteUser(Account.ID2Email(Convert.ToUInt32(Request.QueryString["ID"].ToString())), 1);

        Client.Contact = Convert.ToDouble(Contacto.Text);
        Client.Email = Email.Text;
        Client.Address = Morada.Text;
        Client.CC = Convert.ToUInt32(BI.Text);
        Client.FiscalNumber = Convert.ToUInt32(Contribuinte.Text);

        if (Client.SaveChangesToDatabase())
        {
            FailureText.Text = "Dados alterados com sucesso.";
            ErrorMessage.Visible = true;
        }
        else
        {
            FailureText.Text = "Erro ao alterar dados.";
            ErrorMessage.Visible = true;
        }

    }

    protected void Back_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Admin/Clients");
    }

}