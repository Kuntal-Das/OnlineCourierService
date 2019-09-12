<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/index.Master" AutoEventWireup="true" CodeBehind="changePassword.aspx.cs" Inherits="OnlineCourierService.changePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/changePassword.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="CPHerrMsg" runat="server">
    <asp:Panel ID="PError" runat="server" CssClass="PError">
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
    <asp:Panel ID="Puser" CssClass="account" runat="server" OnClick="toogleUserontrol();">
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
    Change Password
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="CPHcontent" runat="server">
    <div class="cngpass">
        <div class="inputbox">
            <asp:TextBox ID="TBOLDpass" CssClass="input" TextMode="Password" runat="server" autocomplete="off" required=""></asp:TextBox>
            <span class="floating-placeholder">Old Password</span>
            <asp:RequiredFieldValidator ID="RFVOpass" runat="server" ErrorMessage="Old Password is Reqired" ControlToValidate="TBOLDpass" Display="Dynamic"
                ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
        </div>

        <div class="inputbox">
            <asp:TextBox ID="TBpass" CssClass="input" TextMode="Password" runat="server" autocomplete="off" required=""></asp:TextBox>
            <span class="floating-placeholder">Create New Password</span>
            <asp:RequiredFieldValidator ID="RFVpass" runat="server" ErrorMessage="Password is Reqired" ControlToValidate="TBpass" Display="Dynamic"
                ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="REVNpass" runat="server" ControlToValidate="TBpass" Display="Dynamic"
                            ErrorMessage="Invalid Password" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&amp;*-]).{8,}$">*</asp:RegularExpressionValidator>
                        <span class="info">i</span>
                        <span class="msg">Password should At least one upper case English letter,<br> At least one lower case English letter,<br> At least one digit,<br> At least one special character,<br> Minimum eight in length</span>
        </div>
        <div class="inputbox">
            <asp:TextBox ID="TBcpass" CssClass="input" TextMode="Password" runat="server" autocomplete="off" required=""></asp:TextBox>
            <span class="floating-placeholder">Confirm New Password</span>
            <asp:RequiredFieldValidator ID="RFVcpass" runat="server" ErrorMessage="Confirm Password !" ControlToValidate="TBcpass" Display="Dynamic"
                ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CVcpass" runat="server" ErrorMessage="Passwords Don't Match" ControlToCompare="TBpass" ControlToValidate="TBcpass"
                Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:CompareValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TBcpass" Display="Dynamic"
                            ErrorMessage="Invalid Password" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&amp;*-]).{8,}$">*</asp:RegularExpressionValidator>
                        <span class="info">i</span>
                        <span class="msg">Password should At least one upper case English letter,<br> At least one lower case English letter,<br> At least one digit,<br> At least one special character,<br> Minimum eight in length</span>

        </div>
        <asp:ValidationSummary ID="VSpass" ForeColor="Red" DisplayMode="List" runat="server" />
        <div class="action">
            <asp:LinkButton ID="LBreg" CssClass="btn" runat="server" OnClick="CngPass">Change Password</asp:LinkButton>
            <asp:LinkButton ID="LBcancel" CssClass="cbtn" runat="server" CausesValidation="false" OnClick="Cancel">Cancel</asp:LinkButton>
        </div>
    </div>
</asp:Content>
