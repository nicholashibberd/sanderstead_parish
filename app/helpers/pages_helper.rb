module PagesHelper
  
  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    markdown.render(text).html_safe if text
  end
  
  def render_layout(page)
    begin
      church_layout_path = Rails.root.join('app', 'views', 'layouts', page.church_id, "_#{page.layout}.html.erb")
      layout = File.exist?(church_layout_path) ? "layouts/#{page.church_id}/#{page.layout}" : "layouts/default/#{page.layout}"
      render layout
    rescue ActionView::MissingTemplate => e
      render "layouts/default/default"
    end
  end
  
  def path_for_page(church, page)
    page.new_record? ? pages_path(church) : page_path(church, page)
  end
  
  def view_document_path(document)
    document.file.url
  end
  
end