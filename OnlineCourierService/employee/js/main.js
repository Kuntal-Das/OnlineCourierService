window.addEventListener("load", function () {
    let dropdown = document.querySelector(".dropdown");
    let account = document.querySelector(".account");
    account.addEventListener("click", _ => {
        account.classList.toggle("appear");
        dropdown.classList.toggle("hidden");
    });
});