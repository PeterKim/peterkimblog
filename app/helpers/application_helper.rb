module ApplicationHelper
  def full_title(page_title)
    base_title = "peterkimblog"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def get_heading(page_heading)
    page_heading.empty?? "<div></div>" : "<div class=\"center\"><h1>#{page_heading}</h1></div>"
  end
end
