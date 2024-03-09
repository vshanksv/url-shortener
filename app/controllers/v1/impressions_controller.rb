module V1
  class ImpressionsController < ApplicationController
    before_action :authenticate_user!

    def index
      @search = OpenStruct.new(start_date: params.dig(:search, :start_date) || 1.month.ago,
                               end_date: params.dig(:search, :end_date) || DateTime.now)
      result = ImpressionReportService.call(@search)

      if result.success?
        @pagy, @impression_reports = pagy_array(ImpressionReportPresenter.new(result.response).massage_data)
      else
        render file: Rails.root.join('public/empty_table.html').to_s, status: :not_found
      end
    end

    def show
      @pagy, @impressions = pagy(ShortLinkFact.where(short_url: params[:id]).order(created_at: :desc))
      @impressions = @impressions.decorate
    end
  end
end
