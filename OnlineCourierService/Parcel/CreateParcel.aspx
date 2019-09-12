<%@ Page Title="Create Parcel" Language="C#" MasterPageFile="~/Parcel/Parcel.Master" AutoEventWireup="true" CodeBehind="CreateParcel.aspx.cs" Inherits="OnlineCourierService.Parcel.CreateParcel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/CreateParcel.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {
            min-width: 300px;
            max-width: max-content;
            position: relative;
            display: flex;
            flex-direction: row;
            align-items: center;
            left: 0px;
            top: 0px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="CPHerrMsg" runat="server">
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

<asp:Content ID="Content3" ContentPlaceHolderID="CPHuser" runat="server">
    <asp:LinkButton ID="LoginSignIn" CssClass="login" runat="server" CausesValidation="false" OnClick="LoginSignIn_Click">
        <span></span><span></span><span></span><span></span>
        Sign Up or Login <svg role="presentation" class="icon user--icon"><use xlink:href="#usericon" /></svg>
    </asp:LinkButton>
    <asp:Panel ID="Puser" CssClass="account" runat="server" Visible="false" OnClick="toogleUserontrol();">
        <asp:Panel ID="ProundedDP" CssClass="userDP" runat="server"></asp:Panel>
        <asp:Label ID="Aname" CssClass="user" runat="server" Text="Employee"></asp:Label>
        <ul class="usercontrol hidden">
            <li class="l2__nav">
                <asp:HyperLink CssClass="l2__link" ID="profile" runat="server" NavigateUrl="~/Profile.aspx">My Profile</asp:HyperLink>
            </li>
            <li class="l2__nav">
                <asp:LinkButton ID="signout" CausesValidation="false" CssClass="l2__link" runat="server" OnClick="Logout">Log Out</asp:LinkButton>
            </li>
        </ul>
    </asp:Panel>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="CPHheader" runat="server">
    Make New Shipment / Parcel 
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="CPHcontent" runat="server">
    <div class="full__div grid">
        <h3 class="hero__text">Parcel Info.</h3>
        <div class="inputbox">
            <asp:Label ID="LPtype" runat="server" Text="Select Parcel Type :"></asp:Label>
            <asp:DropDownList ID="DDLPtype" runat="server" CssClass="ddl" OnSelectedIndexChanged="DDLPtype_SelectedIndexChanged" AutoPostBack="True">
                <asp:ListItem Selected="True" Value="-1">Select Parcel Type</asp:ListItem>
                <asp:ListItem>Basic</asp:ListItem>
                <asp:ListItem>Business</asp:ListItem>
                <asp:ListItem Value="DryFood">Dry Food</asp:ListItem>
                <asp:ListItem Value="CookedFood">Cooked Food</asp:ListItem>
                <asp:ListItem>Gift</asp:ListItem>
                <asp:ListItem>Electronics</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RFVPtype" runat="server" ErrorMessage="Parcel Type is Required" ControlToValidate="DDLPtype" ForeColor="Red"
                Text="*" Display="Dynamic" SetFocusOnError="true" InitialValue="-1"></asp:RequiredFieldValidator>
        </div>
        <div class="inputbox">
            <asp:Label ID="Label1" runat="server" Text="Select Payment Method :"></asp:Label>
            <asp:DropDownList ID="DDLPaymentM" runat="server" CssClass="ddl">
                <asp:ListItem Value="-1">Select Payment Method</asp:ListItem>
                <asp:ListItem>Pay Online</asp:ListItem>
                <asp:ListItem>Pay On PickUp</asp:ListItem>
                <asp:ListItem>Pay in Branch</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RFVPaymentM" runat="server" ErrorMessage="Payment Method is Required" ControlToValidate="DDLPaymentM" ForeColor="Red"
                Text="*" Display="Dynamic" SetFocusOnError="true" InitialValue="-1"></asp:RequiredFieldValidator>
            <span class="info">i</span>
            <span class="msg">Your Payment Method Declares How You want do send Your Parcel<br />
                <ul style="margin-left:10px;">
                    <li>For &quot;online Payment&quot; Or &quot;Pay on Pickup&quot; parcel will be picked up from yuor Home Address,</li>
                    <li>But for &quot;Pay in Branch&quot; option You need to Carr your Parcel to Branch while to make the payment</li>
                </ul>
            </span>
        </div>
        <div class="inputbox">
            <asp:TextBox ID="TBPweight" CssClass="input" runat="server" autocomplete="off" required=""></asp:TextBox>
            <span class="floating-placeholder">approx Parcel Weight(in Kg)</span>
            <asp:RequiredFieldValidator ID="RFVpWeight" runat="server" ErrorMessage="Weight is Required" SetFocusOnError="True" ControlToValidate="TBPweight" 
                Text="*" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CVweight" runat="server" ErrorMessage="weight must be in Decimal" ControlToValidate="TBPweight" Display="Dynamic" ForeColor="Red" 
                Operator="DataTypeCheck" SetFocusOnError="True" Type="Double">*</asp:CompareValidator>
            <asp:RangeValidator ID="RVweight" runat="server" ErrorMessage="weight must be between 1-100" ControlToValidate="TBPweight" Display="Dynamic" ForeColor="Red" 
                MaximumValue="101" MinimumValue="1" SetFocusOnError="True">*</asp:RangeValidator>

        </div>
    </div>
    <asp:ObjectDataSource ID="OBSReg" runat="server" SelectMethod="GetRegionWithRegBranchID" TypeName="OnlineCourierService.employee.Classes.DataAccessLayer"></asp:ObjectDataSource>

    <div class="grid">
        <div class="half__div">
            <h3 class="hero__text">Sender's Info.</h3>
            <div class="inputbox">
                <asp:TextBox ID="TBsName" CssClass="input" runat="server" required=""></asp:TextBox>
                <span class="floating-placeholder">Sender's Full Name</span>
                <asp:RequiredFieldValidator ID="RFVsName" ControlToValidate="TBsName" runat="server" ErrorMessage="Sender's Name is Reqired"
                    Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
            <div class="inputbox">
                <asp:TextBox ID="TBsEmail" CssClass="input" runat="server" required=""></asp:TextBox>
                <span class="floating-placeholder">Sender's Email Address</span>
                <asp:RequiredFieldValidator ID="RFVsCID" ControlToValidate="TBsEmail" runat="server" ErrorMessage="Sender's Email is Reqired"
                    Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="REVsEmail" runat="server" ErrorMessage="Invalid Sender's Email" ControlToValidate="TBsEmail" Display="Dynamic"
                    ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
            </div>
            <div class="inputbox">
                <asp:TextBox ID="TBsAddr" TextMode="MultiLine" CssClass="input" runat="server" required=""></asp:TextBox>
                <span class="floating-placeholder">Sender's Postal Address</span>
                <asp:RequiredFieldValidator ID="RFVsAddr" runat="server" ErrorMessage="Sender's Address is Required" ControlToValidate="TBsAddr" Display="Dynamic" 
                    ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
            <div class="auto-style1">
                <asp:Label ID="LsReg" CssClass="lable" runat="server" Text="Select Sender's Region :"></asp:Label>
                <asp:DropDownList ID="DDLsReg" CssClass="ddl" runat="server" DataSourceID="OBSReg" DataTextField="Name"
                    DataValueField="ID" AutoPostBack="True" OnSelectedIndexChanged="DDLsReg_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RFVsReg" runat="server" ErrorMessage="Sender's Region is Required" ControlToValidate="DDLsReg" Display="Dynamic" 
                    ForeColor="Red" SetFocusOnError="True" InitialValue="-1">*</asp:RequiredFieldValidator>

            </div>
            <div class="inputbox">
                <asp:Label ID="Lsbranch" CssClass="lable" runat="server" Text="Select Sender's Nearby Branch :"></asp:Label>
                <asp:DropDownList ID="DDLsbranch" CssClass="ddl" runat="server">
                    <asp:ListItem Value="-1">Select Branch</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RFVsBranch" runat="server" ErrorMessage="Sender's Nearby Branch is Required" ControlToValidate="DDLsbranch" Display="Dynamic" 
                    ForeColor="Red" SetFocusOnError="True" InitialValue="-1">*</asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="half__div">
            <h3 class="hero__text">Receiver's Info.</h3>
            <div class="inputbox">
                <asp:TextBox ID="TBrName" CssClass="input" runat="server" required=""></asp:TextBox>
                <span class="floating-placeholder">receiver's Full Name</span>
                <asp:RequiredFieldValidator ID="RFVrName" ControlToValidate="TBrName" runat="server" ErrorMessage="Receiver's Name is Reqired"
                    Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
            <div class="inputbox">
                <asp:TextBox ID="TBrEmail" CssClass="input" runat="server" required=""></asp:TextBox>
                <span class="floating-placeholder">Receiver's Email Address</span>
                <asp:RequiredFieldValidator ID="RFVrEmail" ControlToValidate="TBrEmail" runat="server" ErrorMessage="Receiver's Email is Reqired"
                    Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="REVrEmail" runat="server" ErrorMessage="Invalid Receiver's Email" ControlToValidate="TBrEmail" Display="Dynamic"
                    ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
            </div>
            <div class="inputbox">
                <asp:TextBox ID="TBrAddr" TextMode="MultiLine" CssClass="input" runat="server" required=""></asp:TextBox>
                <span class="floating-placeholder">Receiver's Postal Address</span>
                <asp:RequiredFieldValidator ID="RFVrAddr" runat="server" ErrorMessage="Receiver's Address is Required" ControlToValidate="TBrAddr" Display="Dynamic" 
                    ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
            <div class="inputbox">
                <asp:Label ID="LrReg" CssClass="lable" runat="server" Text="Select Receiver's Region :"></asp:Label>
                <asp:DropDownList ID="DDLrReg" CssClass="ddl" runat="server" DataSourceID="OBSReg" DataTextField="Name" DataValueField="ID"
                    OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RFVrReg" runat="server" ErrorMessage="Receiver's Region is Required" ControlToValidate="DDLrReg" Display="Dynamic" 
                    ForeColor="Red" SetFocusOnError="True" InitialValue="-1">*</asp:RequiredFieldValidator>
            </div>
            <div class="inputbox">
                <asp:Label ID="LrBranch" CssClass="lable" runat="server" Text="Select Receiver's Nearby Branch :"></asp:Label>
                <asp:DropDownList ID="DDLrbranch" CssClass="ddl" runat="server">
                    <asp:ListItem Value="-1">Select Branch</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RFVrbranch" runat="server" ErrorMessage="Receiver's Nearby Branch is Required" ControlToValidate="DDLrbranch" Display="Dynamic" 
                    ForeColor="Red" SetFocusOnError="True" InitialValue="-1">*</asp:RequiredFieldValidator>
            </div>
        </div>
    </div>
    <div class="grid">
        <div class="full__div">
            <h3 class="hero__text">Packing Info.</h3>
            We can Take care of your Packaging Or else You can do it yourself.<br />
            <br />
            <div class="inputbox">
                <asp:DropDownList ID="DDLpackage" CssClass="ddl" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDLpackage_SelectedIndexChanged">
                    <asp:ListItem>Packaging Managed by Us</asp:ListItem>
                    <asp:ListItem>Packaging Managed by Customer</asp:ListItem>
                </asp:DropDownList>
            </div>
            <br />
            <b>Note:</b> Personal Account Holders will be charged Extra Upto Rs.250 (According to the ammount of parcel).
            For cooked/Dry food an exta charge may will be applied for packging provided by Us(if the packaging cost exceeds normal limit)<br />
            <br />
            Business account holders will not be charged Extra for Packaging provided by Us.<br />
        </div>
        <asp:Panel ID="PFood" CssClass="full__div" runat="server" Visible="false">
            <h3 class="hero__text">Cooked/Dry Food</h3>
            For sending Cooked/Dry food we preffer to Package it ourself so that the food quality remains intact and for that we need to know 
            some basic info. about your parcel to provide our best service at your door.<br />
            <br />
            <div class="inputbox">
                <asp:TextBox ID="TBfood" CssClass="input" runat="server" required=""></asp:TextBox>
                <span class="floating-placeholder">Enter how many container you Need</span>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Containers No. is Required" SetFocusOnError="True" ControlToValidate="TBfood" 
                Text="*" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Containers No. be in Integer" ControlToValidate="TBfood" Display="Dynamic" ForeColor="Red" 
                Operator="DataTypeCheck" SetFocusOnError="True" Type="Integer">*</asp:CompareValidator>
            <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Containers No. must be between 1-10" ControlToValidate="TBfood" Display="Dynamic" ForeColor="Red" 
                MaximumValue="10" MinimumValue="1" SetFocusOnError="True">*</asp:RangeValidator>

            </div>
            <br />
            <br />
            <br />
        </asp:Panel>
    </div>
    <asp:ValidationSummary ID="VSparcel" ForeColor="Red" DisplayMode="List" runat="server" style="margin:10px 20px"/>
    <div class="full__div">
        <h3 class="hero__text">Place Pickup Request/Send Package </h3>
        <asp:Button ID="Bsubmit" CssClass="btn" runat="server" Text="Palce Requet" />
        <asp:LinkButton ID="LBcancel" CssClass="cbtn" runat="server">Cancel</asp:LinkButton>
    </div>
    <svg display="none">
        <symbol id="usericon" role="presentation" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 194 194">
            <path class="border"
                d="M97 13a84 84 0 1 1-84 84 84.09513 84.09513 0 0 1 84-84m0-13a97 97 0 1 0 97 97A97 97 0 0 0 97 0z" />
            <circle class="head" cx="97" cy="65" r="33" />
            <path class="body"
                d="M43 142c-8.44147-9.10907-8.31122-14.73462-8-17 .83569-6.08286 6.0473-10.29041 12.5-15.5a70.56271 70.56271 0 0 1 12.00311-7.8181 6.82759 6.82759 0 0 1 6.52424.17143 60.95361 60.95361 0 0 0 60.67427.158 6.83155 6.83155 0 0 1 6.92674.11175A131.12246 131.12246 0 0 1 144.5 109.5c8.96344 6.76105 13.46625 10.24872 14.5 15.5 1.34631 6.83887-3.77936 13.1456-7 17-10.00458 11.9733-28 24-50 24-28.77063 0-49.63916-13.89883-59-24z" />
        </symbol>
    </svg>
</asp:Content>
