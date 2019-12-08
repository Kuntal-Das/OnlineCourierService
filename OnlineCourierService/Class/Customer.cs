using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;

namespace OnlineCourierService.Class
{
  public class Customer : Password
  {
    private static readonly string connectionstr = "Data Source=DESKTOP-74RBQ7M\\KUNTALSQLS;Initial Catalog=CourierService;Persist Security Info=True;User ID=sa;Password=************";
    public string cid { private get; set; }
    public string name { get; set; }
    public string address { get; set; }
    public string gender { get; set; }
    public DateTime dob { get; set; }
    public long phno { get; set; }
    public string email { get; set; }
    public long BID { get; set; }
    public string accType { get; set; }
    public string status { get; set; }
    public string pass { private get; set; }
    public string imgurl { get; set; }
    public static Customer GetinfoByEmail(string Email){
      Customer cus = null;
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          string q = "Select CID from Customer WHERE Email=@EMAIL";
          SqlCommand cmd = new SqlCommand(q, con);
          cmd.Parameters.AddWithValue("@EMAIL", Email);
          cus = new Customer(Convert.ToString(cmd.ExecuteScalar()), true);
        }catch (SqlException){return cus;}
        catch (Exception){return cus;}
        finally{con.Close();}
      }
      cus.FillData();
      return cus;
    }
    public Customer(string CID, bool isActive){
      this.cid = CID;
      this.status = (isActive) ? "Active" : "Inactive";
    }
    public Customer(string email){
      this.phno = -1;
      this.email = email;
      this.status = "Active";
    }
    public Customer(long phno){
      this.email = null;
      this.phno = phno;
      this.status = "Active";
    }
    public Customer(string name, string address, string gender, DateTime dob, long phno, string email, long BID, string accType, string pass){
      this.name = name;
      this.address = address;
      this.gender = gender;
      this.dob = dob;
      this.phno = phno;
      this.email = email;
      this.BID = BID;
      this.accType = accType;
      this.pass = pass;
      this.status = "Active";
    }
    public static string isPasswordResetLinkValid(string Uid){
      string cid = null;
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("CIsPasswordResetLinkValid", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@GUID", Uid);
          cid = cmd.ExecuteScalar().ToString();
        }
        catch (SqlException) { return null; }
        catch (NullReferenceException) { return null; }
        catch (Exception) { return null; }
        finally { con.Close(); }
      }
      return cid;
    }
    public static int ResetPassword(string guid, string pass){
      int c = -1;
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("CResetPassword", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@GUID", guid);
          cmd.Parameters.AddWithValue("@Password", Password.HashPassword(pass));
          c = Convert.ToInt32(cmd.ExecuteScalar());
        }
        catch (SqlException) { return c; }
        catch (Exception) { return c; }
        finally { con.Close(); }
      }
      return c;
    }
    public static int GenerateResetPasswordLink(string Email, string link){
      int success = -1;
      using (SqlConnection con = new SqlConnection(connectionstr)){
        con.Open();
        SqlCommand cmd = new SqlCommand("CRequestResetPassword", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Email", Email);
        SqlDataReader rdr = cmd.ExecuteReader();
        while (rdr.Read()){
          if (Convert.ToBoolean(rdr["ReturnCode"])){
            if (Password.SendPasswordResetEmail(Email, rdr["Name"].ToString(), rdr["UniqueId"].ToString(), link)){
              success = 1;
            }
          }
          else{
            success = -1;
          }
        }
        con.Close();
        return success;
      }
    }
    public string GetCIDbyPass(string pass){
      this.cid = null;
      pass = Password.HashPassword(pass);
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("GetCIDbyPass", con);
          cmd.CommandType = CommandType.StoredProcedure;
          if (this.email != null){
            cmd.Parameters.AddWithValue("@PHNO", null);
            cmd.Parameters.AddWithValue("@EMAIL", this.email);
            cmd.Parameters.AddWithValue("@PASS", pass);
          }else if (this.phno != -1){
            cmd.Parameters.AddWithValue("@PHNO", this.phno);
            cmd.Parameters.AddWithValue("@EMAIL", null);
            cmd.Parameters.AddWithValue("@PASS", pass);
          }else{
            cmd.Parameters.AddWithValue("@PHNO", this.phno);
            cmd.Parameters.AddWithValue("@EMAIL", this.email);
            cmd.Parameters.AddWithValue("@PASS", pass);
          }
          this.cid = cmd.ExecuteScalar().ToString();
          return this.cid;
        }catch (SqlException){return this.cid;}
        catch (Exception){return this.cid;}
        finally{con.Close();}
      }
    }
    public int UpdatePassword(string newpass, string oldpass){
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("UpdateCPass", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@OLD_CID", this.cid);
          cmd.Parameters.AddWithValue("@OLD_PASS", Password.HashPassword(oldpass));
          cmd.Parameters.AddWithValue("@PASS", Password.HashPassword(newpass));
          return cmd.ExecuteNonQuery();
        }catch (SqlException){
          return -1;
        }finally{
          con.Close();
        }
      }
    }

    public static int CountCustomer(long phno){
      int count = -1;
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("CountCbyPhno", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@PHNO", phno);
          count = Convert.ToInt32(cmd.ExecuteScalar());
        }catch (SqlException){return count;}
        catch (Exception){return count;}
        finally{con.Close();}
      }
      return count;
    }
    public static int CountCustomer(string email){
      int count = -1;
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("CountCbyEmail", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@EMAIL", email);
          count = Convert.ToInt32(cmd.ExecuteScalar());
        }catch (SqlException){return count;}
        catch (Exception){return count;}
        finally{con.Close();}
      }
      return count;
    }
    public int FillData(){
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlDataAdapter da = new SqlDataAdapter("GetCusInfo", con);
          da.SelectCommand.CommandType = CommandType.StoredProcedure;
          DataTable data = new DataTable("CustomerInfo");
          da.SelectCommand.Parameters.AddWithValue("@CID", this.cid);
          da.Fill(data);
          if (data.Equals(null)){return -1;}
          foreach (DataRow row in data.Rows){
            this.cid = row.Field<string>("CID");
            this.name = row.Field<string>("NAME");
            this.address = row.Field<string>("ADDR");
            this.gender = row.Field<string>("GENDER");
            this.dob = row.Field<DateTime>("DOB");
            this.phno = Convert.ToInt64(row.Field<decimal>("PHNO"));
            this.email = row.Field<string>("EMAIL");
            this.BID = Convert.ToInt64(row.Field<decimal>("BID"));
            this.accType = row.Field<string>("ACCTYPE");
            this.status = row.Field<string>("STATUS");
            if (row.Field<byte[]>("IMGDATA") != null){
              this.imgurl = Convert.ToBase64String(row.Field<byte[]>("IMGDATA"));
              this.imgurl = ("data:Image/png;base64," + imgurl);
            }
          }
          return 1;
        }catch (SqlException){return -1;}
        catch (Exception){return -1;}
        finally{con.Close();}
      }
    }
    public string InsertData(){
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("InsertCustomer", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@NAME", name);
          cmd.Parameters.AddWithValue("@ADDRESS", address);
          cmd.Parameters.AddWithValue("@GENDER", gender);
          cmd.Parameters.AddWithValue("@DOB", dob);
          cmd.Parameters.AddWithValue("@PHNO", phno);
          cmd.Parameters.AddWithValue("@EMAIL", email);
          cmd.Parameters.AddWithValue("@BID", BID);
          cmd.Parameters.AddWithValue("@ACCTYPE", accType);
          cmd.Parameters.AddWithValue("@STATUS", status);
          cmd.Parameters.AddWithValue("@PASS", Password.HashPassword(pass));
          this.cid = Convert.ToString(cmd.ExecuteScalar());
          //this.cid = Convert.ToString(cmd.Parameters["@CID"].Value);
          return this.cid;
        }catch (SqlException){return null;}
        catch (Exception){return null;}
        finally{con.Close();}
      }
    }
    public int InsertUpdateImage(HttpPostedFile img){
      string fileName = Path.GetFileName(img.FileName);
      string fileExtennsion = Path.GetExtension(fileName).ToLower();
      int fileSize = img.ContentLength;//length or size of the file
      if (fileExtennsion == ".jpg" || fileExtennsion == ".jpeg" || fileExtennsion == ".png"){
        Stream imgstream = img.InputStream;
        BinaryReader imgbin = new BinaryReader(imgstream);
        byte[] imgBytes = imgbin.ReadBytes((int)imgstream.Length);
        using (SqlConnection con = new SqlConnection(connectionstr)){
          try{
            con.Open();
            SqlCommand cmd = new SqlCommand("InsertUpdateCImage", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CID", this.cid);
            cmd.Parameters.AddWithValue("@NAME", fileName);
            cmd.Parameters.AddWithValue("@SIZE", fileSize);
            cmd.Parameters.AddWithValue("@IMGDATA", imgBytes);
            cmd.ExecuteNonQuery();
            return 1;
          }catch (Exception){return -1;}
          finally{con.Close();}
        }
      }else{return -1;}
    }
    public int UpdateData(Customer newCus){
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("UpdateCustomer", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@OLD_CID", this.cid);
          cmd.Parameters.AddWithValue("@OLD_NAME", this.name);
          cmd.Parameters.AddWithValue("@NAME", newCus.name);
          cmd.Parameters.AddWithValue("@OLD_ADDR", this.address);
          cmd.Parameters.AddWithValue("@ADDR", newCus.address);
          cmd.Parameters.AddWithValue("@OLD_GENDER", this.gender);
          cmd.Parameters.AddWithValue("@GENDER", newCus.gender);
          cmd.Parameters.AddWithValue("@OLD_DOB", this.dob);
          cmd.Parameters.AddWithValue("@DOB", newCus.dob);
          cmd.Parameters.AddWithValue("@OLD_PHNO", this.phno);
          cmd.Parameters.AddWithValue("@PHNO", newCus.phno);
          cmd.Parameters.AddWithValue("@OLD_EMAIL", this.email);
          cmd.Parameters.AddWithValue("@EMAIL", newCus.email);
          cmd.Parameters.AddWithValue("@OLD_BID", this.BID);
          cmd.Parameters.AddWithValue("@BID", newCus.BID);
          cmd.Parameters.AddWithValue("@OLD_ACCTYPE", this.accType);
          cmd.Parameters.AddWithValue("@ACCTYPE", newCus.accType);
          cmd.Parameters.AddWithValue("@OLD_STATUS", this.status);
          cmd.Parameters.AddWithValue("@STATUS", newCus.status);
          return cmd.ExecuteNonQuery();
        }catch (SqlException){return -1;}
        catch (Exception){return -1;}
        finally{con.Close();}
      }
    }
  }
}
