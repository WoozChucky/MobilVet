<%@ Page Title="Marcar Consulta" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="New.aspx.cs" Inherits="Account_Consults_New" %>
<%@ Import Namespace="MobilVet.Backend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

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

                    <asp:ValidationSummary runat="server" CssClass="text-danger" />

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Urgente" CssClass="col-md-2 control-label">Urgência</asp:Label>
                        <div class="col-md-10">
                            <asp:DropDownList ID="Urgente" runat="server" CssClass="form-control">
                                <asp:ListItem Selected="True" Value="-1">Escolha uma opção</asp:ListItem>
                                <asp:ListItem Value="0">Sim</asp:ListItem>
                                <asp:ListItem Value="1">Não</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
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
                        <asp:Label runat="server" AssociatedControlID="Calendar1" CssClass="col-md-2 control-label">Data</asp:Label>
                        <div class="col-md-10">
                            <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="Black" BorderStyle="Solid" CellSpacing="1" DayNameFormat="Short" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="150px" NextPrevFormat="ShortMonth" OnSelectionChanged="Calendar1_SelectionChanged" SelectedDate="05/27/2014 23:58:10" SelectionMode="DayWeekMonth" Width="230px" OnDayRender="Calendar1_DayRender">
                                <DayHeaderStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" Height="8pt" />
                                <DayStyle BackColor="#CCCCCC" />
                                <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="White" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                                <TitleStyle BackColor="#999999" BorderStyle="Solid" Font-Bold="True" Font-Size="12pt" ForeColor="White" Height="12pt" />
                                <TodayDayStyle BackColor="#999999" ForeColor="White" />
                            </asp:Calendar>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Dia" CssClass="col-md-2 control-label">Dia</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Dia" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="AnimalList"
                                CssClass="text-danger" ErrorMessage="O campo do Animal é de preenchimento obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Horas" CssClass="col-md-2 control-label">Horas</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Horas" CssClass="form-control" TextMode="Time"/>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Horas"
                                CssClass="text-danger" ErrorMessage="O campo das Horas é de preenchimento obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Obs" CssClass="col-md-2 control-label">Observações (Opcional)</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" Rows="3" ID="Obs" Columns="3" CssClass="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button ID="Button1"  runat="server" OnClick="Button1_Click" Text="Marcar" CssClass="btn btn-default" />&nbsp;<asp:Button ID="Button2"  runat="server" OnClick="Button2_Click" Text="Voltar" CssClass="btn btn-default" />
                        </div>
                    </div>
                    
                </asp:PlaceHolder>
            </section>
        </div>
    </div>

</asp:Content>

