class Api::UsersController < ApplicationController

  before_action :verify_jwt_token, only: [:changePassword]

  def index
    @team = Team.find(params[:team_id])

    if @team
      @users = @team.users
    else
      @users = User.all
    end

    if !@team
      render json: {message: "Invalid Code" }, status: :unprocessable_entity
    end

  end

  def join
    @team = Team.find_by(code: params[:code])
    debugger
    if @team
      @user =  User.find(current_user.id)
      debugger
      @team.users.push(@user)
      debugger
      @user.is_admin = false
      render :ok, json: { team: @team }
    end
  end

  #Sign up new user Or Adds a user to a team
  def create
    @user = User.new(user_params)
    if @user.save
      render :ok, json: {}
    else
      @errors = @user.errors.full_messages
      render json: { message: @errors }, status: :unauthorized
    end
  end

  def update
  end

  def changePassword
    @user = User.find_by(email: params[:email])
    @user.password = params[:password]
    @user.save()
    if @user.save
      render :ok, json: {}
    else
      @errors = @user.errors.full_messages
      render json: { message: @errors }, status: :unprocessable_entity
    end
  end


  #Handle both deleting account and only removing user from team
  def destroy
    @team = Team.find(params[:team_id])
    if @team
      #Only delete from team
      @user = User.find(params[:id])
      @team.users.delete(@user)
    else
      #Delete account
      @user.destroy
    end
  end


  private

  def user_params
    params.permit(:username, :email, :password)
  end

end
