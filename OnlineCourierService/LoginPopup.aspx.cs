using OnlineCourierService.Class;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService
{
    public partial class LoginPopup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Customer cus;
            if (!IsPostBack)
            {
                if (Session["LightCus"] != null)
                {
                    string CID = Session["LightCus"].ToString();
                    cus = new Customer(CID, true);
                    cus.FillData();
                    if (cus.email != null)
                    {
                        string link = (Request.Cookies["redirectLink"] == null) ? "~/index.aspx" : Request.Cookies["redirectLink"].Value;
                        Response.Redirect(link);
                    }
                }
            }
        }
        private void Notifyuser(string msg, bool issuccessful)
        {
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
        protected void Blogin_Click(object sender, EventArgs e)
        {
            string link = (Request.Cookies["redirectLink"] == null) ? "~/index.aspx" : Request.Cookies["redirectLink"].Value;

            if (Page.IsValid)
            {
                string CID = null;
                Customer Cus;
                try
                {
                    Cus = new Customer(Convert.ToInt64(TBunm.Text.Trim()));
                }
                catch (FormatException)
                {
                    Cus = new Customer(TBunm.Text.Trim());
                }
                CID = Cus.GetCIDbyPass(TBpas.Text.Trim());
                if (CID == null)
                {
                    Notifyuser("Email/Phone Number or Password Do not Match", false);
                    return;
                }
                Session["LightCus"] = CID;
                Response.Redirect(link);
            }
            else
            {
                Notifyuser("Validation Error, Data Not Saved", false);
            }
        }
        protected void LBskip_Click(object sender, EventArgs e)
        {
            string link = (Request.Cookies["redirectLink"] == null) ? "~/index.aspx" : Request.Cookies["redirectLink"].Value;
            Response.Redirect(link+ "?Redirect=false");
        }


    }
}