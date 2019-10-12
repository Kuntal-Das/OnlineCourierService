<%@ Page Title="Parcel Report" Language="C#" MasterPageFile="~/index.Master" AutoEventWireup="true" CodeBehind="Report-Parcel.aspx.cs" Inherits="OnlineCourierService.Report_Parcel" %>
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
<asp:Content ID="Content4" ContentPlaceHolderID="CPHheader" runat="server">Parcel Report</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="CPHcontent" runat="server">

  <asp:SqlDataSource ID="Parcel" runat="server" ConnectionString="<%$ ConnectionStrings:CourierServiceConnectionString %>" SelectCommand="SELECT [PLID], [ParcelType], [PaymentStatus], [sName], [sAddr], [sEMAIL], [rName], [rAddr], [rEMAIL] FROM [PARCEL]"></asp:SqlDataSource>

   <asp:GridView ID="GVParcel" runat="server" AutoGenerateColumns="False" DataKeyNames="PLID" DataSourceID="Parcel" CellPadding="3" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellSpacing="2">
    <Columns>
      <asp:BoundField DataField="PLID" HeaderText="Parcel ID" ReadOnly="True" SortExpression="PLID" />
      <asp:BoundField DataField="ParcelType" HeaderText="Parcel Type" SortExpression="ParcelType" />
      <asp:BoundField DataField="PaymentStatus" HeaderText="PaymentStatus" SortExpression="PaymentStatus" />
      <asp:BoundField DataField="sName" HeaderText="Sender's Name" SortExpression="sName" />
      <asp:BoundField DataField="sAddr" HeaderText="Sender's Addr" SortExpression="sAddr" />
      <asp:BoundField DataField="sEMAIL" HeaderText="Sender's EMAIL" SortExpression="sEMAIL" />
      <asp:BoundField DataField="rName" HeaderText="Receiver's Name" SortExpression="rName" />
      <asp:BoundField DataField="rAddr" HeaderText="Receiver's Addr" SortExpression="rAddr" />
      <asp:BoundField DataField="rEMAIL" HeaderText="Receiver's EMAIL" SortExpression="rEMAIL" />
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
