class ImpressionReportPresenter
  attr_reader :impressions_in_hash

  def initialize(impressions_in_hash)
    @impressions_in_hash = impressions_in_hash
  end

  def massage_data
    impressions_in_hash.map do |(short_url, target_url, created_at), value|
      OpenStruct.new(short_url:, target_url:, created_at:, value:)
    end
  end
end
