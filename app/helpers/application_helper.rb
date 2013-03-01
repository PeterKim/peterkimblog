module ApplicationHelper
  def full_title(page_title)
    base_title = "peterkimblog"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def get_heading(page_title, page_heading)
    pages_w_header = %w{Help About Contact Sign\ up Sign\ in Edit\ User}
    if pages_w_header.include?(page_title)   
      heading = page_heading.empty?? page_title : page_heading
      "<div class=\"center\"><h1>#{heading}</h1></div>"
    else
      ""
    end
  end
end
