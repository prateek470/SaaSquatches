$ ->
   $(document).on 'change', "#faculty_id", (evt) ->
    $.ajax 'course_assignments/update_faculty_details',
      type: 'GET'
      dataType: 'script'
      data: {
        faculty_id: $("#faculty_id option:selected").val()
      }
    $.ajax 'course_assignments/show_faculty_preference',
     type: 'GET'
     dataType: 'json'
     data: {
       faculty_id: $("#faculty_id option:selected").val()
     }
     success: (data, textStatus, jqXHR) ->
        $("#first-div").empty()
        $("#second-div").empty()
        $("#first-div").append("<table class = \"table table-bordered\">
        <thead>
        <tr>
        <th>Good Preference</th>
        </tr>
        </thead>")
        for goodtimes in data.goodtimes
          $("#first-div").append(goodtimes)
          $("#first-div").append("<br></br>")
        $("#second-div").append("<table class = \"table table-bordered\">
        <thead>
        <tr>
        <th>Bad Preference</th>
        </tr>
        </thead>")
        for badtimes in data.badtimes
          $("#second-div").append(badtimes)
          $("#second-div").append("<br></br>")
    error: (xhr) ->
     alert 'Dialog3'
