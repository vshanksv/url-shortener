class UrlPairPresenter
  attr_reader :short_link

  def initialize(short_link)
    @short_link = short_link
  end

  def massage_data
    {
      target_url: short_link.target_url,
      short_url: Settings.domain_url + short_link.short_url
    }
  end
end
