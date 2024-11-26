class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.text :description
      t.datetime :end_time, null: false
      t.string :location, null: false
      t.datetime :start_time, null: false
      t.string :title, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
