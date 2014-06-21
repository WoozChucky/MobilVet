<%@ Page Title="Histórico Clínico" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Clinic.aspx.cs" Inherits="Veterinary_Clinic" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>      
        <%: Title %>
    </h2>

    <div id="InformationArea">
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="text-danger"><%: SuccessMessage %></p>
        </asp:PlaceHolder>
    </div>

    <div class="row">
        <div class="col-md-12">
            <section id="passwordForm">
                <asp:PlaceHolder runat="server" ID="AccountInfo" Visible="true"><br />
                    <div class="form-horizontal">

                        <h4>Adicionar Histórico Clínico</h4>

                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="AnimalList" CssClass="col-md-2 control-label">Animal</asp:Label>
                            <div class="col-md-10">
                                <asp:DropDownList ID="AnimalList" runat="server" CssClass="form-control">  
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="AnimalList"
                                    CssClass="text-danger" ErrorMessage="O campo do Animal é de preenchimento obrigatório." />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="DrugsList" CssClass="col-md-2 control-label">Medicamento</asp:Label>
                            <div class="col-md-10">
                                <asp:DropDownList ID="DrugsList" runat="server" CssClass="form-control">
                                    <asp:ListItem Selected="True" Text="Nenhum Medicamento" Value="0"></asp:ListItem>  
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="DrugsList"
                                    CssClass="text-danger" ErrorMessage="O campo do Animal é de preenchimento obrigatório." />
                            </div>
                        </div>

                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Ocorrencia" CssClass="col-md-2 control-label">Ocorrencia</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" CssClass="form-control" ID="Ocorrencia" TextMode="MultiLine" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Ocorrencia"
                                    CssClass="text-danger" ErrorMessage="O campo da Ocorrencia é de preenchimento obrigatório." />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Adicionar" CssClass="btn btn-default" />
                            </div>
                        </div>

                        <hr />                        
                         
                        
                    </div>
                </asp:PlaceHolder>
            </section>
        </div>
    </div>

</asp:Content>
