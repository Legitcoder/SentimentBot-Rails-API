class Api::UsersController < ApplicationController

  #Sign up new user
  def create
    @user = User.new(user_params)
    if @user.save
      render :ok, json: {}
    else
      @errors = @user.errors.full_messages
      render json: { message: @errors }, status: :unauthorized
    end
  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
