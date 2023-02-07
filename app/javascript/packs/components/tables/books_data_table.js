export default class BooksDataTable {
  constructor() {
    $(document).ready(function() {
      showBooksTable();
    });

    function showBooksTable() {
      $('#books-datatable').dataTable({
        "order": [],
        "columnDefs": [ {
          "targets"  : 'no-sort',
          "orderable": false,
        }],
        "processing": true,
        "serverSide": true,
        "ajax": {
          "url": $('#books-datatable').data('source')
        },
        "pagingType": "full_numbers",
        "columns": [
          {"data": "isbn"},
          {"data": "title"},
          {"data": "author"},
          {"data": "stock"},
          {"data": "status"},
          {"data": "actions"}
        ]
        // pagingType is optional, if you want full pagination controls.
        // Check dataTables documentation to learn more about
        // available options.
      });
    }
  }
}
