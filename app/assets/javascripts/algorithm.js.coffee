@Algorithms = {}
@Algorithms.init = ->
  $('#fibonacci_input').keyup ->
    n = $('#fibonacci_input').val()
    spinner = (new Spinner).spin($('div')[0])
    $.ajax
      type: 'GET'
      url: '/pages/fibonacci'
      data: 'number': n
      success: (data) ->
        $('#fibonacciResult').html data
        return
    spinner.stop()
    return
  $('#sort_input').keypress (e) ->
    if e.which == 13
      n = $('#sort_input').val()
      $.ajax
        type: 'GET'
        url: '/pages/sort_array'
        data: 'input_character': n
        success: (data) ->
          $('#sort_result').html ''
          $.each data, (index, item) ->
            $('#sort_result').append '<span class="label label-success">' + item + '</span> '
            return
          #$('#sort_result').html(data);
          $('#sort_input').val ''
          return
    return
