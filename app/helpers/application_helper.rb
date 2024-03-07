module ApplicationHelper
  def domain_url(short_url)
    Settings.domain_url + short_url
  end
end
