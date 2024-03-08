class ImpressionJob
  include Sidekiq::Job

  # Sidekiq's retry mechanism will catch exceptions and retry the jobs regularly within 25 retries (about 21 days)
  def perform(ip, short_url)
    short_link = ShortLink.find_by(short_url:)
    short_link.short_link_facts.create!(ip:, user_id: short_link.user_id)
  end
end
