using OnlineCourierService.Class;
using System;
using System.Web.UI;

namespace OnlineCourierService
{
  public partial class index : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e){
      Customer cus;
      if (!IsPostBack){
        if (Session["LightCus"] != null){
          string CID = Session["LightCus"].ToString();
          cus = new Customer(CID, true);
          LoginSignIn.Visible = false;
          Plogin.Visible = Pbusiness.Visible = Ppresonal.Visible = false;
          Puser.Visible = true;
          cus.FillData();
          Aname.Text = cus.name;
          if (cus.imgurl != null){
            ProundedDP.Style.Add("background-image", cus.imgurl);
          }
        }
      }
    }
    private void Notifyuser(string msg, bool issuccessful){
      if (issuccessful){
        Lerr.Text = msg;
        Lerr.Style.Add("color", "Navy");
        PError.Style.Add("border", "2px solid Navy");
      }else{
        Lerr.Text = msg;
        Lerr.Style.Add("color", "Red");
        PError.Style.Add("border", "2px solid lightred");
      }
      PError.Style.Add("display", "block");
    }
    protected void Blogin_Click(object sender, EventArgs e){
      if (Page.IsValid){
        string CID = null;
        Customer Cus;
        try{
          Cus = new Customer(Convert.ToInt64(TBunm.Text.Trim()));
        }catch (FormatException){
          Cus = new Customer(TBunm.Text.Trim());
        }
        CID = Cus.GetCIDbyPass(TBpas.Text.Trim());
        if (CID == null){
          Notifyuser("Email/Phone Number or Password Do not Match", false);
          return;
        }
        Session["LightCus"] = CID;
        Response.Redirect("~/index.aspx");
      }else{
        Notifyuser("Validation Error, Data Not Saved", false);
      }
    }
    protected void Logout(object sender, EventArgs e){
      Session.Remove("LightCus");
      Response.Redirect("~/index.aspx");
    }
  }
}