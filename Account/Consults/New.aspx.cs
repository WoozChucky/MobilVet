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

public partial class Account_Consults_New : System.Web.UI.Page
{
    protected String SuccessMessage
    {
        get;
        set;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
            Response.Redirect("~/Account/Login?ReturnUrl=Account/Consults/New");

        WebsiteUser Op = (WebsiteUser)Session["User"];

        if (Op.Level == 2)
            Response.Redirect("~/Veterinary/");
        else if (Op.Level == 3)
            Response.Redirect("~/Admin/");

        if(Op.HasAnimals())
            Core.LoadAnimals(AnimalList, Op.ClientID);
        else
        {
            Response.Redirect("~/Account/Consults");
        }
    }
    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        Dia.Text = Calendar1.SelectedDate.Day + "/" + Calendar1.SelectedDate.Month + "/" + Calendar1.SelectedDate.Year;
        DateTime dt = DateTime.Now;

        if(Calendar1.SelectedDate.Day == dt.Day)
        {
            Dia.Text = Calendar1.SelectedDate.Day + "/" + Calendar1.SelectedDate.Month + "/" + Calendar1.SelectedDate.Year;
            return;
        }
        if(DateTime.Parse(Dia.Text) < dt )
        {
            SuccessMessage = "Impossível fazer marcações para essa data.";
            successMessage.Visible = true;
            Dia.Text = "";
        }
        else
        {
            Dia.Text = Calendar1.SelectedDate.Day + "/" + Calendar1.SelectedDate.Month + "/" + Calendar1.SelectedDate.Year;
        }       
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if(Page.IsValid && Urgente.SelectedValue != "-1")
        {
            DateTime dt = DateTime.Now; 
            if(dt > DateTime.Parse(Dia.Text + " " + Horas.Text))
            {
                SuccessMessage = "Impossível fazer marcações para essa data.";
                successMessage.Visible = true;
                return;
            }
            if (DateTime.Parse(Dia.Text + " " + Horas.Text).Hour < DateTime.Parse(Dia.Text + "  09:00 AM").Hour || DateTime.Parse(Dia.Text + " " + Horas.Text).Hour > DateTime.Parse(Dia.Text + "  5:00 PM").Hour)
            {
                SuccessMessage = "Impossível fazer marcações para essa horas. As consultas sao efectuadas das 9 da manhã às 5 da tarde.";
                successMessage.Visible = true;
                return;
            }

            WebsiteUser Op = (WebsiteUser)Session["User"];

            SuccessMessage = Core.RegisterConsult(Dia.Text + " " + Horas.Text, Convert.ToUInt32(AnimalList.SelectedValue), Convert.ToUInt32(Urgente.SelectedValue), Op.Address, Op.ClientID, Obs.Text);
            successMessage.Visible = true;
            
        }
        else
        {
            SuccessMessage = "Occorreu um erro ao tentar validar a marcação.";
            successMessage.Visible = true;
        }
    }
    protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
    {
        if (e.Day.Date.DayOfWeek == DayOfWeek.Saturday || e.Day.Date.DayOfWeek == DayOfWeek.Sunday)
        {
            e.Day.IsSelectable = false;
            e.Cell.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Account/Consults");
    }
}