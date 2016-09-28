module ApplicationHelper

  def full_title page_title = ""
    base_title = t"helper.sample"
    if page_title.empty?
      base_title
    else
      page_title + t("helper.x") + base_title
    end
  end
end
