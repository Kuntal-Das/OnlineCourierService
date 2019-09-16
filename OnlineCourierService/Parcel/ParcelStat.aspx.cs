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
                if (Request.QueryString["PLID"] != null)
                {
                    LoadData(Request.QueryString["PLID"]);
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

        private void LoadData(string PLID)
        {
            Package parcel = new Package(PLID);
            parcel.FillData();
            LPLID.Text += PLID;
            LPtype.Text += parcel.ParcelType;
            LPweight.Text += parcel.Weight + "KG";
            LPRdate.Text += parcel.ReqDate;
            LPpackaging.Text += (parcel.PackagingByCustomer == 0) ? "Customer" : "Lightning Corp";
            if (parcel.Container != -1)
            {
                LPcontainer.Visible = true;
                LPcontainer.Text += parcel.Container;
            }
            if (parcel.Distance == 0)
            {
                LPDistance.Text += "Yet to Be calculated";
                LPinvoicePrice.Text += "Yet to Be calculated";
                LPpaymentDate.Text += "Unknown";
            }
            else
            {
                LPDistance.Text += "About " + parcel.Distance + "KM";
                LPinvoicePrice.Text += "Rs." + parcel.invoicePrice;
                LPpaymentDate.Text += parcel.PayDate;
            }
            LPpaymentStat.Text += parcel.PaymentStatus;
            LPpaymentMethod.Text += parcel.PaymentMethod;

            LSname.Text += parcel.Sender.Name;
            LSaddress.Text += parcel.Sender.Address;
            LSemail.Text += parcel.Sender.Email;
            if (parcel.Sender.CID == "-1")
            {
                LSisRegistered.Text += "No";
            }
            else
            {
                LSisRegistered.Text += "Yes";
                Customer rec = Customer.GetinfoByEmail(parcel.Sender.Email);
                LSphno.Visible = true;
                LSphno.Text += rec.phno;
            }
            LRname.Text += parcel.Receiver.Name;
            LRaddress.Text += parcel.Receiver.Address;
            LRemail.Text += parcel.Receiver.Email;
            if (parcel.Receiver.CID == "-1")
            {
                LRisRegistered.Text += "no";
            }
            else
            {
                LRisRegistered.Text += "Yes";
                Customer rec = Customer.GetinfoByEmail(parcel.Receiver.Email);
                LRphno.Visible = true;
                LRphno.Text += rec.phno;
            }

            if (parcel.SourceRID == -1)
            {
                PrCP2.Visible = false;
                PsCP2.Visible = false;
            }
            if (parcel.DestRID == -1)
            {
                PrCP3.Visible = false;
                PsCP3.Visible = false;
            }
            if (parcel.SourceBID == parcel.DestBID)
            {
                PrCP4.Visible = false;
            }

            if (parcel.statuslist.Count != 0)
            {

            }
        }


    }
}