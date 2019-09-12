<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="notification.aspx.cs" Inherits="OnlineCourierService.employee.notification" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=0.86, maximum-scale=3.0, minimum-scale=0.86" />
    <link rel="shortcut icon" href="../lightning.ico" />
    <title>Notification</title>
    <link rel="stylesheet" href="css/notification.css" />
    <script type="text/javascript" src="js/main.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page">
            <nav class="navigation">
                <asp:HyperLink ID="logo" CssClass="logo proj-logo" runat="server" NavigateUrl="~/employee/emp.aspx"></asp:HyperLink>
                <h1 class="intro">All Notifications</h1>
                <div class="account">
                    <asp:Panel ID="ProundedDP" CssClass="userDP" runat="server"></asp:Panel>

                    <asp:Label ID="Aname" CssClass="user" runat="server" Text="Employee"></asp:Label>
                    <ul class="dropdown hidden">
                        <li class="l2__nav">
                            <asp:HyperLink CssClass="l2__link" ID="profile" runat="server" NavigateUrl="~/employee/empProfile.aspx">My Profile</asp:HyperLink>
                        </li>
                        <li class="l2__nav">
                            <asp:LinkButton ID="signout" CssClass="l2__link" runat="server" OnClick="Logout">Log Out</asp:LinkButton>
                        </li>
                    </ul>
                </div>
            </nav>
            <div class="Main-container">
                <div class="side-nav">
                    <asp:HyperLink ID="hlhome" CssClass="side-link" runat="server" NavigateUrl="~/employee/admin.aspx">Home</asp:HyperLink>
                    <asp:HyperLink ID="hlemanager" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/empManager.aspx">Employee Manager</asp:HyperLink>
                    <asp:HyperLink ID="hlrbmanager" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/regBManager.aspx">Regional Branch Manager</asp:HyperLink>
                    <asp:HyperLink ID="hlsbmanager" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/subBManager.aspx">Sub-Branch Manager</asp:HyperLink>
                    <asp:HyperLink ID="hlrates" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/ratesManager.aspx">Rates Manager</asp:HyperLink>

                </div>
                <asp:Panel ID="Panel1" CssClass="flex-container" runat="server"></asp:Panel>
            </div>
            <footer class="footer">
                <asp:HyperLink ID="sitemap" CssClass="footer__link" runat="server" NavigateUrl="#">Site Map</asp:HyperLink>
                <span class="footer__span">&copy;2019 - 2021 Lightning Corp.</span>
            </footer>
        </div>
    </form>
</body>
</html>
