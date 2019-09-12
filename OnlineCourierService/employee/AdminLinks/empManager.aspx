<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="empManager.aspx.cs" Inherits="OnlineCourierService.employee.AdminLinks.empManager" %>

<%@ Register Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>

<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>--%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=0.86, maximum-scale=3.0, minimum-scale=0.86" />
    <link rel="shortcut icon" href="../../lightning.ico" />
    <title>Manage Employee</title>
    <link rel="stylesheet" href="css/sidebar.css" />
    <link rel="stylesheet" href="css/empManager.css" />
    <script type="text/javascript" src="../js/main.js"></script>
    <script type="text/javascript" src="js/empManager.js"></script>
</head>
<body>
    <form id="form1" method="post" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
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
                <h1 class="intro">Manage Employee</h1>
                <div class="account">
                    <asp:Panel ID="ProundedDP" CssClass="userDP" runat="server"></asp:Panel>

                    <asp:Label ID="Aname" CssClass="user" runat="server" Text="Employee"></asp:Label>
                    <ul class="dropdown hidden">
                        <li class="l2__nav">
                            <asp:HyperLink CssClass="l2__link" ID="profile" runat="server" NavigateUrl="~/employee/empProfile.aspx">My Profile</asp:HyperLink>
                        </li>
                        <li class="l2__nav">
                            <asp:LinkButton ID="signout" CssClass="l2__link" runat="server" OnClick="Logout" CausesValidation="False">Log Out</asp:LinkButton>
                        </li>
                    </ul>
                </div>
            </nav>
            <main class="Main-container">
                <div class="side-nav">
                    <asp:HyperLink ID="hlhome" CssClass="side-link" runat="server" NavigateUrl="~/employee/admin.aspx">Home</asp:HyperLink>
                    <asp:HyperLink ID="hlrbmanager" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/regBManager.aspx">Regional Branch Manager</asp:HyperLink>
                    <asp:HyperLink ID="hlsbmanager" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/subBManager.aspx">Sub-Branch Manager</asp:HyperLink>
                    <asp:HyperLink ID="hlrates" CssClass="side-link" runat="server" NavigateUrl="~/employee/AdminLinks/ratesManager.aspx">Rates Manager</asp:HyperLink>
                </div>
                <div class="content">
                    <div class="tabs">
                        <asp:LinkButton ID="LBCreateEmp" CssClass="tab active" runat="server" OnClick="CreateEmp" CausesValidation="False">Create Employee Account</asp:LinkButton>
                        <asp:LinkButton ID="LBSrcEmp" CssClass="tab" runat="server" OnClick="SrcEmp" CausesValidation="False">Search Employee Account</asp:LinkButton>
                    </div>

                    <asp:Panel ID="PcreateEmp" CssClass="tabpanel" runat="server">

                        <asp:ObjectDataSource ID="OBSRegBranch" runat="server" SelectMethod="GetRegBranch" TypeName="OnlineCourierService.employee.Classes.DataAccessLayer"></asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="OBSBranch" runat="server" SelectMethod="GetBranchByRid" TypeName="OnlineCourierService.employee.Classes.DataAccessLayer">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DDLRbranch" DefaultValue="0" Name="Rid" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="OBSPost" runat="server" SelectMethod="GetDepartments" TypeName="OnlineCourierService.employee.Classes.DataAccessLayer"></asp:ObjectDataSource>
                        <asp:Panel ID="Panel1" CssClass="Form-Container" runat="server">

                            <h3 id="pi" class="hero-text">Personal Information</h3>

                            <asp:Label ID="Lname" CssClass="lable" runat="server" Text="Name "></asp:Label>
                            <asp:TextBox ID="TBname" CssClass="input" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="TBVname" runat="server" ErrorMessage="Name is Required" ControlToValidate="TBname" ForeColor="Red"></asp:RequiredFieldValidator>

                            <asp:Label ID="LAddr" CssClass="lable" runat="server" Text="Address "></asp:Label>
                            <asp:TextBox ID="TBAddr" CssClass="input" runat="server" TextMode="MultiLine" Columns="5"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RFVaddress" runat="server" ErrorMessage="Address is Required" ControlToValidate="TBAddr" ForeColor="Red"></asp:RequiredFieldValidator>

                            <asp:Label ID="Lgender" CssClass="lable" runat="server" Text="Gender"></asp:Label>
                            <asp:RadioButtonList ID="RBLgenger" CssClass="list" runat="server">
                                <asp:ListItem Value="Male" Selected="True"> Male</asp:ListItem>
                                <asp:ListItem Value="Female"> Female</asp:ListItem>
                                <asp:ListItem Value="Other"> Other</asp:ListItem>
                            </asp:RadioButtonList>

                            <asp:Label ID="Ldob" CssClass="lable" runat="server" Text="Date of Birth :"></asp:Label>
                            <asp:TextBox ID="TBdob" CssClass="input-date" runat="server" TextMode="Date" min="1960-01-01"></asp:TextBox>

                            <asp:Label ID="Lemail" CssClass="lable" runat="server" Text="Email "></asp:Label>
                            <asp:TextBox ID="TBemail" CssClass="input" runat="server" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RFVemail" runat="server" ErrorMessage="Email is Required" ControlToValidate="TBemail" ForeColor="Red"></asp:RequiredFieldValidator>

                            <asp:Label ID="Lphno" CssClass="lable" runat="server" Text="Phone No. "></asp:Label>
                            <asp:TextBox ID="TBphno" CssClass="input" runat="server" TextMode="Phone"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RFVphone" runat="server" ErrorMessage="Phone No. is Required" ControlToValidate="TBphno" ForeColor="Red"></asp:RequiredFieldValidator>

                            <h3 id="ci" class="hero-text">Branch Information</h3>

                            <asp:Label ID="LRBranch" CssClass="lable" runat="server" Text="Regional Branch :"></asp:Label>
                            <asp:DropDownList ID="DDLRbranch" CssClass="ddl" runat="server" DataSourceID="OBSRegBranch" DataTextField="BName" DataValueField="Bid" AutoPostBack="True"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RFVRegBranch" runat="server" ErrorMessage="Regional Branch is Required" ControlToValidate="DDLRbranch" ForeColor="Red" InitialValue="-1"></asp:RequiredFieldValidator>

                            <asp:Label ID="LBranch" CssClass="lable" runat="server" Text="Branch"></asp:Label>
                            <asp:DropDownList ID="DDLbranch" CssClass="ddl" runat="server" DataSourceID="OBSBranch" DataTextField="BName" DataValueField="Bid"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RFVbranch" runat="server" ErrorMessage="Branch is Required" ControlToValidate="DDLbranch" ForeColor="Red" InitialValue="-1"></asp:RequiredFieldValidator>

                            <asp:Label ID="Lpost" CssClass="lable" runat="server" Text="Post"></asp:Label>
                            <asp:DropDownList ID="DDLpost" CssClass="ddl" runat="server" DataSourceID="OBSPost" DataTextField="DeptName" DataValueField="DeptId"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RFVpost" runat="server" ErrorMessage="Post is Required" ControlToValidate="DDLpost" ForeColor="Red" InitialValue="-1"></asp:RequiredFieldValidator>

                            <h3 class="hero-text">Profile picture</h3>
                            <asp:FileUpload ID="FUprofileImg" CssClass="input-img" runat="server" />

                            <asp:Button ID="Bsave" CssClass="save" runat="server" Text="Save Changes" OnClick="SaveChanges" />
                        </asp:Panel>


                    </asp:Panel>

                    <asp:Panel ID="PsrcEmp" CssClass="tabpanel" runat="server" Visible="false">
                        <h3 class="hero">Search Employee Account</h3>
                        <p class="list">
                            Search Employee By his/her ID number or the Branch ID no he/she Works in<br />
                            Edit his/her Branch if he/she recently transfered to a new branch,<br />
                            Change his/her position in the Company/Branch,<br />
                            Deactivate/Activate his/her Account,<br />
                        </p>

                        <div class="Divsrch">
                            <asp:Label ID="Lsrc" runat="server" Text="Search Employee By "></asp:Label>
                            <asp:DropDownList ID="DDlsrchbby" CssClass="ddl" runat="server" OnSelectedIndexChanged="ChangeSrchbehavior" AutoPostBack="True">
                                <asp:ListItem Value="EID">Employee ID</asp:ListItem>
                                <asp:ListItem Value="BID">Branch ID</asp:ListItem>
                            </asp:DropDownList>
                            <asp:DropDownList ID="DDLSrcPost" runat="server" CssClass="ddl" DataSourceID="OBSPost" DataTextField="DeptName" DataValueField="DeptId" Visible="False">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RFVpostSrc" runat="server" ControlToValidate="DDLSrcPost" Display="Dynamic" ErrorMessage="Post is Required" ForeColor="Red" SetFocusOnError="True" Visible="False">*</asp:RequiredFieldValidator>
                            <asp:TextBox ID="TBsrc" CssClass="input" runat="server" TextMode="Search"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RFVid" runat="server" ErrorMessage="Employee ID/Branch ID Required" ControlToValidate="TBsrc" Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>

                            <asp:CompareValidator ID="CVid" runat="server" ControlToValidate="TBsrc" Display="Dynamic" ErrorMessage="Employee ID/Branch ID  must be in integer Format" ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Type="Integer">*</asp:CompareValidator>

                            <asp:Button ID="Bsrc" CssClass="btn" runat="server" Text="Search" OnClick="SearchByEid" />
                        </div>
                            <asp:ValidationSummary ID="VSSrc" runat="server" ForeColor="Red" DisplayMode="List"/>

                        <br />
                        <asp:GridView ID="GVEmp" runat="server" AutoGenerateColumns="False" CssClass="GV" DataKeyNames="EID" OnRowCommand="GVEmp_RowCommand" OnRowDataBound="GVEmp_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="EID" HeaderText="Employee ID" ReadOnly="true" />
                                <asp:BoundField DataField="NAME" HeaderText="Employee Name" ReadOnly="true" />
                                <asp:BoundField DataField="DOB" DataFormatString="{0:d}" HeaderText="Date Of Birth" ReadOnly="true" />
                                <asp:BoundField DataField="GENDER" HeaderText="Gender" ReadOnly="true" />
                                <asp:BoundField DataField="RID" HeaderText="Regional Branch ID" ReadOnly="true" />
                                <asp:TemplateField HeaderText="Branch ID">
                                    <EditItemTemplate>
                                        <asp:ObjectDataSource ID="OBSGVSubB" runat="server" SelectMethod="GetBranchByRid" TypeName="OnlineCourierService.employee.Classes.DataAccessLayer">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="DDLRID" Name="Rid" PropertyName="SelectedValue" Type="Int32" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                        <asp:DropDownList ID="DDLRID" CssClass="ddlGV" runat="server" DataSourceID="OBSRegBranch" DataTextField="BName" DataValueField="Bid" AutoPostBack="True" SelectedValue='<%# Bind("RID") %>' OnSelectedIndexChanged="DDLRID_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RFVrid" ControlToValidate="DDLRID" ErrorMessage="Regional Branch is Required" InitialValue="-1" ValidationGroup="gv"
                                            Text="*" ForeColor="Red"  runat="server" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>

                                        <asp:DropDownList ID="DDLBID" CssClass="ddlGV" runat="server" DataSourceID="OBSGVSubB" DataTextField="BName" DataValueField="Bid">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RFVbid" ControlToValidate="DDLBID" ErrorMessage="Sub-Branch is Required" InitialValue="-1" ValidationGroup="gv"
                                            Text="*" ForeColor="Red"  runat="server" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("BID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="POSTINDEX" HeaderText="Post Index" ReadOnly="True" />
                                <asp:TemplateField HeaderText="Post">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DDLpost" CssClass="ddlGV" runat="server" SelectedValue='<%# Bind("POSTINDEX") %>' DataSourceID="OBSPost" DataTextField="DeptName" DataValueField="DeptId">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RFVpost" ControlToValidate="DDLpost" ErrorMessage="Post of Employee is Required" InitialValue="-1" ValidationGroup="gv"
                                            Text="*" ForeColor="Red"  runat="server" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("POST") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DDLstatus" CssClass="ddlGV" runat="server" SelectedValue='<%# Bind("STATUS") %>'>
                                            <asp:ListItem Value="-1">Select Status</asp:ListItem>
                                            <asp:ListItem>Active</asp:ListItem>
                                            <asp:ListItem Value="Inactive"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RFVstatus" ControlToValidate="DDLstatus" ErrorMessage="Status of Employee is Required" InitialValue="-1" ValidationGroup="gv"
                                            Text="*" ForeColor="Red"  runat="server" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("STATUS") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit">
                                    <EditItemTemplate>
                                        <asp:Button ID="Button1" runat="server" CausesValidation="True" ValidationGroup="gv" CommandArgument='<%# Eval("EID") %>' CommandName="UpdateROW" CssClass="btn" Text="Update"/>
                                        <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandArgument='<%# Eval("EID") %>' CommandName="CancelEDIT" CssClass="btn" Text="Cancel"/>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("EID") %>' CommandName="EditROW" CssClass="btn" Text="Edit" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                            <asp:ValidationSummary ID="VSgv" runat="server" ForeColor="Red" DisplayMode="List" ValidationGroup="gv"/>
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
