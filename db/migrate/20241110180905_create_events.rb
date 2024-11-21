class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.text :description
      t.datetime :end_time
      t.string :location
      t.datetime :start_time
      t.string :title
      t.references :creator, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
