using System;
using System.IO;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using OnlineCourierService.Class;

namespace OnlineCourierService.employee.Classes
{
  public class Employee : Password
  {
    private static readonly string connectionString = "Data Source=DESKTOP-74RBQ7M\\KUNTALSQLS;Initial Catalog=CourierService;Persist Security Info=True;User ID=sa;Password=!@Kd_Hell45";
    private SqlConnection con;
    private SqlCommand cmd;
    private SqlDataAdapter da;
    public int Eid { private get; set; }
    public long Bid { get; set; }
    public string Bname { get; set; }
    public long phno { get; set; }
    public DateTime dob { get; set; }
    public DateTime createdOn { get; protected set; }
    public string name { get; set; }
    public String address { get; set; }
    public string gender { get; set; }
    public string Email { get; set; }
    public string post { get; set; }
    public int postindex { get; set; }
    public string password { protected get; set; }
    public bool isAdmin { get; protected set; }
    public bool isActive { get; protected set; }
    public string imgurl { get; set; }

    /***********************************************
                      Constructors
    ************************************************/
    public Employee(int Eid){
      this.Eid = Eid;
      this.Bid = this.phno = -1;
      this.name = this.address = this.Email = this.post = this.password = null;
      this.isAdmin = false;
      this.isActive = true;
      con = new SqlConnection(connectionString);
    }
    public Employee(string Email){
      this.Email = Email;
      this.Eid = -1;
      this.Bid = this.phno = -1;
      this.name = this.address = this.post = this.password = null;
      this.isAdmin = false;
      this.isActive = true;
      con = new SqlConnection(connectionString);
    }
    public Employee(long phno){
      this.phno = phno;
      this.Eid = -1;
      this.Bid = -1;
      this.name = this.address = this.Email = this.post = this.password = null;
      this.isAdmin = false;
      this.isActive = true;
      con = new SqlConnection(connectionString);
    }
    public Employee(string Email, long phno){
      this.phno = phno;
      this.Email = Email;
      this.Eid = -1;
      this.Bid = -1;
      this.name = this.address = this.post = this.password = null;
      this.isAdmin = false;
      this.isActive = true;
      con = new SqlConnection(connectionString);
    }

    public Employee(string name, string address, string gender, string email, DateTime dob, long Bid, long phno, string password, int postindex, Boolean isActive)
    {
      this.Eid = -1;
      this.post = null;
      this.name = name;
      this.address = address;
      this.Email = email;
      this.gender = gender;
      this.password = password;
      this.Bid = Bid;
      this.phno = phno;
      this.dob = dob;
      this.postindex = postindex;
      this.isActive = isActive;
      this.isAdmin = isAdmin;
      this.con = new SqlConnection(connectionString);
    }

    public static int GenerateResetPasswordLink(string Email, string link)
    {
      int success = -1;
      using (SqlConnection con = new SqlConnection(connectionString)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("ERequestResetPassword", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@Email", Email);
          SqlDataReader rdr = cmd.ExecuteReader();
          while (rdr.Read()){
            if (Convert.ToBoolean(rdr["ReturnCode"])){
              if (Password.SendPasswordResetEmail(Email, rdr["Name"].ToString(), rdr["UniqueId"].ToString(), link))
              {success = 1;}
            }else{success = -1;}
          }
        }catch (SqlException) { return success; }
        catch (Exception) { return success; }
        finally { con.Close(); }
        return success;
      }
    }

