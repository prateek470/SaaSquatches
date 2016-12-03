$ ->
   $(document).on 'change', "#sessionId", (evt) ->
    $.ajax 'addpreference',
      type: 'GET'
      dataType: 'script'
      data: {
        faculty_id: $("#sessionId option:selected").val()
    }