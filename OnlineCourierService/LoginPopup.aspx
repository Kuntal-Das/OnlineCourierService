<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPopup.aspx.cs" Inherits="OnlineCourierService.LoginPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login PopUp</title>
    <link href="css/LoginPopup.css" rel="stylesheet" />
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
            </nav>
            <div class="container">
                <div class="logintab">
                    <div class="inputbox">
                        <asp:TextBox ID="TBunm" CssClass="input" runat="server" autocomplete="off" autoFocus="true" required=""></asp:TextBox>
                        <span class="floating-placeholder">Email / Phone No.</span>
                        <asp:RequiredFieldValidator ID="RFVunm" runat="server" ErrorMessage="Username is Required" ControlToValidate="TBunm" Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                    </div>
                    <div class="inputbox">
                        <asp:TextBox ID="TBpas" CssClass="input" runat="server" TextMode="Password" required=""></asp:TextBox>
                        <span class="floating-placeholder">Password</span>
                        <asp:RequiredFieldValidator ID="RFVpass" runat="server" ErrorMessage="Password is Required" ControlToValidate="TBpas" Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                    </div>
                    <asp:ValidationSummary ID="VSlogin" ForeColor="Red" DisplayMode="List" runat="server" />
                    <asp:Button ID="Blogin" CssClass="btn" runat="server" Text="Log In" OnClick="Blogin_Click" />
                    <asp:LinkButton ID="LBskip" CssClass="cbtn" runat="server" OnClick="LBskip_Click" CausesValidation="false">Skip</asp:LinkButton>
                    <div class="link">
                        <asp:HyperLink ID="HyperLink46" CssClass="link_a" NavigateUrl="~/register.aspx" runat="server">Create Account</asp:HyperLink>
                        <asp:HyperLink ID="HyperLink47" CssClass="link_a" NavigateUrl="~/forgotpassword.aspx" runat="server">Forgot Password?</asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
