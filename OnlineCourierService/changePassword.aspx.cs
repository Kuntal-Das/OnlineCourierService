using OnlineCourierService.Class;
using System;
using System.Collections.Generic;
using System.Linq;
//using System.Runtime.Caching;
using System.Web.Caching;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService
{
  public partial class changePassword : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (Session["LightCus"] == null)
      {
        Response.Redirect("~/index.aspx");
      }
      Customer cus;
      if (!IsPostBack && Session["LightCus"] != null)
      {
        cus = new Customer(Session["LightCus"].ToString(), true);
        cus.FillData();
        Cache.Add("CustomerData", cus, null, Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(5), CacheItemPriority.AboveNormal, null);
        Aname.Text = cus.name;
        if (cus.imgurl != null)
        {
          ProundedDP.Style.Add("background-image", cus.imgurl);
        }
      }
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
    protected void Logout(object sender, EventArgs e)
    {
      Session.Remove("LightCus");
      Response.Redirect("~/index.aspx");
    }

    protected void Cancel(object sender, EventArgs e)
    {
      Response.Redirect("~/Profile.aspx");
    }

    protected void CngPass(object sender, EventArgs e)
    {
      if (Page.IsValid)
      {
        Customer cus = (Customer)Cache.Get("CustomerData");
        if (cus == null)
        {
          cus = new Customer(Session["LightCus"].ToString(), true);
          cus.FillData();
        }
        string oldpass = TBOLDpass.Text.Trim();
        string cid = Session["LightCus"].ToString();
        string vcid = cus.GetCIDbyPass(oldpass);

        if (!vcid.Equals(cid))
        {
          Notifyuser("Old Password do not Match", false);
          return;
        }
        string newpass = TBcpass.Text.Trim();
        if (cus.UpdatePassword(newpass, oldpass) > 0)
        {
          Notifyuser("Password Changed Successfully", true);
        }
        else
        {
          Notifyuser("Password not Changed due to Data conflict", false);
        }
      }
      else
      {
        Notifyuser("Validation Error Data Not Saved", false);
        return;
      }
    }
  }
}