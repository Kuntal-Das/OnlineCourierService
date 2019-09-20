using OnlineCourierService.Class;
using System;
using System.Web.UI;

namespace OnlineCourierService
{
  public partial class resetPassword : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      string guid = Request.QueryString["uid"];
      if (guid == null)
      {
        Notifyuser("Password Reset link has expired or is invalid", false);
        TBCnewPass.Enabled = TBnewPass.Enabled = BcngP.Enabled = false;
        return;
      }
      if (!IsPostBack)
      {
        string cid = Customer.isPasswordResetLinkValid(guid);
        if (cid == null)
        {
          Notifyuser("Password Reset link has expired or is invalid", false);
          TBCnewPass.Enabled = TBnewPass.Enabled = BcngP.Enabled = false;
          return;
        }
        Customer cus = new Customer(cid, true);
        cus.FillData();
        Luser.Text += " for " + cus.email;
        Session.Add("ValidGUID", true);
      }
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
    protected void BcngP_Click(object sender, EventArgs e)
    {
      if (!Convert.ToBoolean(Session["ValidGUID"]))
      {
        Notifyuser("Update Password Failed !", false);
        return;
      }
      if (Page.IsValid)
      {
        if (Customer.ResetPassword(Request.QueryString["uid"], TBCnewPass.Text.Trim()) != 1)
        {
          Notifyuser("Update Password Failed !", false);
          return;
        }
        Notifyuser("Password Changed Successfully!", true);
      }
      else
      {
        Notifyuser("Validation Error, Try Again Later", false);
        return;
      }
    }
  }
}