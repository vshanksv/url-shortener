module V1
  class SessionsController < ApplicationController
    def new; end

    def create
      user = User.authenticate_by(email: params[:email], password: params[:password])
      if user.present?
        login user
        redirect_to root_path
      else
        flash[:alert] = 'Invalid email or password'
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      logout
      redirect_to root_path
    end
  end
end
