module TransactionsHelper
  def transaction_status_badge(status)
    class_name = transaction_status_badge_class_name(status)
    "<span class='badge badge-pill badge-#{class_name}'>#{status}</span>".html_safe
  end

  def transaction_status_badge_class_name(status)
    return 'warning' if status.eql? 'on going'
    return 'danger' if status.eql? 'delayed'

    'success'
  end
end
