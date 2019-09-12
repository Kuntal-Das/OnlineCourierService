window.addEventListener("load", _ => {

    let today = new Date(),
        day = today.getDate() - 1,
        month = today.getMonth() + 1, //January is 0
        maxyear = today.getFullYear() - 10;
        minyear = today.getFullYear() - 100;
    if (day < 10) {
        day = '0' + day
    }
    if (month < 10) {
        month = '0' + month
    }
    maxdate = maxyear + '-' + month + '-' + day;
    mindate = minyear + '-' + month + '-' + day;

    document.getElementById("CPHcontent_TBdob").max = maxdate;
    document.getElementById("CPHcontent_TBdob").min = mindate;

    document.getElementById("dobmsg").innerHTML = "Maximum allowed date : " + maxdate + "<br/> Minimum allowed Date : " + mindate;

});