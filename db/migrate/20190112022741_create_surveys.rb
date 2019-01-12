class CreateSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :surveys do |t|
      t.string :schedule
      t.references :team, foreign_key: true
      t.string :question

      t.timestamps
    end
  end
end