    public static long isPasswordResetLinkValid(string Uid){
      long Eid = -1;
      using (SqlConnection con = new SqlConnection(connectionString)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("EIsPasswordResetLinkValid", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@GUID", Uid);
          Eid = Convert.ToInt64(cmd.ExecuteScalar());
        }catch (SqlException) { return -1; }
        catch (NullReferenceException) { return -1; }
        catch (Exception) { return -1; }
        finally { con.Close(); }
      }
      return Eid;
    }
    public static int ResetPassword(string guid, string pass){
      int c = -1;
      using (SqlConnection con = new SqlConnection(connectionString)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("EResetPassword", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@GUID", guid);
          cmd.Parameters.AddWithValue("@Password", Password.HashPassword(pass));
          c = Convert.ToInt32(cmd.ExecuteScalar());
        }catch (SqlException) { return c; }
        catch (Exception) { return c; }
        finally { con.Close(); }
      }
      return c;
    }
    /***********************************************
        Toggels Connections Open() to Close()
                        and 
                    vice versa
    ************************************************/
    private void OpenConnection(){
      if (con.State == ConnectionState.Closed)
      {con.Open();}
    }

    private void CloseConnection(){
      if (con.State == ConnectionState.Open)
      {con.Close();}
    }

    public static int CountByEmail(string email){
      using (SqlConnection con1 = new SqlConnection(connectionString)){
        SqlCommand cmd1 = new SqlCommand("CountEbyEmPh", con1);
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Parameters.AddWithValue("@EMAIL", email);
        cmd1.Parameters.AddWithValue("@PHNO", null);
        try{
          con1.Open();
          return Convert.ToInt32(cmd1.ExecuteScalar());
        }catch (Exception){return -1;}
        finally{con1.Close();}
      }
    }

