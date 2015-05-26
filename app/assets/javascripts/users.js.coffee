$ ->
  $('#users-table').dataTable
    processing: true
    serverSide: true
    ajaxSource: $('#users-table').data('source')
    sPaginationType: "full_numbers"