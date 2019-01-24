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

  #This triggers the change of schedule
  def update
    @survey = Survey.find(params[:id])

    device_token = params[:device_token]
    notification = Rpush::Apns::Notification.new
    notification.app = Rpush::Apnsp8::App.find_by_name("moin-sentiment-bot-3")
    notification.device_token = device_token
    notification.data = { aps: { "content-available": 1 }, schedule: params[:schedule], time: Time.now, feelings: @survey.feelings, surveyId: @survey.id }
    notification.save!
    Rpush.push

    newSchedule = params[:schedule]
    @survey.schedule = newSchedule
    if @survey.save
      render :ok, json: { survey: @survey }
    else
      @errors = @survey.errors.full_messages
      render json: { message: @errors }, status: :unprocessable_entity
    end
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
