using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace OnlineCourierService.Class
{
    public class CheckPoint
    {
        protected long BID { get; set; }
        protected DateTime RecTime { get; set; }
        protected int RecByEID { get; set; }
        protected DateTime SentTime { get; set; }
        protected int SentByEID { get; set; }
        public CheckPoint(long BID, DateTime RecTime, int RecByEID, DateTime SentTime, int SentByEID)
        {
            this.BID = BID;
            this.RecTime = RecTime;
            this.RecByEID = RecByEID;
            this.SentTime = SentTime;
            this.SentByEID = SentByEID;
        }
        public CheckPoint() { }
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
        public string ParcelID { private get; set; }
        public string ParcelType { get; set; }
        public double Weight { get; set; }
        public long SourceBID { get; set; }
        public long SourceRID { get; set; }
        public long DestBID { get; set; }
        public long DestRID { get; set; }
        public double invoicePrice { get; set; }
        public string PaymentMethod { get; set; }
        public string PaymentStatus { get; set; }
        public long ApprovedByEID { get; set; }
        public SenderReceiver Sender { get; set; }
        public SenderReceiver Receiver { get; set; }
        public int PackagingByCustomer { get; set; }
        public int Container { get; set; }
        public List<long> BoundPath { get; set; }//BIDs->Time->EID(if possible)
        public long sendingStatus { get; set; }//processing req,PickedUp,Approved,ckeckpoints(BIDs),out for Delivery,received/returned
        public Package(string PacelType, double Weight, SenderReceiver Sender, SenderReceiver Receiver, long SourceBID, long DestBID,long SourceRID, long DestRID,
            long sendingStatus, double invoicePrice, string PaymentMethod, string PaymentStatus, int PackagingByCustomer, int Container)
        {
            this.ParcelType = PacelType;
            this.Weight = Weight;
            this.Sender = Sender;
            this.Receiver = Receiver;
            this.SourceBID = SourceBID;
            this.DestBID = DestBID;
            this.SourceRID = SourceRID;
            this.DestRID = DestRID;
            this.sendingStatus = sendingStatus;
            this.invoicePrice = invoicePrice;
            this.PaymentMethod = PaymentMethod;
            this.PaymentStatus = PaymentStatus;
            this.PackagingByCustomer = PackagingByCustomer;
            this.Container = Container;
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
                    cmd1.Parameters.AddWithValue("@sBID", this.SourceBID);
                    cmd1.Parameters.AddWithValue("@sRID", this.SourceRID);
                    cmd1.Parameters.AddWithValue("@sEMAIL", this.Sender.Email);

                    cmd1.Parameters.AddWithValue("@rCID", this.Receiver.CID);
                    cmd1.Parameters.AddWithValue("@rNAME", this.Receiver.Name);
                    cmd1.Parameters.AddWithValue("@rADDR", this.Receiver.Address);
                    cmd1.Parameters.AddWithValue("@rBID", this.DestBID);
                    cmd1.Parameters.AddWithValue("@rRID", this.DestRID);
                    cmd1.Parameters.AddWithValue("@rEMAIL", this.Receiver.Email);

                    cmd1.Parameters.AddWithValue("@PByCus", this.PackagingByCustomer);
                    cmd1.Parameters.AddWithValue("@Container", this.Container);

                    return Convert.ToString(cmd1.ExecuteScalar());
                }
                catch (SqlException) { return null; }
                catch (Exception) { return null; }
                finally { con.Close(); }
            }
        }





    }
}