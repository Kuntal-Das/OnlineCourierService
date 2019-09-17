﻿using OnlineCourierService.employee.Classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace OnlineCourierService.Class
{
    internal class Status
    {
        internal string remark { get; private set; }
        internal int eid { get; private set; }
        internal Object date { get; private set; }
        internal Status(string remark, int eid, Object date)
        {
            this.eid = eid;
            this.date = date;
            this.remark = remark;
        }
    }
    internal class SenderReceiver
    {
        internal string CID { get; set; }
        internal string Name { get; set; }
        internal string Address { get; set; }
        internal string Email { get; set; }
        internal SenderReceiver(string CID, string Name, string Email, string Address)
        {
            this.CID = CID;
            this.Name = Name;
            this.Email = Email;
            this.Address = Address;
        }
        internal SenderReceiver() { }
    }
    internal class Package
    {
        private static readonly string connectionstr = "Data Source=DESKTOP-74RBQ7M\\KUNTALSQLS;Initial Catalog=CourierService;Persist Security Info=True;User ID=sa;Password=!@Kd_Hell45";
        internal static readonly DateTime nullDate = new DateTime(1800, 12, 31);
        internal string ParcelID { private get; set; }
        internal string ParcelType { get; private set; }
        internal double Weight { get; private set; }
        internal long SourceBID { get; private set; }
        internal long SourceRID { get; private set; }
        internal long DestBID { get; private set; }
        internal long DestRID { get; private set; }
        internal double invoicePrice { get; private set; }
        internal string PaymentMethod { get; private set; }
        internal string PaymentStatus { get; private set; }
        internal DateTime PayDate { get; private set; }
        internal int PackagingByCustomer { get; private set; }
        internal int Container { get; private set; }
        internal double Distance { get; private set; }
        internal DateTime ReqDate { get; private set; }
        internal long bidStatus { get; private set; }//processing req,PickedUp,Approved,ckeckpoints(BIDs),out for Delivery,received/returned
        internal string currentStatus { get; private set; }//processing req,PickedUp,Approved,ckeckpoints(BIDs),out for Delivery,received/returned
        internal SenderReceiver Sender { get; private set; }
        internal SenderReceiver Receiver { get; private set; }
        internal List<Status> statuslist { get; private set; }
        internal Object REJECTED_DATE { get; set; }
        internal Object DISAPPROVED_DATE { get; set; }
        internal Object RETURNED_DATE { get; set; }
        internal Object CANCELED_DATE { get; set; }
        internal Package(string PacelType, double Weight, SenderReceiver Sender, SenderReceiver Receiver, long SourceBID, long DestBID, long SourceRID, long DestRID,
            long bidStatus, double invoicePrice, string PaymentMethod, string PaymentStatus, int PackagingByCustomer, int Container)
        {
            this.ParcelType = PacelType;
            this.Weight = Weight;
            this.Sender = Sender;
            this.Receiver = Receiver;
            this.SourceBID = SourceBID;
            this.SourceRID = SourceRID;
            this.DestBID = DestBID;
            this.DestRID = DestRID;
            this.bidStatus = bidStatus;
            this.invoicePrice = invoicePrice;
            this.PaymentMethod = PaymentMethod;
            this.PaymentStatus = PaymentStatus;
            this.PackagingByCustomer = PackagingByCustomer;
            this.Container = Container;
            this.PayDate = nullDate;
            this.Distance = 0;
            this.statuslist = null;
        }
        internal Package(string PLID)
        {
            this.ParcelID = PLID;
            this.ParcelType = null;
            this.Weight = -1;
            this.Sender = null;
            this.Receiver = null;
            this.SourceBID = -1;
            this.SourceRID = -1;
            this.DestBID = -1;
            this.DestRID = -1;
            this.bidStatus = -1;
            this.currentStatus = null;
            this.invoicePrice = -1;
            this.PaymentMethod = null;
            this.PaymentStatus = null;
            this.PayDate = nullDate;
            this.PackagingByCustomer = -1;
            this.Container = -1;
            this.Distance = -1;
            this.statuslist = null;
        }
        internal string insertPackage()
        {
            using (SqlConnection con = new SqlConnection(connectionstr))
            {
                try
                {
                    con.Open();
                    if (Customer.CountCustomer(Sender.Email) == 1 && Sender.CID == "-1")
                    {
                        SqlCommand cmd = new SqlCommand("Select CID from Customer WHERE Email=@EMAIL", con);
                        cmd.Parameters.AddWithValue("@EMAIL", Sender.Email);
                        Sender.CID = cmd.ExecuteScalar().ToString();
                    }
                    if (Customer.CountCustomer(Receiver.Email) == 1 && Receiver.CID == "-1")
                    {
                        SqlCommand cmd = new SqlCommand("Select CID from Customer WHERE Email=@EMAIL", con);
                        cmd.Parameters.AddWithValue("@EMAIL", Receiver.Email);
                        Receiver.CID = cmd.ExecuteScalar().ToString();
                    }
                    SqlCommand cmd1 = new SqlCommand("InsertParcel", con);
                    cmd1.CommandType = CommandType.StoredProcedure;

                    cmd1.Parameters.AddWithValue("@PTYPE", this.ParcelType);
                    cmd1.Parameters.AddWithValue("@WEIGHT", this.Weight);
                    cmd1.Parameters.AddWithValue("@PAYSTATUS", this.PaymentStatus);
                    cmd1.Parameters.AddWithValue("@PAYMETHOD", this.PaymentMethod);

                    cmd1.Parameters.AddWithValue("@sCID", this.Sender.CID);
                    cmd1.Parameters.AddWithValue("@sNAME", this.Sender.Name);
                    cmd1.Parameters.AddWithValue("@sADDR", this.Sender.Address);
                    cmd1.Parameters.AddWithValue("@sEMAIL", this.Sender.Email);

                    cmd1.Parameters.AddWithValue("@rCID", this.Receiver.CID);
                    cmd1.Parameters.AddWithValue("@rNAME", this.Receiver.Name);
                    cmd1.Parameters.AddWithValue("@rADDR", this.Receiver.Address);
                    cmd1.Parameters.AddWithValue("@rEMAIL", this.Receiver.Email);

                    cmd1.Parameters.AddWithValue("@PByCus", this.PackagingByCustomer);
                    cmd1.Parameters.AddWithValue("@Container", this.Container);

                    cmd1.Parameters.AddWithValue("@sBID", this.SourceBID);
                    if (SourceBID == SourceRID || DestRID == SourceRID || DestBID == SourceRID)
                    { cmd1.Parameters.AddWithValue("@sRID", -1); }
                    else { cmd1.Parameters.AddWithValue("@sRID", this.SourceRID); }

                    cmd1.Parameters.AddWithValue("@rBID", this.DestBID);
                    if (DestBID == DestRID || SourceRID == DestRID || SourceBID == DestRID)
                    { cmd1.Parameters.AddWithValue("@rRID", -1); }
                    else { cmd1.Parameters.AddWithValue("@rRID", this.DestRID); }

                    return Convert.ToString(cmd1.ExecuteScalar());
                }
                catch (SqlException) { return null; }
                catch (Exception) { return null; }
                finally { con.Close(); }
            }
        }

        internal static DataTable GetParcelsByPLID(string PLID)
        {
            DataTable data = new DataTable("Parcel by PLID");
            using (SqlConnection con = new SqlConnection(connectionstr))
            {
                try
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter("SrcParcelByPLID", con);
                    da.SelectCommand.CommandType = CommandType.StoredProcedure;
                    da.SelectCommand.Parameters.AddWithValue("@PLID", PLID);
                    da.Fill(data);
                    return data;
                }
                catch (Exception) { return null; }
                finally { con.Close(); }
            }
        }

        internal static DataTable GetParcelsByCID(string CID, int type)///type:0 for sent ;1 for received
        {
            DataTable data = new DataTable("Parcel by PLID");
            using (SqlConnection con = new SqlConnection(connectionstr))
            {
                try
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter("SentParcelByCID", con);
                    da.SelectCommand.CommandType = CommandType.StoredProcedure;
                    da.SelectCommand.Parameters.AddWithValue("@CID", CID);
                    da.SelectCommand.Parameters.AddWithValue("@type", type);
                    da.Fill(data);
                    return data;
                }
                catch (Exception) { return null; }
                finally { con.Close(); }
            }
        }
        internal int FillData()
        {
            using (SqlConnection con = new SqlConnection(connectionstr))
            {
                try
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter("GetParcelInfo", con);
                    da.SelectCommand.CommandType = CommandType.StoredProcedure;
                    da.SelectCommand.Parameters.AddWithValue("@PLID", this.ParcelID);
                    DataTable data = new DataTable("Parcel Details");
                    da.Fill(data);
                    if (data.Rows.Count != 1) { return -1; }
                    foreach (DataRow dataRow in data.Rows)
                    {
                        this.ParcelType = dataRow.Field<string>("PTYPE");
                        this.Distance = Convert.ToDouble(dataRow.Field<decimal>("DISTANCE"));
                        this.Weight = Convert.ToDouble(dataRow.Field<decimal>("WEIGHT"));
                        this.PackagingByCustomer = dataRow.Field<int>("PACKAGEBYCUS");
                        this.invoicePrice = Convert.ToDouble(dataRow.Field<decimal>("INVOICE"));
                        this.PaymentStatus = dataRow.Field<string>("PAYSTATUS");
                        this.PaymentMethod = dataRow.Field<string>("PAYMETHOD");
                        var date = dataRow.Field<Object>("PAYDATE");
                        this.PayDate = (date == null) ? nullDate : (DateTime)date;
                        this.Container = dataRow.Field<int>("CONTAINER");

                        this.Sender = new SenderReceiver();
                        this.Sender.CID = dataRow.Field<string>("SCID");
                        this.Sender.Name = dataRow.Field<string>("SNAME");
                        this.Sender.Address = dataRow.Field<string>("SADDR");
                        this.Sender.Email = dataRow.Field<string>("SEMAIL");

                        this.Receiver = new SenderReceiver();
                        this.Receiver.CID = dataRow.Field<string>("RCID");
                        this.Receiver.Name = dataRow.Field<string>("RNAME");
                        this.Receiver.Address = dataRow.Field<string>("RADDR");
                        this.Receiver.Email = dataRow.Field<string>("REMAIL");

                        this.SourceBID = Convert.ToInt64(dataRow.Field<decimal>("SBID"));
                        this.SourceRID = Convert.ToInt64(dataRow.Field<decimal>("CP2"));
                        this.DestBID = Convert.ToInt64(dataRow.Field<decimal>("RBID"));
                        this.DestRID = Convert.ToInt64(dataRow.Field<decimal>("CP3"));
                        this.currentStatus = dataRow.Field<string>("CSTATUS");
                        this.bidStatus = Convert.ToInt64(dataRow.Field<decimal>("CBIDSTAT"));
                        this.ReqDate = dataRow.Field<DateTime>("REQDATE");


                        string cp1, cp2 = "", cp3 = "", cp4;
                        cp1 = (SourceBID != -1) ? Branch.GetBranchNameByBID(SourceBID) + "(" + SourceBID + ")" : "";
                        cp4 = (DestBID != -1) ? Branch.GetBranchNameByBID(DestBID) + "(" + DestBID + ")" : "";
                        if (SourceRID == -1 && DestRID == -1)
                        {
                            cp2 = cp3 = Branch.GetBranchNameByBID(DestBID) + "(" + DestBID + ")";
                        }
                        else if (SourceRID == -1)
                        {
                            cp2 = Branch.GetBranchNameByBID(DestRID) + "(" + DestRID + ")";
                            cp3 = Branch.GetBranchNameByBID(DestRID) + "(" + DestRID + ")";
                        }
                        else if (DestRID == -1)
                        {
                            cp2 = Branch.GetBranchNameByBID(SourceRID) + "(" + SourceRID + ")";
                            cp3 = Branch.GetBranchNameByBID(DestBID) + "(" + DestBID + ")";
                        }
                        else
                        {
                            cp2 = Branch.GetBranchNameByBID(SourceRID) + "(" + SourceRID + ")";
                            cp3 = Branch.GetBranchNameByBID(DestRID) + "(" + DestRID + ")";
                        }

                        this.statuslist = new List<Status>();
                        //0
                        int eid = Convert.ToInt32(dataRow.Field<decimal>("PROCESSED_BY"));
                        this.statuslist.Add(new Status("Request processed at " + cp1 + " By ", eid, dataRow.Field<Object>("PROCESSED_DATE")));
                        //1
                        eid = Convert.ToInt32(dataRow.Field<decimal>("OUTFRPICKUP_BY"));
                        this.statuslist.Add(new Status("Out for Pick Up By ", eid, dataRow.Field<Object>("OUTFRPICKUP_DATE")));
                        //2
                        eid = Convert.ToInt32(dataRow.Field<decimal>("PICKEDUP_BY"));
                        this.statuslist.Add(new Status("Parcel Picked Up By ", eid, dataRow.Field<Object>("PICKEDUP_DATE")));
                        //3
                        eid = Convert.ToInt32(dataRow.Field<decimal>("APPROVED_BY"));
                        if (SourceBID != DestBID)
                        {
                            this.statuslist.Add(new Status("Parcel Approved and Sent to " + cp2 + " By ", eid, dataRow.Field<Object>("APPROVED_DATE")));
                        }
                        else
                        {
                            this.statuslist.Add(new Status("Parcel Approved By ", eid, dataRow.Field<Object>("APPROVED_DATE")));
                        }
                        //4
                        eid = Convert.ToInt32(dataRow.Field<decimal>("CP2REC_BY"));
                        this.statuslist.Add(new Status("Parcel Received at " + cp2 + " By ", eid, dataRow.Field<Object>("CP2REC_DATE")));
                        //5
                        eid = Convert.ToInt32(dataRow.Field<decimal>("CP2SENT_BY"));
                        this.statuslist.Add(new Status("Parcel Sent to " + cp3 + " By ", eid, dataRow.Field<Object>("CP2SENT_DATE")));
                        //6
                        eid = Convert.ToInt32(dataRow.Field<decimal>("CP3REC_BY"));
                        this.statuslist.Add(new Status("Parcel Received at " + cp3 + " By ", eid, dataRow.Field<Object>("CP3REC_DATE")));
                        //7
                        eid = Convert.ToInt32(dataRow.Field<decimal>("CP3SENT_BY"));
                        this.statuslist.Add(new Status("Parcel Sent to " + cp4 + " By ", eid, dataRow.Field<Object>("CP3SENT_DATE")));
                        //8
                        eid = Convert.ToInt32(dataRow.Field<decimal>("CP4REC_BY"));
                        this.statuslist.Add(new Status("Parcel Received at " + cp4 + " By ", eid, dataRow.Field<Object>("CP4REC_DATE")));
                        //9
                        eid = Convert.ToInt32(dataRow.Field<decimal>("OUTFORDEL_BY"));
                        this.statuslist.Add(new Status("Out for Deivery by ", eid, dataRow.Field<Object>("OUTFORDEL_DATE")));
                        //10
                        eid = Convert.ToInt32(dataRow.Field<decimal>("DELIVERED_BY"));

                        this.statuslist.Add(new Status("Parcel Deivered by ", eid, dataRow.Field<Object>("DELIVERED_DATE")));
                        RETURNED_DATE = dataRow.Field<Object>("RETURNED_DATE");
                        CANCELED_DATE = dataRow.Field<Object>("CANCELED_DATE");
                        REJECTED_DATE = dataRow.Field<Object>("REJECTED_DATE");
                        DISAPPROVED_DATE = dataRow.Field<Object>("DISAPPROVED_DATE");
                    }
                }
                catch (Exception) { return -1; }
                finally { con.Close(); }
            }
            return 0;
        }




    }
}