using OnlineCourierService.employee.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService.employee
{
  public partial class login : System.Web.UI.Page
  {
    private Employee emp;
    public string name
    {
      get
      {
        return Aname.Text.Trim();
      }
    }
    protected void Page_Load(object sender, EventArgs e){}

    protected void getUser(object sender, EventArgs e)
    {
      String user = Aname.Text.Trim();
      try
      {
        emp = new Employee(Convert.ToInt64(user));
      }
      catch (Exception)
      {
        emp = new Employee(user);
      }
      finally
      {
        UsernameError.Text = "\"" + user + "\" not found to be registered";
        UsernameError.Visible = true;
      }
      emp.Filldata();
      int count = emp.CountbyEmailorphno();

      if (count == 1)
      {
        //Server.Transfer("./password.aspx");
        Response.Redirect("./password.aspx?user=" + user);
      }
      else
      {
        UsernameError.Text = "\"" + user + "\" not found to be registered";
        UsernameError.Visible = true;
      }
    }
  }
}