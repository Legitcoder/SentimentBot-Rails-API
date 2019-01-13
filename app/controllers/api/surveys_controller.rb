class Api::SurveysController < ApplicationController

  before_action :verify_jwt_token, except: [:index]

  def index
    @surveys = Survey.all
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
