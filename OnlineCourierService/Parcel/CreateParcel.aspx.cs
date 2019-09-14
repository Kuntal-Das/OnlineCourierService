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
        string link, package=null;
        protected void Page_Load(object sender, EventArgs e)
        {
            bool redirect = true;
            if (Request.QueryString["Redirect"] != null)
            {
                try { redirect = Convert.ToBoolean(Request.QueryString["Redirect"]); }
                catch (Exception) { Response.Redirect("~/Parcel/CreateParcel.aspx?redirect=false"); }
            }
            link = HttpContext.Current.Request.Url.AbsolutePath;
            Customer cus;
            if (!IsPostBack)
            {
                if (Request.QueryString["parcel"] != null)
                {
                    package = Request.QueryString["parcel"];
                    try
                    {
                        DDLPtype.SelectedValue = package;
                        DDLPtype.BorderColor = System.Drawing.Color.Cyan;
                        TogglePFood();
                    }
                    catch (Exception)
                    {
                        Notifyuser("Somthing Happened Wrong! We are looking into it", false);
                    }
                }
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
                    TBPweight.Enabled = TBsName.Enabled = TBsEmail.Enabled =
                        TBsAddr.Enabled = TBrName.Enabled = TBrEmail.Enabled =
                        TBrAddr.Enabled = TBfood.Enabled = false;
                }
                else if (redirect)
                {
                    HttpCookie cookie = new HttpCookie("redirectLink");
                    cookie["link"] = "~" + link;
                    if (package != null)
                    {
                        cookie["qstr"] = "?parcel=" + package;
                    }
                    Response.Cookies.Add(cookie);
                    Server.Transfer("~/LoginPopup.aspx");
                }
                else
                {
                    Psender.Visible = false;
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
            Response.Cookies.Add(new HttpCookie("redirectLink", "~" + link));
            Server.Transfer("~/LoginPopup.aspx");
        }

        protected void DDLsReg_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadsBranch();
            DDLsbranch.Focus();
        }
        private void LoadsBranch()
        {
            long rid = Convert.ToInt64(DDLsReg.SelectedValue);
            if (rid != -1)
            {
                DDLsbranch.DataSource = DataAccessLayer.GetBranchByRid((int)rid);
                DDLsbranch.DataTextField = "BName";
                DDLsbranch.DataValueField = "Bid";
                DDLsbranch.DataBind();
            }
        }

        protected void DDLrReg_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadrBranch();
            DDLrbranch.Focus();
        }
        private void LoadrBranch()
        {
            long rid = Convert.ToInt64(DDLrReg.SelectedValue);
            if (rid != -1)
            {
                DDLrbranch.DataSource = DataAccessLayer.GetBranchByRid((int)rid);
                DDLrbranch.DataTextField = "BName";
                DDLrbranch.DataValueField = "Bid";
                DDLrbranch.DataBind();
            }
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
                else if (DDLpackage.SelectedIndex == 1)//&& PFood.Visible
                {
                    PFood.Visible = false;
                }
            }
            else if (DDLPtype.SelectedValue != "CookedFood" && DDLPtype.SelectedValue != "DryFood")
            {
                if (PFood.Visible)
                {
                    PFood.Visible = false;
                }
            }
        }

        protected void BRec_Click(object sender, EventArgs e)
        {
            if (TBORemail.Text != null)
            {
                string Recemail = TBORemail.Text.Trim();
                Customer cus = null;
                if (Session["LightCus"] != null)
                {
                    cus = new Customer(Session["LightCus"].ToString(), true);
                    cus.FillData();
                }
                else
                {
                    Server.Transfer("~/Parcel/CreateParcel.aspx");
                }
                if (cus.email.Equals(Recemail))
                {
                    Notifyuser("Do not Enter Your Email Address !", false);
                    return;
                }
                if (Customer.CountCustomer(Recemail) != 1)
                {
                    Notifyuser("Entered Email Address is not Registered in Our Website!", false);
                    return;
                }
                HFSender.Value = TBORemail.Text.Trim();
            }
            Psender.Visible = false;
            TBPweight.Enabled = TBsName.Enabled = TBsEmail.Enabled =
                        TBsAddr.Enabled = TBrName.Enabled = TBrEmail.Enabled =
                        TBrAddr.Enabled = TBfood.Enabled = true;

            LoadSender(new Customer(Session["LightCus"].ToString(), true));
            LoadReceiver(Customer.GetinfoByEmail(TBORemail.Text.Trim()));
        }

        protected void LBRecC_Click(object sender, EventArgs e)
        {
            Psender.Visible = false;
            TBPweight.Enabled = TBsName.Enabled = TBsEmail.Enabled =
                        TBsAddr.Enabled = TBrName.Enabled = TBrEmail.Enabled =
                        TBrAddr.Enabled = true;
            LoadSender(new Customer(Session["LightCus"].ToString(), true));
        }
        private void LoadSender(Customer sen)
        {
            sen.FillData();
            TBsName.Text = sen.name;
            TBsEmail.Text = sen.email;
            TBsAddr.Text = sen.address;
            DDLsReg.SelectedValue = Branch.GetRidbyBid(sen.BID).ToString();
            LoadsBranch();
            DDLsbranch.SelectedValue = sen.BID.ToString();
        }
        private void LoadReceiver(Customer rec)
        {
            rec.FillData();
            TBrName.Text = rec.name;
            TBrEmail.Text = rec.email;
            TBrAddr.Text = rec.address;
            DDLrReg.SelectedValue = Branch.GetRidbyBid(rec.BID).ToString();
            LoadrBranch();
            DDLrbranch.SelectedValue = rec.BID.ToString();
        }

        protected void Bsubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string parcelType = DDLPtype.SelectedValue;
                string paymentMethod = DDLPaymentM.SelectedValue;
                double weight = Convert.ToDouble(TBPweight.Text.Trim());
                SenderReceiver Sender, Receiver;
                if (Session["LightCus"] != null)
                {
                    Sender = new SenderReceiver(Session["LightCus"].ToString(), TBsName.Text.Trim(), TBsEmail.Text.Trim(), TBsAddr.Text.Trim());
                }
                else
                {
                    Sender = new SenderReceiver("-1", TBsName.Text.Trim(), TBsEmail.Text.Trim(), TBsAddr.Text.Trim());
                }
                Receiver = new SenderReceiver("-1", TBrName.Text.Trim(), TBrEmail.Text.Trim(), TBrAddr.Text.Trim());

                long sBID = Convert.ToInt64(DDLsbranch.SelectedValue);
                long sRID = Convert.ToInt64(DDLsReg.SelectedValue);

                long rBID = Convert.ToInt64(DDLrbranch.SelectedValue);
                long rRID = Convert.ToInt64(DDLrReg.SelectedValue);

                int PackagingByCustomer = Convert.ToInt32(DDLpackage.SelectedValue);
                int container;
                if (PFood.Visible) { container = Convert.ToInt32(TBfood.Text.Trim()); }
                else { container = -1; }

                Package p = new Package(parcelType, weight, Sender, Receiver, sBID, rBID, sRID, rRID, 0, 0, paymentMethod, "Pending", PackagingByCustomer, container);
                string plid = p.insertPackage();
                if (plid == null)
                {
                    Notifyuser("Parcel Request Creation Failed! Try Again Later", false);
                    return;
                }
                Notifyuser("Parcel Request Placed Successfully with ID: \"" + plid + "\" Note it Down if Your are Not a Registered User", true);
            }
            else
            {
                Notifyuser("Validation Error, Data Not Saved", false);
                return;
            }
        }
    }
}