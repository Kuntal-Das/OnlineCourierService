<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="password.aspx.cs" Inherits="OnlineCourierService.employee.password" %>
<%@ PreviousPageType VirtualPath="~/employee/login.aspx" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=0.86, maximum-scale=3.0, minimum-scale=0.86"/>
    <title>Lightning Corp. Employee Login</title>
    <link rel="shortcut icon" href="../lightning.ico" />
    <link rel="stylesheet" href="css/login.css" />
    <script type="text/javascript" src="js/logadmpass.js"></script>
</head>
<body>
    <div class="logintab">
        <div class="hero">
            <asp:Image ID="Image1" runat="server" CssClass="hero__img" ImageUrl="~/employee/svg/project_logo.svg" />
            <h1 class="hero__text">Employee Login</h1>
        </div>
        <main id="swap" class="wrapper transition-fade">
            <form id="form2" runat="server" method="post" onsubmit="return validatepass();">
                <div class="inputbox">
                    <asp:Label ID="adminName" runat="server" Text="Admin" Font-Size="Medium" Visible="false"></asp:Label>
                    <asp:Label ID="status" CssClass="error" runat="server" Text="ERROR" Enabled="false" Visible="false" ForeColor="Red"></asp:Label>
                    <asp:TextBox ID="Apass" CssClass="input" runat="server" TextMode="Password" autocomplete="false" placeholder="password" autofocus="" required=""></asp:TextBox>
                    <div class="next">
                        <asp:HyperLink ID="forgotPass" CssClass="link__a" runat="server" NavigateUrl="~/employee/EforgotPassword.aspx" Visible="false">Forgot Password</asp:HyperLink>
                        <asp:Button ID="Login" CssClass="submit" runat="server" Text="Login" OnClick="logIn" />
                    </div>
                </div>
            </form>
        </main>
    </div>
</body>
</html>
