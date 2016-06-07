module NoticeManagerHelper
  def notices
    flash.reject { |_, m| m.eql? true }.collect do |key, msg|
      content_tag :div, id: 'bootstrap-alert', class: "alert alert-#{alert_class_finder(key)}",
                                  role: :alert do
        msg
      end
    end.join.html_safe
  end

  private

  def alert_class_finder(key)
    case key
    when 'notice'
      'success'
    when 'alert'
      'danger'
    when 'warning'
      'warning'
    end
  end
end
