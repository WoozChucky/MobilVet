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
/// Summary description for Vehicle
/// </summary>
/// 

namespace MobilVet.Backend
{
    public class Vehicle
    {

        private static SQLDatabaseManager db;

        public Vehicle(String marca, String modelo, Literal message)
        {
            db = new SQLDatabaseManager();

            Dictionary<String, String> InsertData = new Dictionary<String, String>()
            {
                {"MARCA", marca},
                {"MODELO", modelo},
            };

            if(db.Insert("dbo.VEICULOS", InsertData))
            {
                message.Text = "Veículo adicionado com sucesso!";
                message.Visible = true;
            }
            else
            {
                message.Text = "Erro ao adicionar veículo!";
                message.Visible = true;
            }
        }

        public Vehicle(UInt32 ID)
        {

        }

        public UInt32 IDVeículo
        {
            get;
            set;
        }
        public String Marca
        {
            get;
            set;
        }
        public String Modelo
        {
            get;
            set;
        }
        public UInt32 EmUso
        {
            get;
            set;
        }
    }
}