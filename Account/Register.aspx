<%@ Page Title="Registar nova Conta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Account_Register" %>
<%@ Register TagPrefix="recaptcha" Namespace="Recaptcha" Assembly="Recaptcha" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <h2><%: Title %>.</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="DropDownTipo" CssClass="col-md-2 control-label">Tipo Cliente</asp:Label>
            <div class="col-md-10">
                <asp:DropDownList ID="DropDownTipo" runat="server" CssClass="form-control" OnSelectedIndexChanged="SelectedItemChanged" AutoPostBack="True">
                    <asp:ListItem Selected="True" Value="-1">Escolha uma opção</asp:ListItem>
                    <asp:ListItem Value="1">Particular</asp:ListItem>
                    <asp:ListItem Value="2">Empresa</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="UserName" CssClass="col-md-2 control-label">Nome (Primeiro e Ultimo)</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                    CssClass="text-danger" ErrorMessage="O campo do nome é de preenchimento obrigatório." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                    CssClass="text-danger" ErrorMessage="O campo da password é de preenchimento obrigatório." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Confirmar password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="O campo de confirmação de password é de preenchimento obrigatório." />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="As passwords inseridas não coincidem." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="EmailTextBox" CssClass="col-md-2 control-label">Email</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="EmailTextBox" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="EmailTextBox"
                    CssClass="text-danger" ErrorMessage="O campo do email é de preenchimento obrigatório." />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="EmailTextBox" 
                    CssClass="text-danger" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" ErrorMessage="O email inserido não é válido." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Contacto" CssClass="col-md-2 control-label">Telemovel/Telefone</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" TextMode="Number" ID="Contacto" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Contacto"
                    CssClass="text-danger" ErrorMessage="O campo de contacto é de preenchimento obrigatório." />
           </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Morada" CssClass="col-md-2 control-label">Morada</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Morada" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Morada"
                    CssClass="text-danger" ErrorMessage="O campo da morada é de preenchimento obrigatório." />
           </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Sexo" CssClass="col-md-2 control-label">Sexo</asp:Label>
            <div class="col-md-10">
                <asp:RadioButtonList runat="server" ID="Sexo"> 
                    <asp:ListItem Selected="true" Text="Masculino" Value="M" />
                    <asp:ListItem Text="Feminino" Value="F" />
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Sexo"
                    CssClass="text-danger" ErrorMessage="O campo do sexo é de preenchimento obrigatório." />
           </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" Visible="false" ID="BILb" AssociatedControlID="BI" CssClass="col-md-2 control-label">Cartão de Cidadão</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" Visible="false" TextMode="Number" ID="BI" CssClass="form-control" />
                <asp:RequiredFieldValidator Enabled="false"  ID="ReqBI" runat="server" ControlToValidate="BI"
                    CssClass="text-danger" ErrorMessage="O campo do cartão de cidadão é de preenchimento obrigatório." />
                <asp:CompareValidator runat="server" ControlToValidate="BI" 
                    CssClass="text-danger" Operator="DataTypeCheck" Type="Integer" ErrorMessage="O cartão de cidadão inserido não é válido." />
           </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" Visible="false" ID="ContribuinteLb" AssociatedControlID="Contribuinte" CssClass="col-md-2 control-label">Contribuinte</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" Visible="false" ID="Contribuinte" TextMode="Number" CssClass="form-control" />
                <asp:RequiredFieldValidator Enabled="false" ID="ReqContribuinte" runat="server" ControlToValidate="Contribuinte"
                    CssClass="text-danger" ErrorMessage="O campo do contribuinte é de preenchimento obrigatório." />
                <asp:CompareValidator runat="server" ControlToValidate="Contribuinte" 
                    CssClass="text-danger" Operator="DataTypeCheck" Type="Integer" ErrorMessage="O contribuinte inserido não é válido." />
           </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="recaptcha" CssClass="col-md-2 control-label">Captcha</asp:Label>
            <div class="col-md-10">
                <recaptcha:RecaptchaControl
                    ID="recaptcha"
                    runat="server"
                    PublicKey="6LcQDM4SAAAAAKiGczBiPmRlnDbj1m2epSAvbJlw"
                    PrivateKey="6LcQDM4SAAAAAETr7BQiCU5xpS9DRqxELLMXNiSm" Language="pt" Theme="clean"  />
            </div>
        </div>

        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button ID="Button1" runat="server" OnClick="CreateUser_Click" Text="Registar" CssClass="btn btn-default" />
            </div>
        </div>
    </div>
</asp:Content>

