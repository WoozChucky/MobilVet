<%@ Page Title="Editar Conta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="EditAccount.aspx.cs" Inherits="Account_EditAccount" Async="true" %>


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
                        <asp:Label ID="Label6" runat="server" AssociatedControlID="Nome" CssClass="col-md-2 control-label">Nome</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Enabled="false" ID="Nome" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="Nome"
                                CssClass="text-danger" ErrorMessage="O campo do Nome é de preenchimento obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" AssociatedControlID="Contacto" CssClass="col-md-2 control-label">Contacto</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Contacto" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Contacto"
                                CssClass="text-danger" ErrorMessage="O campo do Contacto é de preenchimento obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label2" runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Email</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Enabled="false" ID="Email" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Email" CssClass="text-danger" ErrorMessage="O campo do Email é de preenchimento obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label3" runat="server" AssociatedControlID="Morada" CssClass="col-md-2 control-label">Morada</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Morada" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="Morada" CssClass="text-danger" ErrorMessage="O campo da Morada é de preenchimento obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label4" runat="server" AssociatedControlID="BI" CssClass="col-md-2 control-label">Cartão Cidadão</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="BI" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="BI" CssClass="text-danger" ErrorMessage="O campo do Cartão de Cidadão é de preenchimento obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label5" runat="server" AssociatedControlID="Contribuinte" CssClass="col-md-2 control-label">Contribuinte</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Contribuinte" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="Contribuinte" CssClass="text-danger" ErrorMessage="O campo do Contribuinte é de preenchimento obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button ID="SaveData" runat="server" OnClick="SaveData_Click" Text="Guardar Alterações" CssClass="btn btn-default" />
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</asp:Content>

