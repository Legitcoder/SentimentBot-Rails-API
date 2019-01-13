class ApplicationController < ActionController::API
  include AuthenticationHelper

  def verify_jwt_token
    head :unauthorized if request.headers['Authorization'].nil? || !AuthenticationHelper.valid?(request.headers['Authorization'].split(' ').last)
  end

  def current_user
    token = request.headers['Authorization'].split(' ').last
    decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base).first
    id = decoded_token["id"]
    return User.find(id)
  end
end
