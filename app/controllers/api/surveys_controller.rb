class Api::SurveysController < ApplicationController

  before_action :verify_jwt_token

  def index
    if params[:team_id].present?
      @team = Team.find(params[:team_id])
      @surveys = @team.surveys
    else
      @surveys = Survey.all
    end
  end

  def show
    @survey = Survey.find(params[:id])
  end

  def update

  end

  def create
    @team = Team.find(params[:team_id])
    schedule = params[:schedule]
    @survey = Survey.new(schedule: schedule)
    @survey.team = @team
    if @survey.save
      render :ok, json: {survey: @survey}
    else
      @errors = @survey.errors.full_messages
      render json: { message: @errors }, status: :unprocessable_entity
    end

  end



end
