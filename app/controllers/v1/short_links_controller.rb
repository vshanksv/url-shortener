module V1
  class ShortLinksController < ApplicationController
    before_action :current_user, except: :redirect

    def new
      @short_link = ShortLink.new
    end

    def show
      @short_link = ShortLink.find(params[:id])
    end

    def create
      @short_link = ShortLink.new(short_link_params)
      prepend_http_if_needed(@short_link)
      result = ShortenUrlService.call(@short_link)
      if result.success?
        respond_to do |format|
          format.html { redirect_to v1_short_link_path(@short_link) }
        end
      else
        flash[:alert] = result.response
        render :new, status: :unprocessable_entity
      end
    end

    def redirect
      short_url = params[:shorten_url]
      cached_data = RedisSingleton.instance.client.get(short_url)
      target_url = cached_data || ShortLink.find_by(short_url: params[:shorten_url])&.target_url
      RedisSingleton.instance.client.set(short_url, target_url) if cached_data.blank?

      if target_url.present?
        ip_addr = Rails.env.production? ? request.remote_ip : Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
        # change impression job to run synchronously because redis usage exceed the free tier quota
        ImpressionJob.new.perform(ip_addr, short_url)
        redirect_to target_url, allow_other_host: true
      else
        render file: Rails.root.join('public/404.html').to_s, status: :not_found
      end
    end

    private

    def short_link_params
      params.require(:short_link).permit(:target_url)
    end

    def prepend_http_if_needed(model)
      target_url = model.target_url
      model.target_url = "https://#{target_url}" unless target_url.start_with?('http://', 'https://')
    end
  end
end
