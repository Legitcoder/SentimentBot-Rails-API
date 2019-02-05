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
    random_string = SecureRandom.hex
    app = Rpush::Apnsp8::App.new
    app.name = random_string
    file = File.join(Rails.root, 'app', 'AuthKey_U4TBQWBRJD.p8')
    app.apn_key = File.read(file)
    app.environment = "development" # APNs environment.
    app.apn_key_id = "U4TBQWBRJD"
    app.team_id = "5KBWP959TD"
    app.bundle_id = "com.expertservices.Sentiment-Bot"
    app.connections = 1
    app.save!

    time = params[:time]
    new_schedule = params[:schedule]
    #string_date = params[:start_date]
    start_date = Date.today
    team_members = @survey.team.users

    team_members.each do |team_member|
      if team_member.device_token != ""
        notification = Rpush::Apns::Notification.new
        notification.app = Rpush::Apnsp8::App.find_by_name(random_string)
        notification.device_token = team_member.device_token
        notification.data = { aps: { "content-available": 1 }, schedule: new_schedule, time: time, feelings: @survey.feelings, surveyId: @survey.id }
        notification.save!
        Rpush.push
      end
    end

    @survey.schedule = new_schedule
    @survey.time = time
    @survey.start_date = start_date
    #@survey.start_date = start_date
    if @survey.schedule != "Now"
      if @survey.save
        render "api/surveys/show", status: :ok
      else
        @errors = @survey.errors.full_messages
        render json: { message: @errors }, status: :unprocessable_entity
      end
    else
      render "api/surveys/show", status: :ok
    end
  end

  def create
    @team = Team.find(params[:team_id])
    schedule = params[:schedule]
    @survey = Survey.new(schedule: schedule)
    @survey.team = @team
    if @survey.save
      render :ok, json: @survey
    else
      @errors = @survey.errors.full_messages
      render json: { message: @errors }, status: :unprocessable_entity
    end

  end



end
