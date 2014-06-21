<%@ Page Title="Administração - Clientes" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Clients.aspx.cs" Inherits="Admin_Clients" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>
        <%: Title %>
    </h2>
    <asp:SqlDataSource ID="ClientsSQLDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MobilVetConnection %>" SelectCommand="SELECT DISTINCT [IDCLIENTE], [NOME], [MORADA], [CONTACTO], [EMAIL] FROM [CLIENTE] WHERE ([ESTADO] = @ESTADO) ORDER BY [NOME], [MORADA]">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="ESTADO" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IDCLIENTE" DataSourceID="ClientsSQLDataSource" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCommand="GridView1_RowCommand1">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:BoundField DataField="IDCLIENTE" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="IDCLIENTE" />
                                    <asp:BoundField DataField="NOME" HeaderText="Nome" SortExpression="NOME" />
                                    <asp:BoundField DataField="MORADA" HeaderText="Morada" SortExpression="MORADA" />
                                    <asp:BoundField DataField="CONTACTO" HeaderText="Contacto" SortExpression="CONTACTO" />
                                    <asp:BoundField DataField="EMAIL" HeaderText="Email" SortExpression="EMAIL" />
                                    
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" HeaderText="Alterar" Text="Alterar" CausesValidation="False" CommandName="ChangeClient" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />
                                            <asp:LinkButton runat="server" HeaderText="Eliminar" Text="Eliminar" CausesValidation="False" CommandName="DeleteClient" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
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
                                Response.Write("<p>Não há clientes a apresentar.</p>");
                            }
                        %>

                        <div class="col-md-offset-2 col-md-10">
                            
                            
                        </div>

                        <hr />    
                        
                        <h4>Adicionar Cliente</h4>
                        
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="ErrorMessage" />
                        </p> 
                        
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
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button ID="Button1" runat="server" OnClick="CreateUser_Click" Text="Adicionar" CssClass="btn btn-default" />
                            </div>
                        </div>                                         

                    </div>
                    
                </asp:PlaceHolder>
            </section>
        </div>
    </div>

</asp:Content>
