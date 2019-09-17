using OnlineCourierService.Class;
using OnlineCourierService.employee.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService.employee.EmploeeLinks
{
    public partial class ECreateParcel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private void Notifyuser(string msg, bool isSuccessful)
        {
            if (isSuccessful)
            {
                Lerrmsg.Text = msg;
                Lerrmsg.Style.Add("color", "Navy");
                Perrormsg.Style.Add("border", "2px solid Navy");
            }
            else
            {
                Lerrmsg.Text = msg;
                Lerrmsg.Style.Add("color", "Red");
                Perrormsg.Style.Add("border", "2px solid lightred");
            }
            Perrormsg.Style.Add("display", "block");
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

        protected void Bsubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string parcelType = DDLPtype.SelectedValue;
                string paymentMethod = DDLPaymentM.SelectedValue;
                double weight = Convert.ToDouble(TBPweight.Text.Trim());
                SenderReceiver Sender, Receiver;

                Sender = new SenderReceiver("-1", TBsName.Text.Trim(), TBsEmail.Text.Trim(), TBsAddr.Text.Trim());
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

        protected void LBcancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/index.aspx");
        }













    }
}