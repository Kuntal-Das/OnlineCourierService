using OnlineCourierService.employee.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService.employee
{
    public partial class EresetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string guid = Request.QueryString["uid"];
            if (guid == null)
            {
                Notifyuser("Password Reset link has expired or is invalid", false);
                TBCnewPass.Enabled = TBnewPass.Enabled = BcngP.Enabled = false;
                return;
            }
            if (!IsPostBack)
            {
                long Eid = Employee.isPasswordResetLinkValid(guid);
                if (Eid < 1000)
                {
                    Notifyuser("Password Reset link has expired or is invalid", false);
                    TBCnewPass.Enabled = TBnewPass.Enabled = BcngP.Enabled = false;
                    return;
                }
                Employee Emp = new Employee((int)Eid);
                Emp.Filldata();
                Luser.Text += " for " + Emp.Email;
                Session.Add("EValidGUID", true);

            }
        }
        private void Notifyuser(string msg, bool issuccessful)
        {
            if (!Convert.ToBoolean(Session["EValidGUID"]))
            {
                Notifyuser("Update Password Failed !", false);
                return;
            }
            if (issuccessful)
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
        protected void BcngP_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (Employee.ResetPassword(Request.QueryString["uid"], TBCnewPass.Text.Trim()) != 1)
                {
                    Notifyuser("Update Password Failed !", false);
                    return;
                }
                Notifyuser("Password Changed Successfully!", true);
            }
            else
            {
                Notifyuser("Validation Error, Try Again Later", false);
                return;
            }
        }
    }
}