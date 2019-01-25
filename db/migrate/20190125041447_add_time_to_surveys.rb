class AddTimeToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :time, :string
  end
end
