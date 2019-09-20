using OnlineCourierService.Class;
using System;
using System.IO;
using System.Web;
using System.Web.UI;

namespace OnlineCourierService
{
  public partial class register : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      string q = Request.QueryString["q"];
      if (q != null)
      {
        if (q.Equals("personal"))
        {
          DDLAccType.SelectedIndex = 1;
        }
        else if (q.Equals("business"))
        {
          DDLAccType.SelectedIndex = 2;
        }
        DDLAccType.Focus();
        DDLAccType.BorderColor = System.Drawing.Color.FromArgb(21, 238, 255);///#15eeff
      }
    }
    protected void Cancel(object sender, EventArgs e)
    {
      Response.Redirect("~/index.aspx");
    }

    private void Notifyuser(string msg, bool isSuccessful)
    {
      if (isSuccessful)
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
    protected void Create(object sender, EventArgs e)
    {
      if (Page.IsValid)
      {
        HttpPostedFile img = FUpic.PostedFile;
        if (!img.FileName.Equals(""))
        {
          string fileExtennsion = Path.GetExtension(img.FileName).ToLower();
          if (fileExtennsion != ".jpg" && fileExtennsion != ".jpeg" && fileExtennsion != ".png")
          {
            Notifyuser("Only images(.jpg, .png, .jpeg) can be uploaded", false);
            return;
          }
        }
        if (Customer.CountCustomer(Convert.ToInt64(TBphone.Text.Trim())) != 0)
        {
          Notifyuser("Same Phone Number is already Registered try to Login with it or try with Another one", false);
          return;
        }
        if (Customer.CountCustomer(TBemail.Text.Trim()) != 0)
        {
          Notifyuser("Same Email Address is already Registered try to Login with it or try with Another one", false);
          return;
        }
        string name = TBunm.Text.Trim();
        string addr = TBaddr.Text.Trim();
        string gender = RBLgenger.SelectedValue;
        DateTime dob = DateTime.Parse(TBdob.Text.Trim());
        long phno = Convert.ToInt64(TBphone.Text.Trim());
        string email = TBemail.Text.Trim();
        long bid = Convert.ToInt64(DDLbranch.SelectedValue);
        string pass = TBcpass.Text.Trim();
        string accType = DDLAccType.SelectedValue;
        Customer cus = new Customer(name, addr, gender, dob, phno, email, bid, accType, pass);
        string cid = cus.InsertData();
        if (cid.Equals(null))
        {
          Notifyuser("Account Creation Failed", false);
          return;
        }
        if (!img.FileName.Equals(""))
        {
          cus.InsertUpdateImage(img);
        }
        Notifyuser("Customer Account with ID: " + cid + " has been created", true);
      }
      else
      {
        Notifyuser("Validation Error, Data Not Saved", false);
      }
    }
  }
}