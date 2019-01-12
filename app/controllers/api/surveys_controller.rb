class Api::SurveysController < ApplicationController

  before_action :verify_jwt_token

  def create
    @team = Team.find(params[:team_id])
    schedule = params[:schedule]
    @survey.team = @team
    @survey = Survey.new(schedule: schedule)

    if @survey.save

    else

    end

  end
end
