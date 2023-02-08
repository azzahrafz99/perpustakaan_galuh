class CategoryDatatable < AjaxDatatablesRails::ActiveRecord
  include ApplicationHelper
  extend Forwardable

  def_delegators :@view, :raw, :link_to, :safe_join, :current_user,
                 :category_path, :edit_category_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      name: { source: 'Category.name', cond: :like },
      actions: { searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        name: record.name,
        actions: actions(record),
        DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    Category.all
  end

  def actions(category)
    links = []
    links << show_link(category)
    links << edit_link(category) if admin?
    links << delete_link(category) if admin?
    safe_join(links)
  end

  private

  def show_link(category)
    link_to(category_path(category), class: 'btn btn-sm btn-info',
                                     id: "show-category-#{category.id}") do
      '<i class="fa fa-eye"></i>'.html_safe
    end
  end

  def delete_link(category)
    link_to(category_path(category),
            method: :delete,
            class: 'btn btn-sm btn-danger',
            id: "delete-category-#{category.id}",
            data: { confirm: 'Are you sure want to delete this category?' }) do
      '<i class="fa fa-trash"></i>'.html_safe
    end
  end

  def edit_link(category)
    link_to(edit_category_path(category), id: "edit-category-#{category.id}",
                                          class: 'btn btn-sm btn-warning') do
      '<i class="fa fa-pencil"></i>'.html_safe
    end
  end
end
