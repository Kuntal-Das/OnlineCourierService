using OnlineCourierService.Class;
using OnlineCourierService.employee.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService.Parcel
{
    public partial class CreateParcel : System.Web.UI.Page
    {
        static string link;
        protected void Page_Load(object sender, EventArgs e)
        {
            bool redirect = true;
            if (Request.QueryString["Redirect"] != null)
            {
                redirect = Convert.ToBoolean(Request.QueryString["Redirect"]);
            }
            link = HttpContext.Current.Request.Url.AbsolutePath;
            Customer cus;
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
                else if (redirect)
                {
                    Response.Cookies.Add(new HttpCookie("redirectLink", "~" + link));
                    Server.Transfer("~/LoginPopup.aspx");
                }
            }
        }
        protected void Logout(object sender, EventArgs e)
        {
            Session.Remove("LightCus");
            Response.Redirect("~/index.aspx");
        }

        protected void LoginSignIn_Click(object sender, EventArgs e)
        {
            Response.Cookies.Add(new HttpCookie("redirectLink", "~" + link));
            Server.Transfer("~/LoginPopup.aspx");
        }

        protected void DDLsReg_SelectedIndexChanged(object sender, EventArgs e)
        {
            long rid = Convert.ToInt64(DDLsReg.SelectedValue);
            if (rid != -1)
            {
                DDLsbranch.DataSource = DataAccessLayer.GetBranchByRid((int)rid);
                DDLsbranch.DataTextField = "BName";
                DDLsbranch.DataValueField = "Bid";
                DDLsbranch.DataBind();
            }
            DDLsbranch.Focus();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            long rid = Convert.ToInt64(DDLrReg.SelectedValue);
            if (rid != -1)
            {
                DDLrbranch.DataSource = DataAccessLayer.GetBranchByRid((int)rid);
                DDLrbranch.DataTextField = "BName";
                DDLrbranch.DataValueField = "Bid";
                DDLrbranch.DataBind();
            }
            DDLrbranch.Focus();
        }

        protected void DDLPtype_SelectedIndexChanged(object sender, EventArgs e)
        {
            TogglePFood();
            DDLPtype.Focus();
        }
        protected void DDLpackage_SelectedIndexChanged(object sender, EventArgs e)
        {
            TogglePFood();
            DDLpackage.Focus();
        }


        private void TogglePFood()
        {
            if (DDLPtype.SelectedValue == "CookedFood" || DDLPtype.SelectedValue == "DryFood") 
            {
                if (DDLpackage.SelectedIndex == 0)//&& !PFood.Visible
                {
                    PFood.Visible = true;
                }
                else if(DDLpackage.SelectedIndex == 1)//&& PFood.Visible
                {
                    PFood.Visible = false;
                }
            }
            else if (DDLPtype.SelectedValue != "CookedFood" && DDLPtype.SelectedValue != "DryFood")
            {
                if (DDLpackage.SelectedIndex == 1)//&& PFood.Visible
                {
                    PFood.Visible = false;
                }else if (DDLpackage.SelectedIndex == 0)//&& !PFood.Visible
                {
                    PFood.Visible = true;
                }
            }
        }

    }
}