$("#first-div").empty()
$("#second-div").empty()
$("#first-div").append("<table class = \"table table-bordered\">
<thead>
<tr>
<th>Good Preference</th>
</tr>
</thead>")
<% @goodtimes.each do |good| %>
$("#first-div").append("<%= good %>")
$("#first-div").append("<br></br>")
<% end %>
$("#second-div").append("<table class = \"table table-bordered\">
<thead>
<tr>
<th>Bad Preference</th>
</tr>
</thead>")
<% @badtimes.each do |bad| %>
$("#second-div").append("<%= bad %>")
$("#second-div").append("<br></br>")
<% end %>