class CreateGuests < ActiveRecord::Migration[7.2]
  def change
    create_table :guests do |t|
      t.string :role, default: "guest"
      t.string :rsvp_status, default: "pending"
      t.integer :party_size
      t.references :event, foreign_key: true  
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
