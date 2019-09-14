<%@ Page Title="Search Parcel" Language="C#" MasterPageFile="~/Parcel/Parcel.Master" AutoEventWireup="true" CodeBehind="SrcParcel.aspx.cs" Inherits="OnlineCourierService.Parcel.SrcParcel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/SrcParcel.css" rel="stylesheet" />
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
    Track Your Parcels/Packages
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="CPHcontent" runat="server">
    <div class="full__div">
        <h3 class="hero__text">Search Parcel</h3>
        <asp:Label ID="LsrcPLID" runat="server" Text="Enter Parcel ID"></asp:Label>
        <div class="inputbox">
            <asp:TextBox ID="TBsrcPLID" CssClass="input" runat="server" required=""></asp:TextBox>
            <span class="floating-placeholder">Enter 32-digit Parcel ID</span>
            <asp:RequiredFieldValidator ID="RFVsrcPLID" runat="server" ErrorMessage="Parcel ID is Required" SetFocusOnError="True" ControlToValidate="TBsrcPLID"
                Text="*" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <asp:Button ID="Bsrc" CssClass="btn" runat="server" Text="Search" />
    </div>
    <asp:Panel ID="Panel1" runat="server" CssClass="full__div" Visible="false">
        <h3 class="hero__text">Your Parcels</h3>
        <asp:GridView ID="GVpParcel" CssClass="gv" runat="server"></asp:GridView>
    </asp:Panel>
    <asp:GridView ID="GVsrcParcel" CssClass="gv" runat="server"></asp:GridView>

</asp:Content>
