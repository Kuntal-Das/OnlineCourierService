using OnlineCourierService.employee.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService.employee.EmploeeLinks
{
    public partial class EmployeeLink : System.Web.UI.MasterPage
    {
        string id;
        Employee emp1;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                id = Session["LightEmp"].ToString();
                emp1 = new Employee(Convert.ToInt32(id));
                emp1.Filldata();
            }
            catch (Exception)
            {
                Response.Redirect("~/employee/login.aspx");
            }

            if (id.Equals(null))
            {
                Response.Redirect("~/employee/login.aspx");
            }
            if (!IsPostBack)
            {
                Aname.Text = emp1.name;
                string imgurl = emp1.LoadImage();
                if (imgurl != null)
                {
                    ProundedDP.Style.Add("background-image", "url('" + imgurl + "')");
                }
            }
        }
        protected void Logout(object sender, EventArgs e)
        {
            Session.Remove("LightEmp");
            if (Session["LightAdm"] != null)
            {
                Session.Remove("LightAdm");
            }
            Response.Redirect("~/employee/login.aspx");
        }



    }
}