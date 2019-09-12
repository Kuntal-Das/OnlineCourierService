<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="resetPassword.aspx.cs" Inherits="OnlineCourierService.resetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=0.86, maximum-scale=3.0, minimum-scale=0.86" />
    <link rel="shortcut icon" href="lightning.ico">
    <title>Reset Password</title>
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
                    <asp:Label ID="Luser" runat="server" Text="Reset Password"></asp:Label>
                </h1>
            </nav>
            <div class="container">
                <div class="content">
                    <asp:Label ID="LNewPass" runat="server" CssClass="lable" Text="Create New Password : "></asp:Label>
                    <div class="inputbox">
                        <asp:TextBox ID="TBnewPass" TextMode="Password" CssClass="input" runat="server" autofocus="true"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFVNpass" runat="server" ControlToValidate="TBnewPass" ForeColor="Red" ErrorMessage="Enter New Password"
                            Display="Dynamic" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="REVNpass" runat="server" ControlToValidate="TBnewPass" Display="Dynamic"
                            ErrorMessage="Invalid Password" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&amp;*-]).{8,}$">*</asp:RegularExpressionValidator>
                        <span class="info">i</span>
                        <span class="msg">Password should At least one upper case English letter,<br> At least one lower case English letter,<br> At least one digit,<br> At least one special character,<br> Minimum eight in length</span>

                    </div>

                    <asp:Label ID="LCNewPass" runat="server" CssClass="lable" Text="Create New Password : "></asp:Label>

                    <div class="inputbox">
                        <asp:TextBox ID="TBCnewPass" TextMode="Password" CssClass="input" runat="server" autofocus="true"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFVCNpass" runat="server" ControlToValidate="TBCnewPass" ForeColor="Red" ErrorMessage="Confirm Password !" Display="Dynamic" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CFCNpass" runat="server" ErrorMessage="Passwords Do not Match" ControlToCompare="TBnewPass" ControlToValidate="TBCnewPass" Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:CompareValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TBCnewPass" Display="Dynamic"
                            ErrorMessage="Invalid Password" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&amp;*-]).{8,}$">*</asp:RegularExpressionValidator>
                        <span class="info">i</span>
                        <span class="msg">Password should At least one upper case English letter,<br> At least one lower case English letter,<br> At least one digit,<br> At least one special character,<br> Minimum eight in length</span>
                    </div>
                    <asp:ValidationSummary ID="VSrPass" ForeColor="Red" DisplayMode="List" runat="server" />
                    <asp:Button ID="BcngP" CssClass="btn" runat="server" Text="Change Password" OnClick="BcngP_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
