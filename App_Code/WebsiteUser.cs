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
    /// Summary description for WebsiteUser
    /// </summary>
    public class WebsiteUser
    {
        private String _username;
        private String _email;
        private UInt32 _id;
        private Double _contact;
        private String _address;
        private UInt32 _fiscal;
        private UInt32 _cc;
        private String _encryptedpassword;
        private UInt32 _level;
        private String _type;

        private static SQLDatabaseManager db;

        public WebsiteUser(String mail, UInt32 level)
        {
            _email = mail;
            _level = level;

            db = new SQLDatabaseManager();
            DataTable temp;

            switch(level)
            {
                case 1: //Cliente
                    String query = "SELECT * FROM dbo.CLIENTE WHERE EMAIL='" + _email + "'";
                    temp = db.GetDataTable(query);

                    foreach (DataRow r in temp.Rows)
                    {
                        _username = r["NOME"].ToString();
                        _type = r["TIPO"].ToString();
                        _id = Convert.ToUInt32(r["IDCLIENTE"].ToString());
                        _contact = Convert.ToDouble(r["CONTACTO"].ToString());
                        _address = r["MORADA"].ToString();
                        _fiscal = Convert.ToUInt32(r["CONTRIBUINTE"].ToString());
                        _cc = Convert.ToUInt32(r["BI"].ToString());
                        _encryptedpassword = r["PASSWORD"].ToString();
                        break;
                    }
                    _level = 1;
                    break;

                case 2: //Veterinario
                    query = "SELECT * FROM dbo.VETERINARIO WHERE EMAIL='" + _email + "'";

                    temp = db.GetDataTable(query);

                    foreach (DataRow r in temp.Rows)
                    {
                        _username = r["NOME"].ToString();
                        _type = r["ESPECIALIDADE"].ToString();
                        _id = Convert.ToUInt32(r["IDVETERINARIO"].ToString());
                        _contact = Convert.ToDouble(r["CONTACTO"].ToString());
                        _address = r["MORADA"].ToString();
                        _encryptedpassword = r["PASSWORD"].ToString();
                        break;
                    }
                    _level = 2;
                    break;

                case 3: //Admin
                    query = "SELECT * FROM dbo.ADMIN WHERE EMAIL='" + _email + "'";

                    temp = db.GetDataTable(query);

                    foreach (DataRow r in temp.Rows)
                    {
                        _username = r["NOME"].ToString();
                        _id = Convert.ToUInt32(r["IDADMIN"].ToString());
                        _encryptedpassword = r["PASSWORD"].ToString();
                        break;
                    }
                    _level = 3;
                    break;
            }
        }
        
        public String EncryptedPassword
        {
            get
            {
                return _encryptedpassword;
            }
            set
            {
                _encryptedpassword = value;
            }
        }
        public UInt32 Level
        {
            get
            {
                return _level;
            }
            set
            {
                _level = value;
            }
        }
        public UInt32 CC
        {
            get
            {
                return _cc;
            }
            set
            {
                _cc = value;
            }
        }
        public UInt32 FiscalNumber
        {
            get
            {
                return _fiscal;
            }
            set
            {
                _fiscal = value;
            }
        }
        public String Address
        {
            get
            {
                return _address;
            }
            set
            {
                _address = value;
            }
        }
        public Double Contact
        {
            get
            {
                return _contact;
            }
            set
            {
                _contact = value;
            }
        }
        public String Username
        {
            get
            {
                return _username;
            }
            set
            {
                _username = value;
            }
        }
        public String Email
        {
            get
            {
                return _email;
            }
            set
            {
                _email = value;
            }
        }
        public String Type
        {
            get
            {
                return _type;
            }
            set
            {
                _type = value;
            }
        }
        public UInt32 ClientID
        {
            get
            {
                return _id;
            }
            set
            {
                _id = value;
            }
        }


        public Boolean HasAnimals()
        {
            db = new SQLDatabaseManager();

            String query = String.Format("SELECT * FROM dbo.ANIMAL WHERE IDCLIENTE='{0}'", _id);

            DataTable temp;

            temp = db.GetDataTable(query);

            if (temp.Rows.Count == 0)
                return false;
            return true;
        }
        public Boolean SaveChangesToDatabase()
        {
            db = new SQLDatabaseManager();

            String query = String.Format("UPDATE dbo.CLIENTE SET MORADA='{0}', CONTRIBUINTE='{1}', CONTACTO='{2}', BI='{3}', EMAIL='{4}', PASSWORD='{5}' WHERE IDCLIENTE='{6}'", _address, _fiscal, _contact, _cc, _email, _encryptedpassword, _id);

            if(db.ExecuteNonQuery(query) == 1)
            {
                return true;
            }
            return false;
        }
    }
}