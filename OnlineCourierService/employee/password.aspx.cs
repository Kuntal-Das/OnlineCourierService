using OnlineCourierService.employee.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService.employee
{
    public partial class password : System.Web.UI.Page
    {
        private string euser;
        private string epass;
        private int id;
        private Employee emp;
        protected void Page_Load(object sender, EventArgs e)
        {
            euser = Request.QueryString["user"];
            if (!IsPostBack)
            {
                login prevPage = this.PreviousPage;
                if (prevPage != null)
                {
                    euser = prevPage.name;
                }
                try
                {
                    if (euser.Equals(null))
                    {
                        Response.Redirect("./login.aspx");
                    }
                    //HttpCookie cookie = new HttpCookie("User",euser);
                    //cookie["Name"] = euser;
                    //Response.Cookies.Add(cookie);

                    adminName.Text = "Give Password for : " + euser;
                    adminName.Enabled = adminName.Visible = true;
                }
                catch (NullReferenceException)
                {
                    Response.Redirect("~/employee/login.aspx");
                }
                catch (Exception)
                {
                    Response.Redirect("~/employee/login.aspx");
                }
            }
        }

        protected void logIn(object sender, EventArgs e)
        {
            try
            {
                emp = new Employee(Convert.ToInt64(euser));
            }
            catch (FormatException)
            {
                emp = new Employee(euser);
            }
            epass = Apass.Text.Trim();
            emp.Filldata();
            this.id = emp.CheckPassword(epass);
            if (id >=1000)
            {

                if (emp.IsAdmin())
                {
                    Session["LightAdm"] = id.ToString();
                    Response.Redirect("~/employee/admin.aspx");
                }
                else
                {
                    Session["LightEmp"] = id.ToString();
                    Response.Redirect("~/employee/emp.aspx");
                }
            }
            else
            {
                status.Text = "Wrong Password Entered";
                status.Visible = true;
                forgotPass.Visible = true;
            }
        }
    }
}