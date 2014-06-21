using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.IO;
using System.Security.Cryptography;
using System.Threading.Tasks;
using System.Data;
using System.Text.RegularExpressions;
using MobilVet.Backend;
using Website;
using Microsoft.Owin.Security;

namespace MobilVet.Backend
{
    /// <summary>
    /// Summary description for Mailer
    /// </summary>
    public sealed class Mailer
    {
        private Mailer()
        { }

        public static bool SendMail(MailMessage objMail)
        {
            NetworkCredential objNC = new NetworkCredential("noreplay.zipper@gmail.com", "ABCabc123");
            SmtpClient objSmtp = new SmtpClient("smtp.gmail.com", 587); // for gmail
            objSmtp.EnableSsl = true;
            objSmtp.Credentials = objNC;
            objSmtp.Send(objMail);
            return true;
        }

        public static MailMessage CreateMail(String Email, String ActivationCode)
        {
            MailMessage message = new MailMessage(
                "noreplay.zipper@gmail.com",
                Email,
                "Registo MobilVet",
                "A sua conta foi criada com sucesso. Por favor use o código " + ActivationCode + " para confirmar o seu registo."
                );
            return message;
        }

        public static MailMessage ForgotPassword(String Email, String PlainPassword)
        {

            MailMessage message = new MailMessage(
                "noreplay.zipper@gmail.com",
                Email,
                "Recuperação de Password",
                "Password para login: " + PlainPassword + "\nEmail para login: " + Email
                );
            return message;
        }
    }
}