<%@ Page Title="Sair da Conta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Logout.aspx.cs" Inherits="Account_Logout" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2><%: Title %>.</h2>

    <div class="row">
        <div class="col-md-8">
            <section id="loginForm">
                <div class="form-horizontal">
                    <hr />
                     <p>
                        <asp:Literal runat="server" ID="InfoLabel" />
                    </p>
                </div>
               
            </section>
        </div>
    </div>
</asp:Content>

