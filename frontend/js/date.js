document.getElementById("date").innerHTML = "Today is " + new Date().toLocaleDateString('en-us', { year:"numeric", month:"long", day:"numeric"}) +"."
// displays the date in a readable format;