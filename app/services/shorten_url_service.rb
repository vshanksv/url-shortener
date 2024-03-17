class ShortenUrlService
  include BaseService

  attr_reader :short_link

  def initialize(short_link)
    @short_link = short_link
  end

  def call
    rate_result = RateLimitingService.call(60, 60, 5)
    return failure(rate_result.response) unless rate_result.success?

    unique_key = SecureRandom.urlsafe_base64(6)
    short_link.short_url = unique_key
    short_link.user = Current.user
    short_link.title = retrieve_title

    if short_link.save
      success(short_link)
    else
      failure(short_link.errors.full_messages.join(", "))
    end
  rescue StandardError => e
    Rails.logger.error("Failed to shorten URL. #{e.message}")
    failure("Invalid URL. Failed to shorten URL.")
  end

  private

  def retrieve_title
    Mechanize.new.get(short_link.target_url).title
  rescue StandardError => e
    Rails.logger.error("Failed to get title. #{e.message}")
    nil
  end
end
