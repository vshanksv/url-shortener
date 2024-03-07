class ShortLink < ApplicationRecord
  belongs_to :user, optional: true

  validates :target_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates :short_url, presence: true, db_uniqueness: true
end
