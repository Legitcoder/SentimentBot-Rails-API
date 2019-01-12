class Api::TokensController < ApplicationController

  def create
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      render json: {
          jwt: AuthenticationHelper.issue_token({id: @user.id, username: @user.username})
      }
    else
      head :not_found
    end
  end

end
