class ImpressionJob
  include Sidekiq::Job

  # Sidekiq's retry mechanism will catch exceptions and retry the jobs regularly within 25 retries (about 21 days)
  def perform(ip, short_link_id)
    short_link = ShortLink.find(short_link_id)
    short_link.short_link_facts.create!(ip:, user_id: short_link.user_id)
  end
end
