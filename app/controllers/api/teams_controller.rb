class Api::TeamsController < ApplicationController

  before_action :verify_jwt_token, except: [:index]

  def index
    @teams = Team.all
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    @user = @team.user
    @user.is_admin = true
    if @team.save
      render :ok, json: {team: @team}
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
