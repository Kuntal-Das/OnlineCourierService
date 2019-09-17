<%@ Page Title="Track Parcel" Language="C#" MasterPageFile="~/employee/EmploeeLinks/EmployeeLink.Master" AutoEventWireup="true" CodeBehind="EtrackParcel.aspx.cs" Inherits="OnlineCourierService.employee.EmploeeLinks.EtrackParcel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/EtrackParcel.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPHErrmsg" runat="server">
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
<asp:Content ID="Content3" ContentPlaceHolderID="CPHheader" runat="server">
    Track Parcel
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPHsidebar" runat="server">
    <asp:HyperLink ID="HLhome" CssClass="side-link" runat="server" NavigateUrl="~/employee/emp.aspx">Home</asp:HyperLink>
    <asp:HyperLink ID="HLCreatep" CssClass="side-link" runat="server" NavigateUrl="~/employee/EmploeeLinks/ECreateParcel.aspx">Create Parcel</asp:HyperLink>
    <asp:HyperLink ID="HLUpdateP" CssClass="side-link" runat="server" NavigateUrl="~/employee/EmploeeLinks/EUpdateParcel.aspx">Update Parcel Status</asp:HyperLink>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="CPHcontent" runat="server">
    <div class="inner__div">
        <asp:Label ID="LsrcPLID" runat="server" Text="Enter Parcel ID [Enter PLID as provided Include dashes(-) whenever ncessary] :  "></asp:Label>
        <asp:TextBox ID="TBsrcPLID" CssClass="input" runat="server" required="" Width="400px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RFVsrcPLID" runat="server" ErrorMessage="Parcel ID is Required" SetFocusOnError="True" ControlToValidate="TBsrcPLID"
            Text="*" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="TBsrcPLID" ID="REVsrcParcel" ValidationExpression="^[\s\S]{32,38}$"
            runat="server" ErrorMessage="Invalid Parcel ID" ForeColor="Red" Text="*"></asp:RegularExpressionValidator>
        <asp:Button ID="Bsrc" CssClass="btn" runat="server" Text="Search" OnClick="Bsrc_Click" />
        <asp:ValidationSummary ID="VSsrcParcel" runat="server" ForeColor="Red" DisplayMode="List" />
    </div>
    <asp:GridView ID="GVsrcParcel" CssClass="gv" runat="server" AutoGenerateColumns="False" EnableViewState="False" DataKeyNames="PARCELid"
        EmptyDataText="No Records Found">
        <Columns>
            <asp:BoundField DataField="PARCELid" HeaderText="Parcel ID" />
            <asp:BoundField DataField="SENDER" HeaderText="Sender Name" />
            <asp:BoundField DataField="RECEIVER" HeaderText="Receiver Name" />
            <asp:BoundField DataField="PARCELTYPE" HeaderText="Parcel Type" />
            <asp:BoundField DataField="CURRENTSTATUS" HeaderText="Current Status" />
            <asp:BoundField DataField="PAYMENTSTATUS" HeaderText="Payment Status" />
            <asp:BoundField DataField="DATE" HeaderText="Date Created" DataFormatString="{0:G}" />
            <asp:HyperLinkField ShowHeader="False" Text="View Details" DataNavigateUrlFormatString="~/employee/EmploeeLinks/EParcelDetails.aspx?PLID={0}" DataNavigateUrlFields="PARCELid">
                <ControlStyle CssClass="btn" />
            </asp:HyperLinkField>
        </Columns>
    </asp:GridView>
</asp:Content>
