<%@ Page Title="Conta" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Manage.aspx.cs" Inherits="Account_Manage" %>
<%@ Import Namespace="MobilVet.Backend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script type = "text/javascript">
        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Tem a certeza que pretende eliminar a sua conta?")) {
                confirm_value.value = "Sim";
            } else {
                confirm_value.value = "Nao";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>

    <h2>
        
        <%: Title %>
        <asp:SqlDataSource ID="ClientSelectDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MobilVetConnection %>" SelectCommand="SELECT DISTINCT [NOME], [MORADA], [CONTACTO], [EMAIL], [BI], [CONTRIBUINTE] FROM [CLIENTE] WHERE ([IDCLIENTE] = @IDCLIENTE)">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="IDCLIENTE" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
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

                        <h4>Dados Pessoais</h4>
                        <hr />                        

                        <p>
                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ClientSelectDataSource" ForeColor="#333333" GridLines="None" Height="35px" Width="39px">
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:BoundField DataField="NOME" HeaderText="Nome" SortExpression="NOME" />
                                    <asp:BoundField DataField="MORADA" HeaderText="Morada" SortExpression="MORADA" />
                                    <asp:BoundField DataField="CONTACTO" HeaderText="Contacto" SortExpression="CONTACTO" />
                                    <asp:BoundField DataField="EMAIL" HeaderText="Email" SortExpression="EMAIL" />
                                    <asp:BoundField DataField="BI" HeaderText="BI" SortExpression="BI" />
                                    <asp:BoundField DataField="CONTRIBUINTE" HeaderText="Contribuinte" SortExpression="CONTRIBUINTE" />
                                </Columns>
                                <EditRowStyle BackColor="#999999" />
                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#F7F6F3" Width="1000" ForeColor="#333333" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                            </asp:GridView>
                        </p>

                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button ID="Change" OnClick="Change_Click" runat="server" Text="Alterar" CssClass="btn btn-default" />&nbsp;
                                <asp:Button ID="Delete" OnClick="Delete_Click" OnClientClick="Confirm()" runat="server" Text="Eliminar Conta" CssClass="btn btn-default" />&nbsp;
                                <asp:Button ID="Button3" OnClick="Password_Click" runat="server" Text="Password" CssClass="btn btn-default" />
                            </div>
                        </div><br />

                        <h4>Animais</h4>
                        <hr />   

                        <%
                            WebsiteUser Op = (WebsiteUser)Session["User"];
                            Animal.LoadSimpleList(Op.ClientID, Response); 
                        %>

                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button ID="Button1" OnClick="NewAnimal" runat="server" Text="Adicionar" CssClass="btn btn-default" />
                                 <asp:Button ID="Button4" OnClick="AnimalListing" runat="server" Text="Visualizar" CssClass="btn btn-default" />
                            </div>
                        </div><br />

                        <h4>Consultas</h4>
                        <hr />   

                        <div class="form-group">

                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button ID="Button2" runat="server" Text="Visualizar" OnClick="Button2_Click" CssClass="btn btn-default" />
                            </div>

                        </div>
                        

                    </div>
                    
                </asp:PlaceHolder>
                
                
                
            </section>
        </div>
    </div>

</asp:Content>
