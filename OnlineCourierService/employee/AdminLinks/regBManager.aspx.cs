using OnlineCourierService.employee.Classes;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService.employee.AdminLinks
{
  public partial class regBManager : System.Web.UI.Page
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

    protected void CreateRb(object sender, EventArgs e)
    {
      LBCreateREGb.CssClass = "tab active";
      LBSrcREGb.CssClass = "tab";
      PcreateRb.Visible = true;
      PSrcRb.Visible = false;
    }

    protected void SrcRb(object sender, EventArgs e)
    {
      LBCreateREGb.CssClass = "tab";
      LBSrcREGb.CssClass = "tab active";
      PSrcRb.Visible = true;
      PcreateRb.Visible = false;
    }

    protected void IsAlreadyRegistered(object sender, EventArgs e)
    {
      if (Branch.GetRBidByRegID(Convert.ToInt32(DDLReg.SelectedValue)) != -1)
      {
        LDdlError.Text = "This Region Already have a Regional Branch";
        LDdlError.Visible = true;
        HFalreadyExists.Value = "true";
      }
      else
      {
        LDdlError.Visible = false;
        HFalreadyExists.Value = "false";
      }
    }

    protected void Submit(object sender, EventArgs e)
    {
      if (Page.IsValid && !Convert.ToBoolean(HFalreadyExists.Value))
      {
        int regid = Convert.ToInt32(DDLReg.SelectedValue);
        string Bname = TBRegBname.Text.Trim();
        string Baddr = TBRegBaddr.Text.Trim();
        double lat = Convert.ToDouble(TBLat.Text.Trim());
        double lon = Convert.ToDouble(TBLong.Text.Trim());

        if (Branch.CountB(Bname, Baddr, lat, lon) == 0)
        {

          int rbid = Branch.CreateRegBranch(regid, Bname, Baddr, lat, lon);
          if (rbid != -1)
          {
            LErr.Text = "Regional Branch Created with Regional Branch ID : " + rbid;
            LErr.ForeColor = System.Drawing.Color.Green;
            PError.Style.Add("border", "2px solid lightgreen");
            PError.Visible = true;
          }
          else
          {
            LErr.Text = "Regional Branch Creation FAILED, please contact system administratior !";
            LErr.ForeColor = System.Drawing.Color.Red;
            PError.Style.Add("border", "2px solid lightred");
            PError.Visible = true;
          }
        }
        else
        {
          LErr.Text = "Branch Name/Branch Address/Latetude/Longitude Already Present ! Contact Administrator or try with another one";
          LErr.ForeColor = System.Drawing.Color.Red;
          PError.Style.Add("border", "2px solid lightred");
          PError.Visible = true;
        }
      }
      else
      {
        LErr.Text = "Validation Error! Data Not Saved";
        LErr.ForeColor = System.Drawing.Color.Red;
        PError.Style.Add("border", "2px solid lightred");
        PError.Visible = true;
        return;
      }
    }
    protected void HidePErr(object sender, EventArgs e)
    {
      PError.Visible = false;
    }

    protected void OBSRegB_Updated(object sender, ObjectDataSourceStatusEventArgs e)
    {
      if (e.ReturnValue is int && (int)e.ReturnValue > 0)
      {
        e.AffectedRows = (int)e.ReturnValue;
      }
    }

    protected void GVRegB_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
      if (e.AffectedRows < 1)
      {
        e.KeepInEditMode = true;
        LErr.Text = "Row with Regonal Branch ID :" + e.Keys[0].ToString() + " is not Updated Due to Data Conflict ";
        LErr.ForeColor = System.Drawing.Color.Red;
        PError.Style.Add("border", "2px solid lightRed");
        PError.Visible = true;
      }
      else
      {
        LErr.Text = "Row with Regonal Branch ID :" + e.Keys[0].ToString() + " is Updated Successflly";
        LErr.ForeColor = System.Drawing.Color.SteelBlue;
        PError.Style.Add("border", "2px solid Navy");
        PError.Visible = true;
      }
    }
  }
}