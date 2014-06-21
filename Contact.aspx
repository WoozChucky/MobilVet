<%@ Page Title="Contactos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>
    <h3>A nossa página de contactos</h3>
    <address>
        MobilVet <br />
        Rua Pedro Nunes - Quinta da Nora<br />
        3030-199 COIMBRA <br />
        <abbr title="Telefone">P:</abbr>
        351 239 790 200
    </address>

    <address>
        <strong>Consultas:</strong>   <a href="mailto:Consultas@mobilvet.com">Consultas@mobilvet.com</a><br />
        <strong>Geral:</strong> <a href="mailto:Geral@mobilvet.com">Geral@mobilvet.com</a>
    </address>
    <img src="Content/pict2.jpg" style="align-self:center" />
</asp:Content>
