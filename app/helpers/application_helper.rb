module ApplicationHelper
  def alert_helper(alert_class='default', content)
    content_tag 'div', class: "alert alert-#{alert_class} alert-dismissable" do
      concat content_tag 'button', raw('&times;'), class: "close", :'aria-hidden' => 'true', data: {dismiss: 'alert'}
      concat content
    end
  end

  def active_for(path)
    'active' if current_page?(path)
  end
end
