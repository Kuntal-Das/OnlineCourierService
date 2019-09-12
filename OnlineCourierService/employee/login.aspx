<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="OnlineCourierService.employee.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=0.86, maximum-scale=3.0, minimum-scale=0.86">
    <title>Lightning Corp. Employee Login</title>
    <link rel="shortcut icon" href="../lightning.ico" />
    <link rel="stylesheet" href="css/login.css" />
    <script src="js/logadmunm.js"></script>
</head>
<body>
    <div class="logintab">
        <div class="hero">
            <asp:Image ID="Image1" runat="server" CssClass="hero__img" ImageUrl="~/employee/svg/project_logo.svg" />
            <h1 class="hero__text">Employee Login</h1>
        </div>
        <main class="wrapper" data-router-wrapper="">
            <form id="adminlogin" runat="server" method="post" onsubmit="return validateuser();">
                <div class="inputbox">
                    <asp:Label ID="UsernameError" CssClass="error" runat="server" Text="ERROR" Visible="False"></asp:Label>
                    <asp:TextBox ID="Aname" CssClass="input" runat="server" MaxLength="100" placeholder="Email Address or Phone No." autocomplete="false" autofocus="" required=""></asp:TextBox>
                    <div class="next">
                        <asp:Button ID="next" CssClass="submit" runat="server" Text="next" OnClick="getUser" />
                    </div>
                </div>
            </form>
        </main>
    </div>
</body>
</html>
