class Api::ResponsesController < ApplicationController

  before_action :verify_jwt_token

  #Create a response(feelzy)
  def create
    debugger
    @user = User.find(params[:user_id])
    @response = Response.new(response_params)
    @user.responses << @response
    debugger
    if @response.save
      render :ok, json: {response: @response}
    else
      @errors = @response.errors.full_message
      render json: { message: @errors }, status: :unprocessable_entity
    end
  end

  def destroy

  end

  def response_params
    params.permit(:mood, :emoji, :longitude, :latitude, :date, :image_url)
  end
end
