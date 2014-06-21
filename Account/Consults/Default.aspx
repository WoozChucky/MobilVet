<%@ Page Title="Consultas" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Account_Consults_Default" %>
<%@ Import Namespace="MobilVet.Backend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <h2>
    <%: Title %>
    </h2>

    <asp:SqlDataSource ID="ConsultsSQLDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MobilVetConnection %>" 
        SelectCommand="SELECT [DATA], [LOCAL], [URGENCIA], [ESTADO], [IDPAGAMENTO] FROM [MARCACAO] WHERE ([IDCLIENTE] = @IDCLIENTE) ORDER BY [ESTADO]">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="IDCLIENTE" Type="Int32" />
            </SelectParameters>
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
                        <h4>Histórico de Consultas</h4>
                        <hr />   
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ConsultsSQLDataSource" ForeColor="#333333" GridLines="None" OnRowDataBound="GridView1_RowDataBound">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="DATA" HeaderText="Data" SortExpression="DATA" />
                                <asp:BoundField DataField="LOCAL" HeaderText="Local" SortExpression="LOCAL" />
                                <asp:BoundField DataField="URGENCIA" HeaderText="Urgencia" SortExpression="URGENCIA" />
                                <asp:BoundField DataField="ESTADO" HeaderText="Estado" SortExpression="ESTADO" />
                                <asp:HyperLinkField HeaderText="Pagamento" Text="Link" Visible="False" />
                                <asp:BoundField DataField="IDPAGAMENTO" HeaderText="" SortExpression="IDPAGAMENTO" Visible="False" />
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
                            WebsiteUser Op = (WebsiteUser)Session["User"];
                            Core.LoadConsultas(Op.ClientID, Response);                       
                        %>
                        <br />
                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button OnClick="NovaConsulta" runat="server" Text="Nova Consulta" CssClass="btn btn-default" />&nbsp;
                            </div>
                        </div>
                    </div>

                    <div class="form-horizontal">
                        <h4>Pagamentos e Facturas</h4>
                        <hr />   
                        <% 
                            Core.LoadPayments(Op, Response);
                        %>
                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button ID="Button1"  runat="server" OnClick="Button1_Click" Text="Voltar" CssClass="btn btn-default" />&nbsp;
                            </div>
                        </div>
                    </div>
                    
                </asp:PlaceHolder>
            </section>
        </div>
    </div>

</asp:Content>

