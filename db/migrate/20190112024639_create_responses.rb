class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.string :mood
      t.string :emoji
      t.references :survey, foreign_key: true
      t.references :user, foreign_key: true
      t.date :date
      t.string :image_url
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