    public static int CountByPhone(long phoneNo){
      using (SqlConnection con1 = new SqlConnection(connectionString)){
        SqlCommand cmd1 = new SqlCommand("CountEbyEmPh", con1);
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Parameters.AddWithValue("@EMAIL", null);
        cmd1.Parameters.AddWithValue("@PHNO", phoneNo);
        try{
          con1.Open();
          return Convert.ToInt32(cmd1.ExecuteScalar());
        }catch (Exception){return -1;}
        finally{con1.Close();}
      }
    }
    /***********************************************
      returns Emloyee ID if specified EID and 
                Password is found
    ************************************************/
    public int CheckPassword(string password){
      if (password.Equals(null))
      {return -1;}
      this.cmd = new SqlCommand("GetEidByPass", con);
      cmd.CommandType = CommandType.StoredProcedure;
      if (this.Email != null){
        cmd.Parameters.AddWithValue("@EMAIL", this.Email);
        cmd.Parameters.AddWithValue("@PHNO", null);
      }else if (this.phno != -1){
        cmd.Parameters.AddWithValue("@EMAIL", null);
        cmd.Parameters.AddWithValue("@PHNO", this.phno);
      }
      cmd.Parameters.AddWithValue("@PASS", Password.HashPassword(password));
      OpenConnection();
      try{
        Eid = Convert.ToInt32(cmd.ExecuteScalar());
      }catch (IndexOutOfRangeException){return -1;}
      finally{CloseConnection();}
      return Eid;
    }
    /***********************************************************
        Returnns NO. of employees with email and/or Phone No. 
     ***********************************************************/
    public int CountbyEmailorphno(){
      int count = -1;
      this.da = new SqlDataAdapter();
      this.da.SelectCommand = new SqlCommand("CountEbyEmPh", con);
      this.da.SelectCommand.CommandType = CommandType.StoredProcedure;
      if (this.Email != null){
        this.da.SelectCommand.Parameters.AddWithValue("@EMAIL", this.Email);
        this.da.SelectCommand.Parameters.AddWithValue("@PHNO", null);
      }else if (this.phno != -1){
        this.da.SelectCommand.Parameters.AddWithValue("@EMAIL", null);
        this.da.SelectCommand.Parameters.AddWithValue("@PHNO", this.phno);
      }
      DataTable dt = new DataTable();
      this.da.Fill(dt);
      OpenConnection();
      count = dt.Rows[0].Field<int>("count");
      CloseConnection();
      return count;
    }
    /***********************************************
          Check for administrator privilage
    ************************************************/
    public Boolean IsAdmin(){
      if (this.Eid < 1000)
      {return false;}
      this.cmd = new SqlCommand("isAdmin", con);
      this.cmd.CommandType = CommandType.StoredProcedure;
      this.cmd.Parameters.AddWithValue("@EID", this.Eid);
      OpenConnection();
      int x = Convert.ToInt32(cmd.ExecuteScalar());
      this.isAdmin = (x == 1 || x == 2);
      CloseConnection();
      return isAdmin;
    }
    /*************************************************************************
         Check if the Employee is Active(not retired/or deleted his A/c) 
    **************************************************************************/
    public Boolean IsActive(int Eid){
      if (Eid < 1000)
      {return false;}
      this.cmd = new SqlCommand("isActiveByEid", con);
      this.cmd.CommandType = CommandType.StoredProcedure;
      this.cmd.Parameters.AddWithValue("@EID", Eid);
      OpenConnection();
      isAdmin = (Convert.ToInt32(cmd.ExecuteScalar()).ToString().Equals("Active"));
      CloseConnection();
      return isActive;
    }
    /******************************************************
            Returns Datatable of Notifications by EID 
     ******************************************************/
    public DataTable GetNotifications(){
      if (this.Eid < 1000)
      {return null;}
      this.da = new SqlDataAdapter();
      this.da.SelectCommand = new SqlCommand("GetNotificationByEid", con);
      this.da.SelectCommand.CommandType = CommandType.StoredProcedure;
      this.da.SelectCommand.Parameters.AddWithValue("@EID", this.Eid);
      DataTable dttbl = new DataTable();
      OpenConnection();
      this.da.Fill(dttbl);
      CloseConnection();
      return dttbl;
    }
    public int GetImgCount(){
      using (con){
        this.cmd = new SqlCommand("CountImageByEid", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@EID", this.Eid);
        try{
          OpenConnection();
          return Convert.ToInt32(cmd.ExecuteScalar());
        }catch (Exception){return -1;}
        finally{CloseConnection();}
      }
    }
    public int InsertImage(HttpPostedFile img){
      string fileName = Path.GetFileName(img.FileName);
      string fileExtennsion = Path.GetExtension(fileName).ToLower();
      int fileSize = img.ContentLength;//length or size of the file
      if (fileExtennsion == ".jpg" || fileExtennsion == ".jpeg" || fileExtennsion == ".png"){
        Stream imgstream = img.InputStream;
        BinaryReader imgbin = new BinaryReader(imgstream);
        byte[] imgBytes = imgbin.ReadBytes((int)imgstream.Length);
        using (con){
          cmd = new SqlCommand("InsertImagebyEid", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@EID", this.Eid);
          cmd.Parameters.AddWithValue("@NAME", fileName);
          cmd.Parameters.AddWithValue("@SIZE", fileSize);
          cmd.Parameters.AddWithValue("@IMGDATA", imgBytes);
          try{
            OpenConnection();
            cmd.ExecuteNonQuery();
            return 1;
          }catch (Exception){return -1;}
          finally{CloseConnection();}
        }
      }else{return -1;}
    }

    public int UpdateImage(HttpPostedFile img){
      string fileName = Path.GetFileName(img.FileName);
      string fileExtennsion = Path.GetExtension(fileName).ToLower();
      int fileSize = img.ContentLength;//length or size of the file
      if (fileExtennsion == ".jpg" || fileExtennsion == ".jpeg" || fileExtennsion == ".png"){
        Stream imgstream = img.InputStream;
        BinaryReader imgbin = new BinaryReader(imgstream);
        byte[] imgBytes = imgbin.ReadBytes((int)imgstream.Length);
        using (con = new SqlConnection(connectionString)){
          cmd = new SqlCommand("UpdateImagebyEid", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@EID", this.Eid);
          cmd.Parameters.AddWithValue("@NAME", fileName);
          cmd.Parameters.AddWithValue("@SIZE", fileSize);
          cmd.Parameters.AddWithValue("@IMGDATA", imgBytes);
          try{
            OpenConnection();
            cmd.ExecuteNonQuery();
            return 1;
          }catch (Exception){return -1;}
          finally{CloseConnection();}
        }
      }else{return -1;}
    }

    public string LoadImage(){
      try{
        con = new SqlConnection(connectionString);
        this.cmd = new SqlCommand("GetimageByEID", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@EID", this.Eid);
        OpenConnection();
        byte[] imgbytes = (byte[])cmd.ExecuteScalar();
        string imgstrbase64 = Convert.ToBase64String(imgbytes);
        if (imgstrbase64 != null){
          imgurl = ("data:Image/png;base64," + imgstrbase64);
          return imgurl;
        }
        return null;
      }catch (NullReferenceException){return null;}
      catch (Exception){return null;}
      finally{CloseConnection();}
    }
    public int UpDateAll(){
      using (con = new SqlConnection(connectionString)){
        try{
          OpenConnection();
          cmd = new SqlCommand("UpdateInfoByEid", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@EID", Eid);
          cmd.Parameters.AddWithValue("@BID", Bid);
          cmd.Parameters.AddWithValue("@NAME", name);
          cmd.Parameters.AddWithValue("@DOB", dob);
          cmd.Parameters.AddWithValue("@GENDER", gender);
          cmd.Parameters.AddWithValue("@ADDRESS", address);
          cmd.Parameters.AddWithValue("@EMAIL", Email);
          cmd.Parameters.AddWithValue("@PHNO", phno);
          cmd.Parameters.AddWithValue("@POST", postindex);
          cmd.Parameters.AddWithValue("@PASS", Password.HashPassword(password));
          cmd.Parameters.AddWithValue("@ACTIVE", (isActive) ? 1 : -1);
          cmd.ExecuteNonQuery();
          return 1;
        }catch (Exception){return -1;}
        finally{CloseConnection();}
      }
    }
    public int InsertInfo(){
      using (con = new SqlConnection(connectionString)){
        try{
          OpenConnection();
          cmd = new SqlCommand("InsertInfoByEid", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@BID", Bid);
          cmd.Parameters.AddWithValue("@NAME", name);
          cmd.Parameters.AddWithValue("@DOB", dob);
          cmd.Parameters.AddWithValue("@GENDER", gender);
          cmd.Parameters.AddWithValue("@ADDRESS", address);
          cmd.Parameters.AddWithValue("@EMAIL", Email);
          cmd.Parameters.AddWithValue("@PHNO", phno);
          cmd.Parameters.AddWithValue("@POST", postindex);
          cmd.Parameters.AddWithValue("@PASS", Password.HashPassword(password));
          cmd.Parameters.AddWithValue("@ACTIVE", (isActive) ? "Active" : "Inactive");
          SqlParameter EID = new SqlParameter(){
            ParameterName = "@EID",
            Value = -1,
            Direction = ParameterDirection.Output
          };
          cmd.Parameters.Add(EID);
          cmd.ExecuteNonQuery();
          this.Eid = Convert.ToInt32(cmd.Parameters["@EID"].Value);
          return this.Eid;
        }catch (Exception){return -1;}
        finally{CloseConnection();}
      }
    }

    private DataTable DownSync(){
      try{
        this.da = new SqlDataAdapter();
        this.da.SelectCommand = new SqlCommand("DownloadInfoByEID", con);
        this.da.SelectCommand.CommandType = CommandType.StoredProcedure;
        if (this.Eid >= 1000){
          this.da.SelectCommand.Parameters.AddWithValue("@EID", this.Eid);
          this.da.SelectCommand.Parameters.AddWithValue("@EMAIL", null);
          this.da.SelectCommand.Parameters.AddWithValue("@PHNO", null);
        }else if (this.Email != null){
          this.da.SelectCommand.Parameters.AddWithValue("@EID", null);
          this.da.SelectCommand.Parameters.AddWithValue("@EMAIL", this.Email);
          this.da.SelectCommand.Parameters.AddWithValue("@PHNO", null);
        }else if ((this.phno != -1) && (this.phno.ToString().Length >= 10)){
          this.da.SelectCommand.Parameters.AddWithValue("@EID", null);
          this.da.SelectCommand.Parameters.AddWithValue("@EMAIL", null);
          this.da.SelectCommand.Parameters.AddWithValue("@PHNO", this.phno);
        }
        DataTable dttbl = new DataTable();
        OpenConnection();
        this.da.Fill(dttbl);
        return dttbl;
      }catch (SqlException){return null;}
      finally{CloseConnection();}
    }
    public int Filldata(){
      DataTable data = this.DownSync();
      if (data.Equals(null)){return -1;}
      try{
        foreach (DataRow row in data.Rows){
          this.Eid = Convert.ToInt32(row.Field<decimal>("EID"));
          this.Bid = Convert.ToInt64(row.Field<decimal>("BID"));
          this.name = row.Field<string>("NAME");
          this.address = row.Field<string>("ADDRESS");
          this.gender = row.Field<string>("GENDER");
          this.Email = row.Field<string>("EMAIL");
          this.postindex = row.Field<int>("PINDEX");
          this.post = row.Field<string>("POST");
          this.phno = Convert.ToInt64(row.Field<decimal>("PHNO"));
          this.dob = row.Field<DateTime>("DOB");
          this.createdOn = row.Field<DateTime>("CTS");
          this.isAdmin = (row.Field<int>("PINDEX") == 1 || row.Field<int>("ADMIN") == 2);
          this.isActive = (row.Field<string>("ACTIVE").Equals("Active"));
        }
      }catch (Exception){return -1;}
      return 1;
    }

    public static int UpdateEmpbyAdmin(long OLD_Eid,
        long OLD_Bid, int OLD_postindex, string OLD_status,
        long Bid, int postindex, string status)
    {
      using (SqlConnection con = new SqlConnection(connectionString)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("UpdateEmpByAdmin", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@OLD_EID", OLD_Eid);
          cmd.Parameters.AddWithValue("@OLD_BID", OLD_Bid);
          cmd.Parameters.AddWithValue("@BID", Bid);
          cmd.Parameters.AddWithValue("@OLD_POSTINDEX", OLD_postindex);
          cmd.Parameters.AddWithValue("@POSTINDEX", postindex);
          cmd.Parameters.AddWithValue("@OLD_STATUS", OLD_status);
          cmd.Parameters.AddWithValue("@STATUS", status);
          return cmd.ExecuteNonQuery();
        }catch (SqlException){return -1;}
        finally{con.Close();}
      }
    }

    public static DataTable GetEmpinfoByAdmin(long Eid){
      using (SqlConnection con = new SqlConnection(connectionString)){
        try{
          con.Open();
          SqlDataAdapter Da = new SqlDataAdapter("GetEmpByEid", con);
          Da.SelectCommand.CommandType = CommandType.StoredProcedure;
          Da.SelectCommand.Parameters.AddWithValue("@EID", Eid);
          DataTable data = new DataTable("Employee");
          Da.Fill(data);
          return data;
        }catch (SqlException){return null;}
        finally{con.Close();}
      }
    }

    public static DataTable GetEmpinfoByAdmin2(long bid, int postindex){
      using (SqlConnection con = new SqlConnection(connectionString)){
        try{
          con.Open();
          SqlDataAdapter Da = new SqlDataAdapter("GetEmpByDept_Branch", con);
          Da.SelectCommand.CommandType = CommandType.StoredProcedure;
          Da.SelectCommand.Parameters.AddWithValue("@BID", bid);
          Da.SelectCommand.Parameters.AddWithValue("@POSTINDEX", postindex);
          DataTable data = new DataTable("Employee");
          Da.Fill(data);
          return data;
        }catch (SqlException){return null;}
        finally{con.Close();}
      }
    }
  }
}