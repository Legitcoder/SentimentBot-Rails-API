class AddLastSurveyDateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_survey_date, :date
  end
end
