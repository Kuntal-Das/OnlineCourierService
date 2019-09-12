<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ratesManager.aspx.cs" Inherits="OnlineCourierService.employee.AdminLinks.ratesManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=0.86, maximum-scale=3.0, minimum-scale=0.86" />
    <link rel="shortcut icon" href="../../lightning.ico" />
    <title>Manage Rates</title>
    <link rel="stylesheet" href="css/sidebar.css" />
    <link rel="stylesheet" href="css/ratesManager.css" />
    <script type="text/javascript" src="../js/main.js"></script>
    <script type="text/javascript" src="js/ratesManager.js"></script>
</head>
<body>
    <form id="form1" method="post" runat="server">
        <div class="page">
            <asp:Panel ID="PError" runat="server" Visible="false">
                <asp:LinkButton ID="LBcross" CssClass="cross" OnClick="HidePErr" runat="server"></asp:LinkButton>
                <%--<div class="cross"></div>--%>
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
                <h1 class="intro">Manage Rates</h1>
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
                    <asp:HyperLink ID="hlrbmanager" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/regBManager.aspx">Regional Branch Manager</asp:HyperLink>
                    <asp:HyperLink ID="hlsbmanager" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/subBManager.aspx">Sub-Branch Manager</asp:HyperLink>
                </div>

                <div class="content">

                        <asp:ObjectDataSource ID="OBSRates" runat="server" SelectMethod="GetRates" TypeName="OnlineCourierService.employee.Classes.DataAccessLayer" UpdateMethod="UpdateRates"
                            ConflictDetection="CompareAllValues" OldValuesParameterFormatString="OLD_{0}" InsertMethod="InsertRates" OnUpdated="OBSRates_Updated">
                            <InsertParameters>
                                <asp:Parameter Name="Weight" Type="Int32" />
                                <asp:Parameter Name="Basic" Type="Double" />
                                <asp:Parameter Name="Business" Type="Double" />
                                <asp:Parameter Name="DryFood" Type="Double" />
                                <asp:Parameter Name="CookedFood" Type="Double" />
                                <asp:Parameter Name="Gift" Type="Double" />
                                <asp:Parameter Name="Electronics" Type="Double" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="OLD_RateID" Type="Int32" />
                                <asp:Parameter Name="OLD_Weight" Type="Int32" />
                                <asp:Parameter Name="OLD_Basic" Type="Double" />
                                <asp:Parameter Name="OLD_Business" Type="Double" />
                                <asp:Parameter Name="OLD_DryFood" Type="Double" />
                                <asp:Parameter Name="OLD_CookedFood" Type="Double" />
                                <asp:Parameter Name="OLD_Gift" Type="Double" />
                                <asp:Parameter Name="OLD_Electronics" Type="Double" />
                                <asp:Parameter Name="Weight" Type="Int32" />
                                <asp:Parameter Name="Basic" Type="Double" />
                                <asp:Parameter Name="Business" Type="Double" />
                                <asp:Parameter Name="DryFood" Type="Double" />
                                <asp:Parameter Name="CookedFood" Type="Double" />
                                <asp:Parameter Name="Gift" Type="Double" />
                                <asp:Parameter Name="Electronics" Type="Double" />
                            </UpdateParameters>
                        </asp:ObjectDataSource>
                    <h3 class="hero-text">Rates Chart(in Rupees per KM) According to Parcel Type and Weight(in KG)</h3>
                    <asp:GridView ID="GVParcelRates" runat="server" CssClass="ratesTable" DataSourceID="OBSRates" AutoGenerateColumns="False" DataKeyNames="RateID" ShowFooter="True" OnRowUpdated="GVParcelRates_RowUpdated">
                        <Columns>
                            <asp:TemplateField HeaderText="RateID" SortExpression="RateID">
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("RateID") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("RateID") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Button ValidationGroup="insert" ID="BInsert" OnClick="InsertNewRate" CssClass="btn" runat="server" Text="Insert" />
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Weight" SortExpression="Weight">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" CssClass="GVinput" runat="server" Text='<%# Bind("Weight") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RFVEWeight" runat="server" ControlToValidate="TextBox1" Display="Dynamic" ErrorMessage="Rate is Required for Parcel type : &quot;Weight&quot; to Update " ForeColor="Red" SetFocusOnError="True" Text="*"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CVEWeight" runat="server" ControlToValidate="TextBox1" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Weight&quot; need to be a Integer value to Update" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Text="*" Type="Integer"></asp:CompareValidator>
                                    <asp:CompareValidator ID="CV2EWeight" runat="server" ControlToValidate="TextBox1" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Weight&quot; must be greater than 0 to Update" ForeColor="Red" Operator="GreaterThan" SetFocusOnError="True" Text="*" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Weight") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="TBweight" CssClass="GVinput" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="insert" ID="RFVIWeight" runat="server" ControlToValidate="TBweight" Display="Dynamic" ErrorMessage="Rate is Required for Parcel type : &quot;Weight&quot; for Insertion" ForeColor="Red" SetFocusOnError="True" Text="*"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ValidationGroup="insert" ID="CVIWeight" runat="server" ControlToValidate="TBweight" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Weight&quot; need to be a Integer value for Insertion" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Text="*" Type="Integer"></asp:CompareValidator>
                                    <asp:CompareValidator ValidationGroup="insert" ID="CVI2Weight" runat="server" ControlToValidate="TBweight" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Weight&quot; must be greater than 0 for Insertion" ForeColor="Red" Operator="GreaterThan" SetFocusOnError="True" Text="*" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Basic" SortExpression="Basic">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" CssClass="GVinput" runat="server" Text='<%# Bind("Basic") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RFVEBasic" runat="server" ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="Rate is Required for Parcel type : &quot;Basic&quot; to Update" ForeColor="Red" SetFocusOnError="True" Text="*"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CVEBasic" runat="server" ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Basic&quot; need to be a Decimal value to Update" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Text="*" Type="Double"></asp:CompareValidator>
                                    <asp:CompareValidator ID="CVE2Basic" runat="server" ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Basic&quot; must be greater than 0 to Update" ForeColor="Red" Operator="GreaterThan" SetFocusOnError="True" Text="*" Type="Double" ValueToCompare="0"></asp:CompareValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Basic") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="TBBasic" CssClass="GVinput" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="insert" ID="RFVIBasic" runat="server" ControlToValidate="TBBasic" Display="Dynamic" ErrorMessage="Rate is Required for Parcel type : &quot;Basic&quot; for Insertion" ForeColor="Red" SetFocusOnError="True" Text="*"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ValidationGroup="insert" ID="CVIBasic" runat="server" ControlToValidate="TBBasic" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Basic&quot; need to be a Decimal value for Insertion" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Text="*" Type="Double"></asp:CompareValidator>
                                    <asp:CompareValidator ValidationGroup="insert" ID="CVI2Basic" runat="server" ControlToValidate="TBBasic" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Basic&quot; must be greater than 0 for Insertion" ForeColor="Red" Operator="GreaterThan" SetFocusOnError="True" Text="*" Type="Double" ValueToCompare="0"></asp:CompareValidator>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Business" SortExpression="Business">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" CssClass="GVinput" runat="server" Text='<%# Bind("Business") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RFVEBusiness" runat="server" ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="Rate is Required for Parcel type : &quot;Business&quot; to Update" ForeColor="Red" SetFocusOnError="True" Text="*"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CVEBusiness" runat="server" ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Business&quot; need to be a Decimal value to Update" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Text="*" Type="Double"></asp:CompareValidator>
                                    <asp:CompareValidator ID="CVE2Business" runat="server" ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Business&quot; must be greater than 0 to Update" ForeColor="Red" Operator="GreaterThan" SetFocusOnError="True" Text="*" Type="Double" ValueToCompare="0"></asp:CompareValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Business") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="TBBusiness" CssClass="GVinput" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="insert" ID="RFVIBusiness" runat="server" ControlToValidate="TBBusiness" Display="Dynamic" ErrorMessage="Rate is Required for Parcel type : &quot;Business&quot; for Insertion" ForeColor="Red" SetFocusOnError="True" Text="*"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ValidationGroup="insert" ID="CVIBusiness" runat="server" ControlToValidate="TBBusiness" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Business&quot; need to be a Decimal value for Insertion" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Text="*" Type="Double"></asp:CompareValidator>
                                    <asp:CompareValidator ValidationGroup="insert" ID="CVI2Business" runat="server" ControlToValidate="TBBusiness" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Business&quot; must be greater than 0 for Insertion" ForeColor="Red" Operator="GreaterThan" SetFocusOnError="True" Text="*" Type="Double" ValueToCompare="0"></asp:CompareValidator>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="DryFood" SortExpression="DryFood">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox4" CssClass="GVinput" runat="server" Text='<%# Bind("DryFood") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RFVEDryFood" runat="server" ControlToValidate="TextBox4" Display="Dynamic" ErrorMessage="Rate is Required for Parcel type : &quot;DryFood&quot; to Update" ForeColor="Red" SetFocusOnError="True" Text="*"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CVEDryFood" runat="server" ControlToValidate="TextBox4" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;DryFood&quot; need to be a Decimal value to Update" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Text="*" Type="Double"></asp:CompareValidator>
                                    <asp:CompareValidator ID="CVE2DryFood" runat="server" ControlToValidate="TextBox4" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;DryFood&quot; must be greater than 0 to Update" ForeColor="Red" Operator="GreaterThan" SetFocusOnError="True" Text="*" Type="Double" ValueToCompare="0"></asp:CompareValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("DryFood") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="TBDryFood" CssClass="GVinput" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="insert" ID="RFVEDryFood" runat="server" ControlToValidate="TBDryFood" Display="Dynamic" ErrorMessage="Rate is Required for Parcel type : &quot;DryFood&quot; for Insertion" ForeColor="Red" SetFocusOnError="True" Text="*"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ValidationGroup="insert" ID="CVIDryFood" runat="server" ControlToValidate="TBDryFood" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;DryFood&quot; need to be a Decimal value for Insertion" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Text="*" Type="Double"></asp:CompareValidator>
                                    <asp:CompareValidator ValidationGroup="insert" ID="CVI2DryFood" runat="server" ControlToValidate="TBDryFood" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;DryFood&quot; must be greater than 0 for Insertion" ForeColor="Red" Operator="GreaterThan" SetFocusOnError="True" Text="*" Type="Double" ValueToCompare="0"></asp:CompareValidator>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="CookedFood" SortExpression="CookedFood">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox5" CssClass="GVinput" runat="server" Text='<%# Bind("CookedFood") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RFVECookedFood" runat="server" ControlToValidate="TextBox5" Display="Dynamic" ErrorMessage="Rate is Required for Parcel type : &quot;Cooked Food&quot; to Update" ForeColor="Red" SetFocusOnError="True" Text="*"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CVECookedFood" runat="server" ControlToValidate="TextBox5" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Cooked Food&quot; need to be a Decimal value to Update" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Text="*" Type="Double"></asp:CompareValidator>
                                    <asp:CompareValidator ID="CVE2CookedFood" runat="server" ControlToValidate="TextBox5" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Cooked Food&quot; must be greater than 0 to Update" ForeColor="Red" Operator="GreaterThan" SetFocusOnError="True" Text="*" Type="Double" ValueToCompare="0"></asp:CompareValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("CookedFood") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="TBCookedFood" CssClass="GVinput" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="insert" ID="RFVICookedFood" runat="server" ControlToValidate="TBCookedFood" Display="Dynamic" ErrorMessage="Rate is Required for Parcel type : &quot;Cooked Food&quot; for Insertion" ForeColor="Red" SetFocusOnError="True" Text="*"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ValidationGroup="insert" ID="CVICookedFood" runat="server" ControlToValidate="TBCookedFood" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Cooked Food&quot; need to be a Decimal value for Insertion" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Text="*" Type="Double"></asp:CompareValidator>
                                    <asp:CompareValidator ValidationGroup="insert" ID="CVI2CookedFood" runat="server" ControlToValidate="TBCookedFood" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Cooked Food&quot; must be greater than 0 for Insertion" ForeColor="Red" Operator="GreaterThan" SetFocusOnError="True" Text="*" Type="Double" ValueToCompare="0"></asp:CompareValidator>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Gift" SortExpression="Gift">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox6" CssClass="GVinput" runat="server" Text='<%# Bind("Gift") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RFVEGift" runat="server" ErrorMessage="Rate is Required for Parcel type : &quot;Gift&quot; to Update" ControlToValidate="TextBox6" Display="Dynamic" Text="*" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CVEGift" runat="server" ErrorMessage="Rate of Parcel Type : &quot;Gift&quot; need to be a Decimal value to Update" ControlToValidate="TextBox6" Display="Dynamic" Text="*" SetFocusOnError="True" Type="Double" Operator="DataTypeCheck" ForeColor="Red"></asp:CompareValidator>
                                    <asp:CompareValidator ID="CVE2Gift" runat="server" ErrorMessage="Rate of Parcel Type : &quot;Gift&quot; must be greater than 0 to Update" ControlToValidate="TextBox6" Display="Dynamic" Text="*" SetFocusOnError="True" Type="Double" Operator="GreaterThan" ForeColor="Red" ValueToCompare="0"></asp:CompareValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("Gift") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="TBGift" CssClass="GVinput" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="insert" ID="RFVIGift" runat="server" ErrorMessage="Rate is Required for Parcel type : &quot;Gift&quot; for Insertion" ControlToValidate="TBGift" Display="Dynamic" Text="*" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ValidationGroup="insert" ID="CVIGift" runat="server" ErrorMessage="Rate of Parcel Type : &quot;Gift&quot; need to be a Decimal value for Insertion" ControlToValidate="TBGift" Display="Dynamic" Text="*" SetFocusOnError="True" Type="Double" Operator="DataTypeCheck" ForeColor="Red"></asp:CompareValidator>
                                    <asp:CompareValidator ValidationGroup="insert" ID="CVI2Gift" runat="server" ErrorMessage="Rate of Parcel Type : &quot;Gift&quot; must be greater than 0 for Insertion" ControlToValidate="TBGift" Display="Dynamic" Text="*" SetFocusOnError="True" Type="Double" Operator="GreaterThan" ForeColor="Red" ValueToCompare="0"></asp:CompareValidator>
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Electronics" SortExpression="Electronics">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox7" CssClass="GVinput" runat="server" Text='<%# Bind("Electronics") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RFVEElectronics" runat="server" ControlToValidate="TextBox7" Display="Dynamic" ErrorMessage="Rate is Required for Parcel type : &quot;Electronics&quot; to Update" ForeColor="Red" SetFocusOnError="True" Text="*"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CVEElectronics" runat="server" ControlToValidate="TextBox7" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Electronics&quot; need to be a Decimal value to Update" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Text="*" Type="Double"></asp:CompareValidator>
                                    <asp:CompareValidator ID="CVE2Electronics" runat="server" ControlToValidate="TextBox7" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Electronics&quot; must be greater than 0 to Update" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Text="*" Type="Double" ValueToCompare="0"></asp:CompareValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("Electronics") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="TBElectronics" CssClass="GVinput" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="insert" ID="RFVIElectronics" runat="server" ControlToValidate="TBElectronics" Display="Dynamic" ErrorMessage="Rate is Required for Parcel type : &quot;Electronics&quot; for Insertion" ForeColor="Red" SetFocusOnError="True" Text="*"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ValidationGroup="insert" ID="CVIElectronics" runat="server" ControlToValidate="TBElectronics" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Electronics&quot; need to be a Decimal value for Insertion" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Text="*" Type="Double"></asp:CompareValidator>
                                    <asp:CompareValidator ValidationGroup="insert" ID="CVI2Electronics" runat="server" ControlToValidate="TBElectronics" Display="Dynamic" ErrorMessage="Rate of Parcel Type : &quot;Electronics&quot; must be greater than 0 for Insertion" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Text="*" Type="Double" ValueToCompare="0"></asp:CompareValidator>
                                </FooterTemplate>
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
                    </asp:GridView>
                    <asp:ValidationSummary ID="VSupdate" ForeColor="Red" runat="server" />
                    <asp:ValidationSummary ValidationGroup="insert" ID="VSinsert" runat="server" ForeColor="Red" />
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
