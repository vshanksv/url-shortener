class ShortLink < ApplicationRecord
  belongs_to :user, optional: true
  has_many :short_link_facts, primary_key: :short_url, foreign_key: :short_url,
                              inverse_of: :short_link,
                              dependent: :destroy

  validates :target_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates :short_url, presence: true, db_uniqueness: true

  scope :by_user, ->(user_id) { where(user_id:) }
  scope :with_impression_created_between, lambda { |start_date, end_date|
    where(created_at: start_date..end_date)
      .left_joins(:short_link_facts)
      .group(:short_url, :target_url, :created_at)
      .order(created_at: :desc)
      .count(:ip)
  }
end
