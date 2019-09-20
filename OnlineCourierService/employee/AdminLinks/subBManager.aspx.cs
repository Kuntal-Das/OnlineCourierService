using OnlineCourierService.employee.Classes;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService.employee.AdminLinks
{
  public partial class subBManager : System.Web.UI.Page
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
    protected void HidePErr(object sender, EventArgs e)
    {
      PError.Visible = false;
    }

    protected void Createb(object sender, EventArgs e)
    {
      LBCreateB.CssClass = "tab active";
      LBSrcB.CssClass = "tab";
      PCreateB.Visible = true;
      PSrcB.Visible = false;
    }

    protected void Srcb(object sender, EventArgs e)
    {
      LBSrcB.CssClass = "tab active";
      LBCreateB.CssClass = "tab";
      PSrcB.Visible = true;
      PCreateB.Visible = false;
    }

    protected void SaveChanges(object sender, EventArgs e)
    {
      if (Page.IsValid)
      {
        long rid = Convert.ToInt64(DDLRegB.SelectedValue);
        string Bname = TBSubBname.Text.Trim();
        string Baddr = TBSubBaddr.Text.Trim();
        double lat = Convert.ToDouble(TBLat.Text.Trim());
        double lon = Convert.ToDouble(TBLong.Text.Trim());

        if (Branch.CountB(Bname, Baddr, lat, lon) == 0)
        {
          int rbid = Branch.CreateSubBranch(rid, Bname, Baddr, lat, lon);

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
        PError.Visible = true;
        return;
      }
    }

    protected void OBSSubB_Updated(object sender, ObjectDataSourceStatusEventArgs e)
    {
      if (e.ReturnValue is int && (int)e.ReturnValue > 0)
      {
        e.AffectedRows = (int)e.ReturnValue;
      }
    }

    protected void GVSubB_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
      if (e.AffectedRows < 1)
      {
        e.KeepInEditMode = true;
        LErr.Text = "Row with Sub-Branch ID :" + e.Keys[0].ToString() + " is not Updated Due to Data Conflict ";
        LErr.ForeColor = System.Drawing.Color.Red;
        PError.Style.Add("border", "2px solid lightRed");
        PError.Visible = true;
      }
      else
      {
        LErr.Text = "Row with Sub-Branch ID :" + e.Keys[0].ToString() + " is Updated Successflly";
        LErr.ForeColor = System.Drawing.Color.SteelBlue;
        PError.Style.Add("border", "2px solid Navy");
        PError.Visible = true;
      }
    }
  }
}