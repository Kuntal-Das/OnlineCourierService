using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OnlineCourierService.employee.Classes;

namespace OnlineCourierService.employee
{
    public partial class empProfile : System.Web.UI.Page
    {
        private Employee emp;
        private string id;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                id = Session["LightAdm"].ToString();
            }
            catch (NullReferenceException)
            {
                try
                {
                    id = Session["LightEmp"].ToString();
                    signout.Click -= Logout;
                    signout.Click += new EventHandler(Logout1);
                }
                catch (Exception)
                {
                    Response.Redirect("./login.aspx");
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
            emp = new Employee(Convert.ToInt32(id));
            emp.Filldata();
            if (emp.IsAdmin())
            {
                logo.NavigateUrl = HLhome.NavigateUrl = "~/employee/admin.aspx";
            }
            else
            {
                logo.NavigateUrl = HLhome.NavigateUrl = "~/employee/emp.aspx";
                HL2.Text = "Create Parcel";
                HL2.NavigateUrl = "#";

                HL3.Text = "Update Parcel Status";
                HL3.NavigateUrl = "#";

                HL4.Text = "Track Parcel";
                HL4.NavigateUrl = "#";
                HL5.Visible = false;
            }

            if (!IsPostBack)
            {
                string imgurl = emp.LoadImage();
                if (imgurl != null)
                {
                    ProundedDP.Style.Add("background-image", "url(" + imgurl + ")");
                    ImgProfilePic.ImageUrl = imgurl;
                }
                Luser.Text = emp.post;
                LID.Text += id;
                Aname.Text = TBname.Text = emp.name;
                TBAddr.Text = emp.address;
                if (emp.gender.Equals("Male"))
                {
                    RBLgenger.Items[0].Selected = true;
                }else if (emp.gender.Equals("Female"))
                {
                    RBLgenger.Items[1].Selected = true;
                }else
                {
                    RBLgenger.Items[2].Selected = true;
                }
                TBdob.Text = emp.dob.ToString("yyyy-MM-dd");
                TBemail.Text = emp.Email;
                TBphno.Text = emp.phno.ToString();
            }
        }

        protected void SaveChanges(object sender, EventArgs e)
        {

            HttpPostedFile postedfile = FUprofileImg.PostedFile;
            if (!TBoldpass.Text.Trim().Equals("")|| !TBnewpass.Text.Trim().Equals("")||!TBconfirmpass.Text.Trim().Equals("") || !postedfile.FileName.Equals("") || !TBname.Text.Trim().Equals(emp.name) || !TBAddr.Text.Trim().Equals(emp.address) || !RBLgenger.SelectedValue.Equals(emp.gender) || !DateTime.Parse(TBdob.Text.Trim()).Equals(emp.dob) || !TBemail.Text.Trim().Equals(emp.Email) || !Convert.ToInt64(TBphno.Text.Trim()).Equals(emp.phno))
            {
                string Opass = TBoldpass.Text.Trim();
                if (!Opass.Equals(""))
                {
                    if (Convert.ToInt32(id) == emp.CheckPassword(Opass))
                    {
                        if (TBnewpass.Text.Trim().Equals(TBconfirmpass.Text.Trim())) {
                            emp.password = TBconfirmpass.Text.Trim();
                        } else {
                            emp.password = null;
                            LimgiploadErr.Text = "New Passwords Do not Match";
                            PError.Visible = true;
                            PError.Style.Add("border", "2px solid red");
                            return;
                        }
                    }
                    else
                    {
                        LimgiploadErr.Text = "Old password Do not Match";
                        PError.Visible = true;
                        PError.Style.Add("border", "2px solid red");
                        return;
                    }
                }
                else if(!TBnewpass.Text.Trim().Equals("") || !TBconfirmpass.Text.Trim().Equals(""))
                {
                    LimgiploadErr.Text = "Old password not Provided, Password is Unchanged";
                    PError.Visible = true;
                    PError.Style.Add("border", "2px solid white");
                    return;
                }

                if (!postedfile.FileName.Equals(""))
                {
                    string fileExtennsion = Path.GetExtension(postedfile.FileName).ToLower();
                    if (fileExtennsion == ".jpg" || fileExtennsion == ".jpeg" || fileExtennsion == ".png")
                    {
                        if (emp.GetImgCount()==1)
                        {
                            if (emp.UpdateImage(postedfile) < 0)
                            {
                                LimgiploadErr.Text = "Image Update Failed";
                                PError.Visible = true;
                                PError.Style.Add("border", "2px solid red");
                                return;
                            }
                        }
                        else if(emp.GetImgCount() == 0)
                        {
                            if(emp.InsertImage(postedfile)<0)
                            {
                                LimgiploadErr.Text = "Image Update Failed";
                                PError.Visible = true;
                                PError.Style.Add("border", "2px solid red");
                                return;
                            }
                        }
                    }
                    else
                    {
                        LimgiploadErr.Text = "Only images(.jpg, .png, .jpeg) can be uploaded";
                        PError.Visible = true;
                        PError.Style.Add("border", "2px solid red");
                        return;
                    }
                }

                emp.name = TBname.Text.Trim();
                emp.address = TBAddr.Text.Trim();
                emp.gender = RBLgenger.SelectedValue;
                emp.dob = DateTime.Parse(TBdob.Text.Trim());

                if (!emp.Email.Equals(TBemail.Text.Trim())){
                    if (Employee.CountByEmail(TBemail.Text.Trim()) != 0)
                    {
                        LimgiploadErr.Text = "Email Already Registered, Try With Another One";
                        PError.Visible = true;
                        PError.Style.Add("border", "2px solid red");
                        return;
                    }
                    emp.Email = TBemail.Text.Trim();
                }
                else
                {
                    emp.Email = TBemail.Text.Trim();
                }

                if (emp.phno != Convert.ToInt64(TBphno.Text.Trim())){
                    if (Employee.CountByPhone(Convert.ToInt64(TBphno.Text.Trim())) != 0)
                    {
                        LimgiploadErr.Text = "Phone No. Already Registered, Try With Another One";
                        PError.Visible = true;
                        PError.Style.Add("border", "2px solid red");
                        return;
                    }
                    emp.phno = Convert.ToInt64(TBphno.Text.Trim());
                }
                else
                {
                    emp.phno = Convert.ToInt64(TBphno.Text.Trim());
                }
                emp.UpDateAll();

                LimgiploadErr.Text = "Changes Saved Successfully";
                PError.Style.Add("border", "2px solid green");
                PError.Visible = true;
                string imgurl = emp.LoadImage();
                ImgProfilePic.ImageUrl = imgurl;
                ProundedDP.Style.Add("background-image", "url(" + imgurl + ")");
            }
            else
            {
                LimgiploadErr.Text = "No Changes Detected";
                PError.Style.Add("border", "2px solid white");
                PError.Visible = true;
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

        protected void Logout1(object sender, EventArgs e)
        {
            Session.Remove("LightEmp");
            Response.Redirect("./login.aspx");
        }

    }
}