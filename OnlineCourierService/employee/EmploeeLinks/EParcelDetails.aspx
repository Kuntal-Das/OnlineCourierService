<%@ Page Title="Advance Parcel Tracking" Language="C#" MasterPageFile="~/employee/EmploeeLinks/EmployeeLink.Master" AutoEventWireup="true" CodeBehind="EParcelDetails.aspx.cs" Inherits="OnlineCourierService.employee.EmploeeLinks.EParcelDetails" %>

<asp:Content ID="Chead" ContentPlaceHolderID="head" runat="server">
    <link href="css/ECreateParcel.css" rel="stylesheet" />
    <link href="../../Parcel/css/ParcelStat.css" rel="stylesheet" />
    <style>
        .content {
            width: 80vw;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
    </style>
</asp:Content>
<asp:Content ID="CErrmsg" ContentPlaceHolderID="CPHErrmsg" runat="server">
    <asp:Panel ID="Perrormsg" runat="server" CssClass="PError" EnableViewState="false">
        <div class="cross"></div>
        <asp:Label ID="Lerrmsg" runat="server" Text="" CssClass="Lerr"></asp:Label>
        <script>
            document.querySelector(".cross").addEventListener("click", _ => {
                document.querySelector(".PError").style.opacity = 0;
                document.querySelector(".PError").style.pointerEvents = "none";
            });
        </script>
    </asp:Panel>
</asp:Content>
<asp:Content ID="Cheader" ContentPlaceHolderID="CPHheader" runat="server">Advance Parcel Tracking</asp:Content>
<asp:Content ID="CsideBar" ContentPlaceHolderID="CPHsidebar" runat="server">
    <asp:HyperLink ID="HLhome" CssClass="side-link" runat="server" NavigateUrl="~/employee/emp.aspx">Home</asp:HyperLink>
    <asp:HyperLink ID="HLCreatep" CssClass="side-link" runat="server" NavigateUrl="~/employee/EmploeeLinks/ECreateParcel.aspx">Create Parcel</asp:HyperLink>
    <asp:HyperLink ID="HLUpdateP" CssClass="side-link" runat="server" NavigateUrl="~/employee/EmploeeLinks/EUpdateParcel.aspx">Update Parcel Status</asp:HyperLink>
    <asp:HyperLink ID="HLTrackP" CssClass="side-link" runat="server" NavigateUrl="~/employee/EmploeeLinks/EtrackParcel.aspx">Track Parcel</asp:HyperLink>
</asp:Content>
<asp:Content ID="Ccontent" ContentPlaceHolderID="CPHcontent" runat="server">
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
