# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#prices-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#prices-table').data('source')
    pagingType: 'full_numbers'
    columns: [
      {data: 'brand'}
      {data: 'sku'}
      # {data: 'title'}
      {data: 'price'}
    ]
    # pagingType is optional, if you want full pagination controls.
    # Check dataTables documentation to learn more about
    # available options.
