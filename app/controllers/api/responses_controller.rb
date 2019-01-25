class Api::ResponsesController < ApplicationController

  before_action :verify_jwt_token

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
    date = Date.parse(params[:date])
    dateString = date.strftime('%a %d %b %Y')
    @response = Response.new(longitude: params[:longitude],
                             latitude: params[:latitude],
                             mood: params[:mood],
                             emoji: params[:emoji],
                             user_id: params[:user_id],
                             survey_id: params[:survey_id]
    )
    @response.date = date
    @user.responses << @response
    if @response.save
      render :ok, json: {id: @response.id,
                         date: dateString,
                         longitude: @response.longitude,
                         latitude: @response.latitude,
                         mood: @response.mood,
                         emoji: @response.emoji,
                         userId: @response.user_id,
                         surveyId: @response.survey_id,
                         place: @response.place
      }
    else
      @errors = @response.errors.full_message
      render json: { message: @errors }, status: :unprocessable_entity
    end
  end


  #Upload image_url will be implemented here for selfie
  def upload_response_image
    @response = Response.find(params[:responseId])
    file = Tempfile.new('foo')
    base64 = Base64.decode64(params[:image].tr(' ', '+'))
    image = StringIO.new(base64)
    image.class.class_eval { attr_accessor :original_filename, :content_type }
    image.original_filename = SecureRandom.hex + '.png'
    image.content_type = 'image/png'
    File.open(file, 'wb') do|f|
      f.write(base64)
    end
    cloudinary = Cloudinary::Uploader.upload(file)
    image_url = cloudinary["url"]
    @response.image_url = image_url
    if @response.save
      render :ok, json: {image_url: image_url}
    else
      @errors = @response.errors.full_messages
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
    params.permit(:id, :mood, :emoji, :longitude, :latitude, :date, :image_url, :place, :user_id, :team_id)
  end
end
