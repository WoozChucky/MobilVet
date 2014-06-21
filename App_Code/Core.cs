using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using System.Security.Cryptography;
using System.Threading.Tasks;
using System.Data;
using System.Net.Mail;
using System.Net;
using System.Text.RegularExpressions;
using MobilVet.Backend;
using Website;
using Microsoft.Owin.Security;

/// <summary>
/// Summary description for Core
/// </summary>
public class Core
{
	private Core()
	{	}

    private static SQLDatabaseManager db;

    public static void LoadConsultas(UInt32 IDClient, HttpResponse Response)
    {
        db = new SQLDatabaseManager();

        String query = String.Format("SELECT * FROM dbo.MARCACAO WHERE IDCLIENTE='{0}' AND ESTADO<>'2'", IDClient);

        DataTable temp;

        temp = db.GetDataTable(query);

        if(temp.Rows.Count == 0)
        {
            Response.Write("Não existem consultas agendadas.");
            return;
        }
    }
    public static void LoadAnimals(DropDownList AnimalList, UInt32 ClientID)
    {
        db = new SQLDatabaseManager();

        DataTable temp;
        temp = db.GetDataTable("SELECT IDANIMAL, NOME FROM dbo.ANIMAL WHERE IDCLIENTE='" + ClientID + "'");

        AnimalList.DataSource = temp;
        AnimalList.DataTextField = temp.Columns["NOME"].ToString();
        AnimalList.DataValueField = temp.Columns["IDANIMAL"].ToString();
        AnimalList.DataBind();
    }
    public static String RegisterConsult(String data, UInt32 idAnimal, UInt32 urgencia, String morada, UInt32 idCliente, String obs="")
    {
        db = new SQLDatabaseManager();

        String query = String.Format("SELECT * FROM dbo.MARCACAO WHERE DATA = '{0}'", data);

        DataTable temp;

        temp = db.GetDataTable(query);

        if(temp.Rows.Count > 0)
        {
            return "Já existe uma marcação nessa hora.";
        }

        Dictionary<String, String> InsertData = new Dictionary<String, String>()
            {
                {"DATA", data},
                {"LOCAL", morada},
                {"URGENCIA", Convert.ToString(urgencia)},
                {"IDCLIENTE", Convert.ToString(idCliente)},
                {"IDANIMAL", Convert.ToString(idAnimal)},
                {"ESTADO", "0"},
                {"OBSERVACOES", obs}
            };

        if (db.Insert("dbo.MARCACAO", InsertData))
            return "Marcação efectuada com sucesso.";
        else
            return "Erro ao efectuar marcação.";
    }
    public static String UseVehicle(UInt32 idMarcacao, UInt32 idVet, ref GridViewUpdateEventArgs e)
    {
        db = new SQLDatabaseManager();

        String query = String.Format("SELECT * FROM dbo.VEICULOS WHERE EMUSO = '0'");

        DataTable temp;

        temp = db.GetDataTable(query);

        if (temp.Rows.Count == 0)
        {
            e.Cancel = true;
            return "Não existem veículos disponíveis.";
        }

        UInt32 avaiableCar = 0;

        foreach(DataRow r in temp.Rows)
        {
            avaiableCar = Convert.ToUInt32(r["IDVEICULO"].ToString());
            break;
        }

        query = String.Format("UPDATE dbo.VEICULOS SET EMUSO='{0}' WHERE IDVEICULO='{1}'", idMarcacao, avaiableCar);

        if (db.ExecuteNonQuery(query) < 1)
        {
            e.Cancel = true;
            return "Erro Desconhecido";
        }

        query = String.Format("UPDATE dbo.MARCACAO SET IDVEICULO='{0}', IDVETERINARIO='{1}' WHERE IDMARCACAO='{2}'", avaiableCar, idVet, idMarcacao);

        if (db.ExecuteNonQuery(query) < 1)
        {
            e.Cancel = true;
            return "Erro Desconhecido";
        }

        return "Foi atribuido com sucesso à consulta Nº " + idMarcacao;
    }
    public static String UpdateConsult(UInt32 idMarcacao, UInt32 novoEstado, ref GridViewUpdateEventArgs e)
    {
        db = new SQLDatabaseManager();
        switch(novoEstado)
        {
            case 2:
                String query = String.Format("UPDATE dbo.MARCACAO SET ESTADO='{0}' WHERE IDMARCACAO='{1}'", novoEstado, idMarcacao);
                if (db.ExecuteNonQuery(query) < 1)
                {
                    e.Cancel = true;
                    return "Erro Desconhecido";
                }
                return "Estado alterado com sucesso. Pode prosseguir para o local.";
            case 3:
                query = String.Format("UPDATE dbo.MARCACAO SET ESTADO='{0}' WHERE IDMARCACAO='{1}'", novoEstado, idMarcacao);
                if (db.ExecuteNonQuery(query) < 1)
                {
                    e.Cancel = true;
                    return "Erro Desconhecido";
                }
                query = String.Format("SELECT * FROM dbo.VEICULOS WHERE EMUSO = '{0}'", idMarcacao);

                DataTable temp;

                temp = db.GetDataTable(query);

                UInt32 avaiableCar = 0;

                foreach(DataRow r in temp.Rows)
                {
                    avaiableCar = Convert.ToUInt32(r["IDVEICULO"].ToString());
                    break;
                }
                query = String.Format("UPDATE dbo.VEICULOS SET EMUSO='0' WHERE IDVEICULO='{1}'","0", avaiableCar);
                if (db.ExecuteNonQuery(query) < 1)
                {
                    e.Cancel = true;
                    return "Erro Desconhecido";
                }

                query = String.Format("SELECT IDCLIENTE, URGENCIA FROM dbo.MARCACAO WHERE IDMARCACAO='{0}'", idMarcacao);
                temp = db.GetDataTable(query);
                String idClient = null;
                String urg = null;
                foreach(DataRow r in temp.Rows)
                {
                    idClient = r["IDCLIENTE"].ToString();
                    urg = r["URGENCIA"].ToString();
                    break;
                }
                
                UInt32 montante = 0;
                DateTime dt = DateTime.Now.AddDays(7);
                Random random = new Random();
                int randomNumber = random.Next(23535, 67456);

                if (urg != String.Empty)
                    montante = 40;
                else
                    montante = 30;

                Dictionary<String, String> InsertData = new Dictionary<String, String>()
                {
                    {"MONTANTE", Convert.ToString(montante)},
                    {"METODO", "Multibanco"},
                    {"DATA_LIMITE", dt.ToString()},
                    {"NUMEROMOVIMENTACAO", randomNumber.ToString() },
                    {"IDMARCACAO", Convert.ToString(idMarcacao)},
                    {"IDCLIENTE",  idClient},
                    {"ESTADO", "0"}
                };

                if (!db.Insert("dbo.PAGAMENTO", InsertData))
                    return "Erro ao processar nota de pagamento.";

                query = String.Format("SELECT * FROM dbo.PAGAMENTO WHERE IDMARCACAO='{0}'", idMarcacao);
                temp = db.GetDataTable(query);
                String idPayment = null;
                foreach (DataRow r in temp.Rows)
                {
                    idPayment = r["IDPAGAMENTO"].ToString();
                    break;
                }

                query = String.Format("UPDATE dbo.MARCACAO SET IDPAGAMENTO='{0}' WHERE IDMARCACAO='{1}'", idPayment, idMarcacao);

                if (db.ExecuteNonQuery(query) > 0)
                    return "A nota de pagamento foi criada com sucesso e enviada para o cliente em questão.";
                else
                    return "Erro ao processar nota de pagamento.";
                    
            case 4:
                query = String.Format("UPDATE dbo.MARCACAO SET ESTADO='{0}' WHERE IDMARCACAO='{1}'", novoEstado, idMarcacao);
                if (db.ExecuteNonQuery(query) < 1)
                {
                    e.Cancel = true;
                    return "Erro Desconhecido";
                }
                return "Todo o processo da consulta foi concluído com sucesso.";
        }
        return "Erro desconhecido.";
    }
    public static Boolean RegisterVehicle(String marca, String modelo)
    {
        db = new SQLDatabaseManager();

        Dictionary<String, String> InsertData = new Dictionary<String, String>()
            {
                {"MARCA", marca},
                {"MODELO", modelo}
            };

        if (db.Insert("dbo.VEICULOS", InsertData))
            return true;
        else
            return false;
    }
    public static Boolean RegisterDrug(String nome, String marca, String dose, String principio, String preco)
    {
        db = new SQLDatabaseManager();

        Dictionary<String, String> InsertData = new Dictionary<String, String>()
            {
                {"NOME", nome},
                {"MARCA", marca},
                {"DOSE", dose},
                {"PRINCIPIO_ACTIVO", principio},
                {"PRECO", preco}
            };

        if (db.Insert("dbo.MEDICAMENTOS", InsertData))
            return true;
        else
            return false;
    }
    public static Boolean LoadAnimalsInProgress(DropDownList AnimalList)
    {
        db = new SQLDatabaseManager();

        String query = String.Format("SELECT dbo.ANIMAL.NOME, dbo.ANIMAL.IDANIMAL FROM dbo.ANIMAL, dbo.MARCACAO WHERE dbo.MARCACAO.ESTADO='3' AND  dbo.MARCACAO.IDANIMAL=dbo.ANIMAL.IDANIMAL");

        DataTable temp;
        temp = db.GetDataTable(query);

        if (temp.Rows.Count == 0)
            return false;

        AnimalList.DataSource = temp;
        AnimalList.DataTextField = temp.Columns["NOME"].ToString();
        AnimalList.DataValueField = temp.Columns["IDANIMAL"].ToString();
        AnimalList.DataBind();
        return true;
    }
    public static Boolean LoadDrugs(DropDownList DrugsList)
    {
        db = new SQLDatabaseManager();

        String query = String.Format("SELECT NOME, IDMEDICAMENTO FROM dbo.MEDICAMENTOS WHERE DOSE>0");

        DataTable temp;
        temp = db.GetDataTable(query);

        if (temp.Rows.Count == 0)
            return false;

        DrugsList.DataSource = temp;
        DrugsList.DataTextField = temp.Columns["NOME"].ToString();
        DrugsList.DataValueField = temp.Columns["IDMEDICAMENTO"].ToString();
        DrugsList.Items.Add("Nenhum medicamento");
        DrugsList.DataBind();
        
        return true;
    }
    public static Boolean RegisterClinicHistory(String idAnimal, String idMedicamento, String ocorrencia)
    {
        DateTime dt = DateTime.Now;

        db = new SQLDatabaseManager();

        Dictionary<String, String> InsertData = new Dictionary<String, String>()
            {
                {"IDMEDICAMENTO", idMedicamento},
                {"IDANIMAL", idAnimal},
                {"OCORRENCIA", ocorrencia},
                {"DATA", dt.ToString() }
            };

        if (!db.Insert("dbo.HISTORICOCLINICO", InsertData))
            return false;

        String query = String.Format("UPDATE dbo.MARCACAO SET ESTADO='4' WHERE IDANIMAL='{0}'", idAnimal);

        if (db.ExecuteNonQuery(query) == 0)
            return false;
        return true;
    }
    public static Boolean PaymentExists(String PaymentID)
    {
        db = new SQLDatabaseManager();

        String query = "SELECT IDPAGAMENTO FROM dbo.PAGAMENTO WHERE IDPAGAMENTO='" + PaymentID + "'";

        DataTable temp;
        temp = db.GetDataTable(query);

        if (temp.Rows.Count > 0)
            return true;
        return false;
    }
    public static void FillPaymentFields(String PaymentID, TextBox Data, TextBox Metodo, TextBox Montante, TextBox Movimentacao, TextBox Estado)
    {
        db = new SQLDatabaseManager();

        String query = String.Format("UPDATE dbo.PAGAMENTO SET ESTADO='1'WHERE IDPAGAMENTO='{0}'", PaymentID);

        db.ExecuteNonQuery(query);

        query = String.Format("UPDATE dbo.MARCACAO SET ESTADO='4' WHERE IDPAGAMENTO='{0}'", PaymentID);

        db.ExecuteNonQuery(query);

        query = String.Format("SELECT * FROM dbo.PAGAMENTO WHERE IDPAGAMENTO='{0}'", PaymentID);

        DataTable temp;

        temp = db.GetDataTable(query);

        foreach(DataRow r in temp.Rows)
        {
            Data.Text = r["DATA_LIMITE"].ToString();
            Metodo.Text = r["METODO"].ToString();
            Movimentacao.Text = r["NUMEROMOVIMENTACAO"].ToString();
            Montante.Text = r["MONTANTE"].ToString();
            if(r["ESTADO"].ToString() == "0")
            {
                Estado.Text = "Falta pagar";
            }
            else
            {
                Estado.Text = "Pago";
            }
            break;
        }

    }
    public static void LoadPayments(WebsiteUser Obj, HttpResponse Response)
    {
        
        String query = String.Format("SELECT * FROM dbo.PAGAMENTO WHERE IDCLIENTE='{0}'", Obj.ClientID);

        DataTable temp;
        temp = db.GetDataTable(query);

        foreach(DataRow r in temp.Rows)
        {
            Response.Write("<div class='col-md-4'>");
            Response.Write("<h4><u>Data: </u> " + r["DATA_LIMITE"].ToString().Remove(11) + "</h4>");
            Response.Write("<p><a class='btn btn-default' href='\\Account\\Payments\\Payment?PaymentID=" + r["IDPAGAMENTO"].ToString() + "'>Detalhes &raquo;</a></p>");
            Response.Write("</div>");
        }
    }
}