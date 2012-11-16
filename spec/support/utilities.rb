def full_title(page_title)
  base_title = "peterkimblog"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def get_heading(page_title)
  if page_title != "Home"
    "<div class=\"center\"><h1>#{page_title}</h1></div>"
  else
    ""
  end
end
