﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace OnlineCourierService.Class
{
    public class Status
    {
        string remark;
        long bid;
        DateTime date;
        public Status(string remark, long bid, DateTime date)
        {
            this.bid = bid;
            this.date = date;
            this.remark = remark;
        }
    }
    public class SenderReceiver
    {
        public string CID { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Email { get; set; }
        public SenderReceiver(string CID, string Name, string Email, string Address)
        {
            this.CID = CID;
            this.Name = Name;
            this.Email = Email;
            this.Address = Address;
        }
    }
    public class Package
    {
        private static readonly string connectionstr = "Data Source=DESKTOP-74RBQ7M\\KUNTALSQLS;Initial Catalog=CourierService;Persist Security Info=True;User ID=sa;Password=!@Kd_Hell45";
        public static readonly DateTime nullDate = new DateTime(1800, 12, 31);
        public string ParcelID { private get; set; }
        public string ParcelType { get; private set; }
        public double Weight { get; private set; }
        public long SourceBID { get; private set; }
        public long SourceRID { get; private set; }
        public long DestBID { get; private set; }
        public long DestRID { get; private set; }
        public double invoicePrice { get; private set; }
        public string PaymentMethod { get; private set; }
        public string PaymentStatus { get; private set; }
        public int PackagingByCustomer { get; private set; }
        public int Container { get; private set; }
        public double Distance { get; private set; }
        public DateTime ReqDate { get; private set; }
        public long bidStatus { get; private set; }//processing req,PickedUp,Approved,ckeckpoints(BIDs),out for Delivery,received/returned
        public string currentStatus { get; private set; }//processing req,PickedUp,Approved,ckeckpoints(BIDs),out for Delivery,received/returned
        public SenderReceiver Sender { get; private set; }
        public SenderReceiver Receiver { get; private set; }
        public List<Status> statuslist { get; private set; }
        public Package(string PacelType, double Weight, SenderReceiver Sender, SenderReceiver Receiver, long SourceBID, long DestBID, long SourceRID, long DestRID,
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
            this.Distance = 0;
            this.statuslist = null;
        }
        public Package(string PLID)
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
            this.PackagingByCustomer = -1;
            this.Container = -1;
            this.Distance = -1;
            this.statuslist = null;
        }
        public string insertPackage()
        {
            using (SqlConnection con = new SqlConnection(connectionstr))
            {
                try
                {
                    con.Open();
                    if (Customer.CountCustomer(Receiver.Email) == 1)
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
                    if (this.SourceBID == this.SourceRID) { cmd1.Parameters.AddWithValue("@sRID", -1); }
                    else { cmd1.Parameters.AddWithValue("@sRID", this.SourceRID); }

                    cmd1.Parameters.AddWithValue("@rBID", this.DestBID);
                    if (this.DestBID == this.DestRID) { cmd1.Parameters.AddWithValue("@rRID", -1); }
                    else { cmd1.Parameters.AddWithValue("@rRID", this.DestRID); }

                    return Convert.ToString(cmd1.ExecuteScalar());
                }
                catch (SqlException) { return null; }
                catch (Exception) { return null; }
                finally { con.Close(); }
            }
        }

        public static DataTable GetParcelsByPLID(string PLID)
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

        public static DataTable GetParcelsByCID(string CID, int type)///type:0 for sent ;1 for received
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
        public int FillData()
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
                        this.Distance = dataRow.Field<double>("DISTANCE");
                        this.Weight = dataRow.Field<double>("WEIGHT");
                        this.PackagingByCustomer = dataRow.Field<int>("PACKAGEBYCUS");
                        this.invoicePrice = dataRow.Field<double>("INVOICE");
                        this.PaymentStatus = dataRow.Field<string>("PAYSTATUS");
                        this.PaymentMethod = dataRow.Field<string>("PAYMETHOD");
                        this.Container = dataRow.Field<int>("CONTAINER");

                        this.Sender.CID = dataRow.Field<string>("SCID");
                        this.Sender.Name = dataRow.Field<string>("SNAME");
                        this.Sender.Address = dataRow.Field<string>("SADDR");
                        this.Sender.Email = dataRow.Field<string>("SEMAIL");

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

                        long eid = Convert.ToInt64(dataRow.Field<decimal>("PROCESSED_BY"));
                        if (eid >= 1000) { this.statuslist.Add(new Status("Request processed By", eid, dataRow.Field<DateTime>("PROCESSED_DATE"))); }
                        else { this.statuslist.Add(new Status("Request being processed", -1, nullDate)); }

                        eid = Convert.ToInt64(dataRow.Field<decimal>("PICKEDUP_BY"));
                        if (eid >= 1000) { this.statuslist.Add(new Status("Parcel Picked Up By", eid, dataRow.Field<DateTime>("PICKEDUP_DATE"))); }
                        else { this.statuslist.Add(new Status("Parcel Picked Up By", -1, nullDate)); }

                        eid = Convert.ToInt64(dataRow.Field<decimal>("APPROVED_BY"));
                        if (eid >= 1000) { this.statuslist.Add(new Status("Parcel Approved By", eid, dataRow.Field<DateTime>("APPROVED_DATE"))); }
                        else { this.statuslist.Add(new Status("Parcel Approved By", -1, nullDate)); }

                        eid = Convert.ToInt64(dataRow.Field<decimal>("CP2REC_BY"));
                        if (eid >= 1000) { this.statuslist.Add(new Status("Parcel Received at CheckPoint 2", eid, dataRow.Field<DateTime>("CP2REC_DATE"))); }
                        else { this.statuslist.Add(new Status("Parcel Received at CheckPoint 2 ", -1, nullDate)); }
                        eid = Convert.ToInt64(dataRow.Field<decimal>("CP2SENT_BY"));
                        if (eid >= 1000) { this.statuslist.Add(new Status("Parcel Sent to CheckPoint 3", eid, dataRow.Field<DateTime>("CP2SENT_DATE"))); }
                        else { this.statuslist.Add(new Status("Parcel Sent to CheckPoint 3", -1, nullDate)); }

                        eid = Convert.ToInt64(dataRow.Field<decimal>("CP3REC_BY"));
                        if (eid >= 1000) { this.statuslist.Add(new Status("Parcel Received at CheckPoint 3", eid, dataRow.Field<DateTime>("CP3REC_DATE"))); }
                        else { this.statuslist.Add(new Status("Parcel Received at CheckPoint 3", -1, nullDate)); }
                        eid = Convert.ToInt64(dataRow.Field<decimal>("CP3SENT_BY"));
                        if (eid >= 1000) { this.statuslist.Add(new Status("Parcel Sent to CheckPoint 4", eid, dataRow.Field<DateTime>("CP3SENT_DATE"))); }
                        else { this.statuslist.Add(new Status("Parcel Sent to CheckPoint 4", -1, nullDate)); }

                        //todo-----------------------------------------------------------
                        //eid = Convert.ToInt64(dataRow.Field<decimal>("CP4REC_BY"));
                        //if (eid >= 1000) { this.statuslist.Add(new Status("Parcel Received at CheckPoint 4", eid, dataRow.Field<DateTime>("CP4REC_DATE"))); }
                        //else { this.statuslist.Add(new Status("Parcel Received at CheckPoint 4", -1, nullDate)); }

                        eid = Convert.ToInt64(dataRow.Field<decimal>("OUTFORDEL_BY"));
                        if (eid >= 1000) { this.statuslist.Add(new Status("Out for Deivery by", eid, dataRow.Field<DateTime>("OUTFORDEL_DATE"))); }
                        else { this.statuslist.Add(new Status("Out for Deivery by", -1, nullDate)); }

                        eid = Convert.ToInt64(dataRow.Field<decimal>("DELIVERED_BY"));
                        if (eid >= 1000) { this.statuslist.Add(new Status("Parcel Deivered by", eid, dataRow.Field<DateTime>("DELIVERED_DATE"))); }
                        else { this.statuslist.Add(new Status("Parcel Deivered by", -1, nullDate)); }

                        var date = dataRow.Field<DateTime>("RETURNED_DATE");
                        if (date != null)
                        {
                            this.statuslist.Add(new Status("Parcel Returned By Receiver", 0, (DateTime)date));
                        }
                        date = dataRow.Field<DateTime>("CANCELED_DATE");
                        if (date != null)
                        {
                            this.statuslist.Add(new Status("Parcel Canceled By Sender", 0, (DateTime)date));
                        }
                    }
                }
                catch (Exception) { return -1; }
                finally { con.Close(); }
            }
            return 0;
        }




    }
}