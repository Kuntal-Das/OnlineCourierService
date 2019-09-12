window.addEventListener("load", _ => {
    const page = document.body.querySelector(".page");
    const nav = page.querySelector(".navi");
    const logCont = nav.querySelector(".login-container");
    const container = page.querySelector(".container");
    const content = container.querySelector(".content");

    const tlm = new TimelineMax();

    /*hiding preloader*/
    const pre = document.getElementById("loaderImage");
    const loader = document.getElementById("loader");

    tlm.to(loader, 0.5, { opacity: "0" })
        .to(pre, 1, { scaleY: "0vh", ease: Power2.easeOut }, "-=0.25")
        .fromTo(
            pre,
            0.5,
            { x: "0%" },
            { x: "-100%", ease: Power2.easeInOut },
            "-=0.75"
        );

    // pre.classList.toggle("hide");
    /*changing heading class*/
    let heading = container.querySelector(".head1__heading");
    heading.classList.add("appear");
    setTimeout(function() {
        heading.classList.replace("head1__heading", "head1__welcome");
        pre.style.display = "none";
    }, 2000);

    /* Open Close login form Container */
    if (logCont != null) {
        let login = logCont.querySelector(".close");
        login.addEventListener("click", () => {
            document.querySelector(".login-container").classList.remove("active");
        });
        let loginbutton = nav.querySelector(".login");
        loginbutton.addEventListener("click", () => {
            document.querySelector(".login-container").classList.add("active");
        });
    }

    /* Hamburger menu for mobile view */
    // let ham = nav.querySelector(".ham");
    // ham.addEventListener("click", () => {
    //     if (ham.className == "ham") {
    //         ham.className += " active";
    //     } else {
    //         ham.className = "ham";
    //     }
    // });

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

    /*intersection observer for changing navbar style*/
    let headerOptions = {
        rootMargin: "-105px 0px 0px 0px"
    };
    const headObserver = new IntersectionObserver(function(entries) {
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

    /*fading in quicklinks using Intersection Observer*/
    const quickLinkDiv = container.querySelector(".HQLinks");
    let scrollD = container.querySelector(".scroll-down");
    // let header = container.querySelector(".head1");
    let appearoptions = {
        rootMargin: "0px 0px -60px 0px"
    };
    let appearOnScroll = new IntersectionObserver(function(
        entries,
        appearOnScroll
    ) {
        entries.forEach(entry => {
            if (!entry.isIntersecting) {
                return;
            }
            entry.target.classList.add("appear");
            let head = container.querySelector(".head1");
            head.classList.add("reduced");
            scrollD.classList.add("hide");
            setTimeout(function() {
                scrollD.style.display = "none";
            }, 700);
            appearOnScroll.disconnect(entry.target);
        });
    },
    appearoptions);
    /*Observing QuickLinkDiv*/
    appearOnScroll.observe(quickLinkDiv);

    /*Changing Card style using Intersection Observer*/
    const cards = content.querySelectorAll(".imgDiv");

    function getVisibleStatus() {
        let x = -1;
        for (let i = 0; i < cards.length; i++) {
            if (cards[i].classList.contains("visible")) {
                x = i;
            }
        }
        return x;
    }

    let cardVisibility = new IntersectionObserver(
        function(entrys) {
            entrys.forEach(entry => {
                let stat = getVisibleStatus();
                let pos = entry.target.dataset.pos;
                if (entry.isIntersecting) {
                    entry.target.classList.add("visible");
                } else {
                    if (stat == pos) {
                        entry.target.classList.remove("visible");
                    }
                }
            });
        },
        { rootMargin: "150px 0px -525px 0px" }
    );

    /*lazyloading card images*/
    function loadImg(img) {
        img.style.backgroundImage = "url(" + img.dataset.src + ")";
    }
    const lazyLoad = new IntersectionObserver(
        function(entrys, lazyLoad) {
            entrys.forEach(entry => {
                if (entry.isIntersecting) {
                    loadImg(entry.target);
                    lazyLoad.unobserve(entry.target);
                }
                // lazyLoad.disconnect();
            });
        },
        { rootMargin: "0px 0px 500px 0px" }
    );
    cards.forEach(card => {
        cardVisibility.observe(card);
        lazyLoad.observe(card);
    });
   
});
function toogleUserontrol() {
    let puser = document.getElementById("Puser");
    if (puser != null) {
        let usercontrol = puser.querySelector(".usercontrol");
        puser.classList.toggle("appear");
        usercontrol.classList.toggle("hidden");
    }
}