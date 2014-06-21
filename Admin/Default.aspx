<%@ Page Title="Administração" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>
        
        <%: Title %>
    </h2>

    <div id="InformationArea">
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="text-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>

    </div>

    <div class="row">
        <div class="col-md-12">
            <section id="passwordForm">
                <asp:PlaceHolder runat="server" ID="AccountInfo" Visible="true"><br />

                    <div class="form-horizontal">

                        <h4>Gestão Medicamentos</h4>

                        <div class="col-md-offset-2 col-md-10">
                                <asp:Button ID="Button3" runat="server" Text="Visualizar" OnClick="Button3_Click" CssClass="btn btn-default" />
                        </div>

                        <hr />                        

                        <h4>Gestão Viaturas</h4>

                        <div class="col-md-offset-2 col-md-10">
                                <asp:Button ID="Button5" runat="server" Text="Visualizar" OnClick="Button4_Click" CssClass="btn btn-default" />
                        </div>

                        <hr />   

                        <h4>Gestão Utilizadores</h4>

                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button ID="Button1" runat="server" Text="Clientes" OnClick="Button1_Click" CssClass="btn btn-default" />
                                <asp:Button ID="Button2" runat="server" Text="Veterinários" OnClick="Button2_Click" CssClass="btn btn-default" />
                            </div>
                        </div>

                        <hr />  
                        

                    </div>
                    
                </asp:PlaceHolder>
            </section>
        </div>
    </div>

</asp:Content>
