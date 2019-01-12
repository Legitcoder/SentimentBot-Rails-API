class CreateFeelings < ActiveRecord::Migration[5.2]
  def change
    create_table :feelings do |t|
      t.string :mood
      t.string :emoji
      t.references :survey, foreign_key: true
      t.timestamps
    end
  end
end
