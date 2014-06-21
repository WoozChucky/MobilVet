<%@ Page Title="Animais" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Animal_Default" %>
<%@ Import Namespace="MobilVet.Backend" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>

    <div class="row">
        <% 
            WebsiteUser Op = (WebsiteUser)Session["User"];
            LoadAnimals(Op.ClientID); 
        %>
    </div>
</asp:Content>