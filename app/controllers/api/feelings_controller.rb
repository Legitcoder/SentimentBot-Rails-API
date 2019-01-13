class Api::FeelingsController < ApplicationController

  before_action :verify_jwt_token

  #Manager is able to create a feeling associated with survey
  def create
    @survey = Team.find(params[:survey_id])
    emoji = params[:emoji]
    mood = params[:mood]
    @feeling = Feeling.new(mood: mood, emoji: emoji)
    @team.feelings << @feeling

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

  #Manager is able to destroy feeling associated with survey
  def destroy
    @survey = Team.find(params[:survey_id])
    @feeling = Feeling.find(params[:id])
  end

end
