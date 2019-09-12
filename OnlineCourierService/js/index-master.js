window.addEventListener("load", _ => {
    /*hiding preloader*/
    const nav = document.querySelector(".navi");
    const pre = document.getElementById("loaderImage");
    const loader = document.getElementById("loader");
    const tlm = new TimelineMax();

    tlm.to(loader, 0.75, { opacity: "0" })
        .fromTo(pre,0.5,{ y: "0%" },{ y: "100%", ease: Power2.easeInOut},"-=0.25");
    /*active/inactive dropdown-link*/
    let menulink1 = nav.querySelector(".level1nav__link.t1");
    let menulink2 = nav.querySelector(".level1nav__link.t2");
    let menulink3 = nav.querySelector(".level1nav__link.t3");
    /*dropdownlist 1 */
    var dropdownlst = nav.querySelector("ul.dropdown.UL1");
    dropdownlst.addEventListener("mouseenter", () => {
        menulink1.classList.add("active");
    });
    dropdownlst.addEventListener("mouseleave", () => {
        menulink1.classList.remove("active");
    });
    /*dropdownlist 2*/
    var dropdownlst = nav.querySelector("ul.dropdown.UL2");
    dropdownlst.addEventListener("mouseenter", () => {
        menulink2.classList.add("active");
    });
    dropdownlst.addEventListener("mouseleave", () => {
        menulink2.classList.remove("active");
    });
    /*dropdownlist 3*/
    var dropdownlst = nav.querySelector("ul.dropdown.UL3");
    dropdownlst.addEventListener("mouseenter", () => {
        menulink3.classList.add("active");
    });
    dropdownlst.addEventListener("mouseleave", () => {
        menulink3.classList.remove("active");
    });
    const heading = document.querySelector(".head1");
    /*intersection observer for changing navbar style*/
    let headerOptions = {
        rootMargin: "-50px 0px 0px 0px"
    };
    const headObserver = new IntersectionObserver(function (entries) {
        entries.forEach(entry => {
            if (!entry.isIntersecting) {
                nav.classList.add("scroll");
            } else if (entry.isIntersecting) {
                nav.classList.remove("scroll");
            }
        });
    }, headerOptions);
    /*observing header*/
    headObserver.observe(heading);
});
function toogleUserontrol() {
    let puser = document.getElementById("CPHuser_Puser");
    let usercontrol = puser.querySelector(".usercontrol");
    puser.classList.toggle("appear");
    usercontrol.classList.toggle("hidden");
}