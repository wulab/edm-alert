module ApplicationHelper
  def external_link_to(name = nil, options = nil, html_options = nil, &block)
    html_options ||= {}
    html_options["target"] ||= "_blank"
    html_options["rel"] ||= "nofollow"
    link_to(name, options, html_options, &block)
  end

  def map_pages?
    params[:controller] == 'pages' && 
      %w(map map_with_location map_with_category).include?(params[:action])
  end
end
