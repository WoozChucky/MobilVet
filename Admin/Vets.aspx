<%@ Page Title="Administração - Veterinários" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Vets.aspx.cs" Inherits="Admin_Vets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>
        <%: Title %>
    </h2>
    <asp:SqlDataSource ID="ClientsSQLDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MobilVetConnection %>"
         UpdateCommand="Update [VETERINARIO] SET NOME=@NOME,MORADA=@MORADA,ESPECIALIDADE=@ESPECIALIDADE,CONTACTO=@CONTACTO,EMAIL=@EMAIL WHERE IDVETERINARIO=@IDVETERINARIO"
         SelectCommand="SELECT DISTINCT [NOME], [MORADA], [ESPECIALIDADE], [CONTACTO], [EMAIL], [IDVETERINARIO] FROM [VETERINARIO] ORDER BY [NOME], [ESPECIALIDADE]"
         OnUpdated="ClientsSQLDataSource_Updated">
    </asp:SqlDataSource>

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

                        <h4>Lista de Clientes</h4>

                        <%
                        if(GridView1.Rows.Count == 0)
                            {
                                Response.Write("<p>Não há veterinários a apresentar.</p>");
                            }
                        %>

                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="IDVETERINARIO" DataSourceID="ClientsSQLDataSource" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="NOME" HeaderText="NOME" SortExpression="NOME" />
                                <asp:BoundField DataField="MORADA" HeaderText="MORADA" SortExpression="MORADA" />
                                <asp:BoundField DataField="ESPECIALIDADE" HeaderText="ESPECIALIDADE" SortExpression="ESPECIALIDADE" />
                                <asp:BoundField DataField="CONTACTO" HeaderText="CONTACTO" SortExpression="CONTACTO" />
                                <asp:BoundField DataField="EMAIL" HeaderText="EMAIL" SortExpression="EMAIL" />
                                <asp:BoundField DataField="IDVETERINARIO" HeaderText="IDVETERINARIO" InsertVisible="False" ReadOnly="True" SortExpression="IDVETERINARIO" />
                                <asp:CommandField ShowEditButton="True" ButtonType="Button" CancelText="Cancelar" CausesValidation="False" DeleteText="Apagar" EditText="Editar" InsertText="Inserir" NewText="Novo" SelectText="Selecionar" UpdateText="Actualizar" />
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

                        <hr />    
                        
                        <h4>Adicionar Veterinário</h4>
                        
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="ErrorMessage" />
                        </p> 

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
                            <asp:Label runat="server" AssociatedControlID="Idade" CssClass="col-md-2 control-label">Idade</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="Idade" TextMode="Number" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Idade"
                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="O campo da Idade é de preenchimento obrigatório." />
                                <asp:RangeValidator runat="server" Type="Integer" ControlToValidate="Idade" MaximumValue="125" MinimumValue="016" ErrorMessage="Idade inválida" />
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
                            <asp:Label runat="server" AssociatedControlID="Especialidade" CssClass="col-md-2 control-label">Especialidade</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="Especialidade" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Especialidade"
                                    CssClass="text-danger" ErrorMessage="O campo da Especialidade é de preenchimento obrigatório." />
                           </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button ID="Button1" runat="server" OnClick="CreateVet_Click" Text="Adicionar" CssClass="btn btn-default" />
                            </div>
                        </div>
                     </div>   
                    
                </asp:PlaceHolder>
            </section>
        </div>
    </div>

</asp:Content>
