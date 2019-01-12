class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.references :team, foreign_key: true
      t.string :image_url
      t.boolean :is_admin

      t.timestamps
    end
  end
end
