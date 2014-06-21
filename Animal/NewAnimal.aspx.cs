using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Helpers;
using System.IO;
using MobilVet.Backend;

public partial class Animal_NewAnimal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
            Response.Redirect("~/Account/Login?ReturnUrl=Animal/NewAnimal");
    }

    protected void CreateAnimal(object sender, EventArgs e)
    {
        WebsiteUser Op = (WebsiteUser)Session["User"];
        WebImage photo = null;
        var newFileName = "";
        var imagePath = "";

        if(IsValid)
        {
            photo = WebImage.GetImageFromRequest();
            if(photo != null)
            {
                newFileName = Guid.NewGuid().ToString() + "_" + Path.GetFileName(photo.FileName);
                imagePath = @"Images\" + newFileName;
                photo.Resize(width: 250, height: 300, preserveAspectRatio: true, preventEnlarge: true);
                photo.Save(@"~\" + imagePath);
                ErrorMessage.Visible = true;

                Animal subject = new Animal(Nome.Text, Espécie.Text, Raca.Text, Convert.ToUInt32(Idade.Text.ToString()), Convert.ToUInt32(Peso.Text.ToString()), Convert.ToUInt32(Temperatura.Text.ToString()), imagePath, Op.ClientID, Convert.ToUInt32(DropDownTipo.Text));
                
                switch(Animal.Add(subject))
                {
                        
                    case 0:
                        ErrorMessage.Text = "Erro ao registar novo animal. Por favor verifique se os dados que inseriu são válidos.";
                        break;
                    case 1:
                        ErrorMessage.Text = "O animal foi registdo com sucesso mas houve um problema ao enviar a foto.";
                        break;
                    case 2:
                        ErrorMessage.Text = "Registo efectuado com sucesso.";
                        break;
                    default:
                        ErrorMessage.Text = "Erro desconhecido.";
                        break;
                }

            }
            else
                ErrorMessage.Text = "Foto inválida.";
        }
    }
}