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
    device_token = params[:device_token]
    # app = Rpush::Apnsp8::App.new
    # app.name = "dude-Bot"
    # file = File.join(Rails.root, 'app', 'config', 'AuthKey_U4TBQWBRJD.p8')
    # app.apn_key = file
    # app.environment = "development" # APNs environment.
    # app.apn_key_id = "U4TBQWBRJD"
    # app.team_id = "5KBWP959TD"
    # app.bundle_id = "com.expertservices.Sentiment-Bot"
    # app.connections = 1
    # app.save!

    notification = Rpush::Apns::Notification.new
    notification.app = Rpush::Apnsp8::App.find_by_name("dude-Bot")
    debugger
    notification.device_token = device_token
    notification.alert = "hi mom!"
    notification.data = { foo: :bar }
    notification.save!
    @survey = Survey.find(params[:id])
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
