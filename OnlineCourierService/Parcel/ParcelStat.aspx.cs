using OnlineCourierService.Class;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService.Parcel
{
    public partial class ParcelStat : System.Web.UI.Page
    {
        private Customer cus;
        private string link;
        protected void Page_Load(object sender, EventArgs e)
        {
            link = HttpContext.Current.Request.Url.AbsolutePath;
            if (!IsPostBack)
            {
                if (Session["LightCus"] != null)
                {
                    string CID = Session["LightCus"].ToString();
                    cus = new Customer(CID, true);
                    LoginSignIn.Visible = false;
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
        private void Notifyuser(string msg, bool isSuccessful)
        {
            if (isSuccessful)
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
        protected void Logout(object sender, EventArgs e)
        {
            Session.Remove("LightCus");
            Response.Redirect("~/index.aspx");
        }
        protected void LoginSignIn_Click(object sender, EventArgs e)
        {
            HttpCookie cookie = new HttpCookie("redirectLink");
            cookie["link"] = "~" + link;
            cookie.Expires = DateTime.Now.AddMinutes(5);
            Response.Cookies.Add(cookie);
            Server.Transfer("~/LoginPopup.aspx");
        }


    }
}