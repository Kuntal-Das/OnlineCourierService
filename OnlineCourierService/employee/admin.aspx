<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="OnlineCourierService.employee.admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=0.86, maximum-scale=3.0, minimum-scale=0.86" />
    <link rel="shortcut icon" href="../lightning.ico" />
    <title>Lightning Admin Panel</title>
    <link rel="stylesheet" href="css/main.css" />
    <script type="text/javascript" src="js/main.js"></script>
</head>
<body>
    <form id="form1" method="post" runat="server">
        <div class="page">
            <nav class="navigation">
                <asp:HyperLink ID="logo" CssClass="logo proj-logo" runat="server" NavigateUrl="~/employee/admin.aspx"></asp:HyperLink>
                <h1 class="intro">
                    <asp:Label ID="Luser" runat="server" Text="Admin Pannel"></asp:Label>
                </h1>
                <div class="account">
                    <asp:Panel ID="ProundedDP" CssClass="adminDP" runat="server"></asp:Panel>

                    <asp:Label ID="Aname" CssClass="admin" runat="server" Text="Customer"></asp:Label>
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
            <main class="flex-container">
                <section class="container">
                    <div class="card">
                        <div class="card__index">01</div>
                        <h3 class="card__head">Manage Employee</h3>
                        <p class="card__text">
                            Create an Employee Account,<br />
                            Get Employee Status,<br />
                            Activate/Deactivate Employee Account,<br />
                            Change Emplyees' Workplace
                        </p>
                        <asp:HyperLink ID="HyperLink1" CssClass="card__button" runat="server" NavigateUrl="~/employee/AdminLinks/empManager.aspx">GO</asp:HyperLink>
                    </div>

                    <div class="card">
                        <div class="card__index">02</div>
                        <h3 class="card__head">Manage Regional Branch</h3>
                        <p class="card__text">
                            Create / Update Regional Branch Info.,<br />
                            Change Regional Branch Address 
                        </p>
                        <asp:HyperLink ID="HyperLink2" CssClass="card__button" runat="server" NavigateUrl="~/employee/AdminLinks/regBManager.aspx">GO</asp:HyperLink>
                    </div>

                    <div class="card">
                        <div class="card__index">03</div>
                        <h3 class="card__head">Manage Sub-Branch</h3>
                        <p class="card__text">
                            Create / Update Sub-Branch Info.,<br />
                            Change Sub-Branch Address 
                        </p>
                        <asp:HyperLink ID="HyperLink3" CssClass="card__button" runat="server" NavigateUrl="~/employee/AdminLinks/subBManager.aspx">GO</asp:HyperLink>
                    </div>

                    <div class="card">
                        <div class="card__index">04</div>
                        <h3 class="card__head">Manage Rates</h3>
                        <p class="card__text">
                            Query Current Rates,<br />
                            Update Rates
                        </p>
                        <asp:HyperLink ID="HyperLink4" CssClass="card__button" runat="server" NavigateUrl="~/employee/AdminLinks/ratesManager.aspx">GO</asp:HyperLink>
                    </div>
                </section>
            </main>
            <footer class="footer">
                <asp:Panel ID="Ppage" CssClass="footer__div" runat="server">
                    <asp:Label ID="Label1" CssClass="footer__span" runat="server" Text="Logged in as: "></asp:Label>
                    <asp:DropDownList ID="DDLpage" CssClass="ddl" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDLpage_SelectedIndexChanged">
                        <asp:ListItem>Admin</asp:ListItem>
                        <asp:ListItem>Employee</asp:ListItem>
                    </asp:DropDownList>
                </asp:Panel>
                <div class="footer__div">
                    <asp:HyperLink ID="HyperLink6" CssClass="footer__link" runat="server" NavigateUrl="#">Site Map</asp:HyperLink>
                    <span class="footer__span">&copy;2019 - 2021 Lightning Corp.</span>
                </div>
            </footer>
        </div>
    </form>
</body>
</html>
