<%@ Page Title="Create Parcel" Language="C#" MasterPageFile="~/employee/EmploeeLinks/EmployeeLink.Master" AutoEventWireup="true" CodeBehind="ECreateParcel.aspx.cs" Inherits="OnlineCourierService.employee.EmploeeLinks.ECreateParcel" %>

<asp:Content ID="Chead" ContentPlaceHolderID="head" runat="server">
    <link href="../../Parcel/css/CreateParcel.css" rel="stylesheet" />
    <link href="css/ECreateParcel.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="CerrMsg" ContentPlaceHolderID="CPHErrmsg" runat="server">
    <asp:Panel ID="Perrormsg" runat="server" CssClass="PError" EnableViewState="false">
        <div class="cross"></div>
        <asp:Label ID="Lerrmsg" runat="server" Text="" CssClass="Lerr"></asp:Label>
        <script>
            document.querySelector(".cross").addEventListener("click", _ => {
                document.querySelector(".PError").style.opacity = 0;
                document.querySelector(".PError").style.pointerEvents = "none";
            });
        </script>
    </asp:Panel>
</asp:Content>
<asp:Content ID="Cheader" ContentPlaceHolderID="CPHheader" runat="server">Create Parcel On Behalf of A Customer</asp:Content>
<asp:Content ID="Csidebar" ContentPlaceHolderID="CPHsidebar" runat="server">
    <asp:HyperLink ID="HLhome" CssClass="side-link" runat="server" NavigateUrl="~/employee/emp.aspx">Home</asp:HyperLink>
    <asp:HyperLink ID="HLUpdateP" CssClass="side-link" runat="server" NavigateUrl="~/employee/EmploeeLinks/EUpdateParcel.aspx">Update Parcel Status</asp:HyperLink>
    <asp:HyperLink ID="HLCreatep" CssClass="side-link" runat="server" NavigateUrl="~/employee/EmploeeLinks/EtrackParcel.aspx">Track Parcel</asp:HyperLink>
