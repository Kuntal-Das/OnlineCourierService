using OnlineCourierService.employee.Classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace OnlineCourierService.employee
{
    public partial class notification : System.Web.UI.Page
    {
        private String id;
        private Employee emp;
        protected void Page_Load(object sender, EventArgs e)
        {
                try
                {
                    id = Session["LightAdm"].ToString();
                    emp = new Employee(Convert.ToInt32(id));
                    emp.Filldata();

                    if (emp.IsAdmin())
                    {
                        logo.NavigateUrl = hlhome.NavigateUrl = "~/employee/admin.aspx";
                    }
                    else
                    {
                        logo.NavigateUrl = hlhome.NavigateUrl = "~/employee/emp.aspx";
                    }
                }
                catch (Exception)
                {
                    Response.Redirect("./login.aspx");
                }
                if (id.Equals(null))
                {
                    Response.Redirect("./login.aspx");
                }
            string imgurl = emp.LoadImage();
                if (imgurl != null)
                {
                    ProundedDP.Style.Add("background-image", "url(" + imgurl + ")");
                }
            Aname.Text = emp.name;
            LoadNotifications(emp.GetNotifications());
        }

        private void LoadNotifications(DataTable data)
        {
            foreach (DataRow row in data.Rows)
            {
                if (row.Field<int>("unread") == 1)
                {
                    Panel1.Controls.Add(CreateNotificationDiv(row,"note"));
                }
                if (row.Field<int>("unread") == -1)
                {
                    Panel1.Controls.Add(CreateNotificationDiv(row, "note read"));
                }
                //foreach (DataColumn column in data.Columns){Response.Write(row[column]);}
            }
        }

        private HtmlGenericControl CreateNotificationDiv(DataRow row,String divclass)
        {
            HyperLink link = new HyperLink();
            link.ID = "Hlink" + row.Field<int>("count");
            link.CssClass = "link";
            link.Text = "More Details...";
            link.NavigateUrl = row.Field<String>("onclick");

            HtmlGenericControl span = new HtmlGenericControl("span");
            span.Attributes.Add("class", "time");
            span.InnerText = row.Field<DateTime>("Timestamp").ToString();


            HtmlGenericControl h3 = new HtmlGenericControl("h3");
            h3.Attributes.Add("class", "text");
            h3.InnerText = row.Field<String>("notification");

            HtmlGenericControl div = new HtmlGenericControl("div");
            div.Attributes.Add("class", divclass);

            div.Controls.Add(h3);
            div.Controls.Add(span);
            div.Controls.Add(link);

            return div;
        }
        protected void Logout(object sender, EventArgs e)
        {
            Session.Remove("LightAdm");
            Response.Redirect("./login.aspx");
        }
    }
}