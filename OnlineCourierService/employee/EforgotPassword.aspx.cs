using OnlineCourierService.employee.Classes;
using System;
using System.Web;
using System.Web.UI;

namespace OnlineCourierService.employee
{
  public partial class EforgotPassword : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    private void Notifyuser(string msg, bool issuccessful)
    {
      if (issuccessful)
      {
        Lerr.Text = msg;
        Lerr.Style.Add("color", "Navy");
        PError.Style.Add("border", "2px solid Navy");
      }
      else
      {
        Lerr.Text = msg;
        Lerr.Style.Add("color", "Red");
        PError.Style.Add("border", "2px solid lightred");
      }
      PError.Style.Add("display", "block");
    }
    protected void Bpreset_Click(object sender, EventArgs e)
    {
      if (Page.IsValid)
      {
        string email = TBunm.Text.Trim();
        if (Employee.CountByEmail(email) != 1)
        {
          Notifyuser("Email is not Found to be Registered", false);
          return;
        }
        string link = HttpContext.Current.Request.Url.Authority;
        link += "/employee/EresetPassword.aspx";
        if (Employee.GenerateResetPasswordLink(email, link) == 1)
        {
          Notifyuser("An email with instructions to reset your password is sent to your registered email", true);
        }
        else
        {
          Notifyuser("We Are Facing Some Internal Problem Try Again Later", false);
          return;
        }
      }
      else
      {
        Notifyuser("Validation Error", false);
        return;
      }
    }
  }
}