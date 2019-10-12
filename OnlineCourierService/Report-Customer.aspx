<%@ Page Title="Customer Report" Language="C#" MasterPageFile="~/index.Master" AutoEventWireup="true" CodeBehind="Report-Customer.aspx.cs" Inherits="OnlineCourierService.Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <style>
    .container{
      display:flex;
      justify-content:center;
      align-items:start;
    }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPHerrMsg" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPHuser" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPHheader" runat="server">Customer Report</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="CPHcontent" runat="server">
  
  <asp:SqlDataSource ID="Customer" runat="server" ConnectionString="<%$ ConnectionStrings:CourierServiceConnectionString %>" SelectCommand="SELECT [CID], [Name], [Address], [Gender], [DOB], [Phno], [Email], [AccType] FROM [Customer]"></asp:SqlDataSource>

  <asp:GridView ID="GVCustomer" runat="server" AutoGenerateColumns="False" DataSourceID="Customer" CellPadding="3" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellSpacing="2">
    <Columns>
      <asp:BoundField DataField="CID" HeaderText="Customer ID" ReadOnly="True" SortExpression="CID" />
      <asp:BoundField DataField="Name" HeaderText="Customer's Name" SortExpression="Name" />
      <asp:BoundField DataField="Address" HeaderText="Customer's Address" SortExpression="Address" />
      <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
      <asp:BoundField DataField="DOB" HeaderText="Date Of Birth" SortExpression="DOB" DataFormatString="{0:d}"/>
      <asp:BoundField DataField="Phno" HeaderText="Customer's Phno" SortExpression="Phno" />
      <asp:BoundField DataField="Email" HeaderText="Customer'sEmail" SortExpression="Email" />
      <asp:BoundField DataField="AccType" HeaderText="Customer's AccType" SortExpression="AccType" />
    </Columns>
    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
    <SortedAscendingCellStyle BackColor="#FFF1D4" />
    <SortedAscendingHeaderStyle BackColor="#B95C30" />
    <SortedDescendingCellStyle BackColor="#F1E5CE" />
    <SortedDescendingHeaderStyle BackColor="#93451F" />
  </asp:GridView>

</asp:Content>
