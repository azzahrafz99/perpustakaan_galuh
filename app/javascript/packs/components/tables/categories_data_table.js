export default class CategoriesDataTable {
  constructor() {
    $(document).ready(function() {
      showCategoriesTable();
    });

    function showCategoriesTable() {
      $('#categories-datatable').dataTable({
        "order": [],
        "columnDefs": [ {
          "targets"  : 'no-sort',
          "orderable": false,
        }],
        "processing": true,
        "serverSide": true,
        "ajax": {
          "url": $('#categories-datatable').data('source')
        },
        "pagingType": "full_numbers",
        "columns": [
          {"data": "name"},
          {"data": "actions"}
        ]
        // pagingType is optional, if you want full pagination controls.
        // Check dataTables documentation to learn more about
        // available options.
      });
    }
  }
}
