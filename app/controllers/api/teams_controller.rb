class Api::TeamsController < ApplicationController

  before_action :verify_jwt_token

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    debugger
    if @team.save
      render :ok, json: {}
    else
      @errors = @team.errors.full_messages
      render json: { message: @errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
  end

  def team_params
    params.permit(:team_name, :code, :id)
  end

end
