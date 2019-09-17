using OnlineCourierService.Class;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService.employee.EmploeeLinks
{
    public partial class EtrackParcel : System.Web.UI.Page
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
        private void LoadSrcResult()
        {

            GVsrcParcel.DataSource = Package.GetParcelsByPLID(TBsrcPLID.Text.Trim());
            GVsrcParcel.DataBind();

        }
        protected void Bsrc_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            { LoadSrcResult(); }
            else
            {
                Notifyuser("Validation Error Search Not Completed", false);
                return;
            }
        }





    }
}