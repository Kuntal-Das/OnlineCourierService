using OnlineCourierService.Class;
using OnlineCourierService.employee.Classes;
using System;
using System.Web.Caching;
using System.Web;
using System.Web.UI;
using System.IO;

namespace OnlineCourierService
{
  public partial class Profile : System.Web.UI.Page
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
        Lcid.Text = Session["LightCus"].ToString();
        cus = new Customer(Session["LightCus"].ToString(), true);
        LoadData(cus);
      }
    }

    private void LoadData(Customer cus)
    {
      cus.FillData();
      Cache.Add("CustomerData", cus, null, Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(5), CacheItemPriority.AboveNormal, null);
      Aname.Text = cus.name;
      if (cus.imgurl != null)
      {
        ProundedDP.Style.Add("background-image", cus.imgurl);
      }
      TBunm.Text = cus.name;
      TBaddr.Text = cus.address;
      TBdob.Text = cus.dob.ToString("yyyy-MM-dd");
      RBLgenger.SelectedValue = cus.gender;
      TBphone.Text = cus.phno.ToString();
      TBemail.Text = cus.email;
      DDLAccType.SelectedValue = cus.accType;
      if (cus.imgurl != null)
      {
        ImgProfilePic.ImageUrl = cus.imgurl;
      }
      long rid = Branch.GetRidbyBid(cus.BID);
      DDLregwithRID.SelectedValue = rid.ToString();

      DDLbranch.DataSource = DataAccessLayer.GetBranchByRid((int)rid); ;
      DDLbranch.DataValueField = "Bid";
      DDLbranch.DataTextField = "Bname";
      DDLbranch.DataBind();
      DDLbranch.SelectedValue = cus.BID.ToString();
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

    protected void Update(object sender, EventArgs e)
    {
      if (Page.IsValid)
      {
        Customer cus = (Customer)Cache.Get("CustomerData");
        if (cus == null)
        {
          cus = new Customer(Session["LightCus"].ToString(), true);
          cus.FillData();
        }
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

        long phno = Convert.ToInt64(TBphone.Text.Trim());
        if (Customer.CountCustomer(phno) != 0 && cus.phno != phno)
        {
          Notifyuser("Phnoe Number is Already Registed with another account", false);
          return;
        }
        string email = TBemail.Text.Trim();
        if (Customer.CountCustomer(email) != 0 && !cus.email.Equals(email))
        {
          Notifyuser("Email is Already Registed with another account", false);
          return;
        }
        string name = TBunm.Text.Trim();
        string addr = TBaddr.Text.Trim();
        DateTime dob = DateTime.Parse(TBdob.Text.Trim());
        string gender = RBLgenger.SelectedValue;
        string acctype = DDLAccType.SelectedValue;
        long bid = Convert.ToInt64(DDLbranch.SelectedValue);


        if (cus.UpdateData(new Customer(name, addr, gender, dob, phno, email, bid, acctype, null)) > 0)
        {
          cus.InsertUpdateImage(img);
          Notifyuser("Information Updated Successfully", true);
        }
        else
        {
          Notifyuser("Data not Saved Due to Data Conflict", false);
        }

        LoadData(cus);
      }
      else
      {
        Notifyuser("Validation Error Data Not Saved", false);
        return;
      }
    }
    protected void Cancel(object sender, EventArgs e)
    {
      Response.Redirect("~/index.aspx");
    }

    protected void DDLregwithRID_SelectedIndexChanged(object sender, EventArgs e)
    {
      int rid = Convert.ToInt32(DDLregwithRID.SelectedValue);
      DDLbranch.DataSource = DataAccessLayer.GetBranchByRid(rid);
      DDLbranch.DataValueField = "Bid";
      DDLbranch.DataTextField = "Bname";
      DDLbranch.DataBind();
    }
  }
}