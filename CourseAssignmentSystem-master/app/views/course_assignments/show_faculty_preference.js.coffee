#$("#first-div").empty().append("<%= escape_javascript(render(:partial => @timeslot)) %>")
$("#first-div").empty().append("<table class = \"table table-bordered\">
    <thead>
    <tr>
    <th>Good Preference</th>
    </tr>
    </thead>")
$("#first-div").append("<%= @goodtimes %>")
"<% @goodtimes.each do |goodtime|%>"
#alert 'here'
$("#first-div").append goodtime 
#$("#first-div").append("<br></br>")
<% end %>
$("#second-div").empty().append("<table class = \"table table-bordered\">
    <thead>
    <tr>
    <th>Bad Preference</th>
    </tr>
    </thead>")
#for badtime in @badtimes
#$("#second-div").append(@goodtimes)
#$("#second-div").append("<br></br>")