using Microsoft.AspNet.Identity;
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


namespace MobilVet.Backend
{
    /// <summary>
    /// Summary description for Account
    /// </summary>
    public class Account
    {

        private static SQLDatabaseManager db;

        public static String ID2Email(UInt32 id)
        {
            String query = String.Format("SELECT * FROM dbo.CLIENTE WHERE IDCLIENTE='{0}'", id);

            db = new SQLDatabaseManager();

            DataTable temp;

            temp = db.GetDataTable(query);

            if (temp.Rows.Count < 1)
                return null;

            foreach(DataRow r in temp.Rows)
            {
                return r["EMAIL"].ToString();
            }
            return null;
        }
        public static Boolean AccountExists(String Email, String BI, String Contribuinte)
        {
            if (Email.Length == 0 && BI.Length == 00 && Contribuinte.Length == 00)
                return true;

            String query = String.Format("SELECT * FROM dbo.CLIENTE WHERE EMAIL='{0}' OR BI='{1}' OR CONTRIBUINTE='{2}'", Email, BI, Contribuinte);

            db = new SQLDatabaseManager();

            DataTable temp;

            temp = db.GetDataTable(query);

            foreach (DataRow r in temp.Rows)
            {
                return true;
            }

            return false;
        }
        public static Boolean ValidEmail(String Email)
        {
            if (Email.Length == 0)
                return false;

            String query = String.Format("SELECT * FROM dbo.ACESSOS WHERE EMAIL='{0}'", Email);

            db = new SQLDatabaseManager();

            DataTable temp;

            temp = db.GetDataTable(query);

            foreach (DataRow r in temp.Rows)
            {
                return true;
            }

            return false;
        }
        public static Boolean Register(DropDownList DropDownTipo, Literal ErrorMessage, params String[] Parameter)
        {
            if (Parameter.Length != 8)
            {
                ErrorMessage.Text = "";
                return false;
            }

            if (DropDownTipo.SelectedValue == "-1")
            {
                ErrorMessage.Text = "Escolha o tipo de cliente.";
                return false;
            }

            if (DropDownTipo.SelectedValue == "1")
            {
                if (Parameter[6].Length != 8)
                {
                    ErrorMessage.Text = "Cartão de Cidadão inválido";
                    return false;
                }
                if (AccountExists(Parameter[2], Parameter[6], "-1"))
                {
                    ErrorMessage.Text = "Conta já existente";
                    return false;
                }
            }
            else if (DropDownTipo.SelectedValue == "2")
            {
                if (Parameter[7].Length != 9)
                {
                    ErrorMessage.Text = "Contribuinte inválido";
                    return false;
                }
                if (AccountExists(Parameter[2], "-1", Parameter[7]))
                {
                    ErrorMessage.Text = "Conta já existente";
                    return false;
                }
            }

            if (Parameter[3].Length < 6 || Parameter[3].Length > 15)
            {
                ErrorMessage.Text = "Contacto inválido";
                return false;
            }

            String SaltKey = SEM.GetSerialKeyAlphaNumaric(8);
            String ActivationCode = SEM.GetSerialKeyAlphaNumaric(16);

            db = new SQLDatabaseManager();

            Dictionary<String, String> InsertData = new Dictionary<String, String>()
            {
                {"NOME", Parameter[0]},
                {"PASSWORD", SEM.Encrypt(Parameter[1], SaltKey)},
                {"EMAIL", Parameter[2]},
                {"CONTACTO", Parameter[3]},
                {"MORADA", Parameter[4]},
                {"SEXO", Parameter[5]},
                {"TIPO", DropDownTipo.SelectedValue.ToString()},
                {"HASH", SaltKey},
                {"CODIGO", ActivationCode},
                {"ESTADO", "0"},
                {"BI", Parameter[6]},
                {"CONTRIBUINTE", Parameter[7]}
            };

            if (db.Insert("dbo.CLIENTE", InsertData))
            {
                String query = String.Format("SELECT IDCLIENTE FROM dbo.CLIENTE WHERE NOME='{0}' AND HASH='{1}' AND EMAIL='{2}'",
                Parameter[0], SaltKey, Parameter[2]);

                DataTable temp;
                temp = db.GetDataTable(query);

                String LastInsertID = null;

                foreach (DataRow r in temp.Rows)
                {
                    LastInsertID = r["IDCLIENTE"].ToString();
                    break;
                }

                InsertData = new Dictionary<String, String>()
                {
                    {"IDUSER", LastInsertID},
                    {"IDPERMISSAO", "1"},
                    {"EMAIL", Parameter[2]}
                };

                db.Insert("dbo.ACESSOS", InsertData);

                if (Mailer.SendMail(Mailer.CreateMail(Parameter[2], ActivationCode)))
                    ErrorMessage.Text = "Conta criada com sucesso!";
                else
                    ErrorMessage.Text = "Erro ao enviar email!";
            }
            else
            {
                ErrorMessage.Text = "Erro ao criar conta!";
                return false;
            }
            return true;
        }
        public static UInt32 Login(String Email, String Password, HttpResponse Resp)
        {
            db = new SQLDatabaseManager();

            String query = "SELECT * FROM dbo.ACESSOS WHERE EMAIL='" + Email + "'";
            DataTable temp;

            UInt32 accesslevel = 50;

            temp = db.GetDataTable(query);

            if (temp.Rows.Count == 0)
                return 0;

            foreach (DataRow r in temp.Rows)
            {
                accesslevel = Convert.ToUInt32(r["IDPERMISSAO"].ToString());
                break;
            }

            switch (accesslevel)
            {
                case 1: //Cliente
                    String SaltKey = null;
                    query = "SELECT HASH FROM dbo.CLIENTE WHERE EMAIL='" + Email + "'";

                    temp = db.GetDataTable(query);

                    foreach (DataRow r in temp.Rows)
                    {
                        SaltKey = r["HASH"].ToString();
                        break;
                    }

                    query = "SELECT * FROM dbo.CLIENTE WHERE EMAIL='" + Email + "' AND PASSWORD='" + SEM.Encrypt(Password, SaltKey) + "' AND ESTADO <> -1";

                    temp = db.GetDataTable(query);

                    if (temp.Rows.Count == 0)
                        return 0;

                    foreach (DataRow r in temp.Rows)
                    {
                        if (r["ESTADO"].ToString() == "0")
                        {
                            Resp.Redirect("~/Account/Activate?Email=" + Email);
                            return 0;
                        }
                    }
                    return 1;

                case 2: //Veterinario
                    SaltKey = null;
                    query = "SELECT HASH FROM dbo.VETERINARIO WHERE EMAIL='" + Email + "'";

                    temp = db.GetDataTable(query);

                    foreach (DataRow r in temp.Rows)
                    {
                        SaltKey = r["HASH"].ToString();
                        break;
                    }

                    query = "SELECT * FROM dbo.VETERINARIO WHERE EMAIL='" + Email + "' AND PASSWORD='" + SEM.Encrypt(Password, SaltKey) + "'";

                    temp = db.GetDataTable(query);

                    if (temp.Rows.Count == 0)
                        return 0;

                    return 2;
                case 3: //Admin
                    SaltKey = null;
                    query = "SELECT HASH FROM dbo.ADMIN WHERE EMAIL='" + Email + "'";

                    temp = db.GetDataTable(query);

                    foreach (DataRow r in temp.Rows)
                    {
                        SaltKey = r["HASH"].ToString();
                        break;
                    }

                    query = "SELECT * FROM dbo.ADMIN WHERE EMAIL='" + Email + "' AND PASSWORD='" + SEM.Encrypt(Password, SaltKey) + "'";

                    temp = db.GetDataTable(query);

                    if (temp.Rows.Count == 0)
                        return 0;

                    return 3;
                default: //Desconhecido
                    return 0;
            }
        }
        public static Boolean Activate(String Email, String Code, Literal Message)
        {
            if (!ValidEmail(Email))
                return false;

            String query = "UPDATE dbo.CLIENTE SET ESTADO=1 WHERE EMAIL='" + Email + "' AND CODIGO='" + Code + "' ";

            if (db.ExecuteNonQuery(query) == 1)
                return true;

            return false;
        }
        public static Boolean Deactivate(String Email)
        {
            if (!ValidEmail(Email))
                return false;

            String query = "UPDATE dbo.CLIENTE SET ESTADO=-1 WHERE EMAIL='" + Email + "'";

            if (db.ExecuteNonQuery(query) == 1)
                return true;

            return false;
        }
        public static String Email2Hash(String Email)
        {
            String Hash = null;

            if (!ValidEmail(Email))
                return null;

            String query = "SELECT HASH FROM dbo.CLIENTE WHERE EMAIL='" + Email + "'";

            DataTable temp;
            temp = db.GetDataTable(query);

            foreach (DataRow r in temp.Rows)
            {
                Hash = r["HASH"].ToString();
                break;
            }
            
            return Hash;
        }
        public static String Email2EncryptedPassword(String Email)
        {
            String EncryptedPassword = null;

            if (!ValidEmail(Email))
                return null;

            String query = "SELECT PASSWORD FROM dbo.CLIENTE WHERE EMAIL='" + Email + "'";

            DataTable temp;
            temp = db.GetDataTable(query);

            foreach (DataRow r in temp.Rows)
            {
                EncryptedPassword = r["PASSWORD"].ToString();
                break;
            }

            return EncryptedPassword;
        }
        public static Boolean RegisterVeterinary(String nome, UInt32 idade, String morada, String especialidade, String email, Double contacto, String password)
        {
            String SaltKey = SEM.GetSerialKeyAlphaNumaric(8);

            db = new SQLDatabaseManager();

            Dictionary<String, String> InsertData = new Dictionary<String, String>()
            {
                {"NOME", nome},
                {"PASSWORD", SEM.Encrypt(password, SaltKey)},
                {"EMAIL", email},
                {"CONTACTO", Convert.ToString(contacto)},
                {"MORADA", morada},
                {"SEXO", "M"},
                {"HASH", SaltKey},
                {"ESPECIALIDADE", especialidade},
                {"IDADE", Convert.ToString(idade)}
            };

            if (db.Insert("dbo.VETERINARIO", InsertData))
            {
                String query = String.Format("SELECT IDVETERINARIO FROM dbo.VETERINARIO WHERE NOME='{0}' AND HASH='{1}' AND EMAIL='{2}'",
                nome, SaltKey, email);

                DataTable temp;
                temp = db.GetDataTable(query);

                String LastInsertID = null;

                foreach (DataRow r in temp.Rows)
                {
                    LastInsertID = r["IDVETERINARIO"].ToString();
                    break;
                }

                InsertData = new Dictionary<String, String>()
                {
                    {"IDUSER", LastInsertID},
                    {"IDPERMISSAO", "2"},
                    {"EMAIL", email}
                };

                if (db.Insert("dbo.ACESSOS", InsertData))
                    return true;
                else
                    return false;
            }
            else
                return false;
        }
    }
}