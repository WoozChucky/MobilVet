<%@ Page Title="Administração - Veículos" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Vehicles.aspx.cs" Inherits="Admin_Vehicles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:MobilVetConnection %>" DeleteCommand="DELETE FROM [VEICULOS] WHERE [IDVEICULO] = @original_IDVEICULO AND [MARCA] = @original_MARCA AND [MODELO] = @original_MODELO AND [EMUSO] = @original_EMUSO" InsertCommand="INSERT INTO [VEICULOS] ([MARCA], [MODELO], [EMUSO]) VALUES (@MARCA, @MODELO, @EMUSO)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [VEICULOS] ORDER BY [MARCA], [MODELO]" UpdateCommand="UPDATE [VEICULOS] SET [MARCA] = @MARCA, [MODELO] = @MODELO, [EMUSO] = @EMUSO WHERE [IDVEICULO] = @original_IDVEICULO AND [MARCA] = @original_MARCA AND [MODELO] = @original_MODELO AND [EMUSO] = @original_EMUSO">
            <DeleteParameters>
                <asp:Parameter Name="original_IDVEICULO" Type="Int32" />
                <asp:Parameter Name="original_MARCA" Type="String" />
                <asp:Parameter Name="original_MODELO" Type="String" />
                <asp:Parameter Name="original_EMUSO" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="MARCA" Type="String" />
                <asp:Parameter Name="MODELO" Type="String" />
                <asp:Parameter Name="EMUSO" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="MARCA" Type="String" />
                <asp:Parameter Name="MODELO" Type="String" />
                <asp:Parameter Name="EMUSO" Type="Int32" />
                <asp:Parameter Name="original_IDVEICULO" Type="Int32" />
                <asp:Parameter Name="original_MARCA" Type="String" />
                <asp:Parameter Name="original_MODELO" Type="String" />
                <asp:Parameter Name="original_EMUSO" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
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

                        <h4>Lista de Veículos</h4>

                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="IDVEICULO" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="IDVEICULO" HeaderText="IdVeiculo" InsertVisible="False" ReadOnly="True" SortExpression="IDVEICULO" />
                                <asp:BoundField DataField="MARCA" HeaderText="Marca" SortExpression="MARCA" />
                                <asp:BoundField DataField="MODELO" HeaderText="Modelo" SortExpression="MODELO" />
                                <asp:BoundField DataField="EMUSO" HeaderText="EmUso" SortExpression="EMUSO" />
                                <asp:CommandField ButtonType="Button" CancelText="Cancelar" CausesValidation="False" DeleteText="Apagar" EditText="Editar" HeaderText="Opções" InsertText="Inserir" NewText="Novo" SelectText="Selecionar" ShowDeleteButton="True" ShowEditButton="True" ShowHeader="True" ShowInsertButton="False" UpdateText="Actualizar" />
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

                        <%
                        if(GridView1.Rows.Count == 0)
                            {
                                Response.Write("<p>Não existem veículos a apresentar.</p>");
                            }
                        %>
                        <hr />    
                        
                        <h4>Adicionar Veículo</h4>
                        
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
                            <asp:Label runat="server" AssociatedControlID="Modelo" CssClass="col-md-2 control-label">Modelo</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="Modelo" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Modelo"
                                    CssClass="text-danger" ErrorMessage="O campo do Modelo é de preenchimento obrigatório." />
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
