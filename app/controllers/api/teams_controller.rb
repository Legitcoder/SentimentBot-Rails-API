class Api::TeamsController < ApplicationController

  #before_action :verify_jwt_token, except: [:index]

  def index
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @teams = @user.teams
      render json: @teams.first.to_json
    else
      @teams = Team.all
    end
  end

  def show
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(team_params)
    debugger
    @team.user = User.find(params[:user_id])
    @user = @team.user
    @user.is_admin = true
    @user.save
    if @team.save
      render :ok, json: @team.to_json
    else
      @errors = @team.errors.full_messages
      render json: { message: @errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @user = current_user
    @user.is_admin = false
    @team = Team.find(params[:id])
    @team.destroy
    @user.save
  end

  def team_params
    params.permit(:team_name, :code, :id)
  end

end
