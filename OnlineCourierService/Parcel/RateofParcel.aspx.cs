using OnlineCourierService.Class;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService.Parcel
{
    public partial class RateofParcel : System.Web.UI.Page
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
                    Puser.Visible = true;

                    cus.FillData();
                    Aname.Text = cus.name;
                    if (cus.imgurl != null)
                    {
                        ProundedDP.Style.Add("background-image", cus.imgurl);
                    }
                }
            }
        }

        protected void Logout(object sender, EventArgs e)
        {
            Session.Remove("LightCus");
            Response.Redirect("~/index.aspx");
        }
    }
}