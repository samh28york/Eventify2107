class CreateGuests < ActiveRecord::Migration[7.2]
  def change
    create_table :guests do |t|
      t.string :email, null: false  # Define email column
      t.string :first_name
      t.string :last_name
      t.integer :party_size
      t.string :password_digest, null: false, default: ""
      t.string :phone
      t.references :event, foreign_key: true  # Adds event_id with a foreign key constraint

      t.timestamps
    end
  end
end
