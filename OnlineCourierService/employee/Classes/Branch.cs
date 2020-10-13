using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

namespace OnlineCourierService.employee.Classes
{
  public class Branch
  {
    //private static readonly string connectionstr = "Data Source=DESKTOP-74RBQ7M\\KUNTALSQLS;Initial Catalog=CourierService;Persist Security Info=True;User ID=sa;Password=!@Kd_Hell45";
    private static readonly string connectionstr = "Data Source=NOT-A-PC;Initial Catalog=CourierService;Integrated Security=True";
    private static SqlConnection con;
    public long Bid { get; private set; }
    public long Rid { get; private set; }
    public string name { get; set; }
    public string address { get; set; }
    public double lat { get; set; }
    public string status { get; set; }
    public double lon { get; set; }

    public static long GetRidbyBid(long BID){
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("select RID from Branch where BID=@bid", con);
          cmd.Parameters.AddWithValue("@bid", BID);
          return Convert.ToInt64(cmd.ExecuteScalar());
        }catch (SqlException){return -1;}
        catch (Exception){return -1;}
        finally{con.Close();}
      }
    }

    public static int GetRBidByRegID(int Regid){
      int RBid = -1;
      using (con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("GetRBidBy", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@RegID", Regid);
          string rbid = cmd.ExecuteScalar().ToString();
          if (!rbid.Equals(null)){RBid = Convert.ToInt32(rbid);}
        }catch (Exception){return -1;}
        finally{con.Close();}
      }
      return RBid;
    }

    public static int CreateRegBranch(int regid, string Bname, string Baddr, double latitude, double longitude){
      int Bid = -1;
      using (con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("InsertRegB", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@REGID", regid);
          cmd.Parameters.AddWithValue("@REGNAME", Bname);
          cmd.Parameters.AddWithValue("@REGADDR", Baddr);
          cmd.Parameters.AddWithValue("@LAT", latitude);
          cmd.Parameters.AddWithValue("@LONG", longitude);
          SqlParameter bid = new SqlParameter(){
            ParameterName = "@BID",
            Value = -1,
            Direction = ParameterDirection.Output
          };
          cmd.Parameters.Add(bid);
          cmd.ExecuteNonQuery();
          String rbid = cmd.Parameters["@BID"].Value.ToString();
          if (!rbid.Equals(null)){Bid = Convert.ToInt32(rbid);}
        }catch (Exception){return -1;}
        finally{con.Close();}
      }
      return Bid;
    }

    public static int CountB(string Name, string Address, double latitude, double longitude){
      int count = -1;
      using (con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("CountB", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@NAME", Name);
          cmd.Parameters.AddWithValue("@ADDR", Address);
          cmd.Parameters.AddWithValue("@LAT", latitude);
          cmd.Parameters.AddWithValue("@LONG", longitude);
          count = Convert.ToInt32(cmd.ExecuteScalar());
        }catch (Exception){return -1;}
        finally{con.Close();}
      }
      return count;
    }

    public static int CreateSubBranch(long rid, string Name, string Address, double latitude, double longitude){
      int Bid = -1;
      using (con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("InserSubB", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@RID", rid);
          cmd.Parameters.AddWithValue("@NAME", Name);
          cmd.Parameters.AddWithValue("@ADDR", Address);
          cmd.Parameters.AddWithValue("@LAT", latitude);
          cmd.Parameters.AddWithValue("@LONG", longitude);
          SqlParameter bid = new SqlParameter(){
            ParameterName = "@BID",
            Value = -1,
            Direction = ParameterDirection.Output
          };
          cmd.Parameters.Add(bid);
          cmd.ExecuteNonQuery();
          String rbid = cmd.Parameters["@BID"].Value.ToString();
          if (!rbid.Equals(null)){Bid = Convert.ToInt32(rbid);}
        }catch (Exception){return -1;}
        finally{con.Close();}
      }
      return Bid;
    }

    public static int CountRegB(){
      using (SqlConnection con = new SqlConnection(connectionstr)){
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Branch WHERE RID=BID", con);
        return Convert.ToInt32(cmd.ExecuteScalar());
      }
    }

    public static List<Branch> GetRegBranches(int startIndex, int pageSize){
      List<Branch> Regbs = new List<Branch>();
      using (SqlConnection con = new SqlConnection(connectionstr)){
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter("GetRegBranchesByPage", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@STARTI", startIndex);
        da.SelectCommand.Parameters.AddWithValue("@PSIZE", pageSize);
        DataTable data = new DataTable("RegBranchs");
        da.Fill(data);
        foreach (DataRow row in data.Rows){
          Branch b1 = new Branch();
          b1.Bid = b1.Rid = Convert.ToInt64(row.Field<decimal>("RID"));
          b1.name = row.Field<string>("Bname");
          b1.address = row.Field<string>("Baddress");
          b1.lat = Convert.ToDouble(row.Field<decimal>("Latitude"));
          b1.lon = Convert.ToDouble(row.Field<decimal>("Longitude"));
          b1.status = row.Field<string>("Status");
          Regbs.Add(b1);
        }
      }
      return Regbs;
    }

    public static int UpdateRegBranches(long OLD_Bid,
        string OLD_name, string OLD_address, double OLD_lat, double OLD_lon, string OLD_status,
        string name, string address, double lat, double lon, string status)
    {
      using (con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("UpdateRegB", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@OLD_BID", OLD_Bid);
          cmd.Parameters.AddWithValue("@OLD_BNAME", OLD_name);
          cmd.Parameters.AddWithValue("@OLD_BADDR", OLD_address);
          cmd.Parameters.AddWithValue("@OLD_LAT", OLD_lat);
          cmd.Parameters.AddWithValue("@OLD_LON", OLD_lon);
          cmd.Parameters.AddWithValue("@OLD_STATUS", OLD_status);
          cmd.Parameters.AddWithValue("@BNAME", name);
          cmd.Parameters.AddWithValue("@BADDR", address);
          cmd.Parameters.AddWithValue("@LAT", lat);
          cmd.Parameters.AddWithValue("@LON", lon);
          cmd.Parameters.AddWithValue("@STATUS", status);
          return cmd.ExecuteNonQuery();
        }catch (Exception){return -1;}
        finally{con.Close();}
      }
    }

    public static List<Branch> GetSubBranch(int rid){
      List<Branch> SubBs = new List<Branch>();
      using (SqlConnection con = new SqlConnection(connectionstr)){
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter("GetSubBranchByRID", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@RID", rid);
        DataTable data = new DataTable("RegBranchs");
        da.Fill(data);
        foreach (DataRow row in data.Rows){
          Branch b1 = new Branch();
          b1.Bid = Convert.ToInt64(row.Field<decimal>("BID"));
          b1.Rid = Convert.ToInt64(row.Field<decimal>("RID"));
          b1.name = row.Field<string>("Bname");
          b1.address = row.Field<string>("Baddress");
          b1.lat = Convert.ToDouble(row.Field<decimal>("Latitude"));
          b1.lon = Convert.ToDouble(row.Field<decimal>("Longitude"));
          b1.status = row.Field<string>("Status");
          SubBs.Add(b1);
        }
      }
      return SubBs;
    }

    public static int UpdateSubBranches(long OLD_Bid,
       string OLD_name, string OLD_address, double OLD_lat, double OLD_lon, string OLD_status,
       string name, string address, double lat, double lon, string status)
    {
      using (con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("UpdateSubB", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@OLD_BID", OLD_Bid);
          cmd.Parameters.AddWithValue("@OLD_BNAME", OLD_name);
          cmd.Parameters.AddWithValue("@OLD_BADDR", OLD_address);
          cmd.Parameters.AddWithValue("@OLD_LAT", OLD_lat);
          cmd.Parameters.AddWithValue("@OLD_LON", OLD_lon);
          cmd.Parameters.AddWithValue("@OLD_STATUS", OLD_status);
          cmd.Parameters.AddWithValue("@BNAME", name);
          cmd.Parameters.AddWithValue("@BADDR", address);
          cmd.Parameters.AddWithValue("@LAT", lat);
          cmd.Parameters.AddWithValue("@LON", lon);
          cmd.Parameters.AddWithValue("@STATUS", status);
          return cmd.ExecuteNonQuery();
        }catch (Exception){return -1;}
        finally{con.Close();}
      }
    }

    public static string GetBranchNameByBID(long BID){
      string name = null;
      using (con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("select Bname from Branch where BID=@BID", con);
          cmd.Parameters.AddWithValue("@BID", BID);
          name = Convert.ToString(cmd.ExecuteScalar());
        }catch (Exception){return null;}
      }
      return name;
    }
  }
}