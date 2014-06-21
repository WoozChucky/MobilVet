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
using System.Collections.Specialized;
using MobilVet.Backend;
using Website;
using Microsoft.Owin.Security;

public partial class Veterinary_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["User"] == null)
            Response.Redirect("~/Account/Login?ReturnUrl=Veterinary/");

        WebsiteUser Op = (WebsiteUser)Session["User"];

        if (Op.Level == 1)
            Response.Redirect("~/Account/");
        else if (Op.Level == 3)
            Response.Redirect("~/Admin/");
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string value = e.Row.Cells[3].Text;

            if (value == "0")
            {
                e.Row.Cells[3].Text = "Não";
            }
            else if (value == "1")
            {
                e.Row.Cells[3].Text = "Sim";
            }
        }
    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        WebsiteUser Op = (WebsiteUser)Session["User"];
        GridViewRow linha = GridView1.Rows[e.RowIndex];

        UInt32 consultID = Convert.ToUInt32(GridView1.Rows[e.RowIndex].Cells[0].Text);
        UInt32 newStatus = Convert.ToUInt32(((TextBox)linha.Cells[4].Controls[0]).Text);

        successMessage.Visible = true;
        switch (newStatus)
        {

            case 1: //Espera Deslocamento
                Message.Text = (Core.UseVehicle(consultID, Op.ClientID, ref e));
                break;
            case 2: //Espera Progresso
                 Message.Text = (Core.UpdateConsult(consultID, newStatus, ref e));
                break;
            case 3: //Espera Pagamento
                 Message.Text = (Core.UpdateConsult(consultID, newStatus, ref e));
                break;
            case 4: //Completo
                Message.Text = (Core.UpdateConsult(consultID, newStatus, ref e));
                break;
            default:
                e.Cancel = true;
                Message.Text = "Estado de consulta inválido!";
                successMessage.Visible = true;
                break;
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Veterinary/Clinic");
    }
}