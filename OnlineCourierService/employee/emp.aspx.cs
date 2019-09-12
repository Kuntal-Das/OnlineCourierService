using OnlineCourierService.employee.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService.employee
{
    public partial class emp : System.Web.UI.Page
    {
        private Employee emp1;
        private String id;
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
            if (emp1.IsAdmin())
            {
                Ppage.Visible = true;
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

        protected void DDLpage_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDLpage.SelectedValue.Equals("Admin"))
            {
                if (Session["LightAdm"] == null)
                {
                    Session["LightAdm"] = Session["LightEmp"];
                }
                //Session.Remove("LightEmp");
                Response.Redirect("~/employee/admin.aspx");
            }
            else if (DDLpage.SelectedValue.Equals("Employee"))
            {
                if (Session["LightEmp"] == null)
                {
                    Session["LightEmp"] = Session["LightAdm"];
                }
                //Session.Remove("LightAdm");
                Response.Redirect("~/employee/emp.aspx");
            }
        }
    }
}