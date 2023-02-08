export default class UsersDataTable {
  constructor() {
    $(document).ready(function() {
      showUsersTable();
    });

    $(document).on("turbo:render", function() {
      showUsersTable();
    });

    function showUsersTable() {
      $('#users-datatable').dataTable({
        "order": [],
        "columnDefs": [
          { "orderable": true, "targets": [0, 1, 2] },
          { "orderable": false, "targets": [3, 4] },
        ],
        "processing": true,
        "serverSide": true,
        "ajax": {
          "url": $('#users-datatable').data('source')
        },
        "pagingType": "full_numbers",
        "columns": [
          {"data": "email"},
          {"data": "first_name"},
          {"data": "last_name"},
          {"data": "roles"},
          {"data": "actions"}
        ]
        // pagingType is optional, if you want full pagination controls.
        // Check dataTables documentation to learn more about
        // available options.
      });
    }
  }
}
