module ApplicationHelper
  def external_link_to(name = nil, options = nil, html_options = nil, &block)
    html_options ||= {}
    html_options["target"] ||= "_blank"
    html_options["rel"] ||= "nofollow"
    link_to(name, options, html_options, &block)
  end
end
