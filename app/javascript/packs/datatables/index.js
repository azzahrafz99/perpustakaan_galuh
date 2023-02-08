import BooksDataTable from '../components/tables/books_data_table';
import CategoriesDataTable from '../components/tables/categories_data_table';
import TransactionsDataTable from '../components/tables/transactions_data_table';
import UsersDataTable from '../components/tables/users_data_table';

$(function () {
  new BooksDataTable();
  new CategoriesDataTable();
  new TransactionsDataTable();
  new UsersDataTable();
});
