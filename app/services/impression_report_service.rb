class ImpressionReportService
  include BaseService

  attr_reader :search

  def initialize(search)
    @search = search
  end

  def call
    start_date = search.start_date.to_date.beginning_of_day
    end_date = search.end_date.to_date.end_of_day
    if start_date > end_date
      return failure(error_code: "invalid_date_range",
                     error_message: "Start date cannot exceed end date.")
    end

    impression_reports = if Current.user&.admin?
                           ShortLink.with_impression_created_between(start_date, end_date)
                         else
                           ShortLink.by_user(Current.user.id).with_impression_created_between(start_date, end_date)
                         end
    if impression_reports.present?
      success(impression_reports)
    else
      failure(error_code: "empty_table",
              error_message: "No data found.")
    end
  rescue StandardError => e
    Rails.logger.error("ImpressionReportService failed. Message: #{e.message}")
    failure(error_code: "general_error", error_message: "Please try again later.")
  end
end
