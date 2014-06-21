<%@ Page Title="Administração - Medicamentos" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Drugs.aspx.cs" Inherits="Admin_Drugs" %>

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

                        <h4>Lista de Medicamentos</h4>

                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="IDMEDICAMENTO" DataSourceID="DrugsDataSource" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="IDMEDICAMENTO" HeaderText="IdMedicamento" InsertVisible="False" ReadOnly="True" SortExpression="IDMEDICAMENTO" />
                                <asp:BoundField DataField="NOME" HeaderText="Nome" SortExpression="NOME" />
                                <asp:BoundField DataField="MARCA" HeaderText="Marca" SortExpression="MARCA" />
                                <asp:BoundField DataField="DOSE" HeaderText="Dose" SortExpression="DOSE" />
                                <asp:BoundField DataField="PRINCIPIO_ACTIVO" HeaderText="Principio Activo" SortExpression="PRINCIPIO_ACTIVO" />
                                <asp:BoundField DataField="PRECO" HeaderText="Preço" SortExpression="PRECO" />
                                <asp:CommandField ButtonType="Button" CancelText="Cancelar" DeleteText="Apagar" EditText="Editar" HeaderText="Acções" InsertText="Inserir" NewText="Novo" ShowDeleteButton="True" ShowEditButton="True" ShowHeader="True" ShowInsertButton="False" UpdateText="Actualizar" CausesValidation="True" />
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>

                        <asp:SqlDataSource ID="DrugsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MobilVetConnection %>" 
                                    DeleteCommand="DELETE FROM [MEDICAMENTOS] WHERE [IDMEDICAMENTO] = @IDMEDICAMENTO" 
                                    InsertCommand="INSERT INTO [MEDICAMENTOS] ([NOME], [MARCA], [DOSE], [PRINCIPIO_ACTIVO], [PRECO]) VALUES (@NOME, @MARCA, @DOSE, @PRINCIPIO_ACTIVO, @PRECO)" 
                                    SelectCommand="SELECT * FROM [MEDICAMENTOS] ORDER BY [DOSE]" 
                                    UpdateCommand="UPDATE [MEDICAMENTOS] SET [NOME] = @NOME, [MARCA] = @MARCA, [DOSE] = @DOSE, [PRINCIPIO_ACTIVO] = @PRINCIPIO_ACTIVO, [PRECO] = @PRECO WHERE [IDMEDICAMENTO] = @IDMEDICAMENTO">
                                    <DeleteParameters>
                                        <asp:Parameter Name="IDMEDICAMENTO" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="NOME" Type="String" />
                                        <asp:Parameter Name="MARCA" Type="String" />
                                        <asp:Parameter Name="DOSE" Type="Double" />
                                        <asp:Parameter Name="PRINCIPIO_ACTIVO" Type="String" />
                                        <asp:Parameter Name="PRECO" Type="Double" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="NOME" Type="String" />
                                        <asp:Parameter Name="MARCA" Type="String" />
                                        <asp:Parameter Name="DOSE" Type="Double" />
                                        <asp:Parameter Name="PRINCIPIO_ACTIVO" Type="String" />
                                        <asp:Parameter Name="PRECO" Type="Double" />
                                        <asp:Parameter Name="IDMEDICAMENTO" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>        

                        <%
                        if(GridView1.Rows.Count == 0)
                            {
                                Response.Write("<p>Não há medicamentos a apresentar.</p>");
                            }
                        %>

                        <hr />    

                        <h4>Adicionar Medicamento</h4>

                        <p class="text-danger">
                            <asp:Literal runat="server" ID="ErrorMessage" />
                        </p> 
                        <asp:ValidationSummary runat="server" CssClass="text-danger" />
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Marca" CssClass="col-md-2 control-label">Marca</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="Marca" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Marca"
                                    CssClass="text-danger" ErrorMessage="O campo da Marca é de preenchimento obrigatório." />
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
                            <asp:Label runat="server" AssociatedControlID="Dose" CssClass="col-md-2 control-label">Dose</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" TextMode="Number" ID="Dose" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Dose"
                                    CssClass="text-danger" ErrorMessage="O campo da Dose é de preenchimento obrigatório." />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Preco" CssClass="col-md-2 control-label">Preço</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="Preco" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Preco"
                                    CssClass="text-danger" ErrorMessage="O campo do Preco é de preenchimento obrigatório." />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Principio" CssClass="col-md-2 control-label">Principio Activo</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" TextMode="MultiLine" ID="Principio" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Principio"
                                    CssClass="text-danger" ErrorMessage="O campo do Principio Activo é de preenchimento obrigatório." />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Adicionar" CssClass="btn btn-default" />
                            </div>
                        </div>
                        
                     </div>   
                    
                </asp:PlaceHolder>
            </section>
        </div>
    </div>

</asp:Content>
