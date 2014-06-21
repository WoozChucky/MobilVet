<%@ Page Title="Pagamentos" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Payment.aspx.cs" Inherits="Account_Payments_Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

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
                        <h4>Facturação</h4>

                        <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                            <p class="text-danger">
                                <asp:Literal runat="server" ID="FailureText" />
                            </p>
                        </asp:PlaceHolder>
                        <div class="form-group">
                            <asp:Label ID="Label6" runat="server" AssociatedControlID="DataLimite" CssClass="col-md-2 control-label">Data Limite</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" Enabled="false" ID="DataLimite" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label1" runat="server" AssociatedControlID="Metodo" CssClass="col-md-2 control-label">Método Pagamento</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" Enabled="false" ID="Metodo" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label2" runat="server" AssociatedControlID="Montante" CssClass="col-md-2 control-label">Montante</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" Enabled="false" ID="Montante" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label3" runat="server" AssociatedControlID="Movimentacao" CssClass="col-md-2 control-label">Numero Movimentação</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" Enabled="false" ID="Movimentacao" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label4" runat="server" AssociatedControlID="Estado" CssClass="col-md-2 control-label">Estado</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" Enabled="false" ID="Estado" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button ID="Button1"  runat="server" OnClick="Button1_Click" Text="Voltar" CssClass="btn btn-default" />&nbsp;
                            </div>
                        </div>
                        <hr />  
                    </div>
                 </asp:PlaceHolder>
             </section>
         </div>
     </div>
</asp:Content>
