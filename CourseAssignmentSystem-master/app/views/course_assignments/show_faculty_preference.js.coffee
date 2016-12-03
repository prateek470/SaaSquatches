$("#first-div").empty().append("<table class = \"table table-bordered\">
    <thead>
    <tr>
    <th>Good Preference</th>
    </tr>
    </thead>")
for goodtime in @goodtimes
  $("#first-div").append(goodtime)
  $("#first-div").append("<br></br>")
$("#second-div").empty().append("<table class = \"table table-bordered\">
    <thead>
    <tr>
    <th>Bad Preference</th>
    </tr>
    </thead>")
for badtime in @badtimes
  $("#second-div").append(badtime)
  $("#second-div").append("<br></br>")