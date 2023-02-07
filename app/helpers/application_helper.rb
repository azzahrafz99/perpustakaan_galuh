module ApplicationHelper
  delegate :admin?, to: :current_user
end
