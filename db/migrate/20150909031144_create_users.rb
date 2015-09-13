class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :user_name
      t.string :email, uniqueness: true
      t.string :password_digest
      t.string :type
      t.string :street_address
      t.string :city
      t.string :state_address
      t.integer :zip

      t.timestamps null: false
    end
  end
end
