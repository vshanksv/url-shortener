class ShortLink < ApplicationRecord
  before_save :prepend_http_if_needed

  belongs_to :user, optional: true

  validates :target_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates :short_url, presence: true, db_uniqueness: true

  private

  def prepend_http_if_needed
    self.target_url = "https://#{target_url}" unless target_url.start_with?('http://', 'https://')
  end
end
