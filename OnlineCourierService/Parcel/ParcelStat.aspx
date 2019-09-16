<%@ Page Title="Parcel Details" Language="C#" MasterPageFile="~/Parcel/Parcel.Master" AutoEventWireup="true" CodeBehind="ParcelStat.aspx.cs" Inherits="OnlineCourierService.Parcel.ParcelStat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/ParcelStat.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="CPHerrMsg" runat="server">
    <asp:Panel ID="PError" runat="server" CssClass="PError" EnableViewState="false">
        <div class="cross"></div>
        <asp:Label ID="Lerr" runat="server" Text="" CssClass="Lerr"></asp:Label>
        <script>
            document.querySelector(".cross").addEventListener("click", _ => {
                document.querySelector(".PError").style.opacity = 0;
                document.querySelector(".PError").style.pointerEvents = "none";
            });
        </script>
    </asp:Panel>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CPHuser" runat="server">
    <asp:LinkButton ID="LoginSignIn" CssClass="login" runat="server" CausesValidation="false" OnClick="LoginSignIn_Click">
        <span></span><span></span><span></span><span></span>
        Sign Up or Login <svg role="presentation" class="icon user--icon"><use xlink:href="#usericon" /></svg>
    </asp:LinkButton>
    <asp:Panel ID="Puser" CssClass="account" runat="server" Visible="false" OnClick="toogleUserontrol();">
        <asp:Panel ID="ProundedDP" CssClass="userDP" runat="server"></asp:Panel>
        <asp:Label ID="Aname" CssClass="user" runat="server" Text="Employee"></asp:Label>
        <ul class="usercontrol hidden">
            <li class="l2__nav">
                <asp:HyperLink CssClass="l2__link" ID="profile" runat="server" NavigateUrl="~/Profile.aspx">My Profile</asp:HyperLink>
            </li>
            <li class="l2__nav">
                <asp:LinkButton ID="signout" CausesValidation="false" CssClass="l2__link" runat="server" OnClick="Logout">Log Out</asp:LinkButton>
            </li>
        </ul>
    </asp:Panel>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="CPHheader" runat="server">
    Parcel Details
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="CPHcontent" runat="server">
    <div class="info__container">
        <h3>Parcel Details</h3>
        <span>&#9661;</span>
    </div>
    <div class="content">
        <div class="half__div">
            <h3 class="hero__text">Parcel Details</h3>
            <asp:Label ID="LPLID" CssClass="lable" runat="server" Text="Parcel ID : "></asp:Label>
            <asp:Label ID="LPtype" CssClass="lable" runat="server" Text="Parcel Type : "></asp:Label>
            <asp:Label ID="LPweight" CssClass="lable" runat="server" Text="Parcel Weight : "></asp:Label>
            <asp:Label ID="LPRdate" CssClass="lable" runat="server" Text="Parcel Request Date : "></asp:Label>
            <asp:Label ID="LPpackaging" CssClass="lable" runat="server" Text="Parcel Packaging Managed by : "></asp:Label>
            <asp:Label ID="LPcontainer" CssClass="lable" runat="server" Text="Parcel Containers : " Visible="false"></asp:Label>
            <asp:Label ID="LPDistance" CssClass="lable" runat="server" Text="Distance : "></asp:Label>
        </div>
        <div class="half__div">
            <h3 class="hero__text">Parcel Payment Details</h3>
            <asp:Label ID="LPinvoicePrice" CssClass="lable" runat="server" Text="Parcel Invoice Price : "></asp:Label>
            <asp:Label ID="LPpaymentStat" CssClass="lable" runat="server" Text="Parcel Payment Status : "></asp:Label>
            <asp:Label ID="LPpaymentMethod" CssClass="lable" runat="server" Text="Parcel Payment Method : "></asp:Label>
            <asp:Label ID="LPpaymentDate" CssClass="lable" runat="server" Text="Payment Date : "></asp:Label>
        </div>
    </div>

    <div class="info__container">
        <h3>Sender / Receiver Details</h3>
        <span>&#9661;</span>
    </div>
    <div class="content">
        <div class="half__div">
            <h3 class="hero__text">Sender Details</h3>
            <asp:Label ID="LSname" CssClass="lable" runat="server" Text="Name : "></asp:Label>
            <asp:Label ID="LSaddress" CssClass="lable" runat="server" Text="Address : "></asp:Label>
            <asp:Label ID="LSemail" CssClass="lable" runat="server" Text="Email : "></asp:Label>
            <asp:Label ID="LSisRegistered" CssClass="lable" runat="server" Text="Is Registered : "></asp:Label>
            <asp:Label ID="LSphno" CssClass="lable" runat="server" Text="Phone No. : " Visible="false"></asp:Label>
        </div>
        <div class="half__div">
            <h3 class="hero__text">Receiver Details</h3>
            <asp:Label ID="LRname" CssClass="lable" runat="server" Text="Parcel Type : "></asp:Label>
            <asp:Label ID="LRaddress" CssClass="lable" runat="server" Text="Parcel Weight : "></asp:Label>
            <asp:Label ID="LRemail" CssClass="lable" runat="server" Text="Email : "></asp:Label>
            <asp:Label ID="LRisRegistered" CssClass="lable" runat="server" Text="Is Registered : "></asp:Label>
            <asp:Label ID="LRphno" CssClass="lable" runat="server" Text="Phone No. : " Visible="false"></asp:Label>
        </div>
    </div>
    <div class="info__container">
        <h3>Parcel Status</h3>
        <span>&#9661;</span>
    </div>
    <div class="status">
        <asp:Panel ID="PprogressBar" CssClass="progressbar" runat="server"></asp:Panel>
        <asp:Panel ID="Pprocessing" CssClass="stat__div" runat="server">
            <span class="round"></span>
            <asp:Label ID="Lprocessing" runat="server" Text="Prossing"></asp:Label><asp:Label ID="LpDate" runat="server" Text="Date : "></asp:Label>
        </asp:Panel>
        <asp:Panel ID="PoutForPickUp" CssClass="stat__div" runat="server">        
            <span class="round"></span>
            <asp:Label ID="Lofpu" runat="server" Text="Out for Pick Up"></asp:Label><asp:Label ID="LofpuDate" runat="server" Text="Date : "></asp:Label>
        </asp:Panel>
        <asp:Panel ID="PpickedUp" CssClass="stat__div" runat="server">        
            <span class="round"></span>
            <asp:Label ID="Lpickedup" runat="server" Text="Picked Up By"></asp:Label><asp:Label ID="LpuDate" runat="server" Text="Date : "></asp:Label>
        </asp:Panel>
        <asp:Panel ID="Papproved" CssClass="stat__div" runat="server">        
            <span class="round"></span>
            <asp:Label ID="Lappr" runat="server" Text="Being Approved"></asp:Label><asp:Label ID="LapprDate" runat="server" Text="Date : "></asp:Label>
        </asp:Panel>
        <asp:Panel ID="PrCP2" CssClass="stat__div" runat="server">   
            <span class="round"></span>
            <asp:Label ID="LrCP2" runat="server" Text="Reached Checkpoint 2 "></asp:Label><asp:Label ID="LrCP2Date" runat="server" Text="Date : "></asp:Label>
        </asp:Panel>
        <asp:Panel ID="PsCP2" CssClass="stat__div" runat="server">   
            <span class="round"></span>
            <asp:Label ID="LsCP2" runat="server" Text="Out for Checkpoint 3 "></asp:Label><asp:Label ID="LsCP2Date" runat="server" Text="Date : "></asp:Label>
        </asp:Panel>
        <asp:Panel ID="PrCP3" CssClass="stat__div" runat="server">   
            <span class="round"></span>
            <asp:Label ID="LrCP3" runat="server" Text="Reached Checkpoint 3 "></asp:Label><asp:Label ID="LrCP3Date" runat="server" Text="Date : "></asp:Label>
        </asp:Panel>
        <asp:Panel ID="PsCP3" CssClass="stat__div" runat="server">   
            <span class="round"></span>
            <asp:Label ID="LsCP3" runat="server" Text="Out for Checkpoint 4 "></asp:Label><asp:Label ID="LsCP3Date" runat="server" Text="Date : "></asp:Label>
        </asp:Panel>
        <asp:Panel ID="PrCP4" CssClass="stat__div" runat="server">   
            <span class="round"></span>
            <asp:Label ID="LrCP4" runat="server" Text="Reached Checkpoint 4 "></asp:Label><asp:Label ID="LrCP4Date" runat="server" Text="Date : "></asp:Label>
        </asp:Panel>
        <asp:Panel ID="PoutForDeli" CssClass="stat__div" runat="server">   
            <span class="round"></span>
            <asp:Label ID="LoutForDeli" runat="server" Text="Out for Delivery"></asp:Label><asp:Label ID="LoutForDeliDate" runat="server" Text="Date : "></asp:Label>
        </asp:Panel>
        <asp:Panel ID="PdeliBy" CssClass="stat__div" runat="server">   
            <span class="round"></span>
            <asp:Label ID="LdeliBy" runat="server" Text="Delivered By "></asp:Label><asp:Label ID="LdeliByDate" runat="server" Text="Date : "></asp:Label>
        </asp:Panel>
        <asp:Panel ID="Preturn" CssClass="stat__div" runat="server">
            <span class="round"></span>
            <asp:Label ID="Lreturn" runat="server" Text="Returned by Receiver"></asp:Label><asp:Label ID="LreturnDate" runat="server" Text="Date : "></asp:Label>
        </asp:Panel>
        <asp:Panel ID="Pcancel" CssClass="stat__div" runat="server">
            <span class="round"></span>
            <asp:Label ID="Lcancel" runat="server" Text="Canceled by Sender"></asp:Label><asp:Label ID="LcancelDate" runat="server" Text="Date : "></asp:Label>
        </asp:Panel>
    </div>
</asp:Content>
