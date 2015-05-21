$ ->
  $('#users-table').dataTable
    processing: true
    serverSide: true
    ajaxSource: $('#users-table').data('source')
    pagingType: 'full_numbers'