module ApplicationHelper
  # Use to identify the active page
  def is_active(path)  
    current_page?(path) ? "active" : nil
  end

end
