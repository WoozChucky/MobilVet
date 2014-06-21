<%@ Page Title="Activar Conta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Activate.aspx.cs" Inherits="Account_Activate" Async="true" %>


<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2><%: Title %>.</h2>

    <div class="row">
        <div class="col-md-8">
            <section id="loginForm">
                <div class="form-horizontal">
                    <hr />
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Email</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Email" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Email"
                                CssClass="text-danger" ErrorMessage="O campo Email é de preenchimento obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label2" runat="server" AssociatedControlID="Code" CssClass="col-md-2 control-label">Código Activação</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Code" CssClass="form-control" /> Código de activação enviado para o endereço de email acima.
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Code" CssClass="text-danger" ErrorMessage="O campo do Código de Activação é de preenchimento obrigatório." />
                        </div>
                        
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button ID="Button1" runat="server" OnClick="Activate" Text="Activar" CssClass="btn btn-default" />
                        </div>
                    </div>
                </div>
                <p>
                    <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Regista-te</asp:HyperLink>
                    se não possuires uma conta.
                </p>
            </section>
        </div>
    </div>
</asp:Content>

