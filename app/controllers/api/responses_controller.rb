class Api::ResponsesController < ApplicationController

  #before_action :verify_jwt_token

  def index
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @responses = @user.responses
    end

    if params[:team_id].present?
      @team = Team.find(params[:team_id])
      @responses = @team.responses
    end

    if params[:id].present?
      @responses = Response.all
    end
  end

  #Create a response(feelzy)
  def create
    @user = User.find(params[:user_id])
    @response = Response.new(response_params)
    @response.date = Time.new
    @user.responses << @response
    if @response.save
      render :ok, json: {response: @response}
    else
      @errors = @response.errors.full_message
      render json: { message: @errors }, status: :unprocessable_entity
    end
  end


  #Delete a response(feelzy)
  def destroy
    @response = Response.find(params[:id])
    if @response.destroy
      render :ok, json: { response: @response}
    else
      @errors = @response.errors.full_messages
      render json: { message: @errors }, status: :bad_request
    end
  end

  def response_params
    params.permit(:mood, :emoji, :longitude, :latitude, :date, :image_url)
  end
end
