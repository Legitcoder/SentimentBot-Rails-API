class Response < ApplicationRecord
  belongs_to :survey, optional: true
  belongs_to :user



  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      if geo.data["error"] != "Unable to geocode"
        obj.place = "#{geo.state}, #{geo.country}"
      else
        obj.place = "N/A"
      end
    end
  end

  after_validation :reverse_geocode

end
