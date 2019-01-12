class CreateFeelzs < ActiveRecord::Migration[5.2]
  def change
    create_table :feelzs do |t|
      t.string :mood
      t.string :emoji
      t.date :date
      t.string :image_url
      t.double :longitude
      t.double :latitude
      t.references :survey, foreign_key: true
      t.timestamps
    end
  end
end
