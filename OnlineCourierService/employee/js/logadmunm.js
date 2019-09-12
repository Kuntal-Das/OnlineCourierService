function validateuser() {
    let user = document.getElementById("Aname");
    if (user.value.trim().length < 3) {
        user.style.border = "2px solid red";
        return false;
    }
    return true;
}