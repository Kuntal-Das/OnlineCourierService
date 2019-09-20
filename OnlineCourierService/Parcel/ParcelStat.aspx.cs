using OnlineCourierService.Class;
using OnlineCourierService.employee.Classes;
using System;
using System.Web;
using System.Web.UI.HtmlControls;
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
      if (parcel.Sender.CID == "-1") { LSisRegistered.Text += "No"; }
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
      if (parcel.Receiver.CID == "-1") { LRisRegistered.Text += "no"; }
      else
      {
        LRisRegistered.Text += "Yes";
        Customer rec = Customer.GetinfoByEmail(parcel.Receiver.Email);
        LRphno.Visible = true;
        LRphno.Text += rec.phno;
      }


      if (parcel.statuslist.Count != 0)
      {
        Pstatus.Controls.Add(GenerateStaatusDiv("stat__div done", "Request Placed", parcel.ReqDate.ToString()));
        double c1 = 1, c2 = 0, c = 0;
        Employee emp;
        parcel.statuslist.ForEach(s =>
        {
          if ((parcel.SourceRID != -1 || (c != 4 && c != 5)) && (parcel.DestRID != -1 || (c != 6 && c != 7)) && (parcel.SourceBID != parcel.DestBID || c != 8))
          {
            if (s.date != null)
            {
              c1++;
              emp = new Employee(s.eid);
              emp.Filldata();
              Pstatus.Controls.Add(GenerateStaatusDiv("stat__div done", s.remark, s.date.ToString()));
            }
            else if (s.date == null)
            {
              c2++;
              Pstatus.Controls.Add(GenerateStaatusDiv("stat__div", s.remark, ""));
            }
          }
          c++;
        });
        double percent = 100 - ((c1 * 100d) / (c1 + c2));
        string p = percent + "% " + percent + "%";
        PprogressBar.Style.Add("background-position", p);

        //---------------------------------------------------
        //if (parcel.SourceBID == parcel.DestBID)
        //{
        //    PrCP4.Visible = false;
        //}

      }


    }
    private HtmlGenericControl GenerateStaatusDiv(string divClassName, string l1Text, string l2Text)
    {
      Label l1 = new Label();
      //l1.CssClass = l1ID;
      l1.Text = l1Text;

      Label l2 = new Label();
      //l1.CssClass = l1ID;
      l2.Text = l2Text;

      HtmlGenericControl span = new HtmlGenericControl("span");
      span.Attributes.Add("class", "round");

      HtmlGenericControl div = new HtmlGenericControl("div");
      div.Attributes.Add("class", divClassName);

      div.Controls.AddAt(0, span);
      div.Controls.AddAt(1, l1);
      div.Controls.AddAt(2, l2);

      return div;
    }


  }
}