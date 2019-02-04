class AddStartDateToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :start_date, :date
  end
end