</asp:Content>
<asp:Content ID="Ccontent" ContentPlaceHolderID="CPHcontent" runat="server">
    <div class="full__div">
        <h3 class="hero__text">Parcel Info.</h3>
        <div class="inputbox">
            <asp:Label ID="LPtype" runat="server" CssClass="lable" Text="Select Parcel Type : "></asp:Label>
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
            <asp:Label ID="Label1" CssClass="lable" runat="server" Text="Select Payment Method : "></asp:Label>
            <asp:DropDownList ID="DDLPaymentM" runat="server" CssClass="ddl">
                <asp:ListItem Value="-1">Select Payment Method</asp:ListItem>
                <asp:ListItem>Pay On PickUp</asp:ListItem>
                <asp:ListItem>Pay in Branch</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RFVPaymentM" runat="server" ErrorMessage="Payment Method is Required" ControlToValidate="DDLPaymentM" ForeColor="Red"
                Text="*" Display="Dynamic" SetFocusOnError="true" InitialValue="-1"></asp:RequiredFieldValidator>
            <span class="info">i</span>
            <div class="msg">Customers' Payment Method Declares How You want do send Your Parcel<br />
                <ul style="margin-left: 10px;">
                    <li>For &quot;Pay on Pickup&quot; parcel will be picked up from Customers' Home Address,</li>
                    <li>But for &quot;Pay in Branch&quot; option Customer need to Carry your Parcel to Branch while you go to make the payment</li>
                </ul>
            </div>
        </div>
        <div class="inputbox">
            <asp:Label ID="Label2" runat="server" CssClass="lable" Text="Approx Parcel Weight(in Kg) : "></asp:Label>
            <asp:TextBox ID="TBPweight" CssClass="input" runat="server" autocomplete="off" required=""></asp:TextBox>
            <asp:RequiredFieldValidator ID="RFVpWeight" runat="server" ErrorMessage="Weight is Required" SetFocusOnError="True" ControlToValidate="TBPweight"
                Text="*" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CVweight" runat="server" ErrorMessage="weight must be in Decimal" ControlToValidate="TBPweight" Display="Dynamic" ForeColor="Red"
                Operator="DataTypeCheck" SetFocusOnError="True" Type="Double">*</asp:CompareValidator>
            <asp:RangeValidator ID="RVweight" runat="server" ErrorMessage="weight must be between 1-100" ControlToValidate="TBPweight" Display="Dynamic" ForeColor="Red"
                MaximumValue="100" MinimumValue="1" SetFocusOnError="True" Type="Double">*</asp:RangeValidator>

        </div>
    </div>
    <div class="grid">
        <div class="full__div">
            <h3 class="hero__text">Packing Info.</h3>
            We can Take care of your Packaging Or else You can do it yourself.<br />
            <br />
            <div class="inputbox">
                <asp:DropDownList ID="DDLpackage" CssClass="ddl" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDLpackage_SelectedIndexChanged">
                    <asp:ListItem Value="0">Packaging Managed by Us</asp:ListItem>
                    <asp:ListItem Value="1">Packaging Managed by Customer</asp:ListItem>
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
                <asp:RequiredFieldValidator ID="RFVContainer" runat="server" ErrorMessage="Containers No. is Required" SetFocusOnError="True" ControlToValidate="TBfood"
                    Text="*" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CVContainer" runat="server" ErrorMessage="Containers No. be in Integer" ControlToValidate="TBfood" Display="Dynamic" ForeColor="Red"
                    Operator="DataTypeCheck" SetFocusOnError="True" Type="Integer">*</asp:CompareValidator>
                <asp:RangeValidator ID="RVContainer" runat="server" ErrorMessage="Containers No. must be between 1-10" ControlToValidate="TBfood" Display="Dynamic" ForeColor="Red"
                    MaximumValue="10" MinimumValue="1" SetFocusOnError="True" Type="Integer">*</asp:RangeValidator>
            </div>
            <br />
            <br />
            <br />
        </asp:Panel>
    </div>
    <asp:ObjectDataSource ID="OBSReg" runat="server" SelectMethod="GetRegionWithRegBranchID" TypeName="OnlineCourierService.employee.Classes.DataAccessLayer"></asp:ObjectDataSource>

    <div class="grid">
        <div class="half__div">
            <h3 class="hero__text">Sender's Info.</h3>
            <div class="inputbox">
                <asp:Label ID="Label3" CssClass="lable" runat="server" Text="Sender's Full Name"></asp:Label>
                <asp:TextBox ID="TBsName" CssClass="input" runat="server" required=""></asp:TextBox>
                <asp:RequiredFieldValidator ID="RFVsName" ControlToValidate="TBsName" runat="server" ErrorMessage="Sender's Name is Reqired"
                    Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
            <div class="inputbox">
                <asp:Label ID="Label4" CssClass="lable" runat="server" Text="Sender's Email Address"></asp:Label>
                <asp:TextBox ID="TBsEmail" CssClass="input" runat="server" required=""></asp:TextBox>
                <asp:RequiredFieldValidator ID="RFVsCID" ControlToValidate="TBsEmail" runat="server" ErrorMessage="Sender's Email is Reqired"
                    Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="REVsEmail" runat="server" ErrorMessage="Invalid Sender's Email" ControlToValidate="TBsEmail" Display="Dynamic"
                    ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
            </div>
            <div class="inputbox">
                <asp:Label ID="Label5" CssClass="lable" runat="server" Text="Sender's Postal Address"></asp:Label>
                <asp:TextBox ID="TBsAddr" TextMode="MultiLine" CssClass="input" runat="server" required=""></asp:TextBox>
                <asp:RequiredFieldValidator ID="RFVsAddr" runat="server" ErrorMessage="Sender's Address is Required" ControlToValidate="TBsAddr" Display="Dynamic"
                    ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
            <div class="inputbox">
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
                <asp:Label ID="Label6" CssClass="lable" runat="server" Text="Receiver's Full Name"></asp:Label>
                <asp:TextBox ID="TBrName" CssClass="input" runat="server" required=""></asp:TextBox>
                <asp:RequiredFieldValidator ID="RFVrName" ControlToValidate="TBrName" runat="server" ErrorMessage="Receiver's Name is Reqired"
                    Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
            <div class="inputbox">
                <asp:Label ID="Label7" CssClass="lable" runat="server" Text="Receiver's Email Address"></asp:Label>
                <asp:TextBox ID="TBrEmail" CssClass="input" runat="server" required=""></asp:TextBox>
                <asp:RequiredFieldValidator ID="RFVrEmail" ControlToValidate="TBrEmail" runat="server" ErrorMessage="Receiver's Email is Reqired"
                    Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="REVrEmail" runat="server" ErrorMessage="Invalid Receiver's Email" ControlToValidate="TBrEmail" Display="Dynamic"
                    ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
            </div>
            <div class="inputbox">
                <asp:Label ID="Label8" CssClass="lable" runat="server" Text="Receiver's Postal Address"></asp:Label>
                <asp:TextBox ID="TBrAddr" TextMode="MultiLine" CssClass="input" runat="server" required=""></asp:TextBox>
                <asp:RequiredFieldValidator ID="RFVrAddr" runat="server" ErrorMessage="Receiver's Address is Required" ControlToValidate="TBrAddr" Display="Dynamic"
                    ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
            <div class="inputbox">
                <asp:Label ID="LrReg" CssClass="lable" runat="server" Text="Select Receiver's Region :"></asp:Label>
                <asp:DropDownList ID="DDLrReg" CssClass="ddl" runat="server" DataSourceID="OBSReg" DataTextField="Name" DataValueField="ID"
                    OnSelectedIndexChanged="DDLrReg_SelectedIndexChanged" AutoPostBack="True">
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
    <asp:ValidationSummary ID="VSparcel" ForeColor="Red" DisplayMode="List" runat="server" Style="margin: 10px 20px" />
    <div class="full__div">
        <h3 class="hero__text">Place Pickup Request/Send Package </h3>
        <asp:Button ID="Bsubmit" CssClass="btn" runat="server" Text="Place Request" OnClick="Bsubmit_Click" />
        <asp:LinkButton ID="LBcancel" CssClass="cbtn" CausesValidation="false" OnClick="LBcancel_Click" runat="server">Cancel</asp:LinkButton>
    </div>
</asp:Content>
