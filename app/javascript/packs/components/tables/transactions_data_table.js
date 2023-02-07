export default class TransactionsDataTable {
  constructor() {
    $(document).ready(function() {
      showTransactionsTable();
    });

    function showTransactionsTable() {
      $('#transactions-datatable').dataTable({
        "order": [],
        "columnDefs": [ {
          "targets"  : 'no-sort',
          "orderable": false,
        }],
        "processing": true,
        "serverSide": true,
        "ajax": {
          "url": $('#transactions-datatable').data('source')
        },
        "pagingType": "full_numbers",
        "columns": [
          {"data": "isbn"},
          {"data": "book_title"},
          {"data": "user"},
          {"data": "loan_date"},
          {"data": "period"},
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
