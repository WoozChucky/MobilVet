using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using MobilVet.Backend;

public partial class Account_EditAccount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
            Response.Redirect("~/Account/Login?ReturnUrl=Account/EditAccount");

        if(!IsPostBack)
        {
            WebsiteUser Op = (WebsiteUser)Session["User"];

            if (Op.Level == 2)
                Response.Redirect("~/Veterinary/");
            else if (Op.Level == 3)
                Response.Redirect("~/Admin/");

            Nome.Text = Op.Username;
            Contacto.Text = Convert.ToString(Op.Contact);
            Email.Text = Op.Email;
            Morada.Text = Op.Address;
            BI.Text = Convert.ToString(Op.CC);
            Contribuinte.Text = Convert.ToString(Op.FiscalNumber);
        }
    }
    protected void SaveData_Click(object sender, EventArgs e)
    {
        WebsiteUser Op = (WebsiteUser)Session["User"];

        Op.Contact = Convert.ToDouble(Contacto.Text);
        Op.Email = Email.Text;
        Op.Address = Morada.Text;
        Op.CC = Convert.ToUInt32(BI.Text);
        Op.FiscalNumber = Convert.ToUInt32(Contribuinte.Text);

        if(Op.SaveChangesToDatabase())
        {
            FailureText.Text = "Dados alterados com sucesso.";
            ErrorMessage.Visible = true;
            Session["User"] = new WebsiteUser(Op.Email, 1);
        }
        else
        {
            FailureText.Text = "Erro ao alterar dados.";
            ErrorMessage.Visible = true;
        }
        
    }
}