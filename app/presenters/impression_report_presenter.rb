class ImpressionReportPresenter
  attr_reader :impressions_in_hash

  def initialize(impressions_in_hash)
    @impressions_in_hash = impressions_in_hash
  end

  def massage_data
    impression_reports = []
    impressions_in_hash.each do |key, value|
      impression_reports << OpenStruct.new(key:, value:)
    end
    impression_reports
  end
end
