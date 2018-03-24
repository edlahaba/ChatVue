module ApplicationHelper
  def title(page_title = nil)
    default_text = "Aplicación de chat NSS"
    if page_title != nil
      "#{page_title} | #{default_text}"
    else
      "#{default_text}"
    end
  end
end
