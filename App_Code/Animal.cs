using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Text;
using System.IO;
using System.Security.Cryptography;
using System.Threading.Tasks;
using System.Data;
using System.Net.Mail;
using System.Net;
using System.Text.RegularExpressions;
using System.Web.UI;
using MobilVet.Backend;

/// <summary>
/// Summary description for Animal
/// </summary>
public sealed class Animal
{
    private String _name, _species, _race, _photopath;
    private UInt32 _age, _weight, _temperature, _ownerID, animalID, _type;

    private static SQLDatabaseManager db;

    public Animal(String Name, String Species, String Race, UInt32 Age, UInt32 Weight, UInt32 Temperature, String PhotoPath, UInt32 OwnerID, UInt32 Type)
	{
        _name = Name;
        _species = Species;
        _race = Race;
        _age = Age;
        _weight = Weight;
        _temperature = Temperature;
        _photopath = PhotoPath;
        _ownerID = OwnerID;
        _type = Type;
	}
    public Animal(UInt32 IDAnimal)
    {
        db = new SQLDatabaseManager();

        String query = "SELECT * FROM dbo.ANIMAL WHERE IDANIMAL='" + IDAnimal + "'";

        DataTable temp;
        temp = db.GetDataTable(query);

        foreach (DataRow r in temp.Rows)
        {
            this.Name = r["NOME"].ToString();
            this.Age = Convert.ToUInt32(r["IDADE"].ToString());
            this.OwnerID = Convert.ToUInt32(r["IDCLIENTE"].ToString());
            this.Race = r["RACA"].ToString();
            this.Species = r["ESPECIE"].ToString();
            this.Temperature = Convert.ToUInt32(r["TEMPERATURA"].ToString());
            this.Type = Convert.ToUInt32(r["TIPO"].ToString());
            this.Weight = Convert.ToUInt32(r["PESO"].ToString());
            break;
        }
    }
    public String Name
    {
        get
        {
            return _name;
        }
        set
        {
            _name = value;
        }
    }
    public String Species
    {
        get
        {
            return _species;
        }
        set
        {
            _species = value;
        }
    }
    public String Race
    {
        get
        {
            return _race;
        }
        set
        {
            _race = value;
        }
    }
    public UInt32 Age
    {
        get
        {
            return _age;
        }
        set
        {
            _age = value;
        }
    }
    public UInt32 Weight
    {
        get
        {
            return _weight;
        }
        set
        {
            _weight = value;
        }
    }
    public UInt32 Temperature
    {
        get
        {
            return _temperature;
        }
        set
        {
            _temperature = value;
        }
    }
    public UInt32 OwnerID
    {
        get
        {
            return _ownerID;
        }
        set
        {
            _ownerID = value;
        }
    }
    public UInt32 AnimalID
    {
        set
        {
            animalID = value;
        }
        get
        {
            return animalID;
        }
    }
    public UInt32 Type
    {
        set
        {
            _type = value;
        }
        get
        {
            return _type;
        }
    }
    public static void LoadSimpleList(UInt32 OwnerID, HttpResponse Response)
    {
        db = new SQLDatabaseManager();

        String query = "SELECT * FROM dbo.ANIMAL WHERE IDCLIENTE='" + OwnerID + "'";

        DataTable temp;
        temp = db.GetDataTable(query);

        if (temp.Rows.Count < 1)
            return;

        foreach (DataRow r in temp.Rows)
        {
            Response.Write("<p> &raquo; <a href='\\Animal\\Animal?AnimalID=" + r["IDANIMAL"].ToString() + "'>" + r["NOME"].ToString() + "</a></p>");
        }
    }
    public static UInt32 Add(Animal obj)
    {
        db = new SQLDatabaseManager();
        
        Dictionary<String, String> Data = new Dictionary<String, String>
        {
            {"NOME", obj.Name},
            {"ESPECIE", obj.Species},
            {"RACA", obj.Race},
            {"IDADE", Convert.ToString(obj.Age)},
            {"PESO", Convert.ToString(obj.Weight)},
            {"TEMPERATURA", Convert.ToString(obj.Temperature)},
            {"IDCLIENTE", Convert.ToString(obj.OwnerID)},
            {"TIPO", Convert.ToString(obj.Type)}
        };

        if(db.Insert("dbo.ANIMAL", Data))
        {
            String query = String.Format("SELECT IDANIMAL FROM dbo.ANIMAL WHERE NOME='{0}' AND ESPECIE='{1}' AND RACA='{2}' AND IDADE='{3}' AND PESO='{4}' AND TEMPERATURA='{5}' AND IDCLIENTE='{6}'",
                obj.Name, obj.Species, obj.Race, obj.Age, obj.Weight, obj.Temperature, obj.OwnerID);

            DataTable temp;
            temp = db.GetDataTable(query);

            String LastInsertID = null;

            foreach (DataRow r in temp.Rows)
            {
                LastInsertID = r["IDANIMAL"].ToString();
                break;
            }

            Data = new Dictionary<String, String>
            {
                {"URL", obj._photopath},
                {"IDANIMAL", LastInsertID}
            };

            if (db.Insert("dbo.FOTOS", Data))
                return 2;
            return 1;
        }
        return 0;
    }
    public static void DrawAnimal(HttpResponse Response, String PhotoPath, String Name, String Race, UInt32 Age, UInt32 AnimalID)
    {
        Response.Write("<div class='col-md-4'>");
        Response.Write("<h2>" + Name + "</h2>");
        Response.Write("<p><u>Raça:</u> " + Race + "</p>");
        Response.Write("<p><u>Idade:</u> " + Age + "</p>");
        Response.Write("<p><a href='\\Animal\\Animal?AnimalID=" + AnimalID + "'><img src='..\\" + PhotoPath + "' alt='" + Race + "' /></a></p>");
        Response.Write("<p><a class='btn btn-default' href='\\Animal\\Animal?AnimalID="+ AnimalID +"'>Detalhes &raquo;</a></p>");
        Response.Write("</div>");
    }
    public static void LoadAnimal(UInt32 AnimalID, Page Page, HttpResponse Response)
    {
        if (!Animal.Exists(AnimalID))
        {
            Page.Title = "Animal inexistente";
            Response.End();
            return;
        }        

    }
    public static Boolean Exists(UInt32 AnimalID)
    {
        db = new SQLDatabaseManager();

        String query = "SELECT NOME FROM dbo.ANIMAL WHERE IDANIMAL='" + AnimalID + "'";

        DataTable temp;
        temp = db.GetDataTable(query);

        if (temp.Rows.Count > 0)
            return true;
        return false;
    }
    public static Boolean isValidOwner(WebsiteUser obj, UInt32 AnimalID)
    {
        db = new SQLDatabaseManager();

        String query = "SELECT * FROM dbo.ANIMAL WHERE IDCLIENTE='" + obj.ClientID + "' AND IDANIMAL='" + AnimalID + "'";

        DataTable temp;
        temp = db.GetDataTable(query);

        if (temp.Rows.Count > 0)
            return true;
        return false;
    }
    public static String Id2Name(UInt32 AnimalID)
    {
        db = new SQLDatabaseManager();

        String query = "SELECT NOME FROM dbo.ANIMAL WHERE IDANIMAL='" + AnimalID + "'";

        DataTable temp;
        temp = db.GetDataTable(query);

        foreach (DataRow r in temp.Rows)
        {
            return r["NOME"].ToString();
        }

        return null;
    }
    public Boolean SaveChangesToDatabase()
    {
        db = new SQLDatabaseManager();

        String query = String.Format("UPDATE dbo.ANIMAL SET NOME='{0}', ESPECIE='{1}', RACA='{2}', IDADE='{3}', PESO='{4}', TEMPERATURA='{5}', TIPO='{6}' WHERE IDANIMAL='{7}'", _name, _species, _race, _age, _weight, _temperature, _type, animalID);

        if (db.ExecuteNonQuery(query) == 1)
        {
            return true;
        }
        return false;
    }
}