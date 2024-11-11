class CreateGuestlists < ActiveRecord::Migration[7.2]
  def change
    create_table :guestlists do |t|
      t.string :rsvp_status
      t.references :event, null: false, foreign_key: true
      t.references :guest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
