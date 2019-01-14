class Api::UsersController < ApplicationController

  before_action :verify_jwt_token, except: [:create]

  def index
    if params[:team_id].present?
      @team = Team.find(params[:team_id])
      @users = @team.users
    else
      @users = User.all
    end
  end


  def show
    @user = User.find(params[:id])
  end

  def join
    @team = Team.find_by(code: params[:code])
    if @team
      @user =  User.find(current_user.id)
      @team.users << @user
      @user.is_admin = false
      render :ok, json: { team: @team }
    end

    if !@team
      render json: {message: "Invalid Code" }, status: :unprocessable_entity
    end

  end

  #Sign up new user
  def create
    @user = User.new(user_params)
    if @user.save
      render :ok, json: {user: @user}
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
      if !@team.users.contains(@user)
        render :ok, json: { user: @user }
      else
        render json: { message: "User couldn't be removed from team, Please Try again!" }, status: :unprocessable_entity
      end
    else
      #Delete account
      @user.destroy
    end
  end


  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :image_url)
  end

end
