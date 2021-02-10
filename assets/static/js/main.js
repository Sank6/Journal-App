function ready() {
    document.querySelectorAll(".date, .show-date").forEach((elem) => {
        let d = new Date(elem.getAttribute("date_value"));
        elem.innerText = d.toLocaleDateString(undefined, { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })
    })

    let bg = document.getElementById("bg");
    document.body.style.backgroundImage = `url("${bg.innerText}")`;
}