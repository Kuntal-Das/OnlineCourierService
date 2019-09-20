using OnlineCourierService.employee.Classes;
using System;

namespace OnlineCourierService.employee
{
  public partial class admin : System.Web.UI.Page
  {
    private Employee emp;
    private String id;
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
          ProundedDP.Style.Add("background-image", "url('" + imgurl + "')");
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

    protected void DDLpage_SelectedIndexChanged(object sender, EventArgs e)
    {
      if (DDLpage.SelectedValue.Equals("Admin"))
      {
        if (Session["LightAdm"] == null)
        {
          Session["LightAdm"] = Session["LightEmp"];
        }
        Response.Redirect("~/employee/admin.aspx");
      }
      else if (DDLpage.SelectedValue.Equals("Employee"))
      {
        if (Session["LightEmp"] == null)
        {
          Session["LightEmp"] = Session["LightAdm"];
        }
        Response.Redirect("~/employee/emp.aspx");
      }
    }
  }
}