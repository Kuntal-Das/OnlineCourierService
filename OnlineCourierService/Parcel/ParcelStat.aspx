<%@ Page Title="Advance Shipment Tracking" Language="C#" MasterPageFile="~/Parcel/Parcel.Master" AutoEventWireup="true" CodeBehind="ParcelStat.aspx.cs" Inherits="OnlineCourierService.Parcel.ParcelStat" %>

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
    Advance Shipment Tracking
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="CPHcontent" runat="server">
    <div class="info__container">
        <h3>Parcel Details</h3>
        <span>&#9661;</span>
    </div>
    <div class="DetailsTab">
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
    <div class="DetailsTab">
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
    <asp:Panel ID="Pstatus" CssClass="status" runat="server">
        <asp:Panel ID="PprogressBar" CssClass="progressbar" runat="server"></asp:Panel>
    </asp:Panel>
</asp:Content>
