class AddPlaceToResponses < ActiveRecord::Migration[5.2]
  def change
    add_column :responses, :place, :string, default: "N/A"
  end
end
