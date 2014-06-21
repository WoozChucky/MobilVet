<%@ Page Title="Veterinário" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Veterinary_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>
        <asp:SqlDataSource ID="ConsultasPendentesDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MobilVetConnection %>" 
            SelectCommand="SELECT [IDMARCACAO], [DATA], [LOCAL], [URGENCIA], [ESTADO], [OBSERVACOES] FROM [MARCACAO] WHERE ([ESTADO] <> @ESTADO) ORDER BY [DATA], [URGENCIA], [ESTADO]" 
            UpdateCommand="UPDATE [MARCACAO] SET [ESTADO] = @ESTADO, [OBSERVACOES] = @OBSERVACOES WHERE [IDMARCACAO] = @IDMARCACAO">
            <SelectParameters>
                <asp:Parameter DefaultValue="4" Name="ESTADO" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="DATA" Type="String" />
                <asp:Parameter Name="LOCAL" Type="String" />
                <asp:Parameter Name="URGENCIA" Type="String" />
                <asp:Parameter Name="ESTADO" Type="Int32" />
                <asp:Parameter Name="OBSERVACOES" Type="String" />
                <asp:Parameter Name="IDMARCACAO" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        
        <%: Title %>
    </h2>

    <div id="InformationArea">
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="text-danger"><asp:Literal ID="Message"  runat="server"></asp:Literal></p>
        </asp:PlaceHolder>
    </div>

    <div class="row">
        <div class="col-md-12">
            <section id="passwordForm">
                <asp:PlaceHolder runat="server" ID="AccountInfo" Visible="true"><br />
                    <div class="form-horizontal">

                        <h4>Consultas Pendentes</h4>

                        <%
                            if (GridView1.Rows.Count == 0)
                                Response.Write("Não existem consultas pendentes.");
                             %>
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="IDMARCACAO" DataSourceID="ConsultasPendentesDataSource" ForeColor="#333333" GridLines="None" OnRowDataBound="GridView1_RowDataBound" OnRowUpdating="GridView1_RowUpdating">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="IDMARCACAO" HeaderText="IdMarcação" InsertVisible="False" ReadOnly="True" SortExpression="IDMARCACAO" />
                                <asp:BoundField DataField="DATA" HeaderText="Data" ReadOnly="True" SortExpression="DATA" />
                                <asp:BoundField DataField="LOCAL" HeaderText="Local" ReadOnly="True" SortExpression="LOCAL" />
                                <asp:BoundField DataField="URGENCIA" HeaderText="Urgencia" ReadOnly="True" SortExpression="URGENCIA" />
                                <asp:BoundField DataField="ESTADO" HeaderText="Estado" SortExpression="ESTADO" />
                                <asp:BoundField DataField="OBSERVACOES" HeaderText="Observações" SortExpression="OBSERVACOES" />
                                <asp:CommandField ButtonType="Button" CancelText="Cancelar" DeleteText="Apagar" EditText="Editar" ShowEditButton="True" UpdateText="Alterar" />
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

                         <b><p>Legenda Estado de Consultas</p> </b>
                        <asp:BulletedList ID="BulletedList1"  runat="server">
                            <asp:ListItem Text="0 - Espera Aceitação"></asp:ListItem>
                            <asp:ListItem Text="1 - Espera Deslocamento"></asp:ListItem>
                            <asp:ListItem Text="2 - Em Progresso"></asp:ListItem>
                            <asp:ListItem Text="3 - Espera Pagamento"></asp:ListItem>
                            <asp:ListItem Text="4 - Completo"></asp:ListItem>
                        </asp:BulletedList>
                        <hr /> 

                        <h4>Histórico Clínico dos Animais</h4>
                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Visualizar" CssClass="btn btn-default" />
                            </div>
                        </div>
                        <hr /> 
                       
                         
                        
                    </div>
                </asp:PlaceHolder>
            </section>
        </div>
    </div>

</asp:Content>
