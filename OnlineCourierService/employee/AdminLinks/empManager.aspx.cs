using OnlineCourierService.employee.Classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineCourierService.employee.AdminLinks
{
    public partial class empManager : System.Web.UI.Page
    {
        private string eid;
        private Employee emp;
        //private long OLD_EID, OLD_BID;
        //private int OLD_POSTINDEX;
        //private string OLD_status;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                eid = Session["LightAdm"].ToString();
                emp = new Employee(Convert.ToInt32(eid));
                emp.Filldata();

                Aname.Text = emp.name;
            }
            catch (Exception)
            {
                Response.Redirect("~/employee/login.aspx");
            }
            if (eid.Equals(null) || !emp.IsAdmin())
            {
                Response.Redirect("~/employee/login.aspx");
            }
            if (!IsPostBack)
            {
                string imgurl = emp.LoadImage();
                if (imgurl != null)
                {
                    ProundedDP.Style.Add("background-image", "url(" + imgurl + ")");
                }
            }
        }

        protected void Logout(object sender, EventArgs e)
        {
            Session.Remove("LightAdm");
            if (Session["LightEmp"] != null)
            {
                Session.Remove("LightEmp");
            }
            Response.Redirect("~/employee/login.aspx");
        }
        protected void CreateEmp(object sender, EventArgs e)
        {
            LBCreateEmp.CssClass = "tab active";
            LBSrcEmp.CssClass = "tab";
            PcreateEmp.Visible = true;
            PsrcEmp.Visible = false;
        }

        protected void SrcEmp(object sender, EventArgs e)
        {
            LBCreateEmp.CssClass = "tab";
            LBSrcEmp.CssClass = "tab active";
            PsrcEmp.Visible = true;
            PcreateEmp.Visible = false;
        }

        protected void SaveChanges(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string name = TBname.Text.Trim();
                string addr = TBAddr.Text.Trim();
                string gender = RBLgenger.SelectedValue;
                DateTime dob = DateTime.Parse(TBdob.Text);
                string email = TBemail.Text.Trim();
                long phno = Convert.ToInt64(TBphno.Text.Trim());
                long bid = Convert.ToInt64(DDLbranch.SelectedValue);
                int postindex = Convert.ToInt32(DDLpost.SelectedValue);

                HttpPostedFile image = FUprofileImg.PostedFile;

                Employee newemp = new Employee(name, addr, gender, email, dob, bid, phno, "N0password", postindex, true);

                if (Employee.CountByEmail(email) != 0)
                {
                    LErr.Text = "Same Email is Already Registered";
                    PError.Visible = true;
                    PError.Style.Add("border", "2px solid red");
                    return;
                }
                if (Employee.CountByPhone(phno) != 0)
                {
                    LErr.Text = "Same Phone No is Already Registered";
                    PError.Visible = true;
                    PError.Style.Add("border", "2px solid red");
                    return;
                }
                if (!image.FileName.Equals(""))
                {
                    string fileExtennsion = Path.GetExtension(image.FileName).ToLower();
                    if (fileExtennsion != ".jpg" && fileExtennsion != ".jpeg" && fileExtennsion != ".png")
                    {
                        LErr.Text = "Only images(.jpg, .png, .jpeg) can be uploaded";
                        PError.Visible = true;
                        PError.Style.Add("border", "2px solid red");
                        return;
                    }
                    goto INSERT;
                }
            INSERT:
                string id = Convert.ToString(newemp.InsertInfo());
                newemp.InsertImage(image);
                LErr.Text = "Successful! Account Created With Employee ID :" + id + " and Default password";
                PError.Style.Add("border", "2px solid lightgreen");
                PError.Visible = true;


            }
            else
            {
                LErr.Text = "Validation Failed! Data Not Saved";
                PError.Style.Add("border", "2px solid red");
                PError.Visible = true;
                return;
            }
        }

        protected void HidePErr(object sender, EventArgs e)
        {
            PError.Visible = false;
        }

        protected void ChangeSrchbehavior(object sender, EventArgs e)
        {
            if (DDlsrchbby.SelectedValue.ToString().Equals("EID"))
            {
                RFVpostSrc.Visible = DDLSrcPost.Visible = false;
                TBsrc.Text = String.Empty;
            }else if (DDlsrchbby.SelectedValue.ToString().Equals("BID"))
            {
                RFVpostSrc.Visible = DDLSrcPost.Visible = true;
                TBsrc.Text = String.Empty;
            }
        }
        
        protected void SearchByEid(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                LoadGVDataByEid();
            }
            else
            {
                LErr.Text = "Validation Error Search Not Performed";
                LErr.ForeColor = System.Drawing.Color.Red;
                PError.Style.Add("border", "2px solid lightRed");
                PError.Visible = true;
            }
        }

        private void LoadGVDataByEid()
        {
            DataTable data=null;
            if (DDlsrchbby.SelectedValue.Equals("EID"))
            {
                data = Employee.GetEmpinfoByAdmin(Convert.ToInt64(TBsrc.Text.Trim()));
                
            }else if (DDlsrchbby.SelectedValue.Equals("BID"))
            {
                data = Employee.GetEmpinfoByAdmin2(Convert.ToInt64(TBsrc.Text.Trim()), Convert.ToInt32(DDLSrcPost.SelectedValue));
            }
            if (data==null || data.Rows.Count <= 0)
            {
                data.Rows.Add(data.NewRow());
                GVEmp.DataSource = data;
                GVEmp.DataBind();
                GVEmp.Rows[0].Cells.Clear();
                GVEmp.Rows[0].Cells.Add(new TableCell());
                GVEmp.Rows[0].Cells[0].ColumnSpan = data.Columns.Count;
                GVEmp.Rows[0].Cells[0].Text = "No Data Found";
                GVEmp.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Center;
            }
            else
            {
                GVEmp.DataSource = data;
                GVEmp.DataBind();
            }
        }

        protected void GVEmp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[6].Style.Add("Display", "none");
                e.Row.Cells[4].Style.Add("Display", "none");

            }else if(e.Row.RowType is DataControlRowType.DataRow)
            {
                if (e.Row.Cells[0].Text.Equals(eid))
                {
                    e.Row.Cells[9].Controls.Clear();
                    e.Row.Cells[9].Text = "Not Editable";
                }
                //if(e.Row.Cells[6].Text.Equals("1") || e.Row.Cells[6].Text.Equals("2"))
                //{
                //    ((DropDownList)e.Row.Cells[8].FindControl("DDLactive")).
                //}
                e.Row.Cells[6].Style.Add("Display", "none");
                e.Row.Cells[4].Style.Add("Display", "none");
            }
        }

        protected void DDLRID_SelectedIndexChanged(object sender, EventArgs e)
        {
            ((DropDownList)(GVEmp.Rows[GVEmp.EditIndex].Cells[7].FindControl("DDLBID"))).SelectedValue = "-1";
        }

        protected void GVEmp_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("EditROW"))
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                LoadGVDataByEid();
                string selectedBID = ((Label)(GVEmp.Rows[rowindex].Cells[7].FindControl("Label3"))).Text;
                GVEmp.EditIndex = rowindex;
                LoadGVDataByEid();

                ((DropDownList)(GVEmp.Rows[rowindex].Cells[7].FindControl("DDLBID"))).SelectedValue = selectedBID;

                HttpCookie oldcollection = new HttpCookie("OLD");
                oldcollection["OLD_EID"] = e.CommandArgument.ToString();
                oldcollection["OLD_BID"] = ((DropDownList)GVEmp.Rows[rowindex].FindControl("DDLBID")).SelectedValue.ToString();
                oldcollection["OLD_POSTINDEX"]= ((DropDownList)GVEmp.Rows[rowindex].FindControl("DDLpost")).SelectedValue.ToString();
                oldcollection["OLD_status"] = ((DropDownList)GVEmp.Rows[rowindex].FindControl("DDLstatus")).SelectedValue.ToString();

                Response.Cookies.Add(oldcollection);
            }
            else if (e.CommandName.Equals("CancelEDIT"))
            {
                GVEmp.EditIndex = -1;
                LoadGVDataByEid();
            }
            else if (e.CommandName.Equals("UpdateROW"))
            {
                if (Page.IsValid)
                {
                    int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                    long BID = Convert.ToInt64(((DropDownList)GVEmp.Rows[rowindex].FindControl("DDLBID")).SelectedValue);
                    int POSTINDEX = Convert.ToInt32(((DropDownList)GVEmp.Rows[rowindex].FindControl("DDLpost")).SelectedValue);
                    string status = ((DropDownList)GVEmp.Rows[rowindex].FindControl("DDLstatus")).SelectedValue;

                    HttpCookie oldcollection = Request.Cookies["OLD"];
                    long OLD_EID = Convert.ToInt64(oldcollection["OLD_EID"].ToString());
                    long OLD_BID = Convert.ToInt64(oldcollection["OLD_BID"].ToString());
                    int OLD_POSTINDEX = Convert.ToInt32(oldcollection["OLD_POSTINDEX"].ToString());
                    string OLD_status = oldcollection["OLD_status"].ToString();

                    if (Employee.UpdateEmpbyAdmin(OLD_EID, OLD_BID, OLD_POSTINDEX, OLD_status, BID, POSTINDEX, status) > 0)
                    {
                        GVEmp.EditIndex = -1;
                        LoadGVDataByEid();

                        LErr.Text = "Row with BID :" + e.CommandArgument + " is Updated Successflly";
                        LErr.ForeColor = System.Drawing.Color.SteelBlue;
                        PError.Style.Add("border", "2px solid Navy");
                        PError.Visible = true;

                    }
                    else
                    {
                        GVEmp.EditIndex = -1;
                        LoadGVDataByEid();

                        //GVEmp.EditIndex = rowindex;
                        //LoadGVDataByEid();
                        //((DropDownList)(GVEmp.Rows[rowindex].Cells[7].FindControl("DDLBID"))).SelectedValue = OLD_BID.ToString();

                        //OLD_BID = Convert.ToInt64(((DropDownList)GVEmp.Rows[rowindex].FindControl("DDLBID")).SelectedValue);
                        //OLD_POSTINDEX = Convert.ToInt32(((DropDownList)GVEmp.Rows[rowindex].FindControl("DDLpost")).SelectedValue);
                        //OLD_status = ((DropDownList)GVEmp.Rows[rowindex].FindControl("DDLstatus")).SelectedValue;

                        LErr.Text = "Row with EID : " + e.CommandArgument + " not Saved Due to Data Conflict";
                        LErr.ForeColor = System.Drawing.Color.Red;
                        PError.Style.Add("border", "2px solid lightRed");
                        PError.Visible = true;
                    }
                }
                else
                {
                    LErr.Text = "Validation Error Data not Saved";
                    LErr.ForeColor = System.Drawing.Color.Red;
                    PError.Style.Add("border", "2px solid lightRed");
                    PError.Visible = true;
                }
            }
        }






    }
}