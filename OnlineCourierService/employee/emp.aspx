<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="emp.aspx.cs" Inherits="OnlineCourierService.employee.emp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=0.86, maximum-scale=3.0, minimum-scale=0.86" />
    <link rel="shortcut icon" href="../lightning.ico" />
    <title>Lightning Employee Page</title>
    <script src="js/main.js"></script>
    <link href="css/main.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" method="post" runat="server">
        <div class="page">
            <nav class="navigation">
                <asp:HyperLink ID="logo" CssClass="logo proj-logo" runat="server" NavigateUrl="~/employee/emp.aspx"></asp:HyperLink>
                <h1 class="intro">
                    <asp:Label ID="Luser" runat="server" Text="Employee Pannel"></asp:Label>
                </h1>
                <div class="account">
                    <asp:Panel ID="ProundedDP" CssClass="adminDP" runat="server"></asp:Panel>

                    <asp:Label ID="Aname" CssClass="admin" runat="server" Text="Employee"></asp:Label>
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
                        <h3 class="card__head">Create A Parcel</h3>
                        <p class="card__text">
                            Create a new parcel on behalf of a User(Registered/Unregistered)
                        </p>
                        <asp:HyperLink ID="HyperLink1" CssClass="card__button" runat="server" NavigateUrl="#">GO</asp:HyperLink>
                    </div>

                    <div class="card">
                        <div class="card__index">02</div>
                        <h3 class="card__head">Update Parcel Status</h3>
                        <p class="card__text">
                            Are you a Delivery Person?<br />
                            update the status of the parcel you deliver on the Go!<br />
                            Not a Delivery Person, You can still update Status of a parcel if it reaches in your branch!
                        </p>
                        <asp:HyperLink ID="HyperLink2" CssClass="card__button" runat="server" NavigateUrl="#">GO</asp:HyperLink>
                    </div>

                    <div class="card">
                        <div class="card__index">03</div>
                        <h3 class="card__head">Track pacel</h3>
                        <p class="card__text">
                            Track Parcel by Parcel ID,<br />
                            Get Current Status of the parcel
                        </p>
                        <asp:HyperLink ID="HyperLink3" CssClass="card__button" runat="server" NavigateUrl="#">GO</asp:HyperLink>
                    </div>
                </section>
            </main>
            <footer class="footer">
                <asp:Panel ID="Ppage" CssClass="footer__div" runat="server" Visible="false">
                    <asp:Label ID="Label1" CssClass="footer__span" runat="server" Text="Logged in as: "></asp:Label>
                    <asp:DropDownList ID="DDLpage" CssClass="ddl" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDLpage_SelectedIndexChanged">
                        <asp:ListItem>Admin</asp:ListItem>
                        <asp:ListItem Selected="True">Employee</asp:ListItem>
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
