class Api::FeelingsController < ApplicationController

  before_action :verify_jwt_token


  def index
    if params[:survey_id].present?
      @survey = Survey.find(params[:survey_id])
      @feelings = @survey.feelings
    else
      @feelings = Feeling.all
    end
  end


  #Manager is able to create a feeling associated with survey
  def create
    @survey = Survey.find(params[:survey_id])
    emoji = params[:emoji]
    mood = params[:mood]
    @feeling = Feeling.new(mood: mood, emoji: emoji)
    @survey.feelings << @feeling

    if @feeling.save
      render :ok, json: {feeling: @feeling}
    else
      @errors = @feelings.error.full_messages
      render json: {message: @errors}, status: :unprocessable_entity
    end

    if !@survey
      render json: {message: "Survey is Required!" }, status: :unprocessable_entity
    end
  end

  #Manager is able to destroy feeling
  def destroy
    @feeling = Feeling.find(params[:id])
    @feeling.destroy
    render :ok, json: { feeling: @feeling }
  end

end
