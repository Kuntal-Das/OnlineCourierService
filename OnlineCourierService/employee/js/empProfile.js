window.addEventListener("load", function () {
    let dropdown = document.querySelector(".dropdown");
    let account = document.querySelector(".account");
    account.addEventListener("click", _ => {
        account.classList.toggle("appear");
        dropdown.classList.toggle("hidden");
    });

    let edit1 = document.getElementById("HLeditpersonal");
    edit1.addEventListener("click", _ => {
        let inputs = document.querySelectorAll(".input");
        inputs.forEach(input => {
            input.disabled = false;
        });
        inputs[0].select();
        this.document.getElementById("RBLgenger_0").disabled = false;
        this.document.getElementById("RBLgenger_1").disabled = false;
        this.document.getElementById("RBLgenger_2").disabled = false;
    });

    let edit2 = document.getElementById("HLeditpass");
    edit2.addEventListener("click", _ => {
        let inputs = document.querySelectorAll(".input-pass");
        inputs.forEach(input => {
            input.disabled = false;
        });
        inputs[0].focus();
    });
    let today = new Date(),
        day = today.getDate() - 1,
        month = today.getMonth() + 1, //January is 0
        year = today.getFullYear();
    if (day < 10) {
        day = '0' + day
    }
    if (month < 10) {
        month = '0' + month
    }
    today = year + '-' + month + '-' + day;

    document.getElementById("TBdob").max = today;
});