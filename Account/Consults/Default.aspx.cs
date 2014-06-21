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

public partial class Account_Consults_Default : System.Web.UI.Page
{

    protected String SuccessMessage
    {
        get;
        set;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
            Response.Redirect("~/Account/Login?ReturnUrl=Account/Consults/");

        WebsiteUser Op = (WebsiteUser)Session["User"];

        if (Op.Level == 2)
            Response.Redirect("~/Veterinary/");
        else if (Op.Level == 3)
            Response.Redirect("~/Admin/");

        ConsultsSQLDataSource.SelectParameters["IDCLIENTE"].DefaultValue = Convert.ToString(Op.ClientID);
        
    }

    protected void NovaConsulta(object sender, EventArgs e)
    {
        Response.Redirect("~/Account/Consults/New");
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string value = e.Row.Cells[2].Text;

            if (value == "0")
            {
                e.Row.Cells[2].Text = "Não";
            }
            else if (value == "1")
            {
                e.Row.Cells[2].Text = "Sim";
            }

            value = e.Row.Cells[3].Text;

            switch(value)
            {
                case "0":
                    e.Row.Cells[3].Text = "Espera confirmação";
                    e.Row.Cells[4].Visible = false;
                    break;
                case "1":
                    e.Row.Cells[3].Text = "Espera deslocamento";
                    e.Row.Cells[4].Visible = false;
                    break;
                case "2":
                    e.Row.Cells[3].Text = "Em progresso";
                    e.Row.Cells[4].Visible = false;
                    break;
                case "3":
                    e.Row.Cells[3].Text = "Espera Pagamento";
                    HyperLinkField hp = (HyperLinkField)GridView1.Columns[4];
                    GridView1.Columns[4].Visible = true;
                    GridView1.Columns[5].Visible = true;
                    hp.NavigateUrl = String.Format("~/Account/Payments/Payment?PaymentID={0}", e.Row.Cells[5].Text);
                    hp.Text = "Pagar";
                    e.Row.Cells[4].Visible = true;
                    break;
                case "4":
                    e.Row.Cells[3].Text = "Completo";
                    e.Row.Cells[4].Visible = false;
                    break;
            }
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Account/Manage");
    }
}