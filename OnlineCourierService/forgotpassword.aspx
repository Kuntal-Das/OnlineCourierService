<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgotpassword.aspx.cs" Inherits="OnlineCourierService.forgotpassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=0.86, maximum-scale=3.0, minimum-scale=0.86" />
    <link rel="shortcut icon" href="lightning.ico">
    <title>Forgot Password</title>
    <link href="css/forgotpasssword.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="page">
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
            <nav class="navigation">
                <asp:HyperLink ID="logo" CssClass="logo proj-logo" runat="server" NavigateUrl="~/index.aspx"></asp:HyperLink>
                <h1 class="intro">
                    <asp:Label ID="Luser" runat="server" Text="Forgot Password"></asp:Label>
                </h1>
            </nav>
            <div class="container">
                <div class="content">
                    <asp:Label ID="Ltext" runat="server" CssClass="lable" Text="Enter Your Registered Email Address"></asp:Label>
                    <asp:TextBox ID="TBunm" CssClass="input" runat="server" autofocus="true"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVemail" runat="server" ControlToValidate="TBunm" ForeColor="Red" ErrorMessage="Email is Rqeuired" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="REVemail" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="Invalid Email Address" ControlToValidate="TBunm" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    <asp:Button ID="Bpreset" CssClass="btn" runat="server" Text="Reset Password" OnClick="Bpreset_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
