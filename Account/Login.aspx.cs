using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Web;
using System.Web.UI;
using Website;
using MobilVet.Backend;

public partial class Account_Login : Page
{
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] != null)
                Response.Redirect("~/Account/Manage");
        }

        protected void LogIn(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if(Account.ValidEmail(Email.Text))
                {
                    switch(Account.Login(Email.Text, Password.Text, Response))
                    {
                        case 0:
                            FailureText.Text = "Dados incorrectos ou conta recentemente eliminada.";
                            ErrorMessage.Visible = true;
                            break;
                        case 1:
                            Session["User"] = new WebsiteUser(Email.Text, 1);

                            if (Request.QueryString["ReturnUrl"] != null)
                            {
                                Response.Redirect("~/" + Request.QueryString["ReturnUrl"].ToString());
                            }
                            else
                                Response.Redirect("~/Account/Manage");
                            break;
                        case 2:
                            Session["User"] = new WebsiteUser(Email.Text, 2);

                            if (Request.QueryString["ReturnUrl"] != null)
                            {
                                Response.Redirect("~/" + Request.QueryString["ReturnUrl"].ToString());
                            }
                            else
                                Response.Redirect("~/Account/Manage");
                            break;
                        case 3:
                            Session["User"] = new WebsiteUser(Email.Text, 3);

                            if (Request.QueryString["ReturnUrl"] != null)
                            {
                                Response.Redirect("~/" + Request.QueryString["ReturnUrl"].ToString());
                            }
                            else
                                Response.Redirect("~/Account/Manage");
                            break;
                    }
                }
                else
                {
                    FailureText.Text = "Conta inexistente.";
                    ErrorMessage.Visible = true;
                }
            }
        }
}