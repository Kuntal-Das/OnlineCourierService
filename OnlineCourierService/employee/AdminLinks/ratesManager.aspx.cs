using OnlineCourierService.employee.Classes;
using System;
using System.Web.UI.WebControls;

namespace OnlineCourierService.employee.AdminLinks
{
  public partial class ratesManager : System.Web.UI.Page
  {
    private string id;
    private Employee emp;
    protected void Page_Load(object sender, EventArgs e)
    {
      try
      {
        id = Session["LightAdm"].ToString();
        emp = new Employee(Convert.ToInt32(id));
        emp.Filldata();

        Aname.Text = emp.name;
      }
      catch (Exception)
      {
        Response.Redirect("~/employee/login.aspx");
      }
      if (id.Equals(null) || !emp.IsAdmin())
      {
        Response.Redirect("~/employee/login.aspx");
      }
      if (!IsPostBack)
      {
        string imgurl = emp.LoadImage();
        if (imgurl != null)
        {
          ProundedDP.Style.Add("background-image", "url(" + imgurl + ")");
        }
      }
    }

    protected void Logout(object sender, EventArgs e)
    {
      Session.Remove("LightAdm");
      if (Session["LightEmp"] != null)
      {
        Session.Remove("LightEmp");
      }
      Response.Redirect("~/employee/login.aspx");
    }

    protected void InsertNewRate(object sender, EventArgs e)
    {
      if (DataAccessLayer.CountRateWeight(Convert.ToInt32(((TextBox)GVParcelRates.FooterRow.FindControl("TBweight")).Text.Trim())) != 0)
      {
        LErr.Text = "Row is not Inserted as Similar Weight value already present";
        LErr.ForeColor = System.Drawing.Color.Red;
        PError.Style.Add("border", "2px solid lightRed");
        PError.Visible = true;
        return;
      }
      OBSRates.InsertParameters["Weight"].DefaultValue =
          ((TextBox)GVParcelRates.FooterRow.FindControl("TBweight")).Text.Trim();

      OBSRates.InsertParameters["Basic"].DefaultValue =
          ((TextBox)GVParcelRates.FooterRow.FindControl("TBBasic")).Text.Trim();

      OBSRates.InsertParameters["Business"].DefaultValue =
          ((TextBox)GVParcelRates.FooterRow.FindControl("TBBusiness")).Text.Trim();

      OBSRates.InsertParameters["DryFood"].DefaultValue =
          ((TextBox)GVParcelRates.FooterRow.FindControl("TBDryFood")).Text.Trim();

      OBSRates.InsertParameters["CookedFood"].DefaultValue =
          ((TextBox)GVParcelRates.FooterRow.FindControl("TBCookedFood")).Text.Trim();

      OBSRates.InsertParameters["Gift"].DefaultValue =
          ((TextBox)GVParcelRates.FooterRow.FindControl("TBGift")).Text.Trim();

      OBSRates.InsertParameters["Electronics"].DefaultValue =
          ((TextBox)GVParcelRates.FooterRow.FindControl("TBElectronics")).Text.Trim();

      OBSRates.Insert();

      LErr.Text = "Row is Inserted Successflly";
      LErr.ForeColor = System.Drawing.Color.SteelBlue;
      PError.Style.Add("border", "2px solid Navy");
      PError.Visible = true;
    }

    protected void GVParcelRates_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
      if (e.AffectedRows < 1)
      {
        e.KeepInEditMode = true;
        LErr.Text = "Row with Rate ID :" + e.Keys[0].ToString() + " is not Updated Due to Data Conflict / Similar Weight value already present";
        LErr.ForeColor = System.Drawing.Color.Red;
        PError.Style.Add("border", "2px solid lightRed");
        PError.Visible = true;
      }
      else
      {
        LErr.Text = "Row with Rate ID :" + e.Keys[0].ToString() + " is Updated Successflly";
        LErr.ForeColor = System.Drawing.Color.SteelBlue;
        PError.Style.Add("border", "2px solid Navy");
        PError.Visible = true;
      }

    }

    protected void HidePErr(object sender, EventArgs e)
    {
      PError.Visible = false;
    }

    protected void OBSRates_Updated(object sender, ObjectDataSourceStatusEventArgs e)
    {
      if (e.ReturnValue is int && (int)e.ReturnValue > 0)
      {
        e.AffectedRows = (int)e.ReturnValue;
      }
    }

    //protected void InsertNewRate(object sender,EventArgs e) { }
  }
}