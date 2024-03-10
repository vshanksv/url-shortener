module V1
  class ImpressionsController < ApplicationController
    before_action :authenticate_user!

    def index
      @search = OpenStruct.new(start_date: params.dig(:search, :start_date) || 1.month.ago,
                               end_date: params.dig(:search, :end_date) || DateTime.now)
      result = ImpressionReportService.call(@search)

      if result.success?
        @impression_reports = Kaminari.paginate_array(ImpressionReportPresenter.new(result.response).massage_data)
                                      .page(params[:page]).per(10)
      else
        render file: Rails.root.join('public/empty_table.html').to_s, status: :not_found
      end
    end

    def show
      @impressions = ShortLinkFact.where(short_url: params[:id]).order(created_at: :desc).page(params[:page]).decorate
    end
  end
end
