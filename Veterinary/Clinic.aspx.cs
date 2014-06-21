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

public partial class Veterinary_Clinic : System.Web.UI.Page
{
    protected String SuccessMessage
    {
        get;
        set;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
            Response.Redirect("~/Account/Login?ReturnUrl=Veterinary/Clinic");

        WebsiteUser Op = (WebsiteUser)Session["User"];

        if (Op.Level != 2)
            Response.Redirect("~/Default");

        if (!Core.LoadAnimalsInProgress(AnimalList))
            Response.Redirect("~/Veterinary");
        if (!Core.LoadDrugs(DrugsList))
            Response.Redirect("~/Veterinary");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if(Page.IsValid)
        {
            successMessage.Visible = true;
            if(Core.RegisterClinicHistory(AnimalList.SelectedValue, DrugsList.SelectedValue, Ocorrencia.Text))
            {
                SuccessMessage = "Histórico clínico adicionado com sucesso.";
            }
            else
            {
                SuccessMessage = "Erro ao adicionar histórico clínico";
            }
        }
    }
}