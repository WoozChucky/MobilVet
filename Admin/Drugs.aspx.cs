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

public partial class Admin_Drugs : System.Web.UI.Page
{
    protected String SuccessMessage
    {
        get;
        set;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
            Response.Redirect("~/Account/Login?ReturnUrl=Admin/Drugs");

        WebsiteUser Op = (WebsiteUser)Session["User"];

        if (Op.Level != 3)
            Response.Redirect("~/Default");

        if (!IsPostBack)
            successMessage.Visible = false;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            successMessage.Visible = true;
            if (Core.RegisterDrug(Marca.Text, Nome.Text, Dose.Text, Principio.Text, Preco.Text))
            {
                SuccessMessage = "Medicamento registado com sucesso.";
            }
            else
            {
                SuccessMessage = "Erro ao registar medicamento.";
            }
        }
    }
}