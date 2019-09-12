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
    } 
    public class Parcel : CheckPoint
    {
        public string ParcelID { private get; set; }
        public string ParcelType { get; set; }
        public double Weight { get; set; }
        public string SenderCID { get; set; }
        public string ReceiverCID { get; set; }
        public string SenderName { get; set; }
        public string ReciverName { get; set; }
        public long SourceBID { get; set; }
        public long DestBID { get; set; }
        public string SourceAddr { get; set; }
        public string DestAddr { get; set; }
        public List<CheckPoint> BoundPath { get; set; }//BIDs->Time->EID(if possible)
        public List<string> sendingStatus { get; set; }//processing req,PickedUp,Approved,ckeckpoints(BIDs),out for Delivery,received/returned
        public double invoicePrice { get; set; }
        public string PaymentMethod { get; set; }
        public bool PaymentStatus { get; set; }
        public Parcel(string PacelType,double Weight,string SenderCID,string ReceiverCID,long SourceBID,long DestBID,
            string SourceAddr,string DestAddr,string sendingStatus,double invoicePrice,string PaymentMethod, bool PaymentStatus)
        {
            this.ParcelType = ParcelType;
            this.Weight = Weight;
            this.SenderCID = SenderCID;
            this.ReceiverCID = ReceiverCID;
            this.SourceBID = SourceBID;
            this.DestBID = DestBID;
            this.SourceAddr = SourceAddr;
            this.DestAddr = DestAddr;
            this.sendingStatus.Add(sendingStatus);
            this.invoicePrice = invoicePrice;
            this.PaymentMethod = PaymentMethod;
            this.PaymentStatus = PaymentStatus;
        }
    }
}