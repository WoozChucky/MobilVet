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

public partial class Admin_Clients : System.Web.UI.Page
{
    protected String SuccessMessage
    {
        get;
        set;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
            Response.Redirect("~/Account/Login?ReturnUrl=Admin/");

        WebsiteUser Op = (WebsiteUser)Session["User"];

        if (Op.Level != 3)
            Response.Redirect("~/Default");

        if (!IsPostBack)
            successMessage.Visible = false;
    }

    protected void GridView1_RowCommand1(object sender, GridViewCommandEventArgs e)
    {
        LinkButton lnkBtn = (LinkButton)e.CommandSource;
        GridViewRow myRow = (GridViewRow)lnkBtn.Parent.Parent;  // a linha
        GridView myGrid = (GridView)sender; // a gridview
        UInt32 ID = Convert.ToUInt32(myGrid.DataKeys[myRow.RowIndex].Value.ToString()); // o valor da datakey

        if (e.CommandName == "ChangeClient")
        {
            Response.Redirect("~/Admin/ChangeClient?ID=" + ID);
        }
        else if (e.CommandName == "DeleteClient")
        {
            if(Account.Deactivate(Account.ID2Email(ID)))
            {
                SuccessMessage = "Conta bloqueada com sucesso.";
                successMessage.Visible = true;
                Response.Redirect("~/Admin/Clients");
            }
            else
            {
                SuccessMessage = "Erro ao bloquear conta, por favor tente novamente.";
                successMessage.Visible = true;
            }
        }
    }

    protected void CreateUser_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            Account.Register(DropDownTipo, ErrorMessage, UserName.Text, Password.Text, EmailTextBox.Text, Contacto.Text, Morada.Text,
                Sexo.Text, BI.Text, Contribuinte.Text);
        }
    }

    protected void SelectedItemChanged(object sender, EventArgs e)
    {

        switch (DropDownTipo.SelectedValue.ToString())
        {
            case "1":
                BI.Visible = true;
                BILb.Visible = true;
                ReqBI.Enabled = true;
                ReqContribuinte.Enabled = false;
                Contribuinte.Visible = false;
                ContribuinteLb.Visible = false;
                break;
            case "2":
                BI.Visible = false;
                BILb.Visible = false;
                ReqBI.Enabled = false;
                ReqContribuinte.Enabled = true;
                Contribuinte.Visible = true;
                ContribuinteLb.Visible = true;
                break;
            default:
                BI.Visible = false;
                BILb.Visible = false;
                ReqBI.Enabled = false;
                ReqContribuinte.Enabled = false;
                Contribuinte.Visible = false;
                ContribuinteLb.Visible = false;
                break;
        }
    }
}