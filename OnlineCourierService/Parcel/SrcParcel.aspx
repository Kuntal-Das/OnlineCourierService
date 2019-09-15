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
        <div class="inner__div">
            <asp:Label ID="LsrcPLID" runat="server" Text="Enter Parcel ID [Enter PLID as provided Include dashes(-) whenever ncessary] :  "></asp:Label>
            <div class="inputbox">
                <asp:TextBox ID="TBsrcPLID" CssClass="input" runat="server" required="" Width="400px"></asp:TextBox>
                <span class="floating-placeholder">Enter 32-digit Parcel ID</span>
                <asp:RequiredFieldValidator ID="RFVsrcPLID" runat="server" ErrorMessage="Parcel ID is Required" SetFocusOnError="True" ControlToValidate="TBsrcPLID"
                    Text="*" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="TBsrcPLID" ID="REVsrcParcel" ValidationExpression="^[\s\S]{32,38}$"
                    runat="server" ErrorMessage="Invalid Parcel ID" ForeColor="Red" Text="*"></asp:RegularExpressionValidator>
            </div>
            <asp:Button ID="Bsrc" CssClass="btn" runat="server" Text="Search" OnClick="Bsrc_Click" />
            <asp:ValidationSummary ID="VSsrcParcel" runat="server" ForeColor="Red" DisplayMode="List" />
        </div>
        <asp:GridView ID="GVsrcParcel" CssClass="gv" runat="server" AutoGenerateColumns="False" EnableViewState="False" DataKeyNames="PARCELid"
            EmptyDataText="No Records Found">
            <Columns>
                <asp:BoundField DataField="PARCELid" HeaderText="Parcel ID" />
                <asp:BoundField DataField="SENDER" HeaderText="Sender Name" />
                <asp:BoundField DataField="RECEIVER" HeaderText="Receiver Name" />
                <asp:BoundField DataField="PARCELTYPE" HeaderText="Parcel Type" />
                <asp:BoundField DataField="CURRENTSTATUS" HeaderText="Current Status" />
                <asp:BoundField DataField="PAYMENTSTATUS" HeaderText="Payment Status" />
                <asp:BoundField DataField="DATE" HeaderText="Date Created" DataFormatString="{0:G}" />
                <asp:HyperLinkField ShowHeader="False" Text="View Details" DataNavigateUrlFormatString="~/Parcel/ParcelStat.aspx?PLID={0}" DataNavigateUrlFields="PARCELid">
                    <ControlStyle CssClass="btn" />
                </asp:HyperLinkField>
            </Columns>
        </asp:GridView>
    </div>
    <asp:Panel ID="PYParcel" runat="server" CssClass="full__div" Visible="false">
        <h3 class="hero__text">Your Parcels</h3>
        <div class="inner__div">
            <asp:RadioButtonList ID="RBLParcels" runat="server" CssClass="rblist" AutoPostBack="True" RepeatDirection="Horizontal" RepeatLayout="Table" 
                OnSelectedIndexChanged="RBLParcels_SelectedIndexChanged">
                <asp:ListItem Text="Sent/Being Sent" Value="0" Selected="True"></asp:ListItem>
                <asp:ListItem Text="Received/Will Receive" Value="2"></asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <asp:GridView ID="GVbyCID" CssClass="gv" runat="server" AutoGenerateColumns="False" EnableViewState="False" DataKeyNames="PARCELid"
            EmptyDataText="No Records To Show">
            <Columns>
                <asp:BoundField DataField="PARCELid" HeaderText="Parcel ID" />
                <asp:BoundField DataField="SENDER" HeaderText="Sender Name" />
                <asp:BoundField DataField="RECEIVER" HeaderText="Receiver Name" />
                <asp:BoundField DataField="PARCELTYPE" HeaderText="Parcel Type" />
                <asp:BoundField DataField="CURRENTSTATUS" HeaderText="Current Status" />
                <asp:BoundField DataField="PAYMENTSTATUS" HeaderText="Payment Status" />
                <asp:BoundField DataField="DATE" HeaderText="Date Created" DataFormatString="{0:G}" />
                <asp:HyperLinkField ShowHeader="False" Text="View Details" DataNavigateUrlFormatString="~/Parcel/ParcelStat.aspx?PLID={0}" DataNavigateUrlFields="PARCELid">
                    <ControlStyle CssClass="btn" />
                </asp:HyperLinkField>
            </Columns>
        </asp:GridView>
    </asp:Panel>

</asp:Content>
