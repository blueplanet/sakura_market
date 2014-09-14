module JournalsHelper
  def good_button(journal)
    class_name = 'good btn btn-success'
    class_name += ' disabled' if current_user.good_journals.include?(journal)

    link_to journal_goods_path(journal),
      method: :post,
      remote: true,
      class: class_name do
      concat content_tag :span, '', class: 'glyphicon glyphicon-thumbs-up'
      concat ' Good !'
    end
  end
end
