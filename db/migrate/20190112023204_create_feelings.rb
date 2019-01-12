class CreateFeelings < ActiveRecord::Migration[5.2]
  def change
    create_table :feelings do |t|
      t.string :mood
      t.string :emoji

      t.timestamps
    end
  end
end
