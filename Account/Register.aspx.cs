using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Web.UI;
using System.Collections.Generic;
using Website;
using MobilVet.Backend;

public partial class Account_Register : Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] != null)
            Response.Redirect("~/Account/Manage");
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