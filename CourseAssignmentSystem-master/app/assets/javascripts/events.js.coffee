$ ->
  $(document).on 'change', '#building_select', (evt) ->
    $.ajax 'events/update_rooms',
      type: 'GET'
      dataType: 'script'
      data: {
        building_id: $("#building_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!")
        
$(document).on 'change', '#building_selection', (evt) ->
    $.ajax 'events/update_room_selection',
      type: 'GET'
      dataType: 'script'
      data: {
        building_id: $("#building_selection option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!")