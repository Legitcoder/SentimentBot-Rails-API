class Api::UsersController < ApplicationController

  before_action :verify_jwt_token, except: [:create, :oauth]

  def index
    if params[:team_id].present?
      @team = Team.find(params[:team_id])
      @users = @team.users
    else
      @users = User.all
    end
  end

  def oauth
    @user = User.find_by(email: params[:email])
    if @user
      render json: {
          jwt: AuthenticationHelper.issue_token({id: @user.id})
      }
    else
      @user = User.create(user_params)
      @user.password_digest = SecureRandom::urlsafe_base64
      if @user.save
        render json: {
            jwt: AuthenticationHelper.issue_token({id: @user.id})
        }
      else
        @errors = @user.errors.full_messages
        render json: { message: @errors }, status: :unauthorized
      end
    end

  end

  def upload

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
      @user.is_team_member = true
      render :ok, json: @team.to_json
    end

    if !@team
      render json: {message: "Invalid Code" }, status: :unprocessable_entity
    end

  end

  #Sign up new user
  def create
    @user = User.new(user_params)
    if @user.save
      render :ok, json: @user.to_json
    else
      @errors = @user.errors.full_messages
      render json: { message: @errors }, status: :unauthorized
    end
  end

  def update
  end


  ##Change Password for user without oAuth login
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


  #Handle both deleting account and only removing user from team/leaving team
  def destroy
    if params[:team_id].present?
      #Only delete from team
      @team = Team.find(params[:team_id])
      @user = User.find(params[:id])
      @team.users.delete(@user)
      @user.is_team_member = false
      if @user.save
        render :ok, json: { user: @user }
      else
        render json: { message: ["User couldn't be removed from team, Please Try again!"] }, status: :unprocessable_entity
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
