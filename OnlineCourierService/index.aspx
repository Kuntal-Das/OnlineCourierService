<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="OnlineCourierService.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <meta name="viewport" content="width=device-width, initial-scale=0.86, maximum-scale=3.0, minimum-scale=0.86" />
  <link rel="shortcut icon" href="lightning.ico" />
  <title>Lightning Corp.</title>
  <link href="css/index.css" rel="stylesheet" />
</head>
<body>
  <form id="form1" runat="server">
    <section class="page">
      <div id="loaderImage" class="preloader">
        <img id="loader" src="svg/index.scratching-reveal-loader.svg" alt="LOGO">
      </div>
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
      <nav class="navi">
        <a href="index.aspx" class="logo proj-logo"></a>
        <ul class="menu">
          <li class="level1nav">
            <asp:HyperLink ID="HyperLink24" CssClass="level1nav__link t1" runat="server">Shipping&blacktriangledown;</asp:HyperLink>
            <ul class="dropdown UL1">
              <li class="level2nav">
                <asp:HyperLink ID="HyperLink1" CssClass="level2nav__link" NavigateUrl="~/Parcel/CreateParcel.aspx" runat="server">Create a Shipment</asp:HyperLink>
              </li>
              <li class="level2nav">
                <asp:HyperLink ID="HyperLink3" CssClass="level2nav__link" NavigateUrl="~/Parcel/RateofParcel.aspx" runat="server">Shipping Rates</asp:HyperLink>
              </li>
              <li class="level2nav">
                <asp:HyperLink ID="HyperLink6" CssClass="level2nav__link" NavigateUrl="#" runat="server">Returns</asp:HyperLink>
              </li>
              <li class="level2nav">
                <asp:HyperLink ID="HyperLink8" CssClass="level2nav__link" NavigateUrl="#" runat="server">Learn More about Online Shipping</asp:HyperLink>
              </li>
              <li class="level2nav">
                <asp:HyperLink ID="HyperLink9" CssClass="level2nav__link" NavigateUrl="#" runat="server">All Shiping Services</asp:HyperLink>
              </li>
            </ul>
          </li>
          <li class="level1nav">
            <asp:HyperLink ID="HyperLink23" CssClass="level1nav__link t2" runat="server">Tracking&blacktriangledown;</asp:HyperLink>
            <ul class="dropdown UL2">
              <li class="level2nav">
                <asp:HyperLink ID="HyperLink10" CssClass="level2nav__link" NavigateUrl="~/Parcel/ParcelStat.aspx" runat="server">Advance Shipment Tracking</asp:HyperLink>
              </li>
              <li class="level2nav">
                <asp:HyperLink ID="HyperLink12" CssClass="level2nav__link" NavigateUrl="#" runat="server">Track by Email</asp:HyperLink>
              </li>
              <li class="level2nav">
                <asp:HyperLink ID="HyperLink2" runat="server" CssClass="level2nav__link" NavigateUrl="~/Parcel/SrcParcel.aspx">All Tracking Services</asp:HyperLink>
              </li>
            </ul>
          </li>
          <li class="level1nav">
            <asp:HyperLink ID="HyperLink22" CssClass="level1nav__link t3" runat="server">Support&blacktriangledown;</asp:HyperLink>
            <ul class="dropdown UL3">
              <li class="level2nav">
                <asp:HyperLink ID="HyperLink16" CssClass="level2nav__link" NavigateUrl="#" runat="server">File a Claim</asp:HyperLink>
              </li>
              <li class="level2nav">
                <asp:HyperLink ID="HyperLink18" CssClass="level2nav__link" NavigateUrl="#" runat="server">Billing/Invoice Forms</asp:HyperLink>
              </li>
              <li class="level2nav">
                <asp:HyperLink ID="HyperLink4" runat="server" CssClass="level2nav__link" NavigateUrl="#">Find Our Store Locations</asp:HyperLink>
              </li>
            </ul>
          </li>
        </ul>
        <asp:HyperLink ID="LoginSignIn" CssClass="login" runat="server">
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    Sign Up or Login
                    <svg role="presentation" class="icon user--icon"><use xlink:href="#usericon" /></svg>
        </asp:HyperLink>
        <asp:Panel ID="Plogin" CssClass="login-container" runat="server">
          <div class="close"></div>
          <div class="logintab">
            <div class="inputbox">
              <asp:TextBox ID="TBunm" CssClass="input" runat="server" autocomplete="off" required=""></asp:TextBox>
              <span class="floating-placeholder">Email / Phone No.</span>
              <asp:RequiredFieldValidator ID="RFVunm" runat="server" ErrorMessage="Username is Required" ControlToValidate="TBunm" Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
            <div class="inputbox">
              <asp:TextBox ID="TBpas" CssClass="input" runat="server" TextMode="Password" required=""></asp:TextBox>
              <span class="floating-placeholder">Password</span>
              <asp:RequiredFieldValidator ID="RFVpass" runat="server" ErrorMessage="Password is Required" ControlToValidate="TBpas" Display="Dynamic" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </div>
            <asp:ValidationSummary ID="VSlogin" ForeColor="Red" DisplayMode="List" runat="server" />
            <asp:Button ID="Blogin" CssClass="sub" runat="server" Text="Log In" OnClick="Blogin_Click" />
            <div class="link">
              <asp:HyperLink ID="HyperLink46" CssClass="link_a" NavigateUrl="~/register.aspx" runat="server">Create Account</asp:HyperLink>
              <asp:HyperLink ID="HyperLink47" CssClass="link_a" NavigateUrl="~/forgotpassword.aspx" runat="server">Forgot Password?</asp:HyperLink>
            </div>
          </div>
        </asp:Panel>
        <asp:Panel ID="Puser" CssClass="account" runat="server" Visible="false" OnClick="toogleUserontrol()">
          <asp:Panel ID="ProundedDP" CssClass="userDP" runat="server"></asp:Panel>

          <asp:Label ID="Aname" CssClass="user" runat="server" Text="Employee"></asp:Label>
          <ul class="usercontrol hidden">
            <li class="l2__nav">
              <asp:HyperLink CssClass="l2__link" ID="profile" runat="server" NavigateUrl="~/Profile.aspx">My Profile</asp:HyperLink>
            </li>
            <li class="l2__nav">
              <asp:LinkButton ID="signout" CssClass="l2__link" runat="server" OnClick="Logout">Log Out</asp:LinkButton>
            </li>
          </ul>
        </asp:Panel>
      </nav>
      <div class="container">
        <a href="#mid" class="scroll-down">
          <span class="arrow"></span>
          <span class="arrow"></span>
          <span class="arrow"></span>
        </a>
        <header class="head1">
          <h1 class="head1__heading">Welcome to Lightning Corp</h1>
        </header>
        <div id="mid" class="HQLinks">
          <asp:HyperLink ID="HyperLink25" CssClass="HQLinks__link" NavigateUrl="~/Parcel/RateofParcel.aspx" runat="server">
                        <svg role="presentation" class="icon rate--icon"><use xlink:href="#rate" /></svg>
                        <p class="HQLinks__p">Rate of transport</p>
          </asp:HyperLink>
          <asp:HyperLink ID="HyperLink27" CssClass="HQLinks__link" NavigateUrl="~/Parcel/SrcParcel.aspx" runat="server">
                        <svg role="presentation" class="icon track--icon"><use xlink:href="#trackParcel" /></svg>
                        <p class="HQLinks__p">Track Shipmnet</p>
          </asp:HyperLink>
          <asp:HyperLink ID="HyperLink26" CssClass="HQLinks__link" NavigateUrl="~/Parcel/CreateParcel.aspx" runat="server">
                        <svg role="presentation" class="icon create--icon"><use xlink:href="#createParcel" /></svg>
                        <p class="HQLinks__p">New Shipment</p>
          </asp:HyperLink>
        </div>
        <div class="content">
          <div class="3rd imgDiv" data-src="/svg/background/gift.svg" data-pos="0">
            <div class="desc">
              <h2 class="desc__h2">Send Gifts</h2>
              <p class="desc__p">
                Do you want to send gifts to your dearest who lives far from you<br />
                on their Birthday or in other Occation? We got it Covered,
                                <br />
                We take care of wrapping and packaging while You prepare the gift
                                <br />
                We will include a Special Gift from us too 
              </p>
              <asp:HyperLink ID="HyperLink30" CssClass="desc__link" NavigateUrl="~/Parcel/CreateParcel.aspx?parcel=Gift" runat="server">Send Gifts</asp:HyperLink>
            </div>
          </div>
          <div class="4th imgDiv" data-src="/svg/background/food.svg" data-pos="1">
            <div class="desc">
              <h2 class="desc__h2">Send Food</h2>
              <p class="desc__p">
                Do you want your closest one to Taste the food made by you, but they live Far from you ?<br />
                We have Food Delivery Service when you need<br />
                You just make the food, We Take care of everything else<br />
              </p>
              <asp:HyperLink ID="HyperLink31" CssClass="desc__link" NavigateUrl="~/Parcel/CreateParcel.aspx?parcel=CookedFood" runat="server">Send Cooked Food / Dry Food</asp:HyperLink>
            </div>
          </div>
          <asp:Panel ID="Ppresonal" CssClass="1st imgDiv" runat="server" data-src="/svg/background/open.svg" data-pos="2">
            <div class="desc">
              <h2 class="desc__h2">Open New Personal Account</h2>
              <p class="desc__p">
                Are you new here open a personal Account so that you can keep track of
                                everything you do here
              </p>
              <asp:HyperLink ID="HyperLink28" CssClass="desc__link" NavigateUrl="~/register.aspx?q=personal" runat="server">Create Personal A/c</asp:HyperLink>
            </div>
          </asp:Panel>
          <asp:Panel ID="Pbusiness" CssClass="2nd imgDiv" runat="server" data-src="/svg/background/business.svg" data-pos="3">
            <div class="desc">
              <h2 class="desc__h2">Open New Business Account</h2>
              <p class="desc__p">
                Are you a business person or a corporative looking for our service Create
                                a
                                Business Account, we take extra care for our business clients
              </p>
              <asp:HyperLink ID="HyperLink29" CssClass="desc__link" NavigateUrl="~/register.aspx?q=business" runat="server">Create Business A/c</asp:HyperLink>
            </div>
          </asp:Panel>
        </div>
        <footer class="foot">
          <div class="foot__div about">
            <h3>About</h3>
            <ul>
              <li>
                <asp:HyperLink ID="HyperLink32" CssClass="foot__link" NavigateUrl="#" runat="server">About Us </asp:HyperLink>
              </li>
              <li>
                <asp:HyperLink ID="HyperLink33" CssClass="foot__link" NavigateUrl="#" runat="server">Contact Us</asp:HyperLink>
              </li>
              <li>
                <asp:HyperLink ID="HyperLink34" CssClass="foot__link" NavigateUrl="#" runat="server">Our Store Locatons</asp:HyperLink>
              </li>
            </ul>
          </div>
          <div class="foot__div help">
            <h3>Help</h3>
            <ul>
              <li>
                <asp:HyperLink ID="HyperLink35" CssClass="foot__link" NavigateUrl="#" runat="server">Payments</asp:HyperLink>
              </li>
              <li>
                <asp:HyperLink ID="HyperLink36" CssClass="foot__link" NavigateUrl="#" runat="server">Shipping</asp:HyperLink>
              </li>
              <li>
                <asp:HyperLink ID="HyperLink37" CssClass="foot__link" NavigateUrl="#" runat="server">International Holiday Schedule</asp:HyperLink>
              </li>
              <li>
                <asp:HyperLink ID="HyperLink38" CssClass="foot__link" NavigateUrl="#" runat="server">Cancellation</asp:HyperLink>
              </li>
              <li>
                <asp:HyperLink ID="HyperLink39" CssClass="foot__link" NavigateUrl="#" runat="server">FAQ</asp:HyperLink>
              </li>
              <li>
                <asp:HyperLink ID="HyperLink40" CssClass="foot__link" NavigateUrl="#" runat="server">Report Infringement</asp:HyperLink>
              </li>
            </ul>
          </div>
          <div class="foot__div policy">
            <h3>Policy</h3>
            <ul>
              <li>
                <asp:HyperLink ID="HyperLink41" CssClass="foot__link" NavigateUrl="#" runat="server">Cancellation Policy</asp:HyperLink>
              </li>
              <li>
                <asp:HyperLink ID="HyperLink42" CssClass="foot__link" NavigateUrl="#" runat="server">Terms of Service</asp:HyperLink>
              </li>
              <li>
                <asp:HyperLink ID="HyperLink43" CssClass="foot__link" NavigateUrl="#" runat="server">Security</asp:HyperLink>
              </li>
              <li>
                <asp:HyperLink ID="HyperLink44" CssClass="foot__link" NavigateUrl="#" runat="server">Privacy</asp:HyperLink>
              </li>
              <li>
                <asp:HyperLink ID="HyperLink45" CssClass="foot__link" NavigateUrl="#" runat="server">Conditions Of Carriage</asp:HyperLink>
              </li>
            </ul>
          </div>
          <div class="foot__div region">
            <h3>Region: </h3>
            <select>
              <option value="India">India</option>
            </select>
          </div>
        </footer>
        <div class="footer__bottom" id="bottom">
          <div class="social">
            <span class="social__follow">Follow Us on : </span>
            <a href="#" class="social__link facebook-icon">
              <svg role="presentation" class="icon facebook--icon">
                <use xlink:href="#facebookicon" />
              </svg>
            </a>
            <a href="#" class="social__link twitter-icon">
              <svg role="presentation" class="icon twitter--icon">
                <use xlink:href="#twittericon" />
              </svg>
            </a>
            <a href="#" class="social__link linkedin-icon">
              <svg role="presentation" class="icon linkedin--icon">
                <use xlink:href="#linkedinicon" />
              </svg>
            </a>
          </div>
          <div class="bottom">
            <a href="#" class="bottom__link">Sitemap</a> <span>&copy;2019 - 2021 Lightning Corp.</span>
          </div>
        </div>
      </div>
    </section>
    <!-- svgs -->
    <svg display="none">
      <symbol id="usericon" role="presentation" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 194 194">
        <path class="border"
          d="M97 13a84 84 0 1 1-84 84 84.09513 84.09513 0 0 1 84-84m0-13a97 97 0 1 0 97 97A97 97 0 0 0 97 0z" />
        <circle class="head" cx="97" cy="65" r="33" />
        <path class="body"
          d="M43 142c-8.44147-9.10907-8.31122-14.73462-8-17 .83569-6.08286 6.0473-10.29041 12.5-15.5a70.56271 70.56271 0 0 1 12.00311-7.8181 6.82759 6.82759 0 0 1 6.52424.17143 60.95361 60.95361 0 0 0 60.67427.158 6.83155 6.83155 0 0 1 6.92674.11175A131.12246 131.12246 0 0 1 144.5 109.5c8.96344 6.76105 13.46625 10.24872 14.5 15.5 1.34631 6.83887-3.77936 13.1456-7 17-10.00458 11.9733-28 24-50 24-28.77063 0-49.63916-13.89883-59-24z" />
      </symbol>
      <symbol id="facebookicon" role="presentation" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512">
        <path fill="currentColor"
          d="M279.14 288l14.22-92.66h-88.91v-60.13c0-25.35 12.42-50.06 52.24-50.06h40.42V6.26S260.43 0 225.36 0c-73.22 0-121.08 44.38-121.08 124.72v70.62H22.89V288h81.39v224h100.17V288z" />
      </symbol>
      <symbol id="twittericon" role="presentation" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
        <path fill="currentColor"
          d="M459.37 151.716c.325 4.548.325 9.097.325 13.645 0 138.72-105.583 298.558-298.558 298.558-59.452 0-114.68-17.219-161.137-47.106 8.447.974 16.568 1.299 25.34 1.299 49.055 0 94.213-16.568 130.274-44.832-46.132-.975-84.792-31.188-98.112-72.772 6.498.974 12.995 1.624 19.818 1.624 9.421 0 18.843-1.3 27.614-3.573-48.081-9.747-84.143-51.98-84.143-102.985v-1.299c13.969 7.797 30.214 12.67 47.431 13.319-28.264-18.843-46.781-51.005-46.781-87.391 0-19.492 5.197-37.36 14.294-52.954 51.655 63.675 129.3 105.258 216.365 109.807-1.624-7.797-2.599-15.918-2.599-24.04 0-57.828 46.782-104.934 104.934-104.934 30.213 0 57.502 12.67 76.67 33.137 23.715-4.548 46.456-13.32 66.599-25.34-7.798 24.366-24.366 44.833-46.132 57.827 21.117-2.273 41.584-8.122 60.426-16.243-14.292 20.791-32.161 39.308-52.628 54.253z" />
      </symbol>
      <symbol id="linkedinicon" role="presentation" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
        <path fill="currentColor"
          d="M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5 0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9V416z" />
      </symbol>
      <symbol id="rate" role="presentation" data-name="rate" xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 112.81 112.88">
        <g class="calculator" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
          stroke-width="2">
          <path
            d="M2.36 43.38h45.28a.86.86 0 0 1 .86.86v66.28a.86.86 0 0 1-.86.86H2.36a.86.86 0 0 1-.86-.86V44.24a.86.86 0 0 1 .86-.86z" />
          <path
            d="M7.51 49.4h34.98v18H7.51zM7.5 77.38h5M17.5 77.38h5M27.5 77.38h5M37.5 77.38h5M7.5 87.38h5M17.5 87.38h5M27.5 87.38h5M7.5 97.38h5M17.5 97.38h5M27.5 97.38h5M40.5 87.38v10" />
        </g>
        <path class="parcel" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
          stroke-width="2"
          d="M87.69 11.4L43.21 32.41M111.31 22.5L66.78 43.51M66.78 43.51v42.02M66.78 43.51L22.16 22.5M22.16 38.94V22.5l44.62-21 44.53 21v42.02L66.78 85.53l-14.22-6.99" />
      </symbol>
      <symbol id="trackParcel" role="presentation" data-name="track" xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 111.99562 99.88413">
        <path class="parcel" fill="none" stroke="currentColor" stroke-width="2"
          d="M45.43 43.76967L1 22.43967M45.43 43.76967v41.56M89.69 22.43967l-44.26 21.33M66.19 11.15967l-44.26 21.33M89.69 41.18V22.44L45.39 1.11 1 22.44V65.1l44.39 21.33 12.51-6.02" />
        <path class="srch" fill="none" stroke="currentColor" stroke-width="2"
          d="M90.83 71.8l19.78 20.61-5.78 6.03-19.79-20.61M87.24 47.69967a19.74 19.74 0 0 1 0 27.12 17.9 17.9 0 0 1-25.30488.69512q-.357-.338-.69512-.69512a19.74 19.74 0 0 1 0-27.12 17.9 17.9 0 0 1 25.30488-.69512q.35705.33796.69512.69512z" />
      </symbol>
      <symbol id="createParcel" role="presentation" xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 105.69275 85.44504">
        <g id="parcel" fill="none" stroke="currentColor" stroke-width="2" stroke-miterlimit="10">
          <path
            d="M55.37508 51.83L10.99947 30.52611a.038.038 0 0 0-.05439.03422v41.37084a.038.038 0 0 0 .02147.03419L55.37508 93.39"
            transform="translate(-10.44508 -8.43783)" />
          <path d="M74.77092 29.01108L44.93 43.39217M65.69 10.78216l-44.26 21.33" />
          <path
            d="M55.37508 51.83v41.54043a.01243.01243 0 0 0 .01772.01125L99.63509 72.61V46.50275M10.94508 30.5L53.04292 9.17774a2.22341 2.22341 0 0 1 1.94051-.03334l22.52165 10.45081 7.71092 3.66544"
            transform="translate(-10.44508 -8.43783)" />
        </g>
        <g id="plus" fill="none" stroke="currentColor" stroke-width="2" stroke-miterlimit="10">
          <path d="M99.205 22.06217h-20.03M89.19 12.08217v20.02999" />
          <circle cx="89.19" cy="22.06217" r="16.00275" />
        </g>
      </symbol>
      <symbol id="arrow" role="presentation" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 220.6233 111.09344">
        <rect class="rect" y="45.94671" width="186.04651" height="19.31202" fill="currentColor" />
        <polygon class="trangle" points="160.775 12.967 160.775 98.238 211.318 55.89 160.775 12.967" fill="#fff"
          stroke="currentColor" stroke-miterlimit="10" stroke-width="12" />
      </symbol>

    </svg>

  </form>
  <script src="js/index.js"></script>
  <script src="js/libraries/TweenMax.min.js"></script>
  <script src="js/libraries/jquery-3.4.1.min.js"></script>
  <script src="js/index.js"></script>
  <script>
    $(document).ready(function () {
      $(".scroll-down").click(function (event) {
        if (this.hash !== "") {
          event.preventDefault();
          var hash = this.hash;
          $('html, body').animate({
            scrollTop: 80
          })
        }
      })
    })
  </script>
</body>
</html>
