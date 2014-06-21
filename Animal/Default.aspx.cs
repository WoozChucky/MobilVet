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

public partial class Animal_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["User"] == null)
        {
            Response.Redirect("~/Account/Login?ReturnUrl=Animal/Default");
        }
    }

    protected void LoadAnimals(UInt32 ClientID)
    {
        SQLDatabaseManager db = new SQLDatabaseManager();

        String query = String.Format("SELECT * FROM dbo.ANIMAL WHERE IDCLIENTE='{0}'", ClientID);

        DataTable temp;
        DataTable temp2;
        String photoPath = null;

        temp = db.GetDataTable(query);

        if(temp.Rows.Count < 1)
        {
            Response.Write("<div class='col-md-4'>");
            Response.Write("<h2>Não existem animais</h2>");
            Response.Write("<p>Pretende <a href='NewAnimal'>adicionar</a> um novo animal ?</p>");
            Response.Write("</div>");
            return;
        }

        foreach (DataRow r in temp.Rows)
        {
            query = String.Format("SELECT * FROM dbo.FOTOS WHERE IDANIMAL='{0}'", r["IDANIMAL"].ToString());
            temp2 = db.GetDataTable(query);
            foreach (DataRow x in temp2.Rows)
            {
                photoPath = x["URL"].ToString();
                break;
            }

            Animal.DrawAnimal(Response, photoPath, r["NOME"].ToString(), r["RACA"].ToString(), Convert.ToUInt32(r["IDADE"].ToString()), Convert.ToUInt32(r["IDANIMAL"].ToString()));
        }
    }
}