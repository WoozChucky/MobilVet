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

public partial class Animal_Animal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["AnimalID"] != null)
        {
            if (Session["User"] == null)
            {
                Response.Redirect("~/Account/Login?ReturnUrl=Animal/Animal?AnimalID=" + Request.QueryString["AnimalID"].ToString());
            }

            WebsiteUser Op = (WebsiteUser)Session["User"];

            if (Animal.Exists(Convert.ToUInt32(Request.QueryString["AnimalID"].ToString())))
            {
                Page.Title = "Animal - " + Animal.Id2Name(Convert.ToUInt32(Request.QueryString["AnimalID"].ToString()));
                Animal Animalito = new Animal(Convert.ToUInt32(Request.QueryString["AnimalID"].ToString()));
                if (Animal.isValidOwner(Op, Convert.ToUInt32(Request.QueryString["AnimalID"].ToString())))
                {
                    if (!IsPostBack)
                        LoadFields(Animalito);
                }
                else
                    Response.Redirect("~/Animal/");
            }
            else
            {
                Response.Redirect("~/Animal/");
            }
        }
        else
            Response.Redirect("~/Animal/");        
    }

    protected void SaveData_Click(object sender, EventArgs e)
    {
        if(ChangeButton.Text == "Alterar Dados")
        {
            ChangeButton.Text = "Guardar Alterações";
            ChangeFieldSecurity(1);
        }
        else
        {
            ChangeButton.Text = "Alterar Dados";
            ChangeFieldSecurity(0);
            
            Animal Animalito = new Animal(Convert.ToUInt32(Request.QueryString["AnimalID"].ToString()));

            Animalito.AnimalID = Convert.ToUInt32(Request.QueryString["AnimalID"].ToString());
            Animalito.Name = Nome.Text;
            Animalito.Race = Raca.Text;
            Animalito.Species = Especie.Text;
            Animalito.Age = Convert.ToUInt32(Idade.Text);
            Animalito.Weight = Convert.ToUInt32(Peso.Text);
            Animalito.Temperature = Convert.ToUInt32(Temperatura.Text);

            Animalito.SaveChangesToDatabase();
        }
    }

    protected void LoadFields(Animal obj)
    {
        Nome.Text = obj.Name;
        Raca.Text = obj.Race;
        Especie.Text = obj.Species;
        Idade.Text = Convert.ToString(obj.Age);
        Peso.Text = Convert.ToString(obj.Weight);
        Temperatura.Text = Convert.ToString(obj.Temperature);
    }

    private void ChangeFieldSecurity(UInt32 token)
    {
        switch(token)
        {
            case 0:
                Nome.Enabled = false;
                Raca.Enabled = false;
                Especie.Enabled = false;
                Idade.Enabled = false;
                Peso.Enabled = false;
                Temperatura.Enabled = false;
                break;
            case 1:
                Nome.Enabled = true;
                Raca.Enabled = true;
                Especie.Enabled = true;
                Idade.Enabled = true;
                Peso.Enabled = true;
                Temperatura.Enabled = true;
                break;
            default:
                break;
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string value = e.Row.Cells[1].Text;

            SQLDatabaseManager db = new SQLDatabaseManager();

            String query = String.Format("SELECT NOME FROM dbo.MEDICAMENTOS WHERE IDMEDICAMENTO='{0}'", value);

            DataTable temp;

            temp = db.GetDataTable(query);

            foreach (DataRow r in temp.Rows)
            {
                e.Row.Cells[1].Text = r["NOME"].ToString();
                break;
            }

        }
    }
}