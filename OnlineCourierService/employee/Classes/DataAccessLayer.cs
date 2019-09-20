using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace OnlineCourierService.employee.Classes
{
  public class Rates
  {
    public int RateID { get; set; }
    public double Weight { get; set; }
    public double Basic { get; set; }
    public double Business { get; set; }
    public double DryFood { get; set; }
    public double CookedFood { get; set; }
    public double Gift { get; set; }
    public double Electronics { get; set; }
    public Rates() { }
    public Rates(int ID, double weight, double basic, double business, double dryf, double cookedf, double gift, double elec)
    {
      this.RateID = ID;
      this.Weight = weight;
      this.Basic = basic;
      this.Business = business;
      this.DryFood = dryf;
      this.CookedFood = cookedf;
      this.Gift = gift;
      this.Electronics = elec;
    }
  }
  public class Region
  {
    public int ID { get; set; }
    public string Name { get; set; }

    public Region(int id, string name){
      this.ID = id;
      this.Name = name;
    }
  }
  public class Branch1
  {
    public int Bid { get; set; }
    public string BName { get; set; }
    public Branch1(int bid, string name){
      this.Bid = bid;
      this.BName = (bid != -1) ? (name + " (" + bid + ")") : name;
    }
  }
  public class Dept
  {
    public int DeptId { set; get; }
    public string DeptName { set; get; }
    public Dept(int DID, string Dname){
      this.DeptId = DID;
      this.DeptName = Dname;
    }
  }
  public class Employee1
  {
    public int Eid { set; get; }
    public string name { set; get; }
    public string gender { set; get; }
    public DateTime dob { set; get; }
    public long Bid { set; get; }
    public long Rid { set; get; }
    public string Bname { set; get; }
    public int postindex { set; get; }
    public string post { set; get; }
    public string status { set; get; }
  }
  public class DataAccessLayer
  {
    private static readonly string connectionstr = "Data Source=DESKTOP-74RBQ7M\\KUNTALSQLS;Initial Catalog=CourierService;Persist Security Info=True;User ID=sa;Password=!@Kd_Hell45";
    public static List<Region> GetRegion(){
      List<Region> r = new List<Region>();
      r.Add(new Region(-1, "Select Region"));
      DataTable data = new DataTable("Regions");
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlDataAdapter Da = new SqlDataAdapter("GetRegions", con);
          Da.SelectCommand.CommandType = CommandType.StoredProcedure;
          Da.Fill(data);
          foreach (DataRow row in data.Rows){
            r.Add(new Region(row.Field<int>("RegionID"), row.Field<string>("Region")));
          }
        }catch (SqlException){return null;}
        finally{con.Close();}
      }
      return r;
    }
    //returns every branch under a region searched by regional branch id
    public static List<Branch1> GetBranchByRid(int Rid){
      List<Branch1> b1 = new List<Branch1>();
      b1.Add(new Branch1(-1, "Select Branch"));
      DataTable data = new DataTable("Branchs");
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlDataAdapter Da = new SqlDataAdapter("GetBranchlist", con);
          Da.SelectCommand.CommandType = CommandType.StoredProcedure;
          Da.SelectCommand.Parameters.AddWithValue("@RID", Rid);
          Da.Fill(data);
          foreach (DataRow row in data.Rows){
            b1.Add(new Branch1(Convert.ToInt32(row.Field<decimal>("BID")), row.Field<string>("Bname")));
          }
        }catch (SqlException){return null;}
        finally{con.Close();}
      }
      return b1;
    }
    public static List<Branch1> GetRegBranch(){
      List<Branch1> b1 = new List<Branch1>();
      b1.Add(new Branch1(-1, "Select Regional Branch"));
      DataTable data = new DataTable("RegBranch");
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlDataAdapter Da = new SqlDataAdapter("GetRegBranchlist", con);
          Da.SelectCommand.CommandType = CommandType.StoredProcedure;
          Da.Fill(data);
          foreach (DataRow row in data.Rows){
            b1.Add(new Branch1(Convert.ToInt32(row.Field<decimal>("BID")), row.Field<string>("Bname")));
          }
        }catch (SqlException){return null;}
        finally{con.Close();}
      }
      return b1;
    }
    public static List<Dept> GetDepartments(){
      List<Dept> depts = new List<Dept>();
      depts.Add(new Dept(-1, "Select Post"));
      DataTable data = new DataTable("Departments");
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlDataAdapter Da = new SqlDataAdapter("GetDept", con);
          Da.SelectCommand.CommandType = CommandType.StoredProcedure;
          Da.Fill(data);
          foreach (DataRow row in data.Rows){
            depts.Add(new Dept(row.Field<int>("DeptID"), row.Field<string>("DeptName")));
          }
        }catch (SqlException){return null;}
        finally{con.Close();}
      }
      return depts;
    }
    public static List<Employee1> GetEmpinfoByBID_Dept(int bid, int did){
      List<Employee1> emps = new List<Employee1>();
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlDataAdapter Da = new SqlDataAdapter("GetEmpByDept_Branch", con);
          Da.SelectCommand.CommandType = CommandType.StoredProcedure;
          Da.SelectCommand.Parameters.AddWithValue("@BID", bid);
          Da.SelectCommand.Parameters.AddWithValue("@DEPTID", did);
          DataTable data = new DataTable("Employees");
          Da.Fill(data);
          foreach (DataRow row in data.Rows){
            Employee1 emp = new Employee1();
            emp.Eid = Convert.ToInt32(row.Field<decimal>("EID"));
            emp.name = row.Field<string>("NAME");
            emp.dob = row.Field<DateTime>("DOB");
            emp.Bid = Convert.ToInt64(row.Field<decimal>("BRANCH"));
            emp.Bname = row.Field<string>("BNAME");
            emp.post = row.Field<string>("POST");
            emp.postindex = row.Field<int>("POSTINDEX");
            emp.gender = row.Field<string>("GENDER");
            emp.status = (row.Field<int>("STATUS") == 1) ? "Active" : "Inactive";
            emps.Add(emp);
          }
        }catch (SqlException){return null;}
        finally{con.Close();}
      }
      return emps;
    }
    public static List<Rates> GetRates(){
      List<Rates> rates = new List<Rates>();
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlDataAdapter Da = new SqlDataAdapter("GetRates", con);
          Da.SelectCommand.CommandType = CommandType.StoredProcedure;
          DataTable data = new DataTable("Rates");
          Da.Fill(data);
          foreach (DataRow row in data.Rows){
            Rates r = new Rates();
            r.RateID = row.Field<int>("RateID");
            r.Weight = row.Field<double>("WEIGHT");
            r.Basic = row.Field<double>("Basic");
            r.Business = row.Field<double>("Business");
            r.DryFood = row.Field<double>("DryFood");
            r.CookedFood = row.Field<double>("CookedFood");
            r.Gift = row.Field<double>("Gift");
            r.Electronics = row.Field<double>("Electronics");
            rates.Add(r);
          }
        }catch (SqlException){return null;}
        finally{con.Close();}
      }
      return rates;
    }
    public static int UpdateRates(int OLD_RateID,
        int OLD_Weight, double OLD_Basic, double OLD_Business, double OLD_DryFood, double OLD_CookedFood, double OLD_Gift, double OLD_Electronics,
        int Weight, double Basic, double Business, double DryFood, double CookedFood, double Gift, double Electronics)
    {
      if (CountRateWeight(Weight) == 0){
        using (SqlConnection con = new SqlConnection(connectionstr)){
          try{
            con.Open();
            SqlCommand cmd = new SqlCommand("UpdateRate", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@RATEID", OLD_RateID);
            cmd.Parameters.AddWithValue("@O_WEIGHT", OLD_Weight);
            cmd.Parameters.AddWithValue("@O_BASIC", OLD_Basic);
            cmd.Parameters.AddWithValue("@O_BUSINESS", OLD_Business);
            cmd.Parameters.AddWithValue("@O_DF", OLD_DryFood);
            cmd.Parameters.AddWithValue("@O_CF", OLD_CookedFood);
            cmd.Parameters.AddWithValue("@O_GIFT", OLD_Gift);
            cmd.Parameters.AddWithValue("@O_ELEC", OLD_Electronics);
            cmd.Parameters.AddWithValue("@WEIGHT", Weight);
            cmd.Parameters.AddWithValue("@BASIC", Basic);
            cmd.Parameters.AddWithValue("@BUSINESS", Business);
            cmd.Parameters.AddWithValue("@DF", DryFood);
            cmd.Parameters.AddWithValue("@CF", CookedFood);
            cmd.Parameters.AddWithValue("@GIFT", Gift);
            cmd.Parameters.AddWithValue("@ELEC", Electronics);
            return cmd.ExecuteNonQuery();
          }catch (SqlException){return -1;}
          catch (Exception){return -1;}
          finally{con.Close();}
        }
      }else{return -1;}
    }
    public static int CountRateWeight(int weight){
      int count = -1;
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlCommand cmd = new SqlCommand("CountWeight", con);
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@weight", weight);
          count = Convert.ToInt32(cmd.ExecuteScalar());
        }catch (SqlException){return count;}
        catch (Exception){return count;}
        finally{con.Close();}
        return count;
      }
    }
    public static int InsertRates(int Weight, double Basic, double Business, double DryFood, double CookedFood, double Gift, double Electronics){
      if (CountRateWeight(Weight) == 0){
        using (SqlConnection con = new SqlConnection(connectionstr)){
          try{
            con.Open();
            SqlCommand cmd = new SqlCommand("InsertRates", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@WEIGHT", Weight);
            cmd.Parameters.AddWithValue("@BASIC", Basic);
            cmd.Parameters.AddWithValue("@BUSINESS", Business);
            cmd.Parameters.AddWithValue("@DRYFOOD", DryFood);
            cmd.Parameters.AddWithValue("@COOKEDFOOD", CookedFood);
            cmd.Parameters.AddWithValue("@GIFT", Gift);
            cmd.Parameters.AddWithValue("@ELEC", Electronics);
            SqlParameter rateID = new SqlParameter(){
              ParameterName = "@RATEID",
              Value = -1,
              Direction = ParameterDirection.Output
            };
            cmd.Parameters.Add(rateID);
            cmd.ExecuteNonQuery();
            return Convert.ToInt32(cmd.Parameters["@RATEID"].Value);
          }catch (SqlException){return -1;}
          catch (Exception){return -1;}
          finally{con.Close();}
        }
      }else{return -1;}
    }
    //gets all regions with existing regional branch ID
    public static List<Region> GetRegionWithRegBranchID(){
      List<Region> r = new List<Region>();
      r.Add(new Region(-1, "Select Region"));
      DataTable data = new DataTable("Regions");
      using (SqlConnection con = new SqlConnection(connectionstr)){
        try{
          con.Open();
          SqlDataAdapter Da = new SqlDataAdapter("GetRegionsWithRID", con);
          Da.SelectCommand.CommandType = CommandType.StoredProcedure;
          Da.Fill(data);
          foreach (DataRow row in data.Rows){
            r.Add(new Region(Convert.ToInt32(row.Field<decimal>("RBranchID")), row.Field<string>("Region")));
          }
        }catch (SqlException){return null;}
        finally{con.Close();}
      }
      return r;
    }
  }
}