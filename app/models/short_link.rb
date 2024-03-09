class ShortLink < ApplicationRecord
  belongs_to :user, optional: true
  has_many :short_link_facts, primary_key: :short_url, foreign_key: :short_url,
                              inverse_of: :short_link,
                              dependent: :destroy

  validates :target_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates :short_url, presence: true, db_uniqueness: true
end
