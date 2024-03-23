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
        return redirect_to v1_empty_table_path if result.response[:error_code] == "empty_table"

        redirect_to v1_impressions_path, alert: result.response[:error_message]
      end
    end

    def show
      if Current.user.consumer? && Current.user.id != ShortLink.find_by(short_url: params[:id])&.user_id
        return render file: Rails.root.join('public/401.html').to_s, status: :unauthorized
      end

      @impressions = ShortLinkFact.where(short_url: params[:id]).order(created_at: :desc).page(params[:page]).decorate
    end
  end
end
