<%@ Page Title="Employee Report" Language="C#" MasterPageFile="~/index.Master" AutoEventWireup="true" CodeBehind="Report-Employee.aspx.cs" Inherits="OnlineCourierService.Report_Employee" %>
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
<asp:Content ID="Content4" ContentPlaceHolderID="CPHheader" runat="server">Employee Report</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="CPHcontent" runat="server">
  
  <asp:SqlDataSource ID="Employee" runat="server" ConnectionString="<%$ ConnectionStrings:CourierServiceConnectionString %>" SelectCommand="SELECT [EID], [Ename], [Edob], [Egender], [Eaddress], [Eemail], [Ephno], [Epost] FROM [employee]"></asp:SqlDataSource>

  <asp:GridView ID="GVEmployee" runat="server" AutoGenerateColumns="False" DataKeyNames="EID" DataSourceID="Employee" CellPadding="3" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellSpacing="2">
    <Columns>
      <asp:BoundField DataField="EID" HeaderText="Employee ID" InsertVisible="False" ReadOnly="True" SortExpression="EID" />
      <asp:BoundField DataField="Ename" HeaderText="Employee Name" SortExpression="Ename" />
      <asp:BoundField DataField="Edob" HeaderText="Date ofBirth" SortExpression="Edob" DataFormatString="{0:d}"/>
      <asp:BoundField DataField="Egender" HeaderText="Gender" SortExpression="Egender" />
      <asp:BoundField DataField="Eaddress" HeaderText="Employee address" SortExpression="Eaddress" />
      <asp:BoundField DataField="Eemail" HeaderText="Employee'semail" SortExpression="Eemail" />
      <asp:BoundField DataField="Ephno" HeaderText="Employee'sphno" SortExpression="Ephno" />
      <asp:BoundField DataField="Epost" HeaderText="Employee's post" SortExpression="Epost" />
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
