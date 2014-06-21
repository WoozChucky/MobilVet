<%@ Page Title="Adicionar novo Animal" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="NewAnimal.aspx.cs" Inherits="Animal_NewAnimal" %>


<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <h2><%: Title %>.</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="DropDownTipo" CssClass="col-md-2 control-label">Tipo de Animal</asp:Label>
            <div class="col-md-10">
                <asp:DropDownList ID="DropDownTipo" runat="server" CssClass="form-control">
                    <asp:ListItem Selected="True" Value="-1">Escolha uma opção</asp:ListItem>
                    <asp:ListItem Value="1">Doméstico</asp:ListItem>
                    <asp:ListItem Value="2">Pecuária</asp:ListItem>
                </asp:DropDownList>
                <asp:RangeValidator Type="Integer" MaximumValue="2" MinimumValue="1" ControlToValidate="DropDownTipo" CssClass="text-danger" runat="server"
                    ErrorMessage="Selecione o tipo de animal." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Nome" CssClass="col-md-2 control-label">Nome</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Nome" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Nome"
                    CssClass="text-danger" ErrorMessage="O campo do Nome é de preenchimento obrigatório." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Espécie" CssClass="col-md-2 control-label">Espécie</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Espécie" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Espécie"
                    CssClass="text-danger" ErrorMessage="O campo da Espécie é de preenchimento obrigatório." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Raca" CssClass="col-md-2 control-label">Raça</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Raca" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Raca"
                    CssClass="text-danger" ErrorMessage="O campo da Raca é de preenchimento obrigatório." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Idade" CssClass="col-md-2 control-label">Idade</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Idade" TextMode="Number" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Idade"
                    CssClass="text-danger" ErrorMessage="O campo da Idade é de preenchimento obrigatório." />
                <asp:RangeValidator Type="Integer" MaximumValue="100" MinimumValue="0" ControlToValidate="Idade" CssClass="text-danger" runat="server"
                    ErrorMessage="A idade inserida é inválida" />
           </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Peso" CssClass="col-md-2 control-label">Peso (em Kg)</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Peso" TextMode="Number" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Peso"
                    CssClass="text-danger" ErrorMessage="O campo do Peso é de preenchimento obrigatório." />
                <asp:RangeValidator Type="Integer" MaximumValue="200" MinimumValue="1" ControlToValidate="Peso" CssClass="text-danger" runat="server"
                    ErrorMessage="O Peso inserido é inválida" />
           </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Temperatura" CssClass="col-md-2 control-label">Temperatura</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" TextMode="Number" ID="Temperatura" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Peso"
                    CssClass="text-danger" ErrorMessage="O campo da Idade é de preenchimento obrigatório." />
                <asp:RangeValidator Type="Integer" MaximumValue="50" MinimumValue="1" ControlToValidate="Temperatura" CssClass="text-danger" runat="server"
                    ErrorMessage="A Temperatura inserido é inválida" />
           </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="FileUpload1" CssClass="col-md-2 control-label">Foto</asp:Label>
            <div class="col-md-10">
                <asp:FileUpload ID="FileUpload1"  runat="server" />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button ID="Button1" runat="server" OnClick="CreateAnimal" Text="Adicionar" CssClass="btn btn-default" />
            </div>
        </div>
    </div>
</asp:Content>

