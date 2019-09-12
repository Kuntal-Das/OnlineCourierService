<%@ Page Title="" Language="C#" MasterPageFile="~/index.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="OnlineCourierService.register" %>

<asp:Content ID="CHead" ContentPlaceHolderID="head" runat="server">
    <link href="css/register.css" rel="stylesheet" />
    <script src="js/register.js"></script>
</asp:Content>

<asp:Content ID="CErr" ContentPlaceHolderID="CPHerrMsg" runat="server">
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


<asp:Content ID="Cuser" ContentPlaceHolderID="CPHuser" runat="server">
</asp:Content>

<asp:Content ID="Cheader" ContentPlaceHolderID="CPHheader" runat="server">
    New Customer Registration
</asp:Content>

<asp:Content ID="CContent" ContentPlaceHolderID="CPHcontent" runat="server">
    <div class="regform">
        <div class="info">
            <h3 class="hero">Personal Info.</h3>
            <div class="inputbox">
                <asp:TextBox ID="TBunm" CssClass="input" runat="server" autocomplete="off" required=""></asp:TextBox>
                <span class="floating-placeholder">User Name</span>
                <asp:RequiredFieldValidator ID="RFVunm" runat="server" ErrorMessage="Name is Reqired" ControlToValidate="TBunm" Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
            <div class="inputbox">
                <asp:TextBox ID="TBaddr" CssClass="input" runat="server" autocomplete="off" required=""></asp:TextBox>
                <span class="floating-placeholder">Address</span>
                <asp:RequiredFieldValidator ID="RFVaddr" runat="server" ErrorMessage="Address is Reqired" ControlToValidate="TBaddr" Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
            <div class="inputbox">
                <asp:TextBox ID="TBdob" CssClass="input" TextMode="Date" runat="server" autocomplete="off"></asp:TextBox>
                <span class="floating-placeholder">Date of Birth</span>
                <span class="info__span">i</span>
                <span id="dobmsg" class="msg">message</span>

                <asp:RequiredFieldValidator ID="RFVdob" runat="server" ErrorMessage="Date of Birth is Reqired" ControlToValidate="TBdob" Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
            <div class="inputbox radio">
                <asp:Label ID="Label1" CssClass="lable" runat="server" Text="Gender"></asp:Label>
                <asp:RadioButtonList ID="RBLgenger" runat="server">
                    <asp:ListItem Selected="True">Male</asp:ListItem>
                    <asp:ListItem>Female</asp:ListItem>
                    <asp:ListItem>Other</asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <div class="inputbox">
                <asp:TextBox ID="TBphone" CssClass="input" TextMode="Phone" runat="server" autocomplete="off" required=""></asp:TextBox>
                <span class="floating-placeholder">Phone Number</span>
                <asp:RequiredFieldValidator ID="RFVphno" runat="server" ErrorMessage="Phone No. is Reqired" ControlToValidate="TBphone" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" maxlength="10" minlength="10">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="REVphnoe" runat="server" ControlToValidate="TBphone" ErrorMessage="Invalid Phone Number" ValidationExpression="[0-9]{10}" Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RegularExpressionValidator>
            </div>
            <div class="inputbox">
                <asp:TextBox ID="TBemail" CssClass="input" runat="server" autocomplete="off" required=""></asp:TextBox>
                <span class="floating-placeholder">Email</span>
                <asp:RequiredFieldValidator ID="RFVemail" runat="server" ErrorMessage="Email is Reqired" ControlToValidate="TBemail" Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="REVemail" runat="server" ErrorMessage="Invalid Email Address" ControlToValidate="TBemail" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
            </div>
            <div class="inputbox">
                <asp:FileUpload ID="FUpic" CssClass="input" runat="server" />
                <span class="floating-placeholder">Profile Picture</span>
            </div>
        </div>
        <div class="info">
            <h3 class="hero">Branch Info.</h3>
            <asp:ObjectDataSource ID="OBSRegWithRID" runat="server" SelectMethod="GetRegionWithRegBranchID" TypeName="OnlineCourierService.employee.Classes.DataAccessLayer"></asp:ObjectDataSource>
            <asp:ObjectDataSource ID="OBSBranch" runat="server" SelectMethod="GetBranchByRid" TypeName="OnlineCourierService.employee.Classes.DataAccessLayer">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DDLregwithRID" Name="Rid" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:Label ID="Lreg" CssClass="lable" runat="server" Text="Select Region"></asp:Label>
            <div class="inputbox">
                <asp:DropDownList ID="DDLregwithRID" CssClass="ddl" runat="server" AutoPostBack="True" DataSourceID="OBSRegWithRID" DataTextField="Name" DataValueField="ID"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RFVreg" runat="server" ErrorMessage="Region is Required" ControlToValidate="DDLregwithRID" Display="Dynamic" ForeColor="Red" InitialValue="-1" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
            <asp:Label ID="Lbranch" CssClass="lable" runat="server" Text="Select Nearest Branch"></asp:Label>
            <div class="inputbox">
                <asp:DropDownList ID="DDLbranch" CssClass="ddl" runat="server" DataSourceID="OBSBranch" DataTextField="BName" DataValueField="Bid"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RFVbranch" runat="server" ErrorMessage="Branch name is Required" ControlToValidate="DDLbranch" Display="Dynamic" ForeColor="Red" InitialValue="-1" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
            <h3 class="hero">Credential Info.</h3>

            <div class="inputbox">
                <asp:TextBox ID="TBpass" CssClass="input" TextMode="Password" runat="server" autocomplete="off" required=""></asp:TextBox>
                <span class="floating-placeholder">Create Password</span>
                <asp:RequiredFieldValidator ID="RFVpass" runat="server" ErrorMessage="Password is Reqired" ControlToValidate="TBpass" Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TBpass" Display="Dynamic"
                    ErrorMessage="Invalid Password" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&amp;*-]).{8,}$">*</asp:RegularExpressionValidator>
                <span class="info__span">i</span>
                <span class="msg">Password should At least one upper case English letter,<br>
                    At least one lower case English letter,<br>
                    At least one digit,<br>
                    At least one special character,<br>
                    Minimum eight in length</span>

            </div>
            <div class="inputbox">
                <asp:TextBox ID="TBcpass" CssClass="input" TextMode="Password" runat="server" autocomplete="off" required=""></asp:TextBox>
                <span class="floating-placeholder">Confirm Password</span>
                <asp:RequiredFieldValidator ID="RFVcpass" runat="server" ErrorMessage="Confirm Password !" ControlToValidate="TBcpass" Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CVcpass" runat="server" ErrorMessage="Passwords Don't Match" ControlToCompare="TBpass" ControlToValidate="TBcpass" Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:CompareValidator>
                <asp:RegularExpressionValidator ID="REVNpass" runat="server" ControlToValidate="TBcpass" Display="Dynamic"
                    ErrorMessage="Invalid Password" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&amp;*-]).{8,}$">*</asp:RegularExpressionValidator>
                <span class="info__span">i</span>
                <span class="msg">Password should At least one upper case English letter,<br>
                    At least one lower case English letter,<br>
                    At least one digit,<br>
                    At least one special character,<br>
                    Minimum eight in length</span>

            </div>
            <h3 class="hero">Account Type</h3>

            <div class="inputbox">
                <asp:DropDownList ID="DDLAccType" CssClass="ddl" runat="server">
                    <asp:ListItem Value="-1">Select Account Type</asp:ListItem>
                    <asp:ListItem>Personal Account</asp:ListItem>
                    <asp:ListItem>Business Account</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RFVbranch0" runat="server" ErrorMessage="Account type is Required" ControlToValidate="DDLAccType" Display="Dynamic" ForeColor="Red" InitialValue="-1" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
        </div>
    </div>
    <asp:ValidationSummary CssClass="val" ID="ValidationSummary1" ForeColor="Red" DisplayMode="List" runat="server" />
    <div class="action">
        <asp:LinkButton ID="LBreg" CssClass="btn" runat="server" OnClick="Create">Register</asp:LinkButton>
        <asp:LinkButton ID="LBcancel" CssClass="cbtn" runat="server" CausesValidation="false" OnClick="Cancel">Cancel</asp:LinkButton>
    </div>
</asp:Content>
