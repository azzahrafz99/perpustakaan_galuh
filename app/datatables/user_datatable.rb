class UserDatatable < AjaxDatatablesRails::ActiveRecord
  include ApplicationHelper
  extend Forwardable

  def_delegators :@view, :raw, :link_to, :safe_join, :current_user,
                 :user_path, :edit_user_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      email: { source: 'User.email', cond: :like },
      first_name: { source: 'User.first_name', cond: :like },
      last_name: { source: 'User.last_name', cond: :like },
      roles: { source: 'User.roles', cond: :like },
      actions: { searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        email: record.email,
        first_name: record.first_name,
        last_name: record.last_name,
        roles: record.roles.pluck(:name)&.join(', '),
        actions: actions(record),
        DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    User.includes(:roles)
  end

  def actions(user)
    links = []
    links << show_link(user)
    links << edit_link(user) if admin?
    links << delete_link(user) if admin?
    safe_join(links)
  end

  private

  def delete_link(user)
    link_to(user_path(user),
            method: :delete,
            class: 'btn btn-sm btn-danger',
            id: "delete-user-#{user.id}",
            data: { confirm: 'Are you sure you want delete this user?' }) do
      raw '<i class="fa fa-trash"></i>'
    end
  end

  def edit_link(user)
    link_to(edit_user_path(user), class: 'btn btn-sm btn-warning', target: '_top') do
      raw '<i class="fa fa-pencil"></i>'
    end
  end

  def show_link(user)
    link_to(user_path(user), class: 'btn btn-sm btn-info', target: '_top') do
      raw '<i class="fa fa-eye"></i>'
    end
  end
end
