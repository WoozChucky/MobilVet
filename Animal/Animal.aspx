<%@ Page Title="Animais" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Animal.aspx.cs" Inherits="Animal_Animal" %>
<%@ Import Namespace="MobilVet.Backend" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>

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
                    <asp:ValidationSummary runat="server" CssClass="text-danger" />
                    <div class="form-group">
                        <asp:Label ID="Label6" runat="server" AssociatedControlID="Nome" CssClass="col-md-2 control-label">Nome</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Enabled="false" ID="Nome" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="Nome"
                                CssClass="text-danger" ErrorMessage="O campo do Nome é de preenchimento obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" AssociatedControlID="Raca" CssClass="col-md-2 control-label">Raça</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Enabled="false" ID="Raca" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Raca"
                                CssClass="text-danger" ErrorMessage="O campo da Raça é de preenchimento obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label2" runat="server" AssociatedControlID="Especie" CssClass="col-md-2 control-label">Espécie</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Enabled="false" ID="Especie" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Especie" CssClass="text-danger" ErrorMessage="O campo da Espécie é de preenchimento obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label3" runat="server" AssociatedControlID="Idade" CssClass="col-md-2 control-label">Idade</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Enabled="false" TextMode="Number" ID="Idade" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="Idade" CssClass="text-danger" ErrorMessage="O campo da Idade é de preenchimento obrigatório." />
                            <asp:RangeValidator Type="Integer" MaximumValue="100" MinimumValue="0" ControlToValidate="Idade" CssClass="text-danger" runat="server"
                    ErrorMessage="A idade inserida é inválida" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label4" runat="server" AssociatedControlID="Peso" CssClass="col-md-2 control-label">Peso (em Kg)</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Enabled="false" TextMode="Number" ID="Peso" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="Peso" CssClass="text-danger" ErrorMessage="O campo do Peso é de preenchimento obrigatório." />
                            <asp:RangeValidator Type="Integer" MaximumValue="200" MinimumValue="1" ControlToValidate="Peso" CssClass="text-danger" runat="server"
                    ErrorMessage="O Peso inserido é inválida" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label5" runat="server" AssociatedControlID="Temperatura" CssClass="col-md-2 control-label">Temperatura</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Enabled="false" TextMode="Number" ID="Temperatura" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="Temperatura" CssClass="text-danger" ErrorMessage="O campo da Temperatura é de preenchimento obrigatório." />
                            <asp:RangeValidator Type="Integer" MaximumValue="50" MinimumValue="1" ControlToValidate="Temperatura" CssClass="text-danger" runat="server"
                    ErrorMessage="A Temperatura inserido é inválida" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button ID="ChangeButton" runat="server" OnClick="SaveData_Click" Text="Alterar Dados" CssClass="btn btn-default" />
                        </div>
                    </div>
                    <hr />

                    <h4>Histórico Clínico</h4>

                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="IDHISTORICO" DataSourceID="ClinicHistoryDataSource" ForeColor="#333333" GridLines="None" OnRowDataBound="GridView1_RowDataBound">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="DATA" HeaderText="Data" SortExpression="DATA" />
                            <asp:BoundField DataField="IDMEDICAMENTO" HeaderText="Medicamento" SortExpression="IDMEDICAMENTO" />
                            <asp:BoundField DataField="IDHISTORICO" HeaderText="IDHISTORICO" InsertVisible="False" ReadOnly="True" SortExpression="IDHISTORICO" Visible="False" />
                            <asp:BoundField DataField="IDANIMAL" HeaderText="IDANIMAL" SortExpression="IDANIMAL" Visible="False" />
                            <asp:BoundField DataField="OCORRENCIA" HeaderText="Ocorrencia" SortExpression="OCORRENCIA" />
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
                    <asp:SqlDataSource ID="ClinicHistoryDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MobilVetConnection %>" SelectCommand="SELECT [IDMEDICAMENTO], [IDHISTORICO], [DATA], [IDANIMAL], [OCORRENCIA] FROM [HISTORICOCLINICO] WHERE ([IDANIMAL] = @IDANIMAL) ORDER BY [DATA]">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="0" Name="IDANIMAL" QueryStringField="AnimalID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <hr />

                </div>
            </section>
        </div>
      </div>
</asp:Content>