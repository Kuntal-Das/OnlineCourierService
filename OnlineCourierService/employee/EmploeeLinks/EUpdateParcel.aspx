<%@ Page Title="Update Parcel" Language="C#" MasterPageFile="~/employee/EmploeeLinks/EmployeeLink.Master" AutoEventWireup="true" CodeBehind="EUpdateParcel.aspx.cs" Inherits="OnlineCourierService.employee.EmploeeLinks.EUpdateParcel" %>

<asp:Content ID="Chead" ContentPlaceHolderID="head" runat="server">
    <link href="css/EUpdateParcel.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="CerrMsg" ContentPlaceHolderID="CPHErrmsg" runat="server">
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

<asp:Content ID="Cheader" ContentPlaceHolderID="CPHheader" runat="server">Update Parcel Status</asp:Content>

<asp:Content ID="Csidebar" ContentPlaceHolderID="CPHsidebar" runat="server">
    <asp:HyperLink ID="HLhome" CssClass="side-link" runat="server" NavigateUrl="~/employee/emp.aspx">Home</asp:HyperLink>
    <asp:HyperLink ID="HLUpdateP" CssClass="side-link" runat="server" NavigateUrl="~/employee/EmploeeLinks/ECreateParcel.aspx">Create Parcel</asp:HyperLink>
    <asp:HyperLink ID="HLCreatep" CssClass="side-link" runat="server" NavigateUrl="~/employee/EmploeeLinks/EtrackParcel.aspx">Track Parcel</asp:HyperLink>
</asp:Content>

<asp:Content ID="Ccontent" ContentPlaceHolderID="CPHcontent" runat="server">
    <div class="tabs">
        <asp:RadioButtonList ID="RBLparcel" runat="server" AutoPostBack="True" RepeatDirection="Horizontal" OnSelectedIndexChanged="RBLparcel_SelectedIndexChanged">
            <asp:ListItem Selected="True">To be Processed</asp:ListItem>
            <asp:ListItem>To be Picked Up</asp:ListItem>
            <asp:ListItem>Will be Sent to Next Branch</asp:ListItem>
            <asp:ListItem>To be Delivered</asp:ListItem>
        </asp:RadioButtonList>
    </div>
    <asp:Panel ID="P0" CssClass="tabpanel" runat="server">
        Tab1
    </asp:Panel>
    <asp:Panel ID="P1" CssClass="tabpanel" runat="server" Visible="false">
        Tab2
    </asp:Panel>
    <asp:Panel ID="P2" CssClass="tabpanel" runat="server" Visible="false">
        Tab3
    </asp:Panel>
    <asp:Panel ID="P3" CssClass="tabpanel" runat="server" Visible="false">
        Tab4
    </asp:Panel>
</asp:Content>
