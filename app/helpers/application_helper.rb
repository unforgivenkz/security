module ApplicationHelper
# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "ДБиЗИ"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def full_h1title(h1_title)
    base_title = "Добро пожаловать на страницу портала ДБиЗИ!"
    if h1_title.empty?
      base_title
    else
      "#{h1_title}"
    end
  end

end
