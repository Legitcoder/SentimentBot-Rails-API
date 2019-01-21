class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :image_url, default: 'https://res.cloudinary.com/dg3xzcms5/image/upload/v1548039381/images/default-profile-icon-24.jpg'
      t.boolean :is_admin, default: false
      t.references :team

      t.timestamps
    end
  end
end
