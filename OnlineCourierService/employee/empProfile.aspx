<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="empProfile.aspx.cs" Inherits="OnlineCourierService.employee.empProfile" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE h
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=0.86, maximum-scale=3.0, minimum-scale=0.86" />
    <link rel="shortcut icon" href="../lightning.ico" />
    <title>My Proflie</title>
    <link rel="stylesheet" href="css/empProfile.css" />
    <script type="text/javascript" src="js/empProfile.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page">
            <asp:Panel ID="PError" runat="server" Visible="false">
                <div class="cross"></div>
                <asp:Label ID="LimgiploadErr" runat="server" Text="Label" Visible="true"></asp:Label>
                <script>
                    document.querySelector(".cross").addEventListener("click", _ => {
                        document.getElementById("PError").style.opacity = 0;
                        document.getElementById("PError").style.pointerEvents = "none";
                    });
                </script>
            </asp:Panel>

            <nav class="navigation">
                <asp:HyperLink ID="logo" CssClass="logo proj-logo" runat="server" NavigateUrl="~/employee/emp.aspx"></asp:HyperLink>
                <h1 class="intro">
                    My Profile(<asp:Label ID="Luser" runat="server" Text="User"></asp:Label>) <asp:Label ID="LID" runat="server" Text="Employee ID:"></asp:Label>
                </h1>
                <div class="account">
                    <asp:Panel ID="ProundedDP" CssClass="userDP" runat="server"></asp:Panel>

                    <asp:Label ID="Aname" CssClass="user" runat="server" Text="Employee"></asp:Label>
                    <ul class="dropdown hidden">
                        <li class="l2__nav">
                            <asp:LinkButton ID="signout" CssClass="l2__link" runat="server" OnClick="Logout">Log Out</asp:LinkButton>
                        </li>
                    </ul>
                </div>
            </nav>
            <div class="Main-container">
                <div class="side-nav">
                    <asp:HyperLink ID="HLhome" CssClass="side-link" runat="server" NavigateUrl="~/employee/admin.aspx">Home</asp:HyperLink>
                    <asp:HyperLink ID="HL2" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/empManager.aspx">Employee Manager</asp:HyperLink>
                    <asp:HyperLink ID="HL3" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/regBManager.aspx">Regional Branch Manager</asp:HyperLink>
                    <asp:HyperLink ID="HL4" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/subBManager.aspx">Sub-Branch Manager</asp:HyperLink>
                    <asp:HyperLink ID="HL5" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/ratesManager.aspx">Rates Manager</asp:HyperLink>
                </div>
                <div class="profile">
                    <div id="Panel1" class="info">
                        <h3 id="pi" class="hero-text">Personal Information</h3>

                        <asp:HyperLink ID="HLeditpersonal" CssClass="editbtn" runat="server" NavigateUrl="#">Edit</asp:HyperLink>

                        <asp:Label ID="Lname" CssClass="lable" runat="server" Text="Name "></asp:Label>
                        <asp:TextBox ID="TBname" CssClass="input" runat="server" minlength="3" required="" Enabled="false"></asp:TextBox>

                        <asp:Label ID="LAddr" CssClass="lable" runat="server" Text="Address "></asp:Label>
                        <asp:TextBox ID="TBAddr" CssClass="input" runat="server" TextMode="MultiLine" required="" Columns="5" Enabled="false"></asp:TextBox>

                        <asp:Label ID="Lgender" CssClass="gender" runat="server" Text="Gender"></asp:Label>
                        <asp:RadioButtonList ID="RBLgenger" runat="server" Enabled="false">
                            <asp:ListItem Value="Male" Selected="True"> Male</asp:ListItem>
                            <asp:ListItem Value="Female"> Female</asp:ListItem>
                            <asp:ListItem Value="Other"> Other</asp:ListItem>
                        </asp:RadioButtonList>

                        <asp:Label ID="Ldob" CssClass="lable" runat="server" Text="Date of Birth :"></asp:Label>
                        <asp:TextBox ID="TBdob" CssClass="input" runat="server" TextMode="Date" required="" min="1960-01-01" Enabled="false"></asp:TextBox>

                        <asp:Label ID="Lemail" CssClass="lable" runat="server" Text="Email "></asp:Label>
                        <asp:TextBox ID="TBemail" CssClass="input" runat="server" TextMode="Email" required="" Enabled="false"></asp:TextBox>

                        <asp:Label ID="Lphno" CssClass="lable" runat="server" Text="Phone No. "></asp:Label>
                        <asp:TextBox ID="TBphno" CssClass="input" runat="server" minlength="10" MaxLength="10" TextMode="Phone" required="" Enabled="false"></asp:TextBox>

                        <h3 id="ci" class="hero-text">Credential Information</h3>
                        <asp:HyperLink ID="HLeditpass" CssClass="editbtn" runat="server" NavigateUrl="#HLeditpass">Edit</asp:HyperLink>

                        <asp:Label ID="LOpass" CssClass="lable" runat="server" Text="Old Password "></asp:Label>
                        <asp:TextBox ID="TBoldpass" CssClass="input-pass" runat="server" TextMode="Password" Enabled="false"></asp:TextBox>

                        <asp:Label ID="LNpass" CssClass="lable" runat="server" Text="New Password "></asp:Label>
                        <asp:TextBox ID="TBconfirmpass" CssClass="input-pass" runat="server" TextMode="Password" Enabled="false"></asp:TextBox>

                        <asp:Label ID="LCNpass" CssClass="lable" runat="server" Text="Confirm New Password "></asp:Label>
                        <asp:TextBox ID="TBnewpass" CssClass="input-pass" runat="server" minlength="8" TextMode="Password" Enabled="false"></asp:TextBox>

                        <asp:Button ID="Bsave" CssClass="save" runat="server" Text="Save Changes" OnClick="SaveChanges" />
                    </div>
                    <div id="Panel2" class="profile-image">
                        <h3 class="hero-text">Profile picture</h3>
                        <asp:Image ID="ImgProfilePic" CssClass="profile-pic" runat="server" />
                        <asp:FileUpload ID="FUprofileImg" CssClass="input-img" runat="server" />
                    </div>
                    <div class="action-div">
                        <h3>Account De-Activation</h3>
                        <p class="text">
                            De-Activating a Admin will not Delete account, it will change the admin status as "Deactive" and it can't be changed by any other
                            employee or admin.If the admin trys to login form a decativated account the Status will be changed to "Active".
                        </p>
                        <asp:Button ID="Bdeactivate" CssClass="del" runat="server" Text="Deactivate Account" />
                    </div>
                </div>
            </div>
            <footer class="footer">
                <asp:HyperLink ID="sitemap" CssClass="footer__link" runat="server" NavigateUrl="#">Site Map</asp:HyperLink>
                <span class="footer__span">&copy;2019 - 2021 Lightning Corp.</span>
            </footer>
        </div>
    </form>
</body>
</html>
