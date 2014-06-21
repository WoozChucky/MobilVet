<%@ Page Title="Alterar Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Password.aspx.cs" Inherits="Account_Password" Async="true" %>


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
                        <asp:Label ID="Label1" runat="server" AssociatedControlID="CurrentPassword" CssClass="col-md-2 control-label">Password Antiga</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" TextMode="Password" ID="CurrentPassword" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CurrentPassword"
                                CssClass="text-danger" ErrorMessage="O campo da Password Antiga é de preenchimento obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label2" runat="server" AssociatedControlID="NewPassword" CssClass="col-md-2 control-label">Nova Password</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" TextMode="Password" ID="NewPassword" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NewPassword"
                                CssClass="text-danger" ErrorMessage="O campo da Nova Password é de preenchimento obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label3" runat="server" AssociatedControlID="NewPasswordRepeat" CssClass="col-md-2 control-label">Email</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" TextMode="Password" ID="NewPasswordRepeat" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="NewPasswordRepeat"
                                CssClass="text-danger" ErrorMessage="O campo da Password é de preenchimento obrigatório." />
                            <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="NewPasswordRepeat"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="As passwords inseridas não coincidem." />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button ID="Button1" runat="server" OnClick="ChangePassword" Text="Alterar" CssClass="btn btn-default" />
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</asp:Content>

