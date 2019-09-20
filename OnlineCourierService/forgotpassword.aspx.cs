using OnlineCourierService.Class;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService
{
  public partial class forgotpassword : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e){}

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
        if (Customer.CountCustomer(email) != 1)
        {
          Notifyuser("Email is not Found to be Registered", false);
          return;
        }
        string link = HttpContext.Current.Request.Url.Authority;
        link += "/resetPassword.aspx";
        if (Customer.GenerateResetPasswordLink(email, link) == 1)
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