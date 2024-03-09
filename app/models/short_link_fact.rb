class ShortLinkFact < ApplicationRecord
  belongs_to :short_link, primary_key: :short_url, foreign_key: :short_url, inverse_of: :short_link_facts

  validates :short_url, presence: true
  validates :ip, format: { with: Resolv::IPv4::Regex }

  scope :by_user, ->(user_id) { where(user_id:) }
  scope :group_by_short_url, -> { group(:short_url).count }
  scope :in_between, ->(start_date, end_date) { where(created_at: start_date..end_date) }
  # scope :order_by_count, -> { order('count_all desc') }

  def self.count_by_short_url(start_date, end_date)
    # in_between(start_date, end_date).group_by_short_url.order_by_count
    in_between(start_date, end_date).group_by_short_url
  end
end
