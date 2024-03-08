class ShortLinkFact < ApplicationRecord
  belongs_to :short_link, primary_key: :short_url, foreign_key: :short_url, inverse_of: :short_link_facts

  validates :short_url, presence: true
  validates :ip, format: { with: Resolv::IPv4::Regex }
end
