<%@ Page Title="" Language="C#" MasterPageFile="~/Parcel/Parcel.Master" AutoEventWireup="true" CodeBehind="RateofParcel.aspx.cs" Inherits="OnlineCourierService.Parcel.RateofParcel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/RateofParcel.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="CPHerrMsg" runat="server"></asp:Content>

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
    Rate of Transport
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="CPHcontent" runat="server">
    <h3 class="hero-text">
        Rates Chart(in Rupees per KM) According to Parcel Type and Weight(in KG)
    </h3>
    <asp:ObjectDataSource ID="OBSPrates" runat="server" SelectMethod="GetRates" TypeName="OnlineCourierService.employee.Classes.DataAccessLayer"></asp:ObjectDataSource>
    <asp:GridView ID="GVRates" runat="server" AutoGenerateColumns="False" DataSourceID="OBSPrates" CssClass="ratesTable">
        <Columns>
            <asp:BoundField DataField="Weight" HeaderText="Weight" SortExpression="Weight" />
            <asp:BoundField DataField="Basic" HeaderText="Basic" SortExpression="Basic" DataFormatString="{0:c}" />
            <asp:BoundField DataField="Business" HeaderText="Business" SortExpression="Business" DataFormatString="{0:c}"/>
            <asp:BoundField DataField="DryFood" HeaderText="Dry Food" SortExpression="DryFood" DataFormatString="{0:c}"/>
            <asp:BoundField DataField="CookedFood" HeaderText="Cooked Food" SortExpression="CookedFood" DataFormatString="{0:c}"/>
            <asp:BoundField DataField="Gift" HeaderText="Gift" SortExpression="Gift" DataFormatString="{0:c}"/>
            <asp:BoundField DataField="Electronics" HeaderText="Electronics" SortExpression="Electronics" DataFormatString="{0:c}"/>
        </Columns>
    </asp:GridView>
</asp:Content>
