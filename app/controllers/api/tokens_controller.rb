class Api::TokensController < ApplicationController

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      render json: {
          jwt: AuthenticationHelper.issue_token({id: @user.id})
      }
    else
      render json: { message: ["Email or Password is Invalid"] }, status: :not_found
    end
  end

end
