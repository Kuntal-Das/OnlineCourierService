<%@ Page Title="Branch Report" Language="C#" MasterPageFile="~/index.Master" AutoEventWireup="true" CodeBehind="Report-Branch.aspx.cs" Inherits="OnlineCourierService.Report_Branch" %>
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
<asp:Content ID="Content4" ContentPlaceHolderID="CPHheader" runat="server">Branch Report</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="CPHcontent" runat="server">

  <asp:SqlDataSource ID="Branch" runat="server" ConnectionString="<%$ ConnectionStrings:CourierServiceConnectionString %>" SelectCommand="SELECT [BID], [RID], [Bname], [Baddress], [Status], [Latitude], [Longitude] FROM [Branch]"></asp:SqlDataSource>

   <asp:GridView ID="GVBranch" runat="server" AutoGenerateColumns="False" DataKeyNames="BID" DataSourceID="Branch" CellPadding="3" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellSpacing="2">
    <Columns>
      <asp:BoundField DataField="BID" HeaderText="Branch ID" InsertVisible="False" ReadOnly="True" SortExpression="BID" />
      <asp:BoundField DataField="RID" HeaderText="Regional BID" SortExpression="RID" />
      <asp:BoundField DataField="Bname" HeaderText="Branch name" SortExpression="Bname" />
      <asp:BoundField DataField="Baddress" HeaderText="Branch address" SortExpression="Baddress" />
      <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
      <asp:BoundField DataField="Latitude" HeaderText="Latitude" SortExpression="Latitude" />
      <asp:BoundField DataField="Longitude" HeaderText="Longitude" SortExpression="Longitude" />
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
