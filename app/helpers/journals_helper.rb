module JournalsHelper
  def good_button(journal)
    class_name = 'good btn'
    class_name += current_user.good_journals.include?(journal) ?
      ' btn-default disabled' : ' btn-success'

    link_to journal_goods_path(journal),
      method: :post,
      remote: true,
      class: class_name,
      data: { disable_with: t('links.sending') } do
      concat content_tag :span, '', class: 'glyphicon glyphicon-thumbs-up'
      concat ' '
      concat t('links.good')
    end
  end
end
