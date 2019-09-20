using System;
using System.Security.Cryptography;
using System.Text;
using System.Net.Mail;

namespace OnlineCourierService.Class
{
  public class Password
  {
    protected static string HashPassword(string pass){
      if (pass == null){
        return null;
      }
      byte[] barray = null;
      using (SHA256 sha256Hash = SHA256.Create()){
        barray = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(pass));
      }
      return Convert.ToBase64String(barray);
    }

    protected static bool SendPasswordResetEmail(string ToEmail, string UserName, string UniqueId, string link){
      // MailMessage class is present is System.Net.Mail namespace
      MailMessage mailMessage = new MailMessage("noreply.lightning.corp599@gmail.com", ToEmail);
      // StringBuilder class is present in System.Text namespace
      StringBuilder sbEmailBody = new StringBuilder();
      sbEmailBody.Append("Dear " + UserName + ",<br/><br/>");
      sbEmailBody.Append("Please click on the following link to reset your password");
      sbEmailBody.Append("<br/>"); sbEmailBody.Append("<a href=\"https://" + link + "?uid=" + UniqueId + "\">Reset Password</a>");
      sbEmailBody.Append("<br/> Ignore It If you Have not Made any Request Like This <br/>");
      sbEmailBody.Append("<br/><br/>");
      sbEmailBody.Append("<b>Lightning Corp.</b><br/><br/>");
      sbEmailBody.Append("<tt>This is a Computer Generated Email Do not Reply to it.</tt>");
      mailMessage.IsBodyHtml = true;
      mailMessage.Body = sbEmailBody.ToString();
      mailMessage.Subject = "Reset Your Password";
      try{
        SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
        smtpClient.Credentials = new System.Net.NetworkCredential(){
          UserName = "noreply.lightning.corp599@gmail.com",
          Password = "***********************************"
        };
        smtpClient.EnableSsl = true;
        smtpClient.Send(mailMessage);
      }
      catch (Exception) { return false; }
      return true;
    }
  }
}