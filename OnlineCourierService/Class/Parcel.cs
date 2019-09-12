using System;
using System.Collections.Generic;
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
        public string Email { get; set; }
        public SenderReceiver(string CID, string Name, string Email)
        {
            this.CID = CID;
            this.Name = Name;
            this.Email = Email;
        }
    }
    public class Parcel : CheckPoint
    {
        public string ParcelID { private get; set; }
        public string ParcelType { get; set; }
        public double Weight { get; set; }
        public long SourceBID { get; set; }
        public long DestBID { get; set; }
        public string SourceAddr { get; set; }
        public string DestAddr { get; set; }
        public double invoicePrice { get; set; }
        public string PaymentMethod { get; set; }
        public bool PaymentStatus { get; set; }
        public long ApprovedByEID { get; set; }
        public SenderReceiver Sender { get; set; }
        public SenderReceiver Receiver { get; set; }
        public List<CheckPoint> BoundPath { get; set; }//BIDs->Time->EID(if possible)
        public List<string> sendingStatus { get; set; }//processing req,PickedUp,Approved,ckeckpoints(BIDs),out for Delivery,received/returned
        public Parcel(string PacelType, double Weight, string SenderCID, string ReceiverCID, string SenderName, string ReceiverName,
            string SenderEmail, string ReceiverEmail, long SourceBID, long DestBID, List<CheckPoint> BoundPath,
            string SourceAddr, string DestAddr, string sendingStatus, double invoicePrice, string PaymentMethod, bool PaymentStatus)
        {
            this.ParcelType = PacelType;
            this.Weight = Weight;
            this.SourceBID = SourceBID;
            this.DestBID = DestBID;
            this.SourceAddr = SourceAddr;
            this.DestAddr = DestAddr;
            this.sendingStatus.Add(sendingStatus);
            this.invoicePrice = invoicePrice;
            this.PaymentMethod = PaymentMethod;
            this.PaymentStatus = PaymentStatus;
            this.Sender = new SenderReceiver(SenderCID, SenderName, SenderEmail);
            this.Receiver = new SenderReceiver(ReceiverCID, ReceiverName, ReceiverEmail);
            this.BoundPath = BoundPath;
        }
    }
}