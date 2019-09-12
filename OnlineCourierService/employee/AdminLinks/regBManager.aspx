<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="regBManager.aspx.cs" Inherits="OnlineCourierService.employee.AdminLinks.regBManager" %>

<%@ Register Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=0.86, maximum-scale=3.0, minimum-scale=0.86" />
    <link rel="shortcut icon" href="../../lightning.ico" />
    <title>Manage Regional Branch</title>
    <link rel="stylesheet" href="css/sidebar.css" />
    <link rel="stylesheet" href="css/regBManager.css" />
    <script type="text/javascript" src="../js/main.js"></script>
    <script type="text/javascript" src="js/regBManager.js"></script>
    <style type="text/css">
        .auto-style1 {
            width: calc(100% - 30px);
            margin: 15px;
            text-align: center;
            border-collapse: collapse;
            margin: 15px 15px 15px 55px;
        }
    </style>
</head>
<body>
    <form id="form1" method="post" runat="server">

        <div class="page">
            <asp:Panel ID="PError" runat="server" Visible="false">
                <asp:LinkButton ID="LinkButton1" CssClass="cross" OnClick="HidePErr" runat="server"></asp:LinkButton>
                <asp:Label ID="LErr" runat="server" Text="Label" Visible="true"></asp:Label>
                <script>
                    document.querySelector(".cross").addEventListener("click", _ => {
                        document.getElementById("PError").style.opacity = 0;
                        document.getElementById("PError").style.pointerEvents = "none";
                    });
                </script>
            </asp:Panel>
            <nav class="navigation">
                <asp:HyperLink ID="logo" CssClass="logo proj-logo" runat="server" NavigateUrl="~/employee/admin.aspx"></asp:HyperLink>
                <h1 class="intro">Manage Regional Branch</h1>
                <div class="account">
                    <asp:Panel ID="ProundedDP" CssClass="userDP" runat="server"></asp:Panel>

                    <asp:Label ID="Aname" CssClass="user" runat="server" Text="Employee"></asp:Label>
                    <ul class="dropdown hidden">
                        <li class="l2__nav">
                            <asp:HyperLink CssClass="l2__link" ID="profile" runat="server" NavigateUrl="~/employee/empProfile.aspx">My Profile</asp:HyperLink>
                        </li>
                        <li class="l2__nav">
                            <asp:LinkButton ID="signout" CssClass="l2__link" runat="server" OnClick="Logout">Log Out</asp:LinkButton>
                        </li>
                    </ul>
                </div>
            </nav>
            <main class="Main-container">
                <div class="side-nav">
                    <asp:HyperLink ID="hlhome" CssClass="side-link" runat="server" NavigateUrl="~/employee/admin.aspx">Home</asp:HyperLink>
                    <asp:HyperLink ID="hlemanager" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/empManager.aspx">Employee Manager</asp:HyperLink>
                    <asp:HyperLink ID="hlsbmanager" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/subBManager.aspx">Sub-Branch Manager</asp:HyperLink>
                    <asp:HyperLink ID="hlrates" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/ratesManager.aspx">Rates Manager</asp:HyperLink>
                </div>
                <div class="content">
                    <div class="tabs">
                        <asp:LinkButton ID="LBCreateREGb" CssClass="tab active" runat="server" OnClick="CreateRb" CausesValidation="False">Create Regional Branch</asp:LinkButton>
                        <asp:LinkButton ID="LBSrcREGb" CssClass="tab" runat="server" OnClick="SrcRb" CausesValidation="False">Edit Regional Branch</asp:LinkButton>
                    </div>

                    <asp:Panel ID="PcreateRb" CssClass="tabpanel" runat="server">
                        <div class="inner-content">
                            <asp:HiddenField ID="HFalreadyExists" runat="server" Value="false" />
                            <asp:ObjectDataSource ID="OBSRegions" runat="server" SelectMethod="GetRegion" TypeName="OnlineCourierService.employee.Classes.DataAccessLayer"></asp:ObjectDataSource>

                            <asp:Label ID="LRegname" CssClass="lable" runat="server" Text="Regional Name "></asp:Label>
                            <asp:DropDownList ID="DDLReg" CssClass="ddl" runat="server" DataSourceID="OBSRegions" DataTextField="Name" DataValueField="ID" OnSelectedIndexChanged="IsAlreadyRegistered" AutoPostBack="True"></asp:DropDownList>
                            <div class="validation">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="DDLReg" Display="Dynamic" ErrorMessage="Region is Required" ForeColor="Red" InitialValue="-1" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:Label ID="LDdlError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                            </div>

                            <asp:Label ID="LRegBname" CssClass="lable" runat="server" Text="Regional Branch Name "></asp:Label>
                            <asp:TextBox ID="TBRegBname" CssClass="input" runat="server"></asp:TextBox>
                            <div class="validation">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Regional Branch Name is Required" ControlToValidate="TBRegBname" ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <asp:Label ID="LRegBaddr" CssClass="lable" runat="server" Text="Regional Branch Address "></asp:Label>
                            <asp:TextBox ID="TBRegBaddr" CssClass="input" runat="server"></asp:TextBox>
                            <div class="validation">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Regional Branch Address is Required" ControlToValidate="TBRegBaddr" ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <asp:Label ID="Llatetude" CssClass="lable" runat="server" Text="Latetude "></asp:Label>
                            <asp:TextBox ID="TBLat" CssClass="input" runat="server"></asp:TextBox>
                            <div class="validation">
                                <asp:RequiredFieldValidator ID="RFVLat" runat="server" ErrorMessage="Latetude is Required" ControlToValidate="TBLat" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CVLat" runat="server" ControlToValidate="TBLat" Display="Dynamic" ErrorMessage="Latedude Must be in Decimal" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Type="Double"></asp:CompareValidator>
                            </div>

                            <asp:Label ID="Llongitude" CssClass="lable" runat="server" Text="Longitude "></asp:Label>
                            <asp:TextBox ID="TBLong" CssClass="input" runat="server"></asp:TextBox>
                            <div class="validation">
                                <asp:RequiredFieldValidator ID="RFVLong" runat="server" ErrorMessage="Longitude is Required" ControlToValidate="TBLong" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CVLong" runat="server" ControlToValidate="TBLong" Display="Dynamic" ErrorMessage="Longitude Must be in Decimal" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Type="Double"></asp:CompareValidator>
                            </div>

                            <asp:Button ID="Bsubmit" CssClass="btn save" runat="server" Text="Create" OnClick="Submit" />
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="PSrcRb" CssClass="tabpanel" runat="server" Visible="false">
                        <div class="grid-content">
                            <asp:ObjectDataSource ID="OBSRegB" runat="server"
                                SelectMethod="GetRegBranches"
                                TypeName="OnlineCourierService.employee.Classes.Branch"
                                StartRowIndexParameterName="startIndex"
                                MaximumRowsParameterName="pageSize"
                                EnablePaging="True" SelectCountMethod="CountRegB"
                                UpdateMethod="UpdateRegBranches" ConflictDetection="CompareAllValues" OldValuesParameterFormatString="OLD_{0}" OnUpdated="OBSRegB_Updated">
                                <UpdateParameters>
                                    <asp:Parameter Name="OLD_Bid" Type="Int64" />
                                    <asp:Parameter Name="OLD_name" Type="String" />
                                    <asp:Parameter Name="OLD_address" Type="String" />
                                    <asp:Parameter Name="OLD_lat" Type="Double" />
                                    <asp:Parameter Name="OLD_lon" Type="Double" />
                                    <asp:Parameter Name="OLD_status" Type="String" />
                                    <asp:Parameter Name="name" Type="String" />
                                    <asp:Parameter Name="address" Type="String" />
                                    <asp:Parameter Name="lat" Type="Double" />
                                    <asp:Parameter Name="lon" Type="Double" />
                                    <asp:Parameter Name="status" Type="String" />
                                </UpdateParameters>
                            </asp:ObjectDataSource>

                            <asp:GridView ID="GVRegB" runat="server" AutoGenerateColumns="False" CssClass="GVRegB" DataSourceID="OBSRegB" DataKeyNames="Bid" AllowPaging="True"
                                OnRowUpdated="GVRegB_RowUpdated" PageSize="10">
                                <Columns>
                                    <asp:BoundField DataField="Bid" HeaderText="Branch ID" ReadOnly="True" SortExpression="Bid" />

                                    <asp:TemplateField HeaderText="Regional Branch Name" SortExpression="name">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TBRegBname" CssClass="GVinput input-area" runat="server" TextMode="MultiLine" Text='<%# Bind("name") %>'></asp:TextBox>
                                            <div>
                                                <asp:RequiredFieldValidator ID="RFVRegBname" ControlToValidate="TBRegBname" runat="server" ErrorMessage="Regional Branch Name is Required"
                                                    Text="*" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Region Branch Address" SortExpression="address">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TBRegBaddr" CssClass="GVinput input-area" runat="server" TextMode="MultiLine" Text='<%# Bind("address") %>'></asp:TextBox>
                                            <div>
                                                <asp:RequiredFieldValidator ID="RFVRegBaddr" ControlToValidate="TBRegBaddr" runat="server" ErrorMessage="Regional Branch Address is Required"
                                                    Text="*" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            </div>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("address") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Latitude" SortExpression="lat">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TBRegBlat" CssClass="GVinput" runat="server" Text='<%# Bind("lat") %>'></asp:TextBox>
                                            <div>
                                                <asp:RequiredFieldValidator ID="RFVRegBlat" ControlToValidate="TBRegBlat" runat="server" ErrorMessage="Latitude of Regional Branch is Required"
                                                    Text="*" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                <asp:CompareValidator ID="CVRegBlat" runat="server" ControlToValidate="TBRegBlat" Display="Dynamic" ErrorMessage="Latetude for Regional Branch is of Decimal Type" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Type="Double">*</asp:CompareValidator>
                                                <asp:CompareValidator ID="CVRegBlat0" runat="server" ControlToValidate="TBRegBlat" Display="Dynamic" ErrorMessage="Latetude for Regional Branch Must be Greater than or Equal To Zero" ForeColor="Red" Operator="GreaterThanEqual" SetFocusOnError="True" Type="Double" ValueToCompare="0">*</asp:CompareValidator>
                                                <asp:CompareValidator ID="CVRegBlat1" runat="server" ControlToValidate="TBRegBlat" Display="Dynamic" ErrorMessage="Latetude for Regional Branch Must be Less than or Equal To 180" ForeColor="Red" Operator="LessThanEqual" SetFocusOnError="True" Type="Double" ValueToCompare="180">*</asp:CompareValidator>
                                            </div>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("lat") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Longitude" SortExpression="lon">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TBRegBlon" runat="server" CssClass="GVinput" Text='<%# Bind("lon") %>'></asp:TextBox>
                                            <div>
                                                <asp:RequiredFieldValidator ID="RFVRegBlon" ControlToValidate="TBRegBlon" runat="server" ErrorMessage="Longitude of Regional Branch is Required"
                                                    Text="*" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                <asp:CompareValidator ID="CVRegBlon" runat="server" ControlToValidate="TBRegBlon" Display="Dynamic" ErrorMessage="Latetude for Regional Branch is of Decimal Type" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Type="Double">*</asp:CompareValidator>
                                                <asp:CompareValidator ID="CVRegBlon0" runat="server" ControlToValidate="TBRegBlon" Display="Dynamic" ErrorMessage="Latetude for Regional Branch Must be Greater than or Equal To Zero" ForeColor="Red" Operator="GreaterThanEqual" SetFocusOnError="True" Type="Double" ValueToCompare="0">*</asp:CompareValidator>
                                                <asp:CompareValidator ID="CVRegBlon1" runat="server" ControlToValidate="TBRegBlon" Display="Dynamic" ErrorMessage="Latetude for Regional Branch Must be Less than or Equal To 180" ForeColor="Red" Operator="LessThanEqual" SetFocusOnError="True" Type="Double" ValueToCompare="180">*</asp:CompareValidator>
                                            </div>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("lon") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Status" SortExpression="status">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DDLRegBstatus" runat="server" CssClass="ddl" SelectedValue='<%# Bind("status") %>'>
                                                <asp:ListItem Value="Select Status">Select Status</asp:ListItem>
                                                <asp:ListItem>Active</asp:ListItem>
                                                <asp:ListItem>Inactive</asp:ListItem>
                                            </asp:DropDownList>
                                            <span>
                                                <asp:RequiredFieldValidator ID="RFVRegBstatus" ControlToValidate="DDLRegBstatus" runat="server" ErrorMessage="Regional Branch Status is Required"
                                                    Text="*" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" InitialValue="Select Status"></asp:RequiredFieldValidator>
                                            </span>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ShowHeader="False">
                                        <EditItemTemplate>
                                            <asp:Button ID="Button1" CssClass="btn" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                            <asp:Button ID="Button2" CssClass="btn" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Button ID="Button1" CssClass="btn" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <AlternatingRowStyle ForeColor="#284775" />
                                <PagerStyle CssClass="pager" HorizontalAlign="Center" />
                            </asp:GridView>
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" DisplayMode="List" />
                        </div>
                    </asp:Panel>
                </div>
            </main>
            <footer class="footer">
                <asp:HyperLink ID="sitemap" CssClass="footer__link" runat="server" NavigateUrl="#">Site Map</asp:HyperLink>
                <span class="footer__span">&copy;2019 - 2021 Lightning Corp.</span>
            </footer>
        </div>
    </form>
</body>
</html>
