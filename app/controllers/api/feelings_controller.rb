class Api::FeelingsController < ApplicationController

  #Manager is able to create a feeling
  def create
    emoji = params[:emoji]
    mood = params[:mood]
    @feeling = Feeling.new(mood: mood, emoji: emoji)
    if @feeling.save

    else

    end
  end

end
