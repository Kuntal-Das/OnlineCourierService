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
        string link, query = null;
        Customer cus;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["LightCus"] != null)
                {
                    string CID = Session["LightCus"].ToString();
                    cus = new Customer(CID, true);
                    cus.FillData();
                    if (cus.email != null)
                    {
                        if (Request.Cookies["redirectLink"] == null)
                        {
                            link = "~/index.aspx";
                        }
                        else
                        {
                            HttpCookie cookie = Request.Cookies["redirectLink"];
                            link = cookie["link"];
                            query = (cookie["qstr"] == null) ? "" : cookie["qstr"];
                        }
                        Response.Redirect(link + query);
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
            HttpCookie cookie = Request.Cookies["redirectLink"];
            link = cookie["link"];
            query = (cookie["qstr"] == null) ? "" : cookie["qstr"];

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
                Response.Redirect(link + query);
            }
            else
            {
                Notifyuser("Validation Error, Data Not Saved", false);
            }
        }
        protected void LBskip_Click(object sender, EventArgs e)
        {
            HttpCookie cookie = Request.Cookies["redirectLink"];
            link = cookie["link"];
            if (cookie["qstr"] == null)
            {
                Response.Redirect(link + "?Redirect=false");
            }
            else
            {
                query = cookie["qstr"];
                Response.Redirect(link + query+"&Redirect=false");
            }
        }


    }
}