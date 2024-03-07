class ShortenUrlService
  include BaseService

  attr_reader :short_link

  def initialize(short_link)
    @short_link = short_link
  end

  def call
    unique_key = SecureRandom.urlsafe_base64(6)
    short_link.short_url = unique_key
    short_link.user = Current.user

    if short_link.save
      success(short_link)
    else
      failure(short_link.errors.full_messages.join(", "))
    end
  end
end
