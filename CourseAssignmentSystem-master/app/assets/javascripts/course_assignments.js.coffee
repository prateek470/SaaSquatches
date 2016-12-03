
$ ->
   $(document).on 'change', "#faculty_id", (evt) ->
    $.ajax 'course_assignments/update_faculty_details',
      type: 'GET'
      dataType: 'script'
      data: {
        faculty_id: $("#faculty_id option:selected").val()
      }

   $(document).on 'click', '#show_faculty_pref', (evt) ->
    $.ajax 'course_assignments/show_faculty_preference',
      type: 'GET'
      dataType: 'script'
      data: {
        faculty_id: $("#faculty_id option:selected").val()
      }
      success: (data, textStatus, jqXHR) ->
        alert 'Ajax success'
      error: (xhr) ->
        alert 'Some error in Show Faculty Preference'
