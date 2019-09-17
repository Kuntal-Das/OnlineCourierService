using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService.employee.EmploeeLinks
{
    public partial class EUpdateParcel : System.Web.UI.Page
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

        protected void RBLparcel_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (RBLparcel.SelectedIndex == 0)
            {
                P0.Visible = true;
                P1.Visible =P2.Visible = P3.Visible = false;
            }
            else if (RBLparcel.SelectedIndex == 1)
            {
                P1.Visible = true;
                P0.Visible =P2.Visible = P3.Visible = false;
            }
            else if (RBLparcel.SelectedIndex == 2)
            {
                P2.Visible = true;
                P1.Visible = P0.Visible = P3.Visible = false;
            }
            else if (RBLparcel.SelectedIndex == 3)
            {
                P3.Visible = true;
                P1.Visible = P2.Visible = P0.Visible = false;
            }
        }
    }
}