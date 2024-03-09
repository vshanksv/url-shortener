module V1
  class UserApiKeysController < ApplicationController
    before_action :authenticate_user!

    def index
      @user_api_keys = current_user.user_api_keys
    end

    def create
      @user_api_key = UserApiKey.new(user: current_user)
      if @user_api_key.save
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.append('api_keys_frame', partial: 'user_api_key',
                                                                       locals: { user_api_key: @user_api_key })
          end
          format.html { redirect_to v1_user_api_keys_path }
        end
      else
        render :index, status: :unprocessable_entity
      end
    end
  end
end
