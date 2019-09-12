function validatepass() {
    let user = document.getElementById("Aname");
    if (user.value.trim().length < 5) {
        user.style.border = "2px solid red";
        return false;
    }
    return true;
}